Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD904606A339
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HOFtQzS/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L55586yd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31DE580F82;
	Mon, 16 Nov 2026 16:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81Qdv_YaY8lQ; Mon, 16 Nov 2026 16:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F12880FAB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846648;
	b=M8uIQ4xFpmk2UCtYvz4MbXLgBmKO5uizNdJdavO6QRFh8QCOIx25YZb48fFezBf4iZXw
	 0jgTY+Yy5Qow/nN0Bic09rH9QG2zkenEPdVsSnbGzI35GxOGqMExjGPh0XD9Ajz8Vh4np
	 +nUMnqS0yl2Lk+DVCsk55+re7PYdlNnTVa0sIVwPi6mu5ysx7ucHxk2KSz4CHE2IXCKgw
	 UYW4vJK3DD3FeQDGiMQ8U+6Hho18EFsjAaxbnBlem866U+AgHckKji/TR1fi94hM8oCu3
	 3pbj/sCVbs8dtrYOQs48QegaTKN1R8vTOoh3MDbd4IqBb5oxSoxHEeCQU4vDD8srlEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cX77mkOpHhHiZxKAOWdKfJ/1l0efhKgsxu4OvE2YkHI=;
	b=JzU8UfqgxghsxWoCo4urXLqqt9odsFptbPOV5qqERZPRnHZjtysPanZNnzAThAPNzsbq
	 S8xrQKVknfKcFUhGJVmPDPHwvJTr5x7sGuupSSvSjRaLZpedOhlvkWxj/gUotJP2rvisO
	 SKgyUfnJ0XPFmVZ8rIAOKLjT5ubLt0nAkqY62Pu8IxpVOGuuhHQR9ExcrKPFb4vchOzAr
	 g8kGR2t7lWpmYBbWI8pLDFnG0/2poyCWas6nRxeeYMG+PsCI1Oqlgdy3HqET04Vnz4vJc
	 zfsWo6RZ+AN3ES400gM+esdzNAs3ybeeQghZkxXqOak0UdkV0Z0zNmGMXqFV6+JFn0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846648;
	bh=cX77mkOpHhHiZxKAOWdKfJ/1l0efhKgsxu4OvE2YkHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOFtQzS/9L6IkziFvXziN7Hs9nblsG3BzjEtmgatvqzl+Cq8RraRzk/SxVvNqQEUF
	 HsagkR8V02Bwvh6SYhhmpJqoIiDEXuI7dcfVv77t17EHMIrCqbq0yNG5zfYVg+45u/
	 PayElARUYjxADX7igbMh3CjNz2w9BPa5hcZRauQk+2Gmo5Kdth05UpPUinfOCZrEaI
	 8FYxFlrlWrxJYDL6zUOYGxomyC1Wbg1+jJXhMjifLOcrQV0qeTs+kK31fJc7WD2iLA
	 J4LOvzYP8ccAzfPaWuz5wUYaB/swihY4PIN5Eo4Oi5wKY0XkQQ48O1iaOToLMBUE7L
	 L2sFhtMrSkIWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F12880FAB;
	Mon, 16 Nov 2026 16:30:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEDC0169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B099440708
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHDzEQJzeBWk for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B913040704
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=angelo.compagnucci@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=L55586yd
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B913040704
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:37:46 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso3534386f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794843464; x=1795448264;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cX77mkOpHhHiZxKAOWdKfJ/1l0efhKgsxu4OvE2YkHI=;
 b=L55586yduc/fgGDwT5Vgu0YJpwRZOnVHGuCUrMFs4Y2ByzHMA2c3AcUkhorIBqtPzG
 +FSxH/uvtzIpEDLRtT5gqtzoBMpDdMJbRBSwTh7TrJNgeDESymEsu4LkobuWOXT1Vr4J
 w72db2pblHYne6/4FmsL7TJdDMxCsL1rjAu8xiyg2LfySHcfNmnuI5/hG8t2glzdGZki
 TtRmSF61qjwrDXo3WHG3D5f6d0CqUvJv+8pRXeMfEOHj1LFyn2HgOeKlIgrbbYdc7vE4
 u5T8AiZrMIL3ZH8g+OYPa16ATdlY6MXOGrZQP6b7KtW80gjoARA2hDTS/fg++lHMhLiJ
 yOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794843464; x=1795448264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cX77mkOpHhHiZxKAOWdKfJ/1l0efhKgsxu4OvE2YkHI=;
 b=tHH8Nrk3F6TL9/aCkBuyX14DVGQFn86rvz5YEFPgkaSI6aTOYD5uX52PBxGqPvlFlD
 m3sIudbDyqy96iwLJb5WW9oCDf0QPBOFqmq202cR7X4eYyfwRrWZ3PoeuHDfwlIC1B+Z
 GXRzOw+BlULqFrYSyVxia4X9IqVkU/wTVCQu9u4/M3eWb3LUnXqvpWGZfhtx3WMCt313
 dFwlAqFtnHl2lKXr2QNzIeHv8HQeTBIfBW2HgcvnxbvQqNF3aB/2Yt3StcPFT9erfa7h
 dkJYT8jbzAPe8BJQpgz1QO1n3a3OcPJAhLj3Emi1kzRuQzjEuax3n37y3bydX6MV2xbX
 6Q4g==
