Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6F0D1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1DC88E14;
	Tue, 22 Oct 2024 08:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f5KrkJCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D2588E31; Tue, 22 Oct 2024 08:01:32 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B5088D9C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e72db7bb1so3795931b3a.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729576887; x=1730181687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQtSTBj+FFOYPbrahR/x6eagL3SGevdHo7aloWMeb7Y=;
 b=f5KrkJCYSOKGBYNy/XAfBVdz1xTxtEf94KXiWPGAjiAIkgPk+rxtqwQrN6p9joBxHR
 dp+O3RrRxdxDVJwhTkx5wNQUoOoqJPyQYZpcCfSM0qf2pfxrt3DTeRkbVnsLmutF/5Oi
 jmAluK9IDm6x8M0ufcK8pwd9JWpxXpn93PIaBSPMzxUiaLCIIqrz4rplqviE5m3yFxZ+
 Ia995vcMjkZiOo26GolztUBKy+cxaBzBCFvy3OBUSKTVihWMv4DLZGJq5aV16zUgNwKc
 x8ku/XgjMYnAu0XMzapH4Jx4ZSB4E5en1mM6/zMQlfomG8bQw7yIppBUi3pGQz46sphI
 bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729576887; x=1730181687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQtSTBj+FFOYPbrahR/x6eagL3SGevdHo7aloWMeb7Y=;
 b=nYKdDCm4JU998j3Ac6Z7SdLtJ4kG7YZWp9fg9WeW8fpp/+Hpav0g4mtyr/oe9vnbHe
 VWVCQIJWkRAYz6QYSREz8836CrNMUuFVcW/fH940HObyY1Oylfp5vx3piouMk0O+pYEB
 DDMT1prBv31cSPbxmfCX/U8KATaiRaJLCGfsJss8g48LTT6TtGNbeYn8j0LJkc+TQcPn
 pbaqG7H2NIRDgTnWlrFdO+2+64XV6gvbFzjHnBpiiugc6yr197A8DZ8OKFVKgU0MTr10
 Z5FejzWoG73X9V73X8zvTpSvQvKHirQxujh54TQgQA+UPm/8B9bsCNmlrgKkgf1Nhvw1
 ddNQ==
X-Gm-Message-State: AOJu0YzK7NfEhkYCFVyebzYxFqsYLduowV908/Sqs6oej0J4bD3zdr5x
 YAbfLQlQHXW0df+yLQWDLFAbFu0Qi3CQnXWErS2xZQu1+WWQpW7oZkx5xyWuMI3/mJDVYVmR2Z8
 jBhazNo5xTr0xav4JUqq4V6vM77/Q++1Qu6sqcg==
X-Google-Smtp-Source: AGHT+IFXlK4qvBKkVf9LBwDfDpFuxWZzMKY0ZTBiMDgle9/7mmNfw1W02cBsMlU2GFGuzrzZ/LDxLDt/id+Fp8X/A1I=
X-Received: by 2002:a05:6a20:1d98:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1d96de875a0mr1863197637.10.1729576887238; Mon, 21 Oct 2024
 23:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-6-sjg@chromium.org>
 <CAC_iWj+HQg0itBTF8ZmsVr4qQkWjX+RdZ2snPKvOsVA5pMhXOQ@mail.gmail.com>
 <CAFLszTgiebQV4VVWsMiv7Niepf2ceDxpo1yqykpJ-6X9hxchpw@mail.gmail.com>
 <CAC_iWj+wg1p5kojdVb4YyM3h=FLi7B0n3J669m=iqdtRVpH4Qw@mail.gmail.com>
 <CAFLszTg82+z77ds1x5qUunvvq3gAX0y8VwNfGkjFFJ4hDeiHeQ@mail.gmail.com>
In-Reply-To: <CAFLszTg82+z77ds1x5qUunvvq3gAX0y8VwNfGkjFFJ4hDeiHeQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 22 Oct 2024 09:00:50 +0300
Message-ID: <CAC_iWjJpz+4+eLYDMZsEJnFfD+ZJWk_FakvbF4cJNoASK19wUA@mail.gmail.com>
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

Hi Simon

