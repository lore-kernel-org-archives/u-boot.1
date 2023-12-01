Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144C8C07E97
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F277386F50;
	Fri,  1 Dec 2023 10:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IxBKttVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F56870FC; Fri,  1 Dec 2023 10:25:54 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE37386314
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so1208537f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701422751; x=1702027551; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=AruCqHsQI304Nr68QtDiwsIJO6ymBwuw9OHM+wcq6HQ=;
 b=IxBKttVWgF/api2e1R1+gtxYWg1qjCyMULYPVPnuN87pcpi9wpoQubOTq/XpVod/M3
 +8PYH3lluVysxJYXCmifkvF56z2DxH5rGL/4tPVuCl3a4BZ38ktwd4mDxmxO55gLvWaX
 37rAWO3uFT68LiVt51Ma/fmTWdSU5fJfNbTNV4xzVcD5NlTOBnQ2KtL2pBT0DEv1jsXO
 GK/VX5fd7k+wFd4/xF2yqB4078Sw3QiYvBN/lD8soz5t78RKiD3FpJ+sfNJ9jX22MB+r
 7aU80clMv9qEOw19geevTcpxSJ4citiH5VPYHIbNwC5DnS1EhuTxOlHVkP9QyuraaEVm
 WbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701422751; x=1702027551;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AruCqHsQI304Nr68QtDiwsIJO6ymBwuw9OHM+wcq6HQ=;
 b=vdT5VMRmpy2wWttk2DUqpwJ7zvnhw3BbFeklCvwINjnuNCyD7rI3hnjOHDBMujQl2A
 w/1CDU1j/eLszR+e6o6+KdbIL1LN9Ktm+UYeV7ip/J/Bxq/d3W4c2A4OQtu1UT+0nF4b
 kLk/wkzEvTSe9eBm1VCUrRv6npD/bG3eij6j4p77naCKjYjx/k1qt300BuJjYsM/+dkt
 CYd6WpGl6SAAGiWrRnSaLmo5jV4Eil8k0LGKhdfu+JDSqoNUowiNMZGdQGSPYtsLeLKK
 DTWRekR9Lr1ZwCmTbaOhBnujEEu+qYPo6pxUovErz03zVveF+51CZHSwfdzES90TGKRj
 I3SA==
X-Gm-Message-State: AOJu0Yy2MU+WO1sh1DQF0lQ0dz5sjty+M69Xb/wsMY8AyQjLoc2NYMvp
 yczA0trowMSu/osNGteD+WwKdQ==
X-Google-Smtp-Source: AGHT+IGNxKKSnTfR6tPaE9PfuC7UUTf8L3dkhSsIm/GtPMXX2czFZdzFunjrDGxxYMbwr+Y5YDwtsg==
X-Received: by 2002:a05:6000:137a:b0:333:1bc8:40f7 with SMTP id
 q26-20020a056000137a00b003331bc840f7mr483269wrz.14.1701422751097; 
 Fri, 01 Dec 2023 01:25:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 dd16-20020a0560001e9000b00332cc24a59bsm3647361wrb.109.2023.12.01.01.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:25:50 -0800 (PST)
Message-ID: <693d85b5-0cec-42cf-898e-1e747606fe1d@linaro.org>
Date: Fri, 1 Dec 2023 10:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/9] button: qcom-pmic: introduce Qualcomm PMIC button
 driver
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-2-41500e237ad0@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-2-41500e237ad0@linaro.org>
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

On 30/11/2023 21:22, Caleb Connolly wrote:
> Qualcomm PMICs include a "pon" function which handles two buttons, the
> power button and "resin" button (usually volume down). Introduce a new
> driver following upstream Linux DT to enable these and map them to Enter
> and Down respectively to enable use in boot menus.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   MAINTAINERS                       |   1 +
>   drivers/button/Kconfig            |   9 +++
>   drivers/button/Makefile           |   1 +
>   drivers/button/button-qcom-pmic.c | 165 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 176 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6d63c8ab563..8cd102eaa070 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   R:	Sumit Garg <sumit.garg@linaro.org>
>   S:	Maintained
>   F:	arch/arm/mach-snapdragon/
> +F:	drivers/button/button-qcom-pmic.c
>   F:	drivers/clk/qcom/
>   F:	drivers/gpio/msm_gpio.c
>   F:	drivers/mmc/msm_sdhci.c
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 8ce2de37d62a..097b05f822e7 100644
> --- a/drivers/button/Kconfig
> +++ b/drivers/button/Kconfig
> @@ -27,4 +27,13 @@ config BUTTON_GPIO
>   	  The GPIO driver must used driver model. Buttons are configured using
>   	  the device tree.
>   
> +config BUTTON_QCOM_PMIC
> +	bool "Qualcomm power button"
> +	depends on BUTTON
> +	depends on PMIC_QCOM
> +	help
> +	  Enable support for the power and "resin" (usually volume down) buttons
> +	  on Qualcomm SoCs. These will be configured as the Enter and Down keys
> +	  respectively, allowing navigation of bootmenu with buttons on device.
> +
>   endmenu
> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
> index bbd18af14940..68555081a47a 100644
> --- a/drivers/button/Makefile
> +++ b/drivers/button/Makefile
> @@ -5,3 +5,4 @@
>   obj-$(CONFIG_BUTTON) += button-uclass.o
>   obj-$(CONFIG_BUTTON_ADC) += button-adc.o
>   obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
> +obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
> \ No newline at end of file
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> new file mode 100644
> index 000000000000..34a976d1e6c6
> --- /dev/null
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm generic pmic gpio driver
> + *
> + * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> + * (C) Copyright 2023 Linaro Ltd.
> + */
> +
> +#include <button.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <log.h>
> +#include <power/pmic.h>
> +#include <spmi/spmi.h>
> +#include <linux/bitops.h>
> +
> +#define REG_TYPE		0x4
> +#define REG_SUBTYPE		0x5
> +
> +struct qcom_pmic_btn_priv {
> +	u32 base;
> +	u32 status_bit;
> +	int code;
> +	struct udevice *pmic;
> +};
> +
> +#define PON_INT_RT_STS                        0x10
> +#define KPDPWR_ON_INT_BIT                     0
> +#define RESIN_ON_INT_BIT                      1
> +
> +#define NODE_IS_PWRKEY(node) (!strncmp(ofnode_get_name(node), "pwrkey", strlen("pwrkey")))
> +#define NODE_IS_RESIN(node) (!strncmp(ofnode_get_name(node), "resin", strlen("resin")))

