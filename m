Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6764C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B2F87BCE;
	Fri, 29 Dec 2023 18:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgeEXL5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD2787BC7; Fri, 29 Dec 2023 18:47:11 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C489C87B87
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1Kf032432;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=t2PyNR+RsnSgd6gl/VEKJM6r0174d2EQLW3TajApVXE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jgeEXL5u80y/FBstSRmMkGGRSF+nE4/KskuSDcdZXJPFicAgTTupXnB4G2FjrFvvf
 STU1ZdRO/KxltJ1rZ4VRYhAcYZyXXulHRtcWO2GLXraA6LxcwMmBFjKpFz1cvxGxjo
 gg3pZOIecQjVCgBdo/MtEjbCXebtmMZ7Q5ExEQLk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Ze025017
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl11Y005079;
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
Subject: [PATCH v2 15/26] arm: dts: k3-am654: remove duplicate sdhci0 pinmux
 node
Date: Fri, 29 Dec 2023 11:47:12 -0600
Message-ID: <20231229174656.634065-43-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=bb@ti.com;
 h=from:subject; bh=4oyNtfwQqB68ijqMya6MOFo7k6chbpYh5mNX7r/fM/s=;
 b=owNCWmg5MUFZJlNZpfTndwAAaP///r9J0/e2H6uvazH/f9c3ab/6/3/f3P4n/7/vhHfn2eWwA
 RsYHagB6gAA00ABoAMgNAaA0NAAaeU0NAepkGgADTQAAAbUPUZDQ02psJ6ogNHqA0AeoMgAADTT
 JkaNHqAADTT1DCaaaAaZNAxNA9JptMo09TQBp6hoAA0BoHIaPUwQaGJpoNBiAGmEyZDTTIGJpoA
 DTQaYmIyAwQBoMmjQBoBiDTQaAYECOArU/0gYumgAkQI4V20CoEQA+NIp1iMQYKBK5rvBrrQ89I
 eANzQ5kecqAuxCcZReChMJ0wLPqCcledMOOlLiau7Zcw6AmGSqpzK9YcVQ2DAPKrnaZwL+3vZM+
 KC5bAF8zeYlteKgyA/zFEvibcaaMojZy7YVVTwNSMZqI0vFPlgzpTEdRFcwMsv7QPIHpufI1HEk
 0TjZYcrrKPBjUaRLz1shtvNtPjIcIY37ERAGPd1KBBC/HHW8CY5E8g1YQWYBkAdD5LUh+oDyL2D
 DKkU9yaBIW744fyu7fRkV2CMTwS3ppk3uAglOagntdf6nQDDpTSu4VqlNYMDgn7pIIh+q2bRRjH
 SXpxLWNJ2hELWGDqzz3FBTBiEWCZhCtUR9WjCu68ooszWdiQG6lLzAR7WSx2O9dcNy/fCURpFIN
 lg/xdyRThQkKX053cA=
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 26 ++++++++-----------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 3d599a5413812..f28245b12b6f6 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -140,22 +140,6 @@
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
@@ -182,12 +166,18 @@
 	pinctrl-0 = <&wkup_vtt_pins_default>;
 };
 
+/*
+ * MMC is probed to pull in firmware, so any clock
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

