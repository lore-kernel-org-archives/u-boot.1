Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1937C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 06:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17799831A1;
	Sun, 21 Jul 2024 08:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eOXhhvxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 862F883333; Sun, 21 Jul 2024 08:59:15 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8670282BA7
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D92F43F6D5; 
 Sun, 21 Jul 2024 06:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721545152;
 bh=gNW6Rxku5MgkeCn2nfopscmMsIkme2HX/2Pw923XUo8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eOXhhvxRGEqCltQq7Qty9DT2UaxrtHJpsJxpd83aeMG0QJ2+mA3PnknZjDh8neUYm
 BViJ6hqCPOcsOTSmtMjNOmRhiyX2rz2wPzkZMmBj8O+IgkGE/JYP2x9DBG87nRsbqd
 n17o+viUl9OvW54Nyc/BYAyGd7tTuU5G2ch5JK1zc0s9mcIPfm0yUA7HvO7JsHTVOG
 cT9kXjaxPlWOH4A5h23aGcMhZUEPezrHYTCiB9LZNwO9p+/ZU061Rfhflym61cXXi/
 HZBelNtff6EqWCXU9r+k1zKOastjJZMiGZOgch4/kI1Q9DrPjmmd2HUWo/HmbPu8Ng
 pAifcZ3bll3sQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Minda Chen <minda.chen@starfivetech.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] mmc: consider cd-gpios in Synopsys DesignWare driver
Date: Sun, 21 Jul 2024 08:59:07 +0200
Message-ID: <20240721065907.7518-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
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

The JH7110 SoC uses a GPIO for card detect.

* In the of_to_plat function check if a cd-gpios definition exists and
  request the GPIO.
* In the getcd function return the GPIO value in this case.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Check that DM_GPIO is enabled to avoid build failure
	on ARC platforms
---
 drivers/mmc/snps_dw_mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 9bdbe5070b1..aef05cb932f 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -12,6 +12,7 @@
 #include <dwmmc.h>
 #include <errno.h>
 #include <fdtdec.h>
+#include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/libfdt.h>
 #include <linux/err.h>
@@ -29,6 +30,7 @@ struct snps_dwmci_plat {
 struct snps_dwmci_priv_data {
 	struct dwmci_host	host;
 	u32			f_max;
+	struct gpio_desc	cd_gpio;
 };
 
 static int snps_dwmmc_clk_setup(struct udevice *dev)
@@ -106,6 +108,10 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 	if (!ret && priv->f_max < CLOCK_MIN)
 		return -EINVAL;
 
+	if (CONFIG_IS_ENABLED(DM_GPIO))
+		gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
+				     GPIOD_IS_IN);
+
 	host->fifo_mode = dev_read_bool(dev, "fifo-mode");
 	host->name = dev->name;
 	host->dev_index = 0;
@@ -119,6 +125,9 @@ int snps_dwmmc_getcd(struct udevice *dev)
 	struct snps_dwmci_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&priv->cd_gpio))
+		return dm_gpio_get_value(&priv->cd_gpio);
+
 	return !(dwmci_readl(host, DWMCI_CDETECT) & 1);
 }
 
-- 
2.45.2

