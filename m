Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E89CF539E
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AC4892CF;
	Wed, 23 Oct 2024 17:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xOZKaCFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB558919C; Wed, 23 Oct 2024 17:25:12 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE28892CF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so5192380a91.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729697101; x=1730301901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCFICVNw5kJT/X6dG5F9wuEnUgZW62iDWUMvq3C+ROk=;
 b=xOZKaCFUR8yr1ahM5u3W1BfpW7jS55wtUngkAUROCxTlW4kgWWil4WJS8235ghGzO+
 4airePNI4CmtvoOQ7frij1bo4cSyPlC+b+DU8mTXmasgbb8pSkukiFZkTrprAUvnnQNI
 u4sZYpz4+AQDKXcN7e0+s0L9RcfqpbhLuYtBdup2tGQMrdl/EBZ/EGSXDXhv4S6tD0gb
 4ZDg154WvZridYyHhrDyA1GUKzpptuDjgzqFpDXCJVpDt1VZhyD8ezrkQGOUjzlbpoY3
 CL4X75NBq2x99SrUY6ZwbDSIbQa8DZLzOUxRXOob4qUCJMfDl1qwLJKJv5GmLLtEAMXn
 a0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729697101; x=1730301901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCFICVNw5kJT/X6dG5F9wuEnUgZW62iDWUMvq3C+ROk=;
 b=wrPkPAXZBFOBW4NsOT2e12FdYGP5xDM92I10VhJmg1pH4sZ/o0DTmfO1I24BpufPE4
 MapQ+lJVrjuwxCN+BuGAFkhEuqOdmuxVys/uxfg2kvfefPzTzBPzysz8rIUisQn7YQhe
 ItBaJKwQu15LM0sRNGgtGA0cm3JyqibMcZDfx1dcie1Qp2SGjpYdshxFSG8EZ5hbGgMj
 IwfKWRhhEHIieYZaymDeg7pUn4E8aqaMPJxjOb2hZwOYAhfqJ/9NTaadSyzMVavmjKJ/
 x+QqVVQCmYzYFjMsJ04ToLI6cOez10l7qhqZRkh90fKksiotzHOUOc+VaVlF7mSa79kS
 86yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBiJZQmdVCB/vVLaMkGY3Y2MNgoD3kmnwubOo0jgENve+mMpjCRno38DFtfdXpzYVGZgvbcqI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv4KXyVYTvi1AN2FqA7KObjU293cPZrf4rilX/VGavkvS1/IVL
 yqiJiGkn//BqxA8AHaIW04WcPacGNB7042TQJLNPmOsWmTdc6wL5r0CvqSm0RfY6jyMKEpYjr6R
 W7atvE44DvPkqKq/Y7P2l+MpZ1GHzra0MYW+H9jq+Ao2AU9eQ
X-Google-Smtp-Source: AGHT+IFU1sMVCjaxaKLSsloGnaMxOOIEShtw5gA6ktZ3O4ijkq6dRK7RDwTmlSi0VhlsrjsvqbAa4cLAznkTepA7q7A=
X-Received: by 2002:a17:90b:274c:b0:2e2:ba35:356e with SMTP id
 98e67ed59e1d1-2e76b605896mr2789259a91.17.1729697101329; Wed, 23 Oct 2024
 08:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241023143747.1209481-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241023143747.1209481-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 23 Oct 2024 18:24:24 +0300
Message-ID: <CAC_iWjJEqV03JgvVi4tN1Lpt=-f3a-qv57OnRxPz_sa1=Oye6Q@mail.gmail.com>
Subject: Re: [PATCH] lmb: Remove lmb_alloc_flags()
To: sughosh.ganu@linaro.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de
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

Hi all,

Apologies for the noise, I'll send a v2, since this is correct, but I
also need to move some LMB defines to it's header file

Thanks
/Ilias

On Wed, 23 Oct 2024 at 17:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> lmb_alloc_flags() & lmb_alloc_base_flags() are just a wrappers for
> _lmb_alloc_base(). Since the only difference is the max address of the
> allowed allocation which _lmb_alloc_base() already supports with the
> LMB_ALLOC_ANYWHERE flag, remove one of them.
>
> Keep the lmb_alloc_base_flags() flags which also prints an error
> on failures and adjust efi_allocate_pages() to only use one of them.
>
> While at it clean up the duplicate function description from the header
> file.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/lmb.h               | 26 --------------------------
>  lib/efi_loader/efi_memory.c |  3 ++-
>  lib/lmb.c                   | 17 -----------------
>  3 files changed, 2 insertions(+), 44 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index e46abf400c68..92464d6e1342 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -95,32 +95,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
>  phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
>  phys_size_t lmb_get_free_size(phys_addr_t addr);
>
> -/**
> - * lmb_alloc_flags() - Allocate memory region with specified attributes
> - * @size: Size of the region requested
> - * @align: Alignment of the memory region requested
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter.
> - *
> - * Return: base address on success, 0 on error
> - */
> -phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);
> -
> -/**
> - * lmb_alloc_base_flags() - Allocate specified memory region with specified attributes
> - * @size: Size of the region requested
> - * @align: Alignment of the memory region requested
> - * @max_addr: Maximum address of the requested region
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter. The max_addr parameter is used to specify the maximum address
> - * below which the requested region should be allocated.
> - *
> - * Return: base address on success, 0 on error
> - */
>  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
>                                  phys_addr_t max_addr, uint flags);
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 3d742fa19150..9f3f08769977 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -472,7 +472,8 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>         switch (type) {
>         case EFI_ALLOCATE_ANY_PAGES:
>                 /* Any page */
> -               addr = (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);
> +               addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE,
> +                                                LMB_ALLOC_ANYWHERE, flags);
>                 if (!addr)
>                         return EFI_OUT_OF_RESOURCES;
>                 break;
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 69001ad57373..3a9edb1e565e 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -670,23 +670,6 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
>         return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
>  }
>
> -/**
> - * lmb_alloc_flags() - Allocate memory region with specified attributes
> - * @size: Size of the region requested
> - * @align: Alignment of the memory region requested
> - * @flags: Memory region attributes to be set
> - *
> - * Allocate a region of memory with the attributes specified through the
> - * parameter.
> - *
> - * Return: base address on success, 0 on error
> - */
> -phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
> -{
> -       return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
> -                              flags);
> -}
> -
>  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
>  {
>         phys_addr_t alloc;
> --
> 2.45.2
>
