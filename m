Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB61FC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 20:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E849484105;
	Fri, 26 Jun 2026 22:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USxqqFRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D886984119; Fri, 26 Jun 2026 22:52:03 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA37B83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-48d6c621a67so776962b6e.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782507119; x=1783111919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sth0GM2pcG6OyeOsDqJVftZ7F1T+k2W56/wHtM269gc=;
 b=USxqqFRVxTgYzUOAajynip1AQ0TOssa9y/m3zk9fG0gX8agLLWoBqK51zyE0+w5Bsl
 Vp2P3zF5Xqi0bSyF+pYOSko7BVx/g4P9/TJX8zsEbSOxGP8IOa7gdEYQulLCYC0tfm32
 b4foCGwqpJLAzu9cH7M6NE1POw7w8zlzK3YdLMkkABefQvfNOJtOH2b/mPgT0CaaOuNu
 spbhvNgtF7XgX//1ktkYDlRP7SNMdJ4Z+I5g6sH9yMluWrs5UihvGIAvCzVeFZ3PnOri
 z2wqtwX4+/X8tyNY//PUgklqpEaeeMlAtTUAJdS1UcYWS1MJLjTUvRZlwfIFCXbiBs93
 y96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782507119; x=1783111919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sth0GM2pcG6OyeOsDqJVftZ7F1T+k2W56/wHtM269gc=;
 b=l4iOK7LFu1lGYgt9j5HhPRhCx7gj8Z5SmSIM2G6qTkxWKtVaHvE/i0+dwYK9Bq2EZc
 M+/qPZTxQxR82ZDfeMRnQecKslacVWexGXa2Yq5rLHVm5zs7bO9qhDfbWG+pjChIJKdL
 5FDDnwS81bPHRcKB0OZ3E5wzRZmStzWl5Jy/MWuBe1FqnUll2XFs0ORu3zqJY4Lfbr+X
 QIfWMfbhZ8HP8h6LPVuFAxg81MpznX5Cfj5mpYsKilDloEDk26b1I9UZ87/n4mg9LF/j
 wgrT1FPuqWkLHIJ8u8V7CGJwOBuWsINRcyjc8TKKTr+aagRT//pw+pGJoQM4ChEFL1dG
 DWqQ==
X-Gm-Message-State: AOJu0YxQd/krA5c+7FOb1zS0ItowW8wFqTufAug4aoSfwoArzov0+OdD
 WU64HLO2G2AZh8kGr6gFg4iGx7fZQy54AY+nfAGGoLJtnmRmPwwPosoHzatCDIjvKzg=
X-Gm-Gg: AfdE7clV8fSzYiEdmEaj6YHCrQX1bTZlwPzNMH23q6E7g62GIpk4LFVlmaANEje9F2v
 JK+CeZ2mxOuLkbgXPF7tG/2i9G3Nn51HCil7hjLB++X5qQ/2Flqqdd6NAivcncmBjiV1Hqh9tx2
 fBfgrfmjRnme7Cq2yvkCV/sVzyMmXrGP3xHbJhrEu3q87ETyWkN59mHQ+8ir8Bj5rmyKbO6XOlN
 BFFCiMzpf4cLY/+5BZgqMzdU2gTg+zQtkaYqa++87YWCM68dRCM+faFFVxhdhfBZH5DzgjDM3Y6
 hGkGyHmNQR84piPa3chLWsgyTS1oBRIU1iA+dmbr1yOjOJQfwlocUcbrLoF7c3h0fUDRz4lio8a
 ogIQPsmLD/dW+x0cWn9GouRSU/ME3ZhTWeG9mUVcP7lXqBz3WzyJyxOIV6hzE1du8kOCKgDGPSN
 2bEQArYNtTqbq/tCqniP0eGWNyhd0aqPrKuQbuf4/FV5I1fc3t20PCRMU0aWZEvXAb+QAlirVot
 7NUHrVa5bTHfrJO2tRo0Id92oxLIcJPBz80Qa+UN/9FIr+dU0iVeUOnWHSuz9KAI+EBiUVLWTW6
 ROzUUqTNvZWdftQ=
