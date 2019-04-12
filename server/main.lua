local fs = require 'bee.filesystem'

local ROOT = fs.current_path()

package.path = (ROOT / 'src' / '?.lua'):string()
     .. ';' .. (ROOT / 'src' / '?' / 'init.lua'):string()

--collectgarbage('generational')
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 1000)

local log = require 'log'
log.init(ROOT, ROOT / 'log' / 'service.log')
log.info('Lua Lsp startup, root: ', ROOT)

local function tryDebugger()
     local dbg = require 'debugger'
     dbg:io 'listen:127.0.0.1:11411'
     dbg:start()
     log.info('Debugger startup, listen port: 11411')
end

pcall(tryDebugger)

require 'utility'
require 'global_protect'
local service = require 'service'
local session = service()

session:listen()
