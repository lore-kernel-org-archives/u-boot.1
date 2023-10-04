Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5378E7B5E1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BA486E79;
	Wed,  4 Oct 2023 11:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mGUD5uet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3DE86E43; Wed,  4 Oct 2023 11:28:33 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5045386E81
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3945fB4B027121; Wed, 4 Oct 2023 11:28:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=q+l8s0QLmkIKfHjlKZJS174RVbhrTAgRwPV1EWCsyJo=; b=mG
 UD5uet6lPv4pLn4i1Ts1JB6IeNwuwBSWSIjSJdowZYDHOWao3IuKaJaUwIZr7urL
 pYO0HGfHErBqyToFHAb0gofe5Svnj3g4vR+sKDw7jCNZe7jAtutWJDGKEwUMH4vQ
 RfZZUrSNzLdrbI48DhnmPoJEwYbR9qLiqjf72ROishmzL/VHWK0O+Qf7fVx0C3DY
 80jjRgIDZ0MyaE2fwWeJ1JiX2YhpremeMPxcB3jQZotnLGm03rsPlejJqA48rZRX
 RWEodPG1JD4CGW73OhaWL/XRP5Iz63t5ziFGJjygI9qLrzFlCybnpOXjPZB7vzAw
 V4JC8D6L1ULqlmRC3DWA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tew80nud2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:28:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71F0A100053;
 Wed,  4 Oct 2023 11:28:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68FF5214D20;
 Wed,  4 Oct 2023 11:28:28 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:28:27 +0200
Message-ID: <7fe15b9c-213c-3187-ec85-9e9d884c1c33@foss.st.com>
Date: Wed, 4 Oct 2023 11:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] clk: stm32mp1: Add support for USART1 clock
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>, <u-boot@lists.denx.de>
CC: <lukma@denx.de>, <seanga2@gmail.com>, <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230929113437.26081-1-agust@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230929113437.26081-1-agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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



On 9/29/23 13:34, Anatolij Gustschin wrote:
> Add USART1 clock parents and mux configuration. This allows
> support for configuring the USART1 as the serial console in
> SPL and U-Boot via device tree. Without this patch the SPL
> with usart1 serial console enabled crashes because it can
> not find the clock specified in the device tree for usart1.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/clk/stm32/clk-stm32mp1.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index 6150287694..f3ac8c7583 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -72,6 +72,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define RCC_PLL2CSGR		0xA4
>  #define RCC_I2C46CKSELR		0xC0
>  #define RCC_SPI6CKSELR		0xC4
> +#define RCC_UART1CKSELR		0xC8
>  #define RCC_CPERCKSELR		0xD0
>  #define RCC_STGENCKSELR		0xD4
>  #define RCC_DDRITFCR		0xD8
> @@ -317,6 +318,7 @@ enum stm32mp1_parent_sel {
>  	_SPI45_SEL,
>  	_SPI6_SEL,
>  	_RTC_SEL,
> +	_UART1_SEL,
>  	_PARENT_SEL_NB,
>  	_UNKNOWN_SEL = 0xff,
>  };
> @@ -557,6 +559,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 0, SPI6_K, _SPI6_SEL),
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 2, I2C4_K, _I2C46_SEL),
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 3, I2C6_K, _I2C46_SEL),
> +	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 4, USART1_K, _UART1_SEL),
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 8, RTCAPB, _PCLK5),
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 16, BSEC, _UNKNOWN_SEL),
>  	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 20, STGEN_K, _STGEN_SEL),
> @@ -602,6 +605,8 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
>  static const u8 i2c12_parents[] = {_PCLK1, _PLL4_R, _HSI_KER, _CSI_KER};
>  static const u8 i2c35_parents[] = {_PCLK1, _PLL4_R, _HSI_KER, _CSI_KER};
>  static const u8 i2c46_parents[] = {_PCLK5, _PLL3_Q, _HSI_KER, _CSI_KER};
> +static const u8 uart1_parents[] = {_PCLK5, _PLL3_Q, _HSI_KER, _CSI_KER,
> +					_PLL4_Q, _HSE_KER};
>  static const u8 uart6_parents[] = {_PCLK2, _PLL4_Q, _HSI_KER, _CSI_KER,
>  					_HSE_KER};
>  static const u8 uart24_parents[] = {_PCLK1, _PLL4_Q, _HSI_KER, _CSI_KER,
> @@ -659,6 +664,7 @@ static const struct stm32mp1_clk_sel stm32mp1_clk_sel[_PARENT_SEL_NB] = {
>  	STM32MP1_CLK_PARENT(_RTC_SEL, RCC_BDCR, RCC_BDCR_RTCSRC_SHIFT,
>  			    (RCC_BDCR_RTCSRC_MASK >> RCC_BDCR_RTCSRC_SHIFT),
>  			    rtc_parents),
> +	STM32MP1_CLK_PARENT(_UART1_SEL, RCC_UART1CKSELR, 0, 0x7, uart1_parents),
>  };
>  
>  #ifdef STM32MP1_CLOCK_TREE_INIT
> @@ -786,6 +792,7 @@ char * const stm32mp1_clk_parent_sel_name[_PARENT_SEL_NB] = {
>  	[_SPI1_SEL] = "SPI1",
>  	[_SPI45_SEL] = "SPI45",
>  	[_RTC_SEL] = "RTC",
> +	[_UART1_SEL] = "UART1",
>  };
>  
>  static const struct stm32mp1_clk_data stm32mp1_data = {


Hi Anatolij

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
