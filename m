Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5576AC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE533826AA;
	Fri, 11 Jul 2025 22:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oMPxZN88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240CD8277D; Fri, 11 Jul 2025 22:55:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B173081FEE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1752267348; x=1752872148; i=xypron.glpk@gmx.de;
 bh=uEVwGZBxFPmDDuoyLa77WrI3Wb1xxgQl5bBsZpow/2I=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oMPxZN88dlIJrS5VdvycsiYLtWGnbZ5o5OoSkN5IiU5if/mjNUFB4pnjH4wXy/xT
 LtQrlgAAjG2qDgwV0X7SInjj4HLUzt0QCt/gWmra1kDyL/L1j2QYPRrBWsjWRlbrZ
 WaaEaiFlLeiJ0i9riXEV8A2+7Z+PGunAsub4Pn9+3UhHy97JQUCjJj0MGNZlueSLO
 8/Y+WSBR7ZnwZrQjHjk2sg1zQXcCEfemYQbzoC7s50fMdynbg62Id2SzVkoRqrl1X
 Z9YW+I23PUMsnuezBRLHY08HbUfmId95QW9D7N2hSDAm/fuBJtzmbTs0jIwMW5m7i
 1VwkSlvwPieZ1yg9cA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1uOjfW1Qv8-00GqQv; Fri, 11
 Jul 2025 22:55:48 +0200
Date: Fri, 11 Jul 2025 22:55:45 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Paul Liu <paul.liu@linaro.org>
CC: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
User-Agent: Thunderbird for Android
In-Reply-To: <CALG-KHyh2zaOWtyrQiCxp7OxnJHmUnBkyKrV761y-88=RNu8Sg@mail.gmail.com>
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-2-paulliu@debian.org>
 <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
 <CALG-KHyh2zaOWtyrQiCxp7OxnJHmUnBkyKrV761y-88=RNu8Sg@mail.gmail.com>
Message-ID: <3DCBE6CC-1427-4923-97AC-6FA12CA858C0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHEBbDPLi4lNq/bl7gjh8Tm5KaxR1ZqJWgR48iepAxAI+ClEgXo
 urxMz4kEEMwaei3FxrOelfAhu6XaYgyEBL+A4ykynsUL/W3LIbRqMJUUtv+PEC2+kl0P7mj
 GCOUJ/11Mv3Y6PskA789SVUS6U2OK4Loz1xGgQmkV0lc6fW5aGIwBx4fdFq2vq2yqUkIsak
 iYPJdFSJWWpJ1DRTRpBOw==
UI-OutboundReport: notjunk:1;M01:P0:gIi6ajRE13M=;tIJJvKV6W02Myvr39zuQvYamkf9
 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
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

Am 4=2E Juli 2025 13:59:53 MESZ schrieb Paul Liu <paul=2Eliu@linaro=2Eorg>:
>Hi Heinrich, Ilias,
>
>Sorry for the late reply=2E I'm a bit worried about this change=2E This
>structure (efi_system_table_pointer), is not packed=2E
>So its actual size is a bit larger=2E The crc32 field is not at the end o=
f
>the structure=2E Actually there are 4 bytes padding after it=2E But the C=
RC32
>function is calculating the crc sum on the whole structure=2E So it might
>produce random value if we don't zero those padding bytes=2E

Thanks for highlighting this=2E

Structures in UEFI are typically packed=2E

Should padding bytes really be included in the crc32?

We should add a test of the crc32 to https://github=2Ecom/trini/u-boot/blo=
b/master/lib/efi_loader/dbginfodump=2Ec so that we can compare U-Boot to ED=
K2=2E

Best regards

Heinrich

