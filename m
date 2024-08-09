Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17374C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D528871E;
	Fri,  9 Aug 2024 14:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ci1mbqQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F248895D; Fri,  9 Aug 2024 14:16:19 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF718875C
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcus.folkesson@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f04c29588so2629057e87.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723205777; x=1723810577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c7vxauAGN1rhGfeqXXQFu1Oim75Pf7S6Ns7XXnQuOL8=;
 b=ci1mbqQmAjFF4cEqsfCZ0YiBYiX8eH+Oc4nIiJ/9s3V7z6Xbofm6tBZEvCCvEA7Zh2
 /TbRT5qSYQFciyTskLfjH113+zidYuXKhUL/JAkSpWPJsafbD5yD7YxGOMukQp+gB2LD
 P8YgJ7zMXAFpBZVVEpniJO1mTe6Uafnn7YUxs3kGQ1e1SV6jaTKq8eMm7lJWToOVGzv6
 FZ6fZohU0skuvYQul2lhR3xh33gFgIpWrxqvoovFIq9iOJ0MrFC/IEQUc/Aoo23pg7Sq
 nxBWkvnciUVgByooNDeuW0Zacj0SqeOscfhpv13RpWhy3Du9klk11v4L8Bdh0iLqR2Q6
 s1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723205777; x=1723810577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7vxauAGN1rhGfeqXXQFu1Oim75Pf7S6Ns7XXnQuOL8=;
 b=ZEQX8iJ1aaSwE8o2b5wYYMlv0Jfbpb0PqCGRzJvyDLFGDYiVerh8XYHzzrLIXwRswk
 ljXU/Y1pxXWrZfTTXJkgzFhBiQ2s4Xc5chFYDZ/wEbCRm0atGcfLXD7Y6iGBIZ5DYVHr
 e1081DUlY4QcsynybOwivzGML/co4LEePDhkKKddrgKBjv6gcJ/SvQj0E3R/m03jyfFb
 5TUcNlbmhr9ZwYfTxlcc4x1HR7UWNHHveUd2EXszxlBFdqVGrVCB4MPlVoYFXkGxHiFJ
 MXBwdADf2c+UAhEiIChD1QDBH1wcKuGpB6uErpkiCPJ7Boabc8h0iE2xIsGTN/9p9lRO
 NaNA==
X-Gm-Message-State: AOJu0YxaUiUNZgqasuWXwmPosq/xo9WXjnREmpN6TPXb3HjCrSQ419yJ
 l5iL5VD3GTT/0j/aqRXRkqNeLRsiiylL8h5GgMoppt+0cC7HtSvJA/Vnvfej
X-Google-Smtp-Source: AGHT+IF7cQsNtmWYEyEdPqbJYmpjYYVKtlLOoQ2/Mxmpo1MmetWUfWv/20/isRHG6hyEzr2sPqmk8w==
X-Received: by 2002:a05:6512:2804:b0:52c:d750:bd19 with SMTP id
 2adb3069b0e04-530ee981977mr972520e87.8.1723205776235; 
 Fri, 09 Aug 2024 05:16:16 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com.
 [83.233.6.197]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-530de478acfsm963801e87.242.2024.08.09.05.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 05:16:15 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: u-boot@lists.denx.de
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
Date: Fri,  9 Aug 2024 14:15:43 +0200
Message-ID: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Aug 2024 14:58:45 +0200
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

The condition 'ret' is always true as it is never set to other than
-EIO.

Remove 'ret' and the condition for copy.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

 drivers/mtd/nand/raw/atmel/nand-controller.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index ee4ec6da58..00d7e177b9 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -568,12 +568,9 @@ static void atmel_nfc_copy_to_sram(struct nand_chip *chip, const u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_hsmc_nand_controller *nc;
-	int ret = -EIO;
 
 	nc = to_hsmc_nand_controller(nand->controller);
-
-	if (ret)
-		memcpy_toio(nc->sram.virt, buf, mtd->writesize);
+	memcpy_toio(nc->sram.virt, buf, mtd->writesize);
 
 	if (oob_required)
 		memcpy_toio(nc->sram.virt + mtd->writesize, chip->oob_poi,
@@ -586,12 +583,9 @@ static void atmel_nfc_copy_from_sram(struct nand_chip *chip, u8 *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_hsmc_nand_controller *nc;
-	int ret = -EIO;
 
 	nc = to_hsmc_nand_controller(nand->controller);
-
-	if (ret)
-		memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
+	memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
 
 	if (oob_required)
 		memcpy_fromio(chip->oob_poi, nc->sram.virt + mtd->writesize,
-- 
2.45.1

