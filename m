Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B670BC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E18869F6;
	Tue, 15 Aug 2023 00:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QacbnznD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871BA869F0; Tue, 15 Aug 2023 00:41:32 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEA9869E9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-349a1cf0ae2so17323725ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052888; x=1692657688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUdSwn+uiJJasA7oCqYVMVJ8UuMKGKk82ApC800RPhQ=;
 b=QacbnznDu41YrdDN2bWjRlYZE7wj5Ow8WD7Z7rjvv1GmLfDPd14Y/1d14FhPAadoZy
 N80Y0Yd3mkyRyr0fJx1QLUUzZbU4D2Ecd350BT7n2Xa7LM+v6YzwuvlAyrVND+Yo/gkW
 gQungAyGU1UL+2jBQ0zSPrViCtXjbh0Vl9C/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052888; x=1692657688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUdSwn+uiJJasA7oCqYVMVJ8UuMKGKk82ApC800RPhQ=;
 b=WaNkRWwOQiOchLNfCrkLV/7SPpcoh9GLiE/YGjx+zt1Zmz9eZbsaxiYa1D3SX8ZgUO
 X9upu6r2TypTIPMdLzDmzGXGyjkaMrd9Z9AHiQMALOUX0uG8exjZCU/OGMDw+k5S4Gmw
 8y3C36kPtSKXlATm9ul8ETEaDHT+JwfpBoHQbOOoN2vH1Msl09zjTpNNnZbOTr0PwJPd
 /hVsquNSh57KDJG0tWZkcI/qCG4MybTq9XCovsmcALa30VXgC94pb0kJZX1WZMIp26Fv
 M8CIMdbIpLl5qm+YZH2jNUqyVlVNrQPz7xaUoz+Hf8gc9xpvY3kzxqUy1UD01mw8wI1q
 8KcQ==
X-Gm-Message-State: AOJu0YzfCBJvRrvTnVdqKRIj1IQBr2RKDu/ydpQRiSeI+n3MWAiAG8FX
 q9VRoxIvsBgx+LcPqxF2Y7WCf4+g2q1zBELZrto=
X-Google-Smtp-Source: AGHT+IFb1H6ULGv3j5AntmKadT4GQJOdH2sP+EPEUVeT/Nu1adqYwQfNE9raIMb19ljEGmF6z7ofvA==
X-Received: by 2002:a05:6e02:1110:b0:348:dba4:6418 with SMTP id
 u16-20020a056e02111000b00348dba46418mr14705367ilk.6.1692052888268; 
 Mon, 14 Aug 2023 15:41:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 15/19] expo: cedit: Support writing settings to environment
 vars
Date: Mon, 14 Aug 2023 16:40:35 -0600
Message-ID: <20230814224047.535491-16-sjg@chromium.org>
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

Add a command to write cedit settings to environment variables so that
they can be stored with 'saveenv'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c            | 97 +++++++++++++++++++++++++++++++++++------
 cmd/cedit.c             | 22 ++++++++++
 doc/usage/cmd/cedit.rst | 25 +++++++++++
 include/cedit.h         |  9 ++++
 test/boot/cedit.c       | 33 ++++++++++++++
 5 files changed, 172 insertions(+), 14 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 6a74a3809898..9399c01cda96 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -13,6 +13,7 @@
 #include <cedit.h>
 #include <cli.h>
 #include <dm.h>
+#include <env.h>
 #include <expo.h>
 #include <menu.h>
 #include <video.h>
@@ -24,10 +25,12 @@
  *
  * @buf: Buffer to use when writing settings to the devicetree
  * @node: Node to read from when reading settings from devicetree
+ * @verbose: true to show writing to environment variables
  */
 struct cedit_iter_priv {
 	struct abuf *buf;
 	ofnode node;
+	bool verbose;
 };
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
@@ -209,6 +212,30 @@ static int check_space(int ret, struct abuf *buf)
 	return 0;
 }
 
