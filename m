Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D0C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1EDC801BE;
	Wed, 12 Mar 2025 16:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XxxAWGEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DF081870; Wed, 12 Mar 2025 16:42:59 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF02D8141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51668757de=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CFATFB016440;
 Wed, 12 Mar 2025 16:42:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 pdeOwEN7EXChm7d1p4mRrACzQ1xqFH77uuFBzt7U44g=; b=XxxAWGEKYVqFK3wB
 /cTxU/JWyRWDgWjH9Oo6p2KH/rkDK8uCtPE+/awm5n4uERmMi2+GDF8b2RU/UPM0
 KHB1BIbgjfY+BdRkwy4wzbdwrcIUFoDBAm7HZRHBcnv5aIYmjmqUFkkLUIzrE9s1
 c6i3ihyGSRjeTayh55EVxUhu3dhRLZ5mt6jrabIEzmEBo7s3/9VERhzj9T3JqG3B
 DiGTMVaTfdBH0LZnbnwCuGJqH3Kexxh0yloTx53bzQtZfywyO3/eROMThqNHthjQ
 qPZLSS5RuG6d/fnAXbscAYORgvl3zZQDO+4frS+ygmZYlJGef1bhuNKUVY1L3WYu
 VEW0PQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45au3qvjd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 16:42:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E53F84004D;
 Wed, 12 Mar 2025 16:42:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72A4A58FD37;
 Wed, 12 Mar 2025 16:41:55 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 16:41:54 +0100
Message-ID: <21c66d97-22ed-41d8-b661-4768b0c0e8a5@foss.st.com>
Date: Wed, 12 Mar 2025 16:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ARM: dts: stm32: Add TIMERS inverted PWM channel 3
 on STM32MP135F-DK
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20250311143037.818675-1-cheick.traore@foss.st.com>
 <20250311143037.818675-5-cheick.traore@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250311143037.818675-5-cheick.traore@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
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



On 3/11/25 15:30, Cheick Traore wrote:
> The pwm source TIM1_CH3N channel (on PE12) in inverted polarity mode
> will be used to manage the brightness of the panel backlight on
> STM32MP135F-DK.
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/stm32mp13-pinctrl.dtsi | 15 +++++++++++++++
>  arch/arm/dts/stm32mp135f-dk.dts     | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> index c01d39f03ea..52c2a9f24d7 100644
> --- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> @@ -215,6 +215,21 @@
>  		};
>  	};
>  
> +	pwm1_ch3n_pins_a: pwm1-ch3n-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 12, AF1)>; /* TIM1_CH3N */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_ch3n_sleep_pins_a: pwm1-ch3n-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 12, ANALOG)>; /* TIM1_CH3N */
> +		};
> +	};
> +
>  	pwm3_pins_a: pwm3-0 {
>  		pins {
>  			pinmux = <STM32_PINMUX('B', 1, AF2)>; /* TIM3_CH4 */
> diff --git a/arch/arm/dts/stm32mp135f-dk.dts b/arch/arm/dts/stm32mp135f-dk.dts
> index eea740d097c..275823da3c6 100644
> --- a/arch/arm/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/dts/stm32mp135f-dk.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
>  #include <dt-bindings/regulator/st,stm32mp13-regulator.h>
>  #include "stm32mp135.dtsi"
>  #include "stm32mp13xf.dtsi"
> @@ -207,6 +208,19 @@
>  	status = "disabled";
>  };
>  
> +&timers1 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +	pwm1: pwm {
> +		pinctrl-0 = <&pwm1_ch3n_pins_a>;
> +		pinctrl-1 = <&pwm1_ch3n_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +};
> +
>  &timers3 {
>  	/delete-property/dmas;
>  	/delete-property/dma-names;
Applied to u-boot-stm32/next

Thanks
Patrice
