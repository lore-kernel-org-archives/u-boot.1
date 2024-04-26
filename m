Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9087289124;
	Fri, 26 Apr 2024 10:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="iA1eDQTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE828912D; Fri, 26 Apr 2024 10:02:36 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450AF88EF8
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4846c7b602=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q15tKI029735;
 Fri, 26 Apr 2024 10:02:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Iw8YXleoCNmmvn3aKHyiwJcg9W2j/kN83dc8atIfuT8=; b=iA
 1eDQTNkuPV4sFWWVnsvweCsnOX1o+YE3NprJMU49OpweXcvxZxwpUR6BFSVh44LA
 QqeSqh0c5Qf/UB58MuNY3qxVAWGWlWubCejHOTGJcchOyQ6vTT7Hveyms1103J3f
 BhAhLN+JCTGqw1oPSszWu6ymw7MJmPxw0h6j97DjeSQQFYhPwd7fHmWR+V1O+Gww
 xGbFZSACEhPSgWpzwGs1J+uTCngwY7bLR6mpSlV9Ry/vKQWmwa9/mikaLQWqwamc
 LtR7XnOX8Mzd7IItljGpz8SoECpe/oLCYOJQ+fYMdkTXuRGI0CNR/aUudxBVwibO
 nhm9IfxjLAZABvbtsILw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnjee2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 10:02:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 97F4D40045;
 Fri, 26 Apr 2024 10:02:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0BE32122F6;
 Fri, 26 Apr 2024 10:01:56 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 10:01:56 +0200
Message-ID: <31ee6b36-050a-4f0c-99e1-f7ca1ff45e6c@foss.st.com>
Date: Fri, 26 Apr 2024 10:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] ARM: dts: stm32: Add alternate pinmux for MP13 SAI1
 pins
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240421231849.194648-1-marex@denx.de>
 <20240421231849.194648-11-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240421231849.194648-11-marex@denx.de>
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



On 4/22/24 01:16, Marek Vasut wrote:
> Add another mux option for SAI1 pins, this is used on
> DH electronics STM32MP13xx DHCOR DHSBC board.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp13-pinctrl.dtsi | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> index 77a222903de..f2b41104a58 100644
> --- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
> +++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
> @@ -356,6 +356,38 @@
>  		};
>  	};
>  
> +	sai1a_pins_a: sai1a-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 4, AF12)>, /* SAI1_SCK_A */
> +				 <STM32_PINMUX('D', 6, AF6)>, /* SAI1_SD_A */
> +				 <STM32_PINMUX('E', 11, AF6)>; /* SAI1_FS_A */
> +			slew-rate = <0>;
> +			drive-push-pull;
> +			bias-disable;
> +		};
> +	};
> +
> +	sai1a_sleep_pins_a: sai1a-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 4, ANALOG)>, /* SAI1_SCK_A */
> +				 <STM32_PINMUX('D', 6, ANALOG)>, /* SAI1_SD_A */
> +				 <STM32_PINMUX('E', 11, ANALOG)>; /* SAI1_FS_A */
> +		};
> +	};
> +
> +	sai1b_pins_a: sai1b-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 0, AF6)>; /* SAI1_SD_B */
> +			bias-disable;
> +		};
> +	};
> +
> +	sai1b_sleep_pins_a: sai1b-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* SAI1_SD_B */
> +		};
> +	};
> +
>  	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
>  		pins {
>  			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
