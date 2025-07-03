Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5270CC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE0180E9A;
	Thu,  3 Jul 2025 15:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lkqVWbfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31838206E; Thu,  3 Jul 2025 15:03:48 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCA58091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563D3ie6026800;
 Thu, 3 Jul 2025 08:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751547824;
 bh=5GhdqjE23H9al++tpPWLJAIAnpe6DGLmG8GvYC54Drs=;
 h=From:To:CC:Subject:Date;
 b=lkqVWbfhmLNA9uURaIwi+o95kWQRn+39PqUegu89HvD0xniFpSW67jHs4p4xpjAVq
 NkR38R2HX+qFMtCWRkA8f2mB/xlVYTM/OICvKrbpTI8NO07U4oWLDWtjYc4ZBQSaoB
 Jw93+ZWPck+MTLghPnpLDkyZyVwBy6hIAc+/2Y0U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563D3HKv1850902
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:03:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:03:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:03:17 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563D3GP31152977;
 Thu, 3 Jul 2025 08:03:17 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] configs: am62x: fix CONFIG_NR_DRAM_BANKS to 1
Date: Thu, 3 Jul 2025 18:32:26 +0530
Message-ID: <20250703130227.4106816-1-anshuld@ti.com>
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

CONFIG_NR_DRAM_BANKS defines the number of DRAM banks on the
device. The default value of NR_DRAM_BANKS for ARCH_K3 is set to 2
(arch/arm/mach-k3/Kconfig:199) but should be 1 for am62x platforms.

This patch updates NR_DRAM_BANKS value for all am62x platforms to 1.

Fixes: 2969ed31b893 ("configs: Add am62x_beagleplay_*_defconfig")
Fixes: 2d257d9279e3 ("configs: Add configs for AM62x SK")
Fixes: 085cd6459dae ("board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM")
Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/am62x_beagleplay_a53_defconfig | 2 +-
 configs/am62x_beagleplay_r5_defconfig  | 1 +
 configs/am62x_evm_a53_defconfig        | 1 +
 configs/am62x_evm_r5_defconfig         | 1 +
 configs/phycore_am62x_a53_defconfig    | 1 +
 configs/phycore_am62x_r5_defconfig     | 1 +
 configs/verdin-am62_a53_defconfig      | 1 +
 configs/verdin-am62_r5_defconfig       | 1 +
 8 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index f61e701e3c9..05853317fea 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_A53_BEAGLEPLAY=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 7ca5f58ea0c..a4e680240c6 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_R5_BEAGLEPLAY=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 2c04d32195d..4da668396d0 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -5,6 +5,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 4e3ed7801e6..b23b816e540 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 487eafb0e17..0a4904c1541 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_TARGET_PHYCORE_AM62X_A53=y
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index a5d494cf87a..b3681993d49 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_TARGET_PHYCORE_AM62X_R5=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 4bdcb4b6c46..da384598ef7 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_VERDIN_AM62_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index f9580e697ff..175e2d6a9a7 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_VERDIN_AM62_R5=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.49.0

