Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14132C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F62782B81;
	Thu, 15 May 2025 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qRKDiH5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D7882B81; Thu, 15 May 2025 13:39:06 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 843AD82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54FBcwGd3433368;
 Thu, 15 May 2025 06:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747309139;
 bh=fJToOn4fXBTzJU1IsJPrlfichlO2eM7lISM+9LLM3HM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=qRKDiH5auDRTb+tMdGVnnAUP3i0i1KbVRet5tKEUbckLyDRikhWnSvWe4ESZe1W4y
 YEEOsZevPiRJfvjXghitW9seE5+wYByMSBB6q3HNWkBEPmyVDKkwHKV7wxHMR61gxy
 kGdOfmQipGsf69Q3DsahGtCgIr7kyNjbZb0iAhvU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54FBcwS21688792
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 15 May 2025 06:38:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:38:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:38:58 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBccgA059730;
 Thu, 15 May 2025 06:38:55 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 15 May 2025 17:08:37 +0530
Subject: [PATCH 4/4] arm: dts: k3-am62a7-phycore-r5*: Remove clocks from
 main_timer0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-b4-upstream-k3-pll-miss-v1-4-e38b89f027b8@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747309118; l=1930;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Z6t60qafAWiTreH7l/0cc5zBXd34TivWG2zrffcV+UM=;
 b=f9Za8YXnq/xAcEv+lcgUhmd7XFflYm1jySMFX3lw4hS6vRI4nDzs2FfKKqlj1946Vtgn8ecZW
 YPuS8Q9DjIFAV3gQAUtTCAZfs5IWm/LuGRmDP4rlE2QUETbGckHYaCf
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
 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi | 5 -----
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts        | 9 +++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
index f922f4b4781d9a3aed543ba5c4ebfb3ab879476a..73255a18e9b1526eda50e43786ccc3e122d54060 100644
--- a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
@@ -13,7 +13,6 @@
 / {
 	chosen {
 		stdout-path = "serial2:115200n8";
-		tick-timer = &main_timer0;
 	};
 
 	aliases {
@@ -157,10 +156,6 @@
 	bootph-all;
 };
 
-&main_timer0 {
-	bootph-all;
-};
-
 &main_uart0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
index 0060c7a69349a31e142c40806c372ed2fccdf7ea..63b7864a46969f83571269e3db7bf7670228362b 100644
--- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
@@ -88,6 +88,15 @@
 	ti,secure-host;
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
 &main_bcdma {
 	ti,sci = <&dm_tifs>;
 };

-- 
2.34.1

