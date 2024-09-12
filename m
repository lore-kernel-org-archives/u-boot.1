Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB898EE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDA888EE2;
	Thu, 12 Sep 2024 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSuG3doX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE8E88EFE; Thu, 12 Sep 2024 09:38:13 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CE788EF2
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-206aee4073cso7456295ad.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126688; x=1726731488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZLKvJEaFTCGmmzKbsUZCaX8yX3q9M/VQ+KeEDvie+A=;
 b=KSuG3doXcdei6zxTsjEK/NusY2HgLd6aaSjrVW1n3qyxk7AWJci0V4KxurXe2w/8Uj
 1l/DNW+SH2GxLTlQ1fBewsNMLMLNFOv02zfKiM29/MGr+cJScxkynk67FabichWAWJk2
 tcgchQy3M+QJZF2x6Loce/SKn/5EgAqJPF0qTPdIFMDJt5WdDSoR7osYdKGRwZBojwYs
 sYtShOCpLqPWAByuxdEjocjvGFY/04TbBp3UqqbfLpVqNUBtmgWGhilAWPZ++Y1g68JQ
 Z0y5h3vRI1t1hdLyk8K3YXnjhfje3zOCVi77Q/77BqPf0H+aORsytHG0eqg/ILq7/Qt7
 axrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126688; x=1726731488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZLKvJEaFTCGmmzKbsUZCaX8yX3q9M/VQ+KeEDvie+A=;
 b=ROvyK/Zf8BY2ZZrd4cJRwwlWR5OUhagVwwxv5RAxuLYh2VN69y8qKYoVUMQke/2b3+
 yX6fCP0WCEDWOQvflIrGY8qguw8xqkN+UjqYfqFtKp70tTHLAN+GcaP7V52kaeh6ascr
 KvngqDy6X4JykuBzNAHxBxCoozLxKIhXYzaAL1U+9WjlCZXorBlHaWDhBmHof5e231UV
 nO8RY7fR4MeOVjWg+Bf81THQq+AM4POpnhNBP/Tt2oxRjpVxzDK97wQCzoad3efAAN5M
 Apzw/94ntTCqE5gbkRsspZME+35WHd4D99zL4LdxYRU6g/gv7WlRF4jXpOZN8U4A5o8y
 PmQQ==
X-Gm-Message-State: AOJu0YxfKWFaFNaHUJV/QR6PJnXegQRwVeBAPLZC+xVjf9HLAHlfLsmx
 DI9YtTrT57ijXt0vZKfM3EUCd8VCt6/El6fw2cHlQ8ikWfbTIvcRWAnyow==
X-Google-Smtp-Source: AGHT+IGN+wZxBF9n3oWOlqphiFuBCpd/vWO9UpIHyWScFwowJDobbv8nCZYrccy8BcAbJEsW/g8N0g==
X-Received: by 2002:a17:90b:110f:b0:2c3:40b7:1f6d with SMTP id
 98e67ed59e1d1-2db9fe8d7b7mr2815584a91.0.1726126687892; 
 Thu, 12 Sep 2024 00:38:07 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:38:07 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [RESEND PATCH v2 3/6] mtd: spi-nor: Check nor->info before setting
 macronix_octal_fixups
Date: Thu, 12 Sep 2024 16:37:21 +0900
Message-Id: <cad151ed21d4ad55f609f117fafb81a358fb87cb.1726126079.git.Takahiro.Kuwano@infineon.com>
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

The macronix_octal_fixups should be set only when mfr and flags match.

Fixes: df3d5f9e41 ("mtd: spi-nor: add support for Macronix Octal flash")
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 4dfc110b02..6eaed3da39 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4067,7 +4067,9 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-	nor->fixups = &macronix_octal_fixups;
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_MACRONIX &&
+	    nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
+		nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
 }
 
-- 
2.34.1

