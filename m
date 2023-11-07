Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63577C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 06:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91559867E2;
	Tue,  7 Nov 2023 07:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ic/J8JVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65BB86E05; Tue,  7 Nov 2023 07:42:49 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F568865D0
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 07:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231107064237epoutp0411d00dc542baca377248f707b16f993e~VRCRgNq5r1551415514epoutp04I
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 06:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231107064237epoutp0411d00dc542baca377248f707b16f993e~VRCRgNq5r1551415514epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699339357;
 bh=KXnJsEuTfa/bW5HyOxhA82tOckchhzeqSuCgQLnBm9g=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=ic/J8JVH5F0gjJWSYGu9LiOJblU6+HXZOcI7egiKfLsUb1oORxmYznQJMWTZeU1pa
 l1HXgX/tUqWLGP88xFwQrcWTreJuBBBEme9ONcQKZa1aWNZFof54eyVOzLYfyL1wWr
 a0M8aRlmtMlwmQK8VYhd8+u86xbAfkuW0ep08rEw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231107064237epcas1p2c96b94c60cd5a019a76a1d3833a2545d~VRCRTP9pF0874008740epcas1p2K;
 Tue,  7 Nov 2023 06:42:37 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SPdv01q51z4x9QG; Tue,  7 Nov
 2023 06:42:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 F6.DE.09739.55CD9456; Tue,  7 Nov 2023 15:42:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231107064228epcas1p1e9773beda81cc0266ee4d33104626f04~VRCJfQ8jk0571205712epcas1p1s;
 Tue,  7 Nov 2023 06:42:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231107064228epsmtrp2ce875084ba3bfacd7faf4f3d6a5cdb9a~VRCJexnVt1848818488epsmtrp2m;
 Tue,  7 Nov 2023 06:42:28 +0000 (GMT)
X-AuditID: b6c32a37-487afa800000260b-8f-6549dc5565ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 88.57.07368.45CD9456; Tue,  7 Nov 2023 15:42:28 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231107064228epsmtip2fa8c3263c92afac53c4f9982880b5313~VRCJWQqyF0918809188epsmtip2m;
 Tue,  7 Nov 2023 06:42:28 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Bhargav Raviprakash'" <bhargav.r@ltts.com>, <u-boot@lists.denx.de>
