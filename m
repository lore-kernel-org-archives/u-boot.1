Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF50BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4C7874C4;
	Tue, 31 Oct 2023 08:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738096;
	bh=x1nH8MYZaahmFNf6xOkinK1vT/iM+ChtUCQotdXH6KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIK6dOcE5VV5f2j1m2XCgRXiEXmg8uaEMnuFb+6rUKWt0lceDhXICasZwbO6DdGhe
	 t4E5sZ+Hk20tOc1S0W+cLIUj8Hzep7nD31xw2cCHEpdR13RulAWU+pBuXa9kw1g0nc
	 Mx/K+z9XdE+XWKgl5Zk1gOKPWteVuocD2VHSBF+HE6sx2EsIZI/UXM3JNVjcZVtGmy
	 k1+Vw5w6RR5g1jpkESBI90he/ASgV1Fg7pW8J5TALMjOLtVQCHor8OC2Agf3TQ9WpA
	 1CVxigxAVVUCd4FCHd6rpllXIqhGhoLR1C8pVtvXb+VLO8SkbvmZQ+Z13ksSvANPPm
	 J4xTDoyjy8MJw==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 419F287256;
 Tue, 31 Oct 2023 08:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738094;
 bh=x1nH8MYZaahmFNf6xOkinK1vT/iM+ChtUCQotdXH6KA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eu8v2YFSvIIkJq5eyqX/cbmLG4OgiMdEiA8zr2qV07bhUTXFEQ2sE998sDGlR97GU
 3cZdNgnhCttcI0V97Xq2hgiTlFkdqDrX8bHU9k0T3wOj/fXsqOFTw4priW2VrR6WRj
 lCD1VZrEghhoHxsmz4WoY7BII8N++omeH7ttE5J7gL/1bgPfJJuZ1MCw5k+vRgblUK
 Av8wBK11SoMy+rERQ3gZxNxgsXpubuv8HtNQmlX+JhFihCg8ZuZRquO2cs7r51Of9e
 KC+zVX02/4XFlxatptKchgqYoQ00ZEWjBuAzfp7X4pP9b8G1BgT9NOOwNQyMrn7L+N
 V/CBvjb9SX6ag==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v3 3/3] bootcount: Add driver model I2C driver
Date: Tue, 31 Oct 2023 08:38:48 +0100
Message-ID: <20231031073844.15683-8-pro@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031073844.15683-2-pro@denx.de>
References: <20231031073844.15683-2-pro@denx.de>
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

This adds a generic I2C bootcounter adhering to driver model to replace
the previously removed legacy implementation.

There is no change in functionality, it can be used on any I2C device.
The device tree configuration may look like this for example:

	bootcount {
		compatible = "u-boot,bootcount-i2c";
		i2cbcdev = <&i2c_rtc>;
		offset = <0x11>;
	};

Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v3:
    	- Remove common.h #include
    
    Changes in v2:
    	- Adaption of Kconfig help message
    	- Rename chip to bcdev
    	- Adapt probe to use i2c_get_chip_by_phandle()

 drivers/bootcount/Kconfig            |  10 +++
 drivers/bootcount/Makefile           |   1 +
 drivers/bootcount/bootcount_dm_i2c.c | 102 +++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 7a2548ace2..3c56253b1e 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -109,6 +109,16 @@ config DM_BOOTCOUNT_RTC
 	  Accesses to the backing store are performed using the write16
 	  and read16 ops of DM RTC devices.
 
+config DM_BOOTCOUNT_I2C
+	bool "Driver Model boot counter on I2C device"
+	depends on DM_I2C
+	help
+	  Enable support for the bootcounter on a generic i2c device, like a RTC
+	  or PMIC. The bootcounter is configured in the device tree using the
+	  "u-boot,bootcount-i2c" compatible string. It requires a phandle
+	  'i2cbcdev' for the i2c device and an 'offset' property used within the
+	  device.
+
 config DM_BOOTCOUNT_I2C_EEPROM
 	bool "Support i2c eeprom devices as a backing store for bootcount"
 	depends on I2C_EEPROM
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index d6d2389c16..e7771f5b36 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
 obj-$(CONFIG_DM_BOOTCOUNT_PMIC_PFUZE100) += pmic_pfuze100.o
 obj-$(CONFIG_DM_BOOTCOUNT_RTC)  += rtc.o
 obj-$(CONFIG_DM_BOOTCOUNT_I2C_EEPROM)	+= i2c-eeprom.o
+obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
 obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
 obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
diff --git a/drivers/bootcount/bootcount_dm_i2c.c b/drivers/bootcount/bootcount_dm_i2c.c
new file mode 100644
index 0000000000..e27034cbeb
--- /dev/null
+++ b/drivers/bootcount/bootcount_dm_i2c.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023
+ * Philip Richard Oberfichtner <pro@denx.de>
+ *
+ * Based on previous work from Heiko Schocher (legacy bootcount_i2c.c driver)
+ */
+
+#include <bootcount.h>
+#include <dm.h>
+#include <i2c.h>
+
+#define BC_MAGIC	0x55
+
+struct bootcount_i2c_priv {
+	struct udevice *bcdev;
+	unsigned int offset;
+};
+
+static int bootcount_i2c_set(struct udevice *dev, const u32 val)
+{
+	int ret;
+	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
+
+	ret = dm_i2c_reg_write(priv->bcdev, priv->offset, BC_MAGIC);
+	if (ret < 0)
+		goto err_exit;
+
+	ret = dm_i2c_reg_write(priv->bcdev, priv->offset + 1, val & 0xff);
+	if (ret < 0)
+		goto err_exit;
+
+	return 0;
+
+err_exit:
+	log_debug("%s: Error writing to I2C device (%d)\n", __func__, ret);
+	return ret;
+}
+
+static int bootcount_i2c_get(struct udevice *dev, u32 *val)
+{
+	int ret;
+	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
+
+	ret = dm_i2c_reg_read(priv->bcdev, priv->offset);
+	if (ret < 0)
+		goto err_exit;
+
+	if ((ret & 0xff) != BC_MAGIC) {
+		log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+		*val = 0;
+		return bootcount_i2c_set(dev, 0);
+	}
+
+	ret = dm_i2c_reg_read(priv->bcdev, priv->offset + 1);
+	if (ret < 0)
+		goto err_exit;
+
+	*val = ret;
+	return 0;
+
+err_exit:
+	log_debug("%s: Error reading from I2C device (%d)\n", __func__, ret);
+	return ret;
+}
+
+static int bootcount_i2c_probe(struct udevice *dev)
+{
+	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dev_read_u32(dev, "offset", &priv->offset);
+	if (ret)
+		goto exit;
+
+	ret = i2c_get_chip_by_phandle(dev, "i2cbcdev", &priv->bcdev);
+
+exit:
+	if (ret)
+		log_debug("%s failed, ret = %d\n", __func__, ret);
+
+	return ret;
+}
+
+static const struct bootcount_ops bootcount_i2c_ops = {
+	.get = bootcount_i2c_get,
+	.set = bootcount_i2c_set,
+};
+
+static const struct udevice_id bootcount_i2c_ids[] = {
+	{ .compatible = "u-boot,bootcount-i2c" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootcount_i2c) = {
+	.name		= "bootcount-i2c",
+	.id		= UCLASS_BOOTCOUNT,
+	.priv_auto	= sizeof(struct bootcount_i2c_priv),
+	.probe		= bootcount_i2c_probe,
+	.of_match	= bootcount_i2c_ids,
+	.ops		= &bootcount_i2c_ops,
+};
-- 
2.42.0

