Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA92C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D217E830EA;
	Mon, 28 Jul 2025 10:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DneM861p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208C5830EE; Mon, 28 Jul 2025 10:49:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B23D830E4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 10:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=030437f29f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S7rLdu024803;
 Mon, 28 Jul 2025 10:49:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 WXjIAupCTAEk8KSWO+WtSS1/5Rh7V2z0yjMTpAgTBjA=; b=DneM861pYYR6vu/3
 SPGqNoHw6/LJAnfytUyKPANnA3nZVJpBcvQyJV3kJzqIROq7VurAnrJS1VC6uyTR
 1HK4f0pcfs854GQAVjnpJmrGFlHOjmWsO2C3nvSwbKlbg37n/t4uQLOrsDSXoN1n
 bY63dKhiEPcXFB+qDZGDOkvjka82Bco8he5+2WevSNyfmICaL7Ux8XwRkL1jMjKh
 AO8ih4uidIsZAriYkiRY7nHlr7h83oSF8vtNMnoPquGab7eopxm+R+e9xO+onbv9
 QqqQ1cfiuwl5yGH4uEgyLYbTlZTMfaAVBapE/NtEaJliqUrfWoCu1CfhRSOSI8ph
 1rwnEA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc278ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 10:49:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 904B24008B;
 Mon, 28 Jul 2025 10:48:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 818C86C9722;
 Mon, 28 Jul 2025 10:47:35 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 10:47:35 +0200
Message-ID: <cb580383-8aa9-45e9-88a3-344232eec428@foss.st.com>
Date: Mon, 28 Jul 2025 10:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: stm32: Wrong macros used in register read
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20250724-clk_stm32-v1-1-c12dd33d28c2@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250724-clk_stm32-v1-1-c12dd33d28c2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
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



On 7/24/25 13:37, Andrew Goodbody wrote:
> Smatch reported a warning about a shift macro being used as a mask. Make
> the obvious changes to make this register read calculation work the same
> as the previous ones.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> This fix is somewhat speculative as it is being made without
> reference to any manual.
> ---
>  drivers/clk/stm32/clk-stm32h7.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32h7.c b/drivers/clk/stm32/clk-stm32h7.c
> index aa3be414a29..df82db69738 100644
> --- a/drivers/clk/stm32/clk-stm32h7.c
> +++ b/drivers/clk/stm32/clk-stm32h7.c
> @@ -549,8 +549,8 @@ static u32 stm32_get_PLL1_rate(struct stm32_rcc_regs *regs,
>  	divr1 = readl(&regs->pll1divr) & RCC_PLL1DIVR_DIVR1_MASK;
>  	divr1 = (divr1 >> RCC_PLL1DIVR_DIVR1_SHIFT) + 1;
>  
> -	fracn1 = readl(&regs->pll1fracr) & RCC_PLL1DIVR_DIVR1_MASK;
> -	fracn1 = fracn1 & RCC_PLL1DIVR_DIVR1_SHIFT;
> +	fracn1 = readl(&regs->pll1fracr) & RCC_PLL1FRACR_FRACN1_MASK;
> +	fracn1 = (fracn1 >> RCC_PLL1FRACR_FRACN1_SHIFT) + 1;
>  
>  	vco = (pllsrc / divm1) * divn1;
>  	rate = (pllsrc * fracn1) / (divm1 * 8192);
> 
> ---
> base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
> change-id: 20250724-clk_stm32-b097d32f3fe9
> 
> Best regards,

Hi Andrew

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