X-Received: by 2002:a05:6808:c40f:b0:492:c931:4d65 with SMTP id
 5614622812f47-492c9317413mr5590581b6e.15.1782507119151; 
 Fri, 26 Jun 2026 13:51:59 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-49354e517dfsm2159028b6e.11.2026.06.26.13.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:51:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bohdan Chubuk <chbgdn@gmail.com>
Subject: [PATCH] mmc: sunxi: support DM MMC in SPL
Date: Fri, 26 Jun 2026 14:51:50 -0600
Message-ID: <20260626205153.2744981-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sunxi SPL normally uses the legacy MMC interface while U-Boot
proper uses the DM driver. Boards which enable SPL_DM_MMC need
the DM driver to perform the same early pinmux, resource and clock
setup as the legacy path.

For SPL without OF_CONTROL, create controllers from static platform
data matching the controllers selected by the legacy SPL board code.
Reuse the legacy host capability, resource and clock setup helpers for
that no-devicetree probe path.

For SPL with OF_CONTROL but without SPL_CLK or SPL_PINCTRL, keep
using the devicetree for the controller address and clock register
layout, then fall back to the legacy CCU base, clock init and pinmux
setup. This allows SPL to use DM_MMC without pulling the full clock
and pinctrl drivers into SRAM-constrained builds.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm/include/asm/arch-sunxi/mmc.h |   1 +
 board/sunxi/board.c                   |   6 +-
 drivers/mmc/sunxi_mmc.c               | 252 +++++++++++++++++---------
 3 files changed, 175 insertions(+), 84 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/asm/arch-sunxi/mmc.h
index b8d91b5c64b..e6c19bf08fb 100644
--- a/arch/arm/include/asm/arch-sunxi/mmc.h
+++ b/arch/arm/include/asm/arch-sunxi/mmc.h
@@ -3,6 +3,7 @@
 #ifndef _ASM_ARCH_MMC_H_
 #define _ASM_ARCH_MMC_H_
 
+void sunxi_mmc_pinmux_setup(int sdc_no);
 struct mmc *sunxi_mmc_init(int sdc_no);
 
 #endif /* _ASM_ARCH_MMC_H_ */
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..4311f38737c 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -334,7 +334,7 @@ void board_nand_init(void)
 #endif /* CONFIG_NAND_SUNXI */
 
 #ifdef CONFIG_MMC
