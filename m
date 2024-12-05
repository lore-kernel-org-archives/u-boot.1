Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C780E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65DC8949E;
	Thu,  5 Dec 2024 10:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ds14Aywy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C308949D; Thu,  5 Dec 2024 10:24:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5903189411
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390662; x=1764926662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1x/U2o5k7Fvmkdn+00sG9PWE+AgosUm0hEOoHzKdSiw=;
 b=Ds14AywyqPUSC7vwOaieRhiRO4D+qtEigBto1iB96qJeecuN9Zq6wmjD
 DS5DjJEuABiSgjjfKs3+B1zVWqQI4zlA64sQEOU4ncXg2C3rdcay/Fz8i
 Uq3GFnopN9+4S3+g/Pmj+nZtLXg6vgQ8O2QXfXne5Crk5OOKxuXZB+Y29
 zaXhE2cTMIQlNiv/GWq6fpQuMz1iS+pVMmyE77moFrs6Qrun07hI4ad6f
 qz4XwN3GPcxIHNG+TXz68GcTHJLTB+w0Z81lZiOPl8yo6HCRIOJa9z/Ox
 tXFFUyFHblwPB5faM2n9xs4FkJK5Fp1WmwnCzV5Sx65ob0Z+mOQ4DBQKe Q==;
X-CSE-ConnectionGUID: vWFI4Q5nTui5IQYb+OrVeQ==
X-CSE-MsgGUID: c44ayMqlRc2xyQeA5qU/7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610301"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610301"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:22 -0800
X-CSE-ConnectionGUID: i4Y9yZ+WQuyP0EVTZtAHDA==
X-CSE-MsgGUID: CaRIrDb7TIu9VCIzxU75Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121902"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:17 -0800
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
Subject: [resend v2 10/19] drivers: mtd: nand: cadence: Flush & invalidate dma
 descriptor
Date: Thu,  5 Dec 2024 17:23:06 +0800
Message-Id: <20241205092315.25060-11-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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
index 895ee77320..ed93296ba8 100644
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

