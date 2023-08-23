Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C3EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 01:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED1B86473;
	Wed, 23 Aug 2023 03:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j6L+wEgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80DF186473; Wed, 23 Aug 2023 03:50:18 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1989F864AD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 03:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b89b0c73d7so8988205ad.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692755413; x=1693360213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FhD0dcR7+7DlZBrfYfK966oT6q2elckYP79BFrLF8Jc=;
 b=j6L+wEgFdl4uFDbutovzvsKvv/+849ZulJBVh8HF4HY/EYOiS3bmzRWspKf9LEr28S
 h2zOEJBpx1sV+WY2r18EQF1JNIxhaezI0EJ84fEQgtrP552ijtSlu+ijLO65d+j8IOMN
 cM1jAHQEStW3A77xOFGQl/htevtAOKXbIp5jkU4tXqGaC5+6ZqqlsY7ZEJCWa4DLHeZ7
 +3dHsWuu/nwB6MvVN0b22XBlRTfbJ4ugOpZz8FM65qCmbAN+zD2t2AMS5HReBCpaqztV
 iEi3Z9Vxwv+MTyu7L9pqbPmIQ48HAB3CaqrUcf3Mzy+wTSxYJDHlsIw3+U4MaJHklIGt
 wiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692755413; x=1693360213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FhD0dcR7+7DlZBrfYfK966oT6q2elckYP79BFrLF8Jc=;
 b=H589Oj3/Q2O9Xskl7eoqgd08xrmII8g0Xz8eMz8wBVK+T/IrF4P9gPA07Qeveeb4YM
 fWrrtNjZ9z4TOqsfUfVlnQKbNiRlJKTNk03RcgLdm/OvY0+TjnRRApXyFR87ZOL96iqj
 XXFc62qe+WD01FxLAd7icr7zDR+qiiQicpN70ByNM/jyqRyYwkKgpyHRJDAgBO6m82lr
 aYNC4ETv9kknX99TfQMxE9XD26BtwcPPVLRU9NrT6zUFdJz6sRjZ1pzqXQZhpduW/Up5
 Tzew1w5mjbIAD7dLorrPH6JwqR12ZuF5NB7UDZgOgxlc183lO/A9C1DBG9OcJ9jSVGmc
 K1gw==
X-Gm-Message-State: AOJu0Yw/Upgg9GORhRVovV4nb1F8s3Dyd7BEwIQCJZ8M/Oc3ZOa/XgSe
 tBUqtyvjgYNnN5KBmCSAN37dxw==
X-Google-Smtp-Source: AGHT+IFoxFlAeqsABVw9H09Sska9HtdbMaki88RpVhg4b+3Mhb+6iZyWUVQGNuYXS5wuPU2L+sg9Vw==
X-Received: by 2002:a17:902:cec2:b0:1bb:9e6e:a9f3 with SMTP id
 d2-20020a170902cec200b001bb9e6ea9f3mr12934860plg.4.1692755413201; 
 Tue, 22 Aug 2023 18:50:13 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:c42c:e1e7:4c2:47d8])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001bdeb6bdfbasm9671092plp.241.2023.08.22.18.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:50:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: sjg@chromium.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2] cmd: dm: allow for selecting uclass and device
Date: Wed, 23 Aug 2023 10:49:47 +0900
Message-Id: <20230823014947.20876-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The output from "dm tree" or "dm uclass" is a bit annoying
if the number of devices available on the system is huge.
(This is especially true on sandbox when I debug some DM code.)

With this patch, we can specify the uclass name or the device
name that we are interested in in order to limit the output.

For instance,

=> dm uclass usb
uclass 121: usb
0     usb@1 @ 0bcff8b0, seq 1

uclass 124: usb

=> dm tree usb:usb@1
 Class     Index  Probed  Driver                Name
-----------------------------------------------------------
 usb           0  [   ]   usb_sandbox           usb@1
 usb_hub       0  [   ]   usb_hub               `-- hub
 usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
 usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
 usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
 usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
 usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3

If you want forward-matching against a uclass or udevice name,
you can specify "-e" option.

=> dm uclass -e usb
uclass 15: usb_emul
0     hub-emul @ 0bcffb00, seq 0
1     flash-stick@0 @ 0bcffc30, seq 1
2     flash-stick@1 @ 0bcffdc0, seq 2
3     flash-stick@2 @ 0bcfff50, seq 3
4     keyb@3 @ 0bd000e0, seq 4

uclass 64: usb_mass_storage

uclass 121: usb
0     usb@1 @ 0bcff8b0, seq 1

uclass 122: usb_dev_generic

uclass 123: usb_hub
0     hub @ 0bcff9b0, seq 0

uclass 124: usb

=> dm tree -e usb
 Class     Index  Probed  Driver                Name
-----------------------------------------------------------
 usb           0  [   ]   usb_sandbox           usb@1
 usb_hub       0  [   ]   usb_hub               `-- hub
 usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
 usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
 usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
 usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
 usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v2
