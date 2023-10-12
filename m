Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8FDCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005CF86EF3;
	Thu, 12 Oct 2023 04:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kx9QgwKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C84D86E47; Thu, 12 Oct 2023 04:02:03 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E75286E8B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4180d962b68so3104591cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075807; x=1697680607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKhjPOwUMw3ZJ0erchfhGFGQw1ld4ycIswcjT4p3/fg=;
 b=Kx9QgwKNMYyQYgPV3A8a1UiLzWt4yErznmaoN7JYOWrCDN/DT7UAkrEEyFX9Kl4972
 45Ad+670pHej18AjaqU8e/VkPs0sQT9ivIgGSRgerMTyEezvoD9esXQsTSV/dnq9VqIc
 5xu+1bqQLcLvwgEwInxRhWXYIkkBq+K0C3BYSN5/eUh2U8NiEHlGdMoGRQt2utFBwLan
 oxpUO8RHj5r7oWTbY5WFr4SRQVxEZVlAI8Sj1hrkdPSZgYHpT8q5kAEjmGyBj6Z9tv+U
 w1UjcEvfMp4o7h1YM/zRytiQcW893AJHDZdj67fdYHoXPqFRs7t7Ux/cV1QbFN4bX2br
 CP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075807; x=1697680607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKhjPOwUMw3ZJ0erchfhGFGQw1ld4ycIswcjT4p3/fg=;
 b=lCldNzCUJ2cL0gWuzT7BGmTliLaWOiVUOYxw1qjexySAkCBhkGXBAFSfc37dCtMSI7
 Wwsbk1U0ndxYucfBxGg3Pyj0F58h9fuIxg2XaHz6AbhR2mgUfXDhXN8ikmbpjGA6n5+o
 WuJf0RzhzusenedO61fdVOUe8wy9xcORA0VFAkLzmwX2y1oEdEptBJWIXD+SDn+0sQnb
 mFFt5rVg7lOFUIXnNKNuQ/eMz4VWYAuxaV7OcP8sho6jI5Zf8d5K+EWT7T2JhW8splk6
 40AWQfqKjVYK8KMV6Nv/R4OwqjZ5IpN8rvEB2NaBzp01BZIG6P+tkQxU5xD1CpRf+kL2
 CM6g==
X-Gm-Message-State: AOJu0YzZfGD6RTPtxKPp+9rkstbuFb/w9QS1/ytHwe3Q1M5J2jt3VZfJ
 uGoW1iG55EH2xaz0eRKDQas1E7EmDOHrAQ==
X-Google-Smtp-Source: AGHT+IHaAePrXBZL/sbl+XrW00RJLmZxhueYyuwXC4lhT6oh2hqB36SUTrqbnz6gyidb+Hb9jDob3w==
X-Received: by 2002:ac8:5783:0:b0:417:a514:72d2 with SMTP id
 v3-20020ac85783000000b00417a51472d2mr26580500qta.63.1697075807593; 
 Wed, 11 Oct 2023 18:56:47 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 r8-20020ac87948000000b004196d75d79csm5788322qtt.46.2023.10.11.18.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:47 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 16/26] spl: Don't cache devices when UNIT_TEST is enabled
Date: Wed, 11 Oct 2023 21:56:16 -0400
Message-Id: <20231012015626.3487451-17-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

Several SPL functions try to avoid performing initialization twice by
caching devices. This is fine for regular boot, but does not work with
UNIT_TEST, since all devices are torn down after each test. Disable caching
so we don't use stale devices.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_fat.c | 2 +-
 common/spl/spl_mmc.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index c6e2526ade1..8bec9cce5ca 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -24,7 +24,7 @@ static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
 {
 	int err = 0;
 
-	if (fat_registered)
+	if (!CONFIG_IS_ENABLED(UNIT_TEST) && fat_registered)
 		return err;
 
 	err = fat_register_device(block_dev, partition);
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 67c7ae34a58..a8579e29dee 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -417,7 +417,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 	/* Perform peripheral init only once for an mmc device */
 	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
-	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
+	if (CONFIG_IS_ENABLED(UNIT_TEST) || !mmc ||
+	    spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
 		err = spl_mmc_find_device(&mmc, bootdev->boot_device);
 		if (err)
 			return err;
-- 
2.37.1

