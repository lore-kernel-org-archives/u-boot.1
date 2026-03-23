Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44861F483E1
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 18:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FF084207;
	Mon, 23 Mar 2026 19:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cl7ugyI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D7868420C; Mon, 23 Mar 2026 19:29:00 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94C88410D;
 Mon, 23 Mar 2026 19:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ffhWq2TcTz9thg;
 Mon, 23 Mar 2026 19:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774290535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIrDkeMvcIwGiVgQrGkOZSlNJ1OwbBY1aqH2n8fyJng=;
 b=cl7ugyI4nBUJ4t7c/83yCnZcYgRm94pM3MbYbnzZgh+aQu+8/j4CCXNbptCuTOzy/J5MW2
 Y6b2+/JYFoI4Yg1bUrrZGGwRmXUhgtfibi2bzdYdq02jrZA9HjogzGceZ1vxwJ6sygLXng
 AIIJWQE6BXdRR/2MHVO/TSjo6ZnhaK3ItnCrCYMOZmxCzREIB2o0hxV42Ks9QIci2v6hq3
 DgN2tqif02zIX+jfXq9Wjng82i635/jhPEMJpYxpy7bfwXrKXRwDqdAC8b077xE2S9RIeZ
 1DwrX2zxovGRRtsGD5OSPeiKnBUD4LyaGvByHc0So/Z3BR8UJkTip4lm9+zeuA==
Message-ID: <65974391-a29d-4dcf-ab56-7d6b4a297f0d@mailbox.org>
Date: Mon, 23 Mar 2026 19:28:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Tom Rini <trini@konsulko.com>
Cc: Gary Guo <gary@garyguo.net>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com,
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org,
 casey.connolly@linaro.org, xypron.glpk@gmx.de,
 holger.brunck@hitachienergy.com, ilias.apalodimas@linaro.org,
 jonas@kwiboo.se, kettenis@openbsd.org, semen.protsenko@linaro.org,
 sughosh.ganu@arm.com, u-boot-bounces@lists.denx.de
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
 <20260323181815.GJ502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323181815.GJ502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e515e4df7eea2926cd8
X-MBO-RS-META: 76meca1w7imy5x8jxitbukhjjes38fo8
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

On 3/23/26 7:18 PM, Tom Rini wrote:
> On Mon, Mar 23, 2026 at 06:26:01PM +0100, Marek Vasut wrote:
>> On 3/23/26 6:11 PM, Gary Guo wrote:
>>> On Sun Mar 22, 2026 at 11:25 PM GMT, Mark Kettenis wrote:
>>>>> Date: Sun, 22 Mar 2026 22:59:53 +0100
>>>>>
>>>>> On 3/22/26 10:45 PM, Gary Guo wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> Is your malloc area by any chance above the 4 GiB boundary ? Or how come
>>>>>>> does EFI allocate pages from above 4 GiB range? It should not be doing
>>>>>>> that and that is what should be fixed, at least until the DMA32
>>>>>>> allocator is in place.
>>>>>>>
>>>>>>> Please keep in mind, that revering this patch breaks other use cases,
>>>>>>> like loading into the DRAM above 4 GiB.
>>>>
>>>> Well, technically it doesn't break things as this is new
>>>> functionality.
>>>>
>>>>>> Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_memory.c)
>>>>>> whenever it allocates, which calls efi_allocate_pages, which calls into
>>>>>> lmb_alloc_mem. There's no malloc here.
>>>>> Does something like this make the issue go away ?
>>>>>
>>>>> "
>>>>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>>>> index b77c2f980cc..44eccc0cf35 100644
>>>>> --- a/lib/efi_loader/efi_memory.c
>>>>> +++ b/lib/efi_loader/efi_memory.c
>>>>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
>>>>> efi_allocate_type type,
>>>>>            flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>>>>>            switch (type) {
>>>>>            case EFI_ALLOCATE_ANY_PAGES:
>>>>> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
>>>>> +
>>>>>                    /* Any page */
>>>>> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
>>>>> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
>>>>>                                        len, flags);
>>>>>                    if (err)
>>>>>                            return EFI_OUT_OF_RESOURCES;
>>>>> "
>>>>>
>>>>> If so, then maybe we need a temporary config option which limits the
>>>>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
>>>>
>>>> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
>>>> below 4 GiB.  So that change must indeed be behind a config option and
>>>> care must be taken on what systems to enabled it.
>>>
>>> Perhaps a good short-term fix it to use gd->ram_top here rather than hardcoding
>>> 4 GiB. This way it should work on all systems without a config option.
>> Looking at my notes from last DMA32 investigation, this may indeed do the
>> trick in the meantime. But it would be really good to have this temporary
>> workaround guarded by some Kconfig symbol, so it can be fixed up once the
>> DMA32 allocator is available.
> 
> As my recent patches show, I'm digging around a bunch of Kconfig things
> at the moment and I want to cauation against thinking that a symbol
> guard will lead to someone doing some required fixup work. At least
> filing an issue under https://source.denx.de/u-boot/u-boot/-/issues/
> means we can track it for later and put links to relevant threads as
> comments, when someone has time and interest in picking it up.
Unrelated to whether this is going to be an issue or not, I think we 
have two things to do here:

- Consider ram_top , get input from Heinrich on that
- DMA32 ... how to design that, should that be a special LMB pool ? How 
do we handle hardware which has no memory below 4 GiB, iommu maybe ?
