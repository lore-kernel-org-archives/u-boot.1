Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D294CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBC2832BC;
	Tue,  9 Sep 2025 14:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="EgyM85Rm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78685830B4; Tue,  9 Sep 2025 14:54:17 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BB1830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 14:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=340b2dd98=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1757422455; x=1788958455;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yy/tdbSzGY3X5GvAzF7HNlizv70GJOegz/fHxNUO4WU=;
 b=EgyM85RmLCcyM8gkdZu2ZKG0+5Q1WVMeRmuCsXiTk6nna9bq2CvaILnt
 SNt4OLqZ7pPuXmQaRSO27qFbZVZdzwUi1lXBGWIDdEyToWDCIdiRlJGSc
 vruzX1/U55ZrXKxevg26LCJDVT6qUxEFF5B+MAViYCUJj+UpjqsqmIHrR
 Y/+yqUpvKKBtM/+tpnXro9rdH8ItgqvHSIsHrU3IzB6NEDS4KsT5ZqJ6v
 QG6OrZP8Pfsp1xZXrx+lJ544Zxi7+rIuzn8K7Mi8/vXiV+T0Ct5MzVc+W
 TwxmdgsT1TmCnwDT5EhWkwWg3brdUqFBb+65qCrcGhogBkn1btx+lcLCO A==;
X-CSE-ConnectionGUID: lh5HRUMnQm+ev2peYQx0uw==
X-CSE-MsgGUID: hSF54+z8SiKLsOLjmuOSLg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="277635562"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Sep 2025 05:54:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 05:53:52 -0700
Received: from IRD-DK-FPGA01.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 05:53:50 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <Conor.Dooley@microchip.com>, <Jamie.Gibbons@microchip.com>,
 <Praveen.Kumar@microchip.com>, <Eoin.Dickson@microchip.com>,
 <Cyril.Jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH] gpio: mpfs_gpio: fix compilation warnings
Date: Tue, 9 Sep 2025 18:23:47 +0530
Message-ID: <20250909125347.2847130-1-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

mchp_gpio_get_value() should return int instead of bool, and some casts
are needed.

Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
---
 drivers/gpio/mpfs_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/mpfs_gpio.c b/drivers/gpio/mpfs_gpio.c
index 9bbeada4ef5..35eed596c10 100644
--- a/drivers/gpio/mpfs_gpio.c
+++ b/drivers/gpio/mpfs_gpio.c
@@ -75,7 +75,7 @@ static int mchp_gpio_direction_output(struct udevice *dev, u32 offset, int value
 	return 0;
 }
 
-static bool mchp_gpio_get_value(struct udevice *dev, u32 offset)
+static int mchp_gpio_get_value(struct udevice *dev, u32 offset)
 {
 	struct mchp_gpio_plat *plat = dev_get_plat(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
@@ -136,7 +136,7 @@ static int mchp_gpio_probe(struct udevice *dev)
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	char name[18], *str;
 
-	plat->regs = dev_get_driver_data(dev);
+	plat->regs = (struct mpfs_gpio_reg_offsets *)dev_get_driver_data(dev);
 	sprintf(name, "gpio@%4lx_", (uintptr_t)plat->base);
 	str = strdup(name);
 	if (!str)
@@ -160,10 +160,10 @@ static const struct mpfs_gpio_reg_offsets coregpio_reg_offsets = {
 static const struct udevice_id mchp_gpio_match[] = {
 	{
 		.compatible = "microchip,mpfs-gpio",
-		.data = &mpfs_reg_offsets,
+		.data = (unsigned long)&mpfs_reg_offsets,
 	}, {
 		.compatible = "microchip,coregpio-rtl-v3",
-		.data = &coregpio_reg_offsets,
+		.data = (unsigned long)&coregpio_reg_offsets,
 	},
 	{ /* end of list */ }
 };
-- 
2.34.1

