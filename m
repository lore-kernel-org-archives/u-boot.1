Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6830DC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD44182B7E;
	Thu, 15 May 2025 13:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kpMf9kRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D81782BAB; Thu, 15 May 2025 13:38:59 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E81382B45
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54FBct0S3687334;
 Thu, 15 May 2025 06:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747309135;
 bh=knY4rTtwfcD+qDnlU/vUSp7Y1q0W8XEk2PSEU65R230=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=kpMf9kRrzGDQ/dOLIwBtnBsesvSDv9huNTTh7PtcG7Gfm2bwZO/vgZXoCl47K0E8q
 eDS78+t3uYCQTK46AJxHjiRdh/0b7wTfd+0ODor6UTysNSplib0Tsdp8ST3qMq9m0k
 7E6/psGuKN4K3eTYUBN+0fvtFZeJ1OAlau8yWNUI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54FBctZk3661960
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 15 May 2025 06:38:55 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:38:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:38:54 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBccg9059730;
 Thu, 15 May 2025 06:38:51 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 15 May 2025 17:08:36 +0530
Subject: [PATCH 3/4] arm: dts: k3-am625-verdin-r5*: Remove clocks from
 main_timer0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-b4-upstream-k3-pll-miss-v1-3-e38b89f027b8@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747309118; l=1998;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=+kEu6hNjuEMdVWHEuUgNUPDVOA9MzQNmjtGJ8Mhc2OE=;
 b=8sbCJFAAGaDJTRlwo/RjW/JTOLpgqUQmBet8skkuSbtE14PyrOZ0ykXaWwDCeQauAZ7+7Jf2W
 ZEY9lGTabvsDplDptoa7PiVK3qjIYBZRTYu5wZSMEx1tC6aEiwMyBcd
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
 arch/arm/dts/k3-am625-verdin-r5.dts               | 8 ++++++++
 arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index 2b333e70f5c836512edc7bda273693099b3b3659..39e8ab8158e3564e404b327d6edfccacedc1b307 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -69,6 +69,14 @@
 	ti,secure-host;
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 &secure_proxy_sa3 {
 	/* We require this for boot handshake */
 	status = "okay";
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index b3d237c869793c4adb0a2911dbd8819de5d67d70..8487ea14800492616264cd784c871f99383dc3bb 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -12,10 +12,6 @@
 		eeprom2 = &eeprom_display_adapter;
 	};
 
-	chosen {
-		tick-timer = &main_timer0;
-	};
-
 	memory@80000000 {
 		bootph-all;
 	};
@@ -25,10 +21,6 @@
 	};
 };
 
-&main_timer0 {
-	clock-frequency = <25000000>;
-};
-
 &main_bcdma {
 	reg = <0x00 0x485c0100 0x00 0x100>,
 	      <0x00 0x4c000000 0x00 0x20000>,

-- 
2.34.1

