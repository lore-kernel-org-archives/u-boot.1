Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220EBE9A754
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF5680212;
	Tue, 24 Mar 2026 10:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AR/XDR9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5763E80517; Tue, 24 Mar 2026 10:49:37 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6202C80212
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79df972so5624091d50.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774345773; cv=none;
 d=google.com; s=arc-20240605;
 b=gpTxgskto+RuBf9D+Ua1OvQAzDgSdiHtO76xGSynzCRc/2n5Up8JiJGgw7lxovAVEY
 hu93+SQ1xst0ZMOYg9eN4tzJGjtGMkz2dKbSxEdjk5LXyRRmf68s5FaXHmCItg1IGDtM
 XDnRVu7C09mrDnlJFC1E7yrEbAKlEnH5BfoLRRLGTQBK46cxDOVCE74KSNLE7Lpk5FRc
 1Awf4Qh9P4r5KDdFXCeLZd3gq2noKRbk5qDmfZWYXK8Sr7AFMs8mso3aEknIyQINQvKC
 AS4WbH4uiP9VF5vjvzyvZnhBi8kJsSpmG6LAW0e8EeTErGdxwvFPIxTZSVAtRwdmcXk4
 B4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xFu0hFyALDLHx+jkKG+mbvIHqKHpuKCTvZxD1nm6fFA=;
 fh=eSzp5fxtWt4FnFP2t4Qsi8Ys6PX4zU9FxBJ2dXdnJok=;
 b=V4VGTo5YwsqMJMk3DSbOmwjhhWtoa/IHSoQC4mIgfqvgYmJirB+nT0x5XYp79Vw85O
 V4pqvHWPflJql7/+Qypv4mY/4kvoGwTN4yKDgrti0QcIchXy/ve8a3Y3GgEPzUeR+yw1
 4Z8UXErsi88KD/jyOjjFw7gDMUFAYt2yG2Cb3fxv6hVplMx3NiAoBA5XT4axFFMh+M76
 B09wJXjJA7QuiUv0lYfG0E3xNypZYO98zey4ZZz7unBNdjjYOFFSudvf1Girood1HQUb
 VvUrPtRd390buxerzV4mJPOKoQMBzJxIUz2nKWeuSK0A85ehTZW7E4rto5RGpsLtTYpC
 DKoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774345773; x=1774950573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xFu0hFyALDLHx+jkKG+mbvIHqKHpuKCTvZxD1nm6fFA=;
 b=AR/XDR9ULhDY4S9tJ72Tu31sDldEOou3PStCP7+s3dg7/El6tYudjhYjS8mKkXSKYh
 ImBVabjWafSi4uvueLYxxwv7HwdgIgjx0+9pYQdtMAvMf7w9wK1Nbp7v/GL1OAzYig+w
 bA468QMS/rH8OOjAsennK48zSg4GcsZCyJKdBqLr4P5Z2gLBXLTfr346Etx14brs0uo1
 MIC6+/BiFRi+9K8J8oBsYDeQIjAPvyP65hYNMa5UFCIr/SpUKixismGR1WM1jtULs3By
 dQEpxG++MpmRGiPqLNdFMN65KPrnsCv2tK8NKqz+APGtWqcioByiniaNGhm8BrfynVdw
 F6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345773; x=1774950573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFu0hFyALDLHx+jkKG+mbvIHqKHpuKCTvZxD1nm6fFA=;
 b=UyJo5GERuqHZ/adx1u+2nZa+zhuarbFz9PJuWZexk8uTtbfqApqFSInP+NRbJjmcRc
 FFOZFRPI8NScPvQsIzoLWDl1wz1xIvuYLmQF/SLOHj80YLjQCt413Kw781Gt/dYlCgsf
 zo5LfCaiun1JbLrJCORQB0P3sjo24p80DActH1AvoGQIjiqaeLda53AbfSJMxNq00jCw
 WdIN26hkO+9/rzD8LcFzplGBqQmm0NFiRsoFfvtNherrVZZAMmdSFsLFNHwZNyQmqtjN
 tpF5/gfc9QDUeHww/pUmYULgPrp7M71qfdJFdjKX2aLLbOPoCRgYBZZodYw6yCMlDVVs
 1uhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYDm56S90ncKX4e+y3Z9Mh/tIBV1kXTwP8hR8FTxiyvQYm1G3lVczwUuNlxePtOX/n6/PnUc4=@lists.denx.de
