require 'open-uri'
class GamesController < ApplicationController
  # The new action will be used to display a new random grid and a form.
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end
  # The form will be submitted (with POST) to the score action.

  def score
    # string
    answer = params[:answer]
    # also string now
    letters = params[:letters].gsub(/\s+/, '')

    if check_letters(answer, letters)
      if check_dictionary(answer)
        @answer = 'Well done! Here is your score: XXXX'
      else @answer = 'This is not even an English word, loser!'
      end
    else
      @answer = 'Sorry, your word is not contained in the letters grid'
    end
  end

  private

  def check_letters(answer, letters)
    answer.chars.all? { |letter| answer.chars.count(letter) <= letters.chars.count(letter) }
  end

  def check_dictionary(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end


end
