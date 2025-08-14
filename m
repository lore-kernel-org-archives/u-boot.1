Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDECCA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A9583952;
	Thu, 14 Aug 2025 15:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1L/75am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6826D83938; Thu, 14 Aug 2025 15:13:50 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE31F8396C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b471738daabso727512a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177226; x=1755782026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Mn8JdjZmvbRD1YCpUQEmcwjs2CHDgPXzNAAZQj6svQ=;
 b=B1L/75amw3wOeAHn7eh4da87lmcJ2dGakXPruESypKGKQf+dkACSbQKUTgebiGOZ8p
 UmogXIJiIVlaWCFwg7HKsnaNHhp4rcwQ5MxZlM/+c/pi1jwdSrTdQ9RW9Mbt0WcUxMMd
 8jNViIXsg6sc0BS7djqJkl5XfGHLOSf2ssHbBCSkgna6ROEPlb11Kn7jTtY9CZUcD7kR
 70FHX8DA33SNJny0PBj6I0oLJDcerpeGLBDa+a11s7HP88Hl0bj+jD6hUgPZRsoGfcIZ
 9p2jhAigTZXf5Ag5SUFunYMX3xoWbp3t7H7NDkDYvxSdraNtkXWesP396hwgEdN0g6eg
 Mxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177226; x=1755782026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Mn8JdjZmvbRD1YCpUQEmcwjs2CHDgPXzNAAZQj6svQ=;
 b=n+pfNC6CREjMqz54BFKE4HGfbvJr8QYPkVzp1klB3fCXWcf7w1PTPPdCUl0Ovb6EC6
 A1J9ox/WXkEo0K32WyzVeM1I++7n1/pwuKEBFnBrP37u7W4Wim14W3NutMkgwHSvNKdu
 fhsBWHhX/QtN0/7tJuqyDIYS9V1bn6SZjIr1NUaxdchCMov6xGXwbrQdEiNaF9RO70xh
 zrqU5wzYfaYOlJBnyfDNwyzZnhIRdHyTkMYlyHz8H1TihDtgag/1EOWK3CePTPfcbHfs
 6s1mYUTVGUCS2/2860reMvowYllTZhSmP7KyI9P3U/qeni/N2HDFlF6u4KuMeq6pcXAS
 UjQw==
X-Gm-Message-State: AOJu0YwVO2P0w0DEFCsIO+cs0sjAf4OGooUX48nxOVXzDWttlND1pmb7
 cpXL/praDzwOcrqHQgWmn6ufveH1OuB+8TnpHfVb1XzcF/t/E7Mvrf6NT38dwn+y1qJ2iWUd
X-Gm-Gg: ASbGncuvdQ+17Bs3bY6vP5WIbn/v1qbe64M+rU4G8JLkPJYsQ8RgGP3HVhB2dHTG4+V
 wO1NmSzgs9WZmiA9Wp5GXaRUhckl083+neH8X05YjX+TPhUIiMWuESOIIVVx/s5yySCNCdONpnR
 /+NYUficzsyGvA2ll+EdVyKdHxuPOCHmWCiX7KjTPfhS/GoQk/ZMGCZ2N6RXQXoS+4VN8ZYOMvp
 XkSBwTKvasCnWYrjPPRtkqA+Yu8a7AjAAjmakguFfuZzUt+qQQ7p3BpO4hY89CiNlL1X0c84q9Q
 e6eppOv/DiCa2NQLb3bCXG7wrYPLT/w8l0BNFY6Sw1qz/8IMrPBgtTr+1YPnIk7bvMsnb6tPHjv
 MgKt0eemdAJ7M/kvXqXQuxBbmydw86sKlpFmv5g==
X-Google-Smtp-Source: AGHT+IG0RrOjklBPhz7icFDnPxXtK0C8Bzgas44GKKN+Rk29Zpel3ybJLvU/tBGfnolovOxdYw1oUg==
X-Received: by 2002:a17:903:2947:b0:240:3bb7:fdc3 with SMTP id
 d9443c01a7336-244586c46damr32241165ad.28.1755177225817; 
 Thu, 14 Aug 2025 06:13:45 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:13:45 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 5/5] video: rockchip: add RK3368 VOP support
Date: Thu, 14 Aug 2025 21:12:37 +0800
Message-Id: <20250814131237.8135-6-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131237.8135-1-cn.liweihao@gmail.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
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

This patch adds RK3368 VOP driver based on RK3288. I got its GRF register
user manual from a online forum.

Link: https://github.com/ieiao/wiki/blob/master/docs/embedded-dev/rockchip/rk3368/Rockchip_RK3368_GRF.pdf

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/video/rockchip/Makefile               |  1 +
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 20 +++++
 drivers/video/rockchip/rk3368_vop.c           | 79 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/video/rockchip/rk3368_vop.c

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index f55beceeb..83c0b7aef 100644
--- a/drivers/video/rockchip/Makefile
+++ b/drivers/video/rockchip/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_VIDEO_ROCKCHIP
 obj-y += rk_vop.o
 obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288_vop.o
 obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328_vop.o
+obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368_vop.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399_vop.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) += rk_edp.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index fa5121735..122974d60 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -134,6 +134,11 @@
 #define DW_MIPI_NEEDS_PHY_CFG_CLK	BIT(0)
 #define DW_MIPI_NEEDS_GRF_CLK		BIT(1)
 
+#define RK3368_GRF_SOC_CON7		0x41c
+#define RK3368_DSI_FORCETXSTOPMODE	(0xf << 7)
+#define RK3368_DSI_FORCERXMODE		(0x1 << 6)
+#define RK3368_DSI_TURNDISABLE		(0x1 << 5)
+
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_LCDC_SEL		BIT(0)
 #define RK3399_DSI1_LCDC_SEL		BIT(4)
@@ -911,6 +916,18 @@ struct video_bridge_ops dw_mipi_dsi_rockchip_ops = {
 	.set_backlight = dw_mipi_dsi_rockchip_set_bl,
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
+	{
+		.reg = 0xff960000,
+		.lanecfg1_grf_reg = RK3368_GRF_SOC_CON7,
+		.lanecfg1 = HIWORD_UPDATE(0, RK3368_DSI_TURNDISABLE |
+					     RK3368_DSI_FORCETXSTOPMODE |
+					     RK3368_DSI_FORCERXMODE),
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{
 		.reg = 0xff960000,
@@ -980,6 +997,9 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 };
 
 static const struct udevice_id dw_mipi_dsi_rockchip_dt_ids[] = {
+	{ .compatible = "rockchip,rk3368-mipi-dsi",
+	  .data = (long)&rk3368_chip_data,
+	},
 	{ .compatible = "rockchip,rk3399-mipi-dsi",
 	  .data = (long)&rk3399_chip_data,
 	},
diff --git a/drivers/video/rockchip/rk3368_vop.c b/drivers/video/rockchip/rk3368_vop.c
new file mode 100644
index 000000000..b4aac51c5
--- /dev/null
+++ b/drivers/video/rockchip/rk3368_vop.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author(s): WeiHao Li <cn.liweihao@gmail.com>
+ */
+
+#include <display.h>
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <video.h>
+#include <asm/global_data.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <linux/delay.h>
+#include "rk_vop.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void rk3368_set_pin_polarity(struct udevice *dev,
+				    enum vop_modes mode, u32 polarity)
+{
+	struct rk_vop_priv *priv = dev_get_priv(dev);
+	struct rk3288_vop *regs = priv->regs;
+
+	/* The RK3368 VOP (v3.2) has its polarity configuration in ctrl0 */
+	clrsetbits_le32(&regs->dsp_ctrl0,
+			M_DSP_DCLK_POL | M_DSP_DEN_POL |
+			M_DSP_VSYNC_POL | M_DSP_HSYNC_POL,
+			V_DSP_PIN_POL(polarity));
+}
+
+/*
+ * Try some common regulators. We should really get these from the
+ * device tree somehow.
+ */
+static const char * const rk3368_regulator_names[] = {
+	"vcc18_lcd",
+	"VCC18_LCD",
+	"vdd10_lcd_pwren_h",
+	"vdd10_lcd",
+	"VDD10_LCD",
+	"vcc33_lcd"
+};
+
+static int rk3368_vop_probe(struct udevice *dev)
+{
+	/* Before relocation we don't need to do anything */
+	if (!(gd->flags & GD_FLG_RELOC))
+		return 0;
+
+	/* Probe regulators required for the RK3368 VOP */
+	rk_vop_probe_regulators(dev, rk3368_regulator_names,
+				ARRAY_SIZE(rk3368_regulator_names));
+
+	return rk_vop_probe(dev);
+}
+
+struct rkvop_driverdata rk3368_driverdata = {
+	.set_pin_polarity = rk3368_set_pin_polarity,
+};
+
+static const struct udevice_id rk3368_vop_ids[] = {
+	{ .compatible = "rockchip,rk3368-vop",
+	  .data = (ulong)&rk3368_driverdata },
+	{ }
+};
+
+static const struct video_ops rk3368_vop_ops = {
+};
+
+U_BOOT_DRIVER(rockchip_rk3368_vop) = {
+	.name		= "rockchip_rk3368_vop",
+	.id		= UCLASS_VIDEO,
+	.of_match 	= rk3368_vop_ids,
+	.ops		= &rk3368_vop_ops,
+	.bind		= rk_vop_bind,
+	.probe		= rk3368_vop_probe,
+	.priv_auto	= sizeof(struct rk_vop_priv),
+};
-- 
2.39.5

