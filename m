Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B277ACF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4750089240;
	Thu, 19 Sep 2024 16:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2Sa3vmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE0B8921D; Thu, 19 Sep 2024 16:13:22 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1EF89244
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so819606a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755198; x=1727359998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GJud7mwZZn+sICrYG4GA7wBCnSM++D1VM23I9IhfvI=;
 b=K2Sa3vmKbV/YpTRC8RROVEB4mck1pGxC6roumCTeTfvLAMfPHCMjnF27lV2ZSOsHYX
 izFn7xuTlnTfUgM6TQdwfAZhYLQ9up3exGZSC6ZwNuswjAffp8e7ZP6eKAIcXluaB3Kp
 2r3APlr1g/Wq1z3+gTV6u0Qmuh5ytDAhA8yDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755198; x=1727359998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GJud7mwZZn+sICrYG4GA7wBCnSM++D1VM23I9IhfvI=;
 b=QdI+P31c2l2g5Y87hUSBNaUmohajv8H+2coQfJSTVqPFH3aZxnNPiCn2xYREkvuDi8
 HLQX+FpOlVl+/x1Mu/LM2fi+rj+IA2nc6nQbbnqaIvh8BL1ncwAfFiPOhQhzx+amGHTw
 1w63dMm+d5b9t+Cru0K6Ff/N7IbTF4qh86x9ga4M5rg5nrZI/rafafec63Cw4+W1uPDw
 aIw8nf/PBXVtet/lmhbI2X2shVohfv/o+J9S40c2O84z2DqCO01hwQKI6vGb6VgxEc4F
 nbKh7/FkW5Y3jn8QrG1nDNnrBhmaAjtScUin7GQ0Q+iqta+VOmkvjBci34I6HXY7Q6n2
 CgxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGoktYdDsF1ozsMf9Iu4PcvuEyfVtNUrMQTw0fmn7AlwzoqcXwlvZgQ+IciiS5l4rFqfE0q70=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx95AnzCInRvduDu6oW4vijua069NlxmTraiV290duSHt1LUNB
 aDfyJpCjVCo+jiFS0aHqesN4nIApXgp8zGKKShI76XcrsXzVS9QocbRZ6K5v9DBwaRo6qXHaWAN
 nlN2vIBOLbRd0Pa8fr/51IxpavvZcsgkRgRDs
X-Google-Smtp-Source: AGHT+IGtZ2xY0wbIutV/Ust9RlZt3HDrbefYQqouY25kC0+4X/2Qv/VOgbhJ4+yDbs5gdQA/pizHxw4y1SJY4/57Bjs=
X-Received: by 2002:a05:6a21:38a:b0:1ce:f6dc:2ba8 with SMTP id
 adf61e73a8af0-1d2fcadad94mr5185316637.24.1726755198489; Thu, 19 Sep 2024
 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-2-sjg@chromium.org>
 <52f2da9e-924c-44b4-8390-7d604d07ab33@gmx.de>
In-Reply-To: <52f2da9e-924c-44b4-8390-7d604d07ab33@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:04 +0200
Message-ID: <CAFLszTj9hhNfC8QvRaQnb3HDyJ_+e9uExVo2rvy+K=_1xQOoqg@mail.gmail.com>
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

On Sat, 14 Sept 2024 at 09:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 00:22, Simon Glass wrote:
> >  From my inspection none of the users need the memory to be zeroed. It
> > is somewhat unexpected that it does so, since the name gives no clue to
> > this.
>
> Though the UEFI specification does not require it, EDK II uses
> AllocateZeroPool() to implement
> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode(). We should not
> deviate from it.

Are you saying that there is an unwritten convention in the spec? My
inspection of the code leads me to believe that all of the bytes which
are allocated are written to, within that code, so that zeroing the
bytes serves no purpose.

My goal here is to allow use of malloc(), instead of calloc(), for example.

>
> >
> > Drop the memset() so that it effectively becomes a wrapper around the
> > normal EFI-pool allocator.
> >
> > Another option would be to drop this function and call
> > efi_allocate_pool() directly, but that increase code size a little.
> >
> > Move the function comment to the header file like most other exported
> > functions in U-Boot.
>
> Yes, we should move all non-static EFI function descriptions to headers.
> But it makes no sense to move the comments of a single function and
> leave the other functions unchanged. Have a look at doc/api/efi.rst.

I normally like to do these things one at a time, when changes are
needed, to avoid massive wholesale changes with no other purpose. That
is what has happened with image.h over time. But OK I can drop that
part of the patch, once we sort out the zeroring.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Add new patch to drop the memset() from efi_alloc()
> > - Drop patch to convert device_path allocation to use malloc()
> >
> >   include/efi_loader.h        | 11 ++++++++++-
> >   lib/efi_loader/efi_memory.c |  9 ---------
> >   2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f84852e384f..38971d01442 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -758,8 +758,17 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
> >    * Return:  size in pages
> >    */
> >   #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
> > -/* Allocate boot service data pool memory */
> > +
> > +/**
> > + * efi_alloc() - allocate boot services data pool memory
> > + *
> > + * Allocate memory from pool with type EFI_BOOT_SERVICES_DATA
> > + *
> > + * @size:    number of bytes to allocate
> > + * Return:   pointer to allocated memory, or NULL if out of memory
> > + */
> >   void *efi_alloc(size_t len);
> > +
> >   /* Allocate pages on the specified alignment */
> >   void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align);
> >   /* More specific EFI memory allocator, called by EFI payloads */
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index c6f1dd09456..50cb2f3898b 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -664,14 +664,6 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> >       return r;
> >   }
> >
> > -/**
> > - * efi_alloc() - allocate boot services data pool memory
> > - *
> > - * Allocate memory from pool and zero it out.
> > - *
> > - * @size:    number of bytes to allocate
> > - * Return:   pointer to allocated memory or NULL
> > - */
> >   void *efi_alloc(size_t size)
> >   {
> >       void *buf;
> > @@ -681,7 +673,6 @@ void *efi_alloc(size_t size)
> >               log_err("out of memory");
> >               return NULL;
> >       }
> > -     memset(buf, 0, size);
> >
> >       return buf;
> >   }
>


Regards,
Simon
