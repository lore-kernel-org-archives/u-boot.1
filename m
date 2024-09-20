Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D8BCF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68AA48937F;
	Fri, 20 Sep 2024 09:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P+fcHT/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369CC8937D; Fri, 20 Sep 2024 09:03:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A349F89376
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815802; x=1758351802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qj+U5BQj6yA04kHSFQib2wiFK6B/20WHcmnIdSGVbiw=;
 b=P+fcHT/apO3JNT8m62DlgNCZoESXwHkthIbMB2Tvmds3GnSJHi3EVp2s
 P3pJxnNT3b9pRWWU7xPNhVyBxdgkZmXkrH74n7kpGJCZBKyWyYaJ+ZO7p
 yH2KyQmRKhqiMZxxgAlxOUFgOOFOq3YrV5MObAP3KQRv81mCnFxz8Kxhd
 iGhhwwGae0l9FFyX7LORry/aQKkP2WCWsxazxMwy9ASI841rSBArpBSmm
 JoqDendxOS6dHfnutMYWmgHGxUm4GQdADRTnVDuyMwpb4B6e2OH/4x6DG
 4RE72NcAVgcqwDTwS4nOw+2AibOgcyDLoXvzMIN+RQWuv+mN1k3Bz9bBJ g==;
X-CSE-ConnectionGUID: UZwGAd/6R9SD9Rg40MCQHw==
X-CSE-MsgGUID: F/UvmlZ5SH+Rdzd/aLj7Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961034"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:22 -0700
X-CSE-ConnectionGUID: De53QyphQxGCjdYd5qwB4w==
X-CSE-MsgGUID: L8ghjm57TrG8heFBZ0ThAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235051"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:19 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level initialization
Date: Fri, 20 Sep 2024 15:02:26 +0800
Message-Id: <20240920070242.20884-5-tien.fong.chee@intel.com>
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

Create new low level initialization for Agile5 due to the new ARM core
composition and warm reset behavior.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/Makefile                |  1 +
 .../include/mach/reset_manager_soc64.h        | 12 +++-
 arch/arm/mach-socfpga/lowlevel_init_agilex5.S | 57 +++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/lowlevel_init_agilex5.S

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 67c6a8dfec5..53c91d1d2a5 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -58,6 +58,7 @@ endif
 
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
 obj-y	+= clock_manager_agilex5.o
+obj-y	+= lowlevel_init_agilex5.o
 obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
index c8bb727aa2b..d373ec0dc70 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
@@ -1,15 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- *  Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
+ *  Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef _RESET_MANAGER_SOC64_H_
 #define _RESET_MANAGER_SOC64_H_
 
+#ifndef __ASSEMBLY__
 void reset_deassert_peripherals_handoff(void);
 int cpu_has_been_warmreset(void);
 void print_reset_info(void);
 void socfpga_bridges_reset(int enable);
+#endif
 
 #define RSTMGR_SOC64_STATUS	0x00
 #define RSTMGR_SOC64_MPUMODRST	0x20
@@ -23,14 +25,20 @@ void socfpga_bridges_reset(int enable);
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
diff --git a/arch/arm/mach-socfpga/lowlevel_init_agilex5.S b/arch/arm/mach-socfpga/lowlevel_init_agilex5.S
new file mode 100644
index 00000000000..27430577719
--- /dev/null
+++ b/arch/arm/mach-socfpga/lowlevel_init_agilex5.S
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation. All rights reserved
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <asm/arch/reset_manager_soc64.h>
+#include <asm/macro.h>
+#include <linux/linkage.h>
+
+ENTRY(lowlevel_init)
+	mov	x29, lr			/* Save LR */
+
+	/* Enable Async */
+	msr daifclr, #4
+
+#ifdef CONFIG_SPL_BUILD
+	branch_if_slave x0, 3f
+
+	/* Check rstmgr.stat for warm reset status */
+	ldr	w1, =SOCFPGA_RSTMGR_ADDRESS
+	ldr	w0, [x1]
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	ldr	x2, =RSTMGR_L4WD_MPU_WARMRESET_MASK
+	ands	x0, x0, x2
+	/*
+	 * If current Reset Manager's status is warm reset just reload the
+	 * .data section by copying the data from data preserve section.
+	 * Otherwise, copy the .data section to the data preserve section to
+	 * keep an original copy of .data section. This ensure SPL is
+	 * reentrant after warm reset.
+	 */
+	b.ne	reload_data_section
+	/* Copy from .data to preserved .data to backup the SPL state */
+	ldr	x0, =__data_start
+	ldr	x1, =__preserve_data_start
+	ldr	x2, =__preserve_data_end
+	b	copy_loop
+reload_data_section:
+	/* Copy from preserved .data to .data to restore the SPL state */
+	ldr	x0, =__preserve_data_start
+	ldr	x1, =__data_start
+	ldr	x2, =__data_end
+copy_loop:
+	ldr	w3, [x0]
+	add	x0, x0, #4
+	str	w3, [x1]
+	add	x1, x1, #4
+	cmp	x1, x2
+	b.ne	copy_loop
+3:
+#endif
+
+	mov	lr, x29			/* Restore LR */
+	ret
+ENDPROC(lowlevel_init)
-- 
2.25.1

