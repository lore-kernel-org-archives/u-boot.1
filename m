Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D8C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 18:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5E882977;
	Fri, 25 Apr 2025 20:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ta1Fb1hK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7241E829E2; Fri, 25 Apr 2025 20:55:23 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F69282958
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 20:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54993c68ba0so3050092e87.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745607320; x=1746212120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hZgDLzNKvf3qfxSB1zQ4koeU8gWGCmWt1L03wddWqKg=;
 b=Ta1Fb1hKzKRpLkc//KceSuM5CN0PxGQ58MZe9PdwY+VGd4jEWvctqX6adasEy2aOMB
 /dSMv9fiW7GjHroAqmGHFAaVQ64xL/3RYTeHgP1Av9vRLdstn2vCrUyy9WeuZU5iP0l6
 oVmS1GhQLDYlJyyNnL2QwAaWAII6g7UPrl5B45Ot8DuF9nf2O6k1CBjKoXq8unTTgYBu
 Tl5V9LUZxJjg7FxiRIdXkXXfxg77crO1lfUe5KMhgrzVPpYXWnc+P6ANNJpjLKWfQM07
 CQnIf44UyxEPjuSc1xwYpgt8zO15km8ksYaaiyKOavHFgTtndPSSdFiE5zGJsEWwsi5z
 UQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745607320; x=1746212120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZgDLzNKvf3qfxSB1zQ4koeU8gWGCmWt1L03wddWqKg=;
 b=LxxEKchM1QQdOV8nE6G19RG24dU2jiyzYJZsVCGbNNhHaYbHrT86IlxW7X2fgm4hqx
 kmYdBcOUp4JXJzLNg+WAXcVybo/0wvsXssN0CVVnv8uMO9nGQJrmUXwnxcNp9p9TnZ0a
 eUYTEeWDmWyd6GAUUjShWB37lTxP5J6CD63cTFZiMGLqC4Erfr7qsxwpphvqxuE8Q3lo
 i7lbGoXNj9HV+kLYyPwthqq3Fm2zlDprHFdZ82TCjoSmPFg4HCNsNeLHtdyZIFkV22Ps
 bVHKCQxV2aCC9KlNRZ+qgJIX4KnFu7VUA4yh0SxATJpv2xkgcbokwgvU/QRCg0+SJFgu
 i40A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Ccq3qlEusJZBGHPiZTcw6Y9beV17gIRSOCJ92tnlcZU3tq1b0cHn+lEjcom9cAOkIDkIZkc=@lists.denx.de
X-Gm-Message-State: AOJu0YyXFN3Jg0ac/qnyEfsf006AUn2N68ORxqNB3h7tsTp+lZCZGWuL
 r3EHuuY65Kkmzo+3utZih+vBNDQ77THdP+5PHrMkPZ/e0C9yA4lYgN8ONDO+Ak+h9QtZ2W5ojW/
 tt15Qiz3eo7n7/eVTGXHbOCQtpVC8xcTmRtwmzA==
X-Gm-Gg: ASbGncuHRn47jvmpcI8xNb5RqwtTU9zIdJ5EYS/ZV/ulTS9G1FlY6ucx1Guxel5O7Pv
 GcZREvMLYboEcYYXoKi1LdOR/3LeJwG5whFuElr8IJzjikB3bkO37eItPRiTDLkzdcGfksaToZj
 IgBj08x6vYseUsV2cZjANBRoWmrRL0AURXA3IhcaflkSlBJz+xYBgPmRw=
X-Google-Smtp-Source: AGHT+IHVby7tDTihTk/uXXGuvR6uePaAu0h0bFLtgntFgyyA2z80pK3/BRezWR6qhJGh3tf1DZsy9m9nf5LF9xndlcU=
X-Received: by 2002:a19:9119:0:b0:549:8cc9:67d1 with SMTP id
 2adb3069b0e04-54e8d18d730mr783907e87.38.1745607319546; Fri, 25 Apr 2025
 11:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-2-paulliu@debian.org>
 <a63e9349-6a1a-4c52-992b-6da3ed83ab6b@gmx.de>
