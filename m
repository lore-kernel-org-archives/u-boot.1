Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0555AE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765BE87451;
	Mon,  2 Oct 2023 03:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqaSDiOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EADB87239; Mon,  2 Oct 2023 03:18:07 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FAD18724B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso527756939f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209384; x=1696814184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe3GQjoyQdT3lX4h6Ltw6z+qTY9lauHEC+qNK+0EqxI=;
 b=iqaSDiOqzQs8rMAkZM/uLXpk8WnZEKC/dYAW2kkYMXUrWpv/n6nZCDofayiNCOJY2f
 N+2ueJUxHfDHy0jD6xqtMgAoY9NDBPfj0bfh0jgBxOYN3bZawwUK5zNENpxVKaXb8+fn
 mrOoHj+JaSbUvkIjIk3lmCml6CgEEOkI5SICA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209384; x=1696814184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe3GQjoyQdT3lX4h6Ltw6z+qTY9lauHEC+qNK+0EqxI=;
 b=tuMMs1upDC55kcFP8tgMowh7jems+/982bUHEUYzczjDKkFuCrpjZw7vCtx1dG4J0s
 lgkssVWmOmvc4Uino7iAt5xrYG9X1jrgLPAJStCNWtmQwbsxebmSVv7u6kuzheMoRC4B
 /8jf01cVu4uqEBxeTgEJ+isofh3sy48Dw1YM4a3Yy+II9gStGUzGcBnjBTME552dxL9E
 26SqhVMF9DrqPmUHJQHBeeFBhCsm1R5pIiXPdlHZqEIDEQ7L4zkbvDQwuPrr66BOBaun
 LIaJy3xBACK59RtB6s2fdgJyG9WqnMtydhVLEejx3ic60CBhKLjatBA9CQ5lMhRkm3Ls
 E9sA==
X-Gm-Message-State: AOJu0Yyae3DItY8lFEbX8F8s3nFN9bjl34BPLhv5YNMN2tTi1QH7rvuY
 Nu2ve5MJpZot7GrDPSXgPNr9z/KGD2uHXxmU70I=
X-Google-Smtp-Source: AGHT+IGC1w09NMutwnuYk/D4lQISIlf1rqvtDDIOMCK2onsuMnDJHvHm2/m9xjBwXaQGsPgTb71fNA==
X-Received: by 2002:a6b:e005:0:b0:785:d4f5:2225 with SMTP id
 z5-20020a6be005000000b00785d4f52225mr12511373iog.19.1696209384339; 
 Sun, 01 Oct 2023 18:16:24 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 20/34] expo: Use standard numbering for save and discard
Date: Sun,  1 Oct 2023 19:15:30 -0600
Message-ID: <20231002011553.463514-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Set aside some expo IDs for 'save' and 'discard' buttons. This avoids
needing to store the IDs for these. Adjust the documentation and expo
tool for the new EXPOID_BASE_ID value.

Ignore these objects when saving and loading the cedit, since they do
not contain real data.

Adjust 'cedit run' to return failure when the user exits the expo
without saving. Update the test for this change as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c               | 24 +++++++++++++++++++++---
 boot/expo.c                |  2 +-
 doc/develop/cedit.rst      |  7 ++++++-
 doc/develop/expo.rst       | 12 ++++++++----
 include/expo.h             | 20 ++++++++++++++++++++
 include/test/cedit-test.h  | 30 +++++++++++++++---------------
 test/boot/cedit.c          | 14 ++++++++------
 test/boot/expo.c           |  8 ++++----
 test/boot/files/expo_ids.h |  3 +--
 tools/expo.py              | 33 ++++++++++++++++++++++++++++-----
 10 files changed, 112 insertions(+), 41 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index b5f89e945bce..a53a4f289906 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -155,7 +155,7 @@ int cedit_run(struct expo *exp)
 	struct video_priv *vid_priv;
 	uint scene_id;
 	struct scene *scn;
-	bool done;
+	bool done, save;
 	int ret;
 
 	cli_ch_init(cch);
@@ -165,6 +165,7 @@ int cedit_run(struct expo *exp)
 	scene_id = ret;
 
 	done = false;
