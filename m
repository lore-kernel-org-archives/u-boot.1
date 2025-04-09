Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D97C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8533C8327A;
	Wed,  9 Apr 2025 14:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xGgjkiQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB41583710; Wed,  9 Apr 2025 14:47:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231E4828F8
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 539ClpZH1515216
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Apr 2025 07:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744202871;
 bh=U4lBEePV+fNZ8xomn2KXnw0Q86tOqOk6zhEzD9wtD+Y=;
 h=From:To:CC:Subject:Date;
 b=xGgjkiQkKys0ANygkXaWFr022mOPbaOIYDPCwWmIk9N8rHxgHAzJeYo4SQDxz+Rko
 dhPJhBwUo/hmqrKx2lb23S5zkd0vN6WveiyhJhx76CEFDMzKiG+ifuDbSC7hOt3KfZ
 EepNsSVnQeQNxzwT/DTGDkuMvwZraB+8mEPUtZU0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 539ClpOq085329
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Apr 2025 07:47:51 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Apr 2025 07:47:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Apr 2025 07:47:51 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 539Clor0061645;
 Wed, 9 Apr 2025 07:47:51 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] configs: set SPL_TEXT_BASE by default for k3 platforms
Date: Wed, 9 Apr 2025 18:17:37 +0530
Message-ID: <20250409124739.3843126-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

SPL_TEXT_BASE is used as the load address for the main domain SPL on k3
platforms.

Since the config value is the same for every board, this patch sets the
value 0x80080000 as default for all ARCH_K3 and deletes the instances of
SPL_TEXT_BASE in individual defconfigs.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig                         | 1 +
 configs/am62ax_evm_a53_defconfig           | 1 -
 configs/am62px_evm_a53_defconfig           | 1 -
 configs/am62x_beagleplay_a53_defconfig     | 1 -
 configs/am62x_evm_a53_defconfig            | 1 -
 configs/am64x_evm_a53_defconfig            | 1 -
 configs/am65x_evm_a53_defconfig            | 1 -
 configs/iot2050_defconfig                  | 1 -
 configs/j7200_evm_a72_defconfig            | 1 -
 configs/j721e_beagleboneai64_a72_defconfig | 1 -
 configs/j721e_evm_a72_defconfig            | 1 -
 configs/j721s2_evm_a72_defconfig           | 1 -
 configs/j722s_evm_a53_defconfig            | 1 -
 configs/j784s4_evm_a72_defconfig           | 1 -
 configs/phycore_am62ax_a53_defconfig       | 1 -
 configs/phycore_am62x_a53_defconfig        | 1 -
 configs/phycore_am64x_a53_defconfig        | 1 -
 configs/verdin-am62_a53_defconfig          | 1 -
 18 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 94e118f8465..a84b96ebce4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -271,6 +271,7 @@ config SPL_TEXT_BASE
 	default 0x40200000 if OMAP34XX
 	default 0x402F4000 if AM43XX
 	default 0x402F0400 if AM33XX
+	default 0x80080000 if ARCH_K3
 	default 0x00908000 if ARCH_MX6
 	default 0x00912000 if ARCH_MX7
 	default 0x40301350 if OMAP54XX
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index bf6e9639901..9f47b35ffde 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -15,7 +15,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 30b4a24ee9a..572e5d3dc4a 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -13,7 +13,6 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62p5-sk"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index a8a73166597..fd578df5792 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -11,7 +11,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-beagleplay"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 6527200259e..09a7bdd6544 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -12,7 +12,6 @@ CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-sk"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index a501f3f567e..b3266cc64c8 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -16,7 +16,6 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-evm"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index e9b736714a5..75c33a0d256 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 2d5f18e5bd4..bd441e83cd1 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -21,7 +21,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ac5b10ba149..d2422b1a1bd 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index a5d95975fb4..cca167aad2b 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j721e-beagleboneai64"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 1ddb1965d8b..156d6567282 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j721e-common-proc-board"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index ab943ebfab2..9783b02dd29 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -21,7 +21,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 667d633c899..5225500fee7 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -19,7 +19,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index f058e3b1c00..c8b69c76edc 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j784s4-evm"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 421dd851506..45f9ad8c02e 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 0494fc408b7..6d0a9f35d4b 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -20,7 +20,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index f0c7ee26384..d12da5c3839 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index e7a88c9788d..10de0a2a39b 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
-- 
2.49.0