In-Reply-To: <a63e9349-6a1a-4c52-992b-6da3ed83ab6b@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Fri, 25 Apr 2025 19:55:08 +0100
X-Gm-Features: ATxdqUGguHJObAue3nZP5CNC2RTlZ87mVkVSiERw6IxoxgM5yIzQf34Xh4Mjb_o
Message-ID: <CALG-KHxn=L3kZGjfejd719_JvTjL0vK1GuC1Kcyf=hLwY7MAdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

Thanks for the review.

On Thu, 24 Apr 2025 at 22:46, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > Add EFI_SYSTEM_TABLE_POINTER structure for debugger to locate
> > the address of EFI_SYSTEM_TABLE.
> >
> > This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
>
> Hello Ying-Chun,
>
> Thank you for your contribution.
>
> Unfortunately it is not clear what your use case is. The reason for
> implementing a feature should be mentioned in the commit message.
> Cover-letters for a patch series are the right place to describe
> overarching topics.
>


I'll enhance the commit message in next version.


>
> The relevant information needed to debug U-Boot is the u-boot.map file
> and the relocation address. On arm64 the relocation address can be found
> via the global data structure pointed to by register x18.
>
>
Yes. Previously we use
p/x (*(struct global_data*)\$x18)->relocaddr
add-symbol-file <Symbols.deug> $1
For loading the debug symbols for U-boot.


> Once you have the relocation offset, you can determine the system table
> address via the u-boot.map file.
>
> If you need information about loaded EFI images, you could enable debug
> messages using U-Boot's log command.
>
>
The idea here is to provide another way to get the information about the
loaded EFI images.
So that we can have an easier way to start debugging the EFI applications.

I think for both EDK2 and U-boot, we can get the information through debug
messages.
EDK2 also outputs debug messages through IO port 0x402 on X86. So the
developers can get information there.

But let's assume that our environment is just an ARM board. With hardware
JTAG connects to it.
So through the JTAG, gdb can read the memory. And can stop program running
at a place.
And through this implementation, we can use some python extensions to
directly get the information of the EFI applications for debug.
First, the extension will look for this SystemTablePointer structure
through the memory address.
And then we can get information about the EFI applications.
There is already a python gdb extension in EDK2.
1.
https://github.com/tianocore/edk2/blob/master/BaseTools/Scripts/efi_debugging.py
2.
https://github.com/tianocore/edk2/blob/master/BaseTools/Scripts/efi_gdb.py
And we implemented the missing parts through this PR.
https://github.com/tianocore/edk2/pull/10980

I've also implemented a gdb python extension by reusing the
efi_debugging.py in EDK2.
https://paste.debian.net/hidden/c3122c5b/

By this way it makes things a bit easier. So that we don't need to load
U-boot debug symbols. Don't need debug logs.
Just the EFI application and its debug symbols are needed. And then we can
start debugging on the real hardware.





> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > V2: add Kconfig options to turn on/off this feature.
> > ---
> >   include/efi_api.h             |  6 +++++
> >   include/efi_loader.h          |  2 ++
> >   lib/efi_loader/Kconfig        |  7 ++++++
> >   lib/efi_loader/efi_boottime.c | 44 +++++++++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_setup.c    |  9 +++++++
> >   5 files changed, 68 insertions(+)
> >
> > diff --git a/include/efi_api.h b/include/efi_api.h
> > index eb61eafa028..5017d9037cd 100644
> > --- a/include/efi_api.h
> > +++ b/include/efi_api.h
> > @@ -259,6 +259,12 @@ struct efi_capsule_result_variable_header {
> >       efi_status_t capsule_status;
> >   } __packed;
> >
> > +struct efi_system_table_pointer {
> > +     u64 signature;
> > +     efi_physical_addr_t efi_system_table_base;
> > +     u32 crc32;
> > +};
> > +
> >   struct efi_memory_range {
> >       efi_physical_addr_t     address;
> >       u64                     length;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 1d75d97ebbc..370bc042f70 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -615,6 +615,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
> >   efi_status_t efi_root_node_register(void);
> >   /* Called by bootefi to initialize runtime */
> >   efi_status_t efi_initialize_system_table(void);
> > +/* Called by bootefi to initialize debug */
> > +efi_status_t efi_initialize_system_table_pointer(void);
> >   /* efi_runtime_detach() - detach unimplemented runtime functions */
> >   void efi_runtime_detach(void);
> >   /* efi_convert_pointer() - convert pointer to virtual address */
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index d4f6b56afaa..94a75981389 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -70,6 +70,13 @@ config EFI_SECURE_BOOT
> >   config EFI_SIGNATURE_SUPPORT
> >       bool
> >
> > +config EFI_DEBUG_SUPPORT_TABLE
> > +     bool "EFI Debug Support Table"
> > +     help
> > +       Select this option if you want to setup the EFI Debug Support
> > +       Table which is used by the debug agent or an external debugger to
> > +       determine loaded image information in a quiescent manner.
> > +
> >   menu "UEFI services"
> >
> >   config EFI_GET_TIME
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index 5164cb15986..366bc0d2b1d 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab
> = {
> >       .tables = NULL,
> >   };
> >
> > +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
> NULL;
> > +
> >   /**
> >    * efi_initialize_system_table() - Initialize system table
> >    *
> > @@ -4035,3 +4037,45 @@ efi_status_t efi_initialize_system_table(void)
> >
> >       return ret;
> >   }
> > +
> > +/**
> > + * efi_initialize_system_table() - Initialize system table
> > + *
> > + * Return:   status code
> > + */
> > +efi_status_t efi_initialize_system_table_pointer(void)
>
> This function name seems to be a misnomer as you are setting up much
> more with the next patches.
>

I will fix this in the next version.
Plan to separate it into two functions. One for the system_table_pointer.
Another for the configuration table.


>
> > +{
> > +     efi_status_t ret;
> > +     const int size_4MB = 0x00400000;
> > +     int pages = efi_size_in_pages(sizeof(struct
> efi_system_table_pointer));
> > +     int alignment_mask = size_4MB - 1;
> > +     int real_pages = pages + efi_size_in_pages(size_4MB);
> > +     u64 addr;
> > +     u64 aligned_addr;
> > +     u32 crc32_value;
> > +
> > +     /* Allocate configuration table array */
> > +     ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > +                              EFI_RUNTIME_SERVICES_DATA,
> > +                              real_pages,
> > +                              &addr);
> > +
> > +     /* alignment to 4MB boundary */
> > +     aligned_addr = (addr + alignment_mask) & ~alignment_mask;
> > +
> > +     systab_pointer = (struct efi_system_table_pointer *)aligned_addr;
> > +     memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> > +
> > +     /*
> > +      * These entries will be set to NULL in ExitBootServices(). To
> avoid
> > +      * relocation in SetVirtualAddressMap(), set them dynamically.
> > +      */
>
> This comment does not match the submitted code.
>
>
Will fix this in the next version.


> > +     systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> > +     systab_pointer->efi_system_table_base =
> (efi_physical_addr_t)&systab;
> > +     systab_pointer->crc32 = 0;
> > +     crc32_value = crc32(0,
> > +                         (const unsigned char *)systab_pointer,
> > +                         sizeof(struct efi_system_table_pointer));
> > +     systab_pointer->crc32 = crc32_value;
> > +     return ret;
> > +}
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index aa59bc7779d..6be23ca43bf 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -259,6 +259,15 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > +     /* Initialize system table */
> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> > +             ret = efi_initialize_system_table_pointer();
> > +             if (ret != EFI_SUCCESS) {
> > +                     printf("EFI init system table pointer fail\n");
>
> Maybe: "Installing EFI system table pointer failed\n".
>
> Please, use log_error() and move the output to the appropriate place in
> the efi_initialize_system_table_pointer() function.
>
>
Will fix it in the next version.


> Best regards
>
> Heinrich
>
> > +                     goto out;
> > +             }
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> >               ret = efi_ecpt_register();
> >               if (ret != EFI_SUCCESS)
>
>
Thanks a lot.

Yours,
Paul
