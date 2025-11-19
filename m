Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38208CF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E66283EBA;
	Wed, 19 Nov 2025 10:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="opbB0s5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544B983A8C; Wed, 19 Nov 2025 06:14:24 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356FE83DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BC177441E5;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71559C2BCAF;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=ynSMZiKAAkmhnrFV1glwsJgNC4IyEMOlW/JsWqyPOlw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=opbB0s5QWTgrUWmC9QYbuHT/N+D1GYqJyqqzrOUuQOG1cV+VdjtXrlwW59L5cxqPg
 0jbVgzrUysyeiwCApv4NRAvNcMR9XBe4sgwGQAbai5SWwqED0LaK9UyK9AQhAED5uS
 uhRifS2Q6WMBj5+d06ovmR/3FV5sFHJec3Jc2uLIkUwbU86f400Xt+0pEcDqw3KXNF
 AZ6cij1junc9h6CdfQMTYDfqP1kcY/2ZP0S+0/TraBAtmtJvlmMCI3pVLghXq1dh8T
 3Deq0KQkvSasGoK0cbKulAPGswIVb8YWNSGHe6NU4thHQr9XYfVuvITFTlp7Q8NBJL
 zSUj9ior/09Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 03907CF2570;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:07 +0900
Subject: [PATCH 08/11] mtd: spi-nor: stacked: Cleanup stacked/parallel
 flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-8-c555bd85e6e4@infineon.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=6367;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=UIFLPVZke385l9hXNO40mhicBQVaOLXNsXJaBfM4/sA=;
 b=3VEsn3ZZExlnzsHcxHSM0AiuJ62HGp/bzEK1x9xlndr3CZnyMwU8XquM/IqeI+b1ibAT2aqs5
 7dpdEYZSwv8ByqlNXejUQ68KQ1/Z3fXvs5upMroTEHE+apyTwQwz8Xw
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Remove check of CONFIG_SPI_STACKED_PARALLEL, SNOR_F_HAS_PARALLEL, and
SNOR_F_HAS_STACKED as stacked module is only available when the config
is enabled and dedicated for stacked mode.

Keep SPI_XFER_U_PAGE as it tells controllers whether upper or lower chip
to be accessed. Also keep nor->upage_prev as it tracks previous chip
that write_bar is issued.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/stacked.c | 124 +++++++++++-----------------------------------
 1 file changed, 30 insertions(+), 94 deletions(-)

diff --git a/drivers/mtd/spi/stacked.c b/drivers/mtd/spi/stacked.c
index e005aea1053..49f664bc313 100644
--- a/drivers/mtd/spi/stacked.c
+++ b/drivers/mtd/spi/stacked.c
@@ -25,11 +25,7 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 	if (spi_nor_wait_till_ready(nor))
 		return 1;
 
-	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED) &&
-	    mtd->size <= SZ_32M)
-		return 0;
-
-	if (mtd->size <= SZ_16M)
+	if (mtd->size <= SZ_32M)
 		return 0;
 
 	offset = offset % (u32)mtd->size;
@@ -37,9 +33,7 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 
 	upage_curr = nor->spi->flags & SPI_XFER_U_PAGE;
 
-	if (!(nor->flags & SNOR_F_HAS_STACKED) && bank_sel == nor->bank_curr)
-		return 0;
-	else if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
+	if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
 		return 0;
 
 	nor->upage_prev = upage_curr;
@@ -89,17 +83,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			goto erase_err;
 		}
 		offset = addr;
-		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
-			if (nor->flags & SNOR_F_HAS_PARALLEL)
-				offset /= 2;
-
-			if (nor->flags & SNOR_F_HAS_STACKED) {
-				if (offset >= (mtd->size / 2))
-					nor->spi->flags |= SPI_XFER_U_PAGE;
-				else
-					nor->spi->flags &= ~SPI_XFER_U_PAGE;
-			}
-		}
+		if (offset >= (mtd->size / 2))
+			nor->spi->flags |= SPI_XFER_U_PAGE;
+		else
+			nor->spi->flags &= ~SPI_XFER_U_PAGE;
 #if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
 		ret = write_bar(nor, offset);
 		if (ret < 0)
@@ -168,46 +155,22 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
-	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
-		/* We can hit this case when we use file system like ubifs */
-		from--;
-		len++;
-		is_ofst_odd = true;
-	}
-
 	while (len) {
 		read_len = len;
 		offset = from;
 
 		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
 			bank = (u32)from / SZ_16M;
-			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
-				if (nor->flags & SNOR_F_HAS_PARALLEL)
-					bank /= 2;
-			}
 			rem_bank_len = SZ_16M * (bank + 1);
