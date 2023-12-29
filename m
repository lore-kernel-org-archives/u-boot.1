Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E08C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12B087C09;
	Fri, 29 Dec 2023 18:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dP+VbgZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AF087B92; Fri, 29 Dec 2023 18:47:19 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D215C87BB6
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1Xd088942;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=QmJTQ1aNfzlkwfRgP9NBYLj9cD+7cdgRTXUbYj6Lo/E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dP+VbgZz1CO8nb0VkblXUw9gtn86Iv8mJOSoH+aXa90tDS/ct5a9W4y2rhSCN2l81
 A/BDok7NLMsE+f4zYa2eVbT9CwYlL2bh1DrGYhfSwtonU1aM82DG+3ObLFncDNFB43
 VlzafN9X39Msi5WLmcn8OnCwJ4qr54kS+Y1AEMBI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1aC063421
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl09H122672;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 04/26] arm: dts: k3-am654: pull in dtb update from Linux
Date: Fri, 29 Dec 2023 11:47:01 -0600
Message-ID: <20231229174656.634065-32-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48246; i=bb@ti.com;
 h=from:subject; bh=5BJc1a+XpN/LvjkZz6o2A0T+T9lTrxbZSP1UZYwm9VE=;
 b=owNCWmg5MUFZJlNZrGcXbAAAZX///r7b03/q/Pvets3/9rn+YhM359xzn/b/R/zq79vTv36wA
 RtgGJAADQA0yGmgAGQBoANAyADQAaNBoNNMmmmhkNBiZDQaaaaPQTagaZplPUQBpkNNMgGI000G
 gZMTAhkNBpoDQAwIwRiAYT1DIAaDIxGCGmgDQABhkmnqaDRppoMIBiZDRpkwmQ0AAYQDQGTCGmJ
 kMhgEAA0A00ZMQyAAAAQdWNPxSa0BEWUeXkrAY9ylKI+YVAdBORwOSqk5cWA7Iu3oDKIXx0sQIk
 1nUE+gmJhFHd2DUxsxugvzFEM8DyAT5JYH5gDAlrssW4awScXaGOTzrsqXICvQ9XPyeZV7RYZ40
 8JaqnwhjnX/gHdtS3M1lWeP+ftEcdLlxZW4ccSGeNilbpIsAc7YWsvCVkjhQ+3EKpRkhFWwTzfH
 +E/EaUQxhwuxDug3Nl02OSL5CjhyR3B0ApYDtPtMiKUoFvD6N6ATJclvti3mJnGYvYvl2WAZEds
 gYZmupBifpYLFqp+j8jxJEO2w21dLECb1mA8NFFDU+IvoDdpvhyDhkE2G96NDFE5j4TGL7Oeg/L
 QEL1eS6gB1HCR0FTgPNUyMC9yKHS4DOKjNCO0arkKO3lW1F/tEud3es6sRDDjg29mYjR0tImLdq
 03/i7kinChIVjOLtgA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Pull in dtb updates for the am654 base board from v6.7-rc1 of Linux

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am65-main.dtsi       | 342 ++++++++++++++++++++++-----
 arch/arm/dts/k3-am65-mcu.dtsi        | 156 ++++++++++--
 arch/arm/dts/k3-am65-wakeup.dtsi     |  10 +-
 arch/arm/dts/k3-am65.dtsi            |  19 +-
 arch/arm/dts/k3-am654-base-board.dts | 301 ++++++++++++++---------
 arch/arm/dts/k3-am654.dtsi           |   7 +
 6 files changed, 626 insertions(+), 209 deletions(-)

