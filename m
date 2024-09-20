Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31623CF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F7D89348;
	Fri, 20 Sep 2024 09:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kZDXICov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5DF89335; Fri, 20 Sep 2024 09:03:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2DD8933C
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815797; x=1758351797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V0K+8DKMJWLz1B5xkysKlVH5C0vxTgThFS4bCGiyxiE=;
 b=kZDXICovyb/+GOnu9RvztdgynC543fjiW+FDJ65pEx6pWEcfut0/a5Wg
 ri+pV5zwZ5nteMFuEVQf342/YphKkUZvtCuSVjZF0148wpiFar+oLxypv
 BBBjwMnqVOCVGaDyQjetG1FjK+KYqPQVC+3yrh57qjdQsN7An5oKmbq7H
 0mf/3eKTDhiB/PoGjeDfGDaCUY6PIVINp+ZLhH8cNl4/hIfVsiyENoWTD
 +9opfesCMAtULyUaF40aNLarIWfagSlQ+Xh28mY8BsHRT0D4ZP4UNWwCO
 RvDfvJ5maYyMlAe71XWbV5KF5bZSm00DPOUqK8K8PfXHeVHTiUCZmpJJI A==;
X-CSE-ConnectionGUID: vzEZ/NLxRyurppJu9vNUeQ==
X-CSE-MsgGUID: 6Fv1beYuTSO/vJ8wCkH43A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961018"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:15 -0700
X-CSE-ConnectionGUID: 5U682xAvTKOBwgk9ejYMSw==
X-CSE-MsgGUID: +w/oDUxzT4mWHgnDk/ik3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235015"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:13 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 01/20] arm: socfpga: agilex5: Add new system manager base
 addresses
Date: Fri, 20 Sep 2024 15:02:23 +0800
Message-Id: <20240920070242.20884-2-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Initial creation of new system manager base addresses for Agilex5.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 .../include/mach/system_manager_soc64.h       | 129 +++++++++++-------
 1 file changed, 83 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index a8009664fee..b1ef4a70641 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2019-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2019-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef _SYSTEM_MANAGER_SOC64_H_
@@ -11,22 +11,43 @@ void sysmgr_pinmux_init(void);
 void populate_sysmgr_fpgaintf_module(void);
 void populate_sysmgr_pinmux(void);
 
-#define SYSMGR_SOC64_WDDBG			0x08
-#define SYSMGR_SOC64_DMA			0x20
-#define SYSMGR_SOC64_DMA_PERIPH			0x24
-#define SYSMGR_SOC64_SDMMC			0x28
-#define SYSMGR_SOC64_SDMMC_L3MASTER		0x2c
-#define SYSMGR_SOC64_EMAC_GLOBAL		0x40
-#define SYSMGR_SOC64_EMAC0			0x44
-#define SYSMGR_SOC64_EMAC1			0x48
-#define SYSMGR_SOC64_EMAC2			0x4c
-#define SYSMGR_SOC64_EMAC0_ACE			0x50
-#define SYSMGR_SOC64_EMAC1_ACE			0x54
-#define SYSMGR_SOC64_EMAC2_ACE			0x58
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SYSMGR_SOC64_SILICONID_1		0x00
+#define SYSMGR_SOC64_SILICONID_2		0x04
+#define SYSMGR_SOC64_MPU_STATUS			0x10
+#define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
+#define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
+#define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
+#define SYSMGR_SOC64_USB0_L3MASTER		0x38
+#define SYSMGR_SOC64_USB1_L3MASTER		0x3c
+#define SYSMGR_SOC64_DMAC0_L3_MASTER		0x74
+#define SYSMGR_SOC64_ETR_L3_MASTER		0x78
+#define SYSMGR_SOC64_DMAC1_L3_MASTER		0x7C
+#define SYSMGR_SOC64_SEC_CTRL_SLT		0x80
+#define SYSMGR_SOC64_OSC_TRIM			0x84
+#define SYSMGR_SOC64_DMAC0_CTRL_STATUS_REG	0x88
+#define SYSMGR_SOC64_DMAC1_CTRL_STATUS_REG	0x8C
+#define SYSMGR_SOC64_ECC_INTMASK_VALUE		0x90
+#define SYSMGR_SOC64_ECC_INTMASK_SET		0x94
+#define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
+#define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
+#define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
+#define SYSMGR_SOC64_MPFE_CONFIG		0x228
+#define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
+#define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
+#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK		GENMASK(31, 0)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_MASK	GENMASK(31, 29)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_SHIFT	29
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_INFO_MASK	BIT(27)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_EMIF_INFO_MASK	BIT(28)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_EMIF_INFO_MASK	GENMASK(28, 27)
+#define ALT_SYSMGR_SCRATCH_REG_3_DDR_DBE_MASK	BIT(1)
+#define ALT_SYSMGR_SCRATCH_REG_3_OCRAM_DBE_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MASK	BIT(0)
+#define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
+#else
 #define SYSMGR_SOC64_NAND_AXUSER		0x5c
-#define SYSMGR_SOC64_FPGAINTF_EN1		0x68
-#define SYSMGR_SOC64_FPGAINTF_EN2		0x6c
-#define SYSMGR_SOC64_FPGAINTF_EN3		0x70
 #define SYSMGR_SOC64_DMA_L3MASTER		0x74
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 #define SYSMGR_SOC64_DDR_MODE			0xb8
@@ -34,39 +55,56 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_HMC_CLK			0xb4
 #define SYSMGR_SOC64_IO_PA_CTRL			0xb8
 #endif
