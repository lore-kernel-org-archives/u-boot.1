Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F638C25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E792E884A1;
	Fri, 17 May 2024 14:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CTKKxRto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7FA8848F; Fri, 17 May 2024 07:27:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9073588494
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923659; x=1747459659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qfe7pq9KjIaJRdFzC5jT6E0mLDsHp34Vr3aD7zB6Bk4=;
 b=CTKKxRtoYiAXL9+MOXXzqnBGpWArPWHxitbQuvkbRrHh7/VRFThoA4SR
 VmT+1RY4Z+9Lm/WtyE9Gh2VnlORGdQzt+aNZcKWUAxuVtN5/iFPDQIjMn
 YBCJpXItKT3EsTplTg+NURUWrIh1hoOoP5wrrIva3p6Wd58NW1mfbG52S
 8c/6QUqVCoGHzXsDKais/EETkuc/iky0pNCQlBjOdx6Rqp03eSRK8SrPW
 ireJph/raQsA9ZmecuJ9YAdD8/YVB2tIFb1l+uKZepEOZtEL5huQ2Zpdi
 oymvCIXunGxC0XCYM92nNtnHbLAESJLF5+Kh4mHH/hCWHl5tb+THotZoq A==;
X-CSE-ConnectionGUID: SLCOAwCfRsaOSl6EmWLU9A==
X-CSE-MsgGUID: aNL5+hmmT9igiGDAejj+hA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929937"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:39 -0700
X-CSE-ConnectionGUID: mFGCVWNXTbWFTZTNgGxcJQ==
X-CSE-MsgGUID: 2KRzmzQgReCi5NBVoNp35g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188223"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:34 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 02/16] arch: arm:
 mach-socfpga: Add Agilex7 M-series mach-socfgpa enablement
Date: Fri, 17 May 2024 13:26:47 +0800
Message-Id: <20240517052701.12949-3-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add platform related files for new platform Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/mach-socfpga/include/mach/misc.h     |  3 +-
 .../{spl_agilex.c => spl_agilex7m.c}          | 45 ++++++++++++-------
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |  4 ++
 board/intel/agilex7m-socdk/MAINTAINERS        |  7 +++
 board/intel/agilex7m-socdk/socfpga.c          |  4 ++
 5 files changed, 45 insertions(+), 18 deletions(-)
 copy arch/arm/mach-socfpga/{spl_agilex.c => spl_agilex7m.c} (68%)
 create mode 100644 board/intel/agilex7m-socdk/MAINTAINERS
 create mode 100644 board/intel/agilex7m-socdk/socfpga.c

diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index 8460acb00d..e271d2855f 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -40,7 +40,8 @@ void socfpga_sdram_remap_zero(void);
 #endif
 
 #if defined(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
-	defined(CONFIG_TARGET_SOCFPGA_AGILEX)
+	defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	defined(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 int is_fpga_config_ready(void);
 #endif
 
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex7m.c
similarity index 68%
copy from arch/arm/mach-socfpga/spl_agilex.c
copy to arch/arm/mach-socfpga/spl_agilex7m.c
index ee5a9dc1e2..ee41db8884 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex7m.c
@@ -1,26 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 
-#include <init.h>
-#include <log.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/u-boot.h>
-#include <asm/utils.h>
 #include <common.h>
 #include <hang.h>
 #include <image.h>
+#include <init.h>
+#include <log.h>
 #include <spl.h>
+#include <wdt.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/firewall.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <watchdog.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/u-boot.h>
+#include <asm/utils.h>
 #include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -40,13 +39,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -60,11 +52,30 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	preloader_console_init();
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
 		debug("CCU init failed: %d\n", ret);
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index 6aa9bb26b4..8c06b3d59e 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -39,6 +39,10 @@ static enum endianness check_endianness(u32 handoff)
 	case SOC64_HANDOFF_DDR_PHY_INIT_ENGINE_MAGIC:
 		debug("%s: PHY engine handoff data\n", __func__);
 		return LITTLE_ENDIAN;
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+	case SOC64_HANDOFF_MAGIC_DDR:
+		debug("%s: SOC64_HANDOFF_MAGIC_DDR\n", __func__);
+		return BIG_ENDIAN;
 #endif
 	default:
 		debug("%s: Unknown endianness!!\n", __func__);
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
new file mode 100644
index 0000000000..feb2916488
--- /dev/null
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -0,0 +1,7 @@
+SOCFPGA BOARD
+M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Teik Heng Chong <teik.heng.chong@intel.com>
+S:	Maintained
+F:	board/intel/agilex7m-socdk/
+F:	include/configs/socfpga_agilex7m_socdk.h
+F:	configs/socfpga_agilex7m_sdmmc_defconfig
diff --git a/board/intel/agilex7m-socdk/socfpga.c b/board/intel/agilex7m-socdk/socfpga.c
new file mode 100644
index 0000000000..52921d90aa
--- /dev/null
+++ b/board/intel/agilex7m-socdk/socfpga.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
-- 
2.25.1

