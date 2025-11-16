Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B74CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA1E83B4F;
	Sun, 16 Nov 2025 15:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF8C83AB0; Sun, 16 Nov 2025 15:45:43 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFD383A3D
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id CFC9B340B46;
 Sun, 16 Nov 2025 14:45:35 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:44:02 +0000
Subject: [PATCH 11/11] sunxi: mmc: enable support for A733
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-11-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4642; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=C4euzuLHsYzChfP4W/0AbppbACF42v3u4ZDXzC1JMtw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeNY7f56PEhZ8a+iMkQILahJabEPvsUuQkpXs
 I/43EIR9suJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjWF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277X/sD/933Q2R41mTFQMvsH
 52Gj1dG5TRDdSMhVw82ngZrOtJG4cHHUsDkgbxzI4Wx3GJtoOUW4iXNxwEFCvrSJHnDLhfZWqgt
 OfaCBvhkYLwff86NXi7ecwfKpElk2DkouDQWoFmnCIuUfWBkopjQMTRAoulJKngjtUaD7hAb1LQ
 WEAmoVLT8VtahUI992p+QTTHBLm/vW1hVZYbH301EPi5J52m+T/Mzr0rcZYMB5viqSlWdwVPHq+
 XrkwVZshYNdbCcr2lOuif0sRpip9a4A5jTXQ1DB07+x7eBIG/fIKWdDP30IFGhdcxHtwlJO/pKe
 vIKwMcxnMLEzHBNQk9jbkjkaT+ZIf/mdn2MEZ1JULkNa+WTQ71V/2JNITXG2+jHjLGx4yxHgsE6
 +XA6lAun5nwwprE5Yg8UIByDE59wa3ytePmx+y068w8iU78Sb7t6MUe+nVn/Xrc1kR+/FiuB/gB
 HqyJgxbmawalqlu26X7m+2Uy0rjS1m5gdmgRepO7XcTqIgVHkrzT5dmuOsbmgV+WaF8LgSQHm8p
 FeanAMy9E16GwW8Olj+Cb1szrc7KMxR1LXLbZzSErry/zvNq+6SUh8g7krc8dCdmXcRFRMuA44F
 kDw5oCCnxCqVvgJHnvpD4Uw2Kz/WjLnP5+5+45vJDLAPpCxQdmPL/YSEeT7BDbBAbIBw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Minor clock adjustment for new A733 MMC controller, the SMHC0_CLK_REG
start at offset 0x400, and with step size of 0x10.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/sunxi_mmc.c | 32 ++++++++++++++++++++++++++------
 drivers/mmc/sunxi_mmc.h |  3 ++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..75acfb25e86 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -61,6 +61,7 @@ static bool sunxi_mmc_can_calibrate(void)
 	       IS_ENABLED(CONFIG_MACH_SUN50I_H5) ||
 	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
 	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
+	       IS_ENABLED(CONFIG_MACH_SUN60I_A733) ||
 	       IS_ENABLED(CONFIG_MACH_SUN8I_R40);
 }
 
@@ -112,6 +113,9 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 			if (priv->mmc_no == 2)
 				pll_hz *= 2;
 		}
+
+		if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+			pll_hz /= 3;
 	}
 
 	div = pll_hz / hz;
@@ -167,7 +171,8 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 	}
 
 	/* The A523 has a second divider, not a shift. */
-	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
+		IS_ENABLED(CONFIG_MACH_SUN60I_A733))
 		n = (1U << n) - 1;
 
 	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
@@ -219,7 +224,8 @@ static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 	rval &= ~SUNXI_MMC_CLK_DIVIDER_MASK;
 	writel(rval, &priv->reg->clkcr);
 
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || \
+	defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)
 	/* A64 supports calibration of delays on MMC controller and we
 	 * have to set delay of zero before starting calibration.
 	 * Allwinner BSP driver sets a delay only in the case of
@@ -472,7 +478,9 @@ static void sunxi_mmc_reset(void *regs)
 	writel(SUNXI_MMC_GCTRL_RESET, regs + SUNXI_MMC_GCTRL);
 	udelay(1000);
 
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+		IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
+		IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
 		/* Reset card */
 		writel(SUNXI_MMC_HWRST_ASSERT, regs + SUNXI_MMC_HWRST);
 		udelay(10);
@@ -591,7 +599,8 @@ struct mmc *sunxi_mmc_init(int sdc_no)
 
 	/* config ahb clock */
 	debug("init mmc %d clock and io\n", sdc_no);
-#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
+#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2) && \
+	!defined(CONFIG_MACH_SUN60I_A733)
 	setbits_le32(ccm + CCU_AHB_GATE0, 1 << AHB_GATE_OFFSET_MMC(sdc_no));
 
 #ifdef CONFIG_SUNXI_GEN_SUN6I
@@ -661,17 +670,28 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 	.get_cd		= sunxi_mmc_getcd,
 };
 
-static unsigned get_mclk_offset(void)
+static unsigned int get_mclk_offset(void)
 {
 	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
 		return 0x410;
 
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return 0xd00;
+
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		return 0x830;
 
 	return 0x88;
 };
 
+static unsigned int get_mclk_size(void)
+{
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return 0x10;
+
+	return 0x4;
+};
+
 static int sunxi_mmc_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
@@ -707,7 +727,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
 	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
 
 	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
-	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
+	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * get_mclk_size();
 
 	ret = clk_get_by_name(dev, "ahb", &gate_clk);
 	if (!ret)
diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
index 71865160319..a5caca15ba5 100644
--- a/drivers/mmc/sunxi_mmc.h
+++ b/drivers/mmc/sunxi_mmc.h
@@ -47,7 +47,8 @@ struct sunxi_mmc {
 	u32 chda;		/* 0x90 */
 	u32 cbda;		/* 0x94 */
 	u32 res2[26];
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || \
+	defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)
 	u32 thldc;		/* 0x100 Threshold control */
 	u32 res3[16];
 	u32 samp_dl;

-- 
2.51.2

