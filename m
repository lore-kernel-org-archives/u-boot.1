Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F8C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 22:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1319686F7E;
	Thu,  1 Feb 2024 23:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZwpKCHWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E84F87CFE; Thu,  1 Feb 2024 23:27:49 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE1887CDB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 23:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411MRhXl064120;
 Thu, 1 Feb 2024 16:27:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706826463;
 bh=K6FS+M6NxkWJGPUEFgkIIYUGxufE6xtjmdY3x8gZfXE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZwpKCHWF/DsFrZY8xJyC3d1bxkI73Lrrbf033z//VQ3AzwLY/BJrdphNFuioA7ZMg
 ZVIbuW5atL08Z5cFZg5T5DabzMzVlkQ+jNleJ0ha082OPeC2CYiCDccOTHRx0Huok/
 Nh1/kQlurMvesdT4Ea1OQc6QjvXy1nXsKqG0KMok=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411MRh6e049919
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 16:27:43 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 16:27:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 16:27:43 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411MRgJe076123;
 Thu, 1 Feb 2024 16:27:43 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-am64: Sync with kernel v6.8-rc1
Date: Thu, 1 Feb 2024 16:27:41 -0600
Message-ID: <20240201222741.141074-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201222741.141074-1-afd@ti.com>
References: <20240201222741.141074-1-afd@ti.com>
MIME-Version: 1.0
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

Sync with kernel v6.8-rc1 and sync up the u-boot dts files accordingly.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/k3-am64-main.dtsi        | 22 +++++++++++++++++-----
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 21 +--------------------
 arch/arm/dts/k3-am642-evm.dts         | 12 +++++++++---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 20 --------------------
 arch/arm/dts/k3-am642-sk.dts          | 10 ++++++++--
 5 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/arch/arm/dts/k3-am64-main.dtsi b/arch/arm/dts/k3-am64-main.dtsi
index 0be642bc1b8..e348114f42e 100644
--- a/arch/arm/dts/k3-am64-main.dtsi
+++ b/arch/arm/dts/k3-am64-main.dtsi
@@ -63,7 +63,7 @@
 			#phy-cells = <1>;
 		};
 
-		epwm_tbclk: clock-controller@4140 {
+		epwm_tbclk: clock-controller@4130 {
 			compatible = "ti,am64-epwm-tbclk";
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
@@ -138,8 +138,13 @@
 			      <0x00 0x4c000000 0x00 0x20000>,
 			      <0x00 0x4a820000 0x00 0x20000>,
 			      <0x00 0x4aa40000 0x00 0x20000>,
-			      <0x00 0x4bc00000 0x00 0x100000>;
-			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4bc00000 0x00 0x100000>,
+			      <0x00 0x48600000 0x00 0x8000>,
+			      <0x00 0x484a4000 0x00 0x2000>,
+			      <0x00 0x484c2000 0x00 0x2000>,
+			      <0x00 0x48420000 0x00 0x2000>;
+			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "bchan";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <3>;
 
@@ -155,8 +160,13 @@
 			reg = <0x00 0x485c0000 0x00 0x100>,
 			      <0x00 0x4a800000 0x00 0x20000>,
 			      <0x00 0x4aa00000 0x00 0x40000>,
-			      <0x00 0x4b800000 0x00 0x400000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4b800000 0x00 0x400000>,
+			      <0x00 0x485e0000 0x00 0x20000>,
+			      <0x00 0x484a0000 0x00 0x4000>,
+			      <0x00 0x484c0000 0x00 0x2000>,
+			      <0x00 0x48430000 0x00 0x4000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <2>;
 
@@ -623,6 +633,7 @@
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		status = "disabled";
 	};
 
 	sdhci1: mmc@fa00000 {
@@ -641,6 +652,7 @@
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
+		status = "disabled";
 	};
 
 	cpsw3g: ethernet@8000000 {
diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index a052941e235..c98adc65e89 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -43,29 +43,10 @@
 };
 
 &main_bcdma {
-	reg = <0x00 0x485c0100 0x00 0x100>,
-	      <0x00 0x4c000000 0x00 0x20000>,
-	      <0x00 0x4a820000 0x00 0x20000>,
-	      <0x00 0x4aa40000 0x00 0x20000>,
-	      <0x00 0x4bc00000 0x00 0x100000>,
-	      <0x00 0x48600000 0x00 0x8000>,
-	      <0x00 0x484a4000 0x00 0x2000>,
-	      <0x00 0x484c2000 0x00 0x2000>;
-	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
-		    "cfg", "tchan", "rchan";
+	bootph-all;
 };
 
 &main_pktdma {
-	reg = <0x00 0x485c0000 0x00 0x100>,
-	      <0x00 0x4a800000 0x00 0x20000>,
-	      <0x00 0x4aa00000 0x00 0x40000>,
-	      <0x00 0x4b800000 0x00 0x400000>,
-	      <0x00 0x485e0000 0x00 0x20000>,
-	      <0x00 0x484a0000 0x00 0x4000>,
-	      <0x00 0x484c0000 0x00 0x2000>,
-	      <0x00 0x48430000 0x00 0x4000>;
-	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt", "cfg",
-		    "tchan", "rchan", "rflow";
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/k3-am642-evm.dts b/arch/arm/dts/k3-am642-evm.dts
index 4dba1894101..8c5651d2cf5 100644
--- a/arch/arm/dts/k3-am642-evm.dts
+++ b/arch/arm/dts/k3-am642-evm.dts
@@ -468,11 +468,15 @@
 	bootph-all;
 };
 
-/* mcu_gpio0 is reserved for mcu firmware usage */
+/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
 };
 
