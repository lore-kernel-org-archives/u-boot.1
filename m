Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087DC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 13:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7622488E6F;
	Tue, 17 Sep 2024 15:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYuNbAIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612C288E64; Tue, 17 Sep 2024 15:41:41 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3BD88D45
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e03d17365bso3121971b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726580498; x=1727185298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Y5VFqgiqt7n86HTupL9lLFwqcP/3u2+duxmVG7OrBc=;
 b=DYuNbAIhFxEZ7ZTXK7/kpmiWy0BACqUKmA/llnG/JhkxUusQifATOagFZoWkGXas7r
 hjaY8QQQHPotUXf8fGAMG44N+BnLBa0n8w/V9g15YHGkAFv6CJ0wSsVKwB3wGqU7elbp
 0p9jmqVlcDHTci8wUweuf9+8b4FSBQfhZ4MLVaVJqnfmcat3LE/MuK2GNm56wcxMsJ+m
 U9lkqxCu4tarWgZa4HpN8f23MfDnhpmApml+EgImCEmFr4eb0ZZhf68gd3Szy949fX0d
 dyBdl+ZoGniJFPQ3GyLAqtJgjZhnnk4j7MuLoT1NGQntFR+EDSc6tqapDrHAjFSUXXzH
 8wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726580498; x=1727185298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Y5VFqgiqt7n86HTupL9lLFwqcP/3u2+duxmVG7OrBc=;
 b=HdZ8flF67U2AsdjRk6Ez/MJUgddYpXtF0nXcOwnoSs6O/DQddFXJ09jo1ffh6qmKgs
 0ci7XaDUyWz4vWL8/HSkAgkoYSB+WPoifQrHt1X6WoTPZJ0/Dsmu22eylNlNkwAwKDuk
 WaiZtwl6JHoUZBgqIjME6siY5FIbg/UUw7oHqmC6YTUOErHN9+ds3jZBri/tPtvOOh5c
 tP0/2oqJdFpcJ+G2pRgLkcxyTl60cs3brO6wEvnY3CkOeWxY18xa4ui/rJv7mxY86tyc
 RB1ZSJ/K3eP33lYmpTPHSi8zmNAllj3qZzFe9hqdvBnbFPinvvmc+jq7biCFj3quqgif
 GO+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5HxoE6hKn2uztW2sfc3LeqMNSNih8HBg38pq19eqljJfuu0qxdl22AU1j4fnwNex9sYp5jz4=@lists.denx.de
X-Gm-Message-State: AOJu0YwerSdZCquDFn5MKGwSPFdBoAfAHSt4glGKGH5Z+IiDVGPqrJwH
 809A/rHBWlPmxNqMoRx2ei7JeggxvTpgu8L5imCw6XB26pvFPekLXAdM7Q==
X-Google-Smtp-Source: AGHT+IGKdGVzUYZDUdjAOrk22056sif2MG2QTkxbZiAdHxcbceMm/rku/4SKd9+7gHMArJvOQPurbQ==
X-Received: by 2002:a05:6808:4493:b0:3e0:5c8b:59be with SMTP id
 5614622812f47-3e071acb0e3mr12974435b6e.24.1726580497640; 
 Tue, 17 Sep 2024 06:41:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:18f6:4e29:3360:ce8d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db498e05dbsm5809087a12.19.2024.09.17.06.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 06:41:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sr@denx.de
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] da9063: Add watchdog support
Date: Tue, 17 Sep 2024 10:41:27 -0300
Message-Id: <20240917134127.3152578-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The DA9063 PMIC is a multi-function device that provides
regulator, watchdog, RTC, and ON key functionalities.

Add support for the DA9063 PMIC watchdog functionality.

Based on the 6.11 kernel drivers/watchdog/da9063_wdt.c driver.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Fixed a typo in commit log: RTC -> watchdog.

 drivers/power/pmic/da9063.c   |  12 ++-
 drivers/watchdog/Kconfig      |   6 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/da9063-wdt.c | 142 ++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 drivers/watchdog/da9063-wdt.c

diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
index 7bd3df39142..59c65702863 100644
--- a/drivers/power/pmic/da9063.c
+++ b/drivers/power/pmic/da9063.c
@@ -7,6 +7,9 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <i2c.h>
 #include <log.h>
 #include <linux/printk.h>
@@ -86,6 +89,7 @@ static int da9063_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int da9063_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
+	struct driver *drv;
 	int children;
 
 	regulators_node = dev_read_subnode(dev, "regulators");
@@ -101,8 +105,12 @@ static int da9063_bind(struct udevice *dev)
 	if (!children)
 		debug("%s: %s - no child found\n", __func__, dev->name);
 
-	/* Always return success for this device */
-	return 0;
+	drv = lists_driver_lookup_name("da9063-wdt");
+	if (!drv)
+		return 0;
+
+	return device_bind_with_driver_data(dev, drv, "da9063-wdt", dev->driver_data,
+					    dev_ofnode(dev), &dev);
 }
 
 static int da9063_probe(struct udevice *dev)
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0c3e9913318..90bc5653ee3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -169,6 +169,12 @@ config WDT_CORTINA
 	  This driver support all CPU ISAs supported by Cortina
 	  Access CAxxxx SoCs.
 
