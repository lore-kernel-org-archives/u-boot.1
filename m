Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E916C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 21:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B705681760;
	Mon, 16 Jun 2025 23:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AIGPL6Oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEAF82B18; Mon, 16 Jun 2025 23:53:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299B88006D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750110821; x=1750715621; i=xypron.glpk@gmx.de;
 bh=hzACoqUzgzh8XBwoGyk0OWskmwWqqH+J46wdfqmDHnY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AIGPL6Oaj3LMbfOgu2SbkTchqEVSUfHNTcHifDc1Gq5mgWU/PvDPqlrYHSHX4UL+
 BhKBL6xAc2jHnADwFYXgtKC+6u1wGl7mP5irNRY8kEFEylrcOgKsFR2hId0geMmZl
 J6XwSkWw5jIsTgNAJauiv1ufVufX1AWY8+o6VUQ28lhGNwYrbeQT3K7Vdj3/OMRfT
 GBxRES58PQyL8Q4RSQ1t4PLPHh9FcxjqkvFr+iz6IkMg5FZdwiJgCyOpPleo4PFJJ
 amiB6HN3hZ74B/GaKisvQOJBLLXSnmFpf07l34zNJ/9jKsyu/LDh5iyU9hafkcDBj
 tyUR3FL+/YU/JgJO8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.42]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1ufDtP2zj9-016drC; Mon, 16
 Jun 2025 23:53:40 +0200
Message-ID: <f126efa4-8d21-4358-bf69-45714142daa8@gmx.de>
Date: Mon, 16 Jun 2025 23:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: eficonfig: add support for URI device path based
 boot options
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250616102338.1269541-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250616102338.1269541-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4oTlWP7hPrKo1zLtP1cmvssM4FPJ7uJley3lJdLiQqeyerHmc0T
 ceGCmIaGo7bJC4sW2hKqTngmKenwchNUpsFH9p1bRqDrMqnfBejBZ6y38+ntJFwb9pDXZX1
 H9YCqdIC1lVFHSmcCNv9iEDbibaxKNSq847Ed7jE0mGJywqOjJEZ+xoWoGIZqwYbtc71Whp
 fZGdC+fl0VcYtTfWiWeBg==
UI-OutboundReport: notjunk:1;M01:P0:5TA1vpHA8D4=;4CBgSJsbmDXMn9zXZvq1x6jER8r
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

On 6/16/25 12:23, Sughosh Ganu wrote:
> The eficonfig command provides a menu based interface for maintenance
> of the EFI boot options. Add support for adding a URI based boot
> option. This boot option can then be used for HTTP boot.

With your patch when I try to add a boot option I was surprised to see=20
this menu:

   ** Add Boot Option **

       Description:
       File:
       Initrd File:
       Fdt File:
       Optional Data:
       Uri:
       Save
       Quit

My expectation is that I can define a URL each for

* binary
* initrd
* fdt

It should be possible to choose a network device in this menu instead:

   ** Select Volume **

       nvme 0:1
       nvme 0:2
       mmc 0:1
       mmc 0:2
       Quit