-			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
-				if (nor->flags & SNOR_F_HAS_PARALLEL)
-					rem_bank_len *= 2;
-			}
 			rem_bank_len -= from;
 		}
 
-		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
-			if (nor->flags & SNOR_F_HAS_STACKED) {
-				stack_shift = 1;
-				if (offset >= (mtd->size / 2)) {
-					offset = offset - (mtd->size / 2);
-					nor->spi->flags |= SPI_XFER_U_PAGE;
-				} else {
-					nor->spi->flags &= ~SPI_XFER_U_PAGE;
-				}
-			}
-		}
-
-		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
-			if (nor->flags & SNOR_F_HAS_PARALLEL)
-				offset /= 2;
+		stack_shift = 1;
+		if (offset >= (mtd->size / 2)) {
+			offset = offset - (mtd->size / 2);
+			nor->spi->flags |= SPI_XFER_U_PAGE;
+		} else {
+			nor->spi->flags &= ~SPI_XFER_U_PAGE;
 		}
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
@@ -272,24 +235,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (!len)
 		return 0;
 
-	/*
-	 * Cannot write to odd offset in parallel mode,
-	 * so write 2 bytes first
-	 */
-	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (to & 1)) {
-		u8 two[2] = {0xff, buf[0]};
-		size_t local_retlen;
-
-		ret = spi_nor_write(mtd, to & ~1, 2, &local_retlen, two);
-		if (ret < 0)
-			return ret;
-
-		*retlen += 1; /* We've written only one actual byte */
-		buf++;
-		len--;
-		to++;
-	}
-
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
@@ -308,16 +253,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			page_offset = do_div(aux, nor->page_size);
 		}
 		offset = to + i;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			offset /= 2;
-
-		if (nor->flags & SNOR_F_HAS_STACKED) {
-			if (offset >= (mtd->size / 2)) {
-				offset = offset - (mtd->size / 2);
-				nor->spi->flags |= SPI_XFER_U_PAGE;
-			} else {
-				nor->spi->flags &= ~SPI_XFER_U_PAGE;
-			}
+		if (offset >= (mtd->size / 2)) {
+			offset = offset - (mtd->size / 2);
+			nor->spi->flags |= SPI_XFER_U_PAGE;
+		} else {
+			nor->spi->flags &= ~SPI_XFER_U_PAGE;
 		}
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
@@ -408,6 +348,7 @@ int spi_nor_stacked_post_init_fixups(struct spi_nor *nor)
 #if CONFIG_IS_ENABLED(DM_SPI)
 	u64 flash_size[SNOR_FLASH_CNT_MAX] = { 0 };
 	struct udevice *dev = nor->spi->dev;
+	bool is_stacked = false;
 	u32 idx = 0, i = 0;
 	int rc;
 
@@ -421,33 +362,28 @@ int spi_nor_stacked_post_init_fixups(struct spi_nor *nor)
 		} else {
 			idx++;
 			i++;
-			if (!(nor->flags & SNOR_F_HAS_STACKED))
-				nor->flags |= SNOR_F_HAS_STACKED;
-			if (!(nor->spi->flags & SPI_XFER_STACKED))
-				nor->spi->flags |= SPI_XFER_STACKED;
+			is_stacked = true;
 		}
 	}
 
-	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
+	if (is_stacked) {
 		mtd->size = 0;
 		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++)
 			mtd->size += flash_size[idx];
 	}
 #endif
+	if (!is_stacked)
+		return 0;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
-		nor->spi->flags |= SPI_XFER_U_PAGE;
-		ret = spi_nor_init(nor);
-		if (ret)
-			return ret;
-		nor->spi->flags &= ~SPI_XFER_U_PAGE;
-	}
+	nor->spi->flags |= SPI_XFER_U_PAGE;
+	ret = spi_nor_init(nor);
+	if (ret)
+		return ret;
+	nor->spi->flags &= ~SPI_XFER_U_PAGE;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
-		mtd->_erase = spi_nor_erase;
-		mtd->_read = spi_nor_read;
-		mtd->_write = spi_nor_write;
-	}
+	mtd->_erase = spi_nor_erase;
+	mtd->_read = spi_nor_read;
+	mtd->_write = spi_nor_write;
 
 	return 0;
 }

-- 
2.34.1


