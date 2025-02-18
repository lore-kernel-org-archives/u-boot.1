Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5FFC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB2080F42;
	Tue, 18 Feb 2025 09:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ChQZEDuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D49780F95; Tue, 18 Feb 2025 09:35:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD95680F7D
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867740; x=1771403740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hVfVyT8zsCYSaIFUVl5z/DabbTdTcIe6dxmLl8nTWEU=;
 b=ChQZEDuWVbuWG9ERkF7ekJ7Hhh/qnwbQY9SWHWcmQYOJWoZ670eL3jXy
 p2N3GMIq5oKR5J2FP6lz5S2x0f1JFIX6bJgIFbNIXNVQzWK+KQGxl3ZIJ
 nX88rQRaIuJmod8IqO6rM8PubK340c112x1c5zgHVtERTrMmz1omKEZRr
 tWGmC527VG4OqXbg4QUbRabydkGzJ6hPP/xl+xYxYDbZ/rcpGdMUtP5qU
 DbJWbj+hhtTIvQhP+5bA6vW8V8hDBN26lKcAUmvuCHHh0jDjx1fRSeAkA
 wprfPyuAT5II2lpJTET1FAPpHVUpiS1Gveev8ZQC6OuJ1HhNapSHAFZuj Q==;
X-CSE-ConnectionGUID: 3byVAf9bT8mXaYZ9Njal3Q==
X-CSE-MsgGUID: OV++F0FSSKuhbYpmmiMdDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028131"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028131"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:39 -0800
X-CSE-ConnectionGUID: HeC0BkZGRHeGZ+qWNxw9ng==
X-CSE-MsgGUID: RnIQeoeUSz+zQEP5DN1w3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237714"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:37 -0800
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
Subject: [PATCH v2 08/26] arm: socfpga: Add handoff data support for SoCFPGA
 Agilex5 device
Date: Tue, 18 Feb 2025 16:34:53 +0800
Message-Id: <20250218083511.29249-9-alif.zakuan.yuslaimi@intel.com>
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

Agilex5 supports both HPS handoff data and DDR handoff data.
Existing HPS handoff functions are restructured to support both existing
devices and Agilex5 device.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile                     | 1 +
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 5 +++--
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index edf2356c411..cd9e9272024 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -63,6 +63,7 @@ obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
+obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 endif
 
diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index d839f288411..763b077d8c1 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -17,9 +18,9 @@
 #define SOC64_HANDOFF_MAGIC_FPGA	0x46504741
 #define SOC64_HANDOFF_MAGIC_DELAY	0x444C4159
 #define SOC64_HANDOFF_MAGIC_CLOCK	0x434C4B53
+#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_MAGIC_PERI	0x50455249
-#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
 #else
 #define SOC64_HANDOFF_MAGIC_MISC	0x4D495343
 #endif
@@ -68,7 +69,7 @@
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
-#define SOC64_HANDOFF_SDRAM_LEN		1
+#define SOC64_HANDOFF_SDRAM_LEN		5
 #endif
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index 92051d19b73..7105cdc4905 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -1,15 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
+#include <errno.h>
 #include <asm/arch/handoff_soc64.h>
 #include <asm/io.h>
-#include <errno.h>
 #include "log.h"
 
 #ifndef __ASSEMBLY__
+#include <asm/types.h>
 enum endianness {
 	LITTLE_ENDIAN = 0,
 	BIG_ENDIAN,
@@ -26,7 +28,12 @@ static enum endianness check_endianness(u32 handoff)
 	case SOC64_HANDOFF_MAGIC_FPGA:
 	case SOC64_HANDOFF_MAGIC_DELAY:
 	case SOC64_HANDOFF_MAGIC_CLOCK:
+	case SOC64_HANDOFF_MAGIC_SDRAM:
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	case SOC64_HANDOFF_MAGIC_PERI:
+#else
 	case SOC64_HANDOFF_MAGIC_MISC:
+#endif
 		return BIG_ENDIAN;
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	case SOC64_HANDOFF_DDR_UMCTL2_MAGIC:
-- 
2.25.1

