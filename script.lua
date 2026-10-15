-- ==========================================
-- 🐱 แมวส้ม Speed Hub ×999999 - ULTRA MAX
-- (Speed ×999999 + Bypass 3 ชั้น + Anti-Kick)
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

if LocalPlayer.PlayerGui:FindFirstChild("AnimeScriptHub") then
    LocalPlayer.PlayerGui.AnimeScriptHub:Destroy()
end

-- ==========================================
-- Config
-- ==========================================
local Config = {
    SpeedEnabled = false,
    SpeedValue = 1000,
    SpeedMultiplier = 1,
    SpeedMode = "Turbo",
    BypassEnabled = true,
    AntiKickEnabled = true,
    FPSEnabled = false,
    ThemeColor = Color3.fromRGB(130, 80, 255),
    BgColor = Color3.fromRGB(20, 15, 35),
    TextColor = Color3.fromRGB(240, 240, 255),
    TextDim = Color3.fromRGB(160, 160, 190)
}

-- ==========================================
-- ScreenGui
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimeScriptHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true

-- ==========================================
-- SendNotification
-- ==========================================
local function SendNotification(title, content, duration)
    duration = duration or 3
    pcall(function()
        local NotifContainer = ScreenGui:FindFirstChild("NotifContainer")
        if not NotifContainer then
            NotifContainer = Instance.new("Frame")
            NotifContainer.Name = "NotifContainer"
            NotifContainer.Size = UDim2.new(0, 220, 1, 0)
            NotifContainer.Position = UDim2.new(1, -235, 0, 10)
            NotifContainer.BackgroundTransparency = 1
            NotifContainer.ZIndex = 200
            NotifContainer.Parent = ScreenGui
            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
            layout.Padding = UDim.new(0, 6)
            layout.Parent = NotifContainer
        end
        local NotifBox = Instance.new("Frame")
        NotifBox.Size = UDim2.new(1, 0, 0, 55)
        NotifBox.BackgroundColor3 = Config.BgColor
        NotifBox.BackgroundTransparency = 0.15
        NotifBox.Position = UDim2.new(1, 50, 0, 0)
        NotifBox.ZIndex = 200
        NotifBox.Parent = NotifContainer
        Instance.new("UICorner", NotifBox).CornerRadius = UDim.new(0, 8)
        local boxStroke = Instance.new("UIStroke")
        boxStroke.Color = Config.ThemeColor
        boxStroke.Thickness = 1.5
        boxStroke.Transparency = 0.3
        boxStroke.Parent = NotifBox
        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, -40, 0, 18)
        tLabel.Position = UDim2.new(0, 35, 0, 6)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = title
        tLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tLabel.TextSize = 12
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextXAlignment = Enum.TextXAlignment.Left
        tLabel.ZIndex = 200
        tLabel.Parent = NotifBox
        local cLabel = Instance.new("TextLabel")
        cLabel.Size = UDim2.new(1, -40, 0, 22)
        cLabel.Position = UDim2.new(0, 35, 0, 24)
        cLabel.BackgroundTransparency = 1
        cLabel.Text = content
        cLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        cLabel.TextSize = 11
        cLabel.Font = Enum.Font.Gotham
        cLabel.TextXAlignment = Enum.TextXAlignment.Left
        cLabel.TextWrapped = true
        cLabel.ZIndex = 200
        cLabel.Parent = NotifBox
        NotifBox:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        task.delay(duration, function()
            pcall(function()
                NotifBox:TweenPosition(UDim2.new(1, 50, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
                task.wait(0.3)
                NotifBox:Destroy()
            end)
        end)
    end)
end

-- ==========================================
-- FPS Counter
-- ==========================================
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 100, 0, 25)
FPSLabel.Position = UDim2.new(1, -110, 0, 10)
FPSLabel.BackgroundColor3 = Config.BgColor
FPSLabel.BackgroundTransparency = 0.3
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
FPSLabel.TextSize = 12
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.Visible = false
FPSLabel.ZIndex = 150
FPSLabel.Parent = ScreenGui
Instance.new("UICorner", FPSLabel).CornerRadius = UDim.new(0, 5)

task.spawn(function()
    local frameCount = 0
    local lastTime = tick()
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastTime >= 1 then
            if Config.FPSEnabled then 
                FPSLabel.Text = "FPS: " .. frameCount
            end
            frameCount = 0
            lastTime = now
        end
    end)
end)

