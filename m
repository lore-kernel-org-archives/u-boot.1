Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3801C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B8E87197;
	Wed,  8 Nov 2023 16:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884E9870F5; Wed,  8 Nov 2023 16:36:59 +0100 (CET)
Received: from esa2.ltts.com (unknown [14.140.155.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0927C87208
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: F3aBqP483xOtDJDZpWqDwhn8rpX4yjeeUnSZbDLwO74ADl7Roj86A2xzbo+zGx5wVB+W1468b5
 36xgeUkt+GZA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa2.ltts.com with ESMTP; 08 Nov 2023 21:06:54 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: jh80.chung@samsung.com
Cc: bhargav.r@ltts.com,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] driver: power: add support for TPS65224
Date: Wed,  8 Nov 2023 21:06:47 +0530
Message-Id: <20231108153647.144051-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <053701da1145$9380ac30$ba820490$@samsung.com>
References: <053701da1145$9380ac30$ba820490$@samsung.com>
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

> Hi Bhargav,
> 
> > -----Original Message-----
> > From: Bhargav Raviprakash <bhargav.r@ltts.com>
> > Sent: Monday, November 6, 2023 11:07 PM
> > To: u-boot@lists.denx.de
> > Cc: jh80.chung@samsung.com; Bhargav Raviprakash <bhargav.r@ltts.com>
> > Subject: [PATCH v2 1/2] driver: power: add support for TPS65224
> > 
> > Added support for PMIC TPS65224. Includes driver for pmic,
> > and disabling Watchdog.
> > 
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >  drivers/power/pmic/Kconfig    |   6 ++
> >  drivers/power/pmic/Makefile   |   1 +
> >  drivers/power/pmic/tps65224.c | 141 ++++++++++++++++++++++++++++++++++
> >  include/power/tps65224.h      |  57 ++++++++++++++
> >  4 files changed, 205 insertions(+)
> >  create mode 100644 drivers/power/pmic/tps65224.c
> >  create mode 100644 include/power/tps65224.h
> > 
> > diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> > index 4a6f0ce093..b06bd31823 100644
> > --- a/drivers/power/pmic/Kconfig
> > +++ b/drivers/power/pmic/Kconfig
> > @@ -378,6 +378,12 @@ config PMIC_TPS65941
> >  	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
> >  	This driver binds the pmic children.
> > 
> > +config PMIC_TPS65224
> > +	bool "Enable driver for Texas Instruments TPS65224 PMIC"
> > +	help
> > +	The TPS65224 is a PMIC containing a bunch of SMPS & LDOs.
> > +	This driver binds the pmic children.
> > +
> >  config PMIC_TPS65219
> >  	bool "Enable driver for Texas Instruments TPS65219 PMIC"
> >  	depends on DM_PMIC
> > diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
> > index 0b3b3d62d0..cec16e57d3 100644
> > --- a/drivers/power/pmic/Makefile
> > +++ b/drivers/power/pmic/Makefile
> > @@ -33,6 +33,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
> >  obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
> >  obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
> >  obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
> > +obj-$(CONFIG_PMIC_TPS65224) += tps65224.o
> 
> Ordering this. Maybe it can be located at tps65941.o.
> 

Sure, will do!

> >  obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
> > 
> >  ifeq ($(CONFIG_$(SPL_)POWER_LEGACY),y)
> > diff --git a/drivers/power/pmic/tps65224.c b/drivers/power/pmic/tps65224.c
> > new file mode 100644
> > index 0000000000..33395f6edf
> > --- /dev/null
> > +++ b/drivers/power/pmic/tps65224.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2023 Texas Instruments Incorporated, <www.ti.com>
> > + */
> > +#include <fdtdec.h>
> > +#include <errno.h>
> > +#include <dm.h>
> > +#include <i2c.h>
> > +#include <log.h>
> > +#include <power/pmic.h>
> > +#include <power/regulator.h>
> > +#include <power/tps65224.h>
> > +#include <dm/device.h>
> > +
> > +static const struct pmic_child_info pmic_children_info[] = {
> > +	{ .prefix = "ldo", .driver = TPS65224_LDO_DRIVER },
> > +	{ .prefix = "buck", .driver = TPS65224_BUCK_DRIVER },
> > +	{ },
> > +};
> > +
> > +static int tps65224_write(struct udevice *dev, uint reg, const uint8_t *buff,
> > +			  int len)
> > +{
> > +	if (dm_i2c_write(dev, reg, buff, len)) {
> > +		pr_err("write error to device: %p register: %#x!\n", dev, reg);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tps65224_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
> > +{
> > +	if (dm_i2c_read(dev, reg, buff, len)) {
> > +		pr_err("read error from device: %p register: %#x!\n", dev, reg);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tps65224_bind(struct udevice *dev)
> > +{
> > +	ofnode regulators_node;
> > +	int children;
> > +
> > +	if (dev->driver_data == TPS65224_WD)
> > +		return 0;
> > +
> > +	regulators_node = dev_read_subnode(dev, "regulators");
> > +	if (!ofnode_valid(regulators_node)) {
> > +		debug("%s: %s regulators subnode not found!\n", __func__,
> > +		      dev->name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
> > +
> > +	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
> > +	if (!children)
> > +		printf("%s: %s - no child found\n", __func__, dev->name);
> > +
> > +	/* Probe all the child devices */
> > +	return dm_scan_fdt_dev(dev);
> > +}
> > +
> > +static int stop_watchdog(struct udevice *wd_i2c_dev)
> > +{
> > +	int ret;
> > +
> > +	/* Maintain WD long window */
> > +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_MODE_REG);
> > +	if (ret < 0) {
> > +		debug("failed to read i2c reg (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret &= ~TPS65224_WD_PWRHOLD_MASK;
> > +	ret |= TPS65224_WD_PWRHOLD_MASK;
> 
> Is it a right behavior? After cleared its bit, set again?
> Any reason to do this?
> 
> How about using val and ret as variable to clarify?
> 

Using two variables val and ret will help in readability. Will work on it and repsin.
Thanks for the suggestion!

> 
> > +	ret = dm_i2c_reg_write(wd_i2c_dev, TPS65224_WD_MODE_REG, ret);
> > +	if (ret) {
> > +		debug("%s: %s write WD_PWRHOLD fail!\n", __func__, wd_i2c_dev->name);
> > +		return ret;
> > +	}
> > +
> > +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_MODE_REG);
> > +	if (ret < 0) {
> > +		debug("failed to read back i2c reg (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Disable WD */
> > +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_THR_CFG);
> > +	if (ret < 0) {
> > +		debug("failed to read i2c reg (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret &= ~TPS65224_WD_EN_MASK;
> > +	ret = dm_i2c_reg_write(wd_i2c_dev, TPS65224_WD_THR_CFG, ret);
> > +	if (ret) {
> > +		debug("%s: %s write WD_EN fail!\n", __func__, wd_i2c_dev->name);
> > +		return ret;
> > +	}
> > +
> > +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_THR_CFG);
> > +	if (ret < 0) {
> > +		debug("failed to read back i2c reg (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tps65224_probe(struct udevice *dev)
> > +{
> > +	if (dev->driver_data == TPS65224_WD)
> > +		return stop_watchdog(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct dm_pmic_ops tps65224_ops = {
> > +	.read = tps65224_read,
> > +	.write = tps65224_write,
> > +};
> > +
> > +static const struct udevice_id tps65224_ids[] = {
> > +	{ .compatible = "ti,tps65224", .data = TPS65224 },
> > +	{ .compatible = "ti,tps65224_watchdog",  .data =  TPS65224_WD },
> > +	{ }
> > +};
> > +
> > +U_BOOT_DRIVER(pmic_tps65224) = {
> > +	.name = "tps65224_pmic",
> > +	.id = UCLASS_PMIC,
> > +	.of_match = tps65224_ids,
> > +	.bind = tps65224_bind,
> > +	.probe = tps65224_probe,
> > +	.ops = &tps65224_ops,
> > +};
> > diff --git a/include/power/tps65224.h b/include/power/tps65224.h
> > new file mode 100644
> > index 0000000000..24e91b6a67
> > --- /dev/null
> > +++ b/include/power/tps65224.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * (C) Copyright 2023 Texas Instruments Incorporated, <www.ti.com>
> > + *
> > + */
> > +#ifndef _POWER_TPS65224_H_
> > +#define _POWER_TPS65224_H_
> > +
> > +#define TPS65224                          0x0
> > +#define TPS65224_WD                       0x20
> > +
> > +/* I2C device address for pmic tps65224 */
> > +#define TPS65224_I2C_ADDR                (0x12 >> 1)
> > +#define TPS65224_LDO_NUM                  3
> > +#define TPS65224_BUCK_NUM                 4
> > +
> > +/* Drivers name */
> > +#define TPS65224_LDO_DRIVER              "tps65224_ldo"
> > +#define TPS65224_BUCK_DRIVER             "tps65224_buck"
> > +
> > +#define TPS65224_BUCK_VOLT_MASK           0xFF
> > +#define TPS65224_BUCK1_VOLT_MAX_HEX       0xFD
> > +#define TPS65224_BUCK234_VOLT_MAX_HEX     0x45
> > +#define TPS65224_BUCK_VOLT_MAX            3300000
> > +#define TPS65224_BUCK_MODE_MASK           0x1
> > +
> > +#define TPS65224_LDO_VOLT_MASK            (0x3F << 1)
> > +#define TPS65224_LDO_VOLT_MAX_HEX         0x3A
> > +#define TPS65224_LDO_VOLT_MIN_HEX         0x4
> > +#define TPS65224_LDO1_VOLT_MAX            3300000
> > +#define TPS65224_LDO23_VOLT_MAX           3400000
> > +#define TPS65224_LDO_MODE_MASK            0x1
> > +#define TPS65224_LDO_BYPASS_EN            0x80
> > +#define TP65224_BUCK_CONF_SLEW_MASK       0x3
> > +
> > +/* BYPASS is bit7 of VOUT TPS65224_LDO_BYP_MASK */
> > +#define TPS65224_LDO123_BYP_CONFIG        7
> > +
> > +#define TPS65224_LDO123_VOLT_BYP_MIN      2200000
> > +#define TPS65224_LDO123_VOLT_BYP_MAX      3600000
> > +#define TPS65224_LDO1_VOLT_MIN            1200000
> > +#define TPS65224_LDO23_VOLT_MIN           600000
> > +#define TPS65224_LDO4_VOLT_MIN            1200000
> > +#define TPS65224_LDO1_VSET_MIN            0x0C
> > +#define TPS65224_LDO23_VSET_MIN           0x00
> > +#define TPS65224_LDO123_VSET_MIN          0x0
> > +#define TPS65224_LDO1_VSET_MAX            0x36
> > +#define TPS65224_LDO23_VSET_MAX           0x38
> > +#define TPS65224_LDO123_STEP              50000
> > +#define TPS65224_LDO4_STEP                25000
> > +
> > +#define TPS65224_WD_MODE_REG              0x406
> > +#define TPS65224_WD_PWRHOLD_MASK          BIT(2)
> > +#define TPS65224_WD_THR_CFG               0x409
> > +#define TPS65224_WD_EN_MASK               BIT(6)
> > +
> > +#endif // _POWER_TPS65224_H_
> > --
> > 2.25.1

Regards,
Bhargav
