Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B987AE7D267
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF4786D38;
	Tue, 26 Sep 2023 10:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gk8kwWFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C5386D22; Tue, 26 Sep 2023 10:53:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB84F86A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6RNZ8002898; Tue, 26 Sep 2023 10:53:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=EB3jdN6HZQfFlfMSMq1m6boyTamX0Lu0T8YKCrybYnk=; b=gk
 8kwWFbfZS8j2FTCsV1e66cDOGBE5wbWZRaHSiTe94aSxUrnRqcEieD9rJulvBqX8
 8Wpbr0m798nIk8R6HmKfEYP0eQ3+F2oR5Uk3qAXOry0XBuk3Zq+znssvEm7JPTqg
 yv+BoWmhIPOGI3zR7xdcTjOghile8saD86Annefk8YTfvEZUdCumrJVyrbebH+E0
 ADOacpVLLMpMaR75ULh+bPTlLf4Q0mn0wVXTCtixNsMfUohrAgHY2fJ+2VTEvu85
 Zj8a45NsnnjLMOMAdMooN2uDdYZyjNsnALjrfMnslzYJ8tqg5HQKx0PCwACteNUy
 kvhoyfgWPA7dPnAYCJJQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9pwd3xj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 10:53:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D00A110005A;
 Tue, 26 Sep 2023 10:53:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C93BE22A6C9;
 Tue, 26 Sep 2023 10:53:22 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 10:53:22 +0200
Message-ID: <f896f26b-4203-e034-3868-b4cb94a90c33@foss.st.com>
Date: Tue, 26 Sep 2023 10:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/10] ARM: dts: stm32: add CAN support on stm32f746
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-4-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-4-dario.binacchi@amarulasolutions.com>
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
> commit 0920ccdf41e3078a4dd2567eb905ea154bc826e6 Linux upstream.
> 
> Add support for bxcan (Basic eXtended CAN controller) to STM32F746. The
> chip contains three CAN peripherals, CAN1 and CAN2 in dual peripheral
> configuration and CAN3 in single peripheral configuration:
> - Dual CAN peripheral configuration:
>   * CAN1: Primary bxCAN for managing the communication between a secondary
>     bxCAN and the 512-byte SRAM memory.
>   * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
>   This means that the two bxCAN cells share the 512-byte SRAM memory and
>   CAN2 can't be used without enabling CAN1.
> - Single CAN peripheral configuration:
>   * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
>     512-byte SRAM memory.
> 
>  -------------------------------------------------------------------------
> | features | CAN1              | CAN2               | CAN 3               |
>  -------------------------------------------------------------------------
> | SRAM     | 512-byte shared between CAN1 & CAN2    | 512-byte            |
>  -------------------------------------------------------------------------
> | Filters  | 26 filters shared between CAN1 & CAN2  | 14 filters          |
>  -------------------------------------------------------------------------
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/all/20230427204540.3126234-6-dario.binacchi@amarulasolutions.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
>  arch/arm/dts/stm32f746.dtsi | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
> index c97b3d0d07db..dc5c257fb5fb 100644
> --- a/arch/arm/dts/stm32f746.dtsi
> +++ b/arch/arm/dts/stm32f746.dtsi
> @@ -221,6 +221,23 @@
>  			status = "disabled";
>  		};
>  
> +		can3: can@40003400 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40003400 0x200>;
> +			interrupts = <104>, <105>, <106>, <107>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
> +			st,gcan = <&gcan3>;
> +			status = "disabled";
> +		};
> +
> +		gcan3: gcan@40003600 {
> +			compatible = "st,stm32f4-gcan", "syscon";
> +			reg = <0x40003600 0x200>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
> +		};
> +
>  		usart2: serial@40004400 {
>  			compatible = "st,stm32f7-uart";
>  			reg = <0x40004400 0x400>;
> @@ -301,6 +318,36 @@
>  			status = "disabled";
>  		};
>  
> +		can1: can@40006400 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006400 0x200>;
> +			interrupts = <19>, <20>, <21>, <22>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F7_APB1_RESET(CAN1)>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
> +			st,can-primary;
> +			st,gcan = <&gcan1>;
> +			status = "disabled";
> +		};
> +
> +		gcan1: gcan@40006600 {
> +			compatible = "st,stm32f4-gcan", "syscon";
> +			reg = <0x40006600 0x200>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
> +		};
> +
> +		can2: can@40006800 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006800 0x200>;
> +			interrupts = <63>, <64>, <65>, <66>;
> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
> +			st,can-secondary;
> +			st,gcan = <&gcan1>;
> +			status = "disabled";
> +		};
> +
>  		cec: cec@40006c00 {
>  			compatible = "st,stm32-cec";
>  			reg = <0x40006C00 0x400>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
