class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @player = 1 # player number in action
  end

  def print_board
    system ("clear")
    puts ""
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "===+===+==="
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "===+===+==="
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts ""
  end

  def start_game
    # start by printing the board
    print_board

    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      print_board
    end
    winner
  end

  def get_human_spot
    begin
      print "Enter [0-8]: "
      spot = gets.chomp
      if valid_spot(spot)
        @board[spot.to_i] = @hum
        @player = 1
      else
        puts "Invalid entry"
        spot = nil
      end
    end until spot
  end

  def valid_spot(spot)
    @board.include?(spot) &&
    @board[spot.to_i] != "X" &&
    @board[spot.to_i] != "O"
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
    @player = 2
  end

  def get_best_move(board)
    available_spaces = []

    # Map all available spaces
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end

    # Loop in available spaces
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        board[as.to_i] = as
        return as.to_i
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          board[as.to_i] = as
          return as.to_i
        else
          board[as.to_i] = as
        end
      end
    end

    # No best move found, randomize a spot
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  def winner
    if tie(@board)
      puts "Tied. Game over!"
    elsif @player.eql? 1
      puts "You win!"
    else
      puts "You lose!"
    end
  end
end

game = Game.new
game.start_game
