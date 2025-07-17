Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F251EC83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75AE83531;
	Fri, 18 Jul 2025 01:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E518349B; Fri, 18 Jul 2025 01:56:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5612B83479
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341AB168F;
 Thu, 17 Jul 2025 16:56:45 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0733F694;
 Thu, 17 Jul 2025 16:56:51 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/20] sunxi: clock: H6: unify PLL control bit definitions
Date: Fri, 18 Jul 2025 00:54:36 +0100
Message-ID: <20250717235455.32528-2-andre.przywara@arm.com>
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

The Allwinner PLLs share most of their control bits, they differ mostly
in the factors and dividers.

Drop the PLL specific definition of those common bits, and use one
shared macro, for all PLLs.

This requires changing the users in the SPL clock and DRAM code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 20 +++++++------------
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 13 +++++++-----
 arch/arm/mach-sunxi/dram_sun50i_a133.c        | 10 +++++-----
 arch/arm/mach-sunxi/dram_sun50i_h6.c          |  6 +++---
 arch/arm/mach-sunxi/dram_sun50i_h616.c        |  6 +++---
 5 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 575dff68804..37a620c9866 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -31,29 +31,23 @@
 #define CCU_H6_UART_GATE_RESET		0x90c
 #define CCU_H6_I2C_GATE_RESET		0x91c
 
-/* pll1 bit field */
-#define CCM_PLL1_CTRL_EN		BIT(31)
-#define CCM_PLL1_LDO_EN			BIT(30)
-#define CCM_PLL1_LOCK_EN		BIT(29)
-#define CCM_PLL1_LOCK			BIT(28)
-#define CCM_PLL1_OUT_EN			BIT(27)
+/* PLL bit fields */
+#define CCM_PLL_CTRL_EN			BIT(31)
+#define CCM_PLL_LDO_EN			BIT(30)
+#define CCM_PLL_LOCK_EN			BIT(29)
+#define CCM_PLL_LOCK			BIT(28)
+#define CCM_PLL_OUT_EN			BIT(27)
+#define CCM_PLL1_UPDATE			BIT(26)
 #define CCM_PLL1_CLOCK_TIME_2		(2 << 24)
 #define CCM_PLL1_CTRL_P(p)		((p) << 16)
 #define CCM_PLL1_CTRL_N(n)		(((n) - 1) << 8)
 
 /* pll5 bit field */
-#define CCM_PLL5_CTRL_EN		BIT(31)
-#define CCM_PLL5_LOCK_EN		BIT(29)
-#define CCM_PLL5_LOCK			BIT(28)
-#define CCM_PLL5_OUT_EN			BIT(27)
 #define CCM_PLL5_CTRL_N(n)		(((n) - 1) << 8)
 #define CCM_PLL5_CTRL_DIV1(div1)	((div1) << 0)
 #define CCM_PLL5_CTRL_DIV2(div0)	((div0) << 1)
 
 /* pll6 bit field */
-#define CCM_PLL6_CTRL_EN		BIT(31)
-#define CCM_PLL6_LOCK_EN		BIT(29)
-#define CCM_PLL6_LOCK			BIT(28)
 #define CCM_PLL6_CTRL_P0_SHIFT		16
 #define CCM_PLL6_CTRL_P0_MASK		(0x7 << CCM_PLL6_CTRL_P0_SHIFT)
 #define CCM_PLL6_CTRL_N_SHIFT		8
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 3f375a51965..2f2fd5df93d 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0+
+
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clock.h>
@@ -31,7 +33,7 @@ void clock_init_safe(void)
 	clock_set_pll1(408000000);
 
 	writel(CCM_PLL6_DEFAULT, ccm + CCU_H6_PLL6_CFG);
-	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL6_LOCK))
+	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL_LOCK))
 		;
 
 	clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
@@ -85,15 +87,16 @@ void clock_set_pll1(unsigned int clk)
 	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 
 	/* clk = 24*n/p, p is ignored if clock is >288MHz */
-	val = CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
+	val = CCM_PLL_CTRL_EN | CCM_PLL_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
 	val |= CCM_PLL1_CTRL_N(clk / 24000000);
 	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
 	    IS_ENABLED(CONFIG_MACH_SUN50I_A133))
-	       val |= CCM_PLL1_OUT_EN;
+		val |= CCM_PLL_OUT_EN;
 	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
-	       val |= CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
+		val |= CCM_PLL_OUT_EN | CCM_PLL_LDO_EN;
 	writel(val, ccm + CCU_H6_PLL1_CFG);
