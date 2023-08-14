Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD9C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C56F8666B;
	Tue, 15 Aug 2023 00:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FI8Lmrs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16011869A2; Tue, 15 Aug 2023 00:41:31 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE2D869A3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7918997ad9fso93982339f.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052887; x=1692657687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLOgHQPepZqgIuq9/STiNFaqZhpvKwM2IMBDzNgsuMo=;
 b=FI8Lmrs03DTSk3eZnkR4APRYW+2m2OijUSs4U/7pxMEO7hRCbeUjdhIsnFv4I7ebIU
 Hnd4cZVONWiAQUhMUxlKumj4g1IsiDtFQr/dQbajgDf9vSKTSuO3MjOt41Aq7cblNb75
 0lR+2EME46nazn0K6Zpjs/kcbi4zVbbkZGtXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052887; x=1692657687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLOgHQPepZqgIuq9/STiNFaqZhpvKwM2IMBDzNgsuMo=;
 b=hmA7PxDWiV+1CySSX92iaMe8c+glgG7qPzebNWX1jLIVSGtnllqVIaUUvxH9NmWvLL
 wp+6YTuPdCo9MkapAH3i8VXnRcHEEtfNmjzNpkmpQ2/boSxM6xjE3lZ+1g48Bzf34a8O
 ccD1GcQ7YuiYRlakGYsE4ug/D1lGonr4ekb3bKaUbGYsOum1lGQ9lzs46nLDQhM7FGiA
 5wH/Xm5yIK8K0t3WRRtFTycFV2Aq9vnP4DMliPn8yPvzFyilNOUo2R8nDFFz+OacjDdK
 HlNcn64mqlxz41bLaxs3YvVXHZ1RHp8+1Vaz5RU8CHEWMfMKz7RHLsq1P5h0stwHaD3H
 jw1w==
X-Gm-Message-State: AOJu0Yx7WtBYv5GBtQECB3EiDM8p1RDF5kqU4AtcE8wS2KQhbEjd/UdW
 SVDgPVI2BwkUusEQH3B+aKzidqeVfzzyj8o3Zew=
X-Google-Smtp-Source: AGHT+IEXDExu4I60UhFu9pXn4O8Yg3DfDlQfydedIaTydYERtzGs8sh98VdxyRHFO08MgyJP0+TMSg==
X-Received: by 2002:a05:6e02:1c08:b0:349:4c1b:c04d with SMTP id
 l8-20020a056e021c0800b003494c1bc04dmr392905ilh.5.1692052887412; 
 Mon, 14 Aug 2023 15:41:27 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 14/19] expo: cedit: Support reading settings from a file
Date: Mon, 14 Aug 2023 16:40:34 -0600
Message-ID: <20230814224047.535491-15-sjg@chromium.org>
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

Add a command to read cedit settings from a devicetree file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c            | 52 +++++++++++++++++++++++++++++++++++++++++
 cmd/cedit.c             | 39 +++++++++++++++++++++++++++++++
 doc/usage/cmd/cedit.rst |  8 +++++++
 include/cedit.h         | 13 +++++++++++
 test/boot/cedit.c       | 22 ++++++++++++++---
 5 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 4dd79a2263d6..6a74a3809898 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -23,9 +23,11 @@
  * struct cedit_iter_priv - private data for cedit operations
  *
  * @buf: Buffer to use when writing settings to the devicetree
+ * @node: Node to read from when reading settings from devicetree
  */
 struct cedit_iter_priv {
 	struct abuf *buf;
+	ofnode node;
 };
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
@@ -318,3 +320,53 @@ int cedit_write_settings(struct expo *exp, struct abuf *buf)
 
 	return 0;
 }
