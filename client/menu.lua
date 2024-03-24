ESX = exports['es_extended']:getSharedObject()

print("^1[INFO]^0 Ramoune - Menu factures chargé")

OpenMenu = false
local mainBilling = RageUI.CreateMenu("Factures", "MENU", 0, 0, nil, nil, 0, 255, 255, 255)
mainBilling.Closed = function()
    OpenMenu = false
end
local billings = {}
function Factures()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainBilling, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainBilling, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                ESX.TriggerServerCallback('Ramoune:getBills', function(bills)
                    billings = bills
                    ESX.PlayerData = ESX.GetPlayerData()
                end)
                RageUI.IsVisible(mainBilling, funcwtion()
                        if #billings == 0 then
                            RageUI.Separator("")
                            RageUI.Separator("~r~Vous n'avez pas de factures impayées")
                            RageUI.Separator("")
                        end
                        for i = 1, #billings, 1 do
                            RageUI.Button(billings[i].label, nil, {RightLabel = '[' .. ESX.Math.GroupDigits(billings[i].amount.."~s~] →")}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('esx_billing:payBill', function()
                                        ESX.TriggerServerCallback('Ramoune:getBills', function(bills) billings = bills end)
                                    end, billings[i].id)
                                end
                            })
                        end 
                end)
            end
        end)
    end
end

Keys.Register('F4', 'F4', 'Ouvrir le menu factures', function()
    Factures()
end)

