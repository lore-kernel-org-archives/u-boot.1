Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D36EE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1425280374;
	Wed, 11 Dec 2024 17:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="My2SalWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8154880377; Wed, 11 Dec 2024 17:50:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7741E8036B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=207521b3fe=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBE3mBj014441;
 Wed, 11 Dec 2024 17:50:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 cwYJFb8Fghi0/9J0mhreomtnNvpA8kJqoGhy1mSu34A=; b=My2SalWA8VXHxf2z
 4yNmYMjh0LFG42bD7duHmhb9TiwA2ce2Fo41kdw+ozUl+mYB7v0rXghLzaOZBl/Y
 lKUIPCg/ONcQWYmoaB+FWXan2GfBvqkbdugVT8ZhAwEyJJYTRsrVLluWnriCD7aa
 R472e4xka0xnJWWXgEz/O8qPdj+XTxF3hwvrOKcHlvboMaja4KzKBxvFAcdRAZBv
 lM1Pxw4ccro8vmJkLrGdiCDPl1gvCa9T4ZSa6L1UoKCDrW4eD/urG77JGX8xXbeN
 PmF80S9vf5uS4N38AVz95RsgrOnvSD5MrJW2ZVeOVYOecvoI1MjeA6ED7bA4EXoQ
 TQu2Kw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc93r56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 17:50:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D15D640047;
 Wed, 11 Dec 2024 17:49:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D43B2331F1;
 Wed, 11 Dec 2024 17:44:17 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Dec
 2024 17:44:16 +0100
Message-ID: <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
Date: Wed, 11 Dec 2024 17:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, E
 Shattow <lucent@gmail.com>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
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



On 12/11/24 17:27, Sughosh Ganu wrote:
> On Wed, 11 Dec 2024 at 21:50, Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>>
>>
>> On 12/7/24 16:57, Tom Rini wrote:
>>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
>>>
>>>> There are platforms which set the value of ram_top based on certain
>>>> restrictions that the platform might have in accessing memory above
>>>> ram_top, even when the memory region is in the same DRAM bank. So,
>>>> even though the LMB allocator works as expected, when trying to
>>>> allocate memory above ram_top, prohibit this by marking all memory
>>>> above ram_top as reserved, even if the said memory region is from the
>>>> same bank.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/master, thanks!
>>>
>> Hello
>>
>> This patch is breaking the boot on STM32MP135F-DK.
>>
>> On this platform, we got an area above gd->ram_top,
>> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
>>
>> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
>> this area is no more tagged as LMB_NOMAP, because it's previously been
>> tagged with LMB_NOOVERWRITE in lmb_add_memory().
>>
>> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
>>
>> I suggest to revert this patch.
> 
> I don't think that this patch should be reverted. If the said platform
> has a reserved memory region above ram_top, I would suggest to either
> a) move the ram_top on this platform so that the op-tee region gets
> marked as no-map in the lmb memory map, or b) do not use the lmb

In my explanation above, i indicated that before this commit, 
this area was marked as LMB_NOMAP in the lmb memory map by boot_fdt_add_mem_rsv_regions().
this is exactly what you described in the possible solution "a)".

But now with this commit, as lmb_add_memory() is called in lmb_init() the area above ram_top is marked LMB_NOOVERWRITE.
Then later, boot_fdt_add_mem_rsv_regions() is executed, but the area above ram_top can't be marked as
LMB_NOMAP as previously because it's already marked LMB_NOOVERWRITE. 


> memory map to configure the MMU -- can the MMU configuration logic not
> read the DT to get which regions are to be marked as no-map?
> 
> As far as the lmb module is concerned, it is being told through this
> commit to not consider memory above ram_top for allocations, which is
> not an incorrect thing imo.

That's the case, we don't consider memory above ram_top for allocations,
we only marked it with LMB_NOMAP.

Thanks
Patrice

> 
> -sughosh
> 
>>
>> Patrice
