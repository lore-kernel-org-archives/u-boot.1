Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578EE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F349D89639;
	Fri,  6 Dec 2024 03:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmgrGn8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1433989641; Fri,  6 Dec 2024 03:36:51 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1108918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so56623139f.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452607; x=1734057407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoPhzhnTJIgh3cFnLV8Y5mcUSaG4DWjCwt+l8t03jaA=;
 b=ZmgrGn8ZCFpHN8Lihcr3aAu7i+mL5GllbRnoHh15a7YRDsRkNRu6degUvBCoUMD0y3
 Z9P5A1Vd3z+6hZ2dn0Yj0tXvYKmUdY/lJYfl2e5zf1EzQ5lYbL+yxdTEDbElH/2Hy677
 1omEXc5Af8vqffc/g+GnTUN5ar6OxlTHPL5+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452607; x=1734057407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoPhzhnTJIgh3cFnLV8Y5mcUSaG4DWjCwt+l8t03jaA=;
 b=ZMZRbL0y9bPT+3TvuVUlGN8rAb1YOsS3bVI3LmqgxwuPcNgFuWg8YqI0EYiRmOZX61
 xF+wxJDRKaTeAOmgbhR24oLhMj0tO65iH0pd5KJV//CDdPBElwdgj4ewRobZ6lf1EV8B
 fwF62bH9kYHwCWEvxhX3oHN2yII8uFU1k5ZeKFrUKdjV79OFkCLBmzupSU4kvPmWswoK
 TQvgblrKWvteGxyTEayED2FR/gJD/Yp/b6o6XXIDY3IAymMHW6PwtJfdZ/WZOX3S47lN
 SbVCTQ4ntpKODgumtW9MEcVsGhdP9/KDNm+5iJhJ16bT4LLDSiih2MTeucI4JxmWvhIX
 YlBg==
X-Gm-Message-State: AOJu0YzM6hMS6lAg5zqKUHnvNO1jF61ery+eRz+aQfGwqJE42z4MpXTC
 FlYqMF8GgHLNMDsmdu27hOLCqUqTeYkcoAGPHAQZQ7Gk9O4QrXnwHOKPLpLra/zWn1A90YfBLqo
 =
X-Gm-Gg: ASbGnctJ28VeDbx6XkAuQMGyBGF7zJHJPKW9mEQBHroMwx0cH6I60YpIEr5Vl5yQ3Z0
 kv7i4s7Uc+q4nmp9Etqlpq6m3HfyUZzmUtTBkTvBP9Iqg4t8ZQ6I0tkNgiTFzcCaVQA7OoAV+kS
 8INvSkoiwtgBrl141SQ1FY6NJk23F/sY7YnjbZFvKCWYP73KmHXy4abYmqn/hPUdKEcaISa9BUO
 8IZktidMpVJblW+De6x3iqcnWF1ay6ADC4gJCQuQbaUH7Xu1W8kiFy9ZW8U2+0HTP2pcverXnlw
 qHnmho6ya4o=
X-Google-Smtp-Source: AGHT+IH/8Tdty+fDd9jujJO0n5CLBpwDYA7Q647IblEw7itNckMzrjX+kvVMZCXni5FOnwrAYVg8Cg==
X-Received: by 2002:a05:6602:15ca:b0:83a:b79c:66b6 with SMTP id
 ca18e2360f4ac-8447e1fdd82mr224815639f.2.1733452606838; 
 Thu, 05 Dec 2024 18:36:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 05/46] x86: Rename state to bmi
Date: Thu,  5 Dec 2024 19:35:44 -0700
Message-Id: <20241206023626.2456858-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Use the common name for the struct, in preparation for passing it around
between functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/zimage.c         | 48 +++++++++++++++++------------------
 cmd/x86/zboot.c               |  4 +--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 13a08850dfb..b592057e58b 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -42,7 +42,7 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-extern struct bootm_info state;
