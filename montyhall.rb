module Selector
  MYSELF = 0
  CHAIRPERSON = 1
  NOCHOICE = 2
end

SELECTOR_NAME = {
  Selector::MYSELF => '自分',
  Selector::CHAIRPERSON => '司会者',
  Selector::NOCHOICE => '未選択'
}

class MontyHall
  def initialize()
   @noChangeWinCount = 0
   @changedWinCount = 0
   @totalCount = 0
  end

  def setWinDoors()
    @winDoors = []
    for i in 0..2
      @winDoors[i] = false
    end

    @winDoors[getRandNumber] = true
  end

  def setSelectDoors()
    @selectDoors = []
    for i in 0..2
      @selectDoors[i] = Selector::NOCHOICE
    end

    @selectDoors[getRandNumber] = Selector::MYSELF
  end

  def selectChairPerson()
    for i in 0..2
      isWin = @winDoors[i]
      selector = @selectDoors[i]

      if !isWin && selector != Selector::MYSELF then
        @selectDoors[i] = Selector::CHAIRPERSON
        break
      end
    end
  end  

  def displayState()
    for i in 0..2
      puts i
      puts SELECTOR_NAME[@selectDoors[i]]
      puts @winDoors[i] ? '当たり' : 'はずれ'
    end   
    
    puts '最初の選択を貫いた場合に当たる確率：' + sprintf("%.2f", (@noChangeWinCount.quo(@totalCount) * 100)) + '%'
    puts '選び直した場合に当たる確率：' + sprintf("%.2f", (@changedWinCount.quo(@totalCount) * 100)) + '%'
  end
    
  def judgment()
    @totalCount += 1
    if @winDoors[@selectDoors.index(Selector::MYSELF)] then
      @noChangeWinCount += 1
    else
      @changedWinCount += 1
    end
  end

  def getRandNumber()
    return rand 3
  end

  def select()
   setWinDoors()
   setSelectDoors()
   selectChairPerson()
  end
end

monty = MontyHall.new

for i in 0..10000
  monty.select()
  monty.judgment()
end

monty.displayState()
