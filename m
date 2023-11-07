Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE2C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 06:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1DD870C8;
	Tue,  7 Nov 2023 07:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="fGctFxtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DD7870D5; Tue,  7 Nov 2023 07:46:04 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7AC8709A
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 07:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231107064558epoutp02751d934782d05c2b953121626d028220~VRFMfjNj-1215212152epoutp02d
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 06:45:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231107064558epoutp02751d934782d05c2b953121626d028220~VRFMfjNj-1215212152epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699339558;
 bh=1htB1ARqNeWxKC1K5ESIjeGwRLEWD6TpWZne8Q1xWTc=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=fGctFxtYXg00PYCbMpoUQBLLu6yUupEx3NM2TZHrIE024uzTus+j7HJpp2cuqNCgb
 rqe71FDvgJzn4tqivL42JwauuVLzD6YggFLKux15P5MFGJC9Sr7p8SD6IcoUw/Qn0W
 ATBQT8TDLUaW9r9TjmcdI/r4t49q3mPIZWdqWbog=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231107064558epcas1p32f0e2511ad5453999e78561e82001755~VRFMUrIVh2038220382epcas1p3M;
 Tue,  7 Nov 2023 06:45:58 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SPdys0byrz4x9QF; Tue,  7 Nov
 2023 06:45:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.CD.19104.42DD9456; Tue,  7 Nov 2023 15:45:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231107064555epcas1p40db7ad36de41404625b57321e03aa421~VRFKYczD82761827618epcas1p4m;
 Tue,  7 Nov 2023 06:45:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231107064555epsmtrp1d0ddecda88f594dabcc958ac5c24681d~VRFKXzttL0260702607epsmtrp1T;
 Tue,  7 Nov 2023 06:45:55 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-d3-6549dd24ca3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.26.18939.32DD9456; Tue,  7 Nov 2023 15:45:55 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231107064555epsmtip1e5019477dd4c923fe4bbfcb7f88c20da~VRFKKUQiQ0555705557epsmtip1Y;
 Tue,  7 Nov 2023 06:45:55 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Bhargav Raviprakash'" <bhargav.r@ltts.com>, <u-boot@lists.denx.de>
