Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47444E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA06180137;
	Fri, 13 Dec 2024 11:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mPOSDL+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B6480137; Fri, 13 Dec 2024 11:32:29 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285B68010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWPeI3133164
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 04:32:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085945;
 bh=CItkEUiETSriUFtgeNWAcTxa37VlK8LQLhdAYhuS3nU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mPOSDL+yjOMQiE3kFxIXHlNpwfKYaRMUDEVD3ryJykNCbiJR7LhvmyefCpGDN07G+
 T4lEWd86f67ldhpMjz6ehSyh22Mnsh4oBiHZ62qNA3IUu51SOKso45rRoZ2CDwiW8w
 kucfyJ2yE24h5zTP3B8w2QMskFYYLxgiz1CCFqEs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWP5v045983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:32:25 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:25 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpqD067253;
 Fri, 13 Dec 2024 04:32:21 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 8/9] arm: mach-k3: Set NR_DRAM_BANKS to 2
Date: Fri, 13 Dec 2024 16:01:28 +0530
Message-ID: <20241213103129.332246-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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

From: Neha Malcom Francis <n-francis@ti.com>

Set CONFIG_NR_DRAM_BANKS to 2 as we have two banks described in the
memory/ node for lower and higher addressible DDR regions.

This allows use of FDT functions from fdt_support.c to set up and fix up
the memory/ node correctly.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/Kconfig              | 3 +++
 configs/am62ax_evm_a53_defconfig      | 1 -
 configs/am62px_evm_a53_defconfig      | 1 -
 configs/am62x_evm_a53_defconfig       | 1 -
 configs/am62x_evm_r5_defconfig        | 1 -
 configs/am64x_evm_a53_defconfig       | 1 -
 configs/am64x_evm_r5_defconfig        | 1 -
 configs/am65x_evm_a53_defconfig       | 1 -
 configs/am65x_evm_r5_defconfig        | 1 -
 configs/am65x_evm_r5_usbdfu_defconfig | 1 -
 configs/am65x_evm_r5_usbmsc_defconfig | 1 -
 configs/j7200_evm_a72_defconfig       | 1 -
 configs/j721e_evm_a72_defconfig       | 1 -
 configs/j721s2_evm_a72_defconfig      | 1 -
 configs/j722s_evm_a53_defconfig       | 1 -
 configs/j784s4_evm_a72_defconfig      | 1 -
 16 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index f3f42b392139..a3ac490f6774 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -156,6 +156,9 @@ config K3_X509_SWRV
 	help
 	  SWRV for X509 certificate used for boot images
 
+config NR_DRAM_BANKS
+	default 2
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 7d63340c903f..107d6c6becfe 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM62A7=y
 CONFIG_TARGET_AM62A7_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 9635beb1b27e..30b4a24ee9ae 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM62P5=y
 CONFIG_TARGET_AM62P5_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 003fa4f86814..2509a91cf628 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index fcc5eb028679..b47f2f2d1f3a 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e6e3e018da64..a501f3f567e5 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM642=y
 CONFIG_K3_ATF_LOAD_ADDR=0x701c0000
 CONFIG_TARGET_AM642_A53_EVM=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index c4e498a6ae7a..c7fc9d124c7b 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM642=y
 CONFIG_TARGET_AM642_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index b6df8b428c65..e9b736714a5b 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM654=y
 CONFIG_TARGET_AM654_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 083522ce9b49..4bd5e8f63ff1 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x55000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM654=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_AM654_R5_EVM=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index e60e0d6588d3..ae57007d8985 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x55000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM654=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_AM654_R5_EVM=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index ecd48c45ea16..3aa17eb77f0f 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x55000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM654=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_AM654_R5_EVM=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index eb6203f2b4c2..7e598eeadbeb 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721E=y
 CONFIG_TARGET_J7200_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index bd5563492449..86c746d5064e 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721E=y
 CONFIG_TARGET_J721E_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 2a0ccfb581ea..640aa00a0241 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 35329fb336bf..17595e3c4514 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J722S=y
 CONFIG_TARGET_J722S_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index c7fc6bedda3b..7176ec85cd90 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J784S4_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.34.1

