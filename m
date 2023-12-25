Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62103C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 11:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7584587692;
	Mon, 25 Dec 2023 12:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cJeTJ46Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2483F876A2; Mon, 25 Dec 2023 12:00:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A17A874F6
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 12:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703502012; x=1704106812; i=xypron.glpk@gmx.de;
 bh=wYLUlf/Z1USvVRIrJH/vd9rriUXWY+J1B52gH95gaF4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=cJeTJ46YkjYKsPX170P+Fn9YZbsQZkiLC5SApB7eAU3SeukCf9aGpnTFLFFEDdZy
 XNfNIPCdz355zlsoBjbdBR5HoeGdKQuGIj9SQ7uf3Bus95Lq8AiU0mJzbBrbTAHqP
 WcIj/tHAhSJqizyRvtXWTsVphHVJta4IrqdpNCIA2ndV4Wtd5aOiYnnAroHoVzJdf
 T02aHiqSzkBhG1voIz6Y8PNDZWnOfzIDDjXRY/I5Af2wT++kgXmf33N37Yc6GiE42
 KRtxV2RMWR5rPGxRUeUa9bEr5//270R96NsVQpXSatqa+WOvEKXX9jB3EIuLTQYuX
 3clZmSz8FL1YCXnmaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1r11Hl0LMT-00sLvq; Mon, 25
 Dec 2023 12:00:12 +0100
Message-ID: <d5be3c6d-b189-441d-847e-b78194c8a17a@gmx.de>
Date: Mon, 25 Dec 2023 12:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: auto-generate boot option for each blkio
 device
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231220084133.435240-1-masahisa.kojima@linaro.org>
 <20231220084133.435240-2-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231220084133.435240-2-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qN3ZxkdUfTV4GZDU/9qM+e7LNJYyBlvEZXqjpVpzHugYkgYufVx
 r9Pf1ut8Q+iquyULTsxzBgV+nkmoJkELSppibFV+CkjoeKtzN+GI+2AVxCkeiQdWJZ08nbg
 svFF3S65xKzSEXv7DMnUpHfyaAf+ZxQ2UUHIAtRW145n8xNhaXmqJgsQrrsZBXTSjWBVXcM
 8sjx/8+yQIrRwlDBsApAg==
UI-OutboundReport: notjunk:1;M01:P0:jRb/rxJuzFY=;Dkyc8wwTbp2NwGKepYk6gIdmjPV
 Fauy74sEs+a/dBGPwuGKgPa8kHNJ69WoA2Ok2rwU8HJaBDdz4b4+I9ezSMZ5SvxGv6B5ZHryH
 gtTwYRvkyQ8dCRXZ7xFztYvUCweQ+O+bnmjQzJ7dXieeSL6nxy6ej3BPTnxD/pDC8Z2wlHUZP
 j+S4sfiBPv6mPaTU2suQ7uB8dX3v0MDUBI9e+o7D+GFJVU9DvIEsxQWIWgJzxiVzh9qmFyICV
 PIpJqZA3RgVKTn701365YbaEvt7I83xBEFu6ix7uNW72AWGMrtW+BTyl6oCepvCc4mMw5Dnxf
 1EWlxbMQX33W3N+YxB7uGet2aDo0HDBiaJJv4XXbKtzW+/pyiy8TbLdeOETuhu0XQeJ6EC8nq
 sj4DeuZC/xGMGcqhMOnxmQDkxmVwuudWVn+KrB9BH8UbRrcx3h/zbESfGpY6Ao6A4zhuPIFTe
 UaBTLKumuZydUTFYMjoscjLgDIWqrjQl0GibdwBbjZx+WD3IUSLgl2dFrfxHdNg2Avw1tCBFu
 6Z9CJ8C1ID1QLrNgQJN+s3Cx/FJvoexCNk3pC3VAlVyql9UyeEBORe34ltmGevi9HmANAB3zT
 xHLB+VUQvAGklmXhX5Iy99R5pFukUZbX02cIyC6IOBdQUlmCWKrr21FlHDfuHBDk9682vekLF
 Uvwyz0gV21b9UExGvCqfiWxQ31xEg4WsptxmoalokVPl7wkLcJADN4Hh9e8pfRnaCaH5yRGC2
 LkV6+0UuRssWHK7uyvLZnoT2lEnDeqCq+/m5aa+Dc2WFzM4LlBQALGhy2+paHUZB4UJ35fOJ5
 dbxpE+HIu51yleasLCUeiNMthBFyC+P7PJUEVYSZ5l5S847ed6QR8KsizXZMYjGZ/h6LLELVn
 jJyvp6XskR0pxAoiQLgm7HrP82zjdd6tMxP8D2P0mEydTnEgStLm1OT4I7BsUllMdVEHP5lTm
 9wRWL6PEtSrQqYRF20xbxWnwAIo=
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

