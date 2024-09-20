Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E0CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F528936B;
	Fri, 20 Sep 2024 09:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Miqp+JY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FC589348; Fri, 20 Sep 2024 09:03:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AB489343
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815798; x=1758351798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=opiSx0UvN3+41iap+8UAIyN3kgExvzrMuL2Ib/uA2T4=;
 b=Miqp+JY5+D8ihSnPLVgYMGcffu9jAENpNaXcbTK8cFBvr1NrAVvgsr/2
 2HjkIlfiomY/TVYkdimZuBzF7AQoQ9ZNx4BMgSbn5lTnTQfvZ11tSbXZ+
 2o9efNATSreii3rXvYymbnZ4o6PjgMj3s4typHMNBWi9tvfkrVoIcER3L
 VSybCJBtN6dUGDXd3aL27UAaApGIlpGBGZ1CFmvXmKYSbDBY1ig22Behn
 IU7pV4wVnYvdXaSdylA2cGpU1BW13nuDT5kH/aLddDFtVTc4x9EIvfz6i
 TK87gg0WJNGliLuMe9Ci+u5QEx6o2/nhBFuCzr+rzu7wj318/w+6zgeSX Q==;
X-CSE-ConnectionGUID: NGoPsydWQQizAaqsTPMtOg==
X-CSE-MsgGUID: ljiE51OaRa6T89JIiQXGiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961026"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:17 -0700
X-CSE-ConnectionGUID: fW2HxW5TScOElIF1rXoRWw==
X-CSE-MsgGUID: 8S029NoCSWir72JO9NXsdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235023"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:15 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 02/20] arm: socfpga: Add support for agilex5 clock manager
Date: Fri, 20 Sep 2024 15:02:24 +0800
Message-Id: <20240920070242.20884-3-tien.fong.chee@intel.com>
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

Adding mechanism to retrieve base address for Agilex5 Clock Mananger.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/misc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 495ba2a0d41..6cf2ee60038 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2012-2024 Altera Corporation <www.altera.com>
  */
 
 #include <config.h>
@@ -252,15 +252,19 @@ void socfpga_get_managers_addr(void)
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
+	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
+		ret = socfpga_get_base_addr("intel,agilex5-clkmgr",
+					    &socfpga_clkmgr_base);
+	else
+		ret = socfpga_get_base_addr("altr,clk-mgr",
+					    &socfpga_clkmgr_base);
+
 	if (ret)
 		hang();
 }
-- 
2.25.1

