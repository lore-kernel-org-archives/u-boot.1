Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9AC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121A980FBD;
	Tue, 18 Feb 2025 09:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gASW5rl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE3F80FBC; Tue, 18 Feb 2025 09:35:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD47580F9E
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867757; x=1771403757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mkRbIsh2IpRc1Em6VuI71c4YLgVS1KrtGj5HukK/gKk=;
 b=gASW5rl2RZAqTkO7ofjZFbQ7qaPVXodgEG+rUrof+3J6F6GVkFFDjHlF
 4znd9E41R0B/hJIjb0WQqCkWlCxt0LCHiH6RIpA/XXz2xK4oc8IrB9w3/
 rEOqUxDixuxvj8PxNieyii7xasMch92uP42wa1OsroFo6fR1BihE89oK8
 2m1JqmqM6K2Bb4dO2NsW9APuCmRLRnmxOTBpKOILtaht6j9EQLztP5VW+
 3W2LCBaOpGBbOqdQR19K8KP+c1snv5pCfP0bC9DJamoOkG7OIS8qXPMYo
 QL5b/rtQ+7coQWF+vGThOgEdD5Xg+kUVw3EMdhnTnzWG/dhjiQkSYPFja w==;
X-CSE-ConnectionGUID: 29a3W9nRQuWebnqWg9vxLw==
X-CSE-MsgGUID: jS3NmOAEQVayrqgKNEOAeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028169"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:56 -0800
X-CSE-ConnectionGUID: i/y6GE7dTkKWP7vTCXRXLw==
X-CSE-MsgGUID: L0106qczRDWvywW54f4XOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237756"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:54 -0800
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
Subject: [PATCH v2 15/26] arm: socfpga: agilex5: Update CPU info
Date: Tue, 18 Feb 2025 16:35:00 +0800
Message-Id: <20250218083511.29249-16-alif.zakuan.yuslaimi@intel.com>
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

Update the print info per Agilex5

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- Simplify printout logic writing
---
 arch/arm/mach-socfpga/misc_soc64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index a6cc78454da..573a8f79cae 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -45,7 +46,8 @@ static Altera_desc altera_fpga[] = {
 #if defined(CONFIG_DISPLAY_CPUINFO)
 int print_cpuinfo(void)
 {
-	puts("CPU:   Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)\n");
+	printf("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
+	       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" : "A53");
 
 	return 0;
 }
-- 
2.25.1

