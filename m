Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95678C54ED1
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 00:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070D0838E5;
	Wed, 28 May 2025 02:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m1vvuQn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DBA838E6; Wed, 28 May 2025 02:24:42 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92B38312E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32934448e8bso40515581fa.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748391879; x=1748996679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SYCMwprTcLKV378wvIsvJEmftjQXtSBzEtIk+OHR4xg=;
 b=m1vvuQn64jdKJbG1+vcMsPZ6C1R38r1gJgzT9+HkdnSiDJVvGUhHJSSVC4kY50tOZb
 t3KDT9LlLnnQCKtc/GIctrWSovfW9KbpKYqnmgy+ua1lHk5xYMEuepSLLVTsW/LEclFQ
 pehlTghnO5QlRRcOQVvPl/0wzvCoj70rACn3chupViHjV632r46yiGOGXHPhGUMl9FHz
 lkhxXuqnd5YqjNNPLOywdQTNiFVt8Vo7yxSmTrynTbLDkXdpKVS4PBK+/x7jGRDrjkpd
 vQU+p/UcLpFv+xuTBoifTxFLHYbmWF/dVye0/x0vNUHap8NsSse4hobQUyRhBI17Vuk8
 e5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748391879; x=1748996679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SYCMwprTcLKV378wvIsvJEmftjQXtSBzEtIk+OHR4xg=;
 b=Izmh+tNyD1qJHViTqxkN8DkIcaE6VoMoc/lZ65ZcWB3owNMHB+U60KMK3+u2g9Otde
 ZlHX2I5ouE2cc/zAVm13CWwL2ZFE4jOHKa66FmkO82CQBky41MNI4jplQUcho62WBmjr
 n8gqP/t+uhounBQpf93bNE8HnrtO9DmuVlfplfoUTalXAELZH7wYUbslKlb5ZOqcdCu3
 5A6EdW+gbViBVSI2e9+mzrdHIsyQ6mlfcbDVRN8E5uRPRFzNvl+bJDEgiMACqG22xP75
 LogrjbwkmhY8WaYW1uU2EetvBgarPfx8VLjE5cwSWXPeRgGLMMiQA6stmFJXYbB2DLiA
 mHoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhptmdPZDUbOsSxS0xMkssQU/RkffFskqLXUOzqJ+VUY5BSKqjB/tLwNcL5ZYOkhXU1A+N18M=@lists.denx.de
X-Gm-Message-State: AOJu0YxisA1Wc+k16Tcd/xEymzc1Sf8DYvQvn8udNbIYgj80kABlzTGu
 4+KowBMA7PFWamTuy3t/vxqsJauDWS1ukd3S5HH9xxEpA93YzqB/1fLCKXZfzh5nBJYC/bRQHwp
 TxUEjdNITi7f8AeQq1FODwb9/KosfhKdsjdSi0nSLvw==
X-Gm-Gg: ASbGncvBBoekQM7Tn4/5CGIy4nhGtJXA/oublv7zA0xTdIE0WghZ1N/8w1EM0iT+lwe
 vimXummjSZrJv8gJ/R+oL3C/MpOT1BPLa4D9UbiwW/Uvv//cdjiMMJ9DhjYBipf9uV3kqg7A5iW
 l5ZmgMNrhiQVlvXiiPkso/M8hU7bmr8IcDImYT6gxZyXHc7tlMbrf+XB+9PUNlxFC5ccCOHVBlO
 RwO
X-Google-Smtp-Source: AGHT+IGNICWTVT/yuU77DMHqJMt6vNUuih4OmqYhyQX7pyjv09m2s7NgPoVBJ0qxaweGIDYktr3B/0TucxD7AGR97qI=
X-Received: by 2002:a05:651c:12c3:b0:327:ef96:dc28 with SMTP id
 38308e7fff4ca-3295b9f3edcmr38699631fa.24.1748391878987; Tue, 27 May 2025
 17:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-4-paulliu@debian.org>
 <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
In-Reply-To: <CAFLszTjBDedSGTOLGy4w41+sG2H9yDBCSPcYwUhmWi52myjBoA@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Wed, 28 May 2025 01:24:27 +0100
X-Gm-Features: AX0GCFtFyYgNio_9ZX2eujVQxUw7dz0mmqW5mfpcvE5h2rbu1U5Swx7Nn6qVn98
Message-ID: <CALG-KHwgrP-e1phxqA6GqEtfAZuh3mcF5GiZZsw_NZho+3YL=A@mail.gmail.com>
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

Hi Simon,

I look into the code. It seems other functions in the same .c file put the
comments in the .c file instead of the header file.
Should I move the comments to the header file? I'm a bit confused.

Yours,
Paul



>
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
> Regards,
> Simon
>
