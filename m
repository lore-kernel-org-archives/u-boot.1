Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A42C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F430869ED;
	Tue, 15 Aug 2023 00:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zby5D53F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87368869EC; Tue, 15 Aug 2023 00:41:30 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FE18662F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34aa1572740so4531145ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052887; x=1692657687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5Bk1UhPBeD0yeUXmOBQwbs/lNr23dL2I4ZLl5Z+Z7M=;
 b=Zby5D53Fr4xExUWYU4UYCUTtr2XTGPInm/ruzdmke05drQfgR/R4/UdSBwUBrbYC1o
 4CfC60ZHaK0p4nvRPYkcUjrBdV5AsOTdLMDutqDiawH822Z1MbvkVSYIlq/VS9T2lg2d
 pWPWj0P9DO3UWYVJd9po3Ew8I3mVKflQPm8M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052887; x=1692657687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5Bk1UhPBeD0yeUXmOBQwbs/lNr23dL2I4ZLl5Z+Z7M=;
 b=YRLQVqAQg4LXhELv8b3upLGtFYeOqLVkX6714F5COc3gJnripH0TDjSFQ5C5JGmHU/
 ZSz30cEYRR2ff7WvyFb8a+cyrbdWvtUQgAokW/LHxg3l0EBmQiZ5FQusg5UMP2dG6yij
 kWujsGBpogA7AoGGAXoyGTmDSEhWaqRF8M4Yo9clva/Qa+q3P4av2j83JppC3QyNy3Cu
 2sWg7MtsEZ6jHaH0GJZWVP6g6vnO4nMkd1crr8oT+iXdN4DMe6LBBsv45POLf6wjvazT
 vQY5XyvuQAFzYfjKkS3r3X+caDkXsu+65ABiVdEAzgPyLbd2SYwf0s2LYJwN4oKR64gb
 UVBA==
X-Gm-Message-State: AOJu0Yy5NhKlKNRkRLMIQ9nktKiSQmJpJWzeRaoqhBV3DBkJRfKDkPSC
 QPwAC57pcz/IHptlhFWd2s08QZztTka/RMFALRI=
X-Google-Smtp-Source: AGHT+IEhFNSD4264a78HKT8CQ9B4d8DKYjlzbqy0GDZtK8k9xNjZi/CgKEVhIlsMJY5JaXhZHvByKA==
X-Received: by 2002:a05:6e02:1907:b0:348:8566:be66 with SMTP id
 w7-20020a056e02190700b003488566be66mr15911662ilu.18.1692052886651; 
 Mon, 14 Aug 2023 15:41:26 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/19] expo: cedit: Support writing settings to a file
Date: Mon, 14 Aug 2023 16:40:33 -0600
Message-ID: <20230814224047.535491-14-sjg@chromium.org>
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

Support writing settings from an expo into a file in FDT format. It
consists of a single node with a two properties for each sceneitem,
one with tag ID chosen by the user and another for its text value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c            | 136 ++++++++++++++++++++++++++++++++++++++++
 cmd/cedit.c             |  51 ++++++++++++++-
 doc/usage/cmd/cedit.rst |  19 ++++++
 include/cedit.h         |  22 +++++++
 test/boot/cedit.c       |  45 +++++++++++++
 5 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 6c10b2114541..4dd79a2263d6 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -9,6 +9,7 @@
 #define LOG_CATEGORY LOGC_EXPO
 
 #include <common.h>
+#include <abuf.h>
 #include <cedit.h>
 #include <cli.h>
 #include <dm.h>
@@ -18,6 +19,15 @@
 #include <linux/delay.h>
 #include "scene_internal.h"
 
+/**
+ * struct cedit_iter_priv - private data for cedit operations
+ *
+ * @buf: Buffer to use when writing settings to the devicetree
+ */
+struct cedit_iter_priv {
+	struct abuf *buf;
+};
+
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 {
 	struct scene_obj_txt *txt;
@@ -182,3 +192,129 @@ int cedit_run(struct expo *exp)
 
 	return 0;
 }
