Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE6DC83030
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D5E81E13;
	Mon, 30 Jun 2025 14:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKveMEww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2087A81FEE; Mon, 30 Jun 2025 12:01:48 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E274B800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rafal.vonau@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e7569ccf04cso1373945276.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751277705; x=1751882505; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5zKRmF1WjlOLRNNlqpoOztXUrZRMKl349M0tDNzvvlA=;
 b=ZKveMEwwYzCEsEAlAGGl0S4eWnPsggK55YoGD+YpQBkT85/q2ZW4WAPqbRjnFhfS7L
 nXfaZf8XuJiYTmbgh6ITOZnpO/vUzIPrXHYKqbB2YazjwO9fb9tuHrrKz5sjErQb2o87
 5JMnUmph5ahZq60vNCKPzlB51zpWmu58h/BYa5FFySyQDwnMOhFHduK/wo2RUZOQetkE
 YYIQ7zWgpj7bTTkYK3puYet1SFdhO7iv18OevYl+yuaG5M4ObE7111UaLRWaRZPFn3Te
 rPshP0rYMo9QNClaTQxYcrXEl9sz84J+TaAExRZFYy8hX+TJ2HNLJu1K+nJ5DFsomoqX
 gsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751277705; x=1751882505;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5zKRmF1WjlOLRNNlqpoOztXUrZRMKl349M0tDNzvvlA=;
 b=LWNF/Mcv8xLlTROrs1YvSzTf2J+YpdyPzfWlfEJWO8fr+ifAjsLzqU5rzvUTts/v/p
 dKjIiyus4V19D5LhVZjAZ7q9Ii0A8LItCU74yksZOILYUnpLkyV/y9Xg86+tIKQV6ot1
 LYhLpDuzau9cTM+57fFTZwSvHWxZO+orlQwLGmVm/VWknQq3tAeb3GG4BIe5XqW6wkhu
 Cy0yszqWukk2Dl259apbfTWxoQjY6YuFa8Fh2ijapVWLyLC7eonzdypaZh92+I1v21EO
 C7snvZCzeNUwcdQpPWWsZjVw5pcpaWV7tx6DiRTt6zogE6Sz5QsKJfznyAEoSjxs3jwC
 BC1g==
X-Gm-Message-State: AOJu0YyFUJy/3YQYeO+6isIKwFmbQQOol7vuhbCSD9schUJMpWeeVBso
 l5LmPYFLyUL9CK635BfLaMSdGM+tqxv3rNGQ53rcqIxu36zI/oRsqmtATGzJn6v9qR5wBJA8y5n
 heORfgDeRNggwzV8/LLulg9QTxnTYXSD9Aw==
X-Gm-Gg: ASbGncvgAaP34voebH+Tgr6lslTbNfHP3r1QC6QUVf5Rh8bmBy1+KIngvRam/EAvEym
 oLGZyQoe6hfp2FlR+isVDtcLqPzWrLyv9x2RSD1yPAcMMuaZPJR0f2RrbGfInKPuF7dBYTmXZ/b
 AtvP/YcIUib75jujSjuPvUzG4wP+LYQLR3yshmwUjKl48=
X-Google-Smtp-Source: AGHT+IF8kU92TWqxo2aGfFM8nyOFTIrCCslNx+074bSOaHQ3vIBYx8zGEb63ySh7rtu6F4VKS3tdqR0L9f9/oTz6AhI=
X-Received: by 2002:a05:6902:2989:b0:e84:1c10:5a21 with SMTP id
 3f1490d57ef6-e87a7b0dc1cmr10905662276.11.1751277704596; Mon, 30 Jun 2025
 03:01:44 -0700 (PDT)
MIME-Version: 1.0
From: Rafal Vonau <rafal.vonau@gmail.com>
Date: Mon, 30 Jun 2025 12:01:33 +0200
X-Gm-Features: Ac12FXy9qiN0Zl5uQrVg3Jy8TbiqeIFPSL7iLCCfWyowMVcxgmlfV9NmCUiZH8I
Message-ID: <CABj3Bj9u_g-J3j2MRV2PPMNn0HhZeF-BaJfQOXR5xek5_fZynw@mail.gmail.com>
Subject: [PATCH] nand: fix repeated BBT writes due to missing OOB read
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000007c830b0638c71d9f"
X-Mailman-Approved-At: Mon, 30 Jun 2025 14:18:06 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--0000000000007c830b0638c71d9f
Content-Type: text/plain; charset="UTF-8"

During system startup, U-Boot overwrites the Bad Block Table (BBT) on NAND
flash
every time because it fails to properly read the existing BBT. This happens
due
to missing OOB (Out-Of-Band) reads when checking for the BBT signature.

As a result, U-Boot assumes the BBT is invalid or missing and rewrites it on
every boot, causing unnecessary NAND wear and slower startup.

This patch corrects the issue by enabling proper reading of the BBT from the
OOB area, preventing redundant writes.

