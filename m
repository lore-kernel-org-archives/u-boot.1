Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1981C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DED786F1C;
	Sat, 11 Nov 2023 14:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YWjIvgjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CA786F26; Sat, 11 Nov 2023 14:37:12 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0F486EF6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507a62d4788so4168785e87.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699709829; x=1700314629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/luwKN2c8mvXFq4Xor1cHPXI5hjYjZleTwY8hwv2Ik=;
 b=YWjIvgjWi3o1pTh4wlFggCI2M/YQit4Ihw8Z0Jb63Er1O2Slb3JV/ClqNqII5I/DNX
 Tf58JzMd49D5+JVaPtvdclvK6g7R4lrQUS5yHjOAEdBTyjlpQftogLqIag23iAwv9sm3
 TlYTCf0WfmiwnaxHZ5YtaBBTXyNIcOcCejlQS75hHSyaYn6YQAh4OzQacsav28o/+suD
 pYIClLIMLT012EErNvoGfkjypElJnu6ol0yj4m07C2vSiHA3+gVcrKEtkTBh/YOtDyGb
 EVoIio5D+iDPQsdyeRPTcWBhFRT0IeoNPDL+aQ772611niEipDucRjcPZxMRgwuf/+kT
 lqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699709829; x=1700314629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/luwKN2c8mvXFq4Xor1cHPXI5hjYjZleTwY8hwv2Ik=;
 b=OqI05oWVu6Qgud1IaV0LVyN0X29okKw/XLVp59Ow5azv+nvKVp/OAc/klMRQAfU91l
 epx/OHjHDsgc55v2vPNzyOzMRJzIg2g/C4OKOXdI310kT7OL8dxTdw740iUk6GRokf9e
 NaFdCONsnl/TKo57UUvQDMGXWL7MuH0Q6Oo497uNLrjmrZ8q8kumjYJATPoqgLgQmfi9
 nCRJzyMTDzieqSJx6ChKItM0JdomhchFxJJD7FP6vqiGLZMnGFuskejpTyMEHr3qw9da
 qvGlnLkdKZ29pvgnTCQn4UKZShOM3x2iz4GIXBCQdIwezCupSBVq335lmQ2ky1tFCNb1
 fIig==
X-Gm-Message-State: AOJu0YyJGZv/MpJ84zcj5XZ5Fe1BZbR7ZPMUplhM6VUefyqGFdJiK14A
 Ce2BeiYCC03ZnLi9yI18ZaoaCPfk34eXiw==
X-Google-Smtp-Source: AGHT+IGidX9QpYFixle7aU610Zi3z9b3GWwST/4x1DM7OktVrQx/sjq8U8vT0BRgJ47q/r9aeSx3cw==
X-Received: by 2002:ac2:44cd:0:b0:503:2e6:685e with SMTP id
 d13-20020ac244cd000000b0050302e6685emr1075048lfm.14.1699709828782; 
 Sat, 11 Nov 2023 05:37:08 -0800 (PST)
Received: from user-PC.. ([178.134.170.122]) by smtp.gmail.com with ESMTPSA id
 h6-20020a0565123c8600b00509469ffb01sm277432lfv.193.2023.11.11.05.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:37:08 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Sam Edwards <CFSworks@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v1 1/2] sunxi: SPL SPI: Add SPI boot support for the Allwinner
 R528/T113 SoCs
Date: Sat, 11 Nov 2023 16:33:07 +0300
Message-Id: <20231111133432.755363-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231111133432.755363-1-bigunclemax@gmail.com>
References: <20231111133432.755363-1-bigunclemax@gmail.com>
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
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 78 +++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index a10e4c06b6..732f60821a 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1044,7 +1044,7 @@ config SPL_STACK_R_ADDR
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
 	help
 	  Enable support for SPI Flash. This option allows SPL to read from
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index c2410dd7bb..ba3b1579f0 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -73,18 +73,27 @@
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
@@ -102,17 +111,22 @@
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
@@ -126,7 +140,8 @@ static void spi0_pinmux_setup(unsigned int pin_function)
 static bool is_sun6i_gen_spi(void)
 {
 	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
-	       IS_ENABLED(CONFIG_SUN50I_GEN_H6);
+	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
 }
 
 static uintptr_t spi0_base_address(void)
@@ -137,6 +152,9 @@ static uintptr_t spi0_base_address(void)
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
 		return 0x05010000;
 
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+		return 0x04025000;
+
 	if (!is_sun6i_gen_spi() ||
 	    IS_ENABLED(CONFIG_MACH_SUNIV))
 		return 0x01C05000;
@@ -152,23 +170,30 @@ static void spi0_enable_clock(void)
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
@@ -180,6 +205,14 @@ static void spi0_enable_clock(void)
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
@@ -206,11 +239,13 @@ static void spi0_disable_clock(void)
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
@@ -224,7 +259,8 @@ static void spi0_init(void)
 	if (IS_ENABLED(CONFIG_MACH_SUN50I) ||
 	    IS_ENABLED(CONFIG_SUN50I_GEN_H6))
 		pin_function = SUN50I_GPC_SPI0;
-	else if (IS_ENABLED(CONFIG_MACH_SUNIV))
+	else if (IS_ENABLED(CONFIG_MACH_SUNIV) ||
+		 IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 		pin_function = SUNIV_GPC_SPI0;
 
 	spi0_pinmux_setup(pin_function);
-- 
2.40.1

