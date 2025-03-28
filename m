Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775AFC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0508981DCC;
	Fri, 28 Mar 2025 17:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ICqEZdos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835EE8129B; Fri, 28 Mar 2025 16:31:32 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4F1810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rmfrfs@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so17472275e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743175890; x=1743780690; darn=lists.denx.de;
 h=in-reply-to:references:to:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0me0/99Xtr8T7DN6FXjlZtwaMo6pRXHbqrNZnREfjM=;
 b=ICqEZdossbnHrzkeZGWq8DPy/P/n5+TfbjuQBB3JRwXTGi4cLCMvB6PQ/XU6queu37
 1Hckip/uR7oME5htUqXUocdhUcoXLzQW9PFDmpw57WVaWRQsm0nU6M9Grcq067+KbwvJ
 ljGdybaqmvTv++ynY8VLCM7DtCErKz0POgITnSrXGU01ul9QRC1pR9HtPNJZt0DBjqQy
 EwsPKd8S0fPT0llPtxS/WwopnZJD9Y5mBGjP7iqcLKKfkQNrx/iIIVKRcSAtsWVD5NZt
 v+85N+9QF0StTL+Bd+7Yh5gicIEQYJ3u5cw+c8Yrn7BsHjPzrQNNWMfqbxN/WmA7N+X4
 jGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743175890; x=1743780690;
 h=in-reply-to:references:to:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w0me0/99Xtr8T7DN6FXjlZtwaMo6pRXHbqrNZnREfjM=;
 b=ipwe573c5c8hLC0RLyCZ1zDLJAGB5ryIUMP7Jm/lXt86di1jmw5EYl29pXGAcZ2G3k
 nBS5K2D84g9p6o+KUq4UtReWtQNeb4MSVL+b7xjz9pKL8bFG/+Lx9lVGWAsf6vVJ/1xB
 MzmCUsZRDXLUfy0fwIJSBqiQMW1wcfJtNpzTCGzsv3iyQ+H6W4V6VUtn5Cywu8GF16p/
 a0s4d9RtCU/uYpNlCHnSyzjdxqM4BQFkobnA4MeubmtApcRBRDkx1RNN9QAApEb2j1TK
 2blG7X2URuEEN/j6/u23THUjQdWLXLylX1lpcSLIRLe8FaBVYW+bExHsNHSQp8Ntezkh
 Xf5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKGL5NjkQeeAqjW/4trsMflgwMluJKdMLKfGbS4geqw1U30/bhTY0oDdcw172n1yQm7yb2eIA=@lists.denx.de
X-Gm-Message-State: AOJu0YzMS4J2HOGcaQovmbWaVe3Gc0k3Xf0MIp/ObwLld6o1DoiW87Q7
 vCFff+RwJIAHwup9K/ACtlPP+eQ6IYKvFQZSDLgAa3NiknpX5X4SkmWlIw==
X-Gm-Gg: ASbGncsJh2oPMpKXWhVV9KeftFVS/+BchhcbD2F7rRfI2z+a2iwjuXDCY2e9TJpxswj
 s7afxZ6OgJhEbg0e9D1HTtMh6cSR/Fhrr08MgzCFlMlqCl0LgCDJsxV+I4qHj7TDCMj+VP0CTEA
 Omad8G/72ZmRLUClr2YDeYLDm8HuEVf9nPfh5Be3JWO7ooo7sy67mKm8ICPW6NF9GNGo509yhUs
 8mT7RndrUi/4v0nFlPxypctZRgybQd/K/55BrZztxqqbH75l2y9VLmz4a1QI5pz98YpXzzqe8Xa
 VX+5h3bnW0lFj7JTFjG3Tp6h3vtCIAzs5mcgZGPZFb0lJ2L+7LQjkhednpWRPlYLm/q0mQ==
