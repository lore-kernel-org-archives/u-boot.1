Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527CEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 02:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D86087110;
	Tue, 22 Aug 2023 04:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zFF4mqDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 483A287111; Tue, 22 Aug 2023 04:46:40 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A73A86B97
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-688d994565bso685046b3a.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692672395; x=1693277195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3G5xwLB/Xq5zSbsMs2igLb6GxUW9Rwb9hOoNyAv7SYE=;
 b=zFF4mqDMM3h4K9TTmUYD+Y+0LwN05/vgna8vok4xOMqpPav+5OYLh3G86jrNZiWQb6
 dv6G0UzRhzkIEHn+lUOTDNl1b7yVIxb2xmoDCe1YW3MDVHEE4dJNOkzyPOEEICqw4rwS
 rH7w4PA7kzg3vxSNHfAF4N9pJtVTYrUP41mzdJHPaAiqFJ5eKo2hj1IEM4hKjm02ZP2s
 r5JczbaSX5P9RB6MZXGAHJlp2PqMcrMKjeoqk3mckodKQJiwmmzaIkFjk3ehFUHUm6Iy
 SAHf33JwItZWpctaJnlYigpfBcQ66GmbrYAHSaSkPkJzHVnzF9izqsOn1YnRTrnSDZO0
 HQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692672395; x=1693277195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3G5xwLB/Xq5zSbsMs2igLb6GxUW9Rwb9hOoNyAv7SYE=;
 b=eYTTifYVzBFdTIiyqgbsFTdyh6WczvA/sMQRQKajtHWSJ4uYL6nE2iC2lhHbzfIj6u
 DxWKblhsjdTY+YR+WxpxvQ9MODy7A7RvD1tyijYUsB/TjvJdOjrV1wtRHOdMQD5ETm7s
 k+YNkB+hbtJWX/+3H24rhcJCBAe90zhr+UPVyjnuTVVF+ZvE+bYtC024CcVkPCwHculT
 tISSWxReSHreC+tzmd7SH18VEPDbatEOb3aHKJVyLuGimoNOsDyxl9v0e3wCqH0sHGnI
 hcEd8i29zgvNo8kPjPHMWDmgkd/BOEmOmuChpb16CnZEnR2uQTqfdY6pq6fzw/dQNhDN
 HK1A==
X-Gm-Message-State: AOJu0Ywo+4DAfzN7LPUAREo+Kl1F2n/SYgJQOA8+b6GUw/oLCnyV76Ul
 fma1w7r1oIyqGjn0EYzoZajHXg==
X-Google-Smtp-Source: AGHT+IHHTm2NNkxV6ZLg566oz+u/pnypWQwNBPhPzCsYxg0kDVfP5qcTZx+lO5+Jet05QNyVFAcvLA==
X-Received: by 2002:a05:6a21:788a:b0:13a:3649:dc1a with SMTP id
 bf10-20020a056a21788a00b0013a3649dc1amr11922185pzc.0.1692672395466; 
 Mon, 21 Aug 2023 19:46:35 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:80ef:c810:df6:6b53])
 by smtp.gmail.com with ESMTPSA id
 jc9-20020a17090325c900b001bbb22652a4sm7743963plb.226.2023.08.21.19.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 19:46:35 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: sjg@chromium.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] cmd: dm: allow for selecting uclass and device
Date: Tue, 22 Aug 2023 11:46:11 +0900
Message-Id: <20230822024611.32977-1-takahiro.akashi@linaro.org>
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

With this patch, we can specify the uclass or the device
that we are interested in in order to limit the output.

For instance,

=> dm uclass usb
uclass 121: usb
0     usb@1 @ 0bd008b0, seq 1

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

Please note that, at "dm tree", the uclass name (usb) as well as
the device name (usb@1) is required.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/dm.c            | 30 ++++++++++++++++++++--------
 drivers/core/dump.c | 48 +++++++++++++++++++++++++++++++++++++++------
 include/dm/util.h   | 13 ++++++++----
 3 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/cmd/dm.c b/cmd/dm.c
index 3263547cbec6..99268df2f87a 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -59,11 +59,20 @@ static int do_dm_dump_static_driver_info(struct cmd_tbl *cmdtp, int flag,
 static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
-	bool sort;
+	bool sort = false;
+	char *device = NULL;
 
-	sort = argc > 1 && !strcmp(argv[1], "-s");
+	if (argc > 1) {
+		if (!strcmp(argv[1], "-s")) {
+			sort = true;
+			argc--;
+			argv++;
+		}
+		if (argc > 1)
+			device = argv[1];
+	}
 
-	dm_dump_tree(sort);
+	dm_dump_tree(device, sort);
 
 	return 0;
 }
