Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C5CE92723
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 18:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF22886CA7;
	Thu,  5 Oct 2023 20:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rTflDpDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96ECE86CA7; Thu,  5 Oct 2023 20:15:32 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4700F86B58
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 20:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395IFMVR097805;
 Thu, 5 Oct 2023 13:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696529722;
 bh=j2rwcuQCc8Yxt9PPCuN1hVt/swvVaxrJ5pUF+ajVZDs=;
 h=From:To:CC:Subject:Date;
 b=rTflDpDTJNB/EWeG/mh6fvJv/VygNJOcCsSuNqwlRIgi+N7IpBpPf0L9IsclZUweH
 6aaf9tyvchImTEjhKqRSIsdWIdG8BVONtLYlO8bhOLaHFUnBeO58v1RXRi59FrsFj1
 W3tTZ/gDWzhYVMOTPnXoaAmoAffbN55vD4fHS65w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395IFMBh014438
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 13:15:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 13:15:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 13:15:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395IFM3C063155;
 Thu, 5 Oct 2023 13:15:22 -0500
From: Nishanth Menon <nm@ti.com>
To: <trini@konsulko.com>
CC: <vigneshr@ti.com>, <m-chawdhry@ti.com>, <sjg@chromium.org>,
 <jonas@kwiboo.se>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Neha Francis <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-j721e-sk/common-proc-board: Fix boot
Date: Thu, 5 Oct 2023 13:15:14 -0500
Message-ID: <20231005181514.4054241-1-nm@ti.com>
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

Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node
as pre-reloc after relocation") A53 u-boot proper is broken. This is
because nodes marked as 'bootph-pre-ram' are not available at u-boot
proper before relocation.

To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.

Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
Cc: Neha Francis <n-francis@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

The original patch was reviewed prior to commit 9e644284ab81
However the recent break in u-boot requires fixup to maintain sanity.

Neha: I have only build tested this and have assumed this follows the
same pattern of fails with  other platforms - please test and review for
functionality.

 .../k3-j721e-common-proc-board-u-boot.dtsi    | 82 +++++++++----------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 70 ++++++++--------
 2 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index c638af63c180..cd95907b981b 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -6,27 +6,27 @@
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_navss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_mcu_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 
 	chipid@43000014 {
-		bootph-pre-ram;
+		bootph-all;
 	};
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
@@ -38,144 +38,144 @@
 		<0x0 0x28400000 0x0 0x2000>;
 	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
 		    "tchanrt", "rflow";
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
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
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
 
 &wkup_pmx0 {
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
 
 &mcu_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_sdhci0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_usbss0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usbss0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb0 {
 	dr_mode = "peripheral";
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_i2c0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 	status = "okay";
 };
 
 &wkup_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 	status = "okay";
 };
 
 &main_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_i2c0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_esm {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &exp2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_fss0_ospi0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_gpio0 {
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
 
 &ospi1 {
-	bootph-pre-ram;
+	bootph-all;
 
 	flash@0 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &mcu_fss0_hpb0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_gpio_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_fss0_ospi1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 57da7c210a8d..370fe5190b2d 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -6,27 +6,27 @@
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_navss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_mcu_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 
 	chipid@43000014 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &mcu_navss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_ringacc {
-		bootph-pre-ram;
+		bootph-all;
 };
 
 &mcu_udmap {
@@ -38,120 +38,120 @@
 		<0x0 0x28400000 0x0 0x2000>;
 		reg-names = "gcfg", "rchan", "rchanrt", "tchan",
 			    "tchanrt", "rflow";
-		bootph-pre-ram;
+		bootph-all;
 };
 
 &secure_proxy_main {
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
 
 &wkup_pmx0 {
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
 
 &mcu_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_usbss0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usbss0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb0 {
 	dr_mode = "host";
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_usbss1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usbss1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb1 {
 	dr_mode = "host";
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_i2c0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 	status = "okay";
 };
 
 &mcu_fss0_ospi0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_esm {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ospi0 {
-	bootph-pre-ram;
+	bootph-all;
 
 	flash@0 {
-		bootph-pre-ram;
+		bootph-all;
 
 		partition@3fc0000 {
-			bootph-pre-ram;
+			bootph-all;
 		};
 	};
 };
-- 
2.40.0

