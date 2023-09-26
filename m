Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47210E7D267
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D35186DA3;
	Tue, 26 Sep 2023 10:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vx0xtBIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7D186DA3; Tue, 26 Sep 2023 10:54:50 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A6086DB9
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38Q75ZaO012495; Tue, 26 Sep 2023 10:54:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=riAp4p5kbpCUt5pdp91OFS9QH58mWQiyGHZkUed/GXU=; b=vx
 0xtBIKtxl1uDT+AY5cxMq+QjldmBH1wUthrWCBip1ZhD7NDCBnkbamwwNOjDcUga
 uGTlEmP34JW5/QL57SLgthWKIYAoVU9IofEoVsCbMC2Wop6RmyDc8zpC64XeNMHu
 mzPCb7TD1+kSVasBxYZFEZccC0rXh0Dhn6xJBg6Z0F0jT9OzIk2aqrItDFpK4xW5
 GW429qZFfklItzjjL5kbcJ14gTtBv8+Y+tEobe3XrlTJxsAY5LFYdG8aIzKbf9rL
 jDE9HFwrwpZzXhRbOa/Aafnx4lqhtPpxJmWlGRW85Kf7Ymsl1dv/I2FtEos2XTq/
 w62I4o+DWOEjHzGwkvWw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9n54c4qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 10:54:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2C8A10005A;
 Tue, 26 Sep 2023 10:54:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DBFD422A6CB;
 Tue, 26 Sep 2023 10:54:45 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 10:54:45 +0200
Message-ID: <a614f281-0b1f-eab7-a82c-4e9d2502f265@foss.st.com>
Date: Tue, 26 Sep 2023 10:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/10] ARM: dts: stm32: add pin map for LTDC on stm32f7
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?=
 <raphael.gallais-pou@foss.st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-9-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-9-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
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



On 9/3/23 22:48, Dario Binacchi wrote:
> commit ba287d1a0137702a224b1f48673d529257b3c4bf Linux upstream.
> 
> Add pin configurations for using LTDC (LCD-tft Display Controller) on
> stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
> 
>  arch/arm/dts/stm32f7-pinctrl.dtsi | 34 +++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f7-pinctrl.dtsi b/arch/arm/dts/stm32f7-pinctrl.dtsi
> index 607fe42f4f46..d3706ee33b5f 100644
> --- a/arch/arm/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32f7-pinctrl.dtsi
> @@ -376,6 +376,40 @@
>  					bias-pull-up;
>  				};
>  			};
> +
> +			ltdc_pins_a: ltdc-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */
> +						 <STM32_PINMUX('G',12, AF9)>,  /* LCD_B4 */
> +						 <STM32_PINMUX('I', 9, AF14)>, /* LCD_VSYNC */
> +						 <STM32_PINMUX('I',10, AF14)>, /* LCD_HSYNC */
> +						 <STM32_PINMUX('I',14, AF14)>, /* LCD_CLK */
> +						 <STM32_PINMUX('I',15, AF14)>, /* LCD_R0 */
> +						 <STM32_PINMUX('J', 0, AF14)>, /* LCD_R1 */
> +						 <STM32_PINMUX('J', 1, AF14)>, /* LCD_R2 */
> +						 <STM32_PINMUX('J', 2, AF14)>, /* LCD_R3 */
> +						 <STM32_PINMUX('J', 3, AF14)>, /* LCD_R4 */
> +						 <STM32_PINMUX('J', 4, AF14)>, /* LCD_R5 */
> +						 <STM32_PINMUX('J', 5, AF14)>, /* LCD_R6 */
> +						 <STM32_PINMUX('J', 6, AF14)>, /* LCD_R7 */
> +						 <STM32_PINMUX('J', 7, AF14)>, /* LCD_G0 */
> +						 <STM32_PINMUX('J', 8, AF14)>, /* LCD_G1 */
> +						 <STM32_PINMUX('J', 9, AF14)>, /* LCD_G2 */
> +						 <STM32_PINMUX('J',10, AF14)>, /* LCD_G3 */
> +						 <STM32_PINMUX('J',11, AF14)>, /* LCD_G4 */
> +						 <STM32_PINMUX('J',13, AF14)>, /* LCD_B1 */
> +						 <STM32_PINMUX('J',14, AF14)>, /* LCD_B2 */
> +						 <STM32_PINMUX('J',15, AF14)>, /* LCD_B3 */
> +						 <STM32_PINMUX('K', 0, AF14)>, /* LCD_G5 */
> +						 <STM32_PINMUX('K', 1, AF14)>, /* LCD_G6 */
> +						 <STM32_PINMUX('K', 2, AF14)>, /* LCD_G7 */
> +						 <STM32_PINMUX('K', 4, AF14)>, /* LCD_B5 */
> +						 <STM32_PINMUX('K', 5, AF14)>, /* LCD_B6 */
> +						 <STM32_PINMUX('K', 6, AF14)>, /* LCD_B7 */
> +						 <STM32_PINMUX('K', 7, AF14)>; /* LCD_DE */
> +					slew-rate = <2>;
> +				};
> +			};
>  		};
>  	};
>  };
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
