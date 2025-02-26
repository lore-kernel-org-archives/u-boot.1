Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBCFC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED7E810F1;
	Wed, 26 Feb 2025 17:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zv8fQeXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9030981119; Wed, 26 Feb 2025 17:19:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2093D8004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586777; x=1772122777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TtwT7IBxxPr0e588FzlGp3C0+PxPs2FWiedVnwS42wY=;
 b=Zv8fQeXLXtX6vghOJEmUSLnjpkfG0ET9PwubVvpdj9uKBxld79H/bOom
 Z6qWi4mC2q2gM6rgFtGZ2zBzbextt5j6pngCS/QVt4I5IZvDZK3gxgAWL
 0aAtShNEcug4YROEaWxS1ElkT9ie3xHsZ4+cPSXH2V/K8tUmJubp2Fcre
 1g6qrbcx+pnM7/6ir1qSTZpoRlMQ9JhRuxSRc+RGIHuEKiHzqgJWIihAD
 HGE8r9lH2Z37uBG0LR6FE/WFNZ+p9eX9MQi4j7KiQ+XZS+SaCYblJqmuQ
 JJ+1fGrqRerpg9ouhNF1y1zxeGWx2EbA91cgg9rUjx06rfWO0nRu2VJ3h g==;
X-CSE-ConnectionGUID: c2iA1hwzR1aJkB9yZeDkoA==
X-CSE-MsgGUID: k1PmyUv4Q66277JUh4/wxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640108"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640108"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:37 -0800
X-CSE-ConnectionGUID: W0jIoVIZSBam2c8KCjygKg==
X-CSE-MsgGUID: co+yf5KfReqwuOoddOdpfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602765"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:32 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v3 09/19] drivers: mtd: nand: cadence: Flush & invalidate dma
 descriptor
Date: Thu, 27 Feb 2025 00:18:23 +0800
Message-Id: <20250226161833.53689-10-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

Ensure ddr memory is updated with the data from dcache.
This would help to ensure cdma always reading the latest dma descriptor
from ddr memory.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
- add support for invalidate cache
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 71bab97377..a717987be6 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -430,6 +430,10 @@ cadence_nand_cdma_desc_prepare(struct cadence_nand_info *cadence,
 
 	cdma_desc->command_type = ctype;
 	cdma_desc->ctrl_data_ptr = ctrl_data_ptr;
+
+	flush_cache((dma_addr_t)cadence->cdma_desc,
+		    ROUND(sizeof(struct cadence_nand_cdma_desc),
+			  ARCH_DMA_MINALIGN));
 }
 
 static u8 cadence_nand_check_desc_error(struct cadence_nand_info *cadence,
@@ -457,6 +461,11 @@ static int cadence_nand_cdma_finish(struct cadence_nand_info *cadence)
 	struct cadence_nand_cdma_desc *desc_ptr = cadence->cdma_desc;
 	u8 status = STAT_BUSY;
 
+	invalidate_dcache_range((dma_addr_t)cadence->cdma_desc,
+				(dma_addr_t)cadence->cdma_desc +
+				ROUND(sizeof(struct cadence_nand_cdma_desc),
+				      ARCH_DMA_MINALIGN));
+
 	if (desc_ptr->status & CDMA_CS_FAIL) {
 		status = cadence_nand_check_desc_error(cadence,
 						       desc_ptr->status);
-- 
2.19.0

