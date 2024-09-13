Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBC2FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF61886AF;
	Fri, 13 Sep 2024 11:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c4Mfk04v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4919E88B49; Fri, 13 Sep 2024 11:57:23 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33D088D28
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so228366666b.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221434; x=1726826234;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mvzLq45UAwkCCqqyJ82Yf/IOCaPYS9JtH6sYR6xojk=;
 b=c4Mfk04v7dLNG2miOJtKxCvdUXIzygHo7qcaGVIfOqVsMsMTZHnT6Q4tnXkZbDANE8
 JYHu304R7CqUCc0fQyeeCsNwqNRa8sWjLU/Ycf+AyM7Wp1+eS990ZUEPUsxa6j6bTNHb
 KqcGMIrNbKIrxlzH4j+clZImhrpdCodL6wxqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221434; x=1726826234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mvzLq45UAwkCCqqyJ82Yf/IOCaPYS9JtH6sYR6xojk=;
 b=i5ug2DIngeHYYnDoWkg+vBg4WDlPWHGKH69MmEXpTF+g7TgDGOUzj5+FGv+34NW/bG
 kUao2f9z+cggCWgwcSUCSbbJVYEsSSAiRn90wFw7qcGoPz8q/PoYNUL3feLFbTq4l5HO
 EiWShK+iXjW3deps+sn8OIq1kcHK3fOFtLMrMQyVWyu51DyhVJam4o2+ulB/244raAis
 ctfz4QMKm1a7TqX0RWyR45lizqXwveXjFAe0eCEtkfi7iOs6HWHts3lvwaqdj2+PWGC6
 OcjsFF4rfTipR+eLdWsEllAvuI97BIHjZsYzX/COmxLVTiaRQUWhKI/yZ0pZUgkTBONW
 PA0g==
X-Gm-Message-State: AOJu0YwG5AunAuNa+dOudIwzX62rez5e022Dne2nQiWD33Hpddzvyh49
 wswORT3NpXe8H2uvtf+mR4PwTEDibjBTx1CKRDjbK1m184pXLj4XeMROTIOuPAD7rNPgIhrLxiV
 cRfI=
X-Google-Smtp-Source: AGHT+IHbfBiPHX7zwMPabQcKqnqUHDOdwLuO27hRX0JAHNLb+Ef5q6FIU88AjES85BPnFh4aAT2meQ==
X-Received: by 2002:a17:906:c104:b0:a7a:c083:857b with SMTP id
 a640c23a62f3a-a902961a6c6mr580328166b.42.1726221433667; 
 Fri, 13 Sep 2024 02:57:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:13 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/26] video: Update mxsfb video drivers for iMX8MM/iMX8MN
 display
Date: Fri, 13 Sep 2024 11:55:54 +0200
Message-ID: <20240913095622.72377-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Update mxsfb for LCD video driver

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/mxsfb.c | 139 ++++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 46 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 792d6314d15e..45431f0a1047 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -21,8 +21,13 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/dma.h>
 #include <asm/io.h>
+#include <reset.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <video_link.h>
 
 #include "videomodes.h"
+#include <dm/device-internal.h>
 
 #define	PS2KHZ(ps)	(1000000000UL / (ps))
 #define HZ2PS(hz)	(1000000000UL / ((hz) / 1000))
@@ -30,6 +35,11 @@
 #define BITS_PP		18
 #define BYTES_PP	4
 
+struct mxsfb_priv {
+	fdt_addr_t reg_base;
+	struct udevice *disp_dev;
+};
+
 struct mxs_dma_desc desc;
 
 /**
@@ -56,9 +66,10 @@ __weak void mxsfb_system_setup(void)
  */
 
 static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
-			 struct display_timing *timings, int bpp)
+			 struct display_timing *timings, int bpp, bool bridge)
 {
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)priv->reg_base;
 	const enum display_flags flags = timings->flags;
 	uint32_t word_len = 0, bus_width = 0;
 	uint8_t valid_data = 0;
@@ -109,7 +120,7 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 	}
 #else
 	/* Kick in the LCDIF clock */
-	mxs_set_lcdclk(MXS_LCDIF_BASE, timings->pixelclock.typ / 1000);
+	mxs_set_lcdclk(priv->reg_base, timings->pixelclock.typ / 1000);
 #endif
 
 	/* Restart the LCDIF block */
