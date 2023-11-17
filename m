Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD8C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A276586FC9;
	Fri, 17 Nov 2023 23:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RxKTzEPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DDAA86F2A; Fri, 17 Nov 2023 23:38:39 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D26186FC9
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcVEi024217;
 Fri, 17 Nov 2023 16:38:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700260711;
 bh=YqtLC85CRS5g3LCPc/GVmSMIK0KaOtldkcqmm8Xkav4=;
 h=From:To:CC:Subject:Date;
 b=RxKTzEPCMm+QURhHoXyA4yDUkI7h7zQCXt77hm7OI3l49ZS9zp9DoAI9a+2uWzlPY
 t7g7z73zD6Rk66r/1z18DAJiSR4iUq1Lq1i/fozVV5wx935KCyDfjSyIHAqSDGGmm4
 XfNy+pSHMBNKopzD5dlW9Q7ZDrEJ/Whmgku5eO8I=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHMcVpO052313
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 16:38:31 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 16:38:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 16:38:31 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcUtv021675; 
 Fri, 17 Nov 2023 16:38:30 -0600
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH 1/3] configs: keystone2: Remove unused SPL_MALLOC_F_SIZE and
 KEYSTONE_SPL_STACK_SIZE
Date: Fri, 17 Nov 2023 16:38:27 -0600
Message-ID: <20231117223829.346652-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

These are leftover definitions. While here cleanup some leftover comments.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 include/configs/ti_armv7_keystone2.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/configs/ti_armv7_keystone2.h b/include/configs/ti_armv7_keystone2.h
index 72c04d8a994..637e9e4369e 100644
--- a/include/configs/ti_armv7_keystone2.h
+++ b/include/configs/ti_armv7_keystone2.h
@@ -9,23 +9,10 @@
 #ifndef __CONFIG_KS2_EVM_H
 #define __CONFIG_KS2_EVM_H
 
-/* U-Boot Build Configuration */
-
-/* SoC Configuration */
-
 /* Memory Configuration */
 #define CFG_SYS_LPAE_SDRAM_BASE	0x800000000
 #define CFG_MAX_RAM_BANK_SIZE	(2 << 30)       /* 2GB */
 
-#ifdef CONFIG_SYS_MALLOC_F_LEN
-#define SPL_MALLOC_F_SIZE	CONFIG_SYS_MALLOC_F_LEN
-#else
-#define SPL_MALLOC_F_SIZE	0
-#endif
-
-/* SPL SPI Loader Configuration */
-#define KEYSTONE_SPL_STACK_SIZE		(8 * 1024)
-
 /* SRAM scratch space entries  */
 #define SRAM_SCRATCH_SPACE_ADDR		0xc0c23fc
 
@@ -53,8 +40,6 @@
 #define CFG_KSNET_SERDES_SGMII2_BASE		KS2_SGMII_SERDES2_BASE
 #define CFG_KSNET_SERDES_LANES_PER_SGMII	KS2_LANES_PER_SGMII_SERDES
 
-/* EEPROM definitions */
-
 /* NAND Configuration */
 #define CFG_SYS_NAND_MASK_CLE		0x4000
 #define CFG_SYS_NAND_MASK_ALE		0x2000
@@ -63,13 +48,6 @@
 #define CFG_SYS_NAND_LARGEPAGE
 #define CFG_SYS_NAND_BASE_LIST		{ 0x30000000, }
 
-
-
-/* U-Boot general configuration */
-
-/* EDMA3 */
-
-
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.39.2

