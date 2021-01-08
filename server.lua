ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- BILLS WITHOUT ESX_BILLING (START)
RegisterServerEvent('rr_portagens:PagaPortagem')
AddEventHandler('rr_portagens:PagaPortagem', function(valor)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_state',function(account)
        stateAccount = account
    end)
	
    xPlayer.removeMoney(valor)
    stateAccount.addMoney(valor)
    
end)