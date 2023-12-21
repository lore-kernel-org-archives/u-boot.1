Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC065C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F118793F;
	Thu, 21 Dec 2023 18:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TKN411vB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE4D878F6; Thu, 21 Dec 2023 18:44:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3002878E2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE1w083881;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=CtQo3x4uNWfEKt4HuoCu6GQDeRaaGdTobFKhYKA3NeA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TKN411vBFKrTac0kAdGq5Vn0Im6ewJoQmAB4/ZYJNye/peXGuJKU+MQxHC4CFIr2/
 Hh5eEeva8P2fDOJ2X4JCFpcHx+pqYzw76q4YsBd/cSYzXRtSXzuFFfjFYAzCDnL53Q
 rp45cbU2vyIruQBSOm4QB5SivBJi93AMoGJJO514=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiE3U097316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEak069266;
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
Subject: [PATCH 15/26] arm: dts: k3-am654: remove duplicate sdhci0 pinmux node
Date: Thu, 21 Dec 2023 11:44:01 -0600
Message-ID: <20231221174412.210807-16-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=bb@ti.com;
 h=from:subject; bh=wcmCxvRbnhp7BYOgi2bKtQLpaDDW3WaivzjxWTvIsBw=;
 b=owNCWmg5MUFZJlNZetLo3QAAaH///n/93+/qfrO5c+nK/jXu/R/z3J/xrP9V769987d3+X2wA
 RsbRD1AaAAaGjEABoyDQDCaNNAAGho0ABkaBppkMEaaDJkGnqAABpppiNPR6SGU0GgGjQ0AaABo
 DQZNqDQMQNAAaGQaBoZNAyep6gDQYTTT1DaQyGmnqDIDRgO1GQeUafqmnqaZGgAyDQPUGIaAGgZ
 GgADIyAAAAyAMgAaaaYjTQDRtCNBoSJOA6kNA9J+V5BWa4IB9EcDXhoRqIMTcgf58sKQsedp0Mg
 swVMdiUo63OjooYM7Uez07Bkit+gnIPlSkzzrsazSCspWT6by5D+72DMXKd4BJCrxK9yXafO5i4
 O/R3PSEWGFUpj4vMwn41cSiEV8sjlIzcxVtphyV1MdeO+84EEzpS5NtItei6sWeQtC+FBQtVXmy
 BNie5s+l6wETIMcUfuJD/qC/hvBdXkIAd8XTfQE/aFeGY3FrIm+pWgNVveiBu2dKd9E/9IBsvJt
 Gk35yu6cZq6PgzCQVnFuDDTZH9bdbz0k3uRroZu25BWZDGiNAMnKN2jEtX/ycf0XNtIoat9odkj
 AAVzLFAkB907hNRKMefcbDaWBgHUYW25KfkYJYGyjX7/ZtG7dbpfwnYc3rPnsAyKEANS8wiQvFC
 ebO5FeCwP+LuSKcKEg9aXRugA==
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

With the Linux and U-Boot board dtb files unified, we now have
a duplicate sdhci0 pinmux node. Remove it

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 66953eb5581ae..856917bdfaa5d 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -137,22 +137,6 @@
 };
 
 &main_pmx0 {
-	main_mmc0_pins_default: main_mmc0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)	/* (B25) MMC0_CLK */
-			AM65X_IOPAD(0x01aC, PIN_INPUT_PULLUP, 0)	/* (B27) MMC0_CMD */
-			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP, 0)	/* (A26) MMC0_DAT0 */
-			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP, 0)	/* (E25) MMC0_DAT1 */
-			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP, 0)	/* (C26) MMC0_DAT2 */
-			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP, 0)	/* (A25) MMC0_DAT3 */
-			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP, 0)	/* (E24) MMC0_DAT4 */
-			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP, 0)	/* (A24) MMC0_DAT5 */
-			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP, 0)	/* (B26) MMC0_DAT6 */
-			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0)	/* (D25) MMC0_DAT7 */
-			AM65X_IOPAD(0x01b0, PIN_INPUT, 0)		/* (C25) MMC0_DS */
-		>;
-	};
-
 	main_mmc1_pins_default: main_mmc1_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)	/* (C27) MMC1_CLK */
@@ -179,12 +163,17 @@
 	pinctrl-0 = <&wkup_vtt_pins_default>;
 };
 
+/* MMC is probed to pull in firmware, so any clock
+ * or power-domain operation will fail as we do not
+ * have the firmware running at this point. Delete the
+ * power-domain properties to avoid making calls to
+ * SYSFW before it is loaded. Public ROM has already
+ * set it up for us anyway.
+ */
 &sdhci0 {
 	clock-names = "clk_xin";
 	clocks = <&clk_200mhz>;
-	pinctrl-0 = <&main_mmc0_pins_default>;
 	/delete-property/ power-domains;
-	ti,driver-strength-ohm = <50>;
 };
 
 &sdhci1 {
-- 
2.43.0

