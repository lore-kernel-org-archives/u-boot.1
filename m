Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8479CC021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CD480F3F;
	Mon, 24 Feb 2025 16:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="33sHd5FN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C27180F53; Mon, 24 Feb 2025 16:54:41 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4079E800B3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41501624e1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCGLjD014693;
 Mon, 24 Feb 2025 16:54:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 E8gAg0DdYRoD/K6j8Ly3Qnsgofak+lNGk9JiDDqs8LQ=; b=33sHd5FNhTXdfHjF
 MvrfBVmoRnB/EhPWokAn2NroyGuDLFg65ZvHUXSNqvahKLt7m2ATKbnCPotIkxWf
 /XejJbsxdUYKIUC67DntNIcStqFfFyD7vCpsnQGBOOhVNEFvgN5deP9sPGNtfF+d
 HcCFenKwF0Jk3vUVLISHHBZYVgn8lVjErUPzifY7D5ZckYh32W71HRdZ3SZmas0E
 AFQEZ7EM4gKUCleOxdD9ob5eON6XF1DATgXf2XCL+/hf/lGVMWRL/Ez2EtAhFdkL
 Lyj3KL5Z6SnN9IjILjFm0G5TB15eWqLqH4h5cVAJPuVe80DarnOOThVgg8MIc/N5
 egmueA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44ytdn5rr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 16:54:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B323540053;
 Mon, 24 Feb 2025 16:53:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21A74566051;
 Mon, 24 Feb 2025 16:50:57 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:50:56 +0100
Message-ID: <deb115f9-7767-43bf-a06c-04e59806c19b@foss.st.com>
Date: Mon, 24 Feb 2025 16:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: stm32: drop "st,button1" compatible
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Vikas Manocha
 <vikas.manocha@st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250217181439.1157972-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
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



On 2/17/25 19:14, Dario Binacchi wrote:
> It is pointless to use the custom compatible "st,button1" when
> stm32746g-eval.dts and stm32f769-disco.dts already contain the
> "gpio-keys" compatible, which is specifically used for button
> management. In the case of stm32f746-disco.dts, since it lacks the
> "gpio-keys" compatible, it was decided to translate "st,button1"
> into its "gpio-keys" version in stm32f746-disco-u-boot.dtsi.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  arch/arm/dts/stm32746g-eval-u-boot.dtsi    |  5 -----
>  arch/arm/dts/stm32f746-disco-u-boot.dtsi   | 11 ++++++++---
>  arch/arm/dts/stm32f769-disco-u-boot.dtsi   |  5 -----
>  board/st/stm32f746-disco/stm32f746-disco.c | 15 ---------------
>  4 files changed, 8 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32746g-eval-u-boot.dtsi b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
> index 1c288acec992..f64329287357 100644
> --- a/arch/arm/dts/stm32746g-eval-u-boot.dtsi
> +++ b/arch/arm/dts/stm32746g-eval-u-boot.dtsi
> @@ -23,11 +23,6 @@
>  		spi0 = &qspi;
>  	};
>  
> -	button1 {
> -		compatible = "st,button1";
> -		button-gpio = <&gpioc 13 0>;
> -	};
> -
>  	led1 {
>  		compatible = "st,led1";
>  		led-gpio = <&gpiof 10 0>;
> diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> index 1b42d6cbbc19..e0e2f9e23773 100644
> --- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> @@ -23,9 +23,14 @@
>  		spi0 = &qspi;
>  	};
>  
> -	button1 {
> -		compatible = "st,button1";
> -		button-gpio = <&gpioi 11 0>;
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		button-0 {
> +			label = "User";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
> +		};

No need to add gpio-keys node as CONFIG_BUTTON_GPIO is not enable in configs/stm32f746-disco_defconfig

Thanks
Patrice

>  	};
>  
>  	led1 {
> diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> index add55c96e21f..a50fba64dcd2 100644
> --- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> @@ -23,11 +23,6 @@
>  		spi0 = &qspi;
>  	};
>  
> -	button1 {
> -		compatible = "st,button1";
> -		button-gpio = <&gpioa 0 0>;
> -	};
> -
>  	led1 {
>  		compatible = "st,led1";
>  		led-gpio = <&gpioj 5 0>;
> diff --git a/board/st/stm32f746-disco/stm32f746-disco.c b/board/st/stm32f746-disco/stm32f746-disco.c
> index 8966a09501ed..65a39d965c72 100644
> --- a/board/st/stm32f746-disco/stm32f746-disco.c
> +++ b/board/st/stm32f746-disco/stm32f746-disco.c
> @@ -94,21 +94,6 @@ int board_late_init(void)
>  		dm_gpio_set_value(&gpio, 1);
>  	}
>  
> -	/* read button 1*/
> -	node = fdt_node_offset_by_compatible(gd->fdt_blob, 0, "st,button1");
> -	if (node < 0)
> -		return -1;
> -
> -	gpio_request_by_name_nodev(offset_to_ofnode(node), "button-gpio", 0,
> -				   &gpio, GPIOD_IS_IN);
> -
> -	if (dm_gpio_is_valid(&gpio)) {
> -		if (dm_gpio_get_value(&gpio))
> -			puts("usr button is at HIGH LEVEL\n");
> -		else
> -			puts("usr button is at LOW LEVEL\n");
> -	}
> -
>  	return 0;
>  }
>  


