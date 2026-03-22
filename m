Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E34D58CA1
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 22:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5A880077;
	Sun, 22 Mar 2026 23:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n+HK6sDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23C383D71; Sun, 22 Mar 2026 23:46:20 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBC480050;
 Sun, 22 Mar 2026 23:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ffBHF4MdLz9tD5;
 Sun, 22 Mar 2026 23:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774219577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFb7O2K+77x6yRnAm77ZBg24Mw/h0A4c+JLXUtMk06E=;
 b=n+HK6sDBl4HkFBOB8wqYB/PIgcuEBMfOC43FTbiwQ/TK7i7gkv32T2Dp82Vs8LErf0kheo
 cCRacsIotHIKpWkc2faLGMHDdTThIG46tET2/boc+Uan2meGPYro35cijSKGCzJ+tfvaKj
 PbWCEWxNXZVDDrokmTIV7+0+CM/ARkPrutX5jaHV0Z2OjuwwYharNWgKkPpwIr1gZALIPE
 E/kPG4Vyc+5i4aRw4OAZMZHOh69ma/D7MIFs7QNEGz3XhyO0C68r11fXChCVkpuDe2osFd
 fHzD2kUK9q2zvLiOpTGsNLIb0d4QsV7XmuRF+8h7Nn9MpcNhTb9h4jW0LnQIPA==
Message-ID: <5ab54a41-05b9-41a8-b32c-132fd71fe39c@mailbox.org>
Date: Sun, 22 Mar 2026 23:46:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <DH9NYDQ96F1Q.1AFM2MHWL5TMX@garyguo.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DH9NYDQ96F1Q.1AFM2MHWL5TMX@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tf8itqt6mtdt8ix3cod3m3z6dzissrqu
X-MBO-RS-ID: d8cc7192965eba0b394
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

On 3/22/26 11:27 PM, Gary Guo wrote:
> On Sun Mar 22, 2026 at 9:59 PM GMT, Marek Vasut wrote:
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
>>>
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
> My system is indeed booting with this diff + the RPI5 memory map diff that I
> included in my previous email.
> 
> Tested-by: Gary Guo <gary@garyguo.net>
Thank you for testing. Now, let's see what Heinrich and co. has to say 
about this.
