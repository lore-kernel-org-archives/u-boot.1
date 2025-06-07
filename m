Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21142C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9230682AF6;
	Sat,  7 Jun 2025 11:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UZSBxkXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A67782AFC; Sat,  7 Jun 2025 11:39:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E4682A9E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749289149; x=1749893949; i=xypron.glpk@gmx.de;
 bh=AyMprA62N7cxzTTvNgaSDq33GQMn8+izjFFU6OByQw0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UZSBxkXaeHFMYtrCtOye+I+tMQ+ljg7BopXhtKGavCyGZU4idtoGwoJciSp46S0U
 HAh5oh0d6TuS4o3FTLyvxZ7hJjiLgYCwPQ/KLFlj8i26jE7PWt8Z2Muvf4xIlrUWl
 3i1PHr+/njNhtwqqwUcR3bTIb0yAl1oYEVGfpMO9UMuOacugz0C9j4ygCi6r723X9
 /p+gvb5FsqeXY8o575AsGOMZ723ac4A5T0he+stSK1MEv112zVRgAPFExNjhLKtA6
 j1z51iYfd84xHIPP4yaObTVTNZMIVlFlM7+BNe827s64n+vqBHbxbX3dKXKAHlGvv
 SSuZZCYy1Rj6E4O9+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.175.200]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1uGn0l1m74-00Wn8e; Sat, 07
 Jun 2025 11:39:09 +0200
Message-ID: <8985ca13-e999-43d0-b9a5-ba31ab1125a3@gmx.de>
Date: Sat, 7 Jun 2025 11:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250529040520.3799600-1-paulliu@debian.org>
 <20250529040520.3799600-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250529040520.3799600-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KV/LNJk56RHNtvSW/SpFvHlE8cv0OFqveqRjcw6AZNO4sTh5OZh
 9D9oAW+2LUWfpN8uMd7/ozihiEq3WcHTHmWOtZU9Jzr03vn/W7UPOooTI6t8ocbEJJTow7Z
 En9ZTzv1QDV6OnsWa7yPTPxHJ06sO+lgsNbkXoOp5TVCdESK9O7Go0of/EOKS8bcoYxdWLd
 aPYzd8XibFyN494FPSwpQ==
UI-OutboundReport: notjunk:1;M01:P0:+bgrGATD7p4=;0Mgh0beuC8sF1l7IZE8RPvwtB+a
 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
 ap3bupr
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

On 5/29/25 06:05, Ying-Chun Liu (PaulLiu) wrote:
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
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> V3: make efi_initialize_system_table_pointer() do the job as described.
> V4: use efi_alloc_aligned_pages() for system_table_pointer.
> ---
>   include/efi_api.h             | 16 +++++++++++++++
>   include/efi_loader.h          |  2 ++
>   lib/efi_loader/Kconfig        |  7 +++++++
>   lib/efi_loader/efi_boottime.c | 37 +++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c    |  8 ++++++++
>   5 files changed, 70 insertions(+)
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
> index 7f02a83e2a2..d878fc9021d 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT_TABLE
> +	bool "EFI Debug Support Table"
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table which is used by the debug agent or an external debugger to
> +	  determine loaded image information in a quiescent manner.
> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index dbebb37dc04..16e921781e9 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab =
=3D {
>   	.tables =3D NULL,
>   };
>  =20
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D=
 NULL;
> +
>   /**
>    * efi_initialize_system_table() - Initialize system table
>    *
> @@ -4035,3 +4037,38 @@ efi_status_t efi_initialize_system_table(void)
>  =20
>   	return ret;
>   }
> +
> +/**
> + * efi_initialize_system_table() - Initialize system table pointer
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +	const int size_4MB =3D 0x00400000;
> +	u64 addr;
> +	u32 crc32_value;
> +
> +	/* Allocate configuration table array */
> +	addr =3D (u64)efi_alloc_aligned_pages(sizeof(struct efi_system_table_p=
ointer),
> +					    EFI_RUNTIME_SERVICES_DATA,
> +					    size_4MB);

We expect the code to compile after each individual step. Function=20
efi_alloc_aligned_pages() does not exist when this step is applied.

Even if I apply all patches your code does not compile on 32bit systems:

+lib/efi_loader/efi_boottime.c:4072:16: error: cast from pointer to=20
integer of different size [-Werror=3Dpointer-to-int-cast]
+ 4072 |         addr =3D (u64)efi_alloc_aligned_pages(sizeof(struct=20
efi_system_table_pointer),
+      |

Use (uintptr_t) here.

Best regards

Heinrich

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
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..a6b37d994f6 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS) {
> +			goto out;
> +		}
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)

