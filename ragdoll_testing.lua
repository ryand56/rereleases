--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

--[[
	This script was created by shawnjbragdon#0001.
	Anti-Ragdoll modified by elementemerald#4175.
	If you are going to re-release this, please leave the credit.
	
	https://v3rmillion.net/member.php?action=profile&uid=1870134
	https://forum.robloxscripts.com/user-shawnjbragdon
	
	This script was made using Synapse X.
]]

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

local InternalWhitelist = game:GetService("HttpService"):JSONDecode("{\"whitelist\": \"TheLuminent\"}");

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")
local TestService = game:GetService("TestService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local WallyLibraryV2 = (RunService:IsStudio() and require(script:WaitForChild("WallyLibraryV2"))) or loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminential/releases/main/wallyhub_modified.luau", true))()
local GPEService = (RunService:IsStudio() and require(script:WaitForChild("GPEService"))) or loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminential/releases/main/gpeservice.luau", true))()
local ESPService = (RunService:IsStudio() and require(script:WaitForChild("ESPService"))) or loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminential/releases/main/espservice.luau", true))()

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

local no_ragdoll = false
local mirror_enabled = false

local r = 255
local g = 0
local b = 0

coroutine.resume(coroutine.create(function()
	while true do
		for i = 1, 255, 1 do
			RunService.Stepped:Wait()
			r = r - 1
			g = g + 1
		end
		r = 0
		g = 255
		for i = 1, 255, 1 do
			RunService.Stepped:Wait()
			g = g - 1
			b = b + 1
		end
		g = 0
		b = 255
		for i = 1, 255, 1 do
			RunService.Stepped:Wait()
			b = b - 1
			r = r + 1
		end
		b = 0
		r = 255
	end
end))

local __applyCustom = function(GuiObject)
	coroutine.resume(coroutine.create(function()
		repeat
			wait()
		until GuiObject["object"]:FindFirstChildWhichIsA("TextLabel")
		repeat
			wait()
		until GuiObject["object"]:FindFirstChild("Underline")
		local TextLabel = GuiObject["object"]:FindFirstChildWhichIsA("TextLabel")
		local Underline = GuiObject["object"]:FindFirstChild("Underline")
		while true do
			RunService.Stepped:Wait()
			TextLabel.Font = Enum.Font.Michroma
			TextLabel.TextColor3 = Color3.new(r / 255, g / 255, b / 255)
			TextLabel.TextStrokeColor3 = Color3.new(r / 510, g / 510, b / 510)
			TextLabel.TextStrokeTransparency = 0.5
			Underline.BackgroundColor3 = Color3.new(r / 255, g / 255, b / 255)
		end
	end))
end

default = {
	topcolor       = Color3.fromRGB(30, 30, 30);
	titlecolor     = Color3.fromRGB(255, 255, 255);

	underlinecolor = Color3.fromRGB(255, 0, 0);
	bgcolor        = Color3.fromRGB(35, 35, 35);
	boxcolor       = Color3.fromRGB(35, 35, 35);
	btncolor       = Color3.fromRGB(25, 25, 25);
	dropcolor      = Color3.fromRGB(25, 25, 25);
	sectncolor     = Color3.fromRGB(25, 25, 25);
	bordercolor    = Color3.fromRGB(60, 60, 60);

	font           = Enum.Font.Jura;
	titlefont      = Enum.Font.Michroma;

	fontsize       = 17;
	titlesize      = 18;

	textstroke     = 1;
	titlestroke    = 1;

	strokecolor    = Color3.fromRGB(0, 0, 0);

	textcolor      = Color3.fromRGB(255, 255, 255);
	titletextcolor = Color3.fromRGB(255, 255, 255);

	placeholdercolor = Color3.fromRGB(255, 255, 255);
	titlestrokecolor = Color3.fromRGB(0, 0, 0);
}

WallyLibraryV2["options"] = setmetatable({}, {__index = default})

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

local LocalPlayer = Players.LocalPlayer
local PlayerGui = (RunService:IsStudio() and LocalPlayer:FindFirstChildWhichIsA("PlayerGui")) or game:GetService("CoreGui")
local PlayerMouse = LocalPlayer:GetMouse()

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

spawn(function()
	while not game:IsLoaded() do wait(1) end
	
	StarterGui:SetCore("SendNotification", {
		["Title"] = "Thank you for using.",
		["Text"] = "This script was created by shawnjbragdon#0001.",
		["Duration"] = 4,
	})
end)

local Windows = {
	[1] = (function()
		local Window = WallyLibraryV2:CreateWindow("Ragdoll Testing", {["Parent"] = PlayerGui})
		__applyCustom(Window)
		return Window
	end)(),
}

