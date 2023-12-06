Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57750C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 13:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D417A876E9;
	Wed,  6 Dec 2023 14:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q24aQfzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 891BD876F7; Wed,  6 Dec 2023 13:38:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D59875F8
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cc70d025324;
 Wed, 6 Dec 2023 06:38:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866288;
 bh=eO61QHQp8BM0/y3NJgtOlGcVvJeT49kSOT1BrMU2D3g=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=Q24aQfzsyq9LHUMdiTsGL7MJcbDqFk4zEQYFhPbzf1S4iUzcMUSoSALNa8ykJOhjT
 B8ngdI4Z8FYPU2sipjlP/kElvck9lxYwz2gKeTVacRnvZkQGsMf9V07hjbHfTDTSgk
 2OHN3T90M7gWcefRBaG5q/UgUND96C4c8I728s8I=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6Cc71E115881
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:38:07 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:38:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:38:07 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqc096939;
 Wed, 6 Dec 2023 06:38:01 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v6 01/17] arm: dts: Introduce j784s4 dts from linux kernel
Date: Wed, 6 Dec 2023 18:07:37 +0530
Message-ID: <20231206123753.1486031-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Dec 2023 14:35:30 +0100
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

Introduce the basic j784s4 SoC dts from the v6.7-rc1 tag of the
linux kernel.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/dts/Makefile                  |    1 +
 arch/arm/dts/k3-j784s4-evm.dts         |  981 +++++++++++
 arch/arm/dts/k3-j784s4-main.dtsi       | 2068 ++++++++++++++++++++++++
 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi |  743 +++++++++
 arch/arm/dts/k3-j784s4-thermal.dtsi    |  101 ++
 arch/arm/dts/k3-j784s4.dtsi            |  294 ++++
 6 files changed, 4188 insertions(+)
 create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
 create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-j784s4.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index ea420db1b8..23ee65114b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1408,6 +1408,7 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
 			       k3-am68-sk-r5-base-board.dtb\
 			       k3-j721s2-common-proc-board.dtb\
 			       k3-j721s2-r5-common-proc-board.dtb
+dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-evm.dtb
 dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
 			      k3-am642-r5-evm.dtb \
 			      k3-am642-sk.dtb \
