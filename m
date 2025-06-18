Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2690EC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA4A82BCD;
	Wed, 18 Jun 2025 09:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iQy4/5P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B0C82BF6; Wed, 18 Jun 2025 09:17:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D5682B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750231069; x=1750835869; i=xypron.glpk@gmx.de;
 bh=Fx11c9FLTy3bWfP3T2HX6xabFSfHjbnuH5oUn84yDiA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iQy4/5P3F8utMkOYqxdpGBfKnmH4jjQWoTjRJxB4Kkfjl1HbBZkRT8EPLDC7HqcZ
 Ovx5rcPHoKpEop7xLkVMjdFJyGGaxXHOhXw/9431pHYUXf+Jo+LC9HriQy4aiWV6I
 q4AZ7LKq1PgZe5RMB4bAH2g3OMsUAgIAuXSKTCQVMRGvWp+cbli15Gd3ScA89zu2u
 tnduci5nUs7qe8VEtQp5YxZA/swjoxZs+/EN08fymuXx57stio0hw5uj7aJKrmdby
 1tbW5HxlRM8Tu3uGe4px2PLxzR59OgQIb8I2NoqmMaXDBdloSlocRHTKxzaKtlxjx
 ruCMGX06RkTdPYEllg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.213]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1vDSkK26Av-00bM6q; Wed, 18
 Jun 2025 09:17:49 +0200
Message-ID: <8e6b79be-0053-4773-8c8b-d9bb02301c59@gmx.de>
Date: Wed, 18 Jun 2025 09:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250617120855.87492-1-paulliu@debian.org>
 <20250617120855.87492-5-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250617120855.87492-5-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:if2uKcf1umb+l2kENJaiSzSbq9EuWjbmI7jsKLqC5BapvJuqOVx
 ZppwuZk+c/u3mq4vKDiJQid8ae7esFfl1qf9LAe88o9JO6YOpnIQpegibVPtYk+wc6DTY3a
 no+2WvErloEaUMHhVxJQQKZ5HOVvOr//UYXMYPvsmFwcH0erfbbdEquJIE/DzWuAX97+Iwu
 7KCtS4Z1ntToObe67jxvg==
UI-OutboundReport: notjunk:1;M01:P0:6wnzgLYe0wE=;W3lRmcbl6pARtt+yvMOg+L0lm4W
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

On 6/17/25 14:08, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
> while loading the image.
>=20
> This feature is described in UEFI Spec 2.10. Section 18.4.3.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the load
> address of an EFI application.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: use Kconfig options to turn on/off this feature.
> V3: Use efi_realloc to realloc the tables. Move tables to boot time.
> V4: Use new efi_realloc().
> V5: Fix function comments and move the code into a separate module.
> V6: refine the code. Handling the error of efi_allocate_pool.
> ---
>   include/efi_api.h                  |   2 +
>   include/efi_loader.h               |   5 ++
>   lib/efi_loader/efi_boottime.c      |   8 ++
>   lib/efi_loader/efi_debug_support.c | 137 +++++++++++++++++++++++++++++
>   4 files changed, 152 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 8da0a350ce3..77a05f752e5 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -581,6 +581,8 @@ struct efi_loaded_image {
>   #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
>   #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
> +
>   /**
>    * struct efi_debug_image_info_normal - Store Debug Information for no=
rmal
>    * image.
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 13ca2ec9a4e..22440b842e3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -650,6 +650,11 @@ efi_status_t efi_root_node_register(void);
>   efi_status_t efi_initialize_system_table(void);
>   /* Called by bootefi to initialize debug */
>   efi_status_t efi_initialize_system_table_pointer(void);
> +/* Called by efi_load_image for register debug info */
> +efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
> +						 struct efi_loaded_image *loaded_image,
> +						 efi_handle_t image_handle);
> +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index dbebb37dc04..303b7543e16 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2129,6 +2129,12 @@ efi_status_t EFIAPI efi_load_image(bool boot_poli=
cy,
>   		*image_handle =3D NULL;
>   		free(info);
>   	}
> +
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT) && *image_handle) {
> +		efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> +						    info,
> +						    *image_handle);
> +	}

Braces are not needed here.

