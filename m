Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF14C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB50C87938;
	Thu, 21 Dec 2023 18:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k2tqULFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A4487922; Thu, 21 Dec 2023 18:44:31 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B231878D7
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFoT083895;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=ioGvrFnuezl4+pzoKAkAsQm1H1LAI7TZAjcFyM8Zc64=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=k2tqULFDqijnrxjt1WR1+t+o39y8XA8ix90Gm1dUlBFCFw2EG2PcVzI429Sjk95y0
 zec5JW5tP3D4cq4yGQ34WpFmHTMyb1/buqjG1plVdrs9djS/HUWaOLZuxXeJpQbcoA
 sLk6X1dMOqvN/XT+ElFBirKWkNTvqwrbNngRNSkQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFfJ025808
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEKh069275;
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
Subject: [PATCH 21/26] arm: dts: k3-am654: remove duplicate vtt pinmux
Date: Thu, 21 Dec 2023 11:44:07 -0600
Message-ID: <20231221174412.210807-22-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=bb@ti.com;
 h=from:subject; bh=dWil0hxayB8YOKZD3ZEOceMfvPYh9pycGgVDv81Qd44=;
 b=owNCWmg5MUFZJlNZkaaA4AAAdP///v/9/m//q5+/eD73+8/n+7e//BfJ++/T3i1Pjvbb8/WwA
 RmwyHqAyaA00ZAAAAABkAABpoAAaNGjQDEGQAaAGhoMTRoYyRtEGT0AEQGhoaaZBo0NADIDTIDE
 aBoAYgAyekMIaaGmQGEMgxAaaAAaNDIGTBNDICGho9RhGmCGE0ZBkBoA000aABoMjI0AAZGRpoa
 HqaAD1MgaNAABhMjIAAaA4f4ELUP2AqMPcBdvy8f9ShuIHmRASOj7H/TZEyDs+oLIa1DIdWJzOZ
 iqXgGsVY8uAyA6QuJ0GHBnBfAb9Cu7JzbmWWUwThn8gexULAWneQFKldHrRcf5TJNcRcyRIsYEA
 VJh3Yk/XPKEc0DZ3vH+Jfoih9upF9o7aGgx17xS/CB+Tx6CR+/0nyW4K/cYjjhEsIgOqBqDPj5X
 n4w8AnvG/lLe7SJm7dkM0Xw6YzJBmAFQQpMf71APLSlQd2kLtYq/SIxYtyvjYR9CkRzhYgGhVig
 ijZqnsyJWjIPF4ioSjPEm9eiGMB4LcAfABsTqMxV6nIsNuinGUq+luStCfE0MtAjRpmuFCtuDWl
 2IAi0k9GspYAREuBjJcO7VoleyZrwzn62ACVME72TcMmnVnBixrh+4NhKNPaP852rY84Ax3VgaG
 2P9/i7kinChISNNAcA=
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi |  2 +-
 arch/arm/dts/k3-am654-r5-base-board.dts      | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 104cb2e559f2f..a9b2d0d2a3036 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -101,7 +101,7 @@
 	bootph-pre-ram;
 };
 
-&wkup_vtt_pins_default {
+&ddr_vtt_pins_default {
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 1b99517e51678..b4aa904e9bb4d 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -101,18 +101,8 @@
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
 
 /* MMC is probed to pull in firmware, so any clock
-- 
2.43.0

