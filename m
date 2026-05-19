Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82199CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDE98470B;
	Tue, 19 May 2026 15:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="FHlMU+uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D62A847E1; Tue, 19 May 2026 15:01:26 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B2D843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195677; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m14iHr/Cr/YpBS+cwCGrSgSCNraM8Z2uHLj5Z8opz8M9/2XoPpqQ5ak15IkaFsTevLcbcG9bw1ioUFPvqc3yaOz0aONdtnIPGu+IqZSi/2g/CG1W9XoPrDaTp5w5GQXIkDmHRFEWmYLXYqs8s0zuEgLMzwBc+guSGNGAHjy4swI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195677;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EM+ban1YY8ITUUhy7rtmL7jbwq42NgKnFqjnVhOb7uI=; 
 b=ZIq/5jBaxfs0qHB2UF7FzWpLJDmqmOF035ZrBcem4TGUFpA3Lj41OCw0Ju0fr2Gybz554+mSiB08XQDPtQdHjn5LJBaLNXQEcL5Et+/KqGyT1FkPEoPUqmyBUtkEm85mB6Nu13rfgxIM5xRMx32PskyHy/vqFACyKiS0YNd98wE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195677; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=EM+ban1YY8ITUUhy7rtmL7jbwq42NgKnFqjnVhOb7uI=;
 b=FHlMU+uIvSCDn/DAjBMKwtQR/2hLWHrDpgquV8sgLHQz2m7Z5ROuNuQ0gJ6XFeDn
 Wcn2a33brRHFnrrnkG5Llg27rUJisb+9JBUMEOE5jkhxgYpukhtLC3qyFifQIDYPfl7
 MN44MmvKVqCd9Okc0QUjRxvtiDMlVUYS3kLja3cc=
Received: by mx.zohomail.com with SMTPS id 1779195674454868.1560175151159;
 Tue, 19 May 2026 06:01:14 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 19 May 2026 20:58:28 +0800
Subject: [PATCH 1/5] net: dwc_eth_qos: add support for sun55i platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-a5e-gmac1-v1-1-c3117603b9fb@pigmoral.tech>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=10237;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=8UngEXoKGHKxGVpck+HvG37JpYSOyAUCKA5Amyp9wfs=;
 b=/hwwaIgnFocsdILcy2bcxUWk1wUnLEakIjEk6cvbzgPkkLY5BEo8xdnS9CJtvt8FZtvCNQyQB
 ZnvUCII6iz0DP5x3iTQ2RAWioL8ikwLdyfv53HcgOBvyUEndHDc+pb1
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The Allwinner sun55i (A523/A527/T527) platform features the Synopsys
DesignWare Ethernet QOS IP. To enable this GMAC controller in U-Boot,
this introduces the glue layer responsible for configuring the
corresponding clocks, resets, and syscon registers.

This implementation is directly ported from upstream Linux kernel commit
f603808a98af ("net: stmmac: Add support for Allwinner A523 GMAC200").

Link: https://patch.msgid.link/20250925191600.3306595-3-wens@kernel.org
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/net/Kconfig             |   9 ++
 drivers/net/Makefile            |   1 +
 drivers/net/dwc_eth_qos.c       |   6 +
 drivers/net/dwc_eth_qos.h       |   1 +
 drivers/net/dwc_eth_qos_sunxi.c | 254 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 271 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 666618681df..7a02d82f8bf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -285,6 +285,15 @@ config DWC_ETH_QOS_STARFIVE
 	  The Synopsys Designware Ethernet QOS IP block with specific
 	  configuration used in STARFIVE  JH7110 soc.
 
