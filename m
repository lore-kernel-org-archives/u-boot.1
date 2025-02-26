Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2992C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD1780FB6;
	Wed, 26 Feb 2025 07:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LPxV9J2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837AA80F7B; Wed, 26 Feb 2025 07:39:54 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3412F807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dnO81386361
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 00:39:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551990;
 bh=HFYBzKHfwou/3FueN67Hr2fDSee9L+neLB+AHvvh1dI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LPxV9J2pfugXTu/mshcK8MK6TjbiYKfZh7M0ntimWz4yqq2yO+HeCsEEkMsx90YM2
 P6z0Qqldfb3hBTkHLsRW6YQv9ZeBYqrwoohIJKtf9Wl3/qYRFJtmuXgtRgcu1Rz2tZ
 wcxtyr8JCCiXURDr6ROGwBRvkMZaGyUCQESvSvmI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dnOk024499
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 00:39:49 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:49 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgM9049984;
 Wed, 26 Feb 2025 00:39:47 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 2/5] arm: dts: k3-am62x: Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:20 +0530
Message-ID: <20250226063923.2266288-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226063923.2266288-1-s-k6@ti.com>
References: <20250226063923.2266288-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Update the DDR Configurations for AM62x SK according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
index d92e3ce048b9..8def52b07f48 100644
--- a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.08.60
- * Wed Mar 16 2022 17:41:20 GMT-0500 (Central Daylight Time)
+ * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
+ * Tue Sep 17 2024 11:00:17 GMT+0530 (India Standard Time)
  * DDR Type: DDR4
  * Frequency = 800MHz (1600MTs)
  * Density: 16Gb
@@ -12,6 +12,8 @@
 #define DDRSS_PLL_FHS_CNT 6
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
+#define DDRSS_SDRAM_IDX 15
+#define DDRSS_REGION_IDX 17
 
 #define DDRSS_CTL_0_DATA 0x00000A00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -334,7 +336,7 @@
 #define DDRSS_CTL_318_DATA 0x3FFF0000
 #define DDRSS_CTL_319_DATA 0x000FFF00
 #define DDRSS_CTL_320_DATA 0xFFFFFFFF
-#define DDRSS_CTL_321_DATA 0x000FFF00
+#define DDRSS_CTL_321_DATA 0x00FFFF00
 #define DDRSS_CTL_322_DATA 0x0A000000
 #define DDRSS_CTL_323_DATA 0x0001FFFF
 #define DDRSS_CTL_324_DATA 0x01010101
@@ -901,7 +903,7 @@
 #define DDRSS_PHY_117_DATA 0x00800080
 #define DDRSS_PHY_118_DATA 0x00800080
 #define DDRSS_PHY_119_DATA 0x01000080
-#define DDRSS_PHY_120_DATA 0x01A00000
+#define DDRSS_PHY_120_DATA 0x01000000
 #define DDRSS_PHY_121_DATA 0x00000000
 #define DDRSS_PHY_122_DATA 0x00000000
 #define DDRSS_PHY_123_DATA 0x00080200
@@ -1157,7 +1159,7 @@
 #define DDRSS_PHY_373_DATA 0x00800080
 #define DDRSS_PHY_374_DATA 0x00800080
 #define DDRSS_PHY_375_DATA 0x01000080
-#define DDRSS_PHY_376_DATA 0x01A00000
+#define DDRSS_PHY_376_DATA 0x01000000
 #define DDRSS_PHY_377_DATA 0x00000000
 #define DDRSS_PHY_378_DATA 0x00000000
 #define DDRSS_PHY_379_DATA 0x00080200
@@ -2152,7 +2154,7 @@
 #define DDRSS_PHY_1368_DATA 0x00000002
 #define DDRSS_PHY_1369_DATA 0x00000100
 #define DDRSS_PHY_1370_DATA 0x00000000
-#define DDRSS_PHY_1371_DATA 0x0001F7C0
+#define DDRSS_PHY_1371_DATA 0x0001F7C2
 #define DDRSS_PHY_1372_DATA 0x00020002
 #define DDRSS_PHY_1373_DATA 0x00000000
 #define DDRSS_PHY_1374_DATA 0x00001142
-- 
2.34.1