+
+static int h_read_settings(struct scene_obj *obj, void *vpriv)
+{
+	struct cedit_iter_priv *priv = vpriv;
+	ofnode node = priv->node;
+
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_TEXT:
+		break;
+	case SCENEOBJT_MENU: {
+		struct scene_obj_menu *menu;
+		uint val;
+
+		if (ofnode_read_u32(node, obj->name, &val))
+			return log_msg_ret("rd", -ENOENT);
+		menu = (struct scene_obj_menu *)obj;
+		menu->cur_item_id = val;
+
+		break;
+	}
+	}
+
+	return 0;
+}
+
+int cedit_read_settings(struct expo *exp, oftree tree)
+{
+	struct cedit_iter_priv priv;
+	ofnode root, node;
+	int ret;
+
+	root = oftree_root(tree);
+	if (!ofnode_valid(root))
+		return log_msg_ret("roo", -ENOENT);
+	node = ofnode_find_subnode(root, CEDIT_NODE_NAME);
+	if (!ofnode_valid(node))
+		return log_msg_ret("pat", -ENOENT);
+
+	/* read in the items */
+	priv.node = node;
+	ret = expo_iter_scene_objs(exp, h_read_settings, &priv);
+	if (ret) {
+		log_debug("Failed to read settings (err=%d)\n", ret);
+		return log_msg_ret("set", ret);
+	}
+
+	return 0;
+}
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 18cc8ba191bf..a155e080b1f2 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -99,6 +99,43 @@ static int do_cedit_write_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_read_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	const char *fname;
+	void *buf;
+	oftree tree;
+	ulong size;
+	int ret;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+	fname = argv[3];
+
+	ret = fs_load_alloc(argv[1], argv[2], argv[3], SZ_1M, 0, &buf, &size);
+	if (ret) {
+		printf("File not found\n");
+		return CMD_RET_FAILURE;
+	}
+
+	tree = oftree_from_fdt(buf);
+	if (!oftree_valid(tree)) {
+		free(buf);
+		printf("Cannot create oftree\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = cedit_read_settings(cur_exp, tree);
+	oftree_dispose(tree);
+	free(buf);
+	if (ret) {
+		printf("Failed to read settings: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -128,12 +165,14 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 #ifdef CONFIG_SYS_LONGHELP
 static char cedit_help_text[] =
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
+	"cedit read_fdt <i/f> <dev[:part]> <filename>     - read settings\n"
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
 
 U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
+	U_BOOT_SUBCMD_MKENT(read_fdt, 5, 1, do_cedit_read_fdt),
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 0581594831fa..0a9f620b59b3 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -11,6 +11,7 @@ Synopis
     cedit load <interface> <dev[:part]> <filename>
     cedit run
     cedit write_fdt <dev[:part]> <filename>
+    cedit read_fdt <dev[:part]> <filename>
 
 Description
 -----------
@@ -45,6 +46,11 @@ cedit write_fdt
 Writes the current user settings to a devicetree file. For each menu item the
 selected ID and its text string are written.
 
+cedit read_fdt
+~~~~~~~~~~~~~~
+
+Reads the user settings from a devicetree file and updates the cedit with those
+settings.
 
 Example
 -------
@@ -65,3 +71,5 @@ That results in::
             power-loss-str = "Always Off";
         };
     }
+
+    => cedit read_fdt hostfs - settings.dtb
diff --git a/include/cedit.h b/include/cedit.h
index 6086e3020062..bb6e87d4af77 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -7,6 +7,8 @@
 #ifndef __CEDIT_H
 #define __CEDIT_H
 
+#include <dm/ofnode_decl.h>
+
 struct abuf;
 struct expo;
 struct scene;
@@ -67,4 +69,15 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
  */
 int cedit_write_settings(struct expo *exp, struct abuf *buf);
 
+/**
+ * cedit_read_settings() - Read settings in FDT format
+ *
+ * Read an FDT with the settings
+ *
+ * @exp: Expo to read settings into
+ * @tree: Tree to read from
+ * Return: 0 if OK, -ve on error
+ */
+int cedit_read_settings(struct expo *exp, oftree tree);
+
 #endif /* __CEDIT_H */
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 1dd78c64158d..659c47ed35fb 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -54,11 +54,12 @@ static int cedit_base(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(cedit_base, 0);
 
-/* Check the cedit write_fdt commands */
+/* Check the cedit write_fdt and read_fdt commands */
 static int cedit_fdt(struct unit_test_state *uts)
 {
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
+	struct scene_obj_menu *menu;
 	ulong addr = 0x1000;
 	struct ofprop prop;
 	struct scene *scn;
@@ -72,6 +73,11 @@ static int cedit_fdt(struct unit_test_state *uts)
 
 	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
 
+	/* get a menu to fiddle with */
+	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	menu->cur_item_id = ID_CPU_SPEED_2;
+
 	ut_assertok(run_command("cedit write_fdt hostfs - settings.dtb", 0));
 	ut_assertok(run_commandf("load hostfs - %lx settings.dtb", addr));
 	ut_assert_nextlinen("1024 bytes read");
@@ -80,9 +86,9 @@ static int cedit_fdt(struct unit_test_state *uts)
 	tree = oftree_from_fdt(fdt);
 	node = ofnode_find_subnode(oftree_root(tree), CEDIT_NODE_NAME);
 
-	ut_asserteq(ID_CPU_SPEED_1,
+	ut_asserteq(ID_CPU_SPEED_2,
 		    ofnode_read_u32_default(node, "cpu-speed", 0));
-	ut_asserteq_str("2 GHz", ofnode_read_string(node, "cpu-speed-str"));
+	ut_asserteq_str("2.5 GHz", ofnode_read_string(node, "cpu-speed-str"));
 	ut_assert(ofnode_valid(node));
 
 	/* There should only be 4 properties */
@@ -93,6 +99,16 @@ static int cedit_fdt(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	/* reset the expo */
+	menu->cur_item_id = ID_CPU_SPEED_1;
+
+	/* load in the settings and make sure they update */
+	ut_assertok(run_command("cedit read_fdt hostfs - settings.dtb", 0));
+	ut_asserteq(ID_CPU_SPEED_2, menu->cur_item_id);
+
+	ut_assertnonnull(menu);
+	ut_assert_console_end();
+
 	return 0;
 }
 BOOTSTD_TEST(cedit_fdt, 0);
-- 
2.41.0.694.ge786442a9b-goog

