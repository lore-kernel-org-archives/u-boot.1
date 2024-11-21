Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07568D6ED0E
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE4389763;
	Thu, 21 Nov 2024 13:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X+gZNSHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DF589760; Thu, 21 Nov 2024 13:03:07 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9FD89752
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALC31wR152969
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 06:03:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732190581;
 bh=HCrXJIvII3Qe7ml9+3nqKgwvCFGqpCjjshzuwieqOK4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=X+gZNSHrfGRq/YT4UMZS+0i3k6Zbo9BFQYEBCSck7MGl56q2HXxWTNgi8UoeMnaF+
 GFLkEbH1PZdzN1ZbLvnNVyA+dfkX1WNZTI3pOknbmci3lrViuGWb3h6gdyNf3SYgoT
 3tlu9icUHPK2O8/35JU33l67+Bm2W5/VR112bwLI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALC31iL060804
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Nov 2024 06:03:01 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 06:03:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 06:03:01 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC2sLc007780;
 Thu, 21 Nov 2024 06:02:58 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Nov 2024 17:32:51 +0530
Subject: [PATCH 1/3] arm: dts: k3-*-r5: Remove clocks from mcu_timer0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241121-b4-upstream-pll-fix-v1-1-904f618897a7@ti.com>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
In-Reply-To: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732190574; l=8433;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=CN1gVvhMjhR3DK/v4F5l8ujrQbRKgub5bUv6ikRv7G8=;
 b=8iX5T10b8qX2bn/IiV7aFS+xjsf0hcrI/gZQQVonhrHXm+VWkMJ8KhdpZfNtahOQk/X1GGcVh
 gBDhpl/v8aRAekRYBGdtZYwMemyX1PZeLU3cG/sgQ3caBOC5EQDcxFJ
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Updated PLL driver sequencing requires us to use udelay in the PLL
driver as there is no poll bit to get the status of operations.
tick-timer(mcu_timer0/main_timer0) setting up the clocks for itself is
something that won't work as the PLL driver will be using udelay and
PLLs are configured during clock probe which would end up in a recursive
probe.

tick-timer being used by K3 devices are configured by ROM and we really
don't need to configure any of the clocks.

Remove the clock dependency from R5 stage as we don't need to setup
clocks for it.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi         | 10 ----------
 arch/arm/dts/k3-am62-r5-lp-sk.dts              |  9 +++++++++
 arch/arm/dts/k3-am625-r5-sk.dts                |  9 +++++++++
 arch/arm/dts/k3-am625-sk-u-boot.dtsi           | 10 ----------
 arch/arm/dts/k3-am62a7-r5-sk.dts               | 10 ++++++++++
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi          |  5 -----
 arch/arm/dts/k3-am62p5-r5-sk.dts               |  8 ++++++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  4 ++++
 arch/arm/dts/k3-j721e-r5.dtsi                  |  6 +++++-
 arch/arm/dts/k3-j721s2-r5.dtsi                 |  4 ++++
 arch/arm/dts/k3-j722s-r5-evm.dts               |  8 ++++++++
 arch/arm/dts/k3-j784s4-r5.dtsi                 |  5 ++++-
 12 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
index cbcc7f3bb45cb75ac9550f8dbf1b88c20389d398..848bc350698ff00fb409caa4c512235d8492f4f3 100644
--- a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
@@ -5,13 +5,3 @@
  */
 
 #include "k3-am62-lp-sk-binman.dtsi"
-
-/ {
-	chosen {
-		tick-timer = &main_timer0;
-	};
-};
-
-&main_timer0 {
-	clock-frequency = <25000000>;
-};
diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
index b8e5f49a1fc7491208b3690ff2584dd6fb8eb42c..135e8d49b9159262cc2fe270e6381d58067a065a 100644
--- a/arch/arm/dts/k3-am62-r5-lp-sk.dts
+++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
@@ -12,6 +12,7 @@
 
 / {
 	aliases {
+		tick-timer = &main_timer0;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 		serial0 = &wkup_uart0;
@@ -72,6 +73,14 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index d2dd75469c1a60993556d5c999c279a7d5b91532..34c501dd51bb458bd0972fbf332f26c975dfb5db 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -12,6 +12,7 @@
 
 / {
 	aliases {
+		tick-timer = &main_timer0;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 		serial0 = &wkup_uart0;
@@ -70,6 +71,14 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index 1fc0d407cbf3d7560c99964947d2fc2ce165bd97..487ccf04b553730a60f97974e667e084a5bbe3fc 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -6,16 +6,6 @@
 
 #include "k3-am625-sk-binman.dtsi"
 
-/ {
-	chosen {
-		tick-timer = &main_timer0;
-	};
-};
-
-&main_timer0 {
-	clock-frequency = <25000000>;
-};
-
 &main_bcdma {
 	reg = <0x00 0x485c0100 0x00 0x100>,
 	      <0x00 0x4c000000 0x00 0x20000>,
diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 464227b3b25de125462199ce5a7dc6511f16fe24..49e62533a951ba1509bfe24cf3b68fd9005d9a61 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -12,6 +12,7 @@
 
 / {
 	aliases {
+		tick-timer = &main_timer0;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 	};
@@ -71,6 +72,15 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+	bootph-pre-ram;
+};
+
 &wkup_uart0_pins_default {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index c42dec161940c2ec34b537f7f594f5fd3a110f93..7dfbeb10c323bbe1f935a50e3efc87b3276f044e 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -9,7 +9,6 @@
 / {
 	chosen {
 		stdout-path = "serial2:115200n8";
-		tick-timer = &main_timer0;
 	};
 
 	memory@80000000 {
@@ -17,10 +16,6 @@
 	};
 };
 
-&main_timer0 {
-	bootph-all;
-};
-
 &cbass_main {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am62p5-r5-sk.dts b/arch/arm/dts/k3-am62p5-r5-sk.dts
index baf1a83dc12459699da58c03da30eef540db3180..b18b4ce12725c0a5e7e702f592c0e57b9e9bec6c 100644
--- a/arch/arm/dts/k3-am62p5-r5-sk.dts
+++ b/arch/arm/dts/k3-am62p5-r5-sk.dts
@@ -78,6 +78,14 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index f096b102793e31acd9b0f55c64242c5c0f8d0bdc..69bf999307761e25ef6fa797d32a61170d7dca9e 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -53,6 +53,10 @@
 };
 
 &mcu_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
 	clock-frequency = <250000000>;
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
index 688a6cf40892b03b0f1b7af59fdff1ed409011af..786a41c5e90ba161825c2615c2813952f05bcd85 100644
--- a/arch/arm/dts/k3-j721e-r5.dtsi
+++ b/arch/arm/dts/k3-j721e-r5.dtsi
@@ -42,7 +42,11 @@
 };
 
 &mcu_timer0 {
-	status = "okay";
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <166666666>;
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index 634676c8491ee6e67668e1e9b3b6c1c3ead31578..a820f516015d7cca2f4405f50cc067291abaaefd 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -43,6 +43,10 @@
 };
 
 &mcu_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
 	clock-frequency = <250000000>;
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 5e5c2e3111eef56c8a39272c3c1ce499a6aaab7d..08286ed792ddfa1d0e219ede4f94ceb0ae6f6d34 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -77,6 +77,14 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 0cd0ccc2dea0379971595faa1076b20aa3606492..b377a47ed22d621adbd8e381098d4ed12b4b441d 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -41,7 +41,10 @@
 };
 
 &mcu_timer0 {
-	status = "okay";
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
 	clock-frequency = <250000000>;
 	bootph-pre-ram;
 };

-- 
2.46.0

