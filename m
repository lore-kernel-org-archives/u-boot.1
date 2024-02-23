Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E45C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 05:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE29887C6A;
	Fri, 23 Feb 2024 06:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Akzlcl6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BA5876BA; Fri, 23 Feb 2024 05:58:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871AC87D97
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 05:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N4wKdK011870;
 Thu, 22 Feb 2024 22:58:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708664300;
 bh=yT5OushQx3Ku+9yr3Z342mV3zkIeUPpr7AxD0LvhrbE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Akzlcl6sTwhL4mhYisJo2yk0gX3Su326gpitZ4XJaAzUss248+dLy2avtKEXEeaxj
 VTe9l6COIe1sHi6ilK4D4FYBKJdMrwwwMF5/eQCTkL2/acFUosmJEOt37WkuVIOwq2
 9btJMGG70qBHxvsUcY9Oha2G70d0CUW7qVvKlj74=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N4wKX4029920
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 22:58:20 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 22:58:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 22:58:19 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N4wKAJ129681;
 Thu, 22 Feb 2024 22:58:20 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 2/2] arm: mach-k3: j721e: Enable OSPI boot
Date: Thu, 22 Feb 2024 22:57:25 -0600
Message-ID: <20240223045725.2010498-3-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223045725.2010498-1-j-humphreys@ti.com>
References: <20240223045725.2010498-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 06:16:36 +0100
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

Add boot ROM XSPI bootmode, and set to BOOT_DEVICE_SPI if detected.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/mach-k3/include/mach/j721e_spl.h | 5 +++--
 arch/arm/mach-k3/j721e_init.c             | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
index ed3d7333bd..aaee653537 100644
--- a/arch/arm/mach-k3/include/mach/j721e_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
@@ -24,8 +24,9 @@
 #define BOOT_DEVICE_UFS			0x13
 #define BOOT_DEVIE_GPMC			0x14
 #define BOOT_DEVICE_PCIE		0x15
-#define BOOT_DEVICE_MMC2_2		0x16
-#define BOOT_DEVICE_RAM			0x17
+#define BOOT_DEVICE_XSPI 		0x16
+#define BOOT_DEVICE_RAM 		0x17
+#define BOOT_DEVICE_MMC2_2 		0xFF /* Invalid value */
 
 /* Backup boot modes with MCU Only = 0 */
 #define BACKUP_BOOT_DEVICE_RAM		0x0
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index c2976c4ea0..7ee9b75de4 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -346,7 +346,8 @@ static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
 	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
 			BOOT_MODE_B_SHIFT;
 
-	if (bootmode == BOOT_DEVICE_OSPI || bootmode ==	BOOT_DEVICE_QSPI)
+	if (bootmode == BOOT_DEVICE_OSPI || bootmode == BOOT_DEVICE_QSPI ||
+	    bootmode == BOOT_DEVICE_XSPI)
 		bootmode = BOOT_DEVICE_SPI;
 
 	if (bootmode == BOOT_DEVICE_MMC2) {
-- 
2.34.1

