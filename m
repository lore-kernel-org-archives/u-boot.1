Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DF5C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCA88396C;
	Thu, 31 Jul 2025 23:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="uehwH4AD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAD48394A; Thu, 31 Jul 2025 21:37:21 +0200 (CEST)
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org
 [IPv6:2001:67c:2050:103:465::111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9928393F
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4btK9B645Hz9y9f;
 Thu, 31 Jul 2025 21:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdd5DYEOV5K8/1GpcwSKMwCAoQ9c+cdt4Lnz19nHoCI=;
 b=uehwH4ADE4v5IvzjU/WlwJKEJ+EWqnk3H4ITdMs9IoDTmstcNehnwd2EHlKo8cM300csJb
 FLksvPL7jqeBM5uk+/pdzXLJjZC8zaYIQL7CCdLU8VMILfQQ+AM04ya5Om2sLRd+64rFr4
 3RdeHrWUsjC8TUdbemkIU7BbUBYYzmxGJOSnLg5v2+Is0udoDSp7aKEDrwF6xknAVxpvc/
 poAtRdVG1uvP9MMQ92y/9goQdwMpv5YPoYd8iu7TE/+pW9M0yzWdTAKsyNy9xMupvnDLDU
 HzRalgwMDJNPLRYFn8El/lXUtKfjX144Wkx6/joyp/m+15XkD2pzZohqFXCkag==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] video: bridge: add Samsung CMC623 image converter
 driver
Date: Thu, 31 Jul 2025 21:36:55 +0200
Message-ID: <20250731193656.286806-5-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
References: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btK9B645Hz9y9f
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

Add support for a Samsung CMC623 image converter chip found in several
Samsung devices such as Samsung Galaxy R (I9103) and Samsung Galaxy
Tab 10.1 (GT-P75xx).

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 drivers/video/bridge/Kconfig  |   8 ++
 drivers/video/bridge/Makefile |   1 +
 drivers/video/bridge/cmc623.c | 234 ++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/video/bridge/cmc623.c

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index be53034bd3d..a48cec7a138 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -66,3 +66,11 @@ config VIDEO_BRIDGE_LVDS_CODEC
 	help
 	  Support for transparent LVDS encoders and decoders that don't
 	  require any configuration.
+
+config VIDEO_BRIDGE_SAMSUNG_CMC623
+	bool "Samsung CMC623 Image Converter driver"
+	depends on VIDEO_BRIDGE && DM_GPIO
+	select DM_I2C
+	help
+	  Samsung CMC623 image converter chip driver.
+	  Found in several Samsung devices such as N1
diff --git a/drivers/video/bridge/Makefile b/drivers/video/bridge/Makefile
index 63dc6e62c49..520f36a7a6f 100644
--- a/drivers/video/bridge/Makefile
+++ b/drivers/video/bridge/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_VIDEO_BRIDGE_ANALOGIX_ANX6345) += anx6345.o
 obj-$(CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768) += tc358768.o
 obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += lvds-codec.o
