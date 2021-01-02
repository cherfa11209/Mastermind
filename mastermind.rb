class Mastermind
  attr_accessor = :secret_code, :color_pool, :answer, :computer_ai

  def initialize
    @computer_ai = []
    @secret_code = []
    @color_pool = ["r", "g", "b", "y", "i", "o", "v"]
    @matching_array = ["-", "-", "-", "-"]
  end

  def formulate_secret_pc
    while @secret_code.length < 4
      color = @color_pool.sample
      @secret_code.push(color)
    end
  end

  def get_guess
    guess_array = []
    puts "--------------------------------------------------"

    until guess_array.length == 4
      puts "guess an initial of one of the colors of the rainbow:"
      guess = gets.chomp
      if @color_pool.include?(guess)
        guess_array.push(guess) 
      else 
        puts "That is in invalid answer, please guess again"
      end
    end
    puts "your answer was #{guess_array}"
    puts ""
    puts "thank you, we will now compare answer to secret code....."
    puts "---------------------------------------------------"
    compare_answer(guess_array)
  end

  def compare_answer(array)
    puts "---------------------------------------------------"
    counter = 0
    until counter == 4
      if array[counter] == @secret_code[counter]
        right_guess =  array[counter]
        @matching_array[counter] = right_guess
      elsif @secret_code.include?(array[counter]) && @secret_code[counter] != array[counter]
        puts "the color #{array[counter]} is correct but it's position is false"
        puts ""
      else
        puts "the color #{array[counter]} is not a part of the secret_code"
        @computer_ai.push(array[counter])
        puts ""
      end
      counter +=1
    end
    print @matching_array
    puts ""
  end

  def play_game_as_code_breaker
    formulate_secret_pc
    remaining_turns = 8

    until remaining_turns == 0 or @matching_array.include?("-") == false
      get_guess
      remaining_turns -= 1
      puts "#{remaining_turns} turns remain"
      ""
    end
    check_for_winner
  end

  def check_for_winner
    if @matching_array.include?("-")
      puts "computer wins!"
    else 
      puts "player wins!"
    end
  end

  def decide_coder
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome to Mastermind! The rules of the game are :

    One player makes a secret code using the initials of rainbow colors,
    the other player must guess the code correctly within 8 turns. 
    the choice is up to you- will you be the coder or the code breaker? 
    [coder/code-breaker]:"
    answer = gets.chomp

    if answer == "code-breaker"
      play_game_as_code_breaker
    elsif answer == "coder"
      play_game_as_coder
    else 
      puts "invalid choice you must decide coder"
      decide_coder
    end
  end

  def formulate_secret_user
    puts "you must pick 4 color initials to formulate your secret code"
    until @secret_code.length == 4 
      puts "choose an initial of one of the colors of the rainbow: "
      answer = gets.chomp
      if @color_pool.include?(answer)
        @secret_code.push(answer)
      else 
        puts "that is an incorrect answer! Try again:"
      end
    end
    puts "your secret code is #{@secret_code}"
    puts "--------------------------------------------------------"
  end

  def check_matching_array
    matching_array_content = []
    @matching_array.each do |char|
      if @color_pool.include?(char)
        matching_array_content.push(char)
      else
        puts "-"
      end
    end
  end

  def computer_guess
    computer_guess_array = []
    x = 0
    until computer_guess_array.length == 4 
      guess_index = rand(0..6)
      choice = @color_pool[guess_index] 
      computer_guess_array.push(choice) unless @computer_ai.include?(choice)
    end

    until x == 4
      if @matching_array[x] == "-"
        x += 1
      elsif @matching_array[x] != "-"
        computer_guess_array[x] = @matching_array[x]
        x += 1
      end
    end

    print computer_guess_array
    puts ""
    compare_answer(computer_guess_array)
    check_matching_array
  end

  def play_game_as_coder 
    turns = 8
    formulate_secret_user
    until turns == 0 or @matching_array.include?("-") == false
      computer_guess
      turns -= 1
      puts "computer has #{turns} remaining"
      puts "-------------------------------------------------"
    end

  end

end

mind = Mastermind.new
mind.decide_coder
