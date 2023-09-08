Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D87EEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AA686A9E;
	Fri,  8 Sep 2023 19:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JcYzNWcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7CB86A35; Fri,  8 Sep 2023 19:30:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B9986A9E
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388HU7OA073547;
 Fri, 8 Sep 2023 12:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694194207;
 bh=IcIgk/kXew0bc4BsYoOB/C2AGBIQHy90HTsj6kwkUgE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JcYzNWcLnDONauAO7CiRp/kIEAWw9eOM1/a9vTS8uGGftKDmc/wtZPaXJTMuAsXu/
 Tr0qikoBxPhiXK3DDq3u8qvG9g9TmBHajbD2EJm4gzjppN7eCsYfwbqenCgcmzFheM
 6LzFRvtA1ddC3nJ+QnZP7tt5+/SldY4rWlc6IpPI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388HU71F012620
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:30:07 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:30:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:30:06 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388HTfxJ052571;
 Fri, 8 Sep 2023 12:30:04 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH v2 1/3] thermal: k3: Add support for thermal in vtm
Date: Fri, 8 Sep 2023 22:59:14 +0530
Message-ID: <20230908172914.436194-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908172914.436194-1-u-kumar1@ti.com>
References: <20230908172914.436194-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

TI K3's SOC supports AVS class 0 and thermal functions
by one IP called VTM (voltage and Thermal Manager).

This patch adds support for thermal management into
available AVS driver.

Along with updating needed configs for boot

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 configs/am65x_evm_r5_defconfig        |   3 +
 configs/am65x_evm_r5_usbdfu_defconfig |   3 +
 configs/am65x_evm_r5_usbmsc_defconfig |   3 +
 configs/am65x_hs_evm_r5_defconfig     |   3 +
 configs/j7200_evm_a72_defconfig       |   3 +
 configs/j7200_evm_r5_defconfig        |   3 +
 configs/j721e_evm_a72_defconfig       |   3 +
 configs/j721e_evm_r5_defconfig        |   3 +
 drivers/misc/Makefile                 |   1 -
 drivers/misc/k3_avs.c                 | 394 -----------
 drivers/thermal/Kconfig               |   7 +
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/k3_thermal.c          | 926 ++++++++++++++++++++++++++
 13 files changed, 958 insertions(+), 395 deletions(-)
 delete mode 100644 drivers/misc/k3_avs.c
 create mode 100644 drivers/thermal/k3_thermal.c

diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index d5196c2024..3b7acb2566 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -140,3 +140,6 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 88f68aa70e..5e2a64e747 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -135,3 +135,6 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 8da49c78c8..f8f8ff7f6f 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -131,3 +131,6 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/configs/am65x_hs_evm_r5_defconfig b/configs/am65x_hs_evm_r5_defconfig
index 0c7b53ca2c..97f4649e6e 100644
--- a/configs/am65x_hs_evm_r5_defconfig
+++ b/configs/am65x_hs_evm_r5_defconfig
@@ -133,3 +133,6 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ad8492a17e..1ee101f3ff 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -197,3 +197,6 @@ CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
+CONFIG_CMD_TEMPERATURE=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index c4dd33627b..6d240b16cb 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -168,3 +168,6 @@ CONFIG_FS_EXT4=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 214fa8b2f3..49ead704ab 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -201,3 +201,6 @@ CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
+CONFIG_CMD_TEMPERATURE=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index cf7bc872b5..f66b08170a 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -178,3 +178,6 @@ CONFIG_FS_EXT4=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_THERMAL=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fd8805f34b..f93bb4b89b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -84,7 +84,6 @@ obj-$(CONFIG_VEXPRESS_CONFIG) += vexpress_config.o
 obj-$(CONFIG_WINBOND_W83627) += winbond_w83627.o
 obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
 obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
-obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
deleted file mode 100644
index 840148d090..0000000000
--- a/drivers/misc/k3_avs.c
+++ /dev/null
@@ -1,394 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Texas Instruments' K3 Clas 0 Adaptive Voltage Scaling driver
- *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
- *      Tero Kristo <t-kristo@ti.com>
- *
- */
-
-#include <common.h>
-#include <dm.h>
-#include <errno.h>
-#include <asm/io.h>
-#include <i2c.h>
-#include <k3-avs.h>
-#include <dm/device_compat.h>
-#include <linux/bitops.h>
-#include <power/regulator.h>
-
-#define AM6_VTM_DEVINFO(i)	(priv->base + 0x100 + 0x20 * (i))
-#define AM6_VTM_OPPVID_VD(i)	(priv->base + 0x104 + 0x20 * (i))
-
-#define AM6_VTM_AVS0_SUPPORTED	BIT(12)
-
-#define AM6_VTM_OPP_SHIFT(opp)	(8 * (opp))
-#define AM6_VTM_OPP_MASK	0xff
-
-#define VD_FLAG_INIT_DONE	BIT(0)
-
-struct k3_avs_privdata {
-	void *base;
-	struct vd_config *vd_config;
-};
-
-struct opp {
-	u32 freq;
-	u32 volt;
-};
-
-struct vd_data {
-	int id;
-	u8 opp;
-	u8 flags;
-	int dev_id;
-	int clk_id;
-	struct opp opps[NUM_OPPS];
-	struct udevice *supply;
-};
-
-struct vd_config {
-	struct vd_data *vds;
-	u32 (*efuse_xlate)(struct k3_avs_privdata *priv, int idx, int opp);
-};
-
-static struct k3_avs_privdata *k3_avs_priv;
-
-/**
- * am6_efuse_voltage: read efuse voltage from VTM
- * @priv: driver private data
- * @idx: VD to read efuse for
- * @opp: opp id to read
- *
- * Reads efuse value for the specified OPP, and converts the register
- * value to a voltage. Returns the voltage in uV, or 0 if nominal voltage
- * should be used.
- *
- * Efuse val to volt conversion logic:
- *
- * val > 171 volt increments in 20mV steps with base 171 => 1.66V
- * val between 115 to 11 increments in 10mV steps with base 115 => 1.1V
- * val between 15 to 115 increments in 5mV steps with base 15 => .6V
- * val between 1 to 15 increments in 20mv steps with base 0 => .3V
- * val 0 is invalid
- */
-static u32 am6_efuse_xlate(struct k3_avs_privdata *priv, int idx, int opp)
-{
-	u32 val = readl(AM6_VTM_OPPVID_VD(idx));
-
-	val >>= AM6_VTM_OPP_SHIFT(opp);
-	val &= AM6_VTM_OPP_MASK;
-
-	if (!val)
-		return 0;
-
-	if (val > 171)
-		return 1660000 + 20000 * (val - 171);
-
-	if (val > 115)
-		return 1100000 + 10000 * (val - 115);
-
-	if (val > 15)
-		return 600000 + 5000 * (val - 15);
-
-	return 300000 + 20000 * val;
-}
-
-static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
-				  struct vd_data *vd,
-				  int opp_id)
-{
-	u32 volt = vd->opps[opp_id].volt;
-	struct vd_data *vd2;
-
-	if (!vd->supply)
-		return -ENODEV;
-
-	vd->opp = opp_id;
-	vd->flags |= VD_FLAG_INIT_DONE;
-
-	/* Take care of ganged rails and pick the Max amongst them*/
-	for (vd2 = priv->vd_config->vds; vd2->id >= 0; vd2++) {
-		if (vd == vd2)
-			continue;
-
-		if (vd2->supply != vd->supply)
-			continue;
-
-		if (vd2->opps[vd2->opp].volt > volt)
-			volt = vd2->opps[vd2->opp].volt;
-
-		vd2->flags |= VD_FLAG_INIT_DONE;
-	}
-
-	return regulator_set_value(vd->supply, volt);
-}
-
-static struct vd_data *get_vd(struct k3_avs_privdata *priv, int idx)
-{
-	struct vd_data *vd;
-
-	for (vd = priv->vd_config->vds; vd->id >= 0 && vd->id != idx; vd++)
-		;
-
-	if (vd->id < 0)
-		return NULL;
-
-	return vd;
-}
-
-/**
- * k3_avs_set_opp: Sets the voltage for an arbitrary VD rail
- * @dev: AVS device
- * @vdd_id: voltage domain ID
- * @opp_id: OPP ID
- *
- * Programs the desired OPP value for the defined voltage rail. This
- * should be called from board files if reconfiguration is desired.
- * Returns 0 on success, negative error value on failure.
- */
-int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id)
-{
-	struct k3_avs_privdata *priv = dev_get_priv(dev);
-	struct vd_data *vd;
-
-	vd = get_vd(priv, vdd_id);
-	if (!vd)
-		return -EINVAL;
-
-	return k3_avs_program_voltage(priv, vd, opp_id);
-}
-
-static int match_opp(struct vd_data *vd, u32 freq)
-{
-	struct opp *opp;
-	int opp_id;
-
-	for (opp_id = 0; opp_id < NUM_OPPS; opp_id++) {
-		opp = &vd->opps[opp_id];
-		if (opp->freq == freq)
-			return opp_id;
-	}
-
-	printf("No matching OPP found for freq %d.\n", freq);
-
-	return -EINVAL;
-}
-
-/**
- * k3_avs_notify_freq: Notify clock rate change towards AVS subsystem
- * @dev_id: Device ID for the clock to be changed
- * @clk_id: Clock ID for the clock to be changed
- * @freq: New frequency for clock
- *
- * Checks if the provided clock is the MPU clock or not, if not, return
- * immediately. If MPU clock is provided, maps the provided MPU frequency
- * towards an MPU OPP, and programs the voltage to the regulator. Return 0
- * on success, negative error value on failure.
- */
-int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq)
-{
-	int opp_id;
-	struct k3_avs_privdata *priv = k3_avs_priv;
-	struct vd_data *vd;
-
-	/* Driver may not be probed yet */
-	if (!priv)
-		return -EINVAL;
-
-	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
-		if (vd->dev_id != dev_id || vd->clk_id != clk_id)
-			continue;
-
-		opp_id = match_opp(vd, freq);
-		if (opp_id < 0)
-			return opp_id;
-
-		vd->opp = opp_id;
-		return k3_avs_program_voltage(priv, vd, opp_id);
-	}
-
-	return -EINVAL;
-}
-
-static int k3_avs_configure(struct udevice *dev, struct k3_avs_privdata *priv)
-{
-	struct vd_config *conf;
-	int ret;
-	char pname[20];
-	struct vd_data *vd;
-
-	conf = (void *)dev_get_driver_data(dev);
-
-	priv->vd_config = conf;
-
-	for (vd = conf->vds; vd->id >= 0; vd++) {
-		sprintf(pname, "vdd-supply-%d", vd->id);
-		ret = device_get_supply_regulator(dev, pname, &vd->supply);
-		if (ret)
-			dev_warn(dev, "supply not found for VD%d.\n", vd->id);
-
-		sprintf(pname, "ti,default-opp-%d", vd->id);
-		ret = dev_read_u32_default(dev, pname, -1);
-		if (ret != -1)
-			vd->opp = ret;
-	}
-
-	return 0;
-}
-
-/**
- * k3_avs_probe: parses VD info from VTM, and re-configures the OPP data
- *
- * Parses all VDs on a device calculating the AVS class-0 voltages for them,
- * and updates the vd_data based on this. The vd_data itself shall be used
- * to program the required OPPs later on. Returns 0 on success, negative
- * error value on failure.
- */
-static int k3_avs_probe(struct udevice *dev)
-{
-	int opp_id;
-	u32 volt;
-	struct opp *opp;
-	struct k3_avs_privdata *priv;
-	struct vd_data *vd;
-	int ret;
-
-	priv = dev_get_priv(dev);
-
-	k3_avs_priv = priv;
-
-	ret = k3_avs_configure(dev, priv);
-	if (ret)
-		return ret;
-
-	priv->base = dev_read_addr_ptr(dev);
-	if (!priv->base)
-		return -ENODEV;
-
-	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
-		if (!(readl(AM6_VTM_DEVINFO(vd->id)) &
-		      AM6_VTM_AVS0_SUPPORTED)) {
-			dev_warn(dev, "AVS-class 0 not supported for VD%d\n",
-				 vd->id);
-			continue;
-		}
-
-		for (opp_id = 0; opp_id < NUM_OPPS; opp_id++) {
-			opp = &vd->opps[opp_id];
-
-			if (!opp->freq)
-				continue;
-
-			volt = priv->vd_config->efuse_xlate(priv, vd->id,
-							    opp_id);
-			if (volt)
-				opp->volt = volt;
-		}
-	}
-
-	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
-		if (vd->flags & VD_FLAG_INIT_DONE)
-			continue;
-
-		k3_avs_program_voltage(priv, vd, vd->opp);
-	}
-
-	return 0;
-}
-
-static struct vd_data am654_vd_data[] = {
-	{
-		.id = AM6_VDD_CORE,
-		.dev_id = 82, /* AM6_DEV_CBASS0 */
-		.clk_id = 0, /* main sysclk0 */
-		.opp = AM6_OPP_NOM,
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1000000,
-				.freq = 250000000, /* CBASS0 */
-			},
-		},
-	},
-	{
-		.id = AM6_VDD_MPU0,
-		.dev_id = 202, /* AM6_DEV_COMPUTE_CLUSTER_A53_0 */
-		.clk_id = 0, /* ARM clock */
-		.opp = AM6_OPP_NOM,
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1100000,
-				.freq = 800000000,
-			},
-			[AM6_OPP_OD] = {
-				.volt = 1200000,
-				.freq = 1000000000,
-			},
-			[AM6_OPP_TURBO] = {
-				.volt = 1240000,
-				.freq = 1100000000,
-			},
-		},
-	},
-	{
-		.id = AM6_VDD_MPU1,
-		.opp = AM6_OPP_NOM,
-		.dev_id = 204, /* AM6_DEV_COMPUTE_CLUSTER_A53_2 */
-		.clk_id = 0, /* ARM clock */
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 1100000,
-				.freq = 800000000,
-			},
-			[AM6_OPP_OD] = {
-				.volt = 1200000,
-				.freq = 1000000000,
-			},
-			[AM6_OPP_TURBO] = {
-				.volt = 1240000,
-				.freq = 1100000000,
-			},
-		},
-	},
-	{ .id = -1 },
-};
-
-static struct vd_data j721e_vd_data[] = {
-	{
-		.id = J721E_VDD_MPU,
-		.opp = AM6_OPP_NOM,
-		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
-		.clk_id = 2, /* ARM clock */
-		.opps = {
-			[AM6_OPP_NOM] = {
-				.volt = 880000, /* TBD in DM */
-				.freq = 2000000000,
-			},
-		},
-	},
-	{ .id = -1 },
-};
-
-static struct vd_config j721e_vd_config = {
-	.efuse_xlate = am6_efuse_xlate,
-	.vds = j721e_vd_data,
-};
-
-static struct vd_config am654_vd_config = {
-	.efuse_xlate = am6_efuse_xlate,
-	.vds = am654_vd_data,
-};
-
-static const struct udevice_id k3_avs_ids[] = {
-	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
-	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
-	{}
-};
-
-U_BOOT_DRIVER(k3_avs) = {
-	.name = "k3_avs",
-	.of_match = k3_avs_ids,
-	.id = UCLASS_MISC,
-	.probe = k3_avs_probe,
-	.priv_auto	= sizeof(struct k3_avs_privdata),
-};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 681b621760..f235cc8ee0 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -35,6 +35,13 @@ config IMX_TMU
 	  The boot is hold to the cool device to throttle CPUs when the
 	  passive trip is crossed
 
