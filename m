Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4784CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 09:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBC186E9F;
	Fri, 13 Oct 2023 11:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697190374;
	bh=XNADUS9k94LYp2SrkVKSwamsCIPmclxT03t+hxxyV1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uiYP5rXd2ci+CrF02WsudQjK9QWX9AsP32nY/MiS4icxvIKyK98i/L2FYcaMui2Pz
	 eYjO0yZe1KkTvZdkC2qIcLWYfSTaoRMf1u9MK+UQIgpQvOxDTSDqdK9eSIs+anV/MH
	 EOllMsGmv5m6V+HwZInC6T7NbMkWvYJDst0EgOZxxMgTRbPyUqvnLRd0CkW524y5Zj
	 fICsTEKvTXJ5dN9P0+fFaN8XDcYAcOUHewWNUY/8NT2D/W9szOjvUGY0LBEOQ9AoNE
	 sSrFfp6uc6fmtvVBSnbTR0Tkw/ykZBV1EZG7glIs1Qs08fohtkwd7ZJNWe3E6QpEtC
	 1neiSshvaRBoQ==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:7e7a:91ff:feeb:a1bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 50535868BF;
 Fri, 13 Oct 2023 11:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697190313;
 bh=XNADUS9k94LYp2SrkVKSwamsCIPmclxT03t+hxxyV1M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QLj4CyqhXmZcByYml4UNVwHFv17Uov6mtfuN6k4D2HqN3yXgZZvi0YoCNOAYdTqxs
 YzuDAGbRuhQxA5SGBaE5Fn2zmvNXQul9Mqy0jz4K8ABT6XuMRchZhGjVGfJmrFMP77
 0mNcCMw1dqXmQQ7jCPPZ1GiHvGHKf/EEJ7tUmO9+xmPLMNWa0E1ARlRnK6fzMAccX8
 anVgKGAKeeMLGh+z7gjNKRs+ZQ1Ggaiy3YbLbyV3ViiiR2Hv/L1yfglPAcIaSEYDDz
 mEmS7+6N4KKQq4qyxOAzqDevBQEUDxnwewhnBftzAJwhDWK5tQegN/oxQhTeExeg3P
 uysJL743fGgkQ==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 2/2] bootcount: Add driver model I2C driver
Date: Fri, 13 Oct 2023 11:43:02 +0200
Message-ID: <20231013094302.28944-3-pro@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013094302.28944-1-pro@denx.de>
References: <20231013094302.28944-1-pro@denx.de>
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
		i2c-bus = <&i2c1>;
		address = <0x52>;
		offset = <0x11>;
	};

Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
---
 drivers/bootcount/Kconfig            |  10 +++
 drivers/bootcount/Makefile           |   1 +
 drivers/bootcount/bootcount_dm_i2c.c | 126 +++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 7a2548ace2..1cf1de2b6d 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -109,6 +109,16 @@ config DM_BOOTCOUNT_RTC
 	  Accesses to the backing store are performed using the write16
 	  and read16 ops of DM RTC devices.
 
+config DM_BOOTCOUNT_I2C
+	bool "Driver Model boot counter on I2C device"
+	depends on DM_I2C
+	help
+	  Enable support for the bootcounter on a generic i2c device, like a
+	  RTC or PMIC. This requires an 'i2c-bus', the i2c chip 'address' and
+	  the 'offset' to read to and write from. All of the three settings are
+	  defined as device tree properties using the "u-boot,bootcount-i2c"
+	  compatible string.
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
index 0000000000..227641f77e
--- /dev/null
+++ b/drivers/bootcount/bootcount_dm_i2c.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023
+ * Philip Richard Oberfichtner <pro@denx.de>
+ *
+ * Based on previous work from Heiko Schocher (legacy bootcount_i2c.c driver)
+ */
+
+#include <bootcount.h>
+#include <common.h>
+#include <dm.h>
+#include <i2c.h>
+
+#define BC_MAGIC	0x55
+
+struct bootcount_i2c_priv {
+	struct udevice *chip;
+	unsigned int offset;
+};
+
+static int bootcount_i2c_set(struct udevice *dev, const u32 val)
+{
+	int ret;
+	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
+
+	ret = dm_i2c_reg_write(priv->chip, priv->offset, BC_MAGIC);
+	if (ret < 0)
+		goto err_exit;
+
+	ret = dm_i2c_reg_write(priv->chip, priv->offset + 1, val & 0xff);
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
+	ret = dm_i2c_reg_read(priv->chip, priv->offset);
+	if (ret < 0)
+		goto err_exit;
+
+	if ((ret & 0xff) != BC_MAGIC) {
+		log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+		*val = 0;
+		return bootcount_i2c_set(dev, 0);
+	}
+
+	ret = dm_i2c_reg_read(priv->chip, priv->offset + 1);
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
+	struct ofnode_phandle_args phandle_args;
+	struct udevice *bus;
+	unsigned int addr;
+	int ret;
+
+	ret = dev_read_u32(dev, "offset", &priv->offset);
+	if (ret) {
+		log_debug("%s: Unable to get offset\n", __func__);
+		return ret;
+	}
+
+	ret = dev_read_u32(dev, "address", &addr);
+	if (ret) {
+		log_debug("%s: Unable to get chip address\n", __func__);
+		return ret;
+	}
+
+	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle_args);
+	if (ret) {
+		log_debug("%s: Unable to get phandle\n", __func__);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C, phandle_args.node, &bus);
+	if (ret) {
+		log_debug("%s: Unable to get i2c bus\n", __func__);
+		return ret;
+	}
+
+	ret = i2c_get_chip(bus, addr, 1, &priv->chip);
+	if (ret) {
+		log_debug("%s: Unable to get i2c chip\n", __func__);
+		return ret;
+	}
+
+	return 0;
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

