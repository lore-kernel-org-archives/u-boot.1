Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2825C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 15:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2DE81760;
	Mon, 16 Jun 2025 17:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ehm5O9x5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66A981E18; Mon, 16 Jun 2025 17:35:17 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F7080E9A
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7d925ff60bso3992134276.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750088114; x=1750692914; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh3KTuDshWsWs8bSidqCEoosB96mCfCytBVIaGX2lYc=;
 b=ehm5O9x5leXfhv9ckK0/R29Rt/1IMMko4ni2Gv3fB5ACodL856Bb6nGJo7rGb0sgxL
 Zm70SVeIkI92A/CNeSB8TeysYxc60JN+7dI5eGBlB03y3lJ6RbMl2f+MD/ChXGzLxrk+
 Ak/5Pl85dpLG1sW6J+gJjqtnzTA9uLfMOzeeshp0mwRtqvMz4DeFKiRGPlWgb5hMGDYf
 /BkmXvG9GByyoOHr555Mg8pVVE2Qq4WPnc7oq03JD38ASE7bhEVq/ri6beTKc8hLHI+T
 mQajUXW6Ks5u1QfHLRy5ZW6SkMe75CrUjwfMFaOgllBq821H2LrmmFalXxpNIR0aSYyJ
 U6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750088114; x=1750692914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lh3KTuDshWsWs8bSidqCEoosB96mCfCytBVIaGX2lYc=;
 b=ebWMAbz6v0vWR40j6opncm8Ky5qCZJO5ovDaseK2dNNxN/vIm6zT51knFrpsoQ7cUr
 /9HUZ05ZhgxSPcg+YEScABFvkxHfWo3O8XI0BVhQZ4UIuegvKONwm0D1CJUWIcilGX+D
 xL7AGzfH/YpyQi6SkkvDCUeYz/+aX+FbBpDBohi9lXchEMtFSzCu89TmOnt4EvXS7wz6
 I9m3rJb/N7E3f4DjGekNyF014Mp/QhfBYw+XkueZkV1G93xvok/KOpmcq8IfwqwgvXN1
 PcHUJ6DVCufHBDGXljLtsjb8ZDsOgQZOHxSFBznZA6fCUPzbbh6SxyzzoHeFsw7l/D9u
 8jyg==
X-Gm-Message-State: AOJu0YwmflI/7cFB232YH+oEvz9fE/WgMOSWywPwgK9tr0gDKadjVk0M
 k2+aA3jWXvj7nQzHFLsAV3dqit+1fkZ3gOciIHXksZ69dGe4s1U1vrXyD2ypAVhV2K+PT1bmZUI
 4OSmym2K7f70n29bCdrx3Hnwg1Lo5M1kSXOoj4CWcYQ==
X-Gm-Gg: ASbGncvUFCFqywcgVLa0f5zQOmAZMIIKvOv8Xuu20KV7J7VgxGMjUPykJq1aTqLGbvk
 SBcsjiajb//oSPiqaux6m4qflSXOOPvTU0mtYJ1QZULnCL5icy+T4/XQDUV4VLltDJSj31sa3K9
 JRzIoiOeeSEQBYhvFznhghgQijXodcv1vEtxnEloPv2JhU
X-Google-Smtp-Source: AGHT+IEHtk0x/6Am6ytwB++FOZNgzDmp3x3sDXxb6OGRjuecgVy41jPqA90fdd/58xceRZwVZ5sGZHdROgrUuisZX4w=
X-Received: by 2002:a05:690c:700e:b0:70e:2d1a:82b8 with SMTP id
 00721157ae682-71175462f8fmr134503077b3.34.1750088114227; Mon, 16 Jun 2025
 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-4-paulliu@debian.org>
 <CAC_iWjLhWKRdGmuwV6OO-yKBbbjE2Kdr=NrxbMoR9Rxy4NYM=g@mail.gmail.com>
 <a6e2637e-a748-4b0d-88a5-13431284dc06@gmx.de>
In-Reply-To: <a6e2637e-a748-4b0d-88a5-13431284dc06@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 18:34:37 +0300
X-Gm-Features: AX0GCFv_gyrxZE1pDNLZZah4LaqtqU5ZIwVB2MilWmDcSDVu2TvcmC6HrYx_UyU
Message-ID: <CAC_iWj+GxJ9AL2sF9Cvhp=ikuwkMDv_gWbmt4j-HBvYW76gudA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
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

On Mon, 16 Jun 2025 at 16:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 16.06.25 15:09, Ilias Apalodimas wrote:
> > Hi Paul
> >
> > [...]
> >
> >> +/**
> >> + * efi_realloc() - reallocate boot services data pool memory
> >> + *
> >> + * Reallocate memory from pool for a new size and copy the data from old one.
> >> + *
> >> + * @ptr:       pointer to old buffer
> >> + * @size:      number of bytes to allocate
> >> + * Return:     EFI status to indicate success or not
> >> + */
> >> +efi_status_t efi_realloc(void **ptr, size_t size)
> >> +{
> >> +       efi_status_t ret;
> >> +       void *new_ptr;
> >> +       struct efi_pool_allocation *alloc;
> >> +       u64 num_pages = efi_size_in_pages(size +
> >> +                                         sizeof(struct efi_pool_allocation));
> >> +       size_t old_size;
> >> +
> >> +       if (!*ptr) {
> >> +               *ptr = efi_alloc(size);
> >
> > Shouldn't you check that *ptr != NULL before returning success here?
>
> Hello Ilias,
>
> Do you mean "check that ptr != NULL"?

No i mean that the efi_alloc() call can fail as well

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >> +               return EFI_SUCCESS;
> >> +       }
> >> +
> >> +       ret = efi_check_allocated((uintptr_t)*ptr, true);
> >> +       if (ret != EFI_SUCCESS)
> >> +               return ret;
> >> +
> >> +       alloc = container_of(*ptr, struct efi_pool_allocation, data);
> >> +
> >> +       /* Check that this memory was allocated by efi_allocate_pool() */
> >> +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> >> +           alloc->checksum != checksum(alloc)) {
> >> +               printf("%s: illegal realloc 0x%p\n", __func__, *ptr);
> >> +               return EFI_INVALID_PARAMETER;
> >> +       }
> >> +
> >> +       /* Don't realloc. The actual size in pages is the same. */
> >> +       if (alloc->num_pages == num_pages)
> >> +               return EFI_SUCCESS;
> >> +
> >> +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> >> +               sizeof(struct efi_pool_allocation);
> >> +
> >> +       new_ptr = efi_alloc(size);
> >> +
> >> +       /* copy old data to new alloced buffer */
> >> +       memcpy(new_ptr, *ptr, min(size, old_size));
> >> +
> >> +       /* free the old buffer */
> >> +       efi_free_pool(*ptr);
> >> +
> >> +       *ptr = new_ptr;
> >> +
> >> +       return EFI_SUCCESS;
> >> +}
> >> +
> >>   /**
> >>    * efi_free_pool() - free memory from pool
> >>    *
> >> --
> >> 2.39.5
> >>
> >
> > Thanks
> > /Ilias
>
