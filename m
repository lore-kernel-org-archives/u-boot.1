Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA50CCEBF67
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13ED389043;
	Fri, 27 Sep 2024 03:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAMPyu+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA7E88F83; Fri, 27 Sep 2024 03:18:28 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62C488E39
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so1011578a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399904; x=1728004704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJM3yAEWIIJ4mlPg+DFN3QkwwuTU1vvoesh+c4RryNE=;
 b=SAMPyu+5njVtb9ms+7kwEPvVjzRknWmtOwgxmN+3tfuUD+HERdInO37Hk8zNA2jsRZ
 30e+dxKauAxCgTDuK+ByeGtrKRn/HGXZbFmmGrBIuiA9GiicXNj1QSJNSqyOxzSgQ7/U
 O7iS9oIi0ZhKDyN6+DoUDkAhg/qp+bet4XW9QiOdXmMoOB9yPevXoLNtsSxWwZNlwie6
 iwajkEP5ObyJjoDPSwh4rKa8s61pHqRd8+cjFrbIh73xgxXC+/Sq1xlOLHfLGKII/WRI
 TY0AE5tGgL1iU1xz4Q7VbJCfi2JsW3hqD0xIASAklrHxjHy5yv5bBi2qC+VDBBdea1SJ
 QFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399904; x=1728004704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJM3yAEWIIJ4mlPg+DFN3QkwwuTU1vvoesh+c4RryNE=;
 b=REwWV5yj9nFANMqe+WGjSAVVWdLh3/1BdzqpeNGwmJBBK9sUCkGas2X18Lz7Exsf8L
 5zb8ayezSRVq18O/iPeWYJV1piWa0grrB2VXRzQOfJlw/6eXgn+JxD2fxnnSsHbqlbI0
 rHVkLGOfjc9+dZ+qmtVSSMd4Rkdp404kupgAq/AgieOHyCjlV9E12Aknh4saQ6tyCscG
 mrB/ZNuXik750s/S4OO9C0OLyPrQ9LGnB+tBEG2GeMfpRQKqyu8LFl0BmEK3nEjz041H
 M1JZZDkhVrx+EV86aWoxwRQ/rvmf1LETUUS7DUsbuDesVzEawOdMaCWwskGhe+UproFD
 +LEw==
X-Gm-Message-State: AOJu0Yz0KqoMxi2H5zynlnMsXlrV6unqFpj0Ucce5ft3P0vEdZyljetD
 UYxnqFjBNIvg4hKewb38zXoY5BJFZ0eySe6Avp1BQH64a32NkxYpl4ARcg==
X-Google-Smtp-Source: AGHT+IFvJwquf2eDDfw2LRjqBuEC6ymUJeJZQxWJu/QRE5NEI25o0KnBxba5JD12WWkJi9F/nu3UmQ==
X-Received: by 2002:a05:6a20:d521:b0:1d2:bb49:63ac with SMTP id
 adf61e73a8af0-1d4fa7ae4b5mr2061067637.40.1727399904115; 
 Thu, 26 Sep 2024 18:18:24 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:23 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 2/6] mtd: spi-nor: Allow flashes to specify MTD
 writesize
Date: Fri, 27 Sep 2024 10:18:07 +0900
Message-Id: <b2468777053f178bd1542e4b83ba4c6c8935468a.1727399650.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
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
index e126fa37c16..4dfc110b02a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2839,6 +2839,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
+	params->writesize = 1;
 	params->size = info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
@@ -4142,7 +4143,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	mtd->dev = nor->dev;
 	mtd->priv = nor;
 	mtd->type = MTD_NORFLASH;
-	mtd->writesize = 1;
+	mtd->writesize = params.writesize;
 	mtd->flags = MTD_CAP_NORFLASH;
 	mtd->size = params.size;
 	mtd->_erase = spi_nor_erase;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadbf..0d37a806c49 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -436,6 +436,7 @@ enum spi_nor_pp_command_index {
 
 struct spi_nor_flash_parameter {
 	u64				size;
+	u32				writesize;
 	u32				page_size;
 	u8				rdsr_dummy;
 	u8				rdsr_addr_nbytes;
-- 
2.34.1

