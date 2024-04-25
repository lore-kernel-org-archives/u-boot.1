Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666C5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF6588E69;
	Thu, 25 Apr 2024 06:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VE4X+zfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1EE8803A; Thu, 25 Apr 2024 06:53:57 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5D188ED8
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e834159f40so4545395ad.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020833; x=1714625633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8lcCQml2WgHwPcPgbrASUk43YAZUDzeqY0cSU6rBZ0=;
 b=VE4X+zfEL6uK4wU1tHWbBWfMyUMv13ltwKIHlmlTzQ+9IAPUB0IqJZofxbS3xXOl6z
 Do+q3MjDcCwuYe9Qy0AkJnDpcFIiH9h5C5k7T/x0WUtC+yozb+JK2QEahFMggy4X4gST
 Rx/3oIlMIQ7mo8gRZak7k8vIDGUXPxS93eyGHTSBXePN7jVuNP4MABpg35oYfsJM61DY
 p+ARH3DHb41qtj6wY+nRT1SjWV/MXfRXdWtq+ihCtWEjMDThM2rXVTkzCYNc6XuVFf+2
 t0YBrVlFugB0jwZ4ooXnl9V1g30rUAIzYZoPfY30iDHikTgmJCnNbEtN6S4hf21quwRN
 2tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020833; x=1714625633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8lcCQml2WgHwPcPgbrASUk43YAZUDzeqY0cSU6rBZ0=;
 b=vIaqsK50ayUzgXQmdAaB0xPEY6IUkGvs3LX4i0djbVUhjJRGsNsA4afKCnat9YK4tj
 cqqFkgeZJMqUM56XZb6Mr26rXjM/qijk/agMuN+rvKRRv8eoAftF+xXg+QOLY5eteXR6
 Sr9k+jLKQOpIfitLSGX3r3KwZokESeJPmD88OEPxpFldO6lI43BZgDlEOHjYDRk7+dzk
 dNc79qCSV3SqLmAqEyQBdIqVihhf844MZELCCpcXAAFcPX0YsLBoADQURiu5/GN/2mLm
 JWcn4vkswZV6S52Zr/B2bwtm6aCtHovynoETnKvgYny73Pj1wjarM6WdCucVPjLNqxWe
 CMyQ==
X-Gm-Message-State: AOJu0YxULaTG5XsVxiOW1fIaE5a4TV0pMvYwQEBPBXkIyusLgSXxWC7I
 DFqK64C+Oo5eNBF9/Y49qiUgw0kH39OpMfrtzTtYtGPp8PWEVlQoKZ5h2Q==
X-Google-Smtp-Source: AGHT+IEFLImBYW0VfTEtJp7Lq9/D/fiImR+4jIpZLXHhCmZyune1e8Dir6rM+D6ZskuC9zgBz1FKIA==
X-Received: by 2002:a17:903:41c1:b0:1e5:86ba:88b5 with SMTP id
 u1-20020a17090341c100b001e586ba88b5mr6068313ple.7.1714020833375; 
 Wed, 24 Apr 2024 21:53:53 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:53 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 4/6] mtd: spi-nor: Replace default_init() hook with
 late_init()
Date: Thu, 25 Apr 2024 13:52:14 +0900
Message-Id: <ab901185da7f37f17767f93ce554b40a4b06b518.1714020303.git.Takahiro.Kuwano@infineon.com>
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
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index c2d2ddf0c8..fda879f3a3 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -189,27 +189,27 @@ struct sfdp_bfpt {
 
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
@@ -2775,10 +2775,11 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
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
@@ -2885,8 +2886,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
-	spi_nor_default_init_fixups(nor);
-
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
 	nor->mtd.erasesize = 0;
@@ -2905,6 +2904,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	}
 
 	spi_nor_post_sfdp_fixups(nor, params);
+	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
 }
@@ -3328,7 +3328,8 @@ static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25fs_s_default_init(struct spi_nor *nor)
+static void s25fs_s_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fs_s_setup;
 }
@@ -3366,9 +3367,9 @@ static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25fs_s_fixups = {
-	.default_init = s25fs_s_default_init,
 	.post_bfpt = s25fs_s_post_bfpt_fixup,
 	.post_sfdp = s25fs_s_post_sfdp_fixup,
+	.late_init = s25fs_s_late_init,
 };
 
 static int s25_s28_mdp_ready(struct spi_nor *nor)
@@ -3452,7 +3453,8 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25_default_init(struct spi_nor *nor)
+static void s25_late_init(struct spi_nor *nor,
+			  struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
 }
@@ -3533,9 +3535,9 @@ static void s25_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s25_fixups = {
-	.default_init = s25_default_init,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
 	.post_sfdp = s25_post_sfdp_fixup,
+	.late_init = s25_late_init,
 };
 
 static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
@@ -3544,13 +3546,14 @@ static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
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
 
@@ -3613,7 +3616,8 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void s28hx_t_default_init(struct spi_nor *nor)
+static void s28hx_t_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
@@ -3651,9 +3655,9 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups s28hx_t_fixups = {
-	.default_init = s28hx_t_default_init,
 	.post_sfdp = s28hx_t_post_sfdp_fixup,
 	.post_bfpt = s25_s28_post_bfpt_fixup,
+	.late_init = s28hx_t_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
@@ -3705,7 +3709,8 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
+static void mt35xu512aba_late_init(struct spi_nor *nor,
+				   struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
 }
@@ -3734,8 +3739,8 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups mt35xu512aba_fixups = {
-	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = mt35xu512aba_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MT35XU */
 
@@ -3795,7 +3800,8 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void macronix_octal_default_init(struct spi_nor *nor)
+static void macronix_octal_late_init(struct spi_nor *nor,
+				     struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
 }
@@ -3812,8 +3818,8 @@ static void macronix_octal_post_sfdp_fixup(struct spi_nor *nor,
 }
 
 static struct spi_nor_fixups macronix_octal_fixups = {
-	.default_init = macronix_octal_default_init,
 	.post_sfdp = macronix_octal_post_sfdp_fixup,
+	.late_init = macronix_octal_late_init,
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
-- 
2.34.1

