Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732B1FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D157C84572;
	Sat, 25 Apr 2026 22:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LDhQ5N0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7F38419E; Sat, 25 Apr 2026 22:01:54 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45A284154
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so8469310e87.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777147311; x=1777752111;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J4obtvlh3KEE/kFgClz5JMnck2ZUr/wL5+TmWU96zzw=;
 b=LDhQ5N0DLR6M535PwvYqyqZyl3KbwLXiE4y4czNxmT5HG+8SiHGlxWkWqSFP1OBWvi
 mlkSgiWib52z2EHlfAF6KgwCRDYhzhzx97CWW5AXDnRGdtQl5v3UjO51CSe55LjjDewo
 9nwOGtBqgcPE2kOHxPlETPlV5aKJXslGc61S2kRRMnaJTIdCXBL138iVc6BLE62IsLZx
 O9qPyI9VrcSXZkwisREPnkZwpicgBLO4Le97ET7mxIePVdL/dZ9Zz4HkDIhCPLijjcms
 sbU09qcnU9puJ0jbSpQefyICODBVJBflJ7ooyjgPX0K26FukGQqRafTX7geBOR4PyVyy
 Of+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147311; x=1777752111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J4obtvlh3KEE/kFgClz5JMnck2ZUr/wL5+TmWU96zzw=;
 b=FN37bLxTMBfGtVvWtVef3Uts4+I9eu5bFpInEAJsHV78z289Rch7IHGg5/P0MiALE+
 er8Se/424rY65BBKOY17qKaRsPCxdNt5QjPqXDW/CQnCYaRIaRZ4z6rvlVDpU0PQ1UcN
 GBrYQgho+cQj1peWUooGVDLIm7Do7L8OdW4C5yrk7RrEQzJTOhiGvQdgnGA7XyHdLqCG
 iBZSizyWac0AGJkU70HFre3JvStG6cfyEF0MmHZ1dKOW5Mf4QNdHctQBZAPMT9wWHHhO
 YrXG2XVnRepN+bknWskEmjxIX1dZRbtwkYb+4EsTrew22dOBXJZyJ+c0E2axdRVZ7FsL
 arBg==
X-Gm-Message-State: AOJu0YyVNM8TaXSmnqZHMlb4jWPudPuXj/xciFG+AoykMLCNtupdWF4f
 i4jizb6280IJn8RzjJoSacVphRGhDQdMVNUS8Bb5F9Zr3Big3wxFZqzP6NNGA0CM2CKkyvStoQz
 /svt+9Lk=
X-Gm-Gg: AeBDietiP81SWRz65HgOFosymWcZ9k4QgwHn1NR8SLc4hOM56iKlpFxxlO4Z8eG0vjU
 omP+PAWmq9IgqVIPKLf5/IdPgx1wsIjZwCcFtqSade7SQ5rX9+dU+mSbIWScnZJ8wS/lSglYejs
 EbcRqVT+TDxFQiumKYNJAFsHbhDocLC5rzoNrI9HkODDxF/aVgc2pY+D1yXx0HKY87MMDVCASbh
 c86WU2vc8ueiEo1jpKxoYmkNrcXJ/f+ZDrvtHyEbFLqq7ynE5nAjndKEb9x4s7nRZIN/cC9AkDk
 76ccUvwIbO0ohLF4Xk9DtxYGVb8o35ibBssv/6u592SszBTKqO0Gb6WgaaIfsoLzHCU9mjIKFES
 a8k60DC1nGYlY5xjwhS5JNlnPOU+GKlSWMxuBqxTb5DOUerdxYFtLYPT6SE9mxzPd/SIPXO5JJ/
 tZAXgYYqRIYhX8cCbwi2Uyi5hLqUJEMQVffkrRomVQp44zV6p7tHLp2zOtnZzaebC/vUT4jWQ55
 tlBQolzUUEoNkJktMqcrCaFwY6QI4qeBLjaiJAtYQT9Tx3PZhJIpDDpT+OVv41IHPlDMOmp7Gq6
 HedveO0lbUR7ABX90znYpByJP1QA
X-Received: by 2002:a05:600c:8b8a:b0:489:149a:f9e7 with SMTP id
 5b1f17b1804b1-489149afa2bmr301137735e9.27.1776950786725; 
 Thu, 23 Apr 2026 06:26:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:26:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:58 +0200
Subject: [PATCH 7/9] net: dwc_eth_qos: Add mediatek support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-7-47ca918e0017@baylibre.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

