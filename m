Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC07C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4F287C9E;
	Tue,  6 Feb 2024 13:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VjNekEtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FFE87C9E; Tue,  6 Feb 2024 13:21:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4950187C7D
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLHiH118794;
 Tue, 6 Feb 2024 06:21:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222077;
 bh=vTCg99iR9Z2A/KAjX+sJKWfAKLoHKaj4gHRhE7UHpJM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=VjNekEtuJUJqbsd56DehF9WeI8VPXLH892TrkppvTMD81CUQ9oqosmeT7sgKIaKPc
 f7lyi8fsGxVsNv3QtdDzT5EyMdY3VaxWvWjO3xJfoaxFPbDGT8GaYdeM0Iq2+INSEV
 5jdIgSMR03TRbO7Vs0mReQ3sYmvwsSqlkactPBYE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLHrf096217
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:17 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:17 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAi0081923;
 Tue, 6 Feb 2024 06:21:14 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 6 Feb 2024 17:51:08 +0530
Subject: [PATCH 01/10] arm: dts: k3-j721s2*: Sync with 6.8-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-1-b75043c59969@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=9795;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=uHnY0mSirsEJ3EnGYrZ9T4DbcMmkrTbyoCUqgCXhPYw=;
 b=AXlJz0IkHmLbxHxUYx0/G3Vn4MCXuS19Uk40h0jOVflECVyAkKSFknzOlSGcE+Toe7mlRO0om
 Ht3Kx2vMIJPC9zuSUfyw9LmOL05w23bheMtZOnzpJx1h1skcH9EIBZk
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Syncs the DT from Linux v6.8-rc1.

Remove udmap overrides and handle location change of chipid node.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  18 +-
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  18 +-
 arch/arm/dts/k3-j721s2-main.dtsi                   |   9 +-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             |  21 ++-
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 193 +++++++++++++++++++++
 5 files changed, 230 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
index 4f34347586e0..43055b5c161e 100644
--- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
@@ -19,10 +19,14 @@
 
 &cbass_mcu_wakeup {
 	bootph-all;
+};
 
-	chipid@43000014 {
-		bootph-all;
-	};
+&wkup_conf {
+	bootph-all;
+};
+
+&chipid {
+	bootph-all;
 };
 
 &mcu_navss {
@@ -34,14 +38,6 @@
 };
 
 &mcu_udmap {
-	reg =   <0x0 0x285c0000 0x0 0x100>,
-		<0x0 0x284c0000 0x0 0x4000>,
-		<0x0 0x2a800000 0x0 0x40000>,
-		<0x0 0x284a0000 0x0 0x4000>,
-		<0x0 0x2aa00000 0x0 0x40000>,
-		<0x0 0x28400000 0x0 0x2000>;
-	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-		    "tchanrt", "rflow";
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index a3ebf5996eac..df5a2f3b7d5b 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -19,10 +19,14 @@
 
 &cbass_mcu_wakeup {
 	bootph-all;
+};
 
-	chipid@43000014 {
-		bootph-all;
-	};
+&wkup_conf {
+	bootph-all;
+};
+
+&chipid {
+	bootph-all;
 };
 
 &mcu_navss {
@@ -34,14 +38,6 @@
 };
 
 &mcu_udmap {
-	reg =   <0x0 0x285c0000 0x0 0x100>,
-		<0x0 0x284c0000 0x0 0x4000>,
-		<0x0 0x2a800000 0x0 0x40000>,
-		<0x0 0x284a0000 0x0 0x4000>,
-		<0x0 0x2aa00000 0x0 0x40000>,
-		<0x0 0x28400000 0x0 0x2000>;
-	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-		    "tchanrt", "rflow";
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/k3-j721s2-main.dtsi b/arch/arm/dts/k3-j721s2-main.dtsi
index b03731b53a26..ea7f2b2ab165 100644
--- a/arch/arm/dts/k3-j721s2-main.dtsi
+++ b/arch/arm/dts/k3-j721s2-main.dtsi
@@ -766,6 +766,7 @@
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
@@ -1086,8 +1087,12 @@
 			compatible = "ti,j721e-navss-main-udmap";
 			reg = <0x0 0x31150000 0x0 0x100>,
 			      <0x0 0x34000000 0x0 0x80000>,
-			      <0x0 0x35000000 0x0 0x200000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+			      <0x0 0x35000000 0x0 0x200000>,
+			      <0x0 0x30b00000 0x0 0x20000>,
+			      <0x0 0x30c00000 0x0 0x8000>,
+			      <0x0 0x30d00000 0x0 0x4000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
 
diff --git a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
index 7254f3bd3634..80aa33c58a45 100644
--- a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
@@ -34,9 +34,16 @@
 		};
 	};
 
-	chipid@43000014 {
-		compatible = "ti,am654-chipid";
-		reg = <0x00 0x43000014 0x00 0x4>;
+	wkup_conf: bus@43000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x43000000 0x20000>;
+
+		chipid: chipid@14 {
+			compatible = "ti,am654-chipid";
+			reg = <0x14 0x4>;
+		};
 	};
 
 	secure_proxy_sa3: mailbox@43600000 {
@@ -471,8 +478,12 @@
 			compatible = "ti,j721e-navss-mcu-udmap";
 			reg = <0x0 0x285c0000 0x0 0x100>,
 			      <0x0 0x2a800000 0x0 0x40000>,
-			      <0x0 0x2aa00000 0x0 0x40000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+			      <0x0 0x2aa00000 0x0 0x40000>,
+			      <0x0 0x284a0000 0x0 0x4000>,
+			      <0x0 0x284c0000 0x0 0x4000>,
+			      <0x0 0x28400000 0x0 0x2000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
 
diff --git a/arch/arm/dts/k3-j721s2-som-p0.dtsi b/arch/arm/dts/k3-j721s2-som-p0.dtsi
index dcad372620b1..da3237b23b63 100644
--- a/arch/arm/dts/k3-j721s2-som-p0.dtsi
+++ b/arch/arm/dts/k3-j721s2-som-p0.dtsi
@@ -172,6 +172,15 @@
 	};
 };
 
+&wkup_pmx1 {
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			/* (C21) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 7)
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
@@ -208,6 +217,190 @@
 		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
+
+	tps659411: pmic@48 {
+		compatible = "ti,tps6594-q1";
+		reg = <0x48>;
+		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ti,primary-pmic;
+		buck1234-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			bucka1234: buck1234 {
+				regulator-name = "vdd_cpu_avs";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-pre-ram;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd_mcuwk_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vdd_mcu_gpioret_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4: ldo4 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	tps659414: pmic@4c {
+		compatible = "ti,tps6594-q1";
+		reg = <0x4c>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		buck1-supply = <&vsys_3v3>;
+		buck2-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			buckb1: buck1 {
+				regulator-name = "vdd_io_1v8_reg";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buckb2: buck2 {
+				regulator-name = "vdd_fpd_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb3: buck3 {
+				regulator-name = "vdd_phy_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb4: buck4 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buckb5: buck5 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob1: ldo1 {
+				regulator-name = "vdd_wk_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob2: ldo2 {
+				regulator-name = "vdd_gpioret_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob3: ldo3 {
+				regulator-name = "vda_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldob4: ldo4 {
+				regulator-name = "vda_pll_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	lp876411: pmic@58 {
+		compatible = "ti,lp8764-q1";
+		reg = <0x58>;
+		system-power-controller;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		buck1234-supply = <&vsys_3v3>;
+
+		regulators {
+			buckc1234: buck1234 {
+				regulator-name = "vdd_core_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &main_i2c0 {

-- 
2.43.0

