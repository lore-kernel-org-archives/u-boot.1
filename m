Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE56C3601E
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 13:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F75A88E56;
	Tue, 17 Sep 2024 15:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsvHB/5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A93888BEF; Tue, 17 Sep 2024 15:56:03 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEAC879C1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 15:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso5109143b3a.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726581359; x=1727186159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/dRkwbUGcWeupcI9oDXNMJ1ooJvn3g9S6dgJo+eO4Q0=;
 b=EsvHB/5qtpod7dXcVmgmQQ0HI4Gf0/VW6g/YC2H7oIzp5xSmW/EB6DK1A3q+Oyco7R
 Df8nh9aLVYKb3l+0pP25zGOWO18bWGwym3GXLulO0svJvB3Nc1PHemetA737P+oUL3T4
 DCI80Q1TWoD/QqefktYG/pHJZfi1XvXdw4empmw/6nspIecLWQjcFS8X1VY8AB/WIqFV
 /aQAsi5cmLCywlrtqFcTgau/DInWRMifSN+hwpOxI3udXSJlHWFkizadM1CvU+H+nTCV
 VXsxjD5jfXX8wnybnjy+/O/I7x4JgH7peFbneoXwbP9sB9/hM2V/v9GVMyX45oVZopJK
 +BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726581359; x=1727186159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/dRkwbUGcWeupcI9oDXNMJ1ooJvn3g9S6dgJo+eO4Q0=;
 b=bHttYMWVFBtJ+5lkV91HLb9a1yXUuLrhayJ8T9NwGCdgg9DEIvMSHJSt75QLf4SELx
 EvCHX8RRepXbbAq3MjoSsqyWilTAUeQ03ZTjqYtViTCah93G9Ez+hcvJ2dHiAHFjUzD8
 8mfvwmjUNqMD8XxCXY1PU5sUNJi5PE+HbKRuRPcMHGs40GXBD4zGNZcHyALjKRZH3vs2
 /JoeRWZ2BhdaiXEiTiyPzva8+ATVEWulb2zyhkdZGTgp8A7FznqpaYxrwIejxr525OBj
 WBNSDINuP5K5+HGXknCa9VSKHvVl7DgxX0SJMH7dPNUJlNSbDSl0z+U3oGaoXPFWlnw0
 c30A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzgWRAJQsI6/n4463bkANBoI5H3KjMETru2uEKXTK+Bf7PEPzhSrakqxoiC6uJSWUjrm40cgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxF156FeBHaAbezseczlrdtWCNCdM8no66eb/xmeWkf1QZMHNwf
 Q1ZTciju8hmGD6gpPdBxITW1bUws1vHn2UJCk4mJtT+h4QSCbmkA
X-Google-Smtp-Source: AGHT+IEH9bKn6LVzbt3T+knbxjIsjpfg1y9v5a4IuxX1ulIo1VL1Sjq+NEHPUzS81r11jw5y/tl/8w==
X-Received: by 2002:a05:6a00:1ac6:b0:714:2198:26bd with SMTP id
 d2e1a72fcca58-71926081831mr30598195b3a.11.1726581359004; 
 Tue, 17 Sep 2024 06:55:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:18f6:4e29:3360:ce8d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db4999fd82sm4975653a12.90.2024.09.17.06.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 06:55:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sr@denx.de
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] da9063: Add watchdog support
Date: Tue, 17 Sep 2024 10:55:50 -0300
Message-Id: <20240917135550.3164425-1-festevam@gmail.com>
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
Changes since v2:
- Use u8 instead of char. (Stefan)
- Keep the Copyright header from Linux. (Stfan)

 drivers/power/pmic/da9063.c   |  12 ++-
 drivers/watchdog/Kconfig      |   6 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/da9063-wdt.c | 149 ++++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 drivers/watchdog/da9063-wdt.c

diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
index 7bd3df391421..59c65702863c 100644
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
index 0c3e99133186..90bc5653ee33 100644
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
index 7b39adcf0ff4..6b564b7f96d2 100644
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
index 000000000000..b7216b578630
--- /dev/null
+++ b/drivers/watchdog/da9063-wdt.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on the Linux drivers/watchdog/da9063_wdt.c file.
+ *
+ * Watchdog driver for DA9063 PMICs.
+ *
+ * Copyright(c) 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
+ *
+ * Ported to U-Boot by Fabio Estevam <festevam@denx.de>
+ *
+ */
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
+	u8 val;
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
+	int ret;
+	u8 val;
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
+	u8 val = DA9063_WATCHDOG;
+
+	return da9063_write(dev, DA9063_REG_CONTROL_F, &val, 1);
+}
+
+static int da9063_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	u8 val = DA9063_SHUTDOWN;
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

