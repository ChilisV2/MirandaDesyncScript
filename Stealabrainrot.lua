-- === BOTÃƒO DESYNC (canto inferior esquerdo) ===

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DesyncGUI"
ScreenGui.Parent = game.CoreGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 150, 0, 45)
Button.Position = UDim2.new(0, 15, 1, -60)  -- canto inferior esquerdo
Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Button.BorderSizePixel = 2
Button.BorderColor3 = Color3.fromRGB(0, 110, 255)
Button.Text = "DESYNC"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.Parent = ScreenGui

-- Arredondar botÃ£o
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = Button

-- ================= DESYNC CODE ===================

local function runDesync()
    local FFlags = {
        DisableDPIScale = true,
        S2PhysicsSenderRate = 15000,
        AngularVelociryLimit = 360,
        StreamJobNOUVolumeCap = 2147483647,
        GameNetDontSendRedundantDeltaPositionMillionth = 1,
        TimestepArbiterOmegaThou = 1073741823,
        MaxMissedWorldStepsRemembered = -2147483648,
        GameNetPVHeaderRotationalVelocityZeroCutoffExponent = -5000,
        PhysicsSenderMaxBandwidthBps = 20000,
        LargeReplicatorSerializeWrite4 = true,
        MaxAcceptableUpdateDelay = 1,
        ServerMaxBandwith = 52,
        InterpolationFrameRotVelocityThresholdMillionth = 5,
        GameNetDontSendRedundantNumTimes = 1,
        StreamJobNOUVolumeLengthCap = 2147483647,
        CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 1,
        TimestepArbiterHumanoidTurningVelThreshold = 1,
        MaxTimestepMultiplierAcceleration = 2147483647,
        SimOwnedNOUCountThresholdMillionth = 2147483647,
        SimExplicitlyCappedTimestepMultiplier = 2147483646,
        TimestepArbiterVelocityCriteriaThresholdTwoDt = 2147483646,
        CheckPVCachedVelThresholdPercent = 10,
        ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 2147483647,
        InterpolationFramePositionThresholdMillionth = 5,
        DebugSendDistInSteps = -2147483648,
        LargeReplicatorEnabled9 = true,
        CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 1,
        LargeReplicatorWrite5 = true,
        NextGenReplicatorEnabledWrite4 = true,
        MaxTimestepMultiplierContstraint = 2147483647,
        MaxTimestepMultiplierBuoyancy = 2147483647,
        MaxDataPacketPerSend = 2147483647,
        LargeReplicatorRead5 = true,
        CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 1,
        TimestepArbiterHumanoidLinearVelThreshold = 1,
        WorldStepMax = 30,
        InterpolationFrameVelocityThresholdMillionth = 5,
        LargeReplicatorSerializeRead3 = true,
        GameNetPVHeaderLinearVelocityZeroCutoffExponent = -5000,
        CheckPVCachedRotVelThresholdPercent = 10,
    }

    for name, value in pairs(FFlags) do
        pcall(function()
            setfflag(tostring(name), tostring(value))
        end)
    end

    -- respawn
    local function respawn(plr)
        local rcdEnabled, wasHidden = false, false
        if gethidden then
            rcdEnabled, wasHidden =
                gethidden(workspace, "RejectCharacterDeletions") 
                ~= Enum.RejectCharacterDeletions.Disabled
        end

        if rcdEnabled and replicatesignal then
            replicatesignal(plr.ConnectDiedSignalBackend)
            task.wait(Players.RespawnTime - 0.1)
            replicatesignal(plr.Kill)
        else
            local char = plr.Character
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Dead)
            end
            char:ClearAllChildren()
            local newChar = Instance.new("Model")
            newChar.Parent = workspace
            plr.Character = newChar
            task.wait()
            plr.Character = char
            newChar:Destroy()
        end
    end

    respawn(Players.LocalPlayer)
end

-- Conectar botÃ£o
Button.MouseButton1Click:Connect(function()
    runDesync()
end)
