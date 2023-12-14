Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299ECC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C13887B1E;
	Thu, 14 Dec 2023 17:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ljh8m5D8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89CD87B08; Thu, 14 Dec 2023 17:52:00 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACFB87B02
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35f7589ea1fso6485955ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572715; x=1703177515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYkZyLNvI/IrYseqoZZxd1Az16TIYBE2ssaJ2s9Zpb0=;
 b=ljh8m5D8FdfnY4fvVTebE/7UZzUGbNLtK5jMvoTqutgfi6ZIbvzeJG4hUiNe1RN+rR
 q6GtOdcPn7qzDm0oJ3aa+l3TR9qeZCQ0oLgj2sk4OGiJ3z6c15ktpqlkNhSamiATY+YT
 GAK+rXwEEoPLp37Ms0KDHop5cphgeRUqfinCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572715; x=1703177515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYkZyLNvI/IrYseqoZZxd1Az16TIYBE2ssaJ2s9Zpb0=;
 b=joqFjiM5D+dkoSzS0Jl0CE0pphJTiKMs3E/Y2owxsjr+B1Bor1QgdOPHCgB3+7s9Zf
 KKxqIQyTm2ebuf5BA3AVk5DtnuHFHfZ892QW5X7w3gg2GD5Aau3/vyjb6rL1gZyc1UXb
 FrIxEpBUh5t2Oh82VzDd5FwNN+oLuT14RRYuGqNTRJk8r5Ed8VKa5qVskt3nXEPrYz0d
 3enDgrRcsA4OiQv8w8kSnquyWGlIYS/PAsnKTq6JYhFk1ESrIIXZBu+f6uToEopDSO/B
 s4yZ2PtelSS1FdkCPMe5AFUyg2nHtv9pFRht5YRrO5Q98wpb/nQVc0k+4oQNG2D7yTGQ
 PVFg==
X-Gm-Message-State: AOJu0YzQYM+pEqif584Af9frXv7K/i4fXwXEsJJrvRz5WBYWGoSMuks9
 ZUavPscx0LWFFLHaNmVGkYakXuuDZTcskBq5zhXjYA==
X-Google-Smtp-Source: AGHT+IF987asFT77jRpeiKB7BU1/6l+Tn53GgFo+xivPd2HZ4XQ8IqG/b0cEcWfgigV7In8s/bDPvA==
X-Received: by 2002:a05:6e02:148a:b0:35d:5128:d379 with SMTP id
 n10-20020a056e02148a00b0035d5128d379mr14475389ilk.24.1702572715377; 
 Thu, 14 Dec 2023 08:51:55 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 14/21] bootm: Drop arguments from do_bootm_states()
Date: Thu, 14 Dec 2023 09:50:23 -0700
Message-ID: <20231214165112.2182274-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

Use the bootm_info struct to hold the information required by bootm.

Now that none of the functions called from do_bootm_states() needs an
argv[] list, change the arguments of do_bootm_states() as well. Take
care to use the same value for boot_progress even though it is a little
inconsistent.

For booti make sure it only uses argv[] and argc at the top of the
function, so we can eventually refactor to remove these parameters.

With bootm, some OSes need access to the arguments provided to the
command, so set these up in the bootm_info struct, for bootm only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Adjust patch to focus just on dropping the do_bootm_states() arguments

 boot/bootm.c    | 52 ++++++++++++++++++++-----------------------------
 cmd/booti.c     | 33 ++++++++++++++++++++-----------
 cmd/bootm.c     | 33 +++++++++++++++++++++++++++++--
 cmd/bootz.c     | 27 +++++++++++++++++++++----
 include/bootm.h | 25 ++++++++----------------
 5 files changed, 105 insertions(+), 65 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 875f8a1c2a56..7156149dfae9 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -990,11 +990,9 @@ unmap_image:
 	return ret;
 }
 
-int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int states, struct bootm_headers *images,
-		    int boot_progress)
+int do_bootm_states(struct bootm_info *bmi, int states)
 {
-	struct bootm_info bmi;
+	struct bootm_headers *images = bmi->images;
 	boot_os_fn *boot_fn;
 	ulong iflag = 0;
 	int ret = 0, need_boot_fn;
@@ -1009,17 +1007,18 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_start();
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD))
-		ret = bootm_pre_load(argv[0]);
+		ret = bootm_pre_load(bmi->addr_fit);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
-		ret = bootm_find_os(cmdtp->name, argv[0]);
+		ret = bootm_find_os(bmi->cmd_name, bmi->addr_fit);
 
 	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
 		ulong img_addr;
 
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
-		ret = bootm_find_other(img_addr, cmd_arg1(argc, argv),
-				       cmd_arg2(argc, argv));
+		img_addr = bmi->addr_fit ? hextoul(bmi->addr_fit, NULL)
+			: image_load_addr;
+		ret = bootm_find_other(img_addr, bmi->conf_ramdisk,
+				       bmi->conf_fdt);
 	}
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
@@ -1073,15 +1072,11 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		return 1;
 	}
 
