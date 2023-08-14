Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE2C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393ED869A2;
	Tue, 15 Aug 2023 00:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TCZ2jGsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AFE869F7; Tue, 15 Aug 2023 00:41:33 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787A3869A2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-791b2b3401aso126763739f.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052890; x=1692657690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUNN5Jori5KSVWy5ZhH5++qd41mt51aZ2T39JOwnVv8=;
 b=TCZ2jGsvBC1H9WB/roZTuwXlsEcRYjn8MDzl4gfKwx13cs+0M9qAaMhED7Yu7y9y5G
 K+mi0MMGUnILA1uv6ssR1N+Io6hMtoAgpUmctNmiezeTorS32HRlrcCbwMMiXxgj+WAE
 v0qFCf/gu6uRBZ9EGNgL7dOVJCShjvY6ek+gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052890; x=1692657690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUNN5Jori5KSVWy5ZhH5++qd41mt51aZ2T39JOwnVv8=;
 b=JNmCfp+i+MoUaQyRlvjP9KBCsgaGhKRShvSxzq1Mno21P7nxBgtke1y2/qdlyI2UMU
 kdBgfXST7IzPIbQX5TdQHBBoRkriDxvy0XxkYNXQxVyAVigiUUbMwg18viAZOqRAeq9n
 GSLzQTBIenZZ1nDq8urPIBqrHK2CfZlKKFih0sINB7JLBTL+3IuRUYdgoSiJRo66tuH2
 TFh0dAcdnRhkiSelq4bvxCpNG4SaUXmqmBh4D9/PJ/9io+l67GBOc/BInkCsPWO9NY9e
 H8DxaPZbYGvcoeisclnO/hIlEIarnNecPilnInLcMzr+BwW1YZUdadlG4j/+DPJTHb1v
 ZzqQ==
X-Gm-Message-State: AOJu0YyDEqDrQraZHEfFje69kteYf1jEUporiVT/4Rt9quhcK0dm6rdl
 heg3Rgtw5VTb/kVoPflFujVimVELEBEtqYqRCBI=
X-Google-Smtp-Source: AGHT+IFfPnrB3Dm6Da2VmKlae5OcibsHg0TbQx91tXhQWaIOETpU4JsMBrl76BH+adqOIPMfRAahfA==
X-Received: by 2002:a05:6e02:1d9e:b0:348:797d:441a with SMTP id
 h30-20020a056e021d9e00b00348797d441amr19296597ila.8.1692052890010; 
 Mon, 14 Aug 2023 15:41:30 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 17/19] expo: cedit: Support writing settings to CMOS RAM
Date: Mon, 14 Aug 2023 16:40:37 -0600
Message-ID: <20230814224047.535491-18-sjg@chromium.org>
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

Add a command to write cedit settings to CMOS RAM so that it can be
preserved across a reboot. This uses a simple bit-encoding, where each
field has a 'bit position' and a 'bit length' in the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c                    | 137 +++++++++++++++++++++++++++++++-
 boot/expo_build.c               |   7 +-
 cmd/cedit.c                     |  36 +++++++++
 doc/develop/expo.rst            |  13 +++
 doc/usage/cmd/cedit.rst         |  22 +++++
 include/cedit.h                 |  13 +++
 include/expo.h                  |   6 +-
 test/boot/cedit.c               |  30 +++++++
 test/boot/files/expo_layout.dts |   5 ++
 9 files changed, 266 insertions(+), 3 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index e3f6dc003991..725745aba55d 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -15,22 +15,37 @@
 #include <dm.h>
 #include <env.h>
 #include <expo.h>
+#include <malloc.h>
 #include <menu.h>
+#include <rtc.h>
 #include <video.h>
 #include <linux/delay.h>
 #include "scene_internal.h"
 
+enum {
+	CMOS_MAX_BITS	= 2048,
+	CMOS_MAX_BYTES	= CMOS_MAX_BITS / 8,
+};
+
+#define CMOS_BYTE(bit)	((bit) / 8)
+#define CMOS_BIT(bit)	((bit) % 8)
+
 /**
  * struct cedit_iter_priv - private data for cedit operations
  *
  * @buf: Buffer to use when writing settings to the devicetree
  * @node: Node to read from when reading settings from devicetree
  * @verbose: true to show writing to environment variables
+ * @mask: Mask bits for the CMOS RAM. If a bit is set the byte containing it
+ * will be written
+ * @value: Value bits for CMOS RAM. This is the actual value written
  */
 struct cedit_iter_priv {
 	struct abuf *buf;
 	ofnode node;
 	bool verbose;
+	u8 *mask;
+	u8 *value;
 };
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
@@ -445,7 +460,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	struct cedit_iter_priv *priv = vpriv;
 	struct scene_obj_menu *menu;
 	char var[60];
