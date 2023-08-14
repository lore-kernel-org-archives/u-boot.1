Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFAAC04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA36B869FC;
	Tue, 15 Aug 2023 00:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cr70AtVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA1C869C1; Tue, 15 Aug 2023 00:41:32 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881B98662F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3499936a13eso19522875ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052889; x=1692657689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4c3sp/RewVsHs7HLkA/9psx4wMUcx2QPsBvX1BswAI=;
 b=Cr70AtVw4Fu6qsiX8Y8IPtG8Rq3elgTh/aNnLNKm/IDQ7jd1khva/bBOkN+cfwoJWy
 ALf03GHPzP43C3rtlyajG1tYo9TtS79tg8Elq8aUlhZ0gN/XPe68G5pEA6Knz9t6I0Wk
 k916BohqplpzWcw+sRnx68jOg8HFRoF9G4GIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052889; x=1692657689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4c3sp/RewVsHs7HLkA/9psx4wMUcx2QPsBvX1BswAI=;
 b=Mz39lpWCUNaO6OFaa9ShilJOvowVQ8aPD7rpDZfLfaqgiCf79WQKFw/S14Lu+Xn0+C
 a0M6oblEKfwFQ+o3KE8ZLZjsug/wblb8wJ993oT2qZvCUSNKNNiGzcZcBZ9Yd6fJhuZh
 BNuS3qkL9+TL6jbjOTLEcXtyiYqCLLg5EThVkjEK2aE8g7i2DuXdsyAovrCQUa75gOyW
 EHH2vZO2o287jGnku360NVAA40LcqsyzXs0GgKg6b4ZgUU2WNM8YoYWBNyK4v26JAHMk
 VUcmYLG0hN8DyirLSFokYyBJOQk0BFgjxXxsDrw2zFa0jZ6XOHZXBaF2ED2ljhEGy/ar
 38ng==
X-Gm-Message-State: AOJu0YwSuQ7SZFy64e4z26XkFigkMTyrnZcWGjqDMQhBnJy5ESyeP78m
 MEuVYrFjanU4MHTJM2g+t6j1asJgrnBi2fZHGpg=
X-Google-Smtp-Source: AGHT+IGWwd9sHAHeXlZyhmhPp/tjAF3rpB9v1yVRPAQX4NhwT0fagxovCSY+UieH3R6pWBOwfBFS3Q==
X-Received: by 2002:a05:6e02:1ca1:b0:349:479d:43fb with SMTP id
 x1-20020a056e021ca100b00349479d43fbmr16843258ill.5.1692052889104; 
 Mon, 14 Aug 2023 15:41:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 16/19] expo: cedit: Support reading settings from environment
 vars
Date: Mon, 14 Aug 2023 16:40:36 -0600
Message-ID: <20230814224047.535491-17-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Add a command to read cedit settings from environment variables so that
they can be restored as part of the environment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c            | 45 +++++++++++++++++++++++++++++++++++++++++
 cmd/cedit.c             | 22 ++++++++++++++++++++
 doc/usage/cmd/cedit.rst | 19 +++++++++++++++++
 include/cedit.h         |  8 ++++++++
 test/boot/cedit.c       | 12 ++++++++++-
 5 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 9399c01cda96..e3f6dc003991 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -439,3 +439,48 @@ int cedit_write_settings_env(struct expo *exp, bool verbose)
 
 	return 0;
 }
