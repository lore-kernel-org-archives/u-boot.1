Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9318CC3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 14:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864F588A34;
	Mon, 16 Sep 2024 16:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdNY9Wad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F96B88AE8; Mon, 16 Sep 2024 16:02:35 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CA188A34
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 16:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-206f9b872b2so40308055ad.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726495351; x=1727100151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UYveoKTdz1KtUiQI3yBbyvAfylWrzGk+WlpxpAbuRrE=;
 b=OdNY9Wadsl/q4HzU+Kpv8nCUy706RK+MjivmlmDRNCa21SXV42vMFCsRJHaF7w2ogD
 FZ8lZdnV8QFUe6qQMmPHX5gWTTb5YxUKmGRm42hiM+IHd2TTntvYdNIGmhZg9OySTt9j
 qsNb1/oxUbMnDD1XeDBSAjHMD9oDLmN38sD+xhfW1V/B2I0PwLPG8K5isEH0X7kqc/G8
 3PMoWmGlogLY6pv8yixpdvH9HHAUpp+lJ4RnqEYHGfp3dvr5gjWRHO0Cdz5xjlKqWzY4
 3cU2+qyaYZOaSXTiybw+gggzZ3bTy31PHvnfSh8pb/MeAFPj0JTM0o8SJ8ymdkstoLQK
 Il0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726495351; x=1727100151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYveoKTdz1KtUiQI3yBbyvAfylWrzGk+WlpxpAbuRrE=;
 b=J8gxSGH56hsbLHbbLnP8Axe9Z7bsIslJeYxSVH+fZxNnYtomylJWNgKOsngGH5QBcO
 F3NDJfRSZMuTR2U0JBdTxcKTJjQKpJysnfDNFDM/M9lB0lNTp2H+tsG8OUcMkJCNjs6a
 NuezGURAuJ8pH7bq4//7FMfxZBQ1W1n1AsaNLmDn1NVR9G+kuI4A83kY7z1Ycn+cRvHc
 LrVEG2EsENgmkPDC9+QhakoNLUr2pJX5euVwyuxQxdYN0uiAqSueZpTjmPd9fVKkJYHm
 bm1yz5/jEug7o225lrbx3fNDA9N6TAfdTSROh//Bbd4NheJ5LC4j/xJZVGgqxeShsRhV
 0vtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOnaflKI7y7XsWzi/mpt1XDaGxWT79v33qi9eiycinUffO0TCcx/RTvDVkgRjdr3sMSU9P2zs=@lists.denx.de
X-Gm-Message-State: AOJu0YzpnQgzHPVlKb5Do1BtjwnXd93vlkbr0ByDBSKgO7Bdekgarxgy
 arIuwbpyoXQYCkLnTo/FPFYgm0u5R4Z/Ayz2IWrItMrlaHaYcuP1
X-Google-Smtp-Source: AGHT+IEqN96iD9J/K+daEn5+kmb16qXp4C22vJM8FXmDyVboTzuZ5Q62LVmYdXFbCGU9wWfHGlI0KA==
X-Received: by 2002:a17:902:d2cf:b0:202:4a35:a803 with SMTP id
 d9443c01a7336-2076e3f1f14mr225846255ad.31.1726495351030; 
 Mon, 16 Sep 2024 07:02:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fe76:c192:884b:c40f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079460574esm36201015ad.109.2024.09.16.07.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 07:02:30 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sr@denx.de
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] da9063: Add watchdog support
Date: Mon, 16 Sep 2024 11:02:25 -0300
Message-Id: <20240916140225.2780402-1-festevam@gmail.com>
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

Add support for the DA9063 PMIC RTC functionality.

Based on the 6.11 kernel drivers/watchdog/da9063_wdt.c driver.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
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

