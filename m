Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D66C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA56A88881;
	Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WhAjEaqw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SuOoOJpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D0388873; Sat, 13 Jul 2024 15:21:26 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BED188836
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpyC6wC6z9sZv;
 Sat, 13 Jul 2024 15:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QWhi2aoTA+/hxp4li/ycCZkl33oKnjU0EYDBsA//Ok=;
 b=WhAjEaqwUXYJBwj07U+XTKZDfPHx9eF8OjXIipnD4hq8ulr0UDOVJLcHrkSz21RQbyVOCw
 SXebzpdr9vD3dBdmIpS6u/xsC9GpX3yGGj5iRMI5A1xgqlWFcDN+X+AcOGs/c8EJEBFYWl
 kJarYGrVpX7jvQL9o9mYdUTp+ITdMqTlI4hCxDdfYu04NBtQR5fAcW3APVxkFnYmBSub4j
 c5A2+nQ3jFmM/ka2qqt7btgIYoKqNLolzYw69rwbQx1hsMBCJgnHrYmiTIlMr29nQyjZni
 ljYmTULm0uQDl/HzbSu2N15si8Z35cwG0mJBqVyaSPTJ28Gic8ct+ePmHZ3htg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QWhi2aoTA+/hxp4li/ycCZkl33oKnjU0EYDBsA//Ok=;
 b=SuOoOJpSmi0MQ5yumKp3L/eAo7u4IgVUorWo9ZkqWmwi5PiYIuazRjNmepyIka5w4nZjq+
 EmrH2adMCcovIkhpjT646E1+wMzdrB6hGk3jTWOVkcC1QDeJvQwVmdxWZyDQyTX5uuWJnD
 1+MCl6tMqsjS7PNwR1DtxCVO5Z5uka5eVtNAPHOCSQVJclUJ7tBnWK2w+iCUzdOdNjl3+k
 QZZ/Vfdt02ehDqHXcP7UvIOSeiKYQ6KxxnmSKCVY0KgfGUfGdkFmVOu5nblvVV6y0xQT3S
 h5BxzYQGS1o7vxm2sjuWozc38jF6ToimzMFaQTsC8oPWEdLfP4JIEN1pyFU29g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/45] arm: mach: ti: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:07 +0200
Message-ID: <20240713132021.57650-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 955eb053888bacf5bb5
X-MBO-RS-META: ks7q3ai9aebqqhnfmt1xq6rdzk3hn9sa
X-Rspamd-Queue-Id: 4WLpyC6wC6z9sZv
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-davinci/da850_lowlevel.c         | 1 -
 arch/arm/mach-keystone/include/mach/psc_defs.h | 1 -
 arch/arm/mach-keystone/msmc.c                  | 1 -
 arch/arm/mach-omap2/am33xx/chilisom.c          | 1 -
 arch/arm/mach-omap2/am33xx/clock.c             | 1 -
 arch/arm/mach-omap2/am33xx/sys_info.c          | 1 -
 arch/arm/mach-omap2/clocks-common.c            | 1 -
 arch/arm/mach-omap2/hwinit-common.c            | 2 --
 arch/arm/mach-omap2/omap3/board.c              | 1 -
 9 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-davinci/da850_lowlevel.c b/arch/arm/mach-davinci/da850_lowlevel.c
index 936b5e11667..78d50d4e719 100644
--- a/arch/arm/mach-davinci/da850_lowlevel.c
+++ b/arch/arm/mach-davinci/da850_lowlevel.c
@@ -146,7 +146,6 @@ static int da850_pll_init(struct davinci_pllc_regs *reg, unsigned long pllmult)
 	 */
 	setbits_le32(&reg->pllctl, PLLCTL_PLLEN);
 
