--==================================================
-- QWSTOMSCRIPTS V1.6
-- GREEN EDITION
-- COMPLETE MENU
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURATION
--==================================================

local Config = {
Name = "𝑸𝒘𝒔𝒕𝒐𝒎𝑺𝒄𝒓𝒊𝒑𝒕𝒔",

Green = Color3.fromRGB(55, 255, 105),
Dark = Color3.fromRGB(7, 12, 9),
Panel = Color3.fromRGB(13, 21, 16),
Button = Color3.fromRGB(21, 37, 26),
Active = Color3.fromRGB(32, 110, 53),

Width = 650,
Height = 440
}

local AnimationsEnabled = true
local SoundEnabled = false
local MenuVisible = true
local CurrentTab = nil

--==================================================
-- CLEAN PREVIOUS GUI
--==================================================

local old = PlayerGui:FindFirstChild("QwstomScripts")

if old then
old:Destroy()
end

--==================================================
-- ANIMATION FUNCTION
--==================================================

local function Animate(object, duration, properties)
if not AnimationsEnabled then
for property, value in pairs(properties) do
object[property] = value
end
return nil
end

local tween = TweenService:Create(
object,
TweenInfo.new(
duration,
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
),
properties
)

tween:Play()
return tween
end

--==================================================
-- SCREEN GUI
--==================================================

local GUI = Instance.new("ScreenGui")
GUI.Name = "QwstomScripts"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 100
GUI.Parent = PlayerGui

--==================================================
-- BACKGROUND
--==================================================

local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Config.Dark
Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0
Background.Parent = GUI

--==================================================
-- SPLASH SCREEN
--==================================================

local Splash = Instance.new("Frame")
Splash.Size = UDim2.fromScale(1, 1)
Splash.BackgroundColor3 = Config.Dark
Splash.BorderSizePixel = 0
Splash.ZIndex = 10
Splash.Parent = GUI

local SplashLogo = Instance.new("TextLabel")
SplashLogo.AnchorPoint = Vector2.new(0.5, 0.5)
SplashLogo.Position = UDim2.fromScale(0.5, 0.5)
SplashLogo.Size = UDim2.fromScale(0.1, 0.1)
SplashLogo.BackgroundTransparency = 1
SplashLogo.Text = Config.Name
SplashLogo.TextColor3 = Config.Green
SplashLogo.TextScaled = true
SplashLogo.Font = Enum.Font.GothamBold
SplashLogo.ZIndex = 11
SplashLogo.Parent = Splash

local SplashStroke = Instance.new("UIStroke")
SplashStroke.Color = Config.Green
SplashStroke.Thickness = 2
SplashStroke.Parent = SplashLogo

Animate(SplashLogo, 1.2, {
Size = UDim2.fromScale(0.9, 0.2)
})

task.wait(1.4)

--==================================================
-- MAIN WINDOW
--==================================================

local Window = Instance.new("Frame")
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.Position = UDim2.fromScale(0.5, 0.55)
Window.Size = UDim2.fromOffset(0, 0)
Window.BackgroundColor3 = Config.Panel
Window.BorderSizePixel = 0
Window.Visible = false
Window.Parent = Background

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 14)
WindowCorner.Parent = Window

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = Config.Green
WindowStroke.Thickness = 1.5
WindowStroke.Parent = Window

Window.Visible = true

Animate(Window, 0.6, {
Size = UDim2.fromOffset(
Config.Width,
Config.Height
)
})

task.wait(0.7)

--==================================================
-- TITLE
--==================================================

local Logo = Instance.new("TextLabel")
Logo.Position = UDim2.fromOffset(18, 10)
Logo.Size = UDim2.fromOffset(500, 55)
Logo.BackgroundTransparency = 1
Logo.Text = Config.Name
Logo.TextColor3 = Config.Green
Logo.TextSize = 28
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Window

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 35)
Close.Position = UDim2.new(1, -48, 0, 15)
Close.BackgroundColor3 = Color3.fromRGB(40, 75, 48)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.Parent = Window

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

--==================================================
-- MENU VISIBILITY
--==================================================

local function SetMenuVisible(state)
if MenuVisible == state then
return
end

MenuVisible = state

if state then
GUI.Enabled = true
Window.Size = UDim2.fromOffset(0, 0)

Animate(Window, 0.35, {
Size = UDim2.fromOffset(
Config.Width,
Config.Height
)
})
else
local tween = Animate(Window, 0.3, {
Size = UDim2.fromOffset(0, 0)
})

if tween then
tween.Completed:Wait()
end

GUI.Enabled = false
end
end

Close.MouseButton1Click:Connect(function()
SetMenuVisible(false)
end)

--==================================================
-- TAB KEY
--==================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then
return
end

if input.KeyCode == Enum.KeyCode.Tab then
SetMenuVisible(not MenuVisible)
end
end)

--==================================================
-- TAB CONTAINER
--==================================================

