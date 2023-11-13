Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1CAC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4E3871A5;
	Mon, 13 Nov 2023 15:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gss1G9Xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DADD871E9; Mon, 13 Nov 2023 15:59:39 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439FE87154
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExRS7030684;
 Mon, 13 Nov 2023 08:59:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887567;
 bh=qSNjBZSUSTL14HQryuuL292C9BVI5OMk/BfOTgVFKpE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Gss1G9XyFqFKWMzSNOsR6nv7nkDpVW1q48EgmsfhwdTpKMHgcMA5zCChSSN/FJd4T
 /vURH5/0+Mu9dQtdDWH664DBwjSZ9Tm3WC0dljc9yZ3YoAnMABSPUlUrCAo8MQRGrD
 tsSaKruumQVz/tcDZuE9bH1/eEzVV9MOau5wwgvo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADExRN9017310
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:59:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:59:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:59:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExQBb041120;
 Mon, 13 Nov 2023 08:59:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/4] arm: dts: k3-am625-beagleplay-u-boot: drop duplicate
 bootph-nodes
Date: Mon, 13 Nov 2023 08:59:18 -0600
Message-ID: <20231113145919.1928812-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145919.1928812-1-nm@ti.com>
References: <20231113145919.1928812-1-nm@ti.com>
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

Kernel dts import now provides bootph-all and bootph-pre-ram properties
for the properties we have been overriding so far. Drop the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 56 --------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 6f3a31558b20..7f8468f298f0 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -13,36 +13,26 @@
 		tick-timer = &main_timer0;
 	};
 
-	memory@80000000 {
-		bootph-all;
-	};
-
 	/* Keep the LEDs on by default to indicate life */
 	leds {
-		bootph-all;
 		led-0 {
 			default-state = "on";
-			bootph-all;
 		};
 
 		led-1 {
 			default-state = "on";
-			bootph-all;
 		};
 
 		led-2 {
 			default-state = "on";
-			bootph-all;
 		};
 
 		led-3 {
 			default-state = "on";
-			bootph-all;
 		};
 
 		led-4 {
 			default-state = "on";
-			bootph-all;
 		};
 	};
 };
@@ -58,45 +48,7 @@
 	};
 };
 
-&main_uart0 {
-	bootph-all;
-};
-
-&console_pins_default {
-	bootph-all;
-};
-
-&main_i2c0 {
-	bootph-all;
-};
-
-&local_i2c_pins_default {
-	bootph-all;
-};
-
-&gpio0_pins_default {
-	bootph-all;
-};
-
-&main_gpio0 {
-	bootph-all;
-};
-
-&main_gpio1 {
-	bootph-all;
-};
-
-&sdhci0 {
-	/* EMMC */
-	bootph-all;
-};
-
-&emmc_pins_default {
-	bootph-all;
-};
-
 &sd_pins_default {
-	bootph-all;
 	/* Force to use SDCD card detect pin */
 	pinctrl-single,pins = <
 		AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
@@ -109,14 +61,6 @@
 	>;
 };
 
-&tps65219 {
-	bootph-all;
-};
-
-&sdhci1 {
-	bootph-all;
-};
-
 #ifdef CONFIG_TARGET_AM625_A53_EVM
 
 #define SPL_AM625_BEAGLEPLAY_DTB "spl/dts/k3-am625-beagleplay.dtb"
-- 
2.40.0

