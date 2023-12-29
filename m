Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A019C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CCD87BC8;
	Fri, 29 Dec 2023 18:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MiJNaKiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE99687BE7; Fri, 29 Dec 2023 18:47:15 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3B787BAF
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl3KF088984;
 Fri, 29 Dec 2023 11:47:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872023;
 bh=hspl8fErMD9BgOyBvnZosKfuRnPolbiTCLuBNzC5fDE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MiJNaKiD4W62fKPwIemMGxwKltTrvDA9sOWYogptiNRFm1eGC/GaMBAgwomwl1L62
 mrUov0aaxfIWp2zDWZC4wYA3rg/HV8gj3Q1WaVstXfiRud+8/QFq5+LnjrF/N8NCox
 oGnFti03qaSpTIUheUYRm2i3jpGqWAfzFisZMHlY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl2C1025064
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:02 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl143005115;
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
Subject: [PATCH v2 26/26] arm: dts: k3-am654: convert bootph-pre-ram to
 bootph-all
Date: Fri, 29 Dec 2023 11:47:23 -0600
Message-ID: <20231229174656.634065-54-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014; i=bb@ti.com;
 h=from:subject; bh=qQwVskxZ1mY//gXEGLOU3qFOxcr0wncT4mIkjfN186w=;
 b=kA0DAAoBwPir0+IT1wwByyZiAGWPBMiisgscwEe686VsDMR0b3ouaFOdwm6Zgbys3hanMNqKP
 IkBMwQAAQoAHRYhBPzosO+QdZyNP7UpvsD4q9PiE9cMBQJljwTIAAoJEMD4q9PiE9cMWkAH/0iy
 I8EsJ1R+0QjX561qd/YEKuCqTVHnz0wDV4131teM1Z9TLTTQSMo+Pkfq8tmhA3v/gNTWXDnKG54
 lTmjUzc3ieQT+Au/h2rWhozLmyOBovKf3RuZOhsZXcZsJymk2j0Ogwt8tFru55fop07yQ44S6cy
 m2flhzXsZrctVn6y0/oGRNjLXFSk6wIPgzckKJMvQlEJMRb4EK286gPqJfWO9hqJz9eIlnBd3QF
 BxJzRkH8S6cuHOhuPCSs0TuoCQnTw4Wjndn0gHY13Aje+fxtnpNYZFwIsmaSFEwNHpUoWUr3YsV
 OhDWkwKqQcdFYvC88iWhhzQJJ+KgoaUUVoKRvng=
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

Many nodes are reused between WKUP SPL, MAIN SPL, and U-Boot. Using
bootph-pre-ram is causing these nodes to be present in SPL builds but
pruned away during the U-Boot build. Convert these nodes to bootph-all
so they will remain no matter which dtb build is happening.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 74 ++++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index da6d4dffbf9d2..4fd188fa191b4 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -18,151 +18,151 @@
 };
 
 &vtt_supply {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_navss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_navss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_ringacc {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_udmap {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 
 	chipid@43000014 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_pds {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_clks {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_reset {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_vtm0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ddr_vtt_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_i2c0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_fss0_ospi0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_pmx1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &vdd_mpu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ospi0 {
-	bootph-pre-ram;
+	bootph-all;
 
 	flash@0 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &dwc3_0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &scm_conf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pru0_0 {
-- 
2.43.0

