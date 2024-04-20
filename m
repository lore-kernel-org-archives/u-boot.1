Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF4C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9287886DA;
	Sat, 20 Apr 2024 02:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="SC0gDJRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB472886DD; Sat, 20 Apr 2024 02:04:56 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8BA886DA
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+FmKSBWq8tm+kONHBAyDjBZbhhY0vTJhdoI5+0m5oFg=;
 b=SC0gDJRRDJjeJzaf4U1g4l5SsT083Y9CYgO0a4I9WfpZnrUi2eodo4Zynr44Ijr7absIsc
 DQ8jZ4RHMJTvt3LFvSmOVF+drQY0DUT0dmlvc0GU7+izWBbm+LPvZYhM7Mz01J2xCo4rAX
 hCGyXo5UH9l8mbUEPHncUFdmybgR+D4np54GYUdWRNr8pN3pcuJW6gPGGjdVHkMBCWgqTS
 Ql3tp8IFtO0TqkJ54ppb92hVv1J/59puhVsrapxUI4I/kRaGSeE9Ccxn5A+aJNYespRWjR
 6swh/wpbZxWZq0VAdLf3uPtHOi0wJawxaMXN8LvNiP0cFs6YbWYJf/RO0vbk/w==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:42 +1000
Subject: [PATCH RFC 9/9] sunxi: video: support HDMI on H6/H616
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-9-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571402; l=7020;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=Cwtk2TMU3X+CFVhjXS9eEdl7tgJM+MqrXWLmZY7TSWg=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAu75TbZwfk4aKeIn/8OBYhCT
 2ZONZ/hFYyfNf5re3QBNnVKVfcoUhZNsvxP46rWX+CwOpEPqD19yiS9w/9kv1CAUAAOpo
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

The H6 and H616 support outputting HDMI through the Display Engine.
Set up the clocks and resets appropriately for the HDMI controller.

This turns out to be a little tricky as the HDMI clock requires a
different parent on the H6 compared to the H616. So we have to end
up choosing VIDEO1 on the H616 and VIDEO0 elsewhere.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  9 +++
 arch/arm/mach-sunxi/clock_sun50i_h6.c             | 10 ++++
 drivers/video/sunxi/sunxi_dw_hdmi.c               | 70 ++++++++++++++++++++---
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index dfe8d9315f..35bd3dd2d8 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -376,13 +376,21 @@ struct sunxi_ccm_reg {
 /* TCON0 clock bit field */
 #define CCM_TCON0_CTRL_ENABLE		(0x1 << 31)
 #define CCM_TCON0_CTRL_VIDEO0_4X	(0x1 << 24)
+#define CCM_TCON0_CTRL_VIDEO1_4X	(0x3 << 24)
 #define CCM_TCON0_CTRL_M(m)		((((m) - 1) & 0xf) << 0)
 
 /* TCON1 clock bit field */
 #define CCM_TCON1_CTRL_ENABLE		(0x1 << 31)
 #define CCM_TCON1_CTRL_VIDEO0_4X	(0x1 << 24)
+#define CCM_TCON1_CTRL_VIDEO1_4X	(0x3 << 24)
 #define CCM_TCON1_CTRL_M(m)		((((m) - 1) & 0xf) << 0)
 
+/* HDMI clock bit field */
+#define CCM_HDMI_CTRL_ENABLE		(0x1 << 31)
+#define CCM_HDMI_CTRL_VIDEO1_4X_H6	(0x2 << 24)
+#define CCM_HDMI_CTRL_VIDEO0_4X_H616	(0x1 << 24)
+#define CCM_HDMI_CTRL_M(m)		((((m) - 1) & 0xf) << 0)
+
 /* CCM bits common to all Display Engine 2.0 clock ctrl regs */
 #define CCM_DE2_CTRL_M(n)		((((n) - 1) & 0xf) << 0)
 #define CCM_DE2_CTRL_PLL_MASK		(3 << 24)
@@ -399,6 +407,7 @@ void clock_set_pll3(unsigned int hz);
 void clock_set_video1(unsigned int hz);
 void clock_set_pll10(unsigned int hz);
 unsigned int clock_get_pll3(void);
+unsigned int clock_get_video1(void);
 #endif
 #endif
 
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 11e303f801..23b7c13e28 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -230,4 +230,14 @@ unsigned int clock_get_pll3(void)
 	return 12000 * n * 1000;
 }
 
+unsigned int clock_get_video1(void)
+{
+	struct sunxi_ccm_reg *const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	u32 rval = readl(&ccm->pll_video1_cfg);
+	int n = ((rval & CCM_VIDEO1_CTRL_N_MASK) >> CCM_VIDEO1_CTRL_N_SHIFT) + 1;
+
+	return 12000 * n * 1000;
+}
+
 #endif
diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
index 34a6b8bab7..475d61a888 100644
--- a/drivers/video/sunxi/sunxi_dw_hdmi.c
+++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
@@ -198,6 +198,12 @@ static void sunxi_dw_hdmi_pll_set(uint clk_khz, int *phy_div)
 {
 	int value, n, m, div, diff;
 	int best_n = 0, best_m = 0, best_div = 0, best_diff = 0x0FFFFFFF;
+	int step = 24000, max_m = 16, pll_value = 0;
+
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+		step = 12000;
+		max_m = 1;
+	}
 
 	/*
 	 * Find the lowest divider resulting in a matching clock. If there
@@ -212,11 +218,11 @@ static void sunxi_dw_hdmi_pll_set(uint clk_khz, int *phy_div)
 		if (target > 912000)
 			continue;
 
-		for (m = 1; m <= 16; m++) {
-			n = (m * target) / 24000;
+		for (m = 1; m <= max_m; m++) {
+			n = (m * target) / step;
 
 			if (n >= 1 && n <= 128) {
-				value = (24000 * n) / m / div;
+				value = (step * n) / m / div;
 				diff = clk_khz - value;
 				if (diff < best_diff) {
 					best_diff = diff;
@@ -231,13 +237,20 @@ static void sunxi_dw_hdmi_pll_set(uint clk_khz, int *phy_div)
 	*phy_div = best_div;
 
 #if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
-	panic("setting HDMI pll not implemented");
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
+		clock_set_video1(step * best_n);
+		pll_value = clock_get_video1();
+	} else {
+		clock_set_pll3(step * best_n);
+		pll_value = clock_get_pll3();
+	}
 #else
 	clock_set_pll3_factors(best_m, best_n);
+	pll_value = clock_get_pll3();
 #endif
 
 	debug("dotclock: %dkHz = %dkHz: (24MHz * %d) / %d / %d\n",
-	      clk_khz, (clock_get_pll3() / 1000) / best_div,
+	      clk_khz, (pll_value / 1000) / best_div,
 	      best_n, best_m, best_div);
 }
 
@@ -246,12 +259,34 @@ static void sunxi_dw_hdmi_lcdc_init(int mux, const struct display_timing *edid,
 {
 	struct sunxi_ccm_reg * const ccm =
 		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
-	int div = DIV_ROUND_UP(clock_get_pll3(), edid->pixelclock.typ);
+	int div, pll_value;
 	struct sunxi_lcdc_reg *lcdc;
 
 #if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
-	panic("initializing HDMI lcdc not implemented");
+	int tcon1_src;
+
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
+		tcon1_src = CCM_TCON1_CTRL_VIDEO1_4X;
+		pll_value = clock_get_video1();
+	} else {
+		tcon1_src = CCM_TCON1_CTRL_VIDEO0_4X;
+		pll_value = clock_get_pll3();
+	}
+
+	div = DIV_ROUND_UP(pll_value, edid->pixelclock.typ);
+
+	if (mux == 0) {
+		writel(tcon1_src | CCM_TCON1_CTRL_ENABLE | CCM_TCON1_CTRL_M(div),
+		       &ccm->tcon_tv0_clk_cfg);
+		setbits_le32(&ccm->tcon_tv_gate_reset, BIT(RESET_SHIFT));
+		setbits_le32(&ccm->tcon_tv_gate_reset, BIT(GATE_SHIFT));
+	} else {
+		/* TODO: H616 supports a second TV encoder */
+		panic("using HDMI lcdc mux 1 is not implemented");
+	}
 #else
+	div = DIV_ROUND_UP(pll_value, edid->pixelclock.typ);
+
 	if (mux == 0) {
 		lcdc = (struct sunxi_lcdc_reg *)SUNXI_LCD0_BASE;
 
@@ -300,7 +335,12 @@ static int sunxi_dw_hdmi_read_edid(struct udevice *dev, u8 *buf, int buf_size)
 static bool sunxi_dw_hdmi_mode_valid(struct udevice *dev,
 				     const struct display_timing *timing)
 {
-	return timing->pixelclock.typ <= 297000000;
+	int max_clock = 297000000;
+
+	if(IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+		max_clock = 594000;
+
+	return timing->pixelclock.typ <= max_clock;
 }
 
 static int sunxi_dw_hdmi_enable(struct udevice *dev, int panel_bpp,
@@ -348,7 +388,19 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 		regulator_set_enable(priv->hvcc, true);
 
 #if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
-	panic("initializing HDMI not implemented");
+	int hdmi_src = CCM_HDMI_CTRL_VIDEO0_4X_H616;
+
+	/* Set HDMI PLL to 297 MHz */
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
+		hdmi_src = CCM_HDMI_CTRL_VIDEO1_4X_H6;
+		clock_set_video1(297000000);
+	} else {
+		clock_set_pll3(297000000);
+	}
+
+	writel(hdmi_src | CCM_HDMI_CTRL_ENABLE, &ccm->hdmi_clk_cfg);
+	setbits_le32(&ccm->hdmi_gate_reset, BIT(RESET_SHIFT));
+	setbits_le32(&ccm->hdmi_gate_reset, BIT(GATE_SHIFT));
 #else
 	/* Set pll3 to 297 MHz */
 	clock_set_pll3(297000000);

-- 
2.44.0

