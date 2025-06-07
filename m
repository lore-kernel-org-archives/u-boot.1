Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262DCC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4435E80E9A;
	Sat,  7 Jun 2025 11:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MXei67m1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E8E81F0D; Sat,  7 Jun 2025 11:33:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CC8807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749288785; x=1749893585; i=xypron.glpk@gmx.de;
 bh=S9aF4mRfXSVNgr10mVc8eVHPKi2domeB5/9VaVEmAvI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MXei67m1BSD7qtc1gMbzVrDTxN6NZ3tfTP4Vvarbz1e4nqyC/JLeI+xr9s+G/Pj1
 ejP7fOMaJ/fu0Ces6I/l0CvkrwLDeTRcm6RDWb/jRGEabH39Xsl37ehM9FZTOy3Ee
 u9Z60XahfBNcO2v8xhM5fErq8hJss8qO5S266jW9NYbefpDJZs+lZYwtQU/r3zYCE
 /CjGrm/L+8uPGMAZAvMTe0hm1avouJ/FvC5jI99Blk8YaPxJvl8d/ZaZgk7cWZQhd
 7UnJ0r5ZU+CUPj2asUj6ODjJp/9v6RnBXe0pqAjQ99EXknfWblOOVeiNRDFurlvEw
 cikttd4PoOwrXLdzsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.175.200]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1ueoNQ0YTt-013Drf; Sat, 07
 Jun 2025 11:33:05 +0200
Message-ID: <c23ef643-5505-4dc1-b105-fd4207e57e5f@gmx.de>
Date: Sat, 7 Jun 2025 11:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250529040520.3799600-1-paulliu@debian.org>
 <20250529040520.3799600-5-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250529040520.3799600-5-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SynRmmegvFF/+UCPHVdhcD9ST2Rl0ktFjDPBB0kDph+4PcT3+e/
 S0mGG0uoswQyRm3rXtJw6dcNtkjEnzEGxN9nxD5nq2ptkprz0H1oEB4MgEJ3n6Y5A8axRCD
 J+TARQSWiJN052vQ0V5K22RVJ7zu6tcuGy8YoUrtiZqxkNgNuO3CU40eYdoeGCIhbYisunP
 tr128qFaBfEyHF4prFTgA==
UI-OutboundReport: notjunk:1;M01:P0:+3/jnGPA5/A=;su5BohV37G1LDI0a9DmrIXKIVS7
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

On 5/29/25 06:05, Ying-Chun Liu (PaulLiu) wrote:
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
> ---
>   include/efi_api.h             |   2 +
>   include/efi_loader.h          |   5 ++
>   lib/efi_loader/efi_boottime.c | 137 ++++++++++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+)
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
> index 16e921781e9..ebd2dab6e41 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2129,6 +2129,14 @@ efi_status_t EFIAPI efi_load_image(bool boot_poli=
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
> @@ -4038,6 +4049,13 @@ efi_status_t efi_initialize_system_table(void)
>   	return ret;
>   }
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
>    * efi_initialize_system_table() - Initialize system table pointer
>    *
> @@ -4072,3 +4090,122 @@ efi_status_t efi_initialize_system_table_pointer=
(void)
>  =20
>   	return EFI_SUCCESS;
>   }
> +
> +/**

This is not a valid function description. See:
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Please, run `make htmldocs` for testing.

Best regards

Heinrich

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
> + * @return                 status code
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
> +	efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +			  sizeof(union efi_debug_image_info),
> +			  (void **)(&(*table)[index].normal_image));
> +	if ((*table)[index].normal_image) {
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
> +	}
> +
> +	efi_m_debug_info_table_header.update_status &=3D
> +		~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +	return EFI_SUCCESS;
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
> +			/* Found a match. Free up the table entry.
> +			 * Move the tail of the table one slot to the front.
> +			 */
> +			efi_free_pool(table[index].normal_image);
> +
> +			memcpy(&table[index],
> +			       &table[index + 1],
> +			       (efi_m_debug_info_table_header.table_size -
> +				index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);
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

