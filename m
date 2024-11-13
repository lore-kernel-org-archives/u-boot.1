Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD5CD41C3E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A76989589;
	Wed, 13 Nov 2024 14:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CdAl5kVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757D789537; Wed, 13 Nov 2024 07:27:28 +0100 (CET)
Received: from mail-io1-xd63.google.com (mail-io1-xd63.google.com
 [IPv6:2607:f8b0:4864:20::d63])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5536E8950B
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd63.google.com with SMTP id
 ca18e2360f4ac-83aac40e908so4092039f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 22:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1731479245; x=1732084045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUqpk/mRrobL+XpkN103WBT0NpFuN511/5/ROZ4KM6g=;
 b=CdAl5kVCM3sUWAoCB6HNC5FE7abFtgasK/gt1jPWZ8C4ykb6KMaqPUIbRzRVal3rnm
 ywoDiLFKzytYOXXTpOOpxo6Xs5IGG9FQs14jxlsuTfFHojX6FWqJPJa97wKtbfec/zff
 jJniX9x+kNZRphJ0/Ev8uTbFRrE9YMUo3bIug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731479245; x=1732084045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUqpk/mRrobL+XpkN103WBT0NpFuN511/5/ROZ4KM6g=;
 b=rDRobfv9MZhBaKNL8Pl345m0KPAaz7ocf97aAqZYpPT+PeKcd25ALuGmgPeovQ92q/
 fOjlm+x9IGHQ23NLCD0V2rnZPArvSL9xxAZINmKghJX0ZJy9MJraQbsbTg4WD2b2Y3/j
 lpKCshPIODN5FX/cwERKhX05uApiYDaNkkQ6lr0tbDIKO5A/8aSF2CpVkGJo3brdIxyn
 Yrjw8COBhZo6O3rkRQTWZ9h0OY3ns3iXcXbx76rFQuxbRbAv8xOeEGjF5+HMzztfhGoY
 4smhw/RfEzsMsYgaVakJRR7vbePtGfEIxWmNUvwox/oXvV5i0EL/KgIKO2bPyg9nbgXO
 FlMw==
X-Gm-Message-State: AOJu0YzWEqv5qhslrGR1PGLDMFdt8LRgB/+w3pGp5QiEUJV+ya69Oyqo
 /CPwnQmTmm894Cvd+llVm5SoCoCzwAH+YNCuLCcsydPU+LyeZhiWvh5AqQurFrrMtvPisyzTY1C
 LLCghIO37YvoIHjtnKNkWe7TaK2G//+SN5OyGFvSZ5aCdDhUBPTmgg0VxsE/BawZ0YlZEseM96P
 jufqOMH401R7yb+ZOZ65hcBjFBBImP99YudAnzy8geX3UBYZTjPz5KU4Q/q/7zb1abKwE4
X-Google-Smtp-Source: AGHT+IFvjbYGXU53bcrGhMcTsV3V/ssQa6xJKz7rMHeA7PfWOza0buxLRCegBgENp50H5MbRPIBwRhv8c7w1
X-Received: by 2002:a05:6602:2cce:b0:83a:acc8:5faf with SMTP id
 ca18e2360f4ac-83e033ed139mr584060139f.5.1731479244950; 
 Tue, 12 Nov 2024 22:27:24 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-83e13584b67sm87580139f.31.2024.11.12.22.27.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2024 22:27:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 3/4] mtd: rawnand: brcmnand: Default bcmbca
 parameter_page_big_endian to zero
Date: Tue, 12 Nov 2024 22:27:14 -0800
Message-Id: <20241113062715.2872-4-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241113062715.2872-1-dregan@broadcom.com>
References: <20241113062715.2872-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:05 +0100
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

Set parameter_page_big_endian to zero for bcmbca

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 749553c9df90..7fd9e1855d1e 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2793,9 +2793,17 @@ int brcmnand_probe(struct udevice *dev, struct brcmnand_soc *soc)
 	nand_hw_control_init(&ctrl->controller);
 	INIT_LIST_HEAD(&ctrl->host_list);
 
+#ifdef CONFIG_NAND_BRCMNAND_BCMBCA
+	/*
+	 * BCMBCA platform does not use non-linux parameter-page-big-endian dts property,
+	 * param page data is little endian
+	 */
+	ctrl->parameter_page_big_endian = 0;
+#else
 	/* Is parameter page in big endian ? */
 	ctrl->parameter_page_big_endian =
 	    dev_read_u32_default(dev, "parameter-page-big-endian", 1);
+#endif
 
 	/* NAND register range */
 #ifndef __UBOOT__
-- 
2.37.3

