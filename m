Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10265C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D052B811C1;
	Wed, 26 Feb 2025 17:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FQ+qtr9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED5C38004F; Wed, 26 Feb 2025 17:20:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7936780FD8
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586809; x=1772122809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qkfbHla2Gl+pR5l5Fi/xM3dRsvaJ376SILegr4fAYzM=;
 b=FQ+qtr9zgqx7kZZ39Q7JM96e5mOmQbiRrjGNDDDFK9KY4gzm0Pr8RQhi
 NbjkhEL4HZfvw5TUgeMLRG0LATQ+tiM1HINJ7eYd9Cq7LlinF8MwC07tv
 9aqf+tlv7ApkrO/nQc7NKAEqQE+gcGWzrTOsrxpGPSYDuqVvFzfKWdk/B
 eQ0Wu0yzajb+M/FgINcUbUDurewFWe78z0hgB+NG/6NpRwe35x6m/HodS
 aEwoljeR0+zY86I6qJIL9JXf47lEmxnSbminrLNycivN41ivj32JXwiwQ
 7pvtzApB9E4X58omHJnysmBBrXqwpXRFpNv8VxF/jMq+bT2PtiFM8a139 w==;
X-CSE-ConnectionGUID: SGG+8bieQj+QzmBuq1azyg==
X-CSE-MsgGUID: VsSSQZJyRRSmNBu3dE1gtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640222"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640222"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:08 -0800
X-CSE-ConnectionGUID: 66oNNYpUR0a3vlIOobjwsA==
X-CSE-MsgGUID: EJVSM9WERviLmTzLL8nukA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602839"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:20:03 -0800
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
Subject: [resend v3 15/19] drivers: mtd: nand: spl: Add support for nand SPL
 load image
Date: Thu, 27 Feb 2025 00:18:29 +0800
Message-Id: <20250226161833.53689-16-dinesh.maniyam@intel.com>
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

Add support for spl nand to load binary image from NAND
to RAM. Leverage the existing nand_spl_load_image from nand_spl_loaders.c

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
- Leverage the existing nand_spl_load_image from nand_spl_loaders.c
---
---
 drivers/mtd/nand/raw/cadence_spl.c | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c

diff --git a/drivers/mtd/nand/raw/cadence_spl.c b/drivers/mtd/nand/raw/cadence_spl.c
new file mode 100644
index 0000000000..682ce2c512
--- /dev/null
+++ b/drivers/mtd/nand/raw/cadence_spl.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com> 
+ */
+
+#include <cadence-nand.h>
+#include <dm.h>
+#include <hang.h>
+#include <nand.h>
+#include <system-constants.h>
+
+/* Unselect after operation */
+void nand_deselect(void)
+{
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+	chip = mtd_to_nand(mtd);
+
+	if (chip->select_chip)
+		chip->select_chip(mtd, -1);
+}
+
+static int nand_is_bad_block(int block)
+{
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	loff_t ofs = block * CONFIG_SYS_NAND_BLOCK_SIZE;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+	chip = mtd_to_nand(mtd);
+
+	return chip->block_bad(mtd, ofs);
+}
+
+static int nand_read_page(int block, int page, uchar *dst)
+{
+	struct mtd_info *mtd;
+	int page_addr = block * SYS_NAND_BLOCK_PAGES + page;
+	loff_t ofs = page_addr * CONFIG_SYS_NAND_PAGE_SIZE;
+	int ret;
+	size_t len = CONFIG_SYS_NAND_PAGE_SIZE;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	ret = nand_read(mtd, ofs, &len, dst);
+	if (ret)
+		printf("nand_read failed %d\n", ret);
+
+	return ret;
+}
+#include "nand_spl_loaders.c"
-- 
2.19.0

