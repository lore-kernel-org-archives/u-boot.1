Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C079DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D819087870;
	Mon,  4 Dec 2023 01:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="njpTfZ5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4121987873; Mon,  4 Dec 2023 01:27:58 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FDB8786E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b350130c3fso104282439f.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649674; x=1702254474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl+VCjx7pHwEG6aDKwp3HDzt/VHJAlBVX8anLI7usig=;
 b=njpTfZ5gCCZaOtxTpLk3vdlONtRrvavNo6/oPo63wr/OF/BHOeUBdpBfTzNNS0dWuj
 AGV5e+8+MvL6BfXp/8t46GlEhxJPd6OZ5xUyYGQNck1XiT9dmLKzXvSmB2EA5ntF1o4o
 s8ITvJISL2DWEidFtU9i2QON0NcyXivr54J6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649674; x=1702254474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl+VCjx7pHwEG6aDKwp3HDzt/VHJAlBVX8anLI7usig=;
 b=qKF42qvKGJfCcu2Yu5vv20MJtvzknVBcIbTWh5aNORl99mBiW6cwc7qo9WINf9Kq0f
 w+pJrqsEdbhx3M532wcjCwfWDjseFoPbHDfvLXO8JbjAQ3XXUZ3xXqYuNOTRoli8YQR9
 TmfUphsoHArUoFUhgBhgLN4cM8qoMwe3DwZ4dW2ZN5lzrr0q+tFAFPyPNbJ8NhK61llF
 1vuG3WY6exlKm4wtRh/rOQP+K7ukDHFrJ6HX4ig8rhTGNdVAiydpmR8k0MOrJpMCrXEi
 ELpyB82o+GdAUXavQUYKuWW5a9sR084dM9FnINvX0RibYJpC/312XmwtL0TFFOSPUiVg
 mDPg==
X-Gm-Message-State: AOJu0YzQPvSS1gGkMgdyWDx2rlU7FEwOTvNtUViyJPz0e5G1WskR7MgS
 TwtWwSEfUrTVvyeF/LDAPDvTHgX+VS2VsKKnYiHgEQ==
X-Google-Smtp-Source: AGHT+IHh32wKsRULhtjJgwVPoztlDN9VG3SaPXZ7gwJXRacAn+wUIMArICa7zHyRXikWKI6RRYBp5Q==
X-Received: by 2002:a92:cf4b:0:b0:35d:59a2:a323 with SMTP id
 c11-20020a92cf4b000000b0035d59a2a323mr2106334ilr.37.1701649674103; 
 Sun, 03 Dec 2023 16:27:54 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 13/18] bootm: Drop arguments from do_bootm_states() and rename
Date: Sun,  3 Dec 2023 17:26:29 -0700
Message-ID: <20231204002642.895926-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

Create a new struct which holds the information required by bootm. Set
this up for each existing caller.

Now that none of the functions called from do_bootm_states() need an
argv[] list, change the arguments of do_bootm_states() as well.

For booti make sure it only uses argv[] and argc at the top of the
function, so we can eventually refactor to remove these parameters.