+config WDT_DA9063
+	bool "DA9063 watchdog timer support"
+	depends on WDT && DM_PMIC_DA9063
+	help
+	  Enable support for the watchdog timer in Dialog DA9063.
+
 config WDT_GPIO
 	bool "External gpio watchdog support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf0ff..6b564b7f96d 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
 obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
 obj-$(CONFIG_WDT_ORION) += orion_wdt.o
 obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
+obj-$(CONFIG_WDT_DA9063) += da9063-wdt.o
 obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
 obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
new file mode 100644
index 00000000000..c9210a106d3
--- /dev/null
+++ b/drivers/watchdog/da9063-wdt.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// DA9063 watchdog driver
+//
+// Copyright (c) 2024 Fabio Estevam <festevam@denx.de>
+//
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <wdt.h>
+
+#define	DA9063_REG_CONTROL_D		0x11
+/* DA9063_REG_CONTROL_D (addr=0x11) */
+#define	DA9063_TWDSCALE_MASK		0x0
+#define DA9063_TWDSCALE_DISABLE		0
+#define	DA9063_REG_CONTROL_F		0x13
+/* DA9063_REG_CONTROL_F (addr=0x13) */
+#define	DA9063_WATCHDOG			0x01
+#define	DA9063_SHUTDOWN			0x02
+
+/*
+ * Watchdog selector to timeout in seconds.
+ *   0: WDT disabled;
+ *   others: timeout = 2048 ms * 2^(TWDSCALE-1).
+ */
+static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
+
+#define DA9063_TWDSCALE_DISABLE		0
+#define DA9063_TWDSCALE_MIN		1
+#define DA9063_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
+
+static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
+{
+	unsigned int i;
+
+	for (i = DA9063_TWDSCALE_MIN; i <= DA9063_TWDSCALE_MAX; i++) {
+		if (wdt_timeout[i] >= secs)
+			return i;
+	}
+
+	return DA9063_TWDSCALE_MAX;
+}
+
+static int da9063_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
+{
+	return dm_i2c_read(dev->parent, reg, buff, len);
+}
+
+static int da9063_write(struct udevice *dev, uint reg, const u8 *buff, int len)
+{
+	return dm_i2c_write(dev->parent, reg, buff, len);
+}
+
+static int da9063_wdt_disable_timer(struct udevice *dev)
+{
+	char val;
+
+	da9063_read(dev, DA9063_REG_CONTROL_D, &val, 1);
+	val &= ~DA9063_TWDSCALE_MASK;
+	val |= DA9063_TWDSCALE_DISABLE;
+	da9063_write(dev, DA9063_REG_CONTROL_D, &val, 1);
+
+	return 0;
+}
+
+static int da9063_wdt_update_timeout(struct udevice *dev, unsigned int timeout)
+{
+	unsigned int regval;
+	char val;
+	int ret;
+
+	/*
+	 * The watchdog triggers a reboot if a timeout value is already
+	 * programmed because the timeout value combines two functions
+	 * in one: indicating the counter limit and starting the watchdog.
+	 * The watchdog must be disabled to be able to change the timeout
+	 * value if the watchdog is already running. Then we can set the
+	 * new timeout value which enables the watchdog again.
+	 */
+	ret = da9063_wdt_disable_timer(dev);
+	if (ret)
+		return ret;
+
+	udelay(300);
+
+	regval = da9063_wdt_timeout_to_sel(timeout);
+
+	da9063_read(dev, DA9063_REG_CONTROL_D, &val, 1);
+	val &= ~DA9063_TWDSCALE_MASK;
+	val |= regval;
+	da9063_write(dev, DA9063_REG_CONTROL_D, &val, 1);
+
+	return 0;
+}
+
+static int da9063_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	return da9063_wdt_update_timeout(dev, timeout);
+}
+
+static int da9063_wdt_stop(struct udevice *dev)
+{
+	return da9063_wdt_disable_timer(dev);
+}
+
+static int da9063_wdt_reset(struct udevice *dev)
+{
+	char val = DA9063_WATCHDOG;
+
+	return da9063_write(dev, DA9063_REG_CONTROL_F, &val, 1);
+}
+
+static int da9063_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	char val = DA9063_SHUTDOWN;
+
+	return da9063_write(dev, DA9063_REG_CONTROL_F, &val, 1);
+}
+
+static const struct wdt_ops da9063_wdt_ops = {
+	.start = da9063_wdt_start,
+	.stop = da9063_wdt_stop,
+	.reset = da9063_wdt_reset,
+	.expire_now = da9063_wdt_expire_now,
+};
+
+static const struct udevice_id da9063_wdt_ids[] = {
+	{ .compatible = "dlg,da9063-watchdog", },
+	{}
+};
+
+U_BOOT_DRIVER(da9063_wdt) = {
+	.name = "da9063-wdt",
+	.id = UCLASS_WDT,
+	.of_match = da9063_wdt_ids,
+	.ops = &da9063_wdt_ops,
+	.flags = DM_FLAG_PROBE_AFTER_BIND,
+};
-- 
2.34.1