+config TI_K3_THERMAL
+        bool "Temperature sensor and AVS driver for TI K3 j7xx SOCs"
+        help
+          Enable thermal and avs support for the Texas Instruments TI K3 j7xx family.
+          The driver supports reading CPU temperature.
+
+
 config TI_DRA7_THERMAL
         bool "Temperature sensor driver for TI dra7xx SOCs"
         help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8acc7d20cb..75acc1942b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
 obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
 obj-$(CONFIG_IMX_SCU_THERMAL) += imx_scu_thermal.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
+obj-$(CONFIG_TI_K3_THERMAL) +=k3_thermal.o
 obj-$(CONFIG_IMX_TMU) += imx_tmu.o
diff --git a/drivers/thermal/k3_thermal.c b/drivers/thermal/k3_thermal.c
new file mode 100644
index 0000000000..de6d88abf0
--- /dev/null
+++ b/drivers/thermal/k3_thermal.c
@@ -0,0 +1,926 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' K3 Clas 0 Adaptive Voltage Scaling driver
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *      Tero Kristo <t-kristo@ti.com>
+ *
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <i2c.h>
+#include <k3-avs.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <power/regulator.h>
+#include <thermal.h>
+
+#include <linux/math64.h>
+#include <dm/devres.h>
+#include <linux/err.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+
+#define AM6_VTM_DEVINFO(i)	(priv->base + 0x100 + 0x20 * (i))
+#define AM6_VTM_OPPVID_VD(i)	(priv->base + 0x104 + 0x20 * (i))
+
+#define AM6_VTM_AVS0_SUPPORTED	BIT(12)
+
+#define AM6_VTM_OPP_SHIFT(opp)	(8 * (opp))
+#define AM6_VTM_OPP_MASK	0xff
+
+#define VD_FLAG_INIT_DONE	BIT(0)
+
+#define K3_VTM_DEVINFO_PWR0_OFFSET              0x4
+#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK    0xf0
+#define K3_VTM_TMPSENS0_CTRL_OFFSET             0x300
+#define K3_VTM_MISC_CTRL_OFFSET                 0xc
+#define K3_VTM_TMPSENS_STAT_OFFSET              0x8
+#define K3_VTM_ANYMAXT_OUTRG_ALERT_EN           0x1
+#define K3_VTM_MISC_CTRL2_OFFSET                0x10
+#define K3_VTM_TS_STAT_DTEMP_MASK               0x3ff
+#define K3_VTM_MAX_NUM_TS                       8
+#define K3_VTM_TMPSENS_CTRL_SOC                 BIT(5)
+#define K3_VTM_TMPSENS_CTRL_CLRZ                BIT(6)
+#define K3_VTM_TMPSENS_CTRL_CLKON_REQ           BIT(7)
+#define K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN       BIT(11)
+
+#define K3_VTM_CORRECTION_TEMP_CNT              3
+
+#define MINUS40CREF                             5
+#define PLUS30CREF                              253
+#define PLUS125CREF                             730
+#define PLUS150CREF                             940
+
+#define TABLE_SIZE                              1024
+#define MAX_TEMP                                123000
+#define COOL_DOWN_TEMP                          105000
+
+#define FACTORS_REDUCTION                       13
+static int *derived_table;
+
+struct k3_thermal_data;
+
+struct k3_avs_privdata {
+	void *base;
+	struct vd_config *vd_config;
+	struct udevice *dev;
+	void __iomem *cfg2_base;
+	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
+};
+
+/* common data structures */
+struct k3_thermal_data {
+	struct k3_avs_privdata *bgp;
+	u32 ctrl_offset;
+	u32 stat_offset;
+};
+
+/**
+ * struct err_values - structure containing error/reference values
+ * @refs: reference error values for -40C, 30C, 125C & 150C
+ * @errs: Actual error values for -40C, 30C, 125C & 150C read from the efuse
+ */
+struct err_values {
+	int refs[4];
+	int errs[4];
+};
+
+struct opp {
+	u32 freq;
+	u32 volt;
+};
+
+struct vd_data {
+	int id;
+	u8 opp;
+	u8 flags;
+	int dev_id;
+	int clk_id;
+	struct opp opps[NUM_OPPS];
+	struct udevice *supply;
+};
+
+struct vd_config {
+	struct vd_data *vds;
+	u32 (*efuse_xlate)(struct k3_avs_privdata *priv, int idx, int opp);
+};
+
+static struct k3_avs_privdata *k3_avs_priv;
+
+#ifndef CONFIG_CPU_V7R
+static u64 int_pow(u64 base, unsigned int exp)
+{
+	u64 result = 1;
+
+	while (exp) {
+		if (exp & 1)
+			result *= base;
+		exp >>= 1;
+		base *= base;
+	}
+
+	return result;
+}
+
+static int compute_value(int index, const s64 *factors, int nr_factors,
+			 int reduction)
+{
+	s64 value = 0;
+	int i;
+
+	for (i = 0; i < nr_factors; i++)
+		value += factors[i] * int_pow(index, i);
+
+	return (int)div64_s64(value, int_pow(10, reduction));
+}
+
+static void init_table(int factors_size, int *table, const s64 *factors)
+{
+	int i;
+
+	for (i = 0; i < TABLE_SIZE; i++)
+		table[i] = compute_value(i, factors, factors_size,
+					 FACTORS_REDUCTION);
+}
+
+static void create_table_segments(struct err_values *err_vals, int seg,
+				  int *ref_table)
+{
+	int m = 0, c, num, den, i, err, idx1, idx2, err1, err2, ref1, ref2;
+
+	if (seg == 0)
+		idx1 = 0;
+	else
+		idx1 = err_vals->refs[seg];
+
+	idx2 = err_vals->refs[seg + 1];
+	err1 = err_vals->errs[seg];
+	err2 = err_vals->errs[seg + 1];
+	ref1 = err_vals->refs[seg];
+	ref2 = err_vals->refs[seg + 1];
+
+	/*
+	 * Calculate the slope with adc values read from the register
+	 * as the y-axis param and err in adc value as x-axis param
+	 */
+	num = ref2 - ref1;
+	den = err2 - err1;
+	if (den)
+		m = num / den;
+	c = ref2 - m * err2;
+
+	/*
+	 * Take care of divide by zero error if error values are same
+	 * Or when the slope is 0
+	 */
+
+	if (den != 0 && m != 0) {
+		for (i = idx1; i <= idx2; i++) {
+			err = (i - c) / m;
+			if (((i + err) < 0) || ((i + err) >= TABLE_SIZE))
+				continue;
+			derived_table[i] = ref_table[i + err];
+		}
+	} else { /* Constant error take care of divide by zero */
+		for (i = idx1; i <= idx2; i++) {
+			if (((i + err1) < 0) || ((i + err1) >= TABLE_SIZE))
+				continue;
+			derived_table[i] = ref_table[i + err1];
+		}
+	}
+}
+
+static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
+{
+	int inc, i, seg;
+
+	/*
+	 * Fill up the lookup table under 3 segments
+	 * region -40C to +30C
+	 * region +30C to +125C
+	 * region +125C to +150C
+	 */
+	for (seg = 0; seg < 3; seg++)
+		create_table_segments(err_vals, seg, ref_table);
+
+	/* Get to the first valid temperature */
+	i = 0;
+	while (!derived_table[i])
+		i++;
+
+	/*
+	 * Get to the last zero index and back fill the temperature for
+	 * sake of continuity
+	 */
+	if (i) {
+		/* 300 milli celsius steps */
+		while (i--)
+			derived_table[i] = derived_table[i + 1] - 300;
+	}
+
+	/*
+	 * Fill the last trailing 0s which are unfilled with increments of
+	 * 100 milli celsius till 1023 code
+	 */
+	i = TABLE_SIZE - 1;
+	while (!derived_table[i])
+		i--;
+
+	i++;
+	inc = 1;
+	while (i < TABLE_SIZE) {
+		derived_table[i] = derived_table[i - 1] + inc * 100;
+		i++;
+	}
+
+	return 0;
+}
+
+static int two_cmp(int tmp, int mask)
+{
+	tmp = ~(tmp);
+	tmp &= mask;
+	tmp += 1;
+
+	/* Return negative value */
+	return (0 - tmp);
+}
+
+static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
+				       unsigned int s2)
+{
+	int d01 = abs(s0 - s1);
+	int d02 = abs(s0 - s2);
+	int d12 = abs(s1 - s2);
+
+	if (d01 <= d02 && d01 <= d12)
+		return (s0 + s1) / 2;
+
+	if (d02 <= d01 && d02 <= d12)
+		return (s0 + s2) / 2;
+
+	return (s1 + s2) / 2;
+}
+
+static inline int k3_bgp_read_temp(struct k3_avs_privdata *bgp,
+				   int *temp)
+{
+	unsigned int dtemp, s0, s1, s2;
+
+	/*
+	 * Errata is applicable for am654 pg 1.0 silicon/J7ES. There
+	 * is a variation of the order for certain degree centigrade on AM654.
+	 * Work around that by getting the average of two closest
+	 * readings out of three readings everytime we want to
+	 * report temperatures.
+	 *
+	 * Errata workaround.
+	 */
+	s0 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	s1 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	s2 = readl(bgp->base + bgp->ts_data[0]->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	dtemp = vtm_get_best_value(s0, s1, s2);
+
+	if (dtemp < 0 || dtemp >= TABLE_SIZE)
+		return -EINVAL;
+
+	*temp = derived_table[dtemp];
+
+	return 0;
+}
+
+static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
+			     void __iomem *fuse_base)
+{
+	int i, tmp, pow;
+	int ct_offsets[5][K3_VTM_CORRECTION_TEMP_CNT] = {
+		{ 0x0, 0x8, 0x4 },
+		{ 0x0, 0x8, 0x4 },
+		{ 0x0, -1,  0x4 },
+		{ 0x0, 0xC, -1 },
+		{ 0x0, 0xc, 0x8 }
+	};
+	int ct_bm[5][K3_VTM_CORRECTION_TEMP_CNT] = {
+		{ 0x3f, 0x1fe000, 0x1ff },
+		{ 0xfc0, 0x1fe000, 0x3fe00 },
+		{ 0x3f000, 0x7f800000, 0x7fc0000 },
+		{ 0xfc0000, 0x1fe0, 0x1f800000 },
+		{ 0x3f000000, 0x1fe000, 0x1ff0 }
+	};
+
+	for (i = 0; i < 3; i++) {
+		/* Extract the offset value using bit-mask */
+		if (ct_offsets[id][i] == -1 && i == 1) {
+			/* 25C offset Case of Sensor 2 split between 2 regs */
+			tmp = (readl(fuse_base + 0x8) & 0xE0000000) >> (29);
+			tmp |= ((readl(fuse_base + 0xC) & 0x1F) << 3);
+			pow = tmp & 0x80;
+		} else if (ct_offsets[id][i] == -1 && i == 2) {
+			/* 125C Case of Sensor 3 split between 2 regs */
+			tmp = (readl(fuse_base + 0x4) & 0xF8000000) >> (27);
+			tmp |= ((readl(fuse_base + 0x8) & 0xF) << 5);
+			pow = tmp & 0x100;
+		} else {
+			tmp = readl(fuse_base + ct_offsets[id][i]);
+			tmp &= ct_bm[id][i];
+			tmp = tmp >> __ffs(ct_bm[id][i]);
+
+			/* Obtain the sign bit pow*/
+			pow = ct_bm[id][i] >> __ffs(ct_bm[id][i]);
+			pow += 1;
+			pow /= 2;
+		}
+
+		/* Check for negative value */
+		if (tmp & pow) {
+			/* 2's complement value */
+			tmp = two_cmp(tmp, ct_bm[id][i] >> __ffs(ct_bm[id][i]));
+		}
+		err[i] = tmp;
+	}
+
+	/* Err value for 150C is set to 0 */
+	err[i] = 0;
+}
+
+static void print_look_up_table(struct udevice *dev, int *ref_table)
+{
+	int i;
+
+	debug("The contents of derived array\n");
+	debug("Code   Temperature\n");
+	for (i = 0; i < TABLE_SIZE; i++)
+		debug("%d       %d %d\n", i, derived_table[i], ref_table[i]);
+}
+#else
+
+static inline int k3_bgp_read_temp(struct k3_avs_privdata *bgp,
+				   int *temp)
+{
+	return -EPFNOSUPPORT;
+}
+
+static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
+			     void __iomem *fuse_base)
+{
+}
+
+static void init_table(int factors_size, int *table, const s64 *factors)
+{
+}
+
+static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
+{
+	return 0;
+}
+
+static void print_look_up_table(struct udevice *dev, int *ref_table)
+{
+}
+#endif
+
+static int k3_j72xx_bandgap_temp_to_adc_code(int temp, bool workaround_needed)
+{
+	int low = 0, high = TABLE_SIZE - 1, mid = 0;
+
+	if (temp > 160000 || temp < -50000)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_K3_AVS0)) {
+		if (temp == 123000)
+			mid = 760 -  workaround_needed * 44;
+		else if (temp == 105000)
+			mid = 648 - workaround_needed * 44;
+		else
+			printf("Only 123C and 105C is supported in R5/SPL\n");
+
+		return mid;
+	}
+
+	/* Binary search to find the adc code */
+	while (low < (high - 1)) {
+		mid = (low + high) / 2;
+		if (temp <= derived_table[mid])
+			high = mid;
+		else
+			low = mid;
+	}
+	return mid;
+}
+
+/* Get temperature callback function for thermal zone */
+static int k3_thermal_get_temp(struct udevice *dev,  int *temp)
+{
+	struct k3_avs_privdata *bgp = dev_get_priv(dev);
+
+	return k3_bgp_read_temp(bgp, temp);
+}
+
+static const struct dm_thermal_ops k3_of_thermal_ops = {
+	.get_temp = k3_thermal_get_temp,
+};
+
+static int k3_j72xx_bandgap_probe(struct udevice *dev)
+{
+	int ret = 0, cnt, val, id;
+	int high_max, low_temp;
+	struct k3_avs_privdata *bgp;
+	struct k3_thermal_data *data;
+	bool workaround_needed = false;
+	int *ref_table;
+	struct err_values err_vals;
+	void __iomem *fuse_base;
+
+	const s64 golden_factors[] = {
+		-490019999999999936,
+		3251200000000000,
+		-1705800000000,
+		603730000,
+		-92627,
+	};
+
+	const s64 pvt_wa_factors[] = {
+		-415230000000000000,
+		3126600000000000,
+		-1157800000000,
+	};
+
+	bgp = dev_get_priv(dev);
+	if (!bgp)
+		return -ENOMEM;
+
+	bgp->dev = dev;
+	bgp->base = (void __iomem *)devfdt_get_addr_index(dev, 0);
+	if (IS_ERR(bgp->base))
+		return PTR_ERR(bgp->base);
+
+	bgp->cfg2_base = (void __iomem *)devfdt_get_addr_index(dev, 1);
+	if (IS_ERR(bgp->cfg2_base))
+		return PTR_ERR(bgp->cfg2_base);
+
+	/*
+	 * Some of TI's J721E SoCs require a software trimming procedure
+	 * for the temperature monitors to function properly. To determine
+	 * if this particular SoC is NOT affected, both bits in the
+	 * WKUP_SPARE_FUSE0[31:30] will be set (0xC0000000) indicating
+	 * when software trimming should NOT be applied.
+	 *
+	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
+	 */
+
+	if (device_is_compatible(bgp->dev, "ti,j721e-vtm")) {
+		fuse_base = (void __iomem *)devfdt_get_addr_index(dev, 2);
+		if (IS_ERR(fuse_base))
+			return PTR_ERR(fuse_base);
+
+		if (!((readl(fuse_base) & 0xc0000000) == 0xc0000000))
+			workaround_needed = false;
+	}
+
+	debug("Work around %sneeded\n", workaround_needed ? "" : "not ");
+
+	/* Get the sensor count in the VTM */
+	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
+	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
+	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
+
+	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	ref_table = kzalloc(sizeof(*ref_table) * TABLE_SIZE, GFP_KERNEL);
+	if (!ref_table) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * TABLE_SIZE,
+				     GFP_KERNEL);
+	if (!derived_table) {
+		ret = -ENOMEM;
+		goto err_free_ref_table;
+	}
+
+	if (!workaround_needed)
+		init_table(5, ref_table, golden_factors);
+	else
+		init_table(3, ref_table, pvt_wa_factors);
+
+	print_look_up_table(dev, ref_table);
+
+	/* Register the thermal sensors */
+	for (id = 0; id < cnt; id++) {
+		data[id].bgp = bgp;
+		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
+		data[id].stat_offset = data[id].ctrl_offset +
+					K3_VTM_TMPSENS_STAT_OFFSET;
+
+		if (workaround_needed) {
+			/* ref adc values for -40C, 30C & 125C respectively */
+			err_vals.refs[0] = MINUS40CREF;
+			err_vals.refs[1] = PLUS30CREF;
+			err_vals.refs[2] = PLUS125CREF;
+			err_vals.refs[3] = PLUS150CREF;
+			get_efuse_values(id, &data[id], err_vals.errs, fuse_base);
+		}
+
+		if (id == 0 && workaround_needed)
+			prep_lookup_table(&err_vals, ref_table);
+		else if (id == 0 && !workaround_needed)
+			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
+
+		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
+		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
+			K3_VTM_TMPSENS_CTRL_SOC |
+			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
+		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
+
+		bgp->ts_data[id] = &data[id];
+	}
+
+	/*
+	 * Program TSHUT thresholds
+	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
+	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
+	 *         This is already taken care as per of init
+	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
+	 */
+	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP, workaround_needed);
+	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP, workaround_needed);
+	debug("high as %d and low as %d\n", high_max, low_temp);
+	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
+	       K3_VTM_MISC_CTRL2_OFFSET);
+	mdelay(100);
+	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
+	       K3_VTM_MISC_CTRL_OFFSET);
+
+	/*
+	 * Now that the derived_table has the appropriate look up values
+	 * Free up the ref_table
+	 */
+	kfree(ref_table);
+
+	return 0;
+
+err_free_ref_table:
+	kfree(ref_table);
+
+err_alloc:
+
+	return ret;
+}
+
+/**
+ * am6_efuse_voltage: read efuse voltage from VTM
+ * @priv: driver private data
+ * @idx: VD to read efuse for
+ * @opp: opp id to read
+ *
+ * Reads efuse value for the specified OPP, and converts the register
+ * value to a voltage. Returns the voltage in uV, or 0 if nominal voltage
+ * should be used.
+ *
+ * Efuse val to volt conversion logic:
+ *
+ * val > 171 volt increments in 20mV steps with base 171 => 1.66V
+ * val between 115 to 11 increments in 10mV steps with base 115 => 1.1V
+ * val between 15 to 115 increments in 5mV steps with base 15 => .6V
+ * val between 1 to 15 increments in 20mv steps with base 0 => .3V
+ * val 0 is invalid
+ */
+static u32 am6_efuse_xlate(struct k3_avs_privdata *priv, int idx, int opp)
+{
+	u32 val = readl(AM6_VTM_OPPVID_VD(idx));
+
+	val >>= AM6_VTM_OPP_SHIFT(opp);
+	val &= AM6_VTM_OPP_MASK;
+
+	if (!val)
+		return 0;
+
+	if (val > 171)
+		return 1660000 + 20000 * (val - 171);
+
+	if (val > 115)
+		return 1100000 + 10000 * (val - 115);
+
+	if (val > 15)
+		return 600000 + 5000 * (val - 15);
+
+	return 300000 + 20000 * val;
+}
+
+static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
+				  struct vd_data *vd,
+				  int opp_id)
+{
+	u32 volt = vd->opps[opp_id].volt;
+	struct vd_data *vd2;
+
+	if (!vd->supply)
+		return -ENODEV;
+
+	vd->opp = opp_id;
+	vd->flags |= VD_FLAG_INIT_DONE;
+
+	/* Take care of ganged rails and pick the Max amongst them*/
+	for (vd2 = priv->vd_config->vds; vd2->id >= 0; vd2++) {
+		if (vd == vd2)
+			continue;
+
+		if (vd2->supply != vd->supply)
+			continue;
+
+		if (vd2->opps[vd2->opp].volt > volt)
+			volt = vd2->opps[vd2->opp].volt;
+
+		vd2->flags |= VD_FLAG_INIT_DONE;
+	}
+
+	return regulator_set_value(vd->supply, volt);
+}
+
+static struct vd_data *get_vd(struct k3_avs_privdata *priv, int idx)
+{
+	struct vd_data *vd;
+
+	for (vd = priv->vd_config->vds; vd->id >= 0 && vd->id != idx; vd++)
+		;
+
+	if (vd->id < 0)
+		return NULL;
+
+	return vd;
+}
+
+/**
+ * k3_avs_set_opp: Sets the voltage for an arbitrary VD rail
+ * @dev: AVS device
+ * @vdd_id: voltage domain ID
+ * @opp_id: OPP ID
+ *
+ * Programs the desired OPP value for the defined voltage rail. This
+ * should be called from board files if reconfiguration is desired.
+ * Returns 0 on success, negative error value on failure.
+ */
+int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id)
+{
+	struct k3_avs_privdata *priv = dev_get_priv(dev);
+	struct vd_data *vd;
+
+	vd = get_vd(priv, vdd_id);
+	if (!vd)
+		return -EINVAL;
+
+	return k3_avs_program_voltage(priv, vd, opp_id);
+}
+
+static int match_opp(struct vd_data *vd, u32 freq)
+{
+	struct opp *opp;
+	int opp_id;
+
+	for (opp_id = 0; opp_id < NUM_OPPS; opp_id++) {
+		opp = &vd->opps[opp_id];
+		if (opp->freq == freq)
+			return opp_id;
+	}
+
+	printf("No matching OPP found for freq %d.\n", freq);
+
+	return -EINVAL;
+}
+
+/**
+ * k3_avs_notify_freq: Notify clock rate change towards AVS subsystem
+ * @dev_id: Device ID for the clock to be changed
+ * @clk_id: Clock ID for the clock to be changed
+ * @freq: New frequency for clock
+ *
+ * Checks if the provided clock is the MPU clock or not, if not, return
+ * immediately. If MPU clock is provided, maps the provided MPU frequency
+ * towards an MPU OPP, and programs the voltage to the regulator. Return 0
+ * on success, negative error value on failure.
+ */
+int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq)
+{
+	int opp_id;
+	struct k3_avs_privdata *priv = k3_avs_priv;
+	struct vd_data *vd;
+
+	/* Driver may not be probed yet */
+	if (!priv)
+		return -EINVAL;
+
+	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
+		if (vd->dev_id != dev_id || vd->clk_id != clk_id)
+			continue;
+
+		opp_id = match_opp(vd, freq);
+		if (opp_id < 0)
+			return opp_id;
+
+		vd->opp = opp_id;
+		return k3_avs_program_voltage(priv, vd, opp_id);
+	}
+
+	return -EINVAL;
+}
+
+static int k3_avs_configure(struct udevice *dev, struct k3_avs_privdata *priv)
+{
+	struct vd_config *conf;
+	int ret;
+	char pname[20];
+	struct vd_data *vd;
+
+	conf = (void *)dev_get_driver_data(dev);
+
+	priv->vd_config = conf;
+
+	for (vd = conf->vds; vd->id >= 0; vd++) {
+		sprintf(pname, "vdd-supply-%d", vd->id);
+		ret = device_get_supply_regulator(dev, pname, &vd->supply);
+		if (ret)
+			dev_warn(dev, "supply not found for VD%d.\n", vd->id);
+
+		sprintf(pname, "ti,default-opp-%d", vd->id);
+		ret = dev_read_u32_default(dev, pname, -1);
+		if (ret != -1)
+			vd->opp = ret;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_avs_probe: parses VD info from VTM, and re-configures the OPP data
+ *
+ * Parses all VDs on a device calculating the AVS class-0 voltages for them,
+ * and updates the vd_data based on this. The vd_data itself shall be used
+ * to program the required OPPs later on. Returns 0 on success, negative
+ * error value on failure.
+ */
+static int k3_avs_probe(struct udevice *dev)
+{
+	int opp_id;
+	u32 volt;
+	struct opp *opp;
+	struct k3_avs_privdata *priv;
+	struct vd_data *vd;
+	int ret;
+
+	priv = dev_get_priv(dev);
+
+	k3_avs_priv = priv;
+
+	ret = k3_avs_configure(dev, priv);
+	if (ret)
+		return ret;
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -ENODEV;
+
+	/* AVS is enabled for SPL to set voltage before releasing A72 */
+	if (IS_ENABLED(CONFIG_K3_AVS0)) {
+		for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
+			if (!(readl(AM6_VTM_DEVINFO(vd->id)) &
+					AM6_VTM_AVS0_SUPPORTED)) {
+				dev_warn(dev, "AVS-class 0 not supported for VD%d\n",
+					 vd->id);
+				continue;
+			}
+
+			for (opp_id = 0; opp_id < NUM_OPPS; opp_id++) {
+				opp = &vd->opps[opp_id];
+
+				if (!opp->freq)
+					continue;
+
+				volt = priv->vd_config->efuse_xlate(priv, vd->id,
+							    opp_id);
+				if (volt)
+					opp->volt = volt;
+			}
+		}
+
+		for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
+			if (vd->flags & VD_FLAG_INIT_DONE)
+				continue;
+
+			k3_avs_program_voltage(priv, vd, vd->opp);
+		}
+	}
+	/* Probe thermal management driver */
+	k3_j72xx_bandgap_probe(dev);
+
+	return 0;
+}
+
+static struct vd_data am654_vd_data[] = {
+	{
+		.id = AM6_VDD_CORE,
+		.dev_id = 82, /* AM6_DEV_CBASS0 */
+		.clk_id = 0, /* main sysclk0 */
+		.opp = AM6_OPP_NOM,
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1000000,
+				.freq = 250000000, /* CBASS0 */
+			},
+		},
+	},
+	{
+		.id = AM6_VDD_MPU0,
+		.dev_id = 202, /* AM6_DEV_COMPUTE_CLUSTER_A53_0 */
+		.clk_id = 0, /* ARM clock */
+		.opp = AM6_OPP_NOM,
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1100000,
+				.freq = 800000000,
+			},
+			[AM6_OPP_OD] = {
+				.volt = 1200000,
+				.freq = 1000000000,
+			},
+			[AM6_OPP_TURBO] = {
+				.volt = 1240000,
+				.freq = 1100000000,
+			},
+		},
+	},
+	{
+		.id = AM6_VDD_MPU1,
+		.opp = AM6_OPP_NOM,
+		.dev_id = 204, /* AM6_DEV_COMPUTE_CLUSTER_A53_2 */
+		.clk_id = 0, /* ARM clock */
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 1100000,
+				.freq = 800000000,
+			},
+			[AM6_OPP_OD] = {
+				.volt = 1200000,
+				.freq = 1000000000,
+			},
+			[AM6_OPP_TURBO] = {
+				.volt = 1240000,
+				.freq = 1100000000,
+			},
+		},
+	},
+	{ .id = -1 },
+};
+
+static struct vd_data j721e_vd_data[] = {
+	{
+		.id = J721E_VDD_MPU,
+		.opp = AM6_OPP_NOM,
+		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
+		.clk_id = 2, /* ARM clock */
+		.opps = {
+			[AM6_OPP_NOM] = {
+				.volt = 880000, /* TBD in DM */
+				.freq = 2000000000,
+			},
+		},
+	},
+	{ .id = -1 },
+};
+
+static struct vd_config j721e_vd_config = {
+	.efuse_xlate = am6_efuse_xlate,
+	.vds = j721e_vd_data,
+};
+
+static struct vd_config am654_vd_config = {
+	.efuse_xlate = am6_efuse_xlate,
+	.vds = am654_vd_data,
+};
+
+static const struct udevice_id k3_avs_ids[] = {
+	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
+	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
+	{}
+};
+
+U_BOOT_DRIVER(k3_avs) = {
+	.name = "k3_avs",
+	.of_match = k3_avs_ids,
+	.id = UCLASS_THERMAL,
+	.ops    = &k3_of_thermal_ops,
+	.probe = k3_avs_probe,
+	.priv_auto	= sizeof(struct k3_avs_privdata),
+};
-- 
2.34.1

