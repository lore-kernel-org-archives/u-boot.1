Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5CEC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEF587A7B;
	Wed, 10 Jan 2024 14:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rLWRcLRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C418F878A5; Wed, 10 Jan 2024 14:53:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E7F87AA9
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 14:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704894821; x=1705499621; i=xypron.glpk@gmx.de;
 bh=IpPs8/lJYCWi7Oa5C/Zs8EwJVG2j6ZowNxdGpUqF+cU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=rLWRcLRtR+QlJrjRisZ+A1y1fQUX7jyF6RBJvotdCqEaIagHAo7F13vzIhIfXKJ4
 BVkBkQR1IaEwT/6DCUAIWciMe04SIP4AlJ1Bb2wGBRhGP37fGPBMfQffq07a50yIe
 wHx87JH75PHIkArvdiS7EIx1egJVRh99Utod6gaGkHqnznqmznikkaGpB3Fi4Zb7j
 vBn476xSbnwldne+5TXdyp9MLZTuT+Wc12IM8XNV+C8qBgsdG6JbGvagHVNMh9Z7i
 hX3vYrU5DOfugFoK+4kiTu5BgpGDpnbkaSu0f3UpXW1NSGBLIvM2LYNTalF4OZ4Bn
 SDabqRenJMk8rJEPwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1qiTeE3NHr-00ffRt; Wed, 10
 Jan 2024 14:53:41 +0100
Message-ID: <0b827e9d-6646-40cb-9944-9d3c7bb40827@gmx.de>
Date: Wed, 10 Jan 2024 14:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi_loader: auto-generate boot option for each
 blkio device
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
 <20231226062820.722358-2-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231226062820.722358-2-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:um2uSaK6VzwGiDn6CozfE9tDV/enyPI5vk1vVGj1wvEQbkqR76M
 MegtPVrrybS0tdjm1qiqvQmTGLSLmf8tVgZ+4hnPth45LORiyMeD0ceoXSScz9vTYrGzsZw
 LmDeEFBSQ5tC7Knj8COakqsblpORGJHRrRRPJdZMFurO323lqlj+2aYh9hiXtML6Pv4nz6x
 QITMc8yj7XAoCgCT8kQnw==
UI-OutboundReport: notjunk:1;M01:P0:IiNKCrRCCc4=;oNidxCmzXNAEIxRRNRURmRaZRe+
 hUY3Gvv4kJfd7CPs49ExIcotNO6UUfFPs9GuhqqPs4ExHtLziTCWksCfOlPusUBIOLw2LE/rg
 2qqoMLqd+3tbbqDOOr/K+eZ6amRB+iLieJ/gybh5S/pNa96BdkgzZFqZP45laRCyBTkiZc32u
 Ols68PbLvlaocc0vAK6pTWTrIfFGH0S69H1QW+vy2ZA2RfpPE07aNL25D4mQj0bTg/u0kmDcx
 p/p7/jGNLKtkMTBMOBXrQfLCTof6xwxdZpujkfcLNElwg8M0Rgsbcg6JzAcsorW15NwGRuAC/
 vh2bF+P1oI7urjn5MuPV3rHBLRnJcbyonTER+1jb64VrlwSU2zpyQZNacwYAiMm6UM2878sV9
 shETcGBcAnZc1DihUdp5GJQcm5jUs08f9OmB2raZmdAS3pO1PicOggqwDF3Qa2QpA/KYLR4jr
 SbIldYVvm2dp2LAh8eBOttrtrhLugh+zckXjrqscIXvquMNpzNTekOT8A5ff6SZlyTrrcIGhj
 SyXKrONRDKWhKAPlT+oLhOYIy6qus9sBVaJOm+pBbKRETm8lbIMs7C+dAs4kbQsvrdD52PoVa
 S69I+hGK1Z9D/0TYkw7yMh5cE/CpF3aPV8Orh0I2V4jSAvyjmVmazWbVzyE0tBB4pve3awYbx
 nqCVeZEgCNw0lSMjt5edqAiG3vpYEP/j2nfhlSMsdUd0WADmk5URWF1ffSzARQ+7q/SNwZSWU
 JGGCKriLUBlTT1uCHYzsFQde8rnljsflxyfKckF5/BlZlZbdmjG62jg2EKSPBfxLon217D9jB
 tw5bVbGUvOoV+/3uLqAz48HOtkaOPB+OqOZ9vVzBfJ2PeBT0+06pakgkzglYHwGJoxkhS1mIS
 nnhSUcJI2clgwjmt3DonGNpqlMgaHv+uelx7ZXat0Kg3eGazQmk3UkYt2DOm/7b//5P6Rnqjt
 JUznhrDxHoAP4FJdI4sipacn0Ac=
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

On 26.12.23 07:28, Masahisa Kojima wrote:
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
> index 56d97f2382..747f75ee82 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -560,6 +560,50 @@ err:
>   	return ret;
>   }
>
> +/**
> + * try_load_from_media() - load file from media
> + *
> + * @file_path:	file path
> + * @handle:	pointer to handle for newly installed image

Please, use the same description as in try_load_entry():

     on return handle for the newly installed image

> + *
> + * If @file_path contains a file name, load the file.
> + * If @file_path does not have a file name, search the architecture-spe=
cific
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

%s/handle/handle_img/

or h_img

> +{
> +	efi_handle_t h;

%s/h/handle_blkdev/

or h_blkdev


> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_device_path *rem, *dp =3D NULL;
> +	struct efi_device_path *final_dp =3D file_path;
> +
> +	h =3D efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
> +	if (h) {
> +		if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
> +			/* no file name present, try default file */
> +			ret =3D check_disk_has_default_file(h->dev, &dp);

check_disk_has_default_file() does not only check for a default file
path , i.e. EFI/BOOT/BOO<ARCH>.EFI, but will check for a given file
path, if provided. In a later patch we should rename this function to
something less misleading.

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

%s/efi_bootmgr_enumerate_boot_option/efi_bootmgr_enumerate_boot_options/

>    *
>    * @opt:		pointer to the media boot option structure
> - * @volume_handles:	pointer to the efi handles
> + * @handles:		pointer to the efi handles

%s/efi/EFI/

"pointer to the efi handles" could be handles for anything.

%s/pointer to the efi handles/pointer to block device handles/

We should move the call to LocateBufferHandle into this function as the
caller does not use handles.


>    * @count:		number of efi handle

On entry number of handles to block devices.
On exit number of boot options.

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

This is the call that should be moved to
efi_bootmgr_enumerate_boot_options().

>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> @@ -1073,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_=
option(void)
>   		goto out;
>   	}
>
> -	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> -	ret =3D gg(opt, volume_handles, count);
> +	ret =3D efi_bootmgr_enumerate_boot_option(opt, handles, &count);

%s/, handles//

>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> @@ -1122,7 +1170,7 @@ out:
>   			free(opt[i].lo);
>   	}
>   	free(opt);
> -	efi_free_pool(volume_handles);
> +	efi_free_pool(handles);

To be moved to efi_bootmgr_enumerate_boot_options().

Best regards

Heinrich

>
>   	if (ret =3D=3D EFI_NOT_FOUND)
>   		return EFI_SUCCESS;

