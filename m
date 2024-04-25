Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991B3C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13CF88EEF;
	Thu, 25 Apr 2024 06:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOk6L03X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA10288EE9; Thu, 25 Apr 2024 06:54:00 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7703688EDA
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so605446b3a.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020837; x=1714625637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8eMIJCPcScvOfebh/obnVSSTChhCdpZ9m+BZyuVBWk=;
 b=nOk6L03XPqt6CKMKdWeEBz0nUVg7MqLV806NonTM+NFsfUt16YWa6TMXR5WUr1nyMM
 nKLWZQQwdMzR7jQd+szftiKrNqmvJEe2rodpd7C5/kwBEx9sS922lKpvnlkeMRoMxdk5
 +d4Tb69XsB2iOm298Msc1fxlnIKBYKY+CE5isLEvGlprDjmh1DFqfPYuI8QDOtXh6CD6
 pLd9DeYhUFL5jYsRZRFPGZoH7NAgHTv7Vrm7n4XHzmj1El6pYWRcKW37E+AGz9/ld6TB
 N04PKabe65+cO0rsfKJUekwdaohcjK3c2bofx/LjMNIcXAufv1tLqrGcND2rjx7Srt/u
 dBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020837; x=1714625637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8eMIJCPcScvOfebh/obnVSSTChhCdpZ9m+BZyuVBWk=;
 b=wrmTczhFaxm1vesqAWTQ39fPClVc/vmHJf8MLcsI1w2oKbIu8Pj0M2tAP+o6jzxkXY
 peM0tyqmvo8j7+ES1YXiA4RpYs5CqLg0ag89laof39uBnkj3y4R4u/zpCaUWBUvBB8fj
 4WhzvFg2IBGo+b0dpwn2B3r08UX6qWtNml0gTzfZ94QHJy4+EKufTQcA9vJxk6DMNL2j
 FdpiTON7Z2IUXn11PCFU8Jp3Jr1s+LtSJLKtFTQFQl18qHmjdx3kkJ9ktVOP98PQJYbK
 vTwejFty46YIBphFh4HleAsEyC2yHxlLc6Kdf+FKeztN2coGVk+eSDMVk2NzyhNHuZoS
 Y2zQ==
X-Gm-Message-State: AOJu0YzVfsSAd7DUQFwZ36i/LdROU7cW07t8alw8YniWzqG5njeOUx/2
 PXmjqkhMLXJ6lRaIhKWSjDmisnKK9uomQ+oivfrw+2x3u3m+9c8yFdnUHA==
X-Google-Smtp-Source: AGHT+IH9GaJD2s1f7XSg39cwUrvp+qP6MPbreaUpVf6FEf1RzfkJvWHSmnVvVsC98yHu8+a+UIV6Pg==
X-Received: by 2002:a05:6a20:96cc:b0:1aa:755f:1746 with SMTP id
 hq12-20020a056a2096cc00b001aa755f1746mr4523904pzc.22.1714020836910; 
 Wed, 24 Apr 2024 21:53:56 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:56 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 5/6] mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only
 after spi_nor_parse_sfdp()
Date: Thu, 25 Apr 2024 13:52:15 +0900
Message-Id: <b396511bbb406b980f9125b1692d7cb636f07ea0.1714020303.git.Takahiro.Kuwano@infineon.com>
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

spi_nor_post_sfdp_fixups() was called regardless of if
spi_nor_parse_sfdp() had been called or not. late_init() should be
instead used to initialize the parameters that are not defined in SFDP.

Ideally spi_nor_post_sfdp_fixups() is called only after successful parse
of SFDP. However, in case SFDP support is disabled by .config, that can
break current functionality. Therefore, we would call it after
spi_nor_parse_sfdp() regardless of its return value.

This patch follows the upstream linux commit:
5273cc6df984("mtd: spi-nor: core: Call spi_nor_post_sfdp_fixups() only
when SFDP is defined")

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index fda879f3a3..ee968c10e4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -190,11 +190,10 @@ struct sfdp_bfpt {
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
@@ -2760,13 +2759,12 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 
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
@@ -2901,9 +2899,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
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