-#define SYSMGR_SOC64_NOC_TIMEOUT		0xc0
-#define SYSMGR_SOC64_NOC_IDLEREQ_SET		0xc4
-#define SYSMGR_SOC64_NOC_IDLEREQ_CLR		0xc8
-#define SYSMGR_SOC64_NOC_IDLEREQ_VAL		0xcc
-#define SYSMGR_SOC64_NOC_IDLEACK		0xd0
-#define SYSMGR_SOC64_NOC_IDLESTATUS		0xd4
-#define SYSMGR_SOC64_FPGA2SOC_CTRL		0xd8
-#define SYSMGR_SOC64_FPGA_CONFIG		0xdc
 #define SYSMGR_SOC64_IOCSRCLK_GATE		0xe0
 #define SYSMGR_SOC64_GPO			0xe4
 #define SYSMGR_SOC64_GPI			0xe8
 #define SYSMGR_SOC64_MPU			0xf0
-/*
- * Bits[31:28] reserved for N5X DDR retention, bits[27:0] reserved for SOC 64-bit
- * storing qspi ref clock (kHz)
- */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD0		0x200
-/* store osc1 clock freq */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD1		0x204
-/* store fpga clock freq */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD2		0x208
-/* reserved for customer use */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD3		0x20c
-/* store PSCI_CPU_ON value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD4		0x210
-/* store PSCI_CPU_ON value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD5		0x214
-/* store VBAR_EL3 value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD6		0x218
-/* store VBAR_EL3 value */
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD7		0x21c
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD8		0x220
-#define SYSMGR_SOC64_BOOT_SCRATCH_COLD9		0x224
+#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK	GENMASK(27, 0)
+#endif /*CONFIG_TARGET_SOCFPGA_AGILEX5*/
+
+#define SYSMGR_SOC64_DMA			0x20
+#define SYSMGR_SOC64_DMA_PERIPH			0x24
+#define SYSMGR_SOC64_WDDBG			0x08
+#define SYSMGR_SOC64_SDMMC			0x28
+#define SYSMGR_SOC64_SDMMC_L3MASTER		0x2C
+#define SYSMGR_SOC64_FPGAINTF_EN1		0x68
+#define SYSMGR_SOC64_FPGAINTF_EN2		0x6C
+#define SYSMGR_SOC64_FPGAINTF_EN3		0x70
+#define SYSMGR_SOC64_NOC_TIMEOUT		0xC0
+#define SYSMGR_SOC64_NOC_IDLEREQ_SET		0xC4
+#define SYSMGR_SOC64_NOC_IDLEREQ_CLR		0xC8
+#define SYSMGR_SOC64_NOC_IDLEREQ_VAL		0xCC
+#define SYSMGR_SOC64_NOC_IDLEACK		0xd0
+#define SYSMGR_SOC64_NOC_IDLESTATUS		0xD4
+#define SYSMGR_SOC64_FPGA2SOC_CTRL		0xD8
+#define SYSMGR_SOC64_FPGA_CONFIG		0xDC
+
+#define SYSMGR_SOC64_TSN_GLOBAL			0x40
+#define SYSMGR_SOC64_TSN_0			0x44
+#define SYSMGR_SOC64_TSN_1			0x48
+#define SYSMGR_SOC64_TSN_2			0x4C
+#define SYSMGR_SOC64_TSN_0_ACE			0x50
+#define SYSMGR_SOC64_TSN_1_ACE			0x54
+#define SYSMGR_SOC64_TSN_2_ACE			0x58
+#define SYSMGR_SOC64_EMAC_GLOBAL	SYSMGR_SOC64_TSN_GLOBAL
+#define SYSMGR_SOC64_EMAC0		SYSMGR_SOC64_TSN_0
+#define SYSMGR_SOC64_EMAC1		SYSMGR_SOC64_TSN_1
+#define SYSMGR_SOC64_EMAC2		SYSMGR_SOC64_TSN_2
+#define SYSMGR_SOC64_EMAC0_ACE		SYSMGR_SOC64_TSN_0_ACE
+#define SYSMGR_SOC64_EMAC1_ACE		SYSMGR_SOC64_TSN_1_ACE
+#define SYSMGR_SOC64_EMAC2_ACE		SYSMGR_SOC64_TSN_2_ACE
+
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD0	0x200
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD1	0x204
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD2	0x208
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD3	0x20C
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD4	0x210
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD5	0x214
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD6	0x218
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD7	0x21C
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD8	0x220
+#define SYSMGR_SOC64_BOOT_SCRATCH_COLD9	0x224
+
 #define SYSMGR_SOC64_PINSEL0			0x1000
 #define SYSMGR_SOC64_IOCTRL0			0x1130
 #define SYSMGR_SOC64_EMAC0_USEFPGA		0x1300
@@ -97,7 +135,6 @@ void populate_sysmgr_pinmux(void);
  * Bits[31:28] reserved for DM DDR retention, bits[27:0] reserved for SOC 64-bit
  * storing qspi ref clock (kHz)
  */
-#define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK		GENMASK(27, 0)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK	BIT(31)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_SHA_MASK		BIT(30)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK	(BIT(29) | BIT(28))
-- 
2.25.1

