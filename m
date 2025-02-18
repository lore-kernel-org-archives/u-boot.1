Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C0AC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B0280FB6;
	Tue, 18 Feb 2025 09:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V9AsLcTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD4080FAA; Tue, 18 Feb 2025 09:35:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5DB807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867755; x=1771403755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TQFH3Q5zh26LAS+pFckWK3kC6NZYH/0Ilfj8/JgWgPo=;
 b=V9AsLcTjH2hazJFW26za5YnggXkh/3VXrhXb5GZwKBsxrC1b//Cv4IA+
 dPvo2sXC6rSDK6Q8/WIIzOqfzCcwag9jeE+MsnQNwd66fKDBlSDl/5dUA
 dKuXQ32W8WtKIyJfZ2GgD+VzK8DWsfhMAnEVgUt+dnqH1pkUpL9gT1QeS
 RzwXu5FjqrtrDxkF+HgpMJzH4L2qefdeODGCgg6k15gKDJD6mhQeXg7nK
 4xhwL9Lt0Rw3u3phOU3SgRaooTc01tu6LvjFq+wgaK4ZE8UPUAH5BCwIF
 LqyeBXlqtlMrTN9N+2CjpXMaMz/z02Zgl+a11RkRK0IohpEwZqFz/f0+q A==;
X-CSE-ConnectionGUID: N7FmquKkSw6H8CKpqGqvyA==
X-CSE-MsgGUID: +yql59GGQCq6qlgxySjzjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028165"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:54 -0800
X-CSE-ConnectionGUID: BSAaAHU0QpmR/U+r+tXZEQ==
X-CSE-MsgGUID: pdfsoPxpRp+/bTL3O/Vgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237751"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:52 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 14/26] arm: socfpga: agilex5: Add SMMU initialization
Date: Tue, 18 Feb 2025 16:34:59 +0800
Message-Id: <20250218083511.29249-15-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 34 ++++++++++++++++++++++++
 arch/arm/mach-socfpga/spl_soc64.c        | 16 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 08f568f5650..af3f5d32f9d 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -388,6 +388,40 @@
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
index 4fe67ea0811..df89125cb29 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020 Intel Corporation. All rights reserved
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
+#include <hang.h>
 #include <spl.h>
+#include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -22,3 +25,16 @@ u32 spl_boot_mode(const u32 boot_device)
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

