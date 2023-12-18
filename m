Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E5FC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8F987692;
	Mon, 18 Dec 2023 20:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ek65DNc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A11874CA; Mon, 18 Dec 2023 20:12:17 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17F4875F5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28b9460a9easo725718a91.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926733; x=1703531533;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbhRGcpyEujzWlScha5887WAxN0gjKhcGj+P4auJ5M8=;
 b=ek65DNc0mcqZlqvFWX0fQMnZJzkrxZleXi0Mchny5WlqqM2FnpxNUpg82t1I/l7QJv
 nBC0oUxe+7ZSQk+7KAm8ALSF4z0tRQMI7QvHmPo7SzmnscgH9T711Uss4DLW9+EhPyia
 OxcBUGp+qUJSqMTFNiANlCta5k6aoPpkH8+/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926733; x=1703531533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbhRGcpyEujzWlScha5887WAxN0gjKhcGj+P4auJ5M8=;
 b=LF1PfKZMFUFnjuxq2BsZCTJQgY51MgbTmZzHzC3jnFeBcIqO4IyTUJ1roZECaaQ6OV
 IBE5fzo+zNnmobaPfgPnBZbkjcFsR8+Fc6q6taFkIpQM94zspARpMa/8OdD27h4nNKvx
 sCiF9PSuAzgTRw/gEiDKcwbMrT6+xyC7TF4MpTrf5BXaQ72eMUYF3PRMW1LT8CSspz5T
 8C0WBsVoNveRHfnQCCSHa1qtn8nU0i4nG0/aRernGbRSvd+OE9jxpr5Nou45gULs6fDw
 LrWpHzvEjOFe6w1JD2KzFW15iKb/+2Kdpk44AcGEuNii82QcuHem3YlNvhblGVoJsClS
 ivVw==
X-Gm-Message-State: AOJu0YyPt3qxUn0vsuy/lMYmvnoyL98WI/3aCGNLJVfutBLUhzPJOv/H
 x40/Wibbjgp0yTlV5Obon+SMxA==
X-Google-Smtp-Source: AGHT+IG4WRm6+AisZ9AVmJn/EcXLjhsbyupZPcxl70Aceqe79yB2Bq4PVJuregeRfC3Zr/SHfxaJLg==
X-Received: by 2002:a17:90a:7c07:b0:28b:4026:5d8 with SMTP id
 v7-20020a17090a7c0700b0028b402605d8mr1703932pjf.5.1702926733279; 
 Mon, 18 Dec 2023 11:12:13 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:12 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 12/17] video: rockchip: Add rk3328 hdmi support
Date: Tue, 19 Dec 2023 00:41:09 +0530
Message-Id: <20231218191114.129329-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

Add Rockchip RK3328 HDMI Out driver.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/video/rockchip/Makefile      |   1 +
 drivers/video/rockchip/rk3328_hdmi.c | 131 +++++++++++++++++++++++++++
 drivers/video/rockchip/rk_hdmi.h     |   3 +
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/video/rockchip/rk3328_hdmi.c

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index 8128289cc8..4991303c73 100644
--- a/drivers/video/rockchip/Makefile
+++ b/drivers/video/rockchip/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399_vop.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) += rk_edp.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
 obj-hdmi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_hdmi.o
+obj-hdmi-$(CONFIG_ROCKCHIP_RK3328) += rk3328_hdmi.o
 obj-hdmi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_hdmi.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_HDMI) += rk_hdmi.o $(obj-hdmi-y)
 obj-mipi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_mipi.o