-
 	/*
 	 * clear EMIFA and EMIFB clock source settings, let them
 	 * run off SYSCLK
diff --git a/arch/arm/mach-keystone/include/mach/psc_defs.h b/arch/arm/mach-keystone/include/mach/psc_defs.h
index f164f95bf24..e5d70d2931e 100644
--- a/arch/arm/mach-keystone/include/mach/psc_defs.h
+++ b/arch/arm/mach-keystone/include/mach/psc_defs.h
@@ -26,7 +26,6 @@
 #define PSC_REG_MDSTAT(x)       (0x800 + (4 * (x)))
 #define PSC_REG_MDCTL(x)        (0xa00 + (4 * (x)))
 
-
 static inline u32 _boot_bit_mask(u32 x, u32 y)
 {
 	u32 val = (1 << (x - y + 1)) - 1;
diff --git a/arch/arm/mach-keystone/msmc.c b/arch/arm/mach-keystone/msmc.c
index a20e0c98865..51c994f972f 100644
--- a/arch/arm/mach-keystone/msmc.c
+++ b/arch/arm/mach-keystone/msmc.c
@@ -53,7 +53,6 @@ struct msms_regs {
 	struct mpax ses[16][8];
 };
 
-
 void msmc_share_all_segments(int priv_id)
 {
 	struct msms_regs *msmc = (struct msms_regs *)KS2_MSMC_CTRL_BASE;
diff --git a/arch/arm/mach-omap2/am33xx/chilisom.c b/arch/arm/mach-omap2/am33xx/chilisom.c
index 4765ce0adee..515b6f1b87c 100644
--- a/arch/arm/mach-omap2/am33xx/chilisom.c
+++ b/arch/arm/mach-omap2/am33xx/chilisom.c
@@ -102,7 +102,6 @@ void chilisom_spl_board_init(void)
 	/* Get the frequency */
 	dpll_mpu_opp100.m = am335x_get_efuse_mpu_max_freq(cdev);
 
-
 	if (i2c_probe(TPS65217_CHIP_PM))
 		return;
 
diff --git a/arch/arm/mach-omap2/am33xx/clock.c b/arch/arm/mach-omap2/am33xx/clock.c
index f07003c95bc..cc955345db9 100644
--- a/arch/arm/mach-omap2/am33xx/clock.c
+++ b/arch/arm/mach-omap2/am33xx/clock.c
@@ -213,7 +213,6 @@ void do_disable_clocks(u32 *const *clk_domains,
 {
 	u32 i, max = 100;
 
-
 	/* Clock modules that need to be put in SW_DISABLE */
 	for (i = 0; (i < max) && clk_modules_disable && clk_modules_disable[i];
 	     i++)
diff --git a/arch/arm/mach-omap2/am33xx/sys_info.c b/arch/arm/mach-omap2/am33xx/sys_info.c
index 87afc096602..7ac67cb4899 100644
--- a/arch/arm/mach-omap2/am33xx/sys_info.c
+++ b/arch/arm/mach-omap2/am33xx/sys_info.c
@@ -74,7 +74,6 @@ u32 get_sys_clk_index(void)
 			CTRL_SYSBOOT_15_14_SHIFT);
 }
 
-
 #ifdef CONFIG_DISPLAY_CPUINFO
 static char *cpu_revs[] = {
 		"1.0",
diff --git a/arch/arm/mach-omap2/clocks-common.c b/arch/arm/mach-omap2/clocks-common.c
index 2a0c22841d0..18d099145c5 100644
--- a/arch/arm/mach-omap2/clocks-common.c
+++ b/arch/arm/mach-omap2/clocks-common.c
@@ -896,7 +896,6 @@ void do_disable_clocks(u32 const *clk_domains,
 {
 	u32 i, max = 100;
 
-
 	/* Clock modules that need to be put in SW_DISABLE */
 	for (i = 0; (i < max) && clk_modules_disable[i]; i++)
 		disable_clock_module(clk_modules_disable[i],
diff --git a/arch/arm/mach-omap2/hwinit-common.c b/arch/arm/mach-omap2/hwinit-common.c
index 138501602c3..bb67e50fd56 100644
--- a/arch/arm/mach-omap2/hwinit-common.c
+++ b/arch/arm/mach-omap2/hwinit-common.c
@@ -268,7 +268,6 @@ void watchdog_init(void)
 	writel(WD_UNLOCK2, &wd2_base->wspr);
 }
 
-
 /*
  * This function finds the SDRAM size available in the system
  * based on DMM section configurations
@@ -315,7 +314,6 @@ u32 omap_sdram_size(void)
 	return total_size;
 }
 
-
 /*
  * Routine: dram_init
  * Description: sets uboots idea of sdram size
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index c5ada607f97..1de343ff48e 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -405,7 +405,6 @@ void v7_arch_cp15_set_acr(u32 acr, u32 cpu_midr, u32 cpu_rev_comb,
 	asm volatile ("mcr p15, 0, %0, c1, c0, 1" : : "r" (acr));
 }
 
-
 #ifndef CONFIG_SYS_L2CACHE_OFF
 static void omap3_update_aux_cr(u32 set_bits, u32 clear_bits)
 {
-- 
2.43.0

