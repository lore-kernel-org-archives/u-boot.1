Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ABDC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D299801BE;
	Fri,  4 Jul 2025 14:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dvAwBuTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52358803DF; Fri,  4 Jul 2025 14:00:08 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6056800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-32b8134ef6aso8424411fa.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751630405; x=1752235205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=50wVE2Lw9xhhghBZLJLFsnNHP6z78r4XEcSFjHJX8R8=;
 b=dvAwBuTLoDKoxOcdIx8GvThkAtrjFK4VMruY5NqwDGImQfqkEqk/4nFe9QnaHZT4IO
 rzL7cdyiHVyINlYrmJR5WQrg1JCMDuQd6sIvAHpWuMAoVj5PJ3muJu/lmpOeTs9NgaMZ
 CwjGS8w8qJgUmS6yji3WydasxwpCzkwooNMEe01JAh8Ijhge5StyQO4EgbTj4bseiyJT
 Dg6axKLwUeSrFGY0Sy2Sfbm1jkKKS6Muvy5U3Nx75Burih283VuX8s72mt3HO+kQBVLa
 u6ulc6O+7TuKg5ACk7uI37nHy/Um2cgKd1Po3b3uO7VIAspRHAbf1QetUo7hgm2V1ZVY
 L9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751630405; x=1752235205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50wVE2Lw9xhhghBZLJLFsnNHP6z78r4XEcSFjHJX8R8=;
 b=EIBBZGTjWIlWPswEwNuEc7mPy+7b4Kjupd47G8dpoeW5YtERQtYZnHz4TGksAD/7Sk
 jWvLXjK56zrU4TqlC0/j8pFxj/v8PBD5IcmeEPA2RFzASYHzgmoenokVr0P7ALa+F4Iy
 EnGHBoUD6dZg0y9ysrvCmRYLsSZGi6O5eKm5XzaUARPG07Qpkhcj8KgHKw/CJs0ToEiC
 m3xgeLDK9OVAKQ7Wo6s0fnmR3sVFkJ7lyXcdUTjEnSOv92PvHNnH4IFP+vsIuQ3NUYYR
 kZl3llKiNpC2LDQ1M40AQN7SFBCTeITVLjVTFlQz8MlrH4e0nHy5j56dKxp8kE645DI1
 OeFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfS1nfxjCaWaJGVZq8teVbxK/q4gfnAcm05O4u8ZKLHFfrioOU6kkdE7uJG+Ao80ORPyXa/YU=@lists.denx.de
X-Gm-Message-State: AOJu0YzLMB44n5ej12ZN/JBBi7Z9UnDIj2sWvMAvf9rIPEtCo4rhw7sR
 hdqiYIG7sI7OAleN1uWcdAu8cepCSgFOe20s4p9p8YlTGs6SxNwWBUqQTl3h7bRDPtf/fMcUZTj
 zhu1SEPCLS1bhYuDhVTxl1zs0XWyvBk0OGxm51ib5cw==
X-Gm-Gg: ASbGncvCNoNvAO9JvFjfaoHFxWYmeo+FarBKFI7eLwfMyQ1wm01rmCF/aw3VvwRc0mc
 lQmfmVeB5IiByIijYwhv5MWdsh+s+lCo9h/nZnntwztB4kH6G6YU1QAEU2Fbcw0Mc3WzpI4r8dY
 hhqFr8RIxaTJZdjnQdRRU5ZSuM9WSkqBG9Y/LAiR7FoWd+Za1J6GqgKsvEivElmkwjw4CcYjh4w
 FWS2wnfBzbicd8=
X-Google-Smtp-Source: AGHT+IGrtvnYWXpSq48gxUqyoqjkc+Ew3EuNjv7vZUo1vplj2r8BtXZy73cao9Z99Bo7QOl46Z/3vnp1Pr92w6ITDDk=
X-Received: by 2002:a05:651c:20d3:b0:32a:85ad:2162 with SMTP id
 38308e7fff4ca-32e5f56baddmr4755311fa.7.1751630404967; Fri, 04 Jul 2025
 05:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-2-paulliu@debian.org>
 <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
In-Reply-To: <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Fri, 4 Jul 2025 12:59:53 +0100
X-Gm-Features: Ac12FXx8mg44t7m0eukf1nEHqg2iKEA3e2rReBsVSfEEOyyEEoIZb4GhGWieyVk
Message-ID: <CALG-KHyh2zaOWtyrQiCxp7OxnJHmUnBkyKrV761y-88=RNu8Sg@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

Hi Heinrich, Ilias,

Sorry for the late reply. I'm a bit worried about this change. This
structure (efi_system_table_pointer), is not packed.
So its actual size is a bit larger. The crc32 field is not at the end of
the structure. Actually there are 4 bytes padding after it. But the CRC32
function is calculating the crc sum on the whole structure. So it might
produce random value if we don't zero those padding bytes.

Yours,
Paul