X-Google-Smtp-Source: AGHT+IEkegGQgCaPK84hSWMh6tLT8vkz9dY92V/tEHJ3sqWO5MTxViaRPVK4pQXAsheA91H6z8W+wg==
X-Received: by 2002:a05:6000:1a8e:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39ad1746a82mr7012655f8f.18.1743175889392; 
 Fri, 28 Mar 2025 08:31:29 -0700 (PDT)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39c0b6588e9sm3037038f8f.14.2025.03.28.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:31:28 -0700 (PDT)
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Mar 2025 15:31:27 +0000
Message-Id: <D8S0A3LI0X3C.2GMJQCI29FL36@linaro.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>, "Tom Rini"
 <trini@konsulko.com>
Subject: Re: [PATCH 2/2] power: regulator: add qcom-usb-vbus
To: "Caleb Connolly" <caleb.connolly@linaro.org>, "Rui Miguel Silva"
 <rui.silva@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jaehoon Chung" <jh80.chung@samsung.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
 <20250227094911.497219-3-rui.silva@linaro.org>
 <e0744b83-8b93-49d9-bf4c-bf09aeb08294@linaro.org>
In-Reply-To: <e0744b83-8b93-49d9-bf4c-bf09aeb08294@linaro.org>
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:14:05 +0100
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

Hey Caleb,
On Thu Mar 20, 2025 at 5:34 PM WET, Caleb Connolly wrote:

>
> Jaehoon: do you mind if I just take these both through the Qualcomm tree?
>
> If not then feel free to pick this one up
>
> Acked-by: Caleb Connolly <caleb.connolly@linaro.org>

Maybe it is easier/faster for you to pick this ones, one month passed.
Thanks in advance.

Cheers,
   Rui

