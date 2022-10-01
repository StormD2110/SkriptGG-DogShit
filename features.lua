Citizen.CreateThread(function()
    if Cypher.AntiVoid then
      Citizen.Wait(0)
        local ped = PlayerPedId()
        local currentPos = GetEntityCoords(ped)
        local retval, groundZ = GetGroundZFor_3dCoord(currentPos.x, currentPos.y, currentPos.z, false)
        local dist = currentPos.z - groundZ
        if IsPedInAnyVehicle(ped, false) then
          local vehicle = GetVehiclePedIsUsing(ped)
          local isheli = GetVehicleClass(vehicle)
          if isheli == 15 or isheli == 16 then
            return
          end
          if currentPos.z - groundZ > 500 or groundZ < 1 and currentPos.z > 50 then
            SetPedCoordsKeepVehicle(PlayerPedId(), myCoords.x, myCoords.y, myCoords.z)
          end
      end
    end
  end)

  Citizen.CreateThread(function()
    while true do
      local ped = PlayerPedId()
      Citizen.Wait(100)
      if IsPedInAnyVehicle(ped, false) then
        local currentPos = GetEntityCoords(ped)
        myCoords = GetEntityCoords(ped)
        Citizen.Wait(30000)
      end
    end
  end)

loadedvehicles = {}
        Citizen.CreateThread(function()
            if Cypher.AntiGrab then
            Citizen.Wait(500)
            local vehs = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehs) do
                local owner = NetworkGetEntityOwner(vehicle)
                if not loadedvehicles[vehicle] then
                    table.insert(loadedvehicles, {vehicle = vehicle, owner = owner})
                else
                    for i, k in pairs(loadedvehicles) do
                        if k.vehicle == vehicle then
                            if owner ~= k.owner then
                                TriggerServerEvent('Cypher:Ban', Cypher.GrabPunishment, "Vehicle Grab", 'It looks like: ' .. tonumber(GetPlayerServerId(owner)) .. ' is grabbing the Vehicle of '.. tonumber(GetPlayerServerId(k.owner)))
                            end
                        end
                    end
                end
            end
           end
        end)
