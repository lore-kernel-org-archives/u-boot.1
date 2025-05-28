Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C705C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 00:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E65838DD;
	Wed, 28 May 2025 02:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v5NaW3rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90F7838DF; Wed, 28 May 2025 02:22:32 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2E88312E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-32918fe5334so40237271fa.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748391747; x=1748996547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zSujFgVYqnpSQpYN8B2+BL31BeOH1WKYT49gbpAxOAc=;
 b=v5NaW3rsmdKoPBM7F1miZozLjLIs4nEwkCP7d0Rd3j52cwH/+a/taqgM1jcS4U+DZL
 w3L1JmLEqeRjpOiVMkZnIzrp3pq7yZk2F9Ufi8GAo8SQWEY8xDs2U1kTDnZa4k+eVipi
 8RP121i7ne/6kmMCde2LZqNbnJrJzmdTQCQ26If1JxRHjM+c8BB9lVoFP5c9GHyh+vRN
 kAgHOYXEq+sbnwvHQ+tiFG8Ty/OKkS+rO/f+NBI9vvShkhGL56lnoMVl1goJVV08hLPt
 6bONNk6PHAesCwGc5Egy2wcj9eGIB7/wdAQNzBYXB4ORNGvJzQ3X7KvsWxxb61YhrzH0
 CbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748391747; x=1748996547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSujFgVYqnpSQpYN8B2+BL31BeOH1WKYT49gbpAxOAc=;
 b=NPHtSjhrHeistQkdfce7S7b+PuxA7w+aeoKRJEFLPU7vGSLdKrFv1yLm2R+qlUXJ0M
 uD2BfBIa41ck7Fb7Aiz3KXRuOSI05652zq+1aKyFEHgv6sQnfHO4JASg5naNLiYNjE1P
 K+upWapTXPgTz8admCav7Q1FY7fgFnLGDkX+NWGJdolnVd0DFomUWURiGJmiZINaa+p5
 HI1oA7TUIDBt7v+fe0DoI99flD2jDyCPz2rS/fSI1YzZJBlGf3S9zOfRQ1m4AkOqSkHW
 xr7eNVK9aZGqNS+c1e9Vbfe6Ph4LueCLdXE8aIpLjEIj74qNL4vIp49xIrc43J3haVva
 yjgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNIUu6bfAJfNjl6TPeBm0j61N6A/XBhyNc+1oowqJ+U5BHuc9A9jyD67Xo6lPJQPxKDAcK3MM=@lists.denx.de
X-Gm-Message-State: AOJu0YzHv/CWp4tygk7HgcR/0izzkQCVSFG6FMhLPF7t4JIlL17DS3aS
 TaA4LNYj02jSRpKnbJDXiUaFfuHKtFSZo2d7zT5PEjA3ILTq0SRyKoFqulZ7Ed8CFpM33PFhFkm
 UZacOba7YfmkRJmG0Vx6Tdf+tq6vLWkx7yPT7pUaQbA==
X-Gm-Gg: ASbGncstw4OtFdrITbhsTUv03AXJuHffF9dz1G8ODafKi+7c1nDMHGGGfX6WC+YruVw
 2y2jhAUYu6jAH0xdZpp0kGHdO8H5Tv9bFtuDBxEkeoKgGq3XS7Wdpl9nolKRIAbYYW7hwGk5WeQ
 4hkRPfKtSPkrOeuFBCyoIElw8ujdV/b54lgR2BVC7grOqVT5PzbyNJviINJxt7rH0bJKwllTZDr
 RwU
X-Google-Smtp-Source: AGHT+IGOlJOY+FqiGzzvOJkp41aBXsyirXC3qT6G+Zek6FmuSV0qcXaMgnGjupeClewMjuXW8elzCeuLHxBXz6n7fls=
X-Received: by 2002:a2e:bc81:0:b0:32a:648d:5c0f with SMTP id
 38308e7fff4ca-32a648d5dc4mr27943861fa.16.1748391746725; Tue, 27 May 2025
 17:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-2-paulliu@debian.org>
 <CAC_iWjKvrK2bxWTnWiuynQhFMCAaExDeJQbCHhg9bHLfK2jT6Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKvrK2bxWTnWiuynQhFMCAaExDeJQbCHhg9bHLfK2jT6Q@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Wed, 28 May 2025 01:22:15 +0100
