Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24747C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FF58714E;
	Tue, 24 Oct 2023 09:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cD+Zh5i3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C68487142; Tue, 24 Oct 2023 09:41:41 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BEF870F1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507c5249d55so5958862e87.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133298; x=1698738098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzw+7TnKlIrV9DsuPsW+zMSZU+vZG2BKSM5Rp83YMgc=;
 b=cD+Zh5i3AUOlepwZVMvjYipFcagS6qePbcpPB8fEggOrYUmV4O5tO8Gus0dJXQe3Ie
 bnbMSNaud+fP4+W5CfY1BsI1iek+ojNoos/+aPPBYWGe+FQ2DR1V2D3prEPusSMAGGjE
 QrRJMU4ZaqRuqdl1LdMzIPQ/jUt543vuBiQXjlGC6+OE729IAPHzk2mulOcYzVTn5C+Q
 n5rJvQOXrvm/UeEFiyYRvJJUsS2kJarhVSuXQ9/5HYuK7NwePL+XoS2BAxmuYr7AuQGi
 fC//6qoaSz0Qo4Nw6GFGuKd9AZqt28lqlLPGtSKWqayQou9xYUpp0vcg7jBy9Sd5eOZk
 MnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133298; x=1698738098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzw+7TnKlIrV9DsuPsW+zMSZU+vZG2BKSM5Rp83YMgc=;
 b=Xs0dpcrj4KKqzdrtlbIsXZRNbUYLrPQj3Jz6KkktsAMAz9tyWeWpkp3F7Mr+GPzoH8
 xgS0yn5Ndlwj7Wqiorxqh0hwM3E2kr59t5EzRjebBNTsXeNCgy51RbpJcBVFdjl0kajQ
 SMrRLZQf+xberoUgHWy6Wm0eYebuCZtpz2CYZkEMxTPrM/RlDYqJ8r40gDcnPgBZEVV4
 mwHjuBgM2M9GMTCsgCQxE3AXDdIOI8KKGsNplK/DSTwY6/qGMQtvlt9lF3983WcsXWgS
 2QUVbhoDeNyApi+ykoMdUYIsHM70qnlyC3G139rlBnicVeG6O/bp1Yp9sl0KcFgzmoD3
 Qg9Q==
X-Gm-Message-State: AOJu0YwR1TP+IssG10ohSDflaPEAxAxQYa2Gs5m4tLrX7upUjikGpwaX
 MhgetEiXgAmtyint8cFh+6g=
X-Google-Smtp-Source: AGHT+IErgGgNON9yLZ7Oyjf6Mn2T5Wayfbdbz3o8qq/GRNCDuJFFtoPoK7O46lFcUhjP3iTZq0A5NQ==
X-Received: by 2002:ac2:5104:0:b0:502:f2a4:152f with SMTP id
 q4-20020ac25104000000b00502f2a4152fmr8115043lfb.10.1698133298424; 
 Tue, 24 Oct 2023 00:41:38 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
Date: Tue, 24 Oct 2023 10:41:05 +0300
Message-Id: <20231024074110.199623-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074110.199623-1-clamor95@gmail.com>
References: <20231024074110.199623-1-clamor95@gmail.com>
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

Add support to bind the regulators/child nodes with the pmic.
Also adds the pmic i2c based read/write functions to access pmic
registers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/device-tree-bindings/pmic/max77663.txt | 84 +++++++++++++++++++++
 drivers/power/pmic/Kconfig                 |  9 +++
 drivers/power/pmic/Makefile                |  1 +
 drivers/power/pmic/max77663.c              | 86 ++++++++++++++++++++++
 include/power/max77663.h                   | 42 +++++++++++
 5 files changed, 222 insertions(+)
 create mode 100644 doc/device-tree-bindings/pmic/max77663.txt
 create mode 100644 drivers/power/pmic/max77663.c
 create mode 100644 include/power/max77663.h

