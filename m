Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5629CEBF67
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DEB89055;
	Fri, 27 Sep 2024 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaxzlY6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8984A88E39; Fri, 27 Sep 2024 03:18:37 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A65C89041
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6afa8baeaso1299842a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399914; x=1728004714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnDRdx/H3Qw/iK99a6NOruQTvvCN4nf2O6mZudja9TA=;
 b=LaxzlY6TryhvNJfRcmXnGca96YRRFGG0sZvJ+Z9XyJC4n0kyKkS8ZWtrZaMBEd+qbp
 eHj8pAcUhQrSQPsVnqRbsopQ1SBlfKtifR7BJLAFhIkdr024+aH6oxcQ9G0dvc9AWiBC
 0Q//If4tEgq8v9e4VkBMR2d59zbyFTsTHkXm7ug1FneMchsFzQNEpTe91HpCDefZoaif
 yhj5L2dzL847pnWz7PE5wHKSmANPxWRKrb6458S3k9A0JfzIXnti+BgWYNyFw1jEBUXV
 OdopTA8EumFeX2XoOOQV3rKbRcu/r62/cV2ysL/eUYNTzS/if4pDfaE8RTQhY3+PG2vu
 sPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399914; x=1728004714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnDRdx/H3Qw/iK99a6NOruQTvvCN4nf2O6mZudja9TA=;
 b=IVl8EX7nWMvHLn+tyEMOTCbtLlkcsxdC8scbX5HOk964DHDoBX0/fCVkLmnG2KyRpS
 UEjbyI11Ky2tSZ6e6xggIQbTKOCZ/R2cPAn0Fci0q7D6OEDpnzffITlzL5VMdBJQgCXq
 sxtqEUgdMPqpwj4bljeJj0CoeoOgjt8wLUmcnFN/zcPsPYpLTD5YxvPXnuHC0rRC3TIk
 afw6EGjWeKt90GB5a/TVFpTW/ohi8AcFTVGAVwBOxUTqwl2mvaCOZ9AHwJ5xhoKAu+qC
 6tKspbtvtlO2NFZrBNyC4g37U1uAd8CLRPeaVmoytRedY4cXE3omTdjJUCOmoIY6TYdX
 nzvQ==
X-Gm-Message-State: AOJu0YyZ407WPpeo4rLqdtJtnioTje6GkVByKzeo24/iyS6EKgmYEK+t
 S8n/1LewfdCKVc6/GZoPigIQ9HQ3PzMQqu74HXI//oCE6mvQmH3yJZQDSw==
X-Google-Smtp-Source: AGHT+IGmM9xx6X7PhwVe8+VuagqP0vzW1CdFXjHYpjRBn4GzSV/qo+owBxeUHtSxZUyu0Chf3UiElg==
X-Received: by 2002:a05:6a21:710a:b0:1cf:21c7:2aff with SMTP id
 adf61e73a8af0-1d4fa6bad47mr2284336637.23.1727399913829; 
 Thu, 26 Sep 2024 18:18:33 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:33 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 5/6] mtd: spi-nor: Call
 spi_nor_post_sfdp_fixups() only after spi_nor_parse_sfdp()
Date: Fri, 27 Sep 2024 10:18:10 +0900
Message-Id: <e6ee72fb09d1c748ebab35bc2cdab58270cf5918.1727399650.git.Takahiro.Kuwano@infineon.com>
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
index e69a25195c9..a8f3edc9f69 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -189,11 +189,10 @@ struct sfdp_bfpt {
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
@@ -2810,13 +2809,12 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 
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
@@ -2951,9 +2949,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		} else {
 			memcpy(params, &sfdp_params, sizeof(*params));
 		}
+
+		spi_nor_post_sfdp_fixups(nor, params);
 	}
 
-	spi_nor_post_sfdp_fixups(nor, params);
 	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
-- 
2.34.1

