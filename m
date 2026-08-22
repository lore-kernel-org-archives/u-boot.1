Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B98C5B572
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 23:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F3E680E94;
	Sat, 22 Aug 2026 23:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQ9c-7T-rUy1; Sat, 22 Aug 2026 23:02:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787439751;
	bh=uEd6diuJONXaQQoZPIVjcrn5C2CykmrbfoD7qjQoIcY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JFQsp106Pd0azR76jTMdKqzkN+u8aZf4qe0AEr7xak96qyCqJwGe5FZ5kFAdDCBgT
	 5gBLVRCe72TSxSoeUYKA9TpvmV7jfVM6OdtiCX/jAkXpXtFlGc7EGLMPQi/2DD7K5y
	 Nbwz3cxwae8wsm40CN7QztcrkjLkrtWUpr8QdBxnLth9E8bgKDrEUO7oESrl210pDv
	 spOmx55YZJMiFugOLfKyDVdMQZhljsq452xGr/NCRUZHAkAXbA0Sl+amxtaYkmo6BX
	 Jrnl0fVWxQx1neouTqJQr5xkB1xQb/SIWbFWoY9/L2U5dKYneoBvDErauDGszd8lq3
	 H/Z96edLYgHcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7961B80E7A;
	Sat, 22 Aug 2026 23:02:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E0A1476
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B5B480DD9
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXOWdeZveIUF for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 20:55:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=G882SXYZ
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D07A280DD8
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:55:45 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso334533266b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1787432143; x=1788036943; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uEd6diuJONXaQQoZPIVjcrn5C2CykmrbfoD7qjQoIcY=;
 b=G882SXYZQsjjzS5EHA2o13/0WWi3rCrw7A8bKDBeceznR/t+w2upiKwrAx/ioqaeiA
 JQEkqOs3yJ2NjIR0eJD6O7hM/38GEuGpAI5LvRmkBk80eA4k45XQeAykFFuSl7CN0zCR
 tDouC+Ip+hk6XJcYBJ/8IHcvE5au/aUUqRU2XH4/Uu/TsHbMuA0++oqeehQXL+pBkWvs
 77rMBdMLgGE9uxEWPRS8giPfqL3b8142tIQTd2E9utrmribTJxK91av/kIZ5TX5hr2/A
 xzk/mrdzT8RnUodW7NJpEqeynxFIuYUrBKc23+YywayXUQdKbT3FzYCsHKZ3fB8trOWZ
 uY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787432143; x=1788036943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uEd6diuJONXaQQoZPIVjcrn5C2CykmrbfoD7qjQoIcY=;
 b=aGYyd4MoGhCMUXrEBseNqBf2P2kh9u40wpoU50+w9vm+i+rzmyebLzcAvWUUAHJdh9
 JMv+ZpOnLz7Zs6VvFfEnagGzX8cfjWybpQLSVDQNdQQcJamQyRfZ6WsoKPxEaEJgI0L9
 nDyDw4Xosk53kbSdwIGR4gPEDzAPukcYHKka56NuBCTDGO8U8f9Hkt10/VqXRcWbkCdO
 OJD3tKObtvq79kQqiBx7vhjv7VcrGysmGAA/u/48M56nxCzshZ/t1RbHKZJjr2PsPOjQ
 R8vOqXqaMEghqUuDf8obPrLhgFgLybfdetZnoox9Ul2PKY2c994BRAi+DehuM1cDGpya
 llMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RodUr/1Ko9QdrHwf2/ExZbhKz4LDu519IVrUcW8aOZ0OhZzThg3H6eiQLUNriamPTReZN+sIAg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIPdV+l4p2jFXZbVPm7BIoevEbXQgXxrX0skOy8Bm7CBcDaOTw
 OY5aqi1UThe1TJTLJi5v/jQUYVUmYg/hdBx4emVHrJ3RA34z8kO1dtD9pMbkbyXoBAcinOE6YSQ
 wBwep8g7tuw==
X-Gm-Gg: AR+sD10VHKZyvDfLl0fZo3J6Tlzrrrmren+icVjf8rLDyJfDkigt7Wdfvt+81MR0jH9
 etspB2FJmH6eirH240gZ2J++HDZWNxLRsxogmoaA7j+QhK/TUC63RPxB49SiVhrITURrXtYjrLT
 FBkcROgT1ZHk0wLEQTBNzsuMz0RIHeAyEGJ/vEgNVfe43a9e96eanx6uzvY+R00gTnia+3Rr69R
 +wn9Nbz2uuIkeOVkBGsZ9M11JhzhzGWtrKyon2Q3irAZL5YTrZZ5Vjx6VW6JHNXPiWSWqbj7vC8
 NtgHJ0NVdM+X9MgF4/VI5Yo9XbspzQl/YTI1WcUcm5eitLp6v+KVPtYpclSSakVNTFZ/9mFYPFv
 qkDCYOxgB/EfvkQfSmJ+LffsMPm4xIDnbLBlCWv4GFT3rD7u7l3WnO/pHGyAHz2Hi5Mbg5oMrkQ
 0sssxL9xhZene/jkGUMQHiIyiQCSIfY0H5IdL4wG1KbqEDALR/TBQSdoW38RBlNaizgm7/Rw==