+
+static int check_space(int ret, struct abuf *buf)
+{
+	if (ret == -FDT_ERR_NOSPACE) {
+		if (!abuf_realloc_inc(buf, CEDIT_SIZE_INC))
+			return log_msg_ret("spc", -ENOMEM);
+		ret = fdt_resize(abuf_data(buf), abuf_data(buf),
+				 abuf_size(buf));
+		if (ret)
+			return log_msg_ret("res", -EFAULT);
+	}
+
+	return 0;
+}
+
+static int h_write_settings(struct scene_obj *obj, void *vpriv)
+{
+	struct cedit_iter_priv *priv = vpriv;
+	struct abuf *buf = priv->buf;
+
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_TEXT:
+		break;
+	case SCENEOBJT_MENU: {
+		const struct scene_obj_menu *menu;
+		const struct scene_obj_txt *txt;
+		struct scene *scn = obj->scene;
+		const struct scene_menitem *mi;
+		const char *str;
+		char name[80];
+		int ret, i;
+
+		menu = (struct scene_obj_menu *)obj;
+		ret = -EAGAIN;
+		for (i = 0; ret && i < 2; i++) {
+			ret = fdt_property_u32(abuf_data(buf), obj->name,
+					       menu->cur_item_id);
+			if (!i) {
+				ret = check_space(ret, buf);
+				if (ret)
+					return log_msg_ret("res", -ENOMEM);
+			}
+		}
+		/* this should not happen */
+		if (ret)
+			return log_msg_ret("wrt", -EFAULT);
+
+		mi = scene_menuitem_find(menu, menu->cur_item_id);
+		if (!mi)
+			return log_msg_ret("mi", -ENOENT);
+
+		txt = scene_obj_find(scn, mi->label_id, SCENEOBJT_TEXT);
+		if (!txt)
+			return log_msg_ret("txt", -ENOENT);
+
+		str = expo_get_str(scn->expo, txt->str_id);
+		if (!str)
+			return log_msg_ret("str", -ENOENT);
+
+		snprintf(name, sizeof(name), "%s-str", obj->name);
+		ret = -EAGAIN;
+		for (i = 0; ret && i < 2; i++) {
+			ret = fdt_property_string(abuf_data(buf), name, str);
+			if (!i) {
+				ret = check_space(ret, buf);
+				if (ret)
+					return log_msg_ret("rs2", -ENOMEM);
+			}
+		}
+
+		/* this should not happen */
+		if (ret)
+			return log_msg_ret("wr2", -EFAULT);
+
+		break;
+	}
+	}
+
+	return 0;
+}
+
+int cedit_write_settings(struct expo *exp, struct abuf *buf)
+{
+	struct cedit_iter_priv priv;
+	void *fdt;
+	int ret;
+
+	abuf_init(buf);
+	if (!abuf_realloc(buf, CEDIT_SIZE_INC))
+		return log_msg_ret("buf", -ENOMEM);
+
+	fdt = abuf_data(buf);
+	ret = fdt_create(fdt, abuf_size(buf));
+	if (!ret)
+		ret = fdt_finish_reservemap(fdt);
+	if (!ret)
+		ret = fdt_begin_node(fdt, "");
+	if (!ret)
+		ret = fdt_begin_node(fdt, CEDIT_NODE_NAME);
+	if (ret) {
+		log_debug("Failed to start FDT (err=%d)\n", ret);
+		return log_msg_ret("sta", -EINVAL);
+	}
+
+	/* write out the items */
+	priv.buf = buf;
+	ret = expo_iter_scene_objs(exp, h_write_settings, &priv);
+	if (ret) {
+		log_debug("Failed to write settings (err=%d)\n", ret);
+		return log_msg_ret("set", ret);
+	}
+
+	ret = fdt_end_node(fdt);
+	if (!ret)
+		ret = fdt_end_node(fdt);
+	if (!ret)
+		ret = fdt_finish(fdt);
+	if (ret) {
+		log_debug("Failed to finish FDT (err=%d)\n", ret);
+		return log_msg_ret("fin", -EINVAL);
+	}
+
+	return 0;
+}
diff --git a/cmd/cedit.c b/cmd/cedit.c
index e98121b067b2..18cc8ba191bf 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -7,15 +7,28 @@
  */
 
 #include <common.h>
+#include <abuf.h>
 #include <cedit.h>
 #include <command.h>
 #include <expo.h>
 #include <fs.h>
+#include <malloc.h>
+#include <mapmem.h>
 #include <dm/ofnode.h>
 #include <linux/sizes.h>
 
 struct expo *cur_exp;
 
