Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F87E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CB789187;
	Thu,  5 Dec 2024 10:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gvVAUYUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985438878A; Thu,  5 Dec 2024 10:24:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5438C88E50
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390688; x=1764926688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZx80rVoyEEEzFZFsGLiXY6f3B2V/hL7slOSGD3CSRU=;
 b=gvVAUYUPNeLKw5EBmuCnSd9W5C4h16e5WhkZEpq/BdJ2W4Cgq6NykXgy
 O/SGDSGP3VFYdTXp5oRWQSf8D6IZqrspBac4FEP9exQWIbCicrWOVEesm
 8u2W7Kk3YaVv5PuCICtmRpuTeFC33ToxOahqrwO0LYjQTcyvfzqa2eB4T
 QwOiOdwSdRNDz+K+oSblQrDkH6B8B+acwvzxK3YOmlu5wcjFUrWTWD7Jh
 oFfAQ1McyGX0eJcVwaPIkVn9VP6hGGOYPq3APxHqmizhfBXdao8yIfs1P
 AkdozzosDfh+a8F+7MZoUp9HkhhAT0pUUw91vhQYyGL0mpEEp+yhVIm+q A==;
X-CSE-ConnectionGUID: Q1SZg83ARvaxTvkSB18ong==
X-CSE-MsgGUID: 7tr56DXmQeC9SgPBH5/ORQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610377"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:48 -0800
X-CSE-ConnectionGUID: 67OeiC90RnOZ4X8YhtPJqw==
X-CSE-MsgGUID: n/i75yMlQDqPCM1AKFV5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122038"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:43 -0800
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
Subject: [resend v2 15/19] drivers: mtd: nand: base: Add support for Hardware
 ECC for check bad block
Date: Thu,  5 Dec 2024 17:23:11 +0800
Message-Id: <20241205092315.25060-16-dinesh.maniyam@intel.com>
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

Leverage linux code to support hardware ECC interface
to verify nand bad block.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
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
index 14f93dab0a..35eb3b5678 100644
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
2.19.0

