Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2D9E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70ED6896B1;
	Wed,  4 Dec 2024 00:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="itU1TCkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CEAA896A3; Wed,  4 Dec 2024 00:46:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632BB89699
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-841a6af60e9so195380839f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269587; x=1733874387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThJbMvvI97V5V2BNyjBZycQM63g/hRHqwrrsn22Kf6I=;
 b=itU1TCkWi8YHuENDpDNK1mOVxE6Fisx08G0kWgsXxU7QjeshfTGvC/A9Wz5WvU6Xva
 4d7tFIaFQYCgjuVPZGT7g38TC3FqTm1gayyYCArCtd3jTinVrWtPlhwQ+DDqHchX74Im
 mtMzNJuIpIHQPbvpE5FscYN+gWGykAAIieMkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269587; x=1733874387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThJbMvvI97V5V2BNyjBZycQM63g/hRHqwrrsn22Kf6I=;
 b=N7t38m64u27WrUUKsZnmiqWRQGjpwT5cIxuYO6+66YNtEKriuzh4IjSzvT6h3sp6+p
 7UK8PopypcE4JJZaY1VAMCjyL5BBymn0yemBKMz36M4x48O3VotUNccfcJ9bslFci3ug
 G7m8ZKsHHP3bW6E2eWdPc9m8oqAD9alYzqydlv0wXgrKn6hjztkHCtrnZ+M2f2UPKA6Z
 oNbj3dCbJ7B5bFjbbGpONOE0dONoB44R5Ugjdpa+c/vVwQ13KOy22/1EhgBAN3l097DQ
 ze5gQ+qdd3BpgMuyQLMLfEvcJ/tYsxGfWUK+u0pMmkC2eg/ltqm4wiv3iixcUFd15l8X
 ammQ==
X-Gm-Message-State: AOJu0Yy5ByxnP6+JbOscM6XTH7Ctxt9SuvvlG2ts9OiopDijyEOWOzZS
 e0ACPGQdj6joYuzj8vfLyYt3Zjzv+ccQH5wFokTGdrJopuWUjaKRoDr1vhxHsbwjVuf0kmJx7Ro
 =
X-Gm-Gg: ASbGncuvPIPTOR51MSkW4msETJjNjaHorYXp12rcwVRAm06exDdNViuzqGs0Ip2XOQG
 d1fZMQIVUgW0BaXgFU/zaWd1mtDfFra9wq2lRpd/qQIDxJCv9nHhZ83au17XHi34SjK1rTshJZi
 QCLBTFkjlhpuXgp5wRUhF+Ri16w2VuYHxbk1bafEjtoJGMDclYiU1X4mfEbsNWnvWZWN2oxoB2C
 m3Icgn/k6WW6Qksnc9PfYe6NjynanmZ7EoGJBwJaciHM/8AGGU9UMB6dBgIYh7njDOhg5SOS6iw
 RdDvtEhm5X4=
X-Google-Smtp-Source: AGHT+IE0BeceOEyM6JTV++X5puGblFmpl2TA45INu/2KTkCejkc1zm6bwBA1cUa/r5huMaovy+Q7Qg==
X-Received: by 2002:a05:6602:3fd3:b0:843:ec8d:be00 with SMTP id
 ca18e2360f4ac-8445b5e3716mr444164939f.13.1733269587046; 
 Tue, 03 Dec 2024 15:46:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 06/41] x86: Move the bootm state for zimage into cmd/
Date: Tue,  3 Dec 2024 16:45:24 -0700
Message-Id: <20241203234559.2938192-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Rather than holding the state in the implementation code, move it to the
command code. The state is now passed to the implementation functions
and can there (with future work) be pass in from bootstd, without going
through the commands.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 22 +++++-----
 arch/x86/lib/zimage.c         | 75 +++++++++++++++++------------------
 cmd/bootflow.c                |  5 ++-
 cmd/x86/zboot.c               | 20 ++++++----
 include/bootm.h               |  8 +++-
 5 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index b592057e58b..4ed6d8d5cc2 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -10,6 +10,8 @@
 #include <asm/bootparam.h>
 #include <asm/e820.h>
 
