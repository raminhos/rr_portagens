local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        for k in pairs(Config.ToolCoords) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.ToolCoords[k].x, Config.ToolCoords[k].y, Config.ToolCoords[k].z)

            if dist <= Config.ToolCoords[k].dist then
                local playerPed = GetPlayerPed(-1)
                local playerCar = GetVehiclePedIsIn(playerPed, false)
                local veh = GetVehiclePedIsIn(playerPed)
                local SpeedKM = GetEntitySpeed(playerPed)*3.6
                
                if SpeedKM > 10 then
                    if IsPedInAnyVehicle(playerPed, false) then
                        if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
                            --print("PAGOU")
                            TriggerServerEvent('rr_portagens:PagaPortagem', Config.ToolCoords[k].valor)
                            ESX.ShowNotification("Pagaste ~g~$" .. Config.ToolCoords[k].valor .. " ~w~de portagem")
                            --print("PAUSOU")
                            Citizen.Wait(5000)
                        end
                    end
                end
            end
        end
    end
end)