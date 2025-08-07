Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D62C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC5B844BA;
	Thu,  7 Aug 2025 10:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="klIx3FGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1952F83AD5; Thu,  7 Aug 2025 09:47:04 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 488AB83A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b421b70f986so485620a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552819; x=1755157619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajtd7WqimPtDvaZbAataPgktd3PD2be/BYiChq4hi3M=;
 b=klIx3FGKbbxOac95ZL6K1pnt+n+ZY6btoi0fvH0MIPTr1H5i7UA+SD++IMnNfMaoDy
 G8RzKM17sI0bZ7tENgscMM+JTZB/dhuF/xtL7uNZw64gPNnU/2xvVHtgCMdwvQUuQaRt
 pBTt9yEXSjTERlWcLXf8eQunGsekz/MASz0PhZoibEOQc+uQ4tousxcg1+ucmUIHQ5q8
 uhnKwRqc2M0GWdIkY1JQW6Gyk1qLg90tODx+wW7nb4RbGUVQ7SVhB0b4j3Ud4YuwZ+Kj
 xgl4Q0Ll8Dvu5fVYnHHZecgFSrs5CPi8lGzPBBIsBT/OYVdqDG5bIO8qp9pbgmcl8mxD
 MNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552819; x=1755157619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ajtd7WqimPtDvaZbAataPgktd3PD2be/BYiChq4hi3M=;
 b=LA38eWnL8Q5RkRHCgWPXgyR7/NiaUgoSG/rlGB9KXzfylKvPXwyOMXUp49NusFee0u
 7W9LmUQkczTnyLoGnroaHkY7PfYVk0FJ/b2Kr8/NIcXYiN57ZeWcHiPFlziKZsdXHE1G
 YglIDKos3nDtSbZWoqHNTWCwmkLtv9/p1GzApd5R2dZNW+iU7joXacMyGkBVO/Crst+5
 YknhoqsGPghvYOLubO+FjLEgtBmzWyFZwaSE6xBnW7KI5iJvy6Hx09AXlRqEWbbzhq6W
 JjOb0AztOhdC/yxr+R7jtmI4xO1KxRVpvRD2vJ7UFk/J63UmCiCcfm0f4ixZYOyIFtmE
 ndsw==
X-Gm-Message-State: AOJu0YzMlDrCeeCgGoNcsNVi9kunXuFZ0U/WaCdiW14FzadRlcwpSEwP
 HKCdPv8YtE+4qzqUCJdM5uLtKXepVQVY/eZT4ddY5b9rjowIAAfbx5bVheESTrBo
X-Gm-Gg: ASbGncuadXiZBG75wfmtHLh+rW+fAhEMkoWXISVBta6lsxeJNdoqt2AVnkSbVDAobAx
 xnFfojLHuWgijIGp74lO/bUUCIwUxHzP8H3YEu0F2kxYRGjKmiumOeoOTODoNil2U5sEb/YWf/O
 fhWiJ2nQjNQQPS/hJ2sDfUdHpTkcal/WUtgWzRmvpKcx5csyWyXBCQKF3XLwXLZCv1yA6Htu12D
 EHCdIGnJ82u5bnPmcuBGQ+hlmEh0bZeHjvQsu3RgJ3h8aGpj252m6eYMwI4deLkkwlOPaJ64Gcg
 FCKIODfUJ0yJckmYXTCEfQEts0Oqzka7aAp2tXAqoWTE7xBNSX5NHRQTpj2V0woNh4rDQQcsJ2t
 yj/ay/riieM9AC/RC9Yg312wgjT0lz1D9JKkr
X-Google-Smtp-Source: AGHT+IEs5+eOEX3w+FVSazqVwC/W5sHPFM8T4d6IQ6Pdjrw6N5F8RheNuh2Z/TAgJUFg4INkpG7caA==
X-Received: by 2002:a17:902:f545:b0:23f:df33:21cb with SMTP id
 d9443c01a7336-242b1ad737fmr31403335ad.44.1754552819317; 
 Thu, 07 Aug 2025 00:46:59 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:46:58 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 08/10] video: rockchip: add rk3368 vop support
Date: Thu,  7 Aug 2025 15:44:16 +0800
Message-Id: <20250807074419.336752-9-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/video/rockchip/Makefile               |  1 +
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 20 +++++
 drivers/video/rockchip/rk3368_vop.c           | 81 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/video/rockchip/rk3368_vop.c

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index f55beceebf..83c0b7aef9 100644
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
index fa51217351..122974d601 100644
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
index 0000000000..46c719c75c
--- /dev/null
+++ b/drivers/video/rockchip/rk3368_vop.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2015 Google, Inc
+ * Copyright 2014 Rockchip Inc.
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

