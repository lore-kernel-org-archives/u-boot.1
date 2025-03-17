Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E914C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 22:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6CB811B2;
	Mon, 17 Mar 2025 23:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUnkIxEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E0580F70; Mon, 17 Mar 2025 20:07:06 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1841800B3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 20:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e60b75f87aaso3667827276.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742238422; x=1742843222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6RevE+/2qxmOX1OsAOO/NoYDCUJbl++tVOD4TWknW3g=;
 b=SUnkIxEy5ufr+k0zD4SrJrYeh8IYwwoL4mBivsPjCKH+wGyYeU/K0HEEJjZlltEM8H
 WikmDvV/Fgv+61WZMFNMViTGwGxJMFpUWy3S0rTKrzesRbIGMDvo1hyD7KIRpLUTDYN3
 6ydj/dxB0EHJxUv7Ln40+zANHVy6AThYhlAEB7A6+p9VNNV25a0Tdj7ZrniEcssYZ/jX
 UCTU1ljJE0xdZP3/0K8jXxFJ0H4bF08DL/PEd4Jai+rlRf9Dh6LhaOvupEeBppqVRWQS
 t0Oxh2LrqeVkonkb0cE0HtYgzK3eVbKArv8i3re3qkeWuyU0sS6bg7z1k70ltNAqYTHe
 0X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742238422; x=1742843222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RevE+/2qxmOX1OsAOO/NoYDCUJbl++tVOD4TWknW3g=;
 b=u73OWwofaLMwBTTQoNQFK0XTvr8urQTYuEAVDmWSgCApvwZOI/YWldsnX3K81lq/An
 /PIJbDvE2G/3gDTG4z8ukL7x2fn8etMmRhMcWNWbRAZ4jlwQz7YO3rsJJdXWnG1dF+9c
 +8+jCLuYECFOpoXv/XjshlmPbNSiwnelNZMqDwxGYoYSVz18grG//7zAtRD4OOLm8WQO
 lZEOACFcsgO2AnOehFXb2C0oVoJ+L0K1NgnvwqD4xlFX0PzWBvU18JRoEVYWPJRFFeiJ
 XZP9xUFHR2R6t3YNe6xpnuEZ4e19FVsTOBkvh//jzsA2DWqWB/awwuKxuHNo0Sn24lRm
 2zKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeGygz2g7cS1uStu4eWh1AONqKQVIVHJ1ATXUzqdovyzGXJMXBAUhVGliK1PCf8YPYWGB5z0s=@lists.denx.de
X-Gm-Message-State: AOJu0YwYss12K1ZVSuBi6Nh6XbMwazxkDRjx+9oPfuDIyIZ8tO3g8OGI
 lvpQYI0pIACTjuU0dd+JFEpgno7s37uRg6gFgaEs/Bown7iwy/nKKWc/eSFBnkZSSyu60RwNzhP
 RIGHMgp95VKOagWslZuymeOTDQvbnJmkAEbE6aA==
X-Gm-Gg: ASbGnctYcOUyk+FOk4BvEBrGStMdY9/WAn0xvPfhOr9RCWs47QCzdyJMh2RTyEaWkDG
 0E2P1g5eCRndNiLx3M9CZi1PUaRlfMmgn4wiVrFVytJy5XFPJAwgC5caTtsjNeC2p+CJ3fqdkwW
 frqGJrCgkHiJtEJtyJ5cR+vpmLLcY=
X-Google-Smtp-Source: AGHT+IHo5HZyjt848wiuxLI0OEj6XSXBPui+ICTN3Q0WxJt5DqBnAeizn1fVgujg9QXdsvTMTmwjqtkPL6Jb6BbB0M0=
X-Received: by 2002:a05:6902:2612:b0:e64:b9c:47b7 with SMTP id
 3f1490d57ef6-e64af1506e9mr1417833276.19.1742238422574; Mon, 17 Mar 2025
 12:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <875xk78wba.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875xk78wba.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 17 Mar 2025 21:06:26 +0200
X-Gm-Features: AQ5f1Jo0kkqDsRovgtxwJj1E3Q7XE_haTrZKUht4pyaht9YS4YYxjLEy8aIzsRw
Message-ID: <CAC_iWjLY6vytm6UB=Fc3kKpMWQ3=nc19eAi+KjjbwHb9Dfw=VQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, e@freeshell.de, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com, andy.tang@nxp.com, mingkai.hu@nxp.com, 
 Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com, 
 udit.agarwal@nxp.com, meenakshi.aggarwal@nxp.com, 
 patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com, 
 Manish.Tomar@nxp.com, matt@traverse.com.au, caleb.connolly@linaro.org, 
 tien.fong.chee@altera.com, michal.simek@amd.com, sumit.garg@kernel.org, 
 patrick.rudolph@9elements.com, alif.zakuan.yuslaimi@intel.com, 
 Oliver.Gaskell@analog.com, duje.mihanovic@skole.hr, robert.marko@sartura.hr, 
 lukas.funke@weidmueller.com, peng.fan@nxp.com, jj251510319013@gmail.com, 
 adrianox@gmail.com, sjg@chromium.org, sughosh.ganu@linaro.org, 
 vincent.stehle@arm.com, raymond.mao@linaro.org, maks.mishinfz@gmail.com, 
 semen.protsenko@linaro.org, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Mar 2025 23:17:43 +0100
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

