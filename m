Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F77AC83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63AC58352B;
	Fri, 18 Jul 2025 01:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4A98353A; Fri, 18 Jul 2025 01:56:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B3D5F834BC
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B1B61762;
 Thu, 17 Jul 2025 16:56:46 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028E83F694;
 Thu, 17 Jul 2025 16:56:52 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/20] sunxi: clock: H6: factor out clock_set_pll()
Date: Fri, 18 Jul 2025 00:54:37 +0100
Message-ID: <20250717235455.32528-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250717235455.32528-1-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
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

The SPL initial clock setup code for the Allwinner H6 and H616 SoCs uses
a simple CPU PLL setup routine, which programs all register bits at once,
then waits for the LOCK bit to clear.
The manual suggests to follow a certain procedure for bringing up any
PLLs, which involves several register writes, one at a time, and some
delays. Also the H616 and the new A523 require some tiny changes in this
sequence, and the different SoCs also feature some extra bits here and
there, which we should not just clear.

So factor out the PLL setup routine, and make it follow the manual's
suggestion. This will read the PLL register at the beginning, then tweak
the bits we need to manipulate, and writes the register several times on
the way. This allows to cover the specific bits for different SoCs.

Besides improving the reliability of the PLL setup, this helps with the
A523, which requires *three* CPU PLLs to be programmed.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  |  2 +-
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 60 +++++++++++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 37a620c9866..5d6519d2367 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -38,8 +38,8 @@
 #define CCM_PLL_LOCK			BIT(28)
 #define CCM_PLL_OUT_EN			BIT(27)
 #define CCM_PLL1_UPDATE			BIT(26)
-#define CCM_PLL1_CLOCK_TIME_2		(2 << 24)
 #define CCM_PLL1_CTRL_P(p)		((p) << 16)
+#define CCM_PLL1_CTRL_N_MASK		GENMASK(15, 8)
 #define CCM_PLL1_CTRL_N(n)		(((n) - 1) << 8)
 
 /* pll5 bit field */
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 2f2fd5df93d..90436b45b40 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -4,6 +4,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/prcm.h>
+#include <linux/delay.h>
 
 #ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
@@ -72,6 +73,53 @@ void clock_init_uart(void)
 		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
 }
 
+static bool has_pll_output_gate(void)
+{
+	return (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
+		IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
+		IS_ENABLED(CONFIG_MACH_SUN50I_A133));
+}
+
+/* A shared routine to program the CPU PLLs for H6, H616, T113, A523 */
+static void clock_set_pll(u32 *reg, unsigned int n)
+{
+	u32 val = readl(reg);
+
+	/* clear the lock enable bit */
+	val &= ~CCM_PLL_LOCK_EN;
+	writel(val, reg);
+
+	/* gate the output on the newer SoCs */
+	if (has_pll_output_gate()) {
+		val &= ~CCM_PLL_OUT_EN;
+		writel(val, reg);
+	}
+
+	val &= ~(CCM_PLL1_CTRL_N_MASK | GENMASK(3, 0) | GENMASK(21, 16));
+	val |= CCM_PLL1_CTRL_N(n);
+	writel(val, reg);			/* program parameter */
+
+	val |= CCM_PLL_CTRL_EN;
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+		val |= CCM_PLL_LDO_EN;
+	writel(val, reg);			/* enable PLL */
+
+	val |= CCM_PLL_LOCK_EN;
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+		val |= CCM_PLL1_UPDATE;
+	writel(val, reg);			/* start locking process */
+
+	while (!(readl(reg) & CCM_PLL_LOCK)) {	/* wait for lock bit */
+	}
+	udelay(20);				/* wait as per manual */
+
+	/* un-gate the output on the newer SoCs */
+	if (has_pll_output_gate()) {
+		val |= CCM_PLL_OUT_EN;
+		writel(val, reg);
+	}
+}
+
 void clock_set_pll1(unsigned int clk)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
@@ -86,17 +134,7 @@ void clock_set_pll1(unsigned int clk)
 	val |= CCM_CPU_AXI_MUX_OSC24M;
 	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 
-	/* clk = 24*n/p, p is ignored if clock is >288MHz */
-	val = CCM_PLL_CTRL_EN | CCM_PLL_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
-	val |= CCM_PLL1_CTRL_N(clk / 24000000);
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
-	    IS_ENABLED(CONFIG_MACH_SUN50I_A133))
-		val |= CCM_PLL_OUT_EN;
-	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
-		val |= CCM_PLL_OUT_EN | CCM_PLL_LDO_EN;
-	writel(val, ccm + CCU_H6_PLL1_CFG);
-	while (!(readl(ccm + CCU_H6_PLL1_CFG) & CCM_PLL_LOCK))
-		;
+	clock_set_pll(ccm + CCU_H6_PLL1_CFG, clk / 24000000);
 
 	/* Switch CPU to PLL1 */
 	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
-- 
2.46.3

