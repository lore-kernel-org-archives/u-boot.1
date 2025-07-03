Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F8C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 09:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AC482103;
	Thu,  3 Jul 2025 11:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YllWAvkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737B682A76; Thu,  3 Jul 2025 11:18:53 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC5A80194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 11:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e7b4ba530feso4743489276.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751534330; x=1752139130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M4lloaR9Pv/8lp5mlWVp2zgw4KfO7iKbCVHPg3+YEc8=;
 b=YllWAvknDptnwknqXUFOLw5QRFG4GVAgkgl6tKEW1vX8z2F8dOEWG25Ms/L8PlzKsK
 FvAtEWjp9Qj3WLf162MK+gZ6yIrT9REVupyaoIjANAhq4FGDSl9pcQPPzu1QPy5b9N6q
 +d9Nqjoi+HRMZ7V55bcwO9p+KjTEqNDmsrdZ2lAh4YEO3pcY74LFFq84PRP5rstfH9mr
 PfRIsgiGMTeXIr+fS78i0drsJdn7cO0wcrQ8oC1OoaXDnN5BCl2LLOPnZbojpNbsnUUk
 5nz1Jy0W5wWlaI5jdNS2p7YKHY1XiB0KPQO4jO4N/3eQNtrHa4QGjCGlrAVWgLSS55v4
 vpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751534330; x=1752139130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4lloaR9Pv/8lp5mlWVp2zgw4KfO7iKbCVHPg3+YEc8=;
 b=SOwEv95mUYqKNxvwTyOX5TpaklBoUB1gLifxyBwKsKIyYkEo73g6EdMRNBEcyDg7Sc
 NIGbl5I/rW4BgLfRDWZQttU2/YV80gzJ8I89DVmUXAh/Mk0HvVZj9moAJjcLktdb1lr8
 ifHvvRRjbDEe4BPUsJA5PFdq0ydWtuNGVByrJfmgBahqNXBXWYM3g4bMAwoCtVx7dD36
 PDOVGYVPDyfRdcC3jtRW45DBheOBa09aKDN5N65Vq+A8BF+zNTXwYe4Rx85k9JqZvW8Q
 cnwet1RwMIvDrhHfa1wB+ZSvUp0LbWrNigCwfEYClgud5eQvV1A67Qr2qn/5yY2LNQ/+
 TBMQ==
X-Gm-Message-State: AOJu0YzWILc5yqFio+Tl2sGim0+BEsQk9np22kkodhuzwR7bDe2raGce
 NYKoPGvCfy5Z6h/tZlz/0ehrQDAzM/KDsFUObhbmz+tuHvTaB6NN9QwIojQYZeeLmbzGi7B0eYr
 JFEbD/DBsiSA+P76VTAGOti/6qtxo66S/ragIPgaRhTEtnK3nYn6B4zk=
X-Gm-Gg: ASbGncsiVnQc2L21TueydQBpGJs9STOmml5LIY9eqb2YzeShlZ7CC8HKOLHvkG5AQHj
 JdE7Ge1RWp9TfOgu3lSgI7KYYS7ocWynw5hB0Oh8v3/gpg0mFfjC4O6MQnzTcMNMsRNha6cet1h
 LCtfw0YyFa5C6+NVBkPLLV/XsL9k1TjFGiXx00ct80qb/t
X-Google-Smtp-Source: AGHT+IFNw+5BvBBYVmeUQ28uog6osTck2qUnRRq4yK2tY0zuE/woAVXH5+7UY/j8dP7l/bskdtig54KqvUDanFSa/mw=
X-Received: by 2002:a05:690c:fd3:b0:70e:29af:844a with SMTP id
 00721157ae682-716590c4b45mr42759027b3.18.1751534330014; Thu, 03 Jul 2025
 02:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-4-paulliu@debian.org>
 <CAC_iWjJNHa0NYr=hB7pRyN-E02iwhKaOXfYfv-LyG9_JoObJjw@mail.gmail.com>
In-Reply-To: <CAC_iWjJNHa0NYr=hB7pRyN-E02iwhKaOXfYfv-LyG9_JoObJjw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 12:18:14 +0300
X-Gm-Features: Ac12FXzXKhQSVZotL1Od5ztGDt5yRRE6eYUnjA6eN7TvJP5cWaCRMghcJU5LzGk
Message-ID: <CAC_iWj+BFa2vf0uvj05Xzdbu21Uj1yxSrwe5_LD_SWi0=cpvPA@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
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

