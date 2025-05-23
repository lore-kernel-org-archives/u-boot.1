Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7EAC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E34832D8;
	Fri, 23 May 2025 18:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uB7pqmIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E758331C; Fri, 23 May 2025 18:35:43 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B0F832C8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5499614d3d2so69765e87.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748018140; x=1748622940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t/e8FsPu+LviheZmKeaLtxhxnS9SkKgaNDwLOrrarzA=;
 b=uB7pqmIoJJK8QRlbzDOd7I+lMAX3WOsYJYDe5HUZhBwmMKpjnZZh75/cIeEeHcUmHP
 3PRJHG9VfwN9ds13xlaWL5GVtKEVH8sj2q2SWPiuEyBaBeGtzHlvV8c5/rJQbqTLyisT
 Yb8ODYhsdHnYdT2Gyz8aApnLVQcOASCr0X+SBSRGex906z2CYZMpD+Td2dLLFGr/1hLr
 AQiKVAXdDkXd4u7HjcQF1pLILJxV/e0YWn/8pDNZpOonoH0jzAXQGH1kelTgUvr5t1Z8
 gxayA1gqe0FUgve9YKTDRo/qUYDFMKRb+B5Ijz4JT0thxyzlAj12T0SU1d2j4nXKJjeQ
 mEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748018140; x=1748622940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/e8FsPu+LviheZmKeaLtxhxnS9SkKgaNDwLOrrarzA=;
 b=qehm2H54cSQeS9ysweng5JbkWObGD8W2SLFC0fcJMw9yjL9VAe3gaPYGgbjXD4mBkA
 egOBCrYnefPG4ZVb5yOr2hVSarI2j1m0AiTQDxlalsJiSXkO1UVi8z4KM00FMk2bcD4K
 3qxcv9gROyepTEYCTiPX6avQ1Yy0H64G2ltNYDp/50Z0HiuDAO/tnQA9KSsUoVNTI+ME
 ZCzq3pHS0vPodU8n82FEvpJrWqc9aVXkG+ovQYWXYlZlP4wy/iyrG5r7J2uxKDeAhNte
 alev1+UX8lnvyhclwLlu1xY90glHYFhNY+ZkszLpBnKLX+PDllp9UuTp1gvugARc18nf
 EosA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvXtXZrqHBtJ1h0u/5N8qAOpmaZZBC5ugBLWUavoxl4R+6P166tO8fqsdFctruI10KbYl1o+o=@lists.denx.de
X-Gm-Message-State: AOJu0YzIs4twko5dhFim07UZsQJthp2MJsY9nkqXHPrjozDQr2ohWZWD
 aLc3/w6i8f0DujCbC862tR1KKIuHy10n5ZwjpXo8nqor1esurhupKw5SRTuB3SszEAx5gXk4RgH
 /i8y3VHk/PGEjaWjEHuQtHP1U2Y6kCf7s2Isvi5j8Dw==
X-Gm-Gg: ASbGnctFotlXwUaFPkwrI3xtT7P++3gTsEcx2DlTqjYWhWBU2oc4gMlYzZOhkxpAlta
 8WZLiL3YZOzTOoqEg9c7mQtaN+AH/mcs8WGYbW1b4+Rln5JUoYPtKg5Y3OLrQy1w1vNNqfrttn3
 BQsfz+s1+2wDf+m4yRs+x/HPDtQlURwRLJZZp4i1h6JQR1A3PmBIjZcbqM5Y0rMMmQSg==
X-Google-Smtp-Source: AGHT+IFgh6QTNSwnnbTV56HsQZxRySvw0wDJFnqJV5J3Xo9WyTQ2+r/LmifdR8MSh7WIp0vq8HlyoIkeDgwrx6tnz0s=
X-Received: by 2002:a05:6512:1242:b0:540:2fd2:6c87 with SMTP id
 2adb3069b0e04-5521c7ade79mr15334e87.16.1748018139964; Fri, 23 May 2025
 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-4-paulliu@debian.org>
 <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
In-Reply-To: <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Fri, 23 May 2025 17:35:28 +0100
X-Gm-Features: AX0GCFt54U3eSXbN6sVYvME5Op5Sso_gQ1pjYqWtGIk1R0YMsmlgxWBfg5541XQ
Message-ID: <CALG-KHxkLkwReXK77Pghi7hUm42i0uQ08ZQDOCHD63yo6anMqw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: Simon Glass <sjg@chromium.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,



