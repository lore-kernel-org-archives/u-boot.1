Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC77C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 04:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF568813F;
	Mon, 15 Apr 2024 06:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RFse5koq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC6488152; Mon, 15 Apr 2024 06:33:31 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E4287F4A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso1637416a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713155608; x=1713760408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVABp0aj/N65+2OS5Q6ckzzUCIj/U2v0s8DfimTFZzc=;
 b=RFse5koqI1FCC3q/Oit3S0ZViogKuWfpLa2plIBwNYd/+UWFktgrc/Tjk4koFSTN/c
 J7lRrOXAooaqtJ5U7AbMBaH3NuRaiUETm8HzO8CVikwPW/5fqC0OdCSiejWM/YmFjmv0
 jMsCsL1x9c8Slq1XC5+YKOj+gxjYTM2cVKmINVkQi2viDVCOOYyYFRLySMjqWBHXZjnz
 AxvnJS976qj3xocUkldwTXWWa58JBcaiLxj0K9O1c2/PkgIzxFLl9yUu2QZ7CopyV97V
 5+VX7PJ4bJQc2xnEs099wkx1WsPWP3lFwGCUpkCMp5TgNE8AwhLvj8HQGWIQhn+Smn1z
 Ty4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713155608; x=1713760408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVABp0aj/N65+2OS5Q6ckzzUCIj/U2v0s8DfimTFZzc=;
 b=a3lze9YLFe8/ERJOVGh1QEb6DW3WfX06f9R/dNMQMCDd4646CpwejQgXmZjg8w95id
 kR/JWOeCa56Fgs0CahSyanJov3B/NHrYTfBQV8fPUt/4RZpCmJPZ79iUeY5h9fd5J+Sd
 1CCohXkxt53YgGJ9fhTUU9jkaxAnQe2DDNmPuSauWSD2nmm1KvutC2C6KYUSCfAVwRWo
 s6sIL2LHzApiv2cKlpdoiVcOSKwNLC9laNzNQXN3iEwrZvSoqKCneScwkcOm2NSyb6zH
 P7yYB8iLeb4Yma3uJH58B72tLCrZg7NWBddxfRQPHQ38hc17MsmJilMekSGUZO33ohTn
 X/xg==
X-Gm-Message-State: AOJu0YwiRyNkJna1gbSLvxQbX5F2N7AZhXPz+7UeEtJ4+H9m+tLIwbFu
 iWsn0aOAi5TKV0FX++acBvHvSICtktz7pJT7IR+c5qRF+GCwiu7M1PuLiw==
X-Google-Smtp-Source: AGHT+IFVcRXeIfRjD2LPFWmk6Nem4pepg4V6DO6m/RrNKx25tj2EUmG2gAKzFcaGBrIQRqgqyOaWWQ==
X-Received: by 2002:a17:902:d4c7:b0:1e2:1805:52c5 with SMTP id
 o7-20020a170902d4c700b001e2180552c5mr11097499plg.16.1713155608087; 
 Sun, 14 Apr 2024 21:33:28 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm6902682plh.290.2024.04.14.21.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 21:33:27 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 2/4] mtd: spi-nor: Allow flashes to specify MTD writesize
Date: Mon, 15 Apr 2024 13:33:09 +0900
Message-Id: <16e3ddf31a406f6aa4dd8e8267ef5d2a329678ea.1713154967.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
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

