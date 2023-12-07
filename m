Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A7C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 07:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4E686D2B;
	Thu,  7 Dec 2023 08:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mv+SNFzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0B087150; Thu,  7 Dec 2023 08:46:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB4B86D2B
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 08:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701935184; x=1733471184;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ORnRAGrYzykSBIPm2QpWEIe4v/7W0VgVRFh1hr0leLY=;
 b=mv+SNFzMY9E8gE7OVaR2JpWKx6vhRlJBjPYtb7u9gor7LXUYt+UuiH6N
 hkzoRD/gYL8mdHTahO4MJTyH35n8IIy9Eq6Wn9f959e6wCFOFN8Ub7gFq
 Yt9oao1xAaCGnmsw0bQ+/WsEvhVny1kHPc+LhfQ34T9AqJ7wKJW+QCmyS
 Ki60HfhYqN+2ocoUWd8YrOduViJ4ovzuC5hiuB7/mZUVSc5lJvb5v4J5a
 a7uG6pM3eH5L9RJ0h4YF8AKbCwco4/PTCHOamKRysrEbsHC38F/pCKU2f
 UwgJMfBC53PrMZ+K6Do/WM++sxVe3Nwl4eF3Sxg7wQi3+WQ0ozcxFzMrs w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7501454"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7501454"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 23:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="862391764"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="862391764"
Received: from ppglcf0283.png.intel.com ([10.126.161.129])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2023 23:46:17 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH] arm: socfpga: stratix10: SPI clock support
Date: Thu,  7 Dec 2023 15:46:02 +0800
Message-Id: <20231207074602.15254-1-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patch is to add SPI clock support for stratix10. Get clock rate
function always returning 0 because the DW-SPI driver get the rate
from clock node in dts but Stratix10 does not support device tree
clock node.To overcome this spi will get the clock_rate directly
from spi clock controller override the weaker function.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 arch/arm/mach-socfpga/clock_manager_s10.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index 4b4f0749db..45300336d5 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
  *
  */
 
@@ -399,6 +399,21 @@ unsigned int cm_get_l4_sys_free_clk_hz(void)
 	return cm_get_l3_main_clk_hz() / 4;
 }
 
+/*
+ * Override weak dw_spi_get_clk implementation in designware_spi.c driver
+ */
+
+int dw_spi_get_clk(struct udevice *bus, ulong *rate)
+{
+	*rate = cm_get_spi_controller_clk_hz();
+	if (!*rate) {
+		printf("SPI: clock rate is zero");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void cm_print_clock_quick_summary(void)
 {
 	printf("MPU         %d kHz\n", (u32)(cm_get_mpu_clk_hz() / 1000));
-- 
2.26.2

