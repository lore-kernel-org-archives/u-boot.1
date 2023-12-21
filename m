Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6FFC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A5E878D7;
	Thu, 21 Dec 2023 18:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uhJZRc/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD58687907; Thu, 21 Dec 2023 18:44:27 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA5B878CB
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFX3118535;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=B2k7VriLksNuRciMsHwN1ldmMtfmLeVo0C27jUOe4a4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uhJZRc/YoHAR+XBIvCI687rFaLNyXZ8IagyJUA0NsFxSX/sRbNW18VyGgzrtRGJwk
 DFqgSOEAYwkR5VCyeX3Lit09hK5KeLkFXErNY9iGtm0AjmyU7iFm1sXuRi7k+gD7aQ
 m6c3c3AWcIeyHh4U+NU6atZcWYXpCK8R96OUCU44=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFhQ097321
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEfU080247;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 19/26] arm: dts: k3-am654: remove usb0
Date: Thu, 21 Dec 2023 11:44:05 -0600
Message-ID: <20231221174412.210807-20-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=bb@ti.com;
 h=from:subject; bh=jX9mxSkWsYsPJpg9YYjsC81yYlNWm6Z+n0wNPAuz9W4=;
 b=owNCWmg5MUFZJlNZyyS6yAAAan///n//+m1u+N+T/M+0lx377eX//P3I61u9/H1v7Pfe5+0wA
 RmWEPUA0ANBoANGmgNA0AGhoxHomIADTIANADQaANGIYE0ZGgNMIwRpie1DoB6g0aBppkyaAAyN
 NMgyGgNNAABpoMJk02kZMQaYmIzKNAAaBoAGQ0ZGmQyTT1B6h6geoGnpDQG01AaGmmjT1HqB6gA
 ABpoekGjRptIAAAA0ANGmmgaAPUNAAQfgIoJxLBDn3Ysr3jRLZGRk8KINRqvN4efALCkKGZgdLI
 6uUk1hmnGL4oeqHcGpzGyIJPjmrlDQbKA7UBsOKzEQPp5WKPbq2CHlvrkhs1StJ5NoyarxLlvYX
 xJht/W2Ztxq9Ae6JAxx4piuus7XUmF4G3MNov6YtMDPkIUPK4f7QbJSIIWmqjLdKcB7gRmtYOjw
 VeqZBHSU7fHPOUEbFPTPVpFb8t3PGbuQfRML3hDj7DAbol+vX9cgyW0JDYkI6wdzCdg1bwKfXjt
 XMNDNZ2axb2O6l9Od+TjfZwwSp+RR1j3JaJT/r/o0HK2op1eP3XHbq9f2y+F054e95tn8CMREfG
 tTnp6FBxezYKuYng2UF8hOR7jNaN0Oo7424n6GE5dPCy8ADEORdKAYsMYVhpXqFBalHj9QsQI9e
 pEC0BACllM+F3JFOFCQyyS6yA==
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

The pinmux for usb0 is missing from the Linux board dtb file. Remove it
until we can introduce it in Linux

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 12 --------
 arch/arm/dts/k3-am654-r5-base-board.dts      | 29 --------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 645241da322a5..104cb2e559f2f 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -133,10 +133,6 @@
 	bootph-pre-ram;
 };
 
-&usb0_pins_default {
-	bootph-pre-ram;
-};
-
 &main_pmx1 {
 	bootph-pre-ram;
 };
@@ -169,14 +165,6 @@
 	bootph-pre-ram;
 };
 
-&usb0_phy {
-	bootph-pre-ram;
-};
-
-&usb0 {
-	bootph-pre-ram;
-};
-
 &scm_conf {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index af2a8a15b5533..e84cf0bf16b27 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,8 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		usb0 = &usb0;
-		usb1 = &usb1;
 	};
 
 	a53_0: a53@0 {
@@ -111,14 +109,6 @@
 	};
 };
 
-&main_pmx0 {
-	usb0_pins_default: usb0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
-		>;
-	};
-};
-
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
 	pinctrl-names = "default";
@@ -156,14 +146,6 @@
 	      <0x0 0x50000000 0x0 0x8000000>;
 };
 
-&main_pmx0 {
-	usb0_pins_default: usb0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
-		>;
-	};
-};
-
 &dwc3_0 {
 	status = "okay";
 	/delete-property/ clocks;
@@ -172,17 +154,6 @@
 	/delete-property/ assigned-clock-parents;
 };
 
-&usb0_phy {
-	status = "okay";
-	/delete-property/ clocks;
-};
-
-&usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_pins_default>;
-	dr_mode = "peripheral";
-};
-
 &davinci_mdio {
 	phy0: ethernet-phy@0 {
 		reg = <0>;
-- 
2.43.0

