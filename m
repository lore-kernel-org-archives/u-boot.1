Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD4DC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3528287946;
	Thu, 21 Dec 2023 18:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FWiOttQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDF58785E; Thu, 21 Dec 2023 18:44:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB4E878E4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEAL027121;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=nw2CXSSAU0fEzAN1+vcClEeGRbFgacI2PL8I5LHRzBY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FWiOttQWhRsTvmkDo5Wzvr9LphfuUn8UvTaQl0YFLe1pMSAumlmyPF4QVT5KQthoa
 0qj+YjxTjUyjEx7zqEm0dPNkUBAwN/r8ZvpY5kCkgLxQ0QCblv9t1nSFPL8kd+2rAy
 uGMAkcMvbGBUA4YaYQl45AymTvmu/+qXSIxaZCWA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEBA032089
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEdc080231;
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
Subject: [PATCH 09/26] arm: dts: k3-am654: remove duplicate timer
Date: Thu, 21 Dec 2023 11:43:55 -0600
Message-ID: <20231221174412.210807-10-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347; i=bb@ti.com;
 h=from:subject; bh=8XjZp0teJ1QN27ECgWzGmQasyc17tVi34rCxvg20ajE=;
 b=owNCWmg5MUFZJlNZCkMjRQAAZv///v5Nj/8m/16v7L73/5fez7R/+vf4L9+J/+n9/1JryO6wA
 RszWO1AaAeoAaaekaeoB6gAAaaAAAAADQ9QBoAAAepoAD1G0gek00eo2p6mnqPIRA0MhpoaDTIa
 aaANDQNGmmBA0AAxAA00GRoaA0ZMEAYmTQNGQaeoNAxPU0eQ7RMmho0A00009TQA00GmjNT1DQ0
 aaAAAAME0GCYTIeoABoaaAGgDJgTIABo1/CWHcQHpR0fENyMUXBHBhEnJCMIiiz7zAVzzrqBY3w
 TsBPdGL82PcGPrn2RyPL00fvKOXcXZlzaaxAshQbXzWn26eqoFtcT9MxvhNX4V2X7wc9RDk99j1
 KWW8K7PBKyP6v2Ck1miR6BtVFfV7ZkJi8c8p0ZkFNwF60eRhtdFPnwCCd+d31VFXRTlpaDVb7Rk
 A64AYPAzEVfAxHTwj5iwlAOu9Slc2oRL6hAEeX+R5Y2nelp1KWdEaG3AraqRLkpK0gXul6OcRpF
 vN7rJY6UTksEgFSjECpMTZPN8WShCQ3LfEpJaKVq+1gS7HJmztZwWnE4gn5Ka9hItqI7FQYZ47O
 PHrp5cPV4J44A59aU0IZi4gFebu+MRc4GiMZ8qE4NgHEASC/rb3DRP+xwTjsJrVsnNoLc6gCkzE
 DvAlAae3gC7kinChIBSGRoo
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

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 12 ++++++++
 arch/arm/dts/k3-am654-r5-base-board.dts      | 29 ++++++++++----------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 7ec65f8fa98aa..9cd8c353c515b 100644
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
index 3e94cfccd4321..3b27ad842532c 100644
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
@@ -108,6 +93,20 @@
 	};
 };
 
+/* timer init is called as part of rproc_start() while
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

