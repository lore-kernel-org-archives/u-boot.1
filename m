Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1438C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6488350A;
	Thu, 31 Jul 2025 11:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Sg9Qx4hC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FCF8353A; Thu, 31 Jul 2025 11:16:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C42483523
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8v3Ba014357;
 Thu, 31 Jul 2025 11:16:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 0rf3a/Ddb9lDt1cyuyTtTGxTBGu4uCryQ4wsVQ+laeA=; b=Sg9Qx4hCvLJAaucD
 B9VOZcJg901YJG/9Ozi0333Oao8Yk1vmrqGKNLHVCtien5KZuaS1IeuRyO9G9xFF
 /2okSruuzKSCllCI7hlqSfxCmf615UA+bkAMpbeF1SCgM0ygmHJwIJFC7DvFTJu5
 f2n6Y356DGcRrYmwAvr8Ik9RvEAiu/xQKf+1+fAT7OxeswgoFsfR8TJ0yD+XIXaV
 jHC6F3Dpnuej/1YTresJZar1k5483EhQE27JWYx8PSUiWZUt7T5+zjOKGvlCrYRa
 pxmT5ulVTFSUAoC9a1eBNclV9OppYtEgbv5caC46YMNcm3KErFCUked48hH2C7yj
 tJgFrA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m59dvuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:16:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B81014006E;
 Thu, 31 Jul 2025 11:15:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 894FD753099;
 Thu, 31 Jul 2025 11:15:08 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:15:08 +0200
Message-ID: <3b1a8ef3-2fe9-489b-b244-274f9fc9061b@foss.st.com>
Date: Thu, 31 Jul 2025 11:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pwm: stm32: add support for stm32mp25
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>
References: <20250620155000.1258718-1-cheick.traore@foss.st.com>
 <20250620155000.1258718-3-cheick.traore@foss.st.com>
 <9f26f5b8-8b6b-4c12-814c-349d7d1666c9@foss.st.com>
Content-Language: en-US
In-Reply-To: <9f26f5b8-8b6b-4c12-814c-349d7d1666c9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 7/28/25 11:03, Patrice CHOTARD wrote:
> 
> 
> On 6/20/25 17:49, Cheick Traore wrote:
>> Add support for STM32MP25 SoC.
>> IPIDR register is used to check the hardware configuration register
>> when available to gather the number of complementary outputs.
>>
>> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
>> ---
>>
>>  drivers/pwm/pwm-stm32.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>> index 5fa649b5903..a691f75e4a7 100644
>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -12,6 +12,7 @@
>>  #include <asm/io.h>
>>  #include <asm/arch/timers.h>
>>  #include <dm/device_compat.h>
>> +#include <linux/bitfield.h>
>>  #include <linux/time.h>
>>  
>>  #define CCMR_CHANNEL_SHIFT	8
>> @@ -157,7 +158,14 @@ static void stm32_pwm_detect_complementary(struct udevice *dev)
>>  {
>>  	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
>>  	struct stm32_pwm_priv *priv = dev_get_priv(dev);
>> -	u32 ccer;
>> +	u32 ccer, val;
>> +
>> +	if (plat->ipidr) {
>> +		/* Simply read from HWCFGR the number of complementary outputs (MP25). */
>> +		val = readl(plat->base + TIM_HWCFGR1);
>> +		priv->have_complementary_output = !!FIELD_GET(TIM_HWCFGR1_NB_OF_DT, val);
>> +		return;
>> +	}
>>  
>>  	/*
>>  	 * If complementary bit doesn't exist writing 1 will have no
>> @@ -192,6 +200,7 @@ static const struct pwm_ops stm32_pwm_ops = {
>>  
>>  static const struct udevice_id stm32_pwm_ids[] = {
>>  	{ .compatible = "st,stm32-pwm" },
>> +	{ .compatible = "st,stm32mp25-pwm" },
>>  	{ }
>>  };
>>  
> 
> Hi Cheick
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
Applied to u-boot-stm32/master

Thanks
Patrice
