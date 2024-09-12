Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F1EE6454
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6208B88ECE;
	Thu, 12 Sep 2024 09:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVEa8DmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0277F88ED3; Thu, 12 Sep 2024 09:38:05 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9D18870D
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2db85775c43so437356a91.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126680; x=1726731480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veaXeuuI3mt3Uoizz6tmhWGr6eiVVK8H4odSRF4/wWw=;
 b=eVEa8DmYzru5zx+FqAYUDLzitXFuMJc7THsQ2OVOWCePUasmTep98OIn7E/giWBGUk
 rPaBpAn4C8Pa4iH2dYL6GieVm0vpfnZIhq+OtzCvxeWTuSSTyemMpxkQKdvByfXYe2Tj
 nxpCZ05doXNorG3VPzdKiOLM+QX9xXlgY1Qe2K534N/aTzxQBkVxQ8VsO4XTinOfr/go
 ARY3m0Oh6Br2WfhfBCTT6FxdSqJtTAaDoXxS/Siaio4SAWeyfkv51GQOkLG8aFwksAAE
 5bV0FVxeAhN0029ECRArj3OTtvTEvGfjrAZCiTVYvnLaG0V1t20QXBqgyiHlr7jVyutA
 bxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126680; x=1726731480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veaXeuuI3mt3Uoizz6tmhWGr6eiVVK8H4odSRF4/wWw=;
 b=BTNBmZW+iOedGjhgZqqT9t4K4WqEu5MZ1CbYx+cHm7YZxFOalLkcGIAatCCkEARQjs
 bug9WpfDOlqU4dDA6V9G1NqwJAd2A+5eEOU6qQoy/JV4+egBk9vO3PhbJ1E3vU0CoGYa
 KmQsMnd5Zgw4GQHSZ+VieanwbxWVcKq1jUyv5pUN9nGgIJCmnqbChEZr4gaM5HRJ11J/
 BY5V8ug7We98nY6yJLGTMhd2nISFpCGkxLZvyMCyjMCLOns09jdV0kxGgzIceAIfJZNl
 kuEbcuMNrMO/RNnXnNsKa7jNiEmntyP/azdBj3Z6+UvbpGLjTOxkzZdYDW/wGllxdIk1
 Gk2g==
X-Gm-Message-State: AOJu0Yxu4U3ydDrbhBjhojWz0Tent5ug4vO+0sA4sIe3M/erSj89I5as
 DN/yaiK+/rYDqZvJKJkKkS2osKAsnM76T5QvV/Q/FbtLwaazhwyTS7OTWg==
X-Google-Smtp-Source: AGHT+IFoglAWf8Vnl+T/WVFQq2wY6eVk1bRZCC/lQaOBu+A17u3YCPuFApKx+OGV1JflpnTbQQW7UA==
X-Received: by 2002:a17:90a:640a:b0:2d8:85fc:464c with SMTP id
 98e67ed59e1d1-2db671ae57cmr15112663a91.11.1726126680204; 
 Thu, 12 Sep 2024 00:38:00 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:37:59 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 1/6] mtd: ubi: Do not zero out EC and VID on ECC-ed
 NOR flashes
Date: Thu, 12 Sep 2024 16:37:19 +0900
Message-Id: <4a106ff5909abde8c398a4f804666fc163a21358.1726126079.git.Takahiro.Kuwano@infineon.com>
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
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/ubi/build.c | 4 +---
 drivers/mtd/ubi/io.c    | 9 ++++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index cf0d702421..104537784a 100644
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

