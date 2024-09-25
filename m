Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18F5CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4819188995;
	Wed, 25 Sep 2024 19:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2O9FiiDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E7888363; Wed, 25 Sep 2024 19:51:37 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF4788995
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=999876f45b=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PD7IHr024311;
 Wed, 25 Sep 2024 19:51:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 spnCYLkjsjfThrKxPJxIii1OJ0bw+46AzhfRavjaPXg=; b=2O9FiiDu30D9XwQr
 88T+2VmmuHL+1PP3UJBvAgSF7cYLJ/3q1RMmTcCdhz6G727B855PyltK8vERLzKi
 i8HuTTr6Vqd419EDH7UMBZQA6GgslxiuODmKAv6C08tlLSKPVvG+DVKI9VguDXeB
 oHjiN4y9WZ4u/bTqraw0CZffhxLQCvLHW7xJ6tTTVhNp6PYc05ie+PzKgEkPh1Pf
 ZBP9dPfN2PF5PNk2gztsauu0KEwy4lp4s8Y82cMK9Cul84haumGqnJAPb7Fc+ASv
 3klom9NoVDBjLrOyTWUKnewpUfcKPeqAz+heimTcBTu6veGbTEWgUH32IUTctEcM
 OMxq4g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41t93jjpak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2024 19:51:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 159EE4006E;
 Wed, 25 Sep 2024 19:50:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AD8E227B40D;
 Wed, 25 Sep 2024 19:50:21 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 25 Sep
 2024 19:50:21 +0200
Message-ID: <6702ce8b-e4ff-45e2-a021-dd0a0d1253db@foss.st.com>
Date: Wed, 25 Sep 2024 19:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix TAMP_SMCR BKP..PROT fields on STM32MP15xx
To: Marek Vasut <marex@denx.de>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240618225736.154959-1-marex@denx.de>
 <2fd69224-c299-4b43-9078-07e06cc345f5@foss.st.com>
 <6957bfce-21c5-4996-9e3f-a43f6243fa49@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <6957bfce-21c5-4996-9e3f-a43f6243fa49@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi Marek,

On 9/25/24 19:04, Marek Vasut wrote:
> On 6/19/24 8:35 AM, Patrice CHOTARD wrote:
>>
>>
>> On 6/19/24 00:57, Marek Vasut wrote:
>>> Update the TAMP_SMCR BKP..PROT fields to put first 10 registers
>>> into protection zone 1 and next 5 into zone 2. This fixes use of
>>> boot counter which is often in zone 3 and has to be updated from
>>> Linux, which runs in NS.
>>>
>>> Fixes: 73f7fc944cf6 ("ARM: stm32: Initialize TAMP_SMCR BKP..PROT 
>>> fields on STM32MP15xx")
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c 
>>> b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>>> index f096fe538d8..ca202bec8ee 100644
>>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
>>> @@ -148,8 +148,8 @@ static void security_init(void)
>>>        */
>>>       clrsetbits_le32(TAMP_SMCR,
>>>               TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
>>> -            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
>>> -            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
>>> +            FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x0A) |
>>> +            FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x0F));
>>>         /* GPIOZ: deactivate the security */
>>>       writel(BIT(0), RCC_MP_AHB5ENSETR);
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> I hope this bugfix will make it into 2024.10 , can you prepare a 
> bugfix PR for 2024.10 ?


Thanks for reminder, I miss it.

And sorry for the delay, because a pull request was planned by Patrice 
after with summer holiday....
but unfortunately it can't do it now (he is out of the office for a few 
weeks after a small incident)

so I will push a PR this week with your 2 bugfix patches.


Regards

Patrick



