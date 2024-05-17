Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D3FC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F43884EF;
	Fri, 17 May 2024 14:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E/iNMTSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1698848D; Fri, 17 May 2024 07:28:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A1C88491
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923698; x=1747459698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4I6aHa6iTtX6YZWhfI/ZRCDxmkvsE4O5SMTH7bJcElI=;
 b=E/iNMTSt1lySsz+xJa3cF5h3tQ+nBz+oN36tBbD6ms0jekbFmd+jN0Id
 gRMQMpNmrx2+lXMbodlj5Xgvz37YMNgsM7cfmcuC5l+KvCSfR/Rkz0gbi
 awUo1LPuBzy1yb1UOfXInIHgRQHNzQPpydqAc7+KbBPCjeJ3uW6yRCCvx
 g1gbeg+bzzsGnPFlVOznUMRpMpfQSa9JivhRyZtxKO8lUQDKuK1WZl/uC
 TYPFfnmYkiXDvJ0MWhIFlD0g0BQBmWSeZS7lLxUeE7XnIdJ0ttwNj+nGU
 YKeWlCafUJKzl729xVoTQlEuG9dNF37pILqk6LtV38bdVZbJ3YkezfNsN A==;
X-CSE-ConnectionGUID: 1lNg+/MiSy2PsWBQ7g6ZRw==
X-CSE-MsgGUID: EOu1nBwMRsKzO0A+A0o8Jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930017"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:18 -0700
X-CSE-ConnectionGUID: qlUz+P93RkuMFTmE6wriYQ==
X-CSE-MsgGUID: GdoKGLg1S4OCaTQyPipY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188322"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:13 -0700
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
 Sin Hui Kho <sin.hui.kho@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 11/16] ddr: altera: soc64:
 Restructure SDRAM firewall function
Date: Fri, 17 May 2024 13:26:56 +0800
Message-Id: <20240517052701.12949-12-tingting.meng@intel.com>
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

From: Sin Hui Kho <sin.hui.kho@intel.com>

Restructure SDRAM firewall function. Move the non-F2SDRAM firewall
configuration to an individual function, in preparation to support
F2SDRAM firewall configuration.

Signed-off-by: Sin Hui Kho <sin.hui.kho@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 drivers/ddr/altera/sdram_soc64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index a0cc9be25e..8f2085f3a0 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -253,7 +253,7 @@ phys_size_t sdram_calculate_size(struct altera_sdram_plat *plat)
 	return size;
 }
 
-void sdram_set_firewall(struct bd_info *bd)
+static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
 {
 	u32 i;
 	phys_size_t value;
@@ -289,7 +289,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_BASEEXT +
 				      (i * 4 * sizeof(u32)));
 
-		/* Setting non-secure MPU limit and limit extexded */
+		/* Setting non-secure MPU limit and limit extended */
 		value = bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
 
 		lower = lower_32_bits(value);
@@ -302,7 +302,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT +
 				      (i * 4 * sizeof(u32)));
 
-		/* Setting non-secure Non-MPU limit and limit extexded */
+		/* Setting non-secure Non-MPU limit and limit extended */
 		FW_MPU_DDR_SCR_WRITEL(lower,
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT +
 				      (i * 4 * sizeof(u32)));
@@ -315,6 +315,11 @@ void sdram_set_firewall(struct bd_info *bd)
 	}
 }
 
+void sdram_set_firewall(struct bd_info *bd)
+{
+	sdram_set_firewall_non_f2sdram(bd);
+}
+
 static int altera_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_sdram_plat *plat = dev_get_plat(dev);
-- 
2.25.1

