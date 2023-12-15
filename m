Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8651AC41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74EA87A64;
	Fri, 15 Dec 2023 15:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P9g1SUUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414F2877CD; Fri, 15 Dec 2023 15:04:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD4487AAE
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9TPBF028431; Fri, 15 Dec 2023 15:04:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=H2lemVg3y86YWYr1+x3r8QhF4IFv1F6vpTVi4m6GQ9o=; b=P9
 g1SUUlOFd3xNEmnMIWEVdjj718D3TbCSPCuDkcbfrY56QSbaP5F34Xg4qlyaeAWr
 k547QuzCKSRz0d0FoxZI5vIT39eSprqurlinoyhfHc3jGwvkWlUtoYH4Eq+AIYML
 oJ2CZl6SxROQYstGNl44l/g2WAtlmk9zOxWUH+m1Gbd+HWjbPQmLtqRVunQVCGUM
 1zqiprbgygTFo/jrltGgMJ5hBThH5x8r6foW/E1B0BgsRHPtge8JulKGLyEUTXL7
 NRFr5EDG6VXrovqA5ah8Se0XnMBcDBeBNolKKu1+bOBljyll0GgpvBXkibPVV1Z5
 op+hn8BnG9+/M2lZKSqg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmtm1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:04:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6778D100052;
 Fri, 15 Dec 2023 15:04:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B623226FB4;
 Fri, 15 Dec 2023 15:04:24 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:04:23 +0100
Message-ID: <6830f875-b159-4105-9a57-79c98b411d9d@foss.st.com>
Date: Fri, 15 Dec 2023 15:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: stm32f: fix setting of division factor for
 LCD_CLK
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Sean Anderson
 <seanga2@gmail.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
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
> The value to be written to the register must be appropriately shifted,
> as is correctly done in other parts of the code.
> 
> Fixes: 5e993508cb25 ("clk: clk_stm32f: Add set_rate for LTDC clock")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  drivers/clk/stm32/clk-stm32f.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
> index ed7660196ef0..4c1864193357 100644
> --- a/drivers/clk/stm32/clk-stm32f.c
> +++ b/drivers/clk/stm32/clk-stm32f.c
> @@ -530,7 +530,8 @@ static ulong stm32_set_rate(struct clk *clk, ulong rate)
>  			/* set pll_saidivr with found value */
>  			clrsetbits_le32(&regs->dckcfgr,
>  					RCC_DCKCFGR_PLLSAIDIVR_MASK,
> -					pllsaidivr_table[i]);
> +					pllsaidivr_table[i] <<
> +					RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
>  			return rate;
>  		}
>  
Applied to u-boot-stm32/next

Thanks
Patrice
