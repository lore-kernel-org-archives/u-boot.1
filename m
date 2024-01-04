Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCBFC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F96187A39;
	Thu,  4 Jan 2024 16:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCOmlf93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1175879E3; Thu,  4 Jan 2024 16:12:54 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E200687A07
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35fc6eb9075so1714505ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381134; x=1704985934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzBZR0N98bjD9X/QBDaoKVmc3EZh4P74Ndhqj2sjVEA=;
 b=JCOmlf93obHmDRHTHXhppu94bgzTOpJjYartRoYHHzpLDFGi3RAcB4QvWkJHsCZ11+
 nHQ7DIrSmEZtcmhV7qSN/vtv5Js9VkO6KX0aYYXg/tagFKJRTe4ytbuc0VHSUxuUAaEh
 s7IXTBIxzirdLp2VVUi9A7TRx/XfAN0bWkqTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381134; x=1704985934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzBZR0N98bjD9X/QBDaoKVmc3EZh4P74Ndhqj2sjVEA=;
 b=u9B2mJVkk+tts927zzcCpXsD5JGprMM4tZ3f07/ThldUJDkmDKkP1poBsf/2jMMAC4
 v5f/qd8NN/EvlDqKMoCCasVWG3iqYFLQM1wTcv5LRQjDMOs+Sf2wF2tO3xnuyLy+7TiM
 kmPOfq2cbHYi7D4CWU+SSyVp17+S9YZDrCaSzbRL7x+xNw4Q1j/HZoCYGbVFY8mJYik7
 Pt/LKB2GrmeGVabrhEt726umQX0YJevl2IH8qPcOG36iF2Q52qb0ADcCEChR97tO/wXD
 Xf0+g77UU944SUcFQKp24Sa7Th5f6v/LEoyovYktb1CWaf3mGFB+JcfEhejO7JgJ6Wgb
 MBJQ==
X-Gm-Message-State: AOJu0Yw1WbE4WMFEDqB3H1Re8p/5IOCsm7bbgctQWwH9vYy7jH3SaUsn
 r9qAjmQE8lmwDPfEMSBtwYLRSg/ypSeataUJ4iq52nZCMHSK
X-Google-Smtp-Source: AGHT+IGj6YBzQDU/yG4FuRZhcdnRWLdmFr5yQmVMbFmQT1P+evhF9i+y2y+wqnT7MlOFd+EudOI6Bg==
X-Received: by 2002:a92:c54b:0:b0:360:35f:55e1 with SMTP id
 a11-20020a92c54b000000b00360035f55e1mr420603ilj.31.1704381134256; 
 Thu, 04 Jan 2024 07:12:14 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 18/19] x86: coreboot: Allow building an expo for editing
 CMOS config
Date: Thu,  4 Jan 2024 08:11:51 -0700
Message-Id: <20240104151152.697855-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

Coreboot provides the CMOS layout in the tables it passes to U-Boot.
Use that to build an editor for the CMOS settings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Avoid using common.h

 boot/Makefile                   |   4 +
 boot/expo_build_cb.c            | 245 ++++++++++++++++++++++++++++++++
 cmd/cedit.c                     |  28 ++++
 doc/board/coreboot/coreboot.rst |   6 +
 doc/develop/cedit.rst           |   2 +-
 doc/usage/cmd/cbcmos.rst        |   3 +
 doc/usage/cmd/cedit.rst         |  76 ++++++++++
 include/cedit.h                 |   1 +
 include/expo.h                  |   8 ++
 test/cmd/coreboot.c             |  34 +++++
 10 files changed, 406 insertions(+), 1 deletion(-)
 create mode 100644 boot/expo_build_cb.c

diff --git a/boot/Makefile b/boot/Makefile
index a90ebea5a86..5808023b380 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -61,6 +61,10 @@ endif
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
 
