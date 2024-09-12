Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D2EE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A9D88E8E;
	Thu, 12 Sep 2024 09:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q8H3m/QD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D6588EF4; Thu, 12 Sep 2024 09:38:11 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595068898B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d50a42ce97so345539a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126685; x=1726731485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8RZhQjXVbrGcioasDbLp+AVUQWyudjJLwWjefxZm24=;
 b=Q8H3m/QDNPtW65esDeSxJVD8cYtpAXJpTPnBETGjSLB+RAL7bLRXwAhHSlhmyzMIzb
 KicU4ugYc6BDrY2RqhWCN1d7qzqZE10YBaRAqa4/sEqqu7Lgm4fpdukxHoSaL1YAk3J+
 /U9RaIJ0RzGWhl06lLG78GO+uNAzIPCsUqYmYms0mZ6QTZkkkktogOpaM8S9FvFgUXO/
 l6PTJS5pUyNTc0/GjkIGIw7zGpbmatUDN/zOkMuL+ED7kHMhzZ7LcMrlQdkYSqY3ZCYM
 4udeYBdM6O+LotMfblCqJzIWs2nvq9EoM8H60OxJnN/sAlRmkT/voI4VdeGiPbqNpQCC
 iTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126685; x=1726731485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8RZhQjXVbrGcioasDbLp+AVUQWyudjJLwWjefxZm24=;
 b=HkiA//6dNh1prCq5EjaJMYqpHWTvoDfFm64FER45CsA0gVwEOSvk9OReH4dgVwcLh0
 xG8kNDDFh1heaqB4ppCgb1Q6S/FgrgJZ1ULJg0SmILLH6tueabR1JgzN+zOMsFYMj0qQ
 a+sKIMsISO0409CxpaaSQ76SBPGabzmnI8ZT48RHWcJPIShrxeXF6/tf79dsuaXjb9ok
 /iwn+jirs6KilnS2/t25ILhFpAP6wd2lBsjneIVUbYNyi2b2BjftKS4mHLwFJTyfQSyI
 1z+I6N3imav46Rv4HvwZLlQPc96ut6v4W6oCTbsDQCokiM9X7l1LHK7ELMwAlshJAULX
 XeNw==
X-Gm-Message-State: AOJu0Yw6Wk5s5r6aRi/jbcL7y1hntDOVoMEzOSKzTNWfJur08K64rguR
 Tf8qqaGePiCPy3+4i/bK1RGYxEmN20Nh1ZFYqkdjn7LUkRd8GKhzfgq/iQ==
X-Google-Smtp-Source: AGHT+IF06Q2ndMVP/ZqnEFEOUmNJOr+Kkj7C9fhLYnUBtI0VEsT2spGMGTcCEuSOOBdoDWb7p4ke5A==
X-Received: by 2002:a17:90b:438f:b0:2d8:9255:396d with SMTP id
 98e67ed59e1d1-2db9fec68bcmr2634351a91.0.1726126684373; 
 Thu, 12 Sep 2024 00:38:04 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:38:03 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 2/6] mtd: spi-nor: Allow flashes to specify MTD
 writesize
Date: Thu, 12 Sep 2024 16:37:20 +0900
Message-Id: <51a2f71fd3da1fdb0bca56bc2be58ebdb4df82c9.1726126079.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726126079.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726126079.git.Takahiro.Kuwano@infineon.com>
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
index e126fa37c1..4dfc110b02 100644
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