+struct bootm_info;
+
 /* linux i386 zImage/bzImage header. Offsets relative to
  * the start of the image */
 
@@ -42,8 +44,6 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-extern struct bootm_info bmi;
-
 /**
  * zboot_load() - Load a zimage
  *
@@ -51,21 +51,21 @@ extern struct bootm_info bmi;
  *
  * Return: 0 if OK, -ve on error
  */
-int zboot_load(void);
+int zboot_load(struct bootm_info *bmi);
 
 /**
  * zboot_setup() - Set up the zboot image reeady for booting
  *
  * Return: 0 if OK, -ve on error
  */
-int zboot_setup(void);
+int zboot_setup(struct bootm_info *bmi);
 
 /**
  * zboot_go() - Start the image
  *
  * Return: 0 if OK, -ve on error
  */
-int zboot_go(void);
+int zboot_go(struct bootm_info *bmi);
 
 /**
  * load_zimage() - Load a zImage or bzImage
@@ -104,6 +104,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
  *
  * Record information about a zimage so it can be booted
  *
+ * @bmi: Bootm information
  * @bzimage_addr: Address of the bzImage to boot
  * @bzimage_size: Size of the bzImage, or 0 to detect this
  * @initrd_addr: Address of the initial ramdisk, or 0 if none
@@ -114,14 +115,17 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
  * @cmdline: Environment variable containing the 'override' command line, or
  *	NULL to use the one in the setup block
  */
-void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
-		 ulong initrd_size, ulong base_addr, const char *cmdline);
+void zboot_start(struct bootm_info *bmi, ulong bzimage_addr, ulong bzimage_size,
+		 ulong initrd_addr, ulong initrd_size, ulong base_addr,
+		 const char *cmdline);
 
 /**
  * zboot_info() - Show simple info about a zimage
  *
- * Shows wherer the kernel was loaded and also the setup base
+ * Shows where the kernel was loaded and also the setup base
+ *
+ * @bmi: Bootm information
  */
-void zboot_info(void);
+void zboot_info(struct bootm_info *bmi);
 
 #endif
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 1afd3084144..fb69d0ef561 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -55,9 +55,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define COMMAND_LINE_SIZE	2048
 
-/* Current state of the boot */
-struct bootm_info bmi;
-
 static void build_command_line(char *command_line, int auto_boot)
 {
 	char *env_command_line;
@@ -366,13 +363,13 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 	return 0;
 }
 
