Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E7DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89099805C3;
	Wed, 26 Feb 2025 17:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PUh6+6MO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D22805C3; Wed, 26 Feb 2025 17:20:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E418121A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586804; x=1772122804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L3gTs/T25J9m6WDM/Z3V7pZqGNdc6QxFZ2yx61B0ToI=;
 b=PUh6+6MOz3NQad7e8ecrk30GR/IQxXOrje29QcoNZ3MBaWcRnJhWEPXT
 +texJge9TBEpKwGWpcLS/shmiRNI3BBHtnLiNJVWn0IVQS2O86/rsrYiB
 2s59W3hOH8mIGG8UM3M7lbEczg4I7w4P5coeCe0nBAnuQdaH4kpL5ooEr
 E4H4aljLcTNImFAp8029Z5K08lclBCQGgKi28Ro/igO3zId4wEob2dq4V
 Ye527raTkioptalq1mCMe3mEKna0cYt+wTZGLuyPfEqqOZK6C9aKDkORN
 R4bT3eqoVrZpoNr3FUfflcg26TEhxW/nac1f/IHCV+Ci9jK1Es36q+BqV g==;
X-CSE-ConnectionGUID: vhmS9+4qTYGL7vWb0AvXNg==
X-CSE-MsgGUID: ZILy9hrkQDyU/JSVvarKAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640198"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:03 -0800
X-CSE-ConnectionGUID: /pqrSi4uSV24B2f3ZvuHHw==
X-CSE-MsgGUID: 7uNI0Md8Qj6bLbaiKUwGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602821"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:58 -0800
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
Subject: [resend v3 14/19] drivers: mtd: nand: base: Add support for Hardware
 ECC for check bad block
Date: Thu, 27 Feb 2025 00:18:28 +0800
Message-Id: <20250226161833.53689-15-dinesh.maniyam@intel.com>
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

Leverage linux code to support hardware ECC interface
to verify nand bad block.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases

v3:
- Remove copyright
---
---
 drivers/mtd/nand/raw/nand_base.c | 69 +++++++++++++++++++++-----------
 include/linux/mtd/rawnand.h      | 11 +++++
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 4401bdcdb9..44cbcb1d60 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -306,6 +306,35 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
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
@@ -315,40 +344,32 @@ void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
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
index 14f93dab0a..147f25b130 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -131,6 +131,17 @@ void nand_wait_ready(struct mtd_info *mtd);
 
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
2.19.0

