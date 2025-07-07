Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA84C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 14:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A198305C;
	Mon,  7 Jul 2025 16:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aZRw3ug6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B341830CA; Mon,  7 Jul 2025 16:12:24 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0668304D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 16:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cf214200so24007975e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751897541; x=1752502341; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B1Rm9DG2Yfh/2h0PYseRe2mO5JD6YFtwK712wWDy+Zg=;
 b=aZRw3ug6IWNznl3gTPGzXKUjqZL6kyB0zc6bzTZ9UEswg2YcgYtyCbPLOiVQ99bkL3
 LAyJek5sZeaUwiBwc0yF1NYK4l8fm432KARMOLR7VcSGjAbmhLP7/QU7TJUEzTO/qw+d
 u1EVj/nd9L8nw65qfMBeGT/YwSW3J9XqwgzA6hEDQ8gsrVagbMXevvBliVcCjWuLouE4
 go4CbUAEwZmP/NoNGdYbLrSpZ05OrukZLHJS72/bv1eDZgjaVksAZvxIiA8CS3OykxeT
 8p5/GywLbekZgNRiWZZ2N+Z5DV5VAdiSJ+rCW22QGiTRuseWLzqT0T5prYxMfNSbxJ1z
 9igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751897541; x=1752502341;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1Rm9DG2Yfh/2h0PYseRe2mO5JD6YFtwK712wWDy+Zg=;
 b=WtFNW7zgBrSl8w7NOuNNn/NL2E0QR8kUtHj3N+Wm+ZoEWkJR9eysgePOpGci6xvmKl
 lwe9CynL12aEIMsU+Q9dpii0IPcpjx9n3o0/YUyokqmhCALyc+piWckopc/q4qxBMAqA
 RU/D7KskizJc3Fs5Lyrp9M8qLJt5x8ni3He7rjr7CtjO8kJM2fYqMNjb0ypE2ENSEEyg
 2VZQ3JuRRIG7rplSdJxNnUllcEVif58dAwFZN+t366tcQJ6Ij/gzMMGFBu/f5443LDdY
 3I+0WrK7+EFYnxAwxdgIJ33tcl2/PViwhEqMkBc2QQQlz6MUYj9cQDSWLu9ph5874C/a
 d3Ug==
X-Gm-Message-State: AOJu0YykxnE7+qwuLgQNOZdwNkQsknK9nXRYOoHwQISeiGJ3SQYfuLk8
 oaL2jsk6yQcdiBadEfA4N8J/zCo3eNyV1NbhO5b+CRIqA0vNatOzwCoPsz5TNbJjNiisGwTFKfV
 oJvCE
X-Gm-Gg: ASbGncsmeK9Vep9kiI+XHFV/2anKd/0hcbvVfP48anaFOv7DYGq5M7t0NsNZqU7kVCg
 b4QtScMDKumORYicgYJojssRswGkHwMtBevh6PTfRMMlWQGF+j6AiVPvPsJAxMw60X+7Ka+1hbH
 1o4ukivm/MRLR3LxNcOyBRwRaFwtw0PgiI1cDXXAsKqsCFWEJGWsfCPlSBbOf1r9V7sK8BhyIJh
 BA8uMSkMEoJLdJnfC4UZ2MVFUlbw83bNQ9SHJ6MaZEwRGQvDbZ+xgo+nEsLMifbJ7xEiIglO+g4
 g787KpyWUcbKssmn1lPbayHCsfPJtHUBWAbXDT6FXtodA0M2a0ChV9ALmOwKSAl2mKrbbUCnGK+
 cTqfP850b6iXY1btT5upN9cQp
X-Google-Smtp-Source: AGHT+IHBLNoxpCEM4RCcPO/GyzWF3AEMSSPO3VyaIZ7lkcIdotvK57Ir+BKn/mRneZw5KESuhga+/w==
X-Received: by 2002:a05:600c:3549:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-454b308c9bcmr151805405e9.10.1751897541465; 
 Mon, 07 Jul 2025 07:12:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96731sm10384076f8f.55.2025.07.07.07.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 07:12:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 07 Jul 2025 15:12:20 +0100
Subject: [PATCH] scsi: Make static functions consistent using lbaint_t
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-scsi_fix-v1-1-26a3b1af4b9f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMPVa2gC/x2NywqDMBBFf0Vm3UAclAR/RUrJY6yzaJSZIoLk3
 xu7PNxzuBcoCZPC1F0gdLDyVhr0jw7SGsqbDOfGgBZH66wzmpRfC58mos89Ohx89tD0GJRMlFD
 SegefoF+Se9iFmv//mJ+1/gDc1elvcwAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The static helper functions are inconsistent in their use of their third
parameter which is used to pass a block count. Keep consistency by
always using lbaint_t here. This will fix an issue where two left shifts
were overflowing the variable type in use.

