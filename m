Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C30EE6454
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7560188F03;
	Thu, 12 Sep 2024 09:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KR/q0MUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87FD488EF2; Thu, 12 Sep 2024 09:38:16 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364178898B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d889ba25f7so456177a91.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126691; x=1726731491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUKaQJWDNK+2EyI68Obu0licHa8r5G0d7t75cagwK/8=;
 b=KR/q0MUb0c+ONomzNkli4BoNmex7sPk8FZdm+2IPC2tN7dy7eQOzW0fwdzRQsAo7jf
 0tNJqB5KwNC4c34iH/8rnnKlVoTnEdp+AfsfgoZrXqbYtLnkupRzdmsRYUe2b+Tv7NfG
 G8UQpwQ6CWwTmSS8kKWSpkALb+ZKkDUVtUShTYSYl0UOBbJ2Z1vdRlnmbh2LWcIOW75L
 aWAYKiUx88vSuQlRZ7PNuOTanWJHLzZ4hHfriCe62TAXeawtmA3u2HRkdEdFsWIROyOY
 eViNxPFifAWkbUGpTVg1UupH9rSUOlpUcaUzZ5usx8GLgBSsaLn/5IElZchKzBQar4sn
 t5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126691; x=1726731491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUKaQJWDNK+2EyI68Obu0licHa8r5G0d7t75cagwK/8=;
 b=VSsBQfBv1rzQrlZSXlKnzIxAddVxOJ3MSUEYTvNCgdNWDr0J7evkjxuqvjHnmw/DBR
 rfSFyGvBabsmkBWqq9WE9pOzObKP6Oxgiw8uNbv7HQuoucxwesytrkQ4MP6ykj3+0L8z
 eaSoCEJjZiRgKiK1G8p/8V2eCxYFLRiTDliUNJqmAlzMz5+OVV+mxxsKpL6DLlqTZ0p4
 /gkfQ5Ob32CYS4ClQg22MVEfnt10CU3Drm7Kc9YgNeQgHq20NKiRqii60szkc7yxi5Q+
 zFeOem66sC7rUu65eI0otOVhlJW1Y5cSW/80VCDP5nSks+tFUnMNF2prOp1YaNT2RnXb
 QMMQ==
X-Gm-Message-State: AOJu0Yzdhh8J+HgSyP8ptrO5Bbhhxun07dk5D17PRviKADjJ+ZR1moR6
 ViWEUZT3QTlTXLOUBo0uZy49FFBl0ccJudkyXNOjLGyN47m+BbI/gbaGoA==
X-Google-Smtp-Source: AGHT+IGw49ObWALYSA8dgfn8kLmsoP8a5O3q7Skggn7cyfmRs8NOSAaGwF6KKpfl0eV11dMKa4DBTw==
X-Received: by 2002:a17:90a:8401:b0:2d8:816a:69c5 with SMTP id
 98e67ed59e1d1-2db9ffe7affmr2304289a91.23.1726126691210; 
 Thu, 12 Sep 2024 00:38:11 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:38:10 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 4/6] mtd: spi-nor: Replace default_init() hook with
 late_init()
Date: Thu, 12 Sep 2024 16:37:22 +0900
Message-Id: <66db1a26c8f7ab77706961c1ab3fb1d366128b99.1726126079.git.Takahiro.Kuwano@infineon.com>
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
index 6eaed3da39..e69a25195c 100644
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

