Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D4C7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850A182AA4;
	Thu, 26 Jun 2025 10:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KQZ3+7lN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9427F82C4C; Thu, 26 Jun 2025 10:22:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B878006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750926131; x=1751530931; i=xypron.glpk@gmx.de;
 bh=uS+rvoLtkkRGzxIkPkpJoRUdBM2MTwSRvuKS1ALPtCM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KQZ3+7lNUGmfzxAQgnp2GO5CI6vRLckrmvZ2KSvtqsOwhxJxc0OIadkxR0Gukv3q
 8U+7Ln87wLN65udirtsjQDYVb2IyRt17sS+YFOMVbheISUfTWvI5lFNcnIPLrHXMI
 8JuBm/1i7DHJWe/8D1Ozi9jfYvUBGp5UqeDEUTtceUUZXgGP9ytu8zE1lBgW4tnzA
 i/FMQVid5sUJ4E+MTs5vmTd69ziSkAEMJej9t1bkj4dOdZ3PxxPxGESX7i+/JDsZz
 01qHbITfYpoqlzCoUl9v7JDyhyIkrXK6v37/l4DrabIERC0opNtkOfzK6ynEZMqSW
 7gy9zuH1Kwqai5cfsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1v3lZb3HHt-00cD8A; Thu, 26
 Jun 2025 10:22:10 +0200
Message-ID: <713c7bf0-25d9-43fc-9e98-486947fd58fb@gmx.de>
Date: Thu, 26 Jun 2025 10:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
 <20250624120730.2158194-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250624120730.2158194-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iNFWsF881cC5scFP0Z/rvwxGqvf10EYXayyTbOJj186Jw6pBRG+
 1upReyQwW+9+x+/Nw9lHhBHFY6QwD4UmCi6ao77wVe0H6f3DK8A1x/ZvmQcaVUgNABrysuq
 2bXGYbJdXlIZaJVQMmriYi90JWhfUmC5iDBzteBtUGh6/uwzqxkABj33gctoWZgdu3zScwW
 DCR5jDJWIYBR8ELtyjVjw==
UI-OutboundReport: notjunk:1;M01:P0:H2vmwrv24VM=;jjjVn1kXQHW/zPXk4nLBf0zXCmr
 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
 7WsbCU5E2rOSu0ae51RVa0o=
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

On 24.06.25 14:07, Sughosh Ganu wrote:
> The eficonfig command provides a menu based interface for maintenance
> of the EFI boot options. Add support for adding a URI based boot
> option. This boot option can then be used for HTTP boot.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Move the option for entering the URI under the boot file.
> * All corresponding changes needed for the above change.
>=20
>   cmd/eficonfig.c      | 113 ++++++++++++++++++++++++++++++++++++++++---
>   include/efi_config.h |   4 ++
>   2 files changed, 109 insertions(+), 8 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 6e14d34a6bd..917d79b8023 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -35,6 +35,7 @@ static int avail_row;
>  =20
>   #define EFICONFIG_DESCRIPTION_MAX 32
>   #define EFICONFIG_OPTIONAL_DATA_MAX 64
> +#define EFICONFIG_URI_MAX 512

I am not aware of as standard setting a limit on URI sizes.

https://www.rfc-editor.org/rfc/rfc9110#section-4.1-5 has this=20
recommendation:

It is RECOMMENDED that all senders and recipients support, at a minimum,=
=20
URIs with lengths of 8000 octets in protocol elements.

We should determine the length of the URI when the user makes his input.

