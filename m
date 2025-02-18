Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88EC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B0980F5C;
	Tue, 18 Feb 2025 09:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Anx/FgYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558E380C98; Tue, 18 Feb 2025 09:35:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9B78043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867726; x=1771403726;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M2yy8kG3ehXRYksFPQ3rpJ82XGTNND5+h9GUIHQaHI0=;
 b=Anx/FgYvcKsZssGxiacIsCryrxBQxrDz5rdHFPzb7KvZvIcj9LxFKFj1
 NynotQLJuyXWzmlx0fCNC1Zv7OyeiescxmxPwFMMLDvmi/1fSlTplecJW
 Rw4O1jHxZsWa0QUkL0OSD0rocGR/o2zIiKHBf+bwiSAWXvfcn12PZdRec
 l6rZPIFIBhf6ED9iQ2iPGtDd10xFxlR2TzvrCdTwerCmMoSTgoBPlZmvw
 DpUTQyyJVHgu3vtWPQshhN/jVWi5DoYFoqRsvgWiHEZgZSuscYE8NxaD2
 AmCIBZEfliM3HdGyWy51eiMJmsyPWaYvHNlVvmdQbHnT3KwSUuSl3e0V2 A==;
X-CSE-ConnectionGUID: MdiAfIyJSYuWRj0rGL5rYA==
X-CSE-MsgGUID: vc28Z1+vSNK/L9hH0W2PHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028097"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028097"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:24 -0800
X-CSE-ConnectionGUID: 4V9K3gGHTK+ryRoMGgDHzA==
X-CSE-MsgGUID: VZCye9r7QuqMtR+qvD0prw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237659"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:22 -0800
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
Subject: [PATCH v2 02/26] arm: socfpga: misc: Exclude Agilex5 from clock
 manager base address retrieval
Date: Tue, 18 Feb 2025 16:34:47 +0800
Message-Id: <20250218083511.29249-3-alif.zakuan.yuslaimi@intel.com>
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

Agilex5 retrieves its clock manager address via probing its own clock
driver model during SPL initialization.

Therefore, excluding Agilex5 from calling generic clock driver in misc
driver.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- probe from DT for Agilex5 clock manager base address
---
 arch/arm/mach-socfpga/misc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 9d464307665..fbe3af845d8 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2012-2025 Altera Corporation <www.altera.com>
  */
 
 #include <config.h>
@@ -248,15 +248,16 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-#ifdef CONFIG_TARGET_SOCFPGA_AGILEX
-	ret = socfpga_get_base_addr("intel,agilex-clkmgr",
-				    &socfpga_clkmgr_base);
-#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
-	ret = socfpga_get_base_addr("intel,n5x-clkmgr",
-				    &socfpga_clkmgr_base);
-#else
-	ret = socfpga_get_base_addr("altr,clk-mgr", &socfpga_clkmgr_base);
-#endif
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX))
+		ret = socfpga_get_base_addr("intel,agilex-clkmgr",
+					    &socfpga_clkmgr_base);
+	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
+		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
+					    &socfpga_clkmgr_base);
+	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
+		ret = socfpga_get_base_addr("altr,clk-mgr",
+					    &socfpga_clkmgr_base);
+
 	if (ret)
 		hang();
 }
-- 
2.25.1

