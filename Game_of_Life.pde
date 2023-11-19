/*
CONTROLS

MOUSE CLICK OR DRAG TO MAKE CELL AVIVE

'p' - PAUSE
'i' - SHOW INSPECTOR
'+' - INCREASE FRAMERATE
'-' - DECREASE FRAMERATE
'k' - KILL CELL
'c' - KILL ALL CELLS
'g' - BORN GLIDER
'r' - ADD RANDOM LIFE
*/




Cell cells[][];

final int cellSize = 10;
int FRAMERATE = 100; // 1000/FRAMERATE UPDATE RATE FOR CELLS
boolean pause = false;
boolean inspector = false;
int cellsW, cellsH;



void setup() {

  size(400, 300);
  frameRate(30);

  pixelDensity(2);

  initializeCells();
}



void draw() {

  boolean newFrame = isTime() && !pause;
  
  if(newFrame)
    for (int i = 0; i < cellsW; i++)
      for (int j = 0; j < cellsH; j++)
        cells[i][j].preUpdate();
      
  for (int i = 0; i < cellsW; i++)
    for (int j = 0; j < cellsH; j++)
      cells[i][j].show();
  
  
  if(newFrame)
    for (int i = 0; i < cellsW; i++)
      for (int j = 0; j < cellsH; j++)
        cells[i][j].update();
  

  if (inspector)
    inspectorInfo();


  noFill();
  
  if(pause)
    stroke(255, 0, 0);
  else
    stroke(115,134,120);

  rect(0, 0, width - 1, height - 1);
}


long lastFrame = 0;

boolean isTime(){
  
  if(millis() - lastFrame > FRAMERATE){
    
    lastFrame = millis();
    return true;
  }
  
  return false;
}



void mouseClicked() {

  cells[(int) mouseX / cellSize][(int) mouseY / cellSize].makeAlive();
}



void mouseDragged(){
 
 cells[(int) mouseX / cellSize][(int) mouseY / cellSize].makeAlive();
}



void keyPressed() {

  if (key == 'p')
    pause = !pause;

  if (key == 'i')
    inspector = !inspector;
    
  if(key == '+')
    FRAMERATE -= FRAMERATE / 2;
    
  if(key == '-')
    FRAMERATE += 100;
    
  if(key == 'k')
    cells[(int) mouseX / cellSize][(int) mouseY / cellSize].kill();
    
  if(key == 'c')
    for (int i = 0; i < cellsW; i++)
      for (int j = 0; j < cellsH; j++)
        cells[i][j].kill();
        
  if(key == 'g'){
    
    cells[(int) mouseX / cellSize + 1][(int) mouseY / cellSize - 1].makeAlive();
    cells[(int) mouseX / cellSize + 1][(int) mouseY / cellSize].makeAlive();
    cells[(int) mouseX / cellSize + 1][(int) mouseY / cellSize + 1].makeAlive();
    cells[(int) mouseX / cellSize][(int) mouseY / cellSize + 1].makeAlive();
    cells[(int) mouseX / cellSize - 1][(int) mouseY / cellSize].makeAlive();
  }

  if(key == 'r')
    for (int i = 0; i < cellsW; i++)
      for (int j = 0; j < cellsH; j++)
        if(((int) random(10)) == 1)
          cells[i][j].makeAlive();    
}



void inspectorInfo() {
  
  Cell cs = cells[(int) mouseX / cellSize][(int) mouseY / cellSize];
  
  //int n = cs.countNeighbours();


  //fill(255);
  //stroke(255);
  //rect(mouseX, mouseY - 20, 80, 30);

  //fill(255, 0, 0);
  //text(n + " neighbours", mouseX + 5, mouseY);
  
  
  for(int i = 0; i < 8; i++){
    
    Cell cn = cells[(int) mouseX / cellSize][(int) mouseY / cellSize].neighbours[i];
    
    if(cn != null){
    
      if(cn.isAlive())
        stroke(0, 255, 0);
      else
        stroke(255, 0, 0);

      line(cs.x + cellSize / 2, cs.y + cellSize / 2, cn.x + cellSize / 2, cn.y + cellSize / 2);
    }
    
    
  }
}



void initializeCells(){
  
  cellsW = width / cellSize;
  cellsH = height / cellSize;

  cells = new Cell[cellsW][cellsH];

  for (int i = 0; i < cellsW; i++)
    for (int j = 0; j < cellsH; j++)
      cells[i][j] = new Cell(i * cellSize, j * cellSize);


  //assign neighbours
  for (int i = 0; i < cellsW; i++)
    for (int j = 0; j < cellsH; j++) {

      if (i > 0)
        cells[i][j].assignLeftN(cells[i - 1][j]);

      if (i < cellsW - 1)
        cells[i][j].assignRightN(cells[i + 1][j]);

      if (j > 0)
        cells[i][j].assignTopN(cells[i][j - 1]);

      if (j < cellsH - 1)
        cells[i][j].assignBottomN(cells[i][j + 1]);



      if (i > 0 && j > 0)
        cells[i][j].assignTopLN(cells[i - 1][j - 1]);

      if (i < cellsW - 1 && j > 0)
        cells[i][j].assignTopRN(cells[i + 1][j - 1]);

      if (i < cellsW - 1 && j < cellsH - 1)
        cells[i][j].assignBottomRN(cells[i + 1][j + 1]);

      if (i > 0 && j < cellsH - 1)
        cells[i][j].assignBottomLN(cells[i - 1][j + 1]);
    }
}
