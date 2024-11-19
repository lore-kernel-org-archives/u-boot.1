Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD93D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394238959E;
	Tue, 19 Nov 2024 14:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VCj1gwx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E25895AA; Tue, 19 Nov 2024 14:19:08 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E258C895A1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a75f77d859so9769135ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022344; x=1732627144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FM3x6glm5Kjz7guXpr60rbNAtfzGfSxZggl/Mhklmiw=;
 b=VCj1gwx+IxtjiqaK7KWW93eQ60mWlQ935R4Wcm5Ks2JdqSWbTMCE/C9jRyZGXdGDcW
 dcWuE/Z85Umz9XjqYuQRF4AENNqH6ivdTrz+xGUJjKvVzebKX+kbBSm098ei0jeiOpza
 GLnOpvTkrOHI3SyFpxZ/NAuULVBuGLf3kWeuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022344; x=1732627144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FM3x6glm5Kjz7guXpr60rbNAtfzGfSxZggl/Mhklmiw=;
 b=FlzsBC9JKzXlFp16gpnys+cCX4eu/ZjEdbvTtPPYlaukH02JyqkiyOTB6vHZ+s7c8F
 gNRg7dLhqqH2/Ut1b5xUeS7+8YUxbZqjYAibVXp7jpuPU6YBCr/9d0jOs9Q3znxgS4wK
 4VsKfzE37LYXZnI9Mqkd6qzJe4GKSPPtXPGaFcvtwPm0cLuUMW61/6qRQCSj8FtPH/iH
 6RCXg3VB4UiZpnYs0pPWo51burtiNcHNHpQdOV6GJKuq997hAENZuGJ4l4zT+SAYqGDu
 3IvuIjMfp5b7vvkolO7/vnun6z0p63oC4pavp8V4swS7IN3obwA08P/JjHhWp6aIz5ty
 AY+A==
X-Gm-Message-State: AOJu0Ywz8OORDxeI7PN1XvYzg08BXR5BUqc66wcDnsR0EIm8MgFmXK5v
 GE5oayfxBXasbX0H4KjE8IJZeD4ByskopLDS+mWDOu3sjP9GNq8oJgOAhC7gsl5gbLqzxJdy4tk
 =
X-Google-Smtp-Source: AGHT+IEacB1X6clL48Ru4/8jFRt0QGPRmcDDMJyfAa3WhgCY2+oj76G9u61SCyd9ZpHI1no33IyghQ==
X-Received: by 2002:a05:6e02:168e:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3a78208bae5mr2378365ab.22.1732022344053; 
 Tue, 19 Nov 2024 05:19:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 05/39] x86: Rename state to bmi
Date: Tue, 19 Nov 2024 06:18:10 -0700
Message-Id: <20241119131844.4078144-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

