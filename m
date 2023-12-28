Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA96C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A982687AD9;
	Thu, 28 Dec 2023 16:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="aylhxlqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA0C87AA4; Thu, 28 Dec 2023 16:39:37 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57A287AB6
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 365A110003B;
 Thu, 28 Dec 2023 18:39:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 365A110003B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777973;
 bh=G1cy7ILkTIxV6Fpb2oF9IP+W04BIObpaGXEDSxmlrSM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=aylhxlqmjFfEPSp/FOkCoClatHN9OP/ciZPuXZgZcuR7G8/0BC8BB2E0kzW+yjyCv
 sKWX0Ip7wRupCokJkomG7ZhvzkuVg2es9dTUEl4mJblLzVK9oujoDeV6h0bZ0cENhV
 10kVHvWFfpc9ey8c8eLCuArQc4UOTkOc3rLj4OwGGjGraSyMKNPZBsIHV/srpXVQQy
 CYKkDNxXvNdlyAVbAKFGZkABUXE9jHs/8N4urmXjDQhgoj5tWxNmUZIc1wvvlWt7MV
 1tFIUSiHiuurlx9ZPwCILmB3+Nd3RXSH/VVEdhEHohQNWdEDb5aioMeaWlTSVZt3qr
 CV8QfFR1F+Zcg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:32 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:32 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 03/12] nand: move nand_util.c to NAND core folder
Date: Thu, 28 Dec 2023 18:39:06 +0300
Message-ID: <20231228153922.84323-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228153922.84323-1-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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

This is right place for this API. Now, fastboot code uses this
API: these functions should be available regardless of the
selected NAND type (RAW / SPI).

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/nand/Makefile        |   2 +-
 drivers/mtd/nand/raw/nand_util.c | 511 -----------------------------
 drivers/mtd/nand/util.c          | 543 +++++++++++++++++++++++++++++++
 3 files changed, 544 insertions(+), 512 deletions(-)
 create mode 100644 drivers/mtd/nand/util.c

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a..301b1bceff 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
-nandcore-objs := core.o bbt.o
+nandcore-objs := core.o bbt.o util.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand_util.c
index 72cc24f403..9c18ce63b9 100644
--- a/drivers/mtd/nand/raw/nand_util.c
+++ b/drivers/mtd/nand/raw/nand_util.c
@@ -35,7 +35,6 @@
 #include <jffs2/jffs2.h>
 
 typedef struct erase_info	erase_info_t;
-typedef struct mtd_info		mtd_info_t;
 
 /* support only for native endian JFFS2 */
 #define cpu_to_je16(x) (x)
@@ -395,513 +394,3 @@ int nand_unlock(struct mtd_info *mtd, loff_t start, size_t length,
 	return ret;
 }
 #endif