-	while (!(readl(ccm + CCU_H6_PLL1_CFG) & CCM_PLL1_LOCK)) {}
+	while (!(readl(ccm + CCU_H6_PLL1_CFG) & CCM_PLL_LOCK))
+		;
 
 	/* Switch CPU to PLL1 */
 	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index a0fca3738f4..3a231141168 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -78,19 +78,19 @@ static void mctl_clk_init(u32 clk)
 	clrbits_le32(ccm + CCU_H6_MBUS_CFG, MBUS_RESET);
 	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(GATE_SHIFT));
 	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(RESET_SHIFT));
-	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL5_CTRL_EN);
+	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL_CTRL_EN);
 	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_MOD_RESET);
 	udelay(5);
 
 	/* Set up PLL5 clock, used for DRAM */
 	clrsetbits_le32(ccm + CCU_H6_PLL5_CFG, 0xff03,
-			CCM_PLL5_CTRL_N((clk * 2) / 24) | CCM_PLL5_CTRL_EN);
+			CCM_PLL5_CTRL_N((clk * 2) / 24) | CCM_PLL_CTRL_EN);
 	setbits_le32(ccm + CCU_H6_PLL5_CFG, BIT(24));
 	clrsetbits_le32(ccm + CCU_H6_PLL5_CFG, 0x3,
-			CCM_PLL5_LOCK_EN | CCM_PLL5_CTRL_EN | BIT(30));
-	clrbits_le32(ccm + CCU_H6_PLL5_CFG, 0x3 | BIT(30));
+			CCM_PLL_LOCK_EN | CCM_PLL_CTRL_EN | CCM_PLL_LDO_EN);
+	clrbits_le32(ccm + CCU_H6_PLL5_CFG, 0x3 | CCM_PLL_LDO_EN);
 	mctl_await_completion(ccm + CCU_H6_PLL5_CFG,
-			      CCM_PLL5_LOCK, CCM_PLL5_LOCK);
+			      CCM_PLL_LOCK, CCM_PLL_LOCK);
 
 	/* Enable DRAM clock and gate*/
 	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, BIT(24) | BIT(25));
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 84fd64a2bfc..ea26e6dd327 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -167,16 +167,16 @@ static void mctl_sys_init(u32 clk_rate)
 	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(0));
 	udelay(5);
 	writel(0, ccm + CCU_H6_DRAM_GATE_RESET);
-	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL5_CTRL_EN);
+	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL_CTRL_EN);
 	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_MOD_RESET);
 
 	udelay(5);
 
 	/* Set PLL5 rate to doubled DRAM clock rate */
-	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN |
+	writel(CCM_PLL_CTRL_EN | CCM_PLL_LOCK_EN |
 	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), ccm + CCU_H6_PLL5_CFG);
 	mctl_await_completion(ccm + CCU_H6_PLL5_CFG,
-			      CCM_PLL5_LOCK, CCM_PLL5_LOCK);
+			      CCM_PLL_LOCK, CCM_PLL_LOCK);
 
 	/* Configure DRAM mod clock */
 	writel(DRAM_CLK_SRC_PLL5, ccm + CCU_H6_DRAM_CLK_CFG);
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 5a59f82d1ef..877181016f3 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -106,16 +106,16 @@ static void mctl_sys_init(u32 clk_rate)
 	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(GATE_SHIFT));
 	udelay(5);
 	clrbits_le32(ccm + CCU_H6_DRAM_GATE_RESET, BIT(RESET_SHIFT));
-	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL5_CTRL_EN);
+	clrbits_le32(ccm + CCU_H6_PLL5_CFG, CCM_PLL_CTRL_EN);
 	clrbits_le32(ccm + CCU_H6_DRAM_CLK_CFG, DRAM_MOD_RESET);
 
 	udelay(5);
 
 	/* Set PLL5 rate to doubled DRAM clock rate */
-	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN | CCM_PLL5_OUT_EN |
+	writel(CCM_PLL_CTRL_EN | CCM_PLL_LOCK_EN | CCM_PLL_OUT_EN |
 	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), ccm + CCU_H6_PLL5_CFG);
 	mctl_await_completion(ccm + CCU_H6_PLL5_CFG,
-			      CCM_PLL5_LOCK, CCM_PLL5_LOCK);
+			      CCM_PLL_LOCK, CCM_PLL_LOCK);
 
 	/* Configure DRAM mod clock */
 	writel(DRAM_CLK_SRC_PLL5, ccm + CCU_H6_DRAM_CLK_CFG);
-- 
2.46.3

