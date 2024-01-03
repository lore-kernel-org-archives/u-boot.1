Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0547EC47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB52879EF;
	Wed,  3 Jan 2024 01:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8CA879E1; Wed,  3 Jan 2024 01:13:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 255E487927
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9499C15;
 Tue,  2 Jan 2024 16:14:30 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEFBC3F5A1;
 Tue,  2 Jan 2024 16:13:43 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 14/19] sunxi: sun9i: make more clock functions SPL only
Date: Wed,  3 Jan 2024 00:12:34 +0000
Message-Id: <20240103001239.17482-15-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

In clock_sun9i.c, responsible for (mostly early) clock setup on the
Allwinner A80 SoC, many functions are only needed by the SPL, and are
thus already guarded by CONFIG_SPL_BUILD.

Over the years drivers like for the UART or I2C were converted to DM, and
they care about clock setup themselves now, by using a proper DM clock
driver.

This means those devices need the clock setup functions here for the SPL
only. Move some functions around, to group all SPL-only function within
one #ifdef guard. Some functions were exported, but never used outside
of this file, so remove their prototypes from the header file and mark
them as static.

This avoids unnecessary code in U-Boot proper and helps further
refactoring. Add some comments on the way to help understanding of the
file.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h |  3 -
 arch/arm/mach-sunxi/clock_sun9i.c             | 97 +++++++++----------
 2 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
index fe6b8ba2732..0264bfe1c50 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
@@ -220,10 +220,7 @@ struct sunxi_ccm_reg {
 
 #ifndef __ASSEMBLY__
 void clock_set_pll1(unsigned int clk);
-void clock_set_pll2(unsigned int clk);
-void clock_set_pll4(unsigned int clk);
 void clock_set_pll6(unsigned int clk);
-void clock_set_pll12(unsigned int clk);
 unsigned int clock_get_pll4_periph0(void);
 #endif
 
diff --git a/arch/arm/mach-sunxi/clock_sun9i.c b/arch/arm/mach-sunxi/clock_sun9i.c
index edaff9a28ce..5913e40cb65 100644
--- a/arch/arm/mach-sunxi/clock_sun9i.c
+++ b/arch/arm/mach-sunxi/clock_sun9i.c
@@ -17,6 +17,52 @@
 
 #ifdef CONFIG_SPL_BUILD
 
+static void clock_set_pll2(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	const int p = 0;
+
+	/* Switch cluster 1 to 24MHz clock while changing PLL2 */
+	clrsetbits_le32(&ccm->cpu_clk_source, C1_CPUX_CLK_SRC_MASK,
+			C1_CPUX_CLK_SRC_OSC24M);
+
+	writel(CCM_PLL2_CTRL_EN | CCM_PLL2_CTRL_P(p) |
+	       CCM_PLL2_CLOCK_TIME_2 | CCM_PLL2_CTRL_N(clk / 24000000),
+	       &ccm->pll2_c1_cfg);
+
+	sdelay(2000);
+
+	/* Switch cluster 1 back to PLL2 */
+	clrsetbits_le32(&ccm->cpu_clk_source, C1_CPUX_CLK_SRC_MASK,
+			C1_CPUX_CLK_SRC_PLL2);
+}
+
+static void clock_set_pll4(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	writel(CCM_PLL4_CTRL_EN | CCM_PLL4_CTRL_N(clk / 24000000),
+	       &ccm->pll4_periph0_cfg);
+
+	sdelay(2000);
+}
+
+static void clock_set_pll12(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	if (readl(&ccm->pll12_periph1_cfg) & CCM_PLL12_CTRL_EN)
+		return;
+
+	writel(CCM_PLL12_CTRL_EN | CCM_PLL12_CTRL_N(clk / 24000000),
+	       &ccm->pll12_periph1_cfg);
+
+	sdelay(2000);
+}
+
 void clock_init_safe(void)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -63,7 +109,6 @@ void clock_init_safe(void)
 	/* set enable-bit in TSTAMP_CTRL_REG */
 	writel(1, 0x01720000);
 }
-#endif
 
 void clock_init_uart(void)
 {
@@ -80,7 +125,6 @@ void clock_init_uart(void)
 			   CONFIG_CONS_INDEX - 1));
 }
 
-#ifdef CONFIG_SPL_BUILD
 void clock_set_pll1(unsigned int clk)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -108,27 +152,6 @@ void clock_set_pll1(unsigned int clk)
 			C0_CPUX_CLK_SRC_PLL1);
 }
 
-void clock_set_pll2(unsigned int clk)
-{
-	struct sunxi_ccm_reg * const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-	const int p = 0;
-
-	/* Switch cluster 1 to 24MHz clock while changing PLL2 */
-	clrsetbits_le32(&ccm->cpu_clk_source, C1_CPUX_CLK_SRC_MASK,
-			C1_CPUX_CLK_SRC_OSC24M);
-
-	writel(CCM_PLL2_CTRL_EN | CCM_PLL2_CTRL_P(p) |
-	       CCM_PLL2_CLOCK_TIME_2 | CCM_PLL2_CTRL_N(clk / 24000000),
-	       &ccm->pll2_c1_cfg);
-
-	sdelay(2000);
-
-	/* Switch cluster 1 back to PLL2 */
-	clrsetbits_le32(&ccm->cpu_clk_source, C1_CPUX_CLK_SRC_MASK,
-			C1_CPUX_CLK_SRC_PLL2);
-}
-
 void clock_set_pll6(unsigned int clk)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -143,32 +166,6 @@ void clock_set_pll6(unsigned int clk)
 	sdelay(2000);
 }
 
-void clock_set_pll12(unsigned int clk)
-{
-	struct sunxi_ccm_reg * const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-
-	if (readl(&ccm->pll12_periph1_cfg) & CCM_PLL12_CTRL_EN)
-		return;
-
-	writel(CCM_PLL12_CTRL_EN | CCM_PLL12_CTRL_N(clk / 24000000),
-	       &ccm->pll12_periph1_cfg);
-
-	sdelay(2000);
-}
-
-
-void clock_set_pll4(unsigned int clk)
-{
-	struct sunxi_ccm_reg * const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-
-	writel(CCM_PLL4_CTRL_EN | CCM_PLL4_CTRL_N(clk / 24000000),
-	       &ccm->pll4_periph0_cfg);
-
-	sdelay(2000);
-}
-#endif
 
 int clock_twi_onoff(int port, int state)
 {
@@ -193,7 +190,9 @@ int clock_twi_onoff(int port, int state)
 
 	return 0;
 }
+#endif /* CONFIG_SPL_BUILD */
 
+/* PLL_PERIPH0 clock (used by the MMC driver) */
 unsigned int clock_get_pll4_periph0(void)
 {
 	struct sunxi_ccm_reg *const ccm =
-- 
2.35.8