X-Gm-Features: AX0GCFvKNSfJF0bBdZlWzvFdMSh9p06mVrTbzYMXz1T2LXnz2fXwlgMJRsNHxsU
Message-ID: <CALG-KHxp_DDz8dq11yQ8FwKN0pLUNT51VMuNCs=GAtra+cs_Gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Ilias,

On Mon, 26 May 2025 at 15:01, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Paul,
>
> [...]
>
>
> >         bool
> >
> > +config EFI_DEBUG_SUPPORT_TABLE
> > +       bool "EFI Debug Support Table"
> > +       help
> > +         Select this option if you want to setup the EFI Debug Support
> > +         Table which is used by the debug agent or an external debugger
> to
> > +         determine loaded image information in a quiescent manner.
> > +
> >  menu "UEFI services"
> >
> >  config EFI_GET_TIME
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index dbebb37dc04..5a4349f8679 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab
> = {
> >         .tables = NULL,
> >  };
> >
> > +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
> NULL;
> > +
> >  /**
> >   * efi_initialize_system_table() - Initialize system table
> >   *
> > @@ -4035,3 +4037,47 @@ efi_status_t efi_initialize_system_table(void)
> >
> >         return ret;
> >  }
> > +
> > +/**
> > + * efi_initialize_system_table() - Initialize system table pointer
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_initialize_system_table_pointer(void)
> > +{
> > +       efi_status_t ret;
> > +       const int size_4MB = 0x00400000;
> > +       int pages = efi_size_in_pages(sizeof(struct
> efi_system_table_pointer));
> > +       int alignment_mask = size_4MB - 1;
> > +       int real_pages = pages + efi_size_in_pages(size_4MB);
> > +       u64 addr;
> > +       u64 aligned_addr;
> > +       u32 crc32_value;
> > +
> > +       /* Allocate configuration table array */
> > +       ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > +                                EFI_RUNTIME_SERVICES_DATA,
> > +                                real_pages,
> > +                                &addr);
> > +
> > +       if (ret != EFI_SUCCESS) {
> > +               log_err("Installing EFI system table pointer failed\n");
> > +               return ret;
> > +       }
> > +
> > +       /* alignment to 4MB boundary */
> > +       aligned_addr = (addr + alignment_mask) & ~alignment_mask;
>
> efi_alloc_aligned_pages() does that for you.
> But I have similar questions to Heinrich here. Why do you need 4MB?


The alignment of this structure is 4MB. Is there a way not to allocate a
full page but still fulfill this?
The spec said. "A check-summed structure containing the physical address of
the EFI system table is created and located on a
4M aligned memory address. A hardware debugger can search memory for this
structure to determine the location of the EFI system table."

So that's why I need a page aligned with 4MB. This code is actually copied
from edk2. So I should replace it with efi_alloc_aligned_pages() right?


>

> > +
> > +       systab_pointer = (struct efi_system_table_pointer *)aligned_addr;
> > +       memset(systab_pointer, 0, sizeof(struct
> efi_system_table_pointer));
> > +
> > +       systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> > +       systab_pointer->efi_system_table_base =
> (efi_physical_addr_t)&systab;
> > +       systab_pointer->crc32 = 0;
>
> You are assigning this at the end regardless, so I guess you can skip it
> here.
>
>
Will remove.


> > +       crc32_value = crc32(0,
> > +                           (const unsigned char *)systab_pointer,
> > +                           sizeof(struct efi_system_table_pointer));
> > +       systab_pointer->crc32 = crc32_value;
> > +
> > +       return ret;
> > +}
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 48f91da5df7..a6b37d994f6 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
> >         if (ret != EFI_SUCCESS)
> >                 goto out;
> >
> > +       /* Initialize system table pointer */
> > +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> > +               ret = efi_initialize_system_table_pointer();
> > +               if (ret != EFI_SUCCESS) {
> > +                       goto out;
> > +               }
> > +       }
> > +
> >         if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> >                 ret = efi_ecpt_register();
> >                 if (ret != EFI_SUCCESS)
> > --
> > 2.39.5
> >
>
> Thanks
> /Ilias
>
