Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE83C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939D480C8F;
	Tue, 18 Feb 2025 09:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XglLkHm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320D4807F1; Tue, 18 Feb 2025 09:35:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B55280C8F
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867730; x=1771403730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bolMrtd372PtseG+uPyp73/VVDPU11VgYCjxR5WqZtQ=;
 b=XglLkHm89VwDKVWBalDlcquaMOQx6REkyGVNjXYrsUAmPf6sD6KOdJii
 xG2pVJnNlKYMa7EbOvHX7LgtesBSolJeVD29vhDZnOdZRbZ7aeX3lqoEM
 A+0OHOaJDiTpbxOM2M3wLJteGsXzhcWo/hraeOzJvwbX3toNPMGzibGOP
 a0DW9g9tsvvi/zPzR22YJYtfAcOPyYw6fVoA8nO6IPAaVVOUPdmQlQKjp
 vizFtmXrdbT2BKIPQuS6dHpVQyypeNoAZJA+mU0cc0Cnds1LfebVIApvL
 fc48MTsv4JAZulWFxnvphLyI+gX2A+KhsjvZxfazuoXgZ5beKgQddgq9q Q==;
X-CSE-ConnectionGUID: BUeki+jRSiqjoC1jEkOX2g==
X-CSE-MsgGUID: UMuvSQ9RSsWPzJ/+Dr90oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028108"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028108"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:29 -0800
X-CSE-ConnectionGUID: GMs+yO8UStSAoaE4g5tsCA==
X-CSE-MsgGUID: fZJRHZpBR8WaSWQ1Hv53Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237681"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:27 -0800
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
Subject: [PATCH v2 04/26] drivers: clk: agilex5: Replace status polling with
 wait_for_bit_le32()
Date: Tue, 18 Feb 2025 16:34:49 +0800
Message-Id: <20250218083511.29249-5-alif.zakuan.yuslaimi@intel.com>
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

Replace cm_wait_for_fsm() function with wait_for_bit_le32() function
which supports accurate timeout.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/clk/altera/clk-agilex5.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index dfc25ac6787..a284b562486 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -41,21 +41,30 @@ struct socfpga_clk_plat {
  */
 static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 val)
 {
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BUSY,
+			  false, 20000, false);
 }
 
 static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 val)
 {
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BUSY,
+			  false, 20000, false);
 }
 
 /* function to write the ctrl register which requires a poll of the busy bit */
 static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
 {
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+
 	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
-	cm_wait_for_fsm();
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT), CLKMGR_STAT_BUSY,
+			  false, 20000, false);
 }
 
 static const struct {
@@ -243,6 +252,7 @@ static void clk_basic_init(struct udevice *dev,
 {
 	struct socfpga_clk_plat *plat = dev_get_plat(dev);
 	u32 vcocalib;
+	uintptr_t base_addr = (uintptr_t)plat->regs;
 
 	if (!cfg)
 		return;
@@ -254,7 +264,8 @@ static void clk_basic_init(struct udevice *dev,
 		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
 			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
 
-		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+		wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+				  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
 
 		/* Put both PLLs in bypass */
 		clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
@@ -375,7 +386,8 @@ static void clk_basic_init(struct udevice *dev,
 				CLKMGR_PLLCX_EN_SET_MSK,
 				CLKMGR_PERPLL_PLLC3);
 
-		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+		wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+				  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
 
 		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_MAINPLL_LOSTLOCK);
 		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_PERPLL_LOSTLOCK);
-- 
2.25.1