-- ==========================================
-- Loading Screen
-- ==========================================
local LoadingGui = Instance.new("Frame")
LoadingGui.Size = UDim2.new(0, 280, 0, 140)
LoadingGui.Position = UDim2.new(0.5, -140, 0.5, -70)
LoadingGui.BackgroundColor3 = Config.BgColor
LoadingGui.BackgroundTransparency = 0.15
LoadingGui.ZIndex = 100
LoadingGui.Parent = ScreenGui
Instance.new("UICorner", LoadingGui).CornerRadius = UDim.new(0, 10)
local loadStroke = Instance.new("UIStroke")
loadStroke.Color = Config.ThemeColor
loadStroke.Thickness = 2
loadStroke.Transparency = 0.3
loadStroke.Parent = LoadingGui
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 0, 60)
StatusText.BackgroundTransparency = 1
StatusText.Text = "กำลังโหลด..."
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamBold
StatusText.ZIndex = 101
StatusText.Parent = LoadingGui
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0.8, 0, 0, 10)
BarBg.Position = UDim2.new(0.1, 0, 0, 95)
BarBg.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
BarBg.BackgroundTransparency = 0.5
BarBg.ZIndex = 101
BarBg.Parent = LoadingGui
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Config.ThemeColor
BarFill.ZIndex = 102
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

-- ==========================================
-- Main Frame
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 340)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -170)
MainFrame.BackgroundColor3 = Config.BgColor
MainFrame.BackgroundTransparency = 0.15
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 10
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Config.ThemeColor
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.3
mainStroke.Parent = MainFrame

local MainBg = Instance.new("ImageLabel")
MainBg.Size = UDim2.new(1, 0, 1, 0)
MainBg.BackgroundTransparency = 1
MainBg.Image = "rbxassetid://16255492011"
MainBg.ImageTransparency = 0.6
MainBg.ScaleType = Enum.ScaleType.Crop
MainBg.ZIndex = 0
MainBg.Parent = MainFrame

local MainOverlay = Instance.new("Frame")
MainOverlay.Size = UDim2.new(1, 0, 1, 0)
MainOverlay.BackgroundColor3 = Config.BgColor
MainOverlay.BackgroundTransparency = 0.3
MainOverlay.ZIndex = 1
MainOverlay.Parent = MainFrame

-- Header
local HeaderBar = Instance.new("Frame")
HeaderBar.Size = UDim2.new(1, 0, 0, 40)
HeaderBar.BackgroundColor3 = Config.BgColor
HeaderBar.BackgroundTransparency = 0.4
HeaderBar.ZIndex = 2
HeaderBar.Parent = MainFrame
Instance.new("UICorner", HeaderBar).CornerRadius = UDim.new(0, 12)
local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 12)
headerFix.Position = UDim2.new(0, 0, 1, -12)
headerFix.BackgroundColor3 = Config.BgColor
headerFix.BackgroundTransparency = 0.4
headerFix.ZIndex = 2
headerFix.Parent = HeaderBar
local HeaderIcon = Instance.new("ImageLabel")
HeaderIcon.Size = UDim2.new(0, 28, 0, 28)
HeaderIcon.Position = UDim2.new(0, 12, 0.5, -14)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Image = "rbxassetid://103628356622817"
HeaderIcon.ZIndex = 3
HeaderIcon.Parent = HeaderBar
local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -80, 1, 0)
HeaderTitle.Position = UDim2.new(0, 48, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "🐱 Speed Hub ×999999"
HeaderTitle.TextColor3 = Config.TextColor
HeaderTitle.TextSize = 14
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.ZIndex = 3
HeaderTitle.Parent = HeaderBar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 10
CloseBtn.Active = true
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = HeaderBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Drag
local dragging = false
local dragStart, startPos
HeaderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
HeaderBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Config.BgColor
Sidebar.BackgroundTransparency = 0.6
Sidebar.ZIndex = 2
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.ScrollBarImageColor3 = Config.ThemeColor
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.Parent = MainFrame
local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 4)
sidebarLayout.Parent = Sidebar
local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 4)
sidebarPadding.PaddingLeft = UDim.new(0, 4)
sidebarPadding.PaddingRight = UDim.new(0, 4)
sidebarPadding.Parent = Sidebar
sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarLayout.AbsoluteContentSize.Y + 8)
end)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -120, 1, -40)
ContentContainer.Position = UDim2.new(0, 120, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ZIndex = 2
ContentContainer.Parent = MainFrame

-- Toggle Button
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Config.BgColor
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.Image = "rbxassetid://103628356622817"
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.AutoButtonColor = false
ToggleButton.ZIndex = 100
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local btnDragging = false
local btnDragStart, btnStartPos
local btnMoved = false

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnMoved = false
        btnDragStart = input.Position
        btnStartPos = ToggleButton.Position
    end
end)
ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = false
        if not btnMoved then MainFrame.Visible = not MainFrame.Visible end
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if math.abs(delta.X) > 10 or math.abs(delta.Y) > 10 then btnMoved = true end
        ToggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- UI Components
