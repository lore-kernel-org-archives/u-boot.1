Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD08FC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91DE88F01;
	Mon, 16 Sep 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GNE6+d0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD1A88EF8; Mon, 16 Sep 2024 11:58:55 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D4988EDB
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso451331266b.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480731; x=1727085531; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EvEkZF2r2AqggnLWTgwzPhL/JoYelLUDEL1aq/7CH+o=;
 b=GNE6+d0OvUvq1QIEWPCNzG7UXgfCVWP4ycbLz2k7uY3D0v3BLCNDm1RxCIOHBrQ6zj
 rk2eFd5Gj1me41X2rXfokeiWJETX49+DZpsvkh9bCuTFkcpP+b5XMcR8/frPOggFFPbi
 5XNcrYsWFagHBeT7Xo9XDgtSU6ODlDGeXYa3CazBB9NBor/11SywqIdv8kiWM0jwlXtd
 R5NzZHstc79HFXXUjAfURsAtBJ74R6oYNBD0ObPVBezMgp0IXXuBbn/CXIkPBgpjCty3
 RRSR5K1B5kiQvLcgPi3c4M7Spy6Df5FF3evkAbHFD84wPFN9U8gDulhiJ6qwFTV8cesq
 y2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480731; x=1727085531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvEkZF2r2AqggnLWTgwzPhL/JoYelLUDEL1aq/7CH+o=;
 b=Xe3Q087agOWyIm2TU2g5ChxwUTlaP6imN7Xsr0y3zeoXTa3nC8of6/dxuHn9caGNC7
 Ipa7COHHHyBa/+VJQk5hT6C/9Wu5VVYap7DjFLHRy4HCedUX844C8UAXsv3Z83peQzaW
 S1GlE7OQPl5yQrg5rgDl23SYPdlVAMoSfo6xmmXGLDT9ygRaW63P+UiYB8lP4s+H0/SX
 NVCnboQxi/WjwbUL1IGPvYyEA3MIf4d9lZ+lHDi1ATE+m0N1nUYtwd4zuQil7HY7uO5P
 Kk4yCx905I8OoytdctIxFYBkAG69IkCKoWT0K0Tu9Qwzt04F9SFjyfWyZjDVuLr6NabD
 +SYg==
X-Gm-Message-State: AOJu0YyDb5sN/PdB6oOBfkQatO8x3PQX83s2XgmU61icyEGrzN/bA7Jy
 ZjoSh0MN3rolMJv7BBHFVi9CpjKxk0kaOgh3jtdOUft5gSmyLqs4EfripgtcQE5pGIr5XT/bxOH
 b
X-Google-Smtp-Source: AGHT+IGOIgggKsf+aOs7KjkhXp77teuPvqK31HHa2MU2HkT08WVwPxbFCPd5m8Mw5FKpjJuyJ7fWJA==
X-Received: by 2002:a17:907:f75a:b0:a86:a90f:3025 with SMTP id
 a640c23a62f3a-a90480ce2a2mr1108324766b.59.1726480730636; 
 Mon, 16 Sep 2024 02:58:50 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:45 +0200
Subject: [PATCH v2 3/7] mtd: rawnand: brcmnand: Fix potential out-of-bounds
 access in oob write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-3-08632f64c8ec@linaro.org>
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

