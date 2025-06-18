Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF50C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7363082B18;
	Wed, 18 Jun 2025 08:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rwFCQ1kH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FE282B20; Wed, 18 Jun 2025 08:39:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5F582B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750228788; x=1750833588; i=xypron.glpk@gmx.de;
 bh=SuMBG+gwv66plphcsnvRpq79CmA8KDznuJRX1lEKokQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rwFCQ1kHQT/l53Z+KVubX9s1+THDY6aL5mdz5oyrvb7JhtzBdB03XkdMZ/YkBeVk
 r7fvaVORQ9AMb1kNRbYA+lSwaKfskVQFkhUXWUhBUzq6R4o1ScyBHIu3VZKpvFmOl
 19KA2fWCFKp54UHrrJsJhTI61v39zd+vWnLjI1FmeyNyv71H3jxzBW4hqzeU+amZP
 HuLEXdqdVujKpBZrP7WeVkNgaJVLGYjWcC1ADvAY7mnWacuhqbcOlQUvCVSaH9Mrg
 qKDNkig8GwR6VnLzKihT2kztGNl7OkTHYVPiB377xKhO08P/M58umIj+2oBgYX2KI
 iMeUBZ/5PN9XvRyOdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.213]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1un0fu44K5-011j4f; Wed, 18
 Jun 2025 08:39:48 +0200
Message-ID: <ca021089-b82f-427b-a29a-34d3813afce5@gmx.de>
Date: Wed, 18 Jun 2025 08:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250617120855.87492-1-paulliu@debian.org>
 <20250617120855.87492-3-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250617120855.87492-3-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PGiddLcBzVkLQnzpARBHIStPDjJlSrw6z05tmxE5QJ9LfBSpNBH
 BNnwD7sbal2mStW6kfrTEFWcO/iKXVYeTDaiFAFptECtOual35JAoZNrZwE/ZM9CdLBKxci
 95v4FvwbjqipWf1ZmiDwN2bf/smFp9KTDainJgnncfuPPV8iIDA82n193/fOBwnjaUEsl5u
 qTQaAe0dqx2xsgYCMgLqA==
UI-OutboundReport: notjunk:1;M01:P0:6De+lm2dLUg=;B/brR2cTrViS23TopI0lacaniBO
 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
 XDbUER9PZmTTW6VPvtYd0LKhJ6QLW1FuHLdR8g==
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
> EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE=
.
>=20
> This feature is described in UEFI Spec version 2.10. Section 18.4.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover and interact
> with system-level debug resources.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V3: Fix the way of installation of configuration table.
> V5: move the code into a separate module.
> ---
>   include/efi_api.h                  | 53 ++++++++++++++++++++++++++++++
>   include/efi_loader.h               |  2 ++
>   lib/efi_loader/efi_debug_support.c |  6 ++++
>   lib/efi_loader/efi_setup.c         | 12 +++++++
>   4 files changed, 73 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 6c4c1a0cc7b..8da0a350ce3 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -238,6 +238,10 @@ enum efi_reset_type {
>   	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
>   		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
> +	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
> +		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> +
>   struct efi_conformance_profiles_table {
>   	u16 version;
>   	u16 number_of_profiles;
> @@ -574,6 +578,55 @@ struct efi_loaded_image {
>   	efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
>   };
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> +
> +/**
> + * struct efi_debug_image_info_normal - Store Debug Information for nor=
mal
> + * image.
> + * @image_info_type: the type of image info.
> + * @loaded_image_protocol_instance: the pointer to struct efi_loaded_im=
age.
> + * @image_handle: the EFI handle of the image.
> + *
> + * This struct is created by efi_load_image() and store the information
> + * for debugging an normal image.
> + */
> +struct efi_debug_image_info_normal {
> +	u32 image_info_type;
> +	struct efi_loaded_image *loaded_image_protocol_instance;
> +	efi_handle_t image_handle;
> +};
> +
> +/**
> + * union efi_debug_image_info - The union to store a pointer for EFI
> + * DEBUG IMAGE INFO.
> + * @image_info_type: the type of the image_info if it is not a normal i=
mage.
> + * @normal_image: The pointer to a normal image.
> + *
> + * This union is for a pointer that can point to the struct of normal_i=
mage.
> + * Or it points to an image_info_type.
> + */
> +union efi_debug_image_info {
> +	u32 *image_info_type;
> +	struct efi_debug_image_info_normal *normal_image;
> +};
> +
> +/**
> + * struct efi_debug_image_info_table_header - store the array of
> + * struct efi_debug_image_info.
> + * @update_status: Status to notify this struct is ready to use or not.
> + * @table_size: The number of elements of efi_debug_image_info_table.
> + * @efi_debug_image_info_table: The array of efi_debug_image_info.
> + *
> + * This struct stores the array of efi_debug_image_info. The
> + * number of elements is table_size.
> + */
> +struct efi_debug_image_info_table_header {
> +	volatile u32 update_status;
> +	u32 table_size;
> +	union efi_debug_image_info *efi_debug_image_info_table;
> +};
> +
>   #define EFI_DEVICE_PATH_PROTOCOL_GUID \
>   	EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
>   		 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 8f065244d8e..d0c72d0bc58 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -315,6 +315,8 @@ extern const struct efi_hii_config_routing_protocol =
efi_hii_config_routing;
>   extern const struct efi_hii_config_access_protocol efi_hii_config_acce=
ss;
>   extern const struct efi_hii_database_protocol efi_hii_database;
>   extern const struct efi_hii_string_protocol efi_hii_string;
> +/* structure for EFI_DEBUG_SUPPORT_PROTOCOL */
> +extern struct efi_debug_image_info_table_header efi_m_debug_info_table_=
header;
>  =20
>   uint16_t *efi_dp_str(struct efi_device_path *dp);
>  =20
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_deb=
ug_support.c
> index 3794b31c4cd..f2dfcc5e6b2 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -11,6 +11,12 @@
>  =20
>   struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
=3D NULL;
>  =20
> +struct efi_debug_image_info_table_header efi_m_debug_info_table_header =
=3D {
> +	0,
> +	0,
> +	NULL
> +};
> +
>   /**
>    * efi_initialize_system_table_pointer() - Initialize system table poi=
nter
>    *
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 6193b9f6d0c..60f3a7e5fbf 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -18,6 +18,9 @@
>  =20
>   efi_status_t efi_obj_list_initialized =3D OBJ_LIST_NOT_INITIALIZED;
>  =20
> +const efi_guid_t efi_debug_image_info_table_guid =3D
> +	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> +
>   /*
>    * Allow unaligned memory access.
>    *
> @@ -280,10 +283,19 @@ efi_status_t efi_init_obj_list(void)
>  =20
>   	/* Initialize system table pointer */
>   	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +		efi_guid_t debug_image_info_table_guid =3D

This variable shadows the variable defined above.

> +			efi_debug_image_info_table_guid;

This self assignment provides a random value from the stack and not the=20
expected GUID.

Please, provide a test in lib/efi_selftest/ verifying that the table is=20
installed with the correct GUID.

> +
>   		ret =3D efi_initialize_system_table_pointer();
>   		if (ret !=3D EFI_SUCCESS) {
>   			goto out;
>   		}
> +
> +		ret =3D efi_install_configuration_table(&debug_image_info_table_guid,
> +						      &efi_m_debug_info_table_header);
> +		if (ret !=3D EFI_SUCCESS) {
> +			goto out;
> +		}

No braces here. Please, use scripts/checkpatch.pl before resubmitting.

Best regards

Heinrich

>   	}
>  =20
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {

