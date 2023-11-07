Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5ECC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059258715E;
	Tue,  7 Nov 2023 15:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZckKQvkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1FB864E5; Tue,  7 Nov 2023 15:29:56 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A262871F5
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40859c466efso41750275e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367393; x=1699972193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JqbFgfkMJokpmyPyjaIzBN6QUUQrV+sfXOCzM/neoLU=;
 b=ZckKQvkj1x5ZJt6HtYwrD7raHuqwK9Rbs8QF7Cj4E94rqK0njK1Gjy3PRqav0D4EAY
 5kmOk+b/IHiZET5MV0xNEZ3HwUVjUraTtfy0vjrL3khSqzCR1WULiNDM83e+5FohwnQJ
 jvCe+lBV2YMq8a8TQ5mgeSl1zCIr1JDCeaPcZxXnI+PBY5SgACkm83S/dISfvDsuvnO2
 W0pzVPz0r9uZTZI4rxnXInv8iHVwXnPArAT/BhzpGVhVD6Rz7zZwEOE9zcuoFIeS0WQe
 MaDpfgAVDZ5J25URjeJDXrLy0aAEsbRMwF8fRFlTrUOqNK0d9E05ZC+CKf11kWizlSN1
 akdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367393; x=1699972193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JqbFgfkMJokpmyPyjaIzBN6QUUQrV+sfXOCzM/neoLU=;
 b=RmJioHRn80BY7Jqk1740mJfnI27i76LOV6iMnvZl7m2ep8sEyRIBxtc5rW6ef+82JW
 Q4JH1QsPT5fZyCvGqt4LPk9DDFTLpl7MzxHLPteN+bTsY0KVW22dJOtYalohOY/HwsCC
 oq+kPPyKVVCgVQr7doy5Ycn3mfOwYpb1biT/PPQttiTAyy/CC0luAW57/3mVYu4AYgdp
 1XHLCLt9dduuHep/gBFRg+Ft5GwNUi7tXRFJfEfX2oYHXD2aHv6Ou6kS7AuDO3NwulJz
 PZfZvjpQ6K4eEedVt5698x49zIkn4xArlMYe8mVU46Ju1OsVr7bqFVBatKVeGQouv3wi
 s9Kg==
X-Gm-Message-State: AOJu0Yy+6tyiuWeS3Dl6HZmERYoWiSWebcCGSZ1ZVjhb+PZ+si2q/0TH
 kmv9jVIOIKUZ7ns9hK6R4rG8SQ==
X-Google-Smtp-Source: AGHT+IHwKnxjgxYe3TI4DpX/YWrSH5nDIWaviuZFqBqX+gsWDdVtz8PFxcdBs2+8l2aWJzNa2hHNNg==
X-Received: by 2002:a05:600c:3b20:b0:404:757e:c5ba with SMTP id
 m32-20020a05600c3b2000b00404757ec5bamr2459440wms.26.1699367393254; 
 Tue, 07 Nov 2023 06:29:53 -0800 (PST)
Received: from [192.168.1.7] (host-92-25-138-185.as13285.net. [92.25.138.185])
 by smtp.gmail.com with ESMTPSA id
 ay8-20020a05600c1e0800b0040772138bb7sm16193404wmb.2.2023.11.07.06.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 06:29:52 -0800 (PST)
Message-ID: <bf8287fa-27a3-45ba-93e9-5cc0772cf610@linaro.org>
Date: Tue, 7 Nov 2023 14:29:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] gpio: qcom_pmic: rework pwrkey driver into a button
 driver
Content-Language: en-US
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
 <20231106-b4-qcom-dt-compat-v1-2-0ccbb7841241@linaro.org>
 <ZUo7UDEVaPtHzWfk@gerhold.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ZUo7UDEVaPtHzWfk@gerhold.net>
Content-Type: text/plain; charset=UTF-8
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



On 07/11/2023 13:27, Stephan Gerhold wrote:
> On Mon, Nov 06, 2023 at 08:57:30PM +0000, Caleb Connolly wrote:
>> The power and resin keys were implemented as GPIOs here, but their only
>> use would be as buttons. Avoid the additional layer of introspection and
>> rework this driver into a button driver.
>>
>> While we're here, replace the "qcom,pm8998-pwrkey" compatible with
>> "qcom,pm8941-pwrkey" to match upstream (Linux).
>>
>> The dragonboard410c and 820c boards are adjusted to benefit from this
>> change too, simplify their custom board init code.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Thanks a lot for working on bringing the Qualcomm DTs in U-Boot closer
> to Linux upstream! I agree that modelling the pwr/resin keys is better
> than exposing tham as GPIOs.
> 
> I'm a bit confused about the actual diff in this patch series though.
> Did you perhaps forget to make some changes you had planned or sent the
> wrong version?
> 
> In particular:
> 
>  - You talk about replacing the custom "qcom,pm8998-pwrkey" compatible
>    with "qcom,pm8941-pwrkey" to match upstream, but don't seem to adjust
>    the users (sdm845.dtsi)?
> 
>  - sdm845.dtsi also uses GPIOs for PON, but you only update DB410c and
>    DB820c. Isn't SDM845 the platform you're testing on?

