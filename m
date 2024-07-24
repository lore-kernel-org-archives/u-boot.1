Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3758DC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE0F889D3;
	Thu, 25 Jul 2024 00:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QTpN0XMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682D6888F6; Wed, 24 Jul 2024 17:09:53 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E625889A8
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-376069031c7so25054065ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833788; x=1722438588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb9FbakTPHKNRpUtKOwmNcMME4fa7oSV+9UlLtahLQc=;
 b=QTpN0XMBM651eYShYTKSBWHPhLiF1yETlVg5OwW6ObVW3k8cSaZRjB72VbCXeY4vzS
 QE3CUD2xq3+whjOmN6fjdTsEpqYQb2D+4zRfuJDKLu94+lQavxW31i5p1s7K0ztJJbj1
 ZIclDWLWIegoMpub0poffeS02941N5wfBWDvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833788; x=1722438588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb9FbakTPHKNRpUtKOwmNcMME4fa7oSV+9UlLtahLQc=;
 b=kvAMAT3hN55f8cNlcZ4s/lcc5F1byfYL50Air7+1zhbp9GPbr/Fo/c1bWuZaXDyAOp
 WFyBLKNXGamjYW/LeW/IUm+N2bL3PhYXOAuK37S72P3aDFXBBj7IlwBSBs6vmXfDVBiX
 kCiW5DHCxEvaO8vyem2pC5yJMHZYGdRr+q1RR96X/EV83P6XrJR4bSoal0xJ2E8L52s1
 lUiXylcHkflPclfiP/BCLn3WjB5rdYgg5ukDbj4W4lLLw6i6o8ZsrB/3cFQ6EC4FsKqE
 cAuAz2TVoOBoemtjhvrzDr8Y+xNwQwrkyuVezBuERKUB+87/nHdIBZzJUWyftTtLgTj5
 jOvw==
X-Gm-Message-State: AOJu0YxvRpxWVmgC3sZrV2lTFu1k+MUwt6ks5IN+Xoi6tP5I8yMulXJP
 hemLhj4nZdWK+Rgr711KCOCIY8Ra5LkQSoiDfnFq6RsGz8jOrmz/vXypmfE6PB+lY1pcFG/jcxs
 =
X-Google-Smtp-Source: AGHT+IHWHtrH2mfwH6uXuQunu7QwnPXAqJ1uqvmNF4+4KgDvMQqM86l8Hk+llo8gI1MoOIyV4MFLOA==
X-Received: by 2002:a05:6e02:2148:b0:398:17c8:6bd9 with SMTP id
 e9e14a558f8ab-39a217ce7d6mr115ab.8.1721833787371; 
 Wed, 24 Jul 2024 08:09:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrew Davis <afd@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Enrico Leto <enrico.leto@siemens.com>, Fabio Estevam <festevam@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, MD Danish Anwar <danishanwar@ti.com>,
 Marek Vasut <marex@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>, Stefano Babic <sbabic@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Vitor Soares <vitor.soares@toradex.com>
Subject: [PATCH 12/35] global_data: Convert have_console into a flag
Date: Wed, 24 Jul 2024 09:08:59 -0600
Message-Id: <20240724150922.2343249-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 00:57:39 +0200
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
index 29e185137ad..1935b1dd11b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1006,7 +1006,7 @@ static const init_fnc_t init_sequence_f[] = {
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
index 7794ddccade..de34fb06548 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -832,7 +832,7 @@ void preloader_console_init(void)
 
 	serial_init();		/* serial communications setup */
 
-	gd->have_console = 1;
+	gd->flags |= GD_FLG_HAVE_CONSOLE;
 
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 	puts("\nU-Boot " SPL_TPL_NAME " " PLAIN_VERSION " (" U_BOOT_DATE " - "
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index af568e99f47..f98d821e085 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -92,15 +92,6 @@ struct global_data {
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
@@ -219,7 +210,7 @@ struct global_data {
 #endif
 #ifdef CONFIG_TIMER
 	/**
-	 * @timer: timer instance for Driver Model
+s	 * @timer: timer instance for Driver Model
 	 */
 	struct udevice *timer;
 #endif
@@ -690,6 +681,12 @@ enum gd_flags {
 	 * @GD_FLG_HUSH_MODERN_PARSER: Use hush 2021 parser.
 	 */
 	GD_FLG_HUSH_MODERN_PARSER = 0x2000000,
+	/**
+	 * @GD_FLG_HAVE_CONSOLE: serial_init() was called and a console
+	 * is available. When not set, indicates that console input and output
+	 * drivers shall not be called.
+	 */
+	GD_FLG_HAVE_CONSOLE = 0x4000000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

