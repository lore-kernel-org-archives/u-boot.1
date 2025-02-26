Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D8CC021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52DEE80977;
	Wed, 26 Feb 2025 07:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QV9Zn1vT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D3B8081A; Wed, 26 Feb 2025 07:40:01 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6CDE807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dsq21386377
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 26 Feb 2025 00:39:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551994;
 bh=0MIZ8rTfrGVEun5+BQhNDMpeDP1w6BuXv5y4HWvv+qM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QV9Zn1vTfqxR2FxrLJ0e2vnH1+tGotIL1Uy/hW2lQhcF5eH4SqTeQu9bUAg4qerjw
 HTX0rW7Gx1a6MUXpV6SmYiDWFU4tFC/ThuqAiyqDJwLmFVjeJVCI3dP3/IJnWeBzjB
 YSq7t4xp+n44WPLyQEW/BixiTOWtnNGfGAbqcAcA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dsPX103872;
 Wed, 26 Feb 2025 00:39:54 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:54 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgMB049984;
 Wed, 26 Feb 2025 00:39:52 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 4/5] arm: dts: k3-am62a: Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:22 +0530
Message-ID: <20250226063923.2266288-5-s-k6@ti.com>
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

Update the DDR Configurations for AM62Ax SK according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi | 50 ++++++++++----------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi b/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
index 9f50d7eae69b..35202651221d 100644
--- a/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
+++ b/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62A SysConfig DDR Subsystem Register Configuration Tool v0.09.01
- * Wed Aug 10 2022 17:34:54 GMT-0500 (Central Daylight Time)
+ * AM62Ax SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
+ * Tue Sep 17 2024 10:55:17 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 1866MHz
  * Density (per channel): 8Gb
@@ -12,6 +12,8 @@
 #define DDRSS_PLL_FHS_CNT 5
 #define DDRSS_PLL_FREQUENCY_1 933000000
 #define DDRSS_PLL_FREQUENCY_2 933000000
+#define DDRSS_SDRAM_IDX 16
+#define DDRSS_REGION_IDX 17
 
 #define DDRSS_CTL_0_DATA 0x00000B00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -402,10 +404,10 @@
 #define DDRSS_CTL_386_DATA 0x01090903
 #define DDRSS_CTL_387_DATA 0x05020201
 #define DDRSS_CTL_388_DATA 0x0E081B1B
-#define DDRSS_CTL_389_DATA 0x0008030E
-#define DDRSS_CTL_390_DATA 0x0B12030E
-#define DDRSS_CTL_391_DATA 0x0B120314
-#define DDRSS_CTL_392_DATA 0x12120814
+#define DDRSS_CTL_389_DATA 0x0008040E
+#define DDRSS_CTL_390_DATA 0x0B120406
+#define DDRSS_CTL_391_DATA 0x0B120406
+#define DDRSS_CTL_392_DATA 0x12120806
 #define DDRSS_CTL_393_DATA 0x01000000
 #define DDRSS_CTL_394_DATA 0x07030701
 #define DDRSS_CTL_395_DATA 0x04000103
@@ -417,8 +419,8 @@
 #define DDRSS_CTL_401_DATA 0x00000200
 #define DDRSS_CTL_402_DATA 0x00000693
 #define DDRSS_CTL_403_DATA 0x00000E9C
-#define DDRSS_CTL_404_DATA 0x03050202
-#define DDRSS_CTL_405_DATA 0x37200201
+#define DDRSS_CTL_404_DATA 0x03000202
+#define DDRSS_CTL_405_DATA 0x37200404
 #define DDRSS_CTL_406_DATA 0x000038C8
 #define DDRSS_CTL_407_DATA 0x00000200
 #define DDRSS_CTL_408_DATA 0x00000200
@@ -426,8 +428,8 @@
 #define DDRSS_CTL_410_DATA 0x00000200
 #define DDRSS_CTL_411_DATA 0x0000FF84
 #define DDRSS_CTL_412_DATA 0x000237D0
-#define DDRSS_CTL_413_DATA 0x111F0402
-#define DDRSS_CTL_414_DATA 0x37200C0D
+#define DDRSS_CTL_413_DATA 0x111A0402
+#define DDRSS_CTL_414_DATA 0x37200C09
 #define DDRSS_CTL_415_DATA 0x000038C8
 #define DDRSS_CTL_416_DATA 0x00000200
 #define DDRSS_CTL_417_DATA 0x00000200
@@ -435,8 +437,8 @@
 #define DDRSS_CTL_419_DATA 0x00000200
 #define DDRSS_CTL_420_DATA 0x0000FF84
 #define DDRSS_CTL_421_DATA 0x000237D0
-#define DDRSS_CTL_422_DATA 0x111F0402
-#define DDRSS_CTL_423_DATA 0x00200C0D
+#define DDRSS_CTL_422_DATA 0x111A0402
+#define DDRSS_CTL_423_DATA 0x00200C09
 #define DDRSS_CTL_424_DATA 0x00000000
 #define DDRSS_CTL_425_DATA 0x02000A00
 #define DDRSS_CTL_426_DATA 0x00050003
@@ -939,7 +941,7 @@
 #define DDRSS_PHY_64_DATA 0x00000000
 #define DDRSS_PHY_65_DATA 0x00000000
 #define DDRSS_PHY_66_DATA 0x00000000
-#define DDRSS_PHY_67_DATA 0x00000004
+#define DDRSS_PHY_67_DATA 0x00000104
 #define DDRSS_PHY_68_DATA 0x00000000
 #define DDRSS_PHY_69_DATA 0x00000000
 #define DDRSS_PHY_70_DATA 0x00000000
@@ -964,7 +966,7 @@
 #define DDRSS_PHY_89_DATA 0x00100010
 #define DDRSS_PHY_90_DATA 0x00100010
 #define DDRSS_PHY_91_DATA 0x00100010