On Sat, 19 Oct 2024 at 21:07, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 16 Oct 2024 at 08:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > > > +
> > > > > +/**
> > > > > + * efi_memory_coop() - Allow EFI to use all available memory
> > > > > + *
> > > > > + * Up until this function is called, only a small portion of memory is available
> > > > > + * for use by the EFI memory-allocator. This function is called at the
> > > > > + * 'point of cooperation', before jumping into an EFI app, which needs to be
> > > > > + * able to make use of all the memory in the machine
> > > >
> > > > As above, this is called when the EFI subsystem comes up. Not when an
> > > > application is called. For example doing a 'printenv -e' to print EFI
> > > > variables would trigger this.
> > >
> > > Yes. At that point we know we are using an EFI feature. We can
> > > certainly extend the intent of this patch to cover that, but I am
> > > trying to take baby steps here.
> > >
> > > > The funtion call you are removing just adds all memory all memory as
> > > > EFI_CONVENTIONAL_MEMORY, which basically means free memory. I can't
> > > > understand what this patch is supposed to fix
> > >
> > > Basically it feeds a small amount of memory to EFI initially, within
> > > the U-Boot region. That is enough to deal with the few allocations
> > > that are done before efi_init_obj_list() is called.
> > >
> > > So if you don't use any EFI features, EFI's memory usage is limited to
> > > the U-Boot region.
> >
> > Yes, but what does it fix?
>
> Just that. U-Boot should not use memory below its own region, that's all.

That's not a problem though. Before the subsystem bringup the only
thing that gets initialized is the memory map

>
> >
> >
> > >
> > > >
> > > > > + *
> > > > > + * Return: efi_status_t (EFI_SUCCESS on success)
> > > > > + */
> > > > > +int efi_memory_coop(void);
> > > > > +
> > > > >  /* Adds new or overrides configuration table entry to the system table */
> > > > >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> > > > >  /* Sets up a loaded image */
> > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > index 9cc33397371..2cd0b00e9eb 100644
> > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > @@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
> > > > >   */
> > > > >  #define EFI_EARLY_REGION_SIZE  SZ_256K
> > > > >
> > > > > +/* Set when all memory has been added for use by EFI */
> > > > > +static bool efi_full_memory;
> > > > > +
> > > > >  efi_uintn_t efi_memory_map_key;
> > > > >
> > > > >  struct efi_mem_list {
> > > > > @@ -932,8 +935,25 @@ static void add_u_boot_and_runtime(void)
> > > > >
> > > > >  int efi_memory_init(void)
> > > > >  {
> > > > > -       efi_add_known_memory();
> > > > > +       efi_status_t ret;
> > > > > +
> > > > > +       /* restrict EFI to its own region until efi_memory_coop() is called */
> > > > > +       ret = efi_add_memory_map_pg((ulong)map_sysmem(gd->efi_region, 0),
> > > > > +                                   EFI_EARLY_REGION_SIZE >> EFI_PAGE_SHIFT,
> > > > > +                                   EFI_CONVENTIONAL_MEMORY, false);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > >
> > > > > +int efi_memory_coop(void)
> > > > > +{
> > > > > +       if (efi_full_memory)
> > > > > +               return 0;
> > > > > +       log_debug("Enabling coop memory\n");
> > > > > +
> > > > > +       efi_full_memory = true;
> > > > > +
> > > > > +       efi_add_known_memory();
> > > > >         add_u_boot_and_runtime();
> > > > >
> > > > >  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > > > > @@ -943,7 +963,7 @@ int efi_memory_init(void)
> > > > >         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > > > >                                (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> > > > >                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
> > > > > -               return -1;
> > > > > +               return -ENOMEM;
> > > > >
> > > > >         efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> > > > >  #endif
> > > > > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > > > > index a610e032d2f..40e23ca104c 100644
> > > > > --- a/lib/efi_loader/efi_setup.c
> > > > > +++ b/lib/efi_loader/efi_setup.c
> > > > > @@ -228,6 +228,11 @@ efi_status_t efi_init_obj_list(void)
> > > > >         if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
> > > > >                 return efi_obj_list_initialized;
> > > > >
> > > > > +       /* Allow EFI to use all memory */
> > > > > +       ret = efi_memory_coop();
> > > > > +       if (ret != EFI_SUCCESS)
> > > > > +               goto out;
> > > > > +
> >
> > I am not sure that will work. I'll have to check if not adding the
> > runtime regions from the linker scripts during bringup is safe.
> > But, instead of adding all that, including a small gd region for
> > efi_region and having to explicitly make that region bigger every time
> > something new gets added on efi allocations, why don't we simply move
> > efi_memory_init() out of init_sequence_r()?
> > We can protect the runtime services etc via LMB now and initialize the
> > memory map in efi_init_obj_list().
> >
> > I haven't gone through all the code, but it sounds doable
>
> Yes that sounds like a good idea...but there is a catch. There are few
> allocations that happen when U-Boot is running - e.g. partitions. I
> think we need to work towards that bit by bit.

There's also the early capsule updates that might need this -- hence
the memory init really early. I'll have a look at this instead of
splitting the memory inits

Thanks
/Ilias

>
> Regards,
> Simon
>
> >
> > Thanks
> > /Ilias
> >
> > > > >         /* Set up console modes */
> > > > >         efi_setup_console_size();
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > Thanks
> > > > /Ilias
> > >
> > > Regards,
> > > SImon
