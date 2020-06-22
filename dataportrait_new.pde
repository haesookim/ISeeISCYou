PImage college;
PImage grad;
PImage activities;

PImage extro;
PImage middle;
PImage intro;

PImage alone;
PImage team;

PImage role;
PImage leader;
PImage follower;

PImage hardship;
PImage tick;
PImage halftick;

int width = 800;
int height =800;

// 자전, 사회대, 자연대, 인문대, 공대, 미대, 음대, 사범대, 경영대, 농생대, 생활과학대
color[] collegeColors = {#86badf, #a9e574, #e4d372, #e48683, 
  #ab8bca, #84e5ae, #fcb54e, #716cc9, #a07e71, 
  #6c8268, #e1d32a};

// 재학, 졸업
color[] gradColors = {#71472d, #bf9277};

// 개발, 기획, 아트, PM
color[] roleColors = {#00762d, #ff5415, #082dda, #721a78};

PImage[] teamplayer = {alone, team};

PImage[] leadership = {leader, follower};

//import processing.pdf.*;
//PGraphicsPDF pdf;

//import processing.svg.*;
Table table;

void setup() {
  size(800,800);
  background(0);
  
  college = loadImage("college.PNG");
  grad = loadImage("grad.PNG");
  activities = loadImage("activities.PNG");

  extro = loadImage("extrovert.PNG");
  middle = loadImage("notreally.PNG");
  intro = loadImage("introvert.PNG");

  alone = loadImage("alone.PNG");
  team = loadImage("team.PNG");

  leader = loadImage("leader.PNG");
  follower = loadImage("follower.PNG");
  role = loadImage("role.PNG");

  hardship= loadImage("startorend.PNG");
  tick = loadImage("tick.PNG");
  halftick = loadImage("halftick.PNG");

  teamplayer = new PImage[] {alone, team};
  leadership = new PImage[] {leader, follower};

  table = loadTable("data.csv", "header");
}

void draw() {
  int i = 0;

  for (TableRow row : table.rows()) {
    String name = row.getString("name");
    int collegeNo = row.getInt("College");
    int gradNo = row.getInt("grad");
    int teamNo = row.getInt("Team");
    int leadershipNo = row.getInt("leader");
    int activityCount = row.getInt("Activities");
    float classOf = row.getFloat("classOf");

    int extro = row.getInt("extro");
    boolean notreally = false;
    boolean extrovert = false;
    if (extro == 1) {
      notreally = true;
    } else if (extro ==2) {
      notreally = true;
      extrovert = true;
    }

    boolean endhard;
    String end = row.getString("Startorend");
    if (end.equals("TRUE")) {
      endhard = true;
    } else {
      endhard = false;
    }
    
    int timezone = row.getInt("Timezone");
    int roleNo = row.getInt("role");

    background(0);
    drawPortrait(collegeNo, gradNo, teamNo, leadershipNo, activityCount, classOf, extrovert, notreally, endhard, timezone, roleNo);
    save(i+"_"+name+".png");
    i++;
  }
  
  //drawPortrait(0, 0, 1, 0, 3, 17, false, true, false, 3, 0);
  //save("me.png");
  println("save");
  exit();
}

void drawPortrait(int collegeNo, int gradNo, int teamNo, int leadershipNo, int activityCount, 
  float classOf, boolean extrovert, boolean notreally, boolean endhard, int timezone, int roleNo) {
  imageMode(CENTER);

  pushMatrix();
  if (endhard) {
    scale(-1, 1);
    translate(-width, 0);
  }

  tint(collegeColors[collegeNo]);
  showImg(college);
  tint(gradColors[gradNo]);
  showImg(grad);
  popMatrix();
  //image(grad, 0, 0, width, height);

  pushMatrix();
  if (endhard) {
    scale(-1, 1);
    translate(-width, 0);
  }
  noTint();
  showImg(hardship);
  popMatrix();


  image(tick, width/2, height/2, width, height);
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 1; i<classOf; i++) {
    rotate(0.1);
    image(tick, 0, 0, width, height);
    if (classOf-i == 0.5) {
      rotate(0.1);
      image(halftick, 0, 0, width, height);
    }
  }

  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  rotate(0.25*timezone);
  tint(roleColors[roleNo]); //Give tint according to role
  image(role, 0, 0, width, height);
  noTint();
  image(leadership[leadershipNo], 0, 0, width, height);
  popMatrix();

  noTint();
  showImg(intro);
  if (notreally) {
    showImg(middle);
  }
  if (extrovert) {
    showImg(middle);
    showImg(extro);
  }


  showImg(teamplayer[teamNo]);
  pushMatrix();
  for (int i = 0; i<activityCount; i++) {
      showImg(activities);
    translate(50, -15);
  }  
  popMatrix();
}

void showImg(PImage img) {
  image(img, width/2, height/2, width, height);
}