diff --git a/arch/arm/dts/k3-j784s4-evm.dts b/arch/arm/dts/k3-j784s4-evm.dts
new file mode 100644
index 0000000000..f1f4c8634a
--- /dev/null
+++ b/arch/arm/dts/k3-j784s4-evm.dts
@@ -0,0 +1,981 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-j784s4.dtsi"
+
+/ {
+	compatible = "ti,j784s4-evm", "ti,j784s4";
+	model = "Texas Instruments J784S4 EVM";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart8;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		i2c0 = &wkup_i2c0;
+		i2c3 = &main_i2c0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 32G RAM */
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+		      <0x08 0x80000000 0x07 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss2_core0_dma_memory_region: r5f-dma-memory@a6000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss2_core0_memory_region: r5f-memory@a6100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss2_core1_dma_memory_region: r5f-dma-memory@a7000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss2_core1_memory_region: r5f-memory@a7100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_0_memory_region: c71-memory@a8100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_1_dma_memory_region: c71-dma-memory@a9000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa9000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_1_memory_region: c71-memory@a9100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa9100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_2_dma_memory_region: c71-dma-memory@aa000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xaa000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_2_memory_region: c71-memory@aa100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xaa100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_3_memory_region: c71-memory@ab100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab100000 0x00 0xf00000>;
+			no-map;
+		};
+	};
+
+	evm_12v0: regulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: regulator-vsys3v3 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: regulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-sd {
+		/* Output of TPS22918 */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vsys_3v3>;
+		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: regulator-TLV71033 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	dp0_pwr_3v3: regulator-dp0-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp0-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	dp0: connector-dp0 {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp0_pwr_3v3>;
+
+		port {
+			dp0_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	bootph-all;
+	main_uart8_pins_default: main-uart8-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
+			J784S4_IOPAD(0x044, PIN_OUTPUT, 14) /* (AG37) MCASP0_AXR1.UART8_RTSn */
+			J784S4_IOPAD(0x0d0, PIN_INPUT, 11) /* (AP38) SPI0_CS1.UART8_RXD */
+			J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
+			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
+			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
+			J784S4_IOPAD(0x100, PIN_INPUT, 0) /* (No Pin) MMC1_CLKLB */
+			J784S4_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA33) MMC1_DAT0 */
+			J784S4_IOPAD(0x0f8, PIN_INPUT, 0) /* (AB34) MMC1_DAT1 */
+			J784S4_IOPAD(0x0f4, PIN_INPUT, 0) /* (AA32) MMC1_DAT2 */
+			J784S4_IOPAD(0x0f0, PIN_INPUT, 0) /* (AC38) MMC1_DAT3 */
+			J784S4_IOPAD(0x0e8, PIN_INPUT, 8) /* (AR38) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
+		>;
+	};
+
+	dp0_pins_default: dp0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
+		>;
+	};
+
+	main_i2c4_pins_default: main-i2c4-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
+			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
+		>;
+	};
+};
+
+&wkup_pmx2 {
+	bootph-all;
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (H37) WKUP_GPIO0_14.MCU_UART0_CTSn */
+			J784S4_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (K37) WKUP_GPIO0_15.MCU_UART0_RTSn */
+			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (K38) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
+			J784S4_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
+			J784S4_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
+			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
+			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
+		>;
+	};
+
+	mcu_adc0_pins_default: mcu-adc0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x0cc, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
+			J784S4_WKUP_IOPAD(0x0d0, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
+			J784S4_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
+			J784S4_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
+			J784S4_WKUP_IOPAD(0x0dc, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
+			J784S4_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
+			J784S4_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
+			J784S4_WKUP_IOPAD(0x0e8, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
+		>;
+	};
+
+	mcu_adc1_pins_default: mcu-adc1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x0ec, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
+			J784S4_WKUP_IOPAD(0x0f0, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
+			J784S4_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
+			J784S4_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
+			J784S4_WKUP_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
+			J784S4_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
+			J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
+			J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	bootph-all;
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (E32) MCU_OSPI0_CLK */
+			J784S4_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (A32) MCU_OSPI0_CSn0 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B33) MCU_OSPI0_D0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B32) MCU_OSPI0_D1 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (C33) MCU_OSPI0_D2 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (C35) MCU_OSPI0_D3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D33) MCU_OSPI0_D4 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
+			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
+		>;
+	};
+};
+
+&wkup_pmx1 {
+	bootph-all;
+	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
+			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
+			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
+			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
+		>;
+	};
+};
+
+&wkup_uart0 {
+	/* Firmware usage */
+	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&wkup_i2c0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&mcu_uart0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
+};
+
+&main_uart8 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart8_pins_default>;
+};
+
+&ufs_wrapper {
+	status = "okay";
+};
+
+&fss {
+	bootph-all;
+	status = "okay";
+};
+
+&ospi0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
+
+	flash@0 {
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				bootph-all;
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
+
+&ospi1 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
+
+	flash@0 {
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <40000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "qspi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "qspi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "qspi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "qspi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "qspi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "qspi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				bootph-all;
+				label = "qspi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+
+	};
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+
+	clock-frequency = <400000>;
+
+	exp1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "PCIE1_2L_MODE_SEL", "PCIE1_4L_PERSTZ", "PCIE1_2L_RC_RSTZ",
+				  "PCIE1_2L_EP_RST_EN", "PCIE0_4L_MODE_SEL", "PCIE0_4L_PERSTZ",
+				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
+				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
+				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
+	};
+
+	exp2: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "R_GPIO_RGMII1_RST", "ENET2_I2CMUX_SEL", "GPIO_USD_PWR_EN",
+				  "USBC_PWR_EN", "USBC_MODE_SEL1", "USBC_MODE_SEL0",
+				  "GPIO_LIN_EN", "R_CAN_STB", "CTRL_PM_I2C_OE#",
+				  "ENET2_EXP_PWRDN", "ENET2_EXP_SPARE2", "CDCI2_RSTZ",
+				  "USB2.0_MUX_SEL", "CANUART_MUX_SEL0", "CANUART_MUX2_SEL1",
+				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
+				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
+				  "USER_INPUT1", "USER_LED1", "USER_LED2";
+	};
+};
+
+&main_sdhci0 {
+	bootph-all;
+	/* eMMC */
+	status = "okay";
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci1 {
+	bootph-all;
+	/* SD card */
+	status = "okay";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-names = "default";
+	disable-wp;
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&mcu_cpsw {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mdio_pins_default>;
+
+	mcu_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&mcu_cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&mcu_phy0>;
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+	interrupts = <432>;
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+	interrupts = <428>;
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "okay";
+	interrupts = <424>;
+
+	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+	interrupts = <420>;
+
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c71_1: mbox-c71-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster5 {
+	status = "okay";
+	interrupts = <416>;
+
+	mbox_c71_2: mbox-c71-2 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c71_3: mbox-c71-3 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mcu_r5fss0_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss0_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+&main_r5fss2_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
+	memory-region = <&main_r5fss2_core0_dma_memory_region>,
+			<&main_r5fss2_core0_memory_region>;
+};
+
+&main_r5fss2_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
+	memory-region = <&main_r5fss2_core1_dma_memory_region>,
+			<&main_r5fss2_core1_memory_region>;
+};
+
+&c71_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
+};
+
+&c71_1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
+	memory-region = <&c71_1_dma_memory_region>,
+			<&c71_1_memory_region>;
+};
+
+&c71_2 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5 &mbox_c71_2>;
+	memory-region = <&c71_2_dma_memory_region>,
+			<&c71_2_memory_region>;
+};
+
+&c71_3 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
+	memory-region = <&c71_3_dma_memory_region>,
+			<&c71_3_memory_region>;
+};
+
+&tscadc0 {
+	pinctrl-0 = <&mcu_adc0_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&tscadc1 {
+	pinctrl-0 = <&mcu_adc1_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&serdes_refclk {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
+
+&dss {
+	status = "okay";
+	assigned-clocks = <&k3_clks 218 2>,
+			  <&k3_clks 218 5>,
+			  <&k3_clks 218 14>,
+			  <&k3_clks 218 18>;
+	assigned-clock-parents = <&k3_clks 218 3>,
+				 <&k3_clks 218 7>,
+				 <&k3_clks 218 16>,
+				 <&k3_clks 218 22>;
+};
+
+&serdes_wiz4 {
+	status = "okay";
+};
+
+&serdes4 {
+	status = "okay";
+	serdes4_dp_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
+			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
+	};
+};
+
+&mhdp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+	phys = <&serdes4_dp_link>;
+	phy-names = "dpphy";
+};
+
+&dss_ports {
+	/* DP */
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&main_i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
+
+	exp4: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&dp0_ports {
+	port@0 {
+		reg = <0>;
+
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+
+		dp0_out: endpoint {
+			remote-endpoint = <&dp0_connector_in>;
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j784s4-main.dtsi b/arch/arm/dts/k3-j784s4-main.dtsi
new file mode 100644
index 0000000000..d89bcddcfe
--- /dev/null
+++ b/arch/arm/dts/k3-j784s4-main.dtsi
@@ -0,0 +1,2068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J784S4 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+#include "k3-serdes.h"
+
+/ {
+	serdes_refclk: clock-serdes {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		/* To be enabled when serdes_wiz* is functional */
+		status = "disabled";
+	};
+};
+
+&cbass_main {
+	msmc_ram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x70000000 0x00 0x800000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x70000000 0x800000>;
+
+		atf-sram@0 {
+			reg = <0x00 0x20000>;
+		};
+
+		tifs-sram@1f0000 {
+			reg = <0x1f0000 0x10000>;
+		};
+
+		l3cache-sram@200000 {
+			reg = <0x200000 0x200000>;
+		};
+	};
+
+	scm_conf: bus@100000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x00100000 0x00 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00100000 0x1c000>;
+
+		serdes_ln_ctrl: mux-controller@4080 {
+			compatible = "reg-mux";
+			reg = <0x00004080 0x30>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
+					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
+					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
+				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
+				      <J784S4_SERDES0_LANE3_USB>,
+				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
+				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
+				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
+				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
+				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
+				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
+				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
+				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
+		};
+	};
+
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;   /* GICV */
+
+		/* vcpumntirq: virtual CPU interface maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: msi-controller@1820000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x00 0x01820000 0x00 0x10000>;
+			socionext,synquacer-pre-its = <0x1000000 0x400000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+
+	main_gpio_intr: interrupt-controller@a00000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <10>;
+		ti,interrupt-ranges = <8 392 56>;
+	};
+
+	main_pmx0: pinctrl@11c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c000 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104200 0x00 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000007>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104280 0x00 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
+	main_crypto: crypto@4e00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x4e00000 0x00 0x1200>;
+		power-domains = <&k3_pds 369 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
+
+		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
+				<&main_udmap 0x4a41>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x4e10000 0x00 0x7d>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 97 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 97 2>;
+		assigned-clock-parents = <&k3_clks 97 3>;
+		power-domains = <&k3_pds 97 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 98 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 98 2>;
+		assigned-clock-parents = <&k3_clks 98 3>;
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 99 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 99 2>;
+		assigned-clock-parents = <&k3_clks 99 3>;
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 100 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 100 2>;
+		assigned-clock-parents = <&k3_clks 100 3>;
+		power-domains = <&k3_pds 100 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 101 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 101 2>;
+		assigned-clock-parents = <&k3_clks 101 3>;
+		power-domains = <&k3_pds 101 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 102 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 102 2>;
+		assigned-clock-parents = <&k3_clks 102 3>;
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 103 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 103 2>;
+		assigned-clock-parents = <&k3_clks 103 3>;
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 104 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 104 2>;
+		assigned-clock-parents = <&k3_clks 104 3>;
+		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 105 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 105 2>;
+		assigned-clock-parents = <&k3_clks 105 3>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 106 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 106 2>;
+		assigned-clock-parents = <&k3_clks 106 3>;
+		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 107 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 107 2>;
+		assigned-clock-parents = <&k3_clks 107 3>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 108 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 108 2>;
+		assigned-clock-parents = <&k3_clks 108 3>;
+		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 109 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 109 2>;
+		assigned-clock-parents = <&k3_clks 109 3>;
+		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 110 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 110 2>;
+		assigned-clock-parents = <&k3_clks 110 3>;
+		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 111 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 111 2>;
+		assigned-clock-parents = <&k3_clks 111 3>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 112 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 112 2>;
+		assigned-clock-parents = <&k3_clks 112 3>;
+		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 113 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 113 2>;
+		assigned-clock-parents = <&k3_clks 113 3>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 114 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 114 2>;
+		assigned-clock-parents = <&k3_clks 114 3>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 115 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 115 2>;
+		assigned-clock-parents = <&k3_clks 115 3>;
+		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 116 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 116 2>;
+		assigned-clock-parents = <&k3_clks 116 3>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x200>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 146 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x200>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 388 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 388 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x200>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 389 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 389 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart3: serial@2830000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02830000 0x00 0x200>;
+		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 390 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 390 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart4: serial@2840000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02840000 0x00 0x200>;
+		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 391 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 391 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart5: serial@2850000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02850000 0x00 0x200>;
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 392 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 392 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart6: serial@2860000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02860000 0x00 0x200>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 393 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 393 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart7: serial@2870000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02870000 0x00 0x200>;
+		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 394 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 394 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart8: serial@2880000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02880000 0x00 0x200>;
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 395 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 395 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_uart9: serial@2890000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02890000 0x00 0x200>;
+		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 396 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 396 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <145>, <146>, <147>, <148>, <149>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 163 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio2: gpio@610000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00610000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <154>, <155>, <156>, <157>, <158>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 164 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio4: gpio@620000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00620000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <163>, <164>, <165>, <166>, <167>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 165 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio6: gpio@630000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00630000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <172>, <173>, <174>, <175>, <176>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 166 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_i2c0: i2c@2000000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02000000 0x00 0x100>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 270 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c1: i2c@2010000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02010000 0x00 0x100>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 271 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c2: i2c@2020000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02020000 0x00 0x100>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 272 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c3: i2c@2030000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02030000 0x00 0x100>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 273 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c4: i2c@2040000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02040000 0x00 0x100>;
+		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 274 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c5: i2c@2050000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02050000 0x00 0x100>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 275 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_i2c6: i2c@2060000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02060000 0x00 0x100>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 276 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_sdhci0: mmc@4f80000 {
+		compatible = "ti,j721e-sdhci-8bit";
+		reg = <0x00 0x04f80000 0x00 0x1000>,
+		      <0x00 0x04f88000 0x00 0x400>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 140 1>, <&k3_clks 140 2>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 140 2>;
+		assigned-clock-parents = <&k3_clks 140 3>;
+		bus-width = <8>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x5>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,strobe-sel = <0x77>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		dma-coherent;
+		status = "disabled";
+	};
+
+	main_sdhci1: mmc@4fb0000 {
+		compatible = "ti,j721e-sdhci-4bit";
+		reg = <0x00 0x04fb0000 0x00 0x1000>,
+		      <0x00 0x04fb8000 0x00 0x400>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 141 3>, <&k3_clks 141 4>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 141 4>;
+		assigned-clock-parents = <&k3_clks 141 5>;
+		bus-width = <4>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		dma-coherent;
+		sdhci-caps-mask = <0x00000003 0x00000000>;
+		no-1-8-v;
+		status = "disabled";
+	};
+
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 404 6>;
+		assigned-clock-parents = <&k3_clks 404 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x5060000 0x00 0x5060000 0x10000>;
+		status = "disabled";
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 404 6>,
+						 <&k3_clks 404 6>,
+						 <&k3_clks 404 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz1: wiz@5070000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 405 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 405 2>, <&k3_clks 405 6>, <&serdes_refclk>, <&k3_clks 405 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 405 6>;
+		assigned-clock-parents = <&k3_clks 405 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05070000 0x00 0x05070000 0x10000>;
+		status = "disabled";
+
+		serdes1: serdes@5070000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05070000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz1 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 405 6>,
+						 <&k3_clks 405 6>,
+						 <&k3_clks 405 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz2: wiz@5020000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 406 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 406 2>, <&k3_clks 406 6>, <&serdes_refclk>, <&k3_clks 406 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 406 6>;
+		assigned-clock-parents = <&k3_clks 406 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05020000 0x00 0x05020000 0x10000>;
+		status = "disabled";
+
+		serdes2: serdes@5020000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05020000 0x010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz2 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz2 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz2 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz2 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 406 6>,
+						 <&k3_clks 406 6>,
+						 <&k3_clks 406 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,j784s4-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 407 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 407 2>, <&k3_clks 407 6>, <&serdes_refclk>, <&k3_clks 407 5>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
+		assigned-clocks = <&k3_clks 407 6>;
+		assigned-clock-parents = <&k3_clks 407 10>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05050000 0x00 0x05050000 0x10000>,
+			 <0xa030a00 0x00 0xa030a00 0x40>; /* DPTX PHY */
+		status = "disabled";
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05050000 0x010000>,
+			      <0x0a030a00 0x40>; /* DPTX PHY */
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz4 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz4 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 407 6>,
+						 <&k3_clks 407 6>,
+						 <&k3_clks 407 6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+	};
+
+	main_navss: bus@30000000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
+		ti,sci-dev-id = <280>;
+		dma-coherent;
+		dma-ranges;
+
+		main_navss_intr: interrupt-controller@310e0000 {
+			compatible = "ti,sci-intr";
+			reg = <0x00 0x310e0000 0x00 0x4000>;
+			ti,intr-trigger-type = <4>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			#interrupt-cells = <1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <283>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>,
+					      <128 672 64>;
+		};
+
+		main_udmass_inta: msi-controller@33d00000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x33d00000 0x00 0x100000>;
+			interrupt-controller;
+			#interrupt-cells = <0>;
+			interrupt-parent = <&main_navss_intr>;
+			msi-controller;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <321>;
+			ti,interrupt-ranges = <0 0 256>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
+		};
+
+		secure_proxy_main: mailbox@32c00000 {
+			bootph-all;
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		hwspinlock: hwlock@30e00000 {
+			compatible = "ti,am654-hwspinlock";
+			reg = <0x00 0x30e00000 0x00 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
+		mailbox0_cluster0: mailbox@31f80000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f80000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster1: mailbox@31f81000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f81000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster2: mailbox@31f82000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f82000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster3: mailbox@31f83000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f83000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster4: mailbox@31f84000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f84000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster5: mailbox@31f85000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f85000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster6: mailbox@31f86000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f86000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster7: mailbox@31f87000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f87000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster8: mailbox@31f88000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f88000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster9: mailbox@31f89000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f89000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster10: mailbox@31f8a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox0_cluster11: mailbox@31f8b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster0: mailbox@31f90000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f90000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster1: mailbox@31f91000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f91000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster2: mailbox@31f92000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f92000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster3: mailbox@31f93000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f93000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster4: mailbox@31f94000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f94000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster5: mailbox@31f95000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f95000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster6: mailbox@31f96000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f96000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster7: mailbox@31f97000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f97000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster8: mailbox@31f98000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f98000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster9: mailbox@31f99000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f99000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster10: mailbox@31f9a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		mailbox1_cluster11: mailbox@31f9b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
+		};
+
+		main_ringacc: ringacc@3c000000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x00 0x3c000000 0x00 0x400000>,
+			      <0x00 0x38000000 0x00 0x400000>,
+			      <0x00 0x31120000 0x00 0x100>,
+			      <0x00 0x33000000 0x00 0x40000>,
+			      <0x00 0x31080000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			ti,num-rings = <1024>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <315>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		main_udmap: dma-controller@31150000 {
+			compatible = "ti,j721e-navss-main-udmap";
+			reg = <0x00 0x31150000 0x00 0x100>,
+			      <0x00 0x34000000 0x00 0x80000>,
+			      <0x00 0x35000000 0x00 0x200000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <319>;
+			ti,ringacc = <&main_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>, /* TX_HCHAN */
+						<0x10>; /* TX_UHCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>, /* RX_HCHAN */
+						<0x0c>; /* RX_UHCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+
+		main_bcdma_csi: dma-controller@311a0000 {
+			compatible = "ti,j721s2-dmss-bcdma-csi";
+			reg = <0x00 0x311a0000 0x00 0x100>,
+			      <0x00 0x35d00000 0x00 0x20000>,
+			      <0x00 0x35c00000 0x00 0x10000>,
+			      <0x00 0x35e00000 0x00 0x80000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <3>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <281>;
+			ti,sci-rm-range-rchan = <0x21>;
+			ti,sci-rm-range-tchan = <0x22>;
+			status = "disabled";
+		};
+
+		cpts@310d0000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x310d0000 0x00 0x400>;
+			reg-names = "cpts";
+			clocks = <&k3_clks 282 0>;
+			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 62 3>; /* CPTS_RFT_CLK */
+			assigned-clock-parents = <&k3_clks 62 5>; /* MAIN_0_HSDIV6_CLK */
+			interrupts-extended = <&main_navss_intr 391>;
+			interrupt-names = "cpts";
+			ti,cpts-periodic-outputs = <6>;
+			ti,cpts-ext-ts-inputs = <8>;
+		};
+	};
+
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 245 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 245 6>, <&k3_clks 245 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 246 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 246 6>, <&k3_clks 246 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 247 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 247 6>, <&k3_clks 247 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 248 6>, <&k3_clks 248 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 249 6>, <&k3_clks 249 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 250 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 250 6>, <&k3_clks 250 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 251 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 251 6>, <&k3_clks 251 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 252 6>, <&k3_clks 252 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 253 6>, <&k3_clks 253 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 254 6>, <&k3_clks 254 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 255 6>, <&k3_clks 255 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 256 6>, <&k3_clks 256 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 257 6>, <&k3_clks 257 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 258 6>, <&k3_clks 258 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan14: can@2681000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02681000 0x00 0x200>,
+		      <0x00 0x02688000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 259 6>, <&k3_clks 259 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan15: can@2691000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02691000 0x00 0x200>,
+		      <0x00 0x02698000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 260 6>, <&k3_clks 260 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan16: can@26a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026a1000 0x00 0x200>,
+		      <0x00 0x026a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 261 6>, <&k3_clks 261 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan17: can@26b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026b1000 0x00 0x200>,
+		      <0x00 0x026b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 262 6>, <&k3_clks 262 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 376 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 376 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 377 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 377 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 378 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 378 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 379 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 379 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 380 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 380 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 381 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 381 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 382 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 382 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 383 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 383 1>;
+		status = "disabled";
+	};
+
+	ufs_wrapper: ufs-wrapper@4e80000 {
+		compatible = "ti,j721e-ufs";
+		reg = <0x00 0x4e80000 0x00 0x100>;
+		power-domains = <&k3_pds 387 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 387 3>;
+		assigned-clocks = <&k3_clks 387 3>;
+		assigned-clock-parents = <&k3_clks 387 6>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		ufs@4e84000 {
+			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
+			reg = <0x00 0x4e84000 0x00 0x10000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			freq-table-hz = <250000000 250000000>, <19200000 19200000>,
+					<19200000 19200000>;
+			clocks = <&k3_clks 387 1>, <&k3_clks 387 3>, <&k3_clks 387 3>;
+			clock-names = "core_clk", "phy_clk", "ref_clk";
+			dma-coherent;
+		};
+	};
+
+	main_r5fss0: r5fss@5c00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
+			 <0x5d00000 0x00 0x5d00000 0x20000>;
+		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss0_core0: r5f@5c00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5c00000 0x00010000>,
+			      <0x5c10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <339>;
+			ti,sci-proc-ids = <0x06 0xff>;
+			resets = <&k3_reset 339 1>;
+			firmware-name = "j784s4-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss0_core1: r5f@5d00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5d00000 0x00010000>,
+			      <0x5d10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <340>;
+			ti,sci-proc-ids = <0x07 0xff>;
+			resets = <&k3_reset 340 1>;
+			firmware-name = "j784s4-main-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss1: r5fss@5e00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
+			 <0x5f00000 0x00 0x5f00000 0x20000>;
+		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss1_core0: r5f@5e00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5e00000 0x00010000>,
+			      <0x5e10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <341>;
+			ti,sci-proc-ids = <0x08 0xff>;
+			resets = <&k3_reset 341 1>;
+			firmware-name = "j784s4-main-r5f1_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss1_core1: r5f@5f00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5f00000 0x00010000>,
+			      <0x5f10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <342>;
+			ti,sci-proc-ids = <0x09 0xff>;
+			resets = <&k3_reset 342 1>;
+			firmware-name = "j784s4-main-r5f1_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss2: r5fss@5900000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5900000 0x00 0x5900000 0x20000>,
+			 <0x5a00000 0x00 0x5a00000 0x20000>;
+		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss2_core0: r5f@5900000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5900000 0x00010000>,
+			      <0x5910000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <343>;
+			ti,sci-proc-ids = <0x0a 0xff>;
+			resets = <&k3_reset 343 1>;
+			firmware-name = "j784s4-main-r5f2_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss2_core1: r5f@5a00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5a00000 0x00010000>,
+			      <0x5a10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <344>;
+			ti,sci-proc-ids = <0x0b 0xff>;
+			resets = <&k3_reset 344 1>;
+			firmware-name = "j784s4-main-r5f2_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <30>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 30 1>;
+		firmware-name = "j784s4-c71_0-fw";
+		status = "disabled";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <33>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 33 1>;
+		firmware-name = "j784s4-c71_1-fw";
+		status = "disabled";
+	};
+
+	c71_2: dsp@66800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x66800000 0x00 0x00080000>,
+		      <0x00 0x66e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <37>;
+		ti,sci-proc-ids = <0x32 0xff>;
+		resets = <&k3_reset 37 1>;
+		firmware-name = "j784s4-c71_2-fw";
+		status = "disabled";
+	};
+
+	c71_3: dsp@67800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x67800000 0x00 0x00080000>,
+		      <0x00 0x67e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <40>;
+		ti,sci-proc-ids = <0x33 0xff>;
+		resets = <&k3_reset 40 1>;
+		firmware-name = "j784s4-c71_3-fw";
+		status = "disabled";
+	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x700000 0x00 0x1000>;
+		ti,esm-pins = <688>, <689>, <690>, <691>, <692>, <693>, <694>,
+			      <695>;
+		bootph-pre-ram;
+	};
+
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2200000 0x00 0x100>;
+		clocks = <&k3_clks 348 1>;
+		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 348 0>;
+		assigned-clock-parents = <&k3_clks 348 4>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2210000 0x00 0x100>;
+		clocks = <&k3_clks 349 1>;
+		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 349 0>;
+		assigned-clock-parents = <&k3_clks 349 4>;
+	};
+
+	watchdog2: watchdog@2220000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2220000 0x00 0x100>;
+		clocks = <&k3_clks 350 1>;
+		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 350 0>;
+		assigned-clock-parents = <&k3_clks 350 4>;
+	};
+
+	watchdog3: watchdog@2230000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2230000 0x00 0x100>;
+		clocks = <&k3_clks 351 1>;
+		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 351 0>;
+		assigned-clock-parents = <&k3_clks 351 4>;
+	};
+
+	watchdog4: watchdog@2240000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2240000 0x00 0x100>;
+		clocks = <&k3_clks 352 1>;
+		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 352 0>;
+		assigned-clock-parents = <&k3_clks 352 4>;
+	};
+
+	watchdog5: watchdog@2250000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2250000 0x00 0x100>;
+		clocks = <&k3_clks 353 1>;
+		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 353 0>;
+		assigned-clock-parents = <&k3_clks 353 4>;
+	};
+
+	watchdog6: watchdog@2260000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2260000 0x00 0x100>;
+		clocks = <&k3_clks 354 1>;
+		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 354 0>;
+		assigned-clock-parents = <&k3_clks 354 4>;
+	};
+
+	watchdog7: watchdog@2270000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2270000 0x00 0x100>;
+		clocks = <&k3_clks 355 1>;
+		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 355 0>;
+		assigned-clock-parents = <&k3_clks 355 4>;
+	};
+
+	/*
+	 * The following RTI instances are coupled with MCU R5Fs, c7x and
+	 * GPU so keeping them reserved as these will be used by their
+	 * respective firmware
+	 */
+	watchdog8: watchdog@22f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x22f0000 0x00 0x100>;
+		clocks = <&k3_clks 360 1>;
+		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 360 0>;
+		assigned-clock-parents = <&k3_clks 360 4>;
+		/* reserved for GPU */
+		status = "reserved";
+	};
+
+	watchdog9: watchdog@2300000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2300000 0x00 0x100>;
+		clocks = <&k3_clks 356 1>;
+		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 356 0>;
+		assigned-clock-parents = <&k3_clks 356 4>;
+		/* reserved for C7X_0 DSP */
+		status = "reserved";
+	};
+
+	watchdog10: watchdog@2310000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2310000 0x00 0x100>;
+		clocks = <&k3_clks 357 1>;
+		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 357 0>;
+		assigned-clock-parents = <&k3_clks 357 4>;
+		/* reserved for C7X_1 DSP */
+		status = "reserved";
+	};
+
+	watchdog11: watchdog@2320000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2320000 0x00 0x100>;
+		clocks = <&k3_clks 358 1>;
+		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 358 0>;
+		assigned-clock-parents = <&k3_clks 358 4>;
+		/* reserved for C7X_2 DSP */
+		status = "reserved";
+	};
+
+	watchdog12: watchdog@2330000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2330000 0x00 0x100>;
+		clocks = <&k3_clks 359 1>;
+		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 359 0>;
+		assigned-clock-parents = <&k3_clks 359 4>;
+		/* reserved for C7X_3 DSP */
+		status = "reserved";
+	};
+
+	watchdog13: watchdog@23c0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23c0000 0x00 0x100>;
+		clocks = <&k3_clks 361 1>;
+		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 361 0>;
+		assigned-clock-parents = <&k3_clks 361 4>;
+		/* reserved for MAIN_R5F0_0 */
+		status = "reserved";
+	};
+
+	watchdog14: watchdog@23d0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23d0000 0x00 0x100>;
+		clocks = <&k3_clks 362 1>;
+		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 362 0>;
+		assigned-clock-parents = <&k3_clks 362 4>;
+		/* reserved for MAIN_R5F0_1 */
+		status = "reserved";
+	};
+
+	watchdog15: watchdog@23e0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23e0000 0x00 0x100>;
+		clocks = <&k3_clks 363 1>;
+		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 363 0>;
+		assigned-clock-parents = <&k3_clks 363 4>;
+		/* reserved for MAIN_R5F1_0 */
+		status = "reserved";
+	};
+
+	watchdog16: watchdog@23f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23f0000 0x00 0x100>;
+		clocks = <&k3_clks 364 1>;
+		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 364 0>;
+		assigned-clock-parents = <&k3_clks 364 4>;
+		/* reserved for MAIN_R5F1_1 */
+		status = "reserved";
+	};
+
+	watchdog17: watchdog@2540000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2540000 0x00 0x100>;
+		clocks = <&k3_clks 365 1>;
+		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 365 0>;
+		assigned-clock-parents = <&k3_clks 366 4>;
+		/* reserved for MAIN_R5F2_0 */
+		status = "reserved";
+	};
+
+	watchdog18: watchdog@2550000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2550000 0x00 0x100>;
+		clocks = <&k3_clks 366 1>;
+		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 366 0>;
+		assigned-clock-parents = <&k3_clks 366 4>;
+		/* reserved for MAIN_R5F2_1 */
+		status = "reserved";
+	};
+
+	mhdp: bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+		reg = <0x0 0xa000000 0x0 0x30a00>,
+		      <0x0 0x4f40000 0x0 0x20>;
+		reg-names = "mhdptx", "j721e-intg";
+		clocks = <&k3_clks 217 11>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Remote-endpoints are on the boards so
+			 * ports are defined in the platform dt file.
+			 */
+		};
+	};
+
+	dss: dss@4a00000 {
+		compatible = "ti,j721e-dss";
+		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
+		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
+		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
+		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
+		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
+		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
+		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
+		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
+		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
+		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
+		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
+		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
+		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
+		reg-names = "common_m", "common_s0",
+			    "common_s1", "common_s2",
+			    "vidl1", "vidl2","vid1","vid2",
+			    "ovr1", "ovr2", "ovr3", "ovr4",
+			    "vp1", "vp2", "vp3", "vp4",
+			    "wb";
+		clocks = <&k3_clks 218 0>,
+			 <&k3_clks 218 2>,
+			 <&k3_clks 218 5>,
+			 <&k3_clks 218 14>,
+			 <&k3_clks 218 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+		status = "disabled";
+
+		dss_ports: ports {
+			/* Ports that DSS drives are platform specific
+			 * so they are defined in platform dt file.
+			 */
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi b/arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
new file mode 100644
index 0000000000..adb5ea6b97
--- /dev/null
+++ b/arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J784S4 SoC Family MCU/WAKEUP Domain peripherals
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_mcu_wakeup {
+	sms: system-controller@44083000 {
+		bootph-all;
+		compatible = "ti,k2g-sci";
+		ti,host-id = <12>;
+
+		mbox-names = "rx", "tx";
+
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
+
+		reg-names = "debug_messages";
+		reg = <0x00 0x44083000 0x00 0x1000>;
+
+		k3_pds: power-controller {
+			bootph-all;
+			compatible = "ti,sci-pm-domain";
+			#power-domain-cells = <2>;
+		};
+
+		k3_clks: clock-controller {
+			bootph-all;
+			compatible = "ti,k2g-sci-clk";
+			#clock-cells = <2>;
+		};
+
+		k3_reset: reset-controller {
+			bootph-all;
+			compatible = "ti,sci-reset";
+			#reset-cells = <2>;
+		};
+	};
+
+	chipid@43000014 {
+		bootph-all;
+		compatible = "ti,am654-chipid";
+		reg = <0x00 0x43000014 0x00 0x4>;
+	};
+
+	secure_proxy_sa3: mailbox@43600000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x43600000 0x00 0x10000>,
+		      <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
+	mcu_ram: sram@41c00000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x41c00000 0x00 0x100000>;
+		ranges = <0x00 0x00 0x41c00000 0x100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	wkup_pmx0: pinctrl@4301c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c000 0x00 0x034>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_gpio_intr: interrupt-controller@42200000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x42200000 0x00 0x400>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <177>;
+		ti,interrupt-ranges = <16 960 16>;
+	};
+
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04200 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04280 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_conf: syscon@40f00000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x40f00000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x40f00000 0x20000>;
+
+		phy_gmii_sel: phy@4040 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4040 0x4>;
+			#phy-cells = <1>;
+		};
+	};
+
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 2>;
+		assigned-clock-parents = <&k3_clks 35 3>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		bootph-all;
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 117 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 117 2>;
+		assigned-clock-parents = <&k3_clks 117 3>;
+		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 118 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 118 2>;
+		assigned-clock-parents = <&k3_clks 118 3>;
+		power-domains = <&k3_pds 118 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 119 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 119 2>;
+		assigned-clock-parents = <&k3_clks 119 3>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 120 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 120 2>;
+		assigned-clock-parents = <&k3_clks 120 3>;
+		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 121 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 121 2>;
+		assigned-clock-parents = <&k3_clks 121 3>;
+		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 122 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 122 2>;
+		assigned-clock-parents = <&k3_clks 122 3>;
+		power-domains = <&k3_pds 122 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 123 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 123 2>;
+		assigned-clock-parents = <&k3_clks 123 3>;
+		power-domains = <&k3_pds 123 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 124 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 124 2>;
+		assigned-clock-parents = <&k3_clks 124 3>;
+		power-domains = <&k3_pds 124 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 125 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 125 2>;
+		assigned-clock-parents = <&k3_clks 125 3>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	wkup_uart0: serial@42300000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x42300000 0x00 0x200>;
+		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 397 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 397 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_uart0: serial@40a00000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x40a00000 0x00 0x200>;
+		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 149 0>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	wkup_gpio0: gpio@42110000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42110000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 167 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	wkup_gpio1: gpio@42100000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42100000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 168 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	wkup_i2c0: i2c@42120000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x42120000 0x00 0x100>;
+		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 279 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_i2c0: i2c@40b00000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b00000 0x00 0x100>;
+		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 277 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_i2c1: i2c@40b10000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b10000 0x00 0x100>;
+		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 278 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 263 6>, <&k3_clks 263 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 264 6>, <&k3_clks 264 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 384 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 384 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 385 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 385 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 386 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 386 0>;
+		status = "disabled";
+	};
+
+	mcu_navss: bus@28380000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
+		ti,sci-dev-id = <323>;
+		dma-coherent;
+		dma-ranges;
+
+		mcu_ringacc: ringacc@2b800000 {
+			bootph-all;
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x00 0x2b800000 0x00 0x400000>,
+			      <0x00 0x2b000000 0x00 0x400000>,
+			      <0x00 0x28590000 0x00 0x100>,
+			      <0x00 0x2a500000 0x00 0x40000>,
+			      <0x00 0x28440000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			ti,num-rings = <286>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <328>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		mcu_udmap: dma-controller@285c0000 {
+			bootph-all;
+			compatible = "ti,j721e-navss-mcu-udmap";
+			reg = <0x00 0x285c0000 0x00 0x100>,
+			      <0x00 0x2a800000 0x00 0x40000>,
+			      <0x00 0x2aa00000 0x00 0x40000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <329>;
+			ti,ringacc = <&mcu_ringacc>;
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>; /* TX_HCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>; /* RX_HCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+	};
+
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x2a480000 0x00 0x80000>,
+		      <0x00 0x2a380000 0x00 0x80000>,
+		      <0x00 0x2a400000 0x00 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
+	mcu_cpsw: ethernet@46000000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0x46000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0x46000000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 63 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&mcu_udmap 0xf000>,
+		       <&mcu_udmap 0xf001>,
+		       <&mcu_udmap 0xf002>,
+		       <&mcu_udmap 0xf003>,
+		       <&mcu_udmap 0xf004>,
+		       <&mcu_udmap 0xf005>,
+		       <&mcu_udmap 0xf006>,
+		       <&mcu_udmap 0xf007>,
+		       <&mcu_udmap 0x7000>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mcu_cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				ti,syscon-efuse = <&mcu_conf 0x200>;
+				phys = <&phy_gmii_sel 1>;
+			};
+		};
+
+		davinci_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 63 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 63 3>;
+			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 63 3>; /* CPTS_RFT_CLK */
+			assigned-clock-parents = <&k3_clks 63 5>; /* MAIN_0_HSDIV6_CLK */
+			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	mcu_r5fss0: r5fss@41000000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x41000000 0x00 0x41000000 0x20000>,
+			 <0x41400000 0x00 0x41400000 0x20000>;
+		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
+
+		mcu_r5fss0_core0: r5f@41000000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41000000 0x00010000>,
+			      <0x41010000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <346>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 346 1>;
+			firmware-name = "j784s4-mcu-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		mcu_r5fss0_core1: r5f@41400000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41400000 0x00010000>,
+			      <0x41410000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <347>;
+			ti,sci-proc-ids = <0x02 0xff>;
+			resets = <&k3_reset 347 1>;
+			firmware-name = "j784s4-mcu-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40200000 0x00 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40210000 0x00 0x1000>;
+		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 1 0>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x47000000 0x00 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x05 0x0000000 0x01 0x0000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 161 7>;
+			assigned-clocks = <&k3_clks 161 7>;
+			assigned-clock-parents = <&k3_clks 161 9>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x07 0x0000000 0x01 0x0000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 162 7>;
+			power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		ti,esm-pins = <95>;
+		bootph-pre-ram;
+	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x42080000 0x00 0x1000>;
+		ti,esm-pins = <63>;
+		bootph-pre-ram;
+	};
+
+	/*
+	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
+	 * reserved as these will be used by their respective firmware
+	 */
+	mcu_watchdog0: watchdog@40600000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40600000 0x00 0x100>;
+		clocks = <&k3_clks 367 1>;
+		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 367 0>;
+		assigned-clock-parents = <&k3_clks 367 4>;
+		/* reserved for MCU_R5F0_0 */
+		status = "reserved";
+	};
+
+	mcu_watchdog1: watchdog@40610000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40610000 0x00 0x100>;
+		clocks = <&k3_clks 368 1>;
+		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 368 0>;
+		assigned-clock-parents = <&k3_clks 368 4>;
+		/* reserved for MCU_R5F0_1 */
+		status = "reserved";
+	};
+};
diff --git a/arch/arm/dts/k3-j784s4-thermal.dtsi b/arch/arm/dts/k3-j784s4-thermal.dtsi
new file mode 100644
index 0000000000..f7b1a15b8f
--- /dev/null
+++ b/arch/arm/dts/k3-j784s4-thermal.dtsi
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+wkup0_thermal: wkup0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 0>;
+
+	trips {
+		wkup0_crit: wkup0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+wkup1_thermal: wkup1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 1>;
+
+	trips {
+		wkup1_crit: wkup1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main0_thermal: main0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 2>;
+
+	trips {
+		main0_crit: main0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main1_thermal: main1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 3>;
+
+	trips {
+		main1_crit: main1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main2_thermal: main2-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 4>;
+
+	trips {
+		main2_crit: main2-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main3_thermal: main3-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 5>;
+
+	trips {
+		main3_crit: main3-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main4_thermal: main4-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 6>;
+
+	trips {
+		main4_crit: main4-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j784s4.dtsi b/arch/arm/dts/k3-j784s4.dtsi
new file mode 100644
index 0000000000..4398c3a463
--- /dev/null
+++ b/arch/arm/dts/k3-j784s4.dtsi
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J784S4 SoC Family
+ *
+ * TRM (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+/ {
+	model = "Texas Instruments K3 J784S4 SoC";
+	compatible = "ti,j784s4";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1: cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a72";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a72";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a72";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a72";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu4: cpu@100 {
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu5: cpu@101 {
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu6: cpu@102 {
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu7: cpu@103 {
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	L2_1: l2-cache1 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+		cache-unified;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a72_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a72-pmu";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@100000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
+			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
+			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
+			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
+			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
+			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
+			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
+			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
+
+			 /* MCUSS_WKUP Range */
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
+			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
+			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
+			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
+			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+
+		cbass_mcu_wakeup: bus@28380000 {
+			bootph-all;
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
+				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
+				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
+				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
+				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
+				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
+				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+		};
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j784s4-thermal.dtsi"
+	};
+};
+
+/* Now include peripherals from each bus segment */
+#include "k3-j784s4-main.dtsi"
+#include "k3-j784s4-mcu-wakeup.dtsi"
-- 
2.34.1

