Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7BEEE49AA
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C06871FA;
	Tue, 22 Aug 2023 05:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hv8Y22/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075B687291; Tue, 22 Aug 2023 05:17:22 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B279987246
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7909307ecd1so137926739f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674237; x=1693279037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8M65vp6qWQ7fhpupbjFZkn4FP3ZJdmP0LsFxzS3kXYk=;
 b=Hv8Y22/Hp2jOzB/XfdM5Pdyxtk9yzR4vQAFPsbNlefVeg5YkfHvUUwx0GMZVjF5rYT
 iwu8XUjCiLI22n09lItgy5uxefJQcOaL8Pvapac0qKpWyw8gdQNqjgeXQfxMg+PMJeQ8
 WpGFZlKa/1bRvtNCV9ZDx+jTjU/w2qMQzEbuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674237; x=1693279037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8M65vp6qWQ7fhpupbjFZkn4FP3ZJdmP0LsFxzS3kXYk=;
 b=N5LEKR+3hfddgFJKZA7x7cwYSCrXDHab76EvtDrKk08JLfDTlhY/jToRiOuwbDWvkA
 cyfKAU9lh6ovO7XH03oP1+BWWapcG0p1K0BNdf1uTwmf/PWABdnf8DFVqZDyqCZVQN+G
 lnWuSJFmv0bTvLLCxb56Klo0Z8yZDWvQmyruvo8JiNCHYope40aKOor7m6nu+26tQDW5
 IYNP2u3MTUTAW6RoG8WQwNMj2+m8M8v0r53eHh+XGf2mKQVU5ce9am7+glhIl3+uTNk1
 kPp4P1gsyDbG1JWWFB6IZlADN9KyMgvTGsZRtKRC0MFCqJ75wMa1Wnv58LLmWKKJM0bm
 B24g==
X-Gm-Message-State: AOJu0Yzf67hKP0UrMyQJWxs2mVd0bY1OsoM2NK8Q9e3Elc6KaqwlEvBl
 88yz0coQVMTve8a14+Ehhl2N2jKtCz34MEFeUGA=
X-Google-Smtp-Source: AGHT+IFk3OzCqzj1h47x8ejqT/++8DlgjY8OegYUNUxMdJ3UiXyjmJB6wuZcsIJK9z7sHHdoiY2t+w==
X-Received: by 2002:a05:6602:2003:b0:783:3899:e1d0 with SMTP id
 y3-20020a056602200300b007833899e1d0mr9689426iod.6.1692674237113; 
 Mon, 21 Aug 2023 20:17:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/14] event: Convert existing spy records to simple
Date: Mon, 21 Aug 2023 21:16:56 -0600
Message-ID: <20230822031705.1340941-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Very few of the existing event-spy records use the arguments they are
passed. Update them to use a simple spy instead, to simplify the code.

Where an adaptor function is currently used, remove it where possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-imx/imx8/cpu.c                  |  4 +--
 arch/arm/mach-imx/imx8m/soc.c                 |  4 +--
 arch/arm/mach-imx/imx8ulp/soc.c               |  7 +----
 arch/arm/mach-imx/imx9/soc.c                  |  4 +--
 arch/arm/mach-omap2/am33xx/board.c            |  4 +--
 arch/arm/mach-omap2/hwinit-common.c           | 12 +++------
 arch/mips/mach-pic32/cpu.c                    | 10 ++-----
 arch/nios2/cpu/cpu.c                          |  4 +--
 arch/riscv/cpu/cpu.c                          |  4 +--
 arch/riscv/include/asm/system.h               |  2 +-
 arch/riscv/lib/spl.c                          |  2 +-
 arch/sandbox/cpu/start.c                      |  7 +----
 arch/x86/cpu/baytrail/cpu.c                   |  4 +--
 arch/x86/cpu/broadwell/cpu.c                  |  4 +--
 arch/x86/cpu/ivybridge/cpu.c                  |  4 +--
 arch/x86/cpu/quark/quark.c                    | 26 +++++++------------
 arch/x86/lib/fsp2/fsp_init.c                  |  4 +--
 board/google/chromebook_coral/coral.c         |  4 +--
 board/keymile/kmcent2/kmcent2.c               |  4 +--
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c |  4 +--
 board/starfive/visionfive2/spl.c              |  2 +-
 drivers/cpu/microblaze_cpu.c                  |  4 +--
 lib/fwu_updates/fwu.c                         |  4 +--
 test/py/tests/test_event_dump.py              |  2 +-
 24 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index c62357044e01..39ac0bc4140b 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -69,7 +69,7 @@ int arch_cpu_init(void)
 	return 0;
 }
 
