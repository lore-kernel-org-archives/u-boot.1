Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11982D58CA3
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 23:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A20683DCB;
	Mon, 23 Mar 2026 00:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="eMMKZOs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834E48408D; Mon, 23 Mar 2026 00:25:48 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B9A83A91
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 00:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7363f957-2646-11f1-afd7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7363f957-2646-11f1-afd7-005056994fde;
 Mon, 23 Mar 2026 00:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=8G80lzSkGGvPsfPh2Pd1XfFIeAKrvS8i4GWcxZ1u12w=;
 b=eMMKZOs9tBfdc/MSBDgrg5tp8ZkD03nUZmPB83DiibTIW4cZzNhY2pRcDZ/ou2P1oGJklYxiwq3Fr
 Rqs7XTP3seTbLOVhh1bCBLGklDQtqQup+UNwAtIZjgtB1E/CNSnaMvluTv9UZxQuIQ3QZV5ZDfMAOp
 6sZFaOLCQZNVscxbAfZGCyq4FEiGJjkzhdt6BQb7+kVJDxcwirl0ZM2f/dKiUg8fFHoDB/fnvRoX5a
 286Zni+4GRge8QK4d1vg1ez52+0rKRAEQgduVzPdpcA2c0d/VlSOPUOuL6hkN5+2Yzw36DM8CsW2TU
 vR5TxC2ls3QwVIp3TjTz6axNH78+bOA==
X-KPN-MID: 33|npaCRznJ7ea+qi/dg8gAyQP0n/pM3BwuQd4Kz/P1UFQhUNeHZvITZOvuVJfV6pb
 ExKC6yobqMFkzCRux+uEIL6zdWuIsRsgbPEbhMBKrm0g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|heEsE9vijaaZ3eWlmpLpPCZCZLVSAiYwPJzlSEBjRklO7W+qrb46Gm6Vuus+N9X
 E4kTTye5hiPVDTsPZgZVRdA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 72c0b30e-2646-11f1-8d40-00505699b758;
 Mon, 23 Mar 2026 00:25:45 +0100 (CET)
Date: Mon, 23 Mar 2026 00:25:43 +0100
Message-Id: <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: gary@garyguo.net, trini@konsulko.com, u-boot@lists.denx.de,
 mbrugger@suse.com, pbrobinson@gmail.com,
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org,
 casey.connolly@linaro.org, xypron.glpk@gmx.de,
 holger.brunck@hitachienergy.com, ilias.apalodimas@linaro.org,
 jonas@kwiboo.se, kettenis@openbsd.org,
 semen.protsenko@linaro.org, sughosh.ganu@arm.com,
 u-boot-bounces@lists.denx.de
In-Reply-To: <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org> (message from
 Marek Vasut on Sun, 22 Mar 2026 22:59:53 +0100)
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
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

> Date: Sun, 22 Mar 2026 22:59:53 +0100
> 
> On 3/22/26 10:45 PM, Gary Guo wrote:
> 
> [...]
> 
> >> Is your malloc area by any chance above the 4 GiB boundary ? Or how come
> >> does EFI allocate pages from above 4 GiB range? It should not be doing
> >> that and that is what should be fixed, at least until the DMA32
> >> allocator is in place.
> >>
> >> Please keep in mind, that revering this patch breaks other use cases,
> >> like loading into the DRAM above 4 GiB.

Well, technically it doesn't break things as this is new
functionality.

> > Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_memory.c)
> > whenever it allocates, which calls efi_allocate_pages, which calls into
> > lmb_alloc_mem. There's no malloc here.
> Does something like this make the issue go away ?
> 
> "
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc..44eccc0cf35 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum 
> efi_allocate_type type,
>          flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>          switch (type) {
>          case EFI_ALLOCATE_ANY_PAGES:
> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
> +
>                  /* Any page */
> -               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
> +               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
>                                      len, flags);
>                  if (err)
>                          return EFI_OUT_OF_RESOURCES;
> "
> 
> If so, then maybe we need a temporary config option which limits the 
> EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.

Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
below 4 GiB.  So that change must indeed be behind a config option and
care must be taken on what systems to enabled it.

To come back to my earlier statement that some SoCs don't fully
support DMA above the 4 GiB boundary: I specifically mentioned
Raspberry Pi and various Rockchip SoCs.  I'm sorry I didn't get around
to testing those boards, but I recently did some work on adding
support for the RK3576 SoC to OpenBSD and can confirm that its SD
controller does not support DMA above the 4 GiB boundary.  That means
that with the diff that has now been commited, any attempt to load
into DRAM above 4 GiB from SD card or MMC is probably going to corrup
some memory below 4 GiB.  The Ethernet controller on those boards does
support DMA above 4 GiB though.

That said, I'd say that on a platform where some of the supported
storage or network devices don't support DMA above 4 GiB, lmb should
not make that memory available until bounce buffers are implemented.
