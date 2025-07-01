Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68827C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56AF81FEE;
	Tue,  1 Jul 2025 09:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k3RbNyLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F0D82ADA; Tue,  1 Jul 2025 09:26:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF9D8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751354764; x=1751959564; i=xypron.glpk@gmx.de;
 bh=gZw+ncewh746ErlNU75z2aINQce63ehYhJemQl0YxKE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k3RbNyLiNAK5H5vSwQ4fi1zvRehVNzQPjPYx9G+lz2Sqt9YZ3cO/ddoI/M6RF4h9
 p/vW0yS7t96O0ERH13v7wsDs6WAldKbC1lMfzo7ugq18X+8+j4X5SfZHn890TfZoI
 A7oYhkrPYEYRLv1piKtEyOio3OrkKixBKs6qcjRUAPPxnJeCTMdjirmFZZ7p1++fX
 i929k7j3Pn2LG+GDkHyrvb+cPGWZ/1OyOpXGvaoHylsOl3SX1TBdpM3H4W/RrWRf8
 UeWi+Nc9oGTZfPimU8jgJat4fnRs2RHXxnuanW3dgv23HzN/YgBgX1HnQNziiRe0v
 r9Sz9Iy8WDIC2KPJVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1uHiLa0RKA-00RZ5m; Tue, 01
 Jul 2025 09:26:04 +0200
Message-ID: <ad4bf9bc-c2c6-451f-8fa2-f4879172733b@gmx.de>
Date: Tue, 1 Jul 2025 09:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250701034926.83536-1-paulliu@debian.org>
 <20250701034926.83536-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701034926.83536-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E4WR7tvsOruehJpliJKfuxmqRNhYYN3KKGUjGzun2D5CkHeE8cz
 NPkNwGIrayol6oiuMbFMEFu+x4y/FxxOIDcaWkBgMQ7KBOz5RDNBg1BNKtOcbwtiP7cZTTI
 oHVySJLZk6Tmu1dHK3x4fb9dTRonv3y0I3luWyPMVxTk2ETr8SzUFvG4vCcdaZTSnOlznPs
 iVyqN7U37Z0HFDGqGVBnQ==
UI-OutboundReport: notjunk:1;M01:P0:3nVLoIvD9GA=;BGDa470GqhJPeyrQ5XooZy8GX5m
 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
 tqIExJoGV0CSptr68puFObs=
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

On 01.07.25 05:49, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> the address of EFI_SYSTEM_TABLE.
>=20
> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the EFI
> system table.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> V3: make efi_initialize_system_table_pointer() do the job as described.
> V4: use efi_alloc_aligned_pages() for system_table_pointer.
> V5: move the code into a separate module.
> V6: Use macros to replace size_4MB
> V7: Fix the code based on the review. Update license field.
> ---
>   include/efi_api.h                  | 16 ++++++++++++
>   include/efi_loader.h               |  2 ++
>   lib/efi_loader/Kconfig             |  8 ++++++
>   lib/efi_loader/Makefile            |  1 +
>   lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c         |  7 ++++++
>   6 files changed, 74 insertions(+)
>   create mode 100644 lib/efi_loader/efi_debug_support.c
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index eb61eafa028..6c4c1a0cc7b 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
>   	efi_status_t capsule_status;
>   } __packed;
>  =20
> +/**
> + * struct efi_system_table_pointer - struct to store the pointer of sys=
tem
> + * table.
> + * @signature: The signature of this struct.
> + * @efi_system_table_base: The physical address of System Table.
> + * @crc32: CRC32 checksum
> + *
> + * This struct is design for hardware debugger to search through memory=
 to
> + * get the address of EFI System Table.
> + */
> +struct efi_system_table_pointer {
> +	u64 signature;
> +	efi_physical_addr_t efi_system_table_base;
> +	u32 crc32;
> +};
> +
>   struct efi_memory_range {
>   	efi_physical_addr_t	address;
>   	u64			length;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 8f9f2bcf1cb..8f065244d8e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>   efi_status_t efi_root_node_register(void);
>   /* Called by bootefi to initialize runtime */
>   efi_status_t efi_initialize_system_table(void);
> +/* Called by bootefi to initialize debug */
> +efi_status_t efi_initialize_system_table_pointer(void);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 7f02a83e2a2..f9d75cbc3fd 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -71,6 +71,14 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT
> +	bool "EFI Debug Support"
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> +	  agent or an external debugger to determine loaded image information
> +	  in a quiescent manner.
> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index cf050e5385d..51ccf1cd87e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_riscv.o
>   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd.o
>   obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) +=3D efi_signature.o
>   obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
> +obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
>  =20
>   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_deb=
ug_support.c
> new file mode 100644
> index 00000000000..c9773feaa5b
> --- /dev/null
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * EFI debug support
> + *
> + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> + */
> +
> +#include <efi_loader.h>
> +#include <linux/sizes.h>
> +#include <u-boot/crc.h>
> +
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D=
 NULL;
> +
> +/**
> + * efi_initialize_system_table_pointer() - Initialize system table poin=
ter
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +	/* Allocate efi_system_table_pointer structure with 4MB alignment. */
> +	systab_pointer =3D efi_alloc_aligned_pages(sizeof(struct efi_system_ta=
ble_pointer),
> +						 EFI_RUNTIME_SERVICES_DATA,
> +						 SZ_4M);
> +
> +	if (!systab_pointer) {
> +		log_err("Installing EFI system table pointer failed\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab=
;

When building with qemu_arm_defconfig:

lib/efi_loader/efi_debug_support.c: In function=20
=E2=80=98efi_initialize_system_table_pointer=E2=80=99:
lib/efi_loader/efi_debug_support.c:48:49: warning: cast from pointer to=20
integer of different size [-Wpointer-to-int-cast]
    48 |         systab_pointer->efi_system_table_base =3D=20
(efi_physical_addr_t)&systab;
       |

You should use (uintptr_t) for the cast.

Best regards

Heinrich

> +	systab_pointer->crc32 =3D crc32(0,
> +				      (const unsigned char *)systab_pointer,
> +				      sizeof(struct efi_system_table_pointer));
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..78c5059256a 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)

