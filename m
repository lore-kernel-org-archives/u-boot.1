Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85353C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E787887BF9;
	Fri, 29 Dec 2023 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="On3dfb+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC6B87BC1; Fri, 29 Dec 2023 18:47:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB1387BAC
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1rm088963;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=RoLHcM55mHgd7a5e7T9fT1oMZDABQlabAKofXPfD2OM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=On3dfb+nbrx59Pcg1D8mTcg+HaPhvefRtnOQdmQCoD6+wIxIho1Yk4ZuZ2PYIN90f
 Ow36hiPCp5RFWWYb1BIiz8Gx969xycaQQmfh+NSHv5y75tohrlRjDvk0HQsmaFoNCf
 Ft15Wb3aD3cSkdAEVJNAvFdTLrWpmZ8aUR1BZygg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Ax115353
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1HC122717;
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
Subject: [PATCH v2 19/26] arm: dts: k3-am654: remove usb0
Date: Fri, 29 Dec 2023 11:47:16 -0600
Message-ID: <20231229174656.634065-47-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=bb@ti.com;
 h=from:subject; bh=UBiwbcTN6L9EOFVQ3IseTPyZi4iUOTA05ah4rs8ckgQ=;
 b=owNCWmg5MUFZJlNZ5o7oZwAAav///n/r+691/5/96e/99zcf7/9/3n2/fue/3Jn7m7/m9s6wA
 Rmah2oADQD1AaBoADRkAZA00ANDQAGgZAAAAaADQAABoNAD1ND1Bpk03qj9KIAAAAAANAA0P1Q0
 NAAAPUAAaA0GgaekBoZHqaBtQAGgNDTR6I8oGmQNNNNByHqaNDEGjRpoAADTTTRhNABk0ABoaAa
 AaPUwCBkGgDTQNADTI0DTQAAGmgAAboekDhgQBDiJKZtYPSBIJv+RWDEERKn6GOwQ5zhcJPgbFE
 fiYGnaqnO7Qo10Izpzxe+vWU5QswNNq2asfNg4vZK8JBU0/RZhiMJSRtb53iUHeZqlpN9n2jcmi
 +EJDk9ZozvTzxX9iYBLqELJ1ZYEE5kalimJn+1aucRQjOjhNbOK/EnVUH8bJ8AoZSsx7pgXDWUZ
 pyEgLut/kJSI7hvwxJHiffeKkEApHSiceuiHDA38pgUZx7LwdLwph+9uJeLPWyx5QkFPI1fhj5v
 4vJgnyVicGKxnl9dzVnDJDKmsmPi7Ni6X1S562GFZlUSmkVie6wh/N5B0ulN3A3ygLuRyVffVGe
 DB4pKm3XTj4oHZVicCmOegqxAXBUQaEo6BP/J0TmdCJwei1vmQkKPvlLKlSU6KA2H9JgDTEAaBx
 hEUKAgj/F3JFOFCQ5o7oZw=
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 12 --------
 arch/arm/dts/k3-am654-r5-base-board.dts      | 29 --------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index a24cb895e5578..3647088c29e4b 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -125,10 +125,6 @@
 	bootph-pre-ram;
 };
 
-&usb0_pins_default {
-	bootph-pre-ram;
-};
-
 &main_pmx1 {
 	bootph-pre-ram;
 };
@@ -161,14 +157,6 @@
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
index da41971a78f81..8e57c77cba923 100644
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
@@ -114,14 +112,6 @@
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
@@ -161,14 +151,6 @@
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
@@ -177,17 +159,6 @@
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

