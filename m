Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAC9E7D0A1
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0209E86B59;
	Thu, 21 Sep 2023 19:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="p9KllgEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FD7864D4; Thu, 21 Sep 2023 19:07:13 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536CD86B70
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695316030; x=1726852030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Rjd61/WEpkBm1L2CL0V4AWuD1OaCw/5XhytpA1yNbw=;
 b=p9KllgEmnhaKg8Rs28wOa1eZSg1pMxkarfodfW0MzZrcx//nCilo/2tS
 9BCwbkKzGTU76IGKzFn73WsfbaZEme0jvCeE5hds3RP3J1+8otJikwncd
 7tSZPr5FVcOYKb9OnEzoIx3IfHElW6OuXPA+k+S0j6RETGu1uxFQfXWQU
 yaLOO+nLCoJE1uc/JDLZN5v7Z2oY7jy8I8zIVTVY/eqJ1Q3J8zKs+PM69
 /xetoKEXSgNEA4Am4xDnbSyIEpmLIfJ6Q1MBWVeJsqbQse7WRfl3lCF0B
 4QFvSGZRyS8wgmhesCI2kTNFqx1Si7zdMePZUUI+p7kYMEAzyCB6a1GMv A==;
X-CSE-ConnectionGUID: NdTKLWK4QlCcaJDaupniyw==
X-CSE-MsgGUID: XrK/3zH9TAelFHDWV64xvQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="6112386"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Sep 2023 10:07:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 10:07:01 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 10:06:57 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <u-boot@lists.denx.de>
CC: <durai.manickamkr@microchip.com>, <hari.prasathge@microchip.com>,
 <varshini.rajendran@microchip.com>, <cristian.birsan@microchip.com>,
 <nicolas.ferre@microchip.com>, <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 3/4] ARM: dts: at91: sam9x60_curiosity: Enable NAND support
Date: Thu, 21 Sep 2023 22:36:30 +0530
Message-ID: <20230921170631.45752-4-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921170631.45752-1-durai.manickamkr@microchip.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 21 Sep 2023 19:18:38 +0200
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

Enable the EBI and NAND flash controller. Define the pinctrl and
partition table.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 104 ++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index d6ae3d648d..0d09679bd3 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -39,6 +39,44 @@
 			};
 
 			pinctrl {
+				ebi {
+					pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
+						atmel,pins =
+							<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+					};
+
+					pinctrl_ebi_addr_nand: ebi-addr-0 {
+						atmel,pins =
+							<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+					};
+				};
+
+				nand {
+					pinctrl_nand_oe_we: nand-oe-we-0 {
+						atmel,pins =
+							<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+							 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+					};
+
+					pinctrl_nand_rb: nand-rb-0 {
+						atmel,pins =
+							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+				};
+
 					pinctrl_flx0: flx0_default {
 						atmel,pins =
 							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
@@ -92,6 +130,72 @@
 	};
 };
 
+&ebi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_0_7>;
+	status = "okay";
+
+	nand_controller: nand-controller {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nand_oe_we &pinctrl_nand_cs &pinctrl_nand_rb>;
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			atmel,rb = <0>;
+			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				at91bootstrap@0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x40000>;
+				};
+
+				uboot@40000 {
+					label = "u-boot";
+					reg = <0x40000 0xc0000>;
+				};
+
+				ubootenvred@100000 {
+					label = "U-Boot Env Redundant";
+					reg = <0x100000 0x40000>;
+				};
+
+				ubootenv@140000 {
+					label = "U-Boot Env";
+					reg = <0x140000 0x40000>;
+				};
+
+				dtb@180000 {
+					label = "device tree";
+					reg = <0x180000 0x80000>;
+				};
+
+				kernel@200000 {
+					label = "kernel";
+					reg = <0x200000 0x600000>;
+				};
+
+				rootfs@800000 {
+					label = "rootfs";
+					reg = <0x800000 0x1f800000>;
+				};
+			};
+		};
+	};
+};
+
 &macb0 {
 	phy-mode = "rmii";
 	status = "okay";
-- 
2.25.1

