Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C37EDE998
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E523A891F5;
	Wed, 11 Sep 2024 09:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OntOG8p3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B089891E7; Wed, 11 Sep 2024 09:11:42 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107FA891FE
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so8062737a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038699; x=1726643499; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0thuF0I1ZnDB7MFUd0vK4BvdCnk5Fzf2pv7fmJ53tVo=;
 b=OntOG8p30yPq9PlnunEi7WGkjVys6IiESyIC7oTrtGFzxON03iCPSkcP+1cNg9Xdp6
 5w1zjJprtaYjTofitMimicl748IGeAn0MILGsvJ5CCzUMIox0BF5FkRKT+2x4ZKvAYfU
 pZEO+UPGqpjf2gX1wpCWugO1n8X0tIQPOamIhfGaG1rlk8svjoSqQS3DiM6dsO/8bvm7
 h26QnWNvSGj0+/UUPwcW6tULu+Hn840fArw+WYTZiSIuHgE38AXrHNWweeoopd8L3knE
 Byog+J1VhO4ohZogVDQaJq3UeMYoxl9yC+4i/guGSUxK8RqfNTmFRg6ubGMncCm7tM0b
 D+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038699; x=1726643499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0thuF0I1ZnDB7MFUd0vK4BvdCnk5Fzf2pv7fmJ53tVo=;
 b=wTIGnXmlhV0/tMFqmuFLcmZuXi4bi9lCFpIXoPAdtQbjDXTNpUfW9tSKmTJmjQVig0
 wYQVEQFs7vwU2uUQaA+gccOyQoleNAqT2CwvwnTzvA1uQTSNFAUguCUfj8nNKONSUGKX
 CaH66YQACYw1r2ihp9R1Fk0CIxixrc4TRuI0MFu/zeFw/KIHOgVNzAU2fbufcCSV8Qlb
 F81Fv5r6MTIvuxvRcN4WV52pTh+UIGaiauawzb8qzHbQogmdt3smIsh+cxRsAHAkeejw
 IC1GcqjsnkfOET9zk2MXmIaH17QLJeWH/77M887Tk8iUbT1V9VpBObdBBI+VpuhvdWBr
 i4ZA==
X-Gm-Message-State: AOJu0YwL2iM9Rk5tiycm+UE3fHd0fljfwwrwNPTVWAIx3FOMim4t3BOy
 SsV+G0zihwwjiR6z9TdXOpB1w0o9H55VXMM0r5zKHTDwKxvbDacKTryFxB5SKGM=
X-Google-Smtp-Source: AGHT+IE1cUP1IvN43TwCqtcenkVj/MlKLHVT/2TsXXPCq3j+2Phcbf1u0W06pbILArdgeDBUd8DEog==
X-Received: by 2002:a17:907:7f10:b0:a7a:af5d:f312 with SMTP id
 a640c23a62f3a-a8ffad9d1b3mr321307466b.46.1726038699324; 
 Wed, 11 Sep 2024 00:11:39 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:38 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:17 +0200
Subject: [PATCH 6/7] mtd: rawnand: brcmnand: Support write protection
 setting from dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-6-be112a20aaf1@linaro.org>
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
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2f786584a1ae..55d5d27438a8 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2847,6 +2847,14 @@ int brcmnand_probe(struct udevice *dev, struct brcmnand_soc *soc)
 	/* Read the write-protect configuration in the device tree */
 	wp_on = dev_read_u32_default(dev, "write-protect", wp_on);
 
+	/* Check if the board connects the WP pin */
+#ifndef __UBOOT__
+	if (of_property_read_bool(dn, "brcm,wp-not-connected"))
+#else
+	if (dev_read_bool(ctrl->dev, "brcm,wp-not-connected"))
+#endif /* __UBOOT__ */
+		wp_on = 0;
+
 	if (ctrl->features & BRCMNAND_HAS_WP) {
 		/* Permanently disable write protection */
 		if (wp_on == 2)

-- 
2.46.0

