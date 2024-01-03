Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990CDC47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326AB8747A;
	Wed,  3 Jan 2024 01:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E53387950; Wed,  3 Jan 2024 01:13:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 52DF9879D2
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A222BC15;
 Tue,  2 Jan 2024 16:14:28 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7A753F5A1;
 Tue,  2 Jan 2024 16:13:41 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 12/19] sunxi: sun50i_h6: make more clock functions SPL only
Date: Wed,  3 Jan 2024 00:12:32 +0000
Message-Id: <20240103001239.17482-13-andre.przywara@arm.com>
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

In clock_sun50i_h6.c, responsible for (mostly early) clock setup on
newer generation Allwinner SoCs, many functions are only needed by the
SPL, and are thus already guarded by CONFIG_SPL_BUILD.

Over the years drivers like for the UART or I2C were converted to DM,
so they care about clock setup themselves now, by using a proper DM clock
driver.

This means those devices need the clock setup functions here for the SPL
only. Include those functions into the existing CONFIG_SPL_BUILD guards,
so they are compiled for the SPL only. By moving the clock_get_pll6()
function to the end of the file, all SPL-only clocks can be contained
within one #ifdef guard.

This avoids unnecessary code in U-Boot proper and helps further
refactoring. Add some comments on the way to help understanding of the
file.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/clock_sun50i_h6.c | 57 +++++++++++++--------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index dac3663e1be..cc2ee336416 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -51,7 +51,6 @@ void clock_init_safe(void)
 	 */
 	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), &ccm->mbus_cfg);
 }
-#endif
 
 void clock_init_uart(void)
 {
@@ -73,7 +72,6 @@ void clock_init_uart(void)
 		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
 }
 
-#ifdef CONFIG_SPL_BUILD
 void clock_set_pll1(unsigned int clk)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -105,33 +103,6 @@ void clock_set_pll1(unsigned int clk)
 	val |= CCM_CPU_AXI_MUX_PLL_CPUX;
 	writel(val, &ccm->cpu_axi_cfg);
 }
-#endif
-
-unsigned int clock_get_pll6(void)
-{
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-	uint32_t rval = readl(&ccm->pll6_cfg);
-	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
-	int div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
-		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
-	int div1, m;
-
-	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
-		div1 = ((rval & CCM_PLL6_CTRL_P0_MASK) >>
-			CCM_PLL6_CTRL_P0_SHIFT) + 1;
-		m = 1;
-	} else {
-		div1 = ((rval & CCM_PLL6_CTRL_DIV1_MASK) >>
-			CCM_PLL6_CTRL_DIV1_SHIFT) + 1;
-		if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
-			m = 4;
-		else
-			m = 2;
-	}
-
-	return 24000000U * n / m / div1 / div2;
-}
 
 int clock_twi_onoff(int port, int state)
 {
@@ -160,3 +131,31 @@ int clock_twi_onoff(int port, int state)
 
 	return 0;
 }
+#endif /* CONFIG_SPL_BUILD */
+
+/* PLL_PERIPH0 clock, used by the MMC driver */
+unsigned int clock_get_pll6(void)
+{
+	struct sunxi_ccm_reg *const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	uint32_t rval = readl(&ccm->pll6_cfg);
+	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
+	int div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
+		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
+	int div1, m;
+
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+		div1 = ((rval & CCM_PLL6_CTRL_P0_MASK) >>
+			CCM_PLL6_CTRL_P0_SHIFT) + 1;
+		m = 1;
+	} else {
+		div1 = ((rval & CCM_PLL6_CTRL_DIV1_MASK) >>
+			CCM_PLL6_CTRL_DIV1_SHIFT) + 1;
+		if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
+			m = 4;
+		else
+			m = 2;
+	}
+
+	return 24000000U * n / m / div1 / div2;
+}
-- 
2.35.8

