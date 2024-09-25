Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FD7C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C90788BBF;
	Wed, 25 Sep 2024 14:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hE1vX1fC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C10B88BBF; Wed, 25 Sep 2024 14:51:48 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AD188CC3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-846c36009d5so1860166241.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268641; x=1727873441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCYFTxibRzoEcffKaNzPgYiEJs1+BFVWgh/EPL+UtME=;
 b=hE1vX1fCQ32PhKjAyfYLgP02pJVm1kaSu1bijvluj2lZ+MG1074cggDwPR1L9Eb+h3
 mxCJSG+JFjEyvMjiUgS1C1wZKaOAp6xQkPo02cLxnZ2yAobUW6qMdVIgVPlhVC+0lDYT
 ftIPHkBCXSBZ0JNqDOozX06Gyh00hU31vhFVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268641; x=1727873441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCYFTxibRzoEcffKaNzPgYiEJs1+BFVWgh/EPL+UtME=;
 b=d6pnhvMBGBY35CowpfRyfi1JhmFAKivd5O8hfEYMmUH5qz5L+dJWKbt+ZsAUp7QA7j
 TCPwSRjyrrvzIvudoOXgormjnBYKulrNlaN8g6lCy6ipTPzApU7jx7CL14kqi+27v1Ym
 2RJbwC3I9x1wUZUIb8X725KingUWXrfV/6T8gQc6AHgFJ9WX9Vn/uzVd69E8IBq7XIXO
 /BoyGddlkG+/eKOIw5Gc4dthEGlFLQuTvk/ESTKbBQhBWCr4qVXlwkKF+uAvpkuxy/JJ
 wWCEJIgfwrYnOO67QNvi0PUAHNf8+x0t53iUSG7qrCVpToI0M4WAXGbh56dCaYntrlkt
 NaAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWghYibgMlXMnp6a9zV3WJnLbV8pd4eLQ1M2yC/kw3+SQkD3Xkh8yjTMkqP8Aq84waGwADsHFg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/6LyFBvFfurC4A4ggnQBj09hE7abbClM3r+NTkzrDInQMxIW/
 +2/y6+11/k9fxoelGUf6pnIvK5mRNjS1O6lmtaoLgF4zF9RZYtgaUHY/eD/xqEJ/0Bqd9mA2bCM
 D+7W6GKLDr6XiYLMk+pzyoGmfsFDJr8LVp4qx
X-Google-Smtp-Source: AGHT+IG1upIIZRkXJyOr1Ip20je6IGD2jHwADYHOoalRxXNIJE5lPOaU0zL+Xtp6TsFMF0U/Y3hhQ9tsXIvARGuIEGo=
X-Received: by 2002:a05:6102:3ed1:b0:493:b9f8:82f2 with SMTP id
 ada2fe7eead31-4a15dd4bfdbmr2725255137.25.1727268641415; Wed, 25 Sep 2024
 05:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-2-sjg@chromium.org>
 <52f2da9e-924c-44b4-8390-7d604d07ab33@gmx.de>
 <CAFLszTj9hhNfC8QvRaQnb3HDyJ_+e9uExVo2rvy+K=_1xQOoqg@mail.gmail.com>
 <8309d2cf-ae84-4907-a6a4-9d6f5a4b8206@gmx.de>
In-Reply-To: <8309d2cf-ae84-4907-a6a4-9d6f5a4b8206@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:28 +0200
Message-ID: <CAFLszTjPYWVhDnyOR=g9s0u3rocjj3S2n6g2AuiSEcnJOm+Gcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] efi: Drop the memset() from efi_alloc()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Mon, 23 Sept 2024 at 14:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 19.09.24 16:13, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 14 Sept 2024 at 09:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 02.09.24 00:22, Simon Glass wrote:
> >>>   From my inspection none of the users need the memory to be zeroed. It
> >>> is somewhat unexpected that it does so, since the name gives no clue to
> >>> this.
> >>
> >> Though the UEFI specification does not require it, EDK II uses
> >> AllocateZeroPool() to implement
> >> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode(). We should not
> >> deviate from it.
> >
> > Are you saying that there is an unwritten convention in the spec? My
> > inspection of the code leads me to believe that all of the bytes which
> > are allocated are written to, within that code, so that zeroing the
> > bytes serves no purpose.
>
> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode() is an API:
>
> You have to consider the current and future usage outside U-Boot.
>
> For saving a few microseconds I would not want to give up compatibility
> with EDK II.