X-Gm-Message-State: APuU4Z9G+nYSyTTyG5hhbon+EGX29Rsz0T32TqjdVw5rqBOfGlcdvqsx
 QfGBXggpBogJ7silutuz2IsknA9NTVdlz8ydp5wyrn/a61P73ccBP2sPadJ1ugMu
X-Gm-Gg: AYBFou2a+r61QA4yd4dcbOzvoGdex7vR8DGiOkInUIC9wO7/NT1deR97+NqqwBEuoOO
 kmXivmjWWb1IrnjM5iXAzF/nRNmDxurK3FJAGsChlfpKU+jggr6KXI3GecGrelqzx8wTC8/JsWj
 +HsRJPzYcc39NXJyFtZPXDNQ+ncfPxvg7dWOtAnpagXCDX/44b+qjQxT8VerzTIoWXpxRy7bQ1n
 /tIT30ttrw5wvg4DbWqvJB9Ifg+xFbmw9aYI7amIkb0FeQ/g9RJtRQYt+OHsCPcW3H+eROTml4X
 S2dwKE47VZrdL4APUgKVhTUFj+ddJZd9ZeOoIrZlamuswuVmkYk288aQKBizCWgXf0G+9nVcV+c
 lXlgjpwZ9pW+YCVwxPm2/mDvvV5/v6xs4EurcndsjSN5XlE4QDjlEsdB3xwHOv2OlZqIXNgIzjL
 RRzNHNg/zTPuAVYkqdXwvH8iXJ+Lznzq71BL3/YmfaJx0xVz9IIKzOWC0htuwyEEBwoYf4uQIrj
 l8gGTFO6pikE4djjQvOEAGZRrTcdeflb/gUYEPUOLVdwKXPQ7lRJy9rBGBb3f8NFbaiQBzE1KE9
 EmlHf3Dm6RlPfFHO8p9lV62V49IVOWmKbcaubsQL+PmtWlxWSKjN
X-Received: by 2002:a05:600c:1c03:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4bb55a42fe4mr248257635e9.5.1794843464560; 
 Mon, 16 Nov 2026 07:37:44 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm296939855e9.6.2026.11.16.07.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:37:44 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 2/2] mtd: spinand: xtx: add support for XT26G04C
Date: Mon, 16 Nov 2026 16:37:39 +0100
Message-ID: <20261116153739.3958623-3-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116153739.3958623-1-angelo.compagnucci@gmail.com>
References: <20261116153739.3958623-1-angelo.compagnucci@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:30:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the XTX XT26G04C. It is a 4Gbit 3.3V SPI NAND with 4096 byte pages,
256 byte OOB and 8-bit on-die ECC.

The status register reports the number of corrected bits in bits 7:4.
Values 0 to 8 are valid and 0xf means an uncorrectable error. The other
XTX parts use a different format, so add a new ECC status function.

The same change was sent to Linux.

Tested on an STM32MP133 board.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/mtd/nand/spi/xtx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index 3e1f884f..a7c6cc75 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -24,6 +24,9 @@
 #define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
 #define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
 
+#define XT26G0XC_STATUS_ECC_MASK	GENMASK(7, 4)
+#define XT26G0XC_STATUS_ECC_UNCOR_ERROR	(0xf)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
@@ -141,6 +144,20 @@ static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int xt26g0xc_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	u8 eccsr = FIELD_GET(XT26G0XC_STATUS_ECC_MASK, status);
+
+	if (eccsr <= 8)
+		return eccsr;
+
+	if (eccsr == XT26G0XC_STATUS_ECC_UNCOR_ERROR)
+		return -EBADMSG;
+
+	return -EINVAL;
+}
+
 static const struct spinand_info xtx_spinand_table[] = {
 	SPINAND_INFO("XT26G01A",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE1),
@@ -252,6 +269,16 @@ static const struct spinand_info xtx_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
 				     xt26xxxd_ecc_get_status)),
+	SPINAND_INFO("XT26G04C",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x13),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&xt26xxxd_ooblayout,
+				     xt26g0xc_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
-- 
2.53.0

