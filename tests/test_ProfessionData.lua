local lu = require('luaunit')

loadfile('test_data2.lua')()
loadfile('wow_functions.lua')()

loadfile('frame.lua')()
loadfile('load_toc.lua')('../ProfessionMailer.toc')

_G['test'] = {}
local test = _G['test']
local ProfessionData =_G['ProfessionData']

function test:testInitTable()
	lu.assertNil(_G['test_table'])
	ProfessionData:init_table('test_table', 'test2')
	lu.assertNotNil(_G['test_table'])
end

function test:testItemUsedFor()
	local usages = ProfessionData:ItemUsedFor(118)
	lu.assertEquals(usages,  {[858] = {
		["name"] = "Lesser Healing Potion",
		["itemID"] = 858,
	}})
end

function test:testDifficulty()
	local difficulty = ProfessionData.RecipeDifficulty('Quadbear-Mirage Raceway', 733)
	lu.assertEquals('optimal', difficulty)
end

function test:testWhoNeeds()
	local needs = ProfessionData:whoNeeds(2447)
	lu.assertEquals(needs[1]['name'], 'Elixir of Minor Fortitude')
	lu.assertEquals(needs[1]['craftedItemId'], 2458)
	lu.assertEquals(needs[1]['character'], 'Quadbear-Mirage Raceway')
end

function test:testWhoNeeds2()
	local needs = ProfessionData:whoNeeds(2678)
	lu.assertEquals(needs[2]['name'], 'Herb Baked Egg')
	lu.assertEquals(needs[2]['craftedItemId'], 6888)
	lu.assertEquals(needs[2]['character'], 'Quadbear-Mirage Raceway')
end

function test:testWhoNeedsNone()
	local needs = ProfessionData:whoNeeds(3280)
	lu.assertNil(needs)
end


os.exit( lu.LuaUnit.run() )