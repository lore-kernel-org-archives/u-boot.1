Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8BEC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A4F886A8;
	Sat, 20 Apr 2024 02:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="ctav8YZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474EC88208; Sat, 20 Apr 2024 02:04:39 +0200 (CEST)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD69886D1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnvyU/UgHwRxIG96DAwQ4nQ19tS60e37buWb18wuHJY=;
 b=ctav8YZSssWGmzB7NxEz/Y1rkD/23BHZKDSN7Keoi+2dEvg2toJvLuMq9y6tl8SKjR7uHn
 COqLOvCyAMakyCdT+FTkotJQSwzn3xra2i0b94BHoZPIxfLf8nUQp1h2+wJrRewrjGjBSi
 RwA29qDYRvD7F1IfsQg/TWKzlUbyEfvTzK0FF4EGyvP8CnzAeGX45ITNV02dmjkO/u4qpI
 hf+BOFzz+YBmrXUzIbR6Dh3BqbLNBcVhHHAckwV6mrdHD8PvsHUkxfoQzKXd0nT656HXEz
 gm8BpQ+5ZlMpPopdxOydh08MVsctRr1AOSENPF22GEWVAuFJ9vrGVA8O2CvMCw==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:40 +1000
Subject: [PATCH RFC 7/9] sunxi: video: dummy out HDMI on H6/D1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-7-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571393; l=2493;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=457rH0d96TOrqmQY+dauVDpwDuZtEWz9ImEObwtqHfQ=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAGuY7oIiiGN9erz2t0WWHjKP
 AH8y3Cn65ilMHgv4X/I4YfCcZnddiecpieZz5Id7zvZNZ32rrFYb910YtvtP/CgUAAOpZ
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

I don't have any hardware to implement HDMI support on, but it's still
worth making the code compile for future work.

Adding HDMI support shouldn't be too difficult, though beware: The H6
and H616 both have a different set of HDMI clock parents. Future code
will most likely need to pick VIDEO0 or VIDEO1 to run the TCON and
HDMI encoder based on the chip.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/sunxi/sunxi_dw_hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
index 0324a050d0..34a6b8bab7 100644
--- a/drivers/video/sunxi/sunxi_dw_hdmi.c
+++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
@@ -230,7 +230,12 @@ static void sunxi_dw_hdmi_pll_set(uint clk_khz, int *phy_div)
 
 	*phy_div = best_div;
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	panic("setting HDMI pll not implemented");
+#else
 	clock_set_pll3_factors(best_m, best_n);
+#endif
+
 	debug("dotclock: %dkHz = %dkHz: (24MHz * %d) / %d / %d\n",
 	      clk_khz, (clock_get_pll3() / 1000) / best_div,
 	      best_n, best_m, best_div);
@@ -244,6 +249,9 @@ static void sunxi_dw_hdmi_lcdc_init(int mux, const struct display_timing *edid,
 	int div = DIV_ROUND_UP(clock_get_pll3(), edid->pixelclock.typ);
 	struct sunxi_lcdc_reg *lcdc;
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	panic("initializing HDMI lcdc not implemented");
+#else
 	if (mux == 0) {
 		lcdc = (struct sunxi_lcdc_reg *)SUNXI_LCD0_BASE;
 
@@ -265,6 +273,7 @@ static void sunxi_dw_hdmi_lcdc_init(int mux, const struct display_timing *edid,
 		writel(CCM_LCD1_CTRL_GATE | CCM_LCD1_CTRL_M(div),
 		       &ccm->lcd1_clk_cfg);
 	}
+#endif
 
 	lcdc_init(lcdc);
 	lcdc_tcon1_mode_set(lcdc, edid, false, false);
@@ -338,6 +347,9 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 	if (priv->hvcc)
 		regulator_set_enable(priv->hvcc, true);
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	panic("initializing HDMI not implemented");
+#else
 	/* Set pll3 to 297 MHz */
 	clock_set_pll3(297000000);
 
@@ -347,6 +359,7 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 
 	/* This reset is referenced from the PHY devicetree node. */
 	setbits_le32(&ccm->ahb_reset1_cfg, 1 << AHB_RESET_OFFSET_HDMI2);
+#endif
 
 	ret = reset_deassert_bulk(&priv->resets);
 	if (ret)

-- 
2.44.0

