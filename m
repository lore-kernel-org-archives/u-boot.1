Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27955CFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6CE5892B6;
	Tue, 15 Oct 2024 06:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SD4rYEgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88F988F1B; Tue, 15 Oct 2024 06:09:34 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13DD892B6
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c70abba48so31900765ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965371; x=1729570171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrIBwXMN9f3HL81J0Z2jVvmHRWXeA555yngKBJjzvAE=;
 b=SD4rYEgkqy7ywOuDcUy4tBZda6GNjk4Vg/Ji0kRv2+BiJmNucCKWxm2ZnLUTZXoMyD
 ZaK8JChGx92IbVXFrvL3gU3LegVLINGKo4QzneUrH70s1J1P8HtrBAeb1vRxslwgr2Db
 ZpmRjmAgYNjGj4GG4zOs4LpIMHZmczbFIZwHLkbvnhEoU+hbAILjlmQYNcXToiipjJSB
 4JntM0WK4jexxyEr4vDj3PTun7kdjxWz1oE2OUjtK5pxck+ULmbo08kXSTQXbYw8kwyS
 WnZukKv2TkYPeViUgz66lFdVKsQCda1IHNg/R2NN9ZhLlzHUD+5R4j3wXhUcEDB7a0Lr
 zGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965371; x=1729570171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrIBwXMN9f3HL81J0Z2jVvmHRWXeA555yngKBJjzvAE=;
 b=M5lASQsJ+hb2/JPjpdi7uYEghPIVMlrM2QGQKXQtZwxtYOG56QlSeFxOofSxMiCtLA
 Z4iWyPcgXh+ufoR9MyB3t6YYjBq5VaXkKJ0C+FFI9gLu4PDdHtGxk9SdUEqHLByRiXjy
 aQjyJ4MBhd3PeTOH4C77569WEZq+3jlrfWNh5EiNufdje58pmOmnSOxpChdAhLDH0PWn
 bXWB4roJPenbEqVDk/NuZ/Xysw0IBSQqaHwg6hBwRYyXgLCvUXKL3HqSM2GuZvFAyAou
 XAwF3nf7whzoNK6pWDq9Ig0J9zM7kW0rHZaIB2Rp/V9hoFdNHaYVM1wu59lRh8frC7en
 7BQw==
X-Gm-Message-State: AOJu0YyTPS2R9bb1uMR4zPyDPbNYhvAn67D6KHqnQ+jF0gqB1tvTABgB
 XhF10hzzzpWCWKMi5oHIyMUqP3/fW7aoP7d3KxMVtlwA0phJVMY56PSo+GX7
X-Google-Smtp-Source: AGHT+IEuTYjJz4wHtEj2LCO+Pxh5jH1DWU0I47/0yuZ91dBI/YPk/J1WSYgn9AlBcGvjD+ooz+oaiA==
X-Received: by 2002:a17:902:dacd:b0:202:cbf:2d6f with SMTP id
 d9443c01a7336-20cbb2717f6mr159098725ad.57.1728965371216; 
 Mon, 14 Oct 2024 21:09:31 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:30 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 5/6] mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only
 after spi_nor_parse_sfdp()
Date: Tue, 15 Oct 2024 13:08:35 +0900
Message-Id: <63b42eddca126e055f90d3d6eab688470d55fa16.1728964655.git.Takahiro.Kuwano@infineon.com>
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

This patch follows the upstream linux commit:
5273cc6df984("mtd: spi-nor: core: Call spi_nor_post_sfdp_fixups() only
when SFDP is defined")

spi_nor_post_sfdp_fixups() was called regardless of if
spi_nor_parse_sfdp() had been called or not. late_init() should be
instead used to initialize the parameters that are not defined in SFDP.

Ideally spi_nor_post_sfdp_fixups() is called only after successful parse
of SFDP. However, in case SFDP support is disabled by .config, that can
break current functionality. Therefore, we would call it after
spi_nor_parse_sfdp() regardless of its return value.

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index d0763882235..46af9b4fe47 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -195,11 +195,10 @@ struct sfdp_bfpt {
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
  * @post_bfpt: called after the BFPT table has been parsed
- * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
- *             that do not support RDSFDP). Typically used to tweak various
- *             parameters that could not be extracted by other means (i.e.
- *             when information provided by the SFDP/flash_info tables are
- *             incomplete or wrong).
+ * @post_sfdp: called after SFDP has been parsed. Typically used to tweak
+ *             various parameters that could not be extracted by other means
+ *             (i.e. when information provided by the SFDP tables are incomplete
+ *             or wrong).
  * @late_init: used to initialize flash parameters that are not declared in the
  *             JESD216 SFDP standard, or where SFDP tables not defined at all.
  *
@@ -3045,13 +3044,12 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 
 /**
  * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and settings
- * after SFDP has been parsed (is also called for SPI NORs that do not
- * support RDSFDP).
+ * after SFDP has been parsed.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Typically used to tweak various parameters that could not be extracted by
- * other means (i.e. when information provided by the SFDP/flash_info tables
- * are incomplete or wrong).
+ * other means (i.e. when information provided by the SFDP tables are incomplete
+ * or wrong).
  */
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
@@ -3193,6 +3191,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		} else {
 			memcpy(params, &sfdp_params, sizeof(*params));
 		}
+
+		spi_nor_post_sfdp_fixups(nor, params);
 	}
 #if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
 	/*
@@ -3250,7 +3250,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		params->page_size <<= 1;
 	}
 #endif
-	spi_nor_post_sfdp_fixups(nor, params);
 	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
-- 
2.34.1

