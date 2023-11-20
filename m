Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AA9C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 22:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CAA8755A;
	Mon, 20 Nov 2023 23:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZVdiMJhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4708753D; Mon, 20 Nov 2023 23:10:18 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A5E87579
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 23:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AKMACv7045890;
 Mon, 20 Nov 2023 16:10:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700518212;
 bh=dsgVS3vmvMLIR/mbi2JZPDE5QFu4V2d6CkxxevyGyqk=;
 h=From:To:CC:Subject:Date;
 b=ZVdiMJhuDdjPBLXPKSd/YxHgOk9SJAoZ5zM3VWYJdyWckLSlnniDhiHWQvr8xGANJ
 /H44CHoXrlnBf68+LdZTr6AdoOrq54yN6CGG/OmiTnWTUtRo41tLtmDaGjtiZ1nY08
 H4c1sHfi8QCLPqFO+QT8z5j98AU7KlaK6Hta799E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AKMACFl005938
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 Nov 2023 16:10:12 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Nov 2023 16:10:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Nov 2023 16:10:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AKMABJZ092803;
 Mon, 20 Nov 2023 16:10:11 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <p.yadav@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <reidt@ti.com>
Subject: [PATCH] arm: mach-k3: J721e: Add xSPI boot mode
Date: Mon, 20 Nov 2023 16:09:27 -0600
Message-ID: <20231120220927.3611197-1-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Vignesh Raghavendra <vigneshr@ti.com>

J7200 ROM supports booting from xSPI compliant flash. Detect if ROM
booted from xSPI bootmode and map that to BOOT_DEVICE_SPI

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 arch/arm/mach-k3/include/mach/j721e_spl.h | 3 ++-
 arch/arm/mach-k3/j721e_init.c             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
index ed3d7333bd..c51bc5ab8e 100644
--- a/arch/arm/mach-k3/include/mach/j721e_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
@@ -24,8 +24,9 @@
 #define BOOT_DEVICE_UFS			0x13
 #define BOOT_DEVIE_GPMC			0x14
 #define BOOT_DEVICE_PCIE		0x15
-#define BOOT_DEVICE_MMC2_2		0x16
+#define BOOT_DEVICE_XSPI		0x16
 #define BOOT_DEVICE_RAM			0x17
+#define BOOT_DEVICE_MMC2_2		0xFF /* Invalid value */
 
 /* Backup boot modes with MCU Only = 0 */
 #define BACKUP_BOOT_DEVICE_RAM		0x0
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index 18814c39ec..7bd64107b2 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -340,7 +340,8 @@ static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
 	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
 			BOOT_MODE_B_SHIFT;
 
-	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI)
+	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI ||
+	    bootmode == BOOT_DEVICE_XSPI)
 		bootmode = BOOT_DEVICE_SPI;
 
 	if (bootmode == BOOT_DEVICE_MMC2) {
-- 
2.34.1

