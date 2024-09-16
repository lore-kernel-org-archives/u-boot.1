Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BE6C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 10:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78DD588EFF;
	Mon, 16 Sep 2024 11:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A5lpU3Qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B8888EF4; Mon, 16 Sep 2024 11:59:00 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BE888F18
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso451342266b.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480737; x=1727085537; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qkiBDX/+saVsGPGZuKtDqACV/GhwNNMijBezP/1HGZI=;
 b=A5lpU3Qj8Q8l/pGBg2sZhn2CeUqQvP+d3N750ttLv43saYazOKTPQB8rVHYBLz9yfh
 gH0Vl80U5LQ2H0e0ub2uN7PBYygnckGEmUHWGfD13cqRr64+ji+gKUpqj/+HzzYZftGt
 uzkl0IYVny+m5wUHps0gr5wqGuM5Q4+VRwdQVCE8K6w5jQ77vOjj7ZsVVuFq+pWGGpsl
 iQDgpOLoPyLcRc2l/mQ9iu5+p9UeoaiLHe35USFcMQiUUX9fEB4A2xx3f7F8b4cn6DGZ
 KpFlf9ZcINN0uOZXSDNmkt4vrd0HU2wcwk0b5pnNaFf2b0NgXH53FJW3CitNaTrlc4In
 j6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480737; x=1727085537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkiBDX/+saVsGPGZuKtDqACV/GhwNNMijBezP/1HGZI=;
 b=WQGrH4qJ0b8D2RrUGo0jv4Rhu936A+0bevy2R1uIX7WdNPRIaX9BMr0aU2IZGbBoSs
 o2ZlsbqwpOZnf4YmdegD1bAz4bHgDx5PbXQxQb8gtHgDr2cYhUAn7RnhV/Kd3o0mX+mZ
 NwUeM0ldlI1EP/tZNA2FKYQJd0l8tDnvQyNtwTXDJzBjFrsvNHp67fIOvjn2W0Sn2epP
 46jIOZZRJLCvHPgljFCY2yXco9y1KcXbtxHElJIZRLgw+U2TT19V+6GF+PQ/YZ/SmOrI
 v0J5Vi2DKcJUNYr1QFXkh9mF5sWjYh75cgcpukteOj5FS4kBAfDVu1E6iRX9nJLvFsGT
 0ICA==
X-Gm-Message-State: AOJu0Yzt3+k44WvF3OMciRYGCIVeywuLKrJYeg/5Vgk2NWtgVHnIbKjg
 6HztwBhK2ofkKOsGzvIBxygvs6ItNf30763cwc5n/5HW+mJV1q+ztVH4zyZYyLk=
X-Google-Smtp-Source: AGHT+IG7h+kdaU8uGjJ8mQ40IvAMjAvR2DdnhsTUgziRgdekuW0OK4ILuhskSGM8bX19nv1Amg8jhQ==
X-Received: by 2002:a17:907:60d1:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a904758f269mr1141033566b.0.1726480736850; 
 Mon, 16 Sep 2024 02:58:56 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:49 +0200
Subject: [PATCH v2 7/7] mtd: rawnand: brcmnand: Add support for getting ecc
 setting from strap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-7-08632f64c8ec@linaro.org>
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
 David Regan <dregan@broadcom.com>, 
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

Backport from the upstream Linux kernel
commit c2cf7e25eb2a3c915a420fb8ceed8912add7f36c
"mtd: rawnand: brcmnand: Add support for getting ecc setting from strap"

Note: the upstream kernel introduces a new
bool brcmnand_get_sector_size_1k() function because the int
version in U-Boot has been removed in Linux. I kept the old
int-returning version that is already in U-Boot as we depend
on that in other code.

BCMBCA broadband SoC based board design does not specify ecc setting in
dts but rather use the SoC NAND strap info to obtain the ecc strength
and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
this purpose and update driver to support this option. However these two
options can not be used at the same time.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240301173308.226004-1-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 70 ++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 071b33951648..749553c9df90 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -980,6 +980,43 @@ static void brcmnand_set_sector_size_1k(struct brcmnand_host *host, int val)
 	nand_writereg(ctrl, acc_control_offs, tmp);
 }
 
+static int brcmnand_get_spare_size(struct brcmnand_host *host)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	u32 acc = nand_readreg(ctrl, acc_control_offs);
+
+	return (acc & brcmnand_spare_area_mask(ctrl));
+}
+
+static void brcmnand_get_ecc_settings(struct brcmnand_host *host, struct nand_chip *chip)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
+						  BRCMNAND_CS_ACC_CONTROL);
+	bool sector_size_1k = brcmnand_get_sector_size_1k(host);
+	int spare_area_size, ecc_level;
+	u32 acc;
+
+	spare_area_size = brcmnand_get_spare_size(host);
+	acc = nand_readreg(ctrl, acc_control_offs);
+	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl->ecc_level_shift;
+	if (sector_size_1k)
+		chip->ecc.strength = ecc_level * 2;
+	else if (spare_area_size == 16 && ecc_level == 15)
+		chip->ecc.strength = 1; /* hamming */
+	else
+		chip->ecc.strength = ecc_level;
+
+	if (chip->ecc.size == 0) {
+		if (sector_size_1k)
+			chip->ecc.size = 1024;
+		else
+			chip->ecc.size = 512;
+	}
+}
+
 /***********************************************************************
  * CS_NAND_SELECT
  ***********************************************************************/
@@ -2323,12 +2360,33 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	struct nand_memory_organization *memorg = nanddev_get_memorg(nanddev);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	char msg[128];
 	u32 offs, tmp, oob_sector;
+	bool use_strap = false;
+	char msg[128];
 	int ret;
 
 	memset(cfg, 0, sizeof(*cfg));
 
+#ifndef __UBOOT__
+	use_strap = of_property_read_bool(nand_get_flash_node(chip),
+					  "brcm,nand-ecc-use-strap"):
+#else
+	use_strap = ofnode_read_bool(nand_get_flash_node(chip),
+				     "brcm,nand-ecc-use-strap");
+#endif /* __UBOOT__ */
+	/*
+	 * Either nand-ecc-xxx or brcm,nand-ecc-use-strap can be set. Error out
+	 * if both exist.
+	 */
+	if (chip->ecc.strength && use_strap) {
+		dev_err(ctrl->dev,
+			"ECC strap and DT ECC configuration properties are mutually exclusive\n");
+		return -EINVAL;
+	}
+
+	if (use_strap)
+		brcmnand_get_ecc_settings(host, chip);
+
 #ifndef __UBOOT__
 	ret = of_property_read_u32(nand_get_flash_node(chip),
 				   "brcm,nand-oob-sector-size",
@@ -2338,10 +2396,14 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 			      "brcm,nand-oob-sector-size",
 			      &oob_sector);
 #endif /* __UBOOT__ */
+
 	if (ret) {
-		/* Use detected size */
-		cfg->spare_area_size = mtd->oobsize /
-					(mtd->writesize >> FC_SHIFT);
+		if (use_strap)
+			cfg->spare_area_size = brcmnand_get_spare_size(host);
+		else
+			/* Use detected size */
+			cfg->spare_area_size = mtd->oobsize /
+						(mtd->writesize >> FC_SHIFT);
 	} else {
 		cfg->spare_area_size = oob_sector;
 	}

-- 
2.46.0

