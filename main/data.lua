local M = {}

M.STATE_MENU = 1
M.STATE_PLAYING = 2
M.STATE_PAUSE = 4
M.STATE_GAMEOVER = 5

M.state = M.STATE_MENU

M.SCR_W = 0
M.SCR_H = 0
M.CANV_W = 256
M.CANV_H = 144
M.TILE_SIZE = 16
M.PIXEL_SIZE = 4
M.MAX_LEVELS = 10

M.gate = {}
M.cities = 0
M.score = 0

M.S = 30
M.cityx = {M.S, M.S*2, M.S*3, M.CANV_W - M.S,M.CANV_W - M.S * 2,M.CANV_W - M.S * 3}
M.cityy = 20

function M.hex2rgba(hex)
	hex = hex:gsub("#","")
	local rgba = vmath.vector4(tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255, 1)
	return rgba
end

function M.sound(id)
	local t = M.gate[id] or 0
	t = os.clock() - t
	if t > 0.05 then
		M.gate[id] = os.clock()
		msg.post("main:/sound", "play", {id = id})
	end
end


function M.onscreen(p, m)
	if p.x > -m and p.x < m + M.CANV_W and p.y > -m and p.y < m + M.CANV_H then
		return true
	else
		return false
	end
end

function M.fullscreen(self)
	defos.toggle_fullscreen()
	defos.disable_window_resize()
	defos.disable_maximize_button()
end

return M
