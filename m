Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C919FCF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB7089357;
	Fri, 20 Sep 2024 09:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F+/jJwBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6B689391; Fri, 20 Sep 2024 09:03:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB1189398
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815819; x=1758351819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uuqAwsohccYWza6uga4J7ZGK9u6uHq6zwMVSh8rlnuE=;
 b=F+/jJwBPTXSRBuyC8NemK6sqX+Axm/i3TVSOVpzMIaJ8ZndW05yVcHa9
 QWoG4gBKWwjhrlP8UVYJb7TAtcq5i7+zEIh9oo1dWIIJ/YIf/7t2M/2X5
 EzVhmoCMHNUhCVU8fQwfrOViNr+LAOki59DmdLxR4V0rNa9stq46TixR6
 ElUdGo0cf4cRVqfbLZNNALqHEJUT7q4U2TzgS+6jCrmNzIeT/zS+ItEbF
 8+nHFt33WnxVrwDRAF6vYctlJqI8MyuqJtuSN7Q9EeHENwLjDe55SF/fQ
 mRKTJSbj76DBz1gTRRGF1ggJ8rGSBSBFjaOUxgvC7RpP7Djdc587f0sm8 A==;
X-CSE-ConnectionGUID: UtR3rbSsQSW3aYWNSQzWjA==
X-CSE-MsgGUID: 7hX+7IOCSrSV3/rbJH4/Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961067"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961067"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:37 -0700
X-CSE-ConnectionGUID: uRBULuiORC+jUspAswoKiw==
X-CSE-MsgGUID: UJyBzes5QcequSa8VBagfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235158"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:34 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 11/20] arm: socfpga: agilex5: Add SMMU initialization
Date: Fri, 20 Sep 2024 15:02:33 +0800
Message-Id: <20240920070242.20884-12-tien.fong.chee@intel.com>
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

Allow non-secure accesses only with SMMU peripherals. This would protect
the content in DDR secure region from accidentally modified by SMMU
peripherals.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 34 ++++++++++++++++++++++++
 arch/arm/mach-socfpga/spl_soc64.c        | 17 +++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index bf30b3b8858..9baf2cbc525 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -387,6 +387,40 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_smmu_secure_config: socfpga-smmu-secure-config {
+			compatible = "intel,socfpga-dtreg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			/* System manager */
+			i_sys_mgt_sysmgr_csr@10d12000 {
+				reg = <0x10d12000 0x00000500>;
+				intel,offset-settings =
+					/* dma_tbu_stream_ctrl_reg_0_dma0 */
+					<0x0000017c 0x00000000 0x0000003f>,
+					/* dma_tbu_stream_ctrl_reg_0_dma1 */
+					<0x00000180 0x00000000 0x0000003f>,
+					/* sdm_tbu_stream_ctrl_reg_1_sdm */
+					<0x00000184 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_usb2 */
+					<0x00000188 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_sdmmc */
+					<0x00000190 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_nand */
+					<0x00000194 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_etr */
+					<0x00000198 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn0 */
+					<0x0000019c 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn1 */
+					<0x000001a0 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn2 */
+					<0x000001a4 0x00000000 0x0000003f>;
+				bootph-all;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index 4fe67ea0811..3bfe4bb9dd3 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2020 Intel Corporation. All rights reserved
+ *  Copyright (C) 2020-2024 Intel Corporation. All rights reserved
  *
  */
 
+#include <hang.h>
 #include <spl.h>
+#include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -22,3 +24,16 @@ u32 spl_boot_mode(const u32 boot_device)
 		return MMCSD_MODE_RAW;
 }
 #endif
+
+/* board specific function prior loading SSBL / U-Boot */
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-smmu-secure-config", &dev);
+	if (ret) {
+		printf("HPS SMMU secure settings init failed: %d\n", ret);
+		hang();
+	}
+}
-- 
2.25.1