diff --git a/arch/arm/dts/k3-am65-main.dtsi b/arch/arm/dts/k3-am65-main.dtsi
index ba4e5d3e1ed7a..5ebb87f467de5 100644
--- a/arch/arm/dts/k3-am65-main.dtsi
+++ b/arch/arm/dts/k3-am65-main.dtsi
@@ -35,7 +35,10 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
-		      <0x00 0x01880000 0x00 0x90000>;	/* GICR */
+		      <0x00 0x01880000 0x00 0x90000>,	/* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,	/* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,	/* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;	/* GICV */
 		/*
 		 * vcpumntirq:
 		 * virtual CPU interface maintenance interrupt
@@ -88,6 +91,7 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -96,6 +100,7 @@
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -104,29 +109,47 @@
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	crypto: crypto@4e00000 {
 		compatible = "ti,am654-sa2ul";
 		reg = <0x0 0x4e00000 0x0 0x1200>;
-		power-domains = <&k3_pds 136 TI_SCI_PD_EXCLUSIVE>;
+		power-domains = <&k3_pds 136 TI_SCI_PD_SHARED>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
 
-		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
-				<&main_udmap 0x4001>;
+		dmas = <&main_udmap 0xc001>, <&main_udmap 0x4002>,
+				<&main_udmap 0x4003>;
 		dma-names = "tx", "rx1", "rx2";
-		dma-coherent;
 
 		rng: rng@4e10000 {
 			compatible = "inside-secure,safexcel-eip76";
 			reg = <0x0 0x4e10000 0x0 0x7d>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&k3_clks 136 1>;
+			status = "disabled"; /* Used by OP-TEE */
 		};
 	};
 
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104200 0x0 0x30>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001ff>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104280 0x0 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+	};
+
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c000 0x0 0x2e4>;
@@ -152,6 +175,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 110 1>;
 		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@2010000 {
@@ -163,6 +187,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 111 1>;
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -174,6 +199,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 112 1>;
 		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -185,6 +211,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 113 1>;
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	ecap0: pwm@3100000 {
@@ -194,6 +221,7 @@
 		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 39 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_spi0: spi@2100000 {
@@ -206,6 +234,7 @@
 		#size-cells = <0>;
 		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
 		dma-names = "tx0", "rx0";
+		status = "disabled";
 	};
 
 	main_spi1: spi@2110000 {
@@ -218,6 +247,7 @@
 		#size-cells = <0>;
 		assigned-clocks = <&k3_clks 137 1>;
 		assigned-clock-rates = <48000000>;
+		status = "disabled";
 	};
 
 	main_spi2: spi@2120000 {
@@ -228,6 +258,7 @@
 		power-domains = <&k3_pds 139 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	main_spi3: spi@2130000 {
@@ -238,6 +269,7 @@
 		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	main_spi4: spi@2140000 {
@@ -248,6 +280,151 @@
 		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 23 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 23 0>;
+		assigned-clock-parents = <&k3_clks 23 1>;
+		power-domains = <&k3_pds 23 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 24 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 24 0>;
+		assigned-clock-parents = <&k3_clks 24 1>;
+		power-domains = <&k3_pds 24 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 27 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 27 0>;
+		assigned-clock-parents = <&k3_clks 27 1>;
+		power-domains = <&k3_pds 27 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 28 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 28 0>;
+		assigned-clock-parents = <&k3_clks 28 1>;
+		power-domains = <&k3_pds 28 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 29 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 29 0>;
+		assigned-clock-parents = <&k3_clks 29 1>;
+		power-domains = <&k3_pds 29 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 30 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 30 0>;
+		assigned-clock-parents = <&k3_clks 30 1>;
+		power-domains = <&k3_pds 30 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 31 0>;
+		assigned-clocks = <&k3_clks 31 0>;
+		assigned-clock-parents = <&k3_clks 31 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 31 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 32 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 32 0>;
+		assigned-clock-parents = <&k3_clks 32 1>;
+		power-domains = <&k3_pds 32 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 33 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 33 0>;
+		assigned-clock-parents = <&k3_clks 33 1>;
+		power-domains = <&k3_pds 33 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 34 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 34 0>;
+		assigned-clock-parents = <&k3_clks 34 1>;
+		power-domains = <&k3_pds 34 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 25 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 25 0>;
+		assigned-clock-parents = <&k3_clks 25 1>;
+		power-domains = <&k3_pds 25 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 26 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 26 0>;
+		assigned-clock-parents = <&k3_clks 26 1>;
+		power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
 	};
 
 	sdhci0: mmc@4f80000 {
@@ -292,7 +469,6 @@
 		ti,otap-del-sel-ddr52 = <0x4>;
 		ti,otap-del-sel-hs200 = <0x7>;
 		ti,clkbuf-sel = <0x7>;
-		ti,otap-del-sel = <0x2>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
@@ -304,21 +480,6 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		pcie0_mode: pcie-mode@4060 {
-			compatible = "syscon";
-			reg = <0x00004060 0x4>;
-		};
-
-		pcie1_mode: pcie-mode@4070 {
-			compatible = "syscon";
-			reg = <0x00004070 0x4>;
-		};
-
-		pcie_devid: pcie-devid@210 {
-			compatible = "syscon";
-			reg = <0x00000210 0x4>;
-		};
-
 		serdes0_clk: clock@4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
@@ -338,11 +499,11 @@
 
 		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
 			compatible = "syscon";
-			reg = <0x0000041e0 0x14>;
+			reg = <0x000041e0 0x14>;
 		};
 
-		ehrpwm_tbclk: clock@4140 {
-			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk";
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
 		};
@@ -439,7 +600,7 @@
 	};
 
 	main_navss: bus@30800000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0xbc00000>;
@@ -497,6 +658,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -506,6 +668,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -515,6 +678,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -524,6 +688,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -533,6 +698,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -542,6 +708,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -551,6 +718,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -560,6 +728,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -569,6 +738,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -578,6 +748,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -587,6 +758,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -596,15 +768,17 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		ringacc: ringacc@3c000000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x3c000000 0x0 0x400000>,
-				<0x0 0x38000000 0x0 0x400000>,
-				<0x0 0x31120000 0x0 0x100>,
-				<0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			reg = <0x0 0x3c000000 0x0 0x400000>,
+			      <0x0 0x38000000 0x0 0x400000>,
+			      <0x0 0x31120000 0x0 0x100>,
+			      <0x0 0x33000000 0x0 0x40000>,
+			      <0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -614,9 +788,9 @@
 
 		main_udmap: dma-controller@31150000 {
 			compatible = "ti,am654-navss-main-udmap";
-			reg =	<0x0 0x31150000 0x0 0x100>,
-				<0x0 0x34000000 0x0 0x100000>,
-				<0x0 0x35000000 0x0 0x100000>;
+			reg = <0x0 0x31150000 0x0 0x100>,
+			      <0x0 0x34000000 0x0 0x100000>,
+			      <0x0 0x35000000 0x0 0x100000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
@@ -687,15 +861,15 @@
 
 	pcie0_rc: pcie@5500000 {
 		compatible = "ti,am654-pcie-rc";
-		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
+		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "config", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000
-			  0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
+			 <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&scm_conf 0x210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -703,32 +877,34 @@
 		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
 		device_type = "pci";
+		status = "disabled";
 	};
 
 	pcie0_ep: pcie-ep@5500000 {
 		compatible = "ti,am654-pcie-ep";
-		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
+		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;
 		dma-coherent;
 		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
 	};
 
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
-		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
+		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "config", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000
-			  0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000>,
+			 <0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&scm_conf 0x210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -736,19 +912,21 @@
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
 		device_type = "pci";
+		status = "disabled";
 	};
 
 	pcie1_ep: pcie-ep@5600000 {
 		compatible = "ti,am654-pcie-ep";
-		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
+		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;
 		dma-coherent;
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
 	};
 
 	mcasp0: mcasp@2b00000 {
@@ -766,6 +944,7 @@
 		clocks = <&k3_clks 104 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -783,6 +962,7 @@
 		clocks = <&k3_clks 105 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -800,6 +980,7 @@
 		clocks = <&k3_clks 106 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	cal: cal@6f03000 {
@@ -826,13 +1007,13 @@
 
 	dss: dss@4a00000 {
 		compatible = "ti,am65x-dss";
-		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
-			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
-			<0x0 0x04a06000 0x0 0x1000>, /* vid */
-			<0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
-			<0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
-			<0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
-			<0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+		reg = <0x0 0x04a00000 0x0 0x1000>, /* common */
+		      <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
+		      <0x0 0x04a06000 0x0 0x1000>, /* vid */
+		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
+		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
+		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
+		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
 		reg-names = "common", "vidl1", "vid",
 			"ovr1", "ovr2", "vp1", "vp2";
 
@@ -840,9 +1021,9 @@
 
 		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
 
-		clocks =	<&k3_clks 67 1>,
-				<&k3_clks 216 1>,
-				<&k3_clks 67 2>;
+		clocks = <&k3_clks 67 1>,
+			 <&k3_clks 216 1>,
+			 <&k3_clks 67 2>;
 		clock-names = "fck", "vp1", "vp2";
 
 		/*
@@ -870,6 +1051,7 @@
 		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 40 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm1: pwm@3010000 {
@@ -879,6 +1061,7 @@
 		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 41 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm2: pwm@3020000 {
@@ -888,6 +1071,7 @@
 		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 42 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm3: pwm@3030000 {
@@ -897,6 +1081,7 @@
 		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 43 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm4: pwm@3040000 {
@@ -906,6 +1091,7 @@
 		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 44 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm5: pwm@3050000 {
@@ -915,6 +1101,7 @@
 		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 45 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	icssg0: icssg@b000000 {
@@ -964,6 +1151,18 @@
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1055,6 +1254,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1105,6 +1305,18 @@
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1196,6 +1408,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1246,6 +1459,18 @@
 			};
 		};
 
+		icssg2_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg2_iepclk_mux>;
+		};
+
+		icssg2_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg2_iepclk_mux>;
+		};
+
 		icssg2_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1337,6 +1562,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 };
diff --git a/arch/arm/dts/k3-am65-mcu.dtsi b/arch/arm/dts/k3-am65-mcu.dtsi
index c93ff1520a0e2..edd5cfbec40e6 100644
--- a/arch/arm/dts/k3-am65-mcu.dtsi
+++ b/arch/arm/dts/k3-am65-mcu.dtsi
@@ -20,13 +20,32 @@
 		};
 	};
 
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04200 0x0 0x10>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000101>;
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04280 0x0 0x8>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000003>;
+	};
+
 	mcu_uart0: serial@40a00000 {
 		compatible = "ti,am654-uart";
-			reg = <0x00 0x40a00000 0x00 0x100>;
-			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <96000000>;
-			current-speed = <115200>;
-			power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		reg = <0x00 0x40a00000 0x00 0x100>;
+		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <96000000>;
+		current-speed = <115200>;
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_ram: sram@41c00000 {
@@ -46,6 +65,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 114 1>;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_spi0: spi@40300000 {
@@ -56,6 +76,7 @@
 		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	mcu_spi1: spi@40310000 {
@@ -66,6 +87,7 @@
 		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	mcu_spi2: spi@40320000 {
@@ -76,6 +98,7 @@
 		power-domains = <&k3_pds 144 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	tscadc0: tscadc@40200000 {
@@ -85,10 +108,11 @@
 		clocks = <&k3_clks 0 2>;
 		assigned-clocks = <&k3_clks 0 2>;
 		assigned-clock-rates = <60000000>;
-		clock-names = "adc_tsc_fck";
+		clock-names = "fck";
 		dmas = <&mcu_udmap 0x7100>,
 			<&mcu_udmap 0x7101 >;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -103,10 +127,11 @@
 		clocks = <&k3_clks 1 2>;
 		assigned-clocks = <&k3_clks 1 2>;
 		assigned-clock-rates = <60000000>;
-		clock-names = "adc_tsc_fck";
+		clock-names = "fck";
 		dmas = <&mcu_udmap 0x7102>,
 			<&mcu_udmap 0x7103>;
 		dma-names = "fifo0", "fifo1";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -114,8 +139,53 @@
 		};
 	};
 
+	/*
+	 * The MCU domain timer interrupts are routed only to the ESM module,
+	 * and not currently available for Linux. The MCU domain timers are
+	 * of limited use without interrupts, and likely reserved by the ESM.
+	 */
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		clocks = <&k3_clks 35 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		clocks = <&k3_clks 36 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		clocks = <&k3_clks 37 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		clocks = <&k3_clks 38 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
@@ -126,11 +196,13 @@
 
 		mcu_ringacc: ringacc@2b800000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			reg = <0x0 0x2b800000 0x0 0x400000>,
+			      <0x0 0x2b000000 0x0 0x400000>,
+			      <0x0 0x28590000 0x0 0x100>,
+			      <0x0 0x2a500000 0x0 0x40000>,
+			      <0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg",
+				    "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -140,9 +212,9 @@
 
 		mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,am654-navss-mcu-udmap";
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x2aa00000 0x0 0x40000>;
+			reg = <0x0 0x285c0000 0x0 0x100>,
+			      <0x0 0x2a800000 0x0 0x40000>,
+			      <0x0 0x2aa00000 0x0 0x40000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
@@ -159,7 +231,54 @@
 		};
 	};
 
-	fss: fss@47000000 {
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x2a480000 0x0 0x80000>,
+		      <0x0 0x2a380000 0x0 0x80000>,
+		      <0x0 0x2a400000 0x0 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
+	m_can0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x0 0x40528000 0x0 0x400>,
+		      <0x0 0x40500000 0x0 0x4400>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 102 5>, <&k3_clks 102 0>;
+		clock-names = "hclk", "cclk";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	m_can1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x0 0x40568000 0x0 0x400>,
+		      <0x0 0x40540000 0x0 0x4400>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 103 5>, <&k3_clks 103 0>;
+		clock-names = "hclk", "cclk";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	fss: bus@47000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -180,6 +299,7 @@
 			power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		ospi1: spi@47050000 {
@@ -194,6 +314,7 @@
 			power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 	};
 
@@ -243,6 +364,7 @@
 			clocks = <&k3_clks 5 10>;
 			clock-names = "fck";
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 
 		cpts@3d000 {
diff --git a/arch/arm/dts/k3-am65-wakeup.dtsi b/arch/arm/dts/k3-am65-wakeup.dtsi
index 9d21cdf6fce8f..fd2b998ebddc4 100644
--- a/arch/arm/dts/k3-am65-wakeup.dtsi
+++ b/arch/arm/dts/k3-am65-wakeup.dtsi
@@ -12,8 +12,8 @@
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x44083000 0x1000>;
@@ -54,6 +54,7 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
@@ -65,6 +66,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 115 1>;
 		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	intr_wkup_gpio: interrupt-controller@42200000 {
@@ -100,8 +102,4 @@
 		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
 	};
-
-	thermal_zones: thermal-zones {
-		#include "k3-am654-industrial-thermal.dtsi"
-	};
 };
diff --git a/arch/arm/dts/k3-am65.dtsi b/arch/arm/dts/k3-am65.dtsi
index a9fc1af03f27f..4d7b6155a76b7 100644
--- a/arch/arm/dts/k3-am65.dtsi
+++ b/arch/arm/dts/k3-am65.dtsi
@@ -8,9 +8,10 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/k3.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
+#include "k3-pinctrl.h"
+
 / {
 	model = "Texas Instruments K3 AM654 SoC";
 	compatible = "ti,am654";
@@ -18,21 +19,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &main_i2c0;
-		i2c3 = &main_i2c1;
-		i2c4 = &main_i2c2;
-		i2c5 = &main_i2c3;
-		ethernet0 = &cpsw_port1;
-	};
-
 	chosen { };
 
 	firmware {
@@ -84,6 +70,7 @@
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
 			 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>,
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A53 PERIPHBASE */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x200000>,
 			 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>,
 			 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>;
diff --git a/arch/arm/dts/k3-am654-base-board.dts b/arch/arm/dts/k3-am654-base-board.dts
index cfbcebfa37c1d..1637ec5ab5eda 100644
--- a/arch/arm/dts/k3-am654-base-board.dts
+++ b/arch/arm/dts/k3-am654-base-board.dts
@@ -10,12 +10,25 @@
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
-	compatible =  "ti,am654-evm", "ti,am654";
+	compatible = "ti,am654-evm", "ti,am654";
 	model = "Texas Instruments AM654 Base Board";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &mcu_i2c0;
+		i2c2 = &main_i2c0;
+		i2c3 = &main_i2c1;
+		i2c4 = &main_i2c2;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	memory@80000000 {
@@ -73,20 +86,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&push_button_pins_default>;
 
-		sw5 {
+		switch-5 {
 			label = "GPIO Key USER1";
 			linux,code = <BTN_0>;
 			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_LOW>;
 		};
 
-		sw6 {
+		switch-6 {
 			label = "GPIO Key USER2";
 			linux,code = <BTN_1>;
 			gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-	evm_12v0: fixedregulator-evm12v0 {
+	evm_12v0: regulator-0 {
 		/* main supply */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
@@ -96,7 +109,7 @@
 		regulator-boot-on;
 	};
 
-	vcc3v3_io: fixedregulator-vcc3v3io {
+	vcc3v3_io: regulator-1 {
 		/* Output of TPS54334 */
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_io";
@@ -107,7 +120,7 @@
 		vin-supply = <&evm_12v0>;
 	};
 
-	vdd_mmc1_sd: fixedregulator-sd {
+	vdd_mmc1_sd: regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1_sd";
 		regulator-min-microvolt = <3300000>;
@@ -117,24 +130,53 @@
 		vin-supply = <&vcc3v3_io>;
 		gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	vtt_supply: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ddr_vtt_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc3v3_io>;
+		gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &wkup_pmx0 {
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x00a0, PIN_INPUT, 0)	/* (AB1) WKUP_UART0_RXD */
+			AM65X_WKUP_IOPAD(0x00a4, PIN_OUTPUT, 0)	/* (AB5) WKUP_UART0_TXD */
+			AM65X_WKUP_IOPAD(0x00c8, PIN_INPUT, 1)	/* (AC2) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+		>;
+	};
+
+	ddr_vtt_pins_default: ddr-vtt-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
 	};
 
-	push_button_pins_default: push-button-pins-default {
+	push_button_pins_default: push-button-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0030, PIN_INPUT, 7) /* (R5) WKUP_GPIO0_24 */
 			AM65X_WKUP_IOPAD(0x003c, PIN_INPUT, 7) /* (P2) WKUP_GPIO0_27 */
 		>;
 	};
 
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* (V1) MCU_OSPI0_CLK */
 			AM65X_WKUP_IOPAD(0x0008, PIN_INPUT, 0)	 /* (U2) MCU_OSPI0_DQS */
@@ -150,13 +192,22 @@
 		>;
 	};
 
-	wkup_pca554_default: wkup-pca554-default {
+	wkup_pca554_default: wkup-pca554-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT, 7) /* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
 		>;
 	};
 
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)	/* (P4) MCU_OSPI1_D1.MCU_UART0_RXD */
+			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)	/* (P5) MCU_OSPI1_D2.MCU_UART0_TXD */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
+			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
+		>;
+	};
+
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 0) /* (N4) MCU_RGMII1_TX_CTL */
 			AM65X_WKUP_IOPAD(0x005c, PIN_INPUT, 0) /* (N5) MCU_RGMII1_RX_CTL */
@@ -173,16 +224,23 @@
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+	mcu_mdio_pins_default: mcu-mdio1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x008c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
 			AM65X_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x00e8, PIN_INPUT,  0) /* (AD8) MCU_I2C0_SCL */
+			AM65X_WKUP_IOPAD(0x00ec, PIN_INPUT,  0) /* (AD7) MCU_I2C0_SDA */
+		>;
+	};
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01e4, PIN_INPUT, 0)	/* (AF11) UART0_RXD */
 			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)	/* (AE11) UART0_TXD */
@@ -191,14 +249,14 @@
 		>;
 	};
 
-	main_i2c2_pins_default: main-i2c2-pins-default {
+	main_i2c2_pins_default: main-i2c2-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0074, PIN_INPUT, 5) /* (T27) GPMC0_CSn3.I2C2_SCL */
 			AM65X_IOPAD(0x0070, PIN_INPUT, 5) /* (R25) GPMC0_CSn2.I2C2_SDA */
 		>;
 	};
 
-	main_spi0_pins_default: main-spi0-pins-default {
+	main_spi0_pins_default: main-spi0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c4, PIN_INPUT, 0) /* (AH13) SPI0_CLK */
 			AM65X_IOPAD(0x01c8, PIN_INPUT, 0) /* (AE13) SPI0_D0 */
@@ -207,7 +265,7 @@
 		>;
 	};
 
-	main_mmc0_pins_default: main-mmc0-pins-default {
+	main_mmc0_pins_default: main-mmc0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0) /* (B25) MMC0_CLK */
 			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP, 0) /* (B27) MMC0_CMD */