- allow for forward-matching against the name
- update command doc
---
 cmd/dm.c             |  48 ++++++++++++++----
 doc/usage/cmd/dm.rst |  30 ++++++++++-
 drivers/core/dump.c  | 116 ++++++++++++++++++++++++++++++++-----------
 include/dm/util.h    |  15 ++++--
 4 files changed, 165 insertions(+), 44 deletions(-)

diff --git a/cmd/dm.c b/cmd/dm.c
index 3263547cbec6..1aa86aab9c1c 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -59,11 +59,26 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
 static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
-	bool sort;
-
-	sort = argc > 1 && !strcmp(argv[1], "-s");
-
-	dm_dump_tree(sort);
+	bool extended = false, sort = false;
+	char *device = NULL;
+
+	for (; argc > 1; argc--, argv++) {
+		if (argv[1][0] != '-')
+			break;
+
+		if (!strcmp(argv[1], "-e")) {
+			extended = true;
+		} else if (!strcmp(argv[1], "-s")) {
+			sort = true;
+		} else {
+			printf("Unknown parameter: %s\n", argv[1]);
+			return 0;
+		}
+	}
+	if (argc > 1)
+		device = argv[1];
+
+	dm_dump_tree(device, extended, sort);
 
 	return 0;
 }
@@ -71,7 +86,20 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-	dm_dump_uclass();
+	bool extended = false;
+	char *uclass = NULL;
+
+	if (argc > 1) {
+		if (!strcmp(argv[1], "-e")) {
+			extended = true;
+			argc--;
+			argv++;
+		}
+		if (argc > 1)
+			uclass = argv[1];
+	}
+
+	dm_dump_uclass(uclass, extended);
 
 	return 0;
 }
@@ -91,8 +119,8 @@ static char dm_help_text[] =
 	"dm drivers       Dump list of drivers with uclass and instances\n"
 	DM_MEM_HELP
 	"dm static        Dump list of drivers with static platform data\n"
-	"dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
-	"dm uclass        Dump list of instances for each uclass"
+	"dm tree [-s][-e][name]   Dump tree of driver model devices (-s=sort)\n"
+	"dm uclass [-e][name]     Dump list of instances for each uclass"
 	;
 #endif
 
@@ -102,5 +130,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
 	U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
 	DM_MEM
 	U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
-	U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
-	U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
+	U_BOOT_SUBCMD_MKENT(tree, 4, 1, do_dm_dump_tree),
+	U_BOOT_SUBCMD_MKENT(uclass, 3, 1, do_dm_dump_uclass));
diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 74c6b01e3619..12b7edeed685 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -12,8 +12,8 @@ Synopis
     dm devres
     dm drivers
     dm static
-    dm tree [-s]
-    dm uclass
+    dm tree [-s][-e] [uclass name]
+    dm uclass [-e] [udevice name]
 
 Description
 -----------
@@ -127,6 +127,12 @@ If -s is given, the top-level devices (those which are children of the root
 device) are shown sorted in order of uclass ID, so it is easier to find a
 particular device type.
 
+If -e is given, forward-matching against existing devices is
+made and only the matched devices are shown.
+
+If a device name is given, forward-matching against existing devices is
+made and only the matched devices are shown.
+
 dm uclass
 ~~~~~~~~~
 
@@ -140,6 +146,11 @@ For each device, the format is::
 where `n` is the index within the uclass, `a` is the address of the device in
 memory and `s` is the sequence number of the device.
 
+If -e is given, forward-matching against existing uclasses is
+made and only the matched uclasses are shown.
+
+If no uclass name is given, all the uclasses are shown.
+
 
 Examples
 --------
@@ -409,6 +420,15 @@ This example shows the abridged sandbox output::
     nop           8  [   ]   scmi_voltage_domain       `-- regulators
     regulator     5  [   ]   scmi_regulator                |-- reg@0
     regulator     6  [   ]   scmi_regulator                `-- reg@1
+    => dm tree pinc
+    pinctrl       0  [ + ]   sandbox_pinctrl_gpio  pinctrl-gpio
+    gpio          1  [ + ]   sandbox_gpio          |-- base-gpios
+    nop           0  [ + ]   gpio_hog              |   |-- hog_input_active_low
+    nop           1  [ + ]   gpio_hog              |   |-- hog_input_active_high
+    nop           2  [ + ]   gpio_hog              |   |-- hog_output_low
+    nop           3  [ + ]   gpio_hog              |   `-- hog_output_high
+    gpio          2  [   ]   sandbox_gpio          |-- extra-gpios
+    gpio          3  [   ]   sandbox_gpio          `-- pinmux-gpios
     =>
 
 
@@ -487,4 +507,10 @@ This example shows the abridged sandbox output::
     0   * gpio-wdt @ 0301c070, seq 0
     1   * wdt@0 @ 03021710, seq 1
 
+    => dm uclass blk
+    uclass 22: blk
+    0     mmc2.blk @ 0301ca00, seq 0
+    1     mmc1.blk @ 0301cee0, seq 1
+    2     mmc0.blk @ 0301d380, seq 2
+
     =>
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 3e77832a3a00..4023b390f542 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -85,29 +85,65 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 	}
 }
 