-static int imx8_init_mu(void *ctx, struct event *event)
+static int imx8_init_mu(void)
 {
 	struct udevice *devp;
 	int node, ret;
@@ -91,7 +91,7 @@ static int imx8_init_mu(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, imx8_init_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8_init_mu);
 
 #if defined(CONFIG_ARCH_MISC_INIT)
 int arch_misc_init(void)
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 78b775f449d9..431ad959f533 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -532,7 +532,7 @@ static void imx_set_wdog_powerdown(bool enable)
 	writew(enable, &wdog3->wmcr);
 }
 
-static int imx8m_check_clock(void *ctx, struct event *event)
+static int imx8m_check_clock(void)
 {
 	struct udevice *dev;
 	int ret;
@@ -549,7 +549,7 @@ static int imx8m_check_clock(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, imx8m_check_clock);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8m_check_clock);
 
 static void imx8m_setup_snvs(void)
 {
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index e23cf60d126f..fd436dd88514 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -803,12 +803,7 @@ int imx8ulp_dm_post_init(void)
 
 	return 0;
 }
-
-static int imx8ulp_evt_dm_post_init(void *ctx, struct event *event)
-{
-	return imx8ulp_dm_post_init();
-}
-EVENT_SPY(EVT_DM_POST_INIT_F, imx8ulp_evt_dm_post_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx8ulp_dm_post_init);
 
 #if defined(CONFIG_SPL_BUILD)
 __weak void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f43b73a6c219..5d8687b6f438 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -552,7 +552,7 @@ int arch_cpu_init(void)
 	return 0;
 }
 
-int imx9_probe_mu(void *ctx, struct event *event)
+int imx9_probe_mu(void)
 {
 	struct udevice *devp;
 	int node, ret;
@@ -576,7 +576,7 @@ int imx9_probe_mu(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
 
 int timer_init(void)
 {
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index ecc0a592e993..a6307251c1fc 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -527,7 +527,7 @@ void board_init_f(ulong dummy)
 
 #endif
 
-static int am33xx_dm_post_init(void *ctx, struct event *event)
+static int am33xx_dm_post_init(void)
 {
 	hw_data_init();
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
@@ -535,4 +535,4 @@ static int am33xx_dm_post_init(void *ctx, struct event *event)
 #endif
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, am33xx_dm_post_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, am33xx_dm_post_init);
diff --git a/arch/arm/mach-omap2/hwinit-common.c b/arch/arm/mach-omap2/hwinit-common.c
index 771533394bcd..0e4572ca41a7 100644
--- a/arch/arm/mach-omap2/hwinit-common.c
+++ b/arch/arm/mach-omap2/hwinit-common.c
@@ -174,7 +174,7 @@ void __weak init_package_revision(void)
  * done in each of these cases
  * This function is called with SRAM stack.
  */
-void early_system_init(void)
+int early_system_init(void)
 {
 #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_MULTI_DTB_FIT)
 	int ret;
@@ -225,6 +225,8 @@ void early_system_init(void)
 	debug_uart_init();
 #endif
 	prcm_init();
+
+	return 0;
 }
 
 #ifdef CONFIG_SPL_BUILD
@@ -240,13 +242,7 @@ void board_init_f(ulong dummy)
 }
 #endif
 
-static int omap2_system_init(void *ctx, struct event *event)
-{
-	early_system_init();
-
-	return 0;
-}
-EVENT_SPY(EVT_DM_POST_INIT_F, omap2_system_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, early_system_init);
 
 /*
  * Routine: wait_for_command_complete
diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index ec3c2505313c..785a87b618b6 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -95,14 +95,8 @@ static void prefetch_init(void)
 	iounmap(regs);
 }
 
-/* arch specific CPU init after DM */
-static int pic32_flash_prefetch(void *ctx, struct event *event)
-{
-	/* flash prefetch */
-	prefetch_init();
-	return 0;
-}
-EVENT_SPY(EVT_DM_POST_INIT_F, pic32_flash_prefetch);
+/* arch-specific CPU init after DM: flash prefetch */
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, prefetch_init);
 
 /* Un-gate DDR2 modules (gated by default) */
 static void ddr2_pmd_ungate(void)
diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index da167f4b29e9..79a54d1bc259 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -64,7 +64,7 @@ static void copy_exception_trampoline(void)
 }
 #endif
 