Finally, rename the function to bootm_run_states() to better indicate
its purpose. The 'do_' prefix is used to indicate a command processor,
which this is now not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/lib/bootm.c |  2 +-
 boot/bootm.c          | 60 ++++++++++++-------------------------------
 cmd/booti.c           | 55 ++++++++++++++++++++++-----------------
 cmd/bootm.c           | 26 +++++++++++++++++--
 cmd/bootz.c           | 45 +++++++++++++++++++++++---------
 include/bootm.h       | 57 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 160 insertions(+), 85 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 05dbe6131728..339a875bdf20 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -216,7 +216,7 @@ static int boot_reloc_fdt(struct bootm_headers *images)
 {
 	/*
 	 * In case of legacy uImage's, relocation of FDT is already done
-	 * by do_bootm_states() and should not repeated in 'bootm prep'.
+	 * by bootm_run_states() and should not repeated in 'bootm prep'.
 	 */
 	if (images->state & BOOTM_STATE_FDT) {
 		debug("## FDT already relocated\n");
diff --git a/boot/bootm.c b/boot/bootm.c
index de5c32099ceb..1f46bb88b38e 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -989,35 +989,9 @@ unmap_image:
 	return ret;
 }
 
-/**
- * Execute selected states of the bootm command.
- *
- * Note the arguments to this state must be the first argument, Any 'bootm'
- * or sub-command arguments must have already been taken.
- *
- * Note that if states contains more than one flag it MUST contain
- * BOOTM_STATE_START, since this handles and consumes the command line args.
- *
- * Also note that aside from boot_os_fn functions and bootm_load_os no other
- * functions we store the return value of in 'ret' may use a negative return
- * value, without special handling.
- *
- * @param cmdtp		Pointer to bootm command table entry
- * @param flag		Command flags (CMD_FLAG_...)
- * @param argc		Number of subcommand arguments (0 = no arguments)
- * @param argv		Arguments
- * @param states	Mask containing states to run (BOOTM_STATE_...)
- * @param images	Image header information
- * @param boot_progress 1 to show boot progress, 0 to not do this
- * Return: 0 if ok, something else on error. Some errors will cause this
- *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
- *	then the intent is to boot an OS, so this function will not return
- *	unless the image type is standalone.
- */
-int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int states, struct bootm_headers *images,
-		    int boot_progress)
+int bootm_run_states(struct bootm_info *bmi, int states)
 {
+	struct bootm_headers *images = bmi->images;
 	boot_os_fn *boot_fn;
 	ulong iflag = 0;
 	int ret = 0, need_boot_fn;
@@ -1032,17 +1006,18 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -1119,7 +1094,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		ret = boot_selected_os(BOOTM_STATE_OS_FAKE_GO, images, boot_fn);
 		if (!ret && cmd_list)
-			ret = run_command_list(cmd_list, -1, flag);
+			ret = run_command_list(cmd_list, -1, 0);
 	}
 #endif
 
@@ -1150,19 +1125,11 @@ err:
 
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
@@ -1180,7 +1147,12 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 		printf("Failed to set cmdline\n");
 		return ret;
 	}
-	ret = do_bootm_states(&cmd, 0, 1, argv, states, &images, 1);
+	memset(&bmi, '\0', sizeof(bmi));
+	bmi.addr_fit = addr_str;
+	bmi.boot_progress = true;
+	bmi.images = &images;
+	bmi.cmd_name = "bootm";
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/booti.c b/cmd/booti.c
index 2db8f4a16ff2..57850a02edc9 100644
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
+	ret = bootm_run_states(bmi, BOOTM_STATE_START);
 
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
@@ -105,12 +103,25 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_info bmi;
+	int states;
 	int ret;
 
 	/* Consume 'booti' */
 	argc--; argv++;
 
