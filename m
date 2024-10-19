Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A7DD3C90C
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 18:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D72891FE;
	Sat, 19 Oct 2024 20:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PKaIE52b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEA5891A4; Sat, 19 Oct 2024 20:07:19 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BA0890CC
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 20:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbcc2bd7fcso17990656d6.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729361236; x=1729966036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=veW57Ywk9qsnd3xNa38s/wEWWYjVNEz1jHipeiW7kzE=;
 b=PKaIE52bZ11vrGYd5W0YGuHIECJXgWxcPqHl8F1MRwqkrA/Ar6j7CU0rcp06/LPIxB
 WUT0wN5sDbv+8LANelPaYLw0/B6BeNCXJQovVc7eUrhhXOqFyiJJ10RumyLsv6hZ/zm3
 dqjkhokPUXlUap6gELKCyYLRAkW6T8X/Jw/cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729361236; x=1729966036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veW57Ywk9qsnd3xNa38s/wEWWYjVNEz1jHipeiW7kzE=;
 b=UBrswzsN5nNry1ZGDauwHlvx/yOBeYMszvl5VjejLlbVoLl2TpXCRUW8eags/rnBBI
 a0ABaduL8mw4gJ9yVR6MspfTaIMsZSBL+vXQwCmp+giQqZJu13PkZ40KOslmkx8RANPM
 VcvyEL5gwJrcSZJ2zyuf0mRzurMF/9mP89h5jPviMJ2h2/ijcZD4gv2oUCJVbx0R+jwE
 ahIZ0EqW0ltSwx2Xt26cxrCWbr7xjuZcW60IVoVrlQlqc7zovGXsqVHkQy60XirReWHd
 2HZJvmD5+qIgZSsh+kJ3L7ca6bJyJGbiLOziOQhgbe2hv9NZCt4tfctgl13XarrcZFKF
 DnYw==
X-Gm-Message-State: AOJu0Ywmxm/Ua/rnRam/CD+egXeUnrn78eWGGyemES8YxWl1nNSc3VxA
 xUq1XdoJ6jXnzzS8YbJ3FOWbgZj0mJQvAxFXqpKCbEB88yqEUuzgAM2VKD1kKQ7kCvXHeGvPBhJ
 H9CpwN/ltgO5qKVAsohn0GJRblydSB9qAv0D9
X-Google-Smtp-Source: AGHT+IEzUvz65TbGzJhmf6IN81aDS3unDCA/npjqMobL/XORW3hejPkehZdvHGKliPCo3u+FjmK1dkwX3N9NYf4BzuE=
X-Received: by 2002:a05:6214:2dc5:b0:6cb:f077:f2f4 with SMTP id
 6a1803df08f44-6cde14d6feemr83672206d6.17.1729361235928; Sat, 19 Oct 2024
 11:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-6-sjg@chromium.org>
 <CAC_iWj+HQg0itBTF8ZmsVr4qQkWjX+RdZ2snPKvOsVA5pMhXOQ@mail.gmail.com>
 <CAFLszTgiebQV4VVWsMiv7Niepf2ceDxpo1yqykpJ-6X9hxchpw@mail.gmail.com>
 <CAC_iWj+wg1p5kojdVb4YyM3h=FLi7B0n3J669m=iqdtRVpH4Qw@mail.gmail.com>
