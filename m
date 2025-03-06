Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9771EC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB8B80BAA;
	Thu,  6 Mar 2025 01:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IzVmj1lG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7DB80F9E; Thu,  6 Mar 2025 01:26:42 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A7C80BAA
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85add719f7aso3235539f.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220796; x=1741825596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCNsGUIdzL37ZqkP6ANC1aTk2Gq92+YHdamThBYWY78=;
 b=IzVmj1lGl5bN4grgI5MZOiRZ9VTyNd1GOW/Zt7XC/HtZkXLrFrTPxcWtm6K8TcFDIN
 8FiVAwJKK151+cQreaBHbeNPu8uluOcht6reEPyxZKaRoN6bBKBO9sPvhZ3F6yEgA5Yo
 oJ16vESw8/dq3YhNsHG13CNchlVeAkJ+yKcz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220796; x=1741825596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCNsGUIdzL37ZqkP6ANC1aTk2Gq92+YHdamThBYWY78=;
 b=bJYb7Ii/YkRjvjpz7mdgj/hbhkQ4crjBnjIZ5/GTxT6NNTGe9/uUAoi5tvJiGRve2I
 1ra0vF/IVt0J6onaiMENHM543NOM3bmt/VpWeqdYEr1XQAqV4kxZvCmQU74u+PN69YXR
 mJtx5iSCXdylYNrHk73cTnM/uzFhGfrpg2ZLXrkT+mbqIiYFyf9NJ/ve2ugL84i2Eu6t
 9N1Hx2gFQzdvXBrkcpqPrF/94ilQDb4vGsWN+dPIbmMQuF7xCN2E/wsAvGyiDapoErs8
 CTOtTJHLRu7eV0NTMFk6BHEHZ0kjnhBT5XRim5HWGXYGm3ZVyJJyW7iVvgucck8G3ocp
 ITYA==
X-Gm-Message-State: AOJu0Yyat0C2bQ5Mrh3ETPL6EAMxH9WIUY287BdgtHZ1mF1W+JCexyxI
 3+tCpwbrb3Dkn8+c0O61pg19DI/UXTruRfqjn0XXjMr6UwAfqOOvOVmrAShIsfQbbO0KxdNWaGE
 =
X-Gm-Gg: ASbGncs4BFxw7KhMPxWsQOIpx+WT9ulkoHyBSqDhVQzgFhmbqGVgSoaohZ+tDkBaoO4
 qPctJFScAqS+zR0oHzI4PRpUKm4rG1glnP6LkGx05m0v4YOcycDiH2uGAHbY4uCZFbTOkZRmit7
 DR30RNnlaQS7rBcnWNpb1smpN6G55tLPUWTwyTW9ZCLHfcLZk013I0LEQh6ufhWBEjaL9X5bJo5
 uDKLUJzFV+uuCqhhzYgIcSGSkgAJbfgD5uRWX3esfZRfS6wPyMA4bhEpeI7AKHMqk/JBV/4rnc6
 MN/LnZjOVJNUuNlZu9CX6E0LuJbsjW4BMzyx7KFk9LquGvyFfCW3n41eUVQBuvoF/bQmz+QoxtD
 H+7idiw==
X-Google-Smtp-Source: AGHT+IELqYOOsLtlbBwPpDqGYdLV3KMJZtJf8ClmXJGpSX0XGfCauB0aCI+w9peZWfIyvI6iGbtW/w==
X-Received: by 2002:a05:6602:4a06:b0:85a:d71d:b2ce with SMTP id
 ca18e2360f4ac-85affbcf73bmr748550039f.14.1741220795824; 
 Wed, 05 Mar 2025 16:26:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v5 05/29] x86: Rename state to bmi
Date: Wed,  5 Mar 2025 17:24:59 -0700
Message-ID: <20250306002533.2380866-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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
index 1dbebfe8afd..991d0c84006 100644
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
@@ -430,7 +430,7 @@ int zboot_go(void)
 	}
 
 	/* we assume that the kernel is in place */
-	ret = boot_linux_kernel((ulong)state.base_ptr, entry, image_64bit);
+	ret = boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
 
 	return ret;
 }
@@ -596,7 +596,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)bmi.bzimage_addr);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
@@ -642,22 +642,22 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
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
2.43.0

