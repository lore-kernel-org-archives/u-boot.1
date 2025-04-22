Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B1AC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 08:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A2680194;
	Tue, 22 Apr 2025 10:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jA2dnWOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28880803CC; Tue, 22 Apr 2025 10:28:30 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B88B800D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=620721f65c=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M58ISv013542;
 Tue, 22 Apr 2025 10:28:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ByX52kD31ST50E3ZFwkYBfFGKFQ6RaPFmWtIiNOME+o=; b=jA2dnWOMlzeVDS5C
 YteQxGEC6p/7QqCZ7N9TBofTtVIOWUZi+jIWw2Iuc05RcJRUPZWdhDsWLCJDZDr3
 0+GbgDYgbp8vMpBoiBzm3NPZhskrcjDgi4zOrBY3Gu//ZDVca/1ziWdSK/zo2n5C
 ErdVv+MZY2NSiROI0jPv5pzn57f+rMGlrb3J3oem/98+70x9GiySNZ1PgAkjAL/d
 BWWdGoyhzLL8ZF6abZ/zEb+p65YVvdj1ecCdBtWrc10GGE6viMy9fxW10HfNb1qx
 ndHyMLDPQtICtiVOshYEH3UbMhHZg4TaJp2888OY5jddMmZqmaq+1AYxKqQ9RcoY
 wVSgQQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464psp6pam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 10:28:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C1C8840063;
 Tue, 22 Apr 2025 10:26:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09FFE96EE8E;
 Tue, 22 Apr 2025 10:24:32 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 10:24:31 +0200
Message-ID: <993246d8-098b-4849-9c1a-822f2d14f77e@foss.st.com>
Date: Tue, 22 Apr 2025 10:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] stm32mp1: clk: Update index for DSI gate
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-9-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250401131413.387139-9-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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

Hi

On 4/1/25 15:14, Patrice Chotard wrote:
> Since upstream kernel commit bda732fda193 ("ARM: dts: stm32: fix
> DSI peripheral clock on stm32mp15 boards"), DSI clock can't be enabled
> as shown on following U-Boot log:
>
> MMC:   STM32 SD/MMC: 0
> Loading Environment from MMC... Reading from MMC(0)... OK
> clk id 57 not found
> stm32-display-dsi dsi@5a000000: peripheral clock enable error -22
> stm32_display display-controller@5a001000: panel device error -22
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@5800a000
>
> Update clk-stm32mp1 driver accordingly.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   drivers/clk/stm32/clk-stm32mp1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index 4044edfb768..204a4b7de45 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -550,7 +550,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
>   
>   	STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 0, LTDC_PX, _PLL4_Q),
>   	STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 4, DSI_PX, _PLL4_Q),
> -	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI_K, _DSI_SEL),
> +	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI, _DSI_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 8, DDRPERFM, _UNKNOWN_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 15, IWDG2, _UNKNOWN_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 16, USBPHY_K, _USBPHY_SEL),


See down stream path: "clk: stm32mp1: fix DSI clock setting"

in fact both clock, DSI_K and DSI are supported, with the other source clock

  	STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 4, DSI_PX, _PLL4_Q),
	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI_K, _DSI_SEL),
+	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI, _PLL4_P),
  	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 8, DDRPERFM, _UNKNOWN_SEL),
  	STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 15, IWDG2, _UNKNOWN_SEL),

=> just need to add the "DSI" clock with same bit but with "PLL4_P" as source

