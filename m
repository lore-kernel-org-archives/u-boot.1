Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD7E7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6905286C35;
	Tue, 26 Sep 2023 11:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7L7+rIoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0A286D51; Tue, 26 Sep 2023 11:21:05 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D7586BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6IhZK024821; Tue, 26 Sep 2023 11:21:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=/8oPwGLhwRcy/nUozskyCTOCUaYwpLPQgjc5vfQ12RM=; b=7L
 7+rIoztUuiDEhMrBQnF+CN+WxHVeKxY/euCN2QsBs/Gjl+BwStsVrR5wEeBy2wvI
 K4X2uN0hzMT8CjYS/OxwsnmrwZ9jOz33zmjZPlG82/DMW4SriS/hJqksUSoPh812
 bM0cndDdlr4lsnn+jJFtTdILdmsFN44pCfFgzZ6PjllbyfIrJN1CquFzesnncyCu
 2gFLx55aUv6IfFR3v3ntCfoX5bw6OChGRNP0yksTbbpgRfzTc0dk9K4KSXfyj1OT
 BgYallj64Kl9p2mhRPIRJ65u44i1Mjzk6gMF2AuqQvwmqvqWKlyN55+9ISeg1AuU
 SejNfFzXU2gZIxTC4OtA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9qbwufk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:21:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15D13100059;
 Tue, 26 Sep 2023 11:21:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0925F22FA2F;
 Tue, 26 Sep 2023 11:21:00 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:20:59 +0200
Message-ID: <52179f63-99a6-66a4-93ce-457a86b2e3ce@foss.st.com>
Date: Tue, 26 Sep 2023 11:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/10] ARM: dts: stm32: add pin map for i2c3 controller on
 stm32f7
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <raphael.gallais-pou@foss.st.com>, Tom
 Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-6-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-6-dario.binacchi@amarulasolutions.com>
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
> commit 0637e66f8250c61f75042131fcb7f88ead2ad436 Linux upstream.
> 
> Add pin configurations for using i2c3 controller on stm32f7.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
> 
>  arch/arm/dts/stm32f7-pinctrl.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f7-pinctrl.dtsi b/arch/arm/dts/stm32f7-pinctrl.dtsi
> index 000278ec2c58..607fe42f4f46 100644
> --- a/arch/arm/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32f7-pinctrl.dtsi
> @@ -172,6 +172,16 @@
>  				};
>  			};
>  
> +			i2c3_pins_a: i2c3-0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('H', 8, AF4)>, /* I2C3_SDA */
> +						 <STM32_PINMUX('H', 7, AF4)>; /* I2C3_SCL */
> +					bias-disable;
> +					drive-open-drain;
> +					slew-rate = <0>;
> +				};
> +			};
> +
>  			usbotg_hs_pins_a: usbotg-hs-0 {
>  				pins {
>  					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
Apply on stm32/next

Thanks
Patrice
