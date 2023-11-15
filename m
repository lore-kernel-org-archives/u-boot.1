Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B26FC48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E15E80245;
	Wed, 15 Nov 2023 14:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kj5zSvvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68790871CD; Wed, 15 Nov 2023 14:28:49 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94580801B6
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso88331531fa.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700054926; x=1700659726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+mivPvaP6CO0C6xYxzWawjE+K9zPKn41VnOjlNP1IAs=;
 b=Kj5zSvvI6te4LTnPBaR0+1kVO1SIi/sbKo4+5D1vbWd3eGMXqZN0zed2fM1FgrQ0iB
 +zDgQ4BCqBPOXZX6X01KiHcksrLY+blD7qh9K09iMYlUDtnDPAsSvG9+8IveA3eAVJaL
 cDv0/jB3hiGlizzD+CVGxp3JrZPSk5GWEy+0b2eJV7I1Xap4fVnQL8RaEyZSDMnYa+/V
 884oVMyDlU9QG2c2U5pqr8F81JGrMGr/uhwdaQKTUOLan/V7owM+f0iw2ZS4qnLmYGNE
 QcWF7Dj0dCwvzN8sB+EG5IDbpUcBFYyMVVQTLcH/Pn5C+ShRzNQ4onnbxRpjZWuGL3+t
 sX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054926; x=1700659726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+mivPvaP6CO0C6xYxzWawjE+K9zPKn41VnOjlNP1IAs=;
 b=THhz68OnDOc6Otics7780IR8Kv0tKYgW5MYhOlsh5x4raIAjU772vz7TJOJ6Mf6oVB
 fLXNAhZcM+qGQ7awNe//N5ZlyJlt8b9MTXwRD7IYrlCM5Ce1t/qxQ/emeWiQE/61NQBA
 2clLeaovizZd+/LoYEDjWT9pAyJVjjb4Mf3CJVK34+VLVq+F8hNobwIWwHN8i130kk12
 yNrSUvE2ywYyrZX2x39XHbLIvN5dSEGaIOKhtn6tAUWOoKgTiyhV1ZW2WRYVfm4C5rdG
 CUS6jzLlHTKo+acc0c6V5Kom53deIn/EvMErAVSSFVP6sa7lQJbK1ckeubQEux0a85NU
 Gs3g==
X-Gm-Message-State: AOJu0YwIoGQHMS8iYjuM+ws/PjiNw3kWxB+yvcDFkEJq9ki+CrogWP6K
 WTsiOznV1BYN29AAxI71Wp8R5Q==
X-Google-Smtp-Source: AGHT+IGczCu4TvHxslGsB9mjrc20QnAGbeJUpbuogaJMi3e/J8aUQKmb6klN5rdi5DaqLbhjcls47g==
X-Received: by 2002:a2e:9b0d:0:b0:2c0:7d6:570a with SMTP id
 u13-20020a2e9b0d000000b002c007d6570amr4041276lji.33.1700054925643; 
 Wed, 15 Nov 2023 05:28:45 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 ay15-20020a05600c1e0f00b0040586360a36sm20954464wmb.17.2023.11.15.05.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:28:44 -0800 (PST)
Message-ID: <d3a7427f-6bb0-4fb3-9ef3-9bb72e755e2e@linaro.org>
Date: Wed, 15 Nov 2023 13:28:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] gpio: qcom_pmic: rework pwrkey driver into a
 button driver
To: Jaehoon Chung <jh80.chung@gmail.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-2-88a92f8f00ba@linaro.org>
 <dae88b6b-59dc-405f-9d9c-259b84679d5a@gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <dae88b6b-59dc-405f-9d9c-259b84679d5a@gmail.com>
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



On 15/11/2023 12:57, Jaehoon Chung wrote:
> Dear Caleb,
> 
> On 11/14/23 22:48, Caleb Connolly wrote:
>> The power and resin keys were implemented as GPIOs here, but their only
>> use would be as buttons. Avoid the additional layer of introspection and
>> rework this driver into a button driver.
>>
>> While we're here, replace the "qcom,pm8998-pwrkey" compatible with
>> "qcom,pm8941-pwrkey" to match upstream (Linux).
>>
>> The dragonboard410c and 820c boards are adjusted to benefit from this
>> change too, simplify their custom board init code.
> 
> I think that this patch can be splited.
> How about?

