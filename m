Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2209AE7D277
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEEC869D1;
	Tue, 26 Sep 2023 11:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="v22XB3ci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F5786BB2; Tue, 26 Sep 2023 11:27:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA9080569
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6glHW000762; Tue, 26 Sep 2023 11:27:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Z9xgbAumF/bHocsDF78l9yJXWwRReoUtiAhh+Te99ds=; b=v2
 2XB3ci6+B424eXH+BWjv1cBGVQfdwmKhSuasIg+VT6BEaETabiqi8paNwPvIVW3z
 7PbnlhGkgZQ9M8DHVAQoXuG3BwIdBg5AjtEsj57giShb+NbLj+JFg495nnhapAiB
 hSn1yAkGJUT743Chn2NdCn1ZR0XaGNkxI5/KX+7cRv/ve/b0V5LgZe5AGTFlRa+D
 MtjF5e4o/A07HDyBHka15E0E9jjSVbi6xG9vzEdQQIGSn6d6l98CHg7Dj8xDmd9c
 IxYkfy2gDlxOkcblyyfxg4Qgs+n3m8rIMxNS3UjGJIYvknOm9bKcO/AysB1CpRz1
 g6yF7lOTvJfblFmhq78g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9pwd44tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:27:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BB6E100059;
 Tue, 26 Sep 2023 11:27:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2073B22FA49;
 Tue, 26 Sep 2023 11:27:03 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:27:02 +0200
Message-ID: <6a18fe20-8b13-e3ad-2aa8-eae51c6eeffa@foss.st.com>
Date: Tue, 26 Sep 2023 11:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] ARM: dts: stm32: add CAN support on stm32f429
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom
 Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
 <20230903203352.658691-2-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903203352.658691-2-dario.binacchi@amarulasolutions.com>
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



On 9/3/23 22:33, Dario Binacchi wrote:
> commit 7355ad1950f41e755e6dc451834be3b94f82acd4 Linux upstream.
> 
> Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
> chip contains two CAN peripherals, CAN1 the primary and CAN2 the secondary,
> that share some of the required logic like clock and filters. This means
> that the secondary CAN can't be used without the primary CAN.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/all/20230328073328.3949796-4-dario.binacchi@amarulasolutions.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
>  arch/arm/dts/stm32f429.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f429.dtsi b/arch/arm/dts/stm32f429.dtsi
> index e5b13aca40c0..22225104fca8 100644
> --- a/arch/arm/dts/stm32f429.dtsi
> +++ b/arch/arm/dts/stm32f429.dtsi
> @@ -321,6 +321,35 @@
>  			status = "disabled";
>  		};
>  
> +		can1: can@40006400 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006400 0x200>;
> +			interrupts = <19>, <20>, <21>, <22>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
> +			st,can-primary;
> +			st,gcan = <&gcan>;
> +			status = "disabled";
> +		};
> +
> +		gcan: gcan@40006600 {
> +			compatible = "st,stm32f4-gcan", "syscon";
> +			reg = <0x40006600 0x200>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
> +		};
> +
> +		can2: can@40006800 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006800 0x200>;
> +			interrupts = <63>, <64>, <65>, <66>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
> +			st,gcan = <&gcan>;
> +			status = "disabled";
> +		};
> +
>  		dac: dac@40007400 {
>  			compatible = "st,stm32f4-dac-core";
>  			reg = <0x40007400 0x400>;


Apply on stm32/next

Thanks
Patrice
