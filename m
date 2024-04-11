Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C52CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C947A88149;
	Thu, 11 Apr 2024 06:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="u+kBPUEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D8888013; Thu, 11 Apr 2024 06:27:04 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6443D88120
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lKMVJ73f6Nb2LMmcsNBMmQfTNk9cknfMRLApBsRpi4=;
 b=u+kBPUEZXD/FSqZbzixBk9Gz5EM/CcJbIFmNNqSWcZDLDOYV3eiXAEqbwLeOXEuO0ok0CX
 DRZsTNvSzpHXULxerMpAPLuNHzwVMT/m/aI4qY67oyMdf8MdYBolPNu/2/6NK3JqBstZHv
 2r1T2Ccdub/+2Xek8cxxGoGjlV/xAz6k9n4kZ34lo3dXMFoP85/j0rjHoMbDa0IRu4+YQO
 sGwPbn7rAcAxzCaktZo88cARDXn+87SWIEXJYwlyJEXW8pSkzokA/zWkJRnB3J2cvTHZcR
 Yc5ILzzzHHt9ipxGxgGncna5Yb30B+ZHkeQiUL+V6XZjV796UrISyxt752+Pag==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:18 +1000
Subject: [PATCH RFC 01/15] sunxi: SPL SPI: Add SPI boot support for the
 Allwinner R528/T113 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-1-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809531; l=7921;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=Yy4X+xhTna7kJp5ZjASMnzURZHw5est2CSExE+NooWo=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAfUoIKBc4YpT18/X0QDuO64V
 4JOdBU0lSjC4k5COXhXWw4YdvuDgOnc+VzQW6+ISyHlGx5PeeO58KjaxXblmBBQUAAOkU
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

From: Maksim Kiselev <bigunclemax@gmail.com>

R528/T113 SoCs uses the same SPI IP as the H6, also have the same clocks
and reset bits layout, but the CCU base is different. Another difference
is that the new SoCs do not have a clock divider inside. Instead of this
we should configure sample mode depending on input clock rate.

The pin assignment is also different: the H6 uses PC0, the R528/T113 PC4
instead. This makes for a change in spi0_pinmux_setup() routine.

This patch extends the H6/H616 #ifdef guards to also cover the R528/T113,
using the shared CONFIG_SUNXI_GEN_NCAT2 and CONFIG_MACH_SUN8I_R528
symbols. Also use CONFIG_SUNXI_GEN_NCAT2 symbol for the Kconfig
dependency.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig         |  2 +-
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 78 +++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index fe89aec6b9..ddf9414b08 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1078,7 +1078,7 @@ config SPL_STACK_R_ADDR
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
 	help
 	  Enable support for SPI Flash. This option allows SPL to read from
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 72faa7171c..7acb44f52a 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -72,18 +72,27 @@
 #define SUN6I_CTL_ENABLE            BIT(0)
 #define SUN6I_CTL_MASTER            BIT(1)
 #define SUN6I_CTL_SRST              BIT(31)
+#define SUN6I_TCR_SDM               BIT(13)
 #define SUN6I_TCR_XCH               BIT(31)
 
 /*****************************************************************************/
 
-#define CCM_AHB_GATING0             (0x01C20000 + 0x60)
-#define CCM_H6_SPI_BGR_REG          (0x03001000 + 0x96c)
-#ifdef CONFIG_SUN50I_GEN_H6
-#define CCM_SPI0_CLK                (0x03001000 + 0x940)
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6)
+#define CCM_BASE                    0x03001000
+#elif IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+#define CCM_BASE                    0x02001000
 #else
-#define CCM_SPI0_CLK                (0x01C20000 + 0xA0)
+#define CCM_BASE                    0x01C20000
 #endif
-#define SUN6I_BUS_SOFT_RST_REG0     (0x01C20000 + 0x2C0)
+
+#define CCM_AHB_GATING0             (CCM_BASE + 0x60)
+#define CCM_H6_SPI_BGR_REG          (CCM_BASE + 0x96c)
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+#define CCM_SPI0_CLK                (CCM_BASE + 0x940)
+#else
+#define CCM_SPI0_CLK                (CCM_BASE + 0xA0)
+#endif
+#define SUN6I_BUS_SOFT_RST_REG0     (CCM_BASE + 0x2C0)
 
 #define AHB_RESET_SPI0_SHIFT        20
 #define AHB_GATE_OFFSET_SPI0        20
