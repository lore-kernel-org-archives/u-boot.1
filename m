Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF9D1AD5E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 14:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C467A88BD2;
	Wed, 16 Oct 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R+E3tetO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B7788BBE; Wed, 16 Oct 2024 16:03:00 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9198865D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 16:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so3087756a91.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729087375; x=1729692175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XDgSNlLrhfUgEFLfjRwZphyJIqcDZ7eVtDgHbwObfCA=;
 b=R+E3tetO5ssAdsMRYuWfZ7igwKN6DMG+7znDDTGYQIpnB4f9A1R+4MiVNdcSHWZhhI
 CYKE95ooyEDZkYNdWZLY/lMVay3AQHW5X05cNoorcXDgY+ODMwGPKXgyilQOFcSmWloE
 g1m5gkPGDT/SLJZEcwAhml+4UUxwQQ9z8Qd8XU6NMtv4tvjydv5knawXV31fASRuzeHm
 DDZM0TDVr/Qzlbyk1g80+EaSlNSVB+pVwR39GW4WEXhEQeAEJuEq0P++b3hdjM6WSt9Q
 CUGdv+eLEblN7UFKM9m2IkbYgpW5Faxri9lL5JyWF/s+ZjZg5TPe3Ngp2Gjz+6KywKe2
 zZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729087375; x=1729692175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDgSNlLrhfUgEFLfjRwZphyJIqcDZ7eVtDgHbwObfCA=;
 b=CuUKfaGJJq7N38vaY8fpYZQmSHBa/f4cBbWhZpE6c0iMwA19qyG48EDjkdhQIBaqX6
 cpvNRGpQO2GV5bvbMXQ7MyKDrouPiUMfJiGM89SAr+HiqepnfIayPfT6i6xNA502PMbb
 XtxD/4fbB2xJ+y2GqkbmaXaCRZe3vVDaQ7axpxYcKCPkPDRDZT2bVptfiZ/ZZNixwm3d
 9WRTA0sD5hmi9WNpMNcjyZ3sr1AYxwxWYPrZJRt8G1VMFwAQh2va9Odyt8PSFibvSeTO
 5eC79pqxUSrxaFSdGHlAcGXP7tyEDVpjVvIRIe5GP9j+BFl66/I9zJoJ7IeCLdbQ/Fgx
 dzLg==
X-Gm-Message-State: AOJu0YyG/iwihUGVTbI18VvrNQoGxT5f3HKvRE+enCtW4tvh0FrkFtLe
 RHTh5v4qZlB+ShBLBS2wfdWPKzetAoya9xyQEbXZyUs7b/ckWqL3NbbB0zg+UGDI38Lk+/Nwjux
 UUuFh27oJajROHL38XwXYcp3efFIfoXJQJoFuSA==
X-Google-Smtp-Source: AGHT+IESaUky7XP6kq0yrkWw7v1tzcQh/P87b4BhEokXaBlcuGyO926hulSWLNo+St/KxnEAGx1dm1WwEiBsI6fb5EQ=
X-Received: by 2002:a17:90a:b301:b0:2e2:d434:8547 with SMTP id
 98e67ed59e1d1-2e3ab7c4de6mr5598593a91.7.1729087375525; Wed, 16 Oct 2024
 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-6-sjg@chromium.org>
 <CAC_iWj+HQg0itBTF8ZmsVr4qQkWjX+RdZ2snPKvOsVA5pMhXOQ@mail.gmail.com>
 <CAFLszTgiebQV4VVWsMiv7Niepf2ceDxpo1yqykpJ-6X9hxchpw@mail.gmail.com>
In-Reply-To: <CAFLszTgiebQV4VVWsMiv7Niepf2ceDxpo1yqykpJ-6X9hxchpw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 17:02:19 +0300
Message-ID: <CAC_iWj+wg1p5kojdVb4YyM3h=FLi7B0n3J669m=iqdtRVpH4Qw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] efi: Keep early allocations to the U-Boot region
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

[...]

