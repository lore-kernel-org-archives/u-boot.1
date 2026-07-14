Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAC0C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 06:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BE7846B0;
	Tue, 14 Jul 2026 08:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LVW7OKt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CF084B49; Tue, 14 Jul 2026 08:39:50 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6782A80517
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 08:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15c193ee65so29861366b.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784011188; x=1784615988; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rexpfsDDOFyoGupOhZTv2h0p41XgOIn4QrbCiGFjkQU=;
 b=LVW7OKt6y8GuhlqZB+ssqw1dk5AgUNK/WfO94unSo+xg7W/vvQ9rk136iVDqrDD5hO
 /N5Ntg1sTNkX/TGH7Nju/mPcYsA6XqAdI4GzVDr4NTwHYvYuu4cAFRbCu5xTaY2/o08a
 ypoExOZxW23U8k7eJhbxn8cHYo05wYwQSUYDBJFeAvwxhWp+dd7t1FUWWi9Pfl+Ik8x4
 ppR3MAC96aqf14YVeUp49zLJWgBGw42fZhXISfRBbs7r64Glwmpx6gM0M4HDplN/qm2f
 KzKpVBfsTrlcJRJTS1Gm8EIx1shRjJTZwPSxLP+IrwIRkRizL8qC7xwDiTV46cAqmrDz
 PjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784011188; x=1784615988;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rexpfsDDOFyoGupOhZTv2h0p41XgOIn4QrbCiGFjkQU=;
 b=QqYbNSqToAQuSZdv2xEX6qmdLCdfHs80goOtEoHRN35hlnvloZoN9kdP5asUV7loqD
 2ZB3UCQl0D8RQSwiEjjG37PTscEhigDUOyux/sxsOVUy1Azk5eyETx+RbBuiQ8gAKhAa
 dpklF4vEASkoq1N3TZ/c6r5qDmKonmsfaKBbjgUmRROVdczN0UZlDoPGTZSg7FkUHjac
 DMx/otNC31NGmhp2S2BCMPQWW4yIw2py2LzDUp/VlJptCoP3hXxWMhGdgvOALkIoDFZQ
 6adGECtGEXcymBBKO8aTXWmlc4Saw+yQAMdhoYTaycmM1e9xbuP4dT/61Hvr+NeUO7KF
 Tyeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZ8EZae/XsLlBeyWB29x74CinQuX00/Au1izFetsgXspEsjRUjsy9pFs+kkz5Rw3bEfTK+a1g=@lists.denx.de
X-Gm-Message-State: AOJu0YwBkdmnHEgHOKoIYNwS938XRN7ao4urLyzwRd5vvIjRK5LFMjhD
 7T3955cSlGTwGy3apa8aGyXO9pE6hogkXf9zaoDpxVThR6y0B3k5asg6
X-Gm-Gg: AfdE7cm4g7jDdtF55jS8PL5lSgNBdRdHa/rJp96gZYs7+cUMtQJkZ3wZa6UEklBqish
 1A8xcEcLEjFZH4ZN56ARNMm8lyEANzGUTHaavd7+Ndr9Aq93AZ5fisIHykOfOGoPXRg2gIt4f/u
 97oj4Gdg5DIy+BB6dIGnRSiLU3qvHVbXTaxyZROlch1qZ6XTn4iA2Mv+eL0cX06bG0fO6QOIucy
 GJlG638ghUkMt0bLsbuI5nHE3Rc112ujiD/MC5yO7ciLmbujhUa969YEcnJF6TOOOxQqsYJ6d01
 FJoCuA4Lsf40Dpcgl56khqJ1zy2NY0WrJats2fVIFGr0NhhThm+7c9qlLuu3p67c/dnJFf+46e5
 h8vZYHJtizlxiXD1o89JJizbu4N2cGH29ErcTUNNUkvhQAoFezivkvyrBqkqNVFmuRMFxj+9nnv
 7I4ivLu1BlG/rSCU/LvQ60/Ow/9NviZGDD8ZS6PZnCfCdWNiOypyU=
X-Received: by 2002:a17:907:97d1:b0:c16:66dd:c356 with SMTP id
 a640c23a62f3a-c1666ddc72emr33747266b.5.1784011187542; 
 Mon, 13 Jul 2026 23:39:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c166ab49e3esm14731166b.51.2026.07.13.23.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 23:39:47 -0700 (PDT)
Message-ID: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
Date: Tue, 14 Jul 2026 08:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
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

The Rockchip boot ROM only checks for NAND chip 0 and with
reduced ECC strength. Currently only the read page functions
have this condition check added.

Fix by adding the same condition to all read and write page
functions by dropping the existing 'selected_bank == 0' check
and use the NAND_IS_BOOT_MEDIUM option that was introduced to
U-Boot more recently than this driver to behave
identically to the Linux driver.

It is now the users responsibility to apply the device tree
property "nand-is-boot-medium" to only NAND chip 0.

Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and others")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Tested-by: Hüseyin BIYIK <boogiepop@gmx.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V2:
fix typos
reword
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index ea8e67d1a23e..e788fda22a95 100644
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
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks))) {
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
+	if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
+	    (page < (pages_per_blk * rknand->boot_blks))) {
 		boot_rom_mode = 1;
 		if (rknand->boot_ecc != ecc->strength)
 			rk_nfc_hw_ecc_setup(chip, rknand->boot_ecc);
-- 
2.39.5

