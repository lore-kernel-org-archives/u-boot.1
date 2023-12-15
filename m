Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E4DC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 07:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930CD878FE;
	Fri, 15 Dec 2023 08:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KHORejey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B02587ADA; Fri, 15 Dec 2023 08:15:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1DF8709C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702624529; x=1734160529;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BCZmaJ05K+85ihGe/Z3zg2FwG7m1grBcw5qPjmAaZ68=;
 b=KHORejeyBOdUl7OmuEpiSF29TLmLWh5Qzy5n8gHlLuxPEymG1uQMeoh6
 JsYOBqHTraJ6XYnxgUgoIwAzpOGZoJzla0XKRf8vMo6GHzCgpFGbiW/Fy
 xi8lDzzZIxOHDKHbQYgFIocvP7TVtiAFcqjjivKubi3lJaUlVJY3tgQba
 XdoE5yzMZGOt0vRr5TCNfOTP7CHcaqaUM6y7g8DB4H5pTkNlKVwuWftfi
 49qruAcTjqiWk0HIR+MetBGTzACJEYyT/YPugmEsoySm63NqialMeepRC
 EPhbp3yjAXqUg2rOy/lthrSvmvZaaDlrvHveINCLUskDEg/iQmklH8kic Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394113512"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; d="scan'208";a="394113512"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 23:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="16188176"
Received: from ppglcf0283.png.intel.com ([10.126.161.129])
 by orviesa002.jf.intel.com with ESMTP; 14 Dec 2023 23:15:22 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH] clk: altera: n5x: Fix MEMCLKMGR_EXTCNTRST_C0CNTRST to bit(0)
Date: Fri, 15 Dec 2023 15:15:19 +0800
Message-Id: <20231215071519.25270-1-dinesh.maniyam@intel.com>
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

MEMCLKMGR_EXTCNTRST_C0CNTRST register defined as BIT[0] in documentation
but it is wrongly defined as BIT[7] in u-boot code. This register is used
to hold associated pingpong counter in reset
while PLL and 5:1 mux configuration is changed.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/clk/altera/clk-mem-n5x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/altera/clk-mem-n5x.h b/drivers/clk/altera/clk-mem-n5x.h
index 7b687012e8..c6bc44bb34 100644
--- a/drivers/clk/altera/clk-mem-n5x.h
+++ b/drivers/clk/altera/clk-mem-n5x.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2020-2023 Intel Corporation <www.intel.com>
  */
 
 #ifndef	_CLK_MEM_N5X_
@@ -77,7 +77,7 @@
 #define MEMCLKMGR_PLLOUTDIV_C0CNT_MASK			GENMASK(4, 0)
 #define MEMCLKMGR_PLLOUTDIV_C0CNT_OFFSET		0
 
-#define MEMCLKMGR_EXTCNTRST_C0CNTRST			BIT(7)
+#define MEMCLKMGR_EXTCNTRST_C0CNTRST			BIT(0)
 #define MEMCLKMGR_EXTCNTRST_ALLCNTRST			\
 	(MEMCLKMGR_EXTCNTRST_C0CNTRST)
 
-- 
2.26.2