+obj-$(CONFIG_VIDEO_BRIDGE_SAMSUNG_CMC623) += cmc623.o
diff --git a/drivers/video/bridge/cmc623.c b/drivers/video/bridge/cmc623.c
new file mode 100644
index 00000000000..78dafef8145
--- /dev/null
+++ b/drivers/video/bridge/cmc623.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Ion Agorria <ion@agorria.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/ofnode_graph.h>
+#include <i2c.h>
+#include <log.h>
+#include <backlight.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <power/regulator.h>
+#include <asm/gpio.h>
+
+static const char * const cmc623_supplies[] = {
+	"vdd3v0-supply", "vdd1v2-supply", "vddio1v8-supply"
+};
+
+struct cmc623_priv {
+	struct udevice *panel;
+	struct display_timing timing;
+
+	struct udevice *supplies[ARRAY_SIZE(cmc623_supplies)];
+
+	struct gpio_desc enable_gpio; /* also known as FAILSAFE */
+	struct gpio_desc bypass_gpio;
+};
+
+static int cmc623_attach(struct udevice *dev)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* Perform panel setup */
+	ret = panel_enable_backlight(priv->panel);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cmc623_set_backlight(struct udevice *dev, int percent)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+
+	return panel_set_backlight(priv->panel, percent);
+}
+
+static int cmc623_panel_timings(struct udevice *dev, struct display_timing *timing)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->timing, sizeof(*timing));
+
+	return 0;
+}
+
+static int cmc623_hw_init(struct udevice *dev)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
+	int i, ret;
+
+	/* enable supplies */
+	for (i = 0; i < ARRAY_SIZE(cmc623_supplies); i++) {
+		ret = regulator_set_enable_if_allowed(priv->supplies[i], 1);
+		if (ret) {
+			log_debug("%s: cannot enable %s %d\n", __func__,
+				  cmc623_supplies[i], ret);
+			return ret;
+		}
+	}
+
+	mdelay(10);
+
+	ret = dm_gpio_set_value(&uc_priv->reset, 1);
+	if (ret) {
+		log_debug("%s: error at reset = 1 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&priv->enable_gpio, 0);
+	if (ret) {
+		log_debug("%s: error at enable = 0 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&priv->bypass_gpio, 0);
+	if (ret) {
+		log_debug("%s: error at bypass = 0 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&uc_priv->sleep, 0);
+	if (ret) {
+		log_debug("%s: error at sleep = 0 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	udelay(2000);
+
+	ret = dm_gpio_set_value(&priv->enable_gpio, 1);
+	if (ret) {
+		log_debug("%s: error at enable = 1 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	udelay(2000);
+
+	ret = dm_gpio_set_value(&priv->bypass_gpio, 1);
+	if (ret) {
+		log_debug("%s: error at bypass = 1 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	udelay(2000);
+
+	ret = dm_gpio_set_value(&uc_priv->sleep, 1);
+	if (ret) {
+		log_debug("%s: error at sleep = 1 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	udelay(2000);
+
+	ret = dm_gpio_set_value(&uc_priv->reset, 0);
+	if (ret) {
+		log_debug("%s: error at sleep = 0 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(10);
+
+	ret = dm_gpio_set_value(&uc_priv->reset, 1);
+	if (ret) {
+		log_debug("%s: error at sleep = 1 (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(10);
+
+	return 0;
+}
+
+static int cmc623_get_panel(struct udevice *dev)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	u32 num = ofnode_graph_get_port_count(dev_ofnode(dev));
+
+	for (i = 0; i < num; i++) {
+		ofnode remote = ofnode_graph_get_remote_node(dev_ofnode(dev), i, -1);
+
+		ret = uclass_get_device_by_ofnode(UCLASS_PANEL, remote, &priv->panel);
+		if (!ret)
+			return 0;
+	}
+
+	/* If this point is reached, no panels were found */
+	return -ENODEV;
+}
+
+static int cmc623_probe(struct udevice *dev)
+{
+	struct cmc623_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	/* get supplies */
+	for (i = 0; i < ARRAY_SIZE(cmc623_supplies); i++) {
+		ret = device_get_supply_regulator(dev, cmc623_supplies[i], &priv->supplies[i]);
+		if (ret) {
+			log_debug("%s: cannot get %s %d\n", __func__, cmc623_supplies[i], ret);
+			if (ret != -ENOENT)
+				return log_ret(ret);
+		}
+	}
+
+	/* get control gpios */
+	ret = gpio_request_by_name(dev, "enable-gpios", 0, &priv->enable_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not get enable-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "bypass-gpios", 0, &priv->bypass_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not get bypass-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = cmc623_hw_init(dev);
+	if (ret) {
+		log_debug("%s: error doing hw init, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = cmc623_get_panel(dev);
+	if (ret) {
+		log_debug("%s: panel not found, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	panel_get_display_timing(priv->panel, &priv->timing);
+
+	return 0;
+}
+
+static const struct video_bridge_ops cmc623_ops = {
+	.attach			= cmc623_attach,
+	.set_backlight		= cmc623_set_backlight,
+	.get_display_timing	= cmc623_panel_timings,
+};
+
+static const struct udevice_id cmc623_ids[] = {
+	{ .compatible = "samsung,cmc623" },
+	{ }
+};
+
+U_BOOT_DRIVER(samsung_cmc623) = {
+	.name		= "samsung_cmc623",
+	.id		= UCLASS_VIDEO_BRIDGE,
+	.of_match	= cmc623_ids,
+	.ops		= &cmc623_ops,
+	.bind		= dm_scan_fdt_dev,
+	.probe		= cmc623_probe,
+	.priv_auto	= sizeof(struct cmc623_priv),
+};
-- 
2.50.0

