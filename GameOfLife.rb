require 'pp'

ROWS = 10
COLUMNS = 10
SPEED = 1



puts "for a #{ROWS}x#{COLUMNS} grid. Set in initial state by stating the live values as r,c. Put in -1,-1 to stop"
@ini_state = []
r=0
c=0

#input initial state
while r.to_i>-1 and c.to_i>-1 do
  puts "r = "
  r= gets
  puts "c = "
  c= gets
  @ini_state.push [r.to_i,c.to_i] if r.to_i>-1 and c.to_i>-1
end

@grid = Array.new(ROWS) { Array.new(COLUMNS) }

#default values
(0...ROWS).each do |row|
  (0...COLUMNS).each do |col|
    @grid[row][col] = false
   end
end

#initialize initial state
for i in (0...@ini_state.length)
  @grid[@ini_state[i][0]][@ini_state[i][1]] = true
end
puts @grid[1][2]

while (1==1)
  system('clear')
 
  (0...ROWS).each do |row|
    (0...COLUMNS).each do |col|
      print @grid[row][col] ? '*' : ' '
    end
    puts
  end

  # create an new_grid field
  new_grid = @grid.map(&:dup)
  
  def alive?(row, col)
    return false if row < 0 || row >= ROWS
    return false if col < 0 || col >= COLUMNS
    @grid[row][col]
  end
  
  (0...ROWS).each do |row|
    (0...COLUMNS).each do |col|
      neighbours = 0
      [-1, 0, 1].each do |row_off|
        [-1, 0, 1].each do |col_off|
          next if row_off == 0 && col_off == 0
           neighbours += 1 if alive?(row + row_off, col + col_off)
        end
      end


      if @grid[row][col]
        new_grid[row][col] = neighbours == 2 || neighbours == 3
        new_grid[row][col] = !(neighbours < 2 || neighbours >3)
      else
        new_grid[row][col] = (neighbours == 3)
      end
    end
  end
  
  @grid = new_grid
  sleep(1.0 / SPEED)
  r
end

