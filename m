Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074C0C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAA281CA8;
	Sun, 23 Mar 2025 12:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BCE80F0E; Sun, 23 Mar 2025 12:36:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6922B81026
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C33F106F;
 Sun, 23 Mar 2025 04:36:18 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D30A43F694;
 Sun, 23 Mar 2025 04:36:10 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 01/34] sunxi: clock: H6: drop usage of struct sunxi_ccm_reg
Date: Sun, 23 Mar 2025 11:35:11 +0000
Message-ID: <20250323113544.7933-2-andre.przywara@arm.com>
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

U-Boot drivers often revert to using C structures for modelling hardware
register frames. This creates some problems:
- A "struct" is a C language construct to group several variables
  together. The details of the layout of this struct are partly subject
  to the compiler's discretion (padding and alignment).
- The "packed" attribute would force a certain layout, but we are not
  using it.
- The actual source of information from the data sheet is the register
  offset. Here we create an artificial struct, carefully tuning the
  layout (with a lot of reserved members) to match that offset. To help
  with correctness, we put the desired information as a *comment*,
  though this is purely for the human reader, and has no effect on the
  generated layout. This sounds all very backwards.
- Using a struct suggests we can assign a pointer and then access the
  register content via the members. But this is not the case, instead
  every MMIO register access must go through specific accessor functions,
  to meet the ordering and access size guarantees the hardware requires.
- We share those structs in code shared across multiple SoC families,
  though most SoCs define their own version of the struct. Members must
  match in their name, across every SoC, otherwise compilation will fail.
  We work around this with even more #ifdefs in the shared code.
- Some SoCs have an *almost* identical layout, but differ in a few
  registers. This requires hard to maintain #ifdef's in the struct
  definition.
- Some of the register frames are huge: the H6 CCU device defines 127
  registers. We use 15 of them. Still the whole frame would need to be
  described, which is very tedious, but for no reason.
- Adding a new SoC often forces people to decide whether to share an
  existing struct, or to create a new copy. For some cases (say like 80%
  similarity) this works out badly either way.

The Linux kernel heavily frowns upon those register structs, and instead
uses a much simpler solution: #define REG_NAME	<offset>
This easily maps to the actual information from the data sheet, and can
much simpler be shared across multiple SoCs, as it allows to have all
SoC versions visible, so we can use C "if" statements instead of #ifdef's.
Also it requires to just define the registers we need, and we can use
alternative locations for some registers much more easily.

Drop the usage of "struct sunxi_ccm_reg" in the H6 SPL clock code, by
defining the respective register names and their offsets, then adding
them to the base pointer.
We cannot drop the struct definition quite yet, as it's also used in
other drivers, still.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 12 +++++
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 52 +++++++++----------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 76dd33c9477..a485e00f1f3 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -13,6 +13,18 @@
 #include <linux/bitops.h>
 #endif
 
+#define CCU_H6_PLL1_CFG			0x000
+#define CCU_H6_PLL5_CFG			0x010
+#define CCU_H6_PLL6_CFG			0x020
+#define CCU_H6_CPU_AXI_CFG		0x500
+#define CCU_H6_PSI_AHB1_AHB2_CFG	0x510
+#define CCU_H6_AHB3_CFG			0x51c
+#define CCU_H6_APB1_CFG			0x520
+#define CCU_H6_APB2_CFG			0x524
+#define CCU_H6_MBUS_CFG			0x540
+#define CCU_H6_UART_GATE_RESET		0x90c
+#define CCU_H6_I2C_GATE_RESET		0x91c
+
 struct sunxi_ccm_reg {
 	u32 pll1_cfg;		/* 0x000 pll1 (cpux) control */
 	u8 reserved_0x004[12];
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index b424a7893ea..482d9e0c695 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -6,8 +6,7 @@
 #ifdef CONFIG_XPL_BUILD
 void clock_init_safe(void)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void *const ccm = (void *)SUNXI_CCM_BASE;
 	struct sunxi_prcm_reg *const prcm =
 		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
 
@@ -32,60 +31,59 @@ void clock_init_safe(void)
 
 	clock_set_pll1(408000000);
 
-	writel(CCM_PLL6_DEFAULT, &ccm->pll6_cfg);
-	while (!(readl(&ccm->pll6_cfg) & CCM_PLL6_LOCK))
+	writel(CCM_PLL6_DEFAULT, ccm + CCU_H6_PLL6_CFG);
+	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL6_LOCK))
 		;
 