local Section = Windows[1]:Section("Overpowered")
local NoRagdoll = Windows[1]:Toggle("Anti-Ragdoll", {["flag"] = "no_ragdoll"})
local PunchAura = Windows[1]:Toggle("Punch-Aura", {["flag"] = "punch_aura"})
local YeetAura = Windows[1]:Toggle("Yeet-Aura", {["flag"] = "yeet_aura"})
local StompAura = Windows[1]:Toggle("Stomp-Aura", {["flag"] = "stomp_aura"})
local AutoEscape = Windows[1]:Toggle("Auto-Escape", {["flag"] = "auto_escape"})
local PunchEverything = Windows[1]:Button("Punch Everything", function()
	local Tool = Players.LocalPlayer.Backpack:FindFirstChild("Punch") or Players.LocalPlayer.Character:FindFirstChild("Punch")
	for index, value in pairs(workspace:GetDescendants()) do
		if value:IsA("BasePart") then
			Tool["push"]:FireServer(value, Players.LocalPlayer.Character:FindFirstChild("RightHand"))
		end
	end
end)
local ActivateMines = Windows[1]:Button("Activate Mines", function()
	for index, value in pairs(workspace.RagdollTesting.things.minefield.mines:GetDescendants()) do
		if value:IsA("TouchTransmitter") then
			if firetouchinterest then
				firetouchinterest(LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").RootPart, value:FindFirstAncestorWhichIsA("BasePart"), 0)
			end
		end
	end
end)
local MirrorSpam = Windows[1]:Toggle("Mirror-Spam", {["flag"] = "mirror_spam"}, function(value)
	if value == false then
		Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["RTGui"].codebase.avatar.switchev:FireServer("mirror", false)
	end
end)
local Section = Windows[1]:Section("Radio")
local Slider = Windows[1]:Slider("Pitch", {["min"] = 0.1, ["max"] = 10}, function(value)
	Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["RTGui"].codebase.radio.switchev:FireServer("radiospeed", value)
end)

if not RunService:IsStudio() then
	workspace.FallenPartsDestroyHeight = -1e6
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

coroutine.resume(coroutine.create(function()
	while true do
		if Windows[1]["flags"]["yeet_aura"] == true then
			for index, value in pairs(Players:GetPlayers()) do
				if value ~= Players.LocalPlayer and table.find(InternalWhitelist, value.Name) == nil then
				    local Tool = Players.LocalPlayer.Backpack:FindFirstChild("Yeet") or Players.LocalPlayer.Character:FindFirstChild("Yeet")
				    Tool["push"]:FireServer(value, Players.LocalPlayer.Character:FindFirstChild("RightHand"))
				end
			end
		end
		if Windows[1]["flags"]["punch_aura"] == true then
			for index, value in pairs(Players:GetPlayers()) do
                if value ~= Players.LocalPlayer then
				    local Tool = Players.LocalPlayer.Backpack:FindFirstChild("Punch") or Players.LocalPlayer.Character:FindFirstChild("Punch")
				    Tool["push"]:FireServer(value, Players.LocalPlayer.Character:FindFirstChild("LeftHand"))
				end
			end
		end
		if Windows[1]["flags"]["stomp_aura"] == true then
			for index, value in pairs(Players:GetPlayers()) do
				pcall(function()
				    if value ~= Players.LocalPlayer then
					    local Tool = Players.LocalPlayer.Backpack:FindFirstChild("Stomp") or Players.LocalPlayer.Character:FindFirstChild("Stomp")
					    Tool["stomped"]:FireServer(value, value.Character["Head"], Players.LocalPlayer.Character:FindFirstChild("RightFoot"))
					end
				end)
			end
		end
		if Windows[1]["flags"]["auto_escape"] == true then
			pcall(function()
				LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["RTGui"].codebase.avatar.dropplrev:FireServer()
			end)
		end
		wait(0.1)
	end
end))

local function OnRenderUpdate()
	local Character = Players.LocalPlayer.Character
	local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
	local RootPart = Humanoid.RootPart or Character:FindFirstChild("HumanoidRootPart")
	
	if Windows[1]["flags"]["mirror_spam"] == true then
		mirror_enabled = not mirror_enabled
		Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["RTGui"].codebase.avatar.switchev:FireServer("mirror", mirror_enabled)
	end
	
	if Windows[1]["flags"]["no_ragdoll"] == true then
		LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["RTGui"].codebase.settings.settingsev:FireServer("settings_safezone", true)
	end
end

RunService.Stepped:Connect(function()
	local success, response = pcall(OnRenderUpdate)
	if not success and RunService:IsStudio() then
		warn(response)
	end
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
