pcall(function() getgenv().FunnyLoopLOL:Disconnect() end)

local HornEvents = {}
local BackfireEvents = {}
local LightEvents = {}
local SmokeEvents = {}

local function OnDescendantAdded(Descendant)
	coroutine.wrap(function()
		if Descendant:IsA("RemoteEvent") then
			if table.find({"horn"}, string.lower(Descendant.Name)) then
				table.insert(HornEvents, Descendant)
			elseif table.find({"backfire_fe"}, string.lower(Descendant.Name)) then
				table.insert(BackfireEvents, Descendant)
			elseif table.find({"fe_lights"}, string.lower(Descendant.Name)) then
				table.insert(LightEvents, Descendant)
			elseif table.find({"smoke_fe"}, string.lower(Descendant.Name)) then
				table.insert(SmokeEvents, Descendant)
			end
		end
	end)()
end

coroutine.wrap(function()
	for _, Descendant in pairs(workspace:GetDescendants()) do
		OnDescendantAdded(Descendant)
	end
end)()

local BrakeEvent

for index, value in pairs(workspace:GetDescendants()) do
	if value:IsA("RemoteEvent") and value.Name == "BrakeHeat_FE" then
		BrakeEvent = value
		break
	end
end

local Wheels = {}

coroutine.wrap(function()
	for index, value in pairs(workspace:GetDescendants()) do
		if table.find({"FL", "FR", "BL", "BR"}, value.Name) then
			table.insert(Wheels, value)
		end
	end
end)()

local val = true

getgenv().FunnyLoopLOL = game:GetService("RunService").RenderStepped:Connect(function()
	coroutine.wrap(function()
		val = not val
		for _, RemoteEvent in pairs(HornEvents) do
			RemoteEvent:FireServer("Horn", true)
		end
		for _, RemoteEvent in pairs(BackfireEvents) do
			RemoteEvent:FireServer("Backfire1")
			RemoteEvent:FireServer("Backfire2")
		end
		for _, RemoteEvent in pairs(LightEvents) do
			RemoteEvent:FireServer("updatelight", "beam", val == true)
		end
		for _, RemoteEvent in pairs(SmokeEvents) do
			RemoteEvent:FireServer("UpdateSmoke", 1e3, 1e3)
		end
		for _, Player in pairs(game:GetService("Players"):GetPlayers()) do
			game:GetService("ReplicatedStorage").ACS_Engine.Eventos.Suppression:FireServer(Player)
		end
		for _, BasePart in pairs(Wheels) do
			pcall(BrakeEvent.FireServer, BrakeEvent, "UpdateHeat", BasePart, val == true and 60 or 0)
		end
	end)()
end)