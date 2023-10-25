Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9926AC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 07:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01BB687A33;
	Wed, 25 Oct 2023 09:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DC287A5E; Wed, 25 Oct 2023 09:50:07 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id DEBB187A33
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 25 Oct 2023 16:50:00 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 8B1BE2059053;
 Wed, 25 Oct 2023 16:50:00 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 25 Oct 2023 16:50:00 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id 0F601B6325;
 Wed, 25 Oct 2023 16:50:00 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Stefan Roese <sr@denx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] spi: dw: Use controller clock rate as maximum frequency
Date: Wed, 25 Oct 2023 16:49:51 +0900
Message-Id: <20231025074951.3161356-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
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

Currently the controller driver has maximum frequency in plat->frequency
that is specified by "spi-max-frequency" DT property in the controller
node. This is special to U-Boot and doesn't exist to Linux.

    spi {
        spi-max-frequency = <A>;
    };

Usually the frequency should be specified by "spi-max-frequency" at the
slave device node.

    spi {
        slave {
            spi-max-frequency = <B>;
        };
    };

The final maximum frequency is set to the smaller value of the controller
node (A) and the slave device node (B).

Currently, if the property in the controller node is omitted, the default
frequency is fixed at 500kHz. Even if the controller and the slave device
allow the higher frequency than 500kHz, the maximum frequency can't exceed
500kHz.

The upper limit of the maximum frequency should be determined by the clock
rate of the controller clock. And this patch determines the maximum
frequency based on the clock rate if the controller node property isn't
specified.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/designware_spi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 1c7d0ca310b6..637ea57eba24 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -250,15 +250,13 @@ static int dw_spi_of_to_plat(struct udevice *bus)
 	if (!plat->regs)
 		return -EINVAL;
 
-	/* Use 500KHz as a suitable default */
+	/* Specify fixed max-frequency as default */
 	plat->frequency = dev_read_u32_default(bus, "spi-max-frequency",
-					       500000);
+					       0);
 
 	if (dev_read_bool(bus, "spi-slave"))
 		return -EINVAL;
 
-	dev_info(bus, "max-frequency=%d\n", plat->frequency);
-
 	return request_gpio_cs(bus);
 }
 
@@ -362,12 +360,17 @@ static int dw_spi_probe(struct udevice *bus)
 	u32 version;
 
 	priv->regs = plat->regs;
-	priv->freq = plat->frequency;
 
 	ret = dw_spi_get_clk(bus, &priv->bus_clk_rate);
 	if (ret)
 		return ret;
 
+	if (!plat->frequency)
+		plat->frequency = priv->bus_clk_rate;
+
+	dev_info(bus, "max-frequency=%d\n", plat->frequency);
+	priv->freq = plat->frequency;
+
 	ret = dw_spi_reset(bus);
 	if (ret)
 		return ret;
-- 
2.25.1

