local listMgr = require 'vm.list'

---@class EmmyParam
local mt = {}
mt.__index = mt
mt.type = 'emmy.param'

function mt:getName()
    return self.name
end

function mt:getSource()
    return listMgr.get(self.source)
end

function mt:bindType(type)
    if type then
        self._bindType = type
    else
        return self._bindType
    end
end

function mt:bindGeneric(generic)
    if generic then
        self._bindGeneric = generic
    else
        return self._bindGeneric
    end
end

function mt:addEnum(str)
    self._enum[#self._enum+1] = str
end

function mt:eachEnum(callback)
    for _, str in ipairs(self._enum) do
        callback(str)
    end
end

return function (manager, source)
    local self = setmetatable({
        source = source.id,
        _manager = manager,
        _enum = {},
    }, mt)
    if source.type == 'emmyParam' then
        self.name = source[1][1]
    elseif source.type == 'emmyVararg' then
        self.name = '...'
    end
    return self
end