>
>Yours,
>Paul
>
>
>On Thu, 3 Jul 2025 at 08:25, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>
>> On 03=2E07=2E25 08:28, Ying-Chun Liu (PaulLiu) wrote:
>> > From: "Ying-Chun Liu (PaulLiu)" <paul=2Eliu@linaro=2Eorg>
>> >
>> > Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
>> > the address of EFI_SYSTEM_TABLE=2E
>> >
>> > This feature is described in UEFI SPEC version 2=2E10=2E Section 18=
=2E4=2E2=2E
>> > The implementation ensures support for hardware-assisted debugging an=
d
>> > provides a standardized mechanism for debuggers to discover the EFI
>> > system table=2E
>> >
>> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul=2Eliu@linaro=2Eorg>
>> > Reviewed-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>> > Tested-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > Cc: Peter Robinson <pbrobinson@gmail=2Ecom>
>> > Cc: Simon Glass <sjg@chromium=2Eorg>
>> > ---
>> > V2: add Kconfig options to turn on/off this feature=2E
>> > V3: make efi_initialize_system_table_pointer() do the job as describe=
d=2E
>> > V4: use efi_alloc_aligned_pages() for system_table_pointer=2E
>> > V5: move the code into a separate module=2E
>> > V6: Use macros to replace size_4MB
>> > V7: Fix the code based on the review=2E Update license field=2E
>> > V8: Fix pointer casting that causes qemu_arm_defconfig failed=2E Modi=
fy
>> KConfig
>> >      so that more defconfigs enabled by default=2E
>> > ---
>> >   include/efi_api=2Eh                  | 16 ++++++++++++
>> >   include/efi_loader=2Eh               |  2 ++
>> >   lib/efi_loader/Kconfig             |  9 +++++++
>> >   lib/efi_loader/Makefile            |  1 +
>> >   lib/efi_loader/efi_debug_support=2Ec | 40 +++++++++++++++++++++++++=
+++++
>> >   lib/efi_loader/efi_setup=2Ec         |  7 ++++++
>> >   6 files changed, 75 insertions(+)
>> >   create mode 100644 lib/efi_loader/efi_debug_support=2Ec
>> >
>> > diff --git a/include/efi_api=2Eh b/include/efi_api=2Eh
>> > index eb61eafa028=2E=2E6c4c1a0cc7b 100644
>> > --- a/include/efi_api=2Eh
>> > +++ b/include/efi_api=2Eh
>> > @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
>> >       efi_status_t capsule_status;
>> >   } __packed;
>> >
>> > +/**
>> > + * struct efi_system_table_pointer - struct to store the pointer of
>> system
>> > + * table=2E
>> > + * @signature: The signature of this struct=2E
>> > + * @efi_system_table_base: The physical address of System Table=2E
>> > + * @crc32: CRC32 checksum
>> > + *
>> > + * This struct is design for hardware debugger to search through mem=
ory
>> to
>> > + * get the address of EFI System Table=2E
>> > + */
>> > +struct efi_system_table_pointer {
>> > +     u64 signature;
>> > +     efi_physical_addr_t efi_system_table_base;
>> > +     u32 crc32;
>> > +};
>> > +
>> >   struct efi_memory_range {
>> >       efi_physical_addr_t     address;
>> >       u64                     length;
>> > diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>> > index 8f9f2bcf1cb=2E=2E8f065244d8e 100644
>> > --- a/include/efi_loader=2Eh
>> > +++ b/include/efi_loader=2Eh
>> > @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>> >   efi_status_t efi_root_node_register(void);
>> >   /* Called by bootefi to initialize runtime */
>> >   efi_status_t efi_initialize_system_table(void);
>> > +/* Called by bootefi to initialize debug */
>> > +efi_status_t efi_initialize_system_table_pointer(void);
>> >   /* efi_runtime_detach() - detach unimplemented runtime functions */
>> >   void efi_runtime_detach(void);
>> >   /* efi_convert_pointer() - convert pointer to virtual address */
>> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> > index 7f02a83e2a2=2E=2E621db8b5c79 100644
>> > --- a/lib/efi_loader/Kconfig
>> > +++ b/lib/efi_loader/Kconfig
>> > @@ -71,6 +71,15 @@ config EFI_SECURE_BOOT
>> >   config EFI_SIGNATURE_SUPPORT
>> >       bool
>> >
>> > +config EFI_DEBUG_SUPPORT
>> > +     bool "EFI Debug Support"
>> > +     default y if !HAS_BOARD_SIZE_LIMIT
>> > +     help
>> > +       Select this option if you want to setup the EFI Debug Support
>> > +       Table and the EFI_SYSTEM_TABLE_POINTER which is used by the d=
ebug
>> > +       agent or an external debugger to determine loaded image
>> information
>> > +       in a quiescent manner=2E
>> > +
>> >   menu "UEFI services"
>> >
>> >   config EFI_GET_TIME
>> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> > index cf050e5385d=2E=2E51ccf1cd87e 100644
>> > --- a/lib/efi_loader/Makefile
>> > +++ b/lib/efi_loader/Makefile
>> > @@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_risc=
v=2Eo
>> >   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd=2Eo
>> >   obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) +=3D efi_signature=2Eo
>> >   obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance=2Eo
>> > +obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support=2Eo
>> >
>> >   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>> >   $(obj)/efi_var_seed=2Eo: $(srctree)/$(EFI_VAR_SEED_FILE)
>> > diff --git a/lib/efi_loader/efi_debug_support=2Ec
>> b/lib/efi_loader/efi_debug_support=2Ec
>> > new file mode 100644
>> > index 00000000000=2E=2E7dc5fa93af9
>> > --- /dev/null
>> > +++ b/lib/efi_loader/efi_debug_support=2Ec
>> > @@ -0,0 +1,40 @@
>> > +// SPDX-License-Identifier: GPL-2=2E0-or-later
>> > +/*
>> > + * EFI debug support
>> > + *
>> > + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd=2E <paul=2Eliu@linar=
o=2Eorg>
>> > + */
>> > +
>> > +#include <efi_loader=2Eh>
>> > +#include <linux/sizes=2Eh>
>> > +#include <u-boot/crc=2Eh>
>> > +
>> > +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
=3D
>> NULL;
>> > +
>> > +/**
>> > + * efi_initialize_system_table_pointer() - Initialize system table
>> pointer
>> > + *
>> > + * Return:   status code
>> > + */
>> > +efi_status_t efi_initialize_system_table_pointer(void)
>> > +{
>> > +     /* Allocate efi_system_table_pointer structure with 4MB alignme=
nt=2E
>> */
>> > +     systab_pointer =3D efi_alloc_aligned_pages(sizeof(struct
>> efi_system_table_pointer),
>> > +                                              EFI_RUNTIME_SERVICES_D=
ATA,
>> > +                                              SZ_4M);
>> > +
>> > +     if (!systab_pointer) {
>> > +             log_err("Installing EFI system table pointer failed\n")=
;
>> > +             return EFI_OUT_OF_RESOURCES;
>> > +     }
>> > +
>> > +     memset(systab_pointer, 0, sizeof(struct efi_system_table_pointe=
r));
>>
>> systab_pointer->crc32 =3D 0;
>>
>> would have been an alternative=2E Maybe Ilias wants to change that when
>> merging=2E
>>
>> Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>
>> > +
>> > +     systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
>> > +     systab_pointer->efi_system_table_base =3D (uintptr_t)&systab;
>> > +     systab_pointer->crc32 =3D crc32(0,
>> > +                                   (const unsigned char
>> *)systab_pointer,
>> > +                                   sizeof(struct
>> efi_system_table_pointer));
>> > +
>> > +     return EFI_SUCCESS;
>> > +}
>> > diff --git a/lib/efi_loader/efi_setup=2Ec b/lib/efi_loader/efi_setup=
=2Ec
>> > index 48f91da5df7=2E=2E78c5059256a 100644
>> > --- a/lib/efi_loader/efi_setup=2Ec
>> > +++ b/lib/efi_loader/efi_setup=2Ec
>> > @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
>> >       if (ret !=3D EFI_SUCCESS)
>> >               goto out;
>> >
>> > +     /* Initialize system table pointer */
>> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
>> > +             ret =3D efi_initialize_system_table_pointer();
>> > +             if (ret !=3D EFI_SUCCESS)
>> > +                     goto out;
>> > +     }
>> > +
>> >       if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>> >               ret =3D efi_ecpt_register();
>> >               if (ret !=3D EFI_SUCCESS)
>>
>>