X-Received: by 2002:a17:907:3f9c:b0:c24:90a3:42a5 with SMTP id
 a640c23a62f3a-c2490a34342mr958415066b.14.1787432143068; 
 Sat, 22 Aug 2026 13:55:43 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968abf18sm521453166b.61.2026.08.22.13.55.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 22 Aug 2026 13:55:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.u-boot-project.org, Aleksei Sviridkin <f@lex.la>
Subject: [PATCH] mtd: spinand: fmsh: add support for FM25G01B and FM25G02B
Date: Sat, 22 Aug 2026 23:55:40 +0300
Message-ID: <20260822205540.1223-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 22 Aug 2026 23:02:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the FudanMicro FM25G01B (1Gbit) and FM25G02B (2Gbit) SPI-NAND
parts. Both have 2048-byte pages with 128 bytes of spare area, 64
pages per erase block, and on-die ECC with a strength of 8 bits per
528-byte step. Their ECC status field is 3 bits wide and reports each
bitflip count from four to eight separately, so it needs a decoder of
its own instead of the coarse ranges the other parts in this file use.

The 0xEB Quad I/O read-from-cache operation takes a single dummy byte
on these chips rather than the two the shared read_cache_variants set
uses, hence the separate variant set: with the extra dummy byte the
data phase is shifted and reads return corrupted data without any ECC
error being reported.

FM25G01B datasheet: https://www.fmsh.com/nvm/FM25G01B_ds_eng.pdf
FM25G02B datasheet: https://www.fmsh.com/nvm/FM25G02B_ds_eng.pdf

This is a port of linux commits
d5a5c9eb2ee9 ("mtd: spinand: fmsh: add support for FM25G{01,02}B")
8211f2d74b35 ("mtd: spinand: fmsh: fix FM25G01B/FM25G02B Quad I/O read
dummy cycles")
which are queued in the MTD tree and not in mainline yet.

Tested on a Keenetic KN-1012 (MT7981B) that boots from an FM25G02B.
FM25G01B is taken over from the Linux table and is untested here.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/mtd/nand/spi/fmsh.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
index 80837b7dd..dc6c3fc35 100644
--- a/drivers/mtd/nand/spi/fmsh.c
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -11,6 +11,16 @@
 #endif
 #include <linux/mtd/spinand.h>
 
+#define FM25G01B_STATUS_ECC_MASK		(7 << 4)
+	#define FM25G01B_STATUS_ECC_NO_BITFLIPS		(0 << 4)
+	#define FM25G01B_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+	#define FM25G01B_STATUS_ECC_4_BITFLIPS		(2 << 4)
+	#define FM25G01B_STATUS_ECC_5_BITFLIPS		(3 << 4)
+	#define FM25G01B_STATUS_ECC_6_BITFLIPS		(4 << 4)
+	#define FM25G01B_STATUS_ECC_7_BITFLIPS		(5 << 4)
+	#define FM25G01B_STATUS_ECC_8_BITFLIPS		(6 << 4)
+	#define FM25G01B_STATUS_ECC_UNCOR_ERROR		(7 << 4)
+
 #define SPINAND_MFR_FMSH		0xA1
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
@@ -29,6 +39,74 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(fm25g_read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static int fm25g01b_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 64;
+	region->length = 64;
+
+	return 0;
+}
+
+static int fm25g01b_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* reserve 2 bytes for the BBM */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static int fm25g01b_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	switch (status & FM25G01B_STATUS_ECC_MASK) {
+	case FM25G01B_STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case FM25G01B_STATUS_ECC_1_3_BITFLIPS:
+		return 3;
+
+	case FM25G01B_STATUS_ECC_4_BITFLIPS:
+		return 4;
+
+	case FM25G01B_STATUS_ECC_5_BITFLIPS:
+		return 5;
+
+	case FM25G01B_STATUS_ECC_6_BITFLIPS:
+		return 6;
+
+	case FM25G01B_STATUS_ECC_7_BITFLIPS:
+		return 7;
+
+	case FM25G01B_STATUS_ECC_8_BITFLIPS:
+		return 8;
+
+	case FM25G01B_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -47,12 +125,37 @@ static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops fm25g01b_ooblayout = {
+	.ecc = fm25g01b_ooblayout_ecc,
+	.rfree = fm25g01b_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
 	.ecc = fm25s01a_ooblayout_ecc,
 	.rfree = fm25s01a_ooblayout_free,
 };
 
 static const struct spinand_info fmsh_spinand_table[] = {
+	SPINAND_INFO("FM25G01B",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 21, 1, 1, 1),
+		     NAND_ECCREQ(8, 528),
+		     SPINAND_INFO_OP_VARIANTS(&fm25g_read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fm25g01b_ooblayout,
+				     fm25g01b_ecc_get_status)),
+	SPINAND_INFO("FM25G02B",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 41, 1, 1, 1),
+		     NAND_ECCREQ(8, 528),
+		     SPINAND_INFO_OP_VARIANTS(&fm25g_read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fm25g01b_ooblayout,
+				     fm25g01b_ecc_get_status)),
 	SPINAND_INFO("FM25S01A",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-- 
2.55.0

