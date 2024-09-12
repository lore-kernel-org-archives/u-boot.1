Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A8CEE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68F288EF2;
	Thu, 12 Sep 2024 09:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UPxOak9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B95D88F14; Thu, 12 Sep 2024 09:38:18 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165E088EEA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso480361a91.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126694; x=1726731494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90wq3IyoXVlovyaq1c7q8C937WeBY29BRLajM1qQXyA=;
 b=UPxOak9hm6NnkQPXFVfImHW+tYCGyWdJkTLphSnz3rdoA6vUI31I1m3XJv6NW5EygC
 0Tb2TLVkUusBKdFCUGfvc2G6TyJudxEqou3Mmedf7EixCump4FkgEnVle2MMJhUgnsAK
 PwAmN0QL3MDTnRMhkpdQvIdhJW4yVL9NCd4V5JIady6uyfKtjEFNw3KPGgHk28kKr3pP
 V+k+xz/XmNyYqe+DbHhx3iw2R46C8GQRH7HrNchfQMnjaS8BJbS6nvKsod0NJzeembEL
 OHzH9RBwGhO6Gt+ZqI4YFjj93ekm8zlDNERLfda07fUoQPyd+fdqb2BRxEXxvaJT7fIy
 UXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126694; x=1726731494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90wq3IyoXVlovyaq1c7q8C937WeBY29BRLajM1qQXyA=;
 b=mz3CMAddClwwVfdCKzt7FNC5BC4vUgHJ1KL2AaYImuP2y4hV5FQYo6mG91jifG04eA
 VA3uJqKuNo7dJQPuuf8HnPJmdtppSWtqPWUreO8V+KZ2SmrZvVMG58+bf7QpVi4+b/xo
 k6Sn0E4YrSE6jR3kc7ZBNb0OokPxLucshB4l84V/jWQRQoatGEgRCKAFSI67WR/X9XCt
 hRO/j7aCQNlHzpLYmDzz6ovwO+mWOV0S9/tUVEl0lt4d0I90c8Q/ftrHneAqXpdQZij+
 ULmB7gOGC23WINzCXSt759xSxIb0mo4L0JIccD3BTQ5hqNh8pixN8jl+klKJrZDManVZ
 KyRg==
X-Gm-Message-State: AOJu0Yw2b2iXcnLG3REjRuKABeXBcpp4FgLRrci9wFafWKD7DmTscJvR
 E2Q+woApFfE9N0G0fh6mV54dAECMOqwgh1n77EgpGL3lUDf0tS5ATUfsqA==
X-Google-Smtp-Source: AGHT+IEdpO/KvfhElOn2ZLKYiUB2yAMIAYIgxrXa/W8DRVx0pQacobRKPA2/zQw7JqpUJMst8fe9aA==
X-Received: by 2002:a17:90a:17e3:b0:2d8:a731:7db0 with SMTP id
 98e67ed59e1d1-2dba00681a7mr1817400a91.35.1726126694463; 
 Thu, 12 Sep 2024 00:38:14 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:38:14 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 5/6] mtd: spi-nor: Call spi_nor_post_sfdp_fixups()
 only after spi_nor_parse_sfdp()
Date: Thu, 12 Sep 2024 16:37:23 +0900
Message-Id: <5a01786e80cdc55aed73634dac7e923695adb8ce.1726126079.git.Takahiro.Kuwano@infineon.com>
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
index e69a25195c..a8f3edc9f6 100644
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

