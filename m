Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15416C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF6282B34;
	Sat, 28 Jun 2025 23:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZpXez/W5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FA282DA1; Sat, 28 Jun 2025 23:09:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C608277D
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751144942; x=1751749742; i=xypron.glpk@gmx.de;
 bh=e77hhl4OpHqhapm6PdpJnjGf+eSNt7ABJaOzMlrXXFI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZpXez/W5K8LGV1XpR0JnHyx9Qrp4aqirAgN1E7NqWeqgONE6bCngIImW+2NlKwUx
 15PabKm1pIL8PN2RfJ2DusINXKF232FFOa9IUaNrm2o27DOGDxUIhQR9gmy2N1T1x
 EP7i8l+sicq9JORxf/FlEtKdZfajqniS0uixZhTKDdq8dtIalROKM+qFX29Qrcam4
 YjRD0AfCs/eC7rNIF+xk1dowaNC0xQo9foOr4IlDa7zuvboVK5y/mSEfobMQOAV5h
 y3NaO/Tc6K2Z7lxnKLn0rgMLqPtSLsEX+JQalNTJ/acRw8mYh01iUzf1r/XBrhMCc
 +O0KUvQfwVuLjUYmqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.106.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1ugiYA1TUu-010IuZ; Sat, 28
 Jun 2025 23:09:02 +0200
Message-ID: <1c832517-d8a7-4da3-899d-00d04bda2588@gmx.de>
Date: Sat, 28 Jun 2025 23:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <20250627112509.264221-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250627112509.264221-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8ORwAXp4QYdLrWEFYRt21Ngiv2aOjwBGnj56mkmdrD9ht7i6o4
 ygQHcC/m3MSCpFTbMxg9AFwTKcS0TGp8YVBXtKHjN/2MztQqC2Yqh5BFM/YyTIMpnsTKfhf
 337yk4K0zlGV8ZdtoP6ePVnOlTQSXuO+Mi8pmlp67qOPVi4z28tuJDw+bzpq4VMEw0gl9ri
 47CKqp2Jgub9WQYgl9N8g==
UI-OutboundReport: notjunk:1;M01:P0:d4sJXzssytw=;fh9RGcsyOZY80fPSPDD8NSsHjFh
 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
 atoAWRCD2ofXMChdIAGfOFs=
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

On 27.06.25 13:25, Sughosh Ganu wrote:
> The eficonfig command provides a menu based interface for maintenance
> of the EFI boot options. Add support for adding a URI based boot
> option. This boot option can then be used for HTTP boot.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviwwed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes since V2:
> * Added comments for eficonfig_create_uri_device_path()
> * Added comments for fill_dp_uri()
> * Remove some superfluous newlines added
>=20
>   cmd/eficonfig.c      | 131 ++++++++++++++++++++++++++++++++++++++++---
>   include/efi_config.h |   4 ++
>   2 files changed, 127 insertions(+), 8 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 6e14d34a6bd..602d31dca2d 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -35,6 +35,7 @@ static int avail_row;
>  =20
>   #define EFICONFIG_DESCRIPTION_MAX 32
>   #define EFICONFIG_OPTIONAL_DATA_MAX 64
> +#define EFICONFIG_URI_MAX 512
>   #define EFICONFIG_MENU_HEADER_ROW_NUM 3
>   #define EFICONFIG_MENU_DESC_ROW_NUM 5
>  =20
> @@ -538,6 +539,40 @@ struct efi_device_path *eficonfig_create_device_pat=
h(struct efi_device_path *dp_
>   	return dp;
>   }
>  =20
> +/**
> + * eficonfig_create_uri_device_path() - Create an URI based device path
> + * @uri_str:	URI string to be added to the device path
> + *
> + * Take the u16 string, convert it to a u8 string, and create a URI
> + * device path. This will be used for the EFI HTTP boot.
> + *
> + * Return: pointer to the URI device path on success, NULL on failure
> + */
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
> @@ -983,6 +1018,22 @@ static efi_status_t eficonfig_boot_add_optional_da=
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
> @@ -998,7 +1049,8 @@ static efi_status_t eficonfig_boot_edit_save(void *=
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
> @@ -1027,6 +1079,13 @@ efi_status_t eficonfig_process_clear_file_selecti=
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
> @@ -1042,16 +1101,30 @@ static struct eficonfig_item select_file_menu_it=
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
>  =20
> -	select_file_menu_items[0].data =3D data;
> -	select_file_menu_items[1].data =3D data;
> -	efi_menu =3D eficonfig_create_fixed_menu(select_file_menu_items,
> -					       ARRAY_SIZE(select_file_menu_items));
> +	menu_count =3D file_info->boot_file_option ?
> +		ARRAY_SIZE(select_boot_file_menu_items) :
> +		ARRAY_SIZE(select_file_menu_items);
> +
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
> @@ -1340,6 +1413,27 @@ out:
>   	return ret;
>   }
>  =20
> +/**
> + * fill_dp_uri() - copy the URI string in the device path
> + * @dp:		pointer to the URI device path
> + * @uri_str:	URI string to be copied
> + *
> + * Copy the passed URI string to the URI device path. This
> + * requires utf8_utf16_strcpy() to copy the u16 string to
> + * the u8 array in the device path structure.
> + *
> + * Return: None
> + */
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
> @@ -1392,10 +1486,13 @@ static efi_status_t eficonfig_edit_boot_option(u=
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
> @@ -1464,6 +1561,14 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>   		goto out;
>   	}
>  =20
> +	bo->file_info.uri =3D calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
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
> @@ -1481,7 +1586,10 @@ static efi_status_t eficonfig_edit_boot_option(u1=
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
> @@ -1512,6 +1620,9 @@ static efi_status_t eficonfig_edit_boot_option(u16=
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
> @@ -1536,7 +1647,10 @@ static efi_status_t eficonfig_edit_boot_option(u1=
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
> @@ -1560,6 +1674,7 @@ out:
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

