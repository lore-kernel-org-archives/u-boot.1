Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797E4C46CD8
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8503C878FF;
	Thu, 21 Dec 2023 18:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="suwCvxTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10FE878FF; Thu, 21 Dec 2023 18:44:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F24587884
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiENP118521;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=2dxNn8RimXgan8eV+ISTVpWoim1ktb31jrsUR/ijS0s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=suwCvxTTe5bVqcDR2UaYaCVD/+p0kc9AzPsGRJw8g01GS2AiItAZm6ZEIZhhodZJz
 CtOwsWDGy3tC5KS5piX6tq4rFS+FZkczY2HbxypTTYIzssIE5/46Mw5SJQxrFOPjaI
 GQZYmqMquTthPgA1ruVAycrr84Ng4psByqwhSGbY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiE6g097309
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEhF069248;
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
Subject: [PATCH 11/26] arm: dts: k3-am654: remove duplicate mcu_udmap
Date: Thu, 21 Dec 2023 11:43:57 -0600
Message-ID: <20231221174412.210807-12-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=bb@ti.com;
 h=from:subject; bh=LHBkk6oR7U7wN9Hmwo9mCj17e46zrH/adD0lSZBLACc=;
 b=owNCWmg5MUFZJlNZMT/fMwAAav///79Pf/1gOd7zcMPfv/q/+R7/93au+Xsn6c9bwvB/+e2wA
 RttNIAPUDQAD1A00A0D1HqDQAANAGgGjQABk0AABo9Tymh6TTajJptTTahjUeEiHqBoZGQMRkYg
 AaMg2kZNNAADQAZNNGRk0wRtTRkNNGgaGEek0NGg0GmIaaeoZIxDaEyGgaMTTahppo0GjQ0YjIa
 aDRoBoGhoGjIBoyAaaMINNGTQwgwJk0AIEQwUXvJZycSPGSxAxn1QUnvuQ4LogOAbhNAUvmG3Ni
 IOFU7mhmPYMeSYn4RrrwM+U/KIPvyHRW4PzUKyNb4jMo5QICzSC1St5A714fjjuKYEPJ2Aht/l6
 IlYuGErgQ6EFrSRCF/FJDy0xUfVqdWQVtIdKAKzcKCE524OqwxfCqHIEslsMjPWPywH6d3WhVx9
 JBWtNZA4n/6giuBTxTkGfAIDrZrZA4g6DAIf7KgDCTIjOKQlgzdy0RhzK60ANryRJ4tenZY2ct9
 2p5xvIQ9LCUTD+LVDxuBEpTGG6v3uX0As3dljtzm35p7KZszB6iUiH7USkjToroXEMkz3R1AMFF
 lKyjUDFxLmMXJb+20jHCBlBewCOFdFYv3iRNeXAqsJvGtS3o6I+fHEOxaQGMGwZ1GtaAsxN0QAI
 8V0pH6Sv8XckU4UJAxP98zA
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
duplicate mcu_udmap node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index cb25db7a3afd0..47d152cbd4b6d 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -52,19 +52,6 @@
 		#mbox-cells = <1>;
 		bootph-pre-ram;
 	};
-
-	mcu_navss: bus@28380000 {
-		dma-controller@285c0000 {
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x284c0000 0x0 0x4000>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x284a0000 0x0 0x4000>,
-				<0x0 0x2aa00000 0x0 0x40000>,
-				<0x0 0x28400000 0x0 0x2000>;
-			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-					    "tchanrt", "rflow";
-		};
-	};
 };
 
 &cbass_wakeup {
-- 
2.43.0

