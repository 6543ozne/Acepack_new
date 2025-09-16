
--ICON
SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas { --jokers
	-- Key for code to find it with
	key = "CustomJokers",
	-- The name of the file, for the code to pull the atlas from
	path = "CustomJokers.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

--SOUNDS
SMODS.Sound{--for 6shooter
    key="dies",
    path="dies.ogg",
    pitch=0.7,
    volume=0.6
}

SMODS.Sound{--for kallamar
    key="aww",
    path="aww.ogg",
    pitch=0.7,
    volume=0.6
}

SMODS.Rarity {
    key = "generika",
    default_weight = 0.15,
    badge_colour = HEX('748ca3'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

--JOKERS

SMODS.Joker{ --Ace
    key = "ace",
    loc_txt = { --basically all the info and description
        name = 'Ace',
        text = {
            'Retrigger all played Aces.',
            'Aces give {X:red,C:white}X3{} Mult.',
            '',
            '{s:0.7}Its in the name.{}'
        },
        unlock = {
            'Unlocked by default.'
        }
    },
        config = {
        extra = {
            repetitions = 1,
            Xmult = 3
        }
    },
    
    pos = {
        x = 2,
        y = 0
    },
    soul_pos = { --FOR OVERLAY
        x = 3,
        y = 0
    },
    cost = 25,
    rarity = 4,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',


    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = "Again!"
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

SMODS.Joker{ --Shipping wall
    key = "shipping_wall",
    loc_txt = {
        name = 'Shipping Wall',
        text = {
            '{X:red,C:white}X2{} Mult if poker hand contains only a heart and a diamond or a spade and a club',
            '{C:green}:33<The purr-fect jokfur!{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    config = { extra = { Xmult=2} },
    rarity = 2,
    atlas = 'CustomJokers',
    pos = { x=4, y=1 },
    cost = 9,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    
    calculate = function(self, card, context)
    if context.joker_main then
            local suits = {
            ['Hearts'] = 0,
            ['Diamonds'] = 0,
            ['Spades'] = 0,
            ['Clubs'] = 0
        }

        for i = 1, #context.scoring_hand do
            if not SMODS.has_any_suit(context.scoring_hand[i]) then
                if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                    suits["Hearts"] = suits["Hearts"] + 1
                elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                    suits["Diamonds"] = suits["Diamonds"] + 1
                elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                    suits["Spades"] = suits["Spades"] + 1
                elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                    suits["Clubs"] = suits["Clubs"] + 1
                end
            end
        end
        for i = 1, #context.scoring_hand do
            if SMODS.has_any_suit(context.scoring_hand[i]) then
                if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                    suits["Hearts"] = suits["Hearts"] + 1
                elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                    suits["Diamonds"] = suits["Diamonds"] + 1
                elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                    suits["Spades"] = suits["Spades"] + 1
                elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                    suits["Clubs"] = suits["Clubs"] + 1
                end
            end
        end
        if (suits["Hearts"] > 0 and suits["Diamonds"] > 0 and suits["Spades"] == 0 and suits["Clubs"] == 0) or
            (suits["Spades"] > 0 and suits["Clubs"] > 0 and suits["Hearts"] == 0 and suits["Diamonds"] == 0) then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
        

    end
end
}

SMODS.Joker{ --Kallamar aka my wife
    key = "kallamar",
    config = {
        extra = {
            Xmult = 4,
            Xmult2 = 2,
            Acepack_aww = 0
        }
    },
    loc_txt = {
        name = 'Kallamar',
        text = {
            '{X:red,C:white}x2{} Mult for each Joker card',
            '',
            '{X:red,C:white}x4{} Mult if its Ace',
            '',
            '{s:0.7}Ah.. Ma petit chou-fleur.'
        },
        ['unlock'] = {
            'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 1,
        y = 1
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' 
          or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.config.center.key ~= "j_AcePack_kallamar" then
            if (function()
        return context.other_joker.config.center.key == "j_AcePack_ace" end)() then
                return {
                    
                    Xmult = card.ability.extra.Xmult,
                    message = "Love wins",
                    sound = "AcePack_aww" --IT WAS THAT EASY?!?!?!?!?!??
                }
            else
                return {
                    Xmult = card.ability.extra.Xmult2
                }
            end
        end
    end
}

SMODS.Joker{ --rekoj
    key = "rekoj",
    loc_txt ={
        name = 'Rekoj',
        text = {
            '{X:blue,C:white}+400{} {C:blue}Chips {}',
            '',
            '{s:0.7}Joker spelled backwards is Rekoj, which is funny because{}'
        },
        unlock = {
            'Unlocked by default.'
        }
    },
    pos = {x=3, y=1},
    cost = 8,
    rarity = "AcePack_generika",
    config = {
    extra = {
        chips = 400
    }
    },
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    calculate = function(self, card, context)
        if context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
        end
    end

}