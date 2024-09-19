Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C28CE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FCF890CE;
	Thu, 19 Sep 2024 05:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GzGfxKiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839F3890C9; Thu, 19 Sep 2024 05:56:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B7F890C8
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718211; x=1758254211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZUfO4/nmhMKOBeOKiFHyS+ouar/YkE6NuMBeLmBbwI4=;
 b=GzGfxKiFBJq6BZW9DO5H6Mw5Meo7JE8rSv7ynYNWpUPsqRArjJWup0Tr
 rHmflfiozHYAjvJNI3exvG9vvUyZEsyWRmcEqgBbAesuxOawKXJehq+Xw
 HfMen2svJPjSEVRrv1CiDM1y+QLgA6Ie6GnW6CrXk7p4xmQAupejVPTIh
 zirdNGf8vHAhXXHetvsjE+aT/DQcu4qqfZ4LoydU3qB87vSGzaaI8g2mF
 TQ80BTDUaGHawkZOVZ47tKA4UCQF1JKXvR3vMPAtdiY9ASa5u0CGPV7gf
 FHHGSFP2Sqcj+dK8AThbzQ5sbaqHti4yO7xryRi2xspVfVJ0rjlN+TChD Q==;
X-CSE-ConnectionGUID: p0HEZ2pMT0yB4j1go9GFZA==
X-CSE-MsgGUID: tTT174YiSDu4l7oW/1H5kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178119"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178119"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:50 -0700
X-CSE-ConnectionGUID: 2Hdr63QqRz2KcLzu7ZtQlg==
X-CSE-MsgGUID: E6KcLTedRd6KXioUTTyIJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253909"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:45 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 16/19] drivers: mtd: nand: spl: Add support for nand SPL load
 image
Date: Thu, 19 Sep 2024 11:55:09 +0800
Message-Id: <20240919035512.13854-17-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

This patch is add support for spl nand to load binary image from NAND
to RAM.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_spl.c | 96 ++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c

diff --git a/drivers/mtd/nand/raw/cadence_spl.c b/drivers/mtd/nand/raw/cadence_spl.c
new file mode 100644
index 0000000000..841801420d
--- /dev/null
+++ b/drivers/mtd/nand/raw/cadence_spl.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <cadence-nand.h>
+#include <dm.h>
+#include <hang.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <nand.h>
+#include <linux/bitfield.h>
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+	size_t count = len, actual = 0, page_align_overhead = 0;
+	u32 page_align_offset = 0;
+	u8 *page_buffer;
+	int err = 0;
+	struct mtd_info *mtd;
+
+	if (!len || !dst)
+		return -EINVAL;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	if ((offset & (mtd->writesize - 1)) != 0) {
+		page_buffer = malloc_cache_aligned(mtd->writesize);
+		if (!page_buffer) {
+			debug("Error: allocating buffer\n");
+			return -ENOMEM;
+		}
+
+		page_align_overhead = offset % mtd->writesize;
+		page_align_offset = (offset / mtd->writesize) * mtd->writesize;
+		count = mtd->writesize;
+
+		err = nand_read_skip_bad(mtd, page_align_offset, &count,
+					 &actual, mtd->size, page_buffer);
+
+		if (err) {
+			free(page_buffer);
+			return err;
+		}
+
+		count -= page_align_overhead;
+		count = min((size_t)len, count);
+		memcpy(dst, page_buffer + page_align_overhead, count);
+		free(page_buffer);
+
+		len -= count;
+		if (!len)
+			return err;
+
+		offset += count;
+		dst += count;
+		count = len;
+	}
+
+	return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size, dst);
+}
+
+/*
+ * The offset at which the image to be loaded from NAND is located is
+ * retrieved from the itb header. The presence of bad blocks in the area
+ * of the NAND where the itb image is located could invalidate the offset
+ * which must therefore be adjusted taking into account the state of the
+ * sectors concerned
+ */
+u32 nand_spl_adjust_offset(u32 sector, u32 offs)
+{
+	u32 sector_align_offset, sector_align_end_offset;
+	struct mtd_info *mtd;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	sector_align_offset = sector & (~(mtd->erasesize - 1));
+
+	sector_align_end_offset = (sector + offs) & (~(mtd->erasesize - 1));
+
+	while (sector_align_offset <= sector_align_end_offset) {
+		if (nand_block_isbad(mtd, sector_align_offset)) {
+			offs += mtd->erasesize;
+			sector_align_end_offset += mtd->erasesize;
+		}
+		sector_align_offset += mtd->erasesize;
+	}
+
+	return offs;
+}
+
+void nand_deselect(void) {}
-- 
2.26.2