On Fri, 23 May 2025 at 14:44, Simon Glass <sjg@chromium.org> wrote:

> Hi,
>
> On Thu, 22 May 2025 at 03:18, Ying-Chun Liu (PaulLiu)
> <paulliu@debian.org> wrote:
> >
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > Add efi_realloc() for realloc memory that previously alloc by
> efi_alloc().
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  include/efi_loader.h        |  2 ++
> >  lib/efi_loader/efi_memory.c | 52 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index d0c72d0bc58..ff7ca5a0480 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -878,6 +878,8 @@ efi_status_t efi_next_variable_name(efi_uintn_t
> *size, u16 **buf,
> >  #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >>
> EFI_PAGE_SHIFT)
> >  /* Allocate boot service data pool memory */
> >  void *efi_alloc(size_t len);
> > +/* Reallocate boot service data pool memory */
> > +void *efi_realloc(void *ptr, size_t len);
> >  /* Allocate pages on the specified alignment */
> >  void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> >  /* More specific EFI memory allocator, called by EFI payloads */
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 0abb1f6159a..4c76df642dc 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -666,6 +666,58 @@ void *efi_alloc(size_t size)
> >         return buf;
> >  }
> >
> > +/**
> > + * efi_realloc() - reallocate boot services data pool memory
> > + *
> > + * Reallocate memory from pool for a new size and copy the data from
> old one.
> > + *
> > + * @ptr:       pointer to old buffer
> > + * @size:      number of bytes to allocate
> > + * Return:     pointer to allocated memory or NULL
> > + */
>
> Should go in header file
>
>
I'll move it to the header file.


> > +void *efi_realloc(void *ptr, size_t size)
> > +{
> > +       efi_status_t ret;
> > +       void *new_ptr;
> > +       struct efi_pool_allocation *alloc;
> > +       u64 num_pages = efi_size_in_pages(size +
> > +                                         sizeof(struct
> efi_pool_allocation));
> > +       size_t old_size;
> > +
> > +       if (!ptr)
> > +               return efi_alloc(size);
> > +
> > +       ret = efi_check_allocated((uintptr_t)ptr, true);
> > +       if (ret != EFI_SUCCESS)
> > +               return ptr;
> > +
> > +       alloc = container_of(ptr, struct efi_pool_allocation, data);
> > +
> > +       /* Check that this memory was allocated by efi_allocate_pool() */
> > +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > +           alloc->checksum != checksum(alloc)) {
> > +               printf("%s: illegal realloc 0x%p\n", __func__, ptr);
> > +               return ptr;
> > +       }
> > +
> > +       /* Don't realloc. The actual size in pages is the same. */
> > +       if (alloc->num_pages == num_pages)
> > +               return ptr;
> > +
> > +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> > +               sizeof(struct efi_pool_allocation);
> > +
> > +       new_ptr = efi_alloc(size);
> > +
> > +       /* copy old data to new alloced buffer */
> > +       memcpy(new_ptr, ptr, min(size, old_size));
> > +
> > +       /* free the old buffer */
> > +       efi_free_pool(ptr);
> > +
> > +       return new_ptr;
> > +}
> > +
> >  /**
> >   * efi_free_pool() - free memory from pool
> >   *
> > --
> > 2.39.5
> >
>
> Could you add a bit of detail as to why this patch is needed? It is
> hard to tell which code will actually use it. So long as it cannot be
> used outside lib/efi_loader then it should be OK.
>
> I would like to remove most/all use of efi_alloc() so that the EFI app
> can use the standard U-Boot malloc(). I am not 100% sure about this,
> but so far it seems like the best way to support EFI booting from the
> EFI app.
>
> So if this patch is accepted, it may make it harder to reconcile
> memory allocation in U-Boot across EFI loader and app.
>
>
This function is just like calloc(). Currently we can only use efi_alloc()
and manually memcpy the data to the new place if we want to enlarge an
allocation.
So if we want to remove efi_alloc and replace it by malloc(). I think we
can also just replace efi_calloc() with calloc().

Yours,
Paul



> Regards,
> Simon
>
