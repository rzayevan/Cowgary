PImage calgary;
PImage ground;
PImage HQ;
PImage pipe;
PImage smallPipe;
PImage emptyPipe;
PImage bus;

int x = 0;
float cowX = 400;
float cowY = 400;
Animation cowRight, cowLeft, cowIdleLeft,cowIdleRight;

String cowState = "idleRight";
int speed = 0;
int jumpSpeed = 0;

void loadImages() {
  calgary = loadImage("CalgaryBackdrop.png");
  ground = loadImage("Ground.png");
  HQ = loadImage("AmazonHQ.png");
  bus = loadImage("CalgaryTransitBus.png");
  bus.resize(400,100);
  pipe = loadImage("Pipe.png");
  pipe.resize(120,90);
  smallPipe = loadImage("Pipe.png");
  smallPipe.resize(60,40);
  emptyPipe = loadImage("PipeEmpty.png");
  emptyPipe.resize(60,40);
  cowRight = new Animation("right_", 10);
  cowLeft = new Animation("left_", 10);
  cowIdleRight = new Animation("idle_",5);
  cowIdleLeft = new Animation("leftIdle_",5);
}

void setBackground() {
  background(255);
  image(calgary, -x/2, 0);
  image(calgary, -x/2+1000, 0);
  for (int i = 0; i<=6; i++){
    image(ground, -2*x+400*i, 570);
  }
  image(HQ, -2*x+1200, 130);
  
  x+=speed;
  drawCow(false);
}

boolean onPlatform(){
  boolean onPlatform = false;
      for(int i = 0; i<platforms.length; i+=2){
      if(cowX>platforms[i]-100 && cowX<platforms[i]+170 && cowY < platforms[i+1]-90 && cowY > platforms[i+1]-110){
      onPlatform = true;
      pickedUpPipes[i/2] = true;
      }
    }
    if(cowY>470){
      onPlatform = true;
    }
  return onPlatform;
}

void drawCow(boolean moves){
  if(moves){
    cowX+=speed*2;
    cowY-=jumpSpeed;
    
    if(!onPlatform()){
      jumpSpeed-=1;
    }else{
      jumpSpeed = 0; 
    }
  
  }else{
   cowX = 400; 
  }
  
  switch(cowState) {
    case "right":
      cowRight.display(cowX, cowY, 0.3);
      break;
    case "left":
      cowLeft.display(cowX, cowY, 0.3);
      break;
    case "idleLeft":
      cowIdleLeft.display(cowX, cowY, 0.15);
      break;
    case "idleRight":
      cowIdleRight.display(cowX, cowY, 0.15);
      break;
    default:

  }
}

void keyPressed() {
  btnPressed = true;
  switch(keyCode) {    case RIGHT:
      speed = 1;
      btnState = "right";
      cowState = "right";
      break;
    case LEFT:
      speed = -1;
      btnState = "left";
      cowState="left";
      break;
    case UP:
      if(onPlatform()){
        jumpSpeed=15;
      }
      break;
  }
}


void keyReleased() {
  btnPressed = false;
  if(keyCode!=38){
    speed=0;
    if(cowState=="right"){
          cowState="idleRight";
    }else if(cowState=="left"){
          cowState="idleLeft";
    }
  }
}