+
+static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
+{
+	struct cedit_iter_priv *priv = vpriv;
+	struct scene_obj_menu *menu;
+	char var[60];
+	int val, ret;
+
+	if (obj->type != SCENEOBJT_MENU)
+		return 0;
+
+	menu = (struct scene_obj_menu *)obj;
+	val = menu->cur_item_id;
+	snprintf(var, sizeof(var), "c.%s", obj->name);
+
+	val = env_get_ulong(var, 10, 0);
+	if (priv->verbose)
+		printf("%s=%d\n", var, val);
+	if (!val)
+		return log_msg_ret("get", -ENOENT);
+
+	/*
+	 * note that no validation is done here, to make sure the ID is valid
+	 * and actually points to a menu item
+	 */
+	menu->cur_item_id = val;
+
+	return 0;
+}
+
+int cedit_read_settings_env(struct expo *exp, bool verbose)
+{
+	struct cedit_iter_priv priv;
+	int ret;
+
+	/* write out the items */
+	priv.verbose = verbose;
+	ret = expo_iter_scene_objs(exp, h_read_settings_env, &priv);
+	if (ret) {
+		log_debug("Failed to read settings from env (err=%d)\n", ret);
+		return log_msg_ret("set", ret);
+	}
+
+	return 0;
+}
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 85629f7b83cb..b2548f44b572 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -156,6 +156,26 @@ static int do_cedit_write_env(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_read_env(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	bool verbose;
+	int ret;
+
+	if (check_cur_expo())
+		return CMD_RET_FAILURE;
+
+	verbose = argc > 1 && !strcmp(argv[1], "-v");
+
+	ret = cedit_read_settings_env(cur_exp, verbose);
+	if (ret) {
+		printf("Failed to read settings from environment: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -187,6 +207,7 @@ static char cedit_help_text[] =
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
 	"cedit read_fdt <i/f> <dev[:part]> <filename>     - read settings\n"
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
+	"cedit read_env [-v]                              - read settings from env vars\n"
 	"cedit write_env [-v]                             - write settings to env vars\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
@@ -195,6 +216,7 @@ U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
 	U_BOOT_SUBCMD_MKENT(read_fdt, 5, 1, do_cedit_read_fdt),
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
+	U_BOOT_SUBCMD_MKENT(read_env, 2, 1, do_cedit_read_env),
 	U_BOOT_SUBCMD_MKENT(write_env, 2, 1, do_cedit_write_env),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 426470a82ac2..1f92b7306a7a 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -13,6 +13,7 @@ Synopis
     cedit write_fdt <dev[:part]> <filename>
     cedit read_fdt <dev[:part]> <filename>
     cedit write_env [-v]
+    cedit read_env [-v]
 
 Description
 -----------
@@ -53,6 +54,16 @@ cedit read_fdt
 Reads the user settings from a devicetree file and updates the cedit with those
 settings.
 
+cedit read_env
+~~~~~~~~~~~~~~
+
+Reads the settings from the environment variables. For each menu item `<name>`,
+cedit looks for a variable called `c.<name>` with the ID of the selected menu
+item.
+
+The `-v` flag enables verbose mode, where each variable is printed after it is
+read.
+
 cedit write_env
 ~~~~~~~~~~~~~~~
 
@@ -91,6 +102,10 @@ That results in::
 This shows settings being stored in the environment::
 
     => cedit write_env -v
+    c.cpu-speed=7
+    c.cpu-speed-str=2.5 GHz
+    c.power-loss=12
+    c.power-loss-str=Memory
     => print
     ...
     c.cpu-speed=6
@@ -98,3 +113,7 @@ This shows settings being stored in the environment::
     c.power-loss=10
     c.power-loss-str=Always Off
     ...
+
+    => cedit read_env -v
+    c.cpu-speed=7
+    c.power-loss=12
diff --git a/include/cedit.h b/include/cedit.h
index f261207e2097..fe10e6c829cd 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -89,4 +89,12 @@ int cedit_read_settings(struct expo *exp, oftree tree);
  */
 int cedit_write_settings_env(struct expo *exp, bool verbose);
 
+/*
+ * cedit_read_settings_env() - Read settings from the environment
+ *
+ * @exp: Expo to read settings into
+ * @verbose: true to print each var before it is read
+ */
+int cedit_read_settings_env(struct expo *exp, bool verbose);
+
 #endif /* __CEDIT_H */
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 26a69f0323fb..7cf0c3e4e930 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -114,7 +114,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(cedit_fdt, 0);
 
-/* Check the cedit write_env command */
+/* Check the cedit write_env and read_env commands */
 static int cedit_env(struct unit_test_state *uts)
 {
 	struct video_priv *vid_priv;
@@ -142,6 +142,16 @@ static int cedit_env(struct unit_test_state *uts)
 	ut_asserteq(7, env_get_ulong("c.cpu-speed", 10, 0));
 	ut_asserteq_str("2.5 GHz", env_get("c.cpu-speed-str"));
 
+	/* reset the expo */
+	menu->cur_item_id = ID_CPU_SPEED_1;
+
+	ut_assertok(run_command("cedit read_env -v", 0));
+	ut_assert_nextlinen("c.cpu-speed=7");
+	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_console_end();
+
+	ut_asserteq(ID_CPU_SPEED_2, menu->cur_item_id);
+
 	return 0;
 }
 BOOTSTD_TEST(cedit_env, 0);
-- 
2.41.0.694.ge786442a9b-goog

