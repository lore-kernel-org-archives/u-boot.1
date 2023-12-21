Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF9C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08BF87942;
	Thu, 21 Dec 2023 18:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IddPAhLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318B087862; Thu, 21 Dec 2023 18:44:35 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77AE878F0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFJl083891;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=SWqKU9syUb8XPbKP9hbV+Y3fcgmac67q1mv0JFKXsJI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IddPAhLaExjZWvaAmr/8eEI997V99iii7OATf6G7mr7J720x8vioR5imFLWEGIuK3
 1gagRZs2+Vcu1sCeFg9cYrIlNB+Oxlxr1awtp4oolIBew3DKfMM2ubyxrgqZUwiWtd
 V3G4TPWe3voMXGNQuU8Y9npaCqCxhkqmqFMVvfhQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFB7025802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEpQ080250;
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
Subject: [PATCH 20/26] arm: dts: k3-am654: remove duplicate mdio
Date: Thu, 21 Dec 2023 11:44:06 -0600
Message-ID: <20231221174412.210807-21-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=bb@ti.com;
 h=from:subject; bh=z3p4z59FFUMqnqSQUlkj3tAhLeozeOcI5JI0SnoCro0=;
 b=owNCWmg5MUFZJlNZcqvKSgAAan///r9bs3/5rV7kFpX7/t/629Zuzc3pWNNZ+u/e3vL2/3+wA
 RmxoxQDIAAAADRoHqA00aaBk0ADQAA0NNqDQNAA00NA0MgGnqG9SeoaHslPUQYTEA0yaBiAZNDJ
 oaDTCAaBiYTIMJkGmI0GQ0YINDJpkABkxGmTJpiAMSYnqNNMQMmJoGmTQMQNMmmgHqepoA0Gg0H
 qAA0AGmh6gNADQ9QA0PUDT1NB5Q0aJbHAzcOE/MBX9BB3MK4IVzHHY3SiCTrUIiDiSIQHnQAZMa
 USO3ZtFihOzeAin6cdFvhLGgs4yOMGr5uRLmLBjR+dvrj5qN29c7x6SErK/+Ym61biKUrYbY00w
 loxb4uJHH/dWe0uqvwNROfBcHQ+i3Z7bjxO5Zfb73+zqmZU0x+GbKY96M/I8MKqULyVZmyElcDk
 3zmGm44f5FrCOhFaHrGLaSB5SLq2yE6ZwfWsemJGVa9asGJI0muAjaIEiYMiADFnHcz1+qMfFMt
 +wRRBjeiHLwQlX5CHIYXAggb+PkWuMa7i2Wu0RddGmkPdesXnxkBOHoNm34zEjHNMS0P2WObSfL
 J9PZRT5qPaIGdVE5IytwGqrikR8Mt9mNTKkv9y02ield1MRfzzol26AGEBKCRlF+xwgKXJL0Mk/
 +LuSKcKEg5VeUlA
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
duplicate mdio node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index e84cf0bf16b27..1b99517e51678 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -154,15 +154,6 @@
 	/delete-property/ assigned-clock-parents;
 };
 
-&davinci_mdio {
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-		/* TODO: phy reset: TCA9555RTWR(i2c:0x21)[p04].GPIO_MCU_RGMII_RSTN */
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
 &mcu_cpsw {
 	reg = <0x0 0x46000000 0x0 0x200000>,
 	      <0x0 0x40f00200 0x0 0x2>;
-- 
2.43.0