In-Reply-To: <20231106140712.1780114-2-bhargav.r@ltts.com>
Subject: RE: [PATCH v2 1/2] driver: power: add support for TPS65224
Date: Tue, 7 Nov 2023 15:42:28 +0900
Message-ID: <053701da1145$9380ac30$ba820490$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDoU1/lH4y7Dp92Xhc75rc5Jh/3MAEbF6DlAgJ+vuWyOPHjMA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmgW7oHc9Ug/6NLBab5x9ktni7t5Pd
 gcnj7J0djB5fN21iDWCKyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
 tVVy8QnQdcvMAZqvpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdArTswtLs1L
 18tLLbEyNDAwMgUqTMjOeD1lB1vBV5eKA7cVGxjXm3YxcnJICJhIzLp0nRnEFhLYwSix/K5X
 FyMXkP2JUWLP/7MsEM43Rom7y7cywXRsONQGldjLKDHl80JWCOclo8TX/58ZQarYBPQk/i9a
 CDZXRMBD4tz802wgNqeAlcS53mmsILawgLPE9fZXYPUsAioSkxc3g9m8ApYSrQs3MEHYghIn
 Zz5hAbGZBeQltr+dwwxxhYLEz6fLWCHiIhKzO9ugdjlJ/P7VyQZykITAKXaJrwveskI0uEhM
 OziBHcIWlnh1fAuULSXx+d1eqIZmRomlSw6yQjg9jBL/Gq6zQVQZS+xfOhnoJA6gdZoS63fp
 Q4QVJXb+nssIcQWfxLuvPawgJRICvBIdbUIQJSoSl16/ZILZdffJf6h7PCRe/Z7ANoFRcRaS
 P2ch+XMWkt9mISxewMiyilEstaA4Nz212LDAGB7byfm5mxjBaU/LfAfjtLcf9A4xMnEwHmKU
 4GBWEuH9a++RKsSbklhZlVqUH19UmpNafIjRFBjyE5mlRJPzgYk3ryTe0MTSwMTMyNjEwtDM
 UEmc99az3hQhgfTEktTs1NSC1CKYPiYOTqkGplaDeUf/puUZnciapzbjwEajv13GPsH9beaS
 izUPWvlFFPmuOBe3uThSXmxeY2LH7yMTzb6nzP5fcHPyjdiKA39fX/jiURqzS2r7Xr2oUysk
 ldg+STdW7WfVuZ75W1N1v1fxnuj2vXurd+T7ye+Zl3zvgkdvqdzuSB5BhUOTNrR4Tp3c1W3+
 4MwSVsft/p8qHoTnHjBI9WZTuMTnnXn5+HSPZxFmgTvKnqy+wH64xej1zPMH2LaclZZLfj/9
 zsWHW25o3c9pe7LW4nx5AdMqF61TRuGb50TIzeS+wrptkp/HnqdaN0NKkhc5XMzS+JOz6/6K
 k1q7jnv6XD19OKQj9RZDcDqHrQ23UXhp5LfpR5VYijMSDbWYi4oTAeOP9CwEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvG7IHc9Ugw8r9Sw2zz/IbPF2bye7
 A5PH2Ts7GD2+btrEGsAUxWWTkpqTWZZapG+XwJXxesoOtoKvLhUHbis2MK437WLk5JAQMJHY
 cKiNBcQWEtjNKHGqiw0iLiXx+elUIJsDyBaWOHy4uIuRC6jkOaPEz5OrmEFq2AT0JP4vWghm
 iwh4SXw62ccGUbSTUeLD5O+sIAlOASuJc73TwGxhAWeJ6+2vGEFsFgEVicmLm8FsXgFLidaF
 G5ggbEGJkzOfgB3ELKAt0fuwlRHClpfY/nYOM8RxChI/ny5jhYiLSMzubIM6wkni969OtgmM
 QrOQjJqFZNQsJKNmIWlfwMiyilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/dxMjOMi1NHYw
 3pv/T+8QIxMH4yFGCQ5mJRHev/YeqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8s
 Sc1OTS1ILYLJMnFwSjUwyUSxrHouPm39/9vTDlVr3w3pVdwc1L9jorR5mMgWq0laF9Il2Th9
 JMSaL4hvEd1SP/9Hi2L/19Zmy+W2An/muC088nfa7NKzC6rUpzFfMlQ88M/mVIzkIvNbRk8f
 9LEctJU/e/LJd71GwS33j9ozSM12WPS56WqEytHK4qDaPW8rVf1KKoMWPT/ytOrQzqldTn7u
 mwVOvbl0Yn8VQ8gZ1QaBtAuOQVL7DvmZBxzjOTN7jqPXQ3bFk9uFXtta/AvJVeMWSrqufBto
 koBA++dDW429z5mfOqUl8dzzJIv+n1nse8Kmy4jtaFbu/+J742U+45dljtH7GDh6OfgZzvP3
 M2f2KtVV+8suyFydekqJpTgj0VCLuag4EQALFfIc4QIAAA==
X-CMS-MailID: 20231107064228epcas1p1e9773beda81cc0266ee4d33104626f04
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

Hi Bhargav,

> -----Original Message-----
> From: Bhargav Raviprakash <bhargav.r@ltts.com>
> Sent: Monday, November 6, 2023 11:07 PM
> To: u-boot@lists.denx.de
> Cc: jh80.chung@samsung.com; Bhargav Raviprakash <bhargav.r@ltts.com>
> Subject: [PATCH v2 1/2] driver: power: add support for TPS65224
> 
> Added support for PMIC TPS65224. Includes driver for pmic,
> and disabling Watchdog.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  drivers/power/pmic/Kconfig    |   6 ++
>  drivers/power/pmic/Makefile   |   1 +
>  drivers/power/pmic/tps65224.c | 141 ++++++++++++++++++++++++++++++++++
>  include/power/tps65224.h      |  57 ++++++++++++++
>  4 files changed, 205 insertions(+)
>  create mode 100644 drivers/power/pmic/tps65224.c
>  create mode 100644 include/power/tps65224.h
> 
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 4a6f0ce093..b06bd31823 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -378,6 +378,12 @@ config PMIC_TPS65941
>  	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
>  	This driver binds the pmic children.
> 
> +config PMIC_TPS65224
> +	bool "Enable driver for Texas Instruments TPS65224 PMIC"
> +	help
> +	The TPS65224 is a PMIC containing a bunch of SMPS & LDOs.
> +	This driver binds the pmic children.
> +
>  config PMIC_TPS65219
>  	bool "Enable driver for Texas Instruments TPS65219 PMIC"
>  	depends on DM_PMIC
> diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
> index 0b3b3d62d0..cec16e57d3 100644
> --- a/drivers/power/pmic/Makefile
> +++ b/drivers/power/pmic/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
>  obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
>  obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
>  obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
> +obj-$(CONFIG_PMIC_TPS65224) += tps65224.o