>
> On 2/27/25 09:45, Rui Miguel Silva wrote:
>> Add regulator driver that allow some Qualcomm PMIC to
>> feed VBUS output to peripherals that are connected.
>>=20
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>   drivers/power/regulator/Kconfig               |   7 ++
>>   drivers/power/regulator/Makefile              |   1 +
>>   .../power/regulator/qcom_usb_vbus_regulator.c | 111 ++++++++++++++++++
>>   3 files changed, 119 insertions(+)
>>   create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c
>>=20
>> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/K=
config
>> index 958f337c7e73..558133e09bf8 100644
>> --- a/drivers/power/regulator/Kconfig
>> +++ b/drivers/power/regulator/Kconfig
>> @@ -224,6 +224,13 @@ config DM_REGULATOR_QCOM_RPMH
>>   	  implements get/set api for a limited set of regulators used
>>   	  by u-boot.
>>  =20
>> +config DM_REGULATOR_QCOM_USB_VBUS
>> +	bool "Enable driver model for Qualcomm USB vbus regulator"
>> +	depends on DM_REGULATOR
>> +	---help---
>> +	  Enable support for the Qualcomm USB Vbus regulator. The driver
>> +	  implements get/set api for the regulator to be used by u-boot.
>> +
>>   config SPL_DM_REGULATOR_GPIO
>>   	bool "Enable Driver Model for GPIO REGULATOR in SPL"
>>   	depends on DM_REGULATOR_GPIO && SPL_GPIO
>> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/=
Makefile
>> index ca6c89d13b5c..a4191b9302b1 100644
>> --- a/drivers/power/regulator/Makefile
>> +++ b/drivers/power/regulator/Makefile
>> @@ -22,6 +22,7 @@ obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) +=3D regulato=
r_common.o
>>   obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) +=3D fixed.o
>>   obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) +=3D gpio-regulator.o
>>   obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) +=3D qcom-rpmh-regulator.o
>> +obj-$(CONFIG_DM_REGULATOR_QCOM_USB_VBUS) +=3D qcom_usb_vbus_regulator.o
>>   obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) +=3D rk8xx.o
>>   obj-$(CONFIG_DM_REGULATOR_S2MPS11) +=3D s2mps11_regulator.o
>>   obj-$(CONFIG_REGULATOR_S5M8767) +=3D s5m8767.o
>> diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers=
/power/regulator/qcom_usb_vbus_regulator.c
>> new file mode 100644
>> index 000000000000..2d58ef5e111e
>> --- /dev/null
>> +++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
>> @@ -0,0 +1,111 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2025, Linaro Limited
>> + */
>> +#define pr_fmt(fmt) "qcom_usb_vbus: " fmt
>> +
>> +#include <bitfield.h>
>> +#include <errno.h>
>> +#include <dm.h>
>> +#include <fdtdec.h>
>> +#include <log.h>
>> +#include <asm/gpio.h>
>> +#include <linux/bitops.h>
>> +#include <linux/printk.h>
>> +#include <power/pmic.h>
>> +#include <power/regulator.h>
>> +
>> +#define CMD_OTG				0x50
>> +#define OTG_EN				BIT(0)
>> +// The 0 bit in this register's bit field is undocumented
>> +#define OTG_CFG				0x56
>> +#define OTG_EN_SRC_CFG			BIT(1)
>> +
>> +struct qcom_usb_vbus_priv {
>> +	phys_addr_t base;
>> +};
>> +
>> +static int qcom_usb_vbus_regulator_of_to_plat(struct udevice *dev)
>> +{
>> +	struct qcom_usb_vbus_priv *priv =3D dev_get_priv(dev);
>> +
>> +	priv->base =3D dev_read_addr(dev);
>> +	if (priv->base =3D=3D FDT_ADDR_T_NONE)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_usb_vbus_regulator_get_enable(struct udevice *dev)
>> +{
>> +	struct qcom_usb_vbus_priv *priv =3D dev_get_priv(dev);
>> +	int otg_en_reg =3D priv->base + CMD_OTG;
>> +	int ret;
>> +
>> +	ret =3D pmic_reg_read(dev->parent, otg_en_reg);
>> +	if (ret < 0)
>> +		log_err("failed to read usb vbus: %d\n", ret);
>> +	else
>> +		ret &=3D OTG_EN;
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool=
 enable)
>> +{
>> +	struct qcom_usb_vbus_priv *priv =3D dev_get_priv(dev);
>> +	int otg_en_reg =3D priv->base + CMD_OTG;
>> +	int ret;
>> +
>> +	if (enable) {
>> +		ret =3D pmic_clrsetbits(dev->parent, otg_en_reg, 0, OTG_EN);
>> +		if (ret < 0) {
>> +			log_err("error enabling: %d\n", ret);
>> +			return ret;
>> +		}
>> +	} else {
>> +		ret =3D pmic_clrsetbits(dev->parent, otg_en_reg, OTG_EN, 0);
>> +		if (ret < 0) {
>> +			log_err("error disabling: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
>> +{
>> +	struct qcom_usb_vbus_priv *priv =3D dev_get_priv(dev);
>> +	int otg_cfg_reg =3D priv->base + OTG_CFG;
>> +	int ret;
>> +
>> +	/* Disable HW logic for VBUS enable */
>> +	ret =3D pmic_clrsetbits(dev->parent, otg_cfg_reg, OTG_EN_SRC_CFG, 0);
>> +	if (ret < 0) {
>> +		log_err("error setting EN_SRC_CFG: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops =3D {
>> +	.get_enable =3D qcom_usb_vbus_regulator_get_enable,
>> +	.set_enable =3D qcom_usb_vbus_regulator_set_enable,
>> +};
>> +
>> +static const struct udevice_id qcom_usb_vbus_regulator_ids[] =3D {
>> +	{ .compatible =3D "qcom,pm8150b-vbus-reg"},
>> +	{ },
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_usb_vbus_regulator) =3D {
>> +	.name =3D "qcom-usb-vbus-regulator",
>> +	.id =3D UCLASS_REGULATOR,
>> +	.of_match =3D qcom_usb_vbus_regulator_ids,
>> +	.of_to_plat =3D qcom_usb_vbus_regulator_of_to_plat,
>> +	.ops =3D &qcom_usb_vbus_regulator_ops,
>> +	.probe =3D qcom_usb_vbus_regulator_probe,
>> +	.priv_auto =3D sizeof(struct qcom_usb_vbus_priv),
>> +};
>
> --=20
> Caleb (they/them)