+&mcu_gpio_intr {
+	status = "reserved";
+};
+
 &main_spi0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -487,17 +491,19 @@
 	};
 };
 
+/* eMMC */
 &sdhci0 {
-	/* emmc */
+	status = "okay";
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 818867df8d9..b71f2fb067c 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -71,30 +71,10 @@
 };
 
 &main_bcdma {
-	reg = <0x00 0x485c0100 0x00 0x100>,
-	      <0x00 0x4c000000 0x00 0x20000>,
-	      <0x00 0x4a820000 0x00 0x20000>,
-	      <0x00 0x4aa40000 0x00 0x20000>,
-	      <0x00 0x4bc00000 0x00 0x100000>,
-	      <0x00 0x48600000 0x00 0x8000>,
-	      <0x00 0x484a4000 0x00 0x2000>,
-	      <0x00 0x484c2000 0x00 0x2000>;
-	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
-		    "cfg", "tchan", "rchan";
 	bootph-all;
 };
 
 &main_pktdma {
-	reg = <0x00 0x485c0000 0x00 0x100>,
-	      <0x00 0x4a800000 0x00 0x20000>,
-	      <0x00 0x4aa00000 0x00 0x40000>,
-	      <0x00 0x4b800000 0x00 0x400000>,
-	      <0x00 0x485e0000 0x00 0x20000>,
-	      <0x00 0x484a0000 0x00 0x4000>,
-	      <0x00 0x484c0000 0x00 0x2000>,
-	      <0x00 0x48430000 0x00 0x4000>;
-	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt", "cfg",
-		    "tchan", "rchan", "rflow";
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index f29c8a9b59b..1dddd6fc1a0 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -433,12 +433,17 @@
 	};
 };
 
-/* mcu_gpio0 is reserved for mcu firmware usage */
+/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
 };
 
+&mcu_gpio_intr {
+	status = "reserved";
+};
+
 &sdhci0 {
+	status = "okay";
 	vmmc-supply = <&wlan_en>;
 	bus-width = <4>;
 	non-removable;
@@ -458,9 +463,10 @@
 	};
 };
 
+/* SD/MMC */
 &sdhci1 {
-	/* SD/MMC */
 	bootph-all;
+	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
-- 
2.39.2

