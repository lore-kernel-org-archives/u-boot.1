Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C161CC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF8D82958;
	Mon, 28 Apr 2025 12:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dB+pqdkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0890082145; Mon, 28 Apr 2025 12:40:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6636829E7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745836851; x=1746441651; i=xypron.glpk@gmx.de;
 bh=OmAiNLZoBQMuI4xfcOeHUyPaArO/pjSb+iuR3qUKkuQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dB+pqdkIvHgKysyk+Yd+Nzv0/AsjoEdVCQFeg5wFIzjY+OPwie4l+WL9oOP36Abz
 IefUuNnyFZEjO208wrJuKw8AdaCZppFihCf2HaAm87k41q9Hq3xaX5uSmveyxif8j
 hYxpufG9BbUQJCUVBBOOS8AqUAwpJz83H0NtFJ1NfcybkgoKPxxF45EJ37bZfDXlb
 SeHQRIlNJ6QV0gHsP4bCMvqO3RyseorIRruN95gjx6Y5QQFmWhYt0deNVzAbnPxgu
 Ntp0ODi/Gihc5uk/4E4AqYJqO4DP9tIqmCcClISYEpItJyeK1k5uPzVkLXSv4YIQi
 dy4W+jYPIXETRc9fZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.110.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1uQKZN12oc-00Xlm7; Mon, 28
 Apr 2025 12:40:51 +0200
Message-ID: <f9010568-6a52-4486-9c29-794107f2e840@gmx.de>
Date: Mon, 28 Apr 2025 12:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250423213145.1959046-1-paulliu@debian.org>
 <20250423213145.1959046-4-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250423213145.1959046-4-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w2MLV/uIDgXase7jyF/wIOBXfV5mJBKoULMSOHKhUHfN/JJ3/NP
 gUYxVaV7mb0926zfpsuUSl8eNP9ZM/bEbF26yl7xoY7k6xrojnMYOLTmgpJJ99IVSNzcuKi
 y+mThez76UZurKpGN2cOQlcPB0L8HW24x0Uur+ki7HC1NN+EoIMCjIogCiqNFr6HeVxvgB3
 L1OsgQyebAQPxxrb1xhGw==
UI-OutboundReport: notjunk:1;M01:P0:jx3yBh9p6f4=;hKUigUHFT1CwLkv0yFYlChaKYej
 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
 ZN5fBB8MFpxGEtsP/eOOzp6aJGThl+FLOJ
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

On 4/23/25 23:31, Ying-Chun Liu (PaulLiu) wrote:
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
>   include/efi_api.h             |   2 +
>   include/efi_loader.h          |   5 ++
>   lib/efi_loader/efi_boottime.c | 136 ++++++++++++++++++++++++++++++++++
>   3 files changed, 143 insertions(+)
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
> index e2665459e44..bf37580c06b 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2130,6 +2130,12 @@ efi_status_t EFIAPI efi_load_image(bool boot_poli=
cy,
>   		*image_handle =3D NULL;
>   		free(info);
>   	}
> +
> +	if (*image_handle) {
> +		efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> +						    info,
> +						    *image_handle);
> +	}
>   error:
>   	return EFI_EXIT(ret);
>   }
> @@ -3359,6 +3365,7 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t =
image_handle)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	efi_core_remove_debug_image_info_entry(image_handle);
>   	switch (efiobj->type) {
>   	case EFI_OBJECT_TYPE_STARTED_IMAGE:
>   		/* Call the unload function */
> @@ -4045,6 +4052,10 @@ efi_m_debug_info_table_header =3D {
>   	NULL
>   };
>  =20
> +static u32 efi_m_max_table_entries;
> +
> +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))
> +
>   const efi_guid_t efi_debug_image_info_table_guid =3D
>   	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
>  =20
> @@ -4095,3 +4106,128 @@ efi_status_t efi_initialize_system_table_pointer=
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
> +	if (table[index].normal_image) {
> +		/* Update the entry. */
> +		table[index].normal_image->image_info_type =3D image_info_type;
> +		table[index].normal_image->loaded_image_protocol_instance =3D
> +			loaded_image;
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

It seems that you just copied the logic from EDK II instead of=20
programming according to the UEFI specification.

I cannot see that the UEFI specification allows NULL pointers inside the=
=20
array.

> +
> +			/* Decrease the number of EFI_DEBUG_IMAGE_INFO
> +			 * elements and set the efi_m_debug_info_table_header
> +			 * in modified status.
> +			 */
> +			efi_m_debug_info_table_header.table_size--;

According to the UEFI specification the table_size must match the array=20
size and not the number of non-NULL elements. If there is a NULL pointer=
=20
in the middle of the table and you decrease the table_size value, the=20
last non-NULL element is not accessible anymore.

A correct implementation would move all elements after the deleted one=20
one slot to the front.

Best regards

Heinrich

> +			efi_m_debug_info_table_header.update_status |=3D
> +				EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +			break;
> +		}
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +}

