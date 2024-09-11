Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9250DEDE998
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6724E891CA;
	Wed, 11 Sep 2024 09:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qu0SVrjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA94891F9; Wed, 11 Sep 2024 09:11:44 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBBC891D1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c3d2f9f896so6975531a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038701; x=1726643501; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gngvSZSXDYIJVQBbZCkdBAj365BqDHKg2e7auavSkXs=;
 b=Qu0SVrjNHt8HR6U3htEC6ICsMWffOcemdGZbD+KY7x0Te6l0QJVcX4zwDLxbmCmoLB
 38tkOdQpu9P51To++q1wjuzVENRDCeqNzdHoXOZQfC+gbz7KLqefOTdYUEHjg65QhECW
 A2KpFlKDC3qAEnu2RNPi5kRcNVlunyLibiMczGah944yzeRdXcmPBoZIEqA1W+pH/X5q
 AMI2+zr+sV+jSG4tAleZPetap5wwSHpf6n8UgvJxjs6KWSRtr3nmkZIXaIctF3Wb7333
 DAr7t80C7WDlUMBUIcO4k59hPEjz0dHUoWLxq8adKPwdrMe+E3G01H/rYRkrNp3S+ZnD
 /FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038701; x=1726643501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gngvSZSXDYIJVQBbZCkdBAj365BqDHKg2e7auavSkXs=;
 b=Ug7gRb1gczw0mw/a6cRKg3cPF4VeetQKKWbjjgOkOVGQ0SXdLTOaHL/HMcmrBGkLbS
 a5YC2OzWRTjd6CxB2iNhsfEHNq6In05n2iXiDVGvN0uWTywIj+sEIHonrzsgjFwDaWxj
 o8zGw9QqM8OVmPUam+UCCT0WMmlCviNVQw0k/y1y+rwlOQiBejUeaM8Vm2v2X7XZgQKL
 p7JcXklzWF20Ujra41dV3R3ud1dusstbFgCNAwZwSQ8FRwTTUdIXOvwvL+2tJxl4DXID
 qiMDjEpedJKtpS0mQCcfe19s5Y0Ij9XWlBLMvKcWlvQ6BxuKJF++k+2D1kaeK0tKA4TL
 MntQ==
X-Gm-Message-State: AOJu0Yyb1uVBilTRPNpS+EbV1oFrh+BK672fQ6KWq6w59A+K2TxC/hN9
 kcJY4r3vQ5xCge94abrHZPvxmaa8f79XNSgeTZpAn3rEnAy73nhfE30DF1eUaas=
X-Google-Smtp-Source: AGHT+IGqpmQ7t7VnX+wQLDBCnoGZr6tp2wOvORduFasVddoMXHu5xnceGUzNoy3++CHwqsyZy2390A==
X-Received: by 2002:a17:907:7255:b0:a86:86d7:2890 with SMTP id
 a640c23a62f3a-a8ffadee499mr298457366b.50.1726038701210; 
 Wed, 11 Sep 2024 00:11:41 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:18 +0200
Subject: [PATCH 7/7] mtd: rawnand: brcmnand: Add support for getting ecc
 setting from strap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-7-be112a20aaf1@linaro.org>
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
index 55d5d27438a8..1ffd6cfff98f 100644
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
+	ret = ofnode_read_bool(nand_get_flash_node(chip),
+			       "brcm,nand-ecc-use-strap");
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

