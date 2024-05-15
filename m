Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCFDC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9DF8832D;
	Wed, 15 May 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="owHZBB6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5378833B; Wed, 15 May 2024 23:59:34 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134D988335
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-61be4b9869dso78019197b3.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810371; x=1716415171;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9mEqXILaCXFuSCORiwgHJL2CvNohtEGSS/JZEMslBE=;
 b=owHZBB6gyVDtZaHd7np2+oKUyfBT0EDqDI8ggR8+i6ZvNsEX362QUyDEgcbjhQszCV
 2xmrmHFqqOeg+MSvrtBPiUdYKRZRMfllrg4o283mlkHK0yx5HoNxtKR+dMZjFcHAQefV
 gpJn7k7VrUpvKYb1qQYjDjUT1x3/YovfwVsLrGRpnAmsqllj7s0RY01udK+MSyGjUtFM
 hHEEqO55kC+dc6p/r3A0PtXWNWoGMVdz16pZjIqG4MSHOsqHH/CPJivOLj2U5yZ/qpsI
 Mzf1OrLpFJbx7N1qEaHqTnrFl1fzJzfAZ/r/1dCbGt6jgI2GUHdaNe+xnFVWJ3vUSXHW
 Eblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810371; x=1716415171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9mEqXILaCXFuSCORiwgHJL2CvNohtEGSS/JZEMslBE=;
 b=CoJb7cFRQL8T+vfrDUk9hsl06VY/jO71xkgKFVKPl/W9DPpNbBiNCt3pltZ/u6gpXB
 9LkVQmO10jPP1fr8Y6gf3J3VpOX6dSzC1eGLIZckpHZwEr5ad6GHsDLLv/H0uBw6anCi
 CYXDNNDNDh8IcHoxZfffEVgruomtoiOejpM8e779dpSYDWqliChOjYGdRu4GQxrRugis
 L4t+cuMG8AIdTrhSkv9d/748SinPKU0Z2oS8xjD9OAfuAzXzAaXTHhQrbW/Bo8m79Jfr
 2k9+Rp8UwXJcb1rlkyJ+KB3rRePuTrgnlRoeYTCy/glC2WxlaIFLuJDWCY8AkfK9fMIZ
 s4aA==
X-Gm-Message-State: AOJu0Yw4Lvmj55gzA5UeQ9WZH+pMPT1nUdp4tj93n/qE49D/krZm/Pu+
 MuJwDHwAIETfdpsdSyY9cUh+23OS4ZWoIcP2XGe8Y3v+3CSyV8upQcP3KWR9aoL7ePfY8r2BKD4
 4Vw==
X-Google-Smtp-Source: AGHT+IHb4W3m+7NX018kXKl3MdD46MZsQ+P6QN+6FjipPMA/8AWDFyW6X579XsWXbbhjX0MIhEMNfg==
X-Received: by 2002:a0d:d895:0:b0:61a:b474:1c4b with SMTP id
 00721157ae682-622b013a8d3mr164204467b3.46.1715810370787; 
 Wed, 15 May 2024 14:59:30 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:30 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 06/11] net: Add support for ADI SC5xx SoCs with DWC QoS
 ethernet
Date: Wed, 15 May 2024 17:57:43 -0400
Message-ID: <20240515215837.14028-7-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
---

 MAINTAINERS                   |   1 +
 drivers/net/Kconfig           |   7 +++
 drivers/net/Makefile          |   1 +
 drivers/net/dwc_eth_qos.c     |   6 ++
 drivers/net/dwc_eth_qos.h     |   2 +
 drivers/net/dwc_eth_qos_adi.c | 101 ++++++++++++++++++++++++++++++++++
 6 files changed, 118 insertions(+)
 create mode 100644 drivers/net/dwc_eth_qos_adi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 977233451e..c1685f0352 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -613,6 +613,7 @@ F:	drivers/clk/adi/
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
+F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b4ff033afa..9ae471e371 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -236,6 +236,13 @@ config DWC_ETH_QOS
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
index dce71685c3..612f5644f3 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DM_ETH_PHY) += eth-phy-uclass.o
 obj-$(CONFIG_DRIVER_DM9000) += dm9000x.o
 obj-$(CONFIG_DSA_SANDBOX) += dsa_sandbox.o
 obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
+obj-$(CONFIG_DWC_ETH_QOS_ADI) += dwc_eth_qos_adi.o
 obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
 obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 67ac86f82b..10528368ca 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1544,6 +1544,12 @@ static const struct udevice_id eqos_ids[] = {
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
index 8b3d0d464d..1b28f2a056 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -84,6 +84,7 @@ struct eqos_mac_regs {
 #define EQOS_MAC_MDIO_ADDRESS_CR_SHIFT			8
 #define EQOS_MAC_MDIO_ADDRESS_CR_100_150		1
 #define EQOS_MAC_MDIO_ADDRESS_CR_20_35			2
+#define EQOS_MAC_MDIO_ADDRESS_CR_150_250		4
 #define EQOS_MAC_MDIO_ADDRESS_CR_250_300		5
 #define EQOS_MAC_MDIO_ADDRESS_SKAP			BIT(4)
 #define EQOS_MAC_MDIO_ADDRESS_GOC_SHIFT			2
@@ -293,3 +294,4 @@ extern struct eqos_config eqos_qcom_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_jh7110_config;
+extern struct eqos_config eqos_adi_config;
diff --git a/drivers/net/dwc_eth_qos_adi.c b/drivers/net/dwc_eth_qos_adi.c
new file mode 100644
index 0000000000..8e770c0dcb
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_adi.c
@@ -0,0 +1,101 @@
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
+#include <asm/io.h>
+
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+
+#include "dwc_eth_qos.h"
+
+static int eqos_start_resets_adi(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	u32 val;
+
+	/*
+	 * Settings need to latch with the DMA reset below. Currently only
+	 * rgmii is supported but other phy interfaces may be supported in
+	 * the future
+	 */
+	sc5xx_enable_rgmii();
+
+	val = readl(&eqos->dma_regs->mode);
+	val |= EQOS_DMA_MODE_SWR;
+	writel(val, &eqos->dma_regs->mode);
+
+	return 0;
+}
+
+static int eqos_probe_resources_adi(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface;
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
+// @todo read mdio_wait from device tree
+// @todo read swr_wait from device tree
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
2.43.2