Signed-off-by: Rafal Vonau <rafal.vonau@gmail.com>
---
drivers/mtd/nand/raw/zynq_nand.c | 14 ++++++++++++++
1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c
b/drivers/mtd/nand/raw/zynq_nand.c
index ca1aff25a52..3adacb1b46c 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -522,6 +522,20 @@ static int zynq_nand_read_page_raw_nooob(struct
mtd_info *mtd,
               struct nand_chip *chip, u8 *buf, int oob_required, int page)
{
       chip->read_buf(mtd, buf, mtd->writesize);
+
+       if (oob_required) {
+               unsigned long data_width = 4;
+               unsigned long data_phase_addr = 0;
+               u8 *p = chip->oob_poi;
+               chip->read_buf(mtd, p, (mtd->oobsize - data_width));
+               p += (mtd->oobsize - data_width);
+
+               data_phase_addr = (unsigned long)chip->IO_ADDR_R;
+               data_phase_addr |= ZYNQ_NAND_CLEAR_CS;
+               chip->IO_ADDR_R = (void __iomem *)data_phase_addr;
+               chip->read_buf(mtd, p, data_width);
+       }
+
       return 0;
}

--
2.20.1

--0000000000007c830b0638c71d9f
Content-Type: application/x-patch; 
	name="0001-fix-Fix-for-the-write-of-the-BBT-table-to-the-NAND-a.patch"
Content-Disposition: attachment; 
	filename="0001-fix-Fix-for-the-write-of-the-BBT-table-to-the-NAND-a.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcixibjv0>
X-Attachment-Id: f_mcixibjv0

RnJvbSAwYjExYmZiYzJhNTNhMTNjYjg2ZTg1ZWYzZDZkMDRmNGUwNmU0NzA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWZhbCBWb25hdSA8cmFmYWwudm9uYXVAZWxmaW4tcGUucGw+
CkRhdGU6IE1vbiwgMzAgSnVuIDIwMjUgMTA6MjI6MDAgKzAyMDAKU3ViamVjdDogW1BBVENIXSBm
aXg6IEZpeCBmb3IgdGhlIHdyaXRlIG9mIHRoZSBCQlQgdGFibGUgdG8gdGhlIE5BTkQgYXQgc3lz
dGVtCiBzdGFydHVwCgpTaWduZWQtb2ZmLWJ5OiBSYWZhbCBWb25hdSA8cmFmYWwudm9uYXVAZWxm
aW4tcGUucGw+Ci0tLQogZHJpdmVycy9tdGQvbmFuZC9yYXcvenlucV9uYW5kLmMgfCAxNCArKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy96eW5xX25hbmQuYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3
L3p5bnFfbmFuZC5jCmluZGV4IGNhMWFmZjI1YTUyLi4zYWRhY2IxYjQ2YyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tdGQvbmFuZC9yYXcvenlucV9uYW5kLmMKKysrIGIvZHJpdmVycy9tdGQvbmFuZC9y
YXcvenlucV9uYW5kLmMKQEAgLTUyMiw2ICs1MjIsMjAgQEAgc3RhdGljIGludCB6eW5xX25hbmRf
cmVhZF9wYWdlX3Jhd19ub29vYihzdHJ1Y3QgbXRkX2luZm8gKm10ZCwKIAkJc3RydWN0IG5hbmRf
Y2hpcCAqY2hpcCwgdTggKmJ1ZiwgaW50IG9vYl9yZXF1aXJlZCwgaW50IHBhZ2UpCiB7CiAJY2hp
cC0+cmVhZF9idWYobXRkLCBidWYsIG10ZC0+d3JpdGVzaXplKTsKKworCWlmIChvb2JfcmVxdWly
ZWQpIHsKKwkJdW5zaWduZWQgbG9uZyBkYXRhX3dpZHRoID0gNDsKKwkJdW5zaWduZWQgbG9uZyBk
YXRhX3BoYXNlX2FkZHIgPSAwOworCQl1OCAqcCA9IGNoaXAtPm9vYl9wb2k7CisJCWNoaXAtPnJl
YWRfYnVmKG10ZCwgcCwgKG10ZC0+b29ic2l6ZSAtIGRhdGFfd2lkdGgpKTsKKwkJcCArPSAobXRk
LT5vb2JzaXplIC0gZGF0YV93aWR0aCk7CisKKwkJZGF0YV9waGFzZV9hZGRyID0gKHVuc2lnbmVk
IGxvbmcpY2hpcC0+SU9fQUREUl9SOworCQlkYXRhX3BoYXNlX2FkZHIgfD0gWllOUV9OQU5EX0NM
RUFSX0NTOworCQljaGlwLT5JT19BRERSX1IgPSAodm9pZCBfX2lvbWVtICopZGF0YV9waGFzZV9h
ZGRyOworCQljaGlwLT5yZWFkX2J1ZihtdGQsIHAsIGRhdGFfd2lkdGgpOworCX0KKwogCXJldHVy
biAwOwogfQogCi0tIAoyLjIwLjEKCg==
--0000000000007c830b0638c71d9f--
