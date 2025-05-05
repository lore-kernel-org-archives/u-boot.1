Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7E2C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7798269F;
	Mon,  5 May 2025 15:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OQv+DYbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8651682076; Mon,  5 May 2025 15:24:09 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9EB8214A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545ABqqG020027;
 Mon, 5 May 2025 15:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 mAXxb8ByoVVUocrWjF8QO9FSaA6upQXjpT0Gs9tP4Is=; b=OQv+DYbgm8awUI0y
 LM9Yt9dUtkM96stGOBQTGjYH6T/EIBO/fq0IyROio5nayG5vyxPP60qaZ65q3LBf
 XKEx9C/pF6gzvAL62Ea9wfGbmv3PEtu9aMMOfnn610qt7nuinzEcNPbPzrHsR8F7
 uM4irHLrgipPAbky9xgKyVlAaugEJHohhlQ2pxs3KWwGC/65nnjUF04b0gCe29eB
 crRfAxdWTbu6cLJqHAu4/vLbxG68mRsMQhu3v/nitA4ghObLBq292nKlyVpLTk2w
 KBDkJZ+pbkPYa6vaZC86G56bOs51QbnVbNGFyjFf7Wk3fH6ePCoeAi8bmYHbgS3Z
 eVcdlw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbkq6ua1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 15:24:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C11764008D;
 Mon,  5 May 2025 15:23:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46C4BB0FBAA;
 Mon,  5 May 2025 15:22:29 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 15:22:28 +0200
Message-ID: <67dd6bcf-7371-4ddc-b738-0f11b665e02d@foss.st.com>
Date: Mon, 5 May 2025 15:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ARM: dts: stm32: add DSI support on stm32f769
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
 <20250401070125.3705126-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250401070125.3705126-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
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



On 4/1/25 09:00, Dario Binacchi wrote:
> [backport from Linux commit a995fd2e8b3c6defd1dcdd3fb350c224e41ea1d0]
> 
> Add support for MIPI DSI Host controller. Since MIPI DSI is not
> available on stm32f746, the patch adds the "stm32f769.dtsi" file
> containing the dsi node inside.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> Changes in v2:
> - Add Reviewed-by tag of Patrice Chotard
> 
>  arch/arm/dts/stm32f769-disco-u-boot.dtsi | 41 +++++++++++-------------
>  arch/arm/dts/stm32f769-disco.dts         |  2 +-
>  arch/arm/dts/stm32f769.dtsi              | 20 ++++++++++++
>  3 files changed, 39 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm/dts/stm32f769.dtsi
> 
> diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> index add55c96e21f..c5ae753debe6 100644
> --- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> @@ -44,30 +44,25 @@
>  			};
>  		};
>  	};
> +};
>  
> -	soc {
> -		dsi: dsi@40016c00 {
> -			compatible = "st,stm32-dsi";
> -			reg = <0x40016c00 0x800>;
> -			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> -			clocks = <&rcc 0 STM32F7_APB2_CLOCK(DSI)>,
> -				  <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>,
> -				  <&clk_hse>;
> -			clock-names = "pclk", "px_clk", "ref";
> -			bootph-all;
> -			status = "okay";
> -
> -			ports {
> -				port@0 {
> -					dsi_out: endpoint {
> -						remote-endpoint = <&panel_in>;
> -					};
> -				};
> -				port@1 {
> -					dsi_in: endpoint {
> -						remote-endpoint = <&dp_out>;
> -					};
> -				};
> +&dsi {
> +	clocks = <&rcc 0 STM32F7_APB2_CLOCK(DSI)>,
> +		 <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>,
> +		 <&clk_hse>;
> +	clock-names = "pclk", "px_clk", "ref";
> +	bootph-all;
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			dsi_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +		port@1 {
> +			dsi_in: endpoint {
> +				remote-endpoint = <&dp_out>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
> index d63cd2ba7eb4..ad1b442055e1 100644
> --- a/arch/arm/dts/stm32f769-disco.dts
> +++ b/arch/arm/dts/stm32f769-disco.dts
> @@ -5,7 +5,7 @@
>   */
>  
>  /dts-v1/;
> -#include "stm32f746.dtsi"
> +#include "stm32f769.dtsi"
>  #include "stm32f769-pinctrl.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm/dts/stm32f769.dtsi b/arch/arm/dts/stm32f769.dtsi
> new file mode 100644
> index 000000000000..4e7d9032149c
> --- /dev/null
> +++ b/arch/arm/dts/stm32f769.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include "stm32f746.dtsi"
> +
> +/ {
> +	soc {
> +		dsi: dsi@40016c00 {
> +			compatible = "st,stm32-dsi";
> +			reg = <0x40016c00 0x800>;
> +			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> +			clock-names = "pclk", "ref";
> +			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> +			reset-names = "apb";
> +			status = "disabled";
> +		};
> +	};
> +};
Hi Dario

For information, stm32f769.dtsi and stm32f769-disco.dts update 
has been dropped due to OF_UPSTREAM now available on stm32 platforms.

Both dropped files will be bring back during nect kernel -> U-Boot DT synchronisation.

Thanks
Patrice