Synopsys DWC Ethernet QOS device support for MediaTek SoCs.
in particular this initial commit adds support for Genio 520/720 and
Genio 510/700 EVKs

Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                   |   1 +
 drivers/net/Kconfig           |   7 +
 drivers/net/Makefile          |   1 +
 drivers/net/dwc_eth_qos.c     |   6 +
 drivers/net/dwc_eth_qos.h     |   2 +
 drivers/net/dwc_eth_qos_mtk.c | 447 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 464 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a59342de3e7..b62f77735f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -437,6 +437,7 @@ F:	drivers/clk/mediatek/
 F:	drivers/cpu/mtk_cpu.c
 F:	drivers/i2c/mtk_i2c.c
 F:	drivers/mmc/mtk-sd.c
+F:	drivers/net/dwc_eth_qos_mtk.c
 F:	drivers/net/mtk_eth/
 F:	drivers/net/phy/mediatek/
 F:	drivers/phy/phy-mtk-*
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 81d6e7cc2b1..c73be2ff1da 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -246,6 +246,13 @@ config DWC_ETH_QOS_INTEL
 	  The Synopsys Designware Ethernet QOS IP block with the specific
 	  configuration used in the Intel Elkhart-Lake soc.
 
+config DWC_ETH_QOS_MTK
+	bool "Synopsys DWC Ethernet QOS device support for MediaTek SoCs"
+	depends on DWC_ETH_QOS && ARCH_MEDIATEK
+	help
+	  The Synopsys Designware Ethernet QOS IP block with the specific
+	  configuration used in MediaTek SoCs.
+
 config DWC_ETH_QOS_QCOM
 	bool "Synopsys DWC Ethernet QOS device support for Qcom SoCs"
 	depends on DWC_ETH_QOS
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index c485068e5d2..761f7f0f451 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
 obj-$(CONFIG_DWC_ETH_QOS_ADI) += dwc_eth_qos_adi.o
 obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
 obj-$(CONFIG_DWC_ETH_QOS_INTEL) += dwc_eth_qos_intel.o
+obj-$(CONFIG_DWC_ETH_QOS_MTK) += dwc_eth_qos_mtk.o
 obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
 obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 0f31d646845..b7e6299c307 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1658,6 +1658,12 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "adi,sc59x-dwmac-eqos",
 		.data = (ulong)&eqos_adi_config
 	},