> > > +
> > > +/**
> > > + * efi_memory_coop() - Allow EFI to use all available memory
> > > + *
> > > + * Up until this function is called, only a small portion of memory is available
> > > + * for use by the EFI memory-allocator. This function is called at the
> > > + * 'point of cooperation', before jumping into an EFI app, which needs to be
> > > + * able to make use of all the memory in the machine
> >
> > As above, this is called when the EFI subsystem comes up. Not when an
> > application is called. For example doing a 'printenv -e' to print EFI
> > variables would trigger this.
>
> Yes. At that point we know we are using an EFI feature. We can
> certainly extend the intent of this patch to cover that, but I am
> trying to take baby steps here.
>
> > The funtion call you are removing just adds all memory all memory as
> > EFI_CONVENTIONAL_MEMORY, which basically means free memory. I can't
> > understand what this patch is supposed to fix
>
> Basically it feeds a small amount of memory to EFI initially, within
> the U-Boot region. That is enough to deal with the few allocations
> that are done before efi_init_obj_list() is called.
>
> So if you don't use any EFI features, EFI's memory usage is limited to
> the U-Boot region.

Yes, but what does it fix?


>
> >
> > > + *
> > > + * Return: efi_status_t (EFI_SUCCESS on success)
> > > + */
> > > +int efi_memory_coop(void);
> > > +
> > >  /* Adds new or overrides configuration table entry to the system table */
> > >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> > >  /* Sets up a loaded image */
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 9cc33397371..2cd0b00e9eb 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
> > >   */
> > >  #define EFI_EARLY_REGION_SIZE  SZ_256K
> > >
> > > +/* Set when all memory has been added for use by EFI */
> > > +static bool efi_full_memory;
> > > +
> > >  efi_uintn_t efi_memory_map_key;
> > >
> > >  struct efi_mem_list {
> > > @@ -932,8 +935,25 @@ static void add_u_boot_and_runtime(void)
> > >
> > >  int efi_memory_init(void)
> > >  {
> > > -       efi_add_known_memory();
> > > +       efi_status_t ret;
> > > +
> > > +       /* restrict EFI to its own region until efi_memory_coop() is called */
> > > +       ret = efi_add_memory_map_pg((ulong)map_sysmem(gd->efi_region, 0),
> > > +                                   EFI_EARLY_REGION_SIZE >> EFI_PAGE_SHIFT,
> > > +                                   EFI_CONVENTIONAL_MEMORY, false);
> > > +
> > > +       return ret;
> > > +}
> > >
> > > +int efi_memory_coop(void)
> > > +{
> > > +       if (efi_full_memory)
> > > +               return 0;
> > > +       log_debug("Enabling coop memory\n");
> > > +
> > > +       efi_full_memory = true;
> > > +
> > > +       efi_add_known_memory();
> > >         add_u_boot_and_runtime();
> > >
> > >  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > > @@ -943,7 +963,7 @@ int efi_memory_init(void)
> > >         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > >                                (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> > >                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
> > > -               return -1;
> > > +               return -ENOMEM;
> > >
> > >         efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> > >  #endif
> > > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > > index a610e032d2f..40e23ca104c 100644
> > > --- a/lib/efi_loader/efi_setup.c
> > > +++ b/lib/efi_loader/efi_setup.c
> > > @@ -228,6 +228,11 @@ efi_status_t efi_init_obj_list(void)
> > >         if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
> > >                 return efi_obj_list_initialized;
> > >
> > > +       /* Allow EFI to use all memory */
> > > +       ret = efi_memory_coop();
> > > +       if (ret != EFI_SUCCESS)
> > > +               goto out;
> > > +

I am not sure that will work. I'll have to check if not adding the
runtime regions from the linker scripts during bringup is safe.
But, instead of adding all that, including a small gd region for
efi_region and having to explicitly make that region bigger every time
something new gets added on efi allocations, why don't we simply move
efi_memory_init() out of init_sequence_r()?
We can protect the runtime services etc via LMB now and initialize the
memory map in efi_init_obj_list().

I haven't gone through all the code, but it sounds doable

Thanks
/Ilias

> > >         /* Set up console modes */
> > >         efi_setup_console_size();
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Thanks
> > /Ilias
>
> Regards,
> SImon
