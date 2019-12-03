require 'rails_helper'

describe Chirp do

  describe 'validations' do
    it 'does not validate chirps with more than 128 characters' do
      text = 't' * 129
      test_chirp = Chirp.new(text: text)
      expect(test_chirp.valid?).to be(false)
    end

    it 'validates chirps with 128 or fewer characters' do
      text = 't' * 128
      test_chirp = Chirp.new(text: text)
      expect(test_chirp.valid?).to be(true)
    end
  end
end
