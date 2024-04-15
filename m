Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03089C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 04:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C230388134;
	Mon, 15 Apr 2024 06:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="awbsvWIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC49887F4A; Mon, 15 Apr 2024 06:33:35 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B2888134
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so18057415ad.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713155612; x=1713760412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC4xOW8KGJe8NtIGeEu95axmeUP7IBBHz2Tmc+SFuZM=;
 b=awbsvWIecwbNZQ/QFIxyoZzeD0vWYvwRUeRBUdfkcPT8Xc01KhGGbm+Dt/U1EylCQ+
 sZBFjTEWGNwp+w9ZXPiwdaayIFq6owV4aA6LqDfbzqBXI29NpxfiaIrfldyFpAFpBkiD
 Yq+ke6ung/mvBC+ctK30R2T/QoqK5pGoZxYm/BtfsT89DO9So17GbptNybU/7nQ/VvkH
 Y0zzbWUgNEpk4ypzDG6HxPOQWb33Yh/GQ++Qde5yohjl+nzrjt86zRyoiOT6JYQGo1/k
 ZJ7Uh4202lyqBzn/UnonqLl9rYvft6kvStu+8VrhCicFlOwv5VP5QYEwtLqCogDHxMNB
 K8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713155612; x=1713760412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BC4xOW8KGJe8NtIGeEu95axmeUP7IBBHz2Tmc+SFuZM=;
 b=mpv8xlW5EKQRShOeXNFAUGBo7ha9/TsvcHJdSaXklj/+gb/pP+pf/PzT7nUZbggEE+
 P3Agec2Iaxp0CX5KzERKqz4MxMkzlfZ5ODGfzrZiowNscoHq0q+wdB+qNNeMz7jm9MJU
 FbcaPSQn1Uoviz+XJYB9HCOdhLLxBiQ/HP0Pcg0W+Q8vTWV7RYDYixyMXiEHZpcLhKWn
 AdwdakiLA2mkFp0LmluNgkm/dfVaCk+y+ebG0qfXeJzam2nU6w7ryxL+xBKgQnyYM/xN
 DU+LfsORKsb2giPbqBHB4ONCA6oxC6ZpcXJo5Bf8/ncVK1PnPVzsSuSNHuHMRU+ULSja
 S2kQ==
X-Gm-Message-State: AOJu0Yy75bXTIPKbdakLBpHRuE+CPN21ygeJDcGzKWc3PU2qrwb9KOo8
 2y2WDeQnA9X1iM3HstfMtK6o8dxfeOYWpnM0Xlkrr2FpZC3T/LfTMigV1g==
X-Google-Smtp-Source: AGHT+IHDxkMN5Oe3kP2ysx83WLPYTqyhn54hkKcI94QcaFTpmsIdJCSCqmX1OZy3MRrK1peuGU/wbw==
X-Received: by 2002:a17:902:aa85:b0:1e3:e246:2cd1 with SMTP id
 d5-20020a170902aa8500b001e3e2462cd1mr7002656plr.62.1713155611983; 
 Sun, 14 Apr 2024 21:33:31 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm6902682plh.290.2024.04.14.21.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 21:33:31 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 3/4] mtd: spi-nor-core: Rework default_init() to take
 flash_parameter
Date: Mon, 15 Apr 2024 13:33:10 +0900
Message-Id: <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
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

default_init() fixup hook should be used to initialize flash parameters
when its information is not provided in SFDP. To support that case, it
needs to take flash_parameter structure like as other hooks.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 1bfef6797f..8f371a5213 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -203,7 +203,8 @@ struct sfdp_bfpt {
  * table is broken or not available.
  */
 struct spi_nor_fixups {
-	void (*default_init)(struct spi_nor *nor);
+	void (*default_init)(struct spi_nor *nor,
+			     struct spi_nor_flash_parameter *params);
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt,
@@ -2775,10 +2776,11 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 		nor->fixups->post_sfdp(nor, params);
 }
 
-static void spi_nor_default_init_fixups(struct spi_nor *nor)
+static void spi_nor_default_init_fixups(struct spi_nor *nor,
+					struct spi_nor_flash_parameter *params)
 {
 	if (nor->fixups && nor->fixups->default_init)
-		nor->fixups->default_init(nor);
+		nor->fixups->default_init(nor, params);
 }
 
 static int spi_nor_init_params(struct spi_nor *nor,
@@ -2885,7 +2887,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
-	spi_nor_default_init_fixups(nor);
+	spi_nor_default_init_fixups(nor, params);
 
 	/* Override the parameters with data read from SFDP tables. */
 	nor->addr_width = 0;
@@ -3328,7 +3330,8 @@ static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25fs_s_default_init(struct spi_nor *nor)
+static void s25fs_s_default_init(struct spi_nor *nor,
+				 struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fs_s_setup;
 }
@@ -3452,7 +3455,8 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
 	return spi_nor_default_setup(nor, info, params);
 }
 
-static void s25_default_init(struct spi_nor *nor)
+static void s25_default_init(struct spi_nor *nor,
+			     struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25_s28_setup;
 }
@@ -3544,7 +3548,8 @@ static int s25fl256l_setup(struct spi_nor *nor, const struct flash_info *info,
 	return -ENOTSUPP; /* Bank Address Register is not supported */
 }
 
-static void s25fl256l_default_init(struct spi_nor *nor)
+static void s25fl256l_default_init(struct spi_nor *nor,
+				   struct spi_nor_flash_parameter *params)
 {
 	nor->setup = s25fl256l_setup;
 }
@@ -3613,7 +3618,8 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void s28hx_t_default_init(struct spi_nor *nor)
+static void s28hx_t_default_init(struct spi_nor *nor,
+				 struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
 	nor->setup = s25_s28_setup;
@@ -3705,7 +3711,8 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
+static void mt35xu512aba_default_init(struct spi_nor *nor,
+				      struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
 }
@@ -3795,7 +3802,8 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static void macronix_octal_default_init(struct spi_nor *nor)
+static void macronix_octal_default_init(struct spi_nor *nor,
+					struct spi_nor_flash_parameter *params)
 {
 	nor->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
 }
-- 
2.34.1

