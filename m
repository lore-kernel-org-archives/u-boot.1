Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888BBCFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B36989262;
	Tue, 15 Oct 2024 06:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SC+Wy9vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0343388F24; Tue, 15 Oct 2024 06:09:17 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7418A89262
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea8ecacf16so785696a12.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965353; x=1729570153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJCotb6F8xEv62pHeeeP2FBRLw2yh6SOq0lDdvQw+ZU=;
 b=SC+Wy9vxlrDBu1A6VSho47RJsf6+kyPZij1zhamvY4mWN6tYAYK8DYpzt5o2IrlVK7
 wC24vSZBgreoy1rfzGVNUiG1r03pvrzuidCXLwSx65cietHdN2iWThVwoxpfaWVHsgui
 OWpIuLqUdk0k4+AX18a4hKM8SlXjeTtatvvMwz3YQEwqa0XKTNOwv8kagvmxwo+LBIc4
 QvIZqladRODzdwVYuE+QXN4txXZSSuOdcVjSAXyCCOFcQsZQPUW5iuWETJ1pUNh47d3w
 lXdGJxeWXtXhcw/QT8c+F9+0prQUWFGowOcsnK/rn+bh7tTzUAREXhtZ+sewJwL6Z1jp
 lsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965353; x=1729570153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJCotb6F8xEv62pHeeeP2FBRLw2yh6SOq0lDdvQw+ZU=;
 b=BFT+pfdmSCM7KEanxLsG0ey0P6pQ9Y1DPhH/yb7y9l1T88AcQ/6qAD3PIpjFC4oj1n
 oPbjMqeeyfIi/KP52kZ0H6Yx0tvnlA7w2jpWf6VnQnH0+eIYEs+fkRhE+jwhzrEzLyNU
 G12o1Q+l6o+psGqSm1sM6DXAyaPHmSHmo6wzbpTQ0T0/3mgOGN54oyawUusj3LeKHv+Y
 rLItnUDGz17GYuBi2T8O209eJMwbZRXid8Rx09R26WAgcv+0NG+NiGU5CIuwNnPzLJ9J
 7QLww/Z2AWN+tiWnDcrC0GD8Xmap8Bwk9ZX6fyVVCWhqueF5b/slZT360CnQPon4oX+C
 6Erg==
X-Gm-Message-State: AOJu0YyAVBdiM4CLSOjNOisjwAxLBmuKoNH5/96nSVnrrXrhHOf/UOS7
 OUHQmjaYieC3AZzcjftNea8kd/NQCYmBU1L4IPrMm07wJSkArOZKFMSQ195F
X-Google-Smtp-Source: AGHT+IE229n7h9MvYDp9n9jZ5w00mtmUtBvjpfRxIFogPv+KFwlU7UucrmlTHRap5TYiz1zVnl8NCQ==
X-Received: by 2002:a05:6a20:9f47:b0:1d6:97f2:5f72 with SMTP id
 adf61e73a8af0-1d8c9576f62mr15440047637.3.1728965352768; 
 Mon, 14 Oct 2024 21:09:12 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:12 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 1/6] mtd: ubi: Do not zero out EC and VID on ECC-ed NOR
 flashes
Date: Tue, 15 Oct 2024 13:08:31 +0900
Message-Id: <f8b5f9514b26ff0741f74b9b5e97bbb11ad9df4f.1728964655.git.Takahiro.Kuwano@infineon.com>
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
index cf0d702421f..104537784ab 100644
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
index 14be95b74bc..45699b4a477 100644
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