-	clrsetbits_le32(&ccm->cpu_axi_cfg, CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
+	clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
+			CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
 			CCM_CPU_AXI_DEFAULT_FACTORS);
 
-	writel(CCM_PSI_AHB1_AHB2_DEFAULT, &ccm->psi_ahb1_ahb2_cfg);
+	writel(CCM_PSI_AHB1_AHB2_DEFAULT, ccm + CCU_H6_PSI_AHB1_AHB2_CFG);
 #ifdef CCM_AHB3_DEFAULT
-	writel(CCM_AHB3_DEFAULT, &ccm->ahb3_cfg);
+	writel(CCM_AHB3_DEFAULT, ccm + CCU_H6_AHB3_CFG);
 #endif
-	writel(CCM_APB1_DEFAULT, &ccm->apb1_cfg);
+	writel(CCM_APB1_DEFAULT, ccm + CCU_H6_APB1_CFG);
 
 	/*
 	 * The mux and factor are set, but the clock will be enabled in
 	 * DRAM initialization code.
 	 */
-	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), &ccm->mbus_cfg);
+	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), ccm + CCU_H6_MBUS_CFG);
 }
 
 void clock_init_uart(void)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void *const ccm = (void *)SUNXI_CCM_BASE;
 
 	/* uart clock source is apb2 */
 	writel(APB2_CLK_SRC_OSC24M|
 	       APB2_CLK_RATE_N_1|
 	       APB2_CLK_RATE_M(1),
-	       &ccm->apb2_cfg);
+	       ccm + CCU_H6_APB2_CFG);
 
 	/* open the clock for uart */
-	setbits_le32(&ccm->uart_gate_reset,
+	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
 		     1 << (CONFIG_CONS_INDEX - 1));
 
 	/* deassert uart reset */
-	setbits_le32(&ccm->uart_gate_reset,
+	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
 		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
 }
 
 void clock_set_pll1(unsigned int clk)
 {
-	struct sunxi_ccm_reg * const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void *const ccm = (void *)SUNXI_CCM_BASE;
 	u32 val;
 
 	/* Do not support clocks < 288MHz as they need factor P */
 	if (clk < 288000000) clk = 288000000;
 
 	/* Switch to 24MHz clock while changing PLL1 */
-	val = readl(&ccm->cpu_axi_cfg);
+	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
 	val &= ~CCM_CPU_AXI_MUX_MASK;
 	val |= CCM_CPU_AXI_MUX_OSC24M;
-	writel(val, &ccm->cpu_axi_cfg);
+	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 
 	/* clk = 24*n/p, p is ignored if clock is >288MHz */
 	val = CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
@@ -94,20 +92,19 @@ void clock_set_pll1(unsigned int clk)
 	       val |= CCM_PLL1_OUT_EN;
 	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 	       val |= CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
-	writel(val, &ccm->pll1_cfg);
-	while (!(readl(&ccm->pll1_cfg) & CCM_PLL1_LOCK)) {}
+	writel(val, ccm + CCU_H6_PLL1_CFG);
+	while (!(readl(ccm + CCU_H6_PLL1_CFG) & CCM_PLL1_LOCK)) {}
 
 	/* Switch CPU to PLL1 */
-	val = readl(&ccm->cpu_axi_cfg);
+	val = readl(ccm + CCU_H6_CPU_AXI_CFG);
 	val &= ~CCM_CPU_AXI_MUX_MASK;
 	val |= CCM_CPU_AXI_MUX_PLL_CPUX;
-	writel(val, &ccm->cpu_axi_cfg);
+	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
 }
 
 int clock_twi_onoff(int port, int state)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void *const ccm = (void *)SUNXI_CCM_BASE;
 	struct sunxi_prcm_reg *const prcm =
 		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
 	u32 value, *ptr;
@@ -120,7 +117,7 @@ int clock_twi_onoff(int port, int state)
 		ptr = &prcm->twi_gate_reset;
 	} else {
 		shift = port;
-		ptr = &ccm->twi_gate_reset;
+		ptr = ccm + CCU_H6_I2C_GATE_RESET;
 	}
 
 	/* set the apb clock gate and reset for twi */
@@ -136,9 +133,8 @@ int clock_twi_onoff(int port, int state)
 /* PLL_PERIPH0 clock, used by the MMC driver */
 unsigned int clock_get_pll6(void)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-	uint32_t rval = readl(&ccm->pll6_cfg);
+	void *const ccm = (void *)SUNXI_CCM_BASE;
+	uint32_t rval = readl(ccm + CCU_H6_PLL6_CFG);
 	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
 	int div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
 		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
-- 
2.46.3

