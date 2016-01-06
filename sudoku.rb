require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def retrieve_pos_from_ui
    p = nil
    until p && legal_illegibility_of_p?(p)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        p = parse_inanity(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        p = nil
      end
    end
    p
  end

  def retrieve_value_from_ui
    v = nil
    until v && legal_illegibility_of_v?(v)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      v = parse_insanity(gets.chomp)
    end
    v
  end

  def parse_inanity(string)
    string.split(",").map { |char| Integer(char) }
  end

  def parse_insanity(string)
    Integer(string)
  end

  def process_parameters
    pos_to_val(retrieve_pos_from_ui, retrieve_value_from_ui)
  end

  def pos_to_val(p, v)
    board[p] = v
  end

  def commence_proceedings
    process_parameters until board_process_terminates?
    puts "Congratulations, you win!"
  end

  def board_process_terminates?
    board.terminate?
  end

  def legal_illegibility_of_p?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def legal_illegibility_of_v?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.commence_proceedings