This issue found by Smatch

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/scsi/scsi.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 7d022ce718a..78efed6b66a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -39,7 +39,7 @@ static void scsi_print_error(struct scsi_cmd *pccb)
 
 #ifdef CONFIG_SYS_64BIT_LBA
 void scsi_setup_read16(struct scsi_cmd *pccb, lbaint_t start,
-		       unsigned long blocks)
+		       lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_READ16;
 	pccb->cmd[1] = 0;
@@ -83,7 +83,7 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
 }
 
 static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
-				  unsigned short blocks)
+				  lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_SYNC_CACHE;
 	pccb->cmd[1] = 0;
@@ -100,7 +100,7 @@ static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
 }
 
 static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
-				unsigned short blocks)
+				lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_READ10;
 	pccb->cmd[1] = 0;
@@ -121,7 +121,7 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 }
 
 static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
-				 unsigned short blocks)
+				 lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_WRITE10;
 	pccb->cmd[1] = 0;
@@ -143,7 +143,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 }
 
 static void scsi_setup_erase_ext(struct scsi_cmd *pccb, lbaint_t start,
-				 unsigned short blocks)
+				 lbaint_t blocks)
 {
 	u8 *param = tempbuff;
 	const u8 param_size = 24;
@@ -193,9 +193,8 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
 	struct udevice *bdev = dev->parent;
 	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
-	lbaint_t start, blks, max_blks;
+	lbaint_t start, blks, max_blks, blocks;
 	uintptr_t buf_addr;
-	unsigned short smallblks = 0;
 	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
 
 	/* Setup device */
@@ -217,7 +216,6 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		pccb->dma_dir = DMA_FROM_DEVICE;
 #ifdef CONFIG_SYS_64BIT_LBA
 		if (start > SCSI_LBA48_READ) {
-			unsigned long blocks;
 			blocks = min_t(lbaint_t, blks, max_blks);
 			pccb->datalen = block_dev->blksz * blocks;
 			scsi_setup_read16(pccb, start, blocks);
@@ -227,20 +225,20 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 #endif
 		if (blks > max_blks) {
 			pccb->datalen = block_dev->blksz * max_blks;
-			smallblks = max_blks;
-			scsi_setup_read_ext(pccb, start, smallblks);
+			blocks = max_blks;
+			scsi_setup_read_ext(pccb, start, blocks);
 			start += max_blks;
 			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
-			smallblks = (unsigned short)blks;
-			scsi_setup_read_ext(pccb, start, smallblks);
+			blocks = blks;
+			scsi_setup_read_ext(pccb, start, blocks);
 			start += blks;
 			blks = 0;
 		}
 		debug("scsi_read_ext: startblk " LBAF
-		      ", blccnt %x buffer %lX\n",
-		      start, smallblks, buf_addr);
+		      ", blccnt " LBAF " buffer %lX\n",
+		      start, blocks, buf_addr);
 		if (scsi_exec(bdev, pccb)) {
 			scsi_print_error(pccb);
 			blkcnt -= blks;
@@ -249,7 +247,7 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 	debug("scsi_read_ext: end startblk " LBAF
-	      ", blccnt %x buffer %lX\n", start, smallblks, buf_addr);
+	      ", blccnt " LBAF " buffer %lX\n", start, blocks, buf_addr);
 	return blkcnt;
 }
 
@@ -263,9 +261,8 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
 	struct udevice *bdev = dev->parent;
 	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
-	lbaint_t start, blks, max_blks;
+	lbaint_t start, blks, max_blks, blocks;
 	uintptr_t buf_addr;
-	unsigned short smallblks;
 	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
 
 	/* Setup device */
@@ -286,19 +283,19 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		pccb->dma_dir = DMA_TO_DEVICE;
 		if (blks > max_blks) {
 			pccb->datalen = block_dev->blksz * max_blks;
-			smallblks = max_blks;
-			scsi_setup_write_ext(pccb, start, smallblks);
+			blocks = max_blks;
+			scsi_setup_write_ext(pccb, start, blocks);
 			start += max_blks;
 			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
-			smallblks = (unsigned short)blks;
-			scsi_setup_write_ext(pccb, start, smallblks);
+			blocks = blks;
+			scsi_setup_write_ext(pccb, start, blocks);
 			start += blks;
 			blks = 0;
 		}
-		debug("%s: startblk " LBAF ", blccnt %x buffer %lx\n",
-		      __func__, start, smallblks, buf_addr);
+		debug("%s: startblk " LBAF ", blccnt " LBAF " buffer %lx\n",
+		      __func__, start, blocks, buf_addr);
 		if (scsi_exec(bdev, pccb)) {
 			scsi_print_error(pccb);
 			blkcnt -= blks;
@@ -312,8 +309,8 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	if (scsi_exec(bdev, pccb))
 		scsi_print_error(pccb);
 
-	debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
-	      __func__, start, smallblks, buf_addr);
+	debug("%s: end startblk " LBAF ", blccnt " LBAF " buffer %lX\n",
+	      __func__, start, blocks, buf_addr);
 	return blkcnt;
 }
 

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250707-scsi_fix-b28d127248d8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

