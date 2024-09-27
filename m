Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2CFCEBF67
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9078688F83;
	Fri, 27 Sep 2024 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mmNSxx85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD1E8902F; Fri, 27 Sep 2024 03:18:35 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F04988F83
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718e6299191so903421b3a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399911; x=1728004711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbCDTFVfB7dDBRYQWhyEDeHfowz1+0dxHcYUGVfcbkA=;
 b=mmNSxx85+/KkfaUMK6LYJ+soBbkcANU+iEoPYo3QAZBSX/lvVcoGuMID3FstKOcajV
 lCGfMdEiaq36u94bNMJoTaNpLhp57eDc26t37M/5AIpnVKgOLsssKZzfNmYZRkwtYpye
 cXV4Q5A9M9DNFGuyiaBSozcl5zEVv8I5wvjdHUop9S924AOMU9prkaGKwLqxaNqkj7DY
 8XX7USna5coENi6kWW7VyTls8hpLXufYSQ9vcsFUwwNd2pnJledJhUb8aRFd48NDDizq
 OmVK/9FPubhP5NHrKyV63YzTenWWTvarMpKSaOeIn9seCEt0bSvYVUYxOyWx1qiFzlLc
 tRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399911; x=1728004711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbCDTFVfB7dDBRYQWhyEDeHfowz1+0dxHcYUGVfcbkA=;
 b=o4wpBvcuSSCOp2N3dBEAK3Dc2DI/FnSjlr4nOcNrKHbQHmbhvvVcPyN1MDSemDWsx0
 RLcLlyQj7m0nJwgEtzPU+15mHRPABCvm13Hv0LvYI52USTqI/oc8fXDVGdNHuqSILFyI
 x+EDyARjl88CzdYrO8c7n3K5yKCevXY9xRfKSJPx+hkN0jnXn8Gn6/WTmsjXX9IeNX2k
 7QZe/XC4JHe6nENhvznrWjQD9wzXpMMGyqcfnlsElLksvOGbHljE47/xAWjcu4ORbalV
 Buyr4xchXk41ommyfDMKSKlEa1qUaX8VzKBTUr7vqjc7sIeFlFBfVn0zKdaPr5M3hPUy
 kZsw==
X-Gm-Message-State: AOJu0Yy2jdQe5rO8NsovLoN6t/oe4LQa03IWXPnRBR+w6p1HSySUXcb0
 PE2G/+zf0sdhA1oWAAhFrdsm3vFxDbm6Ctq6mT4SfLOH/iGJiob1KzTLYQ==
X-Google-Smtp-Source: AGHT+IEWxTMO8wlfEqVNA6qiTIFh5nZ2eH4hTxyU9YUbexbPILL1KOG45J/qRP107NIUI3SXY4io2g==
X-Received: by 2002:a05:6a00:2195:b0:719:8f48:ff01 with SMTP id
 d2e1a72fcca58-71b25f28598mr2358853b3a.6.1727399910663; 
 Thu, 26 Sep 2024 18:18:30 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:30 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 4/6] mtd: spi-nor: Replace default_init() hook
 with late_init()
Date: Fri, 27 Sep 2024 10:18:09 +0900
Message-Id: <cdcd9297f819eea537b41cec73af13eb358e4d8b.1727399650.git.Takahiro.Kuwano@infineon.com>
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

default_init() is wrong, it contributes to the maze of initializing
flash parameters. We'd like to get rid of it because the flash
parameters that it initializes are not really used at SFDP parsing time,
thus they can be initialized later.

Ideally we want SFDP to initialize all the flash parameters. If (when)
SFDP tables are wrong, we fix them with the post_sfdp/bfpt hooks, to
emphasize that SFDP is indeed wrong. When there are parameters that are
not covered by SFDP, we initialize them in late_init() - these
parameters have nothing to do with SFDP and they are not needed earlier.
With this we'll have a clearer view of who initializes what.

There are six default_init() hooks implemented just for initializing
octal_dtr_enable() and/or setup() hooks that called later on.
Just moving those to late_init() does not change functionality.

Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6eaed3da392..e69a25195c9 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -188,27 +188,27 @@ struct sfdp_bfpt {
 
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
- * @default_init: called after default flash parameters init. Used to tweak
- *                flash parameters when information provided by the flash_info
- *                table is incomplete or wrong.
  * @post_bfpt: called after the BFPT table has been parsed
  * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
  *             that do not support RDSFDP). Typically used to tweak various
  *             parameters that could not be extracted by other means (i.e.
  *             when information provided by the SFDP/flash_info tables are
  *             incomplete or wrong).