+static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
+				 const char **strp)
+{
+	struct scene *scn = menu->obj.scene;
+	const struct scene_menitem *mi;
+	const struct scene_obj_txt *txt;
+	const char *str;
+
+	mi = scene_menuitem_find(menu, menu->cur_item_id);
+	if (!mi)
+		return log_msg_ret("mi", -ENOENT);
+
+	txt = scene_obj_find(scn, mi->label_id, SCENEOBJT_TEXT);
+	if (!txt)
+		return log_msg_ret("txt", -ENOENT);
+
+	str = expo_get_str(scn->expo, txt->str_id);
+	if (!str)
+		return log_msg_ret("str", -ENOENT);
+	*strp = str;
+
+	return 0;
+}
+
 static int h_write_settings(struct scene_obj *obj, void *vpriv)
 {
 	struct cedit_iter_priv *priv = vpriv;
@@ -221,9 +248,6 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		break;
 	case SCENEOBJT_MENU: {
 		const struct scene_obj_menu *menu;
-		const struct scene_obj_txt *txt;
-		struct scene *scn = obj->scene;
-		const struct scene_menitem *mi;
 		const char *str;
 		char name[80];
 		int ret, i;
@@ -243,17 +267,9 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		if (ret)
 			return log_msg_ret("wrt", -EFAULT);
 
-		mi = scene_menuitem_find(menu, menu->cur_item_id);
-		if (!mi)
-			return log_msg_ret("mi", -ENOENT);
-
-		txt = scene_obj_find(scn, mi->label_id, SCENEOBJT_TEXT);
-		if (!txt)
-			return log_msg_ret("txt", -ENOENT);
-
-		str = expo_get_str(scn->expo, txt->str_id);
-		if (!str)
-			return log_msg_ret("str", -ENOENT);
+		ret = get_cur_menuitem_text(menu, &str);
+		if (ret)
+			return log_msg_ret("mis", ret);
 
 		snprintf(name, sizeof(name), "%s-str", obj->name);
 		ret = -EAGAIN;
@@ -370,3 +386,56 @@ int cedit_read_settings(struct expo *exp, oftree tree)
 
 	return 0;
 }
+
+static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
+{
+	const struct scene_obj_menu *menu;
+	struct cedit_iter_priv *priv = vpriv;
+	char name[80], var[60];
+	const char *str;
+	int val, ret;
+
+	if (obj->type != SCENEOBJT_MENU)
+		return 0;
+
+	menu = (struct scene_obj_menu *)obj;
+	val = menu->cur_item_id;
+	snprintf(var, sizeof(var), "c.%s", obj->name);
+
+	if (priv->verbose)
+		printf("%s=%d\n", var, val);
+
+	ret = env_set_ulong(var, val);
+	if (ret)
+		return log_msg_ret("set", ret);
+
+	ret = get_cur_menuitem_text(menu, &str);
+	if (ret)
+		return log_msg_ret("mis", ret);
+
+	snprintf(name, sizeof(name), "c.%s-str", obj->name);
+	if (priv->verbose)
+		printf("%s=%s\n", name, str);
+
+	ret = env_set(name, str);
+	if (ret)
+		return log_msg_ret("st2", ret);
+
+	return 0;
+}
+
+int cedit_write_settings_env(struct expo *exp, bool verbose)
+{
+	struct cedit_iter_priv priv;
+	int ret;
+
+	/* write out the items */
+	priv.verbose = verbose;
+	ret = expo_iter_scene_objs(exp, h_write_settings_env, &priv);
+	if (ret) {
+		log_debug("Failed to write settings to env (err=%d)\n", ret);
+		return log_msg_ret("set", ret);
+	}
+
+	return 0;
+}
diff --git a/cmd/cedit.c b/cmd/cedit.c
index a155e080b1f2..85629f7b83cb 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -136,6 +136,26 @@ static int do_cedit_read_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_write_env(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	bool verbose;
+	int ret;
+
+	if (check_cur_expo())
+		return CMD_RET_FAILURE;
+
+	verbose = argc > 1 && !strcmp(argv[1], "-v");
+
+	ret = cedit_write_settings_env(cur_exp, verbose);
+	if (ret) {
+		printf("Failed to write settings to environment: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -167,6 +187,7 @@ static char cedit_help_text[] =
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
 	"cedit read_fdt <i/f> <dev[:part]> <filename>     - read settings\n"
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
+	"cedit write_env [-v]                             - write settings to env vars\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
 
@@ -174,5 +195,6 @@ U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
 	U_BOOT_SUBCMD_MKENT(read_fdt, 5, 1, do_cedit_read_fdt),
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
+	U_BOOT_SUBCMD_MKENT(write_env, 2, 1, do_cedit_write_env),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 0a9f620b59b3..426470a82ac2 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -12,6 +12,7 @@ Synopis
     cedit run
     cedit write_fdt <dev[:part]> <filename>
     cedit read_fdt <dev[:part]> <filename>
+    cedit write_env [-v]
 
 Description
 -----------
@@ -52,6 +53,19 @@ cedit read_fdt
 Reads the user settings from a devicetree file and updates the cedit with those
 settings.
 
+cedit write_env
+~~~~~~~~~~~~~~~
+
+Writes the settings to environment variables. For each menu item the selected
+ID and its text string are written, similar to:
+
+   setenv c.<name> <selected_id>
+   setenv c.<name>-str <selected_id's text string>
+
+The `-v` flag enables verbose mode, where each variable is printed before it is
+set.
+
+
 Example
 -------
 
@@ -73,3 +87,14 @@ That results in::
     }
 
     => cedit read_fdt hostfs - settings.dtb
+
+This shows settings being stored in the environment::
+
+    => cedit write_env -v
+    => print
+    ...
+    c.cpu-speed=6
+    c.cpu-speed-str=2 GHz
+    c.power-loss=10
+    c.power-loss-str=Always Off
+    ...
diff --git a/include/cedit.h b/include/cedit.h
index bb6e87d4af77..f261207e2097 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -80,4 +80,13 @@ int cedit_write_settings(struct expo *exp, struct abuf *buf);
  */
 int cedit_read_settings(struct expo *exp, oftree tree);
 
+/**
+ * cedit_write_settings_env() - Write settings to envrionment variables
+ *
+ * @exp: Expo to write settings from
+ * @verbose: true to print each var as it is set
+ * Return: 0 if OK, -ve on error
+ */
+int cedit_write_settings_env(struct expo *exp, bool verbose);
+
 #endif /* __CEDIT_H */
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 659c47ed35fb..26a69f0323fb 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <cedit.h>
+#include <env.h>
 #include <expo.h>
 #include <mapmem.h>
 #include <dm/ofnode.h>
@@ -112,3 +113,35 @@ static int cedit_fdt(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(cedit_fdt, 0);
+
+/* Check the cedit write_env command */
+static int cedit_env(struct unit_test_state *uts)
+{
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	struct scene_obj_menu *menu;
+	struct scene *scn;
+
+	console_record_reset_enable();
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+
+	/* get a menu to fiddle with */
+	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	menu->cur_item_id = ID_CPU_SPEED_2;
+
+	ut_assertok(run_command("cedit write_env -v", 0));
+	ut_assert_nextlinen("c.cpu-speed=7");
+	ut_assert_nextlinen("c.cpu-speed-str=2.5 GHz");
+	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_nextlinen("c.power-loss-str=Always Off");
+	ut_assert_console_end();
+
+	ut_asserteq(7, env_get_ulong("c.cpu-speed", 10, 0));
+	ut_asserteq_str("2.5 GHz", env_get("c.cpu-speed-str"));
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_env, 0);
-- 
2.41.0.694.ge786442a9b-goog

