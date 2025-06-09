repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
task.wait(3)
_G.TargetName = {"Dragonfly", "Disco Bee"}
local notrejoin = false

local foundPetName = nil

local WEBHOOK_URL = "https://discord.com/api/webhooks/1381051554206843011/Oc2nImremPuZt_rKhA-l9Yyrj8IKfTu6ovpIcdqjO5swqbC4TEwx4WHNKzGkTJjAe_ge"

local function sendWebhook(petName)
    local HttpService = game:GetService("HttpService")
    
    local data = {
        content = "@everyone",
        embeds = {{
            title = "🎯 Pet Đã Được Tìm Thấy!",
            description = "**Pet:** `" .. petName .. "`\n**Trạng thái:** ✅ Đã sẵn sàng để mở",
            color = 65280,
            footer = {
                text = "idk"
            },
            timestamp = DateTime.now():ToIsoDate()
        }}
    }

    local success, response = pcall(function()
    return request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end)

    if success then
        print("📨 Đã gửi embed đến Discord Webhook!")
    else
        warn("❌ Gửi Webhook thất bại:", response)
    end
end
local DataSer = require(game:GetService("ReplicatedStorage").Modules.DataService)
while true do wait()
    for i,v in pairs(DataSer:GetData().SavedObjects) do
        if v.ObjectType == "PetEgg" then
            if v["Data"]["RandomPetData"] ~= nil then
                if v.Data["CanHatch"] then
                   for _, target in ipairs(_G.TargetName) do
                    if v.Data.RandomPetData.Name == target then
                        print("✅ Đã tìm thấy:", v.Data.RandomPetData.Name)
                        foundPetName = v.Data.RandomPetData.Name
                        notrejoin = true
                        sendWebhook(foundPetName)
                        end
                    end 
                end
            end
        end
    end
    if not notrejoin then
        wait(3)
        game:GetService("Players").LocalPlayer:Kick("Don't have your target pet\Rejoin")
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
end
