Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB033CEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE9588FF8;
	Fri, 27 Sep 2024 03:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kv2rjHBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D8988FF8; Fri, 27 Sep 2024 03:18:24 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95FAE88E39
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso1247885b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399901; x=1728004701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJCotb6F8xEv62pHeeeP2FBRLw2yh6SOq0lDdvQw+ZU=;
 b=Kv2rjHBTTmESyWQqXkGtOvYhPM4qwftaM2VYYjuhhEMKLZ/9dACq3zihuMC/FzGbvm
 AcDRgPAi1EBA49RzlfVI+u1QU/THTTPspZRjzKGqmsB7xaHSZpHc9NTlJzkUUL73OhPZ
 20e0qd9yjU1/zMlwpDdf57tDrkpXDsEWZ6EveFEOGB8e5pIjepsUUveYX/HsRCx/0TbJ
 UAT+bZ9uK8gHaYLKrvhP4AcklqCczh8/TGUurXUdlB/9e95pVVcxAai/qBlT1dKPn45v
 Uk7nCLRDReaFtEaN67n+O6cjijnvzwvkSJSKFXppzuUwRVVG3DtuNjG2dMT3844W3vLW
 6MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399901; x=1728004701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJCotb6F8xEv62pHeeeP2FBRLw2yh6SOq0lDdvQw+ZU=;
 b=PXOfPw6GTM+lFdHMfZsZvhRFIRNy/7m9vk1PW7R6/Tsin4tE4gLABpDoc1/CgPbu5Q
 ZTZ7byWqTIIOqgH6Pzl0SumiIHh5z+arg6aQAZ9dTuQW0fJWVgkzXMcM2bMz5xV+iXBn
 +oWJ/TeBy4k48NRcluJvccVB/Yo/9WQeSrKUWrfvCm6pB4BnleYF10mwMRRYtdnH9bDp
 sa3UVdTaX+LQAfXEzGdxiOzzPfk/IfC/dvYJREzAL2FSZSp2uuf8VyWnrXob4S4vRUtj
 +rhqIKtbvtlDqLBFLKcdHxANunkO0o8za+wsKVBIYfnE+4JC0mREerY3wT1LNp7in+hZ
 mMzA==
X-Gm-Message-State: AOJu0Yx2wcwlNrL6dS5p5akVSYxQFDFVOxEAXGQAZMrHbGjdBfDUjn1n
 z1dCy8btaoSf6vp3BAopzc+YDH/iPbduo0Pr22rW38M9hU8N1kFVnPbNuA==
X-Google-Smtp-Source: AGHT+IHN/WYgPUZb0ou9BLqdhJ+HQvBSdL9S/ltXgwELmUTZIqwqGHAhFXuBl9m9UUDiJR+f3nxJqw==
X-Received: by 2002:a05:6a00:4612:b0:713:e3f9:b58e with SMTP id
 d2e1a72fcca58-71b26044023mr2914714b3a.17.1727399900880; 
 Thu, 26 Sep 2024 18:18:20 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:20 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 1/6] mtd: ubi: Do not zero out EC and VID on
 ECC-ed NOR flashes
Date: Fri, 27 Sep 2024 10:18:06 +0900
Message-Id: <53a897774ae0b6357a867c0158cc68e01a578618.1727399650.git.Takahiro.Kuwano@infineon.com>
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