+ifdef CONFIG_COREBOOT_SYSINFO
+obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo_build_cb.o
+endif
+
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE) += vbe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_REQUEST) += vbe_request.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o
diff --git a/boot/expo_build_cb.c b/boot/expo_build_cb.c
new file mode 100644
index 00000000000..442ad760e79
--- /dev/null
+++ b/boot/expo_build_cb.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Building an expo from an FDT description
+ *
+ * Copyright 2022 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	LOGC_EXPO
+
+#include <cedit.h>
+#include <ctype.h>
+#include <errno.h>
+#include <expo.h>
+#include <log.h>
+#include <malloc.h>
+#include <vsprintf.h>
+#include <asm/cb_sysinfo.h>
+
+/**
+ * struct build_info - Information to use when building
+ */
+struct build_info {
+	const struct cb_cmos_option_table *tab;
+	struct cedit_priv *priv;
+};
+
+/**
+ * convert_to_title() - Convert text to 'title' format and allocate a string
+ *
+ * Converts "this_is_a_test" to "This is a test" so it looks better
+ *
+ * @text: Text to convert
+ * Return: Allocated string, or NULL if out of memory
+ */
+static char *convert_to_title(const char *text)
+{
+	int len = strlen(text);
+	char *buf, *s;
+
+	buf = malloc(len + 1);
+	if (!buf)
+		return NULL;
+
+	for (s = buf; *text; s++, text++) {
+		if (s == buf)
+			*s = toupper(*text);
+		else if (*text == '_')
+			*s = ' ';
+		else
+			*s = *text;
+	}
+	*s = '\0';
+
+	return buf;
+}
+
+/**
+ * menu_build() - Build a menu and add it to a scene
+ *
+ * See doc/developer/expo.rst for a description of the format
+ *
+ * @info: Build information
+ * @entry: CMOS entry to build a menu for
+ * @scn: Scene to add the menu to
+ * @objp: Returns the object pointer
+ * Returns: 0 if OK, -ENOMEM if out of memory, -EINVAL if there is a format
+ * error, -ENOENT if there is a references to a non-existent string
+ */
+static int menu_build(struct build_info *info,
+		      const struct cb_cmos_entries *entry, struct scene *scn,
+		      struct scene_obj **objp)
+{
+	struct scene_obj_menu *menu;
+	const void *ptr, *end;
+	uint menu_id;
+	char *title;
+	int ret, i;
+
+	ret = scene_menu(scn, entry->name, 0, &menu);
+	if (ret < 0)
+		return log_msg_ret("men", ret);
+	menu_id = ret;
+
+	title = convert_to_title(entry->name);
+	if (!title)
+		return log_msg_ret("con", -ENOMEM);
+
+	/* Set the title */
+	ret = scene_txt_str(scn, "title", 0, 0, title, NULL);
+	if (ret < 0)
+		return log_msg_ret("tit", ret);
+	menu->title_id = ret;
+
+	end = (void *)info->tab + info->tab->size;
+	for (ptr = (void *)info->tab + info->tab->header_length, i = 0;
+	     ptr < end; i++) {
+		const struct cb_cmos_enums *enums = ptr;
+		struct scene_menitem *item;
+		uint label;
+
+		ptr += enums->size;
+		if (enums->tag != CB_TAG_OPTION_ENUM ||
+		    enums->config_id != entry->config_id)
+			continue;
+
+		ret = scene_txt_str(scn, enums->text, 0, 0, enums->text, NULL);
+		if (ret < 0)
+			return log_msg_ret("tit", ret);
+		label = ret;
+
+		ret = scene_menuitem(scn, menu_id, simple_xtoa(i), 0, 0, label,
+				     0, 0, 0, &item);
+		if (ret < 0)
+			return log_msg_ret("mi", ret);
+		item->value = enums->value;
+	}
+	*objp = &menu->obj;
+
+	return 0;
+}
+
+/**
+ * scene_build() - Build a scene and all its objects
+ *
+ * See doc/developer/expo.rst for a description of the format
+ *
+ * @info: Build information
+ * @scn: Scene to add the object to
+ * Returns: 0 if OK, -ENOMEM if out of memory, -EINVAL if there is a format
+ * error, -ENOENT if there is a references to a non-existent string
+ */
+static int scene_build(struct build_info *info, struct expo *exp)
+{
+	struct scene_obj_menu *menu;
+	const void *ptr, *end;
+	struct scene_obj *obj;
+	struct scene *scn;
+	uint label, menu_id;
+	int ret;
+
+	ret = scene_new(exp, "cmos", 0, &scn);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+
+	ret = scene_txt_str(scn, "title", 0, 0, "CMOS RAM settings", NULL);
+	if (ret < 0)
+		return log_msg_ret("add", ret);
+	scn->title_id = ret;
+
+	ret = scene_txt_str(scn, "prompt", 0, 0,
+			    "UP and DOWN to choose, ENTER to select", NULL);
+	if (ret < 0)
+		return log_msg_ret("add", ret);
+
+	end = (void *)info->tab + info->tab->size;
+	for (ptr = (void *)info->tab + info->tab->header_length; ptr < end;) {
+		const struct cb_cmos_entries *entry;
+		const struct cb_record *rec = ptr;
+
+		entry = ptr;
+		ptr += rec->size;
+		if (rec->tag != CB_TAG_OPTION)
+			continue;
+		switch (entry->config) {
+		case 'e':
+			ret = menu_build(info, entry, scn, &obj);
+			break;
+		default:
+			continue;
+		}
+		if (ret < 0)
+			return log_msg_ret("add", ret);
+
+		obj->start_bit = entry->bit;
+		obj->bit_length = entry->length;
+	}
+
+	ret = scene_menu(scn, "save", EXPOID_SAVE, &menu);
+	if (ret < 0)
+		return log_msg_ret("men", ret);
+	menu_id = ret;
+
+	ret = scene_txt_str(scn, "save", 0, 0, "Save and exit", NULL);
+	if (ret < 0)
+		return log_msg_ret("sav", ret);
+	label = ret;
+	ret = scene_menuitem(scn, menu_id, "save", 0, 0, label,
+			     0, 0, 0, NULL);
+	if (ret < 0)
+		return log_msg_ret("mi", ret);
+
+	ret = scene_menu(scn, "nosave", EXPOID_DISCARD, &menu);
+	if (ret < 0)
+		return log_msg_ret("men", ret);
+	menu_id = ret;
+
+	ret = scene_txt_str(scn, "nosave", 0, 0, "Exit without saving", NULL);
+	if (ret < 0)
+		return log_msg_ret("nos", ret);
+	label = ret;
+	ret = scene_menuitem(scn, menu_id, "exit", 0, 0, label,
+			     0, 0, 0, NULL);
+	if (ret < 0)
+		return log_msg_ret("mi", ret);
+
+	return 0;
+}
+
+static int build_it(struct build_info *info, struct expo **expp)
+{
+	struct expo *exp;
+	int ret;
+
+	ret = expo_new("coreboot", NULL, &exp);
+	if (ret)
+		return log_msg_ret("exp", ret);
+	expo_set_dynamic_start(exp, EXPOID_BASE_ID);
+
+	ret = scene_build(info, exp);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+
+	*expp = exp;
+
+	return 0;
+}
+
+int cb_expo_build(struct expo **expp)
+{
+	struct build_info info;
+	struct expo *exp;
+	int ret;
+
+	info.tab = lib_sysinfo.option_table;
+	if (!info.tab)
+		return log_msg_ret("tab", -ENOENT);
+
+	ret = build_it(&info, &exp);
+	if (ret)
+		return log_msg_ret("bui", ret);
+	*expp = exp;
+
+	return 0;
+}
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 6352e6369d1..1640693a106 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -68,6 +68,28 @@ static int do_cedit_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+#ifdef CONFIG_COREBOOT_SYSINFO
+static int do_cedit_cb_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	struct expo *exp;
+	int ret;
+
+	if (argc > 1)
+		return CMD_RET_USAGE;
+
+	ret = cb_expo_build(&exp);
+	if (ret) {
+		printf("Failed to build expo: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	cur_exp = exp;
+
+	return 0;
+}
+#endif /* CONFIG_COREBOOT_SYSINFO */
+
 static int do_cedit_write_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
 			      char *const argv[])
 {
@@ -272,6 +294,9 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_LONGHELP(cedit,
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
+#ifdef CONFIG_COREBOOT_SYSINFO
+	"cb_load                                          - load coreboot CMOS editor\n"
+#endif
 	"cedit read_fdt <i/f> <dev[:part]> <filename>     - read settings\n"
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
 	"cedit read_env [-v]                              - read settings from env vars\n"
@@ -282,6 +307,9 @@ U_BOOT_LONGHELP(cedit,
 
 U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
+#ifdef CONFIG_COREBOOT_SYSINFO
+	U_BOOT_SUBCMD_MKENT(cb_load, 5, 1, do_cedit_cb_load),
+#endif
 	U_BOOT_SUBCMD_MKENT(read_fdt, 5, 1, do_cedit_read_fdt),
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
 	U_BOOT_SUBCMD_MKENT(read_env, 2, 1, do_cedit_read_env),
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 10a251c2b64..f2c6452b5b9 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -195,3 +195,9 @@ To update the `coreboot.rom` file which is used:
 #. Upload the file to Google drive
 
 #. Send a patch to change the file ID used by wget in the CI yaml files.
+
+Editing CMOS RAM settings
+-------------------------
+
+U-Boot supports creating a configuration editor to edit coreboot CMOS-RAM
+settings. See :ref:`cedit_cb_load`.
diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 310be889240..1ac55ab1219 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -172,4 +172,4 @@ Cedit provides several options for persistent settings:
 
 For now, reading and writing settings is not automatic. See the
 :doc:`../usage/cmd/cedit` for how to do this on the command line or in a
-script.
+script. For x86 devices, see :ref:`cedit_cb_load`.
diff --git a/doc/usage/cmd/cbcmos.rst b/doc/usage/cmd/cbcmos.rst
index 156521dd02b..9395cf1cbd7 100644
--- a/doc/usage/cmd/cbcmos.rst
+++ b/doc/usage/cmd/cbcmos.rst
@@ -40,3 +40,6 @@ CMOS RAM::
     Checksum 6600 written
     => cbc check
     =>
+
+See also :ref:`cedit_cb_load` which shows an example that includes the
+configuration editor.
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 0f0cc26e74b..fbad0a9b147 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -15,6 +15,7 @@ Synopis
     cedit write_env [-v]
     cedit read_env [-v]
     cedit write_cmos [-v] [dev]
+    cedit cb_load
 
 Description
 -----------
@@ -89,6 +90,13 @@ updated.
 Normally the first RTC device is used to hold the data. You can specify a
 different device by name using the `dev` parameter.
 
+.. _cedit_cb_load:
+
+cedit cb_load
+~~~~~~~~~~~~~
+
+This is supported only on x86 devices booted from coreboot. It creates a new
+configuration editor which can be used to edit CMOS settings.
 
 Example
 -------
@@ -155,3 +163,71 @@ Here is an example with the device specified::
 
     => cedit write_cmos rtc@43
     =>
+
+This example shows editing coreboot CMOS-RAM settings. A script could be used
+to automate this::
+
+    => cbsysinfo
+    Coreboot table at 500, size 5c4, records 1d (dec 29), decoded to 000000007dce3f40, forwarded to 000000007ff9a000
+
+    CPU KHz     : 0
+    Serial I/O port: 00000000
+       base        : 00000000
+       pointer     : 000000007ff9a370
+       type        : 1
+       base        : 000003f8
+       baud        : 0d115200
+       regwidth    : 1
+       input_hz    : 0d1843200
+       PCI addr    : 00000010
+    Mem ranges  : 7
+              id: type               ||   base        ||   size
+               0: 10:table    0000000000000000 0000000000001000
+               1: 01:ram      0000000000001000 000000000009f000
+               2: 02:reserved 00000000000a0000 0000000000060000
+               3: 01:ram      0000000000100000 000000007fe6d000
+               4: 10:table    000000007ff6d000 0000000000093000
+               5: 02:reserved 00000000fec00000 0000000000001000
+               6: 02:reserved 00000000ff800000 0000000000800000
+    option_table: 000000007ff9a018
+     Bit  Len  Cfg  ID  Name
+       0  180    r   0  reserved_memory
+     180    1    e   4  boot_option            0:Fallback 1:Normal
+     184    4    h   0  reboot_counter
+     190    8    r   0  reserved_century
+     1b8    8    r   0  reserved_ibm_ps2_century
+     1c0    1    e   1  power_on_after_fail    0:Disable 1:Enable
+     1c4    4    e   6  debug_level            5:Notice 6:Info 7:Debug 8:Spew
+     1d0   80    r   0  vbnv
+     3f0   10    h   0  check_sum
+    CMOS start  : 1c0
+       CMOS end    : 1cf
+       CMOS csum loc: 3f0
+    VBNV start  : ffffffff
+    VBNV size   : ffffffff
+    ...
+    Unimpl.     : 10 37 40
+
+Check that the CMOS RAM checksum is correct, then create a configuration editor
+and load the settings from CMOS RAM::
+
+    => cbcmos check
+    => cedit cb
+    => cedit read_cmos
+
+Now run the cedit. In this case the user selected 'save' so `cedit run` returns
+success::
+
+    => if cedit run; then cedit write_cmos -v; fi
+    Write 2 bytes from offset 30 to 38
+    => echo $?
+    0
+
+Update the checksum in CMOS RAM::
+
+    => cbcmos check
+    Checksum 6100 error: calculated 7100
+    => cbcmos update
+    Checksum 7100 written
+    => cbcmos check
+    =>
diff --git a/include/cedit.h b/include/cedit.h
index f9a4a6d9e8e..5b1900b5082 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -8,6 +8,7 @@
 #define __CEDIT_H
 
 #include <dm/ofnode_decl.h>
+#include <linux/types.h>
 
 struct abuf;
 struct expo;
diff --git a/include/expo.h b/include/expo.h
index 8e834b50e4f..620447acdf1 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -762,4 +762,12 @@ int expo_apply_theme(struct expo *exp, ofnode node);
  */
 int expo_build(ofnode root, struct expo **expp);
 
+/**
+ * cb_expo_build() - Build an expo for coreboot CMOS RAM
+ *
+ * @expp: Returns the expo created
+ * Return: 0 if OK, -ve on error
+ */
+int cb_expo_build(struct expo **expp);
+
 #endif /*__EXPO_H */
diff --git a/test/cmd/coreboot.c b/test/cmd/coreboot.c
index b689035db9d..c34fcc49717 100644
--- a/test/cmd/coreboot.c
+++ b/test/cmd/coreboot.c
@@ -6,12 +6,16 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <cedit.h>
 #include <command.h>
 #include <dm.h>
+#include <expo.h>
 #include <rtc.h>
+#include <test/cedit-test.h>
 #include <test/cmd.h>
 #include <test/test.h>
 #include <test/ut.h>
+#include "../../boot/scene_internal.h"
 
 enum {
 	CSUM_LOC	= 0x3f0 / 8,
@@ -83,3 +87,33 @@ static int test_cmd_cbcmos(struct unit_test_state *uts)
 }
 CMD_TEST(test_cmd_cbcmos, UT_TESTF_CONSOLE_REC);
 
+/* test 'cedit cb_load' command */
+static int test_cmd_cedit_cb_load(struct unit_test_state *uts)
+{
+	struct scene_obj_menu *menu;
+	struct video_priv *vid_priv;
+	struct scene_obj_txt *txt;
+	struct scene *scn;
+	struct expo *exp;
+	int scn_id;
+
+	ut_assertok(run_command("cedit cb_load", 0));
+	ut_assertok(run_command("cedit read_cmos", 0));
+	ut_assert_console_end();
+
+	exp = cur_exp;
+	scn_id = cedit_prepare(exp, &vid_priv, &scn);
+	ut_assert(scn_id > 0);
+	ut_assertnonnull(scn);
+
+	/* just do a very basic test that the first menu is present */
+	menu = scene_obj_find(scn, scn->highlight_id, SCENEOBJT_NONE);
+	ut_assertnonnull(menu);
+
+	txt = scene_obj_find(scn, menu->title_id, SCENEOBJT_NONE);
+	ut_assertnonnull(txt);
+	ut_asserteq_str("Boot option", expo_get_str(exp, txt->str_id));
+
+	return 0;
+}
+CMD_TEST(test_cmd_cedit_cb_load, UT_TESTF_CONSOLE_REC);
-- 
2.34.1