-int zboot_load(void)
+int zboot_load(struct bootm_info *bmi)
 {
 	struct boot_params *base_ptr;
 	int ret;
 
-	if (bmi.base_ptr) {
-		struct boot_params *from = (struct boot_params *)bmi.base_ptr;
+	if (bmi->base_ptr) {
+		struct boot_params *from = (struct boot_params *)bmi->base_ptr;
 
 		base_ptr = (struct boot_params *)DEFAULT_SETUP_BASE;
 		log_debug("Building boot_params at 0x%8.8lx\n",
@@ -380,41 +377,41 @@ int zboot_load(void)
 		memset(base_ptr, '\0', sizeof(*base_ptr));
 		base_ptr->hdr = from->hdr;
 	} else {
-		base_ptr = load_zimage((void *)bmi.bzimage_addr, bmi.bzimage_size,
-				       &bmi.load_address);
+		base_ptr = load_zimage((void *)bmi->bzimage_addr,
+				       bmi->bzimage_size, &bmi->load_address);
 		if (!base_ptr) {
 			puts("## Kernel loading failed ...\n");
 			return -EINVAL;
 		}
 	}
-	bmi.base_ptr = base_ptr;
+	bmi->base_ptr = base_ptr;
 
-	ret = env_set_hex("zbootbase", map_to_sysmem(bmi.base_ptr));
+	ret = env_set_hex("zbootbase", map_to_sysmem(bmi->base_ptr));
 	if (!ret)
-		ret = env_set_hex("zbootaddr", bmi.load_address);
+		ret = env_set_hex("zbootaddr", bmi->load_address);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-int zboot_setup(void)
+int zboot_setup(struct bootm_info *bmi)
 {
-	struct boot_params *base_ptr = bmi.base_ptr;
+	struct boot_params *base_ptr = bmi->base_ptr;
 	int ret;
 
 	ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
-			   0, bmi.initrd_addr, bmi.initrd_size,
-			   (ulong)bmi.cmdline);
+			   0, bmi->initrd_addr, bmi->initrd_size,
+			   (ulong)bmi->cmdline);
 	if (ret)
 		return -EINVAL;
 
 	return 0;
 }
 
-int zboot_go(void)
+int zboot_go(struct bootm_info *bmi)
 {
-	struct boot_params *params = bmi.base_ptr;
+	struct boot_params *params = bmi->base_ptr;
 	struct setup_header *hdr = &params->hdr;
 	bool image_64bit;
 	ulong entry;
@@ -422,7 +419,7 @@ int zboot_go(void)
 
 	disable_interrupts();
 
-	entry = bmi.load_address;
+	entry = bmi->load_address;
 	image_64bit = false;
 	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
@@ -431,7 +428,7 @@ int zboot_go(void)
 	}
 
 	/* we assume that the kernel is in place */
-	ret = boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
+	ret = boot_linux_kernel((ulong)bmi->base_ptr, entry, image_64bit);
 
 	return ret;
 }
@@ -439,16 +436,18 @@ int zboot_go(void)
 int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
 		   ulong base, char *cmdline)
 {
+	struct bootm_info bmi;
 	int ret;
 
-	zboot_start(addr, size, initrd, initrd_size, base, cmdline);
-	ret = zboot_load();
+	bootm_init(&bmi);
+	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
+	ret = zboot_load(&bmi);
 	if (ret)
 		return log_msg_ret("ld", ret);
-	ret = zboot_setup();
+	ret = zboot_setup(&bmi);
 	if (ret)
 		return log_msg_ret("set", ret);
-	ret = zboot_go();
+	ret = zboot_go(&bmi);
 	if (ret)
 		return log_msg_ret("go", ret);
 
@@ -556,7 +555,8 @@ static void show_loader(struct setup_header *hdr)
 	printf("\n");
 }
 
-void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
+void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
+		 bool show_cmdline)
 {
 	struct setup_header *hdr;
 	const char *version;
@@ -597,7 +597,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)bmi.bzimage_addr);
+					    (void *)bmi->bzimage_addr);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
@@ -640,25 +640,24 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 		print_num("Kernel info offset", hdr->kernel_info_offset);
 }
 
-void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
-		 ulong initrd_size, ulong base_addr, const char *cmdline)
+void zboot_start(struct bootm_info *bmi, ulong bzimage_addr, ulong bzimage_size,
+		 ulong initrd_addr, ulong initrd_size, ulong base_addr,
+		 const char *cmdline)
 {
-	bootm_init(&bmi);
-
-	bmi.bzimage_size = bzimage_size;
-	bmi.initrd_addr = initrd_addr;
-	bmi.initrd_size = initrd_size;
+	bmi->bzimage_size = bzimage_size;
+	bmi->initrd_addr = initrd_addr;
+	bmi->initrd_size = initrd_size;
 	if (base_addr) {
-		bmi.base_ptr = map_sysmem(base_addr, 0);
-		bmi.load_address = bzimage_addr;
+		bmi->base_ptr = map_sysmem(base_addr, 0);
+		bmi->load_address = bzimage_addr;
 	} else {
-		bmi.bzimage_addr = bzimage_addr;
+		bmi->bzimage_addr = bzimage_addr;
 	}
-	bmi.cmdline = cmdline;
+	bmi->cmdline = cmdline;
 }
 
