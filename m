Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B347C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4F988EBD;
	Thu, 25 Apr 2024 06:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANbhVeHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE44D88EB1; Thu, 25 Apr 2024 06:53:46 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C9B8803A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso4912305ad.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020823; x=1714625623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuRnxH/lpxvZaB6Fy7v+ZVA7yjgtugy1d+XuLUHmc9k=;
 b=ANbhVeHv2cAhdEK5N0HfyQh2UUKPPKyV4gNU3X98RlMdrtczWGsR2yj3fDPkhrDrms
 Dk1TIXcz0PyWBcaUgGBHPDbqkQyk2u+fd8Gp3Pif8uSc+Cs2SZ1z3yUouB1QhE4yOH/L
 Prq/7WhmKmo6go4m21cutYL/y+XIN5aqTQm5j6IVIiBaof6+o1E5uP3834rEbI000lvu
 FovNDiB9jxcwQB+bOx8fFmfgnZ3lTRrA5DqjnUuyIKbIPnX3e+INrZIidRK9STpOYrxH
 N+ylMdZdpvXyCQWPKB5pF0vCK6Y9Foxtk5r7PpMG8oeYHASDTDdB89v7Z+Ki4sK/mTzY
 ff9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020823; x=1714625623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JuRnxH/lpxvZaB6Fy7v+ZVA7yjgtugy1d+XuLUHmc9k=;
 b=ID3SpZQIoptR2NXEyzElgX+UiMCxCe3EWxJzIo7JlqiGIY5I2PqhKRxtelwxpoDeMI
 2Ce8jGCuzY2ocgbGnUD35QrOV/fhGdrZYnho5nEPXo4wp+fNdA9E/ST9lxsPtx5FYYz5
 DJrtargnsUKmHVTM+yN9oeptGHoCe1quPxrWdZUOypppzOuRSnruw3/AFCefME2wzIML
 uy6OxHu8aP3J0SDBysbM1CAYoIPT35Ar6Xek9deMsqUFQ82HL5FDVnAvoHJ2IHlIdAXF
 ok68hHavwtbH9Pu52QOysoyYpK59c6YmzD8KKBzwQXqr1hA6kLMYrBGTowyGNG1OwwjH
 qAFg==
X-Gm-Message-State: AOJu0Yw+0vAyk1QG6y5mSWP4UNNc1b9ne0qQxrTfVjap8iyOAKhMm/De
 ohaClKwWb7qE5aJT/2uXB9GBKY7aDmbqcIgLzmpVnAaD2TSPqiYPjII7+g==
X-Google-Smtp-Source: AGHT+IGpvH5Jh/eAyMUOm+Kg4SdmI2Y9g7fDEnQOPg/t5MEyGAKYRlBHWo6rT/EXicWnTKJNXAm/+w==
X-Received: by 2002:a17:902:edd3:b0:1e2:6d57:c1bb with SMTP id
 q19-20020a170902edd300b001e26d57c1bbmr4172615plk.21.1714020822727; 
 Wed, 24 Apr 2024 21:53:42 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:42 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 1/6] mtd: ubi: Do not zero out EC and VID on ECC-ed NOR
 flashes
Date: Thu, 25 Apr 2024 13:52:11 +0900
Message-Id: <b92b89d130f8075cebf74bc02eb6efe41afc6d75.1714020303.git.Takahiro.Kuwano@infineon.com>
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

For NOR flashes EC and VID are zeroed out before an erase is issued to
make sure UBI does not mistakenly treat the PEB as used and associate it
with an LEB.

But on some flashes, like the Infineon Semper NOR flash family,
multi-pass page programming is not allowed on the default ECC scheme.
This means zeroing out these magic numbers will result in the flash
throwing a page programming error.

Do not zero out EC and VID for such flashes. A writesize > 1 is an
indication of an ECC-ed flash.

This patch replicates the following upstream linux commit:
f669e74be820 ("ubi: Do not zero out EC and VID on ECC-ed NOR flashes")

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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

