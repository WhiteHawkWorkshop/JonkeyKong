--- STEAMODDED HEADER
--- MOD_NAME: Jonkey Kong
--- MOD_ID: JonkeyKong
--- MOD_AUTHOR: [WhiteHawkWorkshop]
--- MOD_DESCRIPTION: In celebration of Dongtober 2024, adds Jonkey Kong to the available jokers.
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: dec63c
--- PREFIX: kong
----------------------------------------------
------------MOD CODE -------------------------

-- code referenced:
-- Steamodded - example mods - https://github.com/Steamopollys/Steamodded/ - formatting, joker structure
-- DVRP - RiskofJesters https://dvrp-balatro-mods.pages.dev/risk-of-jesters - creating a specific joker by key
-- JustinBanzon - Bird Jokers https://github.com/JustinBanzon/Bird-Jokers - custom sound effects

--Creates an atlas for cards to use
SMODS.Atlas {
  -- Key for code to find it with
  key = "JonkeyKong",
  -- The name of the file, for the code to pull the atlas from
  path = "JonkeyKong.png",
  -- Width of each sprite in 1x size
  px = 69,
  -- Height of each sprite in 1x size
  py = 93
}

local ohbanana = SMODS.Sound({
    key = "ohbanana",
    path = "ohbanana.ogg"
})

SMODS.Joker {
  key = 'jonkey_kong',
  loc_txt = {
    name = 'Jonkey Kong',
    text = {
      "When {C:attention}Boss Blind{} is",
      "defeated, creates a",
      "{C:dark_edition}Negative{} {C:attention}Gros Michel{}",
    }
  },
  config = { extra = {} },
  -- I made this Common because if you're using this mod you probably want to see Jonkey Kong pretty often. If I was actually balancing this, I'd make him Uncommon.
  rarity = 1,
  atlas = 'JonkeyKong',
  pos = { x = 0, y = 0 },
  cost = 5,
  calculate = function(self, card, context)
    -- if boss blind is defeated
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.game_over then
      
      -- play sound effect
      G.E_MANAGER:add_event(Event({
        func = function()
          ohbanana:play(1, 1, true)
          return true
        end
      }))
      
     delay(1)

      -- create Gros Michel
      G.E_MANAGER:add_event(Event({
        func = function()

          -- create specifically Gros Michel by setting forced_key input of create_card to 'j_gros_michel'
          local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_gros_michel', 'kon')

          -- Vanilla function, it's (edition, immediate, silent), so this is ({edition = 'e_negative'}, immediate = true, silent = nil)
          card:set_edition('e_negative', true)
          card:add_to_deck()

          -- card:emplace puts a card in a cardarea
          G.jokers:emplace(card)
          return true
        end
      }))
      -- Ask someone who knows eval_status_text better to elaborate on this.
      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
        { message = 'Oh, Banana!' })
    end
  end
}

----------------------------------------------
------------MOD CODE END----------------------
