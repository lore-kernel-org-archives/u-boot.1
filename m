Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405DBC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3056D8341A;
	Mon, 11 Aug 2025 15:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="MqtnfQc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BA88331B; Mon, 11 Aug 2025 15:12:38 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE6A83020
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 187ADC975E; Mon, 11 Aug 2025 15:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917956; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=4zvK2HhRzlde2pcsMz6w7utxqb+SK8pW7QU7qsnNMe0=;
 b=MqtnfQc2Zcc02UZOic/+U4Q4/W7wkeG4YcPfglY34/qHs0k8hW2LlSgdP1TdwI/oDJH6AW
 oBNwv0NaG9/1hJFHssfXVcyq/3GPHKPbWOw2thKm+ygh1WDf5n1aTY5L/RRr+6DLqJ7QaT
 szOxhl/8M5EdhiDkawjwdZZcRcjsnfWNOHvR9n6uzULxVqoiq9KQgBs4UAmpgWJpokHMDD
 oh/YAvZAo4/nEKpkRxqDLNyxYfM008lHWX1/3XiiG024scdoc8GAVSaM9xuyaqyS7ogAYL
 t4SZicbyUe7J+nItG4segiwpmz2YRO7GsI935te88fo6cPjdJZ4JLPVxwMJWAg==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 3/6] pmic: pca9450: Fix control register for LDO5
Date: Mon, 11 Aug 2025 15:11:59 +0200
Message-ID: <20250811131213.211124-4-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
References: <20250811131213.211124-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

For LDO5 we need to be able to check the status of the SD_VSEL input in
order to know which control register is used. Read the status of the
SD_VSEL signal via GPIO and use the correct register accordingly.

To use this, the LDO5 node in the devicetree needs the sd-vsel-gpios
property to reference the GPIO that is used to read back the SD_VSEL
status internally. Please note that the SION bit in the IOMUX must be
set if the signal is muxed as VSELECT and controlled by the USDHC
controller.

This is equivalent to the following change in Linux:

3ce6f4f943dd ("regulator: pca9450: Fix control register for LDO5")

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/power/regulator/pca9450.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 27db55e688d..9d8d142b464 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -7,9 +7,12 @@
  * ROHM BD71837 regulator driver
  */
 
+#include <asm-generic/gpio.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <log.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <power/pca9450.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
@@ -52,6 +55,7 @@ struct pca9450_plat {
 	u8			volt_mask;
 	struct pca9450_vrange	*ranges;
 	unsigned int		numranges;
+	struct gpio_desc	*sd_vsel_gpio;
 };
 
 #define PCA_RANGE(_min, _vstep, _sel_low, _sel_hi) \
@@ -222,13 +226,23 @@ static int pca9450_set_enable(struct udevice *dev, bool enable)
 			       val);
 }
 
+static u8 pca9450_get_vsel_reg(struct pca9450_plat *plat)
+{
+	if (!strcmp(plat->name, "LDO5") &&
+	    (plat->sd_vsel_gpio && !dm_gpio_get_value(plat->sd_vsel_gpio)) {
+		return PCA9450_LDO5CTRL_L;
+	}
+
+	return plat->volt_reg;
+}
+
 static int pca9450_get_value(struct udevice *dev)
 {
 	struct pca9450_plat *plat = dev_get_plat(dev);
 	unsigned int reg, tmp;
 	int i, ret;
 
-	ret = pmic_reg_read(dev->parent, plat->volt_reg);
+	ret = pmic_reg_read(dev->parent, pca9450_get_vsel_reg(plat));
 	if (ret < 0)
 		return ret;
 
@@ -274,7 +288,7 @@ static int pca9450_set_value(struct udevice *dev, int uvolt)
 	if (!found)
 		return -EINVAL;
 
-	return pmic_clrsetbits(dev->parent, plat->volt_reg,
+	return pmic_clrsetbits(dev->parent, pca9450_get_vsel_reg(plat),
 			       plat->volt_mask, sel);
 }
 
@@ -335,6 +349,19 @@ static int pca9450_regulator_probe(struct udevice *dev)
 
 		*plat = pca9450_reg_data[i];
 
+		if (!strcmp(plat->name, "LDO5")) {
+			if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(DM_REGULATOR_PCA9450)) {
+				plat->sd_vsel_gpio = devm_gpiod_get_optional(dev, "sd-vsel",
+									     GPIOD_IS_IN);
+				if (IS_ERR(plat->sd_vsel_gpio)) {
+					ret = PTR_ERR(plat->sd_vsel_gpio);
+					dev_err(dev, "Failed to request SD_VSEL GPIO: %d\n", ret);
+					if (ret)
+						return ret;
+				}
+			}
+		}
+
 		return 0;
 	}
 
-- 
2.50.1

