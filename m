Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D46AC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A656981B4B;
	Sun, 23 Mar 2025 12:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B2181DD6; Sun, 23 Mar 2025 12:36:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3820E81219
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66179106F;
 Sun, 23 Mar 2025 04:36:32 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBC23F694;
 Sun, 23 Mar 2025 04:36:24 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 12/34] sunxi: clock: H6: add A523 CPU PLL support
Date: Sun, 23 Mar 2025 11:35:22 +0000
Message-ID: <20250323113544.7933-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

The Allwinner A523 features 8 CPU cores, organised in two clusters, both
driven by separate PLLs. Also there is the DSU PLL, which clocks the
hardware that connects the cores to the rest of the system.
And while the PLL registers itself are very similar, they are located in
a separate register frame, outside the main CCU, and also the register
controlling the CPU clock source (mux) is different.

Provide a separate function that reparents the two clusters and the DSU,
while their PLLs are programmed. For the actual PLL programming, we rely
on the existing shared routine.

The selection between the new A523 routine and the existing code is made
with C if statements, but since the choice is effectively made at compile
time already, the compiler optimises away the other code paths, leaving
just the one required function in.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 17 ++++++++
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  2 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 40 ++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 6761ce9d8f7..c95f2b39e64 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #endif
 
+/* Main CCU register offsets */
 #define CCU_H6_PLL1_CFG			0x000
 #define CCU_H6_PLL5_CFG			0x010
 #define CCU_H6_PLL6_CFG			0x020
@@ -31,6 +32,14 @@
 #define CCU_H6_UART_GATE_RESET		0x90c
 #define CCU_H6_I2C_GATE_RESET		0x91c
 
+/* A523 CPU PLL offsets */
+#define CPC_CPUA_PLL_CTRL		0x04
+#define CPC_DSU_PLL_CTRL		0x08
+#define CPC_CPUB_PLL_CTRL		0x0c
+#define CPC_CPUA_CLK_REG		0x60
+#define CPC_CPUB_CLK_REG		0x64
+#define CPC_DSU_CLK_REG			0x6c
+
 /* PLL bit fields */
 #define CCM_PLL_CTRL_EN			BIT(31)
 #define CCM_PLL_LDO_EN			BIT(30)
@@ -42,6 +51,14 @@
 #define CCM_PLL1_CTRL_N_MASK		GENMASK(15, 8)
 #define CCM_PLL1_CTRL_N(n)		(((n) - 1) << 8)
 
+/* A523 CPU clock fields */
+#define CPU_CLK_SRC_HOSC		(0 << 24)
+#define CPU_CLK_SRC_CPUPLL		(3 << 24)
+#define CPU_CLK_CTRL_P(p)		((p) << 16)
+#define CPU_CLK_APB_DIV(n)		(((n) - 1) << 8)
+#define CPU_CLK_PERI_DIV(m1)		(((m1) - 1) << 2)
+#define CPU_CLK_AXI_DIV(m)		(((m) - 1) << 0)
+
 /* pll5 bit field */
 #define CCM_PLL5_CTRL_N(n)		(((n) - 1) << 8)
 #define CCM_PLL5_CTRL_DIV1(div1)	((div1) << 0)
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index 908a582ae0f..c04ddb3f1d4 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -30,6 +30,8 @@
 
 #define SUNXI_CPUCFG_BASE		0x09010000
 
+#define SUNXI_CPU_PLL_CFG_BASE		0x08817000
+
 #ifndef __ASSEMBLY__
 void sunxi_board_init(void);
 void sunxi_reset(void);
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index b205b0a0550..f76d1b83883 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -4,6 +4,10 @@
 #include <asm/arch/prcm.h>
 #include <linux/delay.h>
 
+#ifndef SUNXI_CPU_PLL_CFG_BASE
+#define SUNXI_CPU_PLL_CFG_BASE 0
+#endif
+
 #ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
@@ -111,6 +115,37 @@ static void clock_set_pll(u32 *reg, unsigned int n)
 	}
 }
 
+/* Program the PLLs for both clusters plus the DSU. */
+static void clock_a523_set_cpu_plls(unsigned int n_factor)
+{
+	void *const cpc = (void *)SUNXI_CPU_PLL_CFG_BASE;
+	u32 val;
+
+	val = CPU_CLK_SRC_HOSC | CPU_CLK_CTRL_P(0) |
+	       CPU_CLK_APB_DIV(4) | CPU_CLK_PERI_DIV(2) |
+	       CPU_CLK_AXI_DIV(2);
+
+	/* Switch CPU clock source to 24MHz HOSC while changing the PLL */
+	writel(val, cpc + CPC_CPUA_CLK_REG);
+	writel(val, cpc + CPC_CPUB_CLK_REG);
+	udelay(20);
+	writel(CPU_CLK_SRC_HOSC | CPU_CLK_CTRL_P(0),
+	       cpc + CPC_DSU_CLK_REG);
+	udelay(20);
+
+	clock_set_pll(cpc + CPC_CPUA_PLL_CTRL, n_factor);
+	clock_set_pll(cpc + CPC_CPUB_PLL_CTRL, n_factor);
+	clock_set_pll(cpc + CPC_DSU_PLL_CTRL, n_factor);
+
+	/* Switch CPU clock source to the CPU PLL */
+	clrsetbits_le32(cpc + CPC_CPUA_CLK_REG, CPU_CLK_SRC_HOSC,
+			CPU_CLK_SRC_CPUPLL);
+	clrsetbits_le32(cpc + CPC_CPUB_CLK_REG, CPU_CLK_SRC_HOSC,
+			CPU_CLK_SRC_CPUPLL);
+	clrsetbits_le32(cpc + CPC_DSU_CLK_REG, CPU_CLK_SRC_HOSC,
+			CPU_CLK_SRC_CPUPLL);
+}
+
 static void clock_h6_set_cpu_pll(unsigned int n_factor)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
@@ -139,7 +174,10 @@ void clock_set_pll1(unsigned int clk)
 
 	clk /= 24000000;
 
-	clock_h6_set_cpu_pll(clk);
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+		clock_a523_set_cpu_plls(clk);
+	else
+		clock_h6_set_cpu_pll(clk);
 }
 
 int clock_twi_onoff(int port, int state)
-- 
2.46.3

