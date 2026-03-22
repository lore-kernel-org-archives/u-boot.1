Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0892DD58CA3
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 21:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE1A83D71;
	Sun, 22 Mar 2026 22:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jLmg6GEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECD683FBC; Sun, 22 Mar 2026 22:31:01 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259FF83BE1;
 Sun, 22 Mar 2026 22:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ff8cK2pJCz9tWy;
 Sun, 22 Mar 2026 22:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774215057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMp3U4cPP95xTZwfYvepU3pHQCJzK43tV0pUH+DeH6Y=;
 b=jLmg6GEe1EB7YsdIzp4mYmqZhf2Xpei6zeykIC1bD8bga8iT2nrH1BIHPE8U5mkYqAgITH
 htQKp6Q4tMzN9QLMK5bTf+q+A7h/E8hjKWrAmzvUI7opm1MovxJ5FQxyMnmMz8M1tkuUWk
 pP1lX3WbwW+/eQLe8yVIUe4YHtGVwLFvBil2LXauL6jcLFlLmHSnjIbv8y9Z7B7ZIGGjFM
 pmsKLIf2XgozTdQ9w0h2qQ0Dpa3d+K74qZUi+IvmTUURgB1jUcB5tdD6NHtcj0Kq9tt73W
 hpUd/WFJG1lOOg+9oOu8oRkVbhgiASxpPb4jKU8PBsVMHIElXmdFPbm9Dsq/IA==
Message-ID: <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
Date: Sun, 22 Mar 2026 22:30:51 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 96n31b6ttr3dnibmqg3r8n7xgy3ibs44
X-MBO-RS-ID: fe8fc00e27622cea55c
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

On 3/22/26 10:15 PM, Gary Guo wrote:
> On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
>> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
>>
>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
>>> same bank"). These are based on incorrect premise of the first commit, that
>>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
>>> not and should not use memory above ram_top, user can perfectly well use
>>> that memory from the U-Boot shell, for example to load content in there.
>>>
>>> [...]
>>
>> Applied to u-boot/next, thanks!
>>
>> [1/1] lmb: Reinstate access to memory above ram_top
>>        commit: a3075db94d49f415658bf7e961e1eae90d9abc33
> 
> (Cc RPI maintainers)
> 
> Hi Tom,
> 
> I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am running
> into issues caused by this patch.
> 
> I have EFI enabled, and efi_allocate_pages will call into lmb to allocate pages
> and start accessing them. However on RPI5, only 1G is mapped, so I got hit with
> an "Synchronous Abort" triggered at address 0x1_ffff_f000.
> 
> Now, that is easy to fix with the following diff:
> 
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7a1de22e0aef..1db2e37c44f4 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>   
>   static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
>   	{
> -		/* First 1GB of DRAM */
> -		.virt = 0x00000000UL,
> -		.phys = 0x00000000UL,
> -		.size = 0x40000000UL,
> +		/* 16GB of DRAM max */
> +		.virt = 0x000000000UL,
> +		.phys = 0x000000000UL,
> +		.size = 0x400000000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>   			 PTE_BLOCK_INNER_SHARE
>   	}, {
> 
> and that indeed makes my system go past the init. However, I found that while it
> is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. After
> some investigation, it turns out that efi_load_image_from_file uses
> efi_allocate_pages to allocate pages, and then feed this to f->read. This all
> eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA and it
> fails to write to the buffer allocated (which is above 4G).
> 
> This could be all fixed by having dma_map_single use a bounce buffer and copy
> back the contents on unmap similar to kernel's swiotlb, but that's going to be
> some major work.

The DMA32 allocator is on my list of things to fix.

> In the mean time, I think this patch should be reverted. I can confirm that my
> system boots fine with this reverted.
Is your malloc area by any chance above the 4 GiB boundary ? Or how come 
does EFI allocate pages from above 4 GiB range? It should not be doing 
that and that is what should be fixed, at least until the DMA32 
allocator is in place.

Please keep in mind, that revering this patch breaks other use cases, 
like loading into the DRAM above 4 GiB.