-- ==========================================
local function CreateSidebarButton(name, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Config.BgColor
    btn.BackgroundTransparency = 0.8
    btn.Text = "  " .. name
    btn.TextColor3 = Config.TextDim
    btn.TextSize = 11
    btn.Font = Enum.Font.Gotham
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    btn.ZIndex = 3
    btn.Active = true
    btn.AutoButtonColor = false
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 2, 0.6, 0)
    indicator.Position = UDim2.new(0, 0, 0.2, 0)
    indicator.BackgroundColor3 = Config.ThemeColor
    indicator.Visible = false
    indicator.ZIndex = 4
    indicator.Parent = btn
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Sidebar:GetChildren()) do
            if v:IsA("TextButton") then
                v.TextColor3 = Config.TextDim
                v.BackgroundTransparency = 0.8
                local ind = v:FindFirstChild("Frame")
                if ind then ind.Visible = false end
            end
        end
        btn.TextColor3 = Config.TextColor
        btn.BackgroundTransparency = 0.5
        indicator.Visible = true
        if callback then callback() end
    end)
    return btn
end

local function CreateToggle(parent, text, flagName, defaultState, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -15, 0, 35)
    container.BackgroundTransparency = 1
    container.ZIndex = 3
    container.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Config.TextColor
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = container
    local currentState = Config[flagName]
    if currentState == nil then currentState = defaultState end
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -40, 0.5, -10)
    toggleBtn.BackgroundColor3 = currentState and Config.ThemeColor or Color3.fromRGB(60, 55, 80)
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 6
    toggleBtn.Active = true
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = container
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = currentState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.ZIndex = 7
    knob.Parent = toggleBtn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    toggleBtn.MouseButton1Click:Connect(function()
        currentState = not currentState
        Config[flagName] = currentState
        if currentState then
            toggleBtn.BackgroundColor3 = Config.ThemeColor
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        if callback then callback(currentState) end
    end)
end

local function CreateTextBox(parent, text, flagName, default, maxVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -15, 0, 35)
    container.BackgroundTransparency = 1
    container.ZIndex = 3
    container.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Config.TextColor
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = container
    local currentValue = Config[flagName] or default
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.4, 0, 1, 0)
    box.Position = UDim2.new(0.6, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    box.Text = tostring(currentValue)
    box.TextColor3 = Config.TextColor
    box.PlaceholderText = "0-" .. maxVal
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.ZIndex = 6
    box.Parent = container
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            val = math.clamp(val, 0, maxVal)
            Config[flagName] = val
            box.Text = tostring(val)
            if callback then callback(val) end
        else
            box.Text = tostring(currentValue)
        end
    end)
end

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Config.ThemeColor
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 6
    btn.Active = true
    btn.AutoButtonColor = false
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function ClearContent()
    for _, v in pairs(ContentContainer:GetChildren()) do
        if v:IsA("ScrollingFrame") then v:Destroy() end
    end
end

local function CreatePage(title)
    ClearContent()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -15, 1, -15)
    page.Position = UDim2.new(0, 8, 0, 8)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Config.ThemeColor
    page.ZIndex = 3
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Parent = ContentContainer
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = page
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
    end)
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundTransparency = 1
    header.Text = title
    header.TextColor3 = Config.TextColor
    header.TextSize = 14
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.LayoutOrder = 1
    header.ZIndex = 3
    header.Parent = page
    return page
end

-- ==========================================
-- 🛡️ Bypass Anti-Cheat 3 ชั้น
-- ==========================================
local BypassConnections = {}

