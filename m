Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4C6CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 18:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF77688BCF;
	Wed, 25 Sep 2024 20:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727287469;
	bh=m6WbO+ucGVEzRZwbM3kRv7BoJcbe/HXzmtCrxCQq8Cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CBIh9CH+DxM/KQucpRKbd7QRH2upOTfQ0dv9HyqBf39Xq56XClAcNlH+oNX+TdzRV
	 40HoAErue3ht4MQoEEDPJFgSFRCzYaW5oOJC3Sex2KeSy94+hj+GytfacWlon/0fNc
	 KhTRfCygf4yxeaUiIofv/WrExCvzPqLjJ2GjnLbpETvfy+fuf9Hn55tOB+k5X0ywtJ
	 nWfAXAbEAN9Br9iUCc1PUKMt/R3fcZDf9an3Vqm+G4qATVM34bl41Ho0bw0PWkn5Wa
	 +HgQdK9++cLMUEMdULl1ejA6awZsVk+CUKKZn2sR8DfmF9XkI1TC3I0i2CbqUJHyNZ
	 gzZOextI7AYIg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C4B8388BD2;
 Wed, 25 Sep 2024 20:04:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727287468;
 bh=m6WbO+ucGVEzRZwbM3kRv7BoJcbe/HXzmtCrxCQq8Cw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wvUGwYcsajpzQBGaHEySdVYYSbtJ8XjJBLcTIZu1SFZGbnbiYS8owFGWuMg3iduxZ
 8T6W5N6TdSesvESl8BIl14EAntcBjMz0Th8Xp3KcbyGvpFfdjGPQNe/oFIK8fkgfWq
 hrlkC/9SGKof93xrHTMyRBvWTc1QOv0ALQYX11X++NmLNJO7LyBwhv4Dd6ijLP9m5A
 fE2ZCss2IamTpXCnsRhZNqm8ba9P/FhnHxFC6jFQu6IINj+C3LiUoDQeo6calXIQih
 zMn57kPmPVUo72MTkGcau3pK31jvO/dRvuw+OX6dBNEMNGNGibRfaO0w1NvxEtaA0B
 U/eJvKO5BcKfA==
Message-ID: <7a71a93d-60d6-412b-83b7-a8df244694e4@denx.de>
Date: Wed, 25 Sep 2024 19:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix TAMP_SMCR BKP..PROT fields on STM32MP15xx
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
References: <20240618225736.154959-1-marex@denx.de>
 <2fd69224-c299-4b43-9078-07e06cc345f5@foss.st.com>
 <6957bfce-21c5-4996-9e3f-a43f6243fa49@denx.de>
 <6702ce8b-e4ff-45e2-a021-dd0a0d1253db@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <6702ce8b-e4ff-45e2-a021-dd0a0d1253db@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/25/24 7:50 PM, Patrick DELAUNAY wrote:
> Hi Marek,

Hi,

>>>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/ 
>>>> mach-stm32mp/stm32mp1/stm32mp15x.c
>>>> index f096fe538d8..ca202bec8ee 100644
>>>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>>>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>>>> @@ -148,8 +148,8 @@ static void security_init(void)
>>>>        */
>>>>       clrsetbits_le32(TAMP_SMCR,
>>>>               TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
>>>> -            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
>>>> -            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
>>>> +            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x0A) |
>>>> +            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x0F));
>>>>         /* GPIOZ: deactivate the security */
>>>>       writel(BIT(0), RCC_MP_AHB5ENSETR);
>>>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> I hope this bugfix will make it into 2024.10 , can you prepare a 
>> bugfix PR for 2024.10 ?
> 
> 
> Thanks for reminder, I miss it.
> 
> And sorry for the delay, because a pull request was planned by Patrice 
> after with summer holiday....
> but unfortunately it can't do it now (he is out of the office for a few 
> weeks after a small incident)

I hope you had a good relaxing time ?

> so I will push a PR this week with your 2 bugfix patches.
Thank you !