-	bmi.images = images;
-	bmi.argc = argc;
-	bmi.argv = argv;
-
 	/* Call various other states that are not generally used */
 	if (!ret && (states & BOOTM_STATE_OS_CMDLINE))
-		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, &bmi);
+		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, bmi);
 	if (!ret && (states & BOOTM_STATE_OS_BD_T))
-		ret = boot_fn(BOOTM_STATE_OS_BD_T, &bmi);
+		ret = boot_fn(BOOTM_STATE_OS_BD_T, bmi);
 	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
 		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
 		if (ret) {
@@ -1089,7 +1084,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = CMD_RET_FAILURE;
 			goto err;
 		}
-		ret = boot_fn(BOOTM_STATE_OS_PREP, &bmi);
+		ret = boot_fn(BOOTM_STATE_OS_PREP, bmi);
 	}
 
 #ifdef CONFIG_TRACE
@@ -1097,10 +1092,10 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_OS_FAKE_GO)) {
 		char *cmd_list = env_get("fakegocmd");
 
-		ret = boot_selected_os(argc, argv, BOOTM_STATE_OS_FAKE_GO,
-				images, boot_fn);
+		ret = boot_selected_os(bmi->argc, bmi->argv,
+				       BOOTM_STATE_OS_FAKE_GO, images, boot_fn);
 		if (!ret && cmd_list)
-			ret = run_command_list(cmd_list, -1, flag);
+			ret = run_command_list(cmd_list, -1, 0);
 	}
 #endif
 
@@ -1112,8 +1107,8 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Now run the OS! We hope this doesn't return */
 	if (!ret && (states & BOOTM_STATE_OS_GO))
-		ret = boot_selected_os(argc, argv, BOOTM_STATE_OS_GO,
-				images, boot_fn);
+		ret = boot_selected_os(bmi->argc, bmi->argv, BOOTM_STATE_OS_GO,
+				       images, boot_fn);
 
 	/* Deal with any fallout */
 err:
@@ -1132,19 +1127,11 @@ err:
 
 int bootm_boot_start(ulong addr, const char *cmdline)
 {
-	static struct cmd_tbl cmd = {"bootm"};
 	char addr_str[30];
-	char *argv[] = {addr_str, NULL};
+	struct bootm_info bmi;
 	int states;
 	int ret;
 
-	/*
-	 * TODO(sjg@chromium.org): This uses the command-line interface, but
-	 * should not. To clean this up, the various bootm states need to be
-	 * passed an info structure instead of cmdline flags. Then this can
-	 * set up the required info and move through the states without needing
-	 * the command line.
-	 */
 	states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
 		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
 		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
@@ -1162,7 +1149,10 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 		printf("Failed to set cmdline\n");
 		return ret;
 	}
-	ret = do_bootm_states(&cmd, 0, 1, argv, states, &images, 1);
+	bootm_init(&bmi);
+	bmi.addr_fit = addr_str;
+	bmi.cmd_name = "bootm";
+	ret = do_bootm_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/booti.c b/cmd/booti.c
index d3cceb7e0a39..3fa153eb5e54 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -20,9 +20,9 @@ DECLARE_GLOBAL_DATA_PTR;
 /*
  * Image booting support
  */
