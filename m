Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB340C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A6B878E9;
	Thu, 21 Dec 2023 18:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RWksjY4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30EF8790F; Thu, 21 Dec 2023 18:44:28 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CCC878BF
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiF9G081627;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=R859uBdplP0ljRQHDz+qar6+YcHkJGkQqVvETqF9RSY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RWksjY4Yvnwm9gVF0pw74Iv+Wdlxq7nOvy+WP+vGhiJG4atgVBs+5AX7no5RhhNwN
 AxGjIIuL6ZXKbY9GbKim/sXmMB9uuFchYmw1xM0AXm5v4oVlFKmuXtdTS2a8ybBOW8
 gUHBvtDQnivRBJd3CSXRaMk6u3rivH1UyuLgjxkw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFsf032101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE8o069278;
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
Subject: [PATCH 24/26] arm: dts: k3-am654: move dummy_clock to root node
Date: Thu, 21 Dec 2023 11:44:10 -0600
Message-ID: <20231221174412.210807-25-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=bb@ti.com;
 h=from:subject; bh=LhuFMz7czptX23zh4NO2csRHwX0XY9tmF5M989YyaNY=;
 b=owNCWmg5MUFZJlNZgEnciwAAY3///v9Pnu+9m/P/918iH98e0j6221dt/nf33v+Kjz/57/6wA
 RszQxQDQGgANBoeo0AGg09QADQAAA0DQB6gAAD1A0B6gyDQaG1PU9Iaekemp4ogDQaZA0aGmmRk
 GjQZDIaNGTJpkBkGIAYEyYIZNMIaGgBpoAA0AGRpoZM1EPUNDTTTR6QZNAMjQaGJk0NGgDEBoA0
 AwajTQGIZMIADTBMgANMI0AGjIBgz4Q0/rPvDhQ4LEVHPFBRipIxJ4znReYNBgoDA9b4zhwAjEp
 SCQL9ezwfq8IeRSv0GYP+LCs2Gz2ABAnX9U48C7vqSW0mEEaZ2F0gGX0ejxFIerYW8GanMXgypj
 yX2rTO+1O5KwWPuqcdGCy0jLE5xRiQVyCfomT8SG2gz+0U0+RMSwVEgCpz8rgkLztewyRWSXvcK
 cTiICVdYqnuAomzbG3N0h+YivCsAdcgd1jD4HsQ/GS5zeq6WziEzlcBSyVCPk+fdfZFEG5TJEUE
 Y2iOK/s1wX96SXbfNea4bNZJUxNB93PtCOZRDoPhi4uZ05/BSVutaDXN18MuR5I+JMIEVAEv9jo
 3iQgBlbesYBzv/xTGnYtZjsas4EdGGzWKikDr6V6LDL1oda3CKYHwSpwDTbgxmoP/jgDwSWEyNI
 /SbyqA+k//F3JFOFCQgEnciwA==
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

The dummy_clock node is used to help the drivers probe the IO needed to
setup consoles and boot media to load firmware into the SoC.

This dummy_clock isn't a device that exists nor does it exist in the
mcu domain. So move it from cbass_mcu to the root node to avoid any
confusion.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index b84fdb5d86482..057853fa3c285 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -30,6 +30,13 @@
 		ti,sci-host-id = <10>;
 		bootph-pre-ram;
 	};
+
+	clk_200mhz: dummy_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		bootph-pre-ram;
+	};
 };
 
 &cbass_mcu {
@@ -51,13 +58,6 @@
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
 	};
-
-	clk_200mhz: dummy_clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
 };
 
 /* timer init is called as part of rproc_start() while
-- 
2.43.0