-static void mmc_pinmux_setup(int sdc)
+void sunxi_mmc_pinmux_setup(int sdc)
 {
 	unsigned int pin;
 
@@ -515,13 +515,13 @@ int board_mmc_init(struct bd_info *bis)
 	 * any problem with unconditionally enabling this in the SPL.
 	 */
 	if (!IS_ENABLED(CONFIG_UART0_PORT_F)) {
-		mmc_pinmux_setup(0);
+		sunxi_mmc_pinmux_setup(0);
 		if (!sunxi_mmc_init(0))
 			return -1;
 	}
 
 	if (CONFIG_MMC_SUNXI_SLOT_EXTRA != -1) {
-		mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
+		sunxi_mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
 		if (!sunxi_mmc_init(CONFIG_MMC_SUNXI_SLOT_EXTRA))
 			return -1;
 	}
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..7816dac3423 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -6,11 +6,11 @@
  *
  * MMC driver for allwinner sunxi platform.
  *
- * This driver is used by the (ARM) SPL with the legacy MMC interface, and
- * by U-Boot proper using the full DM interface. The actual hardware access
- * code is common, and comes first in this file.
- * The legacy MMC interface implementation comes next, followed by the
- * proper DM_MMC implementation at the end.
+ * This driver is used by the (ARM) SPL with the legacy MMC interface or the
+ * full DM interface, and by U-Boot proper using the full DM interface. The
+ * actual hardware access code is common, and comes first in this file.
+ * The legacy MMC interface implementation comes next, followed by the DM_MMC
+ * implementation at the end.
  */
 
 #include <dm.h>
@@ -24,9 +24,7 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/cpu.h>
-#if !CONFIG_IS_ENABLED(DM_MMC)
 #include <asm/arch/mmc.h>
-#endif
 #include <linux/delay.h>
 #include <sunxi_gpio.h>
 
@@ -36,7 +34,12 @@
 #define CCM_MMC_CTRL_MODE_SEL_NEW	0
 #endif
 
+#define SUNXI_MMC_NAME			"SUNXI SD/MMC"
+
 struct sunxi_mmc_plat {
+#if !CONFIG_IS_ENABLED(OF_REAL)
+	unsigned int mmc_no;
+#endif
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
@@ -64,6 +67,83 @@ static bool sunxi_mmc_can_calibrate(void)
 	       IS_ENABLED(CONFIG_MACH_SUN8I_R40);
 }
 
+#if !CONFIG_IS_ENABLED(DM_MMC) || !CONFIG_IS_ENABLED(OF_REAL)
+static uint sunxi_mmc_get_host_caps(unsigned int mmc_no)
+{
+	uint host_caps = MMC_MODE_4BIT;
+
+	if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
+	     IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	     IS_ENABLED(CONFIG_MACH_SUN55I_A523)) && mmc_no == 2)
+		host_caps = MMC_MODE_8BIT;
+
+	return host_caps | MMC_MODE_HS_52MHz | MMC_MODE_HS;
+}
+
+static int mmc_resource_init(struct sunxi_mmc_priv *priv, int sdc_no)
+{
+	void *ccm = (void *)SUNXI_CCM_BASE;
+
+	debug("init mmc %d resource\n", sdc_no);
+
+	switch (sdc_no) {
+	case 0:
+		priv->reg = (struct sunxi_mmc *)SUNXI_MMC0_BASE;
+		priv->mclkreg = ccm + CCU_MMC0_CLK_CFG;
+		break;
+	case 1:
+		priv->reg = (struct sunxi_mmc *)SUNXI_MMC1_BASE;
+		priv->mclkreg = ccm + CCU_MMC1_CLK_CFG;
+		break;
+#ifdef SUNXI_MMC2_BASE
+	case 2:
+		priv->reg = (struct sunxi_mmc *)SUNXI_MMC2_BASE;
+		priv->mclkreg = ccm + CCU_MMC2_CLK_CFG;
+		break;
+#endif
+#ifdef SUNXI_MMC3_BASE
+	case 3:
+		priv->reg = (struct sunxi_mmc *)SUNXI_MMC3_BASE;
+		priv->mclkreg = ccm + CCU_MMC3_CLK_CFG;
+		break;
+#endif
+	default:
+		printf("Wrong mmc number %d\n", sdc_no);
+		return -1;
+	}
+	priv->mmc_no = sdc_no;
+
+	return 0;
+}
+#endif
+
+#if !CONFIG_IS_ENABLED(DM_MMC) || !CONFIG_IS_ENABLED(OF_REAL) || \
+	!CONFIG_IS_ENABLED(CLK)
+static void sunxi_mmc_clock_init(int sdc_no)
+{
+	void *ccm = (void *)SUNXI_CCM_BASE;
+
+	debug("init mmc %d clock and io\n", sdc_no);
+#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
+	setbits_le32(ccm + CCU_AHB_GATE0, 1 << AHB_GATE_OFFSET_MMC(sdc_no));
+
+#ifdef CONFIG_SUNXI_GEN_SUN6I
+	/* unassert reset */
+	setbits_le32(ccm + CCU_AHB_RESET0_CFG, 1 << AHB_RESET_OFFSET_MMC(sdc_no));
+#endif
+#if defined(CONFIG_MACH_SUN9I)
+	/* sun9i has a mmc-common module, also set the gate and reset there */
+	writel(SUNXI_MMC_COMMON_CLK_GATE | SUNXI_MMC_COMMON_RESET,
+	       SUNXI_MMC_COMMON_BASE + 4 * sdc_no);
+#endif
+#else /* CONFIG_SUN50I_GEN_H6 */
+	setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << sdc_no);
+	/* unassert reset */
+	setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << (RESET_SHIFT + sdc_no));
+#endif
+}
+#endif
+
 static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 {
 	unsigned int pll, pll_hz, div, n, oclk_dly, sclk_dly;
@@ -492,43 +572,6 @@ static void sunxi_mmc_reset(void *regs)
 /* support 4 mmc hosts */
 struct sunxi_mmc_priv mmc_host[4];
 
-static int mmc_resource_init(int sdc_no)
-{
-	struct sunxi_mmc_priv *priv = &mmc_host[sdc_no];
-	void *ccm = (void *)SUNXI_CCM_BASE;
-
-	debug("init mmc %d resource\n", sdc_no);
-
-	switch (sdc_no) {
-	case 0:
-		priv->reg = (struct sunxi_mmc *)SUNXI_MMC0_BASE;
-		priv->mclkreg = ccm + CCU_MMC0_CLK_CFG;
-		break;
-	case 1:
-		priv->reg = (struct sunxi_mmc *)SUNXI_MMC1_BASE;
-		priv->mclkreg = ccm + CCU_MMC1_CLK_CFG;
-		break;
-#ifdef SUNXI_MMC2_BASE
-	case 2:
-		priv->reg = (struct sunxi_mmc *)SUNXI_MMC2_BASE;
-		priv->mclkreg = ccm + CCU_MMC2_CLK_CFG;
-		break;
-#endif
-#ifdef SUNXI_MMC3_BASE
-	case 3:
-		priv->reg = (struct sunxi_mmc *)SUNXI_MMC3_BASE;
-		priv->mclkreg = ccm + CCU_MMC3_CLK_CFG;
-		break;
-#endif
-	default:
-		printf("Wrong mmc number %d\n", sdc_no);
-		return -1;
-	}
-	priv->mmc_no = sdc_no;
-
-	return 0;
-}
-
 static int sunxi_mmc_core_init(struct mmc *mmc)
 {
 	struct sunxi_mmc_priv *priv = mmc->priv;
@@ -562,52 +605,27 @@ static const struct mmc_ops sunxi_mmc_ops = {
 
 struct mmc *sunxi_mmc_init(int sdc_no)
 {
-	void *ccm = (void *)SUNXI_CCM_BASE;
 	struct sunxi_mmc_priv *priv = &mmc_host[sdc_no];
 	struct mmc_config *cfg = &priv->cfg;
 	int ret;
 
 	memset(priv, '\0', sizeof(struct sunxi_mmc_priv));
 
-	cfg->name = "SUNXI SD/MMC";
+	cfg->name = SUNXI_MMC_NAME;
 	cfg->ops  = &sunxi_mmc_ops;
 
 	cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
-	cfg->host_caps = MMC_MODE_4BIT;
-
-	if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
-	    (sdc_no == 2))
-		cfg->host_caps = MMC_MODE_8BIT;
-
-	cfg->host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;
+	cfg->host_caps = sunxi_mmc_get_host_caps(sdc_no);
 	cfg->b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
 
 	cfg->f_min = 400000;
 	cfg->f_max = 52000000;
 
-	if (mmc_resource_init(sdc_no) != 0)
+	if (mmc_resource_init(priv, sdc_no) != 0)
 		return NULL;
 
 	/* config ahb clock */
-	debug("init mmc %d clock and io\n", sdc_no);
-#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
-	setbits_le32(ccm + CCU_AHB_GATE0, 1 << AHB_GATE_OFFSET_MMC(sdc_no));
-
-#ifdef CONFIG_SUNXI_GEN_SUN6I
-	/* unassert reset */
-	setbits_le32(ccm + CCU_AHB_RESET0_CFG, 1 << AHB_RESET_OFFSET_MMC(sdc_no));
-#endif
-#if defined(CONFIG_MACH_SUN9I)
-	/* sun9i has a mmc-common module, also set the gate and reset there */
-	writel(SUNXI_MMC_COMMON_CLK_GATE | SUNXI_MMC_COMMON_RESET,
-	       SUNXI_MMC_COMMON_BASE + 4 * sdc_no);
-#endif
-#else /* CONFIG_SUN50I_GEN_H6 */
-	setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << sdc_no);
-	/* unassert reset */
-	setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << (RESET_SHIFT + sdc_no));
-#endif
+	sunxi_mmc_clock_init(sdc_no);
 	ret = mmc_set_mod_clk(priv, 24000000);
 	if (ret)
 		return NULL;
@@ -644,7 +662,7 @@ static int sunxi_mmc_getcd(struct udevice *dev)
 	    (mmc->cfg->host_caps & MMC_CAP_NEEDS_POLL))
 		return 1;
 
