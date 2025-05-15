Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A129C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D134382B4A;
	Thu, 15 May 2025 13:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="glyeS/+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923C082B72; Thu, 15 May 2025 13:38:52 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3839482B45
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBclS52925267
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 06:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747309127;
 bh=6AIhTNWUXFcgXXUiPz7tmvvyHyx5gfvd5Q1FJKqoqpQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=glyeS/+uKDSef7RVd2ecG3jW3tWrVOT/L1SE0bWeRgY/Z90kSDZSzQpfeVpvodqcE
 wOfLgfC1Pzf2Dg2WXzq6owdaAL5Fqd2rTPyigLpQM5AoUCjVSoXYBV/E6yZMS+0+co
 qS6gl5kURjVSuKHwbrmfEDBFJEBOoGIn7VgE/WDI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBclAo067488
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 06:38:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:38:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:38:46 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBccg7059730;
 Thu, 15 May 2025 06:38:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 15 May 2025 17:08:34 +0530
Subject: [PATCH 1/4] arm: dts: k3-am625-beagleplay-r5*: Remove clocks from
 main_timer0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-b4-upstream-k3-pll-miss-v1-1-e38b89f027b8@ti.com>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Chandru
 Dhavamani <chandru@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747309118; l=1973;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=nVa8+R18/BT6YJ0SHUP66d731r9XRJLyG0K7Fpt7RT4=;
 b=126eRNNVj8+UDzza6O7mvzjNI7Cdz4OFo83wwyvac8aWFafu4CCswZRiLYxXbd3IpHkmLF/uS
 YTikXezvcG1DMO7GowJmJTLv23KerFUK2JTO6qKLRwoRZCU/EzxoNwE
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

The commit 79d91e77f4c2 ("clk: ti: clk-k3-pll: Add additional robustness
steps to the PLL sequence") introduced a change which requires the
main_timer0 to not rely on it's own clocks which anyways was wrong.

Fix it by removing the clock dependency for it, also while at it, move
it from u-boot.dtsi to R5 as that is the only entity that should require
it as DM isn't up.

Fixes: 5d1aac358f3c ("arm: dts: k3-*-r5: Remove clocks from mcu_timer0")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 8 --------
 arch/arm/dts/k3-am625-r5-beagleplay.dts      | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 01b6a8e417ca1016cb68b5add248b10b0bd7857a..2a4f0e4536526af65cd042e17721158be45b9ce0 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -9,10 +9,6 @@
 #include "k3-binman.dtsi"
 
 / {
-	chosen {
-		tick-timer = &main_timer0;
-	};
-
 	/* Keep the LEDs on by default to indicate life */
 	leds {
 		led-0 {
@@ -37,10 +33,6 @@
 	};
 };
 
-&main_timer0 {
-	clock-frequency = <25000000>;
-};
-
 &sd_pins_default {
 	/* Force to use SDCD card detect pin */
 	pinctrl-single,pins = <
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9e0a6ed678448534aaa9c985b9369aa78c7815e9..c0c0c0aaa2910304e77cbfa6a1936c1feb6b1444 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -46,6 +46,14 @@
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
 &dmsc {
 	mboxes= <&secure_proxy_main 0>,
 		<&secure_proxy_main 1>,

-- 
2.34.1