local TabsFrame = Instance.new("Frame")
TabsFrame.Position = UDim2.fromOffset(15, 85)
TabsFrame.Size = UDim2.fromOffset(620, 48)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = Window

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 7)
TabLayout.Parent = TabsFrame

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(18, 150)
Content.Size = UDim2.fromOffset(614, 270)
Content.BackgroundColor3 = Color3.fromRGB(10, 18, 13)
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = Window

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

--==================================================
-- UI HELPERS
--==================================================

local function CreateLabel(parent, text, y)
local label = Instance.new("TextLabel")
label.Position = UDim2.fromOffset(20, y)
label.Size = UDim2.new(1, -40, 0, 30)
label.BackgroundTransparency = 1
label.Text = text
label.TextColor3 = Config.Green
label.TextSize = 15
label.Font = Enum.Font.GothamBold
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = parent

return label
end

local function CreateButton(parent, text, y, callback)
local button = Instance.new("TextButton")
button.Position = UDim2.fromOffset(20, y)
button.Size = UDim2.fromOffset(560, 40)
button.BackgroundColor3 = Config.Button
button.Text = text
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 14
button.Font = Enum.Font.GothamBold
button.AutoButtonColor = true
button.Parent = parent

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 9)
corner.Parent = button

local stroke = Instance.new("UIStroke")
stroke.Color = Config.Green
stroke.Transparency = 0.65
stroke.Parent = button

button.MouseButton1Click:Connect(callback)

return button
end

local function CreateTab(name, description)
local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(116, 43)
button.BackgroundColor3 = Config.Button
button.Text = name
button.TextColor3 = Config.Green
button.TextSize = 14
button.Font = Enum.Font.GothamBold
button.Parent = TabsFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = button

local page = Instance.new("Frame")
page.Size = UDim2.fromScale(1, 1)
page.BackgroundTransparency = 1
page.Visible = false
page.Parent = Content

CreateLabel(page, name, 15)

local info = Instance.new("TextLabel")
info.Position = UDim2.fromOffset(20, 50)
info.Size = UDim2.new(1, -40, 0, 35)
info.BackgroundTransparency = 1
info.Text = description
info.TextColor3 = Color3.fromRGB(165, 190, 171)
info.TextSize = 13
info.Font = Enum.Font.Gotham
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = page

button.MouseButton1Click:Connect(function()
if CurrentTab then
CurrentTab.Page.Visible = false

Animate(CurrentTab.Button, 0.2, {
BackgroundColor3 = Config.Button
})
end

CurrentTab = {
Page = page,
Button = button
}

page.Visible = true

Animate(button, 0.2, {
BackgroundColor3 = Config.Active
})
end)

return button, page
end

--==================================================
-- CREATE TABS
--==================================================

local MainButton, MainTab = CreateTab(
"Main",
"Welcome to QwstomScripts!"
)

local PlayerButton, PlayerTab = CreateTab(
"Player",
"Character settings and test tools."
)

local VisualsButton, VisualsTab = CreateTab(
"Visuals",
"Visual tools for tagged test NPCs."
)

local TeleportButton, TeleportTab = CreateTab(
"Teleport",
"Test map locations."
)

local SettingsButton, SettingsTab = CreateTab(
"Settings",
"Customize your interface."
)

--==================================================
-- SELECT MAIN TAB
--==================================================

MainTab.Visible = true

CurrentTab = {
Page = MainTab,
Button = MainButton
}

MainButton.BackgroundColor3 = Config.Active

--==================================================
-- MAIN PAGE
--==================================================

CreateLabel(MainTab, "QWSTOMSCRIPTS GREEN EDITION", 115)

local mainInfo = Instance.new("TextLabel")
mainInfo.Position = UDim2.fromOffset(20, 155)
mainInfo.Size = UDim2.fromOffset(550, 70)
mainInfo.BackgroundTransparency = 1
mainInfo.Text =
"Welcome! This interface contains test tools for your own Roblox environment."
mainInfo.TextColor3 = Color3.fromRGB(180, 200, 185)
mainInfo.TextSize = 14
mainInfo.TextWrapped = true
mainInfo.Font = Enum.Font.Gotham
mainInfo.TextXAlignment = Enum.TextXAlignment.Left
mainInfo.Parent = MainTab

--==================================================
-- PLAYER PAGE
--==================================================

local function GetHumanoid()
local character = Player.Character
return character and character:FindFirstChildOfClass("Humanoid")
end

local speed = 16
local jump = 50

CreateLabel(PlayerTab, "WALK SPEED", 110)

local speedLabel = Instance.new("TextLabel")
speedLabel.Position = UDim2.fromOffset(20, 140)
speedLabel.Size = UDim2.fromOffset(160, 30)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextColor3 = Config.Green
speedLabel.TextSize = 14
speedLabel.Parent = PlayerTab

CreateButton(PlayerTab, "SPEED +", 175, function()
speed = math.clamp(speed + 2, 16, 32)

local humanoid = GetHumanoid()

if humanoid then
humanoid.WalkSpeed = speed
end

speedLabel.Text = "Speed: " .. speed
end)

