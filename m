Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771F4C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C735181DCA;
	Fri, 28 Mar 2025 09:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="e0w1NNRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5820D81EBB; Fri, 28 Mar 2025 09:33:46 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4809481A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6182c41fd1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S21K5S015789;
 Fri, 28 Mar 2025 09:33:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nqyU8E6Lj+q4TI7jvv8tiybhl/yp9VBzhXabD4nAnMQ=; b=e0w1NNRvkMuokLXn
 pKjMd0Rk1UTG3PzquD6IH1ZqemT5LLJjIs7+gqywM+bBj3TEY7YjyVl/v43zDlqu
 xi7bsvH3QorxuFzNr+hsmD0OX9v5B9tOhqX4VIKhhoxURBVCQqZGh0jn6BWhVOmp
 RWdlZwqR+omjr1j82CTg+/wmKOZkRRnOrJpOdta8vUeEc5bXh4i1Hk/bTLvztnJm
 zQCjsw6/o/RzGdE6zQIGB+CTHka6LROxXr5lN86rI5wRW6n55mqesnIbo7pCwQ93
 /wAWpQ+5bn2e01R4YQMrZDa9cdwcmXuLfPtDzEc5mNLGge10h1WSQsa7Ut7Q+AeK
 t5OnIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45me34rc3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:33:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70B464004B;
 Fri, 28 Mar 2025 09:32:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 182558604D9;
 Fri, 28 Mar 2025 09:30:15 +0100 (CET)
Received: from [10.252.6.4] (10.252.6.4) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 09:30:14 +0100
Message-ID: <e043f254-dcfe-4e23-babb-44cf679dcb0d@foss.st.com>
Date: Fri, 28 Mar 2025 09:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ARM: dts: stm32: add DSI support on stm32f769
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
 <20250324180047.1571378-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250324180047.1571378-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.6.4]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
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



On 3/24/25 19:00, Dario Binacchi wrote:
> [backport from Linux commit a995fd2e8b3c6defd1dcdd3fb350c224e41ea1d0]
> 
> Add support for MIPI DSI Host controller. Since MIPI DSI is not
> available on stm32f746, the patch adds the "stm32f769.dtsi" file
> containing the dsi node inside.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
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


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
