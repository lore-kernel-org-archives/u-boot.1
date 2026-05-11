Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57739CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59B28464D;
	Mon, 11 May 2026 23:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="B7G5r0ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B0C8466C; Mon, 11 May 2026 23:38:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 85FF5845E9
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78FE22C34;
 Mon, 11 May 2026 14:37:57 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 3F2093F85F; Mon, 11 May 2026 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778535482; bh=lA6JiRAdI1XNNDYB3a5liEgF5w+Ea9wm3rCG6xAJBk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B7G5r0ZM21q1CUN2G2/a7f7aDhxA8gZ/tU3F/ZJLJ2yYcqcxccM6779CRUpJBj7Bv
 E72pCk1L7cn1JK6WHlukPWMc/vVoWro/XWMnwfmNFyMu3l+EpV3CyG3AtalD2nHhW2
 zSW7extABQw0gMkICIHPiELGvvaBNsaMZiqmqxnk=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 2/5] sunxi: spl: spi: Clean up SPI0 pinmux setting
Date: Mon, 11 May 2026 23:37:10 +0200
Message-ID: <20260511213713.15943-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260511213713.15943-1-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
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

The function to set the pinmux for the Port C SPI0 pins was looking more
like a logic puzzle from a magazine than something that readers could
understand and extend.

Replace the convoluted pinmux setup, grouped by pin, with a simple array
of the four pins involved, and just initialise this array at build time,
based on the selected SoC.

This makes it easy to see which pins are needed, and even easier to extend.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 43 ++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 5f72e809952..905a7db2a77 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -105,35 +105,28 @@
 
 /*
  * Allwinner A10/A20 SoCs were using pins PC0,PC1,PC2,PC23 for booting
- * from SPI Flash, everything else is using pins PC0,PC1,PC2,PC3.
- * The H6 uses PC0, PC2, PC3, PC5, the H616 PC0, PC2, PC3, PC4.
+ * from SPI Flash, later SoCs are using pins PC0,PC1,PC2,PC3.
+ * Newer SoCs are all over the place.
  */
 static void spi0_pinmux_setup(unsigned int pin_function)
 {
-	/* All chips use PC2. And all chips use PC0, except R528/T113 */
-	if (!IS_ENABLED(CONFIG_MACH_SUN8I_R528))
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
-
-	sunxi_gpio_set_cfgpin(SUNXI_GPC(2), pin_function);
+	const u16 spi0_pc_pins[4] = {
+#if IS_ENABLED(CONFIG_MACH_SUN8I_R528)
+		SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4), SUNXI_GPC(5)
+#elif IS_ENABLED(CONFIG_MACH_SUN50I_H616)
+		SUNXI_GPC(0), SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4)
+#elif IS_ENABLED(CONFIG_MACH_SUN50I_H6)
+		SUNXI_GPC(0), SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(5)
+#elif IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN5I) || \
+      IS_ENABLED(CONFIG_MACH_SUN7I) || IS_ENABLED(CONFIG_MACH_SUN8I_R40)
+		SUNXI_GPC(0), SUNXI_GPC(1), SUNXI_GPC(2), SUNXI_GPC(23)
+#else
+		SUNXI_GPC(0), SUNXI_GPC(1), SUNXI_GPC(2), SUNXI_GPC(3)
+#endif
+	};
 
-	/* All chips except H6/H616/R528/T113 use PC1. */
-	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
-	    !IS_ENABLED(CONFIG_MACH_SUN8I_R528))
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(1), pin_function);
-
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
-	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(5), pin_function);
-	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
-	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(4), pin_function);
-
-	/* Older generations use PC23 for CS, newer ones use PC3. */
-	if (IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN7I) ||
-	    IS_ENABLED(CONFIG_MACH_SUN8I_R40))
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(23), pin_function);
-	else
-		sunxi_gpio_set_cfgpin(SUNXI_GPC(3), pin_function);
+	for (int i = 0; i < 4; i++)
+		sunxi_gpio_set_cfgpin(spi0_pc_pins[i], pin_function);
 }
 
 static bool is_sun6i_gen_spi(void)
-- 
2.46.4

