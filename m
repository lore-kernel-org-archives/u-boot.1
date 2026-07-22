Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB8FC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA9540904;
	Wed, 22 Jul 2026 21:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sh6QTuKQnALL; Wed, 22 Jul 2026 21:45:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 436964099D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756726;
	bh=8JajAC5c7r4FNt6VnwAMzgPUjjPcoR65jMA7nJOsiqA=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=PcOONIr85ujZy4zB1QklJgkOdaHa9Xx9nAguHyyeKeBvz0+PHe7FzgnGRg0Mu02t3
	 rj0yZ44RrxHg/MeBL5HPQlFJO7XwwP+c3/MrjcLXq78VaJoWGQcVWDj+4qi7NDX3aF
	 FTWJCLHVZbXOrRlM7YqsoeUDb9D2bxcReMEIuh3T3CKbCUHu/KtxMYonjx41oHYG3x
	 VcIvIDpmjVoiIXCzp/L6dxxQTfnfEEIn8js3gkuhFvAWhcuY7unTWZKaLG/qnmhmzz
	 y7k04T8wf3eVdMDLi2CEFKWtQS2BfrAJEMlhoVsos4Usb/NW0ElViHjb/TpNVDFJJw
	 2B2xcDP49MUHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 436964099D;
	Wed, 22 Jul 2026 21:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B61FD313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A783640182
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Zyz6Ygfh0Tj for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:45:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CA9A540082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA9A540082
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA9A540082
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:45:24 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698c1df9651so42962a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756723; x=1785361523;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8JajAC5c7r4FNt6VnwAMzgPUjjPcoR65jMA7nJOsiqA=;
 b=GQ7TbeCWtymhodQQ9ClHYfhjWTWflTEpDna68TWhfD8RYYByJ+YCZXeTT6C3lmWibj
 kP7PD6xV46rGXxShMQzdZTa3iB9kfb8se1ZPT5iL3lzETwNIZqy7Ktc4NrRDLwWD8jD/
 v1fVc/daa2pfQ2iAAT89dTZgBHQNlJZ7tCMwigQx19d2LUVuYI5jiBKH7ckOZ0DmgbvE
 GvOekiei1JvPrNxMM0JJBjq52gYwSuQTtygaLM01mqmUUAbp6O+4Al7AiQY0LX/3E9W5
 pB8/3VfEkOGgggnR/yEcr6GhMkD7iirxCb6xhqr8d95qpiZZvxwj6VgPUny9oIi4q2xi
 a04w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRklYi50dYcLd1X+aAwix8fxti8h+Kcx0YnQj3/JENHW0uPJ+4UoWX290i18Oq+04Z1kkHuVw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwUop0Y1eHOMFYmI0fx4GMQybq7Rh82AFJXJtMWpuXajNTOdOIQ
 jS2ofzPviqf1gXyWQbziH98QlABdrnAk0nr9OvgSIxjIccy99kdj3Sg/DfGG4g==
X-Gm-Gg: AR+sD12xfBW6+hPLOPezHRVibh4Hg60gDBb4yrZGVUCUDSJYjCTj4UC5jK4+YmeJpwb
 cgvALElZhgd+ym+5xywiW/x5IApvp8BMN7y7ev/ets5P9oyX9R6ifrlDxsIZoS8KNua0wjqYX6D
 EHtnjzfehU6fdMK7VvUX4ytl/lJCBzaGt7zbJpNRbi9qtCUS4MczVdJ9x+pGFpacCj71Qt1My3l
 hgnTnoic7+fuj3Tl297uKq7n3CgJTnmYEoaAjln/R+cfgJnUB8QmUhgwx7tKUkuq+pyssJgQZfX
 GEquQ4HoskmNAFbNOsfa4LhCQ5RiM/ZGujwQBS6mkLtLySvZHO/d6ofQVqol2yNm0mi1ewGBQp6
 +6wiofUZOJvQOehtVATpREEWhM5KsSPnO/mRaEEOeJKjm+G2CbbMBUDnP8p2AL1K3Hyr0RctXfm
 sMEu/USjHvIi8UQznD1xJgfHejQkT4iOx7n+s/9nFl