@@ -101,17 +110,22 @@
  */
 static void spi0_pinmux_setup(unsigned int pin_function)
 {
-	/* All chips use PC0 and PC2. */
-	sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
+	/* All chips use PC2. And all chips use PC0, except R528/T113 */
+	if (!IS_ENABLED(CONFIG_MACH_SUN8I_R528))
+		sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
+
 	sunxi_gpio_set_cfgpin(SUNXI_GPC(2), pin_function);
 
-	/* All chips except H6 and H616 use PC1. */
-	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	/* All chips except H6/H616/R528/T113 use PC1. */
+	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
+	    !IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 		sunxi_gpio_set_cfgpin(SUNXI_GPC(1), pin_function);
 
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
+	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 		sunxi_gpio_set_cfgpin(SUNXI_GPC(5), pin_function);
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
+	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 		sunxi_gpio_set_cfgpin(SUNXI_GPC(4), pin_function);
 
 	/* Older generations use PC23 for CS, newer ones use PC3. */
@@ -125,7 +139,8 @@ static void spi0_pinmux_setup(unsigned int pin_function)
 static bool is_sun6i_gen_spi(void)
 {
 	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
-	       IS_ENABLED(CONFIG_SUN50I_GEN_H6);
+	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
 }
 
 static uintptr_t spi0_base_address(void)
@@ -136,6 +151,9 @@ static uintptr_t spi0_base_address(void)
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
 		return 0x05010000;
 
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+		return 0x04025000;
+
 	if (!is_sun6i_gen_spi() ||
 	    IS_ENABLED(CONFIG_MACH_SUNIV))
 		return 0x01C05000;
@@ -151,23 +169,30 @@ static void spi0_enable_clock(void)
 	uintptr_t base = spi0_base_address();
 
 	/* Deassert SPI0 reset on SUN6I */
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	    IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		setbits_le32(CCM_H6_SPI_BGR_REG, (1U << 16) | 0x1);
 	else if (is_sun6i_gen_spi())
 		setbits_le32(SUN6I_BUS_SOFT_RST_REG0,
 			     (1 << AHB_RESET_SPI0_SHIFT));
 
 	/* Open the SPI0 gate */
-	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
+	    !IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		setbits_le32(CCM_AHB_GATING0, (1 << AHB_GATE_OFFSET_SPI0));
 
 	if (IS_ENABLED(CONFIG_MACH_SUNIV)) {
 		/* Divide by 32, clock source is AHB clock 200MHz */
 		writel(SPI0_CLK_DIV_BY_32, base + SUN6I_SPI0_CCTL);
 	} else {
-		/* Divide by 4 */
-		writel(SPI0_CLK_DIV_BY_4, base + (is_sun6i_gen_spi() ?
-					  SUN6I_SPI0_CCTL : SUN4I_SPI0_CCTL));
+		/* New SoCs do not have a clock divider inside */
+		if (!IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+			/* Divide by 4 */
+			writel(SPI0_CLK_DIV_BY_4,
+			       base + (is_sun6i_gen_spi() ? SUN6I_SPI0_CCTL :
+			       SUN4I_SPI0_CCTL));
+		}
+
 		/* 24MHz from OSC24M */
 		writel((1 << 31), CCM_SPI0_CLK);
 	}
@@ -179,6 +204,14 @@ static void spi0_enable_clock(void)
 		/* Wait for completion */
 		while (readl(base + SUN6I_SPI0_GCR) & SUN6I_CTL_SRST)
 			;
+
+		/*
+		 * For new SoCs we should configure sample mode depending on
+		 * input clock. As 24MHz from OSC24M is used, we could use
+		 * normal sample mode by setting SDM bit in the TCR register
+		 */
+		if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+			setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_SDM);
 	} else {
 		/* Enable SPI in the master mode and reset FIFO */
 		setbits_le32(base + SUN4I_SPI0_CTL, SUN4I_CTL_MASTER |
@@ -205,11 +238,13 @@ static void spi0_disable_clock(void)
 		writel(0, CCM_SPI0_CLK);
 
 	/* Close the SPI0 gate */
-	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
+	    !IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		clrbits_le32(CCM_AHB_GATING0, (1 << AHB_GATE_OFFSET_SPI0));
 
 	/* Assert SPI0 reset on SUN6I */
-	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	    IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
 		clrbits_le32(CCM_H6_SPI_BGR_REG, (1U << 16) | 0x1);
 	else if (is_sun6i_gen_spi())
 		clrbits_le32(SUN6I_BUS_SOFT_RST_REG0,
@@ -223,7 +258,8 @@ static void spi0_init(void)
 	if (IS_ENABLED(CONFIG_MACH_SUN50I) ||
 	    IS_ENABLED(CONFIG_SUN50I_GEN_H6))
 		pin_function = SUN50I_GPC_SPI0;
-	else if (IS_ENABLED(CONFIG_MACH_SUNIV))
+	else if (IS_ENABLED(CONFIG_MACH_SUNIV) ||
+		 IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 		pin_function = SUNIV_GPC_SPI0;
 
 	spi0_pinmux_setup(pin_function);

-- 
2.44.0