+#endif
+#if IS_ENABLED(CONFIG_DWC_ETH_QOS_MTK)
+	{
+		.compatible = "mediatek,mt8189-gmac",
+		.data = (ulong)&eqos_mtk_config
+	},
 #endif
 	{ }
 };
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ba16f1a37cb..978b848b46e 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -97,6 +97,7 @@ struct eqos_mac_regs {
 #define EQOS_MAC_MDIO_ADDRESS_PA_MASK			GENMASK(25, 21)
 #define EQOS_MAC_MDIO_ADDRESS_RDA_MASK			GENMASK(20, 16)
 #define EQOS_MAC_MDIO_ADDRESS_CR_MASK			GENMASK(11, 8)
+#define EQOS_MAC_MDIO_ADDRESS_CR_60_100			0
 #define EQOS_MAC_MDIO_ADDRESS_CR_100_150		1
 #define EQOS_MAC_MDIO_ADDRESS_CR_20_35			2
 #define EQOS_MAC_MDIO_ADDRESS_CR_150_250		4
@@ -316,3 +317,4 @@ extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_stm32mp25_config;
 extern struct eqos_config eqos_jh7110_config;
 extern struct eqos_config eqos_adi_config;
+extern struct eqos_config eqos_mtk_config;
diff --git a/drivers/net/dwc_eth_qos_mtk.c b/drivers/net/dwc_eth_qos_mtk.c
new file mode 100644
index 00000000000..275f1f2cf15
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_mtk.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <net.h>
+#include <phy.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include "dwc_eth_qos.h"
+
+/*
+ * Peri Configuration register is SoC specific,
+ * so add a SoC specific prefix.
+ */
+#define MT8189_PERI_ETH_CTRL0		0x270
+#define MT8189_PERI_ETH_CTRL1		0x274
+#define MT8189_PERI_ETH_CTRL2		0x278
+
+#define EQOS_MTK_RMII_CLK_SRC_INTERNAL	BIT(28)
+#define EQOS_MTK_RMII_CLK_SRC_RXC	BIT(27)
+#define EQOS_MTK_ETH_INTF_SEL		GENMASK(26, 24)
+#define EQOS_MTK_PHY_INTF_MII		0
+#define EQOS_MTK_PHY_INTF_RGMII		1
+#define EQOS_MTK_PHY_INTF_RMII		4
+#define EQOS_MTK_RGMII_TXC_PHASE_CTRL	BIT(22)
+#define EQOS_MTK_EXT_PHY_MODE		BIT(21)
+#define EQOS_MTK_TXC_OUT_OP		BIT(20)
+#define EQOS_MTK_DLY_GTXC_INV		BIT(12)
+#define EQOS_MTK_DLY_GTXC_STAGE_FINE	GENMASK(11, 6)
+#define EQOS_MTK_DLY_GTXC_ENABLE	BIT(5)
+#define EQOS_MTK_DLY_GTXC_STAGES	GENMASK(4, 0)
+
+#define EQOS_MTK_DLY_RXC_INV		BIT(25)
+#define EQOS_MTK_DLY_RXC_ENABLE		BIT(18)
+#define EQOS_MTK_DLY_RXC_STAGES		GENMASK(17, 13)
+#define EQOS_MTK_DLY_TXC_INV		BIT(12)
+#define EQOS_MTK_DLY_TXC_ENABLE		BIT(5)
+#define EQOS_MTK_DLY_TXC_STAGES		GENMASK(4, 0)
+
+#define EQOS_MTK_DLY_RMII_RXC_INV	BIT(25)
+#define EQOS_MTK_DLY_RMII_RXC_ENABLE	BIT(18)
+#define EQOS_MTK_DLY_RMII_RXC_STAGES	GENMASK(17, 13)
+#define EQOS_MTK_DLY_RMII_TXC_INV	BIT(12)
+#define EQOS_MTK_DLY_RMII_TXC_ENABLE	BIT(5)
+#define EQOS_MTK_DLY_RMII_TXC_STAGES	GENMASK(4, 0)
+
+#define RX_DELAY_MAX_PS			9800
+#define TX_DELAY_MAX_PS			9800
+
+#define OUT_OP				true
+
+struct eqos_mtk_priv {
+	struct regmap *peri_regmap;
+	bool rmii_clk_from_mac;
+	bool rmii_rxc;
+	u32 tx_delay_ps_per_stage;
+	u32 rx_delay_ps_per_stage;
+	bool tx_inv;
+	bool rx_inv;
+};
+
+static int mtk_clk_init(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_by_name(dev, "mac_main", &eqos->clk_tx);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(mac_main) failed: %d", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "ptp_ref", &eqos->clk_ptp_ref);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(ptp_ref) failed: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mtk_set_delay(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
+
+	switch (pdata->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_ENABLE,
+					!!mtk_pdata->tx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_STAGES, mtk_pdata->tx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_INV, mtk_pdata->tx_inv);
+
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_ENABLE,
+					!!mtk_pdata->rx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_STAGES, mtk_pdata->rx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_INV, mtk_pdata->rx_inv);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		if (mtk_pdata->rmii_clk_from_mac) {
+			/* case 1: mac provides the rmii reference clock,
+			 * and the clock output to TXC pin.
+			 * The egress timing can be adjusted by RMII_TXC delay macro circuit.
+			 * The ingress timing can be adjusted by RMII_RXC delay macro circuit.
+			 */
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_TXC_ENABLE,
+						     !!mtk_pdata->tx_delay_ps_per_stage);
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_TXC_STAGES,
+						     mtk_pdata->tx_delay_ps_per_stage);
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_TXC_INV,
+						     mtk_pdata->tx_inv);
+
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_RXC_ENABLE,
+						     !!mtk_pdata->rx_delay_ps_per_stage);
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_RXC_STAGES,
+						     mtk_pdata->rx_delay_ps_per_stage);
+			rmii_delay_val |= FIELD_PREP(EQOS_MTK_DLY_RMII_RXC_INV,
+						     mtk_pdata->rx_inv);
+		} else {
+			/* case 2: the rmii reference clock is from external phy,
+			 * and the property "rmii_rxc" indicates which pin(TXC/RXC)
+			 * the reference clk is connected to. The reference clock is a
+			 * received signal, so rx_delay_ps_per_stage/rx_inv are used to indicate
+			 * the reference clock timing adjustment
+			 */
+			if (mtk_pdata->rmii_rxc) {
+				/* the rmii reference clock from outside is connected
+				 * to RXC pin, the reference clock will be adjusted
+				 * by RXC delay macro circuit.
+				 */
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_ENABLE,
+							!!mtk_pdata->rx_delay_ps_per_stage);
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_STAGES,
+							mtk_pdata->rx_delay_ps_per_stage);
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_INV,
+							mtk_pdata->rx_inv);
+			} else {
+				/* the rmii reference clock from outside is connected
+				 * to TXC pin, the reference clock will be adjusted
+				 * by TXC delay macro circuit.
+				 */
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_ENABLE,
+							!!mtk_pdata->rx_delay_ps_per_stage);
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_STAGES,
+							mtk_pdata->rx_delay_ps_per_stage);
+				delay_val |= FIELD_PREP(EQOS_MTK_DLY_TXC_INV,
+							mtk_pdata->rx_inv);
+			}
+		}
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		gtxc_delay_val |= FIELD_PREP(EQOS_MTK_DLY_GTXC_ENABLE,
+					     !!mtk_pdata->tx_delay_ps_per_stage);
+		gtxc_delay_val |= FIELD_PREP(EQOS_MTK_DLY_GTXC_STAGES,
+					     mtk_pdata->tx_delay_ps_per_stage);
+		gtxc_delay_val |= FIELD_PREP(EQOS_MTK_DLY_GTXC_INV, mtk_pdata->tx_inv);
+		gtxc_delay_val |= EQOS_MTK_DLY_GTXC_STAGE_FINE;
+
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_ENABLE,
+					!!mtk_pdata->rx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_STAGES, mtk_pdata->rx_delay_ps_per_stage);
+		delay_val |= FIELD_PREP(EQOS_MTK_DLY_RXC_INV, mtk_pdata->rx_inv);
+
+		break;
+	default:
+		pr_err("%s: dev=%p phy interface not supported\n", __func__, dev);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(mtk_pdata->peri_regmap,
+			   MT8189_PERI_ETH_CTRL0,
+			   EQOS_MTK_RGMII_TXC_PHASE_CTRL |
+			   EQOS_MTK_DLY_GTXC_ENABLE |
+			   EQOS_MTK_DLY_GTXC_INV |
+			   EQOS_MTK_DLY_GTXC_STAGE_FINE |
+			   EQOS_MTK_DLY_GTXC_STAGES,
+			   gtxc_delay_val);
+	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL1, delay_val);
+	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL2, rmii_delay_val);
+
+	return 0;
+}
+
+static int mtk_set_interface(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+	int rmii_clk_from_mac = mtk_pdata->rmii_clk_from_mac ? EQOS_MTK_RMII_CLK_SRC_INTERNAL : 0;
+	int rmii_rxc = mtk_pdata->rmii_rxc ? EQOS_MTK_RMII_CLK_SRC_RXC : 0;
+	u32 intf_val = 0;
+
+	/* select phy interface in top control domain */
+	switch (pdata->phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_MII);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		intf_val |= (rmii_rxc | rmii_clk_from_mac);
+		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_RMII);
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		intf_val |= FIELD_PREP(EQOS_MTK_ETH_INTF_SEL, EQOS_MTK_PHY_INTF_RGMII);
+		break;
+	default:
+		pr_err("%s: dev=%p phy interface not supported\n", __func__, dev);
+		return -EINVAL;
+	}
+
+	/* only support external PHY */
+	intf_val |= EQOS_MTK_EXT_PHY_MODE;
+	if (OUT_OP)
+		intf_val |= EQOS_MTK_TXC_OUT_OP;
+
+	regmap_write(mtk_pdata->peri_regmap, MT8189_PERI_ETH_CTRL0, intf_val);
+
+	return 0;
+}
+
+static int mtk_config_dt(struct udevice *dev)
+{	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+	struct ofnode_phandle_args args;
+	u32 tx_delay_ps, rx_delay_ps;
+	int ret;
+
+	if (!dev_read_u32(dev, "mediatek,tx-delay-ps", &tx_delay_ps)) {
+		if (tx_delay_ps > TX_DELAY_MAX_PS) {
+			pr_err("%s: dev=%p Invalid TX clock delay: %dps\n",
+			       __func__, dev, tx_delay_ps);
+			return -EINVAL;
+		}
+	}
+
+	if (!dev_read_u32(dev, "mediatek,rx-delay-ps", &rx_delay_ps)) {
+		if (rx_delay_ps > RX_DELAY_MAX_PS) {
+			pr_err("%s: dev=%p Invalid RX clock delay: %dps\n",
+			       __func__, dev, rx_delay_ps);
+			return -EINVAL;
+		}
+	}
+
+	/* 290ps per stage */
+	mtk_pdata->tx_delay_ps_per_stage = tx_delay_ps / 290;
+	mtk_pdata->rx_delay_ps_per_stage = rx_delay_ps / 290;
+
+	mtk_pdata->tx_inv = dev_read_bool(dev, "mediatek,txc-inverse");
+	mtk_pdata->rx_inv = dev_read_bool(dev, "mediatek,rxc-inverse");
+	mtk_pdata->rmii_clk_from_mac = dev_read_bool(dev, "mediatek,rmii-clk-from-mac");
+	mtk_pdata->rmii_rxc = dev_read_bool(dev, "mediatek,rmii-rxc");
+
+	ret = dev_read_phandle_with_args(dev, "mediatek,pericfg", NULL, 0, 0, &args);
+	if (ret) {
+		pr_err("Failed to get mediatek,pericfg property: %d\n", ret);
+		return ret;
+	}
+
+	mtk_pdata->peri_regmap = syscon_node_to_regmap(args.node);
+	if (IS_ERR(mtk_pdata->peri_regmap)) {
+		pr_err("%s: dev=%p Invalid perif_cfg reg\n", __func__, dev);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int eqos_probe_resources_mtk(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata;
+	int ret;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		dev_err(dev, "eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	mtk_pdata = calloc(1, sizeof(struct eqos_mtk_priv));
+	if (!mtk_pdata)
+		return -ENOMEM;
+
+	pdata->priv_pdata = mtk_pdata;
+
+	ret = mtk_config_dt(dev);
+	if (ret) {
+		dev_err(dev, "mtk config dt failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = mtk_clk_init(dev);
+	if (ret)
+		goto err;
+
+	pdata->phy_interface = eqos->config->interface(dev);
+	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
+		dev_err(dev, "Invalid PHY interface\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = mtk_set_interface(dev);
+	if (ret)
+		goto err;
+
+	ret = mtk_set_delay(dev);
+	if (ret)
+		goto err;
+
+	debug("%s: OK\n", __func__);
+	return 0;
+err:
+	free(mtk_pdata);
+	return ret;
+}
+
+static int eqos_remove_resources_mtk(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	free(mtk_pdata);
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_stop_clks_mtk(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	clk_disable(&eqos->clk_ptp_ref);
+	clk_disable(&eqos->clk_tx);
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_start_clks_mtk(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	int ret;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	ret = clk_enable(&eqos->clk_tx);
+	if (ret < 0) {
+		pr_err("clk_enable(mac_main) failed: %d", ret);
+		goto err;
+	}
+
+	ret = clk_enable(&eqos->clk_ptp_ref);
+	if (ret < 0) {
+		pr_err("clk_enable(ptp_ref) failed: %d", ret);
+		goto err_disable_clk_mac_main;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+
+err_disable_clk_mac_main:
+	clk_disable(&eqos->clk_tx);
+err:
+	debug("%s: FAILED: %d\n", __func__, ret);
+	return ret;
+}
+
+static int eqos_fix_mac_speed_mtk(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eqos_mtk_priv *mtk_pdata = pdata->priv_pdata;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	switch (pdata->phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		if (eqos->phy->speed == SPEED_1000)
+			regmap_update_bits(mtk_pdata->peri_regmap,
+					   MT8189_PERI_ETH_CTRL0,
+					   EQOS_MTK_RGMII_TXC_PHASE_CTRL |
+					   EQOS_MTK_DLY_GTXC_ENABLE |
+					   EQOS_MTK_DLY_GTXC_INV |
+					   EQOS_MTK_DLY_GTXC_STAGE_FINE |
+					   EQOS_MTK_DLY_GTXC_STAGES,
+					   EQOS_MTK_RGMII_TXC_PHASE_CTRL);
+		else
+			mtk_set_delay(dev);
+		break;
+	default:
+		debug("%s: dev=%p no need to adjust mac delay\n", __func__, dev);
+		break;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static struct eqos_ops eqos_mtk_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_mtk,
+	.eqos_remove_resources = eqos_remove_resources_mtk,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_null_ops,
+	.eqos_stop_clks = eqos_stop_clks_mtk,
+	.eqos_start_clks = eqos_start_clks_mtk,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_fix_mac_speed_mtk,
+	.eqos_get_enetaddr = eqos_null_ops,
+};
+
+struct eqos_config eqos_mtk_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10000,
+	.swr_wait = 10,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_60_100,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_mtk_ops
+};

-- 
2.52.0

