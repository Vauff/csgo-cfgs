//#####################################################################
//Patched version intended for use with GFL ze_chaos_v7_4f stripper
//Removes HTML formatting broken after Shattered Web Update.
//Install as csgo/scripts/vscripts/ze_chaos/functions_patched.nut
//#####################################################################

//Written By Color[STEAM_1:0:44837813]
//DO NOT COPY WITHOUT MY PERMISSION

IncludeScript("ze_chaos/init.nut");

function PlayBGM(index) {
  local message = "message " + bgm[index - 1];
  EntFire("bgm", "StopSound", "");
  EntFire("bgm", "AddOutput", message, 0.01);
  EntFire("bgm", "PlaySound", "", 0.01);
}

function ShowTimeHUD(second) {
  for (local i = 0; i <= second; i++) {
    message < -null;
    local j = second - i;
    if (j == 0) {
      break;
    };
    if (j > 15) {
      message = "message " + j.tostring() + "s left!";
    } else if (j > 5 && j <= 15) {
      message = "message " + j.tostring() + "s left!";
    } else if (j > 0 && j <= 5) {
      message = "message " + j.tostring() + "s left!";
    };;;
    EntFire("global_hud", "AddOutput", message, i);
    EntFire("global_hud", "ShowMessage", "", i + 0.01);;
  };
};;

function DisplayText(time) {
  EntFire("global_text", "Display", "", time + 0.01);
  EntFire("global_text", "Display", "", time + 1.01);
  EntFire("global_text", "Display", "", time + 2.01);
}

function ShowBossTime(second) {
  for (local i = 0; i <= second; i++) {
    message < -null;
    local j = second - i;
    if (j == 0) {
      break;
    };
    message = "Boss Time: " + j.tostring() + "s";
    EntFire("bosstime_text", "SetText", message, i);
    EntFire("bosstime_text", "Display", "", i + 0.01);
  }
}

function SetHumanHealth(health) {
  if (activator.GetHealth() > 0 && activator.GetHealth() < health) {
    activator.SetHealth(health);
  }
}

function SpawnMeteor(index) {
  local meteor = null;
  if (index) {
    meteor = Entities.FindByName(null, "level3_meteor_template");
  } else {
    meteor = Entities.FindByName(null, "level2_boss_meteor_template");
  };
  if (meteor) {
    meteor.SetOrigin(activator.GetOrigin());
    EntFireByHandle(meteor, "ForceSpawn", "", 0.01, meteor, meteor);
  }
}

function SpawnBossBall() {
  local track = Entities.FindByName(null, "level2_boss_ball_track_2");
  local ball = Entities.FindByName(null, "level2_boss_ball");
  if (track != null && activator != null && ball != null) {
    local pos_1 = activator.GetOrigin();
    pos_1 = Vector(pos_1.x, pos_1.y, pos_1.z + 32);
    local pos_2 = ball.GetOrigin();
    local distance = sqrt(pow((pos_1.x - pos_2.x), 2) + pow((pos_1.y - pos_2.y), 2) + pow((pos_1.z - pos_2.z), 2));
    local speed = distance / 5;
    speed = speed.tointeger();
    track.SetOrigin(pos_1);
    EntFireByHandle(ball, "SetMaxSpeed", speed.tostring(), 0, ball, ball);
    EntFire("level2_boss_ball", "StartForward", "", 0.01);
    EntFire("level2_boss_ball_particle", "Start", "", 0.01);
  }
}

function ChooseBossSkill() {
  local num = RandomInt(1, 1000);
  switch (num % 3) {
  case 0:
    EntFire("Command", "command", "say <--Dragon uses black hole-->");
    EntFire("level2_boss_push_forward", "Enable", "");
    EntFire("level2_boss_push_forward", "Disable", "", 3);
    EntFire("level2_boss_particle_3", "Start", "");
    EntFire("level2_boss_particle_3", "Stop", "", 3);
    break;
  case 1:
    EntFire("Command", "command", "say <--Dragon uses fire-->");
    EntFire("level2_boss_fire_back", "Enable", "");
    EntFire("level2_boss_fire_back", "Disable", "", 4);
    EntFire("level2_boss_fire_back_particle", "Start", "");
    EntFire("level2_boss_fire_back_particle", "Stop", "", 4);
    break;
  case 2:
    EntFire("Command", "command", "say <--Dragon uses meteor-->");
    EntFire("level2_boss_meteor_trigger", "Enable", "");
    EntFire("level2_boss_he_box", "SetDamageFilter", "noblast");
    EntFire("level2_boss_he_box", "SetDamageFilter", "blast", 4);
    break;
  }
}

function SpawnParticle(index) {
  local name = null;
  switch (index) {
  case 1:
    name = "item_fire_particle_template";
    break;
  case 2:
    name = "item_snowstorm_particle_template";
    break;
  case 3:
    name = "item_lightning_particle_template";
    break;
  case 4:
    name = "item_water_particle_template";
    break;
  }
  local template = Entities.FindByName(null, name);
  template.SetOrigin(activator.GetOrigin());
  EntFireByHandle(template, "ForceSpawn", "", 0.01, template, template);
}

function SpawnItems(level) {
  local totalNumber = 5;
  local chooseNumber = 3;
  local index = ChooseNumbers(totalNumber, chooseNumber);
  local humanItems = ["item_beam_weapon_template", "item_fire_weapon_template", "item_snowstorm_weapon_template", "item_lightning_weapon_template", "item_water_weapon_template"];
  items.append("item_alacrity_weapon_template");
  items.append("item_health_weapon_template");
  local num = RandomInt(1, 1000);
  if (num % 2 != 0) {
    items.append("item_poison_weapon_template");
  } else {
    items.append("item_blackhole_weapon_template");
  };
  if (index != []) {
    for (local i = 0; i < chooseNumber; i++) {
      items.append(humanItems[index[i]]);
    }
  };
  for (local i = 1; i <= 6; i++) {
    local template = ChooseItems();
    ChooseItems_2(template, level, i);
  }
}

function ChooseItems() {
  local template = null;
  local templateName = "1";
  if (items != []) {
    while (templateName == "1") {
      local num = RandomInt(1, 1000);
      num = num % 6;
      templateName = items[num];
      if (templateName != "1") {
        template = Entities.FindByName(null, items[num]);
        items[num] = "1";
      };
    };
  };
  return template;
}