+config DWC_ETH_QOS_SUNXI
+	bool "Synopsys DWC Ethernet QOS device support for Allwinner SoCs"
+	depends on DWC_ETH_QOS && ARCH_SUNXI
+	select REGMAP
+	select SUNXI_SYSCON
+	help
+	  The Synopsys Designware Ethernet QOS IP block with specific
+	  configuration used in Allwinner SoCs.
+
 config E1000
 	bool "Intel PRO/1000 Gigabit Ethernet support"
 	depends on PCI
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 5e90183d090..c23c5e60245 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_DWC_ETH_XGMAC) += dwc_eth_xgmac.o
 obj-$(CONFIG_DWC_ETH_XGMAC_SOCFPGA) += dwc_eth_xgmac_socfpga.o
 obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
 obj-$(CONFIG_DWC_ETH_QOS_STM32) += dwc_eth_qos_stm32.o
+obj-$(CONFIG_DWC_ETH_QOS_SUNXI) += dwc_eth_qos_sunxi.o
 obj-$(CONFIG_E1000) += e1000.o
 obj-$(CONFIG_E1000_SPI) += e1000_spi.o
 obj-$(CONFIG_EEPRO100) += eepro100.o
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 0f31d646845..362508ec9a2 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1658,6 +1658,12 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "adi,sc59x-dwmac-eqos",
 		.data = (ulong)&eqos_adi_config
 	},
+#endif
+#if IS_ENABLED(CONFIG_DWC_ETH_QOS_SUNXI)
+	{
+		.compatible = "allwinner,sun55i-a523-gmac200",
+		.data = (ulong)&eqos_sunxi_config
+	},
 #endif
 	{ }
 };
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ba16f1a37cb..f6fc6164707 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -316,3 +316,4 @@ extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_stm32mp25_config;
 extern struct eqos_config eqos_jh7110_config;
 extern struct eqos_config eqos_adi_config;