Hi Mark,
Thanks for taking a look

On Mon, 17 Mar 2025 at 18:18, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Date: Mon, 17 Mar 2025 15:38:36 +0200
> >
> > The EFI subsystem defines its own bounce buffer for devices that
> > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > which can be reused instead of defining another symbol.
> > The only limitation for EFI is that we don't know how big the file a user
> > chooses to transfer is and as a result we can't depend on allocating the
> > memory from the malloc area, which can prove too small.
> >
> > So allocate an EFI buffer of the correct size and pass it to the DM,
> > which already supports bounce buffering via bounce_buffer_start_extalign()
>
> The existing bounce buffer code servers a completely different purpose
> though.  It exists to make sure that hardware with cache-incoherent
> DMA can safely do the required cache flushes.
>
> This means that:
>
> * SoCs with cache-coherent DMA don't necessarily set BOUNCE_BUFFER.
>   Looks like you added that option to all the SoCs where you remove
>   EFI_LOADER_BOUNCE_BUFFER.

Yes, and that has a side effect I should have probably added to the
commit message. Using the existing bounce buffer will flush caches
even if it's pointless.

>
> * SoCs that (now) set BOUNCE_BUFFER may double bounce if the buffers
>   aren't properly aligned.  I suppose that this won't happen since
>   efi_disk_add_dev() sets medio.io_align to the device block size
>   which is typically larger than the cache line size.

I think it won't happen indeed but for a different reason. The EFI
memory we allocate and pass to bounce_buffer_start_extalign() is
page-aligned.
The DM subsystem will call that function with either
blk_buffer_aligned() which always returns 1 or whatever the device has
defined. The strictest one I found was the virtio one which requires
page alignment.

Allocating memory from EFI is needed, simply because the current
bounce buffer API will use the malloc area, which might not be enough.
Do you think the extra cache flush is a no-go and we should leave the
code as-is?

>
> Still the commit message is somewhat misleading; this code doesn't
> really make us use the DM bounce buffering code.
>
> I also spotted a few bugs in the implementation.  See below.

[...]

> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -105,6 +105,8 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >       int blksz;
> >       int blocks;
> >       unsigned long n;
> > +     u64 bb = 0xffffffff;
> > +     void *bb_ptr = buffer;
> >
> >       diskobj = container_of(this, struct efi_disk_obj, ops);
> >       blksz = diskobj->media.block_size;
> > @@ -113,27 +115,35 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >       EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
> >                 blocks, lba, blksz, direction);
> >
> > +     if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && (uintptr_t)buffer >= SZ_4G + buffer_size - 1) {
>
> Shouldn't that check be
>
>         if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && (uintptr_t)buffer + buffer_size - 1 >= SZ_4G) {
>
> ?

Yes...
I originally had (uintptr_t)buffer > SZ_4G - buffer_size - 1 and avoid
potential overflows, but then I started to think what happens if
buffer_size is 4GB and completely messed this up ...
I think it's (uintptr_t)buffer + buffer_size + 1 >= SZ_4G though,
because SZ_4G is 0x100000000. Anyway yes, you are right, I'll fix it
in v2, but using subtractions.

>
> > +             if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > +                                    buffer_size >> EFI_PAGE_SHIFT, &bb) != EFI_SUCCESS)
> > +                     return EFI_OUT_OF_RESOURCES;
> > +
> > +             bb_ptr = (void *)(uintptr_t)bb;
> > +     }
> >       /* We only support full block access */
> > -     if (buffer_size & (blksz - 1))
> > +     if (buffer_size & (blksz - 1)) {
> > +             if (buffer != bb_ptr)
> > +                     efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> >               return EFI_BAD_BUFFER_SIZE;
> > +     }
>
> Any reason why you don't check the buffer_size check before allocating
> the bounce buffer?  That way you don't have to worry about freeing it
> here.

Nop, that code was already there and I  didn't move it. I'll move it around.

>
> You're missing a memcpy() here in the case direction == EFI_DISK_WRITE.

ah thanks

>
> >       if (CONFIG_IS_ENABLED(PARTITIONS) &&
> >           device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
> >               if (direction == EFI_DISK_READ)

[...]

> > +                     efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
> >               return EFI_DEVICE_ERROR;
> > +     }
> > +
> > +     if (buffer != bb_ptr) {
> > +             memcpy(buffer, bb_ptr, buffer_size);
>
> This memcpy() is only necessary if direction == EFI_DISK_READ.

Ok

[...]

Thanks
/Ilias
