Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF49C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 17:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6132806FC;
	Thu, 20 Mar 2025 18:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pEMStRT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF258070C; Thu, 20 Mar 2025 18:34:35 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77AB7803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so9973455e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742492073; x=1743096873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BIbdq0vKw0gaFateIPm6JwVE8ReLoK8GP0XUHQUc+hQ=;
 b=pEMStRT5whlXNPcC+nx3DkSKwav1kDqW8bYHChTWxACDZkiUpUYiqoWplAkqm6iqde
 robRhBqzBtrBnyTL2DwzXBEeMRujnGE4hkoloNy2kOdXTAbUT/on/SBmgNYNx0uTdqrW
 s87qCUJZWBTyzYUKuT6WJGr1cb8ErxmP7ovErfptWRvsoY0mYZDI/oQBbo/NLOsT1YHd
 T0puGpilncBrak8YB+A02hcmtd/ZhbBgYwmrYxTWljn8qc2dm8vWXdnWj6ITxnm9yRDP
 dqod2R4NxHpwac8KzR2G5mNRcAkwFsRn/2jjCsDG9Goxkkzoy+Z7IVtFDFRnMyILx5WY
 fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492073; x=1743096873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BIbdq0vKw0gaFateIPm6JwVE8ReLoK8GP0XUHQUc+hQ=;
 b=hKvmopFXUdC0yXj/uQtiNeYtSqLa0WXbun9hgm0jNvoeXl6lMws+gAtrYI7w0QdnWq
 fKME74wga53+8iUFBYW3nS86+4pMAbqBeLEO5YU/qgyKgBlAMMgyRaCe58gSqxYQXgLk
 XIN+C1equy0u/BBtn30qBdNgVurlIF4PUuC6jcXslD3+udgUZhg/s66TXE3ym4osW1nj
 s2DhLGgFi0QfNN2AzobpDLrLKDpnX+kxQIePm+rkCByA7GCqyU914QucMnNAbvTv3upX
 oLFLkB9kgWCiHbTAGmu8OlYu3vVIjOSk/E3MJEsepdKrYDX1Gv5+3LZMGeItgUDIwMiw
 odMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaUC/bEainrJW6y63MBuTSEQ3SKKzOBt5OCYr6IyhHcaqyVfyQag6ic28BxcX0TTLaYP0FjHU=@lists.denx.de
X-Gm-Message-State: AOJu0YxRa12oQtBiG2SbBf9I5O+rS+gMsYupCTAXmQIRqKkeA36nJwo0
 xzOaT7M8kt0eaHYyn34d+EEEZeqMXpt+XV3iF9y2BmHXtxffS0f1v85ElsmGEIw=
X-Gm-Gg: ASbGncsJjj1+P/qUTU6eW3XT6AGIStIiXsnxVHxAX2lAumSq5ZvZYffyoarAbukig2v
 eR1mdyDNh+TutuAJjPb0Q5oSI8C+IWkNnYRz4lzHRLGtJS/JqG3aEnMGMQb7V2V3xqaH7EekyNU
 GPoHeop9krWVCFQEotfTL03Vq0EEArtftPlBEeETNJfJOxtQOYOOU69jCIFyMjZmBkBm1W1ADMY
 BNruDwxJ6p0UJJ5F7XTXqLjAOhuFDnKHNcrcxvB/DGBxXvGGgBHotEUR002pqzmacDxsDw0XELJ
 oikWCxMbIBnVAu+e2STrLQF73HoRhzVCJeMvlSeTLUZnNZbIny7Ar+O4Yt+i//Vz3yhqVlz6cms
 oq7xS4kxgW7yDZpCZjR9WfyTpNw==
X-Google-Smtp-Source: AGHT+IG8UTydJfwHbLkiPGYOLmutfR0hKUBe6rEOusEsIEin8PGVfQOaGvtW/oMlBUfsT3tmtRBcug==
X-Received: by 2002:a05:600c:4e56:b0:43d:412e:8a81 with SMTP id
 5b1f17b1804b1-43d4389a4cdmr70777455e9.28.1742492072730; 
 Thu, 20 Mar 2025 10:34:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:1c93:5a83:c943:b712?
 ([2a0a:ef40:1d11:ab01:1c93:5a83:c943:b712])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4b8sm54144375e9.35.2025.03.20.10.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 10:34:31 -0700 (PDT)
Message-ID: <e0744b83-8b93-49d9-bf4c-bf09aeb08294@linaro.org>
Date: Thu, 20 Mar 2025 17:34:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: regulator: add qcom-usb-vbus
To: Rui Miguel Silva <rui.silva@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
 <20250227094911.497219-3-rui.silva@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


Jaehoon: do you mind if I just take these both through the Qualcomm tree?

If not then feel free to pick this one up

Acked-by: Caleb Connolly <caleb.connolly@linaro.org>

On 2/27/25 09:45, Rui Miguel Silva wrote:
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

-- 
Caleb (they/them)