>   #define EFICONFIG_MENU_HEADER_ROW_NUM 3
>   #define EFICONFIG_MENU_DESC_ROW_NUM 5
>  =20
> @@ -538,6 +539,31 @@ struct efi_device_path *eficonfig_create_device_pat=
h(struct efi_device_path *dp_
>   	return dp;
>   }
>  =20
> +static struct efi_device_path *eficonfig_create_uri_device_path(u16 *ur=
i_str)
> +{
> +	char *pos, *p;
> +	u32 len =3D 0;
> +	efi_uintn_t uridp_len;
> +	struct efi_device_path_uri *uridp;
> +
> +	len =3D utf16_utf8_strlen(uri_str);
> +
> +	uridp_len =3D sizeof(struct efi_device_path) + len + 1;
> +	uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
> +	if (!uridp)
> +		return NULL;
> +
> +	uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +	uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> +	uridp->dp.length =3D uridp_len;
> +	p =3D (char *)&uridp->uri;
> +	utf16_utf8_strcpy(&p, uri_str);
> +	pos =3D (char *)uridp + uridp_len;
> +	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
> +
> +	return &uridp->dp;
> +}
> +
>   /**
>    * eficonfig_file_selected() - handler of file selection
>    *
> @@ -983,6 +1009,22 @@ static efi_status_t eficonfig_boot_add_optional_da=
ta(void *data)
>   				 "  enter optional data:");
>   }
>  =20
> +/**
> + * eficonfig_boot_add_uri() - handle user input for HTTP Boot URI
> + *
> + * @data:	pointer to the internal boot option structure
> + * Return:	status code
> + */
> +static efi_status_t eficonfig_boot_add_uri(void *data)
> +{
> +	struct eficonfig_select_file_info *file_info =3D data;
> +
> +	return handle_user_input(file_info->uri, EFICONFIG_URI_MAX, 24,
> +				 "\n  ** Edit URI **\n"
> +				 "\n"
> +				 "  enter HTTP Boot URI:");
> +}
> +
>   /**
>    * eficonfig_boot_edit_save() - handler to save the boot option
>    *
> @@ -998,7 +1040,8 @@ static efi_status_t eficonfig_boot_edit_save(void *=
data)
>   		bo->edit_completed =3D false;
>   		return EFI_NOT_READY;
>   	}
> -	if (u16_strlen(bo->file_info.current_path) =3D=3D 0) {
> +	if (u16_strlen(bo->file_info.current_path) =3D=3D 0 &&
> +	    u16_strlen(bo->file_info.uri) =3D=3D 0) {
>   		eficonfig_print_msg("File is not selected!");
>   		bo->edit_completed =3D false;
>   		return EFI_NOT_READY;
> @@ -1027,6 +1070,13 @@ efi_status_t eficonfig_process_clear_file_selecti=
on(void *data)
>   	return EFI_ABORTED;
>   }
>  =20
> +static struct eficonfig_item select_boot_file_menu_items[] =3D {
> +	{"Select File", eficonfig_process_select_file},
> +	{"Enter URI", eficonfig_boot_add_uri},
> +	{"Clear", eficonfig_process_clear_file_selection},
> +	{"Quit", eficonfig_process_quit},
> +};
> +
>   static struct eficonfig_item select_file_menu_items[] =3D {
>   	{"Select File", eficonfig_process_select_file},
>   	{"Clear", eficonfig_process_clear_file_selection},
> @@ -1042,20 +1092,35 @@ static struct eficonfig_item select_file_menu_it=
ems[] =3D {
>   efi_status_t eficonfig_process_show_file_option(void *data)
>   {
>   	efi_status_t ret;
> +	unsigned int menu_count;
>   	struct efimenu *efi_menu;
> +	struct eficonfig_item *menu_items;
> +	struct eficonfig_select_file_info *file_info =3D data;
> +
> +	menu_items =3D file_info->boot_file_option ? select_boot_file_menu_ite=
ms :
> +		select_file_menu_items;
> +
> +	menu_count =3D file_info->boot_file_option ?
> +		ARRAY_SIZE(select_boot_file_menu_items) :
> +		ARRAY_SIZE(select_file_menu_items);
>  =20
> -	select_file_menu_items[0].data =3D data;
> -	select_file_menu_items[1].data =3D data;
> -	efi_menu =3D eficonfig_create_fixed_menu(select_file_menu_items,
> -					       ARRAY_SIZE(select_file_menu_items));
> +	menu_items[0].data =3D data;
> +	menu_items[1].data =3D data;
> +	menu_items[2].data =3D data;
> +
> +	efi_menu =3D eficonfig_create_fixed_menu(menu_items, menu_count);
>   	if (!efi_menu)
>   		return EFI_OUT_OF_RESOURCES;
>  =20
> -	ret =3D eficonfig_process_common(efi_menu, "  ** Update File **",
> +	ret =3D eficonfig_process_common(efi_menu,
> +				       file_info->boot_file_option ?
> +				       "  ** Update File/URI **" :
> +				       "  ** Update File **",
>   				       eficonfig_menu_desc,
>   				       eficonfig_display_statusline,
>   				       eficonfig_print_entry,
>   				       eficonfig_choice_entry);
> +
>   	if (ret !=3D EFI_SUCCESS) /* User selects "Clear" or "Quit" */
>   		ret =3D EFI_NOT_READY;
>  =20
> @@ -1268,6 +1333,7 @@ static efi_status_t prepare_file_selection_entry(s=
truct efimenu *efi_menu, char
>   	u16_strlcat(file_name, file_info->current_path, len);
>   	ret =3D create_boot_option_entry(efi_menu, title, file_name,
>   				       eficonfig_process_show_file_option, file_info);
> +
>   out:
>   	free(devname);
>   	free(file_name);
> @@ -1340,6 +1406,16 @@ out:
>   	return ret;
>   }
>  =20

