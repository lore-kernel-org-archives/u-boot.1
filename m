Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FBEC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B021687934;
	Thu, 21 Dec 2023 18:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H1Ya2XeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E0F878BA; Thu, 21 Dec 2023 18:44:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DC0878EC
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFJp027130;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=Qkt+DcryPKiAYVScXqvSDHxwzomRGaIIlh3lIgf4KFU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H1Ya2XeWPq9WErpfum/o/afCUVNFzsbcOxvd0gwX0sM8LgU8W0gNWf2XBN8LRfoY4
 +4u1UeRAU3RCWFqenMnUiaIHv6Q9ro0L0u3r38NZAlYGNZuJbC0m72sjwTZgaEGdqG
 PGGf6ZUDP0Xuwu/zG0m5Bn/LlJCpncnB/QXTtyTo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiF55113480
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFG1069284;
 Thu, 21 Dec 2023 11:44:15 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 26/26] arm: dts: k3-am654: convert bootph-pre-ram to bootph-all
Date: Thu, 21 Dec 2023 11:44:12 -0600
Message-ID: <20231221174412.210807-27-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087; i=bb@ti.com;
 h=from:subject; bh=Wh7Ifu1MJ8jolmzPS6prV+zocH5X0uQqdYmvuCfI+98=;
 b=owNCWmg5MUFZJlNZgOFqDwAAaf////9/P//tueK397xb/31rsP02/+1e38eP273//tl9jnewA
 RsWDFAA0AAGgGgAGhoYjIAA00AAAaAxPUAAAeoAAD1AAaGmgfqaamT0n6odAANAAHlBtQAAaANH
 qAADRp6gGhoD1A0HpoJoAADQ9QA8kHqNHqDIGg0BD1NNGhoYQYnqGjQ0AZBoaGmgZAPUAAAGgMg
 0YQDI0AxANNNGmjQGEBoNGJgcO2EhadwI9cd3ehsnAQUwwKVEg9hSkqTXaoohAu2KTgxHgBmgji
 TDcvMLuX+gG0GdsZTrfwkCZQtBBUqtupsg0RgyNDfl20yBKqOZZwfjN8YWpexi8FSfVGIbhYwT6
 zqJD54+LvpiEv8wHofZpQYDLnFAFFHJwW6hV5YgWguV+6Kj2R5gYnMccfSJ8Bg50/WYkMyC9iUA
 hO+LhDMmqFO2+WjWkmiLwsLeq9VX6nOE1kQHz5ulNI2QoKFG6DQMZsG23zLa15ztJ+DILQGe2W+
 w0+F9SUjxMsYYuISNB/EBDEAq32vIp0ZfZ5uU3znkCAYYRYQJnZvIwNFkBqHUT301kXCwwh7nex
 XgQri1IwswaUeQqpVlUISjEQpAUTqlA5iO8VWUXlqyUYf1F+BviRqmRNIl9EPPgD/SARbcIjeH7
 CP/i7kinChIQHC1B4A=
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 78 ++++++++++----------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index a9b2d0d2a3036..770c7d129339f 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -18,159 +18,159 @@
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
 
 &wkup_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_uart0 {
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

