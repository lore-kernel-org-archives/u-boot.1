Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F66C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD49D88231;
	Fri, 14 Jun 2024 14:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="yudOx7v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CED988210; Fri, 14 Jun 2024 14:24:18 +0200 (CEST)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B140882CE
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: u-boot@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2JgImzBHgiCRnrYjrerrDGyRQPIJrOTXHhgwChb0mn0=;
 b=yudOx7v2ErTPVXkLWRCiSWvVTflnb7Ddkr0U36swDVtcJUXmCq48UtCGF9/ZXVnm/DIy27
 RrdH8epeT+YjxXZjffJO3t8zVh6uNXn9ntHA5PwCSrBgI4bjWoNd7Eb+fbxAQIfDcpEaS9
 lTKACO695R0saqPjd9Kw6YJ1wNE23kVEvPL7DsuHbdl5wFjYQDj6nlWe/vUCUMHPuSFVTv
 KKLXq+HWlpo14YvdHD0I04zPocAxGDRL34QOGWSGVSwfPzT2aHxtShWpDu4AP3aXGpMGV9
 2ZjykEqpAoiVrLuVAn89JLNTvtensQkcZ5JRLpWrBy3P9JcOmfJPMkEjIJqwGg==
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: agust@denx.de
X-Envelope-To: contact@jookia.org
X-Envelope-To: trini@konsulko.com
X-Envelope-To: jagan@amarulasolutions.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:24:06 +1000
Subject: [PATCH] sunxi: video: Support driver model LCDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-sunxi_lcd-v1-1-1dc9257b0112@jookia.org>
X-B4-Tracking: v=1; b=H4sIAGU2bGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwND3eLSvIrM+JzkFN0UY8tEk7QkC8NkSxMloPqCotS0zAqwWdGxtbU
 Ax39R1VsAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Anatolij Gustschin <agust@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367846; l=2015;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=zDA4Zw14iKfR17t2qTEK0M1EPCXyZX3Cda5LyxZBsbc=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAf2enKnIIjR4OIHHEmq9F/eE
 bauGuOs1yh2Goysq33NtRyjfCOh3WR4A/KYaTranKJMR/3X+/ExpnmGilSTLUCAUAAP+/
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
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

Currently the LCD code only supports reading panel timings from the
device tree. Change that so it can use a real panel.

Signed-off-by: John Watts <contact@jookia.org>
---
I've been working on a panel driver port from Linux for the T113 and
found I need this code to have the panel boot correctly.
---
 drivers/video/sunxi/sunxi_lcd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/sunxi/sunxi_lcd.c b/drivers/video/sunxi/sunxi_lcd.c
index 7a01cc343c..605ea90de1 100644
--- a/drivers/video/sunxi/sunxi_lcd.c
+++ b/drivers/video/sunxi/sunxi_lcd.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <display.h>
 #include <log.h>
+#include <panel.h>
 #include <video_bridge.h>
 #include <backlight.h>
 #include <dm.h>
@@ -45,6 +46,7 @@ static int sunxi_lcd_enable(struct udevice *dev, int bpp,
 	       (struct sunxi_lcdc_reg *)SUNXI_LCD0_BASE;
 	struct sunxi_lcd_priv *priv = dev_get_priv(dev);
 	struct udevice *backlight;
+	struct udevice *panel;
 	int clk_div, clk_double, ret;
 
 	/* Reset off */
@@ -60,6 +62,12 @@ static int sunxi_lcd_enable(struct udevice *dev, int bpp,
 			    priv->panel_bpp, CONFIG_VIDEO_LCD_DCLK_PHASE);
 	lcdc_enable(lcdc, priv->panel_bpp);
 
+	ret = uclass_get_device(UCLASS_PANEL, 0, &panel);
+	if (ret == 0) {
+		if (panel_enable_backlight(panel) == 0)
+			return 0;
+	}
+
 	ret = uclass_get_device(UCLASS_PANEL_BACKLIGHT, 0, &backlight);
 	if (!ret)
 		backlight_enable(backlight);
@@ -116,6 +124,11 @@ static int sunxi_lcd_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (panel_get_display_timing(cdev, &priv->timing) == 0) {
+		priv->panel_bpp = 32;
+		return 0;
+	}
+
 	if (fdtdec_decode_display_timing(gd->fdt_blob, dev_of_offset(cdev),
 					 0, &priv->timing)) {
 		debug("%s: Failed to decode display timing\n", __func__);

---
base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
change-id: 20240601-sunxi_lcd-d39a4fb81c94

Best regards,
-- 
John Watts <contact@jookia.org>

