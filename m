Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A12DE7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 09:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E208280691;
	Fri, 10 Jan 2025 10:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="kGpzKmaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE4C80628; Fri, 10 Jan 2025 10:13:16 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC03800C2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 10:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1a80de4ccf3311ef99858b75a2457dd9-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Uk/cNBR+3OB/wDLsGrJqqSef3AjO+O6tl4btwlqmkbU=; 
 b=kGpzKmaVoKRX5Qcuti4lCr56bQLp13UpFoMH9oVqN+F/TOJWV6szKi3WV+lRYYNscGd5iDJpcRnGAulP91oQN4wYT268VcraeeTDlq9tZgnux7Z+1MtbSLeXRtfL5F8+W489JQZU/RXS0ixwtwVcQBVxGJ1lFhV1r3d0bR15aEE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:86314888-c3d2-41a4-b760-a00ab0a22cf5, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:39514c13-8831-4185-8e40-f83b1917e828,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a80de4ccf3311ef99858b75a2457dd9-20250110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1618124454; Fri, 10 Jan 2025 17:13:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 17:13:05 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 17:13:04 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH 2/2] board: mediatek: mt7629: Migrate to OF_UPSTREAM
Date: Fri, 10 Jan 2025 17:13:03 +0800
Message-ID: <06ae21548c40fd1cf179fbaab6cbc13a38fbcd8e.1736500023.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1736500023.git.weijie.gao@mediatek.com>
References: <cover.1736500023.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

From: Sam Shih <sam.shih@mediatek.com>

Move differences in DT files between upstream Linux DT and U-Boot DT to
mt7629-rfb-u-boot.dtsi.
Remove old copies of mt7629-related clock bindings, .dts, and .dtsi files.
Update defconfig to switch the whole mt7629 SoC to use OF_UPSTREAM.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7629-rfb-u-boot.dtsi    | 113 +++++++-
 arch/arm/dts/mt7629-rfb.dts            | 123 ---------
 arch/arm/dts/mt7629.dtsi               | 360 -------------------------
 configs/mt7629_rfb_defconfig           |   3 +-
 include/dt-bindings/clock/mt7629-clk.h | 206 --------------
 5 files changed, 114 insertions(+), 691 deletions(-)
 delete mode 100644 arch/arm/dts/mt7629-rfb.dts
 delete mode 100644 arch/arm/dts/mt7629.dtsi
 delete mode 100644 include/dt-bindings/clock/mt7629-clk.h

diff --git a/arch/arm/dts/mt7629-rfb-u-boot.dtsi b/arch/arm/dts/mt7629-rfb-u-boot.dtsi
index 41170474658..e6203757fd7 100644
--- a/arch/arm/dts/mt7629-rfb-u-boot.dtsi
+++ b/arch/arm/dts/mt7629-rfb-u-boot.dtsi
@@ -5,6 +5,53 @@
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  */
 