Argh, yeah you're totally right, I have been testing in the context of
upstream sdm845 DT and I forgot to pull in the individual changes for
this series.
> 
> Some more comments below.
> 
>> ---
>>  arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 +-
>>  arch/arm/dts/dragonboard820c-uboot.dtsi          |   9 +-
>>  arch/arm/dts/dragonboard820c.dts                 |   3 -
>>  board/qualcomm/dragonboard410c/dragonboard410c.c |  29 ++--
>>  board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
>>  drivers/gpio/Kconfig                             |   3 +-
>>  drivers/gpio/qcom_pmic_gpio.c                    | 161 +++++++++++++++--------
>>  7 files changed, 139 insertions(+), 106 deletions(-)
>>
>> diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
>> index 3b0bd0ed0a1b..c96f1fcc8930 100644
>> --- a/arch/arm/dts/dragonboard410c-uboot.dtsi
>> +++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
>> @@ -5,6 +5,9 @@
>>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>>   */
>>  
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>>  / {
>>  
>>  	smem {
>> @@ -46,10 +49,14 @@
>>  
>>  &pm8916_pon {
>>  	key_vol_down {
>> -		gpios = <&pm8916_pon 1 0>;
>> +		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>> +		linux,code = <KEY_DOWN>;
>> +		label = "key_vol_down";
>>  	};
>>  
>>  	key_power {
>> -		gpios = <&pm8916_pon 0 0>;
>> +		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>> +		linux,code = <KEY_ENTER>;
>> +		label = "key_power";
>>  	};
>>  };
> 
> The upstream Linux DT looks like this:
> 
> 		pon@800 {
> 			compatible = "qcom,pm8916-pon";
> 			reg = <0x800>;
> 			mode-bootloader = <0x2>;
> 			mode-recovery = <0x1>;
> 
> 			pwrkey {
> 				compatible = "qcom,pm8941-pwrkey";
> 				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> 				debounce = <15625>;
> 				bias-pull-up;
> 				linux,code = <KEY_POWER>;
> 			};
> 
> 			pm8916_resin: resin {
> 				compatible = "qcom,pm8941-resin";
> 				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> 				debounce = <15625>;
> 				bias-pull-up;
> 				linux,code = <KEY_VOLUME_DOWN>;
> 			};
> 		};
> 
> The new version you add is closer to upstream, but you also add a new
> custom property called "label". You could just derive a unique label
> from the node name ("pwrkey" vs "resin").

I just kinda followed what gpio-button does. I agree though this should
be dropped and we can just use the node name.
> 
> For looking up the buttons in the DB410c/DB820c couldn't you just loop
> over all buttons and find a suitable one based on button_get_code()?
> 
> I think having different *linux*,code values (KEY_POWER vs KEY_ENTER and
> KEY_DOWN vs KEY_VOLUME_DOWN) is also a bit strange. If U-Boot wants
> different key codes it's kind of not the Linux code anymore, might as
> well call it "u-boot,code" then. :-)

Yeah, I don't really know what the right solution is here, in U-Boot we
want to use these buttons as controls - like you would in ABL fastboot.

> 
> If KEY_POWER => KEY_ENTER and KEY_VOLUME_DOWN => KEY_DOWN is more useful
> for U-Boot maybe that mapping could be done automatically in the code,
> without having to change the real hardware description in the DT.

That sounds reasonable.
> 
>> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
>> index ad201d48749c..7db0cc9d64cc 100644
>> --- a/arch/arm/dts/dragonboard820c.dts
>> +++ b/arch/arm/dts/dragonboard820c.dts
>> @@ -112,9 +112,6 @@
>>  				pm8994_pon: pm8994_pon@800 {
>>  					compatible = "qcom,pm8994-pwrkey";
>>  					reg = <0x800 0x96>;
>> -					#gpio-cells = <2>;
>> -					gpio-controller;
>> -					gpio-bank-name="pm8994_key.";
>>  				};
> 
> Shouldn't we do the same change for pm8916_pon in db410c.dts?

Yes
> 
>> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
>> index e5841f502953..3dbc02d83198 100644
>> --- a/drivers/gpio/qcom_pmic_gpio.c
>> +++ b/drivers/gpio/qcom_pmic_gpio.c
>> @@ -5,8 +5,10 @@
>>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>>   */
>>  
>> +#include <button.h>
>>  #include <common.h>
>>  #include <dm.h>
>> +#include <dm/lists.h>
>>  #include <log.h>
>>  #include <power/pmic.h>
>>  #include <spmi/spmi.h>
>> @@ -275,107 +277,150 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
>>  	.priv_auto	= sizeof(struct qcom_gpio_bank),
>>  };
>>  
>> +struct qcom_pmic_btn_priv {
>> +	u32 base;
>> +	u32 status_bit;
>> +	int code;
>> +	struct udevice *pmic;
>> +};
>>  
>>  /* Add pmic buttons as GPIO as well - there is no generic way for now */
>>  #define PON_INT_RT_STS                        0x10
>>  #define KPDPWR_ON_INT_BIT                     0
>>  #define RESIN_ON_INT_BIT                      1
>>  
>> -static int qcom_pwrkey_get_function(struct udevice *dev, unsigned offset)
>> +static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
>>  {
>> -	return GPIOF_INPUT;
>> -}
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>>  
>> -static int qcom_pwrkey_get_value(struct udevice *dev, unsigned offset)
>> -{
>> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>> -
>> -	int reg = pmic_reg_read(dev->parent, priv->pid + PON_INT_RT_STS);
>> +	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
>>  
>>  	if (reg < 0)
>>  		return 0;
>>  
>> -	switch (offset) {
>> -	case 0: /* Power button */
>> -		return (reg & BIT(KPDPWR_ON_INT_BIT)) != 0;
>> -		break;
>> -	case 1: /* Reset button */
>> -	default:
>> -		return (reg & BIT(RESIN_ON_INT_BIT)) != 0;
>> -		break;
>> -	}
>> +	return (reg & BIT(priv->status_bit)) != 0;
>>  }
>>  
>> -/*
>> - * Since pmic buttons modelled as GPIO, we need empty direction functions
>> - * to trick u-boot button driver
>> - */
>> -static int qcom_pwrkey_direction_input(struct udevice *dev, unsigned int offset)
>> +static int qcom_pwrkey_get_code(struct udevice *dev)
>>  {
>> -	return 0;
>> -}
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>>  
>> -static int qcom_pwrkey_direction_output(struct udevice *dev, unsigned int offset, int value)
>> -{
>> -	return -EOPNOTSUPP;
>> +	return priv->code;
>>  }
>>  
>> -static const struct dm_gpio_ops qcom_pwrkey_ops = {
>> -	.get_value		= qcom_pwrkey_get_value,
>> -	.get_function		= qcom_pwrkey_get_function,
>> -	.direction_input	= qcom_pwrkey_direction_input,
>> -	.direction_output	= qcom_pwrkey_direction_output,
>> -};
>> -
>>  static int qcom_pwrkey_probe(struct udevice *dev)
>>  {
>> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>> -	int reg;
>> -	u64 pid;
>> +	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>> +	int ret;
>> +	u64 base;
>>  
>> -	pid = dev_read_addr(dev);
>> -	if (pid == FDT_ADDR_T_NONE)
>> -		return log_msg_ret("bad address", -EINVAL);
>> +	/* Ignore the top-level button node */
>> +	if (!uc_plat->label)
>> +		return 0;
>>  
>> -	priv->pid = pid;
>> +	/* the pwrkey and resin nodes are children of the "pon" node, get the
>> +	 * PMIC device to use in pmic_reg_* calls.
>> +	 */
>> +	priv->pmic = dev->parent->parent;
>> +
>> +	base = dev_read_addr(dev);
>> +	if (!base || base == FDT_ADDR_T_NONE) {
>> +		/* Linux devicetrees don't specify an address in the pwrkey node */
>> +		base = dev_read_addr(dev->parent);
>> +		if (base == FDT_ADDR_T_NONE) {
>> +			printf("%s: Can't find address\n", dev->name);
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> Is it worth introducing new code that supports non-standard Linux DTs?
> Or do we need to stay compatible with old U-Boot DTs too? Would expect
> those are always bundled together with U-Boot.

I've been aiming to minimise the number of changes made to db410c and
db820c as I can't easily test on these boards... I don't think we need
to worry about backwards compatibility - the DTB is usually built-in to
the U-Boot image.
> 
>> +
>> +	priv->base = base;
>>  
>>  	/* Do a sanity check */
>> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>> -	if (reg != 0x1)
>> -		return log_msg_ret("bad type", -ENXIO);
>> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
>> +	if (ret != 0x1 && ret != 0xb) {
>> +		printf("%s: unexpected PMIC function type %d\n", dev->name, ret);
>> +		return -ENXIO;
>> +	}
>>  
>> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
>> -	if ((reg & 0x5) == 0)
>> -		return log_msg_ret("bad subtype", -ENXIO);
>> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
>> +	if ((ret & 0x7) == 0) {
>> +		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
>> +		//return -ENXIO;
> 
> I guess this shouldn't be commented out? :D

Nope! Thanks for catching that
> 
>> +	}
>> +
>> +	/* Bit of a hack, we use the interrupt number to derive if this is the pwrkey or resin
>> +	 * node, it just so happens to line up with the bit numbers in the interrupt status register
>> +	 */
>> +	ret = ofnode_read_u32_index(dev_ofnode(dev), "interrupts", 2, &priv->status_bit);
>> +	if (ret < 0) {
>> +		printf("%s: Couldn't read interrupts: %d\n", __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = ofnode_read_u32(dev_ofnode(dev), "linux,code", &priv->code);
>> +	if (ret < 0) {
>> +		printf("%s: Couldn't read interrupts: %d\n", __func__, ret);
>> +		return ret;
>> +	}
>>  
>>  	return 0;
>>  }
>>  
>> -static int qcom_pwrkey_of_to_plat(struct udevice *dev)
>> +static int button_qcom_pmic_bind(struct udevice *parent)
>>  {
>> -	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
>> +	struct udevice *dev;
>> +	ofnode node;
>> +	int ret;
>>  
>> -	uc_priv->gpio_count = 2;
>> -	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
>> -	if (uc_priv->bank_name == NULL)
>> -		uc_priv->bank_name = "pwkey_qcom";
>> +	dev_for_each_subnode(node, parent) {
>> +		struct button_uc_plat *uc_plat;
>> +		const char *label;
>> +
>> +		if (!ofnode_is_enabled(node))
>> +			continue;
>> +
>> +		label = ofnode_read_string(node, "label");
>> +		if (!label) {
>> +			printf("%s: node %s has no label\n", __func__,
>> +			       ofnode_get_name(node));
>> +			/* Don't break booting, just print a warning and continue */
>> +			continue;
>> +		}
>> +		/* We need the PMIC device to be the parent, so flatten it out here */
>> +		ret = device_bind_driver_to_node(parent, "pwrkey_qcom",
>> +						 ofnode_get_name(node),
>> +						 node, &dev);
>> +		if (ret) {
>> +			printf("Failed to bind %s! %d\n", label, ret);
>> +			return ret;
>> +		}
>> +		uc_plat = dev_get_uclass_plat(dev);
>> +		uc_plat->label = label;
>> +	}
>>  
>>  	return 0;
>>  }
>>  
>> +static const struct button_ops button_qcom_pmic_ops = {
>> +	.get_state	= qcom_pwrkey_get_state,
>> +	.get_code	= qcom_pwrkey_get_code,
>> +};
>> +
>>  static const struct udevice_id qcom_pwrkey_ids[] = {
>>  	{ .compatible = "qcom,pm8916-pwrkey" },
>>  	{ .compatible = "qcom,pm8994-pwrkey" },
> 
> These are also qcom,pm8941-pwrkey upstream.
> 
>> -	{ .compatible = "qcom,pm8998-pwrkey" },
>> +	{ .compatible = "qcom,pm8941-pwrkey" },
>> +	{ .compatible = "qcom,pm8998-pon" },
> 
> "qcom,pm8998-pon" is the outer container node for pwrkey+resin, while
> "qcom,pm8941-pwrkey" is the actual power button. Why are both here next
> to each other?

This is a bit of a U-Boot trick, if you look in the probe function
you'll see the comment "Ignore the top-level button node". Basically the
same Driver is used to handle the NOP parent node and the children.
Otherwise I would have to add a new driver with UCLASS_NOP just to
handle the pon node and bind the children.
> 
>>  	{ }
>>  };
>>  
>>  U_BOOT_DRIVER(pwrkey_qcom) = {
>>  	.name	= "pwrkey_qcom",
>> -	.id	= UCLASS_GPIO,
>> +	.id	= UCLASS_BUTTON,
>>  	.of_match = qcom_pwrkey_ids,
>> -	.of_to_plat = qcom_pwrkey_of_to_plat,
>> +	.bind = button_qcom_pmic_bind,
>>  	.probe	= qcom_pwrkey_probe,
>> -	.ops	= &qcom_pwrkey_ops,
>> -	.priv_auto	= sizeof(struct qcom_gpio_bank),
>> +	.ops	= &button_qcom_pmic_ops,
>> +	.priv_auto	= sizeof(struct qcom_pmic_btn_priv),
>>  };
>>
> 
> Can we move this out of the drivers/gpio into drivers/button? Seems like
> there are now two quite different drivers in the same file. :-)

Yeah, fair enough. Will do.
> 
> Thanks,
> Stephan

-- 
// Caleb (they/them)
