Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2618EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B09087506;
	Tue, 31 Oct 2023 09:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BrHvHo9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824B387576; Tue, 31 Oct 2023 09:57:30 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0085086FBC
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031085725epoutp037f45b4f5a1d47aaefa846aa1dd0dbfe3~TJW_rLyTd2960529605epoutp03l
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:57:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031085725epoutp037f45b4f5a1d47aaefa846aa1dd0dbfe3~TJW_rLyTd2960529605epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698742646;
 bh=f3e6P0JaxBbs3nZN97zWuxKEXB15pUvHRX77Jm/BIbs=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=BrHvHo9OBKQs+D0IP8RHy0bCcD9fUUUtr9vpVsiMDkMf0qIZm8bWqpAHizPvaYBXu
 Qy9mb7KFgPyFPYc+N8JZhH0DVUYw8AazVuAC8nnh33tKtE1QyaiPANggXgro7Q3Vvr
 XfZlbVht31FdYbBJJvSRBde3NCUJ9k6t8Q/uVEgc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231031085725epcas1p120e588f9d2f21e408123f9a8fff55cf9~TJW_RB84-2184121841epcas1p1w;
 Tue, 31 Oct 2023 08:57:25 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKPCm1Ngxz4x9Q2; Tue, 31 Oct
 2023 08:57:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 45.9B.10211.471C0456; Tue, 31 Oct 2023 17:57:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031085723epcas1p23f9e02dbc005949d1d88565ef40cef7c~TJW8nS6Na1454214542epcas1p2r;
 Tue, 31 Oct 2023 08:57:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031085723epsmtrp199d460c1ee1fc52e275c75bb34f50828~TJW8mq2Gy2697726977epsmtrp1P;
 Tue, 31 Oct 2023 08:57:23 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-ca-6540c174c3e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.1F.08755.371C0456; Tue, 31 Oct 2023 17:57:23 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031085723epsmtip2eb79f69336e3b0516d79a31f2f9937f9~TJW8a-x2g0183001830epsmtip2Y;
 Tue, 31 Oct 2023 08:57:23 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20231027082615.306943-4-clamor95@gmail.com>