On Thu, 3 Jul 2025 at 08:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> On 03.07.25 08:28, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> > the address of EFI_SYSTEM_TABLE.
> >
> > This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> > The implementation ensures support for hardware-assisted debugging and
> > provides a standardized mechanism for debuggers to discover the EFI
> > system table.
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V2: add Kconfig options to turn on/off this feature.
> > V3: make efi_initialize_system_table_pointer() do the job as described.
> > V4: use efi_alloc_aligned_pages() for system_table_pointer.
> > V5: move the code into a separate module.
> > V6: Use macros to replace size_4MB
> > V7: Fix the code based on the review. Update license field.
> > V8: Fix pointer casting that causes qemu_arm_defconfig failed. Modify
> KConfig
> >      so that more defconfigs enabled by default.
> > ---
> >   include/efi_api.h                  | 16 ++++++++++++
> >   include/efi_loader.h               |  2 ++
> >   lib/efi_loader/Kconfig             |  9 +++++++
> >   lib/efi_loader/Makefile            |  1 +
> >   lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_setup.c         |  7 ++++++
> >   6 files changed, 75 insertions(+)
> >   create mode 100644 lib/efi_loader/efi_debug_support.c
> >
> > diff --git a/include/efi_api.h b/include/efi_api.h
> > index eb61eafa028..6c4c1a0cc7b 100644
> > --- a/include/efi_api.h
> > +++ b/include/efi_api.h
> > @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
> >       efi_status_t capsule_status;
> >   } __packed;
> >
> > +/**
> > + * struct efi_system_table_pointer - struct to store the pointer of
> system
> > + * table.
> > + * @signature: The signature of this struct.
> > + * @efi_system_table_base: The physical address of System Table.
> > + * @crc32: CRC32 checksum
> > + *
> > + * This struct is design for hardware debugger to search through memory
> to
> > + * get the address of EFI System Table.
> > + */
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
> > index 8f9f2bcf1cb..8f065244d8e 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
> >   efi_status_t efi_root_node_register(void);
> >   /* Called by bootefi to initialize runtime */
> >   efi_status_t efi_initialize_system_table(void);
> > +/* Called by bootefi to initialize debug */
> > +efi_status_t efi_initialize_system_table_pointer(void);
> >   /* efi_runtime_detach() - detach unimplemented runtime functions */
> >   void efi_runtime_detach(void);
> >   /* efi_convert_pointer() - convert pointer to virtual address */
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 7f02a83e2a2..621db8b5c79 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -71,6 +71,15 @@ config EFI_SECURE_BOOT
> >   config EFI_SIGNATURE_SUPPORT
> >       bool
> >
> > +config EFI_DEBUG_SUPPORT
> > +     bool "EFI Debug Support"
> > +     default y if !HAS_BOARD_SIZE_LIMIT
> > +     help
> > +       Select this option if you want to setup the EFI Debug Support
> > +       Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> > +       agent or an external debugger to determine loaded image
> information
> > +       in a quiescent manner.
> > +
> >   menu "UEFI services"
> >
> >   config EFI_GET_TIME
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index cf050e5385d..51ccf1cd87e 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
> >   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
> >   obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) += efi_signature.o
> >   obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
> > +obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
> >
> >   EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> >   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> > diff --git a/lib/efi_loader/efi_debug_support.c
> b/lib/efi_loader/efi_debug_support.c
> > new file mode 100644
> > index 00000000000..7dc5fa93af9
> > --- /dev/null
> > +++ b/lib/efi_loader/efi_debug_support.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * EFI debug support
> > + *
> > + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> > + */
> > +
> > +#include <efi_loader.h>
> > +#include <linux/sizes.h>
> > +#include <u-boot/crc.h>
> > +
> > +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
> NULL;
> > +
> > +/**
> > + * efi_initialize_system_table_pointer() - Initialize system table
> pointer
> > + *
> > + * Return:   status code
> > + */
> > +efi_status_t efi_initialize_system_table_pointer(void)
> > +{
> > +     /* Allocate efi_system_table_pointer structure with 4MB alignment.
> */
> > +     systab_pointer = efi_alloc_aligned_pages(sizeof(struct
> efi_system_table_pointer),
> > +                                              EFI_RUNTIME_SERVICES_DATA,
> > +                                              SZ_4M);
> > +
> > +     if (!systab_pointer) {
> > +             log_err("Installing EFI system table pointer failed\n");
> > +             return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +     memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
>
> systab_pointer->crc32 = 0;
>
> would have been an alternative. Maybe Ilias wants to change that when
> merging.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > +
> > +     systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> > +     systab_pointer->efi_system_table_base = (uintptr_t)&systab;
> > +     systab_pointer->crc32 = crc32(0,
> > +                                   (const unsigned char
> *)systab_pointer,
> > +                                   sizeof(struct
> efi_system_table_pointer));
> > +
> > +     return EFI_SUCCESS;
> > +}
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 48f91da5df7..78c5059256a 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > +     /* Initialize system table pointer */
> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> > +             ret = efi_initialize_system_table_pointer();
> > +             if (ret != EFI_SUCCESS)
> > +                     goto out;
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> >               ret = efi_ecpt_register();
> >               if (ret != EFI_SUCCESS)
>
>
