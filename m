Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB6CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFE482C84;
	Wed, 13 Aug 2025 12:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="JqqsIKM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2021F833BF; Wed, 13 Aug 2025 12:11:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB6A82C84
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6812F25C5F;
 Wed, 13 Aug 2025 12:11:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pxkzUaE09FH; Wed, 13 Aug 2025 12:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1755079875; bh=MVf5PNktutmj+iz5KgmZho71m8jKdQnwXhhpOeVIu9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JqqsIKM5Ojc0HOPhwGYZR0vJ7CIw0HlRffedX1YI79JL6wuheoQE9n763f4rumd5O
 hc7rcNKa8/RQICTVCXVNBFiEnX2XWdUkyDzD424W17s5eFcP9P9233XCe6XTlCXHvn
 VCg102hE2NU/dCLRRwij+XlieDgEKelpXPdGiOlOBZPWOaa6qsgSl1FujP4c3LuuN4
 E6T7cOQ0OKSeGgGS9TnWpcek0kIfBNM9Zx71cpiHpby6vm99jud5A0HrdLZRuZ8c3E
 dETmLJB3GOWRO+qvMxh1keSIpokMqxekyG5vf0bp0mMSrBUUiMc5qTJ+DyfUQv/R8C
 YVuMoHJAUWRkw==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 4/4] dts: th1520: Switch to upstream devicetree
Date: Wed, 13 Aug 2025 10:09:27 +0000
Message-ID: <20250813100926.51725-6-ziyao@disroot.org>
In-Reply-To: <20250813100926.51725-2-ziyao@disroot.org>
References: <20250813100926.51725-2-ziyao@disroot.org>
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

Imply OF_UPSTREAM in platform Kconfig option and adapt existing boards
to use the correct upstream devicetree paths.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 .../dts/th1520-lichee-module-4a-u-boot.dtsi   |  10 +
 arch/riscv/dts/th1520-lichee-module-4a.dtsi   | 164 ------
 .../riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi |  27 +
 arch/riscv/dts/th1520-lichee-pi-4a.dts        |  33 --
 arch/riscv/dts/th1520-u-boot.dtsi             |  44 ++
 arch/riscv/dts/th1520.dtsi                    | 530 ------------------
 configs/th1520_lpi4a_defconfig                |   2 +-
 9 files changed, 83 insertions(+), 729 deletions(-)
 create mode 100644 arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-pi-4a.dts
 create mode 100644 arch/riscv/dts/th1520-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520.dtsi

diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index c73462c04b8..a02f5f24906 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -21,3 +21,4 @@ config THEAD_TH1520
 	imply SPL_CPU
 	imply SPL_OPENSBI
 	imply SPL_LOAD_FIT
