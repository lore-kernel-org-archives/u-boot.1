Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F0C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFFC80F7B;
	Wed, 26 Feb 2025 07:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yc33g/B0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41EEC8081A; Wed, 26 Feb 2025 07:39:52 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D927E8081A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dlO91386348
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 00:39:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551987;
 bh=LQs0cMk9ngr53jbaTC7BNfrhr+fDbEUYZg4lb6kcl2E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yc33g/B0LCitXKoUsWJijc5065VoeCl2yfCUVBypbGQrH4yY6O3L28CFOuKy9i2eg
 Vqc78P/5/6JGYVATzz+dGbQwYr1h4iBGCAvnDcSn5Mw39WcSD9p1Ve197RFI6P9w55
 Z4ywGKJb+hSw/ldvNQ/LzoP7HU5TNAvpfYxBtvF8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dlRj007132
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 00:39:47 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:46 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgM8049984;
 Wed, 26 Feb 2025 00:39:45 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 1/5] arm: dts: k3-am64: Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:19 +0530
Message-ID: <20250226063923.2266288-2-s-k6@ti.com>
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

Update the DDR Configurations for AM64x EVM according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
index 491412119b18..1b5fabc3dd16 100644
--- a/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM64x SysConfig DDR Subsystem Register Configuration Tool v0.08.40
- * Wed Feb 02 2022 16:24:50 GMT-0600 (Central Standard Time)
+ * AM64x SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
+ * Tue Sep 17 2024 11:01:31 GMT+0530 (India Standard Time)
  * DDR Type: DDR4
  * Frequency = 800MHz (1600MTs)
  * Density: 16Gb
@@ -12,6 +12,8 @@
 #define DDRSS_PLL_FHS_CNT 6
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
+#define DDRSS_SDRAM_IDX 15
+#define DDRSS_REGION_IDX 15
 
 #define DDRSS_CTL_0_DATA 0x00000A00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -178,7 +180,7 @@
 #define DDRSS_CTL_162_DATA 0x0E0A0907
 #define DDRSS_CTL_163_DATA 0x0A090000
 #define DDRSS_CTL_164_DATA 0x0A090701
-#define DDRSS_CTL_165_DATA 0x0000000E
+#define DDRSS_CTL_165_DATA 0x0000080E
 #define DDRSS_CTL_166_DATA 0x00040003
 #define DDRSS_CTL_167_DATA 0x00000007
 #define DDRSS_CTL_168_DATA 0x00000000
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

