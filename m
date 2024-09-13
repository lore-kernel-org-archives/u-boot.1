Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FFCFA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1D688B93;
	Fri, 13 Sep 2024 11:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c+39cc28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A66A88CC8; Fri, 13 Sep 2024 11:57:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57B688CC5
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso87895966b.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221429; x=1726826229;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2avQ3f+LlSKpWnLEZG75p6uGV1IhRjabYa/XERRt3A=;
 b=c+39cc283QiqN730PPYbOWjLyaq91Ks+1HNi69Qmn77BJf9sEfHOLAB6cyRfVf0Ugc
 /J/hlPZcCb/IdKZ0lVE2XvVBNbmGKajZwVkvkFAgyhk4TWBhxBDrTrETt2MJRsYvftbf
 XY/b0isR9C3/ZiXpvls/2KT6EsebUkp4Y8nII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221429; x=1726826229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2avQ3f+LlSKpWnLEZG75p6uGV1IhRjabYa/XERRt3A=;
 b=LhtpxlqY3Cn19BWDwNTmY27y/Y4Ckt6smXOfGyABgb1AG5RzScL2yvhkjLN3paLZ7Q
 GpSMonNWUY4FQmiLFtVouqaoSS1jWQqB57mcQiHDtFupdus3T54stYb+I14IKD/o/3mf
 bKbcwNwgE3XgI1zDThwjLx042LRc5wugJ2/4MeDnVywnH/4ImbzBaBxILjqyitVdvNfR
 76nwVhCKznbhM2WA3SrnPVpA9VstClA6GmMqI8ITsPsMomq6Wl2ZgufMcxIKuRfdbLdL
 kN03O5RV0fQeRnkxPlSPbFlW5JWk3flx9unKFXmCOafhydFtc/2FQxblN/gdJ5fXJqse
 cQxg==
X-Gm-Message-State: AOJu0YxupgJgbLDqX12BGUVLJTa7ZhFZPLT0+fQOwqpGz2FxVUXD0kX2
 aOJnrCUqCBh/ihl1vZA/LWdv3vzlDVu+tMgpifA53jf75pHMUekIhBiTXp3S7SDKZtQVuk/iez7
 0O1A=
X-Google-Smtp-Source: AGHT+IHlJ7+Uu8R5Ns2veLSNvokNLgBPY435Yko5Na+oEnE2VfSFGfM22kyMcr8epI0JKVtoyPhJ/Q==
X-Received: by 2002:a17:907:6e8f:b0:a8d:c3b:b16 with SMTP id
 a640c23a62f3a-a9047d1afaemr150708966b.28.1726221428931; 
 Fri, 13 Sep 2024 02:57:08 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:08 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Date: Fri, 13 Sep 2024 11:55:50 +0200
Message-ID: <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
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

Add iMX8 block ctrl driver for displaymix on iMX8MM/iMX8MN and
mediamix on iMX8MP.

To support blk ctrl driver, the power domain driver on iMX8M needs
update to add relevant PGC domains

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/power/domain/Kconfig              |   6 +
 drivers/power/domain/Makefile             |   1 +
 drivers/power/domain/imx8m-blk-ctrl.c     | 438 ++++++++++++++++++++++
 drivers/power/domain/imx8m-power-domain.c | 213 ++++++++++-
 4 files changed, 656 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index bd82d2f7044b..fb006b6e8e28 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -40,6 +40,12 @@ config IMX8M_POWER_DOMAIN
 	  Enable support for manipulating NXP i.MX8M on-SoC power domains via
 	  requests to the ATF.
 