-
-/**
- * check_skip_len
- *
- * Check if there are any bad blocks, and whether length including bad
- * blocks fits into device
- *
- * @param mtd nand mtd instance
- * @param offset offset in flash
- * @param length image length
- * @param used length of flash needed for the requested length
- * Return: 0 if the image fits and there are no bad blocks
- *         1 if the image fits, but there are bad blocks
- *        -1 if the image does not fit
- */
-static int check_skip_len(struct mtd_info *mtd, loff_t offset, size_t length,
-			  size_t *used)
-{
-	size_t len_excl_bad = 0;
-	int ret = 0;
-
-	while (len_excl_bad < length) {
-		size_t block_len, block_off;
-		loff_t block_start;
-
-		if (offset >= mtd->size)
-			return -1;
-
-		block_start = offset & ~(loff_t)(mtd->erasesize - 1);
-		block_off = offset & (mtd->erasesize - 1);
-		block_len = mtd->erasesize - block_off;
-
-		if (!nand_block_isbad(mtd, block_start))
-			len_excl_bad += block_len;
-		else
-			ret = 1;
-
-		offset += block_len;
-		*used += block_len;
-	}
-
-	/* If the length is not a multiple of block_len, adjust. */
-	if (len_excl_bad > length)
-		*used -= (len_excl_bad - length);
-
-	return ret;
-}
-
-#ifdef CONFIG_CMD_NAND_TRIMFFS
-static size_t drop_ffs(const struct mtd_info *mtd, const u_char *buf,
-			const size_t *len)
-{
-	size_t l = *len;
-	ssize_t i;
-
-	for (i = l - 1; i >= 0; i--)
-		if (buf[i] != 0xFF)
-			break;
-
-	/* The resulting length must be aligned to the minimum flash I/O size */
-	l = i + 1;
-	l = (l + mtd->writesize - 1) / mtd->writesize;
-	l *=  mtd->writesize;
-
-	/*
-	 * since the input length may be unaligned, prevent access past the end
-	 * of the buffer
-	 */
-	return min(l, *len);
-}
-#endif
-
-/**
- * nand_verify_page_oob:
- *
- * Verify a page of NAND flash, including the OOB.
- * Reads page of NAND and verifies the contents and OOB against the
- * values in ops.
- *
- * @param mtd		nand mtd instance
- * @param ops		MTD operations, including data to verify
- * @param ofs		offset in flash
- * Return:		0 in case of success
- */
-int nand_verify_page_oob(struct mtd_info *mtd, struct mtd_oob_ops *ops,
-			 loff_t ofs)
-{
-	int rval;
-	struct mtd_oob_ops vops;
-	size_t verlen = mtd->writesize + mtd->oobsize;
-
-	memcpy(&vops, ops, sizeof(vops));
-
-	vops.datbuf = memalign(ARCH_DMA_MINALIGN, verlen);
-
-	if (!vops.datbuf)
-		return -ENOMEM;
-
-	vops.oobbuf = vops.datbuf + mtd->writesize;
-
-	rval = mtd_read_oob(mtd, ofs, &vops);
-	if (!rval)
-		rval = memcmp(ops->datbuf, vops.datbuf, vops.len);
-	if (!rval)
-		rval = memcmp(ops->oobbuf, vops.oobbuf, vops.ooblen);
-
-	free(vops.datbuf);
-
-	return rval ? -EIO : 0;
-}
-
-/**
- * nand_verify:
- *
- * Verify a region of NAND flash.
- * Reads NAND in page-sized chunks and verifies the contents against
- * the contents of a buffer.  The offset into the NAND must be
- * page-aligned, and the function doesn't handle skipping bad blocks.
- *
- * @param mtd		nand mtd instance
- * @param ofs		offset in flash
- * @param len		buffer length
- * @param buf		buffer to read from
- * Return:		0 in case of success
- */
-int nand_verify(struct mtd_info *mtd, loff_t ofs, size_t len, u_char *buf)
-{
-	int rval = 0;
-	size_t verofs;
-	size_t verlen = mtd->writesize;
-	uint8_t *verbuf = memalign(ARCH_DMA_MINALIGN, verlen);
-
-	if (!verbuf)
-		return -ENOMEM;
-
-	/* Read the NAND back in page-size groups to limit malloc size */
-	for (verofs = ofs; verofs < ofs + len;
-	     verofs += verlen, buf += verlen) {
-		verlen = min(mtd->writesize, (uint32_t)(ofs + len - verofs));
-		rval = nand_read(mtd, verofs, &verlen, verbuf);
-		if (!rval || (rval == -EUCLEAN))
-			rval = memcmp(buf, verbuf, verlen);
-
-		if (rval)
-			break;
-	}
-
-	free(verbuf);
-
-	return rval ? -EIO : 0;
-}
-
-/**
- * nand_write_skip_bad:
- *
- * Write image to NAND flash.
- * Blocks that are marked bad are skipped and the is written to the next
- * block instead as long as the image is short enough to fit even after
- * skipping the bad blocks.  Due to bad blocks we may not be able to
- * perform the requested write.  In the case where the write would
- * extend beyond the end of the NAND device, both length and actual (if
- * not NULL) are set to 0.  In the case where the write would extend
- * beyond the limit we are passed, length is set to 0 and actual is set
- * to the required length.
- *
- * @param mtd		nand mtd instance
- * @param offset	offset in flash
- * @param length	buffer length
- * @param actual	set to size required to write length worth of
- *			buffer or 0 on error, if not NULL
- * @param lim		maximum size that actual may be in order to not
- *			exceed the buffer
- * @param buffer        buffer to read from
- * @param flags		flags modifying the behaviour of the write to NAND
- * Return:		0 in case of success
- */
-int nand_write_skip_bad(struct mtd_info *mtd, loff_t offset, size_t *length,
-			size_t *actual, loff_t lim, u_char *buffer, int flags)
-{
-	int rval = 0, blocksize;
-	size_t left_to_write = *length;
-	size_t used_for_write = 0;
-	u_char *p_buffer = buffer;
-	int need_skip;
-
-	if (actual)
-		*actual = 0;
-
-	blocksize = mtd->erasesize;
-
-	/*
-	 * nand_write() handles unaligned, partial page writes.
-	 *
-	 * We allow length to be unaligned, for convenience in
-	 * using the $filesize variable.
-	 *
-	 * However, starting at an unaligned offset makes the
-	 * semantics of bad block skipping ambiguous (really,
-	 * you should only start a block skipping access at a
-	 * partition boundary).  So don't try to handle that.
-	 */
-	if ((offset & (mtd->writesize - 1)) != 0) {
-		printf("Attempt to write non page-aligned data\n");
-		*length = 0;
-		return -EINVAL;
-	}
-
-	need_skip = check_skip_len(mtd, offset, *length, &used_for_write);
-
-	if (actual)
-		*actual = used_for_write;
-
-	if (need_skip < 0) {
-		printf("Attempt to write outside the flash area\n");
-		*length = 0;
-		return -EINVAL;
-	}
-
-	if (used_for_write > lim) {
-		puts("Size of write exceeds partition or device limit\n");
-		*length = 0;
-		return -EFBIG;
-	}
-
-	if (!need_skip && !(flags & WITH_DROP_FFS)) {
-		rval = nand_write(mtd, offset, length, buffer);
-
-		if ((flags & WITH_WR_VERIFY) && !rval)
-			rval = nand_verify(mtd, offset, *length, buffer);
-
-		if (rval == 0)
-			return 0;
-
-		*length = 0;
-		printf("NAND write to offset %llx failed %d\n",
-			offset, rval);
-		return rval;
-	}
-
-	while (left_to_write > 0) {
-		loff_t block_start = offset & ~(loff_t)(mtd->erasesize - 1);
-		size_t block_offset = offset & (mtd->erasesize - 1);
-		size_t write_size, truncated_write_size;
-
-		schedule();
-
-		if (nand_block_isbad(mtd, block_start)) {
-			printf("Skip bad block 0x%08llx\n", block_start);
-			offset += mtd->erasesize - block_offset;
-			continue;
-		}
-
-		if (left_to_write < (blocksize - block_offset))
-			write_size = left_to_write;
-		else
-			write_size = blocksize - block_offset;
-
-		truncated_write_size = write_size;
-#ifdef CONFIG_CMD_NAND_TRIMFFS
-		if (flags & WITH_DROP_FFS)
-			truncated_write_size = drop_ffs(mtd, p_buffer,
-					&write_size);
-#endif
-
-		rval = nand_write(mtd, offset, &truncated_write_size,
-				p_buffer);
-
-		if ((flags & WITH_WR_VERIFY) && !rval)
-			rval = nand_verify(mtd, offset,
-				truncated_write_size, p_buffer);
-
-		offset += write_size;
-		p_buffer += write_size;
-
-		if (rval != 0) {
-			printf("NAND write to offset %llx failed %d\n",
-				offset, rval);
-			*length -= left_to_write;
-			return rval;
-		}
-
-		left_to_write -= write_size;
-	}
-
-	return 0;
-}
-
-/**
- * nand_read_skip_bad:
- *
- * Read image from NAND flash.
- * Blocks that are marked bad are skipped and the next block is read
- * instead as long as the image is short enough to fit even after
- * skipping the bad blocks.  Due to bad blocks we may not be able to
- * perform the requested read.  In the case where the read would extend
- * beyond the end of the NAND device, both length and actual (if not
- * NULL) are set to 0.  In the case where the read would extend beyond
- * the limit we are passed, length is set to 0 and actual is set to the
- * required length.
- *
- * @param mtd nand mtd instance
- * @param offset offset in flash
- * @param length buffer length, on return holds number of read bytes
- * @param actual set to size required to read length worth of buffer or 0
- * on error, if not NULL
- * @param lim maximum size that actual may be in order to not exceed the
- * buffer
- * @param buffer buffer to write to
- * Return: 0 in case of success
- */
-int nand_read_skip_bad(struct mtd_info *mtd, loff_t offset, size_t *length,
-		       size_t *actual, loff_t lim, u_char *buffer)
-{
-	int rval;
-	size_t left_to_read = *length;
-	size_t used_for_read = 0;
-	u_char *p_buffer = buffer;
-	int need_skip;
-
-	if ((offset & (mtd->writesize - 1)) != 0) {
-		printf("Attempt to read non page-aligned data\n");
-		*length = 0;
-		if (actual)
-			*actual = 0;
-		return -EINVAL;
-	}
-
-	need_skip = check_skip_len(mtd, offset, *length, &used_for_read);
-
-	if (actual)
-		*actual = used_for_read;
-
-	if (need_skip < 0) {
-		printf("Attempt to read outside the flash area\n");
-		*length = 0;
-		return -EINVAL;
-	}
-
-	if (used_for_read > lim) {
-		puts("Size of read exceeds partition or device limit\n");
-		*length = 0;
-		return -EFBIG;
-	}
-
-	if (!need_skip) {
-		rval = nand_read(mtd, offset, length, buffer);
-		if (!rval || rval == -EUCLEAN)
-			return 0;
-
-		*length = 0;
-		printf("NAND read from offset %llx failed %d\n",
-			offset, rval);
-		return rval;
-	}
-
-	while (left_to_read > 0) {
-		size_t block_offset = offset & (mtd->erasesize - 1);
-		size_t read_length;
-
-		schedule();
-
-		if (nand_block_isbad(mtd, offset & ~(mtd->erasesize - 1))) {
-			printf("Skipping bad block 0x%08llx\n",
-				offset & ~(mtd->erasesize - 1));
-			offset += mtd->erasesize - block_offset;
-			continue;
-		}
-
-		if (left_to_read < (mtd->erasesize - block_offset))
-			read_length = left_to_read;
-		else
-			read_length = mtd->erasesize - block_offset;
-
-		rval = nand_read(mtd, offset, &read_length, p_buffer);
-		if (rval && rval != -EUCLEAN) {
-			printf("NAND read from offset %llx failed %d\n",
-				offset, rval);
-			*length -= left_to_read;
-			return rval;
-		}
-
-		left_to_read -= read_length;
-		offset       += read_length;
-		p_buffer     += read_length;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_CMD_NAND_TORTURE
-
-/**
- * check_pattern:
- *
- * Check if buffer contains only a certain byte pattern.
- *
- * @param buf buffer to check
- * @param patt the pattern to check
- * @param size buffer size in bytes
- * Return: 1 if there are only patt bytes in buf
- *         0 if something else was found
- */
-static int check_pattern(const u_char *buf, u_char patt, int size)
-{
-	int i;
-
-	for (i = 0; i < size; i++)
-		if (buf[i] != patt)
-			return 0;
-	return 1;
-}
-
-/**
- * nand_torture:
- *
- * Torture a block of NAND flash.
- * This is useful to determine if a block that caused a write error is still
- * good or should be marked as bad.
- *
- * @param mtd nand mtd instance
- * @param offset offset in flash
- * Return: 0 if the block is still good
- */
-int nand_torture(struct mtd_info *mtd, loff_t offset)
-{
-	u_char patterns[] = {0xa5, 0x5a, 0x00};
-	struct erase_info instr = {
-		.mtd = mtd,
-		.addr = offset,
-		.len = mtd->erasesize,
-	};
-	size_t retlen;
-	int err, ret = -1, i, patt_count;
-	u_char *buf;
-
-	if ((offset & (mtd->erasesize - 1)) != 0) {
-		puts("Attempt to torture a block at a non block-aligned offset\n");
-		return -EINVAL;
-	}
-
-	if (offset + mtd->erasesize > mtd->size) {
-		puts("Attempt to torture a block outside the flash area\n");
-		return -EINVAL;
-	}
-
-	patt_count = ARRAY_SIZE(patterns);
-
-	buf = malloc_cache_aligned(mtd->erasesize);
-	if (buf == NULL) {
-		puts("Out of memory for erase block buffer\n");
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < patt_count; i++) {
-		err = mtd_erase(mtd, &instr);
-		if (err) {
-			printf("%s: erase() failed for block at 0x%llx: %d\n",
-				mtd->name, instr.addr, err);
-			goto out;
-		}
-
-		/* Make sure the block contains only 0xff bytes */
-		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
-		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
-			printf("%s: read() failed for block at 0x%llx: %d\n",
-				mtd->name, instr.addr, err);
-			goto out;
-		}
-
-		err = check_pattern(buf, 0xff, mtd->erasesize);
-		if (!err) {
-			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
-				offset);
-			ret = -EIO;
-			goto out;
-		}
-
-		/* Write a pattern and check it */
-		memset(buf, patterns[i], mtd->erasesize);
-		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
-		if (err || retlen != mtd->erasesize) {
-			printf("%s: write() failed for block at 0x%llx: %d\n",
-				mtd->name, instr.addr, err);
-			goto out;
-		}
-
-		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
-		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
-			printf("%s: read() failed for block at 0x%llx: %d\n",
-				mtd->name, instr.addr, err);
-			goto out;
-		}
-
-		err = check_pattern(buf, patterns[i], mtd->erasesize);
-		if (!err) {
-			printf("Pattern 0x%.2x checking failed for block at "
-					"0x%llx\n", patterns[i], offset);
-			ret = -EIO;
-			goto out;
-		}
-	}
-
-	ret = 0;
-
-out:
-	free(buf);
-	return ret;
-}
-
-#endif
diff --git a/drivers/mtd/nand/util.c b/drivers/mtd/nand/util.c
new file mode 100644
index 0000000000..4a372bb67d
--- /dev/null
+++ b/drivers/mtd/nand/util.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * drivers/mtd/nand/util.c
+ *
+ * Copyright (C) 2006 by Weiss-Electronic GmbH.
+ * All rights reserved.
+ *
+ * @author:	Guido Classen <clagix@gmail.com>
+ * @descr:	NAND Flash support
+ * @references: borrowed heavily from Linux mtd-utils code:
+ *		flash_eraseall.c by Arcom Control System Ltd
+ *		nandwrite.c by Steven J. Hill (sjhill@realitydiluted.com)
+ *			       and Thomas Gleixner (tglx@linutronix.de)
+ *
+ * Copyright (C) 2008 Nokia Corporation: drop_ffs() function by
+ * Artem Bityutskiy <dedekind1@gmail.com> from mtd-utils
+ *
+ * Copyright 2010 Freescale Semiconductor
+ */
+
+#include <common.h>
+#include <command.h>
+#include <log.h>
+#include <watchdog.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <div64.h>
+#include <asm/cache.h>
+#include <dm/devres.h>
+
+#include <linux/errno.h>
+#include <linux/mtd/mtd.h>
+#include <nand.h>
+
+/**
+ * check_skip_len
+ *
+ * Check if there are any bad blocks, and whether length including bad
+ * blocks fits into device
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * @param length image length
+ * @param used length of flash needed for the requested length
+ * Return: 0 if the image fits and there are no bad blocks
+ *         1 if the image fits, but there are bad blocks
+ *        -1 if the image does not fit
+ */
+static int check_skip_len(struct mtd_info *mtd, loff_t offset, size_t length,
+			  size_t *used)
+{
+	size_t len_excl_bad = 0;
+	int ret = 0;
+
+	while (len_excl_bad < length) {
+		size_t block_len, block_off;
+		loff_t block_start;
+
+		if (offset >= mtd->size)
+			return -1;
+
+		block_start = offset & ~(loff_t)(mtd->erasesize - 1);
+		block_off = offset & (mtd->erasesize - 1);
+		block_len = mtd->erasesize - block_off;
+
+		if (!nand_block_isbad(mtd, block_start))
+			len_excl_bad += block_len;
+		else
+			ret = 1;
+
+		offset += block_len;
+		*used += block_len;
+	}
+
+	/* If the length is not a multiple of block_len, adjust. */
+	if (len_excl_bad > length)
+		*used -= (len_excl_bad - length);
+
+	return ret;
+}
+
+#ifdef CONFIG_CMD_NAND_TRIMFFS
+static size_t drop_ffs(const struct mtd_info *mtd, const u_char *buf,
+			const size_t *len)
+{
+	size_t l = *len;
+	ssize_t i;
+
+	for (i = l - 1; i >= 0; i--)
+		if (buf[i] != 0xFF)
+			break;
+
+	/* The resulting length must be aligned to the minimum flash I/O size */
+	l = i + 1;
+	l = (l + mtd->writesize - 1) / mtd->writesize;
+	l *=  mtd->writesize;
+
+	/*
+	 * since the input length may be unaligned, prevent access past the end
+	 * of the buffer
+	 */
+	return min(l, *len);
+}
+#endif
+
+/**
+ * nand_verify_page_oob:
+ *
+ * Verify a page of NAND flash, including the OOB.
+ * Reads page of NAND and verifies the contents and OOB against the
+ * values in ops.
+ *
+ * @param mtd		nand mtd instance
+ * @param ops		MTD operations, including data to verify
+ * @param ofs		offset in flash
+ * Return:		0 in case of success
+ */
+int nand_verify_page_oob(struct mtd_info *mtd, struct mtd_oob_ops *ops,
+			 loff_t ofs)
+{
+	int rval;
+	struct mtd_oob_ops vops;
+	size_t verlen = mtd->writesize + mtd->oobsize;
+
+	memcpy(&vops, ops, sizeof(vops));
+
+	vops.datbuf = memalign(ARCH_DMA_MINALIGN, verlen);
+
+	if (!vops.datbuf)
+		return -ENOMEM;
+
+	vops.oobbuf = vops.datbuf + mtd->writesize;
+
+	rval = mtd_read_oob(mtd, ofs, &vops);
+	if (!rval)
+		rval = memcmp(ops->datbuf, vops.datbuf, vops.len);
+	if (!rval)
+		rval = memcmp(ops->oobbuf, vops.oobbuf, vops.ooblen);
+
+	free(vops.datbuf);
+
+	return rval ? -EIO : 0;
+}
+
+/**
+ * nand_verify:
+ *
+ * Verify a region of NAND flash.
+ * Reads NAND in page-sized chunks and verifies the contents against
+ * the contents of a buffer.  The offset into the NAND must be
+ * page-aligned, and the function doesn't handle skipping bad blocks.
+ *
+ * @param mtd		nand mtd instance
+ * @param ofs		offset in flash
+ * @param len		buffer length
+ * @param buf		buffer to read from
+ * Return:		0 in case of success
+ */
+int nand_verify(struct mtd_info *mtd, loff_t ofs, size_t len, u_char *buf)
+{
+	int rval = 0;
+	size_t verofs;
+	size_t verlen = mtd->writesize;
+	uint8_t *verbuf = memalign(ARCH_DMA_MINALIGN, verlen);
+
+	if (!verbuf)
+		return -ENOMEM;
+
+	/* Read the NAND back in page-size groups to limit malloc size */
+	for (verofs = ofs; verofs < ofs + len;
+	     verofs += verlen, buf += verlen) {
+		verlen = min(mtd->writesize, (uint32_t)(ofs + len - verofs));
+		rval = nand_read(mtd, verofs, &verlen, verbuf);
+		if (!rval || (rval == -EUCLEAN))
+			rval = memcmp(buf, verbuf, verlen);
+
+		if (rval)
+			break;
+	}
+
+	free(verbuf);
+
+	return rval ? -EIO : 0;
+}
+
+/**
+ * nand_write_skip_bad:
+ *
+ * Write image to NAND flash.
+ * Blocks that are marked bad are skipped and the is written to the next
+ * block instead as long as the image is short enough to fit even after
+ * skipping the bad blocks.  Due to bad blocks we may not be able to
+ * perform the requested write.  In the case where the write would
+ * extend beyond the end of the NAND device, both length and actual (if
+ * not NULL) are set to 0.  In the case where the write would extend
+ * beyond the limit we are passed, length is set to 0 and actual is set
+ * to the required length.
+ *
+ * @param mtd		nand mtd instance
+ * @param offset	offset in flash
+ * @param length	buffer length
+ * @param actual	set to size required to write length worth of
+ *			buffer or 0 on error, if not NULL
+ * @param lim		maximum size that actual may be in order to not
+ *			exceed the buffer
+ * @param buffer        buffer to read from
+ * @param flags		flags modifying the behaviour of the write to NAND
+ * Return:		0 in case of success
+ */
+int nand_write_skip_bad(struct mtd_info *mtd, loff_t offset, size_t *length,
+			size_t *actual, loff_t lim, u_char *buffer, int flags)
+{
+	int rval = 0, blocksize;
+	size_t left_to_write = *length;
+	size_t used_for_write = 0;
+	u_char *p_buffer = buffer;
+	int need_skip;
+
+	if (actual)
+		*actual = 0;
+
+	blocksize = mtd->erasesize;
+
+	/*
+	 * nand_write() handles unaligned, partial page writes.
+	 *
+	 * We allow length to be unaligned, for convenience in
+	 * using the $filesize variable.
+	 *
+	 * However, starting at an unaligned offset makes the
+	 * semantics of bad block skipping ambiguous (really,
+	 * you should only start a block skipping access at a
+	 * partition boundary).  So don't try to handle that.
+	 */
+	if ((offset & (mtd->writesize - 1)) != 0) {
+		printf("Attempt to write non page-aligned data\n");
+		*length = 0;
+		return -EINVAL;
+	}
+
+	need_skip = check_skip_len(mtd, offset, *length, &used_for_write);
+
+	if (actual)
+		*actual = used_for_write;
+
+	if (need_skip < 0) {
+		printf("Attempt to write outside the flash area\n");
+		*length = 0;
+		return -EINVAL;
+	}
+
+	if (used_for_write > lim) {
+		puts("Size of write exceeds partition or device limit\n");
+		*length = 0;
+		return -EFBIG;
+	}
+
+	if (!need_skip && !(flags & WITH_DROP_FFS)) {
+		rval = nand_write(mtd, offset, length, buffer);
+
+		if ((flags & WITH_WR_VERIFY) && !rval)
+			rval = nand_verify(mtd, offset, *length, buffer);
+
+		if (rval == 0)
+			return 0;
+
+		*length = 0;
+		printf("NAND write to offset %llx failed %d\n",
+			offset, rval);
+		return rval;
+	}
+
+	while (left_to_write > 0) {
+		loff_t block_start = offset & ~(loff_t)(mtd->erasesize - 1);
+		size_t block_offset = offset & (mtd->erasesize - 1);
+		size_t write_size, truncated_write_size;
+
+		schedule();
+
+		if (nand_block_isbad(mtd, block_start)) {
+			printf("Skip bad block 0x%08llx\n", block_start);
+			offset += mtd->erasesize - block_offset;
+			continue;
+		}
+
+		if (left_to_write < (blocksize - block_offset))
+			write_size = left_to_write;
+		else
+			write_size = blocksize - block_offset;
+
+		truncated_write_size = write_size;
+#ifdef CONFIG_CMD_NAND_TRIMFFS
+		if (flags & WITH_DROP_FFS)
+			truncated_write_size = drop_ffs(mtd, p_buffer,
+					&write_size);
+#endif
+
+		rval = nand_write(mtd, offset, &truncated_write_size,
+				p_buffer);
+
+		if ((flags & WITH_WR_VERIFY) && !rval)
+			rval = nand_verify(mtd, offset,
+				truncated_write_size, p_buffer);
+
+		offset += write_size;
+		p_buffer += write_size;
+
+		if (rval != 0) {
+			printf("NAND write to offset %llx failed %d\n",
+				offset, rval);
+			*length -= left_to_write;
+			return rval;
+		}
+
+		left_to_write -= write_size;
+	}
+
+	return 0;
+}
+
+/**
+ * nand_read_skip_bad:
+ *
+ * Read image from NAND flash.
+ * Blocks that are marked bad are skipped and the next block is read
+ * instead as long as the image is short enough to fit even after
+ * skipping the bad blocks.  Due to bad blocks we may not be able to
+ * perform the requested read.  In the case where the read would extend
+ * beyond the end of the NAND device, both length and actual (if not
+ * NULL) are set to 0.  In the case where the read would extend beyond
+ * the limit we are passed, length is set to 0 and actual is set to the
+ * required length.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * @param length buffer length, on return holds number of read bytes
+ * @param actual set to size required to read length worth of buffer or 0
+ * on error, if not NULL
+ * @param lim maximum size that actual may be in order to not exceed the
+ * buffer
+ * @param buffer buffer to write to
+ * Return: 0 in case of success
+ */
+int nand_read_skip_bad(struct mtd_info *mtd, loff_t offset, size_t *length,
+		       size_t *actual, loff_t lim, u_char *buffer)
+{
+	int rval;
+	size_t left_to_read = *length;
+	size_t used_for_read = 0;
+	u_char *p_buffer = buffer;
+	int need_skip;
+
+	if ((offset & (mtd->writesize - 1)) != 0) {
+		printf("Attempt to read non page-aligned data\n");
+		*length = 0;
+		if (actual)
+			*actual = 0;
+		return -EINVAL;
+	}
+
+	need_skip = check_skip_len(mtd, offset, *length, &used_for_read);
+
+	if (actual)
+		*actual = used_for_read;
+
+	if (need_skip < 0) {
+		printf("Attempt to read outside the flash area\n");
+		*length = 0;
+		return -EINVAL;
+	}
+
+	if (used_for_read > lim) {
+		puts("Size of read exceeds partition or device limit\n");
+		*length = 0;
+		return -EFBIG;
+	}
+
+	if (!need_skip) {
+		rval = nand_read(mtd, offset, length, buffer);
+		if (!rval || rval == -EUCLEAN)
+			return 0;
+
+		*length = 0;
+		printf("NAND read from offset %llx failed %d\n",
+			offset, rval);
+		return rval;
+	}
+
+	while (left_to_read > 0) {
+		size_t block_offset = offset & (mtd->erasesize - 1);
+		size_t read_length;
+
+		schedule();
+
+		if (nand_block_isbad(mtd, offset & ~(mtd->erasesize - 1))) {
+			printf("Skipping bad block 0x%08llx\n",
+				offset & ~(mtd->erasesize - 1));
+			offset += mtd->erasesize - block_offset;
+			continue;
+		}
+
+		if (left_to_read < (mtd->erasesize - block_offset))
+			read_length = left_to_read;
+		else
+			read_length = mtd->erasesize - block_offset;
+
+		rval = nand_read(mtd, offset, &read_length, p_buffer);
+		if (rval && rval != -EUCLEAN) {
+			printf("NAND read from offset %llx failed %d\n",
+				offset, rval);
+			*length -= left_to_read;
+			return rval;
+		}
+
+		left_to_read -= read_length;
+		offset       += read_length;
+		p_buffer     += read_length;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_CMD_NAND_TORTURE
+
+/**
+ * check_pattern:
+ *
+ * Check if buffer contains only a certain byte pattern.
+ *
+ * @param buf buffer to check
+ * @param patt the pattern to check
+ * @param size buffer size in bytes
+ * Return: 1 if there are only patt bytes in buf
+ *         0 if something else was found
+ */
+static int check_pattern(const u_char *buf, u_char patt, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] != patt)
+			return 0;
+	return 1;
+}
+
+/**
+ * nand_torture:
+ *
+ * Torture a block of NAND flash.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+int nand_torture(struct mtd_info *mtd, loff_t offset)
+{
+	u_char patterns[] = {0xa5, 0x5a, 0x00};
+	struct erase_info instr = {
+		.mtd = mtd,
+		.addr = offset,
+		.len = mtd->erasesize,
+	};
+	size_t retlen;
+	int err, ret = -1, i, patt_count;
+	u_char *buf;
+
+	if ((offset & (mtd->erasesize - 1)) != 0) {
+		puts("Attempt to torture a block at a non block-aligned offset\n");
+		return -EINVAL;
+	}
+
+	if (offset + mtd->erasesize > mtd->size) {
+		puts("Attempt to torture a block outside the flash area\n");
+		return -EINVAL;
+	}
+
+	patt_count = ARRAY_SIZE(patterns);
+
+	buf = malloc_cache_aligned(mtd->erasesize);
+	if (buf == NULL) {
+		puts("Out of memory for erase block buffer\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < patt_count; i++) {
+		err = mtd_erase(mtd, &instr);
+		if (err) {
+			printf("%s: erase() failed for block at 0x%llx: %d\n",
+				mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		/* Make sure the block contains only 0xff bytes */
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+				mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = check_pattern(buf, 0xff, mtd->erasesize);
+		if (!err) {
+			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
+				offset);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Write a pattern and check it */
+		memset(buf, patterns[i], mtd->erasesize);
+		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
+		if (err || retlen != mtd->erasesize) {
+			printf("%s: write() failed for block at 0x%llx: %d\n",
+				mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+				mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = check_pattern(buf, patterns[i], mtd->erasesize);
+		if (!err) {
+			printf("Pattern 0x%.2x checking failed for block at "
+					"0x%llx\n", patterns[i], offset);
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
+#endif
-- 
2.30.1

