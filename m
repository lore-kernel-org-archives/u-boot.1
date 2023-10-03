Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D592E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6883C87227;
	Tue,  3 Oct 2023 08:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BB8aBrXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1478987242; Tue,  3 Oct 2023 08:29:57 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CAA8721C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50444e756deso674909e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314593; x=1696919393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jj09/D5xt3j7gzsLQRMQGbnvFBTnRPqnlQ/IgrhV9TE=;
 b=BB8aBrXFpDSbY1hwzUqW2acwlmr6NOwhjZg2NfeW3AcJCPOsmxbvmX1lM5V7GIzb8s
 VFWAqwU9fSxuIcEdbd2iIGpeHUGxcSpUKlJ8IpeTR1u9xIuwm9WBl6Q4nBPDGIHEMO5x
 SdR6TFh9zXrAoBGSNn2fjs+g0qyrepfKgJjeBwc7uWO8HYXgxS7BV9uOIDgFI/yx5ols
 89J81ZQWKp+JEPMxpgBttv+RRr99CnCteHjh8NOI6YElSxJgIILADMXJZUSTPoy6aFBd
 /h1n5GvYa4u0sdVbnCyiqqsaFPKlMt1xSmq/cF4VsRMTwmAVoRa+av7Qed5FMnwa1UeY
 1mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314593; x=1696919393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jj09/D5xt3j7gzsLQRMQGbnvFBTnRPqnlQ/IgrhV9TE=;
 b=NP6yQOTv7tl86wc2JuPi7M6zP29VViZQRKTXHRCY0McdQwGvLU2ZMR7VujvT5sNJiQ
 pqSqwUszRg4J9MhMnxpHhMMAyeEwnP1qrsBXeJEaU1MtTid3Icc3yeIaUvrWXG0DLiSs
 PXyDw98JsLViP9PU1MDguWu4nSvSk3jXOPK1PzmMVD2F1u1oQzsTxlqnf6v4oW9es5rk
 ZsXY2IGTECvGQHgrV0IOUs4QsLWbEIHEJKG9Hz4AdWxi9ukNMFSxspTnT/7i/DDxgkE7
 4KqUtyJO0c0mQzkKnPBhynEs6c4voU5QEemVCGZTZhdCAgHRAu75WvO/mzEiXmKl740r
 0fag==
X-Gm-Message-State: AOJu0Yy6z3Yz8WkC9o8Aek7JHK/J84dJRERrwgWNbV2V9nonBhFyTgZG
 Lppexj5KheNB3AIVTJNHPNA=
X-Google-Smtp-Source: AGHT+IF4hWvMVn5eTxpvHV8KlpABISuUx0JLDtpohLF/++62WrVrEvWlGZA7y6209386fBCYxnflfQ==
X-Received: by 2002:a05:6512:3d10:b0:500:7a23:720b with SMTP id
 d16-20020a0565123d1000b005007a23720bmr14999406lfv.55.1696314593023; 
 Mon, 02 Oct 2023 23:29:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 5/8] power: pmic: add the base TPS80031 PMIC support
Date: Tue,  3 Oct 2023 09:29:38 +0300
Message-Id: <20231003062941.42501-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062941.42501-1-clamor95@gmail.com>
References: <20231003062941.42501-1-clamor95@gmail.com>
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
 doc/device-tree-bindings/pmic/tps80031.txt | 76 +++++++++++++++++++
 drivers/power/pmic/Kconfig                 | 11 +++
 drivers/power/pmic/Makefile                |  1 +
 drivers/power/pmic/tps80031.c              | 87 ++++++++++++++++++++++
 include/power/tps80031.h                   | 45 +++++++++++
 5 files changed, 220 insertions(+)
 create mode 100644 doc/device-tree-bindings/pmic/tps80031.txt
 create mode 100644 drivers/power/pmic/tps80031.c
 create mode 100644 include/power/tps80031.h

