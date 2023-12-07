Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64873C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 19:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D9687505;
	Thu,  7 Dec 2023 20:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iDJy9UPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4E687501; Thu,  7 Dec 2023 20:11:13 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239C1874ED
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 20:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c0a0d068bso13280705e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701976264; x=1702581064; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=346m+uSbFhfO81ClnyOwvHuSCTU/sn66ljBEasQz6wM=;
 b=iDJy9UPqy9riVGPRNeUP+UNZm0JO8mfUAErGdbgWhqmJohH/E2476rGwUwX5Bam8Pt
 Pys5Y2r2zAUzlc/4VCWgndM1dE+hWLudzCppcFfV9mk3WpiG/SHCAiUMrcRq88gDahmR
 E1qmXzgRoP48KDRlJF6QoCEu+MBhgHYv6gD0LbSbs99V+blUctsFxklrEc6j8BtStiSz
 UkL7+KdBMNVe02ovTgw4BDy1jK6mOsbaJMWLlX+9XPUztcfRZYDnBNXnYlTe3CJ9jQfs
 V5hgXuoTLUk3eBWUaQHIu4lkaez2EdgGzYZ24hKmE9AtYhoZ1d3IdTvktDwV53SLuiYn
 nHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701976264; x=1702581064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=346m+uSbFhfO81ClnyOwvHuSCTU/sn66ljBEasQz6wM=;
 b=fUKU/k+vbA41EWH+7bKgCqWKEJLlxHAEuczbBmJqQJ0fZegvNAdBF0yyHe5x4AeR/l
 77ZlRbScF1rsB5NpZhUukXV1why/L0GZGH7Iz2fkMuhSQGyQZXjjD+j4f4sixKyyR30G
 gMeXRsqA+X6G8lARahm6cneVRv0zkgiK9xHO6P/Z8KCzhgeNCAw5vdWx363TqmuIel2h
 3NOP8dBBzdxw+R6ZeIDwR5PD+nRzcwibTgb+yzxd6IJjlGJJPAVJv0YeyXzIOK+PRmqt
 RdcitHntvZ1w+YaiXvHCHAOarlNb6pJQjoh+l+kJ0l7xDPEXpxB5DZIxcXJp37GRGqES
 hS+g==
X-Gm-Message-State: AOJu0YxkxgYz+3w1u6EnYUeLr5jBROgbh35Xnn/LbTVE4QzAtuRPE5kQ
 mq9VoxPQ9ofYXU4WeZbOK/37gtRtBCFWrD0LW+x1sQ==
X-Google-Smtp-Source: AGHT+IGpP43qyJGXhR63koichzf3tPY9fI5wGuhZuLfWKcD98XmK1Zzn3A1vYVcl/r2w+o/cUYAJdA==
X-Received: by 2002:a05:600c:3144:b0:40b:4812:22e2 with SMTP id
 h4-20020a05600c314400b0040b481222e2mr1824237wmo.11.1701976264071; 
 Thu, 07 Dec 2023 11:11:04 -0800 (PST)
Received: from [192.168.1.15] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b0040b30be6244sm538310wmq.24.2023.12.07.11.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 11:11:03 -0800 (PST)
Message-ID: <3334681a-e5b3-4d76-afea-26f8111808e8@linaro.org>
Date: Thu, 7 Dec 2023 19:11:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] dts: msm8916: import DT from Linux
Content-Language: en-US
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-18-9492198e0c15@linaro.org>
 <ZV0DJrk_iOMd5I2a@gerhold.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ZV0DJrk_iOMd5I2a@gerhold.net>
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



On 21/11/2023 19:21, Stephan Gerhold wrote:
> On Tue, Nov 21, 2023 at 05:09:41PM +0000, Caleb Connolly wrote:
>> Import the msm8916 devicetree from Linux and adjust the dragonboard410c
>> devicetree to use it.
>>
> 
> Can you add a note here from which Linux version you took the DT?
> 
> It seems quite old, the msm8916-pm8916.dtsi doesn't exist anymore
> upstream since v6.5. Would be nice to bring it up to date (I don't have
> any more cleanup planned at the moment, so the current state upstream
> will probably stay mostly as-is).

