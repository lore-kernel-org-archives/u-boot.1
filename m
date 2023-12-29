Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5A6C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD8987BBB;
	Fri, 29 Dec 2023 18:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fbedbMbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCB387BD7; Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FD287B8F
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1N0032434;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=ZSgTb02Tk8zRKqUb1MJ25uo1ryoaON6bjV04qtAxLGA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fbedbMbEDL5ynDD2pxfeYzE4YQMtD97MSR47bsnsRNcC64hLz0wA//OblG4pLFuqR
 6+F7MlvwAH4UJ6edGIoctj3jGuBQaC0tWQ1dwtQCXBNm9nNT2K54uBQvUFUbgtmY7D
 ChPUruxw4WRPTtHHP0G+duMBpq8SwJiCiO9lW2e4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1CG063438
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1Eg122683;
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
Subject: [PATCH v2 11/26] arm: dts: k3-am654: remove duplicate mcu_udmap
Date: Fri, 29 Dec 2023 11:47:08 -0600
Message-ID: <20231229174656.634065-39-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=bb@ti.com;
 h=from:subject; bh=4KkG6YSh71gyh2Mq5U0P+fjfbRpZvYtT7Bu0jePyN0s=;
 b=owNCWmg5MUFZJlNZucj3wwAAaH///v95v+3tW3+t/ghv3vt+2Vtv+DbcW/u95v/+9/Vnp/8wA
 RsZo5NAaGnqaBppkAANDQNMhpo0GhoAYjQaABowmQZAyA0GgMQ0xANqG0mQ9QehAaaNAGTQD1DQ
 0yAAMgaAaAaaA0AbUA9QMTQMmgBoxNPU2k0ep5QMgB6jQ0B6gxQ9TCeo0MgBiDQGg9QAaNNGg0y
 AGmQAyMgBoAAyGgaGgNNGnqHqAaBowBAgt18Pc47BCfxA5x+DJ7fEOExgJAOpzSUHAgZZ8AUUFR
 cLVsuJfRyJFVC/Xs5kn2YS62jJmdSqYlIFVh4sKio2q+KDZDCtFwI7SggSOHNMmJxx8ZOGjwhc9
 SmhydMIYN9NrWDXchmMXy6AMAhVbyqkAbliBPdiAGkdeby9COdMKOyn1n0JsOEdfbmm7A1dGI1b
 kEjDlf0QfbL/nZWoYIzlAL1gEdtJdSy/oTpeGedydQPfMcZAr7drYU3/gq/JJeeAIhCvMhG0fVS
 ci4V3eyCAAL9K4EMJFVJzmDaDCrZhzTu8ideLsTwmjBvubviteQ1u8DG/F4pzTg2JuoDi3kMD/+
 8s4csnemY+rmNFh8BHrBj3MowMyU/SNq1k1ntRtGNDIKgoMve4Kl5Noo1puFwM6d0TzMH78E9hO
 2AyAZSCHBDu48ei7kinChIXOR74YA==
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index c4fa84a3d0b05..19806ec4e2309 100644
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