Please, document all functions according to
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

> +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> +{
> +	u16 *p =3D *uri_str;
> +	struct efi_device_path_uri *uridp;
> +
> +	uridp =3D (struct efi_device_path_uri *)dp;
> +
> +	utf8_utf16_strcpy(&p, uridp->uri);
> +}
> +
>   /**
>    * fill_file_info() - fill the file info from efi_device_path structur=
e
>    *
> @@ -1392,10 +1468,13 @@ static efi_status_t eficonfig_edit_boot_option(u=
16 *varname, struct eficonfig_bo
>   	size_t len;
>   	efi_status_t ret;
>   	char *tmp =3D NULL, *p;
> +	u16 *current_path =3D NULL;
>   	struct efi_load_option lo =3D {0};
>   	efi_uintn_t dp_size;
>   	struct efi_device_path *dp =3D NULL;
>   	efi_uintn_t size =3D load_option_size;
> +	struct efi_device_path *dp_volume =3D NULL;
> +	struct efi_device_path *uri_dp =3D NULL;
>   	struct efi_device_path *device_dp =3D NULL;
>   	struct efi_device_path *initrd_dp =3D NULL;
>   	struct efi_device_path *fdt_dp =3D NULL;
> @@ -1464,6 +1543,14 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>   		goto out;
>   	}
>  =20
> +	bo->file_info.uri =3D calloc(1, EFICONFIG_URI_MAX * sizeof(u16));

Where is the matching free()?

Best regards

Heinrich

> +	if (!bo->file_info.uri) {
> +		ret =3D  EFI_OUT_OF_RESOURCES;
> +		goto out;
> +	}
> +
> +	bo->file_info.boot_file_option =3D true;
> +
>   	/* copy the preset value */
>   	if (load_option) {
>   		ret =3D efi_deserialize_load_option(&lo, load_option, &size);
> @@ -1481,7 +1568,10 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>   		u16_strcpy(bo->description, lo.label);
>  =20
>   		/* EFI image file path is a first instance */
> -		if (lo.file_path)
> +		if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE,
> +						MSG_URI))
> +			fill_dp_uri(lo.file_path, &bo->file_info.uri);
> +		else
>   			fill_file_info(lo.file_path, &bo->file_info, device_dp);
>  =20
>   		/* Initrd file path (optional) is placed at second instance. */
> @@ -1512,6 +1602,9 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   			goto out;
>   	}
>  =20
> +	if (utf16_utf8_strlen(bo->file_info.uri))
> +		uri_dp =3D eficonfig_create_uri_device_path(bo->file_info.uri);
> +
>   	if (bo->initrd_info.dp_volume) {
>   		dp =3D eficonfig_create_device_path(bo->initrd_info.dp_volume,
>   						 bo->initrd_info.current_path);
> @@ -1536,7 +1629,10 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>   		efi_free_pool(dp);
>   	}
>  =20
> -	dp =3D eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_=
info.current_path);
> +	dp_volume =3D bo->file_info.dp_volume;
> +	current_path =3D bo->file_info.current_path;
> +	dp =3D uri_dp ?
> +		uri_dp : eficonfig_create_device_path(dp_volume, current_path);
>   	if (!dp) {
>   		ret =3D EFI_OUT_OF_RESOURCES;
>   		goto out;
> @@ -1560,6 +1656,7 @@ out:
>   	free(tmp);
>   	free(bo->optional_data);
>   	free(bo->description);
> +	free(bo->file_info.uri);
>   	free(bo->file_info.current_path);
>   	free(bo->initrd_info.current_path);
>   	free(bo->fdt_info.current_path);
> diff --git a/include/efi_config.h b/include/efi_config.h
> index d7c1601137e..4438933db6a 100644
> --- a/include/efi_config.h
> +++ b/include/efi_config.h
> @@ -82,15 +82,19 @@ struct eficonfig_item {
>    * @current_volume:	pointer to the efi_simple_file_system_protocol
>    * @dp_volume:		pointer to device path of the selected device
>    * @current_path:	pointer to the selected file path string
> + * @uri:		URI for HTTP Boot
>    * @filepath_list:	list_head structure for file path list
>    * @file_selectred:	flag indicates file selecting status
> + * @boot_file_option:	flag indicating if option is for boot file
>    */
>   struct eficonfig_select_file_info {
>   	struct efi_simple_file_system_protocol *current_volume;
>   	struct efi_device_path *dp_volume;
>   	u16 *current_path;
> +	u16 *uri;
>   	struct list_head filepath_list;
>   	bool file_selected;
> +	bool boot_file_option;
>   };
>  =20
>   void eficonfig_print_msg(char *msg);

