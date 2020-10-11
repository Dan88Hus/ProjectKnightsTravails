def valid_move?(move)
  return "out of board is restricted area" if (move[0] > -1 && move[0] <= 8) && (move[1] > -1 && move[1] <= 8)
  false
end

def make_move(start)
  moves = []
  possible_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  possible_moves.each do |move|
  move[0] += start[0]
  move[1] += start[1]
  moves.append(move)
  end
  moves.select { |move| valid_move?(move) }
end

def game_board(start, line = [start], visited_array = [], path = [])
  return path if line.empty?

  new_move = line.shift
  visited_array << new_move
  temp_line = make_move(new_move)
  temp_line = temp_line.select { |move| !visited_array.include?(move) && !line.include?(move) }
  temp_line.each { |move| line << move }
  path << [new_move, temp_line] unless temp_line.empty?
  game_board(start, line, visited_array, path)
  path
end

def short_path(start, finish, path = [finish])
  return "This is your place" if start == finish

  path_table = game_board(start)
  until finish == start
    path_table.each do |i|
      next unless i[1].include?(finish)

      path.append(i[0])
      finish = i[0]
    end
  end
  path.reverse
end

def knight_moves(start, finish)
  path = short_path(start, finish)
  puts "You made it in #{path.length-1} moves!'} Here's your path:"
  path.each { |move| puts "#{move}" }
end
knight_moves([3, 3], [4, 3])
