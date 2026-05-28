Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5851CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 11:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1361E803C6;
	Thu, 28 May 2026 13:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD468056B; Thu, 28 May 2026 13:22:38 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937C980398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 545F068BEB; Thu, 28 May 2026 13:22:35 +0200 (CEST)
Received: from localhost (dynamic-077-178-240-039.77.178.pool.telefonica.de
 [77.178.240.39])
 by verein.lst.de (Postfix) with ESMTPSA id 28CC667328;
 Thu, 28 May 2026 13:22:11 +0200 (CEST)
Date: Thu, 28 May 2026 13:22:06 +0200
From: Torsten Duwe <duwe@lst.de>
To: u-boot@lists.denx.de
Cc: Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
Message-ID: <20260528132206.2fe9f474@lst.de>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


Devicetree commit a198185b9b5 introduced a new type of clock,
"gated-fixed-clock", for which Das U-Boot does not have
a driver yet. The required code is similar to gpio-gate-clock,
and can be added using little extra text space.

Use this code e.g. to boot a Rock5 ITX from NVMe

Signed-off-by: Torsten Duwe <duwe@lst.de>
---
Hi all,

I have a Rock 5 ITX, too, and got struck by Heiko's change ;)
Instead of Copy & Waste I merged the required changes into 
clk-gpio, which results in 121 extra code bytes and a driver
which accepts a superset of both DT bindings.

 size clk-gated-fixed.o clk-gpio*.o
   text	   data	    bss	    dec	    hex	filename
    673	    120	      0	    793	    319	clk-gated-fixed.o
    665	    120	      0	    785	    311	clk-gpio.o
    544	    120	      0	    664	    298	clk-gpio-orig.o

All I want to do here is present it as an alternative to Daniele's
approach[1] and let the maintainers decide how to proceed. This is 
a "works for me" raw cut, feel free to review if we want to go this
way.

	Torsten

[1] https://lists.denx.de/pipermail/u-boot/2026-May/619110.html
---
 configs/rock-5-itx-rk3588_defconfig |  1 +
 drivers/clk/clk-gpio.c              | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index cb014de4188..adb20c2f3a0 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -52,6 +52,7 @@ CONFIG_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_DWC_AHCI=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_GPIO=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 4ed14306575..b7abc891ed2 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -6,6 +6,7 @@
 #include <clk.h>
 #include <clk-uclass.h>
 #include <dm.h>
+#include <power/regulator.h>
 #include <linux/clk-provider.h>
 
 #include <asm/gpio.h>
@@ -13,14 +14,18 @@
 struct clk_gpio_priv {
 	struct gpio_desc	enable;	/* GPIO, controlling the gate */
 	struct clk		*clk;	/* Gated clock */
+	struct udevice		*vdd_supply;
 };
 
 static int clk_gpio_enable(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
-	clk_enable(priv->clk);
-	dm_gpio_set_value(&priv->enable, 1);
+	if (priv->clk)
+		clk_enable(priv->clk);
+
+	if (priv->enable.dev)
+		dm_gpio_set_value(&priv->enable, 1);
 
 	return 0;
 }
@@ -29,8 +34,11 @@ static int clk_gpio_disable(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
-	dm_gpio_set_value(&priv->enable, 0);
-	clk_disable(priv->clk);
+	if (priv->enable.dev)
+		dm_gpio_set_value(&priv->enable, 0);
+
+	if (priv->clk)
+		clk_disable(priv->clk);
 
 	return 0;
 }
@@ -39,7 +47,7 @@ static ulong clk_gpio_get_rate(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
-	return clk_get_rate(priv->clk);
+	return (priv->clk) ? clk_get_rate(priv->clk) : -1;
 }
 
 const struct clk_ops clk_gpio_ops = {
@@ -57,7 +65,7 @@ static int clk_gpio_probe(struct udevice *dev)
 	if (IS_ERR(priv->clk)) {
 		log_debug("%s: Could not get gated clock: %ld\n",
 			  __func__, PTR_ERR(priv->clk));
-		return PTR_ERR(priv->clk);
+		priv->clk = 0;
 	}
 
 	ret = gpio_request_by_name(dev, "enable-gpios", 0,
@@ -65,9 +73,15 @@ static int clk_gpio_probe(struct udevice *dev)
 	if (ret) {
 		log_debug("%s: Could not decode enable-gpios (%d)\n",
 			  __func__, ret);
-		return ret;
 	}
 
+	ret = device_get_supply_regulator(dev, "vdd-supply",
+					  &priv->vdd_supply);
+	if (ret == 0)
+		ret = regulator_set_enable(priv->vdd_supply, true);
+
+	log_debug("%s: %s regulator = %d\n", __func__, dev->name, ret);
+
 	return 0;
 }
 
@@ -80,6 +94,7 @@ static int clk_gpio_probe(struct udevice *dev)
  */
 static const struct udevice_id clk_gpio_match[] = {
 	{ .compatible = "gpio-gate-clock" },
+	{ .compatible = "gated-fixed-clock" },
 	{ /* sentinel */ }
 };
 
-- 
2.54.0

