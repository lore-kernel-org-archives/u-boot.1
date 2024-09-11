Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90311EDE998
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3107A891FB;
	Wed, 11 Sep 2024 09:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ILQTihuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040D7891FB; Wed, 11 Sep 2024 09:11:39 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD18891E2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so391669366b.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038696; x=1726643496; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yKuLdsLuyes8mnBA3MrU0R/rfIaNO+BeT5q0k2EEnh0=;
 b=ILQTihuwa8IQUynIW//yvkpd15O4t/2DiCXVa8r46qHP9qEArEnvrgH9PZM48VSkyS
 3qdl0kxa8tcGQkj375pGAUdNJUUupWC5NL8dX1iLUaROieiZQWkS45zlNRVPfv042x1z
 Ne8iiXvVLZUQxA97+qyQFFCWAapLwAbByznEZl3JhxoV9D2Te4dA9H15MOUh3+/v2sOH
 8dYrmnF+8PHX5/qxR/IjiEkMAOL/hZ8g4DuGWzIqAzQfOzEF94xx3fgHEdHOlAZCRre4
 IU+SypNFm3AUkuKLOoGLhWLlCLlZctCtyt64YnyrA2dDPoZhdAU5jiwzL+sfxmzjmhuV
 6krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038696; x=1726643496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKuLdsLuyes8mnBA3MrU0R/rfIaNO+BeT5q0k2EEnh0=;
 b=SjohcjekVJw8h3CC2oC8Rnwf9dzBewZtzEVjPtehBzo/B2difp+kci/Vf7scQoVt/E
 4LORl5IalsYvSG8OfVZuwVbm05Pj8ND62ofIlpqsl0NZXRlUpkJkld2hub6+OWZut8bj
 lLe1/Pae/XRfjuROQxU72ZY7qAqbfkWbhPmWZ+kALQIWGQ4zguxXJ9ITXh+8rZ0v9kP3
 l+VfL4haUz/t5/lCn/F6J1nEYe+gqfy1Xz96gJILjiWQ/+CxGLlYIRYwV3ezoRGSl6r9
 kuQfmtfFrvz2VmNLgBS1ox+lBKB3wanT8qX+IE9arIw0dWVOTnODtNFdwjsjr4bqaSDT
 TE1g==
X-Gm-Message-State: AOJu0Yxl/fk5JFoZIZRpJLO0c/yh90YCL1RjwYcJtW8qkBg/u6fq10Pc
 5A6SPXMpP6sRw05qAEWnG2HpaBT0DOhHFB3InvLb27r5liujeRgDnG+UXGnfMsGLDeOPY3W3Sm+
 F
X-Google-Smtp-Source: AGHT+IEJL5JhL+0gLkQz72doEpgV4nxtd7v1oRQzpqPaGljNIBm44miUhiLQRezfuOczmHdEX1f6/Q==
X-Received: by 2002:a17:907:6d27:b0:a8a:7549:2a25 with SMTP id
 a640c23a62f3a-a8ffab83e3fmr338426966b.36.1726038695966; 
 Wed, 11 Sep 2024 00:11:35 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:15 +0200
Subject: [PATCH 4/7] mtd: rawnand: brcmnand: Fix mtd oobsize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-4-be112a20aaf1@linaro.org>
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
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