-	if (dm_gpio_is_valid(&priv->cd_gpio)) {
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&priv->cd_gpio)) {
 		int cd_state = dm_gpio_get_value(&priv->cd_gpio);
 
 		if (mmc->cfg->host_caps & MMC_CAP_CD_ACTIVE_HIGH)
@@ -652,6 +670,7 @@ static int sunxi_mmc_getcd(struct udevice *dev)
 		else
 			return cd_state;
 	}
+
 	return 1;
 }
 
@@ -661,6 +680,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 	.get_cd		= sunxi_mmc_getcd,
 };
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 static unsigned get_mclk_offset(void)
 {
 	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
@@ -671,20 +691,26 @@ static unsigned get_mclk_offset(void)
 
 	return 0x88;
 };
+#endif
 
 static int sunxi_mmc_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct sunxi_mmc_plat *plat = dev_get_plat(dev);
 	struct sunxi_mmc_priv *priv = dev_get_priv(dev);
+#if CONFIG_IS_ENABLED(OF_REAL)
 	struct reset_ctl_bulk reset_bulk;
+#if CONFIG_IS_ENABLED(CLK)
 	struct clk gate_clk;
-	struct mmc_config *cfg = &plat->cfg;
+#endif
 	struct ofnode_phandle_args args;
 	u32 *ccu_reg;