function ChooseItems_2(template, level, index) {
  local origin = null;
  if (template) {
    local flag = null;
    if (level == 1 && index == 1) {
      local num = RandomInt(1, 1000);
      switch (num % 3) {
      case 0:
        origin = Vector(-4608, -1840, -1988);
        break;
      case 1:
        local x = RandomInt(-4032, -3088);
        origin = Vector(x, -1704, -1668);
        break;
      case 2:
        local y = RandomInt(-1904, -1504);
        origin = Vector(-5008, y, -1668);
        break;
      }
    } else if (level == 1 && index == 2) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        local z = RandomInt(-1622, -1220);
        origin = Vector(-4752, -2624, z);
        break;
      case 1:
        origin = Vector(-4752, -2216, -1668);
        break;
      }
    } else if (level == 1 && index == 3) {
      local num = RandomInt(1, 1000);
      switch (num % 4) {
      case 0:
        origin = Vector(-5552, -2212, -1446);
        break;
      case 1:
        origin = Vector(-3952, -2212, -1446);
        break;
      case 2:
        origin = Vector(-5552, -2984, -1156);
        break;
      case 3:
        origin = Vector(-3952, -2984, -1156);
        break;
      }
    } else if (level == 1 && index == 4) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        origin = Vector(-4752, -2984, -1190);
        break;
      case 1:
        local x = [-5472, -5232, -4992, -4752, -4512, -4272, -4032];
        local j = RandomInt(0, 6);
        origin = Vector(x[j], -4288, -1430);
        break;
      }
    } else if (level == 1 && index == 5) {
      local num = RandomInt(1, 1000);
      switch (num % 6) {
      case 0:
        origin = Vector(-4448, -4896, -1372);
        break;
      case 1:
        origin = Vector(-5056, -4896, -1372);
        break;
      case 2:
        origin = Vector(-4032, -4896, -1372);
        break;
      case 3:
        origin = Vector(-5472, -4896, -1372);
        break;
      case 4:
        origin = Vector(-5264, -4896, -1372);
        break;
      case 5:
        origin = Vector(-4240, -4896, -1372);
        break;
      }
    } else if (level == 1 && index == 6) {
      local y = RandomInt(-5870, -5500);
      origin = Vector(-4752, y, -1112);
    } else if (level == 2 && index == 1) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        local x = RandomInt(3280, 3408);
        local y = RandomInt(-5392, -5184);
        origin = Vector(x, y, 512);
        break;
      case 1:
        local x = RandomInt(3264, 4368);
        local y = RandomInt(-5632, -5504);
        origin = Vector(x, y, 512);
        break;
      }
    } else if (level == 2 && index == 2) {
      local num = RandomInt(1, 1000);
      switch (num % 3) {
      case 0:
        origin = Vector(5456, -4816, 560);
        break;
      case 1:
        origin = Vector(5332, -4204, 706);
        break;
      case 2:
        local x = RandomInt(4008, 4176);
        origin = Vector(x, -5882, 386);
        break;
      }
    } else if (level == 2 && index == 3) {
      local num = RandomInt(1, 1000);
      switch (num % 5) {
      case 0:
        origin = Vector(6824, -5224, 796);
        break;
      case 1:
        origin = Vector(7386, -5016, 770);
        break;
      case 2:
        origin = Vector(7390, -5234, 770);
        break;
      case 3:
        origin = Vector(7488, -5128, 898);
        break;
      case 4:
        origin = Vector(8560, -4420, 386);
        break;
      }
    } else if (level == 2 && index == 4) {
      local num = RandomInt(1, 1000);
      switch (num % 3) {
      case 0:
        origin = Vector(8586, -6728, 752);
        break;
      case 1:
        origin = Vector(8590, -7730, 706);
        break;
      case 2:
        origin = Vector(8306, -7572, 810);
        break;
      }
    } else if (level == 2 && index == 5) {
      local num = RandomInt(1, 1000);
      switch (num % 6) {
      case 0:
        origin = Vector(4302, -7472, 410);
        break;
      case 1:
        origin = Vector(4060, -7478, 410);
        break;
      case 2:
        origin = Vector(3802, -7532, 410);
        break;
      case 3:
        origin = Vector(3620, -7604, 410);
        break;
      case 4:
        origin = Vector(3480, -7728, 410);
        break;
      case 5:
        origin = Vector(3354, -7888, 410);
        break;
      }
    } else if (level == 2 && index == 6) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        origin = Vector(3173, -8290, 595);
        break;
      case 1:
        local x = RandomInt(4224, 4728);
        origin = Vector(x, -9540, 498);
        break;
      }
    } else if (level == 3 && index == 1) {
      origin = Vector(-10672, -904, 608);
    } else if (level == 3 && index == 2) {
      origin = Vector(-10672, -1472, 608);
    } else if (level == 3 && index == 3) {
      local num = RandomInt(1, 1000);
      switch (num % 4) {
      case 0:
        origin = Vector(-9992, -5424, -640);
        break;
      case 1:
        local x = RandomInt(-9480, -8144);
        local y = RandomInt(-5592, -5240);
        origin = Vector(x, y, -640);
        break;
      case 2:
        origin = Vector(-10208, -6464, -608);
        break;
      case 3:
        local x = RandomInt(-9040, -8832);
        local y = RandomInt(-8800, -7920);
        origin = Vector(x, y, -720);
        break;
      }
    } else if (level == 3 && index == 4) {
      local num = RandomInt(1, 1000);
      switch (num % 12) {
      case 0:
        origin = Vector(-10420, -9898, -1088);
        break;
      case 1:
        origin = Vector(-10452, -10054, -1056);
        break;
      case 2:
        origin = Vector(-10492, -10194, -1024);
        break;
      case 3:
        origin = Vector(-10508, -10318, -992);
        break;
      case 4:
        origin = Vector(-10536, -10474, -960);
        break;
      case 5:
        origin = Vector(-10576, -10614, -928);
        break;
      case 6:
        origin = Vector(-10604, -10718, -880);
        break;
      case 7:
        origin = Vector(-10616, -10874, -848);
        break;
      case 8:
        origin = Vector(-10636, -11014, -832);
        break;
      case 9:
        origin = Vector(-10644, -11138, -800);
        break;
      case 10:
        origin = Vector(-10608, -11294, -768);
        break;
      case 11:
        origin = Vector(-10604, -11434, -736);
        break;
      }
    } else if (level == 3 && index == 5) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        origin = Vector(-15880, -10864, 688);
        break;
      case 1:
        origin = Vector(-15880, -10864, 944);
        break;
      }
    } else if (level == 3 && index == 6) {
      local num = RandomInt(1, 1000);
      switch (num % 2) {
      case 0:
        local x = RandomInt(-15026, -14942);
        local y = RandomInt(-10206, -9280);
        origin = Vector(x, y, 864);
        break;
      case 1:
        local x = RandomInt(-15968, -14968);
        local y = RandomInt(-9246, -9122);
        origin = Vector(x, y, 864);
        break;
      };
    };
    if (origin) {
      template.SetOrigin(origin);
    };
    EntFireByHandle(template, "ForceSpawn", "", 1, template, template);
  }
}

function FilterButton() {
  if (activator.GetTeam() == 3) {
    EntFire("level1_counter_2", "Add", "1");
  }
}

function ChooseNumbers(totalNumber, chooseNumber) {
  local index = [];
  local count = 0;
  while (count < chooseNumber) {
    local num = RandomInt(1, 1000);
    num = num % totalNumber;
    local flag = 1;
    for (local j = 0; j < index.len(); j++) {
      if (num == index[j]) {
        flag = 0;
        break;
      }
    }
    if (flag) {
      index.append(num);
      count += 1;
    }
  }
  return index;
}

function SetBossHP(index) {
  local hp = null;
  if (index) {
    hp = RandomInt(130, 150);
  } else {
    hp = RandomInt(80, 90);
  };
  EntFire("counter_2*", "Add", hp);
}

function WarmUp() {
  EntFire("level1_*", "Kill", "");
  EntFire("level2_*", "Kill", "");
  EntFire("level3_*", "Kill", "");
  EntFire("command", "Command", "say <--Warm Up Time-->", 6);
  EntFire("functions", "RunScriptCode", "ShowTimeHUD(60)", 6);
  EntFire("trigger_start", "AddOutput", "OnStartTouch !activator:AddOutput:origin -4048 10976 -7204:0:0");
  EntFire("trigger_start", "Enable", "", 0.01);
  EntFire("tolevel2_brush", "Disable", "", 66);
  EntFire("warmup_brush", "Enable", "", 66);
  EntFire("hurt_1", "Enable", "", 66);
  EntFire("hurt_1", "Disable", "", 68);
  EntFire("command", "Command", "mp_roundtime 25");
  EntFire("command", "Command", "mp_restartgame 3", 68);
  EntFire("command", "Command", "sm_cvar mp_restartgame 3", 68);
}