X-Received: by 2002:a17:907:9629:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c1c50d5b511mr11105466b.4.1784756722313; 
 Wed, 22 Jul 2026 14:45:22 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebcc4dsm158026266b.49.2026.07.22.14.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 14:45:20 -0700 (PDT)
Message-ID: <d6ffb432-5c91-4995-b5ba-d74102869280@gmail.com>
Date: Wed, 22 Jul 2026 23:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784756723; x=1785361523;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8JajAC5c7r4FNt6VnwAMzgPUjjPcoR65jMA7nJOsiqA=;
 b=DzBljjPYBJZwzZRAGZL4Pcc8XLamvIuRD53Rq6snPtKBb2BFaoTk/iZWW3mLfhxmH3
 xrWiGoj3Ra0Lffjb5VwRPONwRpyntYQmnX7ualBYxsx8hremwrSCQR7Nhuf8bpRDiaZA
 uO37LBN5tKwq9/nnJzihjMsut2f6dYZGKdfS5iyiWBv1v4mCOQaSApwG29fw7EBpSv/5
 wUFBR0I000p87PYMFQNMWFtr9i+bycNh37xbP6YRBqKygMopSoz1aVO7FgjJ4PU9yNsD
 TpSn1xP+AiRBZ6Wi+5MhPRzljU39uUz5aAfzKmJdBKasrR5sQE5xnAbLu31kn9u+M1fi
 DeVw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DzBljjPY
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
From: Johan Jonker via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Johan Jonker <jbx6244@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A Rockchip NAND Flash Controller (NFC) supports multiple
flash devices. The SoC boot ROM only checks for NAND chip 0
and with reduced ECC strength. Currently only the read page
functions have this condition check added in the U-Boot
driver.

The rk_nfc_write_page_hwecc function together with a wrongly
placed rockchip,boot-blks property writes these blocks at
any NAND with reduced strength. The rk_nfc_read_page_hwecc
function however does this only for chip 0. Resulting in a
a ECC strength mismatch between what's written and read for
U-Boot applications.

rockchip,boot-blks and rockchip,boot-ecc-strength properties
require the nand-is-boot-medium property to be set in the Linux
driver. When the nand-is-boot-medium property is omitted or accidently
placed in an other NAND node with the required properties than for
chip 0 there is a ECC strength mismatch between what's written
and read between Linux and U-Boot.

Fix by adding the same condition to all read and write page
functions by dropping the existing 'selected_bank == 0' check
and use the NAND_IS_BOOT_MEDIUM option that was introduced to
U-Boot more recently than this driver to behave
identically to the Linux driver.

Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Tested-by: Hüseyin BIYIK <boogiepop@gmx.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V3: (Quentin)
reorder the condition
remove redundant sentence
providing the use case and misbehavior

Changed V2: (Simon)
fix typos
reword
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index ea8e67d1a23e..d23a651f3692 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -440,7 +440,8 @@ static int rk_nfc_write_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -560,7 +561,8 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *mtd,
 	 *
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks)) {
+	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
@@ -624,8 +626,8 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd,
 	int i, pages_per_blk;
 
 	pages_per_blk = mtd->erasesize / mtd->writesize;
-	if ((page < (pages_per_blk * rknand->boot_blks)) &&
-	    nfc->selected_bank == 0 &&
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks)) &&
 	    rknand->boot_ecc != ecc->strength) {
 		/*
 		 * There's currently no method to notify the MTD framework that
@@ -700,8 +702,8 @@ static int rk_nfc_read_page_hwecc(struct mtd_info *mtd,
 	 * are used by the boot ROM.
 	 * Configure the ECC algorithm supported by the boot ROM.
 	 */
-	if (page < (pages_per_blk * rknand->boot_blks) &&
-	    nfc->selected_bank == 0) {
+	if ((page < (pages_per_blk * rknand->boot_blks)) &&
+	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
-- 
2.39.5

