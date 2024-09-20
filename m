Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E6CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AB48937E;
	Fri, 20 Sep 2024 09:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NFTrq/Oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBE28938A; Fri, 20 Sep 2024 09:03:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C623B89335
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815804; x=1758351804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gf4bBmZUGtDXpOrhYeWL7FZzs7pJghG8QD0l6bony/s=;
 b=NFTrq/Oe65Y4Gc0f4gcu0tgbHKhCrsD2/ta1RSj4/HPchpbOLzl4HwOB
 BmQ49r0Rto9E8OyhCUW5RZ3NM9JqbZonNzQ6LwKvRFPmbxMvrDgqmqiuJ
 u16dSjnBYIMKZXfrlN8W7DrPNXEwxmbnX8qIW/ttkCnA48gzrmzZSBjMs
 47eXN1nMqmQfthvyT9S006HS/r511NU4OF0sM6vmkTEhSRqJUj9kT9yyu
 MZc8TSOLh1Bgt7sQyylQZ/wP4qwbQsN0HeWKFiU8W+rGx7H6vjF+zKMyN
 1vYAlWzgPsHUKzPNy2tt1C6L6gCiGqeGUpLAe+wVchD2oIhKxBzEIHt3i w==;
X-CSE-ConnectionGUID: ETMd/TcKScmuAmk2z/u+bQ==
X-CSE-MsgGUID: F7zv8aNpR0W9Ik9Jfn2MlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961037"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:24 -0700
X-CSE-ConnectionGUID: 9D0tFcBjTTKv2fujHQsyKw==
X-CSE-MsgGUID: 5VXm2NqOTWajx6yQ3WDBwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235062"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:21 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 05/20] arm: socfpga: Add handoff data support for SoCFPGA
 Agilex5 device
Date: Fri, 20 Sep 2024 15:02:27 +0800
Message-Id: <20240920070242.20884-6-tien.fong.chee@intel.com>
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

Agilex5 supports both HPS handoff data and DDR handoff data.
Existing HPS handoff functions are restructured to support both existing
devices and Agilex5 device.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/Makefile                     |  1 +
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h |  4 ++--
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 53c91d1d2a5..e0ada69dd5a 100644
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
index d839f288411..918d25a1b61 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -17,9 +17,9 @@
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
@@ -68,7 +68,7 @@
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
-#define SOC64_HANDOFF_SDRAM_LEN		1
+#define SOC64_HANDOFF_SDRAM_LEN		5
 #endif
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index 92051d19b73..c8456c8dd6a 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -1,15 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2020-2024 Intel Corporation <www.intel.com>
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
@@ -26,7 +27,12 @@ static enum endianness check_endianness(u32 handoff)
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

