Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C79C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEA787C02;
	Fri, 29 Dec 2023 18:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qfXmcvva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1DE87B6B; Fri, 29 Dec 2023 18:47:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3981287BB9
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1hp025728;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=oHlOwoNTL6Uv4TYlxuHXGcPrFjH4rWK0kA+3Pd0vq74=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qfXmcvvapDSD7rbTDc+6Y7yR9VC3V00+zkzA3lvoWjbNOB2kIbzGf6MwB09Oi4SWG
 QlIUUVYdRIZ5hj+nfr19o6VpQErFBnpfTIs7s6EFEu4pXrUx9qCdpiWSAinFNoqDEC
 1AC9nuzBSn3T2E3GK/9ODCZtrNnj1W0lWtnl0n3M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1i3063428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1qu122680;
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
Subject: [PATCH v2 09/26] arm: dts: k3-am654: remove duplicate timer
Date: Fri, 29 Dec 2023 11:47:06 -0600
Message-ID: <20231229174656.634065-37-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=bb@ti.com;
 h=from:subject; bh=SRk/4tZMt9PvRT6thKfoZCwVPczCBwnRh5lWlNTT4RE=;
 b=owNCWmg5MUFZJlNZBbUYEgAAan///7ffr/e9G1b/79L0U3/29//y/fevnGubfO3tpb9zq/+wA
 RmYHajRoB6gNAAADQ0AA0DTQ9QGgBo0NNAZGgAGgDIAaANNDQNGnpGmmmaMaocgA0aaGhiGhk0G
 jQGmg0A0MgAbUDQaAaBkzSZMI0AaBpkyeoaGmmE0BiaAGhih6gHqNNAAaBpkGjQyPUeo0ANGhkA
 Ghpp6gyA0GgNAAAGE0NGGkZNDRiAABBcL1VCO2EE+lw+gjMl8xIAUeSQ4cCQAzbxUIIOCl8wOON
 OMDzdoDAXIfEZqJpAVQjNYe/M6bapIxygXrHbc3KN8wakUkW8e6JNtJb7RQySiQoN6QajJW8kzh
 /B5VKtztEBcvGeLgAIUhaLyTplZPLv1ingiTjAWunB1p3/ItEMsrFVqIKEg/m1hIHD09psFsQ38
 7CQl3r2bPMW6nsXHAQ2CttXf57c2JTTgGzyK91vS/Rt5cRrEB0qqKTwZbq97hoZW894vUqcXEtx
 lyFWXzrQipVDLnA9+ppwsaDRElWSAAXeOZE9vNYiZjx5J9qlDKLxUemmSHPCxHiIlKK9sFjMDB3
 UI4KnMONI+pyGkUEbIykIUwddrV8UG/T1CoMZacGPbPW1r8g/sWwqtkIAEWSxgBy44KVIEY/iD5
 KcAiCXB/i7kinChIAtqMCQ=
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

timer1 is really just the mcu_timer0 node redefined for the WKUP SPL.
Remove the timer1 and replace it with the mcu_timer0 from the Linux
device tree we imported into U-Boot.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 12 ++++++++
 arch/arm/dts/k3-am654-r5-base-board.dts      | 30 ++++++++++----------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 4b1e8ce2c920c..a008af5b4a047 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -5,6 +5,18 @@
 
 #include "k3-am65x-binman.dtsi"
 
+/ {
+	chosen {
+		tick-timer = &mcu_timer0;
+	};
+};
+
+&mcu_timer0 {
+	ti,timer-alwon;
+	clock-frequency = <25000000>;
+	bootph-all;
+};
+
 &vtt_supply {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index fb13a17b1dc64..f462262b9aaac 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -26,11 +26,6 @@
 		usb1 = &usb1;
 	};
 
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
 	a53_0: a53@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
@@ -47,16 +42,6 @@
 	};
 };
 
-&cbass_main {
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <25000000>;
-		bootph-all;
-	};
-};
-
 &cbass_mcu {
 	mcu_secproxy: secproxy@28380000 {
 		compatible = "ti,am654-secure-proxy";
@@ -108,6 +93,21 @@
 	};
 };
 
+/*
+ * timer init is called as part of rproc_start() while
+ * starting System Firmware, so any clock/power-domain
+ * operations will fail as SYSFW is not yet up and running.
+ * Delete all clock/power-domain properties to avoid
+ * timer init failure.
+ * This is an always on timer at 20MHz.
+ */
+&mcu_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ power-domains;
+};
+
 &dmsc {
 	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
 	mbox-names = "tx", "rx", "notify";
-- 
2.43.0

