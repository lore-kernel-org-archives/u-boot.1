Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B47C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC80E87BE9;
	Fri, 29 Dec 2023 18:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J7mIPdLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B676A87BD3; Fri, 29 Dec 2023 18:47:12 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD08387BAD
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1Ze088969;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=efoTMyIcgxIJx+JO9FotISrK3XNegJXdr2QkVr1qiMc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=J7mIPdLByJ30UTcsud81Ywe/dWkDnFJEnJnFMYzWHLiK1AXeOPJF2QEdzi3j6dhNG
 M+iJOU3IxuG20yob3l4d24+SIBRYiTwVSdSowX8LyPGZVaz/3G97r+2xPIkmkXK9vs
 zTbwPlST/WuKC2yTDL7NsJhHMkcJj3DNwCdi0lM4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1NM063459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1c7122704;
 Fri, 29 Dec 2023 11:47:01 -0600
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
Subject: [PATCH v2 17/26] arm: dts: k3-am654: remove duplicate wkup_i2c0
Date: Fri, 29 Dec 2023 11:47:14 -0600
Message-ID: <20231229174656.634065-45-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=bb@ti.com;
 h=from:subject; bh=ZYUL2N/kt9+cYkYOCUDOQzvpNcjbtpMW+wW8hr1JuWY=;
 b=owNCWmg5MUFZJlNZbs5jwQAAZn////f/9r/9vx+dsb98367vbuqu1q/3mf/xfqvt/brrv++wA
 RsYHagAANAZADQADRoDQAANGgADQAaAANAGhoAADTI00Mah6hmo8jKep5RA0AaNNABoAABoMQaa
 ABoB5QADRvVBoNMmgaYg00BkeiZBp6gAND1AekAAxkJ6jTNRpoNNNNDQAAZqDENGjQDQGTE0AGg
 AGgMmQGQMgBoAAGTTQNGEAAQdkKlCcroEcF/D/EP8wQA4cZInWkyOvI58eQNLz7AK4CMFYtf8PG
 nDJSBjyEamjMS/pLBdV+REe08CUHJW00k9p5gKGewSfOeJxi8la0yr+5VBCusjZaASmQyhHhk1m
 kzAOiGAzClLZgIbgypauRtzecOoWDtoAE+y47WKuy/pGFDIM3j7hj5uDP9fjhqRdnv1Qk7m01hm
 izrsBcsgV0boF2DnKoCja32LRhMVoywb4Vr3zo03gsnQDA7SsyCbVZQLC39RUsgrTMycfQNqAhK
 OFLjOi8ZAnp6jRCIAQod4/sGNeYsp8LUFOfaOz/Se9Yh6DWIL8+5C0+kL+1fgFn9QKtRLOxsCET
 JXNSVaRgAc1EBrgHniq1UMeKGDPvooqKhARmpxewjxxH48O3FKbvLMEriCTkVmY2CBKDlGSuY67
 pJ3/F3JFOFCQbs5jwQ=
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

With the Linux and U-Boot board dtb files unified, we now have a
duplicate wkup_i2c0 node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 9d7467acd30c9..8c6cb147c821a 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -115,13 +115,6 @@
 		>;
 	};
 
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
-			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
-		>;
-	};
-
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* (V1) MCU_OSPI0_CLK */
@@ -181,24 +174,6 @@
 	/delete-property/ power-domains;
 };
 
-&wkup_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	vdd_mpu: tps62363@60 {
-		compatible = "ti,tps62363";
-		reg = <0x60>;
-		regulator-name = "VDD_MPU";
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <1770000>;
-		regulator-always-on;
-		regulator-boot-on;
-		ti,vsel0-state-high;
-		ti,vsel1-state-high;
-	};
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-- 
2.43.0

