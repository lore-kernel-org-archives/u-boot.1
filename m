Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B3C83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 08:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A3C86308;
	Sun, 27 Aug 2023 10:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fdoRcO7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE35484B20; Sun, 27 Aug 2023 10:21:35 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FA28470A
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 10:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c0cb7285fso290028266b.0
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693124493; x=1693729293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mneJ8R77MkCsuvBwXGitbP5mJ5FsHYCuGR5BOG8Sg9U=;
 b=fdoRcO7chc2m9ocbUGE84M8+IypvEUgfe8tLE2MklU71uTX7ZRyW8Q95nhZ0tXbMw8
 wrbxY37gbW8Qp94gHSQTkJVBHbhRdpx/5MxddjnLEKTWR80bpHW4AyJfYQuji4PJpK4P
 mKtu9Ytytaxew1kvHkzJ5bvIJFSHIMaL5WaVJXlrbAdmCyxlqJlkf97UGaQ9qbEMdVOG
 wsSMywuaSoMs4fmi6Kb10tf3IcYk2smrXFJsVP/L6ctg5KO/VM3nLjJMSlASFNv+jaa5
 eN0V/nqWFHV3JZaBtZq2T45R68+6hQWjlzsc9ER9vxFRB6F2pk4dROdOv5Zaa5HNXhRD
 LJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693124493; x=1693729293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mneJ8R77MkCsuvBwXGitbP5mJ5FsHYCuGR5BOG8Sg9U=;
 b=gab+B9x515f0E/+Du2aejRc57WuaQBk4SHefxH3q3ddQCKibL2z4rf4dqGhazNDbXo
 P80ReOtzICYNQVRKxLGhOvxg1J45Nb3CIshEYKLboUs/HnhFb4w08BG3OJRLgKvfc+2g
 3Rz3rKtDWd/54hYPtgKTIYfwsbUA68LwaDl05Dzyamvb47mSmxOCPyo3z/v49lVy50ZT
 YQdYgkgCBuGQ8ZbXte4QZ4+b3VdmVIWduj6VJ3M54GUSx/zoaVXQgX4F7p67xsqXexce
 qIF1hvi+6QDwsgTljn0JysrXitUwUGHtLd/xyQaBCfCwgmC4KhgvJA0r4qXzMknhPWyl
 o+Yg==
X-Gm-Message-State: AOJu0Yy9X9lV12NG6ffnm/HFX4k2ALIdrN5a4BTI/pGUCY6Nq2mZ6Xt6
 waQKRb8r9hA7tEJenamkskQ=
X-Google-Smtp-Source: AGHT+IHanrpylWwB91LttVwp3LhEZ3HWnwZBkZaQTnKo3VPsvEiV60kqv0/waGre5BkqM09IDYpIgw==
X-Received: by 2002:a17:906:51d0:b0:9a2:24f9:fabd with SMTP id
 v16-20020a17090651d000b009a224f9fabdmr5348530ejk.73.1693124492738; 
 Sun, 27 Aug 2023 01:21:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170906250a00b0099b5a71b0bfsm3153433ejb.94.2023.08.27.01.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 01:21:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 6/6] sysreset: implement PALMAS sysreset functions
Date: Sun, 27 Aug 2023 11:21:06 +0300
Message-Id: <20230827082106.6255-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827082106.6255-1-clamor95@gmail.com>
References: <20230827082106.6255-1-clamor95@gmail.com>
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
index d6eb9cb433..eaa323ef8f 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -10,10 +10,10 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <dm/lists.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/palmas.h>
-#include <dm/device.h>
 
 static const struct pmic_child_info pmic_children_info[] = {
 	{ .prefix = "ldo", .driver = PALMAS_LDO_DRIVER },
@@ -46,7 +46,16 @@ static int palmas_bind(struct udevice *dev)
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
@@ -80,6 +89,24 @@ static int palmas_bind(struct udevice *dev)
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
@@ -97,5 +124,7 @@ U_BOOT_DRIVER(pmic_palmas) = {
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

