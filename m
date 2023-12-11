Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2C6876F2;
	Mon, 11 Dec 2023 10:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GQ7yeZSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D696B876A4; Mon, 11 Dec 2023 10:01:36 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DD6876F5
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d32c599e83so499475ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285292; x=1702890092;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=319dBTS72L2y4PXgXFwsSuUbMu/VVOZcvzhyBZbjcXg=;
 b=GQ7yeZSPn9dj6MkzGeRGFjTfMhXfXZWxD420AjNllHN1FTxo2qphYnGze6zTpE18Jr
 X1aw+WTlxb+Of98mOhHXVBZTeUM0CFukS6cr/KCNORLNgtwt7PRsgRLajmeGDaBk7YDE
 0ZgWNkTVB2ymf4DFr04IuCFiC9QIROXNNg4OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285292; x=1702890092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=319dBTS72L2y4PXgXFwsSuUbMu/VVOZcvzhyBZbjcXg=;
 b=T+1q6DLmDhHkImLyd7xy4B/jiVswiTJMgQsJguT3GtRLEd51OWMesc4wLtKcWtgqkN
 /xoqHKwaGQ3U7Cb4WtjMDElffN0SQy2tf9IWXTej9fbYim8QUAEVSU6Rf0dQcZRELz4i
 /dRSXmGzRViTqD/lRe36hrLaoo5tTwMYgKk2xBX4NKqer5Ambcz6aPNRpK7J3HpA92X4
 +3r4A4EKoF2zcDaF8ND/Xzb2537F2hPXg0LaGyQc2on+rG3YMfD6Lwokhx4Fki7j+5Tz
 8F5yvPXBzHgsihRfN3gg0DBflHGCSjzXqr8EswwLRKmicuHbIMXcvf+vCaLEd5M8D1+c
 OLVQ==
X-Gm-Message-State: AOJu0Yx5rtec+fMQtQOdJU7jwHyRpQDAA6Z+qNq7AO1tnp0lqgvI07Jy
 R/YYzOJKGqHQzmrSZt7fBe20Ug==
X-Google-Smtp-Source: AGHT+IF36lrEBf9tugfctBkePGJ8+DrI77SpwWGltXtmI1qX7DIHhajnEefXDjsIGEkEhs2xembCDw==
X-Received: by 2002:a17:902:6bc4:b0:1d0:6ffe:a22 with SMTP id
 m4-20020a1709026bc400b001d06ffe0a22mr4375216plt.128.1702285292473; 
 Mon, 11 Dec 2023 01:01:32 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:32 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 12/17] video: rockchip: Add rk3328 hdmi support
Date: Mon, 11 Dec 2023 14:29:34 +0530
Message-Id: <20231211085939.5478-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