X-Gm-Message-State: AOJu0YwhMq1Rl8L86utNUBp8ROyM+w36CNu0+x0cc/r042LB00k3P1ok
 IXE9YoWz5jsqp9EWyiP7dgszL5pTaWaH8Q0hX2JMl+HRUsVVn56o5gtcXZS/LS0kG2DrE4ndu82
 PeGsT8ApBGnaGTXLWlCyQgQKCSG5eUsvTaL/Q48Rgwg==
X-Gm-Gg: ATEYQzyfYPxOLlbzzBe5oNpGiycr9sM55A12aTUhM/0d/n1fQmfQI6CA3l+Cpsvfq2J
 K2Sj6iCL+erRqZGTzXIh/NZlVUfJMiWNLLZ8ydyV6Ndi2uF/HZ7Q1GAA8u9twNiDM0lhDCPMf3o
 rpfvAMc2RVXwdSZdf+ibwTAHQ8FModTiFwNxf12BZ1UEp138jcgqZv/cPE/oRppka3XZWAJKnCL
 CPOGjN11hyL/8gSEfzruE9z1MBEg78eyw/CI8kmZufWdm5+7+sKmxefRopnDrmYQ3sMTxVv92wq
 pDSqqTY2uCm7zydhi3tW00rfBtm/Tm94Zggih+tkB+N/nFiJ/UQ+PqnANUYoPjVwx+hgltqg6wI
 kNZ0uLlHgfEXrAdYDdCVtNe1/6031tOcB5rM6NjvpCygeWS26lPZ+A1PILZfYpqIaSSEN9MoHNP
 GeQak/2ArRklUL/JVylBudiVFmy6IREKLNdwJsjAaDScvGiV3mAvvxcnkwY5RDsl0A5xmF+YPkI
 PxPw6Mg94pkOb/mJLPvZHHxJjU/VM2H7QDCmA14gFvvw1MDi+PrR2gN8EMuwHuIueGTJ+/LD5yv
 jT1jFDrALkveXt1q5X7jmTvN2saF1NXo9LGFhOWnz12k
X-Received: by 2002:a05:690c:c4fa:b0:79a:b861:e2fd with SMTP id
 00721157ae682-79ab861e96amr54297377b3.21.1774345773117; Tue, 24 Mar 2026
 02:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
In-Reply-To: <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Mar 2026 11:48:57 +0200
X-Gm-Features: AaiRm53MVziQYRI2aU8T-7BRiNYGF-9szpyx4Cp-4xCbbpi0GlPA0dWRsGbKgVM
Message-ID: <CAC_iWjKae0BbP12KofJJTj9W9gYgf0mS5D2+=289XHKHDhmgYw@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 U-Boot <u-boot-bounces@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Apologies for being late to the party.

On Sun, 22 Mar 2026 at 23:59, Marek Vasut <marek.vasut@mailbox.org> wrote:
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
> >
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

This kind of breaks the EFI spec. The description in the spec is
"Allocation requests of Type AllocateAnyPages allocate any available
range of pages that satisfies the request. On
input, the address pointed to by Memory is ignored."

so in theory *addr should be ignored and in fact it's overwritten by
lmb_alloc_mem(). The reason it works is becase you change the argument
from _ANY to _MAX below.

I am noit against deviating a bit from the spec as long as we get
things working and have a long term plan on fixing it properly.
I'll go through the entire thread and see if there's an easier way out.

Cheers
/Ilias
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