>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>=20
> Note: I had explored adding a corresponding test for this change. But
> looks like the eficonfig command itself is not being tested since
> commit 952018117ab4 ("dm: sandbox: Switch over to using the new host
> uclass"). This needs to be taken up separately as to why the eficonfig
> test has been bypassed, before adding stuff to the test.
>=20
>=20
>   cmd/eficonfig.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 87 insertions(+), 3 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 6e14d34a6bd..f69902b76f7 100644
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
> @@ -57,6 +58,7 @@ struct eficonfig_filepath_info {
>    * @boot_index:		index of the boot option
>    * @description:	pointer to the description string
>    * @optional_data:	pointer to the optional_data
> + * @uri:		URI for HTTP Boot
>    * @edit_completed:	flag indicates edit complete
>    */
>   struct eficonfig_boot_option {
> @@ -66,6 +68,7 @@ struct eficonfig_boot_option {
>   	unsigned int boot_index;
>   	u16 *description;
>   	u16 *optional_data;
> +	u16 *uri;
>   	bool edit_completed;
>   };
>  =20
> @@ -538,6 +541,31 @@ struct efi_device_path *eficonfig_create_device_pat=
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

The code in this function seems not to guarantee valid URLs. E.g. you=20
don't check that the schema is http:// or https://.

Please, provide unit tests for the URL validation.

The UEFI spec refers to RFC 3986 for the allowable content of a Uri()=20
device-path.

See also https://url.spec.whatwg.org/#valid-url-string

The Chinese URL https://www.hk01.com/zone/1/=E6=B8=AF=E8=81=9E should be e=
ncoded as=20
https://www.hk01.com/zone/1/%E6%B8%AF%E8%81%9E.

The following steps are required:

1) convert to UTF-8
2) encode bytes in URL fragements using hex encoding as needed.

See https://url.spec.whatwg.org/#url-fragment-string

Please, implement unit tests for URL encoding.

Best regards

Heinrich

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
> @@ -983,6 +1011,22 @@ static efi_status_t eficonfig_boot_add_optional_da=
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
> +	struct eficonfig_boot_option *bo =3D data;
> +
> +	return handle_user_input(bo->uri, EFICONFIG_URI_MAX, 24,
> +				 "\n  ** Edit URI **\n"
> +				 "\n"
> +				 "  enter HTTP Boot URI:");
> +}
> +
>   /**
>    * eficonfig_boot_edit_save() - handler to save the boot option
>    *
> @@ -998,7 +1042,8 @@ static efi_status_t eficonfig_boot_edit_save(void *=
data)
>   		bo->edit_completed =3D false;
>   		return EFI_NOT_READY;
>   	}
> -	if (u16_strlen(bo->file_info.current_path) =3D=3D 0) {
> +	if (u16_strlen(bo->file_info.current_path) =3D=3D 0 &&
> +	    u16_strlen(bo->uri) =3D=3D 0) {
>   		eficonfig_print_msg("File is not selected!");
>   		bo->edit_completed =3D false;
>   		return EFI_NOT_READY;
> @@ -1318,6 +1363,11 @@ static efi_status_t eficonfig_show_boot_option(st=
ruct eficonfig_boot_option *bo,
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	ret =3D create_boot_option_entry(efi_menu, "Uri: ", bo->uri,
> +				       eficonfig_boot_add_uri, bo);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
>   	ret =3D create_boot_option_entry(efi_menu, "Save", NULL,
>   				       eficonfig_boot_edit_save, bo);
>   	if (ret !=3D EFI_SUCCESS)
> @@ -1340,6 +1390,22 @@ out:
>   	return ret;
>   }
>  =20
> +static bool eficonfig_fp_uri(struct efi_device_path *dp)
> +{
> +	return dp->type =3D=3D DEVICE_PATH_TYPE_MESSAGING_DEVICE &&
> +		dp->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> +}
> +
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
> @@ -1392,10 +1458,13 @@ static efi_status_t eficonfig_edit_boot_option(u=
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
> @@ -1464,6 +1533,12 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>   		goto out;
>   	}
>  =20
> +	bo->uri =3D calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
> +	if (!bo->uri) {
> +		ret =3D  EFI_OUT_OF_RESOURCES;
> +		goto out;
> +	}
> +
>   	/* copy the preset value */
>   	if (load_option) {
>   		ret =3D efi_deserialize_load_option(&lo, load_option, &size);
> @@ -1481,7 +1556,9 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   		u16_strcpy(bo->description, lo.label);
>  =20
>   		/* EFI image file path is a first instance */
> -		if (lo.file_path)
> +		if (lo.file_path && eficonfig_fp_uri(lo.file_path))
> +			fill_dp_uri(lo.file_path, &bo->uri);
> +		else
>   			fill_file_info(lo.file_path, &bo->file_info, device_dp);
>  =20
>   		/* Initrd file path (optional) is placed at second instance. */
> @@ -1512,6 +1589,9 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   			goto out;
>   	}
>  =20
> +	if (utf16_utf8_strlen(bo->uri))
> +		uri_dp =3D eficonfig_create_uri_device_path(bo->uri);
> +
>   	if (bo->initrd_info.dp_volume) {
>   		dp =3D eficonfig_create_device_path(bo->initrd_info.dp_volume,
>   						 bo->initrd_info.current_path);
> @@ -1536,7 +1616,10 @@ static efi_status_t eficonfig_edit_boot_option(u1=
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
> @@ -1558,6 +1641,7 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>   	ret =3D eficonfig_set_boot_option(varname, dp, dp_size, bo->descripti=
on, tmp);
>   out:
>   	free(tmp);
> +	free(bo->uri);
>   	free(bo->optional_data);
>   	free(bo->description);
>   	free(bo->file_info.current_path);

