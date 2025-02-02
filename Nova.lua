--Nova Admin V1.2
--Made by tocat.
---------------------------------------
--Configuration, feel free to edit it
local Nova = {
	ShowPromotion = true,
	AdminNames = {"tocat", "theothertocat"},
	AdminIDs = {},
	FreeAdmin = true,
	MOTD = "Welcome to the Nova test server! Join our discord: https://discord.gg/ea7rBtVfdR",
	ShowDebugLogs = true,
	Version = "1.2 (BETA: Everything is subject to change.)", --Version, DON'T CHANGE!
}
--local start = os.clock()
if game.Workspace:FindFirstChild("Nova Advertisement") then
	game.Workspace:FindFirstChild("Nova Advertisement"):Remove()
end
--WARNING: Unless you know EXACTLY what you're doing, don't edit the code below this.
--If you do know exactly what you're doing, come work with us!
--
local Message;
if Nova.ShowDebugLogs then
	Message = Instance.new("Message", game.Workspace)
end
local function Log(msg)
	print(msg)
	if Nova.ShowDebugLogs then
		Message.Text = msg;
	end
end
Log("NovaInit :: Nova Version: " .. Nova.Version)
Log("NovaInit :: Nova is initializing, hang on a sec...");
script.Parent.Nova.Parent = game.StarterGui
Log("NovaInit :: Nova is running in " .. _VERSION .. " | Expected Lua Version: 5.1")
Log("NovaInit :: Applying your settings...")
for i,v in pairs(Nova) do
	Log("NovaConfig :: " .. tostring(i) .. ": " .. tostring(v)) 
end
if Nova.ShowPromotion then
local Message = Instance.new("Hint", game.Workspace);
Message.Name = "Nova Advertisement"
if Nova.FreeAdmin then
		Message.Text = "This game is powered by Nova Admin V" .. Nova.Version .. ". | Made by tocat. | Free Admin Enabled";
	else
		Message.Text = "This game is powered by Nova Admin V" .. Nova.Version .. ". | Made by tocat.";
end
end

-- Basic Command System for Legacy Roblox Chat (2011)

local Players = game:GetService("Players")
-- Function to check if a player is an admin
local function isAdmin(player)
	 if FreeAdmin then return true end
    for _, admin in ipairs(Nova.AdminNames) do
        if player.Name == admin then
            return true
        end
    end
    return false
end

-- Function to process chat commands
function onChatted(player, message)
    if string.sub(message,1, 1) == "!" and isAdmin(player) then
        local command, arg = string.match(message,"!(%S+)%s*(.*)")
			print("NovaDebug :: Recieved a message, couldn't tell if it's a command or not. Results: " .. string.match(message,"!(%S+)%s*(.*)"))
        if command then
            command = string.lower(command)
            print("NovaDebug :: Command Recieved; " .. string.match(message,"!(%S+)%s*(.*)"))
            if command == "kill" and arg ~= "" then
                local target = Players:FindFirstChild(arg)
                if target and target.Character then
                    target.Character:BreakJoints()
                end
            elseif command == "jump" and arg ~= "" then
                local target = Players:FindFirstChild(arg)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.Jump = true
                end
            elseif command == "announce" then
                local Announcement = Instance.new("Message", game.Workspace)
					 Announcement.Text = "[Nova Admin] Sent by: " .. player.Name .. " | " .. arg
					 wait(5)
					 Announcement:Remove()
				elseif command == "shutdown" then
					 local Hint = Instance.new("Hint", game.Workspace)
                Hint.Text = "The server is going down in 3 seconds!"
					 wait(3)
                Hint.Text = "The server is going down NOW!"
					 local Children = game.Players:GetChildren()
					 for i=1, #Children do
						Children[i]:Remove()
					 end
					 game:Shutdown()
            end
        end
			
    end
end

-- Connect the function to player chats
game.Players.ChildAdded:connect(function(player)
    player.Chatted:connect(function(message)
		  print("NovaDebug :: Got a message: " .. message)
        onChatted(player, message)
    end)
	 if isAdmin(player) then
			local Hint = Instance.new("Hint", player.PlayerGui)
			Hint.Text = "[NOVA]: Hello, " .. player.Name .. ". You're an admin!"
	end

end)
c = game.Players:GetChildren()
for i=1,#c do
local player = c[i]
if Nova.MOTD ~= "" or Nova.MOTD ~= nil then
	player.PlayerGui.Nova.MOTD.Visible = true
	player.PlayerGui.Nova.MOTD.MOTDContent = Nova.MOTD
end
player.Chatted:connect(function(message)
		  print("NovaDebug :: Got a message: " .. message)
        onChatted(player, message)
    end)
	 if isAdmin(player) then
			local Hint = Instance.new("Hint", player.PlayerGui)
			Hint.Text = "[NOVA]: Hello, " .. player.Name .. ". You're an admin!"
	end
end 
Log("NovaInit :: Done.")
wait(2)
Message:Remove()
print("NovaHelp :: --Commands--")
print("NovaHelp :: kill <target> - Kills your target based on their name (Complete name required)")
print("NovaHelp :: jump <target> - Makes your target jump based on their name (Complete name required)")
print("NovaHelp :: announce <message> - Sends a message everyone in the server can see.")
print("NovaHelp :: shutdown - Kicks everyone, then closes the server.")
