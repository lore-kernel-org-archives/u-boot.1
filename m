Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222BEC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F72687ECC;
	Mon, 11 Mar 2024 16:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="rgc7WRP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49ED98573F; Mon, 11 Mar 2024 16:23:10 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF8C87150
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710170587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJDIxcNBMdQ0WPHWWrVHqprCglReCqYiBoN8QysIaiM=;
 b=rgc7WRP2u48GDwr0Js7Mznz01XGqpAqiaNwyYfnRs+XRNdxpiuJzssBaR1IEczR7CMQcTz
 dRFZAtzoHKboW1vwFw8elkvliazFe1U0kVkaM8EwYPCF0+YFZMExepczRxo5QGQlwapM5a
 pnuCP5hMHgyHG77/nGTFI8r8rl2zxbEofepX4YB2tiJaANY6XbLzfCTThNqT0aBSpCLbIi
 QeV/Xq68Zm8pGvvZHepv7tL9tkR2DOLELJiJJ5MoOq+QxvVrTVnbN0iW92gA6rkT/Pui6e
 Re9+Akr0bKByipMHVanohqS9fmSZ25YZNfB5dLpn/HYyyr962MjebjTpimQ0TA==
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [RFC PATCH 3/3] mtd: nand: raw: atmel: Remove redundant PMECC probe
Date: Mon, 11 Mar 2024 16:23:06 +0100
Message-Id: <20240311152306.2358845-4-ada@thorsis.com>
In-Reply-To: <20240311152306.2358845-1-ada@thorsis.com>
References: <20240311152306.2358845-1-ada@thorsis.com>
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

Always probing pmecc in the generic nand controller probe function and
bailing out if pmecc is missing, prevents the driver to be usable for
SoCs which do not have a pmecc hardware ecc engine like older sam9 SoCs,
for example at91sam9g20.  Tested on sam9x60 that the call, which the
comment was moved to, is sufficient to probe the pmecc.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 7 -------
 drivers/mtd/nand/raw/atmel/pmecc.c           | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 0e0441472b8..b36f3a3ccac 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2203,7 +2203,6 @@ static const struct udevice_id atmel_nand_controller_of_ids[] = {
 static int atmel_nand_controller_probe(struct udevice *dev)
 {
 	const struct atmel_nand_controller_caps *caps;
-	struct udevice *pmecc_dev;
 
 	caps = (struct atmel_nand_controller_caps *)dev_get_driver_data(dev);
 	if (!caps) {
@@ -2211,12 +2210,6 @@ static int atmel_nand_controller_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	/* Probe pmecc driver */
-	if (uclass_get_device(UCLASS_MTD, 1, &pmecc_dev)) {
-		printf("%s: get device fail\n", __func__);
-		return -EINVAL;
-	}
-
 	return caps->ops->probe(dev, caps);
 }
 
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 51f6bd2e65b..e500a0fe3f8 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -913,6 +913,7 @@ struct atmel_pmecc *devm_atmel_pmecc_get(struct udevice *userdev)
 	ret = ofnode_parse_phandle_with_args(userdev->node_,
 					     "ecc-engine",
 					     NULL, 0, 0, &args);
+	/* Probe pmecc driver */
 	ret = uclass_get_device_by_ofnode(UCLASS_MTD, args.node, &pdev);
 	if (ret)
 		return NULL;
-- 
2.39.2