Subject: RE: [PATCH v9 3/8] power: pmic: add the base MAX77663 PMIC support
Date: Tue, 31 Oct 2023 17:57:23 +0900
Message-ID: <008a01da0bd8$43960e80$cac22b80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLxkJu7998OOQM6zGAUNVB6NFUBswHNQ1RBAob7R+yuEezJMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTX7fkoEOqQdcxDosD/b2MFt+2bGO0
 mDppM7vF272d7A4sHrMbLrJ47Jx1l93j1YFV7B5n7+xgDGCJyrbJSE1MSS1SSM1Lzk/JzEu3
 VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqppFCWmFMKFApILC5W0rezKcovLUlV
 yMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjO+HltHnPBDPeKv/tmMzYwtlt2
 MXJySAiYSCyY8JCpi5GLQ0hgB6PE543z2SCcT4wSP/bchcp8Y5T49XoWC0zL1Q9tUIm9jBLT
 fk5jgXBeMkrsPNbBDFLFJqAn8X/RQjBbRKBMYmnXWiYQm1lASqLp5C5GEJtTwFKiYfduNhBb
 WMBbYsflq2BxFgFViSmXVgEN5eDgBao5NkEWJMwrIChxcuYTFogx8hLb385hhjhIQeLn02Ws
 EKucJD5seswOUSMiMbuzjRnkNgmBv+wS/59uYoNocJF49OYKE4QtLPHq+BZ2CFtK4mV/GztE
 QzOjxNIlB1khnB5GiX8N16G6jSX2L53MBHIds4CmxPpd+hBhRYmdv+cyQmzmk3j3tYcVpERC
 gFeio00IokRF4tLrl0wwu+4++c86gVFpFpLfZiH5bRaSH2YhLFvAyLKKUSy1oDg3PbXYsMAE
 Ht3J+bmbGMEJUstiB+Pctx/0DjEycTAeYpTgYFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iNEU
 GNgTmaVEk/OBKTqvJN7QxNLAxMzI2MTC0MxQSZz32KveFCGB9MSS1OzU1ILUIpg+Jg5OqQYm
 57nTmm11Wy4d7peyFMy4uuv80305fo//OCVd/PfsqvXpdXH2sqtsbDbPOzR7t62A8OFvcb1S
 n988FXnwP1jhufDkTecyA9gcCluieubfWG2wZdfpBQv++1u/KT7WXnXGbeWvBVrT+k8Lzzhx
 fE7NhtYfK2cZnN9nEsBwJOulYltw59TN3BFnY3YHyOR//hhmlSu09ZSWjPvzFetT/slOc7nY
 eNJDbfNKtmuuKX7ns7srq35PiV+4o091lfTOT91Jrd7KjakTlqb+6X17YLt0w2xBxTUT0wUX
 HZnbvbvlEEvObrmtlrzhVl+0D7x8pqlp+j/yxuULfW8uTN9/V+tLcftXPd7sa2yShtZHFIW+
 RSixFGckGmoxFxUnAgCQ6+iWGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvG7xQYdUg1urNS0O9PcyWnzbso3R
 YuqkzewWb/d2sjuweMxuuMjisXPWXXaPVwdWsXucvbODMYAlissmJTUnsyy1SN8ugSvj57V5
 zAUz3Cv+7pvN2MDYbtnFyMkhIWAicfVDG1MXIxeHkMBuRomWhY/YIRJSEp+fTmXrYuQAsoUl
 Dh8uhqh5zihxrOceE0gNm4CexP9FC5lBbBGBCok5/R/ZQGxmoN6mk7sYIRq2M0pcWnMfbCin
 gKVEw+7dYEXCAt4SOy5fZQSxWQRUJaZcWsUCsowXqObYBFmQMK+AoMTJmU/AwsxAu9o2MkKM
 l5fY/nYOM8SZChI/ny5jhTjBSeLDpsfsEDUiErM725gnMArPQjJpFsKkWUgmzULSsYCRZRWj
 ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCMaGnuYNy+6oPeIUYmDsZDjBIczEoivIdN
 HVKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MKkpK65b
 e0NKUj7xh/+3iv45iYdOxZgKL5c68n3PVkZ5rWLliQmXZvblKTVv+RGx8nRBQeiHn2/4JrSt
 LTBmKj1VtLR+ttqeGyJrrz/d47vjaVzJanGzV7K3dkfyK1bxz6l/zmv3R+wcG2d3p3qiyZOF
 y5efEYr/651Ud8Pu8ma1SamO/nd6LxvlRjsoyBtJfek6JvNGUL/8o+crbtM6nW1ycsWrl2k1
 fxGokDc98Cmy/Mp119js6XsOsGed+CSi+O/y9Ds/2eO7P5i5fDI/8UFj8h3j7CVWmVwXDddN
 MJNaZDR1mqDevBXzlf9nXf94ccWEawXPZmTYNoksZts0NfR22co5tzINDyyXuMuT9F+JpTgj
 0VCLuag4EQDsCmiBAAMAAA==
X-CMS-MailID: 20231031085723epcas1p23f9e02dbc005949d1d88565ef40cef7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231027082635epcas1p4722707057e584787327a0b2bd5fb7df0
References: <20231027082615.306943-1-clamor95@gmail.com>
 <CGME20231027082635epcas1p4722707057e584787327a0b2bd5fb7df0@epcas1p4.samsung.com>
 <20231027082615.306943-4-clamor95@gmail.com>
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
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Friday, October 27, 2023 5:26 PM
> To: Tom Rini <trini@konsulko.com>; Jaehoon Chung <jh80.chung@samsung.com>; Simon Glass
> <sjg@chromium.org>; Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: u-boot@lists.denx.de
> Subject: [PATCH v9 3/8] power: pmic: add the base MAX77663 PMIC support
> 
> Add support to bind the regulators/child nodes with the pmic.
> Also adds the pmic i2c based read/write functions to access pmic
> registers.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Just add a minor comment at below.