diff --git a/doc/device-tree-bindings/pmic/tps80031.txt b/doc/device-tree-bindings/pmic/tps80031.txt
new file mode 100644
index 0000000000..577e6de1c1
--- /dev/null
+++ b/doc/device-tree-bindings/pmic/tps80031.txt
@@ -0,0 +1,76 @@
+Texas Instruments, TPS80031/TPS80032 PMIC
+
+This device uses two drivers:
+- drivers/power/pmic/tps80031.c (for parent device)
+- drivers/power/regulator/tps80031_regulator.c (for child regulators)
+
+This chapter describes the binding info for the PMIC driver and regulators.
+
+Required properties for PMIC:
+- compatible: "ti,tps80031" or "ti,tps80032"
+- reg: 0x48
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
+List of supported regulator nodes names for tps80031/tps80032:
+- smps1, smps2, smps3, smps4, smps5
+- ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldoln, ldousb
+
+SMPS5 in Linux 3.1.10 is referred as vio, but datasheet clearly names it SMPS5.
+
+Optional:
+- regulator-min-microvolt: minimum allowed Voltage to set
+- regulator-max-microvolt: minimum allowed Voltage to set
+- regulator-always-on: regulator should be never disabled
+- regulator-boot-on: regulator should be enabled by the bootloader
+
+Example:
+
+tps80032@48 {
+	compatible = "ti,tps80032";
+	reg = <0x48>;
+
+	regulators {
+		smps1 {
+			regulator-name = "vdd_cpu";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		...
+
+		smps5 {
+			regulator-name = "vdd_1v8_gen";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		ldo1 {
+			regulator-name = "avdd_dsi_csi";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-boot-on;
+		};
+
+		...
+
+		ldousb {
+			regulator-name = "avdd_usb";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index b2a5e71a87..df42f2fa2f 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -350,6 +350,17 @@ config DM_PMIC_TPS65910
 	DC-DC converter, 8 LDOs and a RTC. This driver binds the SMPS and LDO
 	pmic children.
 
+config DM_PMIC_TPS80031
+	bool "Enable driver for Texas Instruments TPS80031/TPS80032 PMIC"
+	---help---
+	This config enables implementation of driver-model pmic uclass features
+	for TPS80031/TPS80032 PMICs. The driver implements read/write operations.
+	This is a Power Management IC with a decent set of peripherals from which
+	5 Buck Converters refered as Switched-mode power supply (SMPS), 11 General-
+	Purpose Low-Dropout Voltage Regulators (LDO), USB OTG Module, Real-Time
+	Clock (RTC) with Timer and Alarm Wake-Up, Two Digital PWM Outputs and more
+	with I2C Compatible Interface. PMIC occupies 4 I2C addresses.
+
 config PMIC_STPMIC1
 	bool "Enable support for STMicroelectronics STPMIC1 PMIC"
 	depends on DM_I2C
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 414a9d8225..55ee614364 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(SPL_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
 obj-$(CONFIG_PMIC_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_PMIC_TPS65910) += pmic_tps65910_dm.o
+obj-$(CONFIG_$(SPL_)DM_PMIC_TPS80031) += tps80031.o
 obj-$(CONFIG_$(SPL_)PMIC_PALMAS) += palmas.o
 obj-$(CONFIG_$(SPL_)PMIC_LP873X) += lp873x.o
 obj-$(CONFIG_$(SPL_)PMIC_LP87565) += lp87565.o
diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
new file mode 100644
index 0000000000..c2b04fffdf
--- /dev/null
+++ b/drivers/power/pmic/tps80031.c
@@ -0,0 +1,87 @@
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
+#include <power/tps80031.h>
+
+static const struct pmic_child_info pmic_children_info[] = {
+	{ .prefix = "ldo", .driver = TPS80031_LDO_DRIVER },
+	{ .prefix = "smps", .driver = TPS80031_SMPS_DRIVER },
+	{ },
+};
+
+static int tps80031_write(struct udevice *dev, uint reg, const uint8_t *buff,
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
+static int tps80031_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
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
+static int tps80031_bind(struct udevice *dev)
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
+static struct dm_pmic_ops tps80031_ops = {
+	.read = tps80031_read,
+	.write = tps80031_write,
+};
+
+static const struct udevice_id tps80031_ids[] = {
+	{ .compatible = "ti,tps80031" },
+	{ .compatible = "ti,tps80032" },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_tps80031) = {
+	.name = "tps80031_pmic",
+	.id = UCLASS_PMIC,
+	.of_match = tps80031_ids,
+	.bind = tps80031_bind,
+	.ops = &tps80031_ops,
+};
diff --git a/include/power/tps80031.h b/include/power/tps80031.h
new file mode 100644
index 0000000000..c80692a8af
--- /dev/null
+++ b/include/power/tps80031.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef _TPS80031_H_
+#define _TPS80031_H_
+
+#define TPS80031_LDO_NUM		9
+#define TPS80031_SMPS_NUM		5
+
+/* Drivers name */
+#define TPS80031_LDO_DRIVER		"tps80031_ldo"
+#define TPS80031_SMPS_DRIVER		"tps80031_smps"
+
+#define TPS80031_SMPS_OFFSET		0xe0
+#define TPS80031_OFFSET_FLAG		BIT(0)
+
+#define REGULATOR_STATUS_MASK		0x3
+#define REGULATOR_MODE_ON		0x1
+
+/* Switched-Mode Power Supply Regulator calculations */
+#define SMPS_VOLT_MASK			0x3f
+#define SMPS_VOLT_LINEAR_HEX		0x39
+#define SMPS_VOLT_NLINEAR_HEX		0x3a
+#define SMPS_VOLT_LINEAR		1300000
+#define SMPS_VOLT_BASE			600000
+#define SMPS_VOLT_BASE_OFFSET		700000
+
+/* Low-Dropout Linear (LDO) Regulator calculations */
+#define LDO_VOLT_MASK			0x3f
+#define LDO_VOLT_MAX_HEX		0x18
+#define LDO_VOLT_MIN_HEX		0x01
+#define LDO_VOLT_MAX			3360000
+#define LDO_VOLT_MIN			1018000
+#define LDO_VOLT_BASE			916000
+
+/* register groups */
+enum {
+	CTRL,
+	VOLT,
+	OFFSET,
+};
+
+#endif /* _TPS80031_H_ */
-- 
2.39.2

