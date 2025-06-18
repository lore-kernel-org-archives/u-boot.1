Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F115C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40D782B18;
	Wed, 18 Jun 2025 08:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Qcmkcb/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D966282C2F; Wed, 18 Jun 2025 08:25:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE2182B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750227930; x=1750832730; i=xypron.glpk@gmx.de;
 bh=B+aAOuMH+T/YN0uZ+tH7imKtx1PGDUKqrEMSuTKQ6+E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Qcmkcb/TFsbw+WTqKbPxzKhG8P+BKtMgaT7JkDwndGc5t+Y0dFZ22WLRU9rt6Wb5
 i/ByJ+4A2PQEEoCSxgd8gOp8MLKFAUCeT+uynVna4wLFowLDz7OqxUTE0zCGz0tX3
 gKoAqApKbrKvp0uZeajR2A1xUiU2NCyWhVWTPB6CUDwnhIKtnZ66SA9y5p9C11EWb
 xDFan/yp6V6bcJmFnG3GnTkp0vIlol7xvpZTJ58Y62z+9+IaRyMAiqmdCXeB/4D/p
 iP7j+rmTECRC0NErNqxXYYcGEtiFvhJI80UjzFxWJ9+YUo0Adk9F3bFzPEeo1XlVk
 9c//vFiVXqwi3rC/1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.213]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1umBfT367S-012SMO; Wed, 18
 Jun 2025 08:25:29 +0200
Message-ID: <1598cffa-316b-41c1-b031-fc3259bcfbac@gmx.de>
Date: Wed, 18 Jun 2025 08:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250617120855.87492-1-paulliu@debian.org>
 <20250617120855.87492-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250617120855.87492-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ejFQXPUaCwG5/HoLrErCx8CkQP3u0ZZ/WNXmZ1td61/DFiTShS
 L7yR6sf1Mx+06vHmLhlAwV5piHzoDjVzHJN+GPQiZB4EEN9MHUTAZVxWBL4wsw2Zr8HTXj2
 a/xUZNHBEXGDRbS3ldfEmbuPz/Ztr7Ih4IGwS2br8a4ugcoACpV7qx5bFy7KlGNZgN4avQf
 003jc7ifcdLlMWsmmfhjw==
UI-OutboundReport: notjunk:1;M01:P0:YzWsBsFLbNo=;Xq8JTclSEtAEXR5sDfGX40sMrez
 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
 J5eaYAY
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

On 6/17/25 14:08, Ying-Chun Liu (PaulLiu) wrote:
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
> ---
>   include/efi_api.h                  | 16 +++++++++++
>   include/efi_loader.h               |  2 ++
>   lib/efi_loader/Kconfig             |  8 ++++++
>   lib/efi_loader/Makefile            |  1 +
>   lib/efi_loader/efi_debug_support.c | 46 ++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c         |  8 ++++++
>   6 files changed, 81 insertions(+)
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

There should be at least one defconfig using the setting so that we at=20
least compile the new code in our CI.

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
> index 00000000000..3794b31c4cd
> --- /dev/null
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later

see https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * EFI application boot time services
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
> +	uintptr_t addr;
> +	u32 crc32_value;
> +
> +	/* Allocate configuration table array */

This comment does not match the allocated object.

> +	addr =3D (uintptr_t)efi_alloc_aligned_pages(sizeof(struct efi_system_t=
able_pointer),
> +						  EFI_RUNTIME_SERVICES_DATA,
> +						  SZ_4M);

Please, assign system_pointer here directly and avoid unnecessary=20
conversions (void *) -> (uintptr_t) -> (struct efi_system_table_pointer *)=
.

> +
> +	if (!addr) {
> +		log_err("Installing EFI system table pointer failed\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	systab_pointer =3D (struct efi_system_table_pointer *)addr;
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab=
;
> +
> +	crc32_value =3D crc32(0,
> +			    (const unsigned char *)systab_pointer,
> +			    sizeof(struct efi_system_table_pointer));
> +	systab_pointer->crc32 =3D crc32_value;

You can do that assignment directly without extra variable.

> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..6193b9f6d0c 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS) {
> +			goto out;
> +		}

Running scripts/checkpatch.pl will indicated that the braces should be=20
avoided here to achieve adherence to the kernel style.

Best regards

Heinrich

> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)

