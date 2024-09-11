Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0A9EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FAD891ED;
	Wed, 11 Sep 2024 09:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GGucw/+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E11D88D17; Wed, 11 Sep 2024 09:11:37 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1BE9891CA
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so7432270e87.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038694; x=1726643494; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EvEkZF2r2AqggnLWTgwzPhL/JoYelLUDEL1aq/7CH+o=;
 b=GGucw/+EDKFZ0daQCNxvIhDG+Cn5Q3v0LNMCsd4rYYxFv4zPS0OGALL/m7IRoj/rpp
 xmVm+lqLU0aUHON8AM+WAiHdEDQsCDRFgZ43AXt+CVcmINjDv+H9cxZdmSi1QTDXeG+M
 9diqiWviT/DJqZ51HkwTsneGWfqFh6iipwnsfRhofkiztdgLR0W+zuIjUKjef83GQXAD
 Us/LLi0PJgYKhG2rmjVU/4vRMrKOI3pq9y4UKdQEEROTYjfE+pmjefKWAuSOI54bolh/
 IGwo2dBL4HmW8UkUVdnlG/93OgpfzTVQ9fzeqSwwWk1u20gjvtr+kw2Fx4/R8OR7UvjJ
 4YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038694; x=1726643494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvEkZF2r2AqggnLWTgwzPhL/JoYelLUDEL1aq/7CH+o=;
 b=puklRy/Vp3U5aQx6dHpBPZXS98+NWSHJ5E9QJyTzIko3YAl9Ka4vLG304lUqeYrob3
 yzy7etAQJUhpSDpgUGI/rgQM754rH5uv61H//1XwgY6AGYC5Psya3g0853eF6PFlTBjt
 BJ5O/MnXD+3FhIs6B2OlT4A8GnaisMSn56asn1YtEnh6/5ZIIkCYmg9TDM2MbMrjGNCj
 SElQkmyqlDZgKAkFX/P4Vs7iHwWorpiBLgLejqisAoMOMz8wH+VR0p5K44YAigPGtwku
 pDbmLCSLRHSVfVxAeeQWYcvh5XOtxaq6PK91XornPeaQbfAc3BjELidOrsQZEKQwCLUX
 djMQ==
X-Gm-Message-State: AOJu0YwibC9ZfxsMM+QSbp7txc/aqPuVKsaksDzXlwHp2X5nMcAiNdwT
 /KNQnkvmLRgC3GJ5ZxGkRGWrar8Sf4P0oZNTQnyNBIa83jnvgzxl1eAvkp2Mw+0aXLIol8yxF7A
 f
X-Google-Smtp-Source: AGHT+IHHELM51EHRzS+8G4S7O8HBYOT92XrkQd5DkIXa/7bIZTpDHB3azHBJocrhBtBtTsZVS1+7ww==
X-Received: by 2002:a05:6512:33c8:b0:535:6aa8:dc49 with SMTP id
 2adb3069b0e04-536587a672emr14143652e87.9.1726038694002; 
 Wed, 11 Sep 2024 00:11:34 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:32 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:14 +0200
Subject: [PATCH 3/7] mtd: rawnand: brcmnand: Fix potential out-of-bounds
 access in oob write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-3-be112a20aaf1@linaro.org>
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
 Florian Fainelli <florian.fainelli@broadcom.com>, 
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

Backport of upstream Linux
commit 5d53244186c9ac58cb88d76a0958ca55b83a15cd
"mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write"

When the oob buffer length is not in multiple of words, the oob write
function does out-of-bounds read on the oob source buffer at the last
iteration. Fix that by always checking length limit on the oob buffer
read and fill with 0xff when reaching the end of the buffer to the oob
registers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-5-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 46a4107a83a9..60d34bd21f53 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1334,19 +1334,33 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
 			     const u8 *oob, int sas, int sector_1k)
 {
 	int tbytes = sas << sector_1k;
-	int j;
+	int j, k = 0;
+	u32 last = 0xffffffff;
+	u8 *plast = (u8 *)&last;
 
 	/* Adjust OOB values for 1K sector size */
 	if (sector_1k && (i & 0x01))
 		tbytes = max(0, tbytes - (int)ctrl->max_oob);
 	tbytes = min_t(int, tbytes, ctrl->max_oob);
 
-	for (j = 0; j < tbytes; j += 4)
+	/*
+	 * tbytes may not be multiple of words. Make sure we don't read out of
+	 * the boundary and stop at last word.
+	 */
+	for (j = 0; (j + 3) < tbytes; j += 4)
 		oob_reg_write(ctrl, j,
 				(oob[j + 0] << 24) |
 				(oob[j + 1] << 16) |
 				(oob[j + 2] <<  8) |
 				(oob[j + 3] <<  0));
+
+	/* handle the remaing bytes */
+	while (j < tbytes)
+		plast[k++] = oob[j++];
+
+	if (tbytes & 0x3)
+		oob_reg_write(ctrl, (tbytes & ~0x3), (__force u32)cpu_to_be32(last));
+
 	return tbytes;
 }
 

-- 
2.46.0

