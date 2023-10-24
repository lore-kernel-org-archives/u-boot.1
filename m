Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49BBC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72217876B0;
	Tue, 24 Oct 2023 09:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WhFRH+ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5753875AF; Tue, 24 Oct 2023 09:49:35 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152B187159
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so5686911e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133769; x=1698738569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5q2M5DXsELqKWZaRrPpGsGtFwA0AL8RCnmyrStDSLv0=;
 b=WhFRH+nikMNKP4kpJsQaKEk0EUKKevhccTm/ZWiHnY/3mK6nzC9/0Z53LIul5tllQe
 kCpUt/XpMJ5S0yhqe5wi2vQNdCKbto8ebN+Y7oHu6+a9u3luqpNM1eMH7Jr3g9x4ouFU
 3Eh5OGJznZN0rpHwF2/8SXk4PeDe/Argovgsi9cFkdraHVmFaYtl+YeKJ39r/NH9lC11
 YZCFV1LZm/WtIqgLVeNxCqJYESTyueEINusyXouIG1ckkK52hv2BvHNGZgqyOJm0Cvtw
 zGGnB6t/IwiIw5+/wE6GaL0mVlTYpHQcF9HVY/UJSGoY8y+2H/5OIamHcZqKydkDu7Y0
 eJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133769; x=1698738569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5q2M5DXsELqKWZaRrPpGsGtFwA0AL8RCnmyrStDSLv0=;
 b=Ts+H0tfsQ78WL9KkeD++SbxeHnwwD87PXwEg2CiZhWP2Qr7VfMz5J7ud336IpPOZwC
 z2mbahzQTTliTxP7XsdzzKNlcPfU1PqhOQPUu2+o3hKesa0hI4KP0Ns9i+cfoLmYc3Yy
 sd0jH8WAHT8qve3gqYjqFx9/6AzoBrzr09K2tHPPLUy8OeEcVjsNEspomrq6LXN8O4xN
 +IY7HHgkdKlfqcn+P9Iu5U/55eoLhgELiTlQHAXOuoRKcrYnUcON+FTi5GYKxh7PNyPq
 6LEcp01wtJ6G2IqdxnwHSSbdxiuQngXFkNaX/NC9hinThzY8Zl8UGxyTPHSezmBzfQPr
 Gsng==
X-Gm-Message-State: AOJu0YwENUT/TJrweTJ/Id0dhqmaHv+mEM/cZ9AiCn1kK/wrArDdbcfm
 HG7k4OWzTB+/lEyXg/KlLOp/MAtWoVE=
X-Google-Smtp-Source: AGHT+IEDZqiGEfoIjeNY5u+wG547ykcs8WsozLhYIZ1pCa0zyeX0HEkKS2thu/o1x+qnsH3XQmJdww==
X-Received: by 2002:a05:6512:3b23:b0:500:ac0b:8d58 with SMTP id
 f35-20020a0565123b2300b00500ac0b8d58mr10141549lfv.18.1698133769072; 
 Tue, 24 Oct 2023 00:49:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 v25-20020ac25939000000b00507a89ef9bbsm2011741lfi.166.2023.10.24.00.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:49:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 6/6] sysreset: implement PALMAS sysreset functions
Date: Tue, 24 Oct 2023 10:49:08 +0300
Message-Id: <20231024074908.199903-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074908.199903-1-clamor95@gmail.com>
References: <20231024074908.199903-1-clamor95@gmail.com>
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

