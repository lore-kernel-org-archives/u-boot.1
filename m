Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C693ACA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309E682998;
	Thu, 21 Aug 2025 08:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="DlKEvgTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB3880422; Thu, 21 Aug 2025 08:46:18 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0084182E37
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mkWcGhzZDO9Cu2mYmo7dLEv70lcW5GUnruBnp4lUXYo=; b=DlKEvgTH4YcdWXKZYOfs39Fr3W
 4q8EhjjouDVaSBCnLZ4BkHS+hx2ia9C097WYJEFjsfSIJKFN0anPFreQoKko3aTIvmwSR5mo8AJAi
 rqoNO6jzUAPUedpU58R8bFgh9/88Vw4rcPZejT1pPAq3kxQdEW6YBipF8BB0Pr3GRpdVGl4Xz8hI2
 0ej1fqh7NUa8WQ1cPs18U9skZAEeeTsdTOubWX9HV2EQQyVfhT5aInLIS2Z0lMIso7oA7xMfJvZNX
 ZcZBANUqaRfIRDBD2iybKd1ztrf/wRid+gDpNDu4faq7TZrTBEV1D38CZYPMsbc8CN4bl2tnuY/hh
 2Aba67hg==;
Received: from [89.212.21.243] (port=49890 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uoz3u-00FihC-2c;
 Thu, 21 Aug 2025 08:46:14 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] arm: dts: imx93-phyboard-segin-u-boot: Clean-up already
 upstream nodes
Date: Thu, 21 Aug 2025 08:46:14 +0200
Message-Id: <20250821064614.2644332-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Clean-up "imx93-phyboard-segin-u-boot.dtsi" internal device-tree from
nodes already part of the upstream device-tree since commit 79f3e77133bd
("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream"). No
functional change is made with this commit.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi | 219 +++---------------
 1 file changed, 35 insertions(+), 184 deletions(-)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 0c3ca2961c98..0c8d0ba9693f 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -69,6 +69,16 @@
 	bootph-some-ram;
 };
 
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_pmic {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -83,6 +93,16 @@
 	bootph-some-ram;
 };
 
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &pinctrl_usdhc2_cd {
 	bootph-pre-ram;
 	bootph-some-ram;
@@ -128,31 +148,9 @@
 	bootph-some-ram;
 };
 
-/*
- * Remove once USB support is added to imx93-phyboard-segin.dts upstream.
- */
-&usbotg1 {
-	disable-over-current;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	status = "okay";
-};
-
 &usdhc1 {
 	bootph-pre-ram;
 	bootph-some-ram;
-	/*
-	 * Remove pinctrl assignments once they are added to imx93-phycore-som.dtsi
-	 */
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 };
 
 &usdhc2 {
@@ -174,6 +172,21 @@
 &lpi2c3 {
 	bootph-pre-ram;
 	bootph-some-ram;
+
+	pmic@25 {
+		bootph-pre-ram;
+		bootph-some-ram;
+
+		regulators {
+			bootph-pre-ram;
+			bootph-some-ram;
+		};
+	};
+
+	eeprom@50 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
 };
 
 &s4muap {
@@ -209,165 +222,3 @@
 	bootph-all;
 	bootph-pre-ram;
 };
-
-/*
- * The two nodes below won't be needed once nxp,pca9451a
- * support is added to the Linux kernel.
- */
-&iomuxc {
-	pinctrl_lpi2c3: lpi2c3grp {
-		bootph-pre-ram;
-		fsl,pins = <
-			MX93_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
-			MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		bootph-pre-ram;
-		fsl,pins = <
-			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x31e
-		>;
-	};
-
-	/*
-	 * Remove pinctrl_usdhc1_100mhz and pinctrl_usdhc1_200mhz once they
-	 * are added to imx93-phycore-som.dtsi
-	 */
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		bootph-pre-ram;
-		bootph-some-ram;
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000139e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000139e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000139e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000139e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000139e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000139e
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
-		>;
-	};
-
-	/* need to config the SION for data and cmd pad, refer to ERR052021 */
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		bootph-pre-ram;
-		bootph-some-ram;
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000139e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013be
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013be
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013be
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013be
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013be
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013be
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
-		>;
-	};
-};
-
-&lpi2c3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-1 = <&pinctrl_lpi2c3>;
-	status = "okay";
-
-	pmic@25 {
-		bootph-pre-ram;
-		bootph-some-ram;
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			bootph-pre-ram;
-			bootph-some-ram;
-			buck1: BUCK1 {
-				regulator-name = "VDD_SOC";
-				regulator-min-microvolt = <610000>;
-				regulator-max-microvolt = <950000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "VDDQ_0V6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <600000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck4: BUCK4 {
-				regulator-name = "VDD_3V3_BUCK";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5 {
-				regulator-name = "VDD_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "VDD_1V1";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "PMIC_SNVS_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "VDD_0V8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "NVCC_SD2";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	eeprom@50 {
-		bootph-pre-ram;
-		bootph-some-ram;
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-		vcc-supply = <&buck4>;
-	};
-};
-- 
2.34.1

