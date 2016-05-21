int w = 0;
int h = 0;
 
// グラフの線の色を格納
color[] col = new color[6];

// number of frames per 1 second
int numFrames = 10;

// y zahyo on one step before
float tyOld = 0;

int thickness = 20;

float heightCoef = 1.5;

String lines[];

void setup() {
  //画面設定
  size(852, 480);
  frameRate(60);
  
  lines = loadStrings("160521-SpeedData-160429-1410.txt");
  
  //グラフ初期化
  initGraph();
}
 
void draw() {
  // センサーの数だけ、グラフをプロット  
  float tx = map(w*thickness, 0, width, 0, width);
  float ty = map(float(lines[w])*(h + 1)*heightCoef, 0, 1023, height, 0);
  float tyOld = map(float(lines[w])*h*heightCoef, 0, 1023, height, 0);
  strokeWeight(thickness);
  stroke(col[0]);
  line(tx, tyOld, tx, ty);
  // 画面の右端まで描画したら再初期化
  if (w > width) {
    initGraph();
  }

  delay(100);
  saveFrame("frames/######.tif");

  if (h == 10) {
    h = 0;
    w++;
  }
  else {
    h++;
  }
}
 
//グラフの初期化
void initGraph() {
  background(47);
  noStroke();
  //cnt = 0;
  w = 0;
  // グラフ描画の線の色を定義
  col[0] = color(255, 127, 31);
  col[1] = color(31, 255, 127);
  col[2] = color(127, 31, 255);
  col[3] = color(31, 127, 255);
  col[4] = color(127, 255, 31);
  col[5] = color(127);
}