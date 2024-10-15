Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D8CFC264
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3318929F;
	Tue, 15 Oct 2024 06:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gewiSWYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3B9892A2; Tue, 15 Oct 2024 06:09:30 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594DD892AF
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso1333606a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965367; x=1729570167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vasCpWoC6L4Nrw6imoW+jZGtlPTLVLn07mL9hkF/MI=;
 b=gewiSWYTi1AgWvbKew2Qmhtv2LLnrBonGLn2CcE10qvEfu3TTdFuJnx4I2iDPlIqG4
 WzVU/nVA9+YxQx51cn1lEfeqBRw9Y8G1/SKtDjc1tgFEXfHipLd0JGfmBeaVT2nRg8lT
 HiSsnn4JA8Qytc4fu8S1Ee7hjlaZImw+lK1g823P6aVvpe+fckmX7HGUd9wM2A1f04Br
 gzp6Zd34UTzcEkvAYq4aQgDpceuT+lLwesowUKvj9sXTuhXNnjtJSLMDp9S2mFtTO7Ms
 priA7HCQKoJhXojqwigRxdkvhE62h9DbhknwXgCLJ+asIwqr/Kj551sCGJft4+EqtVsx
 l3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965367; x=1729570167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vasCpWoC6L4Nrw6imoW+jZGtlPTLVLn07mL9hkF/MI=;
 b=StyYkKKYqQc2arWTdXiyJy+U01HfOV1NPtLiy+sDwqLhXoReIhH70LdGtkKajP1yQR
 4sZlCktyGJL4Jl+QXWIH68fmLywNMduer6BaHssAI2iElJL+j2pNrTMLWvJOPrU82io1
 R2/Qop1GwL1XXZhzTeVoEh2t1FHIHuPkDgCoiuu/cPuc3Qyr9Zy784ckIilB7p51TiG8
 cnHco4F7E10SibqekI+9T7nnN86LpeRKsHAiXsCd9FPkps26TuzKXtt+hzf0ir1x3Uh4
 uItip6soys91O4bHurnU0a+ABPFH3M4pd+AjnhvxCHgmEcOEw+xk6ae3I5xSW+efmsVe
 nb/g==
X-Gm-Message-State: AOJu0YyVwF9aLtAHIuH4iIok620GvgH1JBBXtsDFnVAuhcELCmDBwMAf
 tEIsJoztI6r+qlactZBwJxiPoJaaUgNPl6aQDhHnpRxKIKYbEc2o5DSo9Or4
X-Google-Smtp-Source: AGHT+IH8eDOCzzo3/R/DK4jqlrGX65PkL93hKf6v9jFflCApJPAFznBVQCRyCN1ExwmL274+vyTjOQ==
X-Received: by 2002:a05:6a21:3942:b0:1cf:1250:80a7 with SMTP id
 adf61e73a8af0-1d8bc85d2abmr21798895637.12.1728965366696; 
 Mon, 14 Oct 2024 21:09:26 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:26 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 4/6] mtd: spi-nor: Replace default_init() hook with
 late_init()
Date: Tue, 15 Oct 2024 13:08:34 +0900
Message-Id: <5b58685d52b8128a05b3587e7236a11a37486c28.1728964655.git.Takahiro.Kuwano@infineon.com>
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
index 466729cd2a7..d0763882235 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -194,27 +194,27 @@ struct sfdp_bfpt {
 
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
@@ -3060,10 +3060,11 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
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
@@ -3177,8 +3178,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
-	spi_nor_default_init_fixups(nor);
-
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
@@ -3252,6 +3251,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	}
 #endif
 	spi_nor_post_sfdp_fixups(nor, params);
+	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
 }
@@ -3715,7 +3715,8 @@ static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25fs_s_default_init(struct spi_nor *nor)
+static void s25fs_s_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fs_s_setup;
 }
@@ -3765,9 +3766,9 @@ static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25fs_s_fixups = {
-	.default_init = s25fs_s_default_init,
 	.post_bfpt = s25fs_s_post_bfpt_fixup,
 	.post_sfdp = s25fs_s_post_sfdp_fixup,
+	.late_init = s25fs_s_late_init,
 };
 
 static int s25_s28_mdp_ready(struct spi_nor *nor)
@@ -3851,7 +3852,8 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25_default_init(struct spi_nor *nor)
+static void s25_late_init(struct spi_nor *nor,
+			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
 }
@@ -3932,9 +3934,9 @@ static void s25_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25_fixups = {
-	.default_init = s25_default_init,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
 	.post_sfdp = s25_post_sfdp_fixup,
+	.late_init = s25_late_init,
 };
 
 static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
@@ -3943,13 +3945,14 @@ static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
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
 
@@ -4012,7 +4015,8 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void s28hx_t_default_init(struct spi_nor *nor)
+static void s28hx_t_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
@@ -4050,9 +4054,9 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s28hx_t_fixups = {
-	.default_init = s28hx_t_default_init,
 	.post_sfdp = s28hx_t_post_sfdp_fixup,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
+	.late_init = s28hx_t_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
@@ -4104,7 +4108,8 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
+static void mt35xu512aba_late_init(struct spi_nor *nor,
+				   struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
 }
@@ -4133,8 +4138,8 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups mt35xu512aba_fixups = {
-	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = mt35xu512aba_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MT35XU */
 
@@ -4194,7 +4199,8 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void macronix_octal_default_init(struct spi_nor *nor)
+static void macronix_octal_late_init(struct spi_nor *nor,
+				     struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
 }
@@ -4211,8 +4217,8 @@ static void macronix_octal_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups macronix_octal_fixups = {
-	.default_init = macronix_octal_default_init,
 	.post_sfdp = macronix_octal_post_sfdp_fixup,
+	.late_init = macronix_octal_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
-- 
2.34.1