On 12/20/23 09:41, Masahisa Kojima wrote:
> Current efibootmgr auto-generates the boot option for all
> disks and partitions installing EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> while EDK II reference implementation auto-generates the boot option
> for all devices installing  EFI_BLOCK_IO_PROTOCOL with
> eliminating logical partitions.
>
> This commit modifies the efibootmgr to get aligned to EDK II.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 94 +++++++++++++++++++++++++++---------
>   1 file changed, 71 insertions(+), 23 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 56d97f2382..636f01e2eb 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -560,6 +560,50 @@ err:
>   	return ret;
>   }
>
> +/**
> + * try_load_from_media() - load file from media
> + *
> + * @fp:		file path
> + * @handle:	pointer to handle for newly installed image
> + *
> + * If @fp contains a file name, load the file.
> + * If @fp does not have a file name, search the architecture-specific
> + * default file and load it.
> + * TODO: If the FilePathList[0] device does not support
> + * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL but supports EFI_BLOCK_IO_PROTOCOL,
> + * call EFI_BOOT_SERVICES.ConnectController()
> + * TODO: FilePathList[0] device supports EFI_SIMPLE_FILE_SYSTEM_PROTOCO=
L
> + * not based on EFI_BLOCK_IO_PROTOCOL
> + *
> + * Return:	status code
> + */
> +static efi_status_t try_load_from_media(struct efi_device_path *file_pa=
th,
> +					efi_handle_t *handle)
> +{
> +	efi_handle_t h;
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_device_path *rem, *dp =3D NULL;
> +	struct efi_device_path *final_dp =3D file_path;
> +
> +	h =3D efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
> +	if (h) {
> +		if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
> +			/* no file name present, try default file */
> +			ret =3D check_disk_has_default_file(h->dev, &dp);
> +			if (ret !=3D EFI_SUCCESS)
> +				return ret;
> +
> +			final_dp =3D dp;
> +		}
> +	}
> +
> +	ret =3D EFI_CALL(efi_load_image(true, efi_root, final_dp, NULL, 0, han=
dle));
> +
> +	efi_free_pool(dp);
> +
> +	return ret;
> +}
> +
>   /**
>    * try_load_entry() - try to load image for boot option
>    *
> @@ -594,7 +638,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle=
_t *handle,
>   	}
>
>   	if (lo.attributes & LOAD_OPTION_ACTIVE) {
> -		struct efi_device_path *file_path;
>   		u32 attributes;
>
>   		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
> @@ -611,10 +654,7 @@ static efi_status_t try_load_entry(u16 n, efi_handl=
e_t *handle,
>   			else
>   				ret =3D EFI_LOAD_ERROR;

This line does not exist in efi/next. Am I missing a prerequisite patch?

Best regards

Heinrich

>   		} else {
> -			file_path =3D expand_media_path(lo.file_path);
> -			ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path,
> -						      NULL, 0, handle));
> -			efi_free_pool(file_path);
> +			ret =3D try_load_from_media(lo.file_path, handle);
>   		}
>   		if (ret !=3D EFI_SUCCESS) {
>   			log_warning("Loading %ls '%ls' failed\n",
> @@ -748,19 +788,19 @@ error:
>    * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootab=
le media
>    *
>    * @opt:		pointer to the media boot option structure
> - * @volume_handles:	pointer to the efi handles
> + * @handles:		pointer to the efi handles
>    * @count:		number of efi handle
>    * Return:		status code
>    */
>   static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig=
_media_boot_option *opt,
> -						      efi_handle_t *volume_handles,
> -						      efi_status_t count)
> +						      efi_handle_t *handles,
> +						      efi_uintn_t *count)
>   {
> -	u32 i;
> +	u32 i, num =3D 0;
>   	struct efi_handler *handler;
>   	efi_status_t ret =3D EFI_SUCCESS;
>
> -	for (i =3D 0; i < count; i++) {
> +	for (i =3D 0; i < *count; i++) {
>   		u16 *p;
>   		u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
>   		char *optional_data;
> @@ -768,8 +808,15 @@ static efi_status_t efi_bootmgr_enumerate_boot_opti=
on(struct eficonfig_media_boo
>   		char buf[BOOTMENU_DEVICE_NAME_MAX];
>   		struct efi_device_path *device_path;
>   		struct efi_device_path *short_dp;
> +		struct efi_block_io *blkio;
> +
> +		ret =3D efi_search_protocol(handles[i], &efi_block_io_guid, &handler)=
;
> +		blkio =3D handler->protocol_interface;
>
> -		ret =3D efi_search_protocol(volume_handles[i], &efi_guid_device_path,=
 &handler);
> +		if (blkio->media->logical_partition)
> +			continue;
> +
> +		ret =3D efi_search_protocol(handles[i], &efi_guid_device_path, &handl=
er);
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
>   		ret =3D efi_protocol_open(handler, (void **)&device_path,
> @@ -777,7 +824,7 @@ static efi_status_t efi_bootmgr_enumerate_boot_optio=
n(struct eficonfig_media_boo
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
>
> -		ret =3D efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEV=
ICE_NAME_MAX);
> +		ret =3D efi_disk_get_device_name(handles[i], buf, BOOTMENU_DEVICE_NAM=
E_MAX);
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
>
> @@ -801,17 +848,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_opt=
ion(struct eficonfig_media_boo
>   		 * to store guid, instead of realloc the load_option.
>   		 */
>   		lo.optional_data =3D "1234567";
> -		opt[i].size =3D efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
> -		if (!opt[i].size) {
> +		opt[num].size =3D efi_serialize_load_option(&lo, (u8 **)&opt[num].lo)=
;
> +		if (!opt[num].size) {
>   			ret =3D EFI_OUT_OF_RESOURCES;
>   			goto out;
>   		}
>   		/* set the guid */
> -		optional_data =3D (char *)opt[i].lo + (opt[i].size - u16_strsize(u"12=
34567"));
> +		optional_data =3D (char *)opt[num].lo + (opt[num].size - u16_strsize(=
u"1234567"));
>   		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_=
guid_t));
> +		num++;
>   	}
>
>   out:
> +	*count =3D num;
> +
>   	return ret;
>   }
>
> @@ -1040,8 +1090,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 bo=
ot_index)
>   /**
>    * efi_bootmgr_update_media_device_boot_option() - generate the media =
device boot option
>    *
> - * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYST=
EM_PROTOCOL
> - * and generate the bootmenu entries.
> + * This function enumerates all BlockIo devices and add the boot option=
 for it.
>    * This function also provide the BOOT#### variable maintenance for
>    * the media device entries.
>    * - Automatically create the BOOT#### variable for the newly detected=
 device,
> @@ -1057,13 +1106,13 @@ efi_status_t efi_bootmgr_update_media_device_boo=
t_option(void)
>   	u32 i;
>   	efi_status_t ret;
>   	efi_uintn_t count;
> -	efi_handle_t *volume_handles =3D NULL;
> +	efi_handle_t *handles =3D NULL;
>   	struct eficonfig_media_boot_option *opt =3D NULL;
>
>   	ret =3D efi_locate_handle_buffer_int(BY_PROTOCOL,
> -					   &efi_simple_file_system_protocol_guid,
> +					   &efi_block_io_guid,
>   					   NULL, &count,
> -					   (efi_handle_t **)&volume_handles);
> +					   (efi_handle_t **)&handles);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> @@ -1073,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_=
option(void)
>   		goto out;
>   	}
>
> -	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> -	ret =3D efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
> +	ret =3D efi_bootmgr_enumerate_boot_option(opt, handles, &count);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> @@ -1122,7 +1170,7 @@ out:
>   			free(opt[i].lo);
>   	}
>   	free(opt);
> -	efi_free_pool(volume_handles);
> +	efi_free_pool(handles);
>
>   	if (ret =3D=3D EFI_NOT_FOUND)
>   		return EFI_SUCCESS;

