Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536ACC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1F287940;
	Thu, 21 Dec 2023 18:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B0r2jzjc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66703878F5; Thu, 21 Dec 2023 18:44:32 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0B8878E3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFl7027126;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=KODsTwbCXwowln1WNA86kMLi7G3gEF4k5zt0xA5wm0Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=B0r2jzjcoI8u7oZIqvR+FE76RBIu/p8mIWWgwsr3hRw4gkvqLXSdAydSKBj3cSs5q
 OLLANQ1Tx7NRMm43jQrAK/kFljGg0OBmRbKlgD8q5cA4waJfKXlXITbtz67UP3VcBS
 i8tUOLmdShMrB6HJ5bGBQLucJ7/qOnqf6MflhqDQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiF5O032096
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEZq069269;
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
Subject: [PATCH 16/26] arm: dts: k3-am654: remove duplicate sdhci1 pinmux node
Date: Thu, 21 Dec 2023 11:44:02 -0600
Message-ID: <20231221174412.210807-17-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=bb@ti.com;
 h=from:subject; bh=BC2j5h9tzNTs/ETxGWA/mT9vdOecyNErfav+z5RBT/s=;
 b=owNCWmg5MUFZJlNZNXKG3wAAZP///7drj//6fb/e4xrZH/Xzg7ey/XdcrerP84x6/1fn//+wA
 RrVmMoaMQNGhoNGho0NDTJkNAybUMmjQDRoBhGgGjENBoANBpmoekDT1NDQyGg9Q9RhyGQYjTQM
 BAADQxMJkNA0aaDQBkaDJphDQaMmBGgGmgYjRp6hkGgNDQ9EO9U09T0TNQ0PUyAHogAaGgBoaBo
 ADQA0NBiAADQ9QZNADRoAAA2oDNT9KCCFap9SKsJEeBkFOsESkG5SjrWh/RfEBpW1BfYJMF8aTQ
 iw9pfjD3gtJNQ9trq05WdiPPbEN+3oOdViOpw89HzbmVbjA9bHwdOO8dmPRb9VufS8Op8mkWcU6
 0Q+nHi4agFXw87j0+8kq4xRwrMy32P1ALPCjAMezfRA20cVXra9/qL22miu+7ooN6P6fEHiG+4P
 jG7hRpNnLe9LnqAAz5cpRNOALH6t0IXoAOKW7Z24f8i8QAMGeVbqLCT9MPGGWHeaq5tDezVYh1X
 xKADBfgRQtNnz91m9hlbEw9wgwmHgihP+ty1MnLY5esnCQdHNVJWJ4nn9gd6udJ7ipQfP8nAzDa
 69mO2A4H0B/XZAjKUrmyHd1DZDOl/Z2iMC3JXnnesoToVXIX5jGlbdgcmVCIuNMAKXeKogkwIxX
 +oXI3+GLAF3JFOFCQNXKG3w
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
duplicate sdhci1 pinmux node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 856917bdfaa5d..c4096d1b754c4 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -137,19 +137,6 @@
 };
 
 &main_pmx0 {
-	main_mmc1_pins_default: main_mmc1_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)	/* (C27) MMC1_CLK */
-			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0)	/* (C28) MMC1_CMD */
-			AM65X_IOPAD(0x02d0, PIN_INPUT_PULLUP, 0)	/* (D28) MMC1_DAT0 */
-			AM65X_IOPAD(0x02cc, PIN_INPUT_PULLUP, 0)	/* (E27) MMC1_DAT1 */
-			AM65X_IOPAD(0x02c8, PIN_INPUT_PULLUP, 0)	/* (D26) MMC1_DAT2 */
-			AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP, 0)	/* (D27) MMC1_DAT3 */
-			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0)	/* (B24) MMC1_SDCD */
-			AM65X_IOPAD(0x02e0, PIN_INPUT, 0)		/* (C24) MMC1_SDWP */
-		>;
-	};
-
 	usb0_pins_default: usb0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
@@ -176,12 +163,17 @@
 	/delete-property/ power-domains;
 };
 
+/* MMC is probed to pull in firmware, so any clock
+ * or power-domain operation will fail as we do not
+ * have the firmware running at this point. Delete the
+ * power-domain properties to avoid making calls to
+ * SYSFW before it is loaded. Public ROM has already
+ * set it up for us anyway.
+ */
 &sdhci1 {
 	clock-names = "clk_xin";
 	clocks = <&clk_200mhz>;
-	pinctrl-0 = <&main_mmc1_pins_default>;
 	/delete-property/ power-domains;
-	ti,driver-strength-ohm = <50>;
 };
 
 &wkup_i2c0 {
-- 
2.43.0

