Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF26C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9DA886A6;
	Fri, 19 Apr 2024 08:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PY0o3czR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A33B88699; Fri, 19 Apr 2024 08:51:35 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8767B8862B
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713509489; x=1716101489;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xvFYbU+B8c1h+9oF4ppxVF8aC9s+rCECSgX5NsnIdcQ=;
 b=PY0o3czRJw2XfLTifn7Ti81xyQt8b9xYcWDnz81jl268g58Wd8Xd+wLwyaEoiMcx
 GrsolLWK6x4oluezEDs4zeyIh9WXVr/ZTU8stjX5FLnud9Gf7dNXgaXrB+7k1kSS
 EbLeyPzKnn1Vcrqh3beAIkm9tnyOmxB84ilcwNpYRqk=;
X-AuditID: ac14000a-fbefe7000000290d-77-6622147166e0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8B.95.10509.17412266;
 Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 08:51:28 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 2/3] phycore-am64x: Migrate to OF_UPSTREAM
Date: Fri, 19 Apr 2024 08:51:16 +0200
Message-ID: <20240419065117.2305346-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419065117.2305346-1-w.egorov@phytec.de>
References: <20240419065117.2305346-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRpKBR7dQRCnNoPU8l8XbvZ3sFt3v1B2Y
 PM7e2cHo0d/dwhrAFMVlk5Kak1mWWqRvl8CVcaenga2gdyljxfm1qQ2MV9sZuxg5OSQETCR+
 rj3G1sXIxSEksIRJYtOiyUwQzmNGiXcNr1lAqtgE1CXubPjGCmKLCEhJvOzcyNzFyMHBLCAn
 say/CCQsLGAlcfDkGjYQm0VAVaL3+AFmEJtXwFJi95q17BDL5CVmXvoOZnMC1b99uQysRgio
 ZvqMRkaIekGJkzOfgK1lBqpv3jqbGcKWkDj44gVUvbzEi0vLWWBmTjv3mhnCDpXY+mU70wRG
 oVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgQFsAgD1w7GvjkehxiZOBgP
 MUpwMCuJ8JpxKKYJ8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpakFoEk2Xi
 4JRqYEwLvGXWqn/o9tu1q/5FnviZ1srkqlbpOnHt+VyVeZ/+z178SWB/p4Tp5CtFnw7KJZ5d
 mSqjdeS//6vPEUyVu2bfitjVPtO+wc0g8Fd364JjfLcL2PuO6jHWf9q5Rujth06TTSFtKtWT
 M2713VzT3RbrP/X2wperqkQKJgqqr10q0dXfLvH2VJgSS3FGoqEWc1FxIgD5CXrHTgIAAA==
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

The phycore-am64x can be migrated to OF_UPSTREAM.
Drop redundant device tree files, update MAINTAINERS and
defconfig's DEFAULT_DEVICE_TREE for ti vendor prefix accordingly.
While at it, drop the redundant definitions of AM642_PHYBOARD_ELECTRA_DTB
& SPL_AM642_PHYBOARD_ELECTRA_DTB from the binman dtsi file.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/k3-am64-phycore-som.dtsi         | 320 ------------------
 .../arm/dts/k3-am642-phyboard-electra-rdk.dts | 302 -----------------
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |   6 +-
 arch/arm/mach-k3/am64x/Kconfig                |   1 +
 board/phytec/phycore_am64x/MAINTAINERS        |   2 -
 configs/phycore_am64x_a53_defconfig           |   2 +-
 7 files changed, 3 insertions(+), 631 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am64-phycore-som.dtsi
 delete mode 100644 arch/arm/dts/k3-am642-phyboard-electra-rdk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3646c64d05..48a2b85542 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1346,7 +1346,6 @@ dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-r5-sk.dtb \
 
 dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-r5-evm.dtb \
 			      k3-am642-r5-sk.dtb \
-			      k3-am642-phyboard-electra-rdk.dtb \
 			      k3-am642-r5-phycore-som-2gb.dtb
 
 dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