PALMAS PMIC family has embedded poweroff function used by some
device to initiane device power off. Implement it as sysreset
driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/palmas.c        | 33 +++++++++++++++++--
 drivers/sysreset/Kconfig           |  7 ++++
 drivers/sysreset/Makefile          |  1 +
 drivers/sysreset/sysreset_palmas.c | 53 ++++++++++++++++++++++++++++++
 include/power/palmas.h             | 11 +++++++
 5 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_palmas.c

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index b2e8a2930c..32f2a938b2 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -8,13 +8,13 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <i2c.h>
 #include <log.h>
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/palmas.h>
-#include <dm/device.h>
 
 static const struct pmic_child_info pmic_children_info[] = {
 	{ .prefix = "ldo", .driver = PALMAS_LDO_DRIVER },
@@ -47,7 +47,16 @@ static int palmas_bind(struct udevice *dev)
 {
 	ofnode pmic_node = ofnode_null(), regulators_node;
 	ofnode subnode;
-	int children;
+	int children, ret;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
+		ret = device_bind_driver(dev, PALMAS_RST_DRIVER,
+					 "sysreset", NULL);
+		if (ret) {
+			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
+			return ret;
+		}
+	}
 
 	dev_for_each_subnode(subnode, dev) {
 		const char *name;
@@ -81,6 +90,24 @@ static int palmas_bind(struct udevice *dev)
 	return 0;
 }
 
+static int palmas_probe(struct udevice *dev)
+{
+	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
+	struct palmas_priv *priv = dev_get_priv(dev);
+	struct udevice *bus = dev_get_parent(dev);
+	u32 chip2_addr = chip->chip_addr + 1;
+	int ret;
+
+	/* Palmas PMIC is multi chip and chips are located in a row */
+	ret = i2c_get_chip(bus, chip2_addr, 1, &priv->chip2);
+	if (ret) {
+		log_err("cannot get second PMIC I2C chip (err %d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static struct dm_pmic_ops palmas_ops = {
 	.read = palmas_read,
 	.write = palmas_write,
@@ -98,5 +125,7 @@ U_BOOT_DRIVER(pmic_palmas) = {
 	.id = UCLASS_PMIC,
 	.of_match = palmas_ids,
 	.bind = palmas_bind,
+	.probe = palmas_probe,
 	.ops = &palmas_ops,
+	.priv_auto = sizeof(struct palmas_priv),
 };
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 659170d156..0e52f99628 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -109,6 +109,13 @@ config SYSRESET_SPL_AT91
 	  This enables the system reset driver support for Microchip/Atmel
 	  SoCs in SPL.
 
+config SYSRESET_PALMAS
+	bool "Enable support for PALMAS System Reset"
+	depends on PMIC_PALMAS
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	help
+	  Enable system power management functions found in PLAMAS PMIC family.
+
 config SYSRESET_PSCI
 	bool "Enable support for PSCI System Reset"
 	depends on ARM_PSCI_FW
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 0d96a204a9..c9f1c625ae 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_$(SPL_TPL_)SYSRESET_MAX77663) += sysreset_max77663.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) += sysreset_octeon.o
+obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PALMAS) += sysreset_palmas.o
 obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
diff --git a/drivers/sysreset/sysreset_palmas.c b/drivers/sysreset/sysreset_palmas.c
new file mode 100644
index 0000000000..d853c33504
--- /dev/null
+++ b/drivers/sysreset/sysreset_palmas.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <i2c.h>
+#include <errno.h>
+#include <sysreset.h>
+#include <power/pmic.h>
+#include <power/palmas.h>
+
+static int palmas_sysreset_request(struct udevice *dev,
+				   enum sysreset_t type)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	int ret;
+
+	/*
+	 * Mask INT3 on second page which detects vbus
+	 * or device will immediately turn on.
+	 */
+	ret = dm_i2c_reg_clrset(priv->chip2, PALMAS_INT3_MASK,
+				MASK_VBUS, MASK_VBUS);
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case SYSRESET_POWER:
+		/* PALMAS: SW_RST > DEV_CTRL */
+		pmic_reg_write(dev->parent, PALMAS_DEV_CTRL, SW_RST);
+		break;
+	case SYSRESET_POWER_OFF:
+		/* PALMAS: DEV_OFF > DEV_CTRL */
+		pmic_reg_write(dev->parent, PALMAS_DEV_CTRL, DEV_OFF);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops palmas_sysreset = {
+	.request = palmas_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_palmas) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= PALMAS_RST_DRIVER,
+	.ops	= &palmas_sysreset,
+};
diff --git a/include/power/palmas.h b/include/power/palmas.h
index df5f15c5bd..0a612052f0 100644
--- a/include/power/palmas.h
+++ b/include/power/palmas.h
@@ -2,6 +2,10 @@
 #define TPS659038	0x1
 #define TPS65917	0x2
 
+struct palmas_priv {
+	struct udevice *chip2;
+};
+
 /* I2C device address for pmic palmas */
 #define PALMAS_I2C_ADDR	(0x12 >> 1)
 #define PALMAS_LDO_NUM		11
@@ -10,6 +14,7 @@
 /* Drivers name */
 #define PALMAS_LDO_DRIVER     "palmas_ldo"
 #define PALMAS_SMPS_DRIVER    "palmas_smps"
+#define PALMAS_RST_DRIVER     "palmas_rst"
 
 #define PALMAS_SMPS_VOLT_MASK		0x7F
 #define PALMAS_SMPS_RANGE_MASK		0x80
@@ -24,3 +29,9 @@
 #define PALMAS_LDO_MODE_MASK	0x1
 #define PALMAS_LDO_STATUS_MASK	0x10
 #define PALMAS_LDO_BYPASS_EN	0x40
+
+#define PALMAS_DEV_CTRL			0xA0
+#define   SW_RST			BIT(1)
+#define   DEV_OFF			0x00
+#define PALMAS_INT3_MASK		0x1B
+#define   MASK_VBUS			BIT(7)
-- 
2.39.2