-	int val, ret;
+	int val;
 
 	if (obj->type != SCENEOBJT_MENU)
 		return 0;
@@ -484,3 +499,123 @@ int cedit_read_settings_env(struct expo *exp, bool verbose)
 
 	return 0;
 }
+
+/**
+ * get_cur_menuitem_seq() - Get the sequence number of a menu's current item
+ *
+ * Enumerates the items of a menu (0, 1, 2) and returns the sequence number of
+ * the currently selected item. If the first item is selected, this returns 0;
+ * if the second, 1; etc.
+ *
+ * @menu: Menu to check
+ * Return: Sequence number on success, else -ve error value
+ */
+static int get_cur_menuitem_seq(const struct scene_obj_menu *menu)
+{
+	const struct scene_menitem *mi;
+	int seq, found;
+
+	seq = 0;
+	found = -1;
+	list_for_each_entry(mi, &menu->item_head, sibling) {
+		if (mi->id == menu->cur_item_id) {
+			found = seq;
+			break;
+		}
+		seq++;
+	}
+
+	if (found == -1)
+		return log_msg_ret("nf", -ENOENT);
+
+	return found;
+}
+
+static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
+{
+	const struct scene_obj_menu *menu;
+	struct cedit_iter_priv *priv = vpriv;
+	int val, ret;
+	uint i, seq;
+
+	if (obj->type != SCENEOBJT_MENU)
+		return 0;
+
+	menu = (struct scene_obj_menu *)obj;
+	val = menu->cur_item_id;
+
+	ret = get_cur_menuitem_seq(menu);
+	if (ret < 0)
+		return log_msg_ret("cur", ret);
+	seq = ret;
+	log_debug("%s: seq=%d\n", menu->obj.name, seq);
+
+	/* figure out where to place this item */
+	if (!obj->bit_length)
+		return log_msg_ret("len", -EINVAL);
+	if (obj->start_bit + obj->bit_length > CMOS_MAX_BITS)
+		return log_msg_ret("bit", -E2BIG);
+
+	for (i = 0; i < obj->bit_length; i++, seq >>= 1) {
+		uint bitnum = obj->start_bit + i;
+
+		priv->mask[CMOS_BYTE(bitnum)] |= 1 << CMOS_BIT(bitnum);
+		if (seq & 1)
+			priv->value[CMOS_BYTE(bitnum)] |= BIT(CMOS_BIT(bitnum));
+		log_debug("bit %x %x %x\n", bitnum,
+			  priv->mask[CMOS_BYTE(bitnum)],
+			  priv->value[CMOS_BYTE(bitnum)]);
+	}
+
+	return 0;
+}
+
+int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
+			      bool verbose)
+{
+	struct cedit_iter_priv priv;
+	int ret, i, count, first, last;
+
+	/* write out the items */
+	priv.mask = calloc(1, CMOS_MAX_BYTES);
+	if (!priv.mask)
+		return log_msg_ret("mas", -ENOMEM);
+	priv.value = calloc(1, CMOS_MAX_BYTES);
+	if (!priv.value) {
+		free(priv.mask);
+		return log_msg_ret("val", -ENOMEM);
+	}
+
+	ret = expo_iter_scene_objs(exp, h_write_settings_cmos, &priv);
+	if (ret) {
+		log_debug("Failed to write CMOS (err=%d)\n", ret);
+		ret = log_msg_ret("set", ret);
+		goto done;
+	}
+
+	/* write the data to the RTC */
+	first = CMOS_MAX_BYTES;
+	last = -1;
+	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
+		if (priv.mask[i]) {
+			log_debug("Write byte %x: %x\n", i, priv.value[i]);
+			ret = rtc_write8(dev, i, priv.value[i]);
+			if (ret) {
+				ret = log_msg_ret("wri", ret);
+				goto done;
+			}
+			count++;
+			first = min(first, i);
+			last = max(last, i);
+		}
+	}
+	if (verbose) {
+		printf("Write %d bytes from offset %x to %x\n", count, first,
+		       last);
+	}
+
+done:
+	free(priv.mask);
+	free(priv.value);
+	return ret;
+}
diff --git a/boot/expo_build.c b/boot/expo_build.c
index e8c4a40d3f09..bb33cc2a33f4 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -294,7 +294,7 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 {
 	struct scene_obj *obj;
 	const char *type;
-	u32 id;
+	u32 id, val;
 	int ret;
 
 	log_debug("- object %s\n", ofnode_get_name(node));
@@ -313,6 +313,11 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 	if (ret)
 		return log_msg_ret("bld", ret);
 
+	if (!ofnode_read_u32(node, "start-bit", &val))
+		obj->start_bit = val;
+	if (!ofnode_read_u32(node, "bit-length", &val))
+		obj->bit_length = val;
+
 	return 0;
 }
 
