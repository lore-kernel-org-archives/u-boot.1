Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6950AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 08:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B280586CB1;
	Mon, 13 Nov 2023 09:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2MWcRyRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D9586D12; Mon, 13 Nov 2023 09:51:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D9D86863
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 09:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9681a1e6ac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3ACMf65j018523; Mon, 13 Nov 2023 09:51:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=dgahU9hzfN/dXmgM1wb8ax+CHL6Kf//3Mg4q15+BiX8=; b=2M
 WcRyRg7RDLyPGRIeIMSD/zRPJVmY77qfvf26FTl3E+rbyLeEhYSdCwwqqqXHLcM7
 1RQV13+K4ayicc/4PSshUdHQTI1e06BCcYM3aEq/8g9rncxj4MYz10s8Mk2OPy0t
 ziBaXI2s59nZdEEMqDdgrZpWGfN1nzRH994jnLSkAreDv3hkIcOgnxKpE0c7mitV
 JwjWeJFgo3z7SgbAGYNSlsMy3GoWF98WUFoO+YNL5KPtJjsi5iRW/pYYzH7h9b72
 hdfRmpBQbxm8jqMP+Fijv9G8MMs9gQM6hqAwrDlE+enLqIXbHeI95LhiDYKKdvhU
 32mehlOWytIbxjyiALWw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1cgx91h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 09:51:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D558D10005B;
 Mon, 13 Nov 2023 09:51:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C492120BA10;
 Mon, 13 Nov 2023 09:51:40 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 13 Nov
 2023 09:51:40 +0100
Message-ID: <4a4ecb30-2cbf-4d9e-b044-34d69b381378@foss.st.com>
Date: Mon, 13 Nov 2023 09:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32f769-disco: rework ltdc node
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231111104440.137117-1-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231111104440.137117-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_24,2023-11-09_01,2023-05-22_02
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



On 11/11/23 11:44, Dario Binacchi wrote:
> With commit f479f5dbb7ac ("ARM: dts: stm32: add ltdc support on
> stm32f746 MCU"), which adds the 'ltdc' node in stm32f746.dtsi, we can
> simplify stm32f769-disco-uboot.dtsi and align stm32f769-disco.dtsi with
> the kernel version.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  arch/arm/dts/stm32f769-disco-u-boot.dtsi | 23 +++++++++--------------
>  arch/arm/dts/stm32f769-disco.dts         |  4 ++++
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> index 2c823cce98b4..add55c96e21f 100644
> --- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
> @@ -70,22 +70,17 @@
>  				};
>  			};
>  		};
> +	};
> +};
>  
> -		ltdc: display-controller@40016800 {
> -			compatible = "st,stm32-ltdc";
> -			reg = <0x40016800 0x200>;
> -			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> -			clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
> -
> -			status = "okay";
> -			bootph-all;
> +&ltdc {
> +	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
> +	bootph-all;
>  
> -			ports {
> -				port@0 {
> -					dp_out: endpoint {
> -						remote-endpoint = <&dsi_in>;
> -					};
> -				};
> +	ports {
> +		port@0 {
> +			dp_out: endpoint {
> +				remote-endpoint = <&dsi_in>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
> index 6f93fc7bcfcd..d63cd2ba7eb4 100644
> --- a/arch/arm/dts/stm32f769-disco.dts
> +++ b/arch/arm/dts/stm32f769-disco.dts
> @@ -86,6 +86,10 @@
>  	status = "okay";
>  };
>  
> +&ltdc {
> +	status = "okay";
> +};
> +
>  &rtc {
>  	status = "okay";
>  };
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