In-Reply-To: <CAC_iWj+wg1p5kojdVb4YyM3h=FLi7B0n3J669m=iqdtRVpH4Qw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 12:07:04 -0600
Message-ID: <CAFLszTg82+z77ds1x5qUunvvq3gAX0y8VwNfGkjFFJ4hDeiHeQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] efi: Keep early allocations to the U-Boot region
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 16 Oct 2024 at 08:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > +
> > > > +/**
> > > > + * efi_memory_coop() - Allow EFI to use all available memory
> > > > + *
> > > > + * Up until this function is called, only a small portion of memory is available
> > > > + * for use by the EFI memory-allocator. This function is called at the
> > > > + * 'point of cooperation', before jumping into an EFI app, which needs to be
> > > > + * able to make use of all the memory in the machine
> > >
> > > As above, this is called when the EFI subsystem comes up. Not when an
> > > application is called. For example doing a 'printenv -e' to print EFI
> > > variables would trigger this.
> >
> > Yes. At that point we know we are using an EFI feature. We can
> > certainly extend the intent of this patch to cover that, but I am
> > trying to take baby steps here.
> >
> > > The funtion call you are removing just adds all memory all memory as
> > > EFI_CONVENTIONAL_MEMORY, which basically means free memory. I can't
> > > understand what this patch is supposed to fix
> >
> > Basically it feeds a small amount of memory to EFI initially, within
> > the U-Boot region. That is enough to deal with the few allocations
> > that are done before efi_init_obj_list() is called.
> >
> > So if you don't use any EFI features, EFI's memory usage is limited to
> > the U-Boot region.
>
> Yes, but what does it fix?

Just that. U-Boot should not use memory below its own region, that's all.

>
>
> >
> > >
> > > > + *
> > > > + * Return: efi_status_t (EFI_SUCCESS on success)
> > > > + */
> > > > +int efi_memory_coop(void);
> > > > +
> > > >  /* Adds new or overrides configuration table entry to the system table */
> > > >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> > > >  /* Sets up a loaded image */
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > index 9cc33397371..2cd0b00e9eb 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
> > > >   */
> > > >  #define EFI_EARLY_REGION_SIZE  SZ_256K
> > > >
> > > > +/* Set when all memory has been added for use by EFI */
> > > > +static bool efi_full_memory;
> > > > +
> > > >  efi_uintn_t efi_memory_map_key;
> > > >
> > > >  struct efi_mem_list {
> > > > @@ -932,8 +935,25 @@ static void add_u_boot_and_runtime(void)
> > > >
> > > >  int efi_memory_init(void)
> > > >  {
> > > > -       efi_add_known_memory();
> > > > +       efi_status_t ret;
> > > > +
> > > > +       /* restrict EFI to its own region until efi_memory_coop() is called */
> > > > +       ret = efi_add_memory_map_pg((ulong)map_sysmem(gd->efi_region, 0),
> > > > +                                   EFI_EARLY_REGION_SIZE >> EFI_PAGE_SHIFT,
> > > > +                                   EFI_CONVENTIONAL_MEMORY, false);
> > > > +
> > > > +       return ret;
> > > > +}
> > > >
> > > > +int efi_memory_coop(void)
> > > > +{
> > > > +       if (efi_full_memory)
> > > > +               return 0;
> > > > +       log_debug("Enabling coop memory\n");
> > > > +
> > > > +       efi_full_memory = true;
> > > > +
> > > > +       efi_add_known_memory();
> > > >         add_u_boot_and_runtime();
> > > >
> > > >  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > > > @@ -943,7 +963,7 @@ int efi_memory_init(void)
> > > >         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> > > >                                (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> > > >                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
> > > > -               return -1;
> > > > +               return -ENOMEM;
> > > >
> > > >         efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> > > >  #endif
> > > > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > > > index a610e032d2f..40e23ca104c 100644
> > > > --- a/lib/efi_loader/efi_setup.c
> > > > +++ b/lib/efi_loader/efi_setup.c
> > > > @@ -228,6 +228,11 @@ efi_status_t efi_init_obj_list(void)
> > > >         if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
> > > >                 return efi_obj_list_initialized;
> > > >
> > > > +       /* Allow EFI to use all memory */
> > > > +       ret = efi_memory_coop();
> > > > +       if (ret != EFI_SUCCESS)
> > > > +               goto out;
> > > > +
>
> I am not sure that will work. I'll have to check if not adding the
> runtime regions from the linker scripts during bringup is safe.
> But, instead of adding all that, including a small gd region for
> efi_region and having to explicitly make that region bigger every time
> something new gets added on efi allocations, why don't we simply move
> efi_memory_init() out of init_sequence_r()?
> We can protect the runtime services etc via LMB now and initialize the
> memory map in efi_init_obj_list().
>
> I haven't gone through all the code, but it sounds doable

Yes that sounds like a good idea...but there is a catch. There are few
allocations that happen when U-Boot is running - e.g. partitions. I
think we need to work towards that bit by bit.

Regards,
Simon

>
> Thanks
> /Ilias
>
> > > >         /* Set up console modes */
> > > >         efi_setup_console_size();
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Thanks
> > > /Ilias
> >
> > Regards,
> > SImon