@@ -142,26 +153,30 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 		LCDIF_CTRL_BYPASS_COUNT | LCDIF_CTRL_LCDIF_MASTER,
 		&regs->hw_lcdif_ctrl);
 
-	writel(valid_data << LCDIF_CTRL1_BYTE_PACKING_FORMAT_OFFSET,
+	writel((valid_data << LCDIF_CTRL1_BYTE_PACKING_FORMAT_OFFSET) |
+		LCDIF_CTRL1_RECOVER_ON_UNDERFLOW,
 		&regs->hw_lcdif_ctrl1);
 
+	if (bridge)
+		writel(LCDIF_CTRL2_OUTSTANDING_REQS_REQ_16, &regs->hw_lcdif_ctrl2);
+
 	mxsfb_system_setup();
 
 	writel((timings->vactive.typ << LCDIF_TRANSFER_COUNT_V_COUNT_OFFSET) |
 		timings->hactive.typ, &regs->hw_lcdif_transfer_count);
 
-	vdctrl0 = LCDIF_VDCTRL0_ENABLE_PRESENT | LCDIF_VDCTRL0_ENABLE_POL |
+	vdctrl0 = LCDIF_VDCTRL0_ENABLE_PRESENT |
 		  LCDIF_VDCTRL0_VSYNC_PERIOD_UNIT |
 		  LCDIF_VDCTRL0_VSYNC_PULSE_WIDTH_UNIT |
 		  timings->vsync_len.typ;
 
-	if(flags & DISPLAY_FLAGS_HSYNC_HIGH)
+	if (flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_HSYNC_POL;
-	if(flags & DISPLAY_FLAGS_VSYNC_HIGH)
+	if (flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_VSYNC_POL;
-	if(flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+	if (flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
 		vdctrl0 |= LCDIF_VDCTRL0_DOTCLK_POL;
-	if(flags & DISPLAY_FLAGS_DE_HIGH)
+	if (flags & DISPLAY_FLAGS_DE_HIGH)
 		vdctrl0 |= LCDIF_VDCTRL0_ENABLE_POL;
 
 	writel(vdctrl0, &regs->hw_lcdif_vdctrl0);
@@ -198,10 +213,10 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
 }
 
 static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
-			    int bpp, u32 fb)
+			    int bpp, u32 fb, bool bridge)
 {
 	/* Start framebuffer */
-	mxs_lcd_init(dev, fb, timings, bpp);
+	mxs_lcd_init(dev, fb, timings, bpp, bridge);
 
 #ifdef CONFIG_VIDEO_MXS_MODE_SYSTEM
 	/*
@@ -212,7 +227,8 @@ static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
 	 * sets the RUN bit, then waits until it gets cleared and repeats this
 	 * infinitelly. This way, we get smooth continuous updates of the LCD.
 	 */
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)priv->reg_base;
 
 	memset(&desc, 0, sizeof(struct mxs_dma_desc));
 	desc.address = (dma_addr_t)&desc;
@@ -229,9 +245,9 @@ static int mxs_probe_common(struct udevice *dev, struct display_timing *timings,
 	return 0;
 }
 
-static int mxs_remove_common(u32 fb)
+static int mxs_remove_common(phys_addr_t reg_base, u32 fb)
 {
-	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)MXS_LCDIF_BASE;
+	struct mxs_lcdif_regs *regs = (struct mxs_lcdif_regs *)(reg_base);
 	int timeout = 1000000;
 
 	if (!fb)
@@ -258,6 +274,7 @@ static int mxs_of_get_timings(struct udevice *dev,
 	int ret = 0;
 	u32 display_phandle;
 	ofnode display_node;
+	struct mxsfb_priv *priv = dev_get_priv(dev);
 
 	ret = ofnode_read_u32(dev_ofnode(dev), "display", &display_phandle);
 	if (ret) {
@@ -278,10 +295,19 @@ static int mxs_of_get_timings(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	ret = ofnode_decode_display_timing(display_node, 0, timings);
-	if (ret) {
-		dev_err(dev, "failed to get any display timings\n");
-		return -EINVAL;
+	priv->disp_dev = video_link_get_next_device(dev);
+	if (priv->disp_dev) {
+		ret = video_link_get_display_timings(timings);
+		if (ret) {
+			dev_err(dev, "failed to get any video link display timings\n");
+			return -EINVAL;
+		}
+	} else {
+		ret = ofnode_decode_display_timing(display_node, 0, timings);
+		if (ret) {
+			dev_err(dev, "failed to get any display timings\n");
+			return -EINVAL;
+		}
 	}
 
 	return ret;
@@ -291,20 +317,58 @@ static int mxs_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct mxsfb_priv *priv = dev_get_priv(dev);
 
 	struct display_timing timings;
 	u32 bpp = 0;
 	u32 fb_start, fb_end;
 	int ret;
+	bool enable_bridge = false;
 
 	debug("%s() plat: base 0x%lx, size 0x%x\n",
 	       __func__, plat->base, plat->size);
 
+	priv->reg_base = dev_read_addr(dev);
+	if (priv->reg_base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "lcdif base address is not found\n");
+		return -EINVAL;
+	}
+
 	ret = mxs_of_get_timings(dev, &timings, &bpp);
 	if (ret)
 		return ret;
 
-	ret = mxs_probe_common(dev, &timings, bpp, plat->base);
+	if (priv->disp_dev) {
+		if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
+			if (device_get_uclass_id(priv->disp_dev) == UCLASS_VIDEO_BRIDGE) {
+				ret = video_bridge_attach(priv->disp_dev);
+				if (ret) {
+					dev_err(dev, "fail to attach bridge\n");
+					return ret;
+				}
+
+				ret = video_bridge_set_backlight(priv->disp_dev, 80);
+				if (ret) {
+					dev_err(dev, "fail to set backlight\n");
+					return ret;
+				}
+
+				enable_bridge = true;
+				video_bridge_check_timing(priv->disp_dev, &timings);
+			}
+		}
+
+		if (device_get_uclass_id(priv->disp_dev) == UCLASS_PANEL) {
+			ret = panel_enable_backlight(priv->disp_dev);
+			if (ret) {
+				dev_err(dev, "panel %s enable backlight error %d\n",
+					priv->disp_dev->name, ret);
+				return ret;
+			}
+		}
+	}
+
+	ret = mxs_probe_common(dev, &timings, bpp, plat->base, enable_bridge);
 	if (ret)
 		return ret;
 
@@ -343,33 +407,9 @@ static int mxs_video_probe(struct udevice *dev)
 static int mxs_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
-	struct display_timing timings;
-	u32 bpp = 0;
-	u32 bytes_pp = 0;
-	int ret;
 
-	ret = mxs_of_get_timings(dev, &timings, &bpp);
-	if (ret)
-		return ret;
-
-	switch (bpp) {
-	case 32:
-	case 24:
-	case 18:
-		bytes_pp = 4;
-		break;
-	case 16:
-		bytes_pp = 2;
-		break;
-	case 8:
-		bytes_pp = 1;
-		break;
-	default:
-		dev_err(dev, "invalid bpp specified (bpp = %i)\n", bpp);
-		return -EINVAL;
-	}
-
-	plat->size = timings.hactive.typ * timings.vactive.typ * bytes_pp;
+	/* Max size supported by LCDIF, because in bind, we can't probe panel */
+	plat->size = 1920 * 1080 * 4 * 2;
 
 	return 0;
 }
@@ -377,8 +417,12 @@ static int mxs_video_bind(struct udevice *dev)
 static int mxs_video_remove(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct mxsfb_priv *priv = dev_get_priv(dev);
+
+	if (priv->disp_dev)
+		device_remove(priv->disp_dev, DM_REMOVE_NORMAL);
 
-	mxs_remove_common(plat->base);
+	mxs_remove_common(priv->reg_base, plat->base);
 
 	return 0;
 }
@@ -389,6 +433,8 @@ static const struct udevice_id mxs_video_ids[] = {
 	{ .compatible = "fsl,imx6sx-lcdif" },
 	{ .compatible = "fsl,imx7ulp-lcdif" },
 	{ .compatible = "fsl,imxrt-lcdif" },
+	{ .compatible = "fsl,imx8mm-lcdif" },
+	{ .compatible = "fsl,imx8mn-lcdif" },
 	{ /* sentinel */ }
 };
 
@@ -400,4 +446,5 @@ U_BOOT_DRIVER(mxs_video) = {
 	.probe	= mxs_video_probe,
 	.remove = mxs_video_remove,
 	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
+	.priv_auto   = sizeof(struct mxsfb_priv),
 };
-- 
2.43.0