> ---
>  doc/device-tree-bindings/pmic/max77663.txt | 84 ++++++++++++++++++++++
>  drivers/power/pmic/Kconfig                 |  9 +++
>  drivers/power/pmic/Makefile                |  1 +
>  drivers/power/pmic/max77663.c              | 81 +++++++++++++++++++++
>  include/power/max77663.h                   | 42 +++++++++++
>  5 files changed, 217 insertions(+)
>  create mode 100644 doc/device-tree-bindings/pmic/max77663.txt
>  create mode 100644 drivers/power/pmic/max77663.c
>  create mode 100644 include/power/max77663.h
> 
> diff --git a/doc/device-tree-bindings/pmic/max77663.txt b/doc/device-tree-bindings/pmic/max77663.txt
> new file mode 100644
> index 0000000000..ddb7d3eb14
> --- /dev/null
> +++ b/doc/device-tree-bindings/pmic/max77663.txt
> @@ -0,0 +1,84 @@
> +MAXIM, MAX77663 PMIC
> +
> +This device uses two drivers:
> +- drivers/power/pmic/max77663.c (for parent device)
> +- drivers/power/regulator/max77663_regulator.c (for child regulators)
> +
> +This chapter describes the binding info for the PMIC driver and regulators.
> +
> +Required properties for PMIC:
> +- compatible: "maxim,max77663"
> +- reg: usually 0x1c or 0x3c
> +
> +With those two properties, the pmic device can be used for read/write only.
> +To bind each regulator, the optional regulators subnode should exists.
> +
> +Optional subnode:
> +- name: regulators (subnode list of each device's regulator)
> +
> +Regulators subnode contains set on supported regulators.
> +
> +Required properties:
> +- regulator-name: used for regulator uclass platform data '.name',
> +
> +List of supported regulator nodes names for max77663:
> +- sd0, sd1, sd2, sd3, ldo0, ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldo8
> +
> +Optional:
> +- regulator-min-microvolt: minimum allowed Voltage to set
> +- regulator-max-microvolt: minimum allowed Voltage to set
> +- regulator-always-on: regulator should be never disabled
> +- regulator-boot-on: regulator should be enabled by the bootloader
> +
> +Linux driver binding for this driver is compatible.
> +
> +Example:
> +
> +max77663@1c {
> +	compatible = "maxim,max77663";
> +	reg = <0x1c>;
> +
> +	regulators {
> +		sd0 {
> +			regulator-name = "vdd_cpu";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1250000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		...
> +
> +		ldo0 {
> +			regulator-name = "avdd_pll";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		...
> +
> +		ldo2 {
> +			regulator-name = "avdd_usb";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo3 {
> +			regulator-name = "vdd_sdmmc3";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		...
> +
> +		ldo8 {
> +			regulator-name = "avdd_dsi_csi";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +	};
> +};
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 4a6f0ce093..54665d7e2b 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -184,6 +184,15 @@ config SPL_DM_PMIC_PFUZE100
>  	This config enables implementation of driver-model pmic uclass features
>  	for PMIC PFUZE100 in SPL. The driver implements read/write operations.
> 
> +config DM_PMIC_MAX77663
> +	bool "Enable Driver Model for PMIC MAX77663"
> +	---help---
> +	This config enables implementation of driver-model pmic uclass features
> +	for PMIC MAX77663. The driver implements read/write operations.
> +	This is a Power Management IC with a decent set of peripherals from which
> +	4 DC-to-DC Step-Down (SD) Regulators, 9 Low-Dropout Linear (LDO) Regulators,
> +	8 GPIOs, Real-Time Clock (RTC) and more with I2C Compatible Interface.
> +
>  config DM_PMIC_MAX77686
>  	bool "Enable Driver Model for PMIC MAX77686"
>  	---help---
> diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
> index 0b3b3d62d0..414a9d8225 100644
> --- a/drivers/power/pmic/Makefile
> +++ b/drivers/power/pmic/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_$(SPL_TPL_)DM_PMIC) += pmic-uclass.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_FAN53555) += fan53555.o
>  obj-$(CONFIG_$(SPL_)DM_PMIC_DA9063) += da9063.o
> +obj-$(CONFIG_$(SPL_)DM_PMIC_MAX77663) += max77663.o
>  obj-$(CONFIG_DM_PMIC_MAX77686) += max77686.o
>  obj-$(CONFIG_DM_PMIC_MAX8998) += max8998.o
>  obj-$(CONFIG_DM_PMIC_MC34708) += mc34708.o
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
> new file mode 100644
> index 0000000000..fac97ed221
> --- /dev/null
> +++ b/drivers/power/pmic/max77663.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <power/pmic.h>
> +#include <power/max77663.h>
> +
> +static const struct pmic_child_info pmic_children_info[] = {
> +	{ .prefix = "ldo", .driver = MAX77663_LDO_DRIVER },
> +	{ .prefix = "sd", .driver = MAX77663_SD_DRIVER },
> +	{ },
> +};
> +
> +static int max77663_write(struct udevice *dev, uint reg, const uint8_t *buff,
> +			  int len)
> +{
> +	int ret;
> +
> +	ret = dm_i2c_write(dev, reg, buff, len);
> +	if (ret) {
> +		log_debug("write error to device: %p register: %#x!\n", dev, reg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77663_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
> +{
> +	int ret;
> +
> +	ret = dm_i2c_read(dev, reg, buff, len);
> +	if (ret) {
> +		log_debug("read error from device: %p register: %#x!\n", dev, reg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77663_bind(struct udevice *dev)
> +{
> +	ofnode regulators_node;
> +	int children;
> +
> +	regulators_node = dev_read_subnode(dev, "regulators");
> +	if (!ofnode_valid(regulators_node)) {
> +		log_err("%s regulators subnode not found!\n", dev->name);
> +		return -ENXIO;
> +	}
> +
> +	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
> +
> +	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
> +	if (!children)
> +		log_err("%s - no child found\n", dev->name);
> +
> +	/* Always return success for this device */
> +	return 0;
> +}
> +
> +static struct dm_pmic_ops max77663_ops = {
> +	.read = max77663_read,
> +	.write = max77663_write,
> +};
> +
> +static const struct udevice_id max77663_ids[] = {
> +	{ .compatible = "maxim,max77663" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pmic_max77663) = {
> +	.name = "max77663_pmic",
> +	.id = UCLASS_PMIC,
> +	.of_match = max77663_ids,
> +	.bind = max77663_bind,
> +	.ops = &max77663_ops,
> +};
> diff --git a/include/power/max77663.h b/include/power/max77663.h
> new file mode 100644
> index 0000000000..0f764bcbcc
> --- /dev/null
> +++ b/include/power/max77663.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#ifndef _MAX77663_H_
> +#define _MAX77663_H_
> +
> +#define MAX77663_LDO_NUM		9
> +#define MAX77663_SD_NUM			5
> +
> +/* Drivers name */
> +#define MAX77663_LDO_DRIVER		"max77663_ldo"
> +#define MAX77663_SD_DRIVER		"max77663_sd"
> +
> +/* Step-Down (SD) Regulator calculations */
> +#define SD_STATUS_MASK			0x30
> +
> +#define SD0_VOLT_MAX_HEX		0x40
> +#define SD1_VOLT_MAX_HEX		0x4c
> +#define SD_VOLT_MAX_HEX			0xff
> +#define SD_VOLT_MIN_HEX			0x02
> +
> +#define SD0_VOLT_MAX			1400000
> +#define SD1_VOLT_MAX			1550000
> +#define SD_VOLT_MAX			3787500
> +#define SD_VOLT_MIN			625000
> +
> +#define SD_VOLT_BASE			600000
> +
> +/* Low-Dropout Linear (LDO) Regulator calculations */
> +#define LDO_STATUS_MASK			0xc0
> +#define LDO_VOLT_MASK			0x3f
> +#define LDO_VOLT_MAX_HEX		0x3f
> +
> +#define LDO01_VOLT_MAX			2375000

Does it mean ldo0~1 or only ldo1?

> +#define LDO4_VOLT_MAX			1587500
> +#define LDO_VOLT_MAX			3950000
> +
> +#define LDO_VOLT_BASE			800000
> +
> +#endif /* _MAX77663_H_ */
> --
> 2.39.2


