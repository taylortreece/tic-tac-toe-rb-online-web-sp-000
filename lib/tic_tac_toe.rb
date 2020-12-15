WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    return user_input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, user_input)
    user_input.between?(0, 8) && !position_taken?(board, user_input)

end

def move(board, user_input, value)
    board[user_input] = value
    return display_board(board)
end

def turn_count(board)
    counter = 0
    board.each do |move|
    if move != " "
        counter += 1
        end
    end
    return counter
end

def current_player(board)
    character = turn_count(board)
    if character == 0
        return "X"
    elsif character % 2 == 1
        return "O"
    elsif character % 2 == 0
        return "X"
    end
end

def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
    else
        turn(board)
    end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && position_taken?(board, win_index_1)

  end
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    puts "Cat's Game!"
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    puts "Congratulations #{board[won?(board)[0]]}!"
    return board[won?(board)[0]]
  end
end

#play method

def play(board)
  while !over?(board) do turn(board)
 end
 winner(board)
 draw?(board)
end
