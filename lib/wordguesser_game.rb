class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word
    return @word
  end

  def guesses
    return @guesses
  end

  def wrong_guesses
    return @wrong_guesses
  end

  def guess(input)
    if input == nil || input == '' || !input.match?(/[a-zA-Z]/)
      raise ArgumentError
    end
    input.downcase!
    if @guesses.include?(input) || @wrong_guesses.include?(input)
      return false
    end
    if @word.include?(input)
    @guesses += input
    @wrong_guesses += ''
    else
      @guesses += ''
      @wrong_guesses += input
    end
  return true
  end
  def word_with_guesses
    result = ''
    @word.chars.each do |input|
      if @guesses.include?(input)
        result << input
      else
        result << '-'
      end
    end
    result
  end
  def check_win_or_lose
    if  word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play 
    end
  end

    # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
