import de.bezier.guido.*;
import de.bezier.guido.*;

int NUM_ROWS= 20;
int NUM_COLS= 20;
private MSButton[][] buttons; 
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); 
private int minesStart= (NUM_ROWS*NUM_COLS)/10;
private int nClicked =0;
private boolean game = true;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons= new MSButton[20][20];
    for(int r=0; r< NUM_ROWS; r++){
      for(int c=0; c<NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      
      }
    }
    for(int i=0; i<minesStart; i++){
    setMines();
}
}
public void setMines()
{
    //your code
    int row=(int)(Math.random()* NUM_ROWS);
    int col=(int)(Math.random()*NUM_COLS);
    if (!(mines.contains(buttons[row][col]))){
      mines.add(buttons[row][col]);
    }
}

public void draw ()
{
    background( 0 );
    isWon();
        
}
public void isWon()
{
  nClicked=0;
  for(int r=0; r<buttons.length; r++){
    for(int c=0; c<buttons[r].length; c++){
      if(buttons[r][c].clicked==true){
        nClicked++;
      }
    }
  }
  if(nClicked >= ((NUM_ROWS*NUM_COLS)-mines.size())){
    displayWinningMessage();
  }
}
      
public void displayLosingMessage()
{
    //your code here
    game = false;
    int r = 9;
    buttons[r][6].myLabel = "Y";
    buttons[r][7].myLabel = "O";
    buttons[r][8].myLabel = "U";
    buttons[r][9].myLabel = "";
    buttons[r][10].myLabel = "L";
    buttons[r][11].myLabel = "O";
    buttons[r][12].myLabel = "S";
    buttons[r][13].myLabel = "E";
}
public void displayWinningMessage()
{
    //your code here
     game = false;
    int r = 9;
    buttons[r][6].myLabel = "Y";
    buttons[r][7].myLabel = "O";
    buttons[r][8].myLabel = "U";
    buttons[r][9].myLabel = "";
    buttons[r][10].myLabel = "W";
    buttons[r][11].myLabel = "I";
    buttons[r][12].myLabel = "N";
    buttons[r][13].myLabel = "!";
}
public boolean isValid(int r, int c)
{
    //your code here
    if((r< NUM_ROWS && r>=0)&&(c<NUM_COLS && c>=0)){
    return true;
  }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for(int j = -1; j < 2; j++){
      for(int i = -1; i < 2; i++){
        if((isValid(row+j, col+i)) && (mines.contains(buttons[row+j][col+i])) && ((row+j != row)||(col+i != col))){
          numMines++;
        }
      }
    }
    
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
     if (game) {
            if (!clicked && !flagged) { 
                clicked = true;
                if (mouseButton == RIGHT) {
                    flagged = !flagged;
                    if (!flagged) {
                        clicked = false;
                        setLabel(""); 
                    }
                } else if (mines.contains(this)) {
                    displayLosingMessage();
                } else if (countMines(myRow, myCol) > 0) {
                    setLabel(countMines(myRow, myCol));
                } else {
        //your code here
        for(int r=-1; r<2; r++){
          for(int c=-1; c<2; c++){
            if(((myRow+ r != myRow) || (myCol + c != myCol)) && isValid(myRow +r, myCol +c) &&(!buttons[myRow +r][myCol+c].clicked)){
                buttons[myRow +r][myCol+c].mousePressed();
            }
          }
        }
      }
    }
    }
    }
     public void draw () 
     {    
        if (flagged)
            fill(250,229,66);
         else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
