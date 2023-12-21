Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1714C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1328795E;
	Thu, 21 Dec 2023 18:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dsrqd0Yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9E187886; Thu, 21 Dec 2023 18:44:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9164878EE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFdT083887;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=EQ04s4P518K4oPY9S6a+8BmXQ5GH0w+PYHyWAaUUUzc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Dsrqd0YwaqKGOtQndcGCpiGfBlz3/Dgy21AhLwl9IHFFDt8qDxRZknGfkLEX9PlMJ
 0ACxr2PxunUfDnfeAKynunB1IZ642Ul6JhGXwIPg0MKVfYcok6l5OKH67254hey2rv
 2sV0hy5U3HoLgkvD4ERrH4bIfSncY2gHW7OMIb8s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFgA025796
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE4i080244;
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
Subject: [PATCH 17/26] arm: dts: k3-am654: remove duplicate wkup_i2c0
Date: Thu, 21 Dec 2023 11:44:03 -0600
Message-ID: <20231221174412.210807-18-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=bb@ti.com;
 h=from:subject; bh=wEqW3xy4zeNlOuvd87gfdV+bWekHCB4oD0LoEne4xH0=;
 b=owNCWmg5MUFZJlNZ66OyiQAAZH///7fbJr/679e+H/PB3+pfieem2j9///L1/Vu/2ZbL9fewA
 RswHag0aABkDTQaAaDJppoABkGgyBk0GgANDRoDQA00ADahiMmQ0yepk9TaJ6eqINGg0aNNA0ZN
 GmgNAeghhDRoAAYQAYCaaDQDIxNNNqNNGgAAeoYhoZGm1MIaHpAaPUDIyMhoNDRpppiZGINGjEM
 QGRhMRo0AYmBAAGhpiMjEBoNGQAAAHqZk6O3D00ipjpe/BmZAepoI+7yiGoGEAxXQEYrVwFK1HS
 10NB69ErBCXPgmAl1jwCPCNXeAKZTF53YhuqKLeK0o7Jm670YsF6G75D3A1byCIiVfzmY4NWFBw
 pmH/4LHuR7lRsy1gUsaCQAD29MI246/TnJk12+lrY5eFa/uX2xGeG6gDbcHcYtQW7KrKM1ubt03
 z0cJFOW1RuJuYz4JgQDkRlGQyYhkNE4cTrV2pmGJq7cnUw82wQwhZBTk/ptl2XUO160qxC7rbXt
 ctlS3aDDHoovHdACBpq5Ub0JOwdwmdEpGKQRGXEKion9IjAfZqsMupPFFbAU1IaXncPId+Ym/sm
 6bmXCxAElFF/CQhi2CaMVy/Av6E2UcWksAIeMevD68b9AaeO0zQDn+BSPUT5XFToSjQBKc9mpPD
 0ApEzwMP8XckU4UJDro7KJA
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index c4096d1b754c4..19691d26e6fe4 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -112,13 +112,6 @@
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
@@ -176,24 +169,6 @@
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