+#endif
+	struct mmc_config *cfg = &plat->cfg;
 	int ret;
 
-	cfg->name = dev->name;
+	if (!cfg->name)
+		cfg->name = dev->name;
 
 	cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
 	cfg->host_caps = MMC_MODE_HS_52MHz | MMC_MODE_HS;
@@ -693,37 +719,58 @@ static int sunxi_mmc_probe(struct udevice *dev)
 	cfg->f_min = 400000;
 	cfg->f_max = 52000000;
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 	ret = mmc_of_parse(dev, cfg);
 	if (ret)
 		return ret;
 
 	priv->reg = dev_read_addr_ptr(dev);
+	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
+
+#if !CONFIG_IS_ENABLED(PINCTRL)
+	sunxi_mmc_pinmux_setup(priv->mmc_no);
+#endif
 
 	/* We don't have a sunxi clock driver so find the clock address here */
 	ret = dev_read_phandle_with_args(dev, "clocks", "#clock-cells", 0,
 					  1, &args);
-	if (ret)
+	if (!ret)
+		ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
+	else if (!CONFIG_IS_ENABLED(CLK))
+		ccu_reg = (u32 *)SUNXI_CCM_BASE;
+	else
 		return ret;
-	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
 
-	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
 	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
 
+#if CONFIG_IS_ENABLED(CLK)
 	ret = clk_get_by_name(dev, "ahb", &gate_clk);
 	if (!ret)
 		clk_enable(&gate_clk);
