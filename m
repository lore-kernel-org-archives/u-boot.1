Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009CD58CC5
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 04:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3FC805D7;
	Mon, 23 Mar 2026 05:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rTevkhLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEA68366F; Mon, 23 Mar 2026 05:16:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C790780077;
 Mon, 23 Mar 2026 05:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ffKc40FLCz9tQg;
 Mon, 23 Mar 2026 05:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774239380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rq6tUbAjZqHQBRb99wcenpyDe2Sgr5stc2JDOu09DlU=;
 b=rTevkhLTHCs+ucRtJvD2hQckQnzxcw4T6rdoBzUtUBkQzXyRIBkc+mOrJL2e/+5BOr1ICz
 JQncgRr0vbHkKiLCum/wJikOeaAG/1zjiAstVAbILzK2UZyM7t/+HZsPmEh8nemiLHwuRB
 FyciLutDAislDJN7FpZ5fuKBd/zsRJxaj449fOd89W/KTATtgM7Cu8eh/f71axd18CPZud
 0dOzPd8UzYVCIZ3RxSJKQAFK1qI6tVzvtijPAPEeYabNov5vzwojGFEzuVRXQQ6T2dxeMw
 odpsXItvk67gYwMdS5BgldGf/rnShT9NaUoCCoSdLK5cGDdAvcdREZov5lV/sA==
Message-ID: <0b82ef62-e6b5-4f4c-abdf-fa901015f465@mailbox.org>
Date: Mon, 23 Mar 2026 05:16:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: gary@garyguo.net, trini@konsulko.com, u-boot@lists.denx.de,
 mbrugger@suse.com, pbrobinson@gmail.com, yuya.hamamachi.sx@renesas.com,
 andrew.goodbody@linaro.org, casey.connolly@linaro.org, xypron.glpk@gmx.de,
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7ee1dcbcbeec9e4cda7
X-MBO-RS-META: 3z1haxybfpphtn7apar947uww39ujbuc
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

On 3/23/26 12:25 AM, Mark Kettenis wrote:
>> Date: Sun, 22 Mar 2026 22:59:53 +0100
>>
>> On 3/22/26 10:45 PM, Gary Guo wrote:
>>
>> [...]
>>
>>>> Is your malloc area by any chance above the 4 GiB boundary ? Or how come
>>>> does EFI allocate pages from above 4 GiB range? It should not be doing
>>>> that and that is what should be fixed, at least until the DMA32
>>>> allocator is in place.
>>>>
>>>> Please keep in mind, that revering this patch breaks other use cases,
>>>> like loading into the DRAM above 4 GiB.
> 
> Well, technically it doesn't break things as this is new
> functionality.

It isn't, this change effectively reverted previous change, so this is 
the original behavior.

>>> Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_memory.c)
>>> whenever it allocates, which calls efi_allocate_pages, which calls into
>>> lmb_alloc_mem. There's no malloc here.
>> Does something like this make the issue go away ?
>>
>> "
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index b77c2f980cc..44eccc0cf35 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
>> efi_allocate_type type,
>>           flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>>           switch (type) {
>>           case EFI_ALLOCATE_ANY_PAGES:
>> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
>> +
>>                   /* Any page */
>> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
>> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
>>                                       len, flags);
>>                   if (err)
>>                           return EFI_OUT_OF_RESOURCES;
>> "
>>
>> If so, then maybe we need a temporary config option which limits the
>> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
> 
> Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
> below 4 GiB.  So that change must indeed be behind a config option and
> care must be taken on what systems to enabled it.

Indeed, good point. I suspect we should call the option something like 
"CONFIG_BROKEN_DMA_ABOVE_4G" or "CONFIG_BROKEN_DMA64" , so that once the 
DMA32 allocator lands, it can be enabled exactly on those machines and 
that option deprecated instead.

> To come back to my earlier statement that some SoCs don't fully
> support DMA above the 4 GiB boundary: I specifically mentioned
> Raspberry Pi and various Rockchip SoCs.  I'm sorry I didn't get around
> to testing those boards, but I recently did some work on adding
> support for the RK3576 SoC to OpenBSD and can confirm that its SD
> controller does not support DMA above the 4 GiB boundary.  That means
> that with the diff that has now been commited, any attempt to load
> into DRAM above 4 GiB from SD card or MMC is probably going to corrup
> some memory below 4 GiB.  The Ethernet controller on those boards does
> support DMA above 4 GiB though.

I also have hardware with such limitations, but please read on ...

> That said, I'd say that on a platform where some of the supported
> storage or network devices don't support DMA above 4 GiB, lmb should
> not make that memory available until bounce buffers are implemented.

I don't think LMB is the right tool, because LMB prevents everyone from 
using the memory above 4 GiB boundary, and that makes the memory 
effectively useless.

For example, it is currently (with this patch) possible to TFTP or WGET 
into the memory above 4 GiB, even if the ethernet MAC does not support 
direct writes above 4 GiB boundary, because U-Boot network stack copies 
packets from its packet buffer into the target location (at the expense 
of slight performance drop).

I think it would be better to identify the few places which may pass 
64-bit memory addresses to 32-bit only hardware and fix those up on 
affected hardware ... and then start working toward some DMA32 allocator.
