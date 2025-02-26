Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52D1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E860D80FC8;
	Wed, 26 Feb 2025 07:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lCdn6vDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810E5807EE; Wed, 26 Feb 2025 07:40:01 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF1980977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6duhC1996434
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 00:39:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740551996;
 bh=wuQJzXMn7FieRnEBTMvKlrfpshoPL8JlQbNzLD2xceo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lCdn6vDtWOr6cgg3H7O8gtpJsjWr2vyn8Pv8HsBZQIYITbhv024F+TRsEtHNMKCPA
 RfCLdcdV96oZZItkmEhJ3q6ri9Fq8mIx1ltctOugl6xQtGoPZhwpx6tKDckc+ImTHq
 yZEfnnM7HCU+B1O/r25qnVkj8EjS41o0wurYdWe4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6duO7072229
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 00:39:56 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:39:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:39:56 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6dgMC049984;
 Wed, 26 Feb 2025 00:39:54 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 5/5] arm: dts: k3-am62p: Update DDR Configurations
Date: Wed, 26 Feb 2025 12:09:23 +0530
Message-ID: <20250226063923.2266288-6-s-k6@ti.com>
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

Update the DDR Configurations for AM62Px SK according to the SysConfig
DDR Configuration tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
index f66435201530..c7e33ba50b99 100644
--- a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
+++ b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62Px SysConfig DDR Subsystem Register Configuration Tool v0.10.02
- * Thu Jan 25 2024 10:43:46 GMT-0600 (Central Standard Time)
+ * AM62Px SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
+ * Tue Sep 17 2024 11:03:07 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 1600MHz
  * Density (per channel): 16Gb
@@ -941,7 +941,7 @@
 #define DDRSS_PHY_64_DATA 0x00000000
 #define DDRSS_PHY_65_DATA 0x00000000
 #define DDRSS_PHY_66_DATA 0x00000000
-#define DDRSS_PHY_67_DATA 0x00000004
+#define DDRSS_PHY_67_DATA 0x00000104
 #define DDRSS_PHY_68_DATA 0x00000000
 #define DDRSS_PHY_69_DATA 0x00000000
 #define DDRSS_PHY_70_DATA 0x00000000
@@ -1197,7 +1197,7 @@
 #define DDRSS_PHY_320_DATA 0x00000000
 #define DDRSS_PHY_321_DATA 0x00000000
 #define DDRSS_PHY_322_DATA 0x00000000
-#define DDRSS_PHY_323_DATA 0x00000004
+#define DDRSS_PHY_323_DATA 0x00000104
 #define DDRSS_PHY_324_DATA 0x00000000
 #define DDRSS_PHY_325_DATA 0x00000000
 #define DDRSS_PHY_326_DATA 0x00000000
@@ -1453,7 +1453,7 @@
 #define DDRSS_PHY_576_DATA 0x00000000
 #define DDRSS_PHY_577_DATA 0x00000000
 #define DDRSS_PHY_578_DATA 0x00000000
-#define DDRSS_PHY_579_DATA 0x00000004
+#define DDRSS_PHY_579_DATA 0x00000104
 #define DDRSS_PHY_580_DATA 0x00000000
 #define DDRSS_PHY_581_DATA 0x00000000
 #define DDRSS_PHY_582_DATA 0x00000000
@@ -1709,7 +1709,7 @@
 #define DDRSS_PHY_832_DATA 0x00000000
 #define DDRSS_PHY_833_DATA 0x00000000
 #define DDRSS_PHY_834_DATA 0x00000000
-#define DDRSS_PHY_835_DATA 0x00000004
+#define DDRSS_PHY_835_DATA 0x00000104
 #define DDRSS_PHY_836_DATA 0x00000000
 #define DDRSS_PHY_837_DATA 0x00000000
 #define DDRSS_PHY_838_DATA 0x00000000
-- 
2.34.1

