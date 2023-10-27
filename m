Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A3CC25B67
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 08:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F7887C19;
	Fri, 27 Oct 2023 10:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UUFKNPdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B2F87C18; Fri, 27 Oct 2023 10:26:35 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094C987C13
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso2615537e87.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698395191; x=1698999991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FvX5UPETFI2dHUHu4rGGRuS7b77Hco6ay4fEC7Ksn0=;
 b=UUFKNPdCHMZB2EYeLcUvb5t/BZaTBiWUmbRb292aGQ9XxU55DgMdi5l8Cl4IkcuQbq
 Ia4W7aOZk9vMJAbp0TuOaFtbwOGp9gxUFPVncw5XZvW9ObJcb/jyE3970iUfemS1oVnI
 /PE5YxHMws0ONSiRxal3UprHaOvP6UPBrnw5Laq/KEiXVkQFulKlqd6vHH/sx6pCZb/A
 WNFWgILzM61wgtUH8HNElgb/Ga34mSKWmXuP8k75RDb7Ipg1DBqvODP7KJlRKqecajbg
 2E2H0KVUSPreM/o7QBliTQ2EF0u0RqbyW8LaP+iVtV3WpeeDlDMcRlV1dqRwVPRExloJ
 /T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395191; x=1698999991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FvX5UPETFI2dHUHu4rGGRuS7b77Hco6ay4fEC7Ksn0=;
 b=PTrqPfPC1OYXW6q8Im5mslR3XhvWQ+ZTEA++YiqnoPitgDcd7DsxuWJk8DiqGkvzdw
 LWnffUXZKiGy8esa8yslQGYHlrt5n27JpgwsVk1x8ILsjI/B7yAftppqZsUnME6N7zzS
 TtXhms8rFDX0NK4bcYeJmeAo6I+CFJEJ8m1trMyYZ348KPk0PbBKVFqzjMN838BlIy5A
 etP49I6tbEwVxG+2pPondEMriHU8uLE/w8dKqSTHZbm0NcXtHDwcS0/a2M2TY5P+pvQX
 8KPOhb2VUUrGYG3xWL6oPxJh98/WDOlqQ1hQYwZ/WGz+iyg25kzT0fGRWNFRipAPPKyE
 14Bg==
X-Gm-Message-State: AOJu0Yz4Q6Agyy3Zu8fq1xhyudfp+MtPM46QdtcD4zpTgILVCD/JBSdQ
 2D5Rr4fCpzbVdVp2uDWI93s=
X-Google-Smtp-Source: AGHT+IF/14wDa9yUBkdt5Fmy8t8ot17VYtPOuwtCt2IUU3rUhNU1we/lJOf6TvJEh56kDootJ+ZtaQ==
X-Received: by 2002:a05:6512:39d4:b0:507:b084:d6bb with SMTP id
 k20-20020a05651239d400b00507b084d6bbmr1876876lfu.43.1698395191237; 
 Fri, 27 Oct 2023 01:26:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 u15-20020ac248af000000b004fdd6b72bfdsm183445lfg.117.2023.10.27.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:26:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 3/8] power: pmic: add the base MAX77663 PMIC support
Date: Fri, 27 Oct 2023 11:26:10 +0300
Message-Id: <20231027082615.306943-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027082615.306943-1-clamor95@gmail.com>
References: <20231027082615.306943-1-clamor95@gmail.com>
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
 doc/device-tree-bindings/pmic/max77663.txt | 84 ++++++++++++++++++++++
 drivers/power/pmic/Kconfig                 |  9 +++
 drivers/power/pmic/Makefile                |  1 +
 drivers/power/pmic/max77663.c              | 81 +++++++++++++++++++++
 include/power/max77663.h                   | 42 +++++++++++
 5 files changed, 217 insertions(+)
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
index 0000000000..fac97ed221
--- /dev/null
+++ b/drivers/power/pmic/max77663.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <power/pmic.h>
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