That file still exists on 6.7-rc4, as far as I can tell?
> 
> From a quick look I think U-Boot shouldn't be concerned much about the
> changes, you might just need to do some trivial renames:
> 
>   &msmgpio -> &tlmm
>   &blsp1_uart2 -> &blsp_uart2
> 
> Thanks a lot for working on this!
> 
> Stephan
> 
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/dts/dragonboard410c-uboot.dtsi         |   44 -
>>  arch/arm/dts/dragonboard410c.dts                |  198 +-
>>  arch/arm/dts/msm8916-pins.dtsi                  |  582 ++++++
>>  arch/arm/dts/msm8916-pm8916.dtsi                |   76 +
>>  arch/arm/dts/msm8916.dtsi                       | 2194 +++++++++++++++++++++++
>>  arch/arm/dts/pm8916.dtsi                        |  183 ++
>>  include/dt-bindings/arm/coresight-cti-dt.h      |   37 +
>>  include/dt-bindings/clock/qcom,rpmcc.h          |  174 ++
>>  include/dt-bindings/interconnect/qcom,msm8916.h |  100 ++
>>  include/dt-bindings/reset/qcom,gcc-msm8916.h    |  100 ++
>>  10 files changed, 3484 insertions(+), 204 deletions(-)
>>
>> diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
>> deleted file mode 100644
>> index cec64bf80f99..000000000000
>> --- a/arch/arm/dts/dragonboard410c-uboot.dtsi
>> +++ /dev/null
>> @@ -1,44 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> -/*
>> - * U-Boot addition to handle Dragonboard 410c pins
>> - *
>> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>> - */
>> -
>> -/ {
>> -
>> -	smem {
>> -		bootph-all;
>> -	};
>> -
>> -	soc {
>> -		bootph-all;
>> -
>> -		pinctrl@1000000 {
>> -			bootph-all;
>> -
>> -			uart {
>> -				bootph-all;
>> -			};
>> -		};
>> -
>> -		qcom,gcc@1800000 {
>> -			bootph-all;
>> -		};
>> -
>> -		serial@78b0000 {
>> -			bootph-all;
>> -		};
>> -	};
>> -};
>> -
>> -
>> -&pm8916_gpios {
>> -	usb_hub_reset_pm {
>> -		gpios = <&pm8916_gpios 2 0>;
>> -	};
>> -
>> -	usb_sw_sel_pm {
>> -		gpios = <&pm8916_gpios 3 0>;
>> -	};
>> -};
>> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
>> index a42b68fee8c0..8933c64e56e5 100644
>> --- a/arch/arm/dts/dragonboard410c.dts
>> +++ b/arch/arm/dts/dragonboard410c.dts
>> @@ -7,193 +7,40 @@
>>  
>>  /dts-v1/;
>>  
>> -#include "skeleton64.dtsi"
>>  #include <dt-bindings/gpio/gpio.h>
>>  
>> +#include "msm8916-pm8916.dtsi"
>> +
>>  / {
>>  	model = "Qualcomm Technologies, Inc. Dragonboard 410c";
>>  	compatible = "qcom,apq8016-sbc", "qcom,apq8016";
>>  	qcom,msm-id = <0xce 0x0 0xf8 0x0 0xf9 0x0 0xfa 0x0 0xf7 0x0>;
>>  	qcom,board-id = <0x10018 0x0>;
>> -	#address-cells = <0x2>;
>> -	#size-cells = <0x2>;
>>  
>>  	aliases {
>>  		usb0 = "/soc/ehci@78d9000";
>> +		serial0 = &blsp1_uart2;
>>  	};
>>  
>> -	memory {
>> +	memory@80000000 {
>>  		device_type = "memory";
>>  		reg = <0 0x80000000 0 0x3da00000>;
>>  	};
>>  
>> -	reserved-memory {
>> -		#address-cells = <2>;
>> -		#size-cells = <2>;
>> -		ranges;
>> -
>> -		smem_mem: smem_region@86300000 {
>> -			reg = <0x0 0x86300000 0x0 0x100000>;
>> -			no-map;
>> -		};
>> -	};
>> -
>>  	chosen {
>>  		stdout-path = "/soc/serial@78b0000";
>>  	};
>>  
>> -	smem {
>> -		compatible = "qcom,smem";
>> -		memory-region = <&smem_mem>;
>> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
>> -	};
>> -
>> -	soc {
>> -		#address-cells = <0x1>;
>> -		#size-cells = <0x1>;
>> -		ranges = <0x0 0x0 0x0 0xffffffff>;
>> -		compatible = "simple-bus";
>> -
>> -		rpm_msg_ram: memory@60000 {
>> -			compatible = "qcom,rpm-msg-ram";
>> -			reg = <0x60000 0x8000>;
>> -		};
>> -
>> -		soc_gpios: pinctrl@1000000 {
>> -			compatible = "qcom,msm8916-pinctrl";
>> -			reg = <0x1000000 0x400000>;
>> -			gpio-controller;
>> -			gpio-count = <122>;
>> -			gpio-bank-name="soc";
>> -			#gpio-cells = <2>;
>> -
>> -			blsp1_uart: uart {
>> -				function = "blsp1_uart";
>> -				pins = "GPIO_4", "GPIO_5";
>> -				drive-strength = <8>;
>> -				bias-disable;
>> -			};
>> -		};
>> -		clkc: qcom,gcc@1800000 {
>> -			compatible = "qcom,gcc-msm8916";
>> -			reg = <0x1800000 0x80000>;
>> -			#address-cells = <0x1>;
>> -			#size-cells = <0x0>;
>> -			#clock-cells = <0x1>;
>> -		};
>> -
>> -		serial@78b0000 {
>> -			compatible = "qcom,msm-uartdm-v1.4";
>> -			reg = <0x78b0000 0x200>;
>> -			clocks = <&clkc 4>;
>> -			clock-names = "core";
>> -			pinctrl-names = "uart";
>> -			pinctrl-0 = <&blsp1_uart>;
>> -		};
>> -
>> -		ehci@78d9000 {
>> -			compatible = "qcom,ci-hdrc";
>> -			reg = <0x78d9000 0x400>;
>> -			phys = <&ehci_phy>;
>> -		};
>> -
>> -		ehci_phy: ehci_phy@78d9000 {
>> -			compatible = "qcom,usb-hs-phy-msm8916";
>> -			reg = <0x78d9000 0x400>;
>> -			#phy-cells = <0>;
>> -		};
>> -
>> -		sdhci@07824000 {
>> -			compatible = "qcom,sdhci-msm-v4";
>> -			reg = <0x7824900 0x11c 0x7824000 0x800>;
>> -			bus-width = <0x8>;
>> -			index = <0x0>;
>> -			non-removable;
>> -			clock = <&clkc 0>;
>> -			clock-frequency = <100000000>;
>> -		};
>> -
>> -		sdhci@07864000 {
>> -			compatible = "qcom,sdhci-msm-v4";
>> -			reg = <0x7864900 0x11c 0x7864000 0x800>;
>> -			index = <0x1>;
>> -			bus-width = <0x4>;
>> -			clock = <&clkc 1>;
>> -			clock-frequency = <200000000>;
>> -			cd-gpios = <&soc_gpios 38 GPIO_ACTIVE_LOW>;
>> -		};
>> -
>> -		wcnss {
>> -			bt {
>> -				compatible="qcom,wcnss-bt";
>> -			};
>> -
>> -			wifi {
>> -				compatible="qcom,wcnss-wlan";
>> -			};
>> -		};
>> -
>> -		spmi_bus: spmi@200f000 {
>> -			compatible = "qcom,spmi-pmic-arb";
>> -			reg = <0x0200f000 0x001000>,
>> -			      <0x02400000 0x400000>,
>> -			      <0x02c00000 0x400000>,
>> -			      <0x03800000 0x200000>,
>> -			      <0x0200a000 0x002100>;
>> -			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>> -			#address-cells = <0x1>;
>> -			#size-cells = <0x1>;
>> -			pmic0: pm8916@0 {
>> -				compatible = "qcom,spmi-pmic";
>> -				reg = <0x0 0x1>;
>> -				#address-cells = <0x1>;
>> -				#size-cells = <0x1>;
>> -
>> -				pon@800 {
>> -					compatible = "qcom,pm8916-pon";
>> -					reg = <0x800 0x100>;
>> -					mode-bootloader = <0x2>;
>> -					mode-recovery = <0x1>;
>> -
>> -					pwrkey {
>> -						compatible = "qcom,pm8941-pwrkey";
>> -						debounce = <15625>;
>> -						bias-pull-up;
>> -					};
>> -
>> -					pm8916_resin: resin {
>> -						compatible = "qcom,pm8941-resin";
>> -						debounce = <15625>;
>> -						bias-pull-up;
>> -					};
>> -				};
>> -
>> -				pm8916_gpios: pm8916_gpios@c000 {
>> -					compatible = "qcom,pm8916-gpio";
>> -					reg = <0xc000 0x400>;
>> -					gpio-controller;
>> -					gpio-ranges = <&pm8916_gpios 0 0 4>;
>> -					#gpio-cells = <2>;
>> -				};
>> -			};
>> -
>> -			pmic1: pm8916@1 {
>> -				compatible = "qcom,spmi-pmic";
>> -				reg = <0x1 0x1>;
>> -			};
>> -		};
>> -	};
>> -
>>  	leds {
>>  		compatible = "gpio-leds";
>>  		user1 {
>>  			label = "green:user1";
>> -			gpios = <&soc_gpios 21 0>;
>> +			gpios = <&msmgpio 21 0>;
>>  		};
>>  
>>  		user2 {
>>  			label = "green:user2";
>> -			gpios = <&soc_gpios 120 0>;
>> +			gpios = <&msmgpio 120 0>;
>>  		};
>>  
>>  		user3 {
>> @@ -208,4 +55,35 @@
>>  	};
>>  };
>>  
>> -#include "dragonboard410c-uboot.dtsi"
>> +&blsp1_uart2 {
>> +	status = "okay";
>> +};
>> +
>> +&pm8916_gpios {
>> +	usb_hub_reset_pm {
>> +		gpios = <&pm8916_gpios 2 0>;
>> +	};
>> +
>> +	usb_sw_sel_pm {
>> +		gpios = <&pm8916_gpios 3 0>;
>> +	};
>> +};
>> +
>> +&pm8916_resin {
>> +	status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +	status = "okay";
>> +	clock-frequency = <100000000>;
>> +};
>> +
>> +&sdhc_2 {
>> +	status = "okay";
>> +	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
>> +	clock-frequency = <200000000>;
>> +};
>> +
>> +&usb {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/dts/msm8916-pins.dtsi b/arch/arm/dts/msm8916-pins.dtsi
>> new file mode 100644
>> index 000000000000..33dfcf318a81
>> --- /dev/null
>> +++ b/arch/arm/dts/msm8916-pins.dtsi
>> @@ -0,0 +1,582 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +&msmgpio {
>> +
>> +	blsp1_uart1_default: blsp1-uart1-default-state {
>> +		/* TX, RX, CTS_N, RTS_N */
>> +		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>> +		function = "blsp_uart1";
>> +
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
>> +		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	blsp1_uart2_default: blsp1-uart2-default-state {
>> +		pins = "gpio4", "gpio5";
>> +		function = "blsp_uart2";
>> +
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	blsp1_uart2_sleep: blsp1-uart2-sleep-state {
>> +		pins = "gpio4", "gpio5";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi1_default: spi1-default-state {
>> +		spi-pins {
>> +			pins = "gpio0", "gpio1", "gpio3";
>> +			function = "blsp_spi1";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio2";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi1_sleep: spi1-sleep-state {
>> +		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi2_default: spi2-default-state {
>> +		spi-pins {
>> +			pins = "gpio4", "gpio5", "gpio7";
>> +			function = "blsp_spi2";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio6";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi2_sleep: spi2-sleep-state {
>> +		pins = "gpio4", "gpio5", "gpio6", "gpio7";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi3_default: spi3-default-state {
>> +		spi-pins {
>> +			pins = "gpio8", "gpio9", "gpio11";
>> +			function = "blsp_spi3";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio10";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi3_sleep: spi3-sleep-state {
>> +		pins = "gpio8", "gpio9", "gpio10", "gpio11";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi4_default: spi4-default-state {
>> +		spi-pins {
>> +			pins = "gpio12", "gpio13", "gpio15";
>> +			function = "blsp_spi4";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio14";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi4_sleep: spi4-sleep-state {
>> +		pins = "gpio12", "gpio13", "gpio14", "gpio15";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi5_default: spi5-default-state {
>> +		spi-pins {
>> +			pins = "gpio16", "gpio17", "gpio19";
>> +			function = "blsp_spi5";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio18";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi5_sleep: spi5-sleep-state {
>> +		pins = "gpio16", "gpio17", "gpio18", "gpio19";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi6_default: spi6-default-state {
>> +		spi-pins {
>> +			pins = "gpio20", "gpio21", "gpio23";
>> +			function = "blsp_spi6";
>> +
>> +			drive-strength = <12>;
>> +			bias-disable;
>> +		};
>> +		cs-pins {
>> +			pins = "gpio22";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spi6_sleep: spi6-sleep-state {
>> +		pins = "gpio20", "gpio21", "gpio22", "gpio23";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	i2c1_default: i2c1-default-state {
>> +		pins = "gpio2", "gpio3";
>> +		function = "blsp_i2c1";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c1_sleep: i2c1-sleep-state {
>> +		pins = "gpio2", "gpio3";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c2_default: i2c2-default-state {
>> +		pins = "gpio6", "gpio7";
>> +		function = "blsp_i2c2";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c2_sleep: i2c2-sleep-state {
>> +		pins = "gpio6", "gpio7";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c3_default: i2c3-default-state {
>> +		pins = "gpio10", "gpio11";
>> +		function = "blsp_i2c3";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c3_sleep: i2c3-sleep-state {
>> +		pins = "gpio10", "gpio11";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c4_default: i2c4-default-state {
>> +		pins = "gpio14", "gpio15";
>> +		function = "blsp_i2c4";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c4_sleep: i2c4-sleep-state {
>> +		pins = "gpio14", "gpio15";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c5_default: i2c5-default-state {
>> +		pins = "gpio18", "gpio19";
>> +		function = "blsp_i2c5";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c5_sleep: i2c5-sleep-state {
>> +		pins = "gpio18", "gpio19";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c6_default: i2c6-default-state {
>> +		pins = "gpio22", "gpio23";
>> +		function = "blsp_i2c6";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	i2c6_sleep: i2c6-sleep-state {
>> +		pins = "gpio22", "gpio23";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	pmx-sdc1-clk-state {
>> +		sdc1_clk_on: clk-on-pins {
>> +			pins = "sdc1_clk";
>> +
>> +			bias-disable;
>> +			drive-strength = <16>;
>> +		};
>> +		sdc1_clk_off: clk-off-pins {
>> +			pins = "sdc1_clk";
>> +
>> +			bias-disable;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc1-cmd-state {
>> +		sdc1_cmd_on: cmd-on-pins {
>> +			pins = "sdc1_cmd";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <10>;
>> +		};
>> +		sdc1_cmd_off: cmd-off-pins {
>> +			pins = "sdc1_cmd";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc1-data-state {
>> +		sdc1_data_on: data-on-pins {
>> +			pins = "sdc1_data";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <10>;
>> +		};
>> +		sdc1_data_off: data-off-pins {
>> +			pins = "sdc1_data";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc2-clk-state {
>> +		sdc2_clk_on: clk-on-pins {
>> +			pins = "sdc2_clk";
>> +
>> +			bias-disable;
>> +			drive-strength = <16>;
>> +		};
>> +		sdc2_clk_off: clk-off-pins {
>> +			pins = "sdc2_clk";
>> +
>> +			bias-disable;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc2-cmd-state {
>> +		sdc2_cmd_on: cmd-on-pins {
>> +			pins = "sdc2_cmd";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <10>;
>> +		};
>> +		sdc2_cmd_off: cmd-off-pins {
>> +			pins = "sdc2_cmd";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc2-data-state {
>> +		sdc2_data_on: data-on-pins {
>> +			pins = "sdc2_data";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <10>;
>> +		};
>> +		sdc2_data_off: data-off-pins {
>> +			pins = "sdc2_data";
>> +
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +	};
>> +
>> +	pmx-sdc2-cd-pin-state {
>> +		sdc2_cd_on: cd-on-pins {
>> +			pins = "gpio38";
>> +			function = "gpio";
>> +
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +		};
>> +		sdc2_cd_off: cd-off-pins {
>> +			pins = "gpio38";
>> +			function = "gpio";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	cdc-pdm-lines-state {
>> +		cdc_pdm_lines_act: pdm-lines-on-pins {
>> +			pins = "gpio63", "gpio64", "gpio65", "gpio66",
>> +			       "gpio67", "gpio68";
>> +			function = "cdc_pdm0";
>> +
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +		cdc_pdm_lines_sus: pdm-lines-off-pins {
>> +			pins = "gpio63", "gpio64", "gpio65", "gpio66",
>> +			       "gpio67", "gpio68";
>> +			function = "cdc_pdm0";
>> +
>> +			drive-strength = <2>;
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	ext-pri-tlmm-lines-state {
>> +		ext_pri_tlmm_lines_act: ext-pa-on-pins {
>> +			pins = "gpio113", "gpio114", "gpio115", "gpio116";
>> +			function = "pri_mi2s";
>> +
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +		ext_pri_tlmm_lines_sus: ext-pa-off-pins {
>> +			pins = "gpio113", "gpio114", "gpio115", "gpio116";
>> +			function = "pri_mi2s";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	ext-pri-ws-line-state {
>> +		ext_pri_ws_act: ext-pa-on-pins {
>> +			pins = "gpio110";
>> +			function = "pri_mi2s_ws";
>> +
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +		ext_pri_ws_sus: ext-pa-off-pins {
>> +			pins = "gpio110";
>> +			function = "pri_mi2s_ws";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	ext-mclk-tlmm-lines-state {
>> +		ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
>> +			pins = "gpio116";
>> +			function = "pri_mi2s";
>> +
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +		ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
>> +			pins = "gpio116";
>> +			function = "pri_mi2s";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	/* secondary Mi2S */
>> +	ext-sec-tlmm-lines-state {
>> +		ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
>> +			pins = "gpio112", "gpio117", "gpio118", "gpio119";
>> +			function = "sec_mi2s";
>> +
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +		ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
>> +			pins = "gpio112", "gpio117", "gpio118", "gpio119";
>> +			function = "sec_mi2s";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	cdc_dmic_lines_act: cdc-dmic-lines-on-state {
>> +		clk-pins {
>> +			pins = "gpio0";
>> +			function = "dmic0_clk";
>> +
>> +			drive-strength = <8>;
>> +		};
>> +		data-pins {
>> +			pins = "gpio1";
>> +			function = "dmic0_data";
>> +
>> +			drive-strength = <8>;
>> +		};
>> +	};
>> +	cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
>> +		clk-pins {
>> +			pins = "gpio0";
>> +			function = "dmic0_clk";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +		data-pins {
>> +			pins = "gpio1";
>> +			function = "dmic0_data";
>> +
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	wcnss_pin_a: wcnss-active-state {
>> +		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
>> +		function = "wcss_wlan";
>> +
>> +		drive-strength = <6>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	cci0_default: cci0-default-state {
>> +		pins = "gpio29", "gpio30";
>> +		function = "cci_i2c";
>> +
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	camera_front_default: camera-front-default-state {
>> +		pwdn-pins {
>> +			pins = "gpio33";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +		rst-pins {
>> +			pins = "gpio28";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +		mclk1-pins {
>> +			pins = "gpio27";
>> +			function = "cam_mclk1";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>> +	camera_rear_default: camera-rear-default-state {
>> +		pwdn-pins {
>> +			pins = "gpio34";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +		rst-pins {
>> +			pins = "gpio35";
>> +			function = "gpio";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +		mclk0-pins {
>> +			pins = "gpio26";
>> +			function = "cam_mclk0";
>> +
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/dts/msm8916-pm8916.dtsi b/arch/arm/dts/msm8916-pm8916.dtsi
>> new file mode 100644
>> index 000000000000..6eb5e0a39510
>> --- /dev/null
>> +++ b/arch/arm/dts/msm8916-pm8916.dtsi
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include "msm8916.dtsi"
>> +#include "pm8916.dtsi"
>> +
>> +&camss {
>> +	vdda-supply = <&pm8916_l2>;
>> +};
>> +
>> +&dsi0 {
>> +	vdda-supply = <&pm8916_l2>;
>> +	vddio-supply = <&pm8916_l6>;
>> +};
>> +
>> +&dsi_phy0 {
>> +	vddio-supply = <&pm8916_l6>;
>> +};
>> +
>> +&mpss {
>> +	pll-supply = <&pm8916_l7>;
>> +};
>> +
>> +&sdhc_1 {
>> +	vmmc-supply = <&pm8916_l8>;
>> +	vqmmc-supply = <&pm8916_l5>;
>> +};
>> +
>> +&sdhc_2 {
>> +	vmmc-supply = <&pm8916_l11>;
>> +	vqmmc-supply = <&pm8916_l12>;
>> +};
>> +
>> +&usb_hs_phy {
>> +	v1p8-supply = <&pm8916_l7>;
>> +	v3p3-supply = <&pm8916_l13>;
>> +};
>> +
>> +&wcnss {
>> +	vddpx-supply = <&pm8916_l7>;
>> +};
>> +
>> +&wcnss_iris {
>> +	vddxo-supply = <&pm8916_l7>;
>> +	vddrfa-supply = <&pm8916_s3>;
>> +	vddpa-supply = <&pm8916_l9>;
>> +	vdddig-supply = <&pm8916_l5>;
>> +};
>> +
>> +&rpm_requests {
>> +	smd_rpm_regulators: regulators {
>> +		compatible = "qcom,rpm-pm8916-regulators";
>> +
>> +		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
>> +		pm8916_s3: s3 {};
>> +		pm8916_s4: s4 {};
>> +
>> +		pm8916_l1: l1 {};
>> +		pm8916_l2: l2 {};
>> +		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
>> +		pm8916_l4: l4 {};
>> +		pm8916_l5: l5 {};
>> +		pm8916_l6: l6 {};
>> +		pm8916_l7: l7 {};
>> +		pm8916_l8: l8 {};
>> +		pm8916_l9: l9 {};
>> +		pm8916_l10: l10 {};
>> +		pm8916_l11: l11 {};
>> +		pm8916_l12: l12 {};
>> +		pm8916_l13: l13 {};
>> +		pm8916_l14: l14 {};
>> +		pm8916_l15: l15 {};
>> +		pm8916_l16: l16 {};
>> +		pm8916_l17: l17 {};
>> +		pm8916_l18: l18 {};
>> +	};
>> +};
>> diff --git a/arch/arm/dts/msm8916.dtsi b/arch/arm/dts/msm8916.dtsi
>> new file mode 100644
>> index 000000000000..834e0b66b7f2
>> --- /dev/null
>> +++ b/arch/arm/dts/msm8916.dtsi
>> @@ -0,0 +1,2194 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/arm/coresight-cti-dt.h>
>> +#include <dt-bindings/clock/qcom,gcc-msm8916.h>
>> +#include <dt-bindings/clock/qcom,rpmcc.h>
>> +#include <dt-bindings/interconnect/qcom,msm8916.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/reset/qcom,gcc-msm8916.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
>> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
>> +	};
>> +
>> +	chosen { };
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the reg */
>> +		reg = <0 0x80000000 0 0>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		tz-apps@86000000 {
>> +			reg = <0x0 0x86000000 0x0 0x300000>;
>> +			no-map;
>> +		};
>> +
>> +		smem@86300000 {
>> +			compatible = "qcom,smem";
>> +			reg = <0x0 0x86300000 0x0 0x100000>;
>> +			no-map;
>> +
>> +			hwlocks = <&tcsr_mutex 3>;
>> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
>> +		};
>> +
>> +		hypervisor@86400000 {
>> +			reg = <0x0 0x86400000 0x0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		tz@86500000 {
>> +			reg = <0x0 0x86500000 0x0 0x180000>;
>> +			no-map;
>> +		};
>> +
>> +		reserved@86680000 {
>> +			reg = <0x0 0x86680000 0x0 0x80000>;
>> +			no-map;
>> +		};
>> +
>> +		rmtfs@86700000 {
>> +			compatible = "qcom,rmtfs-mem";
>> +			reg = <0x0 0x86700000 0x0 0xe0000>;
>> +			no-map;
>> +
>> +			qcom,client-id = <1>;
>> +		};
>> +
>> +		rfsa@867e0000 {
>> +			reg = <0x0 0x867e0000 0x0 0x20000>;
>> +			no-map;
>> +		};
>> +
>> +		mpss_mem: mpss@86800000 {
>> +			reg = <0x0 0x86800000 0x0 0x2b00000>;
>> +			no-map;
>> +		};
>> +
>> +		wcnss_mem: wcnss@89300000 {
>> +			reg = <0x0 0x89300000 0x0 0x600000>;
>> +			no-map;
>> +		};
>> +
>> +		venus_mem: venus@89900000 {
>> +			reg = <0x0 0x89900000 0x0 0x600000>;
>> +			no-map;
>> +		};
>> +
>> +		mba_mem: mba@8ea00000 {
>> +			no-map;
>> +			reg = <0 0x8ea00000 0 0x100000>;
>> +		};
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <19200000>;
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x0>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>> +			qcom,acc = <&cpu0_acc>;
>> +			qcom,saw = <&cpu0_saw>;
>> +		};
>> +
>> +		CPU1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x1>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD1>;
>> +			power-domain-names = "psci";
>> +			qcom,acc = <&cpu1_acc>;
>> +			qcom,saw = <&cpu1_saw>;
>> +		};
>> +
>> +		CPU2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x2>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD2>;
>> +			power-domain-names = "psci";
>> +			qcom,acc = <&cpu2_acc>;
>> +			qcom,saw = <&cpu2_saw>;
>> +		};
>> +
>> +		CPU3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x3>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD3>;
>> +			power-domain-names = "psci";
>> +			qcom,acc = <&cpu3_acc>;
>> +			qcom,saw = <&cpu3_saw>;
>> +		};
>> +
>> +		L2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			CPU_SLEEP_0: cpu-sleep-0 {
>> +				compatible = "arm,idle-state";
>> +				idle-state-name = "standalone-power-collapse";
>> +				arm,psci-suspend-param = <0x40000002>;
>> +				entry-latency-us = <130>;
>> +				exit-latency-us = <150>;
>> +				min-residency-us = <2000>;
>> +				local-timer-stop;
>> +			};
>> +		};
>> +
>> +		domain-idle-states {
>> +
>> +			CLUSTER_RET: cluster-retention {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000012>;
>> +				entry-latency-us = <500>;
>> +				exit-latency-us = <500>;
>> +				min-residency-us = <2000>;
>> +			};
>> +
>> +			CLUSTER_PWRDN: cluster-gdhs {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000032>;
>> +				entry-latency-us = <2000>;
>> +				exit-latency-us = <2000>;
>> +				min-residency-us = <6000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	cpu_opp_table: opp-table-cpu {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-200000000 {
>> +			opp-hz = /bits/ 64 <200000000>;
>> +		};
>> +		opp-400000000 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +		};
>> +		opp-800000000 {
>> +			opp-hz = /bits/ 64 <800000000>;
>> +		};
>> +		opp-998400000 {
>> +			opp-hz = /bits/ 64 <998400000>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm: scm {
>> +			compatible = "qcom,scm-msm8916", "qcom,scm";
>> +			clocks = <&gcc GCC_CRYPTO_CLK>,
>> +				 <&gcc GCC_CRYPTO_AXI_CLK>,
>> +				 <&gcc GCC_CRYPTO_AHB_CLK>;
>> +			clock-names = "core", "bus", "iface";
>> +			#reset-cells = <1>;
>> +
>> +			qcom,dload-mode = <&tcsr 0x6100>;
>> +		};
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +
>> +		CPU_PD0: power-domain-cpu0 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD1: power-domain-cpu1 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD2: power-domain-cpu2 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD3: power-domain-cpu3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cluster {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
>> +		};
>> +	};
>> +
>> +	smd {
>> +		compatible = "qcom,smd";
>> +
>> +		rpm {
>> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +			qcom,ipc = <&apcs 8 0>;
>> +			qcom,smd-edge = <15>;
>> +
>> +			rpm_requests: rpm-requests {
>> +				compatible = "qcom,rpm-msm8916";
>> +				qcom,smd-channels = "rpm_requests";
>> +
>> +				rpmcc: clock-controller {
>> +					compatible = "qcom,rpmcc-msm8916", "qcom,rpmcc";
>> +					#clock-cells = <1>;
>> +					clocks = <&xo_board>;
>> +					clock-names = "xo";
>> +				};
>> +
>> +				rpmpd: power-controller {
>> +					compatible = "qcom,msm8916-rpmpd";
>> +					#power-domain-cells = <1>;
>> +					operating-points-v2 = <&rpmpd_opp_table>;
>> +
>> +					rpmpd_opp_table: opp-table {
>> +						compatible = "operating-points-v2";
>> +
>> +						rpmpd_opp_ret: opp1 {
>> +							opp-level = <1>;
>> +						};
>> +						rpmpd_opp_svs_krait: opp2 {
>> +							opp-level = <2>;
>> +						};
>> +						rpmpd_opp_svs_soc: opp3 {
>> +							opp-level = <3>;
>> +						};
>> +						rpmpd_opp_nom: opp4 {
>> +							opp-level = <4>;
>> +						};
>> +						rpmpd_opp_turbo: opp5 {
>> +							opp-level = <5>;
>> +						};
>> +						rpmpd_opp_super_turbo: opp6 {
>> +							opp-level = <6>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	smp2p-hexagon {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <435>, <428>;
>> +
>> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		qcom,ipc = <&apcs 8 14>;
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <1>;
>> +
>> +		hexagon_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		hexagon_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	smp2p-wcnss {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <451>, <431>;
>> +
>> +		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		qcom,ipc = <&apcs 8 18>;
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <4>;
>> +
>> +		wcnss_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		wcnss_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	smsm {
>> +		compatible = "qcom,smsm";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		qcom,ipc-1 = <&apcs 8 13>;
>> +		qcom,ipc-3 = <&apcs 8 19>;
>> +
>> +		apps_smsm: apps@0 {
>> +			reg = <0>;
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		hexagon_smsm: hexagon@1 {
>> +			reg = <1>;
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		wcnss_smsm: wcnss@6 {
>> +			reg = <6>;
>> +			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
>> +
>> +		rng@22000 {
>> +			compatible = "qcom,prng";
>> +			reg = <0x00022000 0x200>;
>> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
>> +			clock-names = "core";
>> +		};
>> +
>> +		restart@4ab000 {
>> +			compatible = "qcom,pshold";
>> +			reg = <0x004ab000 0x4>;
>> +		};
>> +
>> +		qfprom: qfprom@5c000 {
>> +			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
>> +			reg = <0x0005c000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			tsens_base1: base1@d0 {
>> +				reg = <0xd0 0x1>;
>> +				bits = <0 7>;
>> +			};
>> +
>> +			tsens_s0_p1: s0-p1@d0 {
>> +				reg = <0xd0 0x2>;
>> +				bits = <7 5>;
>> +			};
>> +
>> +			tsens_s0_p2: s0-p2@d1 {
>> +				reg = <0xd1 0x2>;
>> +				bits = <4 5>;
>> +			};
>> +
>> +			tsens_s1_p1: s1-p1@d2 {
>> +				reg = <0xd2 0x1>;
>> +				bits = <1 5>;
>> +			};
>> +			tsens_s1_p2: s1-p2@d2 {
>> +				reg = <0xd2 0x2>;
>> +				bits = <6 5>;
>> +			};
>> +			tsens_s2_p1: s2-p1@d3 {
>> +				reg = <0xd3 0x1>;
>> +				bits = <3 5>;
>> +			};
>> +
>> +			tsens_s2_p2: s2-p2@d4 {
>> +				reg = <0xd4 0x1>;
>> +				bits = <0 5>;
>> +			};
>> +
>> +			// no tsens with hw_id 3
>> +
>> +			tsens_s4_p1: s4-p1@d4 {
>> +				reg = <0xd4 0x2>;
>> +				bits = <5 5>;
>> +			};
>> +
>> +			tsens_s4_p2: s4-p2@d5 {
>> +				reg = <0xd5 0x1>;
>> +				bits = <2 5>;
>> +			};
>> +
>> +			tsens_s5_p1: s5-p1@d5 {
>> +				reg = <0xd5 0x2>;
>> +				bits = <7 5>;
>> +			};
>> +
>> +			tsens_s5_p2: s5-p2@d6 {
>> +				reg = <0xd6 0x2>;
>> +				bits = <4 5>;
>> +			};
>> +
>> +			tsens_base2: base2@d7 {
>> +				reg = <0xd7 0x1>;
>> +				bits = <1 7>;
>> +			};
>> +
>> +			tsens_mode: mode@ef {
>> +				reg = <0xef 0x1>;
>> +				bits = <5 3>;
>> +			};
>> +		};
>> +
>> +		rpm_msg_ram: sram@60000 {
>> +			compatible = "qcom,rpm-msg-ram";
>> +			reg = <0x00060000 0x8000>;
>> +		};
>> +
>> +		sram@290000 {
>> +			compatible = "qcom,msm8916-rpm-stats";
>> +			reg = <0x00290000 0x10000>;
>> +		};
>> +
>> +		bimc: interconnect@400000 {
>> +			compatible = "qcom,msm8916-bimc";
>> +			reg = <0x00400000 0x62000>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +		};
>> +
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>> +			reg = <0x004a9000 0x1000>, /* TM */
>> +			      <0x004a8000 0x1000>; /* SROT */
>> +
>> +			// no hw_id 3
>> +			nvmem-cells = <&tsens_mode>,
>> +				      <&tsens_base1>, <&tsens_base2>,
>> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
>> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
>> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
>> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
>> +				      <&tsens_s5_p1>, <&tsens_s5_p2>;
>> +			nvmem-cell-names = "mode",
>> +					   "base1", "base2",
>> +					   "s0_p1", "s0_p2",
>> +					   "s1_p1", "s1_p2",
>> +					   "s2_p1", "s2_p2",
>> +					   "s4_p1", "s4_p2",
>> +					   "s5_p1", "s5_p2";
>> +			#qcom,sensors = <5>;
>> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "uplow";
>> +			#thermal-sensor-cells = <1>;
>> +		};
>> +
>> +		pcnoc: interconnect@500000 {
>> +			compatible = "qcom,msm8916-pcnoc";
>> +			reg = <0x00500000 0x11000>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
>> +		};
>> +
>> +		snoc: interconnect@580000 {
>> +			compatible = "qcom,msm8916-snoc";
>> +			reg = <0x00580000 0x14000>;
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus", "bus_a";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +		};
>> +
>> +		stm: stm@802000 {
>> +			compatible = "arm,coresight-stm", "arm,primecell";
>> +			reg = <0x00802000 0x1000>,
>> +			      <0x09280000 0x180000>;
>> +			reg-names = "stm-base", "stm-stimulus-base";
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					stm_out: endpoint {
>> +						remote-endpoint = <&funnel0_in7>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		/* System CTIs */
>> +		/* CTI 0 - TMC connections */
>> +		cti0: cti@810000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x00810000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		/* CTI 1 - TPIU connections */
>> +		cti1: cti@811000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x00811000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		/* CTIs 2-11 - no information - not instantiated */
>> +
>> +		tpiu: tpiu@820000 {
>> +			compatible = "arm,coresight-tpiu", "arm,primecell";
>> +			reg = <0x00820000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			in-ports {
>> +				port {
>> +					tpiu_in: endpoint {
>> +						remote-endpoint = <&replicator_out1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel0: funnel@821000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x00821000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				/*
>> +				 * Not described input ports:
>> +				 * 0 - connected to Resource and Power Manger CPU ETM
>> +				 * 1 - not-connected
>> +				 * 2 - connected to Modem CPU ETM
>> +				 * 3 - not-connected
>> +				 * 5 - not-connected
>> +				 * 6 - connected trought funnel to Wireless CPU ETM
>> +				 * 7 - connected to STM component
>> +				 */
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +					funnel0_in4: endpoint {
>> +						remote-endpoint = <&funnel1_out>;
>> +					};
>> +				};
>> +
>> +				port@7 {
>> +					reg = <7>;
>> +					funnel0_in7: endpoint {
>> +						remote-endpoint = <&stm_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					funnel0_out: endpoint {
>> +						remote-endpoint = <&etf_in>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		replicator: replicator@824000 {
>> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>> +			reg = <0x00824000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +					replicator_out0: endpoint {
>> +						remote-endpoint = <&etr_in>;
>> +					};
>> +				};
>> +				port@1 {
>> +					reg = <1>;
>> +					replicator_out1: endpoint {
>> +						remote-endpoint = <&tpiu_in>;
>> +					};
>> +				};
>> +			};
>> +
>> +			in-ports {
>> +				port {
>> +					replicator_in: endpoint {
>> +						remote-endpoint = <&etf_out>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etf: etf@825000 {
>> +			compatible = "arm,coresight-tmc", "arm,primecell";
>> +			reg = <0x00825000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			in-ports {
>> +				port {
>> +					etf_in: endpoint {
>> +						remote-endpoint = <&funnel0_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					etf_out: endpoint {
>> +						remote-endpoint = <&replicator_in>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etr: etr@826000 {
>> +			compatible = "arm,coresight-tmc", "arm,primecell";
>> +			reg = <0x00826000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			in-ports {
>> +				port {
>> +					etr_in: endpoint {
>> +						remote-endpoint = <&replicator_out0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel1: funnel@841000 {	/* APSS funnel only 4 inputs are used */
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x00841000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +
>> +			status = "disabled";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +					funnel1_in0: endpoint {
>> +						remote-endpoint = <&etm0_out>;
>> +					};
>> +				};
>> +				port@1 {
>> +					reg = <1>;
>> +					funnel1_in1: endpoint {
>> +						remote-endpoint = <&etm1_out>;
>> +					};
>> +				};
>> +				port@2 {
>> +					reg = <2>;
>> +					funnel1_in2: endpoint {
>> +						remote-endpoint = <&etm2_out>;
>> +					};
>> +				};
>> +				port@3 {
>> +					reg = <3>;
>> +					funnel1_in3: endpoint {
>> +						remote-endpoint = <&etm3_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					funnel1_out: endpoint {
>> +						remote-endpoint = <&funnel0_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		debug0: debug@850000 {
>> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
>> +			reg = <0x00850000 0x1000>;
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +			cpu = <&CPU0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		debug1: debug@852000 {
>> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
>> +			reg = <0x00852000 0x1000>;
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +			cpu = <&CPU1>;
>> +			status = "disabled";
>> +		};
>> +
>> +		debug2: debug@854000 {
>> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
>> +			reg = <0x00854000 0x1000>;
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +			cpu = <&CPU2>;
>> +			status = "disabled";
>> +		};
>> +
>> +		debug3: debug@856000 {
>> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
>> +			reg = <0x00856000 0x1000>;
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +			cpu = <&CPU3>;
>> +			status = "disabled";
>> +		};
>> +
>> +		/* Core CTIs; CTIs 12-15 */
>> +		/* CTI - CPU-0 */
>> +		cti12: cti@858000 {
>> +			compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
>> +				     "arm,primecell";
>> +			reg = <0x00858000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			cpu = <&CPU0>;
>> +			arm,cs-dev-assoc = <&etm0>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		/* CTI - CPU-1 */
>> +		cti13: cti@859000 {
>> +			compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
>> +				     "arm,primecell";
>> +			reg = <0x00859000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			cpu = <&CPU1>;
>> +			arm,cs-dev-assoc = <&etm1>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		/* CTI - CPU-2 */
>> +		cti14: cti@85a000 {
>> +			compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
>> +				     "arm,primecell";
>> +			reg = <0x0085a000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			cpu = <&CPU2>;
>> +			arm,cs-dev-assoc = <&etm2>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		/* CTI - CPU-3 */
>> +		cti15: cti@85b000 {
>> +			compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
>> +				     "arm,primecell";
>> +			reg = <0x0085b000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>;
>> +			clock-names = "apb_pclk";
>> +
>> +			cpu = <&CPU3>;
>> +			arm,cs-dev-assoc = <&etm3>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		etm0: etm@85c000 {
>> +			compatible = "arm,coresight-etm4x", "arm,primecell";
>> +			reg = <0x0085c000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +			arm,coresight-loses-context-with-cpu;
>> +
>> +			cpu = <&CPU0>;
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					etm0_out: endpoint {
>> +						remote-endpoint = <&funnel1_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm1: etm@85d000 {
>> +			compatible = "arm,coresight-etm4x", "arm,primecell";
>> +			reg = <0x0085d000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +			arm,coresight-loses-context-with-cpu;
>> +
>> +			cpu = <&CPU1>;
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					etm1_out: endpoint {
>> +						remote-endpoint = <&funnel1_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm2: etm@85e000 {
>> +			compatible = "arm,coresight-etm4x", "arm,primecell";
>> +			reg = <0x0085e000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +			arm,coresight-loses-context-with-cpu;
>> +
>> +			cpu = <&CPU2>;
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					etm2_out: endpoint {
>> +						remote-endpoint = <&funnel1_in2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm3: etm@85f000 {
>> +			compatible = "arm,coresight-etm4x", "arm,primecell";
>> +			reg = <0x0085f000 0x1000>;
>> +
>> +			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> +			clock-names = "apb_pclk", "atclk";
>> +			arm,coresight-loses-context-with-cpu;
>> +
>> +			cpu = <&CPU3>;
>> +
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					etm3_out: endpoint {
>> +						remote-endpoint = <&funnel1_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		msmgpio: pinctrl@1000000 {
>> +			compatible = "qcom,msm8916-pinctrl";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			gpio-ranges = <&msmgpio 0 0 122>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		gcc: clock-controller@1800000 {
>> +			compatible = "qcom,gcc-msm8916";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +			reg = <0x01800000 0x80000>;
>> +			clocks = <&xo_board>,
>> +				 <&sleep_clk>,
>> +				 <&dsi_phy0 1>,
>> +				 <&dsi_phy0 0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>;
>> +			clock-names = "xo",
>> +				      "sleep_clk",
>> +				      "dsi0pll",
>> +				      "dsi0pllbyte",
>> +				      "ext_mclk",
>> +				      "ext_pri_i2s",
>> +				      "ext_sec_i2s";
>> +		};
>> +
>> +		tcsr_mutex: hwlock@1905000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x01905000 0x20000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		tcsr: syscon@1937000 {
>> +			compatible = "qcom,tcsr-msm8916", "syscon";
>> +			reg = <0x01937000 0x30000>;
>> +		};
>> +
>> +		mdss: display-subsystem@1a00000 {
>> +			status = "disabled";
>> +			compatible = "qcom,mdss";
>> +			reg = <0x01a00000 0x1000>,
>> +			      <0x01ac8000 0x3000>;
>> +			reg-names = "mdss_phys", "vbif_phys";
>> +
>> +			power-domains = <&gcc MDSS_GDSC>;
>> +
>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
>> +			clock-names = "iface",
>> +				      "bus",
>> +				      "vsync";
>> +
>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			mdp: display-controller@1a01000 {
>> +				compatible = "qcom,msm8916-mdp5", "qcom,mdp5";
>> +				reg = <0x01a01000 0x89000>;
>> +				reg-names = "mdp_phys";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_VSYNC_CLK>;
>> +				clock-names = "iface",
>> +					      "bus",
>> +					      "core",
>> +					      "vsync";
>> +
>> +				iommus = <&apps_iommu 4>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdp5_intf1_out: endpoint {
>> +							remote-endpoint = <&dsi0_in>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			dsi0: dsi@1a98000 {
>> +				compatible = "qcom,msm8916-dsi-ctrl",
>> +					     "qcom,mdss-dsi-ctrl";
>> +				reg = <0x01a98000 0x25c>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <4>;
>> +
>> +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
>> +						  <&gcc PCLK0_CLK_SRC>;
>> +				assigned-clock-parents = <&dsi_phy0 0>,
>> +							 <&dsi_phy0 1>;
>> +
>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
>> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
>> +					 <&gcc GCC_MDSS_ESC0_CLK>;
>> +				clock-names = "mdp_core",
>> +					      "iface",
>> +					      "bus",
>> +					      "byte",
>> +					      "pixel",
>> +					      "core";
>> +				phys = <&dsi_phy0>;
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						dsi0_in: endpoint {
>> +							remote-endpoint = <&mdp5_intf1_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						dsi0_out: endpoint {
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			dsi_phy0: phy@1a98300 {
>> +				compatible = "qcom,dsi-phy-28nm-lp";
>> +				reg = <0x01a98300 0xd4>,
>> +				      <0x01a98500 0x280>,
>> +				      <0x01a98780 0x30>;
>> +				reg-names = "dsi_pll",
>> +					    "dsi_phy",
>> +					    "dsi_phy_regulator";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&xo_board>;
>> +				clock-names = "iface", "ref";
>> +			};
>> +		};
>> +
>> +		camss: camss@1b00000 {
>> +			compatible = "qcom,msm8916-camss";
>> +			reg = <0x01b0ac00 0x200>,
>> +				<0x01b00030 0x4>,
>> +				<0x01b0b000 0x200>,
>> +				<0x01b00038 0x4>,
>> +				<0x01b08000 0x100>,
>> +				<0x01b08400 0x100>,
>> +				<0x01b0a000 0x500>,
>> +				<0x01b00020 0x10>,
>> +				<0x01b10000 0x1000>;
>> +			reg-names = "csiphy0",
>> +				"csiphy0_clk_mux",
>> +				"csiphy1",
>> +				"csiphy1_clk_mux",
>> +				"csid0",
>> +				"csid1",
>> +				"ispif",
>> +				"csi_clk_mux",
>> +				"vfe0";
>> +			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 51 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 52 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 55 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "csiphy0",
>> +				"csiphy1",
>> +				"csid0",
>> +				"csid1",
>> +				"ispif",
>> +				"vfe0";
>> +			power-domains = <&gcc VFE_GDSC>;
>> +			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_ISPIF_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0PHYTIMER_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1PHYTIMER_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0PHY_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0PIX_CLK>,
>> +				<&gcc GCC_CAMSS_CSI0RDI_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1PHY_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1PIX_CLK>,
>> +				<&gcc GCC_CAMSS_CSI1RDI_CLK>,
>> +				<&gcc GCC_CAMSS_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_VFE0_CLK>,
>> +				<&gcc GCC_CAMSS_CSI_VFE0_CLK>,
>> +				<&gcc GCC_CAMSS_VFE_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_VFE_AXI_CLK>;
>> +			clock-names = "top_ahb",
>> +				"ispif_ahb",
>> +				"csiphy0_timer",
>> +				"csiphy1_timer",
>> +				"csi0_ahb",
>> +				"csi0",
>> +				"csi0_phy",
>> +				"csi0_pix",
>> +				"csi0_rdi",
>> +				"csi1_ahb",
>> +				"csi1",
>> +				"csi1_phy",
>> +				"csi1_pix",
>> +				"csi1_rdi",
>> +				"ahb",
>> +				"vfe0",
>> +				"csi_vfe0",
>> +				"vfe_ahb",
>> +				"vfe_axi";
>> +			iommus = <&apps_iommu 3>;
>> +			status = "disabled";
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +			};
>> +		};
>> +
>> +		cci: cci@1b0c000 {
>> +			compatible = "qcom,msm8916-cci", "qcom,msm8226-cci";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x01b0c000 0x1000>;
>> +			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
>> +			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_CCI_AHB_CLK>,
>> +				<&gcc GCC_CAMSS_CCI_CLK>,
>> +				<&gcc GCC_CAMSS_AHB_CLK>;
>> +			clock-names = "camss_top_ahb", "cci_ahb",
>> +					  "cci", "camss_ahb";
>> +			assigned-clocks = <&gcc GCC_CAMSS_CCI_AHB_CLK>,
>> +					  <&gcc GCC_CAMSS_CCI_CLK>;
>> +			assigned-clock-rates = <80000000>, <19200000>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&cci0_default>;
>> +			status = "disabled";
>> +
>> +			cci_i2c0: i2c-bus@0 {
>> +				reg = <0>;
>> +				clock-frequency = <400000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +			};
>> +		};
>> +
>> +		gpu@1c00000 {
>> +			compatible = "qcom,adreno-306.0", "qcom,adreno";
>> +			reg = <0x01c00000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clock-names =
>> +			    "core",
>> +			    "iface",
>> +			    "mem",
>> +			    "mem_iface",
>> +			    "alt_mem_iface",
>> +			    "gfx3d";
>> +			clocks =
>> +			    <&gcc GCC_OXILI_GFX3D_CLK>,
>> +			    <&gcc GCC_OXILI_AHB_CLK>,
>> +			    <&gcc GCC_OXILI_GMEM_CLK>,
>> +			    <&gcc GCC_BIMC_GFX_CLK>,
>> +			    <&gcc GCC_BIMC_GPU_CLK>,
>> +			    <&gcc GFX3D_CLK_SRC>;
>> +			power-domains = <&gcc OXILI_GDSC>;
>> +			operating-points-v2 = <&gpu_opp_table>;
>> +			iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
>> +
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-400000000 {
>> +					opp-hz = /bits/ 64 <400000000>;
>> +				};
>> +				opp-19200000 {
>> +					opp-hz = /bits/ 64 <19200000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		venus: video-codec@1d00000 {
>> +			compatible = "qcom,msm8916-venus";
>> +			reg = <0x01d00000 0xff000>;
>> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>> +			power-domains = <&gcc VENUS_GDSC>;
>> +			clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
>> +				 <&gcc GCC_VENUS0_AHB_CLK>,
>> +				 <&gcc GCC_VENUS0_AXI_CLK>;
>> +			clock-names = "core", "iface", "bus";
>> +			iommus = <&apps_iommu 5>;
>> +			memory-region = <&venus_mem>;
>> +			status = "okay";
>> +
>> +			video-decoder {
>> +				compatible = "venus-decoder";
>> +			};
>> +
>> +			video-encoder {
>> +				compatible = "venus-encoder";
>> +			};
>> +		};
>> +
>> +		apps_iommu: iommu@1ef0000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#iommu-cells = <1>;
>> +			compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
>> +			ranges = <0 0x01e20000 0x40000>;
>> +			reg = <0x01ef0000 0x3000>;
>> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +				 <&gcc GCC_APSS_TCU_CLK>;
>> +			clock-names = "iface", "bus";
>> +			qcom,iommu-secure-id = <17>;
>> +
>> +			/* VFE */
>> +			iommu-ctx@3000 {
>> +				compatible = "qcom,msm-iommu-v1-sec";
>> +				reg = <0x3000 0x1000>;
>> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			/* MDP_0 */
>> +			iommu-ctx@4000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x4000 0x1000>;
>> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			/* VENUS_NS */
>> +			iommu-ctx@5000 {
>> +				compatible = "qcom,msm-iommu-v1-sec";
>> +				reg = <0x5000 0x1000>;
>> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		gpu_iommu: iommu@1f08000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#iommu-cells = <1>;
>> +			compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
>> +			ranges = <0 0x01f08000 0x10000>;
>> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +				 <&gcc GCC_GFX_TCU_CLK>;
>> +			clock-names = "iface", "bus";
>> +			qcom,iommu-secure-id = <18>;
>> +
>> +			/* GFX3D_USER */
>> +			iommu-ctx@1000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x1000 0x1000>;
>> +				interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			/* GFX3D_PRIV */
>> +			iommu-ctx@2000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x2000 0x1000>;
>> +				interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		spmi_bus: spmi@200f000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0200f000 0x001000>,
>> +			      <0x02400000 0x400000>,
>> +			      <0x02c00000 0x400000>,
>> +			      <0x03800000 0x200000>,
>> +			      <0x0200a000 0x002100>;
>> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>> +			interrupt-names = "periph_irq";
>> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>> +
>> +		bam_dmux_dma: dma-controller@4044000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x04044000 0x19000>;
>> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +
>> +			num-channels = <6>;
>> +			qcom,num-ees = <1>;
>> +			qcom,powered-remotely;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		mpss: remoteproc@4080000 {
>> +			compatible = "qcom,msm8916-mss-pil";
>> +			reg = <0x04080000 0x100>,
>> +			      <0x04020000 0x040>;
>> +
>> +			reg-names = "qdsp6", "rmb";
>> +
>> +			interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
>> +					      <&hexagon_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&hexagon_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&hexagon_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&hexagon_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready",
>> +					  "handover", "stop-ack";
>> +
>> +			power-domains = <&rpmpd MSM8916_VDDCX>,
>> +					<&rpmpd MSM8916_VDDMX>;
>> +			power-domain-names = "cx", "mx";
>> +
>> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>> +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "bus", "mem", "xo";
>> +
>> +			qcom,smem-states = <&hexagon_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			resets = <&scm 0>;
>> +			reset-names = "mss_restart";
>> +
>> +			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
>> +
>> +			status = "disabled";
>> +
>> +			mba {
>> +				memory-region = <&mba_mem>;
>> +			};
>> +
>> +			mpss {
>> +				memory-region = <&mpss_mem>;
>> +			};
>> +
>> +			bam_dmux: bam-dmux {
>> +				compatible = "qcom,bam-dmux";
>> +
>> +				interrupt-parent = <&hexagon_smsm>;
>> +				interrupts = <1 IRQ_TYPE_EDGE_BOTH>, <11 IRQ_TYPE_EDGE_BOTH>;
>> +				interrupt-names = "pc", "pc-ack";
>> +
>> +				qcom,smem-states = <&apps_smsm 1>, <&apps_smsm 11>;
>> +				qcom,smem-state-names = "pc", "pc-ack";
>> +
>> +				dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
>> +				dma-names = "tx", "rx";
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			smd-edge {
>> +				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
>> +
>> +				qcom,smd-edge = <0>;
>> +				qcom,ipc = <&apcs 8 12>;
>> +				qcom,remote-pid = <1>;
>> +
>> +				label = "hexagon";
>> +
>> +				fastrpc {
>> +					compatible = "qcom,fastrpc";
>> +					qcom,smd-channels = "fastrpcsmd-apps-dsp";
>> +					label = "adsp";
>> +					qcom,non-secure-domain;
>> +
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					cb@1 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		sound: sound@7702000 {
>> +			status = "disabled";
>> +			compatible = "qcom,apq8016-sbc-sndcard";
>> +			reg = <0x07702000 0x4>, <0x07702004 0x4>;
>> +			reg-names = "mic-iomux", "spkr-iomux";
>> +		};
>> +
>> +		lpass: audio-controller@7708000 {
>> +			status = "disabled";
>> +			compatible = "qcom,apq8016-lpass-cpu";
>> +
>> +			/*
>> +			 * Note: Unlike the name would suggest, the SEC_I2S_CLK
>> +			 * is actually only used by Tertiary MI2S while
>> +			 * Primary/Secondary MI2S both use the PRI_I2S_CLK.
>> +			 */
>> +			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_PCNOC_MPORT_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_PCNOC_SWAY_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK>,
>> +				 <&gcc GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK>;
>> +
>> +			clock-names = "ahbix-clk",
>> +					"pcnoc-mport-clk",
>> +					"pcnoc-sway-clk",
>> +					"mi2s-bit-clk0",
>> +					"mi2s-bit-clk1",
>> +					"mi2s-bit-clk2",
>> +					"mi2s-bit-clk3";
>> +			#sound-dai-cells = <1>;
>> +
>> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "lpass-irq-lpaif";
>> +			reg = <0x07708000 0x10000>;
>> +			reg-names = "lpass-lpaif";
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		lpass_codec: audio-codec@771c000 {
>> +			compatible = "qcom,msm8916-wcd-digital-codec";
>> +			reg = <0x0771c000 0x400>;
>> +			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
>> +				 <&gcc GCC_CODEC_DIGCODEC_CLK>;
>> +			clock-names = "ahbix-clk", "mclk";
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>> +		sdhc_1: mmc@7824000 {
>> +			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>> +			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>> +			reg-names = "hc", "core";
>> +
>> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			mmc-ddr-1_8v;
>> +			bus-width = <8>;
>> +			non-removable;
>> +			status = "disabled";
>> +		};
>> +
>> +		sdhc_2: mmc@7864000 {
>> +			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>> +			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
>> +			reg-names = "hc", "core";
>> +
>> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			bus-width = <4>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_dma: dma-controller@7884000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x07884000 0x23000>;
>> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "bam_clk";
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +		};
>> +
>> +		blsp1_uart1: serial@78af000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078af000 0x200>;
>> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&blsp1_uart1_default>;
>> +			pinctrl-1 = <&blsp1_uart1_sleep>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp1_uart2: serial@78b0000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078b0000 0x200>;
>> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&blsp1_uart2_default>;
>> +			pinctrl-1 = <&blsp1_uart2_sleep>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c1: i2c@78b5000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b5000 0x500>;
>> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c1_default>;
>> +			pinctrl-1 = <&i2c1_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi1: spi@78b5000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b5000 0x500>;
>> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi1_default>;
>> +			pinctrl-1 = <&spi1_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c2: i2c@78b6000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b6000 0x500>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c2_default>;
>> +			pinctrl-1 = <&i2c2_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi2: spi@78b6000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b6000 0x500>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi2_default>;
>> +			pinctrl-1 = <&spi2_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c3: i2c@78b7000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b7000 0x500>;
>> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c3_default>;
>> +			pinctrl-1 = <&i2c3_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi3: spi@78b7000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b7000 0x500>;
>> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi3_default>;
>> +			pinctrl-1 = <&spi3_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c4: i2c@78b8000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b8000 0x500>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c4_default>;
>> +			pinctrl-1 = <&i2c4_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi4: spi@78b8000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b8000 0x500>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi4_default>;
>> +			pinctrl-1 = <&spi4_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c5: i2c@78b9000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b9000 0x500>;
>> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c5_default>;
>> +			pinctrl-1 = <&i2c5_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi5: spi@78b9000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b9000 0x500>;
>> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi5_default>;
>> +			pinctrl-1 = <&spi5_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c6: i2c@78ba000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078ba000 0x500>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c6_default>;
>> +			pinctrl-1 = <&i2c6_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi6: spi@78ba000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078ba000 0x500>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi6_default>;
>> +			pinctrl-1 = <&spi6_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		usb: usb@78d9000 {
>> +			compatible = "qcom,ci-hdrc";
>> +			reg = <0x078d9000 0x200>,
>> +			      <0x078d9200 0x200>;
>> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
>> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			clock-names = "iface", "core";
>> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			assigned-clock-rates = <80000000>;
>> +			resets = <&gcc GCC_USB_HS_BCR>;
>> +			reset-names = "core";
>> +			phy_type = "ulpi";
>> +			dr_mode = "otg";
>> +			hnp-disable;
>> +			srp-disable;
>> +			adp-disable;
>> +			ahb-burst-config = <0>;
>> +			phy-names = "usb-phy";
>> +			phys = <&usb_hs_phy>;
>> +			status = "disabled";
>> +			#reset-cells = <1>;
>> +
>> +			ulpi {
>> +				usb_hs_phy: phy {
>> +					compatible = "qcom,usb-hs-phy-msm8916",
>> +						     "qcom,usb-hs-phy";
>> +					#phy-cells = <0>;
>> +					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
>> +					clock-names = "ref", "sleep";
>> +					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
>> +					reset-names = "phy", "por";
>> +					qcom,init-seq = /bits/ 8 <0x0 0x44>,
>> +								 <0x1 0x6b>,
>> +								 <0x2 0x24>,
>> +								 <0x3 0x13>;
>> +				};
>> +			};
>> +		};
>> +
>> +		wcnss: remoteproc@a21b000 {
>> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
>> +			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
>> +			reg-names = "ccu", "dxe", "pmu";
>> +
>> +			memory-region = <&wcnss_mem>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
>> +
>> +			power-domains = <&rpmpd MSM8916_VDDCX>,
>> +					<&rpmpd MSM8916_VDDMX>;
>> +			power-domain-names = "cx", "mx";
>> +
>> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&wcnss_pin_a>;
>> +
>> +			status = "disabled";
>> +
>> +			wcnss_iris: iris {
>> +				/* Separate chip, compatible is board-specific */
>> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
>> +				clock-names = "xo";
>> +			};
>> +
>> +			smd-edge {
>> +				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
>> +
>> +				qcom,ipc = <&apcs 8 17>;
>> +				qcom,smd-edge = <6>;
>> +				qcom,remote-pid = <4>;
>> +
>> +				label = "pronto";
>> +
>> +				wcnss_ctrl: wcnss {
>> +					compatible = "qcom,wcnss";
>> +					qcom,smd-channels = "WCNSS_CTRL";
>> +
>> +					qcom,mmio = <&wcnss>;
>> +
>> +					wcnss_bt: bluetooth {
>> +						compatible = "qcom,wcnss-bt";
>> +					};
>> +
>> +					wcnss_wifi: wifi {
>> +						compatible = "qcom,wcnss-wlan";
>> +
>> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>> +						interrupt-names = "tx", "rx";
>> +
>> +						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
>> +						qcom,smem-state-names = "tx-enable", "tx-rings-empty";
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		intc: interrupt-controller@b000000 {
>> +			compatible = "qcom,msm-qgic2";
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			reg = <0x0b000000 0x1000>, <0x0b002000 0x2000>,
>> +			      <0x0b001000 0x1000>, <0x0b004000 0x2000>;
>> +			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +		};
>> +
>> +		apcs: mailbox@b011000 {
>> +			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>> +			reg = <0x0b011000 0x1000>;
>> +			#mbox-cells = <1>;
>> +			clocks = <&a53pll>, <&gcc GPLL0_VOTE>;
>> +			clock-names = "pll", "aux";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		a53pll: clock@b016000 {
>> +			compatible = "qcom,msm8916-a53pll";
>> +			reg = <0x0b016000 0x40>;
>> +			#clock-cells = <0>;
>> +			clocks = <&xo_board>;
>> +			clock-names = "xo";
>> +		};
>> +
>> +		timer@b020000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x0b020000 0x1000>;
>> +			clock-frequency = <19200000>;
>> +
>> +			frame@b021000 {
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b021000 0x1000>,
>> +				      <0x0b022000 0x1000>;
>> +			};
>> +
>> +			frame@b023000 {
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b023000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b024000 {
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b024000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b025000 {
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b025000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b026000 {
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b026000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b027000 {
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b027000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b028000 {
>> +				frame-number = <6>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b028000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		cpu0_acc: power-manager@b088000 {
>> +			compatible = "qcom,msm8916-acc";
>> +			reg = <0x0b088000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu0_saw: power-manager@b089000 {
>> +			compatible = "qcom,msm8916-saw2-v3.0-cpu", "qcom,saw2";
>> +			reg = <0x0b089000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu1_acc: power-manager@b098000 {
>> +			compatible = "qcom,msm8916-acc";
>> +			reg = <0x0b098000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu1_saw: power-manager@b099000 {
>> +			compatible = "qcom,msm8916-saw2-v3.0-cpu", "qcom,saw2";
>> +			reg = <0x0b099000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu2_acc: power-manager@b0a8000 {
>> +			compatible = "qcom,msm8916-acc";
>> +			reg = <0x0b0a8000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu2_saw: power-manager@b0a9000 {
>> +			compatible = "qcom,msm8916-saw2-v3.0-cpu", "qcom,saw2";
>> +			reg = <0x0b0a9000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu3_acc: power-manager@b0b8000 {
>> +			compatible = "qcom,msm8916-acc";
>> +			reg = <0x0b0b8000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +
>> +		cpu3_saw: power-manager@b0b9000 {
>> +			compatible = "qcom,msm8916-saw2-v3.0-cpu", "qcom,saw2";
>> +			reg = <0x0b0b9000 0x1000>;
>> +			status = "reserved"; /* Controlled by PSCI firmware */
>> +		};
>> +	};
>> +
>> +	thermal-zones {
>> +		cpu0-1-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 5>;
>> +
>> +			trips {
>> +				cpu0_1_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				cpu0_1_crit: cpu-crit {
>> +					temperature = <110000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu0_1_alert0>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu2-3-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 4>;
>> +
>> +			trips {
>> +				cpu2_3_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				cpu2_3_crit: cpu-crit {
>> +					temperature = <110000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu2_3_alert0>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		gpu-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 2>;
>> +
>> +			trips {
>> +				gpu_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +				gpu_crit: gpu-crit {
>> +					temperature = <95000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		camera-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 1>;
>> +
>> +			trips {
>> +				cam_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		modem-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 0>;
>> +
>> +			trips {
>> +				modem_alert0: trip-point0 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +};
>> +
>> +#include "msm8916-pins.dtsi"
>> diff --git a/arch/arm/dts/pm8916.dtsi b/arch/arm/dts/pm8916.dtsi
>> new file mode 100644
>> index 000000000000..f4fb1a92ab55
>> --- /dev/null
>> +++ b/arch/arm/dts/pm8916.dtsi
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/spmi/spmi.h>
>> +
>> +&spmi_bus {
>> +
>> +	pm8916_0: pmic@0 {
>> +		compatible = "qcom,pm8916", "qcom,spmi-pmic";
>> +		reg = <0x0 SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pon@800 {
>> +			compatible = "qcom,pm8916-pon";
>> +			reg = <0x800>;
>> +			mode-bootloader = <0x2>;
>> +			mode-recovery = <0x1>;
>> +
>> +			pwrkey {
>> +				compatible = "qcom,pm8941-pwrkey";
>> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>> +				debounce = <15625>;
>> +				bias-pull-up;
>> +				linux,code = <KEY_POWER>;
>> +			};
>> +
>> +			pm8916_resin: resin {
>> +				compatible = "qcom,pm8941-resin";
>> +				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>> +				debounce = <15625>;
>> +				bias-pull-up;
>> +				status = "disabled";
>> +			};
>> +
>> +			watchdog {
>> +				compatible = "qcom,pm8916-wdt";
>> +				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
>> +				timeout-sec = <60>;
>> +			};
>> +		};
>> +
>> +		pm8916_usbin: usb-detect@1300 {
>> +			compatible = "qcom,pm8941-misc";
>> +			reg = <0x1300>;
>> +			interrupts = <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>;
>> +			interrupt-names = "usb_vbus";
>> +			status = "disabled";
>> +		};
>> +
>> +		pm8916_temp: temp-alarm@2400 {
>> +			compatible = "qcom,spmi-temp-alarm";
>> +			reg = <0x2400>;
>> +			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
>> +			io-channels = <&pm8916_vadc VADC_DIE_TEMP>;
>> +			io-channel-names = "thermal";
>> +			#thermal-sensor-cells = <0>;
>> +		};
>> +
>> +		pm8916_vadc: adc@3100 {
>> +			compatible = "qcom,spmi-vadc";
>> +			reg = <0x3100>;
>> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			#io-channel-cells = <1>;
>> +
>> +			adc-chan@0 {
>> +				reg = <VADC_USBIN>;
>> +				qcom,pre-scaling = <1 10>;
>> +			};
>> +			adc-chan@7 {
>> +				reg = <VADC_VSYS>;
>> +				qcom,pre-scaling = <1 3>;
>> +			};
>> +			adc-chan@8 {
>> +				reg = <VADC_DIE_TEMP>;
>> +			};
>> +			adc-chan@9 {
>> +				reg = <VADC_REF_625MV>;
>> +			};
>> +			adc-chan@a {
>> +				reg = <VADC_REF_1250MV>;
>> +			};
>> +			adc-chan@e {
>> +				reg = <VADC_GND_REF>;
>> +			};
>> +			adc-chan@f {
>> +				reg = <VADC_VDD_VADC>;
>> +			};
>> +		};
>> +
>> +		rtc@6000 {
>> +			compatible = "qcom,pm8941-rtc";
>> +			reg = <0x6000>, <0x6100>;
>> +			reg-names = "rtc", "alarm";
>> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +
>> +		pm8916_mpps: mpps@a000 {
>> +			compatible = "qcom,pm8916-mpp", "qcom,spmi-mpp";
>> +			reg = <0xa000>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&pm8916_mpps 0 0 4>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		pm8916_gpios: gpio@c000 {
>> +			compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
>> +			reg = <0xc000>;
>> +			gpio-controller;
>> +			gpio-ranges = <&pm8916_gpios 0 0 4>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	pm8916_1: pmic@1 {
>> +		compatible = "qcom,pm8916", "qcom,spmi-pmic";
>> +		reg = <0x1 SPMI_USID>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pm8916_pwm: pwm {
>> +			compatible = "qcom,pm8916-pwm";
>> +
>> +			#pwm-cells = <2>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		pm8916_vib: vibrator@c000 {
>> +			compatible = "qcom,pm8916-vib";
>> +			reg = <0xc000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		wcd_codec: audio-codec@f000 {
>> +			compatible = "qcom,pm8916-wcd-analog-codec";
>> +			reg = <0xf000>;
>> +			reg-names = "pmic-codec-core";
>> +			clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
>> +			clock-names = "mclk";
>> +			interrupt-parent = <&spmi_bus>;
>> +			interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
>> +				     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
>> +			interrupt-names = "cdc_spk_cnp_int",
>> +					  "cdc_spk_clip_int",
>> +					  "cdc_spk_ocp_int",
>> +					  "mbhc_ins_rem_det1",
>> +					  "mbhc_but_rel_det",
>> +					  "mbhc_but_press_det",
>> +					  "mbhc_ins_rem_det",
>> +					  "mbhc_switch_int",
>> +					  "cdc_ear_ocp_int",
>> +					  "cdc_hphr_ocp_int",
>> +					  "cdc_hphl_ocp_det",
>> +					  "cdc_ear_cnp_int",
>> +					  "cdc_hphr_cnp_int",
>> +					  "cdc_hphl_cnp_int";
>> +			vdd-cdc-io-supply = <&pm8916_l5>;
>> +			vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
>> +			vdd-micbias-supply = <&pm8916_l13>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +	};
>> +};
>> diff --git a/include/dt-bindings/arm/coresight-cti-dt.h b/include/dt-bindings/arm/coresight-cti-dt.h
>> new file mode 100644
>> index 000000000000..61e7bdf8ea6e
>> --- /dev/null
>> +++ b/include/dt-bindings/arm/coresight-cti-dt.h
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides constants for the defined trigger signal
>> + * types on CoreSight CTI.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
>> +#define _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
>> +
>> +#define GEN_IO		0
>> +#define GEN_INTREQ	1
>> +#define GEN_INTACK	2
>> +#define GEN_HALTREQ	3
>> +#define GEN_RESTARTREQ	4
>> +#define PE_EDBGREQ	5
>> +#define PE_DBGRESTART	6
>> +#define PE_CTIIRQ	7
>> +#define PE_PMUIRQ	8
>> +#define PE_DBGTRIGGER	9
>> +#define ETM_EXTOUT	10
>> +#define ETM_EXTIN	11
>> +#define SNK_FULL	12
>> +#define SNK_ACQCOMP	13
>> +#define SNK_FLUSHCOMP	14
>> +#define SNK_FLUSHIN	15
>> +#define SNK_TRIGIN	16
>> +#define STM_ASYNCOUT	17
>> +#define STM_TOUT_SPTE	18
>> +#define STM_TOUT_SW	19
>> +#define STM_TOUT_HETE	20
>> +#define STM_HWEVENT	21
>> +#define ELA_TSTART	22
>> +#define ELA_TSTOP	23
>> +#define ELA_DBGREQ	24
>> +#define CTI_TRIG_MAX	25
>> +
>> +#endif /*_DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H */
>> diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
>> new file mode 100644
>> index 000000000000..46309c9953b2
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,rpmcc.h
>> @@ -0,0 +1,174 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright 2015 Linaro Limited
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MSM_RPMCC_H
>> +#define _DT_BINDINGS_CLK_MSM_RPMCC_H
>> +
>> +/* RPM clocks */
>> +#define RPM_PXO_CLK				0
>> +#define RPM_PXO_A_CLK				1
>> +#define RPM_CXO_CLK				2
>> +#define RPM_CXO_A_CLK				3
>> +#define RPM_APPS_FABRIC_CLK			4
>> +#define RPM_APPS_FABRIC_A_CLK			5
>> +#define RPM_CFPB_CLK				6
>> +#define RPM_CFPB_A_CLK				7
>> +#define RPM_QDSS_CLK				8
>> +#define RPM_QDSS_A_CLK				9
>> +#define RPM_DAYTONA_FABRIC_CLK			10
>> +#define RPM_DAYTONA_FABRIC_A_CLK		11
>> +#define RPM_EBI1_CLK				12
>> +#define RPM_EBI1_A_CLK				13
>> +#define RPM_MM_FABRIC_CLK			14
>> +#define RPM_MM_FABRIC_A_CLK			15
>> +#define RPM_MMFPB_CLK				16
>> +#define RPM_MMFPB_A_CLK				17
>> +#define RPM_SYS_FABRIC_CLK			18
>> +#define RPM_SYS_FABRIC_A_CLK			19
>> +#define RPM_SFPB_CLK				20
>> +#define RPM_SFPB_A_CLK				21
>> +#define RPM_SMI_CLK				22
>> +#define RPM_SMI_A_CLK				23
>> +#define RPM_PLL4_CLK				24
>> +#define RPM_XO_D0				25
>> +#define RPM_XO_D1				26
>> +#define RPM_XO_A0				27
>> +#define RPM_XO_A1				28
>> +#define RPM_XO_A2				29
>> +#define RPM_NSS_FABRIC_0_CLK			30
>> +#define RPM_NSS_FABRIC_0_A_CLK			31
>> +#define RPM_NSS_FABRIC_1_CLK			32
>> +#define RPM_NSS_FABRIC_1_A_CLK			33
>> +
>> +/* SMD RPM clocks */
>> +#define RPM_SMD_XO_CLK_SRC				0
>> +#define RPM_SMD_XO_A_CLK_SRC			1
>> +#define RPM_SMD_PCNOC_CLK				2
>> +#define RPM_SMD_PCNOC_A_CLK				3
>> +#define RPM_SMD_SNOC_CLK				4
>> +#define RPM_SMD_SNOC_A_CLK				5
>> +#define RPM_SMD_BIMC_CLK				6
>> +#define RPM_SMD_BIMC_A_CLK				7
>> +#define RPM_SMD_QDSS_CLK				8
>> +#define RPM_SMD_QDSS_A_CLK				9
>> +#define RPM_SMD_BB_CLK1				10
>> +#define RPM_SMD_BB_CLK1_A				11
>> +#define RPM_SMD_BB_CLK2				12
>> +#define RPM_SMD_BB_CLK2_A				13
>> +#define RPM_SMD_RF_CLK1				14
>> +#define RPM_SMD_RF_CLK1_A				15
>> +#define RPM_SMD_RF_CLK2				16
>> +#define RPM_SMD_RF_CLK2_A				17
>> +#define RPM_SMD_BB_CLK1_PIN				18
>> +#define RPM_SMD_BB_CLK1_A_PIN			19
>> +#define RPM_SMD_BB_CLK2_PIN				20
>> +#define RPM_SMD_BB_CLK2_A_PIN			21
>> +#define RPM_SMD_RF_CLK1_PIN				22
>> +#define RPM_SMD_RF_CLK1_A_PIN			23
>> +#define RPM_SMD_RF_CLK2_PIN				24
>> +#define RPM_SMD_RF_CLK2_A_PIN			25
>> +#define RPM_SMD_PNOC_CLK			26
>> +#define RPM_SMD_PNOC_A_CLK			27
>> +#define RPM_SMD_CNOC_CLK			28
>> +#define RPM_SMD_CNOC_A_CLK			29
>> +#define RPM_SMD_MMSSNOC_AHB_CLK			30
>> +#define RPM_SMD_MMSSNOC_AHB_A_CLK		31
>> +#define RPM_SMD_GFX3D_CLK_SRC			32
>> +#define RPM_SMD_GFX3D_A_CLK_SRC			33
>> +#define RPM_SMD_OCMEMGX_CLK			34
>> +#define RPM_SMD_OCMEMGX_A_CLK			35
>> +#define RPM_SMD_CXO_D0				36
>> +#define RPM_SMD_CXO_D0_A			37
>> +#define RPM_SMD_CXO_D1				38
>> +#define RPM_SMD_CXO_D1_A			39
>> +#define RPM_SMD_CXO_A0				40
>> +#define RPM_SMD_CXO_A0_A			41
>> +#define RPM_SMD_CXO_A1				42
>> +#define RPM_SMD_CXO_A1_A			43
>> +#define RPM_SMD_CXO_A2				44
>> +#define RPM_SMD_CXO_A2_A			45
>> +#define RPM_SMD_DIV_CLK1			46
>> +#define RPM_SMD_DIV_A_CLK1			47
>> +#define RPM_SMD_DIV_CLK2			48
>> +#define RPM_SMD_DIV_A_CLK2			49
>> +#define RPM_SMD_DIFF_CLK			50
>> +#define RPM_SMD_DIFF_A_CLK			51
>> +#define RPM_SMD_CXO_D0_PIN			52
>> +#define RPM_SMD_CXO_D0_A_PIN			53
>> +#define RPM_SMD_CXO_D1_PIN			54
>> +#define RPM_SMD_CXO_D1_A_PIN			55
>> +#define RPM_SMD_CXO_A0_PIN			56
>> +#define RPM_SMD_CXO_A0_A_PIN			57
>> +#define RPM_SMD_CXO_A1_PIN			58
>> +#define RPM_SMD_CXO_A1_A_PIN			59
>> +#define RPM_SMD_CXO_A2_PIN			60
>> +#define RPM_SMD_CXO_A2_A_PIN			61
>> +#define RPM_SMD_AGGR1_NOC_CLK			62
>> +#define RPM_SMD_AGGR1_NOC_A_CLK			63
>> +#define RPM_SMD_AGGR2_NOC_CLK			64
>> +#define RPM_SMD_AGGR2_NOC_A_CLK			65
>> +#define RPM_SMD_MMAXI_CLK			66
>> +#define RPM_SMD_MMAXI_A_CLK			67
>> +#define RPM_SMD_IPA_CLK				68
>> +#define RPM_SMD_IPA_A_CLK			69
>> +#define RPM_SMD_CE1_CLK				70
>> +#define RPM_SMD_CE1_A_CLK			71
>> +#define RPM_SMD_DIV_CLK3			72
>> +#define RPM_SMD_DIV_A_CLK3			73
>> +#define RPM_SMD_LN_BB_CLK			74
>> +#define RPM_SMD_LN_BB_A_CLK			75
>> +#define RPM_SMD_BIMC_GPU_CLK			76
>> +#define RPM_SMD_BIMC_GPU_A_CLK			77
>> +#define RPM_SMD_QPIC_CLK			78
>> +#define RPM_SMD_QPIC_CLK_A			79
>> +#define RPM_SMD_LN_BB_CLK1			80
>> +#define RPM_SMD_LN_BB_CLK1_A			81
>> +#define RPM_SMD_LN_BB_CLK2			82
>> +#define RPM_SMD_LN_BB_CLK2_A			83
>> +#define RPM_SMD_LN_BB_CLK3_PIN			84
>> +#define RPM_SMD_LN_BB_CLK3_A_PIN		85
>> +#define RPM_SMD_RF_CLK3				86
>> +#define RPM_SMD_RF_CLK3_A			87
>> +#define RPM_SMD_RF_CLK3_PIN			88
>> +#define RPM_SMD_RF_CLK3_A_PIN			89
>> +#define RPM_SMD_MMSSNOC_AXI_CLK			90
>> +#define RPM_SMD_MMSSNOC_AXI_CLK_A		91
>> +#define RPM_SMD_CNOC_PERIPH_CLK			92
>> +#define RPM_SMD_CNOC_PERIPH_A_CLK		93
>> +#define RPM_SMD_LN_BB_CLK3			94
>> +#define RPM_SMD_LN_BB_CLK3_A			95
>> +#define RPM_SMD_LN_BB_CLK1_PIN			96
>> +#define RPM_SMD_LN_BB_CLK1_A_PIN		97
>> +#define RPM_SMD_LN_BB_CLK2_PIN			98
>> +#define RPM_SMD_LN_BB_CLK2_A_PIN		99
>> +#define RPM_SMD_SYSMMNOC_CLK			100
>> +#define RPM_SMD_SYSMMNOC_A_CLK			101
>> +#define RPM_SMD_CE2_CLK				102
>> +#define RPM_SMD_CE2_A_CLK			103
>> +#define RPM_SMD_CE3_CLK				104
>> +#define RPM_SMD_CE3_A_CLK			105
>> +#define RPM_SMD_QUP_CLK				106
>> +#define RPM_SMD_QUP_A_CLK			107
>> +#define RPM_SMD_MMRT_CLK			108
>> +#define RPM_SMD_MMRT_A_CLK			109
>> +#define RPM_SMD_MMNRT_CLK			110
>> +#define RPM_SMD_MMNRT_A_CLK			111
>> +#define RPM_SMD_SNOC_PERIPH_CLK			112
>> +#define RPM_SMD_SNOC_PERIPH_A_CLK		113
>> +#define RPM_SMD_SNOC_LPASS_CLK			114
>> +#define RPM_SMD_SNOC_LPASS_A_CLK		115
>> +#define RPM_SMD_HWKM_CLK			116
>> +#define RPM_SMD_HWKM_A_CLK			117
>> +#define RPM_SMD_PKA_CLK				118
>> +#define RPM_SMD_PKA_A_CLK			119
>> +#define RPM_SMD_CPUSS_GNOC_CLK			120
>> +#define RPM_SMD_CPUSS_GNOC_A_CLK		121
>> +#define RPM_SMD_MSS_CFG_AHB_CLK		122
>> +#define RPM_SMD_MSS_CFG_AHB_A_CLK		123
>> +#define RPM_SMD_BIMC_FREQ_LOG			124
>> +#define RPM_SMD_LN_BB_CLK_PIN			125
>> +#define RPM_SMD_LN_BB_A_CLK_PIN			126
>> +
>> +#endif
>> diff --git a/include/dt-bindings/interconnect/qcom,msm8916.h b/include/dt-bindings/interconnect/qcom,msm8916.h
>> new file mode 100644
>> index 000000000000..359a75feb198
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,msm8916.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Qualcomm interconnect IDs
>> + *
>> + * Copyright (c) 2019, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
>> +
>> +#define BIMC_SNOC_SLV			0
>> +#define MASTER_JPEG			1
>> +#define MASTER_MDP_PORT0		2
>> +#define MASTER_QDSS_BAM			3
>> +#define MASTER_QDSS_ETR			4
>> +#define MASTER_SNOC_CFG			5
>> +#define MASTER_VFE			6
>> +#define MASTER_VIDEO_P0			7
>> +#define SNOC_MM_INT_0			8
>> +#define SNOC_MM_INT_1			9
>> +#define SNOC_MM_INT_2			10
>> +#define SNOC_MM_INT_BIMC		11
>> +#define PCNOC_SNOC_SLV			12
>> +#define SLAVE_APSS			13
>> +#define SLAVE_CATS_128			14
>> +#define SLAVE_OCMEM_64			15
>> +#define SLAVE_IMEM			16
>> +#define SLAVE_QDSS_STM			17
>> +#define SLAVE_SRVC_SNOC			18
>> +#define SNOC_BIMC_0_MAS			19
>> +#define SNOC_BIMC_1_MAS			20
>> +#define SNOC_INT_0			21
>> +#define SNOC_INT_1			22
>> +#define SNOC_INT_BIMC			23
>> +#define SNOC_PCNOC_MAS			24
>> +#define SNOC_QDSS_INT			25
>> +
>> +#define BIMC_SNOC_MAS			0
>> +#define MASTER_AMPSS_M0			1
>> +#define MASTER_GRAPHICS_3D		2
>> +#define MASTER_TCU0			3
>> +#define MASTER_TCU1			4
>> +#define SLAVE_AMPSS_L2			5
>> +#define SLAVE_EBI_CH0			6
>> +#define SNOC_BIMC_0_SLV			7
>> +#define SNOC_BIMC_1_SLV			8
>> +
>> +#define MASTER_BLSP_1			0
>> +#define MASTER_DEHR			1
>> +#define MASTER_LPASS			2
>> +#define MASTER_CRYPTO_CORE0		3
>> +#define MASTER_SDCC_1			4
>> +#define MASTER_SDCC_2			5
>> +#define MASTER_SPDM			6
>> +#define MASTER_USB_HS			7
>> +#define PCNOC_INT_0			8
>> +#define PCNOC_INT_1			9
>> +#define PCNOC_MAS_0			10
>> +#define PCNOC_MAS_1			11
>> +#define PCNOC_SLV_0			12
>> +#define PCNOC_SLV_1			13
>> +#define PCNOC_SLV_2			14
>> +#define PCNOC_SLV_3			15
>> +#define PCNOC_SLV_4			16
>> +#define PCNOC_SLV_8			17
>> +#define PCNOC_SLV_9			18
>> +#define PCNOC_SNOC_MAS			19
>> +#define SLAVE_BIMC_CFG			20
>> +#define SLAVE_BLSP_1			21
>> +#define SLAVE_BOOT_ROM			22
>> +#define SLAVE_CAMERA_CFG		23
>> +#define SLAVE_CLK_CTL			24
>> +#define SLAVE_CRYPTO_0_CFG		25
>> +#define SLAVE_DEHR_CFG			26
>> +#define SLAVE_DISPLAY_CFG		27
>> +#define SLAVE_GRAPHICS_3D_CFG		28
>> +#define SLAVE_IMEM_CFG			29
>> +#define SLAVE_LPASS			30
>> +#define SLAVE_MPM			31
>> +#define SLAVE_MSG_RAM			32
>> +#define SLAVE_MSS			33
>> +#define SLAVE_PDM			34
>> +#define SLAVE_PMIC_ARB			35
>> +#define SLAVE_PCNOC_CFG			36
>> +#define SLAVE_PRNG			37
>> +#define SLAVE_QDSS_CFG			38
>> +#define SLAVE_RBCPR_CFG			39
>> +#define SLAVE_SDCC_1			40
>> +#define SLAVE_SDCC_2			41
>> +#define SLAVE_SECURITY			42
>> +#define SLAVE_SNOC_CFG			43
>> +#define SLAVE_SPDM			44
>> +#define SLAVE_TCSR			45
>> +#define SLAVE_TLMM			46
>> +#define SLAVE_USB_HS			47
>> +#define SLAVE_VENUS_CFG			48
>> +#define SNOC_PCNOC_SLV			49
>> +
>> +#endif
>> diff --git a/include/dt-bindings/reset/qcom,gcc-msm8916.h b/include/dt-bindings/reset/qcom,gcc-msm8916.h
>> new file mode 100644
>> index 000000000000..1f9be10872df
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/qcom,gcc-msm8916.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright 2015 Linaro Limited
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_MSM_GCC_8916_H
>> +#define _DT_BINDINGS_RESET_MSM_GCC_8916_H
>> +
>> +#define GCC_BLSP1_BCR			0
>> +#define GCC_BLSP1_QUP1_BCR		1
>> +#define GCC_BLSP1_UART1_BCR		2
>> +#define GCC_BLSP1_QUP2_BCR		3
>> +#define GCC_BLSP1_UART2_BCR		4
>> +#define GCC_BLSP1_QUP3_BCR		5
>> +#define GCC_BLSP1_QUP4_BCR		6
>> +#define GCC_BLSP1_QUP5_BCR		7
>> +#define GCC_BLSP1_QUP6_BCR		8
>> +#define GCC_IMEM_BCR			9
>> +#define GCC_SMMU_BCR			10
>> +#define GCC_APSS_TCU_BCR		11
>> +#define GCC_SMMU_XPU_BCR		12
>> +#define GCC_PCNOC_TBU_BCR		13
>> +#define GCC_PRNG_BCR			14
>> +#define GCC_BOOT_ROM_BCR		15
>> +#define GCC_CRYPTO_BCR			16
>> +#define GCC_SEC_CTRL_BCR		17
>> +#define GCC_AUDIO_CORE_BCR		18
>> +#define GCC_ULT_AUDIO_BCR		19
>> +#define GCC_DEHR_BCR			20
>> +#define GCC_SYSTEM_NOC_BCR		21
>> +#define GCC_PCNOC_BCR			22
>> +#define GCC_TCSR_BCR			23
>> +#define GCC_QDSS_BCR			24
>> +#define GCC_DCD_BCR			25
>> +#define GCC_MSG_RAM_BCR			26
>> +#define GCC_MPM_BCR			27
>> +#define GCC_SPMI_BCR			28
>> +#define GCC_SPDM_BCR			29
>> +#define GCC_MM_SPDM_BCR			30
>> +#define GCC_BIMC_BCR			31
>> +#define GCC_RBCPR_BCR			32
>> +#define GCC_TLMM_BCR			33
>> +#define GCC_USB_HS_BCR			34
>> +#define GCC_USB2A_PHY_BCR		35
>> +#define GCC_SDCC1_BCR			36
>> +#define GCC_SDCC2_BCR			37
>> +#define GCC_PDM_BCR			38
>> +#define GCC_SNOC_BUS_TIMEOUT0_BCR	39
>> +#define GCC_PCNOC_BUS_TIMEOUT0_BCR	40
>> +#define GCC_PCNOC_BUS_TIMEOUT1_BCR	41
>> +#define GCC_PCNOC_BUS_TIMEOUT2_BCR	42
>> +#define GCC_PCNOC_BUS_TIMEOUT3_BCR	43
>> +#define GCC_PCNOC_BUS_TIMEOUT4_BCR	44
>> +#define GCC_PCNOC_BUS_TIMEOUT5_BCR	45
>> +#define GCC_PCNOC_BUS_TIMEOUT6_BCR	46
>> +#define GCC_PCNOC_BUS_TIMEOUT7_BCR	47
>> +#define GCC_PCNOC_BUS_TIMEOUT8_BCR	48
>> +#define GCC_PCNOC_BUS_TIMEOUT9_BCR	49
>> +#define GCC_MMSS_BCR			50
>> +#define GCC_VENUS0_BCR			51
>> +#define GCC_MDSS_BCR			52
>> +#define GCC_CAMSS_PHY0_BCR		53
>> +#define GCC_CAMSS_CSI0_BCR		54
>> +#define GCC_CAMSS_CSI0PHY_BCR		55
>> +#define GCC_CAMSS_CSI0RDI_BCR		56
>> +#define GCC_CAMSS_CSI0PIX_BCR		57
>> +#define GCC_CAMSS_PHY1_BCR		58
>> +#define GCC_CAMSS_CSI1_BCR		59
>> +#define GCC_CAMSS_CSI1PHY_BCR		60
>> +#define GCC_CAMSS_CSI1RDI_BCR		61
>> +#define GCC_CAMSS_CSI1PIX_BCR		62
>> +#define GCC_CAMSS_ISPIF_BCR		63
>> +#define GCC_CAMSS_CCI_BCR		64
>> +#define GCC_CAMSS_MCLK0_BCR		65
>> +#define GCC_CAMSS_MCLK1_BCR		66
>> +#define GCC_CAMSS_GP0_BCR		67
>> +#define GCC_CAMSS_GP1_BCR		68
>> +#define GCC_CAMSS_TOP_BCR		69
>> +#define GCC_CAMSS_MICRO_BCR		70
>> +#define GCC_CAMSS_JPEG_BCR		71
>> +#define GCC_CAMSS_VFE_BCR		72
>> +#define GCC_CAMSS_CSI_VFE0_BCR		73
>> +#define GCC_OXILI_BCR			74
>> +#define GCC_GMEM_BCR			75
>> +#define GCC_CAMSS_AHB_BCR		76
>> +#define GCC_MDP_TBU_BCR			77
>> +#define GCC_GFX_TBU_BCR			78
>> +#define GCC_GFX_TCU_BCR			79
>> +#define GCC_MSS_TBU_AXI_BCR		80
>> +#define GCC_MSS_TBU_GSS_AXI_BCR		81
>> +#define GCC_MSS_TBU_Q6_AXI_BCR		82
>> +#define GCC_GTCU_AHB_BCR		83
>> +#define GCC_SMMU_CFG_BCR		84
>> +#define GCC_VFE_TBU_BCR			85
>> +#define GCC_VENUS_TBU_BCR		86
>> +#define GCC_JPEG_TBU_BCR		87
>> +#define GCC_PRONTO_TBU_BCR		88
>> +#define GCC_SMMU_CATS_BCR		89
>> +
>> +#endif
>>
>> -- 
>> 2.42.1
>>

-- 
// Caleb (they/them)