function LoadLevel1() {
  ShowChapter("1");
  EntFire("break_2", "Break", "");
  EntFire("level2_*", "Kill", "");
  EntFire("level3_*", "Kill", "");
  EntFire("hurt_1", "Kill", "");
  local relay = Entities.CreateByClassname("logic_relay");
  relay.__KeyValueFromString("targetname", "level1_relay_1");
  EntFireByHandle(relay, "AddOutput", "OnTrigger level1_temp_1:ForceSpawn::0:1", 0, relay, relay);
  local counter_1 = Entities.CreateByClassname("math_counter");
  counter_1.__KeyValueFromString("targetname", "level1_counter_1");
  counter_1.__KeyValueFromFloat("max", 2);
  EntFireByHandle(counter_1, "AddOutput", "OnChangedFromMin !self:SetValue:0:1:0", 0, counter_1, counter_1);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax level1_relay_1:Trigger::0:1", 0, counter_1, counter_1);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax !self:Kill::0:1", 0, counter_1, counter_1);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax level1_button_1*:Lock::0:1", 0, counter_1, counter_1);
  local counter_2 = Entities.CreateByClassname("math_counter");
  counter_2.__KeyValueFromString("targetname", "level1_counter_2");
  counter_2.__KeyValueFromFloat("max", 2);
  EntFireByHandle(counter_2, "AddOutput", "OnChangedFromMin !self:SetValue:0:1:0", 0, counter_2, counter_2);
  EntFireByHandle(counter_2, "AddOutput", "OnHitMax level1_break_6:Break::0:1", 0, counter_2, counter_2);
  EntFireByHandle(counter_2, "AddOutput", "OnHitMax level1_break_7:Break::0:1", 0, counter_2, counter_2);
  EntFireByHandle(counter_2, "AddOutput", "OnHitMax !self:Kill::0:1", 0, counter_2, counter_2);
  EntFireByHandle(counter_2, "AddOutput", "OnHitMax level1_button_2*:Lock::0:1", 0, counter_2, counter_2);
  local counter_3 = Entities.CreateByClassname("math_counter");
  counter_3.__KeyValueFromString("targetname", "level1_counter_3");
  counter_3.__KeyValueFromFloat("max", 4);
  EntFireByHandle(counter_3, "AddOutput", "OnHitMax knight_target*:AddOutput:targetname knight_target_1:0:1", 0, counter_3, counter_3);
  EntFireByHandle(counter_3, "AddOutput", "OnHitMax !self:Kill::0:1", 0, counter_3, counter_3);
  EntFire("warmup_box", "Break", "");
  EntFire("trigger_start", "AddOutput", "OnStartTouch !activator:AddOutput:origin -3040 -1704 -1980:0:0");
  EntFire("trigger_start", "Enable", "", 0.01);
  EntFire("functions", "RunScriptCode", "SpawnItems(1)", 3);
  EntFire("functions", "RunScriptCode", "PlayBGM(1)", 5);
  EntFire("level1_door_3", "AddOutput", "OnOpen level1_teleport_5_*:Enable::0:1");
  EntFire("level1_door_3", "AddOutput", "OnOpen level1_push_1:Disable::0:1");
  EntFire("level1_door_3", "AddOutput", "OnOpen level1_push_1:Enable::0.01:1");
  EntFire("level1_door_3", "AddOutput", "OnOpen command:Command:say <--Shoot zombies into the water-->:0:1");
  EntFire("level1_teleport_5_zombie", "AddOutput", "OnStartTouch !self:SetRemoteDestination:level1_destination_5_human:1:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed prop_1:SetAnimation:down:0:0");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--Hold for last 30s-->:0:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--5s left-->:25:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--4s left-->:26:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--3s left-->:27:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--2s left-->:28:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed command:Command:say <--1s left-->:29:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed level1_door_4:Open::30:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed global_text:SetText:<--Hold for last 30s-->:0:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed global_text:SetText:<--5s left-->:25:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed functions:RunScriptCode:DisplayText(25):0:1");
  EntFire("level1_button_4", "AddOutput", "OnPressed functions:RunScriptCode:ShowTimeHUD(30):0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed level1_prop_3:SetAnimation:down:0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed command:Command:say <--Hold for 15s-->:0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed global_text:SetText:<--Hold for 15s-->:0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed functions:RunScriptCode:ShowTimeHUD(15):0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed command:Command:say <--5s left-->:10:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed global_text:SetText:<--5s left-->:10:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed functions:RunScriptCode:DisplayText(10):0:1");
  EntFire("level1_button_3", "AddOutput", "OnPressed level1_break_5:Break::15:1");
  EntFire("level1_button_1", "AddOutput", "OnPressed level1_prop_1:SetAnimation:down:0:0");
  EntFire("level1_button_1", "AddOutput", "OnPressed level1_counter_1:Add:1:0:0");
  EntFire("level1_button_1", "AddOutput", "OnOut level1_prop_1:SetAnimation:idle:0:0");
  EntFire("level1_button_1_1", "AddOutput", "OnPressed level1_prop_2:SetAnimation:down:0:0");
  EntFire("level1_button_1_1", "AddOutput", "OnPressed level1_counter_1:Add:1:0:0");
  EntFire("level1_button_1_1", "AddOutput", "OnOut level1_prop_2:SetAnimation:idle:0:0");
  EntFire("level1_button_2", "AddOutput", "OnPressed level1_prop_4:SetAnimation:down:0:0");
  EntFire("level1_button_2", "AddOutput", "OnPressed functions:RunScriptCode:FilterButton():0:0");
  EntFire("level1_button_2", "AddOutput", "OnOut level1_prop_4:SetAnimation:idle:0:0");
  EntFire("level1_button_2_1", "AddOutput", "OnPressed level1_prop_5:SetAnimation:down:0:0");
  EntFire("level1_button_2_1", "AddOutput", "OnPressed functions:RunScriptCode:FilterButton():0:0");
  EntFire("level1_button_2_1", "AddOutput", "OnOut level1_prop_5:SetAnimation:idle:0:0");
  EntFire("level1_break_5", "AddOutput", "OnBreak level1_push_1:Enable::0:1");
  EntFire("level1_break_5", "AddOutput", "OnBreak level1_particle_1:Start::0:1");
  EntFire("level1_break_5", "AddOutput", "OnBreak level1_teleport_4:Enable::15:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch command:Command:say <--Hold for 40s-->:0:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(40):0:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch level1_teleport_1:Enable::0:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:35:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch level1_break_2:Break::40:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch global_text:SetText:<--Hold for 40s-->:0:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:35:1");
  EntFire("level1_trigger_4", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(35):0:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch command:Command:say <--Wait for 15s-->:0:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(15):0:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_teleport_2:Enable::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_movelinear_1:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_movelinear_2:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_movelinear_3:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_movelinear_4:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_wall_1:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_wall_2:Kill::10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch level1_door_1:Open::15:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 15s-->:0:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:10:1");
  EntFire("level1_trigger_5", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(10):0:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch command:Command:say <--Wait for 30s-->:0:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(30):0:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:25:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch level1_break_3:Break::30:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 30s-->:0:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:25:1");
  EntFire("level1_trigger_6", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(25):0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch command:Command:say <--Hold for 15s-->:0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(15):0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:10:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch level1_door_2:Open::15:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch global_text:SetText:<--Hold for 15s-->:0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:10:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(10):0:1");
  EntFire("level1_trigger_7", "AddOutput", "OnStartTouch level1_teleport_3:Enable::0:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch command:Command:say <--Wait for 45s-->:0:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(45):0:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:40:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch level1_break_4:Break::45:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 45s-->:0:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:40:1");
  EntFire("level1_trigger_8", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(40):0:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch command:Command:say <--Wait for 30s-->:0:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(30):0:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:25:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch level1_door_3:Open::30:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch level1_door_5:Open::30:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 30s-->:0:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:25:1");
  EntFire("level1_trigger_9", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(25):0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch command:Command:say <--Hold for 35s-->:0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(35):0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch level1_teleport_6:Enable::10:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:30:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch break_1:Break::35:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch global_text:SetText:<--Hold for 35s-->:0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:30:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(30):0:1");
  EntFire("level1_trigger_10", "AddOutput", "OnStartTouch fog_env:TurnOn::0:1");
  EntFire("level1_trigger_11", "AddOutput", "OnStartTouch command:Command:say <--Zombies are in the room-->:0:1");
  EntFire("level1_trigger_11", "AddOutput", "OnStartTouch command:Command:say <--Failed-->:1:1");
  EntFire("level1_trigger_11", "AddOutput", "OnStartTouch relay_1:Kill::0:1");
  EntFire("level1_trigger_13", "AddOutput", "OnStartTouch relay_1:Trigger::2:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch global_text:SetText:<--Hold for 15s-->:0:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:10:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(10):0:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch level1_break_8:Break::15:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:10:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch command:Command:say <--Hold for 15s-->:0:1");
  EntFire("level1_trigger_12", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(15):0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel1_brush:Enable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger level1_counter_3:Add:1:0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel2_brush:Disable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel3_brush:Enable::0:1");
  EntFire("level1_door_4", "AddOutput", "OnFullyOpen level1_hurt:Enable::2:1");
  EntFire("level1_door_4", "AddOutput", "OnFullyOpen level1_trigger_11:Enable::0:1");
  EntFire("level1_door_4", "AddOutput", "OnFullyOpen level1_trigger_13:Enable::0:1");
  EntFire("item_dark_weapon_template", "AddOutput", "OnEntitySpawned item_dark_filter:FireUser1::0:1");
}

function LoadLevel2() {
  ShowChapter("2");
  EntFire("break_2", "Break", "");
  EntFire("level1_*", "Kill", "");
  EntFire("level3_*", "Kill", "");
  EntFire("hurt_1", "Kill", "");
  EntFire("level2_boss_hp_bar", "HideSprite", "");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel1_brush:Enable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel2_brush:Enable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel3_brush:Disable::0:1");
  EntFire("functions", "RunScriptCode", "PlayBGM(5)", 5);
  EntFire("functions", "RunScriptCode", "SpawnItems(2)", 3);
  EntFire("fog_env", "TurnOn", "", 3);
  EntFire("trigger_start", "AddOutput", "OnStartTouch !activator:AddOutput:origin 1536 -5008 360:0:0");
  EntFire("trigger_start", "Enable", "", 0.01);
  EntFire("warmup_box", "Break", "");
  EntFire("level2_counter_1", "AddOutput", "OnStartTouch command:Command:say <--Wait for 20s-->:0:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax functions:RunScriptCode:ShowTimeHUD(20):0:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax command:Command:say <--5s left-->:15:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax level2_teleport_2:Enable::20:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax functions:RunScriptCode:StartBossAnimation():20:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax global_text:SetText:<--Wait for 20s-->:0:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax global_text:SetText:<--5s left-->:15:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax functions:RunScriptCode:DisplayText(20):0:1");
  EntFire("level2_counter_1", "AddOutput", "OnHitMax level2_dark_user_change_1:Enable::20:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch command:Command:say <--Wait for 30s-->:0:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(30):0:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:25:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_teleport_4:Enable::30:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch dragon:Kill::61.55:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_push_3:Kill::64.05:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_brush_9:AddOutput:renderamt 255:64.05:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_beam_9:TurnOn::64.05:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_hurt_10:Enable::64.05:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_teleport_5:Enable::70.05:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 30s-->:0:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:25:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(25):0:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_dark_user_change_3:Enable::25:1");
  EntFire("level2_push_4", "AddOutput", "OnStartTouch level2_dark_user_change_4:Enable::70.05:1");
  EntFire("level2_break_3", "AddOutput", "OnBreak command:Command:say <--Touch 2 beams-->:0:1");
  EntFire("level2_break_3", "AddOutput", "OnHitMax global_text:SetText:<--Touch 2 beams-->:0:1");
  EntFire("level2_break_3", "AddOutput", "OnHitMax functions:RunScriptCode:DisplayText(0):0:1");
  SetLevel2BeamTrigger_2("level2_hurt_4", "level2_brush_6", "level2_beam_6", "level2_target_11", "level2_target_12");
  EntFire("level2_hurt_4", "AddOutput", "OnStartTouch level2_push_2:Enable::0:1");
  EntFire("level2_hurt_4", "AddOutput", "OnStartTouch level2_counter_1:Add:1:0:1");
  SetLevel2BeamTrigger_2("level2_hurt_3", "level2_brush_5", "level2_beam_5", "level2_target_9", "level2_target_10");
  EntFire("level2_hurt_3", "AddOutput", "OnStartTouch level2_push_1:Enable::0:1");
  EntFire("level2_hurt_3", "AddOutput", "OnStartTouch level2_counter_1:Add:1:0:1");
  SetLevel2BeamTrigger_2("level2_hurt_7", "level2_brush_8", "level2_beam_8", "level2_target_15", "level2_target_16");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch command:Command:say <--Wait for 45s-->:0:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:40:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch level2_teleport_3:Enable::20:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch level2_wall_4:Kill::45:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(45):0:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 45s-->:0:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:40:1");
  EntFire("level2_hurt_7", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(40):0:1");
  SetLevel2BeamTrigger_2("level2_hurt_10", "level2_brush_9", "level2_beam_9", "level2_target_17", "level2_target_18");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch command:Command:say <--Hold for last 25s-->:0:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:20:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(25):0:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch level2_door_2:Open::25:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch level2_break_7:Break::25:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch global_text:SetText:<--Hold for last 25s-->:0:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:20:1");
  EntFire("level2_hurt_10", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(20):0:1");
  SetLevel2BeamTrigger("level2_hurt_1", "level2_hurt_2", "level2_brush_2", "level2_brush_3", "level2_beam_2", "level2_beam_3", "level2_target_3", "level2_target_4", "45", "level2_break_2");
  EntFire("level2_hurt_1", "AddOutput", "OnStartTouch level2_teleport_1:Enable::20:1");
  SetLevel2BeamTrigger("level2_hurt_2", "level2_hurt_12", "level2_brush_3", "level2_brush_4", "level2_beam_3", "level2_beam_4", "level2_target_5", "level2_target_6", "15", "level2_break_6");
  SetLevel2BeamTrigger("level2_hurt_12", "level2_hurt_3", "level2_brush_4", "level2_brush_5", "level2_beam_4", "level2_beam_5", "level2_target_7", "level2_target_8", "45", "level2_break_3");
  EntFire("level2_hurt_12", "AddOutput", "OnStartTouch level2_brush_6:AddOutput:renderamt 255:0:1");
  EntFire("level2_hurt_12", "AddOutput", "OnStartTouch level2_beam_6:TurnOn::0:1");
  EntFire("level2_hurt_12", "AddOutput", "OnStartTouch level2_wall_2:Kill::45:1");
  EntFire("level2_hurt_12", "AddOutput", "OnStartTouch level2_hurt_4:Enable::0:1");
  EntFire("level2_hurt_12", "AddOutput", "OnStartTouch level2_teleport_7:Enable::10:1");
  SetLevel2BeamTrigger("level2_hurt_6", "level2_hurt_7", "level2_brush_7", "level2_brush_8", "level2_beam_7", "level2_beam_8", "level2_target_13", "level2_target_14", "45", "level2_break_4");
  EntFire("level2_hurt_6", "AddOutput", "OnStartTouch level2_wall_3:Kill::45:1");
  EntFire("level2_trigger_1", "AddOutput", "OnStartTouch command:Command:say <--Zombies are in the room-->:0:1");
  EntFire("level2_trigger_1", "AddOutput", "OnStartTouch command:Command:say <--Failed-->:1:1");
  EntFire("level2_trigger_1", "AddOutput", "OnStartTouch relay_1:Kill::0:1");
  EntFire("level2_trigger_4", "AddOutput", "OnStartTouch relay_1:Trigger::2:1");
  EntFire("level2_door_2", "AddOutput", "OnFullyOpen level2_trigger_1:Enable::0:0");
  EntFire("level2_door_2", "AddOutput", "OnFullyOpen level2_trigger_4:Enable::0:0");
  EntFire("level2_door_2", "AddOutput", "OnFullyOpen level2_hurt_8:Enable::2:1");
  local knight_target = Entities.FindByName(null, "knight_target_1");
  if (knight_target) {
    EntFire("wk_template", "AddOutput", "origin 8128 -4352 520");
    EntFire("wk_template", "ForceSpawn", "", 0.01);
  };
  EntFire("item_health_human_template", "AddOutput", "origin 6322 -7220 498");
  EntFire("item_health_human_template", "ForceSpawn", "", 0.01);
}

function LoadLevel3() {
  EntFire("level3_break_2", "AddOutput", "OnBreak level3_teleport_6:SetRemoteDestination:level3_destination_6:15:1");
  EntFire("level3_break_11", "AddOutput", "OnBreak level3_teleport_4:SetRemoteDestination:level3_destination_7:0:1");
  ShowChapter("3");
  EntFire("break_2", "Break", "");
  EntFire("level1_*", "Kill", "");
  EntFire("level2_*", "Kill", "");
  EntFire("trigger_start", "AddOutput", "OnStartTouch !activator:AddOutput:origin -1776 -2336 474:0:0");
  EntFire("trigger_start", "Enable", "", 0.01);
  EntFire("warmup_box", "Break", "");
  EntFire("fog_env", "TurnOn", "", 3);
  EntFire("functions", "RunScriptCode", "SpawnItems(3)", 3);
  EntFire("level3_particle_1", "Start", "", 3);
  EntFire("smokestack", "TurnOn", "", 3);
  EntFire("functions", "RunScriptCode", "PlayBGM(10)", 5);
  EntFire("level3_meteor_timer", "AddOutput", "OnTimer level3_meteor_trigger:Enable::0.01:0");
  EntFire("level3_meteor_timer", "AddOutput", "OnTimer level3_meteor_trigger:Disable::0:0");
  EntFire("level3_meteor_timer", "Enable", "", 15);
  SetLevel3Trigger("level3_trigger_1", "level3_wall_1", "level3_break_1", 45);
  SetLevel3Trigger("level3_trigger_2", "level3_wall_2", "level3_break_2", 15);
  SetLevel3Trigger("level3_trigger_3", "level3_wall_3", "level3_break_3", 15);
  SetLevel3Trigger2("level3_trigger_4", "level3_break_4", 30);
  SetLevel3Trigger2("level3_trigger_5", "level3_break_5", 20);
  SetLevel3Trigger2("level3_trigger_6", "level3_break_6", 30);
  SetLevel3Trigger2("level3_trigger_7", "level3_break_9", 30);
  SetLevel3Trigger2("level3_trigger_8", "level3_break_7", 40);
  SetLevel3Trigger2("level3_trigger_9", "level3_break_11", 30);
  SetLevel3Trigger2("level3_trigger_10", "", 30);
  SetLevel3Trigger2("level3_trigger_13", "level3_break_12", 15);
  EntFire("level3_trigger_13", "AddOutput", "OnStartTouch level3_teleport_7:Enable::10:1");
  EntFire("level3_trigger_1", "AddOutput", "OnStartTouch level3_teleport_1:Enable::20:1");
  EntFire("level3_trigger_4", "AddOutput", "OnStartTouch level3_teleport_2:Enable::0:1");
  EntFire("level3_trigger_4", "AddOutput", "OnStartTouch smokestack:Kill::0:1");
  EntFire("level3_trigger_7", "AddOutput", "OnStartTouch level3_teleport_4:Enable::0:1");
  EntFire("level3_trigger_10", "AddOutput", "OnStartTouch level3_door_2:Open::30:1");
  EntFire("level3_trigger_10", "AddOutput", "OnStartTouch level3_dark_user_change_3:Enable::30:1");
  EntFire("level3_door_2", "AddOutput", "OnFullyOpen !self:Close::10:1");
  EntFire("level3_door_2", "AddOutput", "OnFullyClosed functions:RunScriptCode:SpawnLevel3Laser():0:1");
  EntFire("level3_door_2", "AddOutput", "OnFullyClosed level3_trigger_12:Enable::13:1");
  EntFire("level3_door_2", "AddOutput", "OnFullyClosed level3_hurt_3:Enable::15:1");
  EntFire("level3_door_2", "AddOutput", "OnFullyClosed level3_trigger_14:Enable::13:1");
  EntFire("level3_wall_4", "Toggle", "");
  EntFire("wall_1", "Toggle", "");
  EntFire("level3_break_8", "AddOutput", "OnBreak level3_wall_5:Kill::0:1");
  EntFire("level3_break_7", "AddOutput", "OnBreak level3_push_1:Enable::0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch level3_dark_user_change_1:Enable::0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch level3_movelinear:Open::10:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch level3_teleport_5:Enable::10:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch command:Command:say <--Wait for 10s-->:0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch command:Command:say <--5s left-->:5:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch functions:RunScriptCode:ShowTimeHUD(10):0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch global_text:SetText:<--Wait for 10s-->:0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch global_text:SetText:<--5s left-->:5:1");
  EntFire("level3_push_1", "AddOutput", "OnStartTouch functions:RunScriptCode:DisplayText(5):0:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen functions:RunScriptCode:Level3Counter():0:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_particle_3:Start::0:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_hp_trigger:Enable::0.5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_hp_trigger:Disable::1:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_hp_trigger:Kill::1.01:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_particle_3:Kill::5.5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha:EnableDraw::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_hurt:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_box_*:SetDamageFilter::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_box_*:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_hp_bar:ShowSprite::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen counter_2:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen counter_3:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_boss_difficulty_timer_*:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen functions:RunScriptCode:ShowBossTime(120):5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_boss_ultimate_timer:Enable::5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen level3_waha_trigger:Enable::5.5:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyClosed level3_break_10:break::2:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyClosed level3_wall_6:Kill::10:1");
  EntFire("level3_movelinear", "AddOutput", "OnFullyOpen command:Command:say <--Shoot waha's head if possible-->:5:1");
  EntFire("level3_waha", "DisableDraw", "");
  EntFire("level3_waha_box_*", "Disable", "");
  EntFire("level3_waha_hp_trigger", "AddOutput", "OnStartTouch functions:RunScriptCode:SetBossHP(1):0:0");
  EntFire("level3_waha_hp_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:health 100:0:0");
  EntFire("level3_waha_hp_trigger", "AddOutput", "OnStartTouch !activator:AddOutput:max_health 100:0:0");
  EntFire("level3_waha_box_1", "AddOutput", "OnDamaged counter_2*:Subtract:1:0:0");
  EntFire("level3_waha_box_2", "AddOutput", "OnDamaged counter_2*:Subtract:2:0:0");
  local counter_1 = Entities.CreateByClassname("math_counter");
  counter_1.__KeyValueFromString("targetname", "level3_counter_1");
  counter_1.__KeyValueFromFloat("max", 3);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax !self:Kill::0:1", 0, counter_1, counter_1);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax level3_door_1:Open::0.01:1", 0, counter_1, counter_1);
  EntFireByHandle(counter_1, "AddOutput", "OnHitMax level3_door_1:Unlock::0:1", 0, counter_1, counter_1);
  EntFire("level3_break_5", "AddOutput", "OnBreak command:Command:say <--Collect 3 glow balls-->:0:1");
  EntFire("level3_break_5", "AddOutput", "OnBreak functions:RunScriptCode:SpawnSprite():0:1");
  EntFire("level3_break_5", "AddOutput", "OnBreak level3_teleport_3:Enable::80:1");
  local knight_target = Entities.FindByName(null, "knight_target_1");
  if (knight_target) {
    EntFire("wk_template", "AddOutput", "origin -10672 -1200 590");
    EntFire("wk_template", "ForceSpawn", "", 0.01);
  };
  EntFire("level3_trigger_12", "AddOutput", "OnStartTouch command:Command:say <--Zombies are in the room-->:0:1");
  EntFire("level3_trigger_12", "AddOutput", "OnStartTouch command:Command:say <--Failed-->:1:1");
  EntFire("level3_trigger_12", "AddOutput", "OnStartTouch relay_1:Kill::0:1");
  EntFire("level3_trigger_14", "AddOutput", "OnStartTouch relay_1:Trigger::2:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel1_brush:Disable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel2_brush:Enable::0:1");
  EntFire("relay_1", "AddOutput", "OnTrigger tolevel3_brush:Enable::0:1");
  SetTimer("level3_boss_ultimate_timer", 1, 120);
  EntFire("level3_boss_ultimate_timer", "AddOutput", "OnTimer level3_hurt_4:Enable::0:1");
  EntFire("level3_boss_ultimate_timer", "AddOutput", "OnTimer counter_2*:Disable::0:1");
  EntFire("level3_boss_ultimate_timer", "AddOutput", "OnTimer counter_3:Disable::0:1");
  EntFire("level3_boss_ultimate_timer", "AddOutput", "OnTimer !self:Kill::0:1");
  SetTimer("level3_boss_difficulty_timer_1", 1, 24);
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_waha_train:SetMaxSpeed:325:0:1");
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_boss_difficulty_counter*:SetValue:2:0:1");
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer !self:Kill::0:1");
  SetTimer("level3_boss_difficulty_timer_2", 1, 48);
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_waha_train:SetMaxSpeed:350:0:1");
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_boss_difficulty_counter*:SetValue:3:0:1");
  EntFire("level3_boss_difficulty_timer_2", "AddOutput", "OnTimer !self:Kill::0:1");
  SetTimer("level3_boss_difficulty_timer_3", 1, 96);
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_waha_train:SetMaxSpeed:400:0:1");
  EntFire("level3_boss_difficulty_timer_1", "AddOutput", "OnTimer level3_boss_difficulty_counter*:SetValue:4:0:1");
  EntFire("level3_boss_difficulty_timer_3", "AddOutput", "OnTimer !self:Kill::0:1");
  EntFire("item_health_human_template", "AddOutput", "origin -10144 -1184 486");
  EntFire("item_health_human_template", "ForceSpawn", "", 0.01);
}

function SpawnSprite() {
  local x = RandomInt(-12992, -9472);
  local y = RandomInt(2432, 3648);
  local v1 = "origin " + x.tostring() + " " + y.tostring() + " 400";
  x = RandomInt(-15872, -13888);
  y = RandomInt(5952, 7104);
  local v2 = "origin " + x.tostring() + " " + y.tostring() + " 400";
  x = RandomInt(-10240, -9536);
  y = RandomInt(4608, 5952);
  local v3 = "origin " + x.tostring() + " " + y.tostring() + " 320";
  local v = [v1, v2, v3];
  for (local i = 0; i < 3; i++) {
    EntFire("level3_template_1", "AddOutput", v[i], i);
    EntFire("level3_template_1", "ForceSpawn", "", i + 0.1);
  }
}

function Level3Counter() {
  SetBossCounter(1, null, null, null, 1);
  EntFire("counter_3", "AddOutput", "OnGetValue level3_waha_hp_toggle:SetTextureIndex::0:0");
  EntFire("counter_3", "AddOutput", "OnHitMax !self:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_waha:KillHierarchy::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_waha_train:FireUser1::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_waha_trigger:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_waha_hp_toggle:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_movelinear:Close::2:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_dark_user_change_2:Enable::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_boss_ultimate_timer:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_hurt_4:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax bosstime_text:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_boss_difficulty_counter*:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_boss_difficulty_case_*:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level3_boss_difficulty_relay:Kill::0:1");
}

function StartBossAnimation() {
  EntFire("Command", "command", "say <--What...it's a dragon-->", 1);
  EntFire("Command", "command", "say <--It comes...-->", 2);
  SpawnDragonMdl(0, 0, 180, Vector(15820, -8707, 1471));
  EntFire("dragon", "SetParent", "level2_boss_train");
  EntFire("level2_boss_train", "StartForward", "");
  StartDragonAnimation(0, 0, 0, 0, 55, 0, Vector(12233, -8716, 684), Vector(14167, -9168, 1608), 12);
  SetBossCounter(1, null, null, null, 0);
  EntFire("counter_3", "AddOutput", "OnHitMax !self:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_train:StartForward::0.01:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_hp_bar:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_hp_toggle:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_particle_1:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_particle_2:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_particle_3:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_hurt_9:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_break_5:Break::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_wall_5:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_push_forward:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_fire_back:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_fire_back_particle:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_meteor_trigger:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_box:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_he_box:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_teleport_6:Enable::10:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_ball_trigger:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_ball_hurt:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_ball_particle:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_skill_timer:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_ultimate_timer:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_boss_ultimate_hurt:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_hurt_6:Enable::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_beam_7:TurnOn::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_brush_7:AddOutput:renderamt 255:0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax bosstime_text:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_dark_user_change_2:Enable::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_wk_ultimate_to_boss:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_add_hp:Enable::0:1");
  EntFire("counter_3", "AddOutput", "OnHitMax level2_to_boss_item_*:Kill::0:1");
  EntFire("counter_3", "AddOutput", "OnGetValue level2_boss_hp_toggle:SetTextureIndex::0:0");
  EntFire("track_10", "AddOutput", "OnPass !activator:KillHierarchy::0:1");
  EntFire("level2_trigger_2", "AddOutput", "OnStartTouch functions:RunScriptCode:SetBossHP(0):0:0");
  EntFire("level2_trigger_2", "AddOutput", "OnStartTouch !activator:AddOutput:health 200:0:0");
  EntFire("level2_trigger_2", "AddOutput", "OnStartTouch !activator:AddOutput:max_health 200:0:0");
  EntFire("level2_trigger_2", "Enable", "", 1);
  EntFire("level2_trigger_2", "Disable", "", 1.5);
  EntFire("level2_trigger_2", "Kill", "", 1.51);
  EntFire("level2_boss_box", "AddOutput", "OnDamaged counter_2*:Subtract:1:0:0");
  EntFire("level2_boss_he_box", "AddOutput", "OnDamaged counter_2*:Subtract:50:0:0");
  EntFire("track_8", "AddOutput", "OnPass dragon:SetAnimationNoReset:fireattack2:6:1");
  EntFire("track_8", "AddOutput", "OnPass dragon:SetAnimationNoReset:idle:9:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_particle_1:Start::8:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_particle_2:Start::7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_hurt_9:Enable::8:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_hp_bar:ShowSprite::7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_skill_timer:Enable::8:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_skill_sound:PlaySound::7:1");
  EntFire("track_8", "AddOutput", "OnPass counter_2:Enable::7:1");
  EntFire("track_8", "AddOutput", "OnPass counter_3:Enable::7:1");
  EntFire("track_8", "AddOutput", "OnPass functions:RunScriptCode:ShowBossTime(180):7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_ultimate_timer:Enable::7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_boss_ball_trigger:Enable::9:1");
  EntFire("track_8", "AddOutput", "OnPass level2_shake_1:StartShake::7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_wk_ultimate_to_boss:Enable::7:1");
  EntFire("track_8", "AddOutput", "OnPass level2_to_boss_item_*:Enable::7:1");
  EntFire("track_8", "AddOutput", "OnPass Command:command:say <--Grenade can damage dragon-->:2:1");
  EntFire("track_8", "AddOutput", "OnPass Command:command:say <--Balls can damage dragon except beam ball-->:3:1");
  EntFire("level2_boss_ball_track_2", "AddOutput", "OnPass level2_boss_ball_particle:Stop::0:0");
  EntFire("level2_boss_ball_track_2", "AddOutput", "OnPass !activator:TeleportToPathNode:level2_boss_ball_track_1:1:0");
  EntFire("level2_boss_ball_track_2", "AddOutput", "OnPass level2_boss_ball_trigger:Enable::2:0");
  SetTimer("level2_boss_skill_timer", 1, 8);
  EntFire("level2_boss_skill_timer", "AddOutput", "OnTimer dragon:SetAnimationNoReset:fireattack2:0:0");
  EntFire("level2_boss_skill_timer", "AddOutput", "OnTimer dragon:SetAnimationNoReset:idle:3:0");
  EntFire("level2_boss_skill_timer", "AddOutput", "OnTimer level2_boss_skill_sound:PlaySound::1:0");
  EntFire("level2_boss_skill_timer", "AddOutput", "OnTimer functions:RunScriptCode:ChooseBossSkill():2:0");
  SetTimer("level2_boss_ultimate_timer", 1, 180);
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer level2_boss_ultimate_hurt:Enable::0:1");
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer counter_2*:Disable::0:1");
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer counter_3:Disable::0:1");
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer level2_boss_skill_timer:Disable::0:1");
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer !self:Kill::0:1");
  EntFire("level2_boss_ultimate_timer", "AddOutput", "OnTimer level2_boss_ball_trigger:Kill::0:1");
}

function SpawnDragonMdl(x, y, z, v) {
  local mdl = Entities.CreateByClassname("prop_dynamic");
  mdl.SetModel("models/ffvii_temple/ruby_dragon.mdl");
  mdl.__KeyValueFromString("targetname", "dragon");
  mdl.__KeyValueFromString("DefaultAnim", "idle");
  mdl.SetAngles(x, y, z);
  mdl.SetOrigin(v);
  EntFireByHandle(mdl, "SetAnimation", "idle", 0, mdl, mdl);
}

function StartDragonAnimation(x, y, z, x1, y1, z1, v1, v2, time) {
  local viewcontrol = Entities.CreateByClassname("point_viewcontrol_multiplayer");
  local viewtarget = Entities.CreateByClassname("info_target");
  viewcontrol.__KeyValueFromString("targetname", "viewcontrol");
  viewtarget.__KeyValueFromString("targetname", "viewtarget");
  viewtarget.SetAngles(x, y, z);
  viewtarget.SetOrigin(v1);
  viewcontrol.SetAngles(x1, y1, z1);
  viewcontrol.SetOrigin(v2);
  viewcontrol.__KeyValueFromString("target_entity", "viewtarget");
  viewcontrol.__KeyValueFromFloat("interp_time", time);
  EntFireByHandle(viewcontrol, "Enable", "", 0, viewcontrol, viewcontrol);
  EntFireByHandle(viewcontrol, "StartMovement", "", 0.01, viewcontrol, viewcontrol);
  EntFireByHandle(viewcontrol, "Disable", "", time - 0.01, viewcontrol, viewcontrol);
  EntFireByHandle(viewcontrol, "Kill", "", time, viewcontrol, viewcontrol);
  EntFireByHandle(viewtarget, "Kill", "", time, viewtarget, viewtarget);
}

function StartLaser(x, y, z) {
  local v = Vector(x, y, 320);
  local dragon = Entities.FindByName(null, "dragon");
  local template = Entities.FindByName(null, "level2_temp_1");
  if (dragon) {
    dragon.SetOrigin(v);
    EntFireByHandle(dragon, "SetAnimationNoReset", "fireattack", 0.8, dragon, dragon);
    EntFireByHandle(dragon, "SetAnimationNoReset", "idle", 1.3, dragon, dragon);
  };
  if (RandomInt(0, 1) == 0) {
    v = Vector(x, y, z + 35);
  } else {
    v = Vector(x, y, z);
  };
  if (template) {
    template.SetOrigin(v);
    EntFireByHandle(template, "ForceSpawn", "", 1, template, template);
  }
}

function SetBossCounter(flag, counter, name, max, index) {
  if (flag) {
    SetBossCounter(0, bossCounter[0], "counter_2", 1000000, index);
    SetBossCounter(0, bossCounter[1], "counter_2_1", 1000000, index);
    SetBossCounter(0, bossCounter[2], "counter_2_2", 1000000, index);
    SetBossCounter(0, bossCounter[3], "counter_2_3", 1000000, index);
    SetBossCounter(0, bossCounter[4], "counter_2_4", 1000000, index);
    SetBossCounter(0, bossCounter[5], "counter_3", 5, index);
    EntFire("counter_2", "AddOutput", "OnHitMin counter_2_1:Enable::0:1");
    EntFire("counter_2_1", "AddOutput", "OnHitMin counter_2_2:Enable::0:1");
    EntFire("counter_2_2", "AddOutput", "OnHitMin counter_2_3:Enable::0:1");
    EntFire("counter_2_3", "AddOutput", "OnHitMin counter_2_4:Enable::0:1");
    EntFire("counter_2*", "Disable", "", 2);
    EntFire("counter_3", "Disable", "", 2);
    return;
  };
  if (name != "counter_2_4") {
    EntFireByHandle(counter, "AddOutput", "OnHitMin counter_3:GetValue::0.01:1", 0, counter, counter);
  };
  counter.__KeyValueFromString("targetname", name);
  counter.__KeyValueFromInt("max", max);
  EntFireByHandle(counter, "AddOutput", "OnHitMin !self:Kill::0:1", 0, counter, counter);
  EntFireByHandle(counter, "AddOutput", "OnHitMin counter_3:Add:1:0:1", 0, counter, counter);
  if (index) {
    EntFireByHandle(counter, "AddOutput", "OnHitMin level3_waha_box_*:SetHealth:10000000:0:1", 0, counter, counter);
  } else {
    EntFireByHandle(counter, "AddOutput", "OnHitMin level2_boss_box:SetHealth:10000000:0:1", 0, counter, counter);
    EntFireByHandle(counter, "AddOutput", "OnHitMin level2_boss_he_box:SetHealth:10000000:0:1", 0, counter, counter);
  }
}

function SetLevel2BeamTrigger(name, hurt, brush_cur, brush_next, beam_cur, beam_next, target_1, target_2, time, breakable) {
  local output_1 = "OnStartTouch " + name + ":Kill::0:1";
  local output_2 = "OnStartTouch " + hurt + ":Enable::0:1";
  local output_3 = "OnStartTouch " + brush_cur + ":Kill::0:1";
  local output_4 = "OnStartTouch " + brush_next + ":AddOutput:renderamt 255:0:1";
  local output_5 = "OnStartTouch " + beam_cur + ":Kill::0:1";
  local output_6 = "OnStartTouch " + beam_next + ":TurnOn::0:1";
  local output_7 = "OnStartTouch " + target_1 + ":Kill::0:1";
  local output_8 = "OnStartTouch " + target_2 + ":Kill::0:1";
  local output_9 = "OnStartTouch " + "functions:RunScriptCode:ShowTimeHUD(" + time + "):0:1";
  local output_10 = "OnStartTouch " + breakable + ":Break::" + time + ":1";
  local output_11 = "OnStartTouch " + "command:Command:say <--Wood door will break in " + time + "s-->:0:1";
  local output_12 = "OnStartTouch " + "command:Command:say <--Wood door will break in 5s-->:" + (time.tointeger() - 5).tostring() + ":1";
  local output_13 = "OnStartTouch " + "global_text:SetText:<--Wood door will break in " + time + "s-->:0:1";
  local output_14 = "OnStartTouch " + "functions:RunScriptCode:DisplayText(0):0:1";
  local output_15 = "OnStartTouch " + "global_text:SetText:<--Wood door will break in 5s-->:" + (time.tointeger() - 5).tostring() + ":1";
  local output_16 = "OnStartTouch " + "functions:RunScriptCode:DisplayText(" + (time.tointeger() - 5).tostring() + "):0:1";
  local outputs = [output_1, output_2, output_3, output_4, output_5, output_6, output_7, output_8, output_9, output_10, output_11, output_12, output_13, output_14, output_15, output_16];
  for (local i = 0; i < 16; i++) {
    EntFire(name, "AddOutput", outputs[i]);
  }
}

function SetLevel2BeamTrigger_2(name, brush, beam, target_1, target_2) {
  local output_1 = "OnStartTouch " + brush + ":Kill::0:1";
  local output_2 = "OnStartTouch " + beam + ":Kill::0:1";
  local output_3 = "OnStartTouch " + target_1 + ":Kill::0:1";
  local output_4 = "OnStartTouch " + target_2 + ":Kill::0:1";
  local outputs = [output_1, output_2, output_3, output_4];
  for (local i = 0; i < 4; i++) {
    EntFire(name, "AddOutput", outputs[i]);
  }
}

function SetLevel3Trigger(trigger, wall, breakable, time) {
  local output_1 = "OnStartTouch command:Command:say <--Wait for " + time.tostring() + "s-->:0:1";
  local output_2 = "OnStartTouch functions:RunScriptCode:ShowTimeHUD(" + time.tostring() + "):0:1";
  local output_3 = "OnStartTouch command:Command:say <--5s left-->:" + (time - 5).tostring() + ":1";
  local output_4 = "OnStartTouch " + wall + ":Kill::" + time.tostring() + ":1";
  local output_5 = "OnStartTouch " + breakable + ":Break::" + time.tostring() + ":1";
  local output_6 = "OnStartTouch global_text:SetText:<--Wait for " + time.tostring() + "s-->:0:1";
  local output_7 = "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1";
  local output_8 = "OnStartTouch global_text:SetText:<--5s left-->:" + (time - 5).tostring() + ":1";
  local output_9 = "OnStartTouch functions:RunScriptCode:DisplayText(" + (time - 5).tostring() + "):0:1";
  local outputs = [output_1, output_2, output_3, output_4, output_5, output_6, output_7, output_8, output_9];
  for (local i = 0; i < 9; i++) {
    EntFire(trigger, "AddOutput", outputs[i]);
  }
}

function SetLevel3Trigger2(trigger, breakable, time) {
  local output_1 = "OnStartTouch command:Command:say <--Wait for " + time.tostring() + "s-->:0:1";
  local output_2 = "OnStartTouch functions:RunScriptCode:ShowTimeHUD(" + time.tostring() + "):0:1";
  local output_3 = "OnStartTouch command:Command:say <--5s left-->:" + (time - 5).tostring() + ":1";
  local output_4 = "OnStartTouch global_text:SetText:<--Wait for " + time.tostring() + "s-->:0:1";
  local output_5 = "OnStartTouch functions:RunScriptCode:DisplayText(0):0:1";
  local output_6 = "OnStartTouch global_text:SetText:<--5s left-->:" + (time - 5).tostring() + ":1";
  local output_7 = "OnStartTouch functions:RunScriptCode:DisplayText(" + (time - 5).tostring() + "):0:1";
  if (breakable != "") {
    local output_8 = "OnStartTouch " + breakable + ":Break::" + time.tostring() + ":1";
    local outputs = [output_1, output_2, output_3, output_4, output_5, output_6, output_7, output_8];
    for (local i = 0; i < 8; i++) {
      EntFire(trigger, "AddOutput", outputs[i]);
    }
  } else {
    local outputs = [output_1, output_2, output_3, output_4, output_5, output_6, output_7];
    for (local i = 0; i < 7; i++) {
      EntFire(trigger, "AddOutput", outputs[i]);
    }
  }
}

function waha(index, maxSpeed) {
  local track_1 = Entities.FindByName(null, "10");
  local track_2 = Entities.FindByName(null, "11");
  local waha = Entities.FindByName(null, "level3_waha");
  if (track_1 != null && activator != null && track_2 != null && waha != null) {
    local pos = activator.GetOrigin();
    pos = Vector(pos.x, pos.y, 3464);
    local pos_1 = null;
    if (index == 0) {
      track_2.SetOrigin(pos);
      pos_1 = track_1.GetOrigin();
      EntFire("level3_waha_train", "StartForward", "", 0.01);
    } else if (index == 1) {
      track_1.SetOrigin(pos);
      pos_1 = track_2.GetOrigin();
      EntFire("level3_waha_train", "StartBackward", "", 0.01);
    };;
    if (pos_1.x != pos.x || pos_1.y != pos.y) {
      EntFireByHandle(waha, "SetAnimationNoReset", "walk", 0.01, waha, waha);
      local anglesY = asin((pos_1.y - pos.y) / sqrt(pow((pos_1.x - pos.x), 2) + pow((pos_1.y - pos.y), 2)));
      anglesY = anglesY * 180 / PI;
      if (pos_1.x - pos.x < 0) {
        anglesY = -anglesY;
      } else if (pos_1.x - pos.x >= 0) {
        anglesY = anglesY - 180;
      };;
      waha.SetAngles(0, anglesY, 0);
    };
    local distance = sqrt(pow((pos.x - pos_1.x), 2) + pow((pos.y - pos_1.y), 2));
    local time = ceil(distance / maxSpeed);
    time = time.tofloat();
    local number = RandomInt(1, 1000);
    if (number % 5 != 3) {
      EntFireByHandle(waha, "SetAnimationNoReset", "attack", time, waha, waha);
      EntFire("level3_waha_sound", "PlaySound", "", time + 0.2);
      EntFire("level3_waha_hurt_1", "Enable", "", time + 0.2);
      EntFire("level3_waha_hurt_1", "Disable", "", time + 0.4);
      EntFire("level3_waha_particle_1", "Start", "", time + 0.2);
      EntFire("level3_waha_particle_1", "Stop", "", time + 0.4);
      EntFire("level3_shake_1", "StartShake", "", time + 0.2);
    } else {
      EntFireByHandle(waha, "SetAnimationNoReset", "attack2", time, waha, waha);
      EntFire("level3_waha_sound_2", "PlaySound", "", time + 0.2);
      EntFire("level3_waha_hurt_2", "Enable", "", time + 0.2);
      EntFire("level3_waha_hurt_2", "Disable", "", time + 0.4);
      EntFire("level3_waha_hurt_3", "Enable", "", time + 0.2);
      EntFire("level3_waha_hurt_3", "Disable", "", time + 0.4);
      EntFire("level3_waha_particle_2", "Start", "", time + 0.2);
      EntFire("level3_waha_particle_2", "Stop", "", time + 0.4);
    };
    time = time + 1.2;
    EntFire("level3_waha_trigger", "Enable", "", time);
  }
}

function ShowChapter(index) {
  EntFire("screenoverlay", "StartOverlays", "", 3.9);
  EntFire("screenoverlay", "SwitchOverlay", index, 4);
  EntFire("screenoverlay", "StopOverlays", "", 7);
}

function SpawnLevel3Laser() {
  for (local i = 0; i < 8; i++) {
    local output = SetLevel3Laser(i % 2);
    EntFire(output[0], "AddOutput", output[1], i);
    EntFire(output[0], "ForceSpawn", "", i + 0.01);
  }
}

function SetLevel3Laser(index) {
  local output_1 = null;
  local output_2 = null;
  if (index == 0) {
    local number = RandomInt(1, 1000);
    output_1 = "level3_temp_1";
    switch (number % 2) {
    case 0:
      output_2 = "origin -7156 3944 1528";
      break;
    case 1:
      output_2 = "origin -7156 3944 1568";
      break;
    }
  } else if (index == 1) {
    local number = RandomInt(1, 1000);
    output_1 = "level3_temp_2";
    switch (number % 2) {
    case 0:
      output_2 = "origin -7156 5032 1528";
      break;
    case 1:
      output_2 = "origin -7156 5032 1568";
      break;
    }
  };;
  local output = [output_1, output_2];
  return output;
}

function SetTimer(targetname, StartDisabled, RefireTime) {
  local timer = Entities.CreateByClassname("logic_timer");
  timer.__KeyValueFromString("targetname", targetname);
  timer.__KeyValueFromInt("StartDisabled", StartDisabled);
  timer.__KeyValueFromFloat("RefireTime", RefireTime);
}

function ShowItemText(index) {
  local global_text = Entities.CreateByClassname("game_text");
  global_text.__KeyValueFromString("color", "255 255 0");
  global_text.__KeyValueFromFloat("y", 0.4);
  global_text.__KeyValueFromFloat("x", 0.2);
  global_text.__KeyValueFromFloat("fadein", 0.1);
  global_text.__KeyValueFromFloat("fadeout", 0.1);
  global_text.__KeyValueFromFloat("holdtime", 10);
  global_text.__KeyValueFromFloat("fxtime", 0);
  global_text.__KeyValueFromInt("spawnflags", 0);
  global_text.__KeyValueFromInt("channel", 3);
  if (global_text) {
    global_text.__KeyValueFromString("message", itemText[index - 1]);
    EntFireByHandle(global_text, "Display", "", 0.01, activator, global_text);
    EntFireByHandle(global_text, "Kill", "", 11, global_text, global_text);
  }
}

function FreezePlayer() {
  for (local i = 0; i < 11; i++) {
    EntFire("speed", "modifyspeed", "0", i * 0.1, activator);
  }
  EntFire("speed", "modifyspeed", "1", 6, activator);
}