+	save = false;
 	do {
 		struct expo_action act;
 		int ichar, key;
@@ -209,6 +210,15 @@ int cedit_run(struct expo *exp)
 			case EXPOACT_OPEN:
 				scene_set_open(scn, act.select.id, true);
 				cedit_arange(exp, vid_priv, scene_id);
+				switch (scn->highlight_id) {
+				case EXPOID_SAVE:
+					done = true;
+					save = true;
+					break;
+				case EXPOID_DISCARD:
+					done = true;
+					break;
+				}
 				break;
 			case EXPOACT_CLOSE:
 				scene_set_open(scn, act.select.id, false);
@@ -230,6 +240,8 @@ int cedit_run(struct expo *exp)
 
 	if (ret)
 		return log_msg_ret("end", ret);
+	if (!save)
+		return -EACCES;
 
 	return 0;
 }
@@ -478,6 +490,9 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	const char *str;
 	int val, ret;
 
+	if (obj->id < EXPOID_BASE_ID)
+		return 0;
+
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
 	switch (obj->type) {
@@ -550,6 +565,9 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	char var[60];
 	int val;
 
+	if (obj->id < EXPOID_BASE_ID)
+		return 0;
+
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
 	switch (obj->type) {
@@ -645,7 +663,7 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
 	int val, ret;
 	uint i, seq;
 
-	if (obj->type != SCENEOBJT_MENU)
+	if (obj->type != SCENEOBJT_MENU || obj->id < EXPOID_BASE_ID)
 		return 0;
 
 	menu = (struct scene_obj_menu *)obj;
@@ -735,7 +753,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 	int val, ret;
 	uint i;
 
-	if (obj->type != SCENEOBJT_MENU)
+	if (obj->type != SCENEOBJT_MENU || obj->id < EXPOID_BASE_ID)
 		return 0;
 
 	menu = (struct scene_obj_menu *)obj;
diff --git a/boot/expo.c b/boot/expo.c
index 20ca0b9bfa0a..2a1591cce6a4 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -30,7 +30,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	exp->priv = priv;
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
-	exp->next_id = 1;
+	exp->next_id = EXPOID_BASE_ID;
 
 	*expp = exp;
 
diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 82305b921f0a..310be8892404 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -94,7 +94,7 @@ them. Expo supports doing this with an enum, where every ID is listed in the
 enum::
 
     enum {
-        ZERO,
+        ID_PROMPT = EXPOID_BASE_ID,
 
         ID_PROMPT,
 
@@ -130,6 +130,11 @@ that means that something is wrong with your syntax, or perhaps you have an ID
 in the `.dts` file that is not mentioned in your enum. Check both files and try
 again.
 
+Note that the first ID in your file must be no less that `EXPOID_BASE_ID` since
+IDs before that are reserved. The `expo.py` tool automatically obtains this
+value from the `expo.h` header file, but you must set the first ID to this
+enum value.
+
 
 Use the command interface
 -------------------------
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index f7b636e5fc62..d8115c463c1b 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -88,8 +88,13 @@ or even the IDs of objects. Programmatic creation of many items in a loop can be
 handled by allocating space in the enum for a maximum number of items, then
 adding the loop count to the enum values to obtain unique IDs.
 
-Where dynamic IDs are need, use expo_set_dynamic_start() to set the start value,
-so that they are allocated above the starting (enum) IDs.
+Some standard IDs are reserved for certain purposes. These are defined by
+`enum expo_id_t` and start at 1. `EXPOID_BASE_ID` defines the first ID which
+can be used for an expo.
+
+An ID of 0 is invalid. If this is specified in an expo call then a valid
+'dynamic IDs is allocated. Use expo_set_dynamic_start() to set the start
+value, so that they are allocated above the starting (enum) IDs.
 
 All text strings are stored in a structure attached to the expo, referenced by
 a text ID. This makes it easier at some point to implement multiple languages or
@@ -417,8 +422,7 @@ strings are provided inline in the nodes where they are used.
     /* this comment is parsed by the expo.py tool to insert the values below
 
     enum {
-        ZERO,
-        ID_PROMPT,
+        ID_PROMPT = EXPOID_BASE_ID,
         ID_SCENE1,
         ID_SCENE1_TITLE,
 
diff --git a/include/expo.h b/include/expo.h
index 4f62ee077e1f..4198c96adaa6 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -15,6 +15,26 @@ struct udevice;
 
 #include <cli.h>
 
+/**
+ * enum expo_id_t - standard expo IDs
+ *
+ * These are assumed to be in use at all times. Expos should use IDs starting
+ * from EXPOID_BASE_ID,
+ *
+ * @EXPOID_NONE: Not used, invalid ID 0
+ * @EXPOID_SAVE: User has requested that the expo data be saved
+ * @EXPOID_DISCARD: User has requested that the expo data be discarded
+ * @EXPOID_BASE_ID: First ID which can be used for expo objects
+ */
+enum expo_id_t {
+	EXPOID_NONE,
+
+	EXPOID_SAVE,
+	EXPOID_DISCARD,
+
+	EXPOID_BASE_ID = 5,
+};
+
 /**
  * enum expoact_type - types of actions reported by the expo
  *
diff --git a/include/test/cedit-test.h b/include/test/cedit-test.h
index 475ecc9c2dc2..0d38a9534156 100644
--- a/include/test/cedit-test.h
+++ b/include/test/cedit-test.h
@@ -9,24 +9,24 @@
 #ifndef __cedit_test_h
 #define __cedit_test_h
 
-#define ID_PROMPT		1
-#define ID_SCENE1		2
-#define ID_SCENE1_TITLE		3
+#define ID_PROMPT		5
+#define ID_SCENE1		6
+#define ID_SCENE1_TITLE		7
 
-#define ID_CPU_SPEED		4
-#define ID_CPU_SPEED_TITLE	5
-#define ID_CPU_SPEED_1		6
-#define ID_CPU_SPEED_2		7
-#define ID_CPU_SPEED_3		8
+#define ID_CPU_SPEED		8
+#define ID_CPU_SPEED_TITLE	9
+#define ID_CPU_SPEED_1		10
+#define ID_CPU_SPEED_2		11
+#define ID_CPU_SPEED_3		12
 
-#define ID_POWER_LOSS		9
-#define ID_AC_OFF		10
-#define ID_AC_ON		11
-#define ID_AC_MEMORY		12
+#define ID_POWER_LOSS		13
+#define ID_AC_OFF		14
+#define ID_AC_ON		15
+#define ID_AC_MEMORY		16
 
-#define ID_MACHINE_NAME		13
-#define ID_MACHINE_NAME_EDIT	14
+#define ID_MACHINE_NAME		17
+#define ID_MACHINE_NAME_EDIT	18
 
-#define ID_DYNAMIC_START	15
+#define ID_DYNAMIC_START	19
 
 #endif
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index aa4171904864..37807f9a9818 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -34,9 +34,11 @@ static int cedit_base(struct unit_test_state *uts)
 	 * ^N  Move down to second item
 	 * ^M  Select item
 	 * \e  Quit
+	 *
+	 * cedit_run() returns -EACCESS so this command returns CMD_RET_FAILURE
 	 */
 	console_in_puts("\x0e\x0d\x0e\x0d\e");
-	ut_assertok(run_command("cedit run", 0));
+	ut_asserteq(1, run_command("cedit run", 0));
 
 	exp = cur_exp;
 	scn = expo_lookup_scene_id(exp, exp->scene_id);
@@ -152,14 +154,14 @@ static int cedit_env(struct unit_test_state *uts)
 	strcpy(str, "my-machine");
 
 	ut_assertok(run_command("cedit write_env -v", 0));
-	ut_assert_nextlinen("c.cpu-speed=7");
+	ut_assert_nextlinen("c.cpu-speed=11");
 	ut_assert_nextlinen("c.cpu-speed-str=2.5 GHz");
-	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_nextlinen("c.power-loss=14");
 	ut_assert_nextlinen("c.power-loss-str=Always Off");
 	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
-	ut_asserteq(7, env_get_ulong("c.cpu-speed", 10, 0));
+	ut_asserteq(11, env_get_ulong("c.cpu-speed", 10, 0));
 	ut_asserteq_str("2.5 GHz", env_get("c.cpu-speed-str"));
 	ut_asserteq_str("my-machine", env_get("c.machine-name"));
 
@@ -168,8 +170,8 @@ static int cedit_env(struct unit_test_state *uts)
 	*str = '\0';
 
 	ut_assertok(run_command("cedit read_env -v", 0));
-	ut_assert_nextlinen("c.cpu-speed=7");
-	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_nextlinen("c.cpu-speed=11");
+	ut_assert_nextlinen("c.power-loss=14");
 	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 8a84cbc71032..2e8acac07313 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -92,7 +92,7 @@ static int expo_base(struct unit_test_state *uts)
 	*name = '\0';
 	ut_assertnonnull(exp);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(1, exp->next_id);
+	ut_asserteq(EXPOID_BASE_ID, exp->next_id);
 
 	/* Make sure the name was allocated */
 	ut_assertnonnull(exp->name);
@@ -131,7 +131,7 @@ static int expo_scene(struct unit_test_state *uts)
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
 
 	scn = NULL;
-	ut_asserteq(1, exp->next_id);
+	ut_asserteq(EXPOID_BASE_ID, exp->next_id);
 	strcpy(name, SCENE_NAME1);
 	id = scene_new(exp, name, SCENE1, &scn);
 	*name = '\0';
@@ -177,11 +177,11 @@ static int expo_scene_no_id(struct unit_test_state *uts)
 	int id;
 
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
-	ut_asserteq(1, exp->next_id);
+	ut_asserteq(EXPOID_BASE_ID, exp->next_id);
 
 	strcpy(name, SCENE_NAME1);
 	id = scene_new(exp, SCENE_NAME1, 0, &scn);
-	ut_asserteq(1, scn->id);
+	ut_asserteq(EXPOID_BASE_ID, scn->id);
 
 	return 0;
 }
diff --git a/test/boot/files/expo_ids.h b/test/boot/files/expo_ids.h
index a86e0d06f6b5..ffb511364b1f 100644
--- a/test/boot/files/expo_ids.h
+++ b/test/boot/files/expo_ids.h
@@ -4,8 +4,7 @@
  */
 
 enum {
-	ZERO,
-	ID_PROMPT,
+	ID_PROMPT = EXPOID_BASE_ID,
 
 	ID_SCENE1,
 	ID_SCENE1_TITLE,
diff --git a/tools/expo.py b/tools/expo.py
index ea80c70f04e3..44995f28a382 100755
--- a/tools/expo.py
+++ b/tools/expo.py
@@ -20,17 +20,22 @@ from u_boot_pylib import tools
 
 # Parse:
 #	SCENE1		= 7,
+# or    SCENE1		= EXPOID_BASE_ID,
 # or	SCENE2,
-RE_ENUM = re.compile(r'(\S*)(\s*= (\d))?,')
+RE_ENUM = re.compile(r'(\S*)(\s*= ([0-9A-Z_]+))?,')
 
 # Parse #define <name>  "string"
 RE_DEF = re.compile(r'#define (\S*)\s*"(.*)"')
 
-def calc_ids(fname):
+# Parse EXPOID_BASE_ID = 5,
+RE_BASE_ID = re.compile(r'\s*EXPOID_BASE_ID\s*= (\d+),')
+
+def calc_ids(fname, base_id):
     """Figure out the value of the enums in a C file
 
     Args:
         fname (str): Filename to parse
+        base_id (int): Base ID (value of EXPOID_BASE_ID)
 
     Returns:
         OrderedDict():
@@ -55,8 +60,12 @@ def calc_ids(fname):
                 if not line or line.startswith('/*'):
                     continue
                 m_enum = RE_ENUM.match(line)
-                if m_enum.group(3):
-                    cur_id = int(m_enum.group(3))
+                enum_name = m_enum.group(3)
+                if enum_name:
+                    if enum_name == 'EXPOID_BASE_ID':
+                        cur_id = base_id
+                    else:
+                        cur_id = int(enum_name)
                 vals[m_enum.group(1)] = cur_id
                 cur_id += 1
             else:
@@ -67,10 +76,24 @@ def calc_ids(fname):
     return vals
 
 
+def find_base_id():
+    fname = 'include/expo.h'
+    base_id = None
+    with open(fname, 'r', encoding='utf-8') as inf:
+        for line in inf.readlines():
+            m_base_id = RE_BASE_ID.match(line)
+            if m_base_id:
+                base_id = int(m_base_id.group(1))
+    if base_id is None:
+        raise ValueError('EXPOID_BASE_ID not found in expo.h')
+    #print(f'EXPOID_BASE_ID={base_id}')
+    return base_id
+
 def run_expo(args):
     """Run the expo program"""
+    base_id = find_base_id()
     fname = args.enum_fname or args.layout
-    ids = calc_ids(fname)
+    ids = calc_ids(fname, base_id)
     if not ids:
         print(f"Warning: No enum ID values found in file '{fname}'")
 
-- 
2.42.0.582.g8ccd20d70d-goog