What sort of compatibility are you referring to? Are we implementing a
spec or copying Tianocore? Also, did you miss the second sentence in
my response?

>
> >
> > My goal here is to allow use of malloc(), instead of calloc(), for example.
>
> The caller of the API has to release with the memory with FreePool(). So
> we should allocate it with AllocatePool().
>
> See chapter 10.5.8
> "EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode()" in the UEFI
> specification.

Yes, my patch does not change that.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> >>
> >>>
> >>> Drop the memset() so that it effectively becomes a wrapper around the
> >>> normal EFI-pool allocator.
> >>>
> >>> Another option would be to drop this function and call
> >>> efi_allocate_pool() directly, but that increase code size a little.
> >>>
> >>> Move the function comment to the header file like most other exported
> >>> functions in U-Boot.
> >>
> >> Yes, we should move all non-static EFI function descriptions to headers.
> >> But it makes no sense to move the comments of a single function and
> >> leave the other functions unchanged. Have a look at doc/api/efi.rst.
> >
> > I normally like to do these things one at a time, when changes are
> > needed, to avoid massive wholesale changes with no other purpose. That
> > is what has happened with image.h over time. But OK I can drop that
> > part of the patch, once we sort out the zeroring.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v3:
> >>> - Add new patch to drop the memset() from efi_alloc()
> >>> - Drop patch to convert device_path allocation to use malloc()
> >>>
> >>>    include/efi_loader.h        | 11 ++++++++++-
> >>>    lib/efi_loader/efi_memory.c |  9 ---------
> >>>    2 files changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >>> index f84852e384f..38971d01442 100644
> >>> --- a/include/efi_loader.h
> >>> +++ b/include/efi_loader.h
> >>> @@ -758,8 +758,17 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
> >>>     * Return:  size in pages
> >>>     */
> >>>    #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
> >>> -/* Allocate boot service data pool memory */
> >>> +
> >>> +/**
> >>> + * efi_alloc() - allocate boot services data pool memory
> >>> + *
> >>> + * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
> >>> + *
> >>> + * @size:    number of bytes to allocate
> >>> + * Return:   pointer to allocated memory, or NULL if out of memory
> >>> + */
> >>>    void *efi_alloc(size_t len);
> >>> +
> >>>    /* Allocate pages on the specified alignment */
> >>>    void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> >>>    /* More specific EFI memory allocator, called by EFI payloads */
> >>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >>> index c6f1dd09456..50cb2f3898b 100644
> >>> --- a/lib/efi_loader/efi_memory.c
> >>> +++ b/lib/efi_loader/efi_memory.c
> >>> @@ -664,14 +664,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> >>>        return r;
> >>>    }
> >>>
> >>> -/**
> >>> - * efi_alloc() - allocate boot services data pool memory
> >>> - *
> >>> - * Allocate memory from pool and zero it out.
> >>> - *
> >>> - * @size:    number of bytes to allocate
> >>> - * Return:   pointer to allocated memory or NULL
> >>> - */
> >>>    void *efi_alloc(size_t size)
> >>>    {
> >>>        void *buf;
> >>> @@ -681,7 +673,6 @@ void *efi_alloc(size_t size)
> >>>                log_err("out of memory");
> >>>                return NULL;
> >>>        }
> >>> -     memset(buf, 0, size);
> >>>
> >>>        return buf;
> >>>    }
> >>
> >
> >
> > Regards,
> > Simon
>