@@ -71,7 +80,12 @@ static int do_dm_dump_tree(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-	dm_dump_uclass();
+	char *uclass = NULL;
+
+	if (argc > 1)
+		uclass = argv[1];
+
+	dm_dump_uclass(uclass);
 
 	return 0;
 }
@@ -91,8 +105,8 @@ static char dm_help_text[] =
 	"dm drivers       Dump list of drivers with uclass and instances\n"
 	DM_MEM_HELP
 	"dm static        Dump list of drivers with static platform data\n"
-	"dm tree [-s]     Dump tree of driver model devices (-s=sort)\n"
-	"dm uclass        Dump list of instances for each uclass"
+	"dm tree [-s][name] Dump tree of driver model devices (-s=sort)\n"
+	"dm uclass [name] Dump list of instances for each uclass"
 	;
 #endif
 
@@ -102,5 +116,5 @@ U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
 	U_BOOT_SUBCMD_MKENT(drivers, 1, 1, do_dm_dump_drivers),
 	DM_MEM
 	U_BOOT_SUBCMD_MKENT(static, 1, 1, do_dm_dump_static_driver_info),
-	U_BOOT_SUBCMD_MKENT(tree, 2, 1, do_dm_dump_tree),
-	U_BOOT_SUBCMD_MKENT(uclass, 1, 1, do_dm_dump_uclass));
+	U_BOOT_SUBCMD_MKENT(tree, 3, 1, do_dm_dump_tree),
+	U_BOOT_SUBCMD_MKENT(uclass, 2, 1, do_dm_dump_uclass));
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 3e77832a3a00..855d6ca002b7 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -85,11 +85,35 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
 	}
 }
 
-void dm_dump_tree(bool sort)
+void dm_dump_tree(char *uclass, bool sort)
 {
 	struct udevice *root;
 
-	root = dm_root();
+	if (uclass) {
+		char *device;
+		enum uclass_id id;
+
+		device = strchr(uclass, ':');
+		if (!device) {
+			printf("name %s: invalid format\n", uclass);
+			return;
+		}
+		*device = '\0';
+		device++;
+
+		id = uclass_get_by_name(uclass);
+		if (id == UCLASS_INVALID) {
+			printf("uclass %s: not found\n", uclass);
+			return;
+		}
+		if (uclass_find_device_by_name(id, device, &root)) {
+			printf("device %s:%s: not found\n", uclass, device);
+			return;
+		}
+	} else {
+		root = dm_root();
+	}
+
 	if (root) {
 		int dev_count, uclasses;
 		struct udevice **devs = NULL;
@@ -127,13 +151,25 @@ static void dm_display_line(struct udevice *dev, int index)
 	puts("\n");
 }
 
-void dm_dump_uclass(void)
+void dm_dump_uclass(char *uclass)
 {
 	struct uclass *uc;
-	int ret;
-	int id;
+	enum uclass_id id;
+	int count, ret;
+
+	if (uclass) {
+		id = uclass_get_by_name(uclass);
+		if (id == UCLASS_INVALID) {
+			printf("uclass %s: not found\n", uclass);
+			return;
+		}
+		count = 1;
+	} else {
+		id = 0;
+		count = UCLASS_COUNT;
+	}
 
-	for (id = 0; id < UCLASS_COUNT; id++) {
+	for ( ; count; id++, count--) {
 		struct udevice *dev;
 		int i = 0;
 
diff --git a/include/dm/util.h b/include/dm/util.h
index 4bb49e9e8c01..ee1b34c103e3 100644
--- a/include/dm/util.h
+++ b/include/dm/util.h
@@ -27,14 +27,19 @@ struct list_head;
 int list_count_items(struct list_head *head);
 
 /**
- * Dump out a tree of all devices
+ * Dump out a tree of all devices starting @uclass
  *
+ * @uclass: uclass+device name
  * @sort: Sort by uclass name
  */
-void dm_dump_tree(bool sort);
+void dm_dump_tree(char *uclass, bool sort);
 
-/* Dump out a list of uclasses and their devices */
-void dm_dump_uclass(void);
+/*
+ * Dump out a list of uclasses and their devices
+ *
+ * @uclass: uclass name
+ */
+void dm_dump_uclass(char *uclass);
 
 #ifdef CONFIG_DEBUG_DEVRES
 /* Dump out a list of device resources */
-- 
2.34.1

