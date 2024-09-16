Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F176C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46EC588F12;
	Mon, 16 Sep 2024 11:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ODJGwLeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD88B8899C; Mon, 16 Sep 2024 11:58:55 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D8488EE1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso3143126f8f.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480732; x=1727085532; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yKuLdsLuyes8mnBA3MrU0R/rfIaNO+BeT5q0k2EEnh0=;
 b=ODJGwLeH2GhZHvTvHoqHC18ZsTeKGxrCGLKb7H3znKE56zxTHkY/mjaz8WHPDtWCT1
 j1RZa/P80F3T3/KwRj/Rg/WWV10aPPo2CKVLKdawyLhkBSZvMq7rCWvSBcB0Wp8fFIpT
 bZW4xclBd6f5fU7zCyxC0BYx/1zZPYR0wYltjrDWdOTXKMLTdk+IqeolUgtLnmo5emHO
 ldwAu4LDGtipyBJoCS+n2TQZszcyC8mX/hIseVMcT1bOigamfEimEYS59un4zYfPaHLT
 dgL6P9pswaLs6Df6l/IVwYh2iUg/CAG7E/eUXZ3uhAZYt9hL1OW8WJ3iQ6s+igf4/xxY
 Ly9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480732; x=1727085532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKuLdsLuyes8mnBA3MrU0R/rfIaNO+BeT5q0k2EEnh0=;
 b=YLSSDxambd5CmLIqBH95q0yPvDtz61iGQ+ap+HKh5R5/almKNkKkPiE0iLZw3kAqo5
 itt2ZxoH7pik1o9In2788nIgDMGnAHaAJP/GxZeLeKmkLuc6I8RjRF/wjO9IW+hCXZMl
 pzxxKcNXAssBma/PBbBs/XfU129Qn24zvC9HC9h37jGV8gGsZ4UlNXGD7Sjks986ogrx
 ZZDyiCEuF+OoTmH/q/g45cG9z/IvXIFFxYSbdV2GvCnB7zTt9ARE19tTlWcSIKj/+zdV
 61KjJAdpXqmqR4kB6ol/YRCHKcybXyb/nsASXu/6wQ295mTQYqP1m2JKUCgkppZfKwhz
 5/Iw==
X-Gm-Message-State: AOJu0YwreoNUDd0hddzFmsh+YaNMUXW3u+kMSlT7VhK6VQpBye56Q72M
 nT8d/8xJvM9CzR0ICVgsRFQ3oisLtYTTJ2jx3XMYZQ4debep1UA/MooyJzjIyxQ=
X-Google-Smtp-Source: AGHT+IG6VnM81aZCJJVkL37Z/u4QU8F37kA4V3wgXKbeGYnaETwn7ABnifGOJiLutBThcoIQJMpmyA==
X-Received: by 2002:a5d:4585:0:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-378d61e282dmr8636146f8f.18.1726480731616; 
 Mon, 16 Sep 2024 02:58:51 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:46 +0200
Subject: [PATCH v2 4/7] mtd: rawnand: brcmnand: Fix mtd oobsize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-4-08632f64c8ec@linaro.org>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.0
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

From: William Zhang <william.zhang@broadcom.com>

Backport from upstream Linux
commit 60177390fa061c62d156f4a546e3efd90df3c183
"mtd: rawnand: brcmnand: Fix mtd oobsize"

brcmnand controller can only access the flash spare area up to certain
bytes based on the ECC level. It can be less than the actual flash spare
area size. For example, for many NAND chip supporting ECC BCH-8, it has
226 bytes spare area. But controller can only uses 218 bytes. So brcmand
driver overrides the mtd oobsize with the controller's accessible spare
area size. When the nand base driver utilizes the nand_device object, it
resets the oobsize back to the actual flash spare aprea size from
nand_memory_organization structure and controller may not able to access
all the oob area as mtd advises.

This change fixes the issue by overriding the oobsize in the
nand_memory_organization structure to the controller's accessible spare
area size.

Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-6-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 60d34bd21f53..552b239b95ae 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -25,6 +25,7 @@
 #include <linux/completion.h>
 #include <linux/errno.h>
 #include <linux/log2.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/processor.h>
 #include <dm.h>
@@ -2304,6 +2305,8 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 {
 	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
+	struct nand_device *nanddev = mtd_to_nanddev(mtd);
+	struct nand_memory_organization *memorg = nanddev_get_memorg(nanddev);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
 	char msg[128];
@@ -2331,10 +2334,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	if (cfg->spare_area_size > ctrl->max_oob)
 		cfg->spare_area_size = ctrl->max_oob;
 	/*
-	 * Set oobsize to be consistent with controller's spare_area_size, as
-	 * the rest is inaccessible.
+	 * Set mtd and memorg oobsize to be consistent with controller's
+	 * spare_area_size, as the rest is inaccessible.
 	 */
 	mtd->oobsize = cfg->spare_area_size * (mtd->writesize >> FC_SHIFT);
+	memorg->oobsize = mtd->oobsize;
 
 	cfg->device_size = mtd->size;
 	cfg->block_size = mtd->erasesize;

-- 
2.46.0