-static int nios_cpu_setup(void *ctx, struct event *event)
+static int nios_cpu_setup(void)
 {
 	struct udevice *dev;
 	int ret;
@@ -80,7 +80,7 @@ static int nios_cpu_setup(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, nios_cpu_setup);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, nios_cpu_setup);
 
 static int altera_nios2_get_desc(const struct udevice *dev, char *buf,
 				 int size)
diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index ecfb1fb08c4b..4c050333c29d 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -91,7 +91,7 @@ static void dummy_pending_ipi_clear(ulong hart, ulong arg0, ulong arg1)
 }
 #endif
 
-int riscv_cpu_setup(void *ctx, struct event *event)
+int riscv_cpu_setup(void)
 {
 	int ret;
 
@@ -145,7 +145,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, riscv_cpu_setup);
 
 int arch_early_init_r(void)
 {
diff --git a/arch/riscv/include/asm/system.h b/arch/riscv/include/asm/system.h
index ffa7649f3f9e..87a804bfd5f7 100644
--- a/arch/riscv/include/asm/system.h
+++ b/arch/riscv/include/asm/system.h
@@ -26,6 +26,6 @@ struct event;
     } while (0)
 
 /* Hook to set up the CPU (called from SPL too) */
-int riscv_cpu_setup(void *ctx, struct event *event);
+int riscv_cpu_setup(void);
 
 #endif	/* __ASM_RISCV_SYSTEM_H */
diff --git a/arch/riscv/lib/spl.c b/arch/riscv/lib/spl.c
index f4d3b67e5dd0..9b242ed82129 100644
--- a/arch/riscv/lib/spl.c
+++ b/arch/riscv/lib/spl.c
@@ -28,7 +28,7 @@ __weak void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
-	riscv_cpu_setup(NULL, NULL);
+	riscv_cpu_setup();
 
 	preloader_console_init();
 
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 234652872ecc..1026898727f5 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -119,12 +119,7 @@ int sandbox_early_getopt_check(void)
 
 	os_exit(0);
 }
