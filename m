Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F0C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F068B87BDA;
	Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MTwhVfk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3136187BAE; Fri, 29 Dec 2023 18:47:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12F68756F
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1D9032450;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=mWwUynd+iPH8aiRAy+DCqHXP7NvoqNC2XaLq3ZoxMJ4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MTwhVfk3+o4ZlNAelMjEAusgIoYlHl46TI32PC2EjLrGIAmELSSWoar4NLVG2arXX
 oZl3NnFro5b9LrY0u1JiqiPu/6T5Lc/gtn18eQhfIcPSVM25p3ov4yHjnUdOr2Bnw/
 dU5hkm7wKHp5kqhRjoi2J6HgRaUf0jVqq7UJOKO4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Ft115358
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl10k122723;
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
Subject: [PATCH v2 21/26] arm: dts: k3-am654: remove duplicate vtt pinmux
Date: Fri, 29 Dec 2023 11:47:18 -0600
Message-ID: <20231229174656.634065-49-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=bb@ti.com;
 h=from:subject; bh=+6ABvnc6OJ2XVKXJb7RpbJppg3Z4s4VpfjLitlN0Shk=;
 b=owNCWmg5MUFZJlNZC80K+gAAbP///v/9u/0r/9n/Zf/f/9qb9Hb71718+vbT7/7/i3Rr71ewA
 RsW0gDTQBoDQ0GmQD1DTQxA0GjJoGQAAZNAPSYQyABpkGIBkADINADTQ0abUPSIaDRoGjQaAAAa
 BoYhoAAaDIBkDIA0NAGmjQ0yMgaMJoGmmQ0aaBk0aMT0mamhVIZBkaDRo0AzSGgMTI0xNAaBoAA
 GTRo0aaNA9RiGgDQaGgAAAD1GQA0AALF7A2itmjdb7za6uTsYuwQQxDplOAa7gHgDj6qcH9IE7U
 t9fan+gjmyYvvAUdlhpgpbgpEI+rTxZc2OPdlOQ3EjLxKL1qrDPFW5YMu1RjAckUSRlGaOc30KW
 tWN2/G03UCSEq256ajANkiYEdEq0ap4fTEnvMz+oRQv4JqgDaxoZ0ip+5YlYNQlOj7/p+Rg1WSL
 cJxBzkNgm3RMzQ6qslx8itpHMapR2ejwLGDh/78Xwd94BSlFpF5TxLV/Md+ezuCGCAUNDXvJMp1
 j1idBeT0aCfC0AxE4Zxiv+4SYM8SEV+csHrg+/HeRu2SFghsypcdtB0wTBq0f+pMwbqd58VXszP
 UEI+tAv3pCYgV4LeA1j2l0QDoi4SoByGWIHQEWXufEHN9w4CYRtmmbEoAi2ACmF7YK4IFv7yBzT
 oIYImQh0MM2bAcP+LuSKcKEgF5oV9A=
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
duplicate vtt_pinmux node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi |  2 +-
 arch/arm/dts/k3-am654-r5-base-board.dts      | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 3647088c29e4b..da6d4dffbf9d2 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -93,7 +93,7 @@
 	bootph-pre-ram;
 };
 
-&wkup_vtt_pins_default {
+&ddr_vtt_pins_default {
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 14bf1b4c8a462..fb238adaea5b2 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -104,18 +104,8 @@
 	vdd-supply-4 = <&vdd_mpu>;
 };
 
-&wkup_pmx0 {
-	wkup_vtt_pins_default: wkup_vtt_pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
-		>;
-	};
-};
-
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_vtt_pins_default>;
 };
 
 /*
-- 
2.43.0

