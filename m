Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E21C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2240F87128;
	Fri, 14 Jun 2024 13:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0Y/zQhV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AEF87D9B; Fri, 14 Jun 2024 13:59:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEC680E9A
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EAXuR0026966;
 Fri, 14 Jun 2024 13:59:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 xPGDTRvydhk7eDFDbiBK8koZCah5XjM60dYlNUeUoAA=; b=0Y/zQhV0STj+73Fq
 bHu5boK4ttHoP6MTwNsrw7ZlfLVM5FDcairzdcvSAfqlWiKqeL2ADJdK1wYVdYkD
 FQG+cq2968RNoNyuMdVxhu2ZJoIKXGvXqhhEJfYTGb1EdiSHy2G08Pydy+lt4l87
 iMYHng8ny+vV7mKDwldUva1zv8zml0GhyuWApcLhKD4+lt1du/E0DwFUHvq1/+WY
 i0SrK5QP1FXkYaFmy13AciRgsnPqCVad9SoCPVzX1qYvGgWB7xmiNbJUHihapYj7
 GjWLy6830X20xzf8BptPoObh+07SUwlrKyUmLql2Z1nNcVrhonjB78kk65TLbloL
 ClJSRg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yrfuj9muv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 13:59:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EC1C940045;
 Fri, 14 Jun 2024 13:59:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA68F2132EF;
 Fri, 14 Jun 2024 13:58:59 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 13:58:59 +0200
Message-ID: <89e7aad8-705a-4edd-be6b-fa8383b684ab@foss.st.com>
Date: Fri, 14 Jun 2024 13:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Ping IWDG on exit from PSCI suspend code
To: Igor Opaniuk <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>
CC: <u-boot@lists.denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240419220331.277574-1-marex@denx.de>
 <CAL6CDMHFDhcUXhz5+w92SqKa0jC1TNPEiyvRS=jZ4CBqTm7=PA@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAL6CDMHFDhcUXhz5+w92SqKa0jC1TNPEiyvRS=jZ4CBqTm7=PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 6/10/24 10:36, Igor Opaniuk wrote:
> On Sat, Apr 20, 2024 at 12:03 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Make sure the OS would not get any spurious IWDG pretimeout IRQ
>> right after the system wakes up. This may happen in case the SoC
>> got woken up by another source than the IWDG pretimeout and the
>> pretimeout IRQ arrived immediately afterward, but too late to be
>> handled by the suspend main loop. In case either of the IWDG is
>> enabled, ping it first and then return to the OS.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/mach-stm32mp/stm32mp1/psci.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> index 4f2379df45f..e99103910d9 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
>> @@ -808,6 +808,27 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
>>         writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR);
>>         clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CTRL);
>>
>> +       /*
>> +        * Make sure the OS would not get any spurious IWDG pretimeout IRQ
>> +        * right after the system wakes up. This may happen in case the SoC
>> +        * got woken up by another source than the IWDG pretimeout and the
>> +        * pretimeout IRQ arrived immediately afterward, but too late to be
>> +        * handled by the main loop above. In case either of the IWDG is
>> +        * enabled, ping it first and then return to the OS.
>> +        */
>> +
>> +       /* Ping IWDG1 and ACK pretimer IRQ */
>> +       if (gic_enabled[4] & BIT(22)) {
>> +               writel(IWDG_KR_RELOAD_KEY, STM32_IWDG1_BASE + IWDG_KR);
>> +               writel(IWDG_EWCR_EWIC, STM32_IWDG1_BASE + IWDG_EWCR);
>> +       }
>> +
>> +       /* Ping IWDG2 and ACK pretimer IRQ */
>> +       if (gic_enabled[4] & BIT(23)) {
>> +               writel(IWDG_KR_RELOAD_KEY, STM32_IWDG2_BASE + IWDG_KR);
>> +               writel(IWDG_EWCR_EWIC, STM32_IWDG2_BASE + IWDG_EWCR);
>> +       }
>> +
>>         /*
>>          * The system has resumed successfully. Rewrite LR register stored
>>          * on stack with 'ep' value, so that on return from this PSCI call,
>> --
>> 2.43.0
>>
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> 
Applied to u-boot-stm32/next

Thanks
Patrice
