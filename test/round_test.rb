require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require './lib/turn.rb'
require './lib/deck.rb'
require './lib/round.rb'

def create_cards
  card1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
  card2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
  card3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?","North North West",:STEM)
  [card1,card2,card3]
end

def create_round
  cards = create_cards
  deck = Deck.new(cards)
  round = Round.new(deck)
end

class RoundTest < Minitest::Test
  def test_it_exists
    assert_instance_of Round, create_round
  end

  def test_it_has_cards
    assert_equal create_cards, create_round.deck.cards
  end

  def test_it_creates_turn
    assert_equal Turn.new("Juneau",create_cards[0]), create_round.take_turn("Juneau")
  end

  def test_it_tracks_current_card
    assert_equal create_cards[0], create_round.current_card
  end

  def test_it_tracks_number_correct
    round = create_round
    round.take_turn("Juneau")
    assert_equal 1, round.number_correct
  end

  def test_it_tracks_number_correct_by_category
    round = create_round
    round.take_turn("Juneau")
    assert_equal 1, round.number_correct_by_category(:Geography)
    assert_equal 0, round.number_correct_by_category(:STEM)
  end

  def test_it_tracks_percent_correct
    round = create_round
    round.take_turn("Juneau")
    assert_equal 100, round.percent_correct
  end

  def test_it_tracks_percent_correct_by_category
    round = create_round
    round.take_turn("Juneau")
    assert_equal 100, round.percent_correct_by_category(:Geography)
    assert_equal 0, round.percent_correct_by_category(:STEM)
  end

  def test_it_can_return_categories
    deck = Deck.new(create_cards)
    round = Round.new(deck)
    assert_equal [:Geography,:STEM], round.categories_in_deck
  end
end
