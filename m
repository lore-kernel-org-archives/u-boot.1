Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB35EC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E2588E42;
	Wed, 21 Aug 2024 18:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IKcrGKtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087E888E2B; Wed, 21 Aug 2024 18:19:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6E088E15
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70940c9657dso3247424a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257186; x=1724861986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUWyJ+oXoyA79PSBiCooKTspE2Wlm7y904C6v8cB720=;
 b=IKcrGKtYzlowgoTrD9+zcaLj+lu8PYgJEyrUhA+4CC+UZvf5HEUfYBbIpp8LBmW2rQ
 qd9HfWnr1q5TjrhwHy4Q7UQp0BXhjCGjvXgcXJpOPZJ7GiKkj+qfrHKb35Qd+Z0pxMZf
 Gr0pdRMreGxbUBoRVnCAQKBxMWdVoR2Q0BS2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257186; x=1724861986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUWyJ+oXoyA79PSBiCooKTspE2Wlm7y904C6v8cB720=;
 b=Og4bTsvUv19tVIIdXqTaEjVr3yecnHcE2zYXHuihyRjrpHXYtBqo2Zm/FnIQOUNuvu
 tHACMfToc075yuz3o1CZXi3pKPhClVmQSeZ0l3xCajD5j3F0YUw/KkXWm3RdsVCFf3zf
 0XJbHrXcaujyywU9qsfwQDmmPxRDmFFNpA9l9Gdm2K3dQF/7stVhWl9HA/NMM9Mp+Igb
 FkFaAxOIDKI/R2yvHoVgauquQNZdzE3mS9iraUTWlpz1ATkK9j4s34EWOCkpmc6s9ZaA
 /RqY8XMVY9gj4uUxwmD8CJGdBxPrr4rhpazBy8/C2Mza8s17QovaULKDh3ikPLTsGAg4
 9coA==
X-Gm-Message-State: AOJu0YzKvkPPrmpNiop7zFH2c0rISc6ncreHlllVUiw52oq70Iw739c2
 WNxs4wUCk6dBRbVFD6b5NU/K9f/nDe+fNWvXcsN51HiD9/OCTphbY91+qYAslnIgEd4VD8U6Yb0
 =
X-Google-Smtp-Source: AGHT+IE7ZBoHI5UTsG88jQajmz/qPX2VTApoi0fEfrmlxhVKoyKA9B4sX8z2KJTkV5FPFmtaDvnrfQ==
X-Received: by 2002:a05:6830:3490:b0:703:79c6:a9ba with SMTP id
 46e09a7af769-70df85f4b75mr3008876a34.7.1724257186261; 
 Wed, 21 Aug 2024 09:19:46 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/35] global_data: Convert have_console into a flag
Date: Wed, 21 Aug 2024 10:19:04 -0600
Message-Id: <20240821161927.695717-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

We don't need a full word for this boolean value. Convert it into a flag
to save space in global_data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/arm926ejs/mxs/spl_boot.c |  2 +-
 arch/arm/mach-exynos/spl_boot.c       |  2 +-
 arch/arm/mach-k3/common.c             |  2 +-
 arch/arm/mach-k3/r5/sysfw-loader.c    |  2 +-
 board/siemens/common/board_am335x.c   |  2 +-
 common/board_f.c                      |  2 +-
 common/console.c                      | 14 +++++++-------
 common/spl/spl.c                      |  2 +-
 include/asm-generic/global_data.h     | 17 +++++++----------
 9 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
index 76a69d7f958..dd748328293 100644
--- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
+++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
@@ -117,7 +117,7 @@ static void mxs_spl_console_init(void)
 	gd->bd = &bdata;
 	gd->baudrate = CONFIG_BAUDRATE;
 	serial_init();
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 #endif
 }
 
diff --git a/arch/arm/mach-exynos/spl_boot.c b/arch/arm/mach-exynos/spl_boot.c
index bd5a06447b9..219d7fbf957 100644
--- a/arch/arm/mach-exynos/spl_boot.c
+++ b/arch/arm/mach-exynos/spl_boot.c
@@ -312,7 +312,7 @@ static void setup_global_data(gd_t *gdp)
 	memzero((void *)gd, sizeof(gd_t));
 	gd->flags |= GD_FLG_RELOC;
 	gd->baudrate = CONFIG_BAUDRATE;
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 }
 
 void board_init_f(unsigned long bootflag)
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index eaa7d361767..df48ec8d479 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -104,7 +104,7 @@ int early_console_init(void)
 
 	gd->cur_serial_dev = dev;
 	gd->flags |= GD_FLG_SERIAL_READY;
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 	return 0;
 }
diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index 94d051ba0fb..188731e673d 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -451,7 +451,7 @@ void k3_sysfw_loader(bool rom_loaded_sysfw,
 		 * the case when continuing to boot serially from the same
 		 * UART that the ROM loaded the initial bootloader from.
 		 */
-		if (!gd->have_console)
+		if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 			early_console_init();
 #endif
 		ret = spl_ymodem_load_image(&spl_image, &bootdev);
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index 2a727606bc3..e6537b0675a 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -36,7 +36,7 @@ void set_mux_conf_regs(void)
 	/* enable early the console */
 	gd->baudrate = CONFIG_BAUDRATE;
 	serial_init();
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 	siemens_ee_setup();
 	if (draco_read_eeprom() < 0)
diff --git a/common/board_f.c b/common/board_f.c
index 454426d921c..a1f8641ae26 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1022,7 +1022,7 @@ static const init_fnc_t init_sequence_f[] = {
 void board_init_f(ulong boot_flags)
 {
 	gd->flags = boot_flags;
-	gd->have_console = 0;
+	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
 
 	if (initcall_run_list(init_sequence_f))
 		hang();
diff --git a/common/console.c b/common/console.c
index 63f78004fdb..30ddefef6b1 100644
--- a/common/console.c
+++ b/common/console.c
@@ -586,7 +586,7 @@ int getchar(void)
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
 		return 0;
 
-	if (!gd->have_console)
+	if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 		return 0;
 
 	ch = console_record_getc();
@@ -607,7 +607,7 @@ int tstc(void)
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
 		return 0;
 
-	if (!gd->have_console)
+	if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 		return 0;
 
 	if (console_record_tstc())
@@ -715,7 +715,7 @@ void putc(const char c)
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
 		return;
 
-	if (!gd->have_console)
+	if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 		return pre_console_putc(c);
 
 	if (gd->flags & GD_FLG_DEVINIT) {
@@ -759,7 +759,7 @@ void puts(const char *s)
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
 		return;
 
-	if (!gd->have_console)
+	if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 		return pre_console_puts(s);
 
 	if (gd->flags & GD_FLG_DEVINIT) {
@@ -793,7 +793,7 @@ void flush(void)
 	if (IS_ENABLED(CONFIG_DISABLE_CONSOLE) && (gd->flags & GD_FLG_DISABLE_CONSOLE))
 		return;
 
-	if (!gd->have_console)
+	if (!(gd->flags & GD_FLG_HAVE_CONSOLE))
 		return;
 
 	if (gd->flags & GD_FLG_DEVINIT) {
@@ -872,7 +872,7 @@ static int ctrlc_disabled = 0;	/* see disable_ctrl() */
 static int ctrlc_was_pressed = 0;
 int ctrlc(void)
 {
-	if (!ctrlc_disabled && gd->have_console) {
+	if (!ctrlc_disabled && (gd->flags & GD_FLG_HAVE_CONSOLE)) {
 		if (tstc()) {
 			switch (getchar()) {
 			case 0x03:		/* ^C - Control C */
@@ -1011,7 +1011,7 @@ int console_announce_r(void)
 /* Called before relocation - use serial functions */
 int console_init_f(void)
 {
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 	console_update_silent();
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index d6a364de6ee..651b434f615 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -840,7 +840,7 @@ void preloader_console_init(void)
 
 	serial_init();		/* serial communications setup */
 
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 	puts("\nU-Boot " SPL_TPL_NAME " " PLAIN_VERSION " (" U_BOOT_DATE " - "
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index a06b508bebb..0e276c5dece 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -93,15 +93,6 @@ struct global_data {
 	 */
 	unsigned long board_type;
 #endif
-	/**
-	 * @have_console: console is available
-	 *
-	 * A value of 1 indicates that serial_init() was called and a console
-	 * is available.
-	 * A value of 0 indicates that console input and output drivers shall
-	 * not be called.
-	 */
-	unsigned long have_console;
 #if CONFIG_IS_ENABLED(PRE_CONSOLE_BUFFER)
 	/**
 	 * @precon_buf_idx: pre-console buffer index
@@ -220,7 +211,7 @@ struct global_data {
 #endif
 #ifdef CONFIG_TIMER
 	/**
-	 * @timer: timer instance for Driver Model
+s	 * @timer: timer instance for Driver Model
 	 */
 	struct udevice *timer;
 #endif
@@ -709,6 +700,12 @@ enum gd_flags {
 	 * @GD_FLG_UPL: Read/write a Universal Payload (UPL) handoff
 	 */
 	GD_FLG_UPL = 0x4000000,
+	/**
+	 * @GD_FLG_HAVE_CONSOLE: serial_init() was called and a console
+	 * is available. When not set, indicates that console input and output
+	 * drivers shall not be called.
+	 */
+	GD_FLG_HAVE_CONSOLE = 0x8000000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

