hostid = 4135424049--5739437501 
prefix = "."

function getfps()
	local Stats = game:GetService("Stats")
	local FrameRateManager = Stats and Stats:FindFirstChild("FrameRateManager")
	local RenderAverage = FrameRateManager and FrameRateManager:FindFirstChild("RenderAverage")
	return 1000 / RenderAverage:GetValue()
end

local Framework = loadstring(game:HttpGet("https://pastebin.com/raw/3jkCj3vi"))() 
local services = Framework.Services
local TextChatService, TeleportService = services.TextChatService, services.TeleportService
local isModern = (TextChatService.ChatVersion == Enum.ChatVersion.TextChatService)

function chat(msg)
    if isModern then
        local channel = TextChatService.TextChannels["RBXGeneral"]
        channel:SendAsync(msg)
    else
        local args = {
            [1] = msg,
            [2] = "All"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))

    end
end
function find(string)
    if not (string) then
        return
    end

    local saved = {}

    for _,v in ipairs(game.Players:GetPlayers()) do
        if (string.lower(v.Name):match(string.lower(string))) or (string.lower(v.DisplayName):match(string.lower(string))) then
            table.insert(saved, v)
        end
    end

    if (#saved) > (0) then
        print(type(saved[1]))
        return saved[1]
    elseif (#saved) < (1) then
        return nil
    end
end
disabled = false
args = {}

if game.Players:GetPlayerByUserId(hostid) then
    hostuser =  game.Players:GetPlayerByUserId(hostid).Name
else
    chat("Host ID Not found, Either not ingame or entered incorrectly")
end

function newpart(part)
    if part.Name:sub(1, 6) == "Loose_" then
        if tostring(part:WaitForChild("Owner").Value) == game.Players.LocalPlayer.Name then
            latestlog = part
        end
    end
end

game.Workspace:WaitForChild("LogModels").ChildAdded:Connect(newpart)





treeregions = {}
for _, region in ipairs(game.Workspace:GetChildren()) do
    if region.Name == "TreeRegion" then
        local treeTypesInRegion = {}  -- List to store the types of trees in this region
        for _, tree in ipairs(region:GetChildren()) do
            if tree:FindFirstChild("TreeClass") then
                local treeType = tree:FindFirstChild("TreeClass").Value
                if not table.find(treeTypesInRegion, treeType) then
                    table.insert(treeTypesInRegion, treeType)
                end
            end
        end
        if #treeTypesInRegion > 0 then
            treeregions[region] = treeTypesInRegion
        end
    end
end

function getBestAxeNoRequire(hasAxe)
    Player = game.Players.LocalPlayer
    BestCooldown, BestAxe, BestValue = 0, nil, 0

    local Hitpoints = { ["BasicHatchet"] = 0.2, ["EndTimesAxe"] = 1.58, ["IceAxe"] = 0.36, ["CandyCornAxe"] = 1.75, ["CaveAxe"] = 0.4, ["RustyAxe"] = 0.55, ["AxeTwitter"] = 1.65, ["ManyAxe"] = 10.2, ["GingerbreadAxe"] = 1.2, ["AxeAmber"] = 3.39,  ["Beesaxe"] = 1.4, ['Axe1'] = 0.55, ['Axe2'] = 0.93, ['Axe3'] = 1.45, ["CandyCaneAxe"] = 0, ["AxeChicken"] = 0.9, ["AxeSwamp"] = 0.8, ["SilverAxe"] = 1.6,  ["FireAxe"] = 0.6, ["AxeBetaTesters"] = 1.45, ["Rukiryaxe"] = 1.68, ["AxeAlphaTesters"] = 1.5, ["BluesteelAxe"] = 2.8,}

    local Axes = {"BasicHatchet", "EndTimesAxe", "IceAxe", "CandyCornAxe", "CaveAxe", "RustyAxe", "AxeTwitter", "ManyAxe", "GingerbreadAxe", "AxeAmber", "Beesaxe", "Axe1", "Axe2", "Axe3", "CandyCaneAxe", "AxeChicken", "AxeSwamp", "SilverAxe", "FireAxe", "AxeBetaTesters", "Rukiryaxe", "AxeAlphaTesters", "BluesteelAxe", }

    local Cooldown = { ["BasicHatchet"] = 0.65, ["EndTimesAxe"] = 0.4, ["CandyCornAxe"] = 0.6, ["IceAxe"] = 0.4, ["CaveAxe"] = 0.4, ["RustyAxe"] = 0.4, ["AxeTwitter"] = 0.4, ["ManyAxe"] = 1.9, ["GingerbreadAxe"] = 0.5, ["AxeAmber"] = 1, ["Beesaxe"] = 0.5, ['Axe1'] = 0.55, ['Axe2'] = 0.93, ['Axe3'] = 1.45, ["CandyCaneAxe"] = 0.7, ["AxeChicken"] = 0.3, ["AxeSwamp"] = 0.55, ["SilverAxe"] = 0.48, ["FireAxe"] = 0.55, ["AxeBetaTesters"] = 0.54, ["Rukiryaxe"] = 0.4, ["AxeAlphaTesters"] = 0.5, ["BluesteelAxe"] = 0.8, }

    local foundAxe = false

    for i, v in pairs(Player.Backpack:GetChildren()) do
        if v:FindFirstChild("ToolName") and table.find(Axes, tostring(v.ToolName.Value)) then
            foundAxe = true
            if Hitpoints[tostring(v.ToolName.Value)] > BestValue then
                BestValue = Hitpoints[tostring(v.ToolName.Value)]
                BestAxe = v
                BestCooldown = Cooldown[tostring(v.ToolName.Value)]
            end
        end
    end

    if Player.Character:FindFirstChildOfClass("Tool") then
        local axe = Player.Character:FindFirstChildOfClass("Tool")
        if axe:FindFirstChild("ToolName") and table.find(Axes, tostring(axe.ToolName.Value)) then
            foundAxe = true
            if Hitpoints[tostring(axe.ToolName.Value)] > BestValue then
                BestValue = Hitpoints[tostring(axe.ToolName.Value)]
                BestAxe = axe
                BestCooldown = Cooldown[tostring(axe.ToolName.Value)]
            end
        end
    end
    if hasAxe then
        if Player.Character:FindFirstChild("Tool") then
            Player.Character.Humanoid:UnequipTools()
        end
        for i, v in pairs(Player.Backpack:GetChildren()) do
            if v:FindFirstChild("ToolName") and v.ToolName.Value == hasAxe then
                return true
            end
        end
    end

    return { BestAxe, BestCooldown, BestValue }
end

function findregion(className)
    for folder, classes in pairs(treeregions) do
        if table.find(classes, className) then
            return folder
        end
    end
end
function findtree(class)
    for _, tree in ipairs(findregion(class):GetChildren()) do
        if tree:FindFirstChild("TreeClass") then
            if tree:FindFirstChild("TreeClass").Value == class then
                return tree
            end
        end
    end
end

function getwood(class)
    local tree = findtree(class)
    for _, section in ipairs(tree:GetChildren()) do 
        if section:FindFirstChild("ID") then
            if section:FindFirstChild("ID").Value == 1 then
                firstsection = section
            end
        end
    end
    local best = getBestAxeNoRequire()
    local args = {
        [1] = tree.CutEvent,
        [2] = {
            ["tool"] = best[1],
            ["faceVector"] = Vector3.new(-1, 0, 0),
            ["height"] = 0.7449536323547363,
            ["sectionId"] = 1,
            ["hitPoints"] = best[3],
            ["cooldown"] = best[2],
            ["cuttingClass"] = "Axe"
        }
    }
    while not tree:FindFirstChild("InnerWood") do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(firstsection.Position) * CFrame.new(5, 0, 0)
        game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(unpack(args))
        task.wait(0.01)
    end
    return latestlog
end




localPlayer.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)
hostuser = game.Players:GetNameFromUserIdAsync(hostid)
host = game.Players[hostuser]
if host then
    game.Players:Chat("/e wave")
else
    chat("Couldnt find host (" .. hostid .. ")")
end
function response(msg)
    if disabled == false then
        if msg:find(prefix, 1, true) == 1 then
            ended = false
            print("Detected - " .. msg)
            local msg = string.sub(msg, 2)
            local args = {}
            if msg:find("%s") then
                for word in msg:gmatch("%S+") do
                    table.insert(args, word)
                end
            else
                args = {msg}
            end
            cmd = "0"
            if args[1] then
                cmd = string.lower(tostring(args[1]))
            end


            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            

                                    -- CMDS


            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
            

            if cmd == "tree" then
                tree = getwood(args[2])
                for i = 1,50 do
                    task.wait()
                    game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(tree)
                    for _, part in pairs(tree:GetChildren()) do
                        if part:IsA("BasePart") then  -- Only move parts (ignores non-parts)
                            part.CFrame = CFrame.new(host.Character.HumanoidRootPart.Position) * CFrame.new(0,10,0)
                        end
                    end
                end
            end
            if cmd == "rejoin" then
                TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId, game.Players.LocalPlayer)
            end
            if cmd == "kick" then
                if args[2] then
                    if tonumber(args[2]) == index then
                        game:Shutdown()
                    end
                else
                    game:Shutdown()
                end
            end
            if cmd == "fps" then
                if args[2] then
                    if args[2] == "true" then
                        game:GetService("RunService"):Set3dRenderingEnabled(true)
                    else
                        setfpscap(args[2])
                        game:GetService("RunService"):Set3dRenderingEnabled(false)
                    end
                else
                    game:GetService("RunService"):Set3dRenderingEnabled(false)
                end
            end
            if cmd == "end" then
                disabled = true
            end
        end
    end
end
if isModern then
    game:GetService("TextChatService").MessageReceived:Connect(function(textChatMessage)
        local author = tostring(textChatMessage.TextSource)
        if (author) == hostuser then
            response(textChatMessage.Text)
        end
    end)
else
    host.Chatted:Connect(function(input: string)
        response(input)
    end)
end




