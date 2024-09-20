Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D93CF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DA4893AA;
	Fri, 20 Sep 2024 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hBy3ZGUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 917BB893BC; Fri, 20 Sep 2024 09:03:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5CE893AF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815831; x=1758351831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gbTNxq/e/3C95nv+t97Jz6oOwVstC6Z957uFjYiFKgU=;
 b=hBy3ZGUSSjsGZVgTi/nnzFk9Rr1/XssNKQokZtEtneJvRNETpdDxh17j
 uEmoMw41sa1lr/GR3QCo2ndvxjVJdYxTG+aRPk+NljToZ8YXRzbzIN1aa
 rcCBAa4Q1B1+LW1nMJ3vuw8oZpQ20Sz33neT3+orlY/TQclvaIVdkLsM+
 XtyqmIVO/U/prfUA2BNGfHFTjbl/ICONU8zhpW7RjXVx01hI8FedhfxWy
 cc/b8g20p6iLofNy6w/XwoNIV4QrZUp9L7Lp1YFruJbjdkhwQAth17bGh
 hkMJY1M5kjhudzhMY89jmLDFG2oUeFQTAXgI/oLsV/kodgRODi0LAbKfE A==;
X-CSE-ConnectionGUID: sATIuIoPQTKX5T6rtBncYw==
X-CSE-MsgGUID: BDbbeQ6CTZmgdFmW60YJIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961112"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961112"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:50 -0700
X-CSE-ConnectionGUID: u2bwT2R/QiOb33a5FhB74g==
X-CSE-MsgGUID: PsOiZFnDQwWMwOwpNysG1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235272"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:48 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 17/20] arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPGA
Date: Fri, 20 Sep 2024 15:02:39 +0800
Message-Id: <20240920070242.20884-18-tien.fong.chee@intel.com>
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

Add SPL support for Agilex5 SoCFPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/Makefile      |  3 ++
 arch/arm/mach-socfpga/spl_agilex5.c | 84 +++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 32b3e7a57e2..3fbe3d4fa63 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -66,6 +66,8 @@ obj-y	+= reset_manager_s10.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 obj-y	+= ccu_ncore3.o
+obj-y	+= system_manager_soc64.o
+obj-y	+= timer_s10.o
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_N5X
@@ -109,6 +111,7 @@ obj-y	+= spl_n5x.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
 obj-y	+= spl_soc64.o
+obj-y	+= spl_agilex5.o
 endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
new file mode 100644
index 00000000000..2852112f788
--- /dev/null
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <hang.h>
+#include <spl.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/arch/clock_manager.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/misc.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/system_manager.h>
+#include <wdt.h>
+#include <dm/uclass.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = spl_early_init();
+	if (ret)
+		hang();
+
+	socfpga_get_managers_addr();
+
+	sysmgr_pinmux_init();
+
+	/* Ensure watchdog is paused when debugging is happening */
+	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
+	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
+
+	timer_init();
+
+	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
+	if (ret) {
+		debug("Clock init failed: %d\n", ret);
+		hang();
+	}
+
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
+	preloader_console_init();
+	print_reset_info();
+	cm_print_clock_quick_summary();
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-ccu-config", &dev);
+	if (ret) {
+		printf("HPS CCU settings init failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-firewall-config", &dev);
+	if (ret) {
+		printf("HPS firewall settings init failed: %d\n", ret);
+		hang();
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_ALTERA_SDRAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			debug("DRAM init failed: %d\n", ret);
+			hang();
+		}
+	}
+
+	mbox_init();
+
+	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
+		mbox_qspi_open();
+}
-- 
2.25.1