In-Reply-To: <053701da1145$9380ac30$ba820490$@samsung.com>
Subject: RE: [PATCH v2 1/2] driver: power: add support for TPS65224
Date: Tue, 7 Nov 2023 15:45:55 +0900
Message-ID: <054901da1146$0ee766c0$2cb63440$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDoU1/lH4y7Dp92Xhc75rc5Jh/3MAEbF6DlAgJ+vuUB9l8CzbIpRY1Q
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmrq7KXc9UgxsX+Sw2zz/IbPF2bye7
 A5PH2Ts7GD2+btrEGsAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCdsf/jCZaCV94V12afYmxgvGvZxcjBISFgIjFpjnwXIxeHkMAeRon/
 v9vYIJxPjBL77txhhXPm/ljH3sXICdZx6fsaqKqdjBJ3n6xnhHBeMkr8+n8KrIpNQE/i/6KF
 zCC2iICHxLn5p9lAbE4BK4k/0+6BxYUFnCWut79iBLFZBFQkVh9eCGbzClhKfP2/EcoWlDg5
 8wkLiM0sIC+x/e0cZogrFCR+Pl3GChEXkZjd2Qa1y01i+uXlLCAHSQgcYpeYfuYWC0SDi8TB
 648YIWxhiVfHt0C9IyXxsr+NHaKhmVFi6ZKDrBBOD6PEv4brbBBVxhL7l05mAgUZs4CmxPpd
 +hBhRYmdv+cyQlzBJ/Huaw8rJFR5JTrahCBKVCQuvX7JBLPr7pP/rBC2h8Sr3xPYJjAqzkLy
 5ywkf85C8tsshMULGFlWMUqlFhTnpqcmGxYY6uallsOjPDk/dxMjOAFq+exg/L7+r94hRiYO
 xkOMEhzMSiK8f+09UoV4UxIrq1KL8uOLSnNSiw8xmgJDfyKzlGhyPjAF55XEG5pYGpiYGRmb
 WBiaGSqJ88Z8ak8REkhPLEnNTk0tSC2C6WPi4JRqYNo1/5K1pWVZnAXjY9d5s14fDPNgUeo9
 8jFp7pKQs475BzsXLH/hvfHw3Ovrz/wv2cM+K/p/sOQ2aUPTLCntbpNGphUbGDzvGkr8+3B/
 z0s/69AnLfrXrBTrjJ8pnvDsq4rm+qJ8aELy3tAe7yX1KwLCnwWyRDt2/Gx1z4yz/dLRLurM
 U77gVuz1o//V1sw41hAVfExohtnJ2urXLR+cbukuZrn6f9npjTN4n/7syuS33s7fdYghm6ny
 wpqAUzefvjAxTdnWpquw9chrydS9bWa6XTsrvZqEUvtYq82trzL5p1Uf6rOdspnj0xLpRVa7
 jz47tCB/o+U7oxlMF3/0TO2oMtAPSXi5TnryhbOr1yixFGckGmoxFxUnAgD2Q9CPCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnK7yXc9Ug0Odhhab5x9ktni7t5Pd
 gcnj7J0djB5fN21iDWCK4rJJSc3JLEst0rdL4MrY//EES8Er74prs08xNjDetexi5OSQEDCR
 uPR9DVsXIxeHkMB2Ron7Tz8xQiSkJD4/nQqU4ACyhSUOHy6GqHnOKLFj6kNWkBo2AT2J/4sW
 MoPYIgJeEp9O9rHBFb3ZeAkswSlgJfFn2j0wW1jAWeJ6+yuwBSwCKhKrDy8Es3kFLCW+/t8I
 ZQtKnJz5hAXEZhbQluh92MoIYctLbH87hxniOAWJn0+XsULERSRmd7ZBHeEmMf3ycpYJjEKz
 kIyahWTULCSjZiFpX8DIsopRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOMC1gnYwLlv/V+8Q
 IxMH4yFGCQ5mJRHev/YeqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtS
 i2CyTBycUg1MGj19x/7ukjn2VfBWsKKy5CIJp/DpJ20fpxo8vXi4x/WXy33zV/Xvjs2MutxQ
 GlZydeqbjz5PV8S7nN7p+eLukqajUz02pmtE63G8qz8XauK41uHt93a/HAfdfQ8Y0r//zzlt
 5WfoFygWM/VgQ8N5ze/HOl3+Oy/Xf+f8b01lfuRPRtled02Ghnv5PM51k+1WXPINU94t9UVu
 y46W9Mfb9ua77Jb2CNP7uUw4QC7g89Sr/foFjZxmjufczp/oushY7LogTrHee0u61PHfFVN2
 r5VR6v/+hutmysYNk9r7pl+/KFFrOi2oVe2/tjFjYMLUHWJvllw++6joRIeM+kKZr0d7/+Yy
 PSz+KNMuXFGjxFKckWioxVxUnAgAfPoTDN8CAAA=
X-CMS-MailID: 20231107064555epcas1p40db7ad36de41404625b57321e03aa421
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231106140734epcas1p2b9ad92cd73265923005a6d75fe6245c9
References: <20231106140712.1780114-1-bhargav.r@ltts.com>
 <CGME20231106140734epcas1p2b9ad92cd73265923005a6d75fe6245c9@epcas1p2.samsung.com>
 <20231106140712.1780114-2-bhargav.r@ltts.com>
 <053701da1145$9380ac30$ba820490$@samsung.com>
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



> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Tuesday, November 7, 2023 3:42 PM
> To: 'Bhargav Raviprakash' <bhargav.r@ltts.com>; u-boot@lists.denx.de
> Subject: RE: [PATCH v2 1/2] driver: power: add support for TPS65224
> 
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

Just mis-reading. Discard above comment.

> 
> How about using val and ret as variable to clarify?
> 
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
> 