diff --git a/arch/arm/dts/k3-am64-phycore-som.dtsi b/arch/arm/dts/k3-am64-phycore-som.dtsi
deleted file mode 100644
index 1678e74cb7..0000000000
--- a/arch/arm/dts/k3-am64-phycore-som.dtsi
+++ /dev/null
@@ -1,320 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
- * Author: Matt McKee <mmckee@phytec.com>
- *
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
- *
- * Product homepage:
- * https://www.phytec.com/product/phycore-am64x
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	model = "PHYTEC phyCORE-AM64x";
-	compatible = "phytec,am64-phycore-som", "ti,am642";
-
-	aliases {
-		ethernet0 = &cpsw_port1;
-		mmc0 = &sdhci0;
-		rtc0 = &i2c_som_rtc;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-
-	reserved_memory: reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>;
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			function = LED_FUNCTION_HEARTBEAT;
-		};
-	};
-
-	vcc_5v0_som: regulator-vcc-5v0-som {
-		/* VIN / VCC_5V0_SOM */
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_5V0_SOM";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&main_pmx0 {
-	cpsw_mdio_pins_default: cpsw-mdio-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)	/* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
-			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)	/* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
-			AM64X_IOPAD(0x0100, PIN_OUTPUT, 7)	/* (V7) PRG1_PRU0_GPO18.GPIO0_63 */
-		>;
-	};
-
-	cpsw_rgmii1_pins_default: cpsw-rgmii1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0184, PIN_INPUT, 4)	/* (W6) PRG0_PRU0_GPO9.RGMII1_RX_CTL */
-			AM64X_IOPAD(0x0188, PIN_INPUT, 4)	/* (AA5) PRG0_PRU0_GPO10.RGMII1_RXC */
-			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)	/* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
-			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4)	/* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
-			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)	/* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
-			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)	/* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
-			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)	/* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
-			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)	/* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
-			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)	/* (V6) PRG0_PRU1_GPO10.RGMII1_RD2 */
-			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)	/* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
-			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)	/* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
-			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)	/* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
-			AM64X_IOPAD(0x0154, PIN_INPUT, 7)	/* (V12) PRG1_PRU1_GPO19.GPIO0_84 */
-		>;
-	};
-
-	eeprom_wp_pins_default: eeprom-wp-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0208, PIN_OUTPUT, 7)	/* (D12) SPI0_CS0.GPIO1_42 */
-		>;
-	};
-
-	leds_pins_default: leds-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* (L18) OSPI0_CSn1.GPIO0_12 */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* (A18) I2C0_SCL */
-			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* (B18) I2C0_SDA */
-		>;
-	};
-
-	ospi0_pins_default: ospi0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)	/* (N20) OSPI0_CLK */
-			AM64X_IOPAD(0x0008, PIN_INPUT, 0)	/* (N19) OSPI0_DQS */
-			AM64X_IOPAD(0x000c, PIN_INPUT, 0)	/* (M19) OSPI0_D0 */
-			AM64X_IOPAD(0x0010, PIN_INPUT, 0)	/* (M18) OSPI0_D1 */
-			AM64X_IOPAD(0x0014, PIN_INPUT, 0)	/* (M20) OSPI0_D2 */
-			AM64X_IOPAD(0x0018, PIN_INPUT, 0)	/* (M21) OSPI0_D3 */
-			AM64X_IOPAD(0x001c, PIN_INPUT, 0)	/* (P21) OSPI0_D4 */
-			AM64X_IOPAD(0x0020, PIN_INPUT, 0)	/* (P20) OSPI0_D5 */
-			AM64X_IOPAD(0x0024, PIN_INPUT, 0)	/* (N18) OSPI0_D6 */
-			AM64X_IOPAD(0x0028, PIN_INPUT, 0)	/* (M17) OSPI0_D7 */
-			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)	/* (L19) OSPI0_CSn0 */
-		>;
-	};
-
-	rtc_pins_default: rtc-defaults-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* (C19) EXTINTn.GPIO1_70 */
-		>;
-	};
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cpsw_rgmii1_pins_default>;
-};
-
-&cpsw3g_mdio {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cpsw_mdio_pins_default>;
-
-	cpsw3g_phy1: ethernet-phy@1 {
-		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-		interrupt-parent = <&main_gpio0>;
-		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		reset-gpios = <&main_gpio0 63 GPIO_ACTIVE_LOW>;
-		reset-assert-us = <1000>;
-		reset-deassert-us = <1000>;
-	};
-};
-
-&cpsw_port1 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy1>;
-};
-
-&cpsw_port2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&main_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	eeprom@50 {
-		compatible = "atmel,24c32";
-		pinctrl-names = "default";
-		pinctrl-0 = <&eeprom_wp_pins_default>;
-		pagesize = <32>;
-		reg = <0x50>;
-	};
-
-	i2c_som_rtc: rtc@52 {
-		compatible = "microcrystal,rv3028";
-		reg = <0x52>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_pins_default>;
-		interrupt-parent = <&main_gpio1>;
-		interrupts = <70 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-source;
-	};
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-};
-
-&ospi0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&ospi0_pins_default>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <8>;
-		spi-rx-bus-width = <8>;
-		spi-max-frequency = <25000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <0>;
-	};
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <8>;
-	non-removable;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	keep-power-in-suspend;
-};
diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk.dts b/arch/arm/dts/k3-am642-phyboard-electra-rdk.dts
deleted file mode 100644
index 53b64e5541..0000000000
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk.dts
+++ /dev/null
@@ -1,302 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
- * Author: Matt McKee <mmckee@phytec.com>
- *
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
- *
- * Product homepage:
- * https://www.phytec.com/product/phyboard-am64x
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/phy/phy.h>
-#include "k3-am642.dtsi"
-#include "k3-am64-phycore-som.dtsi"
-
-#include "k3-serdes.h"
-
-/ {
-	compatible = "phytec,am642-phyboard-electra-rdk",
-		     "phytec,am64-phycore-som", "ti,am642";
-	model = "PHYTEC phyBOARD-Electra-AM64x RDK";
-
-	aliases {
-		mmc1 = &sdhci1;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-	};
-
-	chosen {
-		stdout-path = &main_uart0;
-	};
-
-	can_tc1: can-phy0 {
-		compatible = "ti,tcan1042";
-		pinctrl-names = "default";
-		pinctrl-0 = <&can_tc1_pins_default>;
-		#phy-cells = <0>;
-		max-bitrate = <5000000>;
-		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
-	};
-
-	can_tc2: can-phy1 {
-		compatible = "ti,tcan1042";
-		pinctrl-names = "default";
-		pinctrl-0 = <&can_tc2_pins_default>;
-		#phy-cells = <0>;
-		max-bitrate = <5000000>;
-		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
-	};
-
-	keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pins_default>;
-
-		key-home {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			gpios = <&main_gpio0 17 GPIO_ACTIVE_HIGH>;
-		};
-
-		key-menu {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
-
-		led-1 {
-			color = <LED_COLOR_ID_RED>;
-			gpios = <&main_gpio0 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-			function = LED_FUNCTION_DISK;
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&main_gpio0 16 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-			function = LED_FUNCTION_DISK;
-		};
-	};
-
-	vcc_3v3_mmc: regulator-sd {
-		/* TPS22963C */
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_MMC";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-};
-
-&main_pmx0 {
-	can_tc1_pins_default: can-tc1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)	/* (P16) GPMC0_ADVn_ALE.GPIO0_32 */
-		>;
-	};
-
-	can_tc2_pins_default: can-tc2-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0090, PIN_OUTPUT, 7)	/* (P17) GPMC0_BE0n_CLE.GPIO0_35 */
-		>;
-	};
-
-	gpio_keys_pins_default: gpio-keys-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0044, PIN_INPUT, 7)	/* (T18) GPMC0_AD2.GPIO0_17 */
-			AM64X_IOPAD(0x0054, PIN_INPUT, 7)	/* (V20) GPMC0_AD6.GPIO0_21 */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* (C18) I2C1_SCL */
-			AM64X_IOPAD(0x026c, PIN_INPUT, 0)	/* (B19) I2C1_SDA */
-		>;
-	};
-
-	main_mcan0_pins_default: main-mcan0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)	/* (A17) MCAN0_TX */
-			AM64X_IOPAD(0x0254, PIN_INPUT, 0)	/* (B17) MCAN0_RX */
-		>;
-	};
-
-	main_mcan1_pins_default: main-mcan1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)	/* (C17) MCAN1_TX */
-			AM64X_IOPAD(0x025c, PIN_INPUT, 0)	/* (D17) MCAN1_RX */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* (K18) MMC1_DAT3 */
-			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* (K19) MMC1_DAT2 */
-			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* (L21) MMC1_DAT1 */
-			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* (K21) MMC1_DAT0 */
-			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0)	/* (L20) MMC1_CLK */
-			AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB */
-			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
-			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
-		>;
-	};
-
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0230, PIN_INPUT, 0)	/* (D15) UART0_RXD */
-			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)	/* (C16) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0248, PIN_INPUT, 0)	/* (D16) UART1_CTSn */
-			AM64X_IOPAD(0x024C, PIN_OUTPUT, 0)	/* (E16) UART1_RTSn */
-			AM64X_IOPAD(0x0240, PIN_INPUT, 0)	/* (E15) UART1_RXD */
-			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)	/* (E14) UART1_TXD */
-		>;
-	};
-
-	main_usb0_pins_default: main-usb0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
-		>;
-	};
-
-	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
-		>;
-	};
-
-	pcie0_pins_default: pcie0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
-		>;
-	};
-
-	user_leds_pins_default: user-leds-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
-			AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
-		>;
-	};
-};
-
-&main_i2c1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
-
-	eeprom@51 {
-		compatible = "atmel,24c02";
-		pagesize = <16>;
-		reg = <0x51>;
-	};
-
-	led-controller@62 {
-		compatible = "nxp,pca9533";
-		reg = <0x62>;
-
-		led-3 {
-			label = "red:user";
-			type = <PCA9532_TYPE_LED>;
-		};
-
-		led-4 {
-			label = "green:user";
-			type = <PCA9532_TYPE_LED>;
-		};
-
-		led-5 {
-			label = "blue:user";
-			type = <PCA9532_TYPE_LED>;
-		};
-	};
-};
-
-&main_mcan0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcan0_pins_default>;
-	phys = <&can_tc1>;
-};
-
-&main_mcan1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcan1_pins_default>;
-	phys = <&can_tc2>;
-};
-
-&main_uart0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	current-speed = <115200>;
-};
-
-&main_uart1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-	uart-has-rtscts;
-	current-speed = <115200>;
-};
-
-&sdhci1 {
-	status = "okay";
-	vmmc-supply = <&vcc_3v3_mmc>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	bus-width = <4>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	no-1-8-v;
-};
-
-&serdes0 {
-	serdes0_pcie_usb_link: phy@0 {
-		reg = <0>;
-		cdns,num-lanes = <1>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_USB3>;
-		resets = <&serdes_wiz0 1>;
-	};
-};
-
-&serdes_ln_ctrl {
-	idle-states = <AM64_SERDES0_LANE0_USB>;
-};
-
-&usbss0 {
-	ti,vbus-divider;
-};
-
-&usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb0_pins_default>;
-	dr_mode = "host";
-	maximum-speed = "super-speed";
-	phys = <&serdes0_pcie_usb_link>;
-	phy-names = "cdns3,usb3-phy";
-};
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 79783aadbe..dd0967079b 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -121,7 +121,7 @@
 #endif
 
 #ifdef CONFIG_TARGET_PHYCORE_AM64X_A53