diff --git a/cmd/cedit.c b/cmd/cedit.c
index b2548f44b572..95d5c22c2f75 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -10,6 +10,7 @@
 #include <abuf.h>
 #include <cedit.h>
 #include <command.h>
+#include <dm.h>
 #include <expo.h>
 #include <fs.h>
 #include <malloc.h>
@@ -176,6 +177,39 @@ static int do_cedit_read_env(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_write_cmos(struct cmd_tbl *cmdtp, int flag, int argc,
+			       char *const argv[])
+{
+	struct udevice *dev;
+	bool verbose = false;
+	int ret;
+
+	if (check_cur_expo())
+		return CMD_RET_FAILURE;
+
+	if (argc > 1 && !strcmp(argv[1], "-v")) {
+		verbose = true;
+		argc--;
+		argv++;
+	}
+
+	if (argc > 1)
+		ret = uclass_get_device_by_name(UCLASS_RTC, argv[1], &dev);
+	else
+		ret = uclass_first_device_err(UCLASS_RTC, &dev);
+	if (ret) {
+		printf("Failed to get RTC device: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (cedit_write_settings_cmos(cur_exp, dev, verbose)) {
+		printf("Failed to write settings to CMOS\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -209,6 +243,7 @@ static char cedit_help_text[] =
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
 	"cedit read_env [-v]                              - read settings from env vars\n"
 	"cedit write_env [-v]                             - write settings to env vars\n"
+	"cedit write_cmos [-v] [dev]                      - write settings to CMOS RAM\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
 
@@ -218,5 +253,6 @@ U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
 	U_BOOT_SUBCMD_MKENT(read_env, 2, 1, do_cedit_read_env),
 	U_BOOT_SUBCMD_MKENT(write_env, 2, 1, do_cedit_write_env),
+	U_BOOT_SUBCMD_MKENT(write_cmos, 2, 1, do_cedit_write_cmos),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index fde91494799e..61b6855c72f4 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -317,6 +317,18 @@ id
 
     Specifies the ID of the object. This is used when referring to the object.
 
+Where CMOS RAM is used for reading and writing settings, the following
+additional properties are required:
+
+start-bit
+    Specifies the first bit in the CMOS RAM to use for this setting. For a RAM
+    with 0x100 bytes, there are 0x800 bit locations. For example, register 0x80
+    holds bits 0x400 to 0x407.
+
+bit-length
+    Specifies the number of CMOS RAM bits to use for this setting. The bits
+    extend from `start-bit` to `start-bit + bit-length - 1`. Note that the bits
+    must be contiguous.
 
 Menu nodes have the following additional properties:
 
@@ -474,6 +486,7 @@ Some ideas for future work:
 - Support curses for proper serial-terminal menus
 - Add support for large menus which need to scroll
 - Add support for reading and writing configuration settings with cedit
+- Update expo.py tool to check for overlapping names and CMOS locations
 
 .. Simon Glass <sjg@chromium.org>
 .. 7-Oct-22
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 1f92b7306a7a..3d6f26e631d6 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -14,6 +14,7 @@ Synopis
     cedit read_fdt <dev[:part]> <filename>
     cedit write_env [-v]
     cedit read_env [-v]
+    cedit write_cmos [-v] [dev]
 
 Description
 -----------
@@ -76,6 +77,18 @@ ID and its text string are written, similar to:
 The `-v` flag enables verbose mode, where each variable is printed before it is
 set.
 
+cedit write_cmos
+~~~~~~~~~~~~~~~~
+
+Writes the settings to locations in the CMOS RAM. The locations used are
+specified by the schema. See `expo_format_`.
+
+The `-v` flag enables verbose mode, which shows which CMOS locations were
+updated.
+
+Normally the first RTC device is used to hold the data. You can specify a
+different device by name using the `dev` parameter.
+
 
 Example
 -------
@@ -117,3 +130,12 @@ This shows settings being stored in the environment::
     => cedit read_env -v
     c.cpu-speed=7
     c.power-loss=12
+
+This shows writing to CMOS RAM. Notice that the bytes at 80 and 84 change::
+
+    => rtc read 80 8
+    00000080: 00 00 00 00 00 2f 2a 08                          ...../*.
+    =>  cedit write_cmos
+    Write 2 bytes from offset 80 to 84
+    => rtc read 80 8
+    00000080: 01 00 00 00 08 2f 2a 08                          ...../*.
diff --git a/include/cedit.h b/include/cedit.h
index fe10e6c829cd..2970965b5f67 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -97,4 +97,17 @@ int cedit_write_settings_env(struct expo *exp, bool verbose);
  */
 int cedit_read_settings_env(struct expo *exp, bool verbose);
 
+/**
+ * cedit_write_settings_cmos() - Write settings to CMOS RAM
+ *
+ * Write settings to the defined places in CMOS RAM
+ *
+ * @exp: Expo to write settings from
+ * @dev: UCLASS_RTC device containing space for this information
+ * Returns 0 if OK, -ve on error
+ * @verbose: true to print a summary at the end
+ */
+int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
+			      bool verbose);
+
 #endif /* __CEDIT_H */
diff --git a/include/expo.h b/include/expo.h
index da151074d207..a2b3a71c1591 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -187,6 +187,8 @@ enum scene_obj_flags_t {
  * @type: Type of this object
  * @dim: Dimensions for this object
  * @flags: Flags for this object
+ * @bit_length: Number of bits used for this object in CMOS RAM
+ * @start_bit: Start bit to use for this object in CMOS RAM
  * @sibling: Node to link this object to its siblings
  */
 struct scene_obj {
@@ -195,7 +197,9 @@ struct scene_obj {
 	uint id;
 	enum scene_obj_t type;
 	struct scene_dim dim;
-	int flags;
+	u8 flags;
+	u8 bit_length;
+	u16 start_bit;
 	struct list_head sibling;
 };
 
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 7cf0c3e4e930..010aae615b97 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -155,3 +155,33 @@ static int cedit_env(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(cedit_env, 0);
+
+/* Check the cedit write_cmos and read_cmos commands */
+static int cedit_cmos(struct unit_test_state *uts)
+{
+	struct scene_obj_menu *menu, *menu2;
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	struct scene *scn;
+
+	console_record_reset_enable();
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+
+	/* get the menus to fiddle with */
+	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	menu->cur_item_id = ID_CPU_SPEED_2;
+
+	menu2 = scene_obj_find(scn, ID_POWER_LOSS, SCENEOBJT_MENU);
+	ut_assertnonnull(menu2);
+	menu2->cur_item_id = ID_AC_MEMORY;
+
+	ut_assertok(run_command("cedit write_cmos -v", 0));
+	ut_assert_nextlinen("Write 2 bytes from offset 80 to 84");
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_cmos, 0);
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index 913140bace98..cb2a674d9d56 100644
--- a/test/boot/files/expo_layout.dts
+++ b/test/boot/files/expo_layout.dts
@@ -38,6 +38,9 @@
 				/* IDs for the menu items */
 				item-id = <ID_CPU_SPEED_1 ID_CPU_SPEED_2
 					ID_CPU_SPEED_3>;
+
+				start-bit = <0x400>;
+				bit-length = <2>;
 			};
 
 			power-loss {
@@ -49,6 +52,8 @@
 					"Memory";
 
 				item-id = <ID_AC_OFF ID_AC_ON ID_AC_MEMORY>;
+				start-bit = <0x422>;
+				bit-length = <2>;
 			};
 		};
 	};
-- 
2.41.0.694.ge786442a9b-goog