-#define DDRSS_PHY_92_DATA 0x02040010
+#define DDRSS_PHY_92_DATA 0x02000010
 #define DDRSS_PHY_93_DATA 0x00000005
 #define DDRSS_PHY_94_DATA 0x51516042
 #define DDRSS_PHY_95_DATA 0x31C06000
@@ -1195,7 +1197,7 @@
 #define DDRSS_PHY_320_DATA 0x00000000
 #define DDRSS_PHY_321_DATA 0x00000000
 #define DDRSS_PHY_322_DATA 0x00000000
-#define DDRSS_PHY_323_DATA 0x00000004
+#define DDRSS_PHY_323_DATA 0x00000104
 #define DDRSS_PHY_324_DATA 0x00000000
 #define DDRSS_PHY_325_DATA 0x00000000
 #define DDRSS_PHY_326_DATA 0x00000000
@@ -1220,7 +1222,7 @@
 #define DDRSS_PHY_345_DATA 0x00100010
 #define DDRSS_PHY_346_DATA 0x00100010
 #define DDRSS_PHY_347_DATA 0x00100010
-#define DDRSS_PHY_348_DATA 0x02040010
+#define DDRSS_PHY_348_DATA 0x02000010
 #define DDRSS_PHY_349_DATA 0x00000005
 #define DDRSS_PHY_350_DATA 0x51516042
 #define DDRSS_PHY_351_DATA 0x31C06000
@@ -1451,7 +1453,7 @@
 #define DDRSS_PHY_576_DATA 0x00000000
 #define DDRSS_PHY_577_DATA 0x00000000
 #define DDRSS_PHY_578_DATA 0x00000000
-#define DDRSS_PHY_579_DATA 0x00000004
+#define DDRSS_PHY_579_DATA 0x00000104
 #define DDRSS_PHY_580_DATA 0x00000000
 #define DDRSS_PHY_581_DATA 0x00000000
 #define DDRSS_PHY_582_DATA 0x00000000
@@ -1476,7 +1478,7 @@
 #define DDRSS_PHY_601_DATA 0x00100010
 #define DDRSS_PHY_602_DATA 0x00100010
 #define DDRSS_PHY_603_DATA 0x00100010
-#define DDRSS_PHY_604_DATA 0x02040010
+#define DDRSS_PHY_604_DATA 0x02000010
 #define DDRSS_PHY_605_DATA 0x00000005
 #define DDRSS_PHY_606_DATA 0x51516042
 #define DDRSS_PHY_607_DATA 0x31C06000
@@ -1707,7 +1709,7 @@
 #define DDRSS_PHY_832_DATA 0x00000000
 #define DDRSS_PHY_833_DATA 0x00000000
 #define DDRSS_PHY_834_DATA 0x00000000
-#define DDRSS_PHY_835_DATA 0x00000004
+#define DDRSS_PHY_835_DATA 0x00000104
 #define DDRSS_PHY_836_DATA 0x00000000
 #define DDRSS_PHY_837_DATA 0x00000000
 #define DDRSS_PHY_838_DATA 0x00000000
@@ -1732,7 +1734,7 @@
 #define DDRSS_PHY_857_DATA 0x00100010
 #define DDRSS_PHY_858_DATA 0x00100010
 #define DDRSS_PHY_859_DATA 0x00100010
-#define DDRSS_PHY_860_DATA 0x02040010
+#define DDRSS_PHY_860_DATA 0x02000010
 #define DDRSS_PHY_861_DATA 0x00000005
 #define DDRSS_PHY_862_DATA 0x51516042
 #define DDRSS_PHY_863_DATA 0x31C06000
@@ -2699,7 +2701,7 @@
 #define DDRSS_PHY_1824_DATA 0x0F0F0804
 #define DDRSS_PHY_1825_DATA 0x00800120
 #define DDRSS_PHY_1826_DATA 0x00041B42
-#define DDRSS_PHY_1827_DATA 0x00005201
+#define DDRSS_PHY_1827_DATA 0x00004201
 #define DDRSS_PHY_1828_DATA 0x00000000
 #define DDRSS_PHY_1829_DATA 0x00000000
 #define DDRSS_PHY_1830_DATA 0x00000000
@@ -2760,7 +2762,7 @@
 #define DDRSS_PHY_1885_DATA 0x00000002
 #define DDRSS_PHY_1886_DATA 0x00000000
 #define DDRSS_PHY_1887_DATA 0x00000000
-#define DDRSS_PHY_1888_DATA 0x00000AC4
+#define DDRSS_PHY_1888_DATA 0x0001F7C4
 #define DDRSS_PHY_1889_DATA 0x04000004
 #define DDRSS_PHY_1890_DATA 0x00000000
 #define DDRSS_PHY_1891_DATA 0x00001142
@@ -2789,10 +2791,10 @@
 #define DDRSS_PHY_1914_DATA 0x0089FF00
 #define DDRSS_PHY_1915_DATA 0x000C3F11
 #define DDRSS_PHY_1916_DATA 0x01990000
-#define DDRSS_PHY_1917_DATA 0x000C3F11
+#define DDRSS_PHY_1917_DATA 0x000C3F91
 #define DDRSS_PHY_1918_DATA 0x01990000
 #define DDRSS_PHY_1919_DATA 0x3F0DFF11
 #define DDRSS_PHY_1920_DATA 0x00EF0000
 #define DDRSS_PHY_1921_DATA 0x00018011
 #define DDRSS_PHY_1922_DATA 0x0089FF00
-#define DDRSS_PHY_1923_DATA 0x20040004
+#define DDRSS_PHY_1923_DATA 0x20040006
-- 
2.34.1