This is not very pretty, but I don't see better alternative except perhaps
defining a struct with the node name and the properties and simply
match over it, but since there's only 2 buttons it makes it generic for nothing.

> +
> +static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
> +{
> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
> +
> +	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
> +
> +	if (reg < 0)
> +		return 0;
> +
> +	return (reg & BIT(priv->status_bit)) != 0;
> +}
> +
> +static int qcom_pwrkey_get_code(struct udevice *dev)
> +{
> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
> +
> +	return priv->code;
> +}
> +
> +static int qcom_pwrkey_probe(struct udevice *dev)
> +{
> +	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
> +	ofnode node = dev_ofnode(dev);
> +	int ret;
> +	u64 base;
> +
> +	/* Ignore the top-level pon node */
> +	if (!uc_plat->label)
> +		return 0;
> +
> +	/* the pwrkey and resin nodes are children of the "pon" node, get the
> +	 * PMIC device to use in pmic_reg_* calls.
> +	 */ > +	priv->pmic = dev->parent->parent;
> +
> +	/* Get the address of the parent pon node */
> +	base = dev_read_addr(dev->parent);
> +	if (base == FDT_ADDR_T_NONE) {
> +		printf("%s: Can't find address\n", dev->name);
> +		return -EINVAL;
> +	}
> +
> +	priv->base = base;
> +
> +	/* Do a sanity check */
> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
> +	if (ret != 0x1 && ret != 0xb) {
> +		printf("%s: unexpected PMIC function type %d\n", dev->name, ret);
> +		return -ENXIO;
> +	}
> +
> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
> +	if ((ret & 0x7) == 0) {
> +		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
> +		return -ENXIO;
> +	}
> +
> +	if (NODE_IS_PWRKEY(node)) {
> +		priv->status_bit = 0;
> +		priv->code = KEY_ENTER;
> +	} else if (NODE_IS_RESIN(node)) {
> +		priv->status_bit = 1;
> +		priv->code = KEY_DOWN;
> +	} else {
> +		/* Should not get here! */
> +		printf("Invalid pon node '%s' should be 'pwrkey' or 'resin'\n",
> +		       ofnode_get_name(node));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int button_qcom_pmic_bind(struct udevice *parent)
> +{
> +	struct udevice *dev;
> +	ofnode node;
> +	int ret;
> +
> +	dev_for_each_subnode(node, parent) {
> +		struct button_uc_plat *uc_plat;
> +		const char *label;
> +
> +		if (!ofnode_is_enabled(node))
> +			continue;
> +
> +		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
> +						 ofnode_get_name(node),
> +						 node, &dev);
> +		if (ret) {
> +			printf("Failed to bind %s! %d\n", label, ret);
> +			return ret;
> +		}
> +		uc_plat = dev_get_uclass_plat(dev);
> +		if (NODE_IS_PWRKEY(node)) {
> +			uc_plat->label = "pwrkey";
> +		} else if (NODE_IS_RESIN(node)) {
> +			uc_plat->label = "vol_down";
> +		} else {
> +			printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
> +			       ofnode_get_name(node));
> +			device_unbind(dev);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct button_ops button_qcom_pmic_ops = {
> +	.get_state	= qcom_pwrkey_get_state,
> +	.get_code	= qcom_pwrkey_get_code,
> +};
> +
> +static const struct udevice_id qcom_pwrkey_ids[] = {
> +	{ .compatible = "qcom,pm8916-pon" },
> +	{ .compatible = "qcom,pm8941-pon" },
> +	{ .compatible = "qcom,pm8998-pon" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qcom_pwrkey) = {
> +	.name = "qcom_pwrkey",
> +	.id = UCLASS_BUTTON,
> +	.of_match = qcom_pwrkey_ids,
> +	.bind = button_qcom_pmic_bind,
> +	.probe = qcom_pwrkey_probe,
> +	.ops = &button_qcom_pmic_ops,
> +	.priv_auto = sizeof(struct qcom_pmic_btn_priv),
> +};
> 

Apart that it looks good:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