local function EnableBypass()
    -- ชั้นที่ 1: Hook WalkSpeed
    if hookmetamethod then
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if Config.BypassEnabled and Config.SpeedEnabled and key == "WalkSpeed" then
                if self:IsA("Humanoid") and self.Parent == LocalPlayer.Character then
                    return Config.SpeedValue * Config.SpeedMultiplier
                end
            end
            return oldIndex(self, key)
        end)
        
        local oldNewIndex
        oldNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
            if Config.BypassEnabled and Config.SpeedEnabled and key == "WalkSpeed" then
                if self:IsA("Humanoid") and self.Parent == LocalPlayer.Character then
                    return -- บล็อกไม่ให้ Anti-Cheat เขียนทับ
                end
            end
            return oldNewIndex(self, key, value)
        end)
    end
    
    -- ชั้นที่ 2: Loop บังคับค่าเร็ว
    local conn1 = RunService.Heartbeat:Connect(function()
        if not (Config.BypassEnabled and Config.SpeedEnabled) then return end
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                pcall(function()
                    humanoid.WalkSpeed = Config.SpeedValue * Config.SpeedMultiplier
                end)
            end
        end
    end)
    table.insert(BypassConnections, conn1)
end

-- ==========================================
-- ⚡ Speed System (4 วิธี)
-- ==========================================
local SpeedConnections = {}
local BVList = {}

local function CleanupSpeed()
    for _, conn in pairs(SpeedConnections) do
        pcall(function() conn:Disconnect() end)
    end
    SpeedConnections = {}
    
    for _, bv in pairs(BVList) do
        pcall(function() bv:Destroy() end)
    end
    BVList = {}
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(char.HumanoidRootPart:GetChildren()) do
            if v.Name:find("SpeedHub") then
                pcall(function() v:Destroy() end)
            end
        end
    end
end

-- วิธี 1: Turbo WalkSpeed
local function StartTurbo()
    local conn = RunService.Heartbeat:Connect(function()
        if not Config.SpeedEnabled or Config.SpeedMode ~= "Turbo" then return end
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                pcall(function()
                    humanoid.WalkSpeed = Config.SpeedValue * Config.SpeedMultiplier
                end)
            end
        end
    end)
    table.insert(SpeedConnections, conn)
end

-- วิธี 2: Multi-BodyVelocity
local function StartMultiBV()
    local conn = RunService.Heartbeat:Connect(function()
        if not Config.SpeedEnabled or Config.SpeedMode ~= "MultiBV" then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            if #BVList < 3 then
                for i = 1, 3 do
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "SpeedHub_BV" .. i
                    bv.MaxForce = Vector3.new(1e6, 0, 1e6)
                    bv.P = 1e6
                    bv.Parent = hrp
                    table.insert(BVList, bv)
                end
            end
            local speed = Config.SpeedValue * Config.SpeedMultiplier
            -- จำกัดความเร็วไม่ให้เกิน 5000 studs/sec (กันเตะ)
            if speed > 5000 then speed = 5000 end
            for _, bv in pairs(BVList) do
                bv.Velocity = moveDir * speed
            end
        end
    end)
    table.insert(SpeedConnections, conn)
end

-- วิธี 3: LinearVelocity
local function StartLinearVelocity()
    local conn = RunService.Heartbeat:Connect(function()
        if not Config.SpeedEnabled or Config.SpeedMode ~= "LinearVelocity" then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            local attach = hrp:FindFirstChild("SpeedHub_Attach")
            if not attach then
                attach = Instance.new("Attachment")
                attach.Name = "SpeedHub_Attach"
                attach.Parent = hrp
            end
            local lv = hrp:FindFirstChild("SpeedHub_LV")
            if not lv then
                lv = Instance.new("LinearVelocity")
                lv.Name = "SpeedHub_LV"
                lv.MaxForce = 1e6
                lv.Attachment0 = attach
                lv.Parent = hrp
            end
            local speed = Config.SpeedValue * Config.SpeedMultiplier
            if speed > 5000 then speed = 5000 end
            lv.VectorVelocity = moveDir * speed
        end
    end)
    table.insert(SpeedConnections, conn)
end

-- วิธี 4: CFrame Snap (เร็วสุด)
local function StartCFrameSnap()
    local conn = RunService.RenderStepped:Connect(function()
        if not Config.SpeedEnabled or Config.SpeedMode ~= "CFrameSnap" then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            local speed = Config.SpeedValue * Config.SpeedMultiplier
            -- จำกัดที่ 300 studs/frame
            if speed > 18000 then speed = 18000 end
            local snapDistance = speed / 60
            hrp.CFrame = hrp.CFrame + (moveDir * snapDistance)
        end
    end)
    table.insert(SpeedConnections, conn)
end

