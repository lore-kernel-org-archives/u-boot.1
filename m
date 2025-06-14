Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C95C71141
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 09:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F80780FA8;
	Sat, 14 Jun 2025 11:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g3Ev8JVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C5D82B70; Sat, 14 Jun 2025 11:37:54 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE0280F0E
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 11:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55E9be0Y2180650;
 Sat, 14 Jun 2025 04:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749893860;
 bh=3Qq+jRCyanD1hHbjscNGBns4Axxa6gA8oL7rUrvB8pI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=g3Ev8JVuk0raDQS9RuVDYuazYpszf4HMGkzGEN3qqji4ra2MHjj8PsWtEYF8+bzgh
 vunazU7ICftUPIm3S6N4aaqlYu7jgHDDekIJtE7AqEP2fNwMbYVjJqQwi9lXHQ9NX+
 /ArOqqSIeQNnyn7UyiJdjSwsdCmFjrHKZ1ewpIp4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55E9bei63359799
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sat, 14 Jun 2025 04:37:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 14
 Jun 2025 04:37:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 14 Jun 2025 04:37:39 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55E9bOPr840286;
 Sat, 14 Jun 2025 04:37:34 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <ggiordano@phytec.com>, <wegorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <jm@ti.com>, <n-francis@ti.com>,
 <bb@ti.com>, <vitor.soares@toradex.com>, <contact@paulk.fr>,
 <Oliver.Gaskell@analog.com>, <marex@denx.de>,
 <jerome.forissier@linaro.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 2/2] configs: j7*/*am62*: Remove malloc size overwrite at
 config level.
Date: Sat, 14 Jun 2025 15:07:17 +0530
Message-ID: <20250614093717.2479920-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614093717.2479920-1-u-kumar1@ti.com>
References: <20250614093717.2479920-1-u-kumar1@ti.com>
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

Use default value of malloc size coming from Kconfig, instead of
board specific override.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 configs/am62x_a53_usbdfu.config            | 1 -
 configs/am64x_evm_a53_defconfig            | 1 -
 configs/am64x_evm_r5_defconfig             | 1 -
 configs/am65x_evm_a53_defconfig            | 1 -
 configs/am65x_evm_r5_defconfig             | 1 -
 configs/am65x_evm_r5_usbdfu_defconfig      | 1 -
 configs/am65x_evm_r5_usbmsc_defconfig      | 1 -
 configs/j7200_evm_a72_defconfig            | 1 -
 configs/j7200_evm_r5_defconfig             | 1 -
 configs/j721e_beagleboneai64_a72_defconfig | 1 -
 configs/j721e_beagleboneai64_r5_defconfig  | 1 -
 configs/j721e_evm_a72_defconfig            | 1 -
 configs/j721e_evm_r5_defconfig             | 1 -
 configs/j721s2_evm_a72_defconfig           | 1 -
 configs/j721s2_evm_r5_defconfig            | 1 -
 configs/j784s4_evm_a72_defconfig           | 1 -
 configs/j784s4_evm_r5_defconfig            | 1 -
 configs/phycore_am62ax_a53_defconfig       | 1 -
 configs/phycore_am62x_a53_defconfig        | 1 -
 configs/phycore_am64x_a53_defconfig        | 1 -
 configs/phycore_am64x_r5_defconfig         | 1 -
 configs/verdin-am62_a53_defconfig          | 1 -
 22 files changed, 22 deletions(-)

diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
index 16cd4c89f41..373b1d0ed64 100644
--- a/configs/am62x_a53_usbdfu.config
+++ b/configs/am62x_a53_usbdfu.config
@@ -1,4 +1,3 @@
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 8f7d098f770..318a2270da2 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index b222bcd6e43..3f7012c99ce 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index a41f67a43fe..2cc7ae1cbc1 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 386749ebabd..7849c89500a 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x55000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index b0d333d95c2..3ac494f0126 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -2,7 +2,6 @@
 
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x57000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 90a857b8b95..7bd65bfef0c 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x55000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index a446074ad5d..ca444cfa349 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 0ae07ddf7c8..b9ffa1fc989 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index e3cd59343f0..fbe6a839fb5 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 086ad99ff6d..7d5c71e5650 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 99461cf6007..16c3c3243b2 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index c8324d4c068..fce4d32a48c 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 084deea28d0..8249a50d46f 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 6ea1d712be1..71fa0d57bc2 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 56af0230860..ba164697802 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 4f5a0c943d8..4c4fd787714 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index c74909dabdf..06a9c5a3152 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 487eafb0e17..18bd2c703ac 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 2032a34030f..a317ab29c34 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 2552479713f..fe21b412f67 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 4bdcb4b6c46..5b2c7f05605 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
-CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
-- 
2.34.1

