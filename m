Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63776E7D26C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A875D86D38;
	Tue, 26 Sep 2023 11:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vsaA598d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF07886CBC; Tue, 26 Sep 2023 11:20:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8508C86BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6G25t004796; Tue, 26 Sep 2023 11:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=mQyAGndqrT7HwLfY+AwS8UYtKS5SOjnHLJwr49kSp5w=; b=vs
 aA598dSHYxzGT8nf+gj0QMOgal6FEOVoZJdBXXJzOUcxDIESlNN9usTAgO4grKbz
 QpMOyc/RMQtv8hM0DsbIlmO2GlprqrIbO7RnEVm3l+ckPun0i8/FH1tkC67xvOAh
 8IrzfIrYTqA0U9q7VOOsgDKS1eONBkt6726PokLlnWOssd3FM5Of1bO3c6HjGyiM
 BZzDBMbqPfMv9Z0tut80+YwM4flDxZFOHAqLrRJwMO/wQkfvu3gSHjLKuN1O8KSX
 ys/DvgOr7H0POOV/jE3QR7el6Wi4md4XlfPPNVZXU05zOOPkhPjPMgVDSDnoPV6b
 AxylPRm8kbjgdFDKJOUw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ta9k09byu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:20:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DACB210005C;
 Tue, 26 Sep 2023 11:20:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF94622FA2E;
 Tue, 26 Sep 2023 11:20:41 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:20:41 +0200
Message-ID: <c5f8c580-77e8-1fe0-8b50-41332714a671@foss.st.com>
Date: Tue, 26 Sep 2023 11:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/10] ARM: dts: stm32: add pin map for CAN controller on
 stm32f7
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <raphael.gallais-pou@foss.st.com>, Tom
 Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-3-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-3-dario.binacchi@amarulasolutions.com>
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
> commit 011644249686f2675e142519cd59e81e04cfc231 Linux upstream.
> 
> Add pin configurations for using CAN controller on stm32f7.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/all/20230427204540.3126234-4-dario.binacchi@amarulasolutions.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
>  arch/arm/dts/stm32f7-pinctrl.dtsi | 82 +++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f7-pinctrl.dtsi b/arch/arm/dts/stm32f7-pinctrl.dtsi
> index 8f37aefa7315..000278ec2c58 100644
> --- a/arch/arm/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32f7-pinctrl.dtsi
> @@ -284,6 +284,88 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			can1_pins_a: can1-0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('A', 11, AF9)>; /* CAN1_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can1_pins_b: can1-1 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can1_pins_c: can1-2 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
> +					bias-pull-up;
> +
> +				};
> +			};
> +
> +			can1_pins_d: can1-3 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('H', 14, AF9)>; /* CAN1_RX */
> +					bias-pull-up;
> +
> +				};
> +			};
> +
> +			can2_pins_a: can2-0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 6, AF9)>; /* CAN2_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can2_pins_b: can2-1 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can3_pins_a: can3-0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('A', 15, AF11)>; /* CAN3_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('A', 8, AF11)>; /* CAN3_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can3_pins_b: can3-1 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 4, AF11)>;  /* CAN3_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 3, AF11)>; /* CAN3_RX */
> +					bias-pull-up;
> +				};
> +			};
>  		};
>  	};
>  };
Apply on stm32/next

Thanks
Patrice