On Thu, 3 Jul 2025 at 12:10, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Paul
>
>
> On Thu, 3 Jul 2025 at 09:28, Ying-Chun Liu (PaulLiu) <paulliu@debian.org> wrote:
> >
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > Add efi_realloc() for realloc memory that previously alloc by efi_alloc().
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V4: Fix efi_realloc return failure code.
> > V6: Return error status when efi_alloc failed.
> > ---
> >  include/efi_loader.h        | 10 +++++++
> >  lib/efi_loader/efi_memory.c | 58 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index d0c72d0bc58..13ca2ec9a4e 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -878,6 +878,16 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
> >  #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
> >  /* Allocate boot service data pool memory */
> >  void *efi_alloc(size_t len);
> > +/**
> > + * efi_realloc() - reallocate boot services data pool memory
> > + *
> > + * Reallocate memory from pool for a new size and copy the data from old one.
> > + *
> > + * @ptr:       pointer to the buffer
> > + * @size:      number of bytes to allocate
> > + * Return:     EFI status to indicate success or not
> > + */
> > +efi_status_t efi_realloc(void **ptr, size_t len);
> >  /* Allocate pages on the specified alignment */
> >  void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> >  /* More specific EFI memory allocator, called by EFI payloads */
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 0abb1f6159a..1570e300570 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -666,6 +666,64 @@ void *efi_alloc(size_t size)
> >         return buf;
> >  }
> >
> > +/**
> > + * efi_realloc() - reallocate boot services data pool memory
> > + *
> > + * Reallocate memory from pool for a new size and copy the data from old one.
> > + *
> > + * @ptr:       pointer to old buffer
> > + * @size:      number of bytes to allocate
> > + * Return:     EFI status to indicate success or not
> > + */
> > +efi_status_t efi_realloc(void **ptr, size_t size)
> > +{
> > +       efi_status_t ret;
> > +       void *new_ptr;
> > +       struct efi_pool_allocation *alloc;
> > +       u64 num_pages = efi_size_in_pages(size +
> > +                                         sizeof(struct efi_pool_allocation));
> > +       size_t old_size;
> > +
> > +       if (!*ptr) {
> > +               *ptr = efi_alloc(size);
> > +               if (*ptr)
> > +                       return EFI_SUCCESS;
> > +               return EFI_OUT_OF_RESOURCES;
> > +       }
> > +
> > +       ret = efi_check_allocated((uintptr_t)*ptr, true);
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
>
> Don't we also need a check here that the memory type you are trying to
> reallocate is Boot Services Data?
> If someone uses this currently to reallocate memory, it will change
> whatever type he has to BDS.
>
> You either add a check or better don't use efi_alloc(). Use
> efi_allocate_pool() and preserve the type.

I am fine picking this up as is, since we dont have any consumers yet
-- as long as you send a follow up with either the check of conver
efi_realloc to efi_allocate_pool and preserve the type

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> # if
memory is realloced it's explicitly converted to BootServicesData

>
> > +       alloc = container_of(*ptr, struct efi_pool_allocation, data);
> > +
> > +       /* Check that this memory was allocated by efi_allocate_pool() */
> > +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > +           alloc->checksum != checksum(alloc)) {
> > +               printf("%s: illegal realloc 0x%p\n", __func__, *ptr);
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       /* Don't realloc. The actual size in pages is the same. */
> > +       if (alloc->num_pages == num_pages)
> > +               return EFI_SUCCESS;
>
> What if the size is smaller? Can't we just free the extra pages
> instead of reallocing?
>
> > +
> > +       old_size = alloc->num_pages * EFI_PAGE_SIZE -
> > +               sizeof(struct efi_pool_allocation);
> > +
> > +       new_ptr = efi_alloc(size);
> > +
> > +       /* copy old data to new alloced buffer */
> > +       memcpy(new_ptr, *ptr, min(size, old_size));
> > +
> > +       /* free the old buffer */
> > +       efi_free_pool(*ptr);
> > +
> > +       *ptr = new_ptr;
> > +
> > +       return EFI_SUCCESS;
> > +}
> > +
> >  /**
> >   * efi_free_pool() - free memory from pool
> >   *
> > --
> > 2.39.5
> >
>
> Thanks
> /Ilias
