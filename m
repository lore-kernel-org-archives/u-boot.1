Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615A7CFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DD8892F2;
	Tue, 15 Oct 2024 06:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csKBpT8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3AA892F8; Tue, 15 Oct 2024 06:09:39 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E60892D9
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso1333647a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965376; x=1729570176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5YwUgQY0FURG90/A8f5KwFxQLdx+EEFNTa1Pu5btBw=;
 b=csKBpT8LPTZpnUl6yv1jFnQV0ZDQbf8zFtQ66K16beTLsEeuix45B9upXgf6qfWPc+
 R6GV0GrVEQaEYeGAHd04/7Rnh0GaIJq/j7L85RPuURhT9tIPUBDxs97dVF8qA5nqL9V4
 36vdZEEQc2h7wsWkmq7IVrHYWyPOT1D/fZh7cV4uQcqQsw9gI578238oCxZ8Ss2LTIgE
 BGNbRYugdU87URTUS5SmOxdyD4LHe5C05uM317LTdQtxx+BD16JeK1yDJ+YbWp5qRxIY
 W9Xii6nO96UPuO+gsc/jLA9TP6fEE20u6C6XaxM/+i141ynDFi9IUR5/q7AKiL4qTk7x
 Aupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965376; x=1729570176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5YwUgQY0FURG90/A8f5KwFxQLdx+EEFNTa1Pu5btBw=;
 b=YEwlmg6WLjM/I30gzk/mtabCTrGEhhUlRJEDGbB7eYpS+Ims2YpAgJ5RT+aZEYYUx+
 OulotLQZyFYL/YEIAanPmjS5C9jhyDtU6D5EqhN3erPCYX4n3fkGKdOFEA7MENpGutAt
 DZvg+Jff+KF/CZu7T4a7m39DzUyK4Oxpff5KOP9lLTgRx5kuDKM4MvzAfpA7DQhL5/U/
 EbmQTimLwNfFG0kaT4pBQoVt1LQgTWcjF16U1hPnQ1Ct/ISdb8sayxzTbVFmF5jpclqG
 SvNu1o54VskUa5XFUxZs6gVEMmSt5vv3jZkhsj4WO5AkwfrkIhApaSLobyV4ptCp8IQ5
 /4Qw==
X-Gm-Message-State: AOJu0YydoV0LPxZGzvyynD87yOmYCXjU8XdSE5YRFdoWCN7HZvogMok7
 mx2btpXILhtRSF6h3c7gJ7NqtxHP50ccacMCPomwolpaC91mfhTTVBlkY2fr
X-Google-Smtp-Source: AGHT+IHN5Om6OmdMr1mfHjhwYvXdbytbMNLcVtUC3L0wbiTtBYu5bRLKgmy2OwxlpeddSSKWrEyY4A==
X-Received: by 2002:a05:6a20:6a04:b0:1d7:e76:6040 with SMTP id
 adf61e73a8af0-1d8ae082fd4mr27198616637.4.1728965375802; 
 Mon, 14 Oct 2024 21:09:35 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:35 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 6/6] mtd: spi-nor: Set ECC unit size to MTD writesize in
 Infineon SEMPER flashes
Date: Tue, 15 Oct 2024 13:08:36 +0900
Message-Id: <377d4d69bf45734c60e7d0ede3ea0c516a11e7c6.1728964655.git.Takahiro.Kuwano@infineon.com>
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

The Infineon SEMPER NOR flash family uses 2-bit ECC by default with each
ECC block being 16 bytes. Under this scheme multi-pass programming to an
ECC block is not allowed. Set the writesize to make sure multi-pass
programming is not attempted on the flash.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 46af9b4fe47..f5c9868bbca 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3855,6 +3855,13 @@ static void s25_late_init(struct spi_nor *nor,
 			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
@@ -4019,6 +4026,13 @@ static void s28hx_t_late_init(struct spi_nor *nor,
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
+
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	params->writesize = 16;
 }
 
 static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
-- 
2.34.1

