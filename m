Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80742E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD19A8949D;
	Thu,  5 Dec 2024 10:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qa3+R9cN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91EE88EF7; Thu,  5 Dec 2024 10:24:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9F589499
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390693; x=1764926693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qkfbHla2Gl+pR5l5Fi/xM3dRsvaJ376SILegr4fAYzM=;
 b=Qa3+R9cNc11WdRMMaWPBE1o9+ew1In+ZFhSkZNnma1Ujzl5UirqSl6U3
 /gb3AHsICi1EJ62vaekDISv9+fz6nfxBKxkIVG2lrVN/Stxv4+/y9U1pA
 TAlav1zR8FdASckPvN2s7OyjQK1fbVang0kVNUxcDPijvqeMviOaTnla5
 zVd1SORURIArpS3ht+2PN6vWFtA2W+s7ceOyB1FRpmbwcGVpL7bAnkV9k
 LoNaqbxDnn0+8sWeClaZNDXK9QxsM4+N5XZjNRSAA+lj3w8rpiMf+ILB0
 NOH2rnhobKe6G4sEQrgzofqlh2+9w04MHQV/2bqZxPnvM0DlYAGq+9106 Q==;
X-CSE-ConnectionGUID: Y7kFf1esSn6vzScQt/9D7Q==
X-CSE-MsgGUID: cBO11k8dRtGO41P/W2Jf3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610391"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:52 -0800
X-CSE-ConnectionGUID: Y/qw7FWBTP+0YczJSRJ8/Q==
X-CSE-MsgGUID: DLodAnIpS8CVVw9YHup6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122080"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:48 -0800
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
Subject: [resend v2 16/19] drivers: mtd: nand: spl: Add support for nand SPL
 load image
Date: Thu,  5 Dec 2024 17:23:12 +0800
Message-Id: <20241205092315.25060-17-dinesh.maniyam@intel.com>
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

