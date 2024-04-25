Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3AAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C195888EB1;
	Thu, 25 Apr 2024 06:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVZAHMit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49AE88E8B; Thu, 25 Apr 2024 06:53:53 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605F588E69
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e86d56b3bcso5075495ad.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020830; x=1714625630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qejPXogi1HG2Sz6zTJizv/M2opZVnxSej+EpL/yUW/U=;
 b=gVZAHMitPTL+c03nr5mw5w6UtsHhUbEZy1vdevMKqa6YTfKkZHOhnULl9qluVzHb1F
 ns7A5v6yuywPYumHs0ViB5RdfLKSV5Dny1t7RosL+uB14MnkSLkUBC+KUaRE8z6lV6xh
 h/vPR342YrS7uJCV/NU9td3vPj7XFHYhOSbwBVe8b1ndse+AB/Ui/Ge+rBM66vmaXK/5
 HQsg2Sy1Y9+TmkikkgWjvlOaKqfRenTOp5ilklLGSuLsxI7lIM4vrIlhr/SfX2IndX1V
 thTmoq8JjZtpTRHAXTT8OL0x2N91OkVjxwh8dAni3nLpi26VqrSl5foG+CykKf2dtb7k
 j/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020830; x=1714625630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qejPXogi1HG2Sz6zTJizv/M2opZVnxSej+EpL/yUW/U=;
 b=kKfhs6JNtwGjKumH/E+Yz5Hmx7XWbEXLDwy7DFEQhfPDeD712tZvX1IHxtlwhKRQ2J
 pZotuqjWOuwMwkJHQ88Fe6VhxGsKCIsN0+FI0UcCWcu/l3OLPQpE9vmRKKyKle3gcVZ/
 oSSQ1ByGmiS8JjNbQqbfTguW7ABrIjPenqo5//U0aC9vUqoz4+IMj71CkHZFPM6pmUqH
 R0RuOB5gG8THmdADlIz+D9BNKb7dK0Z+3CIpQBrJ2mKWQuX+4GLrV31QPN63wYeZ6Qqq
 m4jnXtAlcUFiP8OJQuiF3BXAxz32ZlUlMCr26Db+i4o1WAaIT5KjNLvj0/YYxLq5F8Wj
 6PvQ==
X-Gm-Message-State: AOJu0Yx3v+NnaGFjRoIIbyp8wLt1hcnN+8Gw/pLGwCXjUEqJZOL+jn1l
 mzjMc9XYN6mBtYl86tvi57Cw5V1T8MCW0UXwC6LcwPVZnyw8OFvxqSlJDQ==
X-Google-Smtp-Source: AGHT+IGF59RODUUjoIRvdomuhk2xwldARRbu9EXlDmY/PavUoH8JP1rc/EAQJ4+M/T+Av2mZyp7EDQ==
X-Received: by 2002:a17:902:d3c5:b0:1e3:f27c:457d with SMTP id
 w5-20020a170902d3c500b001e3f27c457dmr4528216plb.65.1714020829879; 
 Wed, 24 Apr 2024 21:53:49 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:49 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH v2 3/6] mtd: spi-nor: Check nor->info before setting
 macronix_octal_fixups
Date: Thu, 25 Apr 2024 13:52:13 +0900
Message-Id: <8bd7edaaeefd69eb9bf2fa469ddbaeebd2433013.1714020303.git.Takahiro.Kuwano@infineon.com>
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

The macronix_octal_fixups should be set only when mfr and flags match.

Fixes: df3d5f9e41 ("mtd: spi-nor: add support for Macronix Octal flash")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 1bfef6797f..c2d2ddf0c8 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4003,7 +4003,9 @@ void spi_nor_set_fixups(struct spi_nor *nor)
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

