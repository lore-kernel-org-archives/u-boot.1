Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0793DE784BB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4200386E06;
	Mon,  2 Oct 2023 17:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KHGlLtBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FCF86EA1; Mon,  2 Oct 2023 17:01:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1439786DFD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392F0suT025489;
 Mon, 2 Oct 2023 10:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696258854;
 bh=fQ2ehiH6HM7E/V1ZtCbmsQ2JnF/F+a8CP7NU5EO3tjQ=;
 h=From:To:CC:Subject:Date;
 b=KHGlLtBvshJEnHCh5OVJ/xxpUYdQb4nVf2vRhiyYuQm4vZslcBeWrKO/rj9d0sPXh
 c8/Erxo+e3jcJSgee1VhiD402jO5W5TaJ+mxTdcrdBgUMg4cjdKjKBdDe9iFV2NjFU
 Hah7BR04x86hKpqUsDntcem4zqDl29LRoIvSWF44=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392F0s9A096527
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:00:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:00:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:00:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392F0stx099670;
 Mon, 2 Oct 2023 10:00:54 -0500
From: Nishanth Menon <nm@ti.com>
To: <trini@konsulko.com>
CC: <vigneshr@ti.com>, <m-chawdhry@ti.com>, <sjg@chromium.org>,
 <jonas@kwiboo.se>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm: dts: k3-am625-beagleplay: Fix Boot
Date: Mon, 2 Oct 2023 10:00:53 -0500
Message-ID: <20231002150053.2930710-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

Since commit [1] A53 u-boot proper is broken. This is because nodes
marked as 'bootph-pre-ram' are not available at u-boot proper before
relocation.

To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.

[1]
9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Reported-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on Roger's series:
https://lore.kernel.org/all/20230929134646.214781-1-rogerq@kernel.org/

Based on:
  next                       e29b932aa07f Merge branch '2023-09-30-Kconfig-updates' into next

See discussion thread:
https://lore.kernel.org/all/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 70 ++++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index f8c04e8a300a..d6c6baa5518b 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -14,143 +14,143 @@
 	};
 
 	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 
 	/* Keep the LEDs on by default to indicate life */
 	leds {
-		bootph-pre-ram;
+		bootph-all;
 		led-0 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 
 		led-1 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 
 		led-2 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 
 		led-3 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 
 		led-4 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 	};
 };
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_timer0 {
 	clock-frequency = <25000000>;
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &dmss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
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
 
 &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &wkup_conf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &chipid {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &console_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &local_i2c_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &gpio0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci0 {
 	/* EMMC */
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &emmc_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sd_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 	/* Force to use SDCD card detect pin */
 	pinctrl-single,pins = <
 		AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
@@ -164,11 +164,11 @@
 };
 
 &tps65219 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 #ifdef CONFIG_TARGET_AM625_A53_EVM
-- 
2.40.0