Ordering this. Maybe it can be located at tps65941.o.

>  obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
> 
>  ifeq ($(CONFIG_$(SPL_)POWER_LEGACY),y)
> diff --git a/drivers/power/pmic/tps65224.c b/drivers/power/pmic/tps65224.c
> new file mode 100644
> index 0000000000..33395f6edf
> --- /dev/null
> +++ b/drivers/power/pmic/tps65224.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 Texas Instruments Incorporated, <www.ti.com>
> + */
> +#include <fdtdec.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <i2c.h>
> +#include <log.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +#include <power/tps65224.h>
> +#include <dm/device.h>
> +
> +static const struct pmic_child_info pmic_children_info[] = {
> +	{ .prefix = "ldo", .driver = TPS65224_LDO_DRIVER },
> +	{ .prefix = "buck", .driver = TPS65224_BUCK_DRIVER },
> +	{ },
> +};
> +
> +static int tps65224_write(struct udevice *dev, uint reg, const uint8_t *buff,
> +			  int len)
> +{
> +	if (dm_i2c_write(dev, reg, buff, len)) {
> +		pr_err("write error to device: %p register: %#x!\n", dev, reg);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65224_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
> +{
> +	if (dm_i2c_read(dev, reg, buff, len)) {
> +		pr_err("read error from device: %p register: %#x!\n", dev, reg);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65224_bind(struct udevice *dev)
> +{
> +	ofnode regulators_node;
> +	int children;
> +
> +	if (dev->driver_data == TPS65224_WD)
> +		return 0;
> +
> +	regulators_node = dev_read_subnode(dev, "regulators");
> +	if (!ofnode_valid(regulators_node)) {
> +		debug("%s: %s regulators subnode not found!\n", __func__,
> +		      dev->name);
> +		return -ENXIO;
> +	}
> +
> +	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
> +
> +	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
> +	if (!children)
> +		printf("%s: %s - no child found\n", __func__, dev->name);
> +
> +	/* Probe all the child devices */
> +	return dm_scan_fdt_dev(dev);
> +}
> +
> +static int stop_watchdog(struct udevice *wd_i2c_dev)
> +{
> +	int ret;
> +
> +	/* Maintain WD long window */
> +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_MODE_REG);
> +	if (ret < 0) {
> +		debug("failed to read i2c reg (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret &= ~TPS65224_WD_PWRHOLD_MASK;
> +	ret |= TPS65224_WD_PWRHOLD_MASK;

Is it a right behavior? After cleared its bit, set again?
Any reason to do this?

How about using val and ret as variable to clarify?


> +	ret = dm_i2c_reg_write(wd_i2c_dev, TPS65224_WD_MODE_REG, ret);
> +	if (ret) {
> +		debug("%s: %s write WD_PWRHOLD fail!\n", __func__, wd_i2c_dev->name);
> +		return ret;
> +	}
> +
> +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_MODE_REG);
> +	if (ret < 0) {
> +		debug("failed to read back i2c reg (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Disable WD */
> +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_THR_CFG);
> +	if (ret < 0) {
> +		debug("failed to read i2c reg (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret &= ~TPS65224_WD_EN_MASK;
> +	ret = dm_i2c_reg_write(wd_i2c_dev, TPS65224_WD_THR_CFG, ret);
> +	if (ret) {
> +		debug("%s: %s write WD_EN fail!\n", __func__, wd_i2c_dev->name);
> +		return ret;
> +	}
> +
> +	ret = dm_i2c_reg_read(wd_i2c_dev, TPS65224_WD_THR_CFG);
> +	if (ret < 0) {
> +		debug("failed to read back i2c reg (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65224_probe(struct udevice *dev)
> +{
> +	if (dev->driver_data == TPS65224_WD)
> +		return stop_watchdog(dev);
> +
> +	return 0;
> +}
> +
> +static struct dm_pmic_ops tps65224_ops = {
> +	.read = tps65224_read,
> +	.write = tps65224_write,
> +};
> +
> +static const struct udevice_id tps65224_ids[] = {
> +	{ .compatible = "ti,tps65224", .data = TPS65224 },
> +	{ .compatible = "ti,tps65224_watchdog",  .data =  TPS65224_WD },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pmic_tps65224) = {
> +	.name = "tps65224_pmic",
> +	.id = UCLASS_PMIC,
> +	.of_match = tps65224_ids,
> +	.bind = tps65224_bind,
> +	.probe = tps65224_probe,
> +	.ops = &tps65224_ops,
> +};
> diff --git a/include/power/tps65224.h b/include/power/tps65224.h
> new file mode 100644
> index 0000000000..24e91b6a67
> --- /dev/null
> +++ b/include/power/tps65224.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2023 Texas Instruments Incorporated, <www.ti.com>
> + *
> + */
> +#ifndef _POWER_TPS65224_H_
> +#define _POWER_TPS65224_H_
> +
> +#define TPS65224                          0x0
> +#define TPS65224_WD                       0x20
> +
> +/* I2C device address for pmic tps65224 */
> +#define TPS65224_I2C_ADDR                (0x12 >> 1)
> +#define TPS65224_LDO_NUM                  3
> +#define TPS65224_BUCK_NUM                 4
> +
> +/* Drivers name */
> +#define TPS65224_LDO_DRIVER              "tps65224_ldo"
> +#define TPS65224_BUCK_DRIVER             "tps65224_buck"
> +
> +#define TPS65224_BUCK_VOLT_MASK           0xFF
> +#define TPS65224_BUCK1_VOLT_MAX_HEX       0xFD
> +#define TPS65224_BUCK234_VOLT_MAX_HEX     0x45
> +#define TPS65224_BUCK_VOLT_MAX            3300000
> +#define TPS65224_BUCK_MODE_MASK           0x1
> +
> +#define TPS65224_LDO_VOLT_MASK            (0x3F << 1)
> +#define TPS65224_LDO_VOLT_MAX_HEX         0x3A
> +#define TPS65224_LDO_VOLT_MIN_HEX         0x4
> +#define TPS65224_LDO1_VOLT_MAX            3300000
> +#define TPS65224_LDO23_VOLT_MAX           3400000
> +#define TPS65224_LDO_MODE_MASK            0x1
> +#define TPS65224_LDO_BYPASS_EN            0x80
> +#define TP65224_BUCK_CONF_SLEW_MASK       0x3
> +
> +/* BYPASS is bit7 of VOUT TPS65224_LDO_BYP_MASK */
> +#define TPS65224_LDO123_BYP_CONFIG        7
> +
> +#define TPS65224_LDO123_VOLT_BYP_MIN      2200000
> +#define TPS65224_LDO123_VOLT_BYP_MAX      3600000
> +#define TPS65224_LDO1_VOLT_MIN            1200000
> +#define TPS65224_LDO23_VOLT_MIN           600000
> +#define TPS65224_LDO4_VOLT_MIN            1200000
> +#define TPS65224_LDO1_VSET_MIN            0x0C
> +#define TPS65224_LDO23_VSET_MIN           0x00
> +#define TPS65224_LDO123_VSET_MIN          0x0
> +#define TPS65224_LDO1_VSET_MAX            0x36
> +#define TPS65224_LDO23_VSET_MAX           0x38
> +#define TPS65224_LDO123_STEP              50000
> +#define TPS65224_LDO4_STEP                25000
> +
> +#define TPS65224_WD_MODE_REG              0x406
> +#define TPS65224_WD_PWRHOLD_MASK          BIT(2)
> +#define TPS65224_WD_THR_CFG               0x409
> +#define TPS65224_WD_EN_MASK               BIT(6)
> +
> +#endif // _POWER_TPS65224_H_
> --
> 2.25.1