diff --git a/doc/device-tree-bindings/pmic/max77663.txt b/doc/device-tree-bindings/pmic/max77663.txt
new file mode 100644
index 0000000000..ddb7d3eb14
--- /dev/null
+++ b/doc/device-tree-bindings/pmic/max77663.txt
@@ -0,0 +1,84 @@
+MAXIM, MAX77663 PMIC
+
+This device uses two drivers:
+- drivers/power/pmic/max77663.c (for parent device)
+- drivers/power/regulator/max77663_regulator.c (for child regulators)
+
+This chapter describes the binding info for the PMIC driver and regulators.
+
+Required properties for PMIC:
+- compatible: "maxim,max77663"
+- reg: usually 0x1c or 0x3c
+
+With those two properties, the pmic device can be used for read/write only.
+To bind each regulator, the optional regulators subnode should exists.
+
+Optional subnode:
+- name: regulators (subnode list of each device's regulator)
+
+Regulators subnode contains set on supported regulators.
+
+Required properties:
+- regulator-name: used for regulator uclass platform data '.name',
+
+List of supported regulator nodes names for max77663:
+- sd0, sd1, sd2, sd3, ldo0, ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldo8
+
+Optional:
+- regulator-min-microvolt: minimum allowed Voltage to set
+- regulator-max-microvolt: minimum allowed Voltage to set
+- regulator-always-on: regulator should be never disabled
+- regulator-boot-on: regulator should be enabled by the bootloader
+
+Linux driver binding for this driver is compatible.
+
+Example:
+
+max77663@1c {
+	compatible = "maxim,max77663";
+	reg = <0x1c>;
+
+	regulators {
+		sd0 {
+			regulator-name = "vdd_cpu";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		...
+
+		ldo0 {
+			regulator-name = "avdd_pll";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		...
+
+		ldo2 {
+			regulator-name = "avdd_usb";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo3 {
+			regulator-name = "vdd_sdmmc3";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		...
+
+		ldo8 {
+			regulator-name = "avdd_dsi_csi";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+	};
+};
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 4a6f0ce093..54665d7e2b 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -184,6 +184,15 @@ config SPL_DM_PMIC_PFUZE100
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC PFUZE100 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_MAX77663
+	bool "Enable Driver Model for PMIC MAX77663"
+	---help---
+	This config enables implementation of driver-model pmic uclass features
+	for PMIC MAX77663. The driver implements read/write operations.
+	This is a Power Management IC with a decent set of peripherals from which
+	4 DC-to-DC Step-Down (SD) Regulators, 9 Low-Dropout Linear (LDO) Regulators,
+	8 GPIOs, Real-Time Clock (RTC) and more with I2C Compatible Interface.
+
 config DM_PMIC_MAX77686
 	bool "Enable Driver Model for PMIC MAX77686"
 	---help---
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 0b3b3d62d0..414a9d8225 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_$(SPL_TPL_)DM_PMIC) += pmic-uclass.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_DA9063) += da9063.o
+obj-$(CONFIG_$(SPL_)DM_PMIC_MAX77663) += max77663.o
 obj-$(CONFIG_DM_PMIC_MAX77686) += max77686.o
 obj-$(CONFIG_DM_PMIC_MAX8998) += max8998.o
 obj-$(CONFIG_DM_PMIC_MC34708) += mc34708.o
diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
new file mode 100644
index 0000000000..4070235d3c
--- /dev/null
+++ b/drivers/power/pmic/max77663.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/max77663.h>
+
+static const struct pmic_child_info pmic_children_info[] = {
+	{ .prefix = "ldo", .driver = MAX77663_LDO_DRIVER },
+	{ .prefix = "sd", .driver = MAX77663_SD_DRIVER },
+	{ },
+};
+
+static int max77663_write(struct udevice *dev, uint reg, const uint8_t *buff,
+			  int len)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, buff, len);
+	if (ret) {
+		log_debug("write error to device: %p register: %#x!\n", dev, reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max77663_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, buff, len);
+	if (ret) {
+		log_debug("read error from device: %p register: %#x!\n", dev, reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max77663_bind(struct udevice *dev)
+{
+	ofnode regulators_node;
+	int children;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		log_err("%s regulators subnode not found!\n", dev->name);
+		return -ENXIO;
+	}
+
+	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
+
+	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
+	if (!children)
+		log_err("%s - no child found\n", dev->name);
+
+	/* Always return success for this device */
+	return 0;
+}
+
+static struct dm_pmic_ops max77663_ops = {
+	.read = max77663_read,
+	.write = max77663_write,
+};
+
+static const struct udevice_id max77663_ids[] = {
+	{ .compatible = "maxim,max77663" },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_max77663) = {
+	.name = "max77663_pmic",
+	.id = UCLASS_PMIC,
+	.of_match = max77663_ids,
+	.bind = max77663_bind,
+	.ops = &max77663_ops,
+};
diff --git a/include/power/max77663.h b/include/power/max77663.h
new file mode 100644
index 0000000000..0f764bcbcc
--- /dev/null
+++ b/include/power/max77663.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef _MAX77663_H_
+#define _MAX77663_H_
+
+#define MAX77663_LDO_NUM		9
+#define MAX77663_SD_NUM			5
+
+/* Drivers name */
+#define MAX77663_LDO_DRIVER		"max77663_ldo"
+#define MAX77663_SD_DRIVER		"max77663_sd"
+
+/* Step-Down (SD) Regulator calculations */
+#define SD_STATUS_MASK			0x30
+
+#define SD0_VOLT_MAX_HEX		0x40
+#define SD1_VOLT_MAX_HEX		0x4c
+#define SD_VOLT_MAX_HEX			0xff
+#define SD_VOLT_MIN_HEX			0x02
+
+#define SD0_VOLT_MAX			1400000
+#define SD1_VOLT_MAX			1550000
+#define SD_VOLT_MAX			3787500
+#define SD_VOLT_MIN			625000
+
+#define SD_VOLT_BASE			600000
+
+/* Low-Dropout Linear (LDO) Regulator calculations */
+#define LDO_STATUS_MASK			0xc0
+#define LDO_VOLT_MASK			0x3f
+#define LDO_VOLT_MAX_HEX		0x3f
+
+#define LDO01_VOLT_MAX			2375000
+#define LDO4_VOLT_MAX			1587500
+#define LDO_VOLT_MAX			3950000
+
+#define LDO_VOLT_BASE			800000
+
+#endif /* _MAX77663_H_ */
-- 
2.39.2

