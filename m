Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387F6E75434
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388948727A;
	Tue,  3 Oct 2023 10:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jVdUWmTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C6E86BE1; Tue,  3 Oct 2023 10:10:58 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFC18724A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938Ar08011552;
 Tue, 3 Oct 2023 03:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320653;
 bh=lvFXwBhHmQ3zPio9lR70zXYUitE3UpBnQeNjKjKr24g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jVdUWmTULmCcx+DRyV8wF5K9FDifGb5LC9ZDF9teR4/oSFKMqo71xmlcA4NV0fkEz
 JhPxL10hrScz+gYthbAnaz9ZAkHoB9/oL1/PXg7xOwDEOYi97zS3snjWjUBfWHgEBP
 23Jgzp0kmoYCUP8r3zpeXTWFiL3EB1hbW2CI50sI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938ArQd125557
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:10:53 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:10:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:10:52 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhED110453;
 Tue, 3 Oct 2023 03:10:51 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 03/10] arm: dts: k3-j721s2-r5-common-proc-board: Add ESM
 PMIC and dependent nodes
Date: Tue, 3 Oct 2023 13:40:31 +0530
Message-ID: <20231003081038.24299-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003081038.24299-1-j-keerthy@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
MIME-Version: 1.0
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

PMIC ESM is part of tps6594x PMIC and connected to WKUP_I2C instance.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../dts/k3-j721s2-r5-common-proc-board.dts    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index c74e8e58ae..629706aaf1 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -142,6 +142,14 @@
 			J721S2_WKUP_IOPAD(0x0b4, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
 	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+		bootph-pre-ram;
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
+		>;
+	};
 };
 
 &sms {
@@ -197,4 +205,35 @@
 	ti,sci = <&dm_tifs>;
 };
 
+&wkup_i2c0 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps659413: tps659413@48 {
+		compatible = "ti,tps659413";
+		reg = <0x48>;
+		bootph-pre-ram;
+
+		regulators: regulators {
+			bootph-pre-ram;
+			buck1234_reg: buck1234 {
+				/*VDD_CPU_AVS*/
+				regulator-name = "buck1234";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <900000>;
+				regulator-always-on;
+				regulator-boot-on;
+				bootph-pre-ram;
+			};
+		};
+
+		esm: esm {
+			compatible = "ti,tps659413-esm";
+			bootph-pre-ram;
+		};
+	};
+};
+
 #include "k3-j721s2-common-proc-board-u-boot.dtsi"
-- 
2.17.1

