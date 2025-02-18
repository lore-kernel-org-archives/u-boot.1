Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA26C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16C780F1C;
	Tue, 18 Feb 2025 09:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TsHdqLT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB585807F1; Tue, 18 Feb 2025 09:35:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2446C80EC0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867732; x=1771403732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1QFdQom2g5DyjuzdRn+ZDXfj5EAY4lk7FPTLbIXXBg=;
 b=TsHdqLT+MRbMqYKfuFEPIGwGUzmJ1Voooc+wxjj1PXBrMZ03DlWqi0Ca
 fITBSuNOE93i/dHO4ZjXLgiPVwJo+iHIUBWe0fJ7DEE/K3yR6lt68xwte
 qotq3YPJdtYNcTRwXwM3qhV8mqgdqlMGtk/6zxBm8+X/ArdDgzFfL6CfG
 zkpt2D8VYWmHVvJ/535Y2mzWqpWC8q72UOgCnv8Atg1U3FPt66GPheJ9b
 KhoXQvTkjs64GRbNVRENvTMQqxvWRJAqhfG5O5WAgT+82wHn3YoXoy83L
 vTGNNJqBFokqxpyMIhZWNrVQ16Hxx4pjYS/JQ+kovS7KJ6hwdDcdrNoNN A==;
X-CSE-ConnectionGUID: xjiSDqDaQx+3tH22SyZmgw==
X-CSE-MsgGUID: AwmkYceyTJeH9H60PqZbhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028112"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028112"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:31 -0800
X-CSE-ConnectionGUID: Fq3MSkomTEqqi81qPuhZAw==
X-CSE-MsgGUID: einqPdUpTMCWi4rEPYhw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237691"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:29 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
Subject: [PATCH v2 05/26] drivers: clk: agilex5: Set PLL to asynchronous mode
Date: Tue, 18 Feb 2025 16:34:50 +0800
Message-Id: <20250218083511.29249-6-alif.zakuan.yuslaimi@intel.com>
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

PLL frequency would overshoot from the original target in
synchronous mode during low VCC voltage condition.

To resolve this issue, PLL is set to run on asynchronous mode
instead of enabling synchronous mode in the clock driver.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex5.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index a284b562486..fb1e72ffc5c 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -72,15 +72,6 @@ static const struct {
 	u32 val;
 	u32 mask;
 } membus_pll[] = {
-	{
-		MEMBUS_CLKSLICE_REG,
-		/*
-		 * BIT[7:7]
-		 * Enable source synchronous mode
-		 */
-		BIT(7),
-		BIT(7)
-	},
 	{
 		MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG,
 		/*
-- 
2.25.1

