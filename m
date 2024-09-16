Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3CFC3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CD988EF8;
	Mon, 16 Sep 2024 11:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dc1EZNuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFBF889BD; Mon, 16 Sep 2024 11:59:00 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C7F88EF8
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso592456766b.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480735; x=1727085535; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pwjIZKsumLweFU0kBnBpQNPYQFt5jGri6gUp/14tvEY=;
 b=dc1EZNuGfveTovVyDPX/8yl2k0sKbdlG7q7J5MxZ626xppmiwiQ9/df3yUNrZH/ZKc
 09QiQjh4rdLELY/c3JRp5H+TzXeqgf2BXQX4vRo7hziu8e4X16noLMrq6rrapxE5TQaM
 SHDZiarme+Qm0Cau5DUWo63kPDlHlQSsPk6/t4mfCUGL3OJDopNve8CpNIpcOJ/uy4z9
 /AW2cxU2SwPFHZtAAJPwspX6jDjSnGmz7IwMBXMxheON0kGOLUHlVdtYKfmQz+PvsQJ/
 F0X5Iz9wo/PzkibaMrOCQeZqvNM37vBA8EZ0mCudQMl5kw1CRZlGtFV4kzqZg9cdanZH
 DQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480735; x=1727085535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwjIZKsumLweFU0kBnBpQNPYQFt5jGri6gUp/14tvEY=;
 b=G430+qq4I+Tt9fJSyzV/mxc+wJnkjKAcyVLTdCR0trY58Q+tZ5djZF/dZ33xkBoOvr
 mYiIp5QrbsBd+xaxDrWTEjwPsV6cNJ7Kt21fN1hpEi3ct+MFt9NW513NGahA7ZYPoahJ
 PTvnDFd2UZjhMGVjPwEjJeSM4h1Fd1Qb2xayeSdq0ee+jvkwR3JxPCceKz+NORynVsxR
 ZyC45koLM2eEiXmkdjENcPkdRkc7l37AEoGiP/YlgGJCZKF8AgPPnJiMjgi4KCGvhI9d
 e5yFdIMl3J3+v+itG8BkhnkQkQSenfl0+yIDF1Tg6rONTCq9afihPg2vSRj9K6IrxAeH
 /ShA==
X-Gm-Message-State: AOJu0YxFfJ2l8IddeFJ35qwq7/E3nru/XKt/P8gG8mO1+rTiJA71cuxU
 V3DhtJ0bzXJGZXzH2MMpVyBj95RbERxggAY+16UEi/1bbHNUW03nzjZuld6NsWA=
X-Google-Smtp-Source: AGHT+IGnAJ8o3JiXNX2JQGCNIuWvPmDPwxPcwv8JkYkutqqYpAJOwyDKjZx+b+N8+uH434VvDuHw0A==
X-Received: by 2002:a17:907:f783:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a902949aec3mr1479023066b.28.1726480735528; 
 Mon, 16 Sep 2024 02:58:55 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:48 +0200
Subject: [PATCH v2 6/7] mtd: rawnand: brcmnand: Support write protection
 setting from dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-6-08632f64c8ec@linaro.org>
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
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>, 
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
commit 8e7daa85641c9559c113f6b217bdc923397de77c
"mtd: rawnand: brcmnand: Support write protection setting from dts"

Augmented to also support the "write-protect" boolean property.

The write protection feature is controlled by the module parameter wp_on
with default set to enabled. But not all the board use this feature
especially in BCMBCA broadband board. And module parameter is not
sufficient as different board can have different option.  Add a device
tree property and allow this feature to be configured through the board
dts on per board basis.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240223034758.13753-14-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2f786584a1ae..071b33951648 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2844,8 +2844,17 @@ int brcmnand_probe(struct udevice *dev, struct brcmnand_soc *soc)
 	/* Disable XOR addressing */
 	brcmnand_rmw_reg(ctrl, BRCMNAND_CS_XOR, 0xff, 0, 0);
 
+	/* Check if the board connects the WP pin */
+#ifndef __UBOOT__
+	if (of_property_read_bool(dn, "brcm,wp-not-connected"))
+#else
+	if (dev_read_bool(ctrl->dev, "brcm,wp-not-connected"))
+#endif /* __UBOOT__ */
+		wp_on = 0;
+
 	/* Read the write-protect configuration in the device tree */
-	wp_on = dev_read_u32_default(dev, "write-protect", wp_on);
+	if (dev_read_bool(ctrl->dev, "write-protect"))
+		wp_on = dev_read_u32_default(dev, "write-protect", wp_on);
 
 	if (ctrl->features & BRCMNAND_HAS_WP) {
 		/* Permanently disable write protection */

-- 
2.46.0

