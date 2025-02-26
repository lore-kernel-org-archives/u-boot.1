Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8729EC021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B15C81197;
	Wed, 26 Feb 2025 18:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UY7f1TE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945AC80FF0; Wed, 26 Feb 2025 18:33:07 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AC280F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5ddd781316so5844983276.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591183; x=1741195983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVgQXd2q8Ztw8B7CBSnL0C+p9i5lKjDjorYh14BoM/o=;
 b=UY7f1TE5Mhfca6k6EaM1YULIesugJNaX5DZo9bN6SAJvrybtj2uCmRs8vco34pTR4p
 85pt52aefIxZ8wo8VlUje40foylJznshkg2mxMFYOr0ExWOZZ7QBCh3FSEJ9gSJYnfuy
 xcOCiUFxDi1yZ1WfQ4BK1HiiI3TiwRDi2bO+A7ZlWW5B1tXxX3hdbLL2UFLCB/RZ1DNH
 AN89vSwIcY/52JQ7kzoo65M3AlADmXJNH9MmDaVNKgzQ90cf3VOGv1P/iYo0fftkKpc2
 O2+keIEyl7ybyRuUWnQmfXBKWcddBb9kQa089FEMfEzpMOplxaG2mrtNC6Ax9WUYw+u3
 YEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591183; x=1741195983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVgQXd2q8Ztw8B7CBSnL0C+p9i5lKjDjorYh14BoM/o=;
 b=OaGCaTgf4s5zGBqqY3xoThu/Q+BMruUNlFwpQFRJIGppU6mgiByOpJCATPKvHANUEY
 pJNC12tKjK+JhS0bCEBkbRtvENtZVx6DtKKKRHxSMwdrxq3i3pBxuff6+pr4kke1rqWJ
 kakVJtj6ROJK7gb5/NTUUPQdeXdIoYLei457ndqTOKVWF7OQ6NdEfYn2d8wOS4JeZK/A
 fwIHWXCGuFhGy9xjj9OMCnvfTytNZUEgw0Yzg0TxB/eyOIWFqXd0WOmJERuN+Dxe5eTF
 SyaQCwgA4VqSM9Sjaexjah1cTEFDNg0RMqphZ10h50as0mzL2nPE0KqCp9T9ZH7NB7Tb
 8oRQ==
X-Gm-Message-State: AOJu0YzkFmtpLsbv2CdmHwKSulmcKveuWyWGpC7JhG9Vq1NMB5PhYbcG
 sfYIEpwFizuh58xl9ucswe+VX5UmyCSJACMu7bMiwpHI25dr/0JX3J5NgOI=
X-Gm-Gg: ASbGncuLldAdypAjbeZQv/Y1fOgq+5L2dvnZoKe09vKWAcT0FUfKS0ZDIEQqzxviyzL
 YfvdjQYOr9qQ+vA/7+XIYo+CX2VlDjo/2UWArelo1N2Ombf2sG07pW1T8nw/gWnhisbO1XqMIWF
 uXSveah/HZx57MP5Wev9Y4gWuSzWiuFlkadZ5K3lFKe4aE7DwP3kYnrjtJsa8msQEnsmVMHb2Gk
 Hq9y/57ngiUCcYi59Ccu3hqz+ntZlob7ShFGfbNfSO7E490QfKkioYuM4O/2wvG1eTKf3pFOa6X
 YY21hsm2g3EIFbq6s4LQIXNPeU9gIJAioZmv09oNEw==
X-Google-Smtp-Source: AGHT+IFtbfBiye4i5knQOSEMGmVAkMwhrut8AFRVi3eDb3GZbNcrB5wRsrHP5gbwLl20OQjBBOynHQ==
X-Received: by 2002:a05:6902:2e0b:b0:e58:aa00:ffe0 with SMTP id
 3f1490d57ef6-e5e8359551emr16838884276.5.1740591183514; 
 Wed, 26 Feb 2025 09:33:03 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:03 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Erik Schumacher <erik.schumacher@iris-sensing.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Greg Malysa <greg.malysa@timesys.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 07/12] net: Add support for ADI SC5xx SoCs with DWC QoS
 ethernet
Date: Wed, 26 Feb 2025 12:30:29 -0500
Message-ID: <20250226173150.13198-8-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

The ADI SC598 includes a Designware QoS 5.20a IP block. This
commit adds support for using the existing ethernet QoS driver
with the SC598 SoC.

Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v3:
- replace readl/writel with ioread32 and iowrite32 and friends
- update for compatibility with changes to dwc qos driver between 2024.04 and 2025.01

 MAINTAINERS                   |   1 +
 drivers/net/Kconfig           |   7 +++
 drivers/net/Makefile          |   1 +
 drivers/net/dwc_eth_qos.c     |   6 ++
 drivers/net/dwc_eth_qos.h     |   2 +
 drivers/net/dwc_eth_qos_adi.c | 103 ++++++++++++++++++++++++++++++++++
 6 files changed, 120 insertions(+)
 create mode 100644 drivers/net/dwc_eth_qos_adi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f2638becc32..2c4dc8b14c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -635,6 +635,7 @@ F:	drivers/clk/adi/
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
+F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1563404ca17..8dc5f4810e9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -237,6 +237,13 @@ config DWC_ETH_QOS
 	  Of Service) IP block. The IP supports many options for bus type,
 	  clocking/reset structure, and feature list.
 
