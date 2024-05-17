Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC35CC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383BC884F5;
	Fri, 17 May 2024 14:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fJiaYNIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F7B88491; Fri, 17 May 2024 07:28:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E702988375
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923703; x=1747459703;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n170DUcryQJOUhYuTbKAbIRh6rTGWNV0JhZ1RjIUAq8=;
 b=fJiaYNIg4ZefvWcOqE4jtFuRSoeUN9fmAFPP01gkq+Gn8c1RR/kyzFgE
 Tjcj05uoTwkF74HzIOBEmgogJ4fEBOwJtuX+nFy6AnwKxlH1u8D4TQMwx
 WwitsBvEKd/ZCNLeetorvAN3VUlExRNn2GFGRMnpQedRKpZw9Rmg8ea9H
 N95JMAFh/cJNGO8/p9QNVfzpaVt5cysPh73DyEsSMA669VevoF0coBKlj
 LSJz1+B/6kShAEtgtFE8wMMp8C4WUm7jesHtNnh10PryhCbxLp3UI3Gdu
 ogFE9Nok5fChQKVa3xizXBzK94G/ZC2tghhy+dseje9BlIfpXYbls/dVR g==;
X-CSE-ConnectionGUID: zpVnsxAWTWKGL8p73FiHIg==
X-CSE-MsgGUID: qIWiox0RT+SdBkWv+BiaLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930025"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:22 -0700
X-CSE-ConnectionGUID: XTtCZatySXWtrUYYAX2Svw==
X-CSE-MsgGUID: zVkVIo9PT1aX1TpjJTqJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188346"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:17 -0700
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
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 12/16] ddr: altera: soc64:
 Clean up bit-shift by zero bit
Date: Fri, 17 May 2024 13:26:57 +0800
Message-Id: <20240517052701.12949-13-tingting.meng@intel.com>
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

From: Teik Heng Chong <teik.heng.chong@intel.com>

Clean up bit-shift by zero bit

Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 drivers/ddr/altera/sdram_soc64.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 02019ac9e5..add7df01a5 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -92,7 +92,7 @@ struct altera_sdram_plat {
 #define NIOSRESERVED2			0x118
 
 #define DRAMADDRW_CFG_COL_ADDR_WIDTH(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1F)
 #define DRAMADDRW_CFG_ROW_ADDR_WIDTH(x)			\
 	(((x) >> 5) & 0x1F)
 #define DRAMADDRW_CFG_BANK_ADDR_WIDTH(x)		\
@@ -103,7 +103,7 @@ struct altera_sdram_plat {
 	(((x) >> 16) & 0x7)
 
 #define CTRLCFG0_CFG_MEMTYPE(x)				\
-	(((x) >> 0) & 0xF)
+	((x) & 0xF)
 #define CTRLCFG0_CFG_DIMM_TYPE(x)			\
 	(((x) >> 4) & 0x7)
 #define CTRLCFG0_CFG_AC_POS(x)				\
@@ -112,17 +112,17 @@ struct altera_sdram_plat {
 	(((x) >> 9) & 0x1F)
 
 #define CTRLCFG1_CFG_DBC3_BURST_LEN(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1F)
 #define CTRLCFG1_CFG_ADDR_ORDER(x)			\
 	(((x) >> 5) & 0x3)
 #define CTRLCFG1_CFG_CTRL_EN_ECC(x)			\
 	(((x) >> 7) & 0x1)
 
 #define DRAMTIMING0_CFG_TCL(x)				\
-	(((x) >> 0) & 0x7F)
+	((x) & 0x7F)
 
 #define CALTIMING0_CFG_ACT_TO_RDWR(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING0_CFG_ACT_TO_PCH(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING0_CFG_ACT_TO_ACT(x)			\
@@ -131,7 +131,7 @@ struct altera_sdram_plat {
 	(((x) >> 18) & 0x3F)
 
 #define CALTIMING1_CFG_RD_TO_RD(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING1_CFG_RD_TO_RD_DC(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING1_CFG_RD_TO_RD_DB(x)			\
@@ -142,7 +142,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING2_CFG_RD_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING2_CFG_RD_TO_WR_PCH(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING2_CFG_RD_AP_TO_VALID(x)		\
@@ -153,7 +153,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING3_CFG_WR_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING3_CFG_WR_TO_RD(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING3_CFG_WR_TO_RD_DC(x)			\
@@ -164,7 +164,7 @@ struct altera_sdram_plat {
 	(((x) >> 24) & 0x3F)
 
 #define CALTIMING4_CFG_WR_AP_TO_VALID(x)		\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING4_CFG_PCH_TO_VALID(x)			\
 	(((x) >> 6) & 0x3F)
 #define CALTIMING4_CFG_PCH_ALL_TO_VALID(x)		\
@@ -175,7 +175,7 @@ struct altera_sdram_plat {
 	(((x) >> 26) & 0x3F)
 
 #define CALTIMING9_CFG_4_ACT_TO_ACT(x)			\
-	(((x) >> 0) & 0xFF)
+	((x) & 0xFF)
 
 /* Firewall DDR scheduler MPFE */
 #define FW_HMC_ADAPTOR_REG_ADDR			0xf8020004
-- 
2.25.1