-	if (booti_start(cmdtp, flag, argc, argv, &images))
+	memset(&bmi, '\0', sizeof(struct bootm_info));
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.boot_progress = true;
+	bmi.images = &images;
+	bmi.cmd_name = "booti";
+
+	if (booti_start(&bmi))
 		return 1;
 
 	/*
@@ -120,19 +131,17 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-#ifdef CONFIG_RISCV_SMODE
-	images.os.arch = IH_ARCH_RISCV;
-#elif CONFIG_ARM64
-	images.os.arch = IH_ARCH_ARM64;
-#endif
-	ret = do_bootm_states(cmdtp, flag, argc, argv,
-#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-			      BOOTM_STATE_RAMDISK |
-#endif
-			      BOOTM_STATE_MEASURE |
-			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-			      BOOTM_STATE_OS_GO,
-			      &images, 1);
+	if (IS_ENABLED(CONFIG_RISCV_SMODE))
+		images.os.arch = IH_ARCH_RISCV;
+	else if (IS_ENABLED(CONFIG_ARM64))
+		images.os.arch = IH_ARCH_ARM64;
+
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 6ded091dd559..68fb48f77a90 100644
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
@@ -103,7 +104,17 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, state, &images, 0);
+	memset(&bmi, '\0', sizeof(struct bootm_info));
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.images = &images;
+	bmi.cmd_name = "bootm";
+
+	ret = bootm_run_states(&bmi, state);
 
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
 	if (!ret && (state & BOOTM_STATE_PRE_LOAD))
@@ -120,6 +131,7 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct bootm_info bmi;
 	int states;
 	int ret;
 
@@ -151,7 +163,17 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		states |= BOOTM_STATE_MEASURE;
 	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
 		states |= BOOTM_STATE_OS_CMDLINE;
-	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
+
+	memset(&bmi, '\0', sizeof(struct bootm_info));
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.boot_progress = true;
+	bmi.images = &images;
+	ret = bootm_run_states(&bmi, states);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/cmd/bootz.c b/cmd/bootz.c
index a652879ea5ec..fa6743a71170 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -27,11 +27,21 @@ int __weak bootz_setup(ulong image, ulong *start, ulong *end)
 static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[], struct bootm_headers *images)
 {
-	int ret;
 	ulong zi_start, zi_end;
+	struct bootm_info bmi;
+	int ret;
+
+	memset(&bmi, '\0', sizeof(struct bootm_info));
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.boot_progress = true;
+	bmi.images = images;
 
-	ret = do_bootm_states(cmdtp, flag, argc, argv, BOOTM_STATE_START,
-			      images, 1);
+	ret = bootm_run_states(&bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel zImage entry point */
 	if (!argc) {
@@ -64,7 +74,8 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int ret;
+	struct bootm_info bmi;
+	int states, ret;
 
 	/* Consume 'bootz' */
 	argc--; argv++;
@@ -79,14 +90,24 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-	ret = do_bootm_states(cmdtp, flag, argc, argv,
-#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-			      BOOTM_STATE_RAMDISK |
-#endif
-			      BOOTM_STATE_MEASURE |
-			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-			      BOOTM_STATE_OS_GO,
-			      &images, 1);
+
+	memset(&bmi, '\0', sizeof(struct bootm_info));
+	if (argc)
+		bmi.addr_fit = argv[0];
+	if (argc > 1)
+		bmi.conf_ramdisk = argv[1];
+	if (argc > 2)
+		bmi.conf_fdt = argv[2];
+	bmi.boot_progress = 1;
+	bmi.images = &images;
+	bmi.cmd_name = "bootz";
+
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/include/bootm.h b/include/bootm.h
index b8d74d03a8c4..a3bef1ab88f2 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -16,6 +16,41 @@ struct cmd_tbl;
 #define BOOTM_ERR_OVERLAP		(-2)
 #define BOOTM_ERR_UNIMPLEMENTED	(-3)
 
+/**
+ * struct bootm_info() - information used when processing images to boot
+ *
+ * These mirror the first three arguments of the bootm command. They are
+ * designed to handle any type of image, but typically it is a FIT.
+ *
+ * @addr_fit: Address of image to bootm, as passed to
+ *	genimg_get_kernel_addr_fit() for processing:
+ *
+ *    NULL: Usees default load address, i.e. image_load_addr
+ *    <addr>: Uses hex address
+ *
+ * For FIT:
+ *    "[<addr>]#<conf>": Uses address (or image_load_addr) and also specifies
+ *	the FIT configuration to use
+ *    "[<addr>]:<subimage>": Uses address (or image_load_addr) and also
+ *	specifies the subimage name containing the OS
+ *
+ * @conf_ramdisk: Address (or with FIT, the name) of the ramdisk image, as
+ *	passed to boot_get_ramdisk() for processing, or NULL for none
+ * @conf_fdt: Address (or with FIT, the name) of the FDT image, as passed to
+ *	boot_get_fdt() for processing, or NULL for none
+ * @boot_progress: true to show boot progress
+ * @images: images information
+ * @cmd_name: command which invoked this operation, e.g. "bootm"
+ */
+struct bootm_info {
+	const char *addr_fit;
+	const char *conf_ramdisk;
+	const char *conf_fdt;
+	bool boot_progress;
+	struct bootm_headers *images;
+	const char *cmd_name;
+};
+
 /*
  *  Continue booting an OS image; caller already has:
  *  - copied image header to global variable `header'
@@ -82,9 +117,25 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
  */
 int bootm_measure(struct bootm_headers *images);
 
-int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int states, struct bootm_headers *images,
-		    int boot_progress);
+/**
+ * bootm_run_states() - Execute selected states of the bootm command.
+ *
+ * Note that if states contains more than one flag it MUST contain
+ * BOOTM_STATE_START, since this handles the addr_fit, conf_ramdisk and conf_fit
+ * members of @bmi
+ *
+ * Also note that aside from boot_os_fn functions and bootm_load_os, no other
+ * functions store the return value of in 'ret' may use a negative return
+ * value, without special handling.
+ *
+ * @bmi: bootm information
+ * @states	Mask containing states to run (BOOTM_STATE_...)
+ * Return: 0 if ok, something else on error. Some errors will cause this
+ *	function to perform a reboot! If states contains BOOTM_STATE_OS_GO
+ *	then the intent is to boot an OS, so this function will not return
+ *	unless the image type is standalone.
+ */
+int bootm_run_states(struct bootm_info *bmi, int states);
 
 void arch_preboot_os(void);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