+config DWC_ETH_QOS_ADI
+	bool "Synopsys DWC Ethernet QOS device support for ADI SC59x-64 parts"
+	depends on DWC_ETH_QOS
+	help
+		The Synopsis Designware Ethernet QoS IP block with the specific
+		configuration used in the ADI ADSP-SC59X 64 bit SoCs
+
 config DWC_ETH_QOS_IMX
 	bool "Synopsys DWC Ethernet QOS device support for IMX"
 	depends on DWC_ETH_QOS
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 80d70212971..d919d437c08 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DM_ETH_PHY) += eth-phy-uclass.o
 obj-$(CONFIG_DRIVER_DM9000) += dm9000x.o
 obj-$(CONFIG_DSA_SANDBOX) += dsa_sandbox.o
 obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
+obj-$(CONFIG_DWC_ETH_QOS_ADI) += dwc_eth_qos_adi.o
 obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
 obj-$(CONFIG_DWC_ETH_QOS_INTEL) += dwc_eth_qos_intel.o
 obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 2279481d935..b4ec3614696 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1631,6 +1631,12 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "starfive,jh7110-dwmac",
 		.data = (ulong)&eqos_jh7110_config
 	},
+#endif
+#if IS_ENABLED(CONFIG_DWC_ETH_QOS_ADI)
+	{
+		.compatible = "adi,sc59x-dwmac-eqos",
+		.data = (ulong)&eqos_adi_config
+	},
 #endif
 	{ }
 };
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index 123f98d5d53..403e8203974 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -87,6 +87,7 @@ struct eqos_mac_regs {
 #define EQOS_MAC_MDIO_ADDRESS_CR_MASK			GENMASK(11, 8)
 #define EQOS_MAC_MDIO_ADDRESS_CR_100_150		1
 #define EQOS_MAC_MDIO_ADDRESS_CR_20_35			2
+#define EQOS_MAC_MDIO_ADDRESS_CR_150_250		4
 #define EQOS_MAC_MDIO_ADDRESS_CR_250_300		5
 #define EQOS_MAC_MDIO_ADDRESS_SKAP			BIT(4)
 #define EQOS_MAC_MDIO_ADDRESS_GOC_MASK			GENMASK(3, 2)
@@ -301,3 +302,4 @@ extern struct eqos_config eqos_qcom_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_jh7110_config;
+extern struct eqos_config eqos_adi_config;
diff --git a/drivers/net/dwc_eth_qos_adi.c b/drivers/net/dwc_eth_qos_adi.c
new file mode 100644
index 00000000000..0e6a901e303
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_adi.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <net.h>
+#include <phy.h>
+#include <reset.h>
+#include <linux/io.h>
+
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+
+#include "dwc_eth_qos.h"
+
+static int eqos_start_resets_adi(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	/*
+	 * Settings need to latch with the DMA reset below. Currently only
+	 * rgmii is supported but other phy interfaces may be supported in
+	 * the future
+	 */
+	sc5xx_enable_rgmii();
+	setbits_32(&eqos->dma_regs->mode, EQOS_DMA_MODE_SWR);
+
+	return 0;
+}
+
+static int eqos_probe_resources_adi(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface;
+	int ret;
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	interface = eqos->config->interface(dev);
+	if (interface == PHY_INTERFACE_MODE_NA) {
+		pr_err("Invalid PHY interface\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rgmii tx clock rate is set to 125 MHz regardless of phy mode, and
+ * by default the internal clock is always connected to 125 MHz. According
+ * to the HRM it is invalid for this clock to have any other speed, so
+ * the hardware won't work anyway if this is wrong.
+ */
+static ulong eqos_get_tick_clk_rate_adi(struct udevice *dev)
+{
+	return 125 * 1000000;
+}
+
+static int eqos_get_enetaddr_adi(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+
+	return eth_env_get_enetaddr("ethaddr", pdata->enetaddr);
+}
+
+static struct eqos_ops eqos_adi_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_adi,
+	.eqos_remove_resources = eqos_null_ops,
+	.eqos_start_resets = eqos_start_resets_adi,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_clks = eqos_null_ops,
+	.eqos_stop_clks = eqos_null_ops,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_null_ops,
+	.eqos_get_enetaddr = eqos_get_enetaddr_adi,
+	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_adi,
+};
+
+struct eqos_config __maybe_unused eqos_adi_config = {
+	.reg_access_always_ok = true,
+	.mdio_wait =  20,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_150_250,
+	.axi_bus_width = EQOS_AXI_WIDTH_32,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_adi_ops,
+};
-- 
2.45.2

