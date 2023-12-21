Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4566EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D56B87925;
	Thu, 21 Dec 2023 18:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kM8VptDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D8487917; Thu, 21 Dec 2023 18:44:30 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8E8878DE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEDP083879;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=TMAcgVQgdAuCtB9mMv91Knpil3lh5AGIf/++M4vMt00=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kM8VptDxPzgqyu7E6GcbhL+xxSh5JqUE0aT+2pi0dYyOzOMcAgNFQ41y4d1y/Fk4/
 xtPVK0GtKmghZWkrvIC9euH2NTO2HB4vv9gQ0GK+p3xxQmvdXEsJepj8DZgrWHC/Dw
 3vZa4K7Xeoi5Jwmu+46zVXEWqbcZVqZqRSexRaRM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiE3T097316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEaS080241;
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
Subject: [PATCH 14/26] arm: dts: k3-am654: remove duplicate main_uart0
Date: Thu, 21 Dec 2023 11:44:00 -0600
Message-ID: <20231221174412.210807-15-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=bb@ti.com;
 h=from:subject; bh=3GFizAV9cT1nUFQk32ZXa+yunxjm2QQsvDpC7sq1fBU=;
 b=kA0DAAoBwPir0+IT1wwByyZiAGWEd/KjrxxRCP0yXxpPZ/cEzazmkySH0vjCJZE4oer/KRWDc
 YkBMwQAAQoAHRYhBPzosO+QdZyNP7UpvsD4q9PiE9cMBQJlhHfyAAoJEMD4q9PiE9cMsjIIAIbl
 HTOXVVuCSCHdJanCqTqk5orHaxFNTcXqd+eTN+Cq3lnFQUrbEjTgwv5HKTgHzIvfjUVM/AKzh5v
 TxW3RMYtVBx9HASeWGRalItR8QpBHicJ7PyxiTeVc9V8NjVMdtD/fuo0Fi1vHDu9S+1WJMOffQl
 GCoOu2zsvV3mDh7IGQNyvnT66aqYvoG4noqFDbQxdOM354HVioFINAIjJpcQnJ3XyqHp9YU3fml
 Ip2j9RczVcdc8LaC5prf3BxiJRbCBGLKllwkzd2xp3Upc/3BLA2mPDrvan31zG7xqbWrd9HojW5
 xV9P1h7ItYQdYxxBzUzXoLtu3/vBCJQr4tIjrj8=
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
duplicate main_uart0 node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 8c14472f9b463..66953eb5581ae 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial2 = &main_uart0;
 		spi0 = &ospi0;
 		spi1 = &ospi1;
 		usb0 = &usb0;
@@ -100,13 +99,6 @@
 	status = "okay";
 };
 
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-	status = "okay";
-};
-
 &wkup_vtm0 {
 	compatible = "ti,am654-vtm", "ti,am654-avs";
 	vdd-supply-3 = <&vdd_mpu>;
@@ -145,15 +137,6 @@
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01e4, PIN_INPUT, 0)	/* (AF11) UART0_RXD */
-			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)	/* (AE11) UART0_TXD */
-			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
-			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
-		>;
-	};
-
 	main_mmc0_pins_default: main_mmc0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)	/* (B25) MMC0_CLK */
-- 
2.43.0

