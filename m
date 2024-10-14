Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388D1D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304B88926F;
	Tue, 15 Oct 2024 00:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nrFIx1ZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55348924E; Tue, 15 Oct 2024 00:32:26 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 324BD87042
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-83549342f09so133279539f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945140; x=1729549940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlRJ5hAGmdutzsO7A2TFdpdJmu1z8idPI0+9ytD9qAg=;
 b=nrFIx1ZBrtvZvFb6Yf7xKIaz0PBtv3fA2pcJjyO9UDBS0bZRXMs2Df+QVoFQvxT5iZ
 Bwcy1hDrL1fqtCWqlMn4mXrfW7WoIybUgGJ695Bqn0p6mnDPZ1vihOTtQt9wGUuEcXUD
 OqTMmyWiTLrAS4WP8ivHcZKbgCbJkaJM9DhNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945140; x=1729549940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlRJ5hAGmdutzsO7A2TFdpdJmu1z8idPI0+9ytD9qAg=;
 b=tv8g/bnlJtalx5kSLcZbY3sCPQJ6SSiqt7pzYL1SoG7YHraAv35vjJ6C2ZhWGrtn9t
 6sBvDdXpB2gB/Y9ctTABK2ij5/bQU+tSsoSLTRWET0Zw2TfwlIEjOm27aEw0bUN/qrWA
 7qXDC4Qjf/uI1Cj7Y8RK4dLNzAN/q99+fuF9mlf3e7xMFKq8VNOKQo6gun5qU5unnuBZ
 yJc2kdzVVqMDr5KD3F0BW4eSHAv6TwaqHRPhkkg8rRgW1YgABWkD4g4Wu6a3kPlI4dw6
 fsNXZmOilc0RbyF3PNIz5yQbXeEc+L/hw0nYYdJPt90zPT7PWUlbWDCWFVksMCrH4J3F
 8fvg==
X-Gm-Message-State: AOJu0YzQgqbXP+wkIvxuBLhEGADY9Zt61t3XfAD1xNK3yYfTsWVOi2qb
 4txRKBwxKs24UIxJh4Ajcte2v7G7q9dka5VUH/FQcb5hwpQrOWn97Mi+A0urQX1UUy/kvUJWLkm
 2M7DC
X-Google-Smtp-Source: AGHT+IF4k12P13A5Pr+kGo8ulsz/IAHxkC0hrvEviX2hjne7woqxQVSe0TshYImiIf0o2u+LNvwoRg==
X-Received: by 2002:a5d:91c4:0:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-835486861e2mr1124793339f.4.1728945140466; 
 Mon, 14 Oct 2024 15:32:20 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 05/20] expo: Use standard numbering for save and discard
Date: Mon, 14 Oct 2024 16:31:57 -0600
Message-Id: <20241014223212.2212442-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

(no changes since v1)

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
index 5758cc5a0d6..cd935d4beba 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -154,7 +154,7 @@ int cedit_run(struct expo *exp)
 	struct video_priv *vid_priv;
 	uint scene_id;
 	struct scene *scn;
-	bool done;
+	bool done, save;
 	int ret;
 
 	cli_ch_init(cch);
@@ -164,6 +164,7 @@ int cedit_run(struct expo *exp)
 	scene_id = ret;
 
 	done = false;
+	save = false;
 	do {
 		struct expo_action act;
 		int ichar, key;
@@ -208,6 +209,15 @@ int cedit_run(struct expo *exp)
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
@@ -229,6 +239,8 @@ int cedit_run(struct expo *exp)
 
 	if (ret)
 		return log_msg_ret("end", ret);
+	if (!save)
+		return -EACCES;
 
 	return 0;
 }
@@ -477,6 +489,9 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	const char *str;
 	int val, ret;
 
+	if (obj->id < EXPOID_BASE_ID)
+		return 0;
+
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
 	switch (obj->type) {
@@ -549,6 +564,9 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	char var[60];
 	int val;
 
+	if (obj->id < EXPOID_BASE_ID)
+		return 0;
+
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
 	switch (obj->type) {
@@ -644,7 +662,7 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
 	int val, ret;
 	uint i, seq;
 
-	if (obj->type != SCENEOBJT_MENU)
+	if (obj->type != SCENEOBJT_MENU || obj->id < EXPOID_BASE_ID)
 		return 0;
 
 	menu = (struct scene_obj_menu *)obj;
@@ -734,7 +752,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 	int val, ret;
 	uint i;
 
-	if (obj->type != SCENEOBJT_MENU)
+	if (obj->type != SCENEOBJT_MENU || obj->id < EXPOID_BASE_ID)
 		return 0;
 
 	menu = (struct scene_obj_menu *)obj;
diff --git a/boot/expo.c b/boot/expo.c
index 700786ec0cc..786f665f53c 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -29,7 +29,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	exp->priv = priv;
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
-	exp->next_id = 1;
+	exp->next_id = EXPOID_BASE_ID;
 
 	*expp = exp;
 
diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 82305b921f0..310be889240 100644
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
index f7b636e5fc6..d8115c463c1 100644
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
index 50e11cd118c..d6e2ccee41b 100644
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
index 475ecc9c2dc..0d38a953415 100644
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
index 1f7af8e5d79..0f2c2e73dd3 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -31,9 +31,11 @@ static int cedit_base(struct unit_test_state *uts)
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
@@ -147,14 +149,14 @@ static int cedit_env(struct unit_test_state *uts)
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
 
@@ -163,8 +165,8 @@ static int cedit_env(struct unit_test_state *uts)
 	*str = '\0';
 
 	ut_assertok(run_command("cedit read_env -v", 0));
-	ut_assert_nextlinen("c.cpu-speed=7");
-	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_nextlinen("c.cpu-speed=11");
+	ut_assert_nextlinen("c.power-loss=14");
 	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index f6a6b4fd2cb..b0bf2988bf0 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -91,7 +91,7 @@ static int expo_base(struct unit_test_state *uts)
 	*name = '\0';
 	ut_assertnonnull(exp);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(1, exp->next_id);
+	ut_asserteq(EXPOID_BASE_ID, exp->next_id);
 
 	/* Make sure the name was allocated */
 	ut_assertnonnull(exp->name);
@@ -130,7 +130,7 @@ static int expo_scene(struct unit_test_state *uts)
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
 
 	scn = NULL;
-	ut_asserteq(1, exp->next_id);
+	ut_asserteq(EXPOID_BASE_ID, exp->next_id);
 	strcpy(name, SCENE_NAME1);
 	id = scene_new(exp, name, SCENE1, &scn);
 	*name = '\0';
@@ -176,11 +176,11 @@ static int expo_scene_no_id(struct unit_test_state *uts)
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
index a86e0d06f6b..ffb511364b1 100644
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
index ea80c70f04e..44995f28a38 100755
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
2.34.1

