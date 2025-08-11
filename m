Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35A4C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4D083394;
	Mon, 11 Aug 2025 15:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="VZdWrhAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B6083335; Mon, 11 Aug 2025 15:12:36 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47B3832DD
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C548C975B; Mon, 11 Aug 2025 15:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917954; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=pLqZoUxu1al+9I3qJtbVAqo5w1/SQvOAmNJtBfARXEg=;
 b=VZdWrhAYflR3fFOmC4A0WBRpm+sxDOWEfurAg0hSKxth3jev9W85cjbD+2GAwxbu2YVxrH
 N3X/Y8AemmpC8/hwXghQEgUCQCNkt3Cj8Z5MXNBo+/JXzeMGKNXXoaDeC3H5ebBMLG+Lw7
 I7rFfXo4U2Wzij28HxFi79wvPbo8vljSNBBmGK8J20H9tD3nC17lgbc+LeKdGxPRtjUOsl
 RZnDISwsi20gJJndjwgSxROyxOV4vXiMxMjCp8OLBdh0+a8up40DgkXCan+ZOus+COgV6w
 3eeWK08cWFdDd52yaLH83x+tCx3892amrU4VKKvcP8F9LFz7whY+ktuc1LfwDg==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 1/6] Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
Date: Mon, 11 Aug 2025 15:11:57 +0200
Message-ID: <20250811131213.211124-2-frieder@fris.de>
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

This reverts commit 2add0511757e2c5897a88b57c5ea8c912140e60f.

It turns out that all boards using the PCA9450 actually have the
SD_VSEL input connected to the VSELECT signal of the SoCs SD/MMC
interface. Therefore we don't need manual control for this signal
via GPIO and there aren't any users.

This is equivalent to the following change in Linux:

c73be62caabb ("Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"")

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/power/pmic/pca9450.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index 9d875f8bdbe..0e3d14abf15 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -6,12 +6,9 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
-#include <dm/device_compat.h>
 #include <i2c.h>
-#include <linux/err.h>
 #include <log.h>
 #include <asm/global_data.h>
-#include <asm-generic/gpio.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
@@ -29,10 +26,6 @@ static const struct pmic_child_info pmic_children_info[] = {
 	{ },
 };
 
-struct pca9450_priv {
-	struct gpio_desc *sd_vsel_gpio;
-};
-
 static int pca9450_reg_count(struct udevice *dev)
 {
 	return PCA9450_REG_NUM;
@@ -85,21 +78,7 @@ static int pca9450_bind(struct udevice *dev)
 
 static int pca9450_probe(struct udevice *dev)
 {
-	struct pca9450_priv *priv = dev_get_priv(dev);
 	unsigned int reset_ctrl;
-	int ret = 0;
-
-	if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(DM_REGULATOR_PCA9450)) {
-		priv->sd_vsel_gpio = devm_gpiod_get_optional(dev, "sd-vsel",
-							     GPIOD_IS_OUT |
-							     GPIOD_IS_OUT_ACTIVE);
-		if (IS_ERR(priv->sd_vsel_gpio)) {
-			ret = PTR_ERR(priv->sd_vsel_gpio);
-			dev_err(dev, "Failed to request SD_VSEL GPIO: %d\n", ret);
-			if (ret)
-				return ret;
-		}
-	}
 
 	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
 		reset_ctrl = PCA9450_PMIC_RESET_WDOG_B_CFG_WARM;
@@ -132,5 +111,4 @@ U_BOOT_DRIVER(pmic_pca9450) = {
 	.bind = pca9450_bind,
 	.probe = pca9450_probe,
 	.ops = &pca9450_ops,
-	.priv_auto = sizeof(struct pca9450_priv),
 };
-- 
2.50.1