diff --git a/drivers/video/rockchip/rk3328_hdmi.c b/drivers/video/rockchip/rk3328_hdmi.c
new file mode 100644
index 0000000000..23624699ba
--- /dev/null
+++ b/drivers/video/rockchip/rk3328_hdmi.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
+ */
+
+#include <clk.h>
+#include <display.h>
+#include <dm.h>
+#include <dw_hdmi.h>
+#include <asm/io.h>
+#include <asm/arch-rockchip/grf_rk3328.h>
+#include "rk_hdmi.h"
+
+#define RK3328_IO_3V_DOMAIN              (7 << (9 + 16))
+#define RK3328_IO_5V_DOMAIN              ((7 << 9) | (3 << (9 + 16)))
+#define RK3328_IO_DDC_IN_MSK             ((3 << 10) | (3 << (10 + 16)))
+#define RK3328_IO_CTRL_BY_HDMI           ((1 << 13) | (1 << (13 + 16)))
+
+static int rk3328_hdmi_enable(struct udevice *dev, int panel_bpp,
+			      const struct display_timing *edid)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+
+	return dw_hdmi_enable(&priv->hdmi, edid);
+}
+
+static int rk3328_dw_hdmi_phy_cfg(struct dw_hdmi *hdmi, uint pixclock)
+{
+	struct rk_hdmi_priv *priv = container_of(hdmi, struct rk_hdmi_priv, hdmi);
+	int ret;
+
+	ret = generic_phy_init(&priv->phy);
+	if (ret) {
+		printf("failed to init phy (ret=%d)\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_power_on(&priv->phy);
+	if (ret) {
+		printf("failed to power on phy (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rk3328_dw_hdmi_setup_hpd(struct dw_hdmi *hdmi)
+{
+	struct rk_hdmi_priv *priv = container_of(hdmi, struct rk_hdmi_priv, hdmi);
+	struct rk3328_grf_regs *grf = priv->grf;
+
+	writel(RK3328_IO_DDC_IN_MSK, &grf->soc_con[2]);
+	writel(RK3328_IO_CTRL_BY_HDMI, &grf->soc_con[3]);
+}
+
+static void rk3328_dw_hdmi_read_hpd(struct dw_hdmi *hdmi, bool hpd_status)
+{
+	struct rk_hdmi_priv *priv = container_of(hdmi, struct rk_hdmi_priv, hdmi);
+	struct rk3328_grf_regs *grf = priv->grf;
+
+	if (hpd_status)
+		writel(RK3328_IO_5V_DOMAIN, &grf->soc_con[4]);
+	else
+		writel(RK3328_IO_3V_DOMAIN, &grf->soc_con[4]);
+}
+
+static const struct dw_hdmi_phy_ops dw_hdmi_rk3328_phy_ops = {
+	.phy_set = rk3328_dw_hdmi_phy_cfg,
+	.setup_hpd = rk3328_dw_hdmi_setup_hpd,
+	.read_hpd = rk3328_dw_hdmi_read_hpd,
+};
+
+static const struct dw_hdmi_plat_data dw_hdmi_rk3328_plat_data = {
+	.phy_force_vendor = true,
+	.phy_ops = &dw_hdmi_rk3328_phy_ops,
+};
+
+static int rk3328_hdmi_of_to_plat(struct udevice *dev)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+	struct dw_hdmi *hdmi = &priv->hdmi;
+
+	hdmi->i2c_clk_high = 0x71;
+	hdmi->i2c_clk_low = 0x76;
+
+	rk_hdmi_of_to_plat(dev);
+
+	hdmi->data = &dw_hdmi_rk3328_plat_data;
+
+	return 0;
+}
+
+static int rk3328_hdmi_probe(struct udevice *dev)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = generic_phy_get_by_name(dev, "hdmi", &priv->phy);
+	if (ret) {
+		printf("failed to get hdmi phy\n");
+		return ret;
+	};
+
+	ret = rk_hdmi_probe(dev);
+	if (ret) {
+		printf("failed to probe rk hdmi\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_display_ops rk3328_hdmi_ops = {
+	.read_edid = rk_hdmi_read_edid,
+	.enable = rk3328_hdmi_enable,
+};
+
+static const struct udevice_id rk3328_hdmi_ids[] = {
+	{ .compatible = "rockchip,rk3328-dw-hdmi" },
+	{ }
+};
+
+U_BOOT_DRIVER(rk3328_hdmi_rockchip) = {
+	.name = "rk3328_hdmi_rockchip",
+	.id = UCLASS_DISPLAY,
+	.of_match = rk3328_hdmi_ids,
+	.ops = &rk3328_hdmi_ops,
+	.of_to_plat = rk3328_hdmi_of_to_plat,
+	.probe = rk3328_hdmi_probe,
+	.priv_auto	= sizeof(struct rk_hdmi_priv),
+};
diff --git a/drivers/video/rockchip/rk_hdmi.h b/drivers/video/rockchip/rk_hdmi.h
index 200dbaea74..dcfba3d3d7 100644
--- a/drivers/video/rockchip/rk_hdmi.h
+++ b/drivers/video/rockchip/rk_hdmi.h
@@ -6,6 +6,8 @@
 #ifndef __RK_HDMI_H__
 #define __RK_HDMI_H__
 
+#include <generic-phy.h>
+
 struct rkhdmi_driverdata {
 	/* configuration */
 	u8 i2c_clk_high;
@@ -19,6 +21,7 @@ struct rkhdmi_driverdata {
 
 struct rk_hdmi_priv {
 	struct dw_hdmi hdmi;
+	struct phy phy;
 	void *grf;
 };
 
-- 
2.25.1

