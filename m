Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC72C4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E4F87468;
	Tue, 14 Nov 2023 17:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fw3W6/re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286A786940; Tue, 14 Nov 2023 17:00:11 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D131871DF
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxwOK040744;
 Tue, 14 Nov 2023 09:59:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699977599;
 bh=Q2lifXSsW5pINQNt1uj4HJ5gxImLcoNcCkJrJDDAnVQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Fw3W6/reHqXT2D+fYBa7hXWhcVaERPn02hW6CQXMJPHm46dmdcrgIjz4HS9mNOAU9
 Ngkda/eVz36Agy/UwQQ5jaJ4UD76DxuQqJNpx5YSbvqSi2M3oGZ6Re9SeDueQsnTlK
 1/acdw0I9KgSAEk1W43f8kRe+Gwy4LrmNV4/uFJw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AEFxwoF067473
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 09:59:58 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 09:59:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 09:59:58 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxvpV021295;
 Tue, 14 Nov 2023 09:59:58 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/3] arm: mach-k3: Move sysfw-loader into R5 directory
Date: Tue, 14 Nov 2023 09:59:50 -0600
Message-ID: <20231114155950.296644-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114155950.296644-1-afd@ti.com>
References: <20231114155950.296644-1-afd@ti.com>
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

SYSFW is only ever loaded by the R5 core, move the code into that
directory. While here also move the related Kconfig symbols.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Kconfig                 | 51 ++----------------------
 arch/arm/mach-k3/Makefile                |  1 -
 arch/arm/mach-k3/r5/Kconfig              | 45 +++++++++++++++++++++
 arch/arm/mach-k3/r5/Makefile             |  4 ++
 arch/arm/mach-k3/{ => r5}/sysfw-loader.c |  2 +-
 5 files changed, 54 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-k3/r5/Kconfig
 rename arch/arm/mach-k3/{ => r5}/sysfw-loader.c (99%)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 4d19cf3e353..ced7d3bcba6 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -109,53 +109,6 @@ config K3_EARLY_CONS_IDX
 	  Use this option to set the index of the serial device to be used
 	  for the early console during SPL execution.
 
-config K3_LOAD_SYSFW
-	bool
-	depends on CPU_V7R
-
-config K3_SYSFW_IMAGE_NAME
-	string "File name of SYSFW firmware and configuration blob"
-	depends on K3_LOAD_SYSFW
-	default	"sysfw.itb"
-	help
-	  Filename of the combined System Firmware and configuration image tree
-	  blob to be loaded when booting from a filesystem.
-
-config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_SECT
-	hex "MMC sector to load SYSFW firmware and configuration blob from"
-	depends on K3_LOAD_SYSFW && SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
-	default 0x3600
-	help
-	  Address on the MMC to load the combined System Firmware and
-	  configuration image tree blob from, when the MMC is being used
-	  in raw mode. Units: MMC sectors (1 sector = 512 bytes).
-
-config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_PART
-	hex "MMC partition to load SYSFW firmware and configuration blob from"
-	depends on K3_LOAD_SYSFW && SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-	default 2
-	help
-	  Partition on the MMC to the combined System Firmware and configuration
-	  image tree blob from, when the MMC is being used in raw mode.
-
-config K3_SYSFW_IMAGE_SIZE_MAX
-	int "Amount of memory dynamically allocated for loading SYSFW blob"
-	depends on K3_LOAD_SYSFW
-	default	280000
-	help
-	  Amount of memory (in bytes) reserved through dynamic allocation at
-	  runtime for loading the combined System Firmware and configuration image
-	  tree blob. Keep it as tight as possible, as this directly affects the
-	  overall SPL memory footprint.
-
-config K3_SYSFW_IMAGE_SPI_OFFS
-	hex "SPI offset of SYSFW firmware and configuration blob"
-	depends on K3_LOAD_SYSFW
-	default	0x6C0000
-	help
-	  Offset of the combined System Firmware and configuration image tree
-	  blob to be loaded when booting from a SPI flash memory.
-
 config SYS_K3_SPL_ATF
 	bool "Start Cortex-A from SPL"
 	depends on CPU_V7R
@@ -187,6 +140,10 @@ config K3_X509_SWRV
 	help
 	  SWRV for X509 certificate used for boot images
 
+if CPU_V7R
+source "arch/arm/mach-k3/r5/Kconfig"
+endif
+
 source "board/ti/am65x/Kconfig"
 source "board/ti/am64x/Kconfig"
 source "board/ti/am62x/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 215c755c5dc..42161376469 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -20,6 +20,5 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
 obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
-obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
 endif
 obj-y += common.o security.o
diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
new file mode 100644
index 00000000000..ae79f8ff6cd
--- /dev/null
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -0,0 +1,45 @@
+config K3_LOAD_SYSFW
+	bool
+
+config K3_SYSFW_IMAGE_NAME
+	string "File name of SYSFW firmware and configuration blob"
+	depends on K3_LOAD_SYSFW
+	default	"sysfw.itb"
+	help
+	  Filename of the combined System Firmware and configuration image tree
+	  blob to be loaded when booting from a filesystem.
+
+config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_SECT
+	hex "MMC sector to load SYSFW firmware and configuration blob from"
+	depends on K3_LOAD_SYSFW && SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+	default 0x3600
+	help
+	  Address on the MMC to load the combined System Firmware and
+	  configuration image tree blob from, when the MMC is being used
+	  in raw mode. Units: MMC sectors (1 sector = 512 bytes).
+
+config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_PART
+	hex "MMC partition to load SYSFW firmware and configuration blob from"
+	depends on K3_LOAD_SYSFW && SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+	default 2
+	help
+	  Partition on the MMC to the combined System Firmware and configuration
+	  image tree blob from, when the MMC is being used in raw mode.
+
+config K3_SYSFW_IMAGE_SIZE_MAX
+	int "Amount of memory dynamically allocated for loading SYSFW blob"
+	depends on K3_LOAD_SYSFW
+	default	280000
+	help
+	  Amount of memory (in bytes) reserved through dynamic allocation at
+	  runtime for loading the combined System Firmware and configuration image
+	  tree blob. Keep it as tight as possible, as this directly affects the
+	  overall SPL memory footprint.
+
+config K3_SYSFW_IMAGE_SPI_OFFS
+	hex "SPI offset of SYSFW firmware and configuration blob"
+	depends on K3_LOAD_SYSFW
+	default	0x6C0000
+	help
+	  Offset of the combined System Firmware and configuration image tree
+	  blob to be loaded when booting from a SPI flash memory.
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index 8a6af73a44e..b99199d3374 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -11,3 +11,7 @@ obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 
 obj-y += lowlevel_init.o
 obj-y += r5_mpu.o
+
+ifeq ($(CONFIG_SPL_BUILD),y)
+obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
+endif
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
similarity index 99%
rename from arch/arm/mach-k3/sysfw-loader.c
rename to arch/arm/mach-k3/r5/sysfw-loader.c
index 73a17276e12..51e3b3cd1ca 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -23,7 +23,7 @@
 #include <spi_flash.h>
 
 #include <asm/io.h>
-#include "common.h"
+#include "../common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.39.2