-
-static int sandbox_misc_init_f(void *ctx, struct event *event)
-{
-	return sandbox_early_getopt_check();
-}
-EVENT_SPY(EVT_MISC_INIT_F, sandbox_misc_init_f);
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, sandbox_early_getopt_check);
 
 static int sandbox_cmdline_cb_help(struct sandbox_state *state, const char *arg)
 {
diff --git a/arch/x86/cpu/baytrail/cpu.c b/arch/x86/cpu/baytrail/cpu.c
index 4a7b4f617f8a..c270426d8208 100644
--- a/arch/x86/cpu/baytrail/cpu.c
+++ b/arch/x86/cpu/baytrail/cpu.c
@@ -45,7 +45,7 @@ static void hsuart_clock_set(void *base)
  * Configure the internal clock of both SIO HS-UARTs, if they are enabled
  * via FSP
  */
-static int baytrail_uart_init(void *ctx, struct event *event)
+static int baytrail_uart_init(void)
 {
 	struct udevice *dev;
 	void *base;
@@ -64,7 +64,7 @@ static int baytrail_uart_init(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, baytrail_uart_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, baytrail_uart_init);
 
 static void set_max_freq(void)
 {
diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index f30aebfe4c62..560b1f7893f6 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -25,7 +25,7 @@
 #include <asm/arch/pch.h>
 #include <asm/arch/rcb.h>
 
-static int broadwell_init_cpu(void *ctx, struct event *event)
+static int broadwell_init_cpu(void)
 {
 	struct udevice *dev;
 	int ret;
@@ -40,7 +40,7 @@ static int broadwell_init_cpu(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, broadwell_init_cpu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, broadwell_init_cpu);
 
 void set_max_freq(void)
 {
diff --git a/arch/x86/cpu/ivybridge/cpu.c b/arch/x86/cpu/ivybridge/cpu.c
index c988d7ff477f..e71a10bfd441 100644
--- a/arch/x86/cpu/ivybridge/cpu.c
+++ b/arch/x86/cpu/ivybridge/cpu.c
@@ -54,7 +54,7 @@ int arch_cpu_init(void)
 	return x86_cpu_init_f();
 }
 
-static int ivybridge_cpu_init(void *ctx, struct event *ev)
+static int ivybridge_cpu_init(void)
 {
 	struct pci_controller *hose;
 	struct udevice *bus, *dev;
@@ -86,7 +86,7 @@ static int ivybridge_cpu_init(void *ctx, struct event *ev)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, ivybridge_cpu_init);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, ivybridge_cpu_init);
 
 #define PCH_EHCI0_TEMP_BAR0 0xe8000000
 #define PCH_EHCI1_TEMP_BAR0 0xe8000400
diff --git a/arch/x86/cpu/quark/quark.c b/arch/x86/cpu/quark/quark.c
index 1be8e38cdf41..86d90d84ddba 100644
--- a/arch/x86/cpu/quark/quark.c
+++ b/arch/x86/cpu/quark/quark.c
@@ -248,22 +248,16 @@ int arch_cpu_init(void)
 	return 0;
 }
 
-static int quark_init_pcie(void *ctx, struct event *event)
-{
-	/*
-	 * Initialize PCIe controller
-	 *
-	 * Quark SoC holds the PCIe controller in reset following a power on.
-	 * U-Boot needs to release the PCIe controller from reset. The PCIe
-	 * controller (D23:F0/F1) will not be visible in PCI configuration
-	 * space and any access to its PCI configuration registers will cause
-	 * system hang while it is held in reset.
-	 */
-	quark_pcie_early_init();
-
-	return 0;
-}
-EVENT_SPY(EVT_DM_POST_INIT_F, quark_init_pcie);
+/*
+ * Initialize PCIe controller
+ *
+ * Quark SoC holds the PCIe controller in reset following a power on.
+ * U-Boot needs to release the PCIe controller from reset. The PCIe
+ * controller (D23:F0/F1) will not be visible in PCI configuration
+ * space and any access to its PCI configuration registers will cause
+ * system hang while it is held in reset.
+ */
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, quark_pcie_early_init);
 
 int checkcpu(void)
 {
diff --git a/arch/x86/lib/fsp2/fsp_init.c b/arch/x86/lib/fsp2/fsp_init.c
index afec7d08d67f..aadc08cf3c44 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -19,7 +19,7 @@
 #include <dm/uclass-internal.h>
 #include <asm/fsp2/fsp_internal.h>
 
-int fsp_setup_pinctrl(void *ctx, struct event *event)
+int fsp_setup_pinctrl(void)
 {
 	struct udevice *dev;
 	ofnode node;
@@ -42,7 +42,7 @@ int fsp_setup_pinctrl(void *ctx, struct event *event)
 
 	return ret;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, fsp_setup_pinctrl);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, fsp_setup_pinctrl);
 
 #if !defined(CONFIG_TPL_BUILD)
 binman_sym_declare(ulong, intel_fsp_m, image_pos);
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index 9e23f5cd31e7..9d9168d608a1 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -33,7 +33,7 @@ struct cros_gpio_info {
 	int flags;
 };
 
-static int coral_check_ll_boot(void *ctx, struct event *event)
+static int coral_check_ll_boot(void)
 {
 	if (!ll_boot_init()) {
 		printf("Running as secondary loader");
@@ -57,7 +57,7 @@ static int coral_check_ll_boot(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_MISC_INIT_F, coral_check_ll_boot);
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, coral_check_ll_boot);
 
 int arch_misc_init(void)
 {
diff --git a/board/keymile/kmcent2/kmcent2.c b/board/keymile/kmcent2/kmcent2.c
index ed552c57b5fa..7e655175c577 100644
--- a/board/keymile/kmcent2/kmcent2.c
+++ b/board/keymile/kmcent2/kmcent2.c
@@ -182,7 +182,7 @@ unsigned long get_serial_clock(unsigned long dummy)
 	return (gd->bus_clk / 2);
 }
 
-static int kmcent2_misc_init_f(void *ctx, struct event *event)
+static int kmcent2_misc_init_f(void)
 {
 	/* configure QRIO pis for i2c deblocking */
 	i2c_deblock_gpio_cfg();
@@ -210,7 +210,7 @@ static int kmcent2_misc_init_f(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_MISC_INIT_F, kmcent2_misc_init_f);
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, kmcent2_misc_init_f);
 
 #define USED_SRDS_BANK 0
 #define EXPECTED_SRDS_RFCK SRDS_PLLCR0_RFCK_SEL_100
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index 2f1731eea6a0..d7f47959ebd7 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -110,14 +110,14 @@ int board_early_init_f(void)
 	return 0;
 }
 
-static int pg_wcom_misc_init_f(void *ctx, struct event *event)
+static int pg_wcom_misc_init_f(void)
 {
 	if (IS_ENABLED(CONFIG_PG_WCOM_UBOOT_UPDATE_SUPPORTED))
 		check_for_uboot_update();
 
 	return 0;
 }
-EVENT_SPY(EVT_MISC_INIT_F, pg_wcom_misc_init_f);
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, pg_wcom_misc_init_f);
 
 int board_init(void)
 {
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 7acd3995aad8..ad5f71a20180 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -218,7 +218,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
-	riscv_cpu_setup(NULL, NULL);
+	riscv_cpu_setup();
 	preloader_console_init();
 
 	/* Set the parent clock of cpu_root clock to pll0,
diff --git a/drivers/cpu/microblaze_cpu.c b/drivers/cpu/microblaze_cpu.c
index c97a89fbd5c8..a229f6913b07 100644
--- a/drivers/cpu/microblaze_cpu.c
+++ b/drivers/cpu/microblaze_cpu.c
@@ -19,7 +19,7 @@ DECLARE_GLOBAL_DATA_PTR;
 	ci = tmp;								\
 }
 
-static int microblaze_cpu_probe_all(void *ctx, struct event *event)
+static int microblaze_cpu_probe_all(void)
 {
 	int ret;
 
@@ -29,7 +29,7 @@ static int microblaze_cpu_probe_all(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_F, microblaze_cpu_probe_all);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, microblaze_cpu_probe_all);
 
 static void microblaze_set_cpuinfo_pvr(struct microblaze_cpuinfo *ci)
 {
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 4d0c8b84b9d0..006f6da4b9a9 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -618,7 +618,7 @@ int fwu_trial_state_ctr_start(void)
 	return ret;
 }
 
-static int fwu_boottime_checks(void *ctx, struct event *event)
+static int fwu_boottime_checks(void)
 {
 	int ret;
 	u32 boot_idx, active_idx;
@@ -682,4 +682,4 @@ static int fwu_boottime_checks(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_MAIN_LOOP, fwu_boottime_checks);
+EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index 041f8f9c9790..a6df9e10e54e 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,6 +18,6 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
-EVT_MISC_INIT_F       sandbox_misc_init_f             .*arch/sandbox/cpu/start.c:.*
+EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.42.0.rc1.204.g551eb34607-goog