+ * @late_init: used to initialize flash parameters that are not declared in the
+ *             JESD216 SFDP standard, or where SFDP tables not defined at all.
  *
  * Those hooks can be used to tweak the SPI NOR configuration when the SFDP
  * table is broken or not available.
  */
 struct spi_nor_fixups {
-	void (*default_init)(struct spi_nor *nor);
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
 			 struct spi_nor_flash_parameter *params);
 	void (*post_sfdp)(struct spi_nor *nor,
 			  struct spi_nor_flash_parameter *params);
+	void (*late_init)(struct spi_nor *nor,
+			  struct spi_nor_flash_parameter *params);
 };
 
 #define SPI_NOR_SRST_SLEEP_LEN			200
@@ -2825,10 +2825,11 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 		nor->fixups->post_sfdp(nor, params);
 }
 
-static void spi_nor_default_init_fixups(struct spi_nor *nor)
+static void spi_nor_late_init_fixups(struct spi_nor *nor,
+				     struct spi_nor_flash_parameter *params)
 {
-	if (nor->fixups && nor->fixups->default_init)
-		nor->fixups->default_init(nor);
+	if (nor->fixups && nor->fixups->late_init)
+		nor->fixups->late_init(nor, params);
 }
 
 static int spi_nor_init_params(struct spi_nor *nor,
@@ -2935,8 +2936,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
-	spi_nor_default_init_fixups(nor);
-
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
@@ -2955,6 +2954,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	}
 
 	spi_nor_post_sfdp_fixups(nor, params);
+	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
 }
@@ -3380,7 +3380,8 @@ static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25fs_s_default_init(struct spi_nor *nor)
+static void s25fs_s_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fs_s_setup;
 }
@@ -3430,9 +3431,9 @@ static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25fs_s_fixups = {
-	.default_init = s25fs_s_default_init,
 	.post_bfpt = s25fs_s_post_bfpt_fixup,
 	.post_sfdp = s25fs_s_post_sfdp_fixup,
+	.late_init = s25fs_s_late_init,
 };
 
 static int s25_s28_mdp_ready(struct spi_nor *nor)
@@ -3516,7 +3517,8 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25_default_init(struct spi_nor *nor)
+static void s25_late_init(struct spi_nor *nor,
+			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
 }
@@ -3597,9 +3599,9 @@ static void s25_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25_fixups = {
-	.default_init = s25_default_init,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
 	.post_sfdp = s25_post_sfdp_fixup,
+	.late_init = s25_late_init,
 };
 
 static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
@@ -3608,13 +3610,14 @@ static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
 	return -ENOTSUPP; /* Bank Address Register is not supported */
 }
 
-static void s25fl256l_default_init(struct spi_nor *nor)
+static void s25fl256l_late_init(struct spi_nor *nor,
+				struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fl256l_setup;
 }
 
 static struct spi_nor_fixups s25fl256l_fixups = {
-	.default_init = s25fl256l_default_init,
+	.late_init = s25fl256l_late_init,
 };
 #endif
 
@@ -3677,7 +3680,8 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void s28hx_t_default_init(struct spi_nor *nor)
+static void s28hx_t_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
@@ -3715,9 +3719,9 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s28hx_t_fixups = {
-	.default_init = s28hx_t_default_init,
 	.post_sfdp = s28hx_t_post_sfdp_fixup,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
+	.late_init = s28hx_t_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
@@ -3769,7 +3773,8 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
+static void mt35xu512aba_late_init(struct spi_nor *nor,
+				   struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
 }
@@ -3798,8 +3803,8 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups mt35xu512aba_fixups = {
-	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = mt35xu512aba_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MT35XU */
 
@@ -3859,7 +3864,8 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void macronix_octal_default_init(struct spi_nor *nor)
+static void macronix_octal_late_init(struct spi_nor *nor,
+				     struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
 }
@@ -3876,8 +3882,8 @@ static void macronix_octal_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups macronix_octal_fixups = {
-	.default_init = macronix_octal_default_init,
 	.post_sfdp = macronix_octal_post_sfdp_fixup,
+	.late_init = macronix_octal_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
-- 
2.34.1

