Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120A7C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 12:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0A28700D;
	Mon, 25 Dec 2023 13:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F6l2ej70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25406871CC; Mon, 25 Dec 2023 13:22:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5286FFE
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 13:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703506950; x=1704111750; i=xypron.glpk@gmx.de;
 bh=fs3kKag/cxXVT/cM9bgKyxux1OoyzE3x1WF+wq3+RvE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=F6l2ej700UOxqko5CMUG1xOMYecsB8EhmcjwMzdhFM/4ZOjEe7Cu47DZ8D+/ipDg
 HGMnwgUc190NDROCjGxVhFgyo5k9p2J/JcZeDUFSf5FFtRIaaGd9xsEFpr9+X091G
 AAhW+hRHK7XUozwYR3hbVqhphnRBE5jSQNMedWi4fWErxIQRT9SOBktUiwleI4U5Y
 8oL3NadRvLR3cjwVJ75+VheyQhHVwp54UvjM9QL4R0PszPt1nSwcIGhnPtHdtcg26
 ws4Zplg9uTmr8VV579KWsVM+NDK0eT+EeCwXYcI03wo2NsNw0CbWJ6HUL3GRV0U11
 d6/kTTT+sYmXKV+pNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1qly4A2RgK-00h4zP; Mon, 25
 Dec 2023 13:22:30 +0100
Message-ID: <0001a0b4-8104-4a15-9614-470c3108b379@gmx.de>
Date: Mon, 25 Dec 2023 13:22:30 +0100
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
X-Provags-ID: V03:K1:LoiOjYIgfBrkgIbFXI6Xt/6SIj1HQvPimwY5XgIGaZbBfTLb7Eh
 roNhtvk5vtjVqMJO/kTzo+rRnBL7DlcRTmvgMJqbBm/OLsQm+mlfn6eit0goE7cKompRWiu
 NgRmJ4C/icQUy+B+g0YvHx5FBJKlDJkXxCd9SLmwT+hHdnq8P5kzvPgdxD+uXPlCcfuAsSC
 LQxC3XQnliKwDaNZFVHEw==
UI-OutboundReport: notjunk:1;M01:P0:Tv4Pb6eRbJI=;/b7CKRgsYMpz5/E263vCwfCouBx
 Q+0knusec+Fh42sNpAMTxNHYo96qIO8QyP+LvNr9UZWZ7Zwqj7FMWZH+vhbwouLJXSg0rx7FR
 1Hmz/ODESF7tA/tad4vuzAxfdVDRdJHWHEAhnXokNFYHUGOClWL89rrm9rz2i9YgOc5tv1SvW
 y/oiqns2zj0m3IAR3a0Sq73+BgLD/m0lkmGtzGY75XcL2G26T5UBRlecJOuTjf4QoxSUva7LC
 mN7Bh4vKkA+UFuEBg6htLiba0Qdj+IyIu24qWkXpSiZRdPNnsL8ay2fx98nwmzi9f+geAviYn
 ZjFSRVyGy4+BS8e937Rb1igx84rnJ9BQ8HwIlwjLHwTCCqXc1DnESjxVEDNZR89WUOdTTZnvp
 vvcQ3nuLkX7WkG5d8f7XRy1fE8B8R4K/b/CUOeBkdmi65F4/CQoMr6FjDJh75QJaHdWuNAYiX
 vflclhbP9gBmi5Pr9goHU47qAMRRCKzWCkl6TTjxFu6IOi8flSg/3ZQJVSVLnhbTncxratvzr
 StZSq3h6XH6ALtZ9ONRlELV96RvnRnt3AEq4RxnjOjkRMVpptgVgz1dt9IZNo73vEn634G/1J
 96yEMs7dkAM4Fn53GZuLQ8vKjnBgu3CxnRDZtRXqsmtz+W0B9ckI9Z9eG7sWSdpy/FRPudtrh
 JuTmkaQH1hUQrgGane4TJi96C1UhW1RP4iKZWbHUX9ysHbvrG0o394+79SgSMryKWqX8HJo7T
 CECn9q211NR0rLVq8iRkBqM3PiQW9qsLlmiXHe2UJqY71rMB8nl8bo8/iUHd4JF+wS0qUbUzo
 uxORdEclMvVM6Oi9NBD6PZ7ORWqpwOIgl0258WrPRItyvSyOpZ9PsdQTVK/laAxKbw81/QZy4
 LmUUfOCX0tMJjPZMkjXpfWLa6oneqrKYFCasGNuIxYZVN7FREKb14OFuf166mdzQxdDOCrGTT
 U7s+W4SmGAV7kPOvvx4wLaZnZjs=
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

This does not match the parameter name of the function leading to a
'make htmldocs' build error.

> + * @handle:	pointer to handle for newly installed image
> + *
> + * If @fp contains a file name, load the file.
> + * If @fp does not have a file name, search the architecture-specific

ditto

Best regards

Heinrich

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