-#define SPL_AM642_PHYBOARD_ELECTRA_DTB "spl/dts/k3-am642-phyboard-electra-rdk.dtb"
+#define SPL_AM642_PHYBOARD_ELECTRA_DTB "spl/dts/ti/k3-am642-phyboard-electra-rdk.dtb"
 #define AM642_PHYBOARD_ELECTRA_DTB "u-boot.dtb"
 
 &binman {
@@ -289,10 +289,6 @@
 
 #ifdef CONFIG_TARGET_PHYCORE_AM64X_A53
 
-#define SPL_AM642_PHYBOARD_ELECTRA_DTB "spl/dts/k3-am642-phyboard-electra-rdk.dtb"
-
-#define AM642_PHYBOARD_ELECTRA_DTB "u-boot.dtb"
-
 &binman {
 	ti-spl {
 		insert-template = <&ti_spl_template>;
diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index b8fea8716e..e8b7d54d7a 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -35,6 +35,7 @@ config TARGET_PHYCORE_AM64X_A53
 	select BINMAN
 	imply BOARD
 	imply SPL_BOARD
+	imply OF_UPSTREAM
 
 config TARGET_PHYCORE_AM64X_R5
 	bool "PHYTEC phyCORE-AM64x running on R5"
diff --git a/board/phytec/phycore_am64x/MAINTAINERS b/board/phytec/phycore_am64x/MAINTAINERS
index caa9bbc97c..f5294db991 100644
--- a/board/phytec/phycore_am64x/MAINTAINERS
+++ b/board/phytec/phycore_am64x/MAINTAINERS
@@ -3,9 +3,7 @@ M:	Wadim Egorov <w.egorov@phytec.de>
 W:	https://www.phytec.com/product/phycore-am64x
 S:	Maintained
 F:	arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
-F:	arch/arm/dts/k3-am64-phycore-som.dtsi
 F:	arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
-F:	arch/arm/dts/k3-am642-phyboard-electra-rdk.dts
 F:	arch/arm/dts/k3-am642-phycore-som-binman.dtsi
 F:	arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am64x
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index f3085c0d10..09f1e2621d 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="k3-am642-phyboard-electra-rdk"
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-phyboard-electra-rdk"
 CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.25.1