CreateButton(PlayerTab, "SPEED -", 220, function()
speed = math.clamp(speed - 2, 16, 32)

local humanoid = GetHumanoid()

if humanoid then
humanoid.WalkSpeed = speed
end

speedLabel.Text = "Speed: " .. speed
end)

--==================================================
-- VISUALS PAGE
--==================================================

local highlightEnabled = false
local highlights = {}

local function ClearHighlights()
for _, highlight in ipairs(highlights) do
highlight:Destroy()
end

table.clear(highlights)
end

local function HighlightTestNPCs()
ClearHighlights()

for _, npc in ipairs(
CollectionService:GetTagged("TestNPC")
) do
if npc:IsA("Model")
and npc:FindFirstChildOfClass("Humanoid") then

local highlight = Instance.new("Highlight")
highlight.Name = "QwstomTestHighlight"
highlight.FillColor = Config.Green
highlight.OutlineColor = Color3.new(1, 1, 1)
highlight.FillTransparency = 0.65
highlight.Parent = npc

table.insert(highlights, highlight)
end
end
end

local highlightButton = CreateButton(
VisualsTab,
"Test NPC Highlight: OFF",
110,
function()
highlightEnabled = not highlightEnabled

if highlightEnabled then
HighlightTestNPCs()
else
ClearHighlights()
end

highlightButton.Text =
"Test NPC Highlight: " ..
(highlightEnabled and "ON" or "OFF")
end
)

CreateButton(
VisualsTab,
"REMOVE ALL HIGHLIGHTS",
160,
function()
highlightEnabled = false
ClearHighlights()
highlightButton.Text = "Test NPC Highlight: OFF"
end
)

--==================================================
-- TELEPORT PAGE
--==================================================

local savedPosition = nil

local function GetRoot()
local character = Player.Character

return character and character:FindFirstChild(
"HumanoidRootPart"
)
end

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(20, 100)
status.Size = UDim2.fromOffset(560, 30)
status.BackgroundTransparency = 1
status.Text = "Position: not saved"
status.TextColor3 = Config.Green
status.TextSize = 14
status.Font = Enum.Font.Gotham
status.Parent = TeleportTab

CreateButton(
TeleportTab,
"SAVE POSITION",
140,
function()
local root = GetRoot()

if root then
savedPosition = root.CFrame
status.Text = "Position successfully saved!"
else
status.Text = "Character not found!"
end
end
)

CreateButton(
TeleportTab,
"TELEPORT TO SAVED",
185,
function()
local root = GetRoot()

if root and savedPosition then
root.CFrame = savedPosition
status.Text = "Returned to saved position!"
else
status.Text = "Save a position first!"
end
end
)

CreateButton(
TeleportTab,
"TELEPORT TO TEST SPAWN",
230,
function()
local root = GetRoot()
local spawn = workspace:FindFirstChildWhichIsA(
"SpawnLocation",
true
)

if root and spawn then
root.CFrame = spawn.CFrame + Vector3.new(0, 4, 0)
status.Text = "Moved to test spawn!"
else
status.Text = "Spawn not found!"
end
end
)

CreateButton(
TeleportTab,
"CLEAR POSITION",
275,
function()
savedPosition = nil
status.Text = "Saved position cleared!"
end
)

--==================================================
-- SETTINGS PAGE
--==================================================

local animationButton
local soundButton

animationButton = CreateButton(
SettingsTab,
"Animations: ON",
110,
function()
AnimationsEnabled = not AnimationsEnabled

animationButton.Text =
"Animations: " ..
(AnimationsEnabled and "ON" or "OFF")
end
)

soundButton = CreateButton(
SettingsTab,
"Interface sounds: OFF",
160,
function()
SoundEnabled = not SoundEnabled

soundButton.Text =
"Interface sounds: " ..
(SoundEnabled and "ON" or "OFF")
end
)

CreateButton(
SettingsTab,
"RESET INTERFACE",
210,
function()
AnimationsEnabled = true
SoundEnabled = false

animationButton.Text = "Animations: ON"
soundButton.Text = "Interface sounds: OFF"

speed = 16
jump = 50

local humanoid = GetHumanoid()

if humanoid then
humanoid.WalkSpeed = 16
humanoid.UseJumpPower = true
humanoid.JumpPower = 50
end
end
)

--==================================================
-- WINDOW DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

Logo.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

dragging = true
dragStart = input.Position
startPosition = Window.Position
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and (
input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch
) then

local delta = input.Position - dragStart

Window.Position = UDim2.new(
startPosition.X.Scale,
startPosition.X.Offset + delta.X,
startPosition.Y.Scale,
startPosition.Y.Offset + delta.Y
)
end
end)

UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

dragging = false
end
end)

--==================================================
-- FINISH SPLASH
--==================================================

Animate(Splash, 0.5, {
BackgroundTransparency = 1
})

Animate(SplashLogo, 0.5, {
TextTransparency = 1
})

task.wait(0.6)
Splash:Destroy()

--==================================================
-- READY
--==================================================

print("QwstomScripts v1.6 loaded successfully!")