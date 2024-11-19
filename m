Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A3CD4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81DF89597;
	Tue, 19 Nov 2024 14:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="betQ11e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CC089597; Tue, 19 Nov 2024 14:19:06 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9508954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a752be9f4bso11621825ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022342; x=1732627142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyiY36/weQJnwf3I783WDFC1sAjosLTIpGSd4DbvcLk=;
 b=betQ11e6EY0Fz08H8PLo4cOCLDE2+oLvlQj+G0vVmxBctkhMCrsFWdbEDECzzyFqCK
 Sbfi44iBtkIvcwWVfzRrzuIOHNGBsQw2NrCKaOyhQmwdUuaa2rbpBO65ZHupd84z2MEl
 4JP5Xk/aetKGd7CTgvJLckegru9TvJcguF/ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022342; x=1732627142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyiY36/weQJnwf3I783WDFC1sAjosLTIpGSd4DbvcLk=;
 b=cGUs0VYGwSJQhkfvcQN//Xb2uGQms31r6JssS9D9co6fqLfUe5F/L+MdPIMZ/rruj9
 i2kK1oy29JU2mKlGPWjUedg9ZPABGodu1F4nQZZJdjxUmt102/QHU4CFyCxy0CJgELPC
 fmhbcCcO2g/Y6zaDspwfciFsdrrHvVylebfgOoCCO/nA8BynBvJXSoaVzJ2NRKuk9vZE
 BXWkI7ARUH3lKJQywOB7lzXfpS8lmCa+SoG7Dj3OYPVHbjiTVgJz7JOKGw773L5YekRN
 A4FpwmzsuuVFpCGiBwdQV5L4yjTGPnKRdnM+NuC1VhkHKKcJ+5HlqJAyk0jmnJ02grNZ
 Rw/w==
X-Gm-Message-State: AOJu0Yw4zArNp55MLnn+bkbekTKW8fv7RaFwODFYhyi8UczqZEQnznnn
 XKeaDKnbYxrKppjqxusG982w7y9Q+J+Le9ehucynrcyuhIbam+kOC36F1rp/E4aQI5ai0Zf5zaE
 =
X-Google-Smtp-Source: AGHT+IGDfrYk3JHJUPfBxcXJw7TgRHENrwuMTtFbjbbLN/OBR2fw9OLOdJP26vhRy54OB1z5tdxz1Q==
X-Received: by 2002:a05:6e02:2167:b0:3a5:e1a8:8ab1 with SMTP id
 e9e14a558f8ab-3a748002cebmr174140865ab.3.1732022341870; 
 Tue, 19 Nov 2024 05:19:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 04/39] x86: Move x86 zboot state into struct bootm_info
Date: Tue, 19 Nov 2024 06:18:09 -0700
Message-Id: <20241119131844.4078144-5-sjg@chromium.org>
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

This structure is supposed to handle any type of booting
programmatically, i.e. without needing a command to be executed. Move
the x86-specific members into it and use it instead of
struct zboot_state. Provide a macro so access is possible without adding
lots of #ifdefs to the code.

This will allow the struct to be used for all four types of booting
(bootm, bootz, booti and zboot).

Call bootm_init() to init the state, to match other boot methods.

Note that some rationalisation could be performed on this. But this
is tricky since addresses are stored as strings in several places. Also
some strings combine multiple arguments into one. So to keep this task
somewhat manageable, we content ourselves with just getting everything
into the same struct

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h | 29 +----------------------------
 arch/x86/lib/zimage.c         |  4 ++--
 include/bootm.h               | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 76b2a797ccf..13a08850dfb 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -42,34 +42,7 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-/**
- * struct zboot_state - Current state of the boot
- *
- * @bzimage_addr: Address of the bzImage to boot, or 0 if the image has already
- *	been loaded and does not exist (as a cohesive whole) in memory
- * @bzimage_size: Size of the bzImage, or 0 to detect this
- * @initrd_addr: Address of the initial ramdisk, or 0 if none
- * @initrd_size: Size of the initial ramdisk, or 0 if none
- * @load_address: Address where the bzImage is moved before booting, either
- *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
- *	This is set up when loading the zimage
- * @base_ptr: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
- *	This is set up when loading the zimage
- * @cmdline: Environment variable containing the 'override' command line, or
- *	NULL to use the one in the setup block
- */
-struct zboot_state {
-	ulong bzimage_addr;
-	ulong bzimage_size;
-	ulong initrd_addr;
-	ulong initrd_size;
-	ulong load_address;
-	struct boot_params *base_ptr;
-	const char *cmdline;
-};
-
-extern struct zboot_state state;
+extern struct bootm_info state;
 
 /**
  * zboot_load() - Load a zimage
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 53fc81f57a2..c2cf52658e9 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,7 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct zboot_state state;
+struct bootm_info state;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -643,7 +643,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	memset(&state, '\0', sizeof(state));
+	bootm_init(&state);
 
 	state.bzimage_size = bzimage_size;
 	state.initrd_addr = initrd_addr;
diff --git a/include/bootm.h b/include/bootm.h
index 154fb98cfcd..5fa9761629e 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -44,6 +44,21 @@ struct cmd_tbl;
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
  * @argv: NULL-terminated list of arguments, or NULL if there are no arguments
+ *
+ * For zboot:
+ * @bzimage_addr: Address of the bzImage to boot, or 0 if the image has already
+ *	been loaded and does not exist (as a cohesive whole) in memory
+ * @bzimage_size: Size of the bzImage, or 0 to detect this
+ * @initrd_addr: Address of the initial ramdisk, or 0 if none
+ * @initrd_size: Size of the initial ramdisk, or 0 if none
+ * @load_address: Address where the bzImage is moved before booting, either
+ *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
+ *	This is set up when loading the zimage
+ * @base_ptr: Pointer to the boot parameters, typically at address
+ *	DEFAULT_SETUP_BASE
+ *	This is set up when loading the zimage
+ * @cmdline: Environment variable containing the 'override' command line, or
+ *	NULL to use the one in the setup block
  */
 struct bootm_info {
 	const char *addr_img;
@@ -54,8 +69,26 @@ struct bootm_info {
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
+
+	/* zboot items */
+#ifdef CONFIG_X86
+	ulong bzimage_addr;
+	ulong bzimage_size;
+	ulong initrd_addr;
+	ulong initrd_size;
+	ulong load_address;
+	struct boot_params *base_ptr;
+	const char *cmdline;
+#endif
 };
 
+/* macro to allow setting fields in generic code */
+#ifdef CONFIG_X86
+#define bootm_x86_set(_bmi, _field, _val)	(_bmi)->_field = (_val)
+#else
+#define bootm_x86_set(_bmi, _field, _val)
+#endif
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.34.1

