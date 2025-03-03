Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEDEC282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 15:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D62D811B2;
	Mon,  3 Mar 2025 16:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtAAT79Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDA6811DF; Mon,  3 Mar 2025 16:05:36 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A3480C93
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 16:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abffb7b9619so162761766b.0
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741014333; x=1741619133; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8PDSb3h/jTp9Ophn4OPhwAyR5MhDhRE67lw+a2FEcrU=;
 b=MtAAT79Z7GxfbGHLaRwytpUMy2sWAOlXd6AQHx9DciOU2AywgNMv6yyXBxxUKQSNj/
 6PtOpwThCWhIYtkXkGUwy8l5PrbfNgja4z2NRuKkMBI0ge8xg70qPtRTNEaQTlYbis8W
 hJ2HJ0nE23Ed0pia3ED9HnNl1Zm1GwoCQ6g2z5sKt+ChnT7JAEAaj3ps2QNfPOwk/1Mu
 GuTgwNNY027g1lqR2a95XAC4HHrCVKWxsAx9XvPphTBmz7icRzCRv56ZaDrix0SdojtA
 jb1Pti/4az+gzso2D9gVcMiQxoqyEnkpWdPipf0EezZBuGoQaL0G7Ut9vxs7m5/iRLRR
 uWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741014333; x=1741619133;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8PDSb3h/jTp9Ophn4OPhwAyR5MhDhRE67lw+a2FEcrU=;
 b=Da1/at0j/9PxdO+TTtaJeAOcPNYSqh0OYfEp3WEqEd3n+Dkr4UVEQLfiVIXNORwNPD
 IcUhyk1ns5F66NYKSzwTpQVdDordb+2LPHl9uW+JqqM0eCyWEjRc2RGCuXhDvYfGIzZ+
 /PcDMvMQDdIPm2sYtbY6tlbkJTaWqLRs3Z6MQDV+Wtjb4o8PT+/QvR8Mv3zRjRQPJqdG
 J/hSh+LB9Z5P3T1sSEOz0LI6x48UQdcOdruUMM55fVclA09nH7jFhGIuWmltEC4zbKUo
 z+lP44/q1M8YdVWvKwfFXtigtmBIOY5dPxc60dP4mex9HjuIfuH+R8SImqTMYZAbOHHk
 dnLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd9dRGVhqz7NhEEI3JamGCPsy7dz0qEg0Sf9XOdWkDoxTsNNMD37UtEMICwle+Kyf4hMiZLEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxRvJbohnq9X9PVTDmyzdzQh0vO5VpQSz6EFgGbb3hVdsBPSiKL
 Yi4UMEIi1iQLv3a5Ir+8C8ya9IEiper56UWYEAFY5WBe8tJ8JWLhZ7tUI65IbeJpVQPz6wSXMFU
 8
X-Gm-Gg: ASbGncv8mt7kh94R+QaqHHucVR0w4ckTF2rmlUqJpYQXS1yVNohxC8eMgmBp0XL8r6z
 U0DizXVxUaHYbjowlk2/lhIHLRM6MOeS6HULgIoyFCucBvWl5aGTr8Z/aQYJMJVkFVrxItbmQP5
 ADQrBvhbSK7IX1VfTXyu/wqjtr0orr0nx+fkqgMLPh8fC8l2R7F5how9/ess3u42PxX4cZfC4kP
 eMz8g3kIsiMks1gdu8mRKiLn/uYVYtRlc3IIVhipxbcwpgYlRw1pS4eKaCyNnOXhu/mE7A4JwIA
 fhllRD6/44h8wUj9d5rKRduyAL3r2m5MP756nLmaCX8TjXkkalibVFY/V3l9yU2P3oafzG418xi
 kL9F+J/s8N7bLn+QBi+MRaQ==
X-Google-Smtp-Source: AGHT+IEZK7GWb2IP/0bAl0jWnJN0kEJSLGUlGliAeYflA5FhcZ4Rtb386WoCrAXPUb0iY98Opl72nQ==
X-Received: by 2002:a17:907:6d0c:b0:ac1:415b:86f0 with SMTP id
 a640c23a62f3a-ac1415b8cacmr306839266b.13.1741014332757; 
 Mon, 03 Mar 2025 07:05:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015?
 ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e917b70asm38474166b.151.2025.03.03.07.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 07:05:32 -0800 (PST)
Message-ID: <76baafad-d2bf-4fc4-8858-3c335dde8ee6@linaro.org>
Date: Mon, 3 Mar 2025 16:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] power: regulator: add qcom-usb-vbus
To: Rui Miguel Silva <rui.silva@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
 <20250227094911.497219-3-rui.silva@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250227094911.497219-3-rui.silva@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 27/02/2025 10:45, Rui Miguel Silva wrote:
> Add regulator driver that allow some Qualcomm PMIC to
> feed VBUS output to peripherals that are connected.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>   drivers/power/regulator/Kconfig               |   7 ++
>   drivers/power/regulator/Makefile              |   1 +
>   .../power/regulator/qcom_usb_vbus_regulator.c | 111 ++++++++++++++++++
>   3 files changed, 119 insertions(+)
>   create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 958f337c7e73..558133e09bf8 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -224,6 +224,13 @@ config DM_REGULATOR_QCOM_RPMH
>   	  implements get/set api for a limited set of regulators used
>   	  by u-boot.
>   
> +config DM_REGULATOR_QCOM_USB_VBUS
> +	bool "Enable driver model for Qualcomm USB vbus regulator"
> +	depends on DM_REGULATOR
> +	---help---
> +	  Enable support for the Qualcomm USB Vbus regulator. The driver
> +	  implements get/set api for the regulator to be used by u-boot.
> +
>   config SPL_DM_REGULATOR_GPIO
>   	bool "Enable Driver Model for GPIO REGULATOR in SPL"
>   	depends on DM_REGULATOR_GPIO && SPL_GPIO
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
> index ca6c89d13b5c..a4191b9302b1 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_$(XPL_)DM_REGULATOR_COMMON) += regulator_common.o
>   obj-$(CONFIG_$(XPL_)DM_REGULATOR_FIXED) += fixed.o
>   obj-$(CONFIG_$(XPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
>   obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
> +obj-$(CONFIG_DM_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus_regulator.o
>   obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
>   obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
>   obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
> diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers/power/regulator/qcom_usb_vbus_regulator.c
> new file mode 100644
> index 000000000000..2d58ef5e111e
> --- /dev/null
> +++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Linaro Limited
> + */
> +#define pr_fmt(fmt) "qcom_usb_vbus: " fmt
> +
> +#include <bitfield.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <log.h>
> +#include <asm/gpio.h>
> +#include <linux/bitops.h>
> +#include <linux/printk.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>
> +
> +#define CMD_OTG				0x50
> +#define OTG_EN				BIT(0)
> +// The 0 bit in this register's bit field is undocumented
> +#define OTG_CFG				0x56
> +#define OTG_EN_SRC_CFG			BIT(1)
> +
> +struct qcom_usb_vbus_priv {
> +	phys_addr_t base;
> +};
> +
> +static int qcom_usb_vbus_regulator_of_to_plat(struct udevice *dev)
> +{
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr(dev);
> +	if (priv->base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int qcom_usb_vbus_regulator_get_enable(struct udevice *dev)
> +{
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +	int otg_en_reg = priv->base + CMD_OTG;
> +	int ret;
> +
> +	ret = pmic_reg_read(dev->parent, otg_en_reg);
> +	if (ret < 0)
> +		log_err("failed to read usb vbus: %d\n", ret);
> +	else
> +		ret &= OTG_EN;
> +
> +	return ret;
> +}
> +
> +static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
> +{
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +	int otg_en_reg = priv->base + CMD_OTG;
> +	int ret;
> +
> +	if (enable) {
> +		ret = pmic_clrsetbits(dev->parent, otg_en_reg, 0, OTG_EN);
> +		if (ret < 0) {
> +			log_err("error enabling: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = pmic_clrsetbits(dev->parent, otg_en_reg, OTG_EN, 0);
> +		if (ret < 0) {
> +			log_err("error disabling: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
> +{
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +	int otg_cfg_reg = priv->base + OTG_CFG;
> +	int ret;
> +
> +	/* Disable HW logic for VBUS enable */
> +	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, OTG_EN_SRC_CFG, 0);
> +	if (ret < 0) {
> +		log_err("error setting EN_SRC_CFG: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops = {
> +	.get_enable = qcom_usb_vbus_regulator_get_enable,
> +	.set_enable = qcom_usb_vbus_regulator_set_enable,
> +};
> +
> +static const struct udevice_id qcom_usb_vbus_regulator_ids[] = {
> +	{ .compatible = "qcom,pm8150b-vbus-reg"},
> +	{ },
> +};
> +
> +U_BOOT_DRIVER(qcom_usb_vbus_regulator) = {
> +	.name = "qcom-usb-vbus-regulator",
> +	.id = UCLASS_REGULATOR,
> +	.of_match = qcom_usb_vbus_regulator_ids,
> +	.of_to_plat = qcom_usb_vbus_regulator_of_to_plat,
> +	.ops = &qcom_usb_vbus_regulator_ops,
> +	.probe = qcom_usb_vbus_regulator_probe,
> +	.priv_auto = sizeof(struct qcom_usb_vbus_priv),
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