Hi,

I thought about splitting this patch but I couldn't see a nice way to do
it, do you have some ideas?

Thanks,
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  MAINTAINERS                                      |   1 +
>>  arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 --
>>  arch/arm/dts/dragonboard410c.dts                 |  22 ++-
>>  arch/arm/dts/dragonboard820c-uboot.dtsi          |  12 --
>>  arch/arm/dts/dragonboard820c.dts                 |  23 +++-
>>  arch/arm/dts/dragonboard845c-uboot.dtsi          |  11 --
>>  arch/arm/dts/dragonboard845c.dts                 |   4 +
>>  arch/arm/dts/sdm845.dtsi                         |  23 +++-
>>  arch/arm/dts/starqltechn-uboot.dtsi              |  10 --
>>  arch/arm/dts/starqltechn.dts                     |  20 +--
>>  arch/arm/mach-snapdragon/Kconfig                 |   3 +
>>  arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
>>  board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
>>  board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
>>  drivers/button/Kconfig                           |   9 ++
>>  drivers/button/Makefile                          |   1 +
>>  drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
>>  drivers/gpio/Kconfig                             |   3 +-
>>  drivers/gpio/qcom_pmic_gpio.c                    | 104 --------------
>>  19 files changed, 269 insertions(+), 258 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f6d63c8ab563..8cd102eaa070 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>>  R:	Sumit Garg <sumit.garg@linaro.org>
>>  S:	Maintained
>>  F:	arch/arm/mach-snapdragon/
>> +F:	drivers/button/button-qcom-pmic.c
>>  F:	drivers/clk/qcom/
>>  F:	drivers/gpio/msm_gpio.c
>>  F:	drivers/mmc/msm_sdhci.c
>> diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
>> index 3b0bd0ed0a1b..cec64bf80f99 100644
>> --- a/arch/arm/dts/dragonboard410c-uboot.dtsi
>> +++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
>> @@ -42,14 +42,3 @@
>>  		gpios = <&pm8916_gpios 3 0>;
>>  	};
>>  };
>> -
>> -
>> -&pm8916_pon {
>> -	key_vol_down {
>> -		gpios = <&pm8916_pon 1 0>;
>> -	};
>> -
>> -	key_power {
>> -		gpios = <&pm8916_pon 0 0>;
>> -	};
>> -};
>> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
>> index 9230dd3fd96c..c41fee977813 100644
>> --- a/arch/arm/dts/dragonboard410c.dts
>> +++ b/arch/arm/dts/dragonboard410c.dts
>> @@ -147,11 +147,23 @@
>>  				#address-cells = <0x1>;
>>  				#size-cells = <0x1>;
>>  
>> -				pm8916_pon: pm8916_pon@800 {
>> -					compatible = "qcom,pm8916-pwrkey";
>> -					reg = <0x800 0x96>;
>> -					#gpio-cells = <2>;
>> -					gpio-controller;
>> +				pon@800 {
>> +					compatible = "qcom,pm8916-pon";
>> +					reg = <0x800 0x100>;
>> +					mode-bootloader = <0x2>;
>> +					mode-recovery = <0x1>;
>> +
>> +					pwrkey {
>> +						compatible = "qcom,pm8941-pwrkey";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +					};
>> +
>> +					pm8916_resin: resin {
>> +						compatible = "qcom,pm8941-resin";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +					};
>>  				};
>>  
>>  				pm8916_gpios: pm8916_gpios@c000 {
>> diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
>> index 457728a43ecb..d93c7c1fbdee 100644
>> --- a/arch/arm/dts/dragonboard820c-uboot.dtsi
>> +++ b/arch/arm/dts/dragonboard820c-uboot.dtsi
>> @@ -30,15 +30,3 @@
>>  		};
>>  	};
>>  };
>> -
>> -&pm8994_pon {
>> -	key_vol_down {
>> -		gpios = <&pm8994_pon 1 0>;
>> -		label = "key_vol_down";
>> -	};
>> -
>> -	key_power {
>> -		gpios = <&pm8994_pon 0 0>;
>> -		label = "key_power";
>> -	};
>> -};
>> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
>> index ad201d48749c..0d9c9f7a4922 100644
>> --- a/arch/arm/dts/dragonboard820c.dts
>> +++ b/arch/arm/dts/dragonboard820c.dts
>> @@ -109,12 +109,23 @@
>>  				#address-cells = <0x1>;
>>  				#size-cells = <0x1>;
>>  
>> -				pm8994_pon: pm8994_pon@800 {
>> -					compatible = "qcom,pm8994-pwrkey";
>> -					reg = <0x800 0x96>;
>> -					#gpio-cells = <2>;
>> -					gpio-controller;
>> -					gpio-bank-name="pm8994_key.";
>> +				pm8994_pon: pon@800 {
>> +					compatible = "qcom,pm8916-pon";
>> +					reg = <0x800 0x100>;
>> +					mode-bootloader = <0x2>;
>> +					mode-recovery = <0x1>;
>> +
>> +					pwrkey {
>> +						compatible = "qcom,pm8941-pwrkey";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +					};
>> +
>> +					pm8994_resin: resin {
>> +						compatible = "qcom,pm8941-resin";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +					};
>>  				};
>>  
>>  				pm8994_gpios: pm8994_gpios@c000 {
>> diff --git a/arch/arm/dts/dragonboard845c-uboot.dtsi b/arch/arm/dts/dragonboard845c-uboot.dtsi
>> index 7728f4f4a3e5..775f45c0149f 100644
>> --- a/arch/arm/dts/dragonboard845c-uboot.dtsi
>> +++ b/arch/arm/dts/dragonboard845c-uboot.dtsi
>> @@ -24,14 +24,3 @@
>>  		};
>>  	};
>>  };
>> -
>> -&pm8998_pon {
>> -	key_vol_down {
>> -		gpios = <&pm8998_pon 1 0>;
>> -		label = "key_vol_down";
>> -	};
>> -	key_power {
>> -		gpios = <&pm8998_pon 0 0>;
>> -		label = "key_power";
>> -	};
>> -};
>> diff --git a/arch/arm/dts/dragonboard845c.dts b/arch/arm/dts/dragonboard845c.dts
>> index b4f057ac6537..054f253eb32a 100644
>> --- a/arch/arm/dts/dragonboard845c.dts
>> +++ b/arch/arm/dts/dragonboard845c.dts
>> @@ -41,4 +41,8 @@
>>  	};
>>  };
>>  
>> +&pm8998_resin {
>> +	status = "okay";
>> +};
>> +
>>  #include "dragonboard845c-uboot.dtsi"
>> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
>> index 4798ace0ff8b..cd5d890e9a45 100644
>> --- a/arch/arm/dts/sdm845.dtsi
>> +++ b/arch/arm/dts/sdm845.dtsi
>> @@ -78,12 +78,25 @@
>>  				#address-cells = <0x1>;
>>  				#size-cells = <0x1>;
>>  
>> -				pm8998_pon: pm8998_pon@800 {
>> -					compatible = "qcom,pm8998-pwrkey";
>> +				pm8998_pon: pon@800 {
>> +					compatible = "qcom,pm8998-pon";
>> +
>>  					reg = <0x800 0x100>;
>> -					#gpio-cells = <2>;
>> -					gpio-controller;
>> -					gpio-bank-name = "pm8998_key.";
>> +					mode-bootloader = <0x2>;
>> +					mode-recovery = <0x1>;
>> +
>> +					pm8998_pwrkey: pwrkey {
>> +						compatible = "qcom,pm8941-pwrkey";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +					};
>> +
>> +					pm8998_resin: resin {
>> +						compatible = "qcom,pm8941-resin";
>> +						debounce = <15625>;
>> +						bias-pull-up;
>> +						status = "disabled";
>> +					};
>>  				};
>>  
>>  				pm8998_gpios: pm8998_gpios@c000 {
>> diff --git a/arch/arm/dts/starqltechn-uboot.dtsi b/arch/arm/dts/starqltechn-uboot.dtsi
>> index 034d5c1c07ed..55c6d18412ba 100644
>> --- a/arch/arm/dts/starqltechn-uboot.dtsi
>> +++ b/arch/arm/dts/starqltechn-uboot.dtsi
>> @@ -25,13 +25,3 @@
>>  	};
>>  };
>>  
>> -&pm8998_pon {
>> -	key_vol_down {
>> -		gpios = <&pm8998_pon 1 0>;
>> -		label = "key_vol_down";
>> -	};
>> -	key_power {
>> -		gpios = <&pm8998_pon 0 0>;
>> -		label = "key_power";
>> -	};
>> -};
>> diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
>> index 5b6372bee79a..0842e19adb60 100644
>> --- a/arch/arm/dts/starqltechn.dts
>> +++ b/arch/arm/dts/starqltechn.dts
>> @@ -45,22 +45,6 @@
>>  		format = "a8r8g8b8";
>>  	};
>>  
>> -	gpio-keys {
>> -		compatible = "gpio-keys";
>> -
>> -		key-pwr {
>> -			label = "Power";
>> -			linux,code = <KEY_ENTER>;
>> -			gpios = <&pm8998_pon 0 GPIO_ACTIVE_LOW>;
>> -		};
>> -
>> -		key-vol-down {
>> -			label = "Volume Down";
>> -			linux,code = <KEY_DOWN>;
>> -			gpios = <&pm8998_pon 1 GPIO_ACTIVE_LOW>;
>> -		};
>> -	};
>> -
>>  	soc: soc {
>>  		serial@a84000 {
>>  			status = "okay";
>> @@ -68,6 +52,10 @@
>>  	};
>>  };
>>  
>> +&pm8998_resin {
>> +	status = "okay";
>> +};
>> +
>>  &tlmm {
>>  	muic_i2c: muic-i2c-n {
>>  		pins = "GPIO_33", "GPIO_34";
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 3c9f3bee3f18..ad6671081910 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -17,6 +17,7 @@ config SDM845
>>  	select LINUX_KERNEL_IMAGE_HEADER
>>  	imply CLK_QCOM_SDM845
>>  	imply PINCTRL_QCOM_SDM845
>> +	imply BUTTON_QCOM_PMIC
>>  
>>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>>  	default 0x80000000
>> @@ -30,6 +31,7 @@ config TARGET_DRAGONBOARD410C
>>  	select ENABLE_ARM_SOC_BOOT0_HOOK
>>  	imply CLK_QCOM_APQ8016
>>  	imply PINCTRL_QCOM_APQ8016
>> +	imply BUTTON_QCOM_PMIC
>>  	help
>>  	  Support for 96Boards Dragonboard 410C. This board complies with
>>  	  96Board Open Platform Specifications. Features:
>> @@ -45,6 +47,7 @@ config TARGET_DRAGONBOARD820C
>>  	bool "96Boards Dragonboard 820C"
>>  	imply CLK_QCOM_APQ8096
>>  	imply PINCTRL_QCOM_APQ8096
>> +	imply BUTTON_QCOM_PMIC
>>  	help
>>  	  Support for 96Boards Dragonboard 820C. This board complies with
>>  	  96Board Open Platform Specifications. Features:
>> diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
>> index 1f8850239437..067acc9a6f44 100644
>> --- a/arch/arm/mach-snapdragon/init_sdm845.c
>> +++ b/arch/arm/mach-snapdragon/init_sdm845.c
>> @@ -5,6 +5,7 @@
>>   * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
>>   */
>>  
>> +#include <button.h>
>>  #include <init.h>
>>  #include <env.h>
>>  #include <common.h>
>> @@ -32,46 +33,18 @@ __weak int board_init(void)
>>  /* Check for vol- and power buttons */
>>  __weak int misc_init_r(void)
>>  {
>> -	struct udevice *pon;
>> -	struct gpio_desc resin;
>> -	int node, ret;
>> +	struct udevice *btn;
>> +	int ret;
>> +	enum button_state_t state;
>>  
>> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8998_pon@800", &pon);
>> +	ret = button_get_by_label("pwrkey", &btn);
>>  	if (ret < 0) {
>> -		printf("Failed to find PMIC pon node. Check device tree\n");
>> -		return 0;
>> +		printf("Couldn't find power button!\n");
>> +		return ret;
>>  	}
>>  
>> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
>> -				  "key_vol_down");
>> -	if (node < 0) {
>> -		printf("Failed to find key_vol_down node. Check device tree\n");
>> -		return 0;
>> -	}
>> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
>> -				       &resin, 0)) {
>> -		printf("Failed to request key_vol_down button.\n");
>> -		return 0;
>> -	}
>> -	if (dm_gpio_get_value(&resin)) {
>> -		env_set("key_vol_down", "1");
>> -		printf("Volume down button pressed\n");
>> -	} else {
>> -		env_set("key_vol_down", "0");
>> -	}
>> -
>> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
>> -				  "key_power");
>> -	if (node < 0) {
>> -		printf("Failed to find key_power node. Check device tree\n");
>> -		return 0;
>> -	}
>> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
>> -				       &resin, 0)) {
>> -		printf("Failed to request key_power button.\n");
>> -		return 0;
>> -	}
>> -	if (dm_gpio_get_value(&resin)) {
>> +	state = button_get_state(btn);
>> +	if (state == BUTTON_ON) {
>>  		env_set("key_power", "1");
>>  		printf("Power button pressed\n");
>>  	} else {
>> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
>> index 371b3262f8c5..350e0e9e20aa 100644
>> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
>> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
>> @@ -5,6 +5,7 @@
>>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>>   */
>>  
>> +#include <button.h>
>>  #include <common.h>
>>  #include <cpu_func.h>
>>  #include <dm.h>
>> @@ -108,32 +109,20 @@ int board_usb_init(int index, enum usb_init_type init)
>>  /* Check for vol- button - if pressed - stop autoboot */
>>  int misc_init_r(void)
>>  {
>> -	struct udevice *pon;
>> -	struct gpio_desc resin;
>> -	int node, ret;
>> +	struct udevice *btn;
>> +	int ret;
>> +	enum button_state_t state;
>>  
>> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8916_pon@800", &pon);
>> +	ret = button_get_by_label("vol_down", &btn);
>>  	if (ret < 0) {
>> -		printf("Failed to find PMIC pon node. Check device tree\n");
>> -		return 0;
>> +		printf("Couldn't find power button!\n");
>> +		return ret;
>>  	}
>>  
>> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
>> -				  "key_vol_down");
>> -	if (node < 0) {
>> -		printf("Failed to find key_vol_down node. Check device tree\n");
>> -		return 0;
>> -	}
>> -
>> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
>> -				       &resin, 0)) {
>> -		printf("Failed to request key_vol_down button.\n");
>> -		return 0;
>> -	}
>> -
>> -	if (dm_gpio_get_value(&resin)) {
>> +	state = button_get_state(btn);
>> +	if (state == BUTTON_ON) {
>>  		env_set("preboot", "setenv preboot; fastboot 0");
>> -		printf("key_vol_down pressed - Starting fastboot.\n");
>> +		printf("vol_down pressed - Starting fastboot.\n");
>>  	}
>>  
>>  	return 0;
>> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
>> index 6785bf58e949..2f0db628368b 100644
>> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
>> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
>> @@ -5,6 +5,7 @@
>>   * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>   */
>>  
>> +#include <button.h>
>>  #include <cpu_func.h>
>>  #include <init.h>
>>  #include <env.h>
>> @@ -139,30 +140,18 @@ void reset_cpu(void)
>>  /* Check for vol- button - if pressed - stop autoboot */
>>  int misc_init_r(void)
>>  {
>> -	struct udevice *pon;
>> -	struct gpio_desc resin;
>> -	int node, ret;
>> +	struct udevice *btn;
>> +	int ret;
>> +	enum button_state_t state;
>>  
>> -	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8994_pon@800", &pon);
>> +	ret = button_get_by_label("pwrkey", &btn);
>>  	if (ret < 0) {
>> -		printf("Failed to find PMIC pon node. Check device tree\n");
>> -		return 0;
>> +		printf("Couldn't find power button!\n");
>> +		return ret;
>>  	}
>>  
>> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
>> -				  "key_vol_down");
>> -	if (node < 0) {
>> -		printf("Failed to find key_vol_down node. Check device tree\n");
>> -		return 0;
>> -	}
>> -
>> -	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
>> -				       &resin, 0)) {
>> -		printf("Failed to request key_vol_down button.\n");
>> -		return 0;
>> -	}
>> -
>> -	if (dm_gpio_get_value(&resin)) {
>> +	state = button_get_state(btn);
>> +	if (state == BUTTON_ON) {
>>  		env_set("bootdelay", "-1");
>>  		printf("Power button pressed - dropping to console.\n");
>>  	}
>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>> index 8ce2de37d62a..097b05f822e7 100644
>> --- a/drivers/button/Kconfig
>> +++ b/drivers/button/Kconfig
>> @@ -27,4 +27,13 @@ config BUTTON_GPIO
>>  	  The GPIO driver must used driver model. Buttons are configured using
>>  	  the device tree.
>>  
>> +config BUTTON_QCOM_PMIC
>> +	bool "Qualcomm power button"
>> +	depends on BUTTON
>> +	depends on PMIC_QCOM
>> +	help
>> +	  Enable support for the power and "resin" (usually volume down) buttons
>> +	  on Qualcomm SoCs. These will be configured as the Enter and Down keys
>> +	  respectively, allowing navigation of bootmenu with buttons on device.
>> +
>>  endmenu
>> diff --git a/drivers/button/Makefile b/drivers/button/Makefile
>> index bbd18af14940..68555081a47a 100644
>> --- a/drivers/button/Makefile
>> +++ b/drivers/button/Makefile
>> @@ -5,3 +5,4 @@
>>  obj-$(CONFIG_BUTTON) += button-uclass.o
>>  obj-$(CONFIG_BUTTON_ADC) += button-adc.o
>>  obj-$(CONFIG_BUTTON_GPIO) += button-gpio.o
>> +obj-$(CONFIG_BUTTON_QCOM_PMIC) += button-qcom-pmic.o
>> \ No newline at end of file
>> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
>> new file mode 100644
>> index 000000000000..34a976d1e6c6
>> --- /dev/null
>> +++ b/drivers/button/button-qcom-pmic.c
>> @@ -0,0 +1,165 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Qualcomm generic pmic gpio driver
>> + *
>> + * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>> + * (C) Copyright 2023 Linaro Ltd.
>> + */
>> +
>> +#include <button.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dm.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>> +#include <log.h>
>> +#include <power/pmic.h>
>> +#include <spmi/spmi.h>
>> +#include <linux/bitops.h>
>> +
>> +#define REG_TYPE		0x4
>> +#define REG_SUBTYPE		0x5
>> +
>> +struct qcom_pmic_btn_priv {
>> +	u32 base;
>> +	u32 status_bit;
>> +	int code;
>> +	struct udevice *pmic;
>> +};
>> +
>> +#define PON_INT_RT_STS                        0x10
>> +#define KPDPWR_ON_INT_BIT                     0
>> +#define RESIN_ON_INT_BIT                      1
>> +
>> +#define NODE_IS_PWRKEY(node) (!strncmp(ofnode_get_name(node), "pwrkey", strlen("pwrkey")))
>> +#define NODE_IS_RESIN(node) (!strncmp(ofnode_get_name(node), "resin", strlen("resin")))
>> +
>> +static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
>> +{
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>> +
>> +	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
>> +
>> +	if (reg < 0)
>> +		return 0;
>> +
>> +	return (reg & BIT(priv->status_bit)) != 0;
>> +}
>> +
>> +static int qcom_pwrkey_get_code(struct udevice *dev)
>> +{
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>> +
>> +	return priv->code;
>> +}
>> +
>> +static int qcom_pwrkey_probe(struct udevice *dev)
>> +{
>> +	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
>> +	ofnode node = dev_ofnode(dev);
>> +	int ret;
>> +	u64 base;
>> +
>> +	/* Ignore the top-level pon node */
>> +	if (!uc_plat->label)
>> +		return 0;
>> +
>> +	/* the pwrkey and resin nodes are children of the "pon" node, get the
>> +	 * PMIC device to use in pmic_reg_* calls.
>> +	 */
>> +	priv->pmic = dev->parent->parent;
>> +
>> +	/* Get the address of the parent pon node */
>> +	base = dev_read_addr(dev->parent);
>> +	if (base == FDT_ADDR_T_NONE) {
>> +		printf("%s: Can't find address\n", dev->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	priv->base = base;
>> +
>> +	/* Do a sanity check */
>> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
>> +	if (ret != 0x1 && ret != 0xb) {
>> +		printf("%s: unexpected PMIC function type %d\n", dev->name, ret);
>> +		return -ENXIO;
>> +	}
>> +
>> +	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
>> +	if ((ret & 0x7) == 0) {
>> +		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (NODE_IS_PWRKEY(node)) {
>> +		priv->status_bit = 0;
>> +		priv->code = KEY_ENTER;
>> +	} else if (NODE_IS_RESIN(node)) {
>> +		priv->status_bit = 1;
>> +		priv->code = KEY_DOWN;
>> +	} else {
>> +		/* Should not get here! */
>> +		printf("Invalid pon node '%s' should be 'pwrkey' or 'resin'\n",
>> +		       ofnode_get_name(node));
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int button_qcom_pmic_bind(struct udevice *parent)
>> +{
>> +	struct udevice *dev;
>> +	ofnode node;
>> +	int ret;
>> +
>> +	dev_for_each_subnode(node, parent) {
>> +		struct button_uc_plat *uc_plat;
>> +		const char *label;
>> +
>> +		if (!ofnode_is_enabled(node))
>> +			continue;
>> +
>> +		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
>> +						 ofnode_get_name(node),
>> +						 node, &dev);
>> +		if (ret) {
>> +			printf("Failed to bind %s! %d\n", label, ret);
>> +			return ret;
>> +		}
>> +		uc_plat = dev_get_uclass_plat(dev);
>> +		if (NODE_IS_PWRKEY(node)) {
>> +			uc_plat->label = "pwrkey";
>> +		} else if (NODE_IS_RESIN(node)) {
>> +			uc_plat->label = "vol_down";
>> +		} else {
>> +			printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
>> +			       ofnode_get_name(node));
>> +			device_unbind(dev);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct button_ops button_qcom_pmic_ops = {
>> +	.get_state	= qcom_pwrkey_get_state,
>> +	.get_code	= qcom_pwrkey_get_code,
>> +};
>> +
>> +static const struct udevice_id qcom_pwrkey_ids[] = {
>> +	{ .compatible = "qcom,pm8916-pon" },
>> +	{ .compatible = "qcom,pm8941-pon" },
>> +	{ .compatible = "qcom,pm8998-pon" },
>> +	{ }
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_pwrkey) = {
>> +	.name = "qcom_pwrkey",
>> +	.id = UCLASS_BUTTON,
>> +	.of_match = qcom_pwrkey_ids,
>> +	.bind = button_qcom_pmic_bind,
>> +	.probe = qcom_pwrkey_probe,
>> +	.ops = &button_qcom_pmic_ops,
>> +	.priv_auto = sizeof(struct qcom_pmic_btn_priv),
>> +};
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index ba42b0768e12..fbf77673c5e0 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -309,12 +309,13 @@ config CMD_PCA953X
>>  config QCOM_PMIC_GPIO
>>  	bool "Qualcomm generic PMIC GPIO/keypad driver"
>>  	depends on DM_GPIO && PMIC_QCOM
>> +	select BUTTON
>>  	help
>>  	  Support for GPIO pins and power/reset buttons found on
>>  	  Qualcomm SoCs PMIC.
>>  	  Default name for GPIO bank is "pm8916".
>>  	  Power and reset buttons are placed in "pwkey_qcom" bank and
>> -          have gpio numbers 0 and 1 respectively.
>> +	  have gpio numbers 0 and 1 respectively.
>>  
>>  config PCF8575_GPIO
>>  	bool "PCF8575 I2C GPIO Expander driver"
>> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
>> index e5841f502953..7b83c67fa464 100644
>> --- a/drivers/gpio/qcom_pmic_gpio.c
>> +++ b/drivers/gpio/qcom_pmic_gpio.c
>> @@ -275,107 +275,3 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
>>  	.priv_auto	= sizeof(struct qcom_gpio_bank),
>>  };
>>  
>> -
>> -/* Add pmic buttons as GPIO as well - there is no generic way for now */
>> -#define PON_INT_RT_STS                        0x10
>> -#define KPDPWR_ON_INT_BIT                     0
>> -#define RESIN_ON_INT_BIT                      1
>> -
>> -static int qcom_pwrkey_get_function(struct udevice *dev, unsigned offset)
>> -{
>> -	return GPIOF_INPUT;
>> -}
>> -
>> -static int qcom_pwrkey_get_value(struct udevice *dev, unsigned offset)
>> -{
>> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>> -
>> -	int reg = pmic_reg_read(dev->parent, priv->pid + PON_INT_RT_STS);
>> -
>> -	if (reg < 0)
>> -		return 0;
>> -
>> -	switch (offset) {
>> -	case 0: /* Power button */
>> -		return (reg & BIT(KPDPWR_ON_INT_BIT)) != 0;
>> -		break;
>> -	case 1: /* Reset button */
>> -	default:
>> -		return (reg & BIT(RESIN_ON_INT_BIT)) != 0;
>> -		break;
>> -	}
>> -}
>> -
>> -/*
>> - * Since pmic buttons modelled as GPIO, we need empty direction functions
>> - * to trick u-boot button driver
>> - */
>> -static int qcom_pwrkey_direction_input(struct udevice *dev, unsigned int offset)
>> -{
>> -	return 0;
>> -}
>> -
>> -static int qcom_pwrkey_direction_output(struct udevice *dev, unsigned int offset, int value)
>> -{
>> -	return -EOPNOTSUPP;
>> -}
>> -
>> -static const struct dm_gpio_ops qcom_pwrkey_ops = {
>> -	.get_value		= qcom_pwrkey_get_value,
>> -	.get_function		= qcom_pwrkey_get_function,
>> -	.direction_input	= qcom_pwrkey_direction_input,
>> -	.direction_output	= qcom_pwrkey_direction_output,
>> -};
>> -
>> -static int qcom_pwrkey_probe(struct udevice *dev)
>> -{
>> -	struct qcom_gpio_bank *priv = dev_get_priv(dev);
>> -	int reg;
>> -	u64 pid;
>> -
>> -	pid = dev_read_addr(dev);
>> -	if (pid == FDT_ADDR_T_NONE)
>> -		return log_msg_ret("bad address", -EINVAL);
>> -
>> -	priv->pid = pid;
>> -
>> -	/* Do a sanity check */
>> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
>> -	if (reg != 0x1)
>> -		return log_msg_ret("bad type", -ENXIO);
>> -
>> -	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
>> -	if ((reg & 0x5) == 0)
>> -		return log_msg_ret("bad subtype", -ENXIO);
>> -
>> -	return 0;
>> -}
>> -
>> -static int qcom_pwrkey_of_to_plat(struct udevice *dev)
>> -{
>> -	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
>> -
>> -	uc_priv->gpio_count = 2;
>> -	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
>> -	if (uc_priv->bank_name == NULL)
>> -		uc_priv->bank_name = "pwkey_qcom";
>> -
>> -	return 0;
>> -}
>> -
>> -static const struct udevice_id qcom_pwrkey_ids[] = {
>> -	{ .compatible = "qcom,pm8916-pwrkey" },
>> -	{ .compatible = "qcom,pm8994-pwrkey" },
>> -	{ .compatible = "qcom,pm8998-pwrkey" },
>> -	{ }
>> -};
>> -
>> -U_BOOT_DRIVER(pwrkey_qcom) = {
>> -	.name	= "pwrkey_qcom",
>> -	.id	= UCLASS_GPIO,
>> -	.of_match = qcom_pwrkey_ids,
>> -	.of_to_plat = qcom_pwrkey_of_to_plat,
>> -	.probe	= qcom_pwrkey_probe,
>> -	.ops	= &qcom_pwrkey_ops,
>> -	.priv_auto	= sizeof(struct qcom_gpio_bank),
>> -};
>>

-- 
// Caleb (they/them)
