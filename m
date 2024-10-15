Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E52CFC264
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E486388F24;
	Tue, 15 Oct 2024 06:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TfN8aBZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CBF89292; Tue, 15 Oct 2024 06:09:25 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942AF88F1B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e6f1a5a19so808744b3a.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965362; x=1729570162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxyz1zw3znPnBC69RI0Q1KtTAu8Qqvo5YNG6P8WMHK8=;
 b=TfN8aBZOhZCcjkONbff4mMh6NBFNnJGtKOI5RKtG/10bml8vN4GoNiPck2xwNWvRfP
 HXL9Q45mYl4ouBolKMI0ZMmjoiD6IYwdmetrjj2uv2Q0xwCoQbZSwdQMgIFlxW/zyBcG
 jQSxKJOZI4jPkLsHfVBAEQfhguT8RgUyz6yRleTHxCdyMUywm/ZvPIvcm8yMyPgtKy6k
 +CqsmXd+UN788ccLc+5Wry8aZrXwoYgVVgk9zgMbXeARj8I/wYV0sr+rHGI+UQXdi0VZ
 mYWW5O0ReaqMccOY6Wia42uocJSO1bNJOneWAStusaD6Ham+3x19TCKyppVNIups5h37
 a/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965362; x=1729570162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxyz1zw3znPnBC69RI0Q1KtTAu8Qqvo5YNG6P8WMHK8=;
 b=dPqBaNJeMPc8j6V11hXuteZ4/Gl3Amm63RmNe84RiWKfkllK13TxeaJVCrziXbutpR
 BRc2q821o6Lbz1J4deur7mCyvZUL6OgRWiIyeh7ddPC4aqy3G+Ajgks+zdI2hJ8Ima8j
 7wp+9vNLdj4lEoX19cWgpitl+6cSvvAjs0udYbq+HEk0pJy6WLZZKlKVvI06AVlTvSKG
 UhtFOU67vnaa2/MDalbDF47QSKl4vIep9RTfcT2Kqiz7ke+YcZU/pliraHesbqz1cR5u
 k12V5O9K1SFFgKowidgOMPynLt3lRhq9nFed8v8OnhkK3ZUQ6pEak8OilRXhaUxCZ14t
 phlw==
X-Gm-Message-State: AOJu0YwOJj04By5Mxpn639c45zdjhh9lIngNJY5qsBf6tEkCDjRM4Wfo
 jkQqwsREdS7p0nc5x1lf23BWwUX5KezDkh4sKfjXxaSVF2GfaD4UUOrbJlnf
X-Google-Smtp-Source: AGHT+IF4DwVZnMluRns7Mkdbw43qLBsGORd4+IatJvnQSaK7b2VeOVSw7FRtAn60dFZyBCYvnJJyng==
X-Received: by 2002:a05:6a20:bc99:b0:1d8:f867:e43e with SMTP id
 adf61e73a8af0-1d8f867e590mr612182637.18.1728965362020; 
 Mon, 14 Oct 2024 21:09:22 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:21 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH v3 3/6] mtd: spi-nor: Check nor->info before setting
 macronix_octal_fixups
Date: Tue, 15 Oct 2024 13:08:33 +0900
Message-Id: <51e572fb4646f69901ddb34ec2174560ba6ab30b.1728964655.git.Takahiro.Kuwano@infineon.com>
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

The macronix_octal_fixups should be set only when mfr and flags match.

Fixes: df3d5f9e41 ("mtd: spi-nor: add support for Macronix Octal flash")
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index d39d0ee7813..466729cd2a7 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4423,7 +4423,9 @@ void spi_nor_set_fixups(struct spi_nor *nor)
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

