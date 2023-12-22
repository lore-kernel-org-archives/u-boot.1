Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44144C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAF5877C8;
	Fri, 22 Dec 2023 06:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNCfsZzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F24587650; Fri, 22 Dec 2023 06:46:41 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09ADD876F8
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d3e05abcaeso10778215ad.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703223997; x=1703828797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUalSoE8z8MXRqfRa1OfC3wOXoIVBbR6QXqEtCvdtRo=;
 b=NNCfsZzQW0GlnEe9x26SuyJwhpZA0SRUBE8WUYXRnxM2L37B9SdxFBBzxIMkIi9768
 hWZmIx65pAO3GvuMvGlcVKV2Sf7P7q8sbANIS74T9gwL3faR6I6XC1vvt2ktemNoP5kQ
 VHCS/2Ijp+bJOiPsKl0U1YBwdQRBOk5xnVHY8yoM7q9G5Ibpy+T8flYLQEt6Y2yYns09
 dNElPjL/2CgwrlxHC7a9plFNw4AC5DcaSt93jeeG9otmPWx5BbhsvP+89mwqKi7qqVSN
 4b8Xb95FxvzVF/5ktqjCaGjcpT/TpYy6CXspMfy+j0TrSQOD5sIg95+0J5r/m0Ha3eN1
 erow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703223997; x=1703828797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUalSoE8z8MXRqfRa1OfC3wOXoIVBbR6QXqEtCvdtRo=;
 b=HFC8GONegP4pYiMQjqkDDH/NNo1wxKqoYyZVdTLXxC0akfsTxi2uDMdsO/jd/cuA+N
 dEhZs1OCiRYMED5CSJJdhDOsEO7Nkdv427YIEl96IjDR6crj118l0/uqzCSCgWBkmwXz
 F3XELEp/emvaxOfkq1kArQ+zD4jDf1TUCydwM4eRw5igSMognsZtRiqDl177D2Krunjq
 LADPnkgnQM3+2Nih+bzoqH6QEOgJ/9+Wnh/ZxPRd0WMa303gTV7nCRxddoRV4xpjbQpC
 1GvxqEezFvuJ0H0f+pNnbJmQ7jTEaOdCOTw8ug6oyNlV9khQfeFRc8e4GU+mOvSPhUyX
 RBsw==
X-Gm-Message-State: AOJu0YxDZ/TraoF77OQ4e93blfHplVGsV/dL/4ocTLUv8k1nafjEKAhC
 sfyEXvc2Fd7KEa6tymXk9Pdg1rXUf1U=
X-Google-Smtp-Source: AGHT+IFpacrnQwWFbzewA0G1964swQOJifelbOxburVNHQ9qJqF7aN2DaRdJJtYIUSuOiSVjFWBk1Q==
X-Received: by 2002:a17:903:41cb:b0:1d4:1623:89ff with SMTP id
 u11-20020a17090341cb00b001d4162389ffmr516358ple.83.1703223997384; 
 Thu, 21 Dec 2023 21:46:37 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:37 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 2/9] mtd: spi-nor-core: Consolidate non-uniform erase
 helpers for S25 and S28
Date: Fri, 22 Dec 2023 14:45:59 +0900
Message-Id: <d0aa3dcf06edcc781d256a603f3d6ef4710affd5.1703220284.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

s25_erase_non_uniform() and s28hx_t_erase_uniform() support hybrid sector
layout (32 x 4KB sectors overlaid at bottom address) and doing same thing.
Consolidate them into single helper named s25_s28_erase_non_uniform().

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 13 +++----------
 include/linux/mtd/spi-nor.h    |  1 -
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index a2ef65cf6f..f62a2f2008 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3344,7 +3344,7 @@ static int s25_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static int s25_erase_non_uniform(struct spi_nor *nor, loff_t addr)
+static int s25_s28_erase_non_uniform(struct spi_nor *nor, loff_t addr)
 {
 	/* Support 32 x 4KB sectors at bottom */
 	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0,
@@ -3385,7 +3385,7 @@ static int s25_setup(struct spi_nor *nor, const struct flash_info *info,
 	if (ret)
 		return ret;
 	if (!(cr & SPINOR_REG_CYPRESS_CFR3_UNISECT))
-		nor->erase = s25_erase_non_uniform;
+		nor->erase = s25_s28_erase_non_uniform;
 
 	/*
 	 * For the multi-die package parts, the ready() hook is needed to check
@@ -3558,13 +3558,6 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor)
 	return 0;
 }
 
-static int s28hx_t_erase_non_uniform(struct spi_nor *nor, loff_t addr)
-{
-	/* Factory default configuration: 32 x 4 KiB sectors at bottom. */
-	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_S28_SE_4K,
-					  0, SZ_128K);
-}
-
 static int s28hx_t_setup(struct spi_nor *nor, const struct flash_info *info,
 			 const struct spi_nor_flash_parameter *params)
 {
@@ -3593,7 +3586,7 @@ static int s28hx_t_setup(struct spi_nor *nor, const struct flash_info *info,
 		return ret;
 
 	if (!(buf & SPINOR_REG_CYPRESS_CFR3_UNISECT))
-		nor->erase = s28hx_t_erase_non_uniform;
+		nor->erase = s25_s28_erase_non_uniform;
 
 	return spi_nor_default_setup(nor, info, params);
 }
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f9a55c8e74..ebe38306a1 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -180,7 +180,6 @@
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
-#define SPINOR_OP_S28_SE_4K			0x21
 #define SPINOR_REG_CYPRESS_ARCFN		0x00000006
 #define SPINOR_REG_CYPRESS_STR1V		0x00800000
 #define SPINOR_REG_CYPRESS_CFR1V		0x00800002
-- 
2.34.1