local function StartSelected()
    CleanupSpeed()
    if Config.SpeedMode == "Turbo" then StartTurbo()
    elseif Config.SpeedMode == "MultiBV" then StartMultiBV()
    elseif Config.SpeedMode == "LinearVelocity" then StartLinearVelocity()
    elseif Config.SpeedMode == "CFrameSnap" then StartCFrameSnap()
    end
end

-- เปิด Bypass ทันที
EnableBypass()

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    CleanupSpeed()
    if Config.SpeedEnabled then
        StartSelected()
    end
end)

-- ==========================================
-- 🛡️ Anti-Kick (ปิด Message เตะ)
-- ==========================================
task.spawn(function()
    while true do
        task.wait(1)
        if Config.AntiKickEnabled then
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    for _, gui in pairs(playerGui:GetChildren()) do
                        if gui:IsA("ScreenGui") then
                            for _, frame in pairs(gui:GetDescendants()) do
                                if frame:IsA("TextLabel") then
                                    local txt = string.lower(frame.Text)
                                    if string.find(txt, "kick") or string.find(txt, "ban") or string.find(txt, "exploit") then
                                        frame.Text = ""
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- เมนู: หน้าหลัก
-- ==========================================
CreateSidebarButton("🏠 หน้าหลัก", 1, function()
    local page = CreatePage("Speed Hub ×999999")
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 60)
    info.BackgroundTransparency = 1
    info.Text = "🚀 Speed ×999999 + Bypass 3 ชั้น + Anti-Kick\nเริ่มจาก ×1 → ×10 → ×100 → ×1000 → ×10000 → ×999999"
    info.TextColor3 = Config.TextDim
    info.TextSize = 11
    info.Font = Enum.Font.Gotham
    info.TextWrapped = true
    info.ZIndex = 3
    info.Parent = page
    
    CreateTextBox(page, "⚡ Speed (0-10000)", "SpeedValue", 1000, 10000, function(value) end)
    
    -- Multiplier Display
    local multLabel = Instance.new("TextLabel")
    multLabel.Size = UDim2.new(1, 0, 0, 25)
    multLabel.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    multLabel.Text = "🚀 Multiplier: ×" .. Config.SpeedMultiplier
    multLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    multLabel.TextSize = 14
    multLabel.Font = Enum.Font.GothamBold
    multLabel.ZIndex = 3
    multLabel.Parent = page
    Instance.new("UICorner", multLabel).CornerRadius = UDim.new(0, 6)
    
    -- ปุ่มเพิ่ม Multiplier
    local multBtn = Instance.new("TextButton")
    multBtn.Size = UDim2.new(1, 0, 0, 35)
    multBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    multBtn.Text = "🚀 เพิ่ม Multiplier (×1 → ×10 → ×100 → ×1000 → ×10000 → ×999999)"
    multBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    multBtn.TextSize = 10
    multBtn.Font = Enum.Font.GothamBold
    multBtn.ZIndex = 6
    multBtn.Active = true
    multBtn.AutoButtonColor = false
    multBtn.Parent = page
    Instance.new("UICorner", multBtn).CornerRadius = UDim.new(0, 6)
    multBtn.MouseButton1Click:Connect(function()
        local mults = {1, 10, 100, 1000, 10000, 999999}
        local currentIdx = 1
        for i, v in ipairs(mults) do
            if v == Config.SpeedMultiplier then
                currentIdx = i
                break
            end
        end
        local nextIdx = (currentIdx % #mults) + 1
        Config.SpeedMultiplier = mults[nextIdx]
        multLabel.Text = "🚀 Multiplier: ×" .. Config.SpeedMultiplier
        SendNotification("Multiplier", "×" .. Config.SpeedMultiplier, 2)
    end)
    
    -- ปุ่ม Reset Multiplier
    local resetMultBtn = Instance.new("TextButton")
    resetMultBtn.Size = UDim2.new(1, 0, 0, 25)
    resetMultBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    resetMultBtn.Text = "🔄 รีเซ็ต Multiplier เป็น ×1"
    resetMultBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetMultBtn.TextSize = 11
    resetMultBtn.Font = Enum.Font.GothamBold
    resetMultBtn.ZIndex = 6
    resetMultBtn.Active = true
    resetMultBtn.AutoButtonColor = false
    resetMultBtn.Parent = page
    Instance.new("UICorner", resetMultBtn).CornerRadius = UDim.new(0, 6)
    resetMultBtn.MouseButton1Click:Connect(function()
        Config.SpeedMultiplier = 1
        multLabel.Text = "🚀 Multiplier: ×1"
        SendNotification("Multiplier", "รีเซ็ตเป็น ×1", 2)
    end)
    
    -- 4 วิธี
    CreateButton(page, "⚡ วิธี 1: Turbo WalkSpeed", function()
        Config.SpeedMode = "Turbo"
        StartSelected()
        SendNotification("Speed", "วิธี 1: Turbo", 2)
    end)
    
    CreateButton(page, "💨 วิธี 2: Multi BodyVelocity", function()
        Config.SpeedMode = "MultiBV"
        StartSelected()
        SendNotification("Speed", "วิธี 2: MultiBV", 2)
    end)
    
    CreateButton(page, "🚀 วิธี 3: LinearVelocity", function()
        Config.SpeedMode = "LinearVelocity"
        StartSelected()
        SendNotification("Speed", "วิธี 3: LinearVelocity", 2)
    end)
    
    CreateButton(page, "🌀 วิธี 4: CFrame Snap (เร็วสุด)", function()
        Config.SpeedMode = "CFrameSnap"
        StartSelected()
        SendNotification("Speed", "วิธี 4: CFrame Snap", 2)
    end)
    
    CreateToggle(page, "🏃 เปิด/ปิด วิ่งเร็ว ULTRA", "SpeedEnabled", false, function(state)
        if state then
            StartSelected()
            SendNotification("Speed", "เปิด - ×" .. Config.SpeedMultiplier, 2)
        else
            CleanupSpeed()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
            SendNotification("Speed", "ปิด", 2)
        end
    end)
end)

-- ==========================================
-- เมนู: Bypass
-- ==========================================
CreateSidebarButton("🛡️ Bypass", 2, function()
    local page = CreatePage("Bypass Anti-Cheat")
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 60)
    info.BackgroundTransparency = 1
    info.Text = "🛡️ Bypass 3 ชั้น:\n1. Hook WalkSpeed\n2. Loop บังคับค่า\n3. Anti-Kick"
    info.TextColor3 = Config.TextDim
    info.TextSize = 11
    info.Font = Enum.Font.Gotham
    info.TextWrapped = true
    info.ZIndex = 3
    info.Parent = page
    
    CreateToggle(page, "🛡️ Bypass Anti-Cheat", "BypassEnabled", true, function(state)
        SendNotification("Bypass", state and "เปิด - ป้องกัน Anti-Cheat" or "ปิด - อาจโดนเตะ", 2)
    end)
    
    CreateToggle(page, "🚫 Anti-Kick (ปิดข้อความเตะ)", "AntiKickEnabled", true, function(state)
        SendNotification("Anti-Kick", state and "เปิด" or "ปิด", 2)
    end)
    
    CreateButton(page, "🔄 รีสตาร์ท Bypass", function()
        EnableBypass()
        SendNotification("Bypass", "รีสตาร์ทแล้ว", 2)
    end)
end)

