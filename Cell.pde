class Cell{
  
  float x, y;
  boolean alive = false;
  boolean nextState = false;


  Cell neighbours[] = new Cell[8];
  
  public Cell(){
    
  }
  
  public Cell(float x, float y){
    
    
    for(int i = 0; i < 4; i++)
      neighbours[i] = null;
    
    this.x = x;
    this.y = y;
  }
 
 
  
  void show(){
    
    stroke(115,134,120);
    
    if(alive)
      fill(115,134,120);
      
     else
       fill(0);
    
    rect(x, y, x + cellSize, y + cellSize);
    
    //stroke(0, 255, 0);
    //fill(255);
    //text((int) x / cellSize + "  " + (int) y / cellSize, x + cellSize / 4, y + cellSize / 2);
    
  }
  
  
  void preUpdate(){
    
    int aliveNeighNum = countNeighbours();
    
    nextState = alive;
  
    if(alive && aliveNeighNum < 2)
      nextState = false;
 
      
    if(alive && aliveNeighNum > 3)
      nextState = false;
      
      
    if(!alive && aliveNeighNum == 3)
      nextState = true;
  }
  
  
  void update(){
    
    if(nextState)
      makeAlive();
      
    else
      kill();
  }
  
  
  void printInfo(boolean printNeighbours){
    
    println("x : " + (int) x  / cellSize + "   y : " + (int) y / cellSize );
    
    if(printNeighbours)
      for(int i  = 0; i < 8; i++){
        
        println(" neighbour #" + i);
        
        if(neighbours[i] == null)
          println("null");
        else
          neighbours[i].printInfo(false);
      }
  }
  
  
  int countNeighbours(){
    
    int aliveNeighNum = 0;
    
    for(int i = 0; i < 8; i++)
      if(neighbours[i] != null && neighbours[i].isAlive())
        aliveNeighNum++;

    return aliveNeighNum;
  }
 
  
  void makeAlive(){
    
    alive = true;
  }
  
  
  void kill(){
    
    alive = false;
  }
  
  
  boolean isAlive(){
    
    return alive;
  }
  
  
  void assignRightN(Cell s){
    
    neighbours[3] = s;
  }
  
  
  void assignLeftN(Cell s){
    
    neighbours[7] = s;  
  }
  
  
  void assignTopN(Cell s){
    
    neighbours[1] = s; 
  }
  
  
  void assignBottomN(Cell s){
    
    neighbours[5] = s; 
  }
  
  
  void assignBottomRN(Cell s){
    
    neighbours[4] = s; 
  }
  
  
  void assignBottomLN(Cell s){
    
    neighbours[6] = s;  
  }
  
  
  void assignTopRN(Cell s){
    
    neighbours[2] = s;
  }
  
  
  void assignTopLN(Cell s){
    
    neighbours[0] = s;
  }
}
