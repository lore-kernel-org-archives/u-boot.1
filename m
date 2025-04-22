Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC72C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9260380194;
	Tue, 22 Apr 2025 11:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FmEATIH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9E980FF7; Tue, 22 Apr 2025 11:44:00 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B22800D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6207ada5ad=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M6gAVx003527;
 Tue, 22 Apr 2025 11:43:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PjJ2F7iqflOaK4liv+7mkmHb6vwWl+NY2o509t7TVeE=; b=FmEATIH/m60Ae1qY
 xy0ZPoIRNBZeUDXZa5xEi7lfiL7sP3UmgOTDQj8hYqMU03QNbawDP1Y5j7sHkSU4
 pVh9a5TVBM0mALRbQTpDqaIW1y8Hiu73ePXdM/7PP9yHTKqNag8ZvguCs2aK3VHv
 vzlExPKB/CSpaJ6NIjfcBXNCBEt4jR+HSlh/DdjVOHUbknXQzHA/9Eg3ghGBGClX
 Myfns9moJch29r7/mxa3MI/mI18zYQHmAqv+W7C4K5kEryKr71uDuEEEN9VIcHig
 kRDHiKcXhYto9ElJ927OQea2FIsc+kE9e7g/mhKm5QBwUcn0cofR2d+uvOm4wy+j
 i7CtDw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464nd3ycc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 11:43:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CF6AD40061;
 Tue, 22 Apr 2025 11:42:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D7989EB437;
 Tue, 22 Apr 2025 11:42:28 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:42:27 +0200
Message-ID: <2be878a1-a4a6-4fd7-9ea7-d2337a4bbad4@foss.st.com>
Date: Tue, 22 Apr 2025 11:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] stm32mp1: clk: Update index for DSI gate
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-9-patrice.chotard@foss.st.com>
 <993246d8-098b-4849-9c1a-822f2d14f77e@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <993246d8-098b-4849-9c1a-822f2d14f77e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
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



On 4/22/25 10:24, Patrick DELAUNAY wrote:
> Hi
> 
> On 4/1/25 15:14, Patrice Chotard wrote:
>> Since upstream kernel commit bda732fda193 ("ARM: dts: stm32: fix
>> DSI peripheral clock on stm32mp15 boards"), DSI clock can't be enabled
>> as shown on following U-Boot log:
>>
>> MMC:   STM32 SD/MMC: 0
>> Loading Environment from MMC... Reading from MMC(0)... OK
>> clk id 57 not found
>> stm32-display-dsi dsi@5a000000: peripheral clock enable error -22
>> stm32_display display-controller@5a001000: panel device error -22
>> In:    serial
>> Out:   serial
>> Err:   serial
>> Net:   eth0: ethernet@5800a000
>>
>> Update clk-stm32mp1 driver accordingly.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/clk/stm32/clk-stm32mp1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
>> index 4044edfb768..204a4b7de45 100644
>> --- a/drivers/clk/stm32/clk-stm32mp1.c
>> +++ b/drivers/clk/stm32/clk-stm32mp1.c
>> @@ -550,7 +550,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
>>         STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 0, LTDC_PX, _PLL4_Q),
>>       STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 4, DSI_PX, _PLL4_Q),
>> -    STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI_K, _DSI_SEL),
>> +    STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI, _DSI_SEL),
>>       STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 8, DDRPERFM, _UNKNOWN_SEL),
>>       STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 15, IWDG2, _UNKNOWN_SEL),
>>       STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 16, USBPHY_K, _USBPHY_SEL),
> 
> 
> See down stream path: "clk: stm32mp1: fix DSI clock setting"

Right, i missed this one.

> 
> in fact both clock, DSI_K and DSI are supported, with the other source clock
> 
>      STM32MP1_CLK_SET_CLR_F(RCC_MP_APB4ENSETR, 4, DSI_PX, _PLL4_Q),
>     STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI_K, _DSI_SEL),
> +    STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 4, DSI, _PLL4_P),
>      STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 8, DDRPERFM, _UNKNOWN_SEL),
>      STM32MP1_CLK_SET_CLR(RCC_MP_APB4ENSETR, 15, IWDG2, _UNKNOWN_SEL),
> 
> => just need to add the "DSI" clock with same bit but with "PLL4_P" as source

Thanks
Patrice

> 