@@ -224,7 +282,7 @@
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0) /* (C27) MMC1_CLK */
 			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0) /* (C28) MMC1_CMD */
@@ -237,7 +295,7 @@
 		>;
 	};
 
-	usb1_pins_default: usb1-pins-default {
+	usb1_pins_default: usb1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8) USB1_DRVVBUS */
 		>;
@@ -245,21 +303,21 @@
 };
 
 &main_pmx1 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0000, PIN_INPUT, 0) /* (D20) I2C0_SCL */
 			AM65X_IOPAD(0x0004, PIN_INPUT, 0) /* (C21) I2C0_SDA */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0008, PIN_INPUT, 0) /* (B21) I2C1_SCL */
 			AM65X_IOPAD(0x000c, PIN_INPUT, 0) /* (E21) I2C1_SDA */
 		>;
 	};
 
-	ecap0_pins_default: ecap0-pins-default {
+	ecap0_pins_default: ecap0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0010, PIN_INPUT, 0) /* (D21) ECAP0_IN_APWM_OUT */
 		>;
@@ -269,19 +327,55 @@
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
 &wkup_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
+	eeprom@50 {
+		/* AT24CM01 */
+		compatible = "atmel,24c1024";
+		reg = <0x50>;
+	};
+
+	vdd_mpu: regulator@60 {
+		compatible = "ti,tps62363";
+		reg = <0x60>;
+		regulator-name = "VDD_MPU";
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <1770000>;
+		regulator-always-on;
+		regulator-boot-on;
+		ti,vsel0-state-high;
+		ti,vsel1-state-high;
+		ti,enable-vout-discharge;
+	};
+
+	gpio@38 {
+		compatible = "nxp,pca9554";
+		reg = <0x38>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pca9554: gpio@39 {
 		compatible = "nxp,pca9554";
 		reg = <0x39>;
@@ -296,7 +390,15 @@
 	};
 };
 