+#include <dt-bindings/reset/mt7629-reset.h>
+
+/ {
+	dramc: dramc@10203000 {
+		compatible = "mediatek,mt7629-dramc";
+		reg = <0x10203000 0x600>,	/* EMI */
+		      <0x10213000 0x1000>,	/* DDRPHY */
+		      <0x10214000 0xd00>;	/* DRAMC_AO */
+		clocks = <&topckgen CLK_TOP_DDRPHYCFG_SEL>,
+			 <&topckgen CLK_TOP_SYSPLL1_D8>,
+			 <&topckgen CLK_TOP_MEM_SEL>,
+			 <&topckgen CLK_TOP_DMPLL>;
+		clock-names = "phy", "phy_mux", "mem", "mem_mux";
+	};
+
+	mcucfg: syscon@10200000 {
+		compatible = "mediatek,mt7629-mcucfg", "syscon";
+		reg = <0x10200000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	timer0: timer@10004000 {
+		compatible = "mediatek,timer";
+		reg = <0x10004000 0x80>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_CLKXTAL_D4>,
+			 <&topckgen CLK_TOP_10M_SEL>;
+		clock-names = "mux", "src";
+	};
+
+	snand: snand@1100d000 {
+		compatible = "mediatek,mt7629-snand";
+		reg = <0x1100d000 0x1000>,
+		      <0x1100e000 0x1000>;
+		reg-names = "nfi", "ecc";
+		clocks = <&pericfg CLK_PERI_NFI_PD>,
+			 <&pericfg CLK_PERI_SNFI_PD>,
+			 <&pericfg CLK_PERI_NFIECC_PD>;
+		clock-names = "nfi_clk", "pad_clk", "ecc_clk";
+		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>,
+				  <&topckgen CLK_TOP_NFI_INFRA_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>,
+					 <&topckgen CLK_TOP_UNIVPLL2_D8>;
+		status = "disabled";
+	};
+};
+
 &infracfg {
 	bootph-all;
 };
@@ -35,8 +82,72 @@
 
 &uart0 {
 	bootph-all;
+	reg-shift = <2>;
+	assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
+};
+
+&qspi {
+	bootph-all;
+	compatible = "mediatek,mtk-snor";
+	reg = <0x11014000 0x1000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_pins>;
+	status = "okay";
+
+	/delete-node/ flash@0;
+
+	spi-flash@0{
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
+&pio {
+	bootph-all;
+	snfi_pins: snfi-pins {
+		mux {
+			bootph-all;
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+	snor_pins: snor-pins {
+		mux {
+			bootph-all;
+			function = "flash";
+			groups = "spi_nor";
+		};
+	};
 };
 
-&snfi {
+&snand {
+	pinctrl-names = "default";
+	pinctrl-0 = <&snfi_pins>;
+	status = "okay";
+	quad-spi;
 	bootph-all;
 };
+
+&eth {
+	resets = <&ethsys ETHSYS_FE_RST>;
+	reset-names = "fe";
+	status = "okay";
+	mediatek,gmac-id = <0>;
+	phy-mode = "2500base-x";
+	mediatek,switch = "mt7531";
+	reset-gpios = <&pio 28 GPIO_ACTIVE_HIGH>;
+	assigned-clocks = <&topckgen CLK_TOP_ETH_SEL>,
+			  <&topckgen CLK_TOP_F10M_REF_SEL>,
+			  <&topckgen CLK_TOP_SGMII_REF_1_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>,
+				 <&topckgen CLK_TOP_SYSPLL4_D16>,
+				 <&topckgen CLK_TOP_SGMIIPLL_D2>;
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+	};
+};
diff --git a/arch/arm/dts/mt7629-rfb.dts b/arch/arm/dts/mt7629-rfb.dts
deleted file mode 100644
index f347725f2f6..00000000000
--- a/arch/arm/dts/mt7629-rfb.dts
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * Copyright (C) 2018 MediaTek Inc.
- * Author: Ryder Lee <ryder.lee@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
- */
-
-/dts-v1/;
-#include "mt7629.dtsi"
-#include "mt7629-rfb-u-boot.dtsi"
-
-/ {
-	model = "MediaTek MT7629 RFB";
-	compatible = "mediatek,mt7629-rfb", "mediatek,mt7629";
-
-	aliases {
-		spi0 = &snor;
-	};
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&eth {
-	status = "okay";
-	mediatek,gmac-id = <0>;
-	phy-mode = "2500base-x";
-	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
-
-	fixed-link {
-		speed = <2500>;
-		full-duplex;
-	};
-};
-
-&pinctrl {
-	state_default: pinmux_conf {
-		bootph-all;
-
-		mux {
-			function = "jtag";
-			groups = "ephy_leds_jtag";
-			bootph-all;
-		};
-	};
-
-	snfi_pins: snfi-pins {
-		mux {
-			function = "flash";
-			groups = "snfi";
-		};
-	};
-
-	snor_pins: snor-pins {
-		mux {
-			function = "flash";
-			groups = "spi_nor";
-		};
-	};
-
-	uart0_pins: uart0-default {
-		mux {
-			function = "uart";
-			groups = "uart0_txd_rxd";
-		};
-	};
-
-	watchdog_pins: watchdog-default {
-		mux {
-			function = "watchdog";
-			groups = "watchdog";
-		};
-	};
-};
-
-&snfi {
-	pinctrl-names = "default", "snfi";
-	pinctrl-0 = <&snor_pins>;
-	pinctrl-1 = <&snfi_pins>;
-	status = "disabled";
-
-	spi-flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		bootph-all;
-	};
-};
-
-&snor {
-	pinctrl-names = "default";
-	pinctrl-0 = <&snor_pins>;
-	status = "okay";
-
-	spi-flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		bootph-all;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&xhci {
-	status = "okay";
-};
-
-&u3phy {
-	status = "okay";
-};
-
-&watchdog {
-	pinctrl-names = "default";
-	pinctrl-0 = <&watchdog_pins>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/mt7629.dtsi b/arch/arm/dts/mt7629.dtsi
deleted file mode 100644
index cd8277deafe..00000000000
--- a/arch/arm/dts/mt7629.dtsi
+++ /dev/null
@@ -1,360 +0,0 @@
-/*
- * Copyright (C) 2018 MediaTek Inc.
- * Author: Ryder Lee <ryder.lee@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
- */
-
-#include <dt-bindings/clock/mt7629-clk.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/mt7629-power.h>
-#include <dt-bindings/reset/mt7629-reset.h>
-#include <dt-bindings/phy/phy.h>
-#include "skeleton.dtsi"
-
-/ {
-	compatible = "mediatek,mt7629";
-	interrupt-parent = <&sysirq>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-method = "mediatek,mt6589-smp";
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			clock-frequency = <1250000000>;
-		};
-
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			clock-frequency = <1250000000>;
-		};
-	};
-
-	clk20m: oscillator@0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <20000000>;
-		clock-output-names = "clk20m";
-	};
-
-	clk40m: oscillator@1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <40000000>;
-		clock-output-names = "clkxtal";
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		clock-frequency = <20000000>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	infracfg: syscon@10000000 {
-		compatible = "mediatek,mt7629-infracfg", "syscon";
-		reg = <0x10000000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	pericfg: syscon@10002000 {
-		compatible = "mediatek,mt7629-pericfg", "syscon";
-		reg = <0x10002000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	timer0: timer@10004000 {
-		compatible = "mediatek,timer";
-		reg = <0x10004000 0x80>;
-		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_CLKXTAL_D4>,
-			 <&topckgen CLK_TOP_10M_SEL>;
-		clock-names = "mux", "src";
-	};
-
-	scpsys: scpsys@10006000 {
-		compatible = "mediatek,mt7629-scpsys";
-		reg = <0x10006000 0x1000>;
-		clocks = <&topckgen CLK_TOP_HIF_SEL>;
-		clock-names = "hif_sel";
-		assigned-clocks = <&topckgen CLK_TOP_HIF_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
-		#power-domain-cells = <1>;
-		infracfg = <&infracfg>;
-	};
-
-	mcucfg: syscon@10200000 {
-		compatible = "mediatek,mt7629-mcucfg", "syscon";
-		reg = <0x10200000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	sysirq: interrupt-controller@10200a80 {
-		compatible = "mediatek,sysirq";
-		reg = <0x10200a80 0x20>;
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-	};
-
-	dramc: dramc@10203000 {
-		compatible = "mediatek,mt7629-dramc";
-		reg = <0x10203000 0x600>,	/* EMI */
-		      <0x10213000 0x1000>,	/* DDRPHY */
-		      <0x10214000 0xd00>;	/* DRAMC_AO */
-		clocks = <&topckgen CLK_TOP_DDRPHYCFG_SEL>,
-			 <&topckgen CLK_TOP_SYSPLL1_D8>,
-			 <&topckgen CLK_TOP_MEM_SEL>,
-			 <&topckgen CLK_TOP_DMPLL>;
-		clock-names = "phy", "phy_mux", "mem", "mem_mux";
-	};
-
-	apmixedsys: clock-controller@10209000 {
-		compatible = "mediatek,mt7629-apmixedsys";
-		reg = <0x10209000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	topckgen: clock-controller@10210000 {
-		compatible = "mediatek,mt7629-topckgen";
-		reg = <0x10210000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	watchdog: watchdog@10212000 {
-		compatible = "mediatek,wdt";
-		reg = <0x10212000 0x600>;
-		interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_FALLING>;
-		#reset-cells = <1>;
-		status = "disabled";
-	};
-
-	wdt-reboot {
-		compatible = "wdt-reboot";
-		wdt = <&watchdog>;
-	};
-
-	pinctrl: pinctrl@10217000 {
-		compatible = "mediatek,mt7629-pinctrl";
-		reg = <0x10217000 0x8000>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&state_default>;
-
-		state_default: pinmux_conf {
-		};
-
-		gpio: gpio-controller {
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-	};
-
-	gic: interrupt-controller@10300000 {
-		compatible = "arm,gic-400";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		reg = <0x10310000 0x1000>,
-		      <0x10320000 0x1000>,
-		      <0x10340000 0x2000>,
-		      <0x10360000 0x2000>;
-	};
-
-	uart0: serial@11002000 {
-		compatible = "mediatek,hsuart";
-		reg = <0x11002000 0x400>;
-		reg-shift = <2>;
-		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_UART_SEL>,
-			 <&pericfg CLK_PERI_UART0_PD>;
-		clock-names = "baud", "bus";
-		status = "disabled";
-		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
-	};
-
-	uart1: serial@11003000 {
-		compatible = "mediatek,hsuart";
-		reg = <0x11003000 0x400>;
-		reg-shift = <2>;
-		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_UART_SEL>,
-			 <&pericfg CLK_PERI_UART1_PD>;
-		clock-names = "baud", "bus";
-		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
-		status = "disabled";
-	};
-
-	uart2: serial@11004000 {
-		compatible = "mediatek,hsuart";
-		reg = <0x11004000 0x400>;
-		reg-shift = <2>;
-		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_UART_SEL>,
-			 <&pericfg CLK_PERI_UART2_PD>;
-		clock-names = "baud", "bus";
-		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
-		status = "disabled";
-	};
-
-	snfi: snfi@1100d000 {
-		compatible = "mediatek,mtk-snfi-spi";
-		reg = <0x1100d000 0x2000>;
-		clocks = <&pericfg CLK_PERI_NFI_PD>,
-			 <&pericfg CLK_PERI_SNFI_PD>;
-		clock-names = "nfi_clk", "pad_clk";
-		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>,
-				  <&topckgen CLK_TOP_NFI_INFRA_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>,
-					 <&topckgen CLK_TOP_UNIVPLL2_D8>;
-		status = "disabled";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	snor: snor@11014000 {
-		compatible = "mediatek,mtk-snor";
-		reg = <0x11014000 0x1000>;
-		clocks = <&pericfg CLK_PERI_FLASH_PD>,
-			 <&topckgen CLK_TOP_FLASH_SEL>;
-		clock-names = "spi", "sf";
-		status = "disabled";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	ssusbsys: ssusbsys@1a000000 {
-		compatible = "mediatek,mt7629-ssusbsys", "syscon";
-		reg = <0x1a000000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	xhci: usb@1a0c0000 {
-		compatible = "mediatek,mt7629-xhci", "mediatek,mtk-xhci";
-		reg = <0x1a0c0000 0x1000>, <0x1a0c3e00 0x0100>;
-		reg-names = "mac", "ippc";
-		power-domains = <&scpsys MT7629_POWER_DOMAIN_HIF1>;
-		clocks = <&ssusbsys CLK_SSUSB_SYS_EN>,
-			 <&ssusbsys CLK_SSUSB_REF_EN>,
-			 <&ssusbsys CLK_SSUSB_MCU_EN>,
-			 <&ssusbsys CLK_SSUSB_DMA_EN>;
-		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
-		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
-		status = "disabled";
-	};
-
-	u3phy: usb-phy@1a0c4000 {
-		compatible = "mediatek,mt7629-tphy", "mediatek,generic-tphy-v2";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x1a0c4000 0x1000>;
-		status = "disabled";
-
-		u2port0: usb-phy@0 {
-			reg = <0x0 0x0700>;
-			#phy-cells = <1>;
-			clocks = <&ssusbsys CLK_SSUSB_U2_PHY_EN>;
-			clock-names = "ref";
-		};
-
-		u3port0: usb-phy@700 {
-			reg = <0x0700 0x0700>;
-			#phy-cells = <1>;
-		};
-	};
-
-	ethsys: syscon@1b000000 {
-		compatible = "mediatek,mt7629-ethsys", "syscon";
-		reg = <0x1b000000 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7629-eth", "syscon";
-		reg = <0x1b100000 0x20000>;
-		clocks = <&topckgen CLK_TOP_ETH_SEL>,
-			<&topckgen CLK_TOP_F10M_REF_SEL>,
-			<&ethsys CLK_ETH_ESW_EN>,
-			<&ethsys CLK_ETH_GP0_EN>,
-			<&ethsys CLK_ETH_GP1_EN>,
-			<&ethsys CLK_ETH_GP2_EN>,
-			<&ethsys CLK_ETH_FE_EN>,
-			<&sgmiisys0 CLK_SGMII_TX_EN>,
-			<&sgmiisys0 CLK_SGMII_RX_EN>,
-			<&sgmiisys0 CLK_SGMII_CDR_REF>,
-			<&sgmiisys0 CLK_SGMII_CDR_FB>,
-			<&sgmiisys1 CLK_SGMII_TX_EN>,
-			<&sgmiisys1 CLK_SGMII_RX_EN>,
-			<&sgmiisys1 CLK_SGMII_CDR_REF>,
-			<&sgmiisys1 CLK_SGMII_CDR_FB>,
-			<&apmixedsys CLK_APMIXED_SGMIPLL>,
-			<&apmixedsys CLK_APMIXED_ETH2PLL>;
-		clock-names = "ethif", "sgmiitop", "esw", "gp0", "gp1", "gp2",
-				"fe", "sgmii_tx250m", "sgmii_rx250m",
-				"sgmii_cdr_ref", "sgmii_cdr_fb",
-				"sgmii2_tx250m", "sgmii2_rx250m",
-				"sgmii2_cdr_ref", "sgmii2_cdr_fb",
-				"sgmii_ck", "eth2pll";
-		assigned-clocks = <&topckgen CLK_TOP_ETH_SEL>,
-				  <&topckgen CLK_TOP_F10M_REF_SEL>,
-				  <&topckgen CLK_TOP_SGMII_REF_1_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>,
-					 <&topckgen CLK_TOP_SYSPLL4_D16>,
-					 <&topckgen CLK_TOP_SGMIIPLL_D2>;
-		power-domains = <&scpsys MT7629_POWER_DOMAIN_ETHSYS>;
-		resets = <&ethsys ETHSYS_FE_RST>;
-		reset-names = "fe";
-		mediatek,ethsys = <&ethsys>;
-		mediatek,sgmiisys = <&sgmiisys0>;
-		mediatek,infracfg = <&infracfg>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	sgmiisys0: syscon@1b128000 {
-		compatible = "mediatek,mt7629-sgmiisys", "syscon";
-		reg = <0x1b128000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	sgmiisys1: syscon@1b130000 {
-		compatible = "mediatek,mt7629-sgmiisys", "syscon";
-		reg = <0x1b130000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-	pwm: pwm@11006000 {
-		compatible = "mediatek,mt7629-pwm";
-		reg = <0x11006000 0x1000>;
-		#clock-cells = <1>;
-		#pwm-cells = <2>;
-		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_PWM_SEL>,
-			 <&pericfg CLK_PERI_PWM_PD>,
-			 <&pericfg CLK_PERI_PWM1_PD>;
-		clock-names = "top", "main", "pwm1";
-		assigned-clocks = <&topckgen CLK_TOP_PWM_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL2_D4>;
-		status = "disabled";
-	};
-
-};
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index abdf3d0cc49..4acf521e7fd 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41fffef0
 CONFIG_ENV_SIZE=0x1000
-CONFIG_DEFAULT_DEVICE_TREE="mt7629-rfb"
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt7629-rfb"
 CONFIG_TARGET_MT7629=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -52,6 +52,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/include/dt-bindings/clock/mt7629-clk.h b/include/dt-bindings/clock/mt7629-clk.h
deleted file mode 100644
index 0bbfbfa744a..00000000000
--- a/include/dt-bindings/clock/mt7629-clk.h
+++ /dev/null
@@ -1,206 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 MediaTek Inc.
- */
-
-#ifndef _DT_BINDINGS_CLK_MT7629_H
-#define _DT_BINDINGS_CLK_MT7629_H
-
-/* TOPCKGEN */
-#define CLK_TOP_FCLKS_OFF		0
-
-#define CLK_TOP_TO_U2_PHY		0
-#define CLK_TOP_TO_U2_PHY_1P		1
-#define CLK_TOP_PCIE0_PIPE_EN		2
-#define CLK_TOP_PCIE1_PIPE_EN		3
-#define CLK_TOP_SSUSB_TX250M		4
-#define CLK_TOP_SSUSB_EQ_RX250M		5
-#define CLK_TOP_SSUSB_CDR_REF		6
-#define CLK_TOP_SSUSB_CDR_FB		7
-#define CLK_TOP_SATA_ASIC		8
-#define CLK_TOP_SATA_RBC		9
-
-#define CLK_TOP_TO_USB3_SYS		10
-#define CLK_TOP_P1_1MHZ			11
-#define CLK_TOP_4MHZ			12
-#define CLK_TOP_P0_1MHZ			13
-#define CLK_TOP_ETH_500M		14
-#define CLK_TOP_TXCLK_SRC_PRE		15
-#define CLK_TOP_RTC			16
-#define CLK_TOP_PWM_QTR_26M		17
-#define CLK_TOP_CPUM_TCK_IN		18
-#define CLK_TOP_TO_USB3_DA_TOP		19
-#define CLK_TOP_MEMPLL			20
-#define CLK_TOP_DMPLL			21
-#define CLK_TOP_DMPLL_D4		22
-#define CLK_TOP_DMPLL_D8		23
-#define CLK_TOP_SYSPLL_D2		24
-#define CLK_TOP_SYSPLL1_D2		25
-#define CLK_TOP_SYSPLL1_D4		26
-#define CLK_TOP_SYSPLL1_D8		27
-#define CLK_TOP_SYSPLL1_D16		28
-#define CLK_TOP_SYSPLL2_D2		29
-#define CLK_TOP_SYSPLL2_D4		30
-#define CLK_TOP_SYSPLL2_D8		31
-#define CLK_TOP_SYSPLL_D5		32
-#define CLK_TOP_SYSPLL3_D2		33
-#define CLK_TOP_SYSPLL3_D4		34
-#define CLK_TOP_SYSPLL_D7		35
-#define CLK_TOP_SYSPLL4_D2		36
-#define CLK_TOP_SYSPLL4_D4		37
-#define CLK_TOP_SYSPLL4_D16		38
-#define CLK_TOP_UNIVPLL			39
-#define CLK_TOP_UNIVPLL1_D2		40
-#define CLK_TOP_UNIVPLL1_D4		41
-#define CLK_TOP_UNIVPLL1_D8		42
-#define CLK_TOP_UNIVPLL_D3		43
-#define CLK_TOP_UNIVPLL2_D2		44
-#define CLK_TOP_UNIVPLL2_D4		45
-#define CLK_TOP_UNIVPLL2_D8		46
-#define CLK_TOP_UNIVPLL2_D16		47
-#define CLK_TOP_UNIVPLL_D5		48
-#define CLK_TOP_UNIVPLL3_D2		49
-#define CLK_TOP_UNIVPLL3_D4		50
-#define CLK_TOP_UNIVPLL3_D16		51
-#define CLK_TOP_UNIVPLL_D7		52
-#define CLK_TOP_UNIVPLL_D80_D4		53
-#define CLK_TOP_UNIV48M			54
-#define CLK_TOP_SGMIIPLL_D2		55
-#define CLK_TOP_CLKXTAL_D4		56
-#define CLK_TOP_HD_FAXI			57
-#define CLK_TOP_FAXI			58
-#define CLK_TOP_F_FAUD_INTBUS		59
-#define CLK_TOP_AP2WBHIF_HCLK		60
-#define CLK_TOP_10M_INFRAO		61
-#define CLK_TOP_MSDC30_1		62
-#define CLK_TOP_SPI			63
-#define CLK_TOP_SF			64
-#define CLK_TOP_FLASH			65
-#define CLK_TOP_TO_USB3_REF		66
-#define CLK_TOP_TO_USB3_MCU		67
-#define CLK_TOP_TO_USB3_DMA		68
-#define CLK_TOP_FROM_TOP_AHB		69
-#define CLK_TOP_FROM_TOP_AXI		70
-#define CLK_TOP_PCIE1_MAC_EN		71
-#define CLK_TOP_PCIE0_MAC_EN		72
-
-#define CLK_TOP_AXI_SEL			73
-#define CLK_TOP_MEM_SEL			74
-#define CLK_TOP_DDRPHYCFG_SEL		75
-#define CLK_TOP_ETH_SEL			76
-#define CLK_TOP_PWM_SEL			77
-#define CLK_TOP_F10M_REF_SEL		78
-#define CLK_TOP_NFI_INFRA_SEL		79
-#define CLK_TOP_FLASH_SEL		80
-#define CLK_TOP_UART_SEL		81
-#define CLK_TOP_SPI0_SEL		82
-#define CLK_TOP_SPI1_SEL		83
-#define CLK_TOP_MSDC50_0_SEL		84
-#define CLK_TOP_MSDC30_0_SEL		85
-#define CLK_TOP_MSDC30_1_SEL		86
-#define CLK_TOP_AP2WBMCU_SEL		87
-#define CLK_TOP_AP2WBHIF_SEL		88
-#define CLK_TOP_AUDIO_SEL		89
-#define CLK_TOP_AUD_INTBUS_SEL		90
-#define CLK_TOP_PMICSPI_SEL		91
-#define CLK_TOP_SCP_SEL			92
-#define CLK_TOP_ATB_SEL			93
-#define CLK_TOP_HIF_SEL			94
-#define CLK_TOP_SATA_SEL		95
-#define CLK_TOP_U2_SEL			96
-#define CLK_TOP_AUD1_SEL		97
-#define CLK_TOP_AUD2_SEL		98
-#define CLK_TOP_IRRX_SEL		99
-#define CLK_TOP_IRTX_SEL		100
-#define CLK_TOP_SATA_MCU_SEL		101
-#define CLK_TOP_PCIE0_MCU_SEL		102
-#define CLK_TOP_PCIE1_MCU_SEL		103
-#define CLK_TOP_SSUSB_MCU_SEL		104
-#define CLK_TOP_CRYPTO_SEL		105
-#define CLK_TOP_SGMII_REF_1_SEL		106
-#define CLK_TOP_10M_SEL			107
-#define CLK_TOP_NR_CLK			108
-
-/* INFRACFG */
-#define CLK_INFRA_MUX1_SEL		0
-#define CLK_INFRA_DBGCLK_PD		1
-#define CLK_INFRA_TRNG_PD		2
-#define CLK_INFRA_DEVAPC_PD		3
-#define CLK_INFRA_APXGPT_PD		4
-#define CLK_INFRA_SEJ_PD		5
-#define CLK_INFRA_NR_CLK		6
-
-/* PERICFG */
-#define CLK_PERIBUS_SEL			0
-#define CLK_PERI_PWM1_PD		1
-#define CLK_PERI_PWM2_PD		2
-#define CLK_PERI_PWM3_PD		3
-#define CLK_PERI_PWM4_PD		4
-#define CLK_PERI_PWM5_PD		5
-#define CLK_PERI_PWM6_PD		6
-#define CLK_PERI_PWM7_PD		7
-#define CLK_PERI_PWM_PD			8
-#define CLK_PERI_AP_DMA_PD		9
-#define CLK_PERI_MSDC30_1_PD		10
-#define CLK_PERI_UART0_PD		11
-#define CLK_PERI_UART1_PD		12
-#define CLK_PERI_UART2_PD		13
-#define CLK_PERI_UART3_PD		14
-#define CLK_PERI_BTIF_PD		15
-#define CLK_PERI_I2C0_PD		16
-#define CLK_PERI_SPI0_PD		17
-#define CLK_PERI_SNFI_PD		18
-#define CLK_PERI_NFI_PD			19
-#define CLK_PERI_NFIECC_PD		20
-#define CLK_PERI_FLASH_PD		21
-#define CLK_PERI_NR_CLK			22
-
-/* APMIXEDSYS */
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_MAINPLL		1
-#define CLK_APMIXED_UNIV2PLL		2
-#define CLK_APMIXED_ETH1PLL		3
-#define CLK_APMIXED_ETH2PLL		4
-#define CLK_APMIXED_SGMIPLL		5
-#define CLK_APMIXED_NR_CLK		6
-
-/* SSUSBSYS */
-#define CLK_SSUSB_U2_PHY_1P_EN		0
-#define CLK_SSUSB_U2_PHY_EN		1
-#define CLK_SSUSB_REF_EN		2
-#define CLK_SSUSB_SYS_EN		3
-#define CLK_SSUSB_MCU_EN		4
-#define CLK_SSUSB_DMA_EN		5
-#define CLK_SSUSB_NR_CLK		6
-
-/* PCIESYS */
-#define CLK_PCIE_P1_AUX_EN		0
-#define CLK_PCIE_P1_OBFF_EN		1
-#define CLK_PCIE_P1_AHB_EN		2
-#define CLK_PCIE_P1_AXI_EN		3
-#define CLK_PCIE_P1_MAC_EN		4
-#define CLK_PCIE_P1_PIPE_EN		5
-#define CLK_PCIE_P0_AUX_EN		6
-#define CLK_PCIE_P0_OBFF_EN		7
-#define CLK_PCIE_P0_AHB_EN		8
-#define CLK_PCIE_P0_AXI_EN		9
-#define CLK_PCIE_P0_MAC_EN		10
-#define CLK_PCIE_P0_PIPE_EN		11
-#define CLK_PCIE_NR_CLK			12
-
-/* ETHSYS */
-#define CLK_ETH_FE_EN			0
-#define CLK_ETH_GP2_EN			1
-#define CLK_ETH_GP1_EN			2
-#define CLK_ETH_GP0_EN			3
-#define CLK_ETH_ESW_EN			4
-#define CLK_ETH_NR_CLK			5
-
-/* SGMIISYS */
-#define CLK_SGMII_TX_EN			0
-#define CLK_SGMII_RX_EN			1
-#define CLK_SGMII_CDR_REF		2
-#define CLK_SGMII_CDR_FB		3
-#define CLK_SGMII_NR_CLK		4
-
-#endif /* _DT_BINDINGS_CLK_MT7629_H */
-- 
2.34.1

