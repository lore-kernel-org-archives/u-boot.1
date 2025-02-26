Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE9C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7ABD80FF2;
	Wed, 26 Feb 2025 07:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fGilGBSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50DA80FE1; Wed, 26 Feb 2025 07:39:56 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8258680F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dqcv1386373
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 00:39:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551992;
 bh=Y9q7damDcz2UdP0lriMuKGCD+QS/+oFdd1w+b6riEeY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fGilGBSb0iMRLG0oKkHkZvTyQyZf/BN0lzghAd9aLit+axyGipjC/JbYdStmpckSY
 S9ZlgMaagbCYg1gof4Ab3A20PZ4VE+B0h0SJ1k9VSTfL6bkk43dGIdYRFfg8w3ghZK
 40DoB8aQMEEc9CZM+E58j5wvYe/Bkq9Q0nHVkVfI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6dqNj072219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 00:39:52 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:51 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgMA049984;
 Wed, 26 Feb 2025 00:39:49 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 3/5] arm: dts: k3-am62-lp: Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:21 +0530
Message-ID: <20250226063923.2266288-4-s-k6@ti.com>
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

Update the DDR Configurations for AM62x LP SK according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62-lp4-50-800-800.dtsi | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi b/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
index c255ae6530f5..ee9e213be840 100644
--- a/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
+++ b/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.09.07
- * Wed Mar 01 2023 17:52:11 GMT-0600 (Central Standard Time)
+ * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
+ * Tue Sep 17 2024 13:07:19 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 800MHz
  * Density (per channel): 16Gb
@@ -13,6 +13,8 @@
 #define DDRSS_PLL_FHS_CNT 3
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
+#define DDRSS_SDRAM_IDX 15
+#define DDRSS_REGION_IDX 16
 
 #define DDRSS_CTL_0_DATA 0x00000B00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -847,7 +849,7 @@
 #define DDRSS_PHY_62_DATA 0x00000000
 #define DDRSS_PHY_63_DATA 0x00000000
 #define DDRSS_PHY_64_DATA 0x00000000
-#define DDRSS_PHY_65_DATA 0x00000004
+#define DDRSS_PHY_65_DATA 0x00000104
 #define DDRSS_PHY_66_DATA 0x00000000
 #define DDRSS_PHY_67_DATA 0x00000000
 #define DDRSS_PHY_68_DATA 0x00000000
@@ -869,7 +871,7 @@
 #define DDRSS_PHY_84_DATA 0x00100010
 #define DDRSS_PHY_85_DATA 0x00100010
 #define DDRSS_PHY_86_DATA 0x00100010
-#define DDRSS_PHY_87_DATA 0x02020010
+#define DDRSS_PHY_87_DATA 0x02000010
 #define DDRSS_PHY_88_DATA 0x51516041
 #define DDRSS_PHY_89_DATA 0x31C06000
 #define DDRSS_PHY_90_DATA 0x07AB0340
@@ -1103,7 +1105,7 @@
 #define DDRSS_PHY_318_DATA 0x00000000
 #define DDRSS_PHY_319_DATA 0x00000000
 #define DDRSS_PHY_320_DATA 0x00000000
-#define DDRSS_PHY_321_DATA 0x00000004
+#define DDRSS_PHY_321_DATA 0x00000104
 #define DDRSS_PHY_322_DATA 0x00000000
 #define DDRSS_PHY_323_DATA 0x00000000
 #define DDRSS_PHY_324_DATA 0x00000000
@@ -1125,7 +1127,7 @@
 #define DDRSS_PHY_340_DATA 0x00100010
 #define DDRSS_PHY_341_DATA 0x00100010
 #define DDRSS_PHY_342_DATA 0x00100010
-#define DDRSS_PHY_343_DATA 0x02020010
+#define DDRSS_PHY_343_DATA 0x02000010
 #define DDRSS_PHY_344_DATA 0x51516041
 #define DDRSS_PHY_345_DATA 0x31C06000
 #define DDRSS_PHY_346_DATA 0x07AB0340
@@ -2181,7 +2183,7 @@
 #define DDRSS_PHY_1396_DATA 0x0089FF00
 #define DDRSS_PHY_1397_DATA 0x000C3F11
 #define DDRSS_PHY_1398_DATA 0x01990000
-#define DDRSS_PHY_1399_DATA 0x000C3F11
+#define DDRSS_PHY_1399_DATA 0x000C3F91
 #define DDRSS_PHY_1400_DATA 0x01990000
 #define DDRSS_PHY_1401_DATA 0x3F0DFF11
 #define DDRSS_PHY_1402_DATA 0x01990000
-- 
2.34.1

