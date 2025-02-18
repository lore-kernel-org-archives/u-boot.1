Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CC5C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDD280BAE;
	Tue, 18 Feb 2025 09:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FJjwrhMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D40809A4; Tue, 18 Feb 2025 09:36:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB26380FD6
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867770; x=1771403770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PaE8gafQj7irgV9ArKN7f9RF80Cc73eQsMbjOqdRMzQ=;
 b=FJjwrhMdXnsSSymQtrOF6MCBGVybzo+DXOCV2pYTkxPdoWWEgdBr0wuD
 gAwJ5Xm81ZnbOINLMa4WjNLPfjXCOuIsnfh/cG3fxWlSWUrsL84N1FLCd
 qRmQLZisSy3rJUYIkpIwfZ8x3ckuAR51Zn5FjvCrpsz+HukvSSLT5YE5z
 T3dKaf7tSOO5GdqEGPEJG26rlfKqWUNaazjoHFF0Ns8PH4JlswekHhlbJ
 /MBTF2Uj2vSqfJKTZx4yy+LJ+/OXZS7VE3ppuBaUgmy+NMQ3bSmcjZO2P
 X987rQsQ4Mtfpl3vpnWMFvsLpLnGP6GxjXpunSEEyZkds3D54HGpAkjbZ Q==;
X-CSE-ConnectionGUID: jYattU5FSHqZUSlMM5CI+Q==
X-CSE-MsgGUID: ChVOfHquSVe3oUgvL9YbRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028201"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028201"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:09 -0800
X-CSE-ConnectionGUID: Q9CwJ3lCTMiHzEATh9QVKg==
X-CSE-MsgGUID: gy2aobPWSDmpe187L96WTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237811"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:07 -0800
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
Subject: [PATCH v2 20/26] arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPGA
Date: Tue, 18 Feb 2025 16:35:05 +0800
Message-Id: <20250218083511.29249-21-alif.zakuan.yuslaimi@intel.com>
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

Add SPL support for Agilex5 SoCFPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile      |  3 +
 arch/arm/mach-socfpga/spl_agilex5.c | 89 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index b6897ba42b1..c038882e3c5 100644
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
index 00000000000..c87e9ed1641
--- /dev/null
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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
+	socfpga_get_sys_mgr_addr("sysmgr@10d12000");
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
+
+	/* Enable non secure access to ocram */
+	clrbits_le32(SOCFPGA_OCRAM_FIREWALL_ADDRESS + 0x18, BIT(0));
+}
-- 
2.25.1

