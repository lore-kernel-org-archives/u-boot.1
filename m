Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D6C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F49087944;
	Thu, 21 Dec 2023 18:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aBqf2YKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8893B8785E; Thu, 21 Dec 2023 18:44:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D75878DF
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEg0083875;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=0f9kgs++Yb4hUPQgfPgMrZx6k2303iIi3cojdqMPdfc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aBqf2YKzhzrE/WSU+PcD+m1i4Kkk70nmQ/vh0uyHQbnFbxPKUqHr6OH4G6tTLgMQo
 i2+jfzq+bft23ix6koc1OFh6HhL2HzJuPBz0Pylf5IQ2F1EUHtWJNdtAJq9P2WG+nl
 vaqZLKj4vOmbpnJ6oc8xK+N86+bdb53ldLO/Dj8w=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEYb032092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE54069258;
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
Subject: [PATCH 13/26] arm: dts: k3-am654: remove duplicate mcu_uart0 node
Date: Thu, 21 Dec 2023 11:43:59 -0600
Message-ID: <20231221174412.210807-14-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=bb@ti.com;
 h=from:subject; bh=Wo9NCiD3TxujgX0ERR1PUOEK2W+cFQ2+3yr+5tQhZvw=;
 b=owNCWmg5MUFZJlNZxW1DOQAAcP///n//r7n+/XvLj6wedv/+//+/Wl1te/ZR3/oZ/t5buX+wA
 RswHagAaaBoBoAaA0AaPUDTTQaGgBoBoaANNDQNDag0AABoGgaaaZD1M1HqPIMogA0GTBNBhAyZ
 Bo0GmRmo0AaZBpoaAYhkGJiZBoaAAGRk00aaNDQaaGgyAaByYjJkDQ0ZNNGTI0yaBo00YQaYmQG
 jQAAAHpA0Mmg0aGTTRkNDRoDQGQ0xA0AGDPoNLLiQ4Be/DxEMLLiUpSCWio3PFVsXXRkSCP9IKd
 gM0pjHuAtZyR4CY/Hy3wgTY5mWbIFahjephA4fG0oC493gOOhRVx8qkaSLVPyUL+bls5S+uXiHA
 pvUT+EjBobduWzlqAaeBAbB2gfYcKUO+T/u4gLDIgIe/XcHDeY4lUpt/F3zYv0r+0x1gZnVjblQ
 LoBYeOLRzDwz6Ctm8+3OIScUpF4SwptweeDXhNftlu7lt1YrilYAkrkMorKcjOZSDURbtRmkwuu
 ZNNBBlUUnGU+pAQqANNQqA++JtDE83++iGjlWJ0kCSPCUz9MIlfdLYYfknEv3xMxepEwlIyPS7J
 XkfTMIURAKfOlWpRwLz9gObagAsQGiIfwhwSDTvSR6gAKQ84UZocBJvmaocMdkSfKG0K0sBw2JG
 FiOjYj9eyFxckv/i7kinChIYrahnIA=
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

With the Linux and U-Boot board dtb files unified we now have a
duplicate mcu_uart0 node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 47d152cbd4b6d..8c14472f9b463 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
 		spi0 = &ospi0;
 		spi1 = &ospi1;
@@ -96,8 +95,6 @@
 };
 
 &mcu_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
 	clock-frequency = <48000000>;
 	/delete-property/ power-domains;
 	status = "okay";
@@ -123,15 +120,6 @@
 		>;
 	};
 
-	mcu_uart0_pins_default: mcu_uart0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)	/* (P4) MCU_OSPI1_D1.MCU_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)	/* (P5) MCU_OSPI1_D2.MCU_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
-			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
-		>;
-	};
-
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
-- 
2.43.0

