Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD15C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 22:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71A48082A;
	Fri, 25 Apr 2025 00:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UESiPd/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0C6809D4; Fri, 25 Apr 2025 00:34:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD888059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 00:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745534057; x=1746138857; i=xypron.glpk@gmx.de;
 bh=dhxRWYW1TwGBIbc92wfJU7zur4ssqkPiaOlUhRm5c1E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UESiPd/rwsGWbRtP60WBtIVwjp3ynq4Kh+tPLaBx/4gMvQI2Ef6HFzHhsgUC6BxI
 bsDHjWPly8gOt/k80esBeZHoweKFoq+3RLQDcosNaM8++yc481cWKHyaUFdbrJQMW
 J4PUpYiisZiFl5Qgji8OUxazxI+5LJpwsrCo87MAHvtNNIHqZFvaZD6YwAUvWicyp
 c0VHPrQGYLDGE628IDRNgdatYF5KVaUVGXGqKPaSyxEKJWnZROMXNs1oeucAIzjbP
 cEIB0sAwZwidG1GQVDLoNKaXd/Z8lKHIuJTyioRqN1OGc6pTnVxd0R0Kc9Y1L9vaB
 jbsvp6x5x9OFOQlHKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.109.177]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1uCC1C1hUh-00C5Nu; Fri, 25
 Apr 2025 00:34:17 +0200
Message-ID: <aded7723-931f-4d17-87ad-dbe788792892@gmx.de>
Date: Fri, 25 Apr 2025 00:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-4-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250424201927.2027257-4-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HNeivT0T/NsjK68LrOj5BMSzALmnhn+ppsyA6SmupJFJOZl2HWQ
 reSVtgTHcrhfGgFjVf4w5uWSO05eF3+FZ5fo8oC56BRM6WvAFdiuxowcRzGg6If2Mf6Idzz
 9tlEDaR0lvgnrj+0lRhz+BmEFMv3nmprna7Pj4Zt+Exh/+Obm93yRRZKUeo3dLn5bwmXdDQ
 ayVYCw5PvTpB3+eOFy9ng==
UI-OutboundReport: notjunk:1;M01:P0:s2HJlsYqZyI=;BmrLeYSQQXm8bvkGvEx/xXS+i0h
 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
 LMCw=
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

On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
> while loading the image.
>=20
> This feature is described in UEFI Spec 2.10. Section 18.4.3.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V2: use Kconfig options to turn on/off this feature.
> ---
>   include/efi_api.h             |   2 +
>   include/efi_loader.h          |   5 ++
>   lib/efi_loader/efi_boottime.c | 140 ++++++++++++++++++++++++++++++++++
>   3 files changed, 147 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 0f4245091f1..ba87af17c1f 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -571,6 +571,8 @@ struct efi_loaded_image {
>   #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
>   #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
> +
>   struct efi_debug_image_info_normal {
>   	u32 image_info_type;
>   	struct efi_loaded_image *loaded_image_protocol_instance;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 370bc042f70..babe23a8a83 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -617,6 +617,11 @@ efi_status_t efi_root_node_register(void);
>   efi_status_t efi_initialize_system_table(void);
>   /* Called by bootefi to initialize debug */
>   efi_status_t efi_initialize_system_table_pointer(void);
> +/* Called by efi_load_image for register debug info */
> +void efi_core_new_debug_image_info_entry(u32 image_info_type,
> +					 struct efi_loaded_image *loaded_image,
> +					 efi_handle_t image_handle);
> +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index e2665459e44..0d4df5ee6ae 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2130,6 +2130,14 @@ efi_status_t EFIAPI efi_load_image(bool boot_poli=
cy,
>   		*image_handle =3D NULL;
>   		free(info);
>   	}
> +
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> +		if (*image_handle) {
> +			efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL=
,
> +							    info,
> +							    *image_handle);
> +		}
> +	}
>   error:
>   	return EFI_EXIT(ret);
>   }
> @@ -3359,6 +3367,9 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t =
image_handle)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> +		efi_core_remove_debug_image_info_entry(image_handle);
> +	}
>   	switch (efiobj->type) {
>   	case EFI_OBJECT_TYPE_STARTED_IMAGE:
>   		/* Call the unload function */
> @@ -4045,6 +4056,10 @@ efi_m_debug_info_table_header =3D {
>   	NULL
>   };
>

Please, describe this field.

> +static u32 efi_m_max_table_entries;
> +

> +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))

Wouldn't it be more readable to use sizeof(union efi_debug_image_info *)=
=20
instead of this constant?