-- ==========================================
-- เมนู: ตั้งค่า
-- ==========================================
CreateSidebarButton("⚙️ ตั้งค่า", 3, function()
    local page = CreatePage("ตั้งค่า")
    
    CreateToggle(page, "📊 แสดง FPS", "FPSEnabled", false, function(state)
        FPSLabel.Visible = state
    end)
    
    CreateButton(page, "🔄 รีเซ็ตทั้งหมด", function()
        CleanupSpeed()
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
        Config.SpeedEnabled = false
        Config.SpeedValue = 1000
        Config.SpeedMultiplier = 1
        SendNotification("Speed", "รีเซ็ตทั้งหมด", 2)
    end)
    
    CreateButton(page, "❌ ทำลาย UI", function()
        CleanupSpeed()
        ScreenGui:Destroy()
    end)
end)

local firstBtn = Sidebar:GetChildren()[1]
if firstBtn and firstBtn:IsA("TextButton") then firstBtn.MouseButton1Click:Fire() end

-- ==========================================
-- โหลดเสร็จ
-- ==========================================
task.spawn(function()
    task.wait(0.5)
    if BarFill then
        BarFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1, true)
    end
    task.wait(1)
    if LoadingGui then LoadingGui:Destroy() end
    if ToggleButton then ToggleButton.Visible = true end
    if MainFrame then MainFrame.Visible = true end
    SendNotification("ยินดีต้อนรับ", "🚀 Speed Hub ×999999 พร้อมใช้!", 4)
end)
