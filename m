Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212F4C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD4980F53;
	Tue, 18 Feb 2025 09:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RdqfNHBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1187D80F42; Tue, 18 Feb 2025 09:35:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874EE8043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867734; x=1771403734;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GJuCXOUtGqLhsxV4+VSYz87oiytTgxWWDDAHVQk1T8Y=;
 b=RdqfNHBsl0Jml9TkwqFDoxXLmwDiGgQKKyJHDpw5yPTFkR4dIfV7ODv3
 VMs/dEb0gJtnTibVASkBcxD+XGR+WIttfdgO5WcshtMqz8Z4288TKuBY9
 WUq9JkE7Jrk9gu1OA5lLLipwBYZCQWxxyyfmaHb7XUXVbJ7J3aLxTfQAq
 RUrkAT26K3l6jLbeaiA5aRDgjCfycd6QGq+MlSyUErGw2JHUYSJMVfHNU
 dVnjJIooYG0ri0a1hlt3dXTvbS8mg5keZ9Dm63Q7/WEJ/HYfV39gkEAqK
 PHDXrjsSclXexo+bD6QNbA7ycXE936AKlEXif32JispeL2VCCE/LfIuy+ Q==;
X-CSE-ConnectionGUID: AOVbEvmhR3iWn3+RyoUkMw==
X-CSE-MsgGUID: sh2kIX2HTd+G9KL38H/xPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028118"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:34 -0800
X-CSE-ConnectionGUID: YpCRiNIlQxGbkjilQV2/fQ==
X-CSE-MsgGUID: jMVY5n8jSbOAU1IBe+9jXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237702"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:32 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 06/26] arm: socfpga: agilex5: Add warm reset mask for
 Agilex5
Date: Tue, 18 Feb 2025 16:34:51 +0800
Message-Id: <20250218083511.29249-7-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

There are 5 L4 watchdogs and one SDM triggered warm reset bit
in Agilex5 reset manager "stat" register where bit 16:20 for L4
watchdogs. Assigning value 1 to these bits in the register address
will initiate SDM to trigger warm reset.

Introducing new warm reset mask for Agilex5 to trigger warm reset
to all five L4 watchdogs.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
index c8bb727aa2b..058fdd6e548 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef _RESET_MANAGER_SOC64_H_
@@ -23,14 +24,20 @@ void socfpga_bridges_reset(int enable);
 #define RSTMGR_BRGMODRST_FPGA2SOC_MASK	0x00000004
 
 /* SDM, Watchdogs and MPU warm reset mask */
-#define RSTMGR_STAT_SDMWARMRST		BIT(1)
+#define RSTMGR_STAT_SDMWARMRST		0x2
 #define RSTMGR_STAT_MPU0RST_BITPOS	8
 #define RSTMGR_STAT_L4WD0RST_BITPOS	16
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define RSTMGR_STAT_L4WD0RST_BIT	0x1F0000
+#define RSTMGR_L4WD_MPU_WARMRESET_MASK	(RSTMGR_STAT_SDMWARMRST | \
+		RSTMGR_STAT_L4WD0RST_BIT)
+#else
 #define RSTMGR_L4WD_MPU_WARMRESET_MASK	(RSTMGR_STAT_SDMWARMRST | \
 		GENMASK(RSTMGR_STAT_MPU0RST_BITPOS + 3, \
 			RSTMGR_STAT_MPU0RST_BITPOS) | \
 		GENMASK(RSTMGR_STAT_L4WD0RST_BITPOS + 3, \
 			RSTMGR_STAT_L4WD0RST_BITPOS))
+#endif
 
 /*
  * SocFPGA Stratix10 reset IDs, bank mapping is as follows:
-- 
2.25.1