-static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[], struct bootm_headers *images)
+static int booti_start(struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	int ret;
 	ulong ld;
 	ulong relocated_addr;
@@ -34,16 +34,15 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	unsigned long decomp_len;
 	int ctype;
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, BOOTM_STATE_START,
-			      images, 1);
+	ret = do_bootm_states(bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel Image entry point */
-	if (!argc) {
+	if (!bmi->addr_fit) {
 		ld = image_load_addr;
 		debug("*  kernel: default image load address = 0x%08lx\n",
 				image_load_addr);
 	} else {
-		ld = hextoul(argv[0], NULL);
+		ld = hextoul(bmi->addr_fit, NULL);
 		debug("*  kernel: cmdline image address = 0x%08lx\n", ld);
 	}
 
@@ -95,9 +94,8 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
-	if (bootm_find_images(image_load_addr, cmd_arg1(argc, argv),
-			      cmd_arg2(argc, argv), relocated_addr,
-			      image_size))
+	if (bootm_find_images(image_load_addr, bmi->conf_ramdisk, bmi->conf_fdt,
+			      relocated_addr, image_size))
 		return 1;
 
 	return 0;
@@ -105,13 +103,25 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_info bmi;
 	int states;
 	int ret;
 
 	/* Consume 'booti' */
 	argc--; argv++;
 
-	if (booti_start(cmdtp, flag, argc, argv, &images))
+	bootm_init(&bmi);
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.boot_progress = true;
+	bmi.cmd_name = "booti";
+	/* do not set up argc and argv[] since nothing uses them */
+
+	if (booti_start(&bmi))
 		return 1;
 
 	/*
@@ -130,7 +140,8 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
-	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
+
+	ret = do_bootm_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 6ded091dd559..42a5cf2fa987 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -76,6 +76,7 @@ static ulong bootm_get_addr(int argc, char *const argv[])
 static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 			       char *const argv[])
 {
+	struct bootm_info bmi;
 	int ret = 0;
 	long state;
 	struct cmd_tbl *c;
@@ -103,7 +104,21 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, state, &images, 0);
+	bootm_init(&bmi);
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.cmd_name = "bootm";
+	bmi.boot_progress = false;
+
+	/* set up argc and argv[] since some OSes use them */
+	bmi.argc = argc;
+	bmi.argv = argv;
+
+	ret = do_bootm_states(&bmi, state);
 
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
 	if (!ret && (state & BOOTM_STATE_PRE_LOAD))
@@ -120,6 +135,7 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_info bmi;
 	int states;
 	int ret;
 
@@ -151,7 +167,20 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		states |= BOOTM_STATE_MEASURE;
 	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
 		states |= BOOTM_STATE_OS_CMDLINE;
-	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
+
+	bootm_init(&bmi);
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+
+	/* set up argc and argv[] since some OSes use them */
+	bmi.argc = argc;
+	bmi.argv = argv;
+
+	ret = do_bootm_states(&bmi, states);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 8c25905598a8..9aa07b682d1c 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -27,11 +27,20 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[], struct bootm_headers *images)
 {
-	int ret;
 	ulong zi_start, zi_end;
+	struct bootm_info bmi;
+	int ret;
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, BOOTM_STATE_START,
-			      images, 1);
+	bootm_init(&bmi);
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	/* do not set up argc and argv[] since nothing uses them */
+
+	ret = do_bootm_states(&bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel zImage entry point */
 	if (!argc) {
@@ -64,6 +73,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_info bmi;
 	int states, ret;
 
 	/* Consume 'bootz' */
@@ -80,12 +90,21 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	images.os.os = IH_OS_LINUX;
 
+	bootm_init(&bmi);
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.cmd_name = "bootz";
+
 	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
 		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
+	ret = do_bootm_states(&bmi, states);
 
 	return ret;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 950ce5181f1d..1f83c160767f 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -132,33 +132,24 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 int bootm_measure(struct bootm_headers *images);
 
 /**
- * Execute selected states of the bootm command.
- *
- * Note the arguments to this state must be the first argument, Any 'bootm'
- * or sub-command arguments must have already been taken.
+ * do_bootm_states() - Execute selected states of the bootm command.
  *
  * Note that if states contains more than one flag it MUST contain
- * BOOTM_STATE_START, since this handles and consumes the command line args.
+ * BOOTM_STATE_START, since this handles the addr_fit, conf_ramdisk and conf_fit
+ * members of @bmi
  *
- * Also note that aside from boot_os_fn functions and bootm_load_os no other
- * functions we store the return value of in 'ret' may use a negative return
+ * Also note that aside from boot_os_fn functions and bootm_load_os, no other
+ * functions store the return value of in 'ret' may use a negative return
  * value, without special handling.
  *
- * @param cmdtp		Pointer to bootm command table entry
- * @param flag		Command flags (CMD_FLAG_...)
- * @param argc		Number of subcommand arguments (0 = no arguments)
- * @param argv		Arguments
- * @param states	Mask containing states to run (BOOTM_STATE_...)
- * @param images	Image header information
- * @param boot_progress 1 to show boot progress, 0 to not do this
+ * @bmi: bootm information
+ * @states	Mask containing states to run (BOOTM_STATE_...)
  * Return: 0 if ok, something else on error. Some errors will cause this
  *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
  *	then the intent is to boot an OS, so this function will not return
  *	unless the image type is standalone.
  */
-int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int states, struct bootm_headers *images,
-		    int boot_progress);
+int do_bootm_states(struct bootm_info *bmi, int states);
 
 void arch_preboot_os(void);
 
-- 
2.43.0.472.g3155946c3a-goog

