Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8FCC41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4877E87BDC;
	Fri, 15 Dec 2023 15:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ftY3OL0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBE287BDA; Fri, 15 Dec 2023 15:04:41 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D301087BDC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9Wx5x016099; Fri, 15 Dec 2023 15:04:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=mT3VVtOVUw1PkeMpvz+BT9S92obtqBFwTJA7KnFPvAA=; b=ft
 Y3OL0XR5a/d3BciM4IAykeMJy8TUg6r34MgtrT8CT8LEdBIMXvRR70WRopwovF5T
 fImrQLMDd0FoPU/+sYFLhSzUdGvQxpFRsN0nTTc1DYJz75GXVwLPwDxzzGB2b1Qj
 FB4Kwsuz3ioMBcoTjtBsUS5P9WRlR6O5CHZ/jc+TIBFvz6pO6DGClQaAGm8rgiMh
 3mZGq7lOf2vdKR7b66mF3M8Ltkz1HjlhcB2D2RYXT1WWTXF3gfeEKSDzBwx/KIp/
 D8j/W2EjhRcMmVTSbPKZH1TZEK59jtRcUXvz3W5c9xhsTfGv8zWmEgWD/AmlLxCC
 kLhgBykn7y2yWULNzqHA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uw42nytjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:04:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 307C5100052;
 Fri, 15 Dec 2023 15:04:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28057226FC9;
 Fri, 15 Dec 2023 15:04:35 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:04:34 +0100
Message-ID: <73272cef-b129-425c-991c-d7c86a8abded@foss.st.com>
Date: Fri, 15 Dec 2023 15:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: stm32f: fix setting of LCD clock
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
 <20231111104625.137511-2-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231111104625.137511-2-dario.binacchi@amarulasolutions.com>
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



On 11/11/23 11:46, Dario Binacchi wrote:
> Set pllsaidivr only if the PLLSAIR output frequency is an exact multiple
> of the pixel clock rate. Otherwise, we search through all combinations
> of pllsaidivr * pllsair and use the one which gives the rate closest to
> requested one.
> 
> Fixes: 5e993508cb25 ("clk: clk_stm32f: Add set_rate for LTDC clock")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  drivers/clk/stm32/clk-stm32f.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
> index 4c1864193357..d68c75ed2013 100644
> --- a/drivers/clk/stm32/clk-stm32f.c
> +++ b/drivers/clk/stm32/clk-stm32f.c
> @@ -522,18 +522,20 @@ static ulong stm32_set_rate(struct clk *clk, ulong rate)
>  
>  	/* get the current PLLSAIR output freq */
>  	pllsair_rate = stm32_clk_get_pllsai_rate(priv, PLLSAIR);
> -	best_div = pllsair_rate / rate;
> -
> -	/* look into pllsaidivr_table if this divider is available*/
> -	for (i = 0 ; i < sizeof(pllsaidivr_table); i++)
> -		if (best_div == pllsaidivr_table[i]) {
> -			/* set pll_saidivr with found value */
> -			clrsetbits_le32(&regs->dckcfgr,
> -					RCC_DCKCFGR_PLLSAIDIVR_MASK,
> -					pllsaidivr_table[i] <<
> -					RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
> -			return rate;
> -		}
> +	if ((pllsair_rate % rate) == 0) {
> +		best_div = pllsair_rate / rate;
> +
> +		/* look into pllsaidivr_table if this divider is available */
> +		for (i = 0 ; i < sizeof(pllsaidivr_table); i++)
> +			if (best_div == pllsaidivr_table[i]) {
> +				/* set pll_saidivr with found value */
> +				clrsetbits_le32(&regs->dckcfgr,
> +						RCC_DCKCFGR_PLLSAIDIVR_MASK,
> +						pllsaidivr_table[i] <<
> +						RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
> +				return rate;
> +			}
> +	}
>  
>  	/*
>  	 * As no pllsaidivr value is suitable to obtain requested freq,
Applied to u-boot-stm32/next

Thanks
Patrice