-void zboot_info(void)
+void zboot_info(struct bootm_info *bmi)
 {
 	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       bmi.load_address, bmi.base_ptr);
+	       bmi->load_address, bmi->base_ptr);
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 5668a0c9b19..5ab322ef00d 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -381,7 +381,10 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	bflow = std->cur_bootflow;
 
 	if (IS_ENABLED(CONFIG_X86) && x86_setup) {
-		zimage_dump(bflow->x86_setup, false);
+		struct bootm_info bmi;
+
+		bootm_init(&bmi);
+		zimage_dump(&bmi, bflow->x86_setup, false);
 
 		return 0;
 	}
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 0d0a8e53172..029ff4eb9fd 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -13,6 +13,9 @@
 #include <vsprintf.h>
 #include <asm/zimage.h>
 
+/* Current state of the boot */
+static struct bootm_info bmi;
+
 static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
@@ -21,6 +24,8 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	ulong base_addr;
 	int i;
 
+	bootm_init(&bmi);
+
 	log_debug("argc %d:", argc);
 	for (i = 0; i < argc; i++)
 		log_debug(" %s", argv[i]);
@@ -36,7 +41,7 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	base_addr = argc > 5 ? hextoul(argv[5], NULL) : 0;
 	cmdline = argc > 6 ? env_get(argv[6]) : NULL;
 
-	zboot_start(bzimage_addr, bzimage_size, initrd_addr, initrd_size,
+	zboot_start(&bmi, bzimage_addr, bzimage_size, initrd_addr, initrd_size,
 		    base_addr, cmdline);
 
 	return 0;
@@ -47,7 +52,7 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int ret;
 
-	ret = zboot_load();
+	ret = zboot_load(&bmi);
 	if (ret)
 		return ret;
 
@@ -61,12 +66,13 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("base is not set: use 'zboot load' first\n");
 		return CMD_RET_FAILURE;
 	}
-	if (zboot_setup()) {
+
+	if (zboot_setup(&bmi)) {
 		puts("Setting up boot parameters failed ...\n");
 		return CMD_RET_FAILURE;
 	}
 
-	if (zboot_setup())
+	if (zboot_setup(&bmi))
 		return CMD_RET_FAILURE;
 
 	return 0;
@@ -75,7 +81,7 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	zboot_info();
+	zboot_info(&bmi);
 
 	return 0;
 }
@@ -85,7 +91,7 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int ret;
 
-	ret = zboot_go();
+	ret = zboot_go(&bmi);
 	if (ret) {
 		printf("Kernel returned! (err=%d)\n", ret);
 		return CMD_RET_FAILURE;
@@ -105,7 +111,7 @@ static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("No zboot setup_base\n");
 		return CMD_RET_FAILURE;
 	}
-	zimage_dump(base_ptr, true);
+	zimage_dump(&bmi, base_ptr, true);
 
 	return 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 5fa9761629e..fe7f80b88a5 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -92,6 +92,8 @@ struct bootm_info {
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
+ * @bmi: Bootm information
+ *
  * Set up the struct with default values for all members:
  * @boot_progress is set to true and @images is set to the global images
  * variable. Everything else is set to NULL except @argc which is 0
@@ -107,7 +109,7 @@ void bootm_init(struct bootm_info *bmi);
  *  - disabled interrupts.
  *
  * @flag: Flags indicating what to do (BOOTM_STATE_...)
- * bmi: Bootm information
+ * @bmi: Bootm information
  * Return: 1 on error. On success the OS boots so this function does
  * not return.
  */
@@ -340,11 +342,13 @@ const char *zimage_get_kernel_version(struct boot_params *params,
  *
  * This shows all available information in a zimage that has been loaded.
  *
+ * @bmi: Bootm information
  * @base_ptr: Pointer to the boot parameters, typically at address
  *	DEFAULT_SETUP_BASE
  * @show_cmdline: true to show the full command line
  */
-void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
+void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
+		 bool show_cmdline);
 
 /*
  * bootm_boot_start() - Boot an image at the given address
-- 
2.34.1