>   error:
>   	return EFI_EXIT(ret);
>   }
> @@ -3359,6 +3365,8 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t =
image_handle)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT))
> +		efi_core_remove_debug_image_info_entry(image_handle);
>   	switch (efiobj->type) {
>   	case EFI_OBJECT_TYPE_STARTED_IMAGE:
>   		/* Call the unload function */
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_deb=
ug_support.c
> index f2dfcc5e6b2..d8df95abf95 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -17,6 +17,13 @@ struct efi_debug_image_info_table_header efi_m_debug_=
info_table_header =3D {
>   	NULL
>   };
>  =20
> +/* efi_m_max_table_entries is the maximum entries allocated for
> + * the efi_m_debug_info_table_header.efi_debug_image_info_table.
> + */
> +static u32 efi_m_max_table_entries;
> +
> +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info =
*))
> +
>   /**
>    * efi_initialize_system_table_pointer() - Initialize system table poi=
nter
>    *
> @@ -50,3 +57,133 @@ efi_status_t efi_initialize_system_table_pointer(voi=
d)
>  =20
>   	return EFI_SUCCESS;
>   }
> +
> +/**
> + * efi_core_new_debug_image_info_entry() - Add a new efi_loaded_image s=
tructure to the
> + *                                         efi_debug_image_info Table.

Nits:
%s/Table/table/

> + *
> + * @image_info_type: type of debug image information
> + * @loaded_image:    pointer to the loaded image protocol for the image
> + *                   being loaded
> + * @image_handle:    image handle for the image being loaded
> + *
> + * Re-Allocates the table if it's not large enough to accommodate anoth=
er
> + * entry.
> + *
> + * Return: status code
> + **/
> +efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
> +						 struct efi_loaded_image *loaded_image,
> +						 efi_handle_t image_handle)
> +{
> +	union efi_debug_image_info **table;
> +	u32 index;
> +	u32 table_size;
> +	efi_status_t ret;
> +
> +	/* Set the flag indicating that we're in the process of updating
> +	 * the table.
> +	 */
> +	efi_m_debug_info_table_header.update_status |=3D
> +		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +	table =3D &efi_m_debug_info_table_header.efi_debug_image_info_table;
> +
> +	if (efi_m_debug_info_table_header.table_size >=3D efi_m_max_table_entr=
ies) {
> +		/* table is full, re-allocate the buffer increasing the size
> +		 * by 4 KiB.
> +		 */
> +		table_size =3D efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
> +
> +		ret =3D efi_realloc((void **)table, table_size + EFI_PAGE_SIZE);
> +
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_m_debug_info_table_header.update_status &=3D
> +				~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +			return ret;
> +		}
> +
> +		/* Enlarge the max table entries and set the first empty
> +		 * entry index to be the original max table entries.
> +		 */
> +		efi_m_max_table_entries +=3D
> +			EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
> +	}
> +
> +	/* We always put the next entry at the end of the currently consumed
> +	 * table (i.e. first free entry)
> +	 */
> +	index =3D efi_m_debug_info_table_header.table_size;
> +
> +	/* Allocate data for new entry. */
> +	ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +				sizeof(union efi_debug_image_info),
> +				(void **)(&(*table)[index].normal_image));
> +	if (ret =3D=3D EFI_SUCCESS && (*table)[index].normal_image) {
> +		/* Update the entry. */
> +		(*table)[index].normal_image->image_info_type =3D image_info_type;
> +		(*table)[index].normal_image->loaded_image_protocol_instance =3D
> +			loaded_image;
> +		(*table)[index].normal_image->image_handle =3D image_handle;
> +
> +		/* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
> +		 * set the efi_m_debug_info_table_header in modified status.
> +		 */
> +		efi_m_debug_info_table_header.table_size++;
> +		efi_m_debug_info_table_header.update_status |=3D
> +			EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +	} else {
> +		log_err("Adding new efi_debug_image_info failed\n");
> +		return ret;
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_core_remove_debug_image_info_entry() - Remove an efi_debug_image=
_info entry.
> + *
> + * @image_handle:    image handle for the image being removed
> + **/
> +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle)
> +{
> +	union efi_debug_image_info *table;
> +	u32 index;
> +
> +	efi_m_debug_info_table_header.update_status |=3D
> +		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +	table =3D efi_m_debug_info_table_header.efi_debug_image_info_table;
> +
> +	for (index =3D 0; index < efi_m_max_table_entries; index++) {
> +		if (table[index].normal_image &&
> +		    table[index].normal_image->image_handle =3D=3D image_handle) {
> +			/* Found a match. Free up the table entry.
> +			 * Move the tail of the table one slot to the front.
> +			 */
> +			efi_free_pool(table[index].normal_image);
> +
> +			memcpy(&table[index],
> +			       &table[index + 1],
> +			       (efi_m_debug_info_table_header.table_size -
> +				index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);

You cannot use memcpy() for overlapping memory areas. This is described=20
in the memcpy man page.

Use memmove() instead.

Best regards

Heinrich

> +
> +			/* Decrease the number of EFI_DEBUG_IMAGE_INFO
> +			 * elements and set the efi_m_debug_info_table_header
> +			 * in modified status.
> +			 */
> +			efi_m_debug_info_table_header.table_size--;
> +			table[efi_m_debug_info_table_header.table_size].normal_image =3D
> +				NULL;
> +			efi_m_debug_info_table_header.update_status |=3D
> +				EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +			break;
> +		}
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +}