+#else
+	sunxi_mmc_clock_init(priv->mmc_no);
+#endif
 
 	ret = reset_get_bulk(dev, &reset_bulk);
 	if (!ret)
 		reset_deassert_bulk(&reset_bulk);
+#else
+	cfg->host_caps = sunxi_mmc_get_host_caps(plat->mmc_no);
+	sunxi_mmc_pinmux_setup(plat->mmc_no);
+	ret = mmc_resource_init(priv, plat->mmc_no);
+	if (ret)
+		return ret;
+	sunxi_mmc_clock_init(plat->mmc_no);
+#endif
 
 	ret = mmc_set_mod_clk(priv, 24000000);
 	if (ret)
 		return ret;
 
 	/* This GPIO is optional */
-	gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
-			     GPIOD_IS_IN | GPIOD_PULL_UP);
+	if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL))
+		gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
+				     GPIOD_IS_IN | GPIOD_PULL_UP);
 
 	upriv->mmc = &plat->mmc;
 
@@ -739,6 +786,7 @@ static int sunxi_mmc_bind(struct udevice *dev)
 	return mmc_bind(dev, &plat->mmc, &plat->cfg);
 }
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 static const struct udevice_id sunxi_mmc_ids[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc" },
 	{ .compatible = "allwinner,sun5i-a13-mmc" },
@@ -754,15 +802,57 @@ static const struct udevice_id sunxi_mmc_ids[] = {
 	{ .compatible = "allwinner,sun50i-a100-emmc" },
 	{ /* sentinel */ }
 };
+#endif
 
 U_BOOT_DRIVER(sunxi_mmc_drv) = {
 	.name		= "sunxi_mmc",
 	.id		= UCLASS_MMC,
+#if CONFIG_IS_ENABLED(OF_REAL)
 	.of_match	= sunxi_mmc_ids,
+#endif
 	.bind		= sunxi_mmc_bind,
 	.probe		= sunxi_mmc_probe,
 	.ops		= &sunxi_mmc_ops,
 	.plat_auto	= sizeof(struct sunxi_mmc_plat),
 	.priv_auto	= sizeof(struct sunxi_mmc_priv),
+#if !CONFIG_IS_ENABLED(OF_CONTROL)
+	.flags		= DM_FLAG_PRE_RELOC,
+#endif
 };
+
+#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(DM_MMC) && \
+	!CONFIG_IS_ENABLED(OF_CONTROL)
+/*
+ * SPL runs DM binding before DRAM init, and sunxi SPL .bss is in DRAM.
+ * Keep this static platform data non-zero so it stays in SRAM-backed .data.
+ */
+#define SUNXI_MMC_PLAT(_mmc_no)	{ \
+		.mmc_no = _mmc_no, \
+		.cfg.name = SUNXI_MMC_NAME, \
+	}
+
+#define SUNXI_MMC_DRVINFO(_mmc_no) \
+	static struct sunxi_mmc_plat sunxi_mmc##_mmc_no##_plat = \
+		SUNXI_MMC_PLAT(_mmc_no); \
+	U_BOOT_DRVINFO(sunxi_mmc##_mmc_no) = { \
+		.name = "sunxi_mmc", \
+		.plat = &sunxi_mmc##_mmc_no##_plat, \
+	}
+
+#if !IS_ENABLED(CONFIG_UART0_PORT_F)
+SUNXI_MMC_DRVINFO(0);
+#endif
+
+#if CONFIG_MMC_SUNXI_SLOT_EXTRA == 1
+SUNXI_MMC_DRVINFO(1);
+#endif
+
+#if CONFIG_MMC_SUNXI_SLOT_EXTRA == 2 && defined(SUNXI_MMC2_BASE)
+SUNXI_MMC_DRVINFO(2);
+#endif
+
+#if CONFIG_MMC_SUNXI_SLOT_EXTRA == 3 && defined(SUNXI_MMC3_BASE)
+SUNXI_MMC_DRVINFO(3);
+#endif
+#endif
 #endif
-- 
2.53.0

