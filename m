Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913BAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D4C88EBC;
	Thu, 25 Apr 2024 06:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WiPryiGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6F888EE5; Thu, 25 Apr 2024 06:53:50 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B366F8803A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso5124795ad.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020826; x=1714625626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SRnBPcK3mQX7rciSQs9F6iCzhqOkJVLI9rng/ugAVk=;
 b=WiPryiGzC/3Ache/nHmsmzpsecWT39Cl1UvVDUg4aKpTd4MNk1UE6BomdW/mjTqJPW
 su7S5Cx3WLFspleeQGNMlFrUnDTlfssOy8fvGgzIwgaXV9FoITw9wIa7TekLJZU7X8uO
 28C7941j/jphuZT24j6qTynIrnfAN72I0GV/kPGd/UfRXU6fp+P2wIdXqVcfq8szth0A
 eHV9zAzbHzXiGOoS1RArFxoEngE99fB7JU150I2LvF52U7nkLQBgXUJb/HD+XrH9aiz9
 uls2QgmK5tbM9+brv995zRoIDYYeIeMNpF/mahoD4g7GjAEucpxS4oHlI+kAZ8JfZSY3
 0uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020826; x=1714625626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SRnBPcK3mQX7rciSQs9F6iCzhqOkJVLI9rng/ugAVk=;
 b=eJFH+uLtT/UN78xzrOFa8fFtt8ChbYnXwuPxOeLvw0Yx4FJfWhSWCa8FogqcTItJSl
 6PT/0myMGmOxbUunnhB3Da3/WYj1JVRZ4Ce5L0Vh4hq56xqIfZxytRmGAuDgNeCd7s13
 /saS91PZw8bQ218UaJx3En/25lLTAlChWJtfoNznilRzaJEX4S079LKtyQrIgxPtTKcE
 X63L0OxnbJx/x959BpJ9b00zIkFKzZzu4PluKd+WZMFdi6BYTILbOZQM6I91scbTE0s7
 XhU/I6bOtZyoo5CdNhBwgfFi3pKEj+yAcICraKKUkQeshjZWcKW04ie5fenJynoKJzTz
 7t7g==
X-Gm-Message-State: AOJu0YxIcqop8w4WBIz7AmlwMmTMSfIw4OqLy2q0Au+HmUFaEps8x+iW
 fW/nJwBiZuePuGOcaOqP5zqdXcsAq8JbB4gtMCbH6gWDV5ZpZZg51+RgbA==
X-Google-Smtp-Source: AGHT+IFNMgrwKDTwg9eNtXmqtseJ4BAy+pAyVn8Z/Lxxi1vxRlUouxXWGUQ7Pk1ljVTjdB0UO5l75A==
X-Received: by 2002:a17:902:e885:b0:1e7:d482:9d96 with SMTP id
 w5-20020a170902e88500b001e7d4829d96mr7390608plg.10.1714020826202; 
 Wed, 24 Apr 2024 21:53:46 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:45 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 2/6] mtd: spi-nor: Allow flashes to specify MTD writesize
Date: Thu, 25 Apr 2024 13:52:12 +0900
Message-Id: <31d19c3333257717a871cdd6312b80b7a9fba0a8.1714020303.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
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
index f86003ca8c..1bfef6797f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2789,6 +2789,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
+	params->writesize = 1;
 	params->size = info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
@@ -4078,7 +4079,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	mtd->dev = nor->dev;
 	mtd->priv = nor;
 	mtd->type = MTD_NORFLASH;
-	mtd->writesize = 1;
+	mtd->writesize = params.writesize;
 	mtd->flags = MTD_CAP_NORFLASH;
 	mtd->size = params.size;
 	mtd->_erase = spi_nor_erase;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..0d37a806c4 100644
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

