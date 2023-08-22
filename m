Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BC8EE49A8
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 06:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 899FA871C2;
	Tue, 22 Aug 2023 08:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TViG2dRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A01187249; Tue, 22 Aug 2023 08:32:48 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFE087067
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so8500106a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692685962; x=1693290762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Ma+Tnq8+rl2+OBxrddESo2U1I8ftg5f/xBMt6m1EY=;
 b=TViG2dRxg856h1KGxwTGmLNenl30mO02BwKpNVzs+4L93brugwF89T2B/MWG3l1WND
 C1LLVbyipdb3vfcJ+EP+PR7+02gp1ZKSOdvdJKKqSRitgmU1vKegDVIXcQkWnvW0J2BY
 JexdsP+ltpX2HaLu89Bmb4ipEc9MKnVgy/7fP7r1rzs+Z6dgR2T+GiA1xUEoaROtu3he
 YsxNEcGK0MzoBUXEFAGW1RNiMfGJcBsfjtt2pGOH8Fxsh/2PHijRN4qqGwG0cihIRLl+
 +I3wXt+hswBaw0ZvnTtmGwpvGDwH1+EksjPzi8+Gd5FSt0+PGKK7Yzm+v4X49+TzQ/8N
 vZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685962; x=1693290762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90Ma+Tnq8+rl2+OBxrddESo2U1I8ftg5f/xBMt6m1EY=;
 b=bqqPkWLs/F2Qu/u6czjdbIt4Ie19A4GtPukNtEUMORa1d8843AASzj9jkiHrwVNahI
 P7uRiQ6PlDpp8kOW/UnRyfD+p5YpM0EM4dBG1B4aso85Em6svz9+D0nmqlC+Zo+ZP7hz
 sOuBzBtH9pTaxmQsqtS4nwYrEETLnkVfqp/wQ6RVK8abGxPlmnIYwDOAVxagpyxzUBYN
 e5KYUh+c+oToj0ZiTBzs9F480XbPghCQREqlnK1o7inyfzgt3x4qrwNvMLEQFW/H3/OZ
 ANPmXHafJjBYuod7GUmhfTRURYZlKog4fElGNoFg+ParRvwf2wZHXE52MegfLwjIAqzn
 7mcQ==
X-Gm-Message-State: AOJu0Yw+gXtSjgV8DSFtNpaBO+fJ8gb9A3BuRPdgf+EdzA4IWctGqcyF
 WvdNrxGwieYArgckVJvVKVwOQzcoJMoSsw==
X-Google-Smtp-Source: AGHT+IEpoVw8A93piAAfcL4WAo50sonFLMSrGMDOpU+dMCLkF4Q6ylqxli8SFO56YjMxy6eLsm5hMw==
X-Received: by 2002:a05:6402:50c9:b0:522:405f:a7 with SMTP id
 h9-20020a05640250c900b00522405f00a7mr9329739edb.16.1692685962418; 
 Mon, 21 Aug 2023 23:32:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b0052a19a75372sm784320edb.90.2023.08.21.23.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 23:32:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 3/8] power: pmic: add the base MAX77663 PMIC support
Date: Tue, 22 Aug 2023 09:32:15 +0300
Message-Id: <20230822063220.5191-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822063220.5191-1-clamor95@gmail.com>
References: <20230822063220.5191-1-clamor95@gmail.com>
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
index 176fb07c65..b2a5e71a87 100644
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

