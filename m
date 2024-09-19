Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D7CCE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333D9890CD;
	Thu, 19 Sep 2024 05:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HA8i9U8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3B1890D8; Thu, 19 Sep 2024 05:56:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFA5890C8
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718205; x=1758254205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9uMwhzPv7D81Ng1O8O20yLT4nP1tkwfVxnTsxLVCIY0=;
 b=HA8i9U8K4xze2YEK/dM46HBPYH2FIX9s3rxZ3jKPTRXWOscnCp3jRK9G
 ISEsUTx9XGypRPKt8aIyBAdQe3gnhPv/UtqdqiQuFt6aiPHFSU+4t23La
 Vd8LaaeKFNc4+7KCMgfV65QhH6XbZJB4MYHfxicGEiJLW2Sb1qiRhtRu9
 KwHnyAXvU0yncZSRD4UCO8n/woSPgmid0hgNnfgLLoKcROllu/E79y0zK
 lbhYQvbzwgGSkr5NKXiUIs6oahAz8UrA7Ai6fQpYrf7/m0/9YsL0dMrkp
 umQMcjmt62CkuvLgY81iE9beVnbyXpXeQCZgYMRjoiS483aysxIBcApAS g==;
X-CSE-ConnectionGUID: f16Cfo7TS0iUoHoa96xOyg==
X-CSE-MsgGUID: J/28KZlbQ+OQUPvppsB8Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178100"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178100"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:45 -0700
X-CSE-ConnectionGUID: eVf5X+E5SYqvfKnd1s1PUQ==
X-CSE-MsgGUID: /ftk1WPQRmSF8mZ+2XvWkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253902"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:40 -0700
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
Subject: [PATCH 15/19] drivers: mtd: nand: base: Add support for Hardware ECC
 for check bad block
Date: Thu, 19 Sep 2024 11:55:08 +0800
Message-Id: <20240919035512.13854-16-dinesh.maniyam@intel.com>
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

This patch is to leverage linux code to support hardware ECC interface
in verify nand bad block.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/nand_base.c | 71 +++++++++++++++++++++-----------
 include/linux/mtd/rawnand.h      | 13 ++++++
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 4401bdcdb9..9b1b2d1f85 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -9,6 +9,8 @@
  *  Copyright (C) 2000 Steven J. Hill (sjhill@realitydiluted.com)
  *		  2002-2006 Thomas Gleixner (tglx@linutronix.de)
  *
+ *  Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
  *  Credits:
  *	David Woodhouse for adding multichip support
  *
@@ -306,6 +308,35 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
 	ioread16_rep(chip->IO_ADDR_R, p, len >> 1);
 }
 
+/*
+ * nand_bbm_get_next_page - Get the next page for bad block markers
+ * @chip: The NAND chip
+ * @page: First page to start checking for bad block marker usage
+ *
+ * Returns an integer that corresponds to the page offset within a block, for
+ * a page that is used to store bad block markers. If no more pages are
+ * available, -EINVAL is returned.
+ */
+int nand_bbm_get_next_page(struct nand_chip *chip, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int last_page = ((mtd->erasesize - mtd->writesize) >>
+			 chip->page_shift) & chip->pagemask;
+	unsigned int bbm_flags = NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE
+		| NAND_BBM_LASTPAGE;
+
+	if (page == 0 && !(chip->options & bbm_flags))
+		return 0;
+	if (page == 0 && chip->options & NAND_BBM_FIRSTPAGE)
+		return 0;
+	if (page <= 1 && chip->options & NAND_BBM_SECONDPAGE)
+		return 1;
+	if (page <= last_page && chip->options & NAND_BBM_LASTPAGE)
+		return last_page;
+
+	return -EINVAL;
+}
+
 /**
  * nand_block_bad - [DEFAULT] Read bad block marker from the chip
  * @mtd: MTD device structure
@@ -315,40 +346,32 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
  */
 static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
 {
-	int page, res = 0, i = 0;
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	u16 bad;
+	int first_page, page_offset;
+	int res;
+	u8 bad;
 
-	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
-		ofs += mtd->erasesize - mtd->writesize;
+	first_page = (int)(ofs >> chip->page_shift) & chip->pagemask;
+	page_offset = nand_bbm_get_next_page(chip, 0);
 
-	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
+	while (page_offset >= 0) {
+		res = chip->ecc.read_oob(mtd, chip, first_page + page_offset);
+		if (res < 0)
+			return res;
 
-	do {
-		if (chip->options & NAND_BUSWIDTH_16) {
-			chip->cmdfunc(mtd, NAND_CMD_READOOB,
-					chip->badblockpos & 0xFE, page);
-			bad = cpu_to_le16(chip->read_word(mtd));
-			if (chip->badblockpos & 0x1)
-				bad >>= 8;
-			else
-				bad &= 0xFF;
-		} else {
-			chip->cmdfunc(mtd, NAND_CMD_READOOB, chip->badblockpos,
-					page);
-			bad = chip->read_byte(mtd);
-		}
+		bad = chip->oob_poi[chip->badblockpos];
 
 		if (likely(chip->badblockbits == 8))
 			res = bad != 0xFF;
 		else
 			res = hweight8(bad) < chip->badblockbits;
-		ofs += mtd->writesize;
-		page = (int)(ofs >> chip->page_shift) & chip->pagemask;
-		i++;
-	} while (!res && i < 2 && (chip->bbt_options & NAND_BBT_SCAN2NDPAGE));
+		if (res)
+			return res;
 
-	return res;
+		page_offset = nand_bbm_get_next_page(chip, page_offset + 1);
+	}
+
+	return 0;
 }
 
 /**
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 537c62424a..49444e9353 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -4,6 +4,8 @@
  *                        Steven J. Hill <sjhill@realitydiluted.com>
  *		          Thomas Gleixner <tglx@linutronix.de>
  *
+ *  Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
  * Info:
  *	Contains standard defines and IDs for NAND flash devices
  *
@@ -131,6 +133,17 @@ void nand_wait_ready(struct mtd_info *mtd);
 
 #define NAND_DATA_IFACE_CHECK_ONLY	-1
 
+/*
+ * There are different places where the manufacturer stores the factory bad
+ * block markers.
+ *
+ * Position within the block: Each of these pages needs to be checked for a
+ * bad block marking pattern.
+ */
+#define NAND_BBM_FIRSTPAGE	BIT(24)
+#define NAND_BBM_SECONDPAGE	BIT(25)
+#define NAND_BBM_LASTPAGE	BIT(26)
+
 /*
  * Constants for ECC_MODES
  */
-- 
2.26.2

