Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08240C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 04:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCAAD8814A;
	Mon, 15 Apr 2024 06:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSwj5JVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24C887F4A; Mon, 15 Apr 2024 06:33:28 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A9E8813F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e5b6e8f662so17912205ad.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713155604; x=1713760404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYE8fBl7DHsL22Uywfx6/RlquJ/DWq5IP8WWasIR4P8=;
 b=YSwj5JVUkh99jV7W+i+9drCCdsGy0n0aKcgvQFi+NYaTReOVK3XXd9ew5HjYC0rI/F
 jGFLpoVNV7d27ZDb7aRkWKg4paYW5n3btqTQ61RT4Pj3wSK4/Xp/x0bHGeK88cqliB+E
 2VaAFfeyq4m2r18L66z9vYC2WNWWdW7BDwSGcRqaCabBUHdceTeEgURZHTwtQJp1h+Nm
 haYO+sasSjhx2RYwwe9TINMeRJakqAIRvFH3F2jQ9eCZiSEz1HnD1Tb0sMePh48cRU69
 gm6IfnLberkMCE+F4rGAYPb4ow3RxHS8LgZTwXUILqpEt52zaqBbAmtWG/d+ek/LvxGJ
 Wqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713155604; x=1713760404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYE8fBl7DHsL22Uywfx6/RlquJ/DWq5IP8WWasIR4P8=;
 b=Hja/62eQIXVPSF4ggj6yE2u1G0WM4AhVCD2WKi604cJ5FKLx+6GIWf/ktVb0nWQupm
 1GbFvlMKaPF6xtTWNj3WkAdkQio5sDQwk+03X1+XrBs+NyrnW4P01UDCNqAqXz23ZGbK
 PQWo31VxXeoR8yS/b6yxicQQquF+QgspMTe4iCVfyUT65lPqpiWfyacLru1DMx6MgDca
 m7SHPSLlPbcOBu6b7GOPpsq0ITwV9mGRK0pmyW0CQU3XhOHV3wOA/ettyPFRcgUr+fUp
 CgcSvjDYEcAdPmtVAT7JjcFXUVgQce1npsp9F9AaaTnSyFH5NfF/IqYE9enT50HCtxEY
 c3Yw==
X-Gm-Message-State: AOJu0YxWRzCIGJ15Bxxoe4q7/LNItzoJxgbQlS9yAWgbxNdgk6AcwqMa
 q7X/QgT/geClYLWvlzvkWYB29ds1dKSYLxeGXDt7lvvIc0FUs03fWys7MQ==
X-Google-Smtp-Source: AGHT+IGOAXb+BUnRvcbeQ8Ao5SP2FhEJdmxhd5AUmfKJjwjKNMqY/PEVxN6ov5oRgCPhlgZgcrnWFw==
X-Received: by 2002:a17:902:eb86:b0:1e7:7287:bbcf with SMTP id
 q6-20020a170902eb8600b001e77287bbcfmr1088624plg.39.1713155604479; 
 Sun, 14 Apr 2024 21:33:24 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm6902682plh.290.2024.04.14.21.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 21:33:23 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 1/4] mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
Date: Mon, 15 Apr 2024 13:33:08 +0900
Message-Id: <87a8c4db9598aa2deb52c41895191b17070ca156.1713154967.git.Takahiro.Kuwano@infineon.com>
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

For NOR flashes EC and VID are zeroed out before an erase is issued to
make sure UBI does not mistakenly treat the PEB as used and associate it
with an LEB.

But on some flashes, like the Infineon Semper NOR flash family,
multi-pass page programming is not allowed on the default ECC scheme.
This means zeroing out these magic numbers will result in the flash
throwing a page programming error.

Do not zero out EC and VID for such flashes. A writesize > 1 is an
indication of an ECC-ed flash.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/ubi/build.c | 4 +---
 drivers/mtd/ubi/io.c    | 9 ++++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a1941b8eb8..81c1b7bdbc 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -679,10 +679,8 @@ static int io_init(struct ubi_device *ubi, int max_beb_per1024)
 		ubi->bad_peb_limit = get_bad_peb_limit(ubi, max_beb_per1024);
 	}
 
-	if (ubi->mtd->type == MTD_NORFLASH) {
-		ubi_assert(ubi->mtd->writesize == 1);
+	if (ubi->mtd->type == MTD_NORFLASH)
 		ubi->nor_flash = 1;
-	}
 
 	ubi->min_io_size = ubi->mtd->writesize;
 	ubi->hdrs_min_io_size = ubi->mtd->writesize >> ubi->mtd->subpage_sft;
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 14be95b74b..45699b4a47 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -563,7 +563,14 @@ int ubi_io_sync_erase(struct ubi_device *ubi, int pnum, int torture)
 		return -EROFS;
 	}
 
-	if (ubi->nor_flash) {
+	/*
+	 * If the flash is ECC-ed then we have to erase the ECC block before we
+	 * can write to it. But the write is in preparation to an erase in the
+	 * first place. This means we cannot zero out EC and VID before the
+	 * erase and we just have to hope the flash starts erasing from the
+	 * start of the page.
+	 */
+	if (ubi->nor_flash && ubi->mtd->writesize == 1) {
 		err = nor_erase_prepare(ubi, pnum);
 		if (err)
 			return err;
-- 
2.34.1