+config IMX8M_BLK_CTRL
+	bool "Enable i.MX8M block control driver"
+	depends on POWER_DOMAIN && ARCH_IMX8M
+	help
+	  Enable support for manipulating NXP i.MX8M on-SoC block control driver
+
 config IMX8MP_HSIOMIX_BLKCTRL
 	bool "Enable i.MX8MP HSIOMIX domain driver"
 	depends on POWER_DOMAIN && IMX8MP
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 2daab73eb758..46849fd2a4db 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
new file mode 100644
index 000000000000..4c89078b991b
--- /dev/null
+++ b/drivers/power/domain/imx8m-blk-ctrl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <power-domain-uclass.h>
+#include <asm/io.h>
+#include <dm/device-internal.h>
+#include <dm/device.h>
+#include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/power/imx8mp-power.h>
+#include <clk.h>
+#include <linux/delay.h>
+
+#define BLK_SFT_RSTN	0x0
+#define BLK_CLK_EN	0x4
+#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL only */
+
+#define DOMAIN_MAX_CLKS 4
+
+struct imx8m_blk_ctrl_domain {
+	struct clk clks[DOMAIN_MAX_CLKS];
+	struct power_domain power_dev;
+};
+
+struct imx8m_blk_ctrl {
+	void __iomem *base;
+	struct power_domain bus_power_dev;
+	struct imx8m_blk_ctrl_domain *domains;
+};
+
+struct imx8m_blk_ctrl_domain_data {
+	const char *name;
+	const char * const *clk_names;
+	const char *gpc_name;
+	int num_clks;
+	u32 rst_mask;
+	u32 clk_mask;
+	u32 mipi_phy_rst_mask;
+};
+
+struct imx8m_blk_ctrl_data {
+	int max_reg;
+	const struct imx8m_blk_ctrl_domain_data *domains;
+	int num_domains;
+	u32 bus_rst_mask;
+	u32 bus_clk_mask;
+};
+
+static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulong domain_id, bool enable)
+{
+	int ret, i;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id].num_clks);
+
+	for (i = 0; i < drv_data->domains[domain_id].num_clks; i++) {
+		debug("%s clk %s\n", __func__, drv_data->domains[domain_id].clk_names[i]);
+		if (enable)
+			ret = clk_enable(&priv->domains[domain_id].clks[i]);
+		else
+			ret = clk_disable(&priv->domains[domain_id].clks[i]);
+		if (ret && ret != -ENOENT) {
+			printf("Failed to %s domain clk %s\n", enable ? "enable" : "disable",
+			       drv_data->domains[domain_id].clk_names[i]);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+	int ret;
+
+	debug("%s, id %lu\n", __func__, power_domain->id);
+
+	if (!priv->domains[power_domain->id].power_dev.dev)
+		return -ENODEV;
+
+	ret = power_domain_on(&priv->bus_power_dev);
+	if (ret < 0) {
+		printf("Failed to power up bus domain %d\n", ret);
+		return ret;
+	}
+
+	/* Enable bus clock and deassert bus reset */
+	setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
+	setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask);
+
+	/* wait for reset to propagate */
+	udelay(5);
+
+	/* put devices into reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
+			     rv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	/* enable upstream and blk-ctrl clocks to allow reset to propagate */
+	ret = imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, true);
+	if (ret) {
+		printf("failed to enable clocks\n");
+		goto bus_powerdown;
+	}
+
+	/* ungate clk */
+	setbits_le32(priv->base + BLK_CLK_EN, drv_data->domains[power_domain->id].clk_mask);
+
+	/* power up upstream GPC domain */
+	ret = power_domain_on(&priv->domains[power_domain->id].power_dev);
+	if (ret < 0) {
+		printf("Failed to power up peripheral domain %d\n", ret);
+		goto clk_disable;
+	}
+
+	/* wait for reset to propagate */
+	udelay(5);
+
+	/* release reset */
+	setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		setbits_le32(priv->base + BLK_MIPI_RESET_DIV,
+			     drv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	return 0;
+clk_disable:
+	imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, false);
+bus_powerdown:
+	power_domain_off(&priv->bus_power_dev);
+	return ret;
+}
+
+static int imx8m_blk_ctrl_power_off(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	debug("%s, id %lu\n", __func__, power_domain->id);
+
+	if (!priv->domains[power_domain->id].power_dev.dev)
+		return -ENODEV;
+
+	/* put devices into reset and disable clocks */
+	if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
+		clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
+			     drv_data->domains[power_domain->id].mipi_phy_rst_mask);
+
+	/* assert reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
+
+	/* gate clk */
+	clrbits_le32(priv->base + BLK_CLK_EN, drv_data->domains[power_domain->id].clk_mask);
+
+	/* power down upstream GPC domain */
+	power_domain_off(&priv->domains[power_domain->id].power_dev);
+
+	imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, false);
+
+	/* power down bus domain */
+	power_domain_off(&priv->bus_power_dev);
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_probe(struct udevice *dev)
+{
+	int ret, i, j;
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+	struct imx8m_blk_ctrl_data *drv_data =
+		(struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	priv->domains = kcalloc(drv_data->num_domains,
+				sizeof(struct imx8m_blk_ctrl_domain), GFP_KERNEL);
+
+	ret = power_domain_get_by_name(dev, &priv->bus_power_dev, "bus");
+	if (ret) {
+		printf("Failed to power_domain_get_by_name %s\n", "bus");
+		return ret;
+	}
+
+	for (j = 0; j < drv_data->num_domains; j++) {
+		ret = power_domain_get_by_name(dev, &priv->domains[j].power_dev,
+					       drv_data->domains[j].gpc_name);
+		if (ret)
+			continue;
+
+		for (i = 0; i < drv_data->domains[j].num_clks; i++) {
+			ret = clk_get_by_name(dev, drv_data->domains[j].clk_names[i],
+					      &priv->domains[j].clks[i]);
+			if (ret) {
+				printf("Failed to get clk %s\n", drv_data->domains[j].clk_names[i]);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int imx8m_blk_ctrl_remove(struct udevice *dev)
+{
+	struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
+
+	kfree(priv->domains);
+
+	return 0;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
+	[IMX8MM_DISPBLK_PD_CSI_BRIDGE] = {
+		.name = "dispblk-csi-bridge",
+		.clk_names = (const char *[]){ "csi-bridge-axi", "csi-bridge-apb",
+					       "csi-bridge-core", },
+		.num_clks = 3,
+		.gpc_name = "csi-bridge",
+		.rst_mask = BIT(0) | BIT(1) | BIT(2),
+		.clk_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5),
+	},
+	[IMX8MM_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.clk_mask = BIT(6) | BIT(7),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(5),
+		.clk_mask = BIT(8) | BIT(9),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(3) | BIT(4),
+		.clk_mask = BIT(10) | BIT(11),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
+	.max_reg = 0x2c,
+	.domains = imx8mm_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
+	.bus_rst_mask = BIT(6),
+	.bus_clk_mask = BIT(12),
+};
+
+static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+	[IMX8MN_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.rst_mask = BIT(4) | BIT(5),
+		.clk_mask = BIT(4) | BIT(5),
+	},
+	[IMX8MN_DISPBLK_PD_ISI] = {
+		.name = "dispblk-isi",
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
+						"disp_apb_root"},
+		.num_clks = 4,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+	.max_reg = 0x84,
+	.domains = imx8mn_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
+	.bus_rst_mask = BIT(8),
+	.bus_clk_mask = BIT(8),
+};
+
+static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[] = {
+	[IMX8MP_MEDIABLK_PD_MIPI_DSI_1] = {
+		.name = "mediablk-mipi-dsi-1",
+		.clk_names = (const char *[]){ "apb", "phy", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi1",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_1] = {
+		.name = "mediablk-mipi-csi2-1",
+		.clk_names = (const char *[]){ "apb", "cam1" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi1",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+	[IMX8MP_MEDIABLK_PD_LCDIF_1] = {
+		.name = "mediablk-lcdif-1",
+		.clk_names = (const char *[]){ "disp1", "apb", "axi", },
+		.num_clks = 3,
+		.gpc_name = "lcdif1",
+		.rst_mask = BIT(4) | BIT(5) | BIT(23),
+		.clk_mask = BIT(4) | BIT(5) | BIT(23),
+	},
+	[IMX8MP_MEDIABLK_PD_ISI] = {
+		.name = "mediablk-isi",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
+		.name = "mediablk-mipi-csi2-2",
+		.clk_names = (const char *[]){ "apb", "cam2" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi2",
+		.rst_mask = BIT(9) | BIT(10),
+		.clk_mask = BIT(9) | BIT(10),
+		.mipi_phy_rst_mask = BIT(30),
+	},
+	[IMX8MP_MEDIABLK_PD_LCDIF_2] = {
+		.name = "mediablk-lcdif-2",
+		.clk_names = (const char *[]){ "disp2", "apb", "axi", },
+		.num_clks = 3,
+		.gpc_name = "lcdif2",
+		.rst_mask = BIT(11) | BIT(12) | BIT(24),
+		.clk_mask = BIT(11) | BIT(12) | BIT(24),
+	},
+	[IMX8MP_MEDIABLK_PD_ISP] = {
+		.name = "mediablk-isp",
+		.clk_names = (const char *[]){ "isp", "axi", "apb" },
+		.num_clks = 3,
+		.gpc_name = "isp",
+		.rst_mask = BIT(16) | BIT(17) | BIT(18),
+		.clk_mask = BIT(16) | BIT(17) | BIT(18),
+	},
+	[IMX8MP_MEDIABLK_PD_DWE] = {
+		.name = "mediablk-dwe",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "dwe",
+		.rst_mask = BIT(19) | BIT(20) | BIT(21),
+		.clk_mask = BIT(19) | BIT(20) | BIT(21),
+	},
+	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
+		.name = "mediablk-mipi-dsi-2",
+		.clk_names = (const char *[]){ "phy", },
+		.num_clks = 1,
+		.gpc_name = "mipi-dsi2",
+		.rst_mask = BIT(22),
+		.clk_mask = BIT(22),
+		.mipi_phy_rst_mask = BIT(29),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mp_media_blk_ctl_dev_data = {
+	.max_reg = 0x138,
+	.domains = imx8mp_media_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mp_media_blk_ctl_domain_data),
+	.bus_rst_mask = BIT(8),
+	.bus_clk_mask = BIT(8),
+};
+
+static const struct udevice_id imx8m_blk_ctrl_ids[] = {
+	{.compatible = "fsl,imx8mm-disp-blk-ctrl", .data = (ulong)&imx8mm_disp_blk_ctl_dev_data},
+	{.compatible = "fsl,imx8mn-disp-blk-ctrl", .data = (ulong)&imx8mn_disp_blk_ctl_dev_data},
+	{.compatible = "fsl,imx8mp-media-blk-ctrl", .data = (ulong)&imx8mp_media_blk_ctl_dev_data},
+	{}
+};
+
+struct power_domain_ops imx8m_blk_ctrl_ops = {
+	.request = imx8m_blk_ctrl_request,
+	.rfree = imx8m_blk_ctrl_free,
+	.on = imx8m_blk_ctrl_power_on,
+	.off = imx8m_blk_ctrl_power_off,
+};
+
+U_BOOT_DRIVER(imx8m_blk_ctrl) = {
+	.name = "imx8m_blk_ctrl",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = imx8m_blk_ctrl_ids,
+	.bind = dm_scan_fdt_dev,
+	.probe = imx8m_blk_ctrl_probe,
+	.remove = imx8m_blk_ctrl_remove,
+	.priv_auto	= sizeof(struct imx8m_blk_ctrl),
+	.ops = &imx8m_blk_ctrl_ops,
+	.flags  = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 8b6870c86463..40fec70d954a 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -32,17 +32,31 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8M_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 
+#define IMX8MM_VPUH1_A53_DOMAIN			BIT(15)
+#define IMX8MM_VPUG2_A53_DOMAIN			BIT(14)
+#define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
+#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
 #define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
 #define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MN_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MN_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MN_DDR1_A53_DOMAIN		BIT(7)
 #define IMX8MN_OTG1_A53_DOMAIN			BIT(4)
 #define IMX8MN_MIPI_A53_DOMAIN			BIT(2)
 
 #define IMX8MP_HSIOMIX_A53_DOMAIN		BIT(19)
+#define IMX8MP_MEDIAMIX_A53_DOMAIN		BIT(12)
 #define IMX8MP_USB2_PHY_A53_DOMAIN		BIT(5)
 #define IMX8MP_USB1_PHY_A53_DOMAIN		BIT(4)
 #define IMX8MP_PCIE_PHY_A53_DOMAIN		BIT(3)
+#define IMX8MP_MIPI_PHY1_A53_DOMAIN		BIT(2)
 
 #define IMX8MP_GPC_PU_PGC_SW_PUP_REQ		0x0d8
 #define IMX8MP_GPC_PU_PGC_SW_PDN_REQ		0x0e4
@@ -50,35 +64,72 @@ DECLARE_GLOBAL_DATA_PTR;
 #define GPC_PU_PGC_SW_PUP_REQ			0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ			0x104
 
+#define IMX8M_PCIE2_SW_Pxx_REQ			BIT(13)
+#define IMX8M_MIPI_CSI2_SW_Pxx_REQ		BIT(12)
+#define IMX8M_MIPI_CSI1_SW_Pxx_REQ		BIT(11)
+#define IMX8M_DISP_SW_Pxx_REQ			BIT(10)
+#define IMX8M_HDMI_SW_Pxx_REQ			BIT(9)
+#define IMX8M_VPU_SW_Pxx_REQ			BIT(8)
+#define IMX8M_GPU_SW_Pxx_REQ			BIT(7)
+#define IMX8M_DDR2_SW_Pxx_REQ			BIT(6)
+#define IMX8M_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8M_PCIE2_SW_Pxx_REQ			BIT(13)
 #define IMX8M_OTG2_SW_Pxx_REQ			BIT(3)
 #define IMX8M_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 
+#define IMX8MM_VPUH1_SW_Pxx_REQ			BIT(13)
+#define IMX8MM_VPUG2_SW_Pxx_REQ			BIT(12)
+#define IMX8MM_VPUG1_SW_Pxx_REQ			BIT(11)
+#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
+#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MM_GPU_SW_Pxx_REQ			(BIT(6) | BIT(9))
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
 #define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MN_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MN_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MN_DDR1_SW_Pxx_REQ			BIT(5)
 #define IMX8MN_OTG1_SW_Pxx_REQ			BIT(2)
 #define IMX8MN_MIPI_SW_Pxx_REQ			BIT(0)
 
 #define IMX8MP_HSIOMIX_Pxx_REQ			BIT(17)
+#define IMX8MP_MEDIMIX_Pxx_REQ			BIT(10)
 #define IMX8MP_USB2_PHY_Pxx_REQ			BIT(3)
 #define IMX8MP_USB1_PHY_Pxx_REQ			BIT(2)
 #define IMX8MP_PCIE_PHY_SW_Pxx_REQ		BIT(1)
+#define IMX8MP_MIPI_PHY1_SW_Pxx_REQ		BIT(0)
 
 #define GPC_M4_PU_PDN_FLG			0x1bc
 
 #define IMX8MP_GPC_PU_PWRHSK			0x190
 #define GPC_PU_PWRHSK				0x1fc
 
+#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
+#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
+#define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
+#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
+#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
+#define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
 
+#define IMX8MN_GPUMIX_HSK_PWRDNACKN		(BIT(29) | BIT(27))
+#define IMX8MN_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MN_HSIO_HSK_PWRDNACKN		BIT(23)
+#define IMX8MN_GPUMIX_HSK_PWRDNREQN		(BIT(11) | BIT(9))
+#define IMX8MN_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MN_HSIO_HSK_PWRDNREQN		BIT(5)
 
+#define IMX8MP_MEDIAMIX_PWRDNACKN		BIT(30)
 #define IMX8MP_HSIOMIX_PWRDNACKN		BIT(28)
+#define IMX8MP_MEDIAMIX_PWRDNREQN		BIT(14)
 #define IMX8MP_HSIOMIX_PWRDNREQN		BIT(12)
 
 /*
@@ -92,15 +143,31 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8M_PGC_OTG2			19
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_MIPI			16
 #define IMX8MM_PGC_PCIE			17
 #define IMX8MM_PGC_OTG1			18
 #define IMX8MM_PGC_OTG2			19
-
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU2D		22
+#define IMX8MM_PGC_GPUMIX		23
+#define IMX8MM_PGC_VPUMIX		24
+#define IMX8MM_PGC_GPU3D		25
+#define IMX8MM_PGC_DISPMIX		26
+#define IMX8MM_PGC_VPUG1		27
+#define IMX8MM_PGC_VPUG2		28
+#define IMX8MM_PGC_VPUH1		29
+
+#define IMX8MN_PGC_MIPI			16
 #define IMX8MN_PGC_OTG1			18
+#define IMX8MN_PGC_DDR1			21
+#define IMX8MN_PGC_GPUMIX		23
+#define IMX8MN_PGC_DISPMIX		26
 
+#define IMX8MP_PGC_MIPI1		12
 #define IMX8MP_PGC_PCIE			13
 #define IMX8MP_PGC_USB1			14
 #define IMX8MP_PGC_USB2			15
+#define IMX8MP_PGC_MEDIAMIX		22
 #define IMX8MP_PGC_HSIOMIX		29
 
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
@@ -142,6 +209,7 @@ struct imx8m_power_domain_plat {
 	void __iomem *base;
 	int resource_id;
 	int has_pd;
+	int count;
 };
 
 #if defined(CONFIG_IMX8MM) || defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MQ)
@@ -230,6 +298,82 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MM_PGC_OTG2),
 	},
+
+	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU] = {
+		.bits  = {
+			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
+			.map = IMX8MM_GPU_A53_DOMAIN,
+			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_GPU2D) | BIT(IMX8MM_PGC_GPU3D),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUMIX_SW_Pxx_REQ,
+			.map = IMX8MM_VPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_VPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_VPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG1] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUG1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG1_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUG1),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUG2] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUG2_SW_Pxx_REQ,
+			.map = IMX8MM_VPUG2_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUG2),
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPUH1] = {
+		.bits  = {
+			.pxx = IMX8MM_VPUH1_SW_Pxx_REQ,
+			.map = IMX8MM_VPUH1_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_VPUH1),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DISPMIX] = {
+		.bits  = {
+			.pxx = IMX8MM_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MM_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MM_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MM_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MM_POWER_DOMAIN_MIPI] = {
+		.bits  = {
+			.pxx = IMX8MM_MIPI_SW_Pxx_REQ,
+			.map = IMX8MM_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MM_PGC_MIPI),
+	},
 };
 
 static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
@@ -258,6 +402,36 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MN_PGC_OTG1),
 	},
+
+	[IMX8MN_POWER_DOMAIN_GPUMIX] = {
+		.bits  = {
+			.pxx = IMX8MN_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MN_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
+		.bits  = {
+			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MN_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_MIPI] = {
+		.bits  = {
+			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
+			.map = IMX8MN_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_MIPI),
+	},
 };
 
 static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
@@ -268,7 +442,15 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
 #endif
 
 #ifdef CONFIG_IMX8MP
-static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
+static const struct imx_pgc_domain imx8mp_pgc_domains[19] = {
+	[IMX8MP_POWER_DOMAIN_MIPI_PHY1] = {
+		.bits = {
+			.pxx = IMX8MP_MIPI_PHY1_SW_Pxx_REQ,
+			.map = IMX8MP_MIPI_PHY1_A53_DOMAIN,
+		},
+		.pgc = BIT(IMX8MP_PGC_MIPI1),
+	},
+
 	[IMX8MP_POWER_DOMAIN_PCIE_PHY] = {
 		.bits = {
 			.pxx = IMX8MP_PCIE_PHY_SW_Pxx_REQ,
@@ -293,6 +475,17 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 		.pgc = BIT(IMX8MP_PGC_USB2),
 	},
 
+	[IMX8MP_POWER_DOMAIN_MEDIAMIX] = {
+		.bits = {
+			.pxx = IMX8MP_MEDIMIX_Pxx_REQ,
+			.map = IMX8MP_MEDIAMIX_A53_DOMAIN,
+			.hskreq = IMX8MP_MEDIAMIX_PWRDNREQN,
+			.hskack = IMX8MP_MEDIAMIX_PWRDNACKN,
+		},
+		.pgc = BIT(IMX8MP_PGC_MEDIAMIX),
+		.keep_clocks = true,
+	},
+
 	[IMX8MP_POWER_DOMAIN_HSIOMIX] = {
 		.bits = {
 			.pxx = IMX8MP_HSIOMIX_Pxx_REQ,
@@ -329,6 +522,11 @@ static int imx8m_power_domain_on(struct power_domain *power_domain)
 	u32 pgc;
 	int ret;
 
+	if (pdata->count > 0) { /* Already on */
+		pdata->count++;
+		return 0;
+	}
+
 	if (pdata->clk.count) {
 		ret = clk_enable_bulk(&pdata->clk);
 		if (ret) {
@@ -373,6 +571,8 @@ static int imx8m_power_domain_on(struct power_domain *power_domain)
 	if (!domain->keep_clocks && pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
 
+	pdata->count++;
+
 	return 0;
 
 out_clk_disable:
@@ -391,6 +591,13 @@ static int imx8m_power_domain_off(struct power_domain *power_domain)
 	u32 pgc;
 	int ret;
 
+	if (!pdata->count) { /* Already off */
+		return 0;
+	} else if (pdata->count > 1) {
+		pdata->count--;
+		return 0;
+	}
+
 	/* Enable reset clocks for all devices in the domain */
 	if (!domain->keep_clocks && pdata->clk.count) {
 		ret = clk_enable_bulk(&pdata->clk);
@@ -439,6 +646,8 @@ static int imx8m_power_domain_off(struct power_domain *power_domain)
 	if (pdata->has_pd)
 		power_domain_off(&pdata->pd);
 
+	pdata->count--;
+
 	return 0;
 
 out_clk_disable:
-- 
2.43.0