+static int check_cur_expo(void)
+{
+	if (!cur_exp) {
+		printf("No expo loaded\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int do_cedit_load(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
@@ -54,16 +67,46 @@ static int do_cedit_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_write_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	const char *fname;
+	struct abuf buf;
+	loff_t bytes;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+	fname = argv[3];
+
+	if (check_cur_expo())
+		return CMD_RET_FAILURE;
+
+	ret = cedit_write_settings(cur_exp, &buf);
+	if (ret) {
+		printf("Failed to write settings: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (fs_set_blk_dev(argv[1], argv[2], FS_TYPE_ANY))
+		return CMD_RET_FAILURE;
+
+	ret = fs_write(fname, map_to_sysmem(abuf_data(&buf)), 0,
+		       abuf_size(&buf), &bytes);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	ofnode node;
 	int ret;
 
-	if (!cur_exp) {
-		printf("No expo loaded\n");
+	if (check_cur_expo())
 		return CMD_RET_FAILURE;
-	}
 
 	node = ofnode_path("/bootstd/cedit-theme");
 	if (ofnode_valid(node)) {
@@ -85,10 +128,12 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 #ifdef CONFIG_SYS_LONGHELP
 static char cedit_help_text[] =
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
+	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
 
 U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
+	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index d34a220797ee..0581594831fa 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -10,6 +10,7 @@ Synopis
 
     cedit load <interface> <dev[:part]> <filename>
     cedit run
+    cedit write_fdt <dev[:part]> <filename>
 
 Description
 -----------
@@ -38,6 +39,12 @@ Runs the default configuration-editor event loop. This is very simple, just
 accepting character input and moving through the objects under user control.
 The implementation is at `cedit_run()`.
 
+cedit write_fdt
+~~~~~~~~~~~~~~~
+
+Writes the current user settings to a devicetree file. For each menu item the
+selected ID and its text string are written.
+
 
 Example
 -------
@@ -46,3 +53,15 @@ Example
 
     => cedit load hostfs - fred.dtb
     => cedit run
+    => cedit write_fdt hostfs - settings.dtb
+
+That results in::
+
+    / {
+        cedit-values {
+            cpu-speed = <0x00000006>;
+            cpu-speed-str = "2 GHz";
+            power-loss = <0x0000000a>;
+            power-loss-str = "Always Off";
+        };
+    }
diff --git a/include/cedit.h b/include/cedit.h
index 851d8e83564a..6086e3020062 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -7,10 +7,21 @@
 #ifndef __CEDIT_H
 #define __CEDIT_H
 
+struct abuf;
 struct expo;
 struct scene;
 struct video_priv;
 
+enum {
+	/* size increment for writing FDT */
+	CEDIT_SIZE_INC	= 1024,
+};
+
+/* Name of the cedit node in the devicetree */
+#define CEDIT_NODE_NAME		"cedit-values"
+
+extern struct expo *cur_exp;
+
 /**
  * cedit_arange() - Arrange objects in a configuration-editor scene
  *
@@ -45,4 +56,15 @@ int cedit_run(struct expo *exp);
 int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 		  struct scene **scnp);
 
+/**
+ * cedit_write_settings() - Write settings in FDT format
+ *
+ * Sets up an FDT with the settings
+ *
+ * @exp: Expo to write settings from
+ * @buf: Returns abuf containing the settings FDT (inited by this function)
+ * Return: 0 if OK, -ve on error
+ */
+int cedit_write_settings(struct expo *exp, struct abuf *buf);
+
 #endif /* __CEDIT_H */
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index f3411f734fa2..1dd78c64158d 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -7,6 +7,8 @@
 #include <common.h>
 #include <cedit.h>
 #include <expo.h>
+#include <mapmem.h>
+#include <dm/ofnode.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 #include <test/cedit-test.h>
@@ -51,3 +53,46 @@ static int cedit_base(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(cedit_base, 0);
+
+/* Check the cedit write_fdt commands */
+static int cedit_fdt(struct unit_test_state *uts)
+{
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	ulong addr = 0x1000;
+	struct ofprop prop;
+	struct scene *scn;
+	oftree tree;
+	ofnode node;
+	void *fdt;
+	int i;
+
+	console_record_reset_enable();
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+
+	ut_assertok(run_command("cedit write_fdt hostfs - settings.dtb", 0));
+	ut_assertok(run_commandf("load hostfs - %lx settings.dtb", addr));
+	ut_assert_nextlinen("1024 bytes read");
+
+	fdt = map_sysmem(addr, 1024);
+	tree = oftree_from_fdt(fdt);
+	node = ofnode_find_subnode(oftree_root(tree), CEDIT_NODE_NAME);
+
+	ut_asserteq(ID_CPU_SPEED_1,
+		    ofnode_read_u32_default(node, "cpu-speed", 0));
+	ut_asserteq_str("2 GHz", ofnode_read_string(node, "cpu-speed-str"));
+	ut_assert(ofnode_valid(node));
+
+	/* There should only be 4 properties */
+	for (i = 0, ofnode_first_property(node, &prop); ofprop_valid(&prop);
+	     i++, ofnode_next_property(&prop))
+		;
+	ut_asserteq(4, i);
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_fdt, 0);
-- 
2.41.0.694.ge786442a9b-goog

