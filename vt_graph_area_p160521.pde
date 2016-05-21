int w = 0;
int h = 0;
 
// グラフの線の色を格納
color[] col = new color[6];

// number of frames per 1 second
int numFrames = 30;

// y zahyo on one step before
float tyOld = 0;

int thickness = 6;

// デバッグ時に描画を速くする
// 通常時は 1
//float speedCoef = 1.0;
float speedCoef = 5.0;

float heightCoef = 15;

String lines[];
String line;
String strV;
float v;
String time;
float d;

void setup() {
  //画面設定
  size(852, 480);
  frameRate(60);
  
  //lines = loadStrings("160521-SpeedData-160429-1410.txt");
  //lines = loadStrings("160521-SpeedData-160429-0901-0903.txt");
  lines = loadStrings("160521-SpeedData-160429-0901-0903-時刻付き.txt");
  
  //グラフ初期化
  initGraph();
}
 
void draw() {
  line = lines[w];
  strV = split(line, ',')[1];
  v = float(strV);
  
  // 棒グラフを描画する
  float tx = map(w*thickness, 0, width, 0, width);
  float ty = map(v*(h + 1)*heightCoef/numFrames, 0, 1023, height, 0);
  //float tyOld = map(float(lines[w])*h*heightCoef/numFrames, 0, 1023, height, 0);
  strokeWeight(thickness);
  strokeCap(SQUARE);
  stroke(col[0]);
  line(tx, 854, tx, ty);
  
  // 移動距離を求める
  d += v/30;
  
  // 前の移動距離を塗りつぶして消す
  strokeWeight(0);
  stroke(47);
  fill(47);
  rect(750, 101, -300, -101);  // x, y, dx, dy

  // 移動距離を描画する
  textSize(50); 
  textAlign(RIGHT);
  fill(255);
  time = split(line, ',')[0];
  text(str(round(d)) + " m", 750, 100); // 表示するテキスト, x座標, y座標
  
  // 前の時刻を塗りつぶして消す
  strokeWeight(0);
  stroke(47);
  fill(47);
  rect(50, 101, 300, -101);  // x, y, dx, dy

  // 時刻を描画する
  textSize(50); 
  textAlign(LEFT);
  fill(255);
  time = split(line, ',')[0];
  text(time, 50, 100); // 表示するテキスト, x座標, y座標
  
  // 画面の右端まで描画したら再初期化
  if (w > width) {
    initGraph();
  }

  delay(int(1000 / (numFrames * speedCoef)));
  saveFrame("frames/######.tif");

  if (h == numFrames - 1) {
    h = 0;
    w++;
  }
  else {
    h++;
  }
}
 
//グラフの初期化
void initGraph() {
  background(0, 127, 0);
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