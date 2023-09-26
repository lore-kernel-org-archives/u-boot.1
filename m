Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B2E7D26E
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1BF86DC9;
	Tue, 26 Sep 2023 11:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DeHtnGd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F22A803AB; Tue, 26 Sep 2023 11:22:19 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BC186DC5
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6IhZY024821; Tue, 26 Sep 2023 11:22:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=psMjIQkPACyZMIDOM3HjfH/7YAC16XRfKeLNDacT2OY=; b=De
 HtnGd6Yqp/24EWQk2sfjipIgaBVnh4A5nqbyZUwc1BOJRhlotiEhF/KXKMatdQJn
 tBiMV60VKvjE/keZ/eGP5g7lD30N6ZsWNZPMuO68dwvK6duwUYKLtQLQ8fZy4JYd
 48lSsy3zkdOBN3OqPTr2WrvrXJL+nV4sxZvF6Iflh42jmV7qqEGR5tbUtobnn8sD
 fWnBi+rr93agjxgJ2sflZv23sbgGV9MJaDnYHaLgdg0K7/y/8H+iMcipvxck/p8h
 GNYRHBEU5O60aPke1xreGxve6J+0g313/X/YoBvQulbb43LGKvZizoMf89iYgU4k
 k7yz1Vd/u6uonOb6sBoA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9qbwufrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:22:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11CD5100059;
 Tue, 26 Sep 2023 11:22:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A23C22FA3C;
 Tue, 26 Sep 2023 11:22:15 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:22:14 +0200
Message-ID: <49689c6e-b58d-f9e1-32aa-9c465d6d3631@foss.st.com>
Date: Tue, 26 Sep 2023 11:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/10] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-8-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-8-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
> The patch applies the changes from Linux commit 008ef8b3a1a00 ("Add LTDC
> (Lcd-tft Display Controller) support") and removes the same settings
> from stm32f746-disco-u-boot.dtsi.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  arch/arm/dts/stm32f746-disco-u-boot.dtsi | 18 ++++++------------
>  arch/arm/dts/stm32f746.dtsi              | 10 ++++++++++
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> index 522cffb1ac9f..3c2b9fc59512 100644
> --- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
> @@ -63,19 +63,13 @@
>  			};
>  		};
>  	};
> +};
>  
> -	soc {
> -		ltdc: display-controller@40016800 {
> -			compatible = "st,stm32-ltdc";
> -			reg = <0x40016800 0x200>;
> -			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> -			clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
> -			pinctrl-0 = <&ltdc_pins>;
> -
> -			status = "okay";
> -			bootph-all;
> -		};
> -	};
> +&ltdc {
> +	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
> +	pinctrl-0 = <&ltdc_pins>;
> +	status = "okay";
> +	bootph-all;
>  };
>  
>  &fmc {
> diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
> index 7b4bd805c998..79dad3192e15 100644
> --- a/arch/arm/dts/stm32f746.dtsi
> +++ b/arch/arm/dts/stm32f746.dtsi
> @@ -518,6 +518,16 @@
>  			};
>  		};
>  
> +		ltdc: display-controller@40016800 {
> +			compatible = "st,stm32-ltdc";
> +			reg = <0x40016800 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> +			clocks = <&rcc 1 CLK_LCD>;
> +			clock-names = "lcd";
> +			status = "disabled";
> +		};
> +
>  		pwrcfg: power-config@40007000 {
>  			compatible = "st,stm32-power-config", "syscon";
>  			reg = <0x40007000 0x400>;
Apply on stm32/next

Thanks
Patrice