+&mcu_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -310,37 +412,39 @@
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c2_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &ecap0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins_default>;
 };
 
 &main_spi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_spi0_pins_default>;
 	#address-cells = <1>;
-	#size-cells= <0>;
+	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		spi-max-frequency = <48000000>;
-		#address-cells = <1>;
-		#size-cells= <1>;
 	};
 };
 
@@ -381,12 +485,14 @@
 };
 
 &tscadc0 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
 
 &tscadc1 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
@@ -400,23 +506,8 @@
 	status = "disabled";
 };
 
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
-&pcie1_rc {
-	status = "disabled";
-};
-
-&pcie1_ep {
-	status = "disabled";
-};
-
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -426,6 +517,7 @@
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
@@ -434,63 +526,24 @@
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
-};
-
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 };
 
 &mcu_r5fss0_core1 {
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -501,17 +554,65 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
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
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "ospi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fe0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+			};
+		};
 	};
 };
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>;
 };
 
 &davinci_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mdio_pins_default>;
+
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
@@ -524,30 +625,6 @@
 	phy-handle = <&phy0>;
 };
 
-&mcasp0 {
-	status = "disabled";
-};
-
-&mcasp1 {
-	status = "disabled";
-};
-
-&mcasp2 {
-	status = "disabled";
-};
-
 &dss {
 	status = "disabled";
 };
-
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
-&icssg2_mdio {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/k3-am654.dtsi b/arch/arm/dts/k3-am654.dtsi
index f0a6541b80428..888567b921f0a 100644
--- a/arch/arm/dts/k3-am654.dtsi
+++ b/arch/arm/dts/k3-am654.dtsi
@@ -93,6 +93,7 @@
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x80000>;
 		cache-line-size = <64>;
 		cache-sets = <512>;
@@ -102,6 +103,7 @@
 	L2_1: l2-cache1 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x80000>;
 		cache-line-size = <64>;
 		cache-sets = <512>;
@@ -111,5 +113,10 @@
 	msmc_l3: l3-cache0 {
 		compatible = "cache";
 		cache-level = <3>;
+		cache-unified;
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-am654-industrial-thermal.dtsi"
 	};
 };
-- 
2.43.0

