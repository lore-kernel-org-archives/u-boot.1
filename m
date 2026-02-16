Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9400E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A349783CB9;
	Mon, 16 Feb 2026 22:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2E583C67; Mon, 16 Feb 2026 22:22:05 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8425083AA9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs62K-000000002d2-1XXb; Mon, 16 Feb 2026 21:21:44 +0000
Date: Mon, 16 Feb 2026 21:21:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 03/20] mtd: add mtd_read_skip_bad() helper
Message-ID: <861a2d0ad1519879d8e2bfcd67ebec605e31f7a1.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:22:55 +0100
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

Add a generic mtd_read_skip_bad() helper to the MTD core that reads
data from an MTD device while transparently skipping bad erase blocks
on NAND.

The function takes a physical byte offset, reads in erase-block-sized
chunks, and automatically skips any block where mtd_block_isbad()
returns true. Non-block-aligned start offsets are handled correctly.
For NOR and other device types without bad-block support, it falls
through to a plain mtd_read().

Refactor the plain-data read path in cmd/mtd.c ("mtd read", without
.raw or .oob suffixes) to use the new helper instead of open-coding
the bad-block skip loop. The write path and OOB/raw read paths
retain their existing page-at-a-time mtd_read_oob() loop.

This helper will also be used by the image_loader MTD backend in a
subsequent patch. It could also serve as a replacement for
nand_read_skip_bad() in drivers/mtd/nand/raw/nand_util.c in the
future.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/mtd.c               | 65 +++++++++++++++++++++++------------------
 drivers/mtd/mtdcore.c   | 45 ++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h | 24 +++++++++++++++
 3 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f25144098b..30e4845b26d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -551,12 +551,6 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		printf("%s %lld byte(s) at offset 0x%08llx\n",
 		       read ? "Reading" : "Writing", len, start_off);
 
-	io_op.mode = raw ? MTD_OPS_RAW : MTD_OPS_AUTO_OOB;
-	io_op.len = has_pages ? mtd->writesize : len;
-	io_op.ooblen = woob ? mtd->oobsize : 0;
-	io_op.datbuf = buf;
-	io_op.oobbuf = woob ? &buf[len] : NULL;
-
 	/* Search for the first good block after the given offset */
 	off = start_off;
 	while (mtd_block_isbad(mtd, off))
@@ -567,31 +561,46 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (benchmark)
 		bench_start = timer_get_us();
 
-	/* Loop over the pages to do the actual read/write */
-	while (remaining) {
-		/* Skip the block if it is bad */
-		if (mtd_is_aligned_with_block_size(mtd, off) &&
-		    mtd_block_isbad(mtd, off)) {
-			off += mtd->erasesize;
-			continue;
-		}
+	if (read && !raw && !woob) {
+		/* Plain data read — use the skip-bad-block helper */
+		size_t rdlen;
 
-		if (read)
-			ret = mtd_read_oob(mtd, off, &io_op);
-		else
-			ret = mtd_special_write_oob(mtd, off, &io_op,
-						    write_empty_pages, woob);
+		ret = mtd_read_skip_bad(mtd, off, remaining, &rdlen, buf);
+		remaining -= rdlen;
+	} else {
+		io_op.mode = raw ? MTD_OPS_RAW : MTD_OPS_AUTO_OOB;
+		io_op.len = has_pages ? mtd->writesize : len;
+		io_op.ooblen = woob ? mtd->oobsize : 0;
+		io_op.datbuf = buf;
+		io_op.oobbuf = woob ? &buf[len] : NULL;
+
+		/* Loop over the pages to do the actual read/write */
+		while (remaining) {
+			/* Skip the block if it is bad */
+			if (mtd_is_aligned_with_block_size(mtd, off) &&
+			    mtd_block_isbad(mtd, off)) {
+				off += mtd->erasesize;
+				continue;
+			}
 
-		if (ret) {
-			printf("Failure while %s at offset 0x%llx\n",
-			       read ? "reading" : "writing", off);
-			break;
-		}
+			if (read)
+				ret = mtd_read_oob(mtd, off, &io_op);
+			else
+				ret = mtd_special_write_oob(mtd, off, &io_op,
+							    write_empty_pages,
+							    woob);
+
+			if (ret) {
+				printf("Failure while %s at offset 0x%llx\n",
+				       read ? "reading" : "writing", off);
+				break;
+			}
 
-		off += io_op.retlen;
-		remaining -= io_op.retlen;
-		io_op.datbuf += io_op.retlen;
-		io_op.oobbuf += io_op.oobretlen;
+			off += io_op.retlen;
+			remaining -= io_op.retlen;
+			io_op.datbuf += io_op.retlen;
+			io_op.oobbuf += io_op.oobretlen;
+		}
 	}
 
 	if (benchmark && bench_start) {
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3bfa5aebbc6..eb36743af1f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1684,6 +1684,51 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 }
 EXPORT_SYMBOL_GPL(mtd_block_markbad);
 
+int mtd_read_skip_bad(struct mtd_info *mtd, loff_t from, size_t len,
+		      size_t *retlen, u_char *buf)
+{
+	size_t remaining = len;
+	u_char *p = buf;
+	int ret;
+
+	*retlen = 0;
+
+	if (!mtd_can_have_bb(mtd)) {
+		ret = mtd_read(mtd, from, len, retlen, buf);
+		if (ret == -EUCLEAN)
+			ret = 0;
+		return ret;
+	}
+
+	while (remaining) {
+		loff_t block_start = from & ~(loff_t)(mtd->erasesize - 1);
+		size_t block_off = from - block_start;
+		size_t chunk, rdlen;
+
+		if (from >= mtd->size)
+			return -EINVAL;
+
+		if (mtd_block_isbad(mtd, block_start)) {
+			/* Skip to start of next erase block */
+			from = block_start + mtd->erasesize;
+			continue;
+		}
+
+		chunk = min(remaining, (size_t)mtd->erasesize - block_off);
+
+		ret = mtd_read(mtd, from, chunk, &rdlen, p);
+		if (ret && ret != -EUCLEAN)
+			return ret;
+
+		p += rdlen;
+		from += rdlen;
+		remaining -= rdlen;
+		*retlen += rdlen;
+	}
+
+	return 0;
+}
+
 #ifndef __UBOOT__
 /*
  * default_mtd_writev - the default writev method
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 1f97bc4fe11..ea3fa513c58 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -471,6 +471,30 @@ int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
 
+/**
+ * mtd_read_skip_bad() - Read from an MTD device, skipping bad blocks
+ *
+ * Read @len bytes starting at physical offset @from into @buf. On NAND
+ * devices, erase blocks that are marked bad are transparently skipped
+ * so the caller always receives a contiguous stream of good data.
+ *
+ * If @from is not erase-block-aligned, reading starts at the correct
+ * position within the first good block.
+ *
+ * For NOR and other device types without bad-block support, this is
+ * equivalent to a plain mtd_read().
+ *
+ * @mtd:	MTD device
+ * @from:	Start offset (physical, byte address)
+ * @len:	Number of bytes to read
+ * @retlen:	Actual number of bytes read (output)
+ * @buf:	Destination buffer
+ * Return: 0 on success, negative errno on failure. -EUCLEAN is
+ *	   treated as success (ECC corrected).
+ */
+int mtd_read_skip_bad(struct mtd_info *mtd, loff_t from, size_t len,
+		      size_t *retlen, u_char *buf);
+
 #ifndef __UBOOT__
 static inline int mtd_suspend(struct mtd_info *mtd)
 {
-- 
2.53.0