+	imply OF_UPSTREAM
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 2b10c2d6c01..1b2e8dd3d4e 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
diff --git a/arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi b/arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
new file mode 100644
index 00000000000..bbfa3c499cf
--- /dev/null
+++ b/arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include "th1520-u-boot.dtsi"
+
+&{/memory@0} {
+	bootph-pre-ram;
+};
diff --git a/arch/riscv/dts/th1520-lichee-module-4a.dtsi b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
deleted file mode 100644
index eecd3e9832a..00000000000
--- a/arch/riscv/dts/th1520-lichee-module-4a.dtsi
+++ /dev/null
@@ -1,164 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-/dts-v1/;
-
-#include "th1520.dtsi"
-
-/ {
-	model = "Sipeed Lichee Module 4A";
-	compatible = "sipeed,lichee-module-4a", "thead,th1520";
-
-	aliases {
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x00000000 0x2 0x00000000>;
-		bootph-pre-ram;
-	};
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&osc_32k {
-	clock-frequency = <32768>;
-};
-
-&emmc {
-	bus-width = <8>;
-	max-frequency = <198000000>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	non-removable;
-	no-sdio;
-	no-sd;
-	status = "okay";
-};
-
-&gmac0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&gmac0_pins>, <&mdio0_pins>;
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
-
-&gmac1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&gmac1_pins>;
-	phy-handle = <&phy1>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
-
-&mdio0 {
-	phy0: ethernet-phy@1 {
-		reg = <1>;
-	};
-
-	phy1: ethernet-phy@2 {
-		reg = <2>;
-	};
-};
-
-&padctrl0_apsys {
-	gmac0_pins: gmac0-0 {
-		tx-pins {
-			pins = "GMAC0_TX_CLK",
-			       "GMAC0_TXEN",
-			       "GMAC0_TXD0",
-			       "GMAC0_TXD1",
-			       "GMAC0_TXD2",
-			       "GMAC0_TXD3";
-			function = "gmac0";
-			bias-disable;
-			drive-strength = <25>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pins = "GMAC0_RX_CLK",
-			       "GMAC0_RXDV",
-			       "GMAC0_RXD0",
-			       "GMAC0_RXD1",
-			       "GMAC0_RXD2",
-			       "GMAC0_RXD3";
-			function = "gmac0";
-			bias-disable;
-			drive-strength = <1>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	gmac1_pins: gmac1-0 {
-		tx-pins {
-			pins = "GPIO2_18", /* GMAC1_TX_CLK */
-			       "GPIO2_20", /* GMAC1_TXEN */
-			       "GPIO2_21", /* GMAC1_TXD0 */
-			       "GPIO2_22", /* GMAC1_TXD1 */
-			       "GPIO2_23", /* GMAC1_TXD2 */
-			       "GPIO2_24"; /* GMAC1_TXD3 */
-			function = "gmac1";
-			bias-disable;
-			drive-strength = <25>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pins = "GPIO2_19", /* GMAC1_RX_CLK */
-			       "GPIO2_25", /* GMAC1_RXDV */
-			       "GPIO2_30", /* GMAC1_RXD0 */
-			       "GPIO2_31", /* GMAC1_RXD1 */
-			       "GPIO3_0",  /* GMAC1_RXD2 */
-			       "GPIO3_1";  /* GMAC1_RXD3 */
-			function = "gmac1";
-			bias-disable;
-			drive-strength = <1>;
-			input-enable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	mdio0_pins: mdio0-0 {
-		mdc-pins {
-			pins = "GMAC0_MDC";
-			function = "gmac0";
-			bias-disable;
-			drive-strength = <13>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mdio-pins {
-			pins = "GMAC0_MDIO";
-			function = "gmac0";
-			bias-disable;
-			drive-strength = <13>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&sdio0 {
-	bus-width = <4>;
-	max-frequency = <198000000>;
-	status = "okay";
-};
diff --git a/arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi b/arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
new file mode 100644
index 00000000000..06d4a70d1ea
--- /dev/null
+++ b/arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include "th1520-lichee-module-4a-u-boot.dtsi"
+#include "thead-th1520-binman.dtsi"
+
+&clk {
+	bootph-some-ram;
+};
+
+&padctrl0_apsys {
+	bootph-some-ram;
+};
+
+&uart0_pins {
+	bootph-some-ram;
+
+	tx-pins {
+		bootph-some-ram;
+	};
+
+	rx-pins {
+		bootph-some-ram;
+	};
+};
diff --git a/arch/riscv/dts/th1520-lichee-pi-4a.dts b/arch/riscv/dts/th1520-lichee-pi-4a.dts
deleted file mode 100644
index 49af88b7adf..00000000000
--- a/arch/riscv/dts/th1520-lichee-pi-4a.dts
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include "th1520-lichee-module-4a.dtsi"
-#include "thead-th1520-binman.dtsi"
-
-/ {
-	model = "Sipeed Lichee Pi 4A";
-	compatible = "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead,th1520";
-
-	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &uart5;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/th1520-u-boot.dtsi b/arch/riscv/dts/th1520-u-boot.dtsi
new file mode 100644
index 00000000000..45ffccbb847
--- /dev/null
+++ b/arch/riscv/dts/th1520-u-boot.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+&{/soc} {
+	ddrc: ddrc@fffd000000 {
+		compatible = "thead,th1520-ddrc";
+		reg = <0xff 0xfd000000 0x0 0x1000000>,
+		      <0xff 0xfe000000 0x0 0x1000000>,
+		      <0xff 0xff000000 0x0 0x4000>,
+		      <0xff 0xff005000 0x0 0x1000>;
+		reg-names = "phy-0", "phy-1", "ctrl", "sys";
+		bootph-pre-ram;
+	};
+};
+
+&cpus {
+	bootph-pre-ram;
+};
+
+&c910_0 {
+	bootph-pre-ram;
+};
+
+&c910_1 {
+	bootph-pre-ram;
+};
+
+&c910_2 {
+	bootph-pre-ram;
+};
+
+&c910_3 {
+	bootph-pre-ram;
+};
+
+&clint {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
deleted file mode 100644
index c46925a132a..00000000000
--- a/arch/riscv/dts/th1520.dtsi
+++ /dev/null
@@ -1,530 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021 Alibaba Group Holding Limited.
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include <dt-bindings/clock/thead,th1520-clk-ap.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "thead,th1520";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus: cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		bootph-pre-ram;
-		timebase-frequency = <3000000>;
-
-		c910_0: cpu@0 {
-			compatible = "thead,c910", "riscv";
-			device_type = "cpu";
-			riscv,isa = "rv64imafdc";
-			reg = <0>;
-			bootph-pre-ram;
-			i-cache-block-size = <64>;
-			i-cache-size = <65536>;
-			i-cache-sets = <512>;
-			d-cache-block-size = <64>;
-			d-cache-size = <65536>;
-			d-cache-sets = <512>;
-			next-level-cache = <&l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		c910_1: cpu@1 {
-			compatible = "thead,c910", "riscv";
-			device_type = "cpu";
-			riscv,isa = "rv64imafdc";
-			reg = <1>;
-			bootph-pre-ram;
-			i-cache-block-size = <64>;
-			i-cache-size = <65536>;
-			i-cache-sets = <512>;
-			d-cache-block-size = <64>;
-			d-cache-size = <65536>;
-			d-cache-sets = <512>;
-			next-level-cache = <&l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu1_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		c910_2: cpu@2 {
-			compatible = "thead,c910", "riscv";
-			device_type = "cpu";
-			riscv,isa = "rv64imafdc";
-			reg = <2>;
-			bootph-pre-ram;
-			i-cache-block-size = <64>;
-			i-cache-size = <65536>;
-			i-cache-sets = <512>;
-			d-cache-block-size = <64>;
-			d-cache-size = <65536>;
-			d-cache-sets = <512>;
-			next-level-cache = <&l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu2_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		c910_3: cpu@3 {
-			compatible = "thead,c910", "riscv";
-			device_type = "cpu";
-			riscv,isa = "rv64imafdc";
-			reg = <3>;
-			bootph-pre-ram;
-			i-cache-block-size = <64>;
-			i-cache-size = <65536>;
-			i-cache-sets = <512>;
-			d-cache-block-size = <64>;
-			d-cache-size = <65536>;
-			d-cache-sets = <512>;
-			next-level-cache = <&l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu3_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		l2_cache: l2-cache {
-			compatible = "cache";
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-size = <1048576>;
-			cache-sets = <1024>;
-			cache-unified;
-		};
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc_24m";
-		#clock-cells = <0>;
-	};
-
-	osc_32k: 32k-oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc_32k";
-		#clock-cells = <0>;
-	};
-
-	aonsys_clk: clock-73728000 {
-		compatible = "fixed-clock";
-		clock-frequency = <73728000>;
-		clock-output-names = "aonsys_clk";
-		#clock-cells = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		plic: interrupt-controller@ffd8000000 {
-			compatible = "thead,th1520-plic", "thead,c900-plic";
-			reg = <0xff 0xd8000000 0x0 0x01000000>;
-			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
-					      <&cpu1_intc 11>, <&cpu1_intc 9>,
-					      <&cpu2_intc 11>, <&cpu2_intc 9>,
-					      <&cpu3_intc 11>, <&cpu3_intc 9>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			riscv,ndev = <240>;
-		};
-
-		clint: timer@ffdc000000 {
-			compatible = "thead,th1520-clint", "thead,c900-clint";
-			reg = <0xff 0xdc000000 0x0 0x00010000>;
-			bootph-pre-ram;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
-					      <&cpu1_intc 3>, <&cpu1_intc 7>,
-					      <&cpu2_intc 3>, <&cpu2_intc 7>,
-					      <&cpu3_intc 3>, <&cpu3_intc 7>;
-		};
-
-		uart0: serial@ffe7014000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xe7014000 0x0 0x100>;
-			bootph-pre-ram;
-			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART0_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		gmac1: ethernet@ffe7060000 {
-			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
-			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
-			reg-names = "dwmac", "apb";
-			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
-			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>;
-			clock-names = "stmmaceth", "pclk";
-			snps,pbl = <32>;
-			snps,fixed-burst;
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <32>;
-			status = "disabled";
-
-			mdio1: mdio {
-				compatible = "snps,dwmac-mdio";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-		};
-
-		gmac0: ethernet@ffe7070000 {
-			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
-			reg = <0xff 0xe7070000 0x0 0x2000>, <0xff 0xec003000 0x0 0x1000>;
-			reg-names = "dwmac", "apb";
-			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
-			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>;
-			clock-names = "stmmaceth", "pclk";
-			snps,pbl = <32>;
-			snps,fixed-burst;
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <32>;
-			status = "disabled";
-
-			mdio0: mdio {
-				compatible = "snps,dwmac-mdio";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-		};
-
-		emmc: mmc@ffe7080000 {
-			compatible = "thead,th1520-dwcmshc";
-			reg = <0xff 0xe7080000 0x0 0x10000>;
-			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
-			clock-names = "core";
-			status = "disabled";
-		};
-
-		sdio0: mmc@ffe7090000 {
-			compatible = "thead,th1520-dwcmshc";
-			reg = <0xff 0xe7090000 0x0 0x10000>;
-			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
-			clock-names = "core";
-			status = "disabled";
-		};
-
-		sdio1: mmc@ffe70a0000 {
-			compatible = "thead,th1520-dwcmshc";
-			reg = <0xff 0xe70a0000 0x0 0x10000>;
-			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
-			clock-names = "core";
-			status = "disabled";
-		};
-
-		uart1: serial@ffe7f00000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xe7f00000 0x0 0x100>;
-			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART1_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@ffe7f04000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xe7f04000 0x0 0x100>;
-			interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART3_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		gpio2: gpio@ffe7f34000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xe7f34000 0x0 0x1000>;
-			clocks = <&clk CLK_GPIO2>;
-			clock-names = "bus";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portc: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio3: gpio@ffe7f38000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xe7f38000 0x0 0x1000>;
-			clocks = <&clk CLK_GPIO3>;
-			clock-names = "bus";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portd: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <59 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		padctrl1_apsys: pinctrl@ffe7f3c000 {
-			compatible = "thead,th1520-pinctrl";
-			reg = <0xff 0xe7f3c000 0x0 0x1000>;
-			clocks = <&clk CLK_PADCTRL1>;
-			thead,pad-group = <2>;
-		};
-
-		gpio0: gpio@ffec005000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xec005000 0x0 0x1000>;
-			clocks = <&clk CLK_GPIO0>;
-			clock-names = "bus";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			porta: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		gpio1: gpio@ffec006000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xec006000 0x0 0x1000>;
-			clocks = <&clk CLK_GPIO1>;
-			clock-names = "bus";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portb: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		padctrl0_apsys: pinctrl@ffec007000 {
-			compatible = "thead,th1520-pinctrl";
-			reg = <0xff 0xec007000 0x0 0x1000>;
-			clocks = <&clk CLK_PADCTRL0>;
-			thead,pad-group = <3>;
-		};
-
-		uart2: serial@ffec010000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xec010000 0x0 0x4000>;
-			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART2_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		clk: clock-controller@ffef010000 {
-			compatible = "thead,th1520-clk-ap";
-			reg = <0xff 0xef010000 0x0 0x1000>;
-			clocks = <&osc>;
-			#clock-cells = <1>;
-		};
-
-		timer0: timer@ffefc32000 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xefc32000 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer1: timer@ffefc32014 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xefc32014 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer2: timer@ffefc32028 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xefc32028 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer3: timer@ffefc3203c {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xefc3203c 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		uart4: serial@fff7f08000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xf7f08000 0x0 0x4000>;
-			interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART4_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart5: serial@fff7f0c000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0xff 0xf7f0c000 0x0 0x4000>;
-			interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART5_PCLK>;
-			clock-names = "buadclk", "apb_pclk";
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		ddrc: ddrc@fffd000000 {
-			compatible = "thead,th1520-ddrc";
-			reg = <0xff 0xfd000000 0x0 0x1000000>,
-			      <0xff 0xfe000000 0x0 0x1000000>,
-			      <0xff 0xff000000 0x0 0x4000>,
-			      <0xff 0xff005000 0x0 0x1000>;
-			reg-names = "phy-0", "phy-1", "ctrl", "sys";
-			bootph-pre-ram;
-		};
-
-		timer4: timer@ffffc33000 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xffc33000 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer5: timer@ffffc33014 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xffc33014 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer6: timer@ffffc33028 {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xffc33028 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		timer7: timer@ffffc3303c {
-			compatible = "snps,dw-apb-timer";
-			reg = <0xff 0xffc3303c 0x0 0x14>;
-			clocks = <&clk CLK_PERI_APB_PCLK>;
-			clock-names = "timer";
-			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		ao_gpio0: gpio@fffff41000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xfff41000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			porte: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <76 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		padctrl_aosys: pinctrl@fffff4a000 {
-			compatible = "thead,th1520-pinctrl";
-			reg = <0xff 0xfff4a000 0x0 0x2000>;
-			clocks = <&aonsys_clk>;
-			thead,pad-group = <1>;
-		};
-
-		ao_gpio1: gpio@fffff52000 {
-			compatible = "snps,dw-apb-gpio";
-			reg = <0xff 0xfff52000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			portf: gpio-controller@0 {
-				compatible = "snps,dw-apb-gpio-port";
-				gpio-controller;
-				#gpio-cells = <2>;
-				ngpios = <32>;
-				reg = <0>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-	};
-};
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 731fe378ac8..1039c2ac54e 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="th1520-lichee-pi-4a"
+CONFIG_DEFAULT_DEVICE_TREE="thead/th1520-lichee-pi-4a"
 CONFIG_SPL_STACK=0xffe0170000
 CONFIG_SPL_BSS_START_ADDR=0xffe0160000
 CONFIG_SPL_BSS_MAX_SIZE=0x10000
-- 
2.50.1

