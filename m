Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424BEE7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFDF86D42;
	Tue, 26 Sep 2023 11:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="issWGoiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DF186D55; Tue, 26 Sep 2023 11:06:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3412686BEE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q8wCP7031998; Tue, 26 Sep 2023 11:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=n34MN5/mfM/ES2fbsMuXnk1dyFlmiZKSNvIMlfYP6aI=; b=is
 sWGoiGOX1zUTKrbFaXwRguNzaKPQt6/qYeicLiFfeDVuFoCrgVY9YUuHVVjcyW3b
 ng+YtnkniRmrduCuHVXBoV6aFEkkZFk7/Y7JciBGQnqZMnjAgUFjvIBf/+cjvpSz
 xmDnZ9Xu/G+sPwxky64+eud5Sx3/ADhY4FWyHU+CjdMYqfTtnEIasOa1UHIgGhL8
 RlBpPS9x7gLVJyzenVC/C/RPz7JSYH3UNc1xtrEaR02srlzDnRKP/XulG/K1RmUz
 /IvHnhyErZT8168NE7DN2i2UETi9BYK7fCnEOk5xUx1AlWJjuGR3/yurpE6HwxK9
 2sk1tat+MXBfjhL56rYw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9pwd4119-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:06:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B95710003D;
 Tue, 26 Sep 2023 11:06:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4389322D190;
 Tue, 26 Sep 2023 11:06:23 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:06:22 +0200
Message-ID: <71121da9-12fe-20c5-8cdb-4ef03f57668a@foss.st.com>
Date: Tue, 26 Sep 2023 11:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add pin map for CAN controller on
 stm32f4
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom
 Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903203352.658691-1-dario.binacchi@amarulasolutions.com>
 <20230903203352.658691-3-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903203352.658691-3-dario.binacchi@amarulasolutions.com>
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
> commit 559a6e75b4bcf0fc9e41d34865e72cf742f67d8e Linux upstream.
> 
> Add pin configurations for using CAN controller on stm32f469-disco
> board. They are located on the Arduino compatible connector CN5 (CAN1)
> and on the extension connector CN12 (CAN2).
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/all/20230328073328.3949796-5-dario.binacchi@amarulasolutions.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
>  arch/arm/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f4-pinctrl.dtsi b/arch/arm/dts/stm32f4-pinctrl.dtsi
> index 46815c965d59..0adc41b2a46c 100644
> --- a/arch/arm/dts/stm32f4-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32f4-pinctrl.dtsi
> @@ -412,6 +412,36 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			can1_pins_a: can1-0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
> +				};
> +				pins2 {
> +					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
> +					bias-pull-up;
> +				};
> +			};
> +
> +			can2_pins_a: can2-0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
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
>  		};
>  	};
>  };

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