+extern struct eqos_config eqos_sunxi_config;
diff --git a/drivers/net/dwc_eth_qos_sunxi.c b/drivers/net/dwc_eth_qos_sunxi.c
new file mode 100644
index 00000000000..91d871dd271
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_sunxi.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Corentin Labbe <clabbe.montjoie@gmail.com>
+ * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <net.h>
+#include <phy.h>
+#include <power/regulator.h>
+#include <regmap.h>
+#include <reset.h>
+#include <malloc.h>
+#include <syscon.h>
+
+#include "dwc_eth_qos.h"
+
+#define SYSCON_REG			0x34
+
+#define SYSCON_PHY_SELECT		BIT(15) /* 1: internal, 0: external */
+/* RMII specific bits */
+#define SYSCON_RMII_EN			BIT(13) /* 1: enable RMII (overrides EPIT) */
+/* Generic system control EMAC_CLK bits */
+#define SYSCON_ETXDC_MASK		GENMASK(12, 10)
+#define SYSCON_ERXDC_MASK		GENMASK(9, 5)
+/* EMAC PHY Interface Type */
+#define SYSCON_EPIT			BIT(2) /* 1: RGMII, 0: MII */
+#define SYSCON_ETCS_MASK		GENMASK(1, 0)
+#define SYSCON_ETCS_MII			0x0
+#define SYSCON_ETCS_EXT_GMII		0x1
+#define SYSCON_ETCS_INT_GMII		0x2
+
+struct sunxi_platform_data {
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
+};
+
+static int sunxi_gmac_set_syscon(struct udevice *dev,
+				 phy_interface_t interface_type)
+{
+	struct regmap *regmap;
+	u32 val, reg = 0;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Unable to map syscon\n");
+		return PTR_ERR(regmap);
+	}
+
+	if (!dev_read_u32(dev, "tx-internal-delay-ps", &val)) {
+		if (val % 100) {
+			dev_err(dev, "tx-delay must be a multiple of 100\n");
+			return -EINVAL;
+		}
+		val /= 100;
+		dev_dbg(dev, "set tx-delay to %x\n", val);
+
+		if (!FIELD_FIT(SYSCON_ETXDC_MASK, val)) {
+			dev_err(dev, "TX clock delay exceeds maximum\n");
+			return -EINVAL;
+		}
+
+		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
+	}
+
+	if (!dev_read_u32(dev, "rx-internal-delay-ps", &val)) {
+		if (val % 100) {
+			dev_err(dev, "rx-delay must be a multiple of 100\n");
+			return -EINVAL;
+		}
+		val /= 100;
+		dev_dbg(dev, "set rx-delay to %x\n", val);
+		if (!FIELD_FIT(SYSCON_ERXDC_MASK, val)) {
+			dev_err(dev, "Invalid RX clock delay: %d\n", val);
+			return -EINVAL;
+		}
+
+		reg |= FIELD_PREP(SYSCON_ERXDC_MASK, val);
+	}
+
+	switch (interface_type) {
+	case PHY_INTERFACE_MODE_MII:
+		/* default */
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		reg |= SYSCON_RMII_EN;
+		break;
+	default:
+		dev_err(dev, "Unsupported interface mode: %s\n",
+			phy_interface_strings[interface_type]);
+		return -EINVAL;
+	}
+
+	ret = regmap_write(regmap, SYSCON_REG, reg);
+	if (ret < 0) {
+		dev_err(dev, "Failed to write to syscon\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int eqos_start_clks_sunxi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data = pdata->priv_pdata;
+
+	return clk_enable_bulk(&data->clks);
+}
+
+static int eqos_stop_clks_sunxi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data = pdata->priv_pdata;
+
+	return clk_disable_bulk(&data->clks);
+}
+
+static int eqos_start_resets_sunxi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data = pdata->priv_pdata;
+	int ret;
+
+	ret = reset_deassert_bulk(&data->resets);
+	if (ret)
+		return ret;
+
+	return sunxi_gmac_set_syscon(dev, pdata->phy_interface);
+}
+
+static int eqos_stop_resets_sunxi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data = pdata->priv_pdata;
+
+	return reset_assert_bulk(&data->resets);
+}
+
+static int eqos_probe_resources_sunxi(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data;
+	struct udevice *phy_supply = NULL;
+	int ret;
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		dev_err(dev, "Failed to get base address: %d\n", ret);
+		return ret;
+	}
+
+	data = calloc(1, sizeof(struct sunxi_platform_data));
+	if (!data)
+		return -ENOMEM;
+
+	pdata->priv_pdata = data;
+
+	pdata->phy_interface = eqos->config->interface(dev);
+	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
+		dev_err(dev, "Failed to get PHY interface mode\n");
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
+	if (ret) {
+		dev_err(dev, "Failed to get stmmaceth clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &data->resets);
+	if (ret) {
+		dev_err(dev, "Failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_bulk(dev, &data->clks);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "phy-supply", &phy_supply);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Failed to get PHY supply: %d\n", ret);
+			return ret;
+		}
+
+		if (phy_supply) {
+			ret = regulator_set_enable_if_allowed(phy_supply, true);
+			if (ret) {
+				dev_err(dev, "Failed to enable phy supply: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int eqos_remove_resources_sunxi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct sunxi_platform_data *data = pdata->priv_pdata;
+
+	reset_assert_bulk(&data->resets);
+	clk_disable_bulk(&data->clks);
+
+	return 0;
+}
+
+static struct eqos_ops eqos_sunxi_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_sunxi,
+	.eqos_remove_resources = eqos_remove_resources_sunxi,
+	.eqos_stop_resets = eqos_stop_resets_sunxi,
+	.eqos_start_resets = eqos_start_resets_sunxi,
+	.eqos_stop_clks = eqos_stop_clks_sunxi,
+	.eqos_start_clks = eqos_start_clks_sunxi,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_null_ops,
+	.eqos_get_enetaddr = eqos_null_ops,
+};
+
+struct eqos_config __maybe_unused eqos_sunxi_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_150_250,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_sunxi_ops
+};

-- 
2.54.0

