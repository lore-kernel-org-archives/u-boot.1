Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35747C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AD183285;
	Fri, 23 May 2025 15:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OLydBEgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5501583264; Fri, 23 May 2025 15:44:22 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452DD83264
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-601dbd75b74so9277520a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748007860; x=1748612660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjmFbrAZos6SLYt7ryqbjEw7q+hODHBfiC/RtVU8GVY=;
 b=OLydBEgvgElUruvfD7wsCEFT/ax1hqCGVm0YHDIcCSS5O0tV7yuPwx6TYeNvJQPEh2
 SJ5LCos32Tecbc1FOEJluuN7jeYmcpF7aY1eDrKa4H7LXBGajnKAP5auKukyaui5BYaH
 /2mJyhBbfyOPP1MayJz4S1GyNFIvYDqEcaUds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748007860; x=1748612660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjmFbrAZos6SLYt7ryqbjEw7q+hODHBfiC/RtVU8GVY=;
 b=GITWlHzUBjbVYR47KayuoMEXthBTkxxEqZTCb+ZTupCgrzPVnpchjpd3kDOlua/wgO
 ZBVNvqsE0Tpa2sOLIIrHdZnOFTLxWhnT1gZfJb/mv+vdCXWGHuzECl6cmLRxCUMPJB5Q
 xbvmJyAOWXlch6EGJzuJ1QwQa2tI8b3g5O878sDhqGLYMoFpXv8kyjQJy9Qyqf8S2PQ9
 jvZEnntWnM9mCqn/HtAn8IQWa5KdQtsq8S0PP41M9vwuN1n4q445iNnf5YW3OtWyyTyL
 aGrSUtUhCPK08Hk33av6mXDgVg0U4hd5vm/iZZHb+hVl65fsdTL1zvH6Ebny+GaS3sdb
 aajQ==
X-Gm-Message-State: AOJu0YwGaccrrf6g7It6JwCEENpjHn2CSfPwji803UHNTcQ8oAGp/MeC
 VTMSpJn0h7XRj18WwuN0d7hDwsFXuNAh56o0SG+KFsGl3L8dkN6BUYSeypdzLJUVCGqf+jDYCmI
 RQ11b8kF0UXVaEoexBYUA18nhZxujmnNP2lK/r1Jx
X-Gm-Gg: ASbGncv3/bjdDpw4wujAeEiSf/5ZqXWLEDm2rR8Q8mM97nsY+8YMsaakXA0v455n5PE
 38ff2aiQ3hPSuQym70E7zqY2eGcKzQOU7tmoqEAHD9v1sW90tGQtow8iekpv+b/qaNXhV8xLsm6
 TUdTHSakYNU3nTeYnAU7bJuzyKHw8gXVbSFA==
X-Google-Smtp-Source: AGHT+IFMu7gaCETyvZl2F9ELcnP5wWrzU/5NptcaZJw11TjFmWoMjdic0Dp4zyvigAeJ3qgPqZ5is5+UGf7Im4jjG1A=
X-Received: by 2002:a17:907:7da2:b0:ad2:2ef3:cc1b with SMTP id
 a640c23a62f3a-ad536b7bd28mr2637723866b.7.1748007859735; Fri, 23 May 2025
 06:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-4-paulliu@debian.org>
In-Reply-To: <20250522011749.3498970-4-paulliu@debian.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 14:44:08 +0100
X-Gm-Features: AX0GCFvKoYN4DQZfs8LD_7slbvSxfRVwcsI5BGNt6t8ONWCEMMhit__x-l8ctnw
Message-ID: <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi,

On Thu, 22 May 2025 at 03:18, Ying-Chun Liu (PaulLiu)
<paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> Add efi_realloc() for realloc memory that previously alloc by efi_alloc().
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  include/efi_loader.h        |  2 ++
>  lib/efi_loader/efi_memory.c | 52 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d0c72d0bc58..ff7ca5a0480 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -878,6 +878,8 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>  #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
>  /* Allocate boot service data pool memory */
>  void *efi_alloc(size_t len);
> +/* Reallocate boot service data pool memory */
> +void *efi_realloc(void *ptr, size_t len);
>  /* Allocate pages on the specified alignment */
>  void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
>  /* More specific EFI memory allocator, called by EFI payloads */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 0abb1f6159a..4c76df642dc 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -666,6 +666,58 @@ void *efi_alloc(size_t size)
>         return buf;
>  }
>
> +/**
> + * efi_realloc() - reallocate boot services data pool memory
> + *
> + * Reallocate memory from pool for a new size and copy the data from old one.
> + *
> + * @ptr:       pointer to old buffer
> + * @size:      number of bytes to allocate
> + * Return:     pointer to allocated memory or NULL
> + */

Should go in header file

> +void *efi_realloc(void *ptr, size_t size)
> +{
> +       efi_status_t ret;
> +       void *new_ptr;
> +       struct efi_pool_allocation *alloc;
> +       u64 num_pages = efi_size_in_pages(size +
> +                                         sizeof(struct efi_pool_allocation));
> +       size_t old_size;
> +
> +       if (!ptr)
> +               return efi_alloc(size);
> +
> +       ret = efi_check_allocated((uintptr_t)ptr, true);
> +       if (ret != EFI_SUCCESS)
> +               return ptr;
> +
> +       alloc = container_of(ptr, struct efi_pool_allocation, data);
> +
> +       /* Check that this memory was allocated by efi_allocate_pool() */
> +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> +           alloc->checksum != checksum(alloc)) {
> +               printf("%s: illegal realloc 0x%p\n", __func__, ptr);
> +               return ptr;
> +       }
> +
> +       /* Don't realloc. The actual size in pages is the same. */
> +       if (alloc->num_pages == num_pages)
> +               return ptr;
> +
> +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> +               sizeof(struct efi_pool_allocation);
> +
> +       new_ptr = efi_alloc(size);
> +
> +       /* copy old data to new alloced buffer */
> +       memcpy(new_ptr, ptr, min(size, old_size));
> +
> +       /* free the old buffer */
> +       efi_free_pool(ptr);
> +
> +       return new_ptr;
> +}
> +
>  /**
>   * efi_free_pool() - free memory from pool
>   *
> --
> 2.39.5
>

Could you add a bit of detail as to why this patch is needed? It is
hard to tell which code will actually use it. So long as it cannot be
used outside lib/efi_loader then it should be OK.

I would like to remove most/all use of efi_alloc() so that the EFI app
can use the standard U-Boot malloc(). I am not 100% sure about this,
but so far it seems like the best way to support EFI booting from the
EFI app.

So if this patch is accepted, it may make it harder to reconcile
memory allocation in U-Boot across EFI loader and app.

Regards,
Simon
