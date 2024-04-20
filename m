Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41628C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8D68869E;
	Sat, 20 Apr 2024 02:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="GEXW8bz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EA18813F; Sat, 20 Apr 2024 02:04:13 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33398869E
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8oK0VOk8rYQ3vJ9vXEpOrB1j+vVgQIm2UFIxpx5/zQ=;
 b=GEXW8bz4hKb2Z5UXDjssH4oTLlrKGSvpC/m+l8GwbFlZOlw6+6pFEkW8sZvSXB30vLuATS
 VIGvALVCM0+D85lroeWLiQAuPa7Cn0m7f9Es5SmuBly+CuWVDRUXhO/FgyiuR9DOzsySkX
 IWeUX7fHchm8mx/iirCgYS+bDAZBhsHjemsIlLM8A1EbdZFkwGx0qgB7uqx8lC/P4IeVGX
 OD7C+X46vHa4pCxm88Evy6gKbVJ5N459U6JNYsGtNuZHHMJ+LqtSDku5Tk7COxs9bTDehd
 PA8FOhLtbjEM0HUPx2Nit84PTiXftPXbEgsAJ01vgWMdtZkLuJMiecQY7tVpiQ==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:37 +1000
Subject: [PATCH RFC 4/9] sunxi: video: support LCD on H6/D1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-4-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571377; l=3146;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=rEvFd18YwRHNn/jxbegK4wU2B8UsGXHXGeMz/kbD8/M=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA0Z3N/IfBEBAy7hx/nK6xbxc
 VcycfBEn5mwaiGWZzHUhLnB6nG9fZQo3JvmuXoifV9dNy37ULZ5KHyMhWfccJBwUAAOo8
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

The H6/D1/R528 don't require any big changes, just some small
tweaks to support new clock and reset logic.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/sunxi/lcdc.c      | 20 ++++++++++++++++++++
 drivers/video/sunxi/sunxi_lcd.c |  6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sunxi/lcdc.c b/drivers/video/sunxi/lcdc.c
index 73033c3b85..ea21d602be 100644
--- a/drivers/video/sunxi/lcdc.c
+++ b/drivers/video/sunxi/lcdc.c
@@ -277,6 +277,12 @@ void lcdc_pll_set(struct sunxi_ccm_reg *ccm, int tcon, int dotclock,
 		}
 	}
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	/* No need to clock doubling, just ask for a higher PLL clock */
+	best_double = 0;
+	step *= 2;
+#endif
+
 #ifdef CONFIG_MACH_SUN6I
 	/*
 	 * Use the MIPI pll if we've been unable to find any matching setting
@@ -302,6 +308,19 @@ void lcdc_pll_set(struct sunxi_ccm_reg *ccm, int tcon, int dotclock,
 		      best_double + 1, step, best_n, best_m);
 	}
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	if (tcon == 0) {
+		writel(CCM_TCON0_CTRL_VIDEO0_4X | CCM_TCON0_CTRL_ENABLE,
+		       &ccm->tcon_lcd0_clk_cfg);
+		setbits_le32(&ccm->tcon_lcd_gate_reset, BIT(RESET_SHIFT));
+		setbits_le32(&ccm->tcon_lcd_gate_reset, BIT(GATE_SHIFT));
+	} else {
+		writel(CCM_TCON1_CTRL_VIDEO0_4X | CCM_TCON1_CTRL_ENABLE,
+		       &ccm->tcon_tv0_clk_cfg);
+		setbits_le32(&ccm->tcon_tv_gate_reset, BIT(RESET_SHIFT));
+		setbits_le32(&ccm->tcon_tv_gate_reset, BIT(GATE_SHIFT));
+	}
+#else
 	if (tcon == 0) {
 		u32 pll;
 
@@ -329,6 +348,7 @@ void lcdc_pll_set(struct sunxi_ccm_reg *ccm, int tcon, int dotclock,
 			setbits_le32(&ccm->lcd0_ch1_clk_cfg,
 				     CCM_LCD_CH1_CTRL_HALF_SCLK1);
 	}
+#endif
 #endif
 
 	*clk_div = best_m;
diff --git a/drivers/video/sunxi/sunxi_lcd.c b/drivers/video/sunxi/sunxi_lcd.c
index 7a01cc343c..3b0e63233f 100644
--- a/drivers/video/sunxi/sunxi_lcd.c
+++ b/drivers/video/sunxi/sunxi_lcd.c
@@ -26,7 +26,7 @@ struct sunxi_lcd_priv {
 
 static void sunxi_lcdc_config_pinmux(void)
 {
-#ifdef CONFIG_MACH_SUN50I
+#if IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SUN8I_R528)
 	int pin;
 
 	for (pin = SUNXI_GPD(0); pin <= SUNXI_GPD(21); pin++) {
@@ -47,10 +47,12 @@ static int sunxi_lcd_enable(struct udevice *dev, int bpp,
 	struct udevice *backlight;
 	int clk_div, clk_double, ret;
 
+#if !IS_ENABLED(CONFIG_SUN50I_GEN_H6) && !IS_ENABLED(CONFIG_MACH_SUN8I_R528)
 	/* Reset off */
 	setbits_le32(&ccm->ahb_reset1_cfg, 1 << AHB_RESET_OFFSET_LCD0);
 	/* Clock on */
 	setbits_le32(&ccm->ahb_gate1, 1 << AHB_GATE_OFFSET_LCD0);
+#endif
 
 	lcdc_init(lcdc);
 	sunxi_lcdc_config_pinmux();
@@ -146,7 +148,7 @@ U_BOOT_DRIVER(sunxi_lcd) = {
 	.priv_auto	= sizeof(struct sunxi_lcd_priv),
 };
 
-#ifdef CONFIG_MACH_SUN50I
+#if IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SUN8I_R528)
 U_BOOT_DRVINFO(sunxi_lcd) = {
 	.name = "sunxi_lcd"
 };

-- 
2.44.0