-void dm_dump_tree(bool sort)
+static void dm_dump_tree_single(struct udevice *dev, bool sort)
 {
-	struct udevice *root;
+	int dev_count, uclasses;
+	struct udevice **devs = NULL;
 
-	root = dm_root();
-	if (root) {
-		int dev_count, uclasses;
-		struct udevice **devs = NULL;
-
-		dm_get_stats(&dev_count, &uclasses);
-
-		printf(" Class     Index  Probed  Driver                Name\n");
-		printf("-----------------------------------------------------------\n");
-		if (sort) {
-			devs = calloc(dev_count, sizeof(struct udevice *));
-			if (!devs) {
-				printf("(out of memory)\n");
-				return;
+	dm_get_stats(&dev_count, &uclasses);
+
+	if (sort) {
+		devs = calloc(dev_count, sizeof(struct udevice *));
+		if (!devs) {
+			printf("(out of memory)\n");
+			return;
+		}
+	}
+	show_devices(dev, -1, 0, devs);
+	free(devs);
+}
+
+static void dm_dump_tree_recursive(struct udevice *dev, char *dev_name,
+				   bool extended, bool sort)
+{
+	struct udevice *child;
+	size_t len;
+
+	len = strlen(dev_name);
+
+	device_foreach_child(child, dev) {
+		if (extended) {
+			if (!strncmp(child->name, dev_name, len)) {
+				dm_dump_tree_single(child, sort);
+				continue;
+			}
+		} else {
+			if (!strcmp(child->name, dev_name)) {
+				dm_dump_tree_single(child, sort);
+				continue;
 			}
 		}
-		show_devices(root, -1, 0, devs);
-		free(devs);
+		dm_dump_tree_recursive(child, dev_name, extended, sort);
+	}
+}
+
+void dm_dump_tree(char *dev_name, bool extended, bool sort)
+{
+	struct udevice *root;
+
+	printf(" Class     Index  Probed  Driver                Name\n");
+	printf("-----------------------------------------------------------\n");
+
+	root = dm_root();
+	if (!root)
+		return;
+
+	if (!dev_name || !strcmp(dev_name, "root")) {
+		dm_dump_tree_single(root, sort);
+		return;
 	}
+
+	dm_dump_tree_recursive(root, dev_name, extended, sort);
 }
 
 /**
@@ -127,26 +163,50 @@ static void dm_display_line(struct udevice *dev, int index)
 	puts("\n");
 }
 
-void dm_dump_uclass(void)
+static void dm_dump_uclass_single(enum uclass_id id)
 {
 	struct uclass *uc;
+	struct udevice *dev;
+	int i = 0, ret;
+
+	ret = uclass_get(id, &uc);
+	if (ret)
+		return;
+
+	printf("uclass %d: %s\n", id, uc->uc_drv->name);
+	uclass_foreach_dev(dev, uc) {
+		dm_display_line(dev, i);
+		i++;
+	}
+	puts("\n");
+}
+
+void dm_dump_uclass(char *uclass, bool extended)
+{
+	struct uclass *uc;
+	enum uclass_id id;
+	bool matching;
 	int ret;
-	int id;
 
-	for (id = 0; id < UCLASS_COUNT; id++) {
-		struct udevice *dev;
-		int i = 0;
+	matching = !!(uclass && strcmp(uclass, "root"));
 
+	for (id = 0; id < UCLASS_COUNT; id++) {
 		ret = uclass_get(id, &uc);
 		if (ret)
 			continue;
 
-		printf("uclass %d: %s\n", id, uc->uc_drv->name);
-		uclass_foreach_dev(dev, uc) {
-			dm_display_line(dev, i);
-			i++;
+		if (matching) {
+			if (extended) {
+				if (!strncmp(uc->uc_drv->name, uclass,
+					     strlen(uclass)))
+					dm_dump_uclass_single(id);
+			} else {
+				if (!strcmp(uc->uc_drv->name, uclass))
+					dm_dump_uclass_single(id);
+			}
+		} else {
+			dm_dump_uclass_single(id);
 		}
-		puts("\n");
 	}
 }
 
diff --git a/include/dm/util.h b/include/dm/util.h
index 4bb49e9e8c01..89206cc49669 100644
--- a/include/dm/util.h
+++ b/include/dm/util.h
@@ -27,14 +27,21 @@ struct list_head;
 int list_count_items(struct list_head *head);
 
 /**
- * Dump out a tree of all devices
+ * Dump out a tree of all devices starting @uclass
  *
+ * @dev_name: udevice name
+ * @extended: true if forword-matching expected
  * @sort: Sort by uclass name
  */
-void dm_dump_tree(bool sort);
+void dm_dump_tree(char *dev_name, bool extended, bool sort);
 
-/* Dump out a list of uclasses and their devices */
-void dm_dump_uclass(void);
+/*
+ * Dump out a list of uclasses and their devices
+ *
+ * @uclass: uclass name
+ * @extended: true if forword-matching expected
+ */
+void dm_dump_uclass(char *uclass, bool extended);
 
 #ifdef CONFIG_DEBUG_DEVRES
 /* Dump out a list of device resources */
-- 
2.34.1