> +
>   const efi_guid_t efi_debug_image_info_table_guid =3D
>   	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
>  =20
> @@ -4095,3 +4110,128 @@ efi_status_t efi_initialize_system_table_pointer=
(void)
>  =20
>   	return ret;
>   }
> +
> +/**
> + * Add a new efi_loaded_image structure to the efi_debug_image_info Tab=
le.
> + * Re-Allocates the table if it's not large enough to accomidate anothe=
r
> + * entry.
> + *
> + * @param image_info_type  type of debug image information
> + * @param loaded_image     pointer to the loaded image protocol for the=
 image
> + *                         being loaded
> + * @param image_handle     image handle for the image being loaded
> + **/
> +void efi_core_new_debug_image_info_entry(u32 image_info_type,
> +					 struct efi_loaded_image *loaded_image,
> +					 efi_handle_t image_handle)

Reallocation can fail. The return value type void seems not to be adequate=
.

> +{
> +	union efi_debug_image_info *table;
> +	union efi_debug_image_info *new_table;
> +	u32 index;
> +	u32 table_size;
> +
> +	/* Set the flag indicating that we're in the process of updating
> +	 * the table.
> +	 */
> +	efi_m_debug_info_table_header.update_status |=3D
> +		EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +	table =3D efi_m_debug_info_table_header.efi_debug_image_info_table;
> +
> +	if (efi_m_debug_info_table_header.table_size < efi_m_max_table_entries=
) {
> +		/* We still have empty entries in the Table, find the first
> +		 * empty entry.
> +		 */
> +		index =3D 0;
> +		while (table[index].normal_image)
> +			index++;
> +	} else {
> +		/* table is full, re-allocate another page for a larger

"Re-allocate the buffer increasing the size by 4 KiB" would be clearer.

> +		 * table.
> +		 */
> +		table_size =3D efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
> +		efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
> +				  table_size + EFI_PAGE_SIZE,
> +				  (void **)&new_table);
> +
> +		if (!new_table) {
> +			efi_m_debug_info_table_header.update_status &=3D
> +				~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +			return;
> +		}
> +
> +		memset(new_table, 0, table_size + EFI_PAGE_SIZE);

Please, carve out an efi_realloc() function and place it in=20
lib/efi_loader/efi_memory.c beside efi_alloc().

> +
> +		/* Copy the old table into the new one. */
> +		memcpy(new_table, table, table_size);
> +		/* Free the old table. */
> +		efi_free_pool(table);
> +		/* Update the table header. */
> +		table =3D new_table;
> +		efi_m_debug_info_table_header.efi_debug_image_info_table =3D
> +			new_table;
> +
> +		/* Enlarge the max table entries and set the first empty
> +		 * entry index to be the original max table entries.
> +		 */
> +		index =3D efi_m_max_table_entries;
> +		efi_m_max_table_entries +=3D
> +			EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
> +	}
> +
> +	/* Allocate data for new entry. */
> +	efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
> +			  sizeof(struct efi_debug_image_info_normal),
> +			  (void **)(&table[index].normal_image));

efi_allocate_pool() will consume a whole page. Shouldn't we have an=20
array of consecutive structures and use realloc_pool() to enlarge it if=20
we load too many images?

> +	if (table[index].normal_image) {
> +		/* Update the entry. */
> +		table[index].normal_image->image_info_type =3D image_info_type;
> +		table[index].normal_image->loaded_image_protocol_instance =3D
> +			loaded_image;

All protocols become invalid after ExitBootServices(). Why would you use=
=20
EFI_RUNTIME_SERVICES_DATA to store references to something that does not=
=20
exist at runtime?

EDK II uses AllocateZeroPool() which does not use EfiRuntimeServicesData.

Best regards

Heinrich

> +		table[index].normal_image->image_handle =3D image_handle;
> +
> +		/* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
> +		 * set the efi_m_debug_info_table_header in modified status.
> +		 */
> +		efi_m_debug_info_table_header.table_size++;
> +		efi_m_debug_info_table_header.update_status |=3D
> +			EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +}
> +
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
> +			/* Found a match. Free up the record, then NULL the
> +			 * pointer to indicate the slot is free.
> +			 */
> +			efi_free_pool(table[index].normal_image);
> +			table[index].normal_image =3D NULL;
> +
> +			/* Decrease the number of EFI_DEBUG_IMAGE_INFO
> +			 * elements and set the efi_m_debug_info_table_header
> +			 * in modified status.
> +			 */
> +			efi_m_debug_info_table_header.table_size--;
> +			efi_m_debug_info_table_header.update_status |=3D
> +				EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +			break;
> +		}
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +}

