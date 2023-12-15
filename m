Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAEDC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4AC87C00;
	Fri, 15 Dec 2023 15:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XOR0sgpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B53987561; Fri, 15 Dec 2023 15:42:56 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D5787B72
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BF9lQlD018518; Fri, 15 Dec 2023 15:42:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=OTHWQMPA6rtbpOXJujZiNJD+dnLRQBitTui/91fqCB8=; b=XO
 R0sgpQ6HT60qIXjRHEhK+LBrtg6YkQBLK+OOnvtD92ur0ECvXPO2f5fYh4OuvKOA
 zH/Oj+a+8sjl6xENQUhgbhG7jLl+uLG0mKXCWzxaVBweaGyYGyP4aqAIRO9vatGs
 Atf0x3zmR4l33NBW/P/sSalRpExjABWrYJttsgZfQ2uwdFivn7dXD+ZnuWtpR9B2
 wXBaKUqb5x2VwlVw/zrtU68VJPcFwvfhu87wvNKw5BSoFwIpvtunNGrq6v0+RqXO
 oEdKywOL1lsOrnif/hAF/wtBoqkni667If871b4DRndhZy9JxFTI7Ya9HhvnFP8h
 ytET1p8D0xSOHCLMswNg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uyb2ka78p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:42:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFA16100052;
 Fri, 15 Dec 2023 15:42:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8551228A27;
 Fri, 15 Dec 2023 15:42:50 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:42:50 +0100
Message-ID: <d69a6e5c-4877-4197-8c8e-13f77ebed236@foss.st.com>
Date: Fri, 15 Dec 2023 15:42:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] ARM: dts: stm32: support MIPI DSI on
 stm32f469-disco board
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
 <20231211220643.1073606-5-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231211220643.1073606-5-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.23.141]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
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



On 12/11/23 23:05, Dario Binacchi wrote:
> Unlike Linux, the DSI driver requires the LTDC clock to be properly
> probed. Hence, the changes made to the DSI node.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> index 8e781c5a7b23..47ba9fa4a783 100644
> --- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> @@ -92,7 +92,9 @@
>  
>  &dsi {
>  	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
> +		 <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>,
>  		 <&clk_hse>;
> +	clock-names = "pclk", "px_clk", "ref";
>  };
>  
>  &gpioa {
> @@ -140,6 +142,8 @@
>  };
>  
>  &ltdc {
> +	bootph-all;
> +
>  	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
>  };
>  
Applied to u-boot-stm32/next

Thanks
Patrice
