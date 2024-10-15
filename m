Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6B4CFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885E3892CE;
	Tue, 15 Oct 2024 06:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WzkXsFMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E877E88F24; Tue, 15 Oct 2024 06:09:20 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50F189292
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e6cec7227so999848b3a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965357; x=1729570157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqeJ6FavPgNZylmCvYnZ0rMS/1XU8LEeAW8PM5Pyczw=;
 b=WzkXsFMG+co7cSuh7o1LwKNyOIfdPufBuag7Q95y1Mu2sNRaI+OY/y9KnbkT251a3W
 NwRuDrx8WOEqFXaNYzVrivtjysFxahdLtaErGeXALztEZN7UgMZHlIqDzmLp4GBQfPDk
 gew4idYKiqKKLSXnoA+5kbyOK6JqJD3riqk1slO30q6dRMNBJeaOFc5arZmUnp0/NTlY
 rGBl439U62t0gWEH1ro2rVVEX0zI/673vT7W9UFj78mmj2FZhW6iz2VH312YstALOamN
 2DRqlZ2tY3P9SWiLEJD1svU2D/DDGvwA8S7g5OsTRUXHQfg/AIEdIWdl7lFsdfmu4SHX
 o5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965357; x=1729570157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqeJ6FavPgNZylmCvYnZ0rMS/1XU8LEeAW8PM5Pyczw=;
 b=Ce/iGJLVrIS7otZvMsn0pDjrwOg93rRGH3a2sfL/KBkbvUugWuSeTgreDytyqw1uuD
 lawD+FsIuc38YX2pCEd21WSq1HW0+LfBBqyPi0ep2bU/6cuy6xjicQg9n/puLxnW1Jim
 coBF8ArBkM1DvgB4+anBk0pMLdzxTUw+9VEJs5UMlgSHvlYPsjf60OqP8sNFZ0fnlJk4
 QEnjXqH7CdJKLHpXcMe9hXi2v7gcHbRWewXDJMsX2X1ULgT5C9KS76yhUJzhWBtpMDdF
 hJuc2rZaE/rlHwEEV86exFEHfm//RMA0jdqeR0EJVFF8fRU9cMYCpj/L0NLGe+XTCJqL
 JlUg==
X-Gm-Message-State: AOJu0Yx3TUOzclLjcO4f9J9H35t8t8Crgp3E0/xD1izBm3TrZYPBNN84
 0EDwvhDGHXD3IaJnTi0/Rc5QUvxEeCZSYr+ZAL7dYbNdS9bh1sNajnuVVoxQ
X-Google-Smtp-Source: AGHT+IGCayW4IysFJgS9huadIb/i6mLQBzKRZUy1kDg8bLPq+3vFf3rJCiMJnCZ4zsJsWKk6TMGNMg==
X-Received: by 2002:a05:6a21:393:b0:1d5:14ff:a153 with SMTP id
 adf61e73a8af0-1d8bcf12232mr20095520637.12.1728965357166; 
 Mon, 14 Oct 2024 21:09:17 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:16 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 2/6] mtd: spi-nor: Allow flashes to specify MTD writesize
Date: Tue, 15 Oct 2024 13:08:32 +0900
Message-Id: <a52b790bb143597ee6febd7ea64967e0d372681b.1728964655.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728964655.git.Takahiro.Kuwano@infineon.com>
References: <cover.1728964655.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Some flashes like the Infineon SEMPER NOR flash family use ECC. Under
this ECC scheme, multi-pass writes to an ECC block is not allowed.
In other words, once data is programmed to an ECC block, it can't be
programmed again without erasing it first.

Upper layers like file systems need to be given this information so they
do not cause error conditions on the flash by attempting multi-pass
programming. This can be done by setting 'writesize' in 'struct
mtd_info'.

Set the default to 1 but allow flashes to modify it in fixup hooks. If
more flashes show up with this constraint in the future it might be
worth it to add it to 'struct flash_info', but for now increasing its
size is not worth it.

This patch replicates the following upstream linux commit:
afd473e85827 ("mtd: spi-nor: core: Allow flashes to specify MTD writesize")

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 3 ++-
 include/linux/mtd/spi-nor.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f5395c7b9b..d39d0ee7813 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3081,6 +3081,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
+	params->writesize = 1;
 	params->size = info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
@@ -4499,7 +4500,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	mtd->dev = nor->dev;
 	mtd->priv = nor;
 	mtd->type = MTD_NORFLASH;
-	mtd->writesize = 1;
+	mtd->writesize = params.writesize;
 	mtd->flags = MTD_CAP_NORFLASH;
 	mtd->size = params.size;
 	mtd->_erase = spi_nor_erase;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 047e83e8463..1ae586b2e5f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -457,6 +457,7 @@ enum spi_nor_pp_command_index {
 
 struct spi_nor_flash_parameter {
 	u64				size;
+	u32				writesize;
 	u32				page_size;
 	u8				rdsr_dummy;
 	u8				rdsr_addr_nbytes;
-- 
2.34.1

