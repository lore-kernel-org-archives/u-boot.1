Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF7F89161;
	Fri, 26 Apr 2024 10:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="m/DJbltx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CE789165; Fri, 26 Apr 2024 10:05:03 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E6C88EF8
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4846c7b602=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q1iHvo003998;
 Fri, 26 Apr 2024 10:04:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Mm/H4p3NRibOWLSJ+aJSmcVyCl67R9Mc0mbfzeF4ub0=; b=m/
 DJbltxDipNYW640+9d6OfE90CWkQSokNH/xSLAJ7APAZVj/zWPHvVTkjsCP2J2aN
 StmZ0prF2dhqiGJLHJOaKIYMKBCgYtp6svR6LnO2dhTqEyK5vRdsOPuZMVK2sijg
 SWlfcbisGXJAG3hMaq6AOOSi0phRk8HnPYXJuJnJPqGqdRQsrRMDQQrmOeeLtwK2
 ec9+shm4N2neaAFxziddpetxu+3z3bxnQPv1YRGRNDFMEd/nZDZ2WATpe8VG3WcP
 s19csCFabvOjMLVyyqmbgFyYrHxkr7Fnj6QIxFuOqud1/l67zjNXt4ye0/cYW3U+
 z27JskT655PpObQdSfnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4ee8qf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 10:04:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 49CF84002D;
 Fri, 26 Apr 2024 10:04:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 809DE214524;
 Fri, 26 Apr 2024 10:04:26 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 10:04:26 +0200
Message-ID: <16cd0033-888f-41a1-ac7f-e6c271755e0a@foss.st.com>
Date: Fri, 26 Apr 2024 10:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] ARM: dts: stm32: Add alternate pinmux for MP13
 UART4 pins
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240421231849.194648-1-marex@denx.de>
 <20240421231849.194648-17-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240421231849.194648-17-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
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



On 4/22/24 01:17, Marek Vasut wrote:
> Add another mux option for UART4 pins, this is used on
> DH electronics STM32MP13xx DHCOR DHSBC board.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp13-pinctrl.dtsi | 30 +++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> index 65f91265a4d..7014c7a6d23 100644
> --- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> @@ -617,6 +617,36 @@
>  		};
>  	};
>  
> +	uart4_pins_b: uart4-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('A', 9, AF8)>; /* UART4_TX */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('D', 8, AF8)>; /* UART4_RX */
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart4_idle_pins_b: uart4-idle-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('A', 9, ANALOG)>; /* UART4_TX */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('D', 8, AF8)>; /* UART4_RX */
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart4_sleep_pins_b: uart4-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 9, ANALOG)>, /* UART4_TX */
> +				 <STM32_PINMUX('D', 8, ANALOG)>; /* UART4_RX */
> +		};
> +	};
> +
>  	uart8_pins_a: uart8-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
