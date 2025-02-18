Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E803BC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4549F80F67;
	Tue, 18 Feb 2025 09:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dd3ewdBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC3080EC0; Tue, 18 Feb 2025 09:35:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018D980C72
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867727; x=1771403727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=raE4hJNSTTMy96iB/BbP+DfsfeFBOfjoDZCr8sLm+44=;
 b=dd3ewdBqKzJVxSZRHmc4K5EOyW6vhJQr66as444CFcLCO4zHo109uzlm
 pmQE7xpNCFD6UL1JqUqM+xs6ZBRNSUVUNiV+3hWvC0VfgEI24zBKlHUrk
 iau6FjCnzetgT0VAn7IQHLO08rWaazxPGoWO2ByAMj3reztcqavAsG9uW
 +El7XFr7czrn0nlEe/hEJNJaWcooV0jXRk632UInkViw1Vqdot+3eNu6+
 FEfhuecuLOSgrYB6++KNhd0eVQQPZfcYlClzY4kPqzHxTBDLgk7t8r76P
 +1sML++S3GxI7/DkOU4Lh1il6EVmazWOTVJjAwtljHDi04LhE+Qv1ysHJ A==;
X-CSE-ConnectionGUID: kNmWCG+CR6SIFSRR7mBwFA==
X-CSE-MsgGUID: VWYrXAhAQ/qFPzyWRc8uWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028103"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:26 -0800
X-CSE-ConnectionGUID: WFvZwS2CQhu9T37NIkrcLg==
X-CSE-MsgGUID: L3lU5CX4Tv+VJrTWiDw+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237670"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:24 -0800
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
Subject: [PATCH v2 03/26] drivers: clk: agilex5: Configure intosc as boot_clk
 source
Date: Tue, 18 Feb 2025 16:34:48 +0800
Message-Id: <20250218083511.29249-4-alif.zakuan.yuslaimi@intel.com>
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

Some customers prefer to minimize the use of external oscillators,
especially when using the FPGA first configuration mode.

By enabling the configuration of the HPS internal oscillator as
the boot_clk source instead of the default external oscillator,
(HPS_OSC_CLK) in non-secure boot scenarios, this allows them
to eliminate the need for an additional oscillator device and
a dedicated HPS pin, simplifying board layout and routing.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex5.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 716c71598bc..dfc25ac6787 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
-#include <clk-uclass.h>
 #include <config.h>
-#include <errno.h>
-#include <dm.h>
 #include <log.h>
+#include <dm.h>
+#include <errno.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <time.h>
@@ -23,9 +23,14 @@
 #include <linux/types.h>
 #include <asm/arch/clock_manager.h>
 #include <dt-bindings/clock/agilex5-clock.h>
+#include <wait_bit.h>
+#include <clk-uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define CLKMGR_CTRL_SWCTRLBTCLKEN_MASK		BIT(8)
+#define CLKMGR_CTRL_SWCTRLBTCLKSEL_MASK		BIT(9)
+
 struct socfpga_clk_plat {
 	void __iomem *regs;
 };
@@ -264,9 +269,14 @@ static void clk_basic_init(struct udevice *dev,
 			       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
 	} else {
 #ifdef CONFIG_XPL_BUILD
-		/* Always force clock manager into boot mode before any configuration */
-		clk_write_ctrl(plat,
-			       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
+		/*
+		 * Configure HPS Internal Oscillator as default boot_clk source,
+		 * always force clock manager into boot mode before any configuration
+		 */
+		clk_write_ctrl(plat, CM_REG_READL(plat, CLKMGR_CTRL) |
+			       CLKMGR_CTRL_BOOTMODE |
+			       CLKMGR_CTRL_SWCTRLBTCLKEN_MASK |
+			       CLKMGR_CTRL_SWCTRLBTCLKSEL_MASK);
 #else
 		/* Skip clock configuration in SSBL if it's not in boot mode */
 		if (!(CM_REG_READL(plat, CLKMGR_CTRL) & CLKMGR_CTRL_BOOTMODE))
-- 
2.25.1

