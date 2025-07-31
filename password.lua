local Settings = {
  Length = 5, -- Recommended: 5 for Numbers Only, 12 | 15 | 20 for all characters
  numbersOnly = true, -- only Generate Numbers (useful for phone pins)
  charset = {
    -- special characters
   special = {"!", "@",":", "~", "{", "}", "[", "]", "<", ">", "_", "-", "=", "+",".", ";", "'", '"', "£", "$","%", "^", "&", "*", "(", ")", "|"},
   -- normal characters
   
   characters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" , "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c",
     "v", "b", "n", "m", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P" ,"A", "S" ,"D" ,"F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
    threshold = 95, -- if number is higher than this, it will be a special character (min: 1, max: 200, default: 95)
  },
  -- how many times should it run the proccess
  times = math.random(100, 700)
}

---@return string Password
function GeneratePassword()
    local password = ""
    local times = math.random(200, 800) -- how many combinations to generate

    local combos = {}
  
        for loopIndex = 1, times do
        if not combos[loopIndex] then
            combos[loopIndex] = {}
        end
        
        
        for i=1, Settings.Length do
        --[[
            if number only, we do a simple random between 0 and 9,
            if all characters, we do a math.random between 1 and 200, and if the resylt is less than or equal to the threshold, we pick a random character from the settings, 
            if its more than the threshold, we pick a random special character
        ]]
            local num =  Settings.numbersOnly and math.random(0, 9) or math.random(1, 200) <= Settings.charset.threshold and Settings.charset.characters[math.random(1, #Settings.charset.characters)] or Settings.charset.special[math.random(1, #Settings.charset.special)]
            table.insert(combos[loopIndex], num)
        end
    end  

    local passwordIndex = math.random(1, Settings.times) -- pick a random combo
    
    for index = 1, Settings.Length do
        local tbl = combos[passwordIndex] 
        password = string.format("%s%s", password, tbl[index]) -- format the password
    end
    
    return password
end

---@return string Password
function Init()
    local pass = ""

    for i=1, Settings.times do
        pass = GeneratePassword() -- generate the password as many times as in the settings
    end
    return pass
end

print("Creating Password...")
print(Init())