+extern struct bootm_info bmi;
 
 /**
  * zboot_load() - Load a zimage
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index c2cf52658e9..1afd3084144 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,7 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct bootm_info state;
+struct bootm_info bmi;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -371,8 +371,8 @@ int zboot_load(void)
 	struct boot_params *base_ptr;
 	int ret;
 
-	if (state.base_ptr) {
-		struct boot_params *from = (struct boot_params *)state.base_ptr;
+	if (bmi.base_ptr) {
+		struct boot_params *from = (struct boot_params *)bmi.base_ptr;
 
 		base_ptr = (struct boot_params *)DEFAULT_SETUP_BASE;
 		log_debug("Building boot_params at 0x%8.8lx\n",
@@ -380,18 +380,18 @@ int zboot_load(void)
 		memset(base_ptr, '\0', sizeof(*base_ptr));
 		base_ptr->hdr = from->hdr;
 	} else {
-		base_ptr = load_zimage((void *)state.bzimage_addr, state.bzimage_size,
-				       &state.load_address);
+		base_ptr = load_zimage((void *)bmi.bzimage_addr, bmi.bzimage_size,
+				       &bmi.load_address);
 		if (!base_ptr) {
 			puts("## Kernel loading failed ...\n");
 			return -EINVAL;
 		}
 	}
-	state.base_ptr = base_ptr;
+	bmi.base_ptr = base_ptr;
 
-	ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
+	ret = env_set_hex("zbootbase", map_to_sysmem(bmi.base_ptr));
 	if (!ret)
-		ret = env_set_hex("zbootaddr", state.load_address);
+		ret = env_set_hex("zbootaddr", bmi.load_address);
 	if (ret)
 		return ret;
 
@@ -400,12 +400,12 @@ int zboot_load(void)
 
 int zboot_setup(void)
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 	int ret;
 
 	ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
-			   0, state.initrd_addr, state.initrd_size,
-			   (ulong)state.cmdline);
+			   0, bmi.initrd_addr, bmi.initrd_size,
+			   (ulong)bmi.cmdline);
 	if (ret)
 		return -EINVAL;
 
@@ -414,7 +414,7 @@ int zboot_setup(void)
 
 int zboot_go(void)
 {
-	struct boot_params *params = state.base_ptr;
+	struct boot_params *params = bmi.base_ptr;
 	struct setup_header *hdr = &params->hdr;
 	bool image_64bit;
 	ulong entry;
@@ -422,7 +422,7 @@ int zboot_go(void)
 
 	disable_interrupts();
 
-	entry = state.load_address;
+	entry = bmi.load_address;
 	image_64bit = false;
 	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
@@ -431,7 +431,7 @@ int zboot_go(void)
 	}
 
 	/* we assume that the kernel is in place */
-	ret = boot_linux_kernel((ulong)state.base_ptr, entry, image_64bit);
+	ret = boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
 
 	return ret;
 }
@@ -597,7 +597,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)bmi.bzimage_addr);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
@@ -643,22 +643,22 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	bootm_init(&state);
+	bootm_init(&bmi);
 
-	state.bzimage_size = bzimage_size;
-	state.initrd_addr = initrd_addr;
-	state.initrd_size = initrd_size;
+	bmi.bzimage_size = bzimage_size;
+	bmi.initrd_addr = initrd_addr;
+	bmi.initrd_size = initrd_size;
 	if (base_addr) {
-		state.base_ptr = map_sysmem(base_addr, 0);
-		state.load_address = bzimage_addr;
+		bmi.base_ptr = map_sysmem(base_addr, 0);
+		bmi.load_address = bzimage_addr;
 	} else {
-		state.bzimage_addr = bzimage_addr;
+		bmi.bzimage_addr = bzimage_addr;
 	}
-	state.cmdline = cmdline;
+	bmi.cmdline = cmdline;
 }
 
 void zboot_info(void)
 {
 	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       state.load_address, state.base_ptr);
+	       bmi.load_address, bmi.base_ptr);
 }
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 40f67a75593..0d0a8e53172 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -57,7 +57,7 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
-	if (!state.base_ptr) {
+	if (!bmi.base_ptr) {
 		printf("base is not set: use 'zboot load' first\n");
 		return CMD_RET_FAILURE;
 	}
@@ -97,7 +97,7 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 
 	if (argc > 1)
 		base_ptr = (void *)hextoul(argv[1], NULL);
-- 
2.34.1

