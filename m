Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BDED59D6F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 17:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138E183106;
	Fri, 12 Dec 2025 18:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QR/1v+n8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038D58334F; Fri, 12 Dec 2025 18:03:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8784382B20
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 18:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765558978; x=1766163778; i=xypron.glpk@gmx.de;
 bh=jcGgFVNTjy/Ds5/XXlImfa/L/ddMl5B+AM3iaiqOY+k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QR/1v+n81hEx4oALu9RzLvJvavB1cTWbCtiDjy8vulcmXboDZFCIBz7YJGqyNLlu
 FCjZyKpYsGSKiuvRLCHnU5+cYcXjuGA2Tulmn/E5QHEw/3QaKkq6ITxSoRjKIaeMX
 uPLU3ezqorRMSNcgf+LsfAeJ7abNKm6nA3x6XgN8ZatfZ3WUTXb1QDH/K6FVbumzB
 fKXPj9F1V2aOqtXDS99ToF7njhY4/0DOTBhRAY7MOY/fHkr0ZJ1yBC0EymCESv6Yg
 RTJVm1a0+ELbQwiRIWCXAMby8NbnSbD/JXLHvux7yuTrQxh91h2+owArWt4lLHi3x
 WFDrz+BoRkdPq2S5EA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1vsSwj3xea-00aZBg; Fri, 12
 Dec 2025 18:02:58 +0100
Message-ID: <1623f49d-708e-4e23-a92e-54636d92d239@gmx.de>
Date: Fri, 12 Dec 2025 18:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Javier Tia <javier.tia@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
References: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ubWtgiVKwhpSmnuooDiLyjbZEJn6xerDgDL2bmjSk/wGoKkJG/+
 DXakhw2FU79kQsx2rzQ0md9CmWBkW49fVGtEsUD5qRCSLmPoPdisKIRAdnOjrfpWOwI8upB
 +mzCRXRZa5qXtBYt3EnnfwzmzTwYxOo/Jl5DMGyupwNt39Y7ioMC244XD0Dv6jVRv9WjGSk
 qbZ4BsNiRKDBsTi91eRhw==
UI-OutboundReport: notjunk:1;M01:P0:gY3m7TomxJE=;z+nG9BpZVFMnSJRchrZPNGoYaUO
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

On 12/8/25 16:14, Ilias Apalodimas wrote:
> The EFI spec in =C2=A78.5.5 says
> "The directory \EFI\UpdateCapsule is checked for capsules only within
>   the EFI system partition on the device specified in the active boot
>   option determine by reference to BootNext variable or BootOrder variab=
le
>   processing."
>=20
> Automatically generated boot options don't point to the ESP, they point =
to
> the disk itself and find_handle() won't match when searching for an ESP
> during a capsule update.
> This happens because find_handle() only matches device paths that are
> shorter or equal to the device path passed as an argument.
> Since the EFI spec allows it we want to allow capsule updates, when the
> boot option points to a disk, but that disk contains an ESP with a
> \EFI\UpdateCapsule  directory.
>=20
> find_handle() implicitly changes it's behavior depending on the passed
> arguments as well. If the 'rem' ptr is not valid it will only search for
> an exact match. Otherwise it will match on the best match and return the
> remaining portion of the matched device path to 'rem'.
>=20
> Tweak this slightly and pass an enum with 3 options
> - EXACT   - Exact match, as if 'rem' was NULL
> - SHORTER - Match a shorter device path and put the remainder in 'rem'
> - LONGER  - Inverse the logic and match a longer device path. Put the
>              remainder into 'rem'.
>=20
> To avoid any regressions, LONGER is only used during capsule updates and
> since 'rem' always carries the remainder of the matched device path we
> can plug it in with minimal changes.
>=20
> Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reported-by: John Toomey <john.toomey@amd.com>
> Tested-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - Fixed the function descriptions
> - renamed device_is_present_and_system_part() to device_has_esp to
>    better match the updated functionality
>=20
>   cmd/eficonfig.c                  |  2 +-
>   include/efi_device_path.h        | 21 ++++++++---
>   lib/efi_loader/efi_bootmgr.c     |  6 ++--
>   lib/efi_loader/efi_boottime.c    |  5 +--
>   lib/efi_loader/efi_capsule.c     | 29 +++++++++------
>   lib/efi_loader/efi_device_path.c | 62 +++++++++++++++++++++++++-------
>   lib/efi_loader/efi_disk.c        |  2 +-
>   7 files changed, 94 insertions(+), 33 deletions(-)
>=20
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index d8d946c87ac8..e317f3c90c14 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -1321,7 +1321,7 @@ static efi_status_t prepare_file_selection_entry(s=
truct efimenu *efi_menu, char
>   		return EFI_OUT_OF_RESOURCES;
>=20
>   	/* get the device name only when the user already selected the file p=
ath */
> -	handle =3D efi_dp_find_obj(file_info->dp_volume, NULL, NULL);
> +	handle =3D efi_dp_find_obj(file_info->dp_volume, NULL, NULL, false);
>   	if (handle) {
>   		ret =3D efi_disk_get_device_name(handle, devname, EFICONFIG_VOLUME_P=
ATH_MAX);
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> index aae85228f681..ffff93f64833 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -71,15 +71,28 @@ struct efi_device_path *efi_dp_shorten(struct efi_de=
vice_path *dp);
>   /**
>    * efi_dp_find_obj() - find handle by device path
>    *
> + * if @match_longer is false, the function will only search for device
> + * paths that are either an exact match or shorter than the provided de=
vice
> + * path.
> + * if @match_longer is true it will also match device paths that are lo=
nger
> + * that the provided device path.
> + * The function searches and matches DPs in this order:
> + * - Try to find an exact match
> + * - Try to find a device path that's shorter than the provided one
> + * - Try to find a device path that's longer than the provided one

Please, mention shortened device paths.

> + *
>    * If @rem is provided, the handle with the longest partial match is r=
eturned.
>    *
> - * @dp:     device path to search
> - * @guid:   GUID of protocol that must be installed on path or NULL
> - * @rem:    pointer to receive remaining device path
> + * @dp:			device path to search
> + * @guid:		GUID of protocol that must be installed on path or NULL
> + * @rem:		pointer to receive remaining device path
> + * @match_longer:	match even if the provided dp is shorter. @rem will
> + *                      still hold the remaining device path if specifi=
ed
> + *
>    * Return:  matching handle
>    */
>   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_gui=
d_t *guid,
> -			     struct efi_device_path **rem);
> +			     struct efi_device_path **rem, bool match_longer);
>=20
>   /**
>    * efi_dp_last_node() - Determine the last device path node before the=
 end node
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85c..df7500a94876 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -84,7 +84,8 @@ struct efi_device_path *expand_media_path(struct efi_d=
evice_path *device_path)
>   	 * booting from removable media.
>   	 */
>   	handle =3D efi_dp_find_obj(device_path,
> -				 &efi_simple_file_system_protocol_guid, &rem);
> +				 &efi_simple_file_system_protocol_guid, &rem,
> +				 false);
>   	if (handle) {
>   		if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
>   			char fname[30];
> @@ -625,7 +626,8 @@ static efi_status_t try_load_from_media(struct efi_d=
evice_path *file_path,
>   	struct efi_device_path *rem, *dp =3D NULL;
>   	struct efi_device_path *final_dp =3D file_path;
>=20
> -	handle_blkdev =3D efi_dp_find_obj(file_path, &efi_block_io_guid, &rem)=
;
> +	handle_blkdev =3D efi_dp_find_obj(file_path, &efi_block_io_guid, &rem,
> +					false);
>   	if (handle_blkdev) {
>   		if (rem->type =3D=3D DEVICE_PATH_TYPE_END) {
>   			/* no file name present, try default file */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index ddc935d22409..0391b92a8be4 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1816,7 +1816,8 @@ efi_status_t efi_setup_loaded_image(struct efi_dev=
ice_path *device_path,
>   	info->system_table =3D &systab;
>=20
>   	if (device_path) {
> -		info->device_handle =3D efi_dp_find_obj(device_path, NULL, NULL);
> +		info->device_handle =3D efi_dp_find_obj(device_path, NULL, NULL,
> +						      false);
>=20
>   		dp =3D efi_dp_concat(device_path, file_path, 0);
>   		if (!dp) {
> @@ -2016,7 +2017,7 @@ efi_status_t efi_load_image_from_path(bool boot_po=
licy,
>   	*size =3D 0;
>=20
>   	dp =3D file_path;
> -	device =3D efi_dp_find_obj(dp, NULL, &rem);
> +	device =3D efi_dp_find_obj(dp, NULL, &rem, false);
>   	ret =3D efi_search_protocol(device, &efi_simple_file_system_protocol_=
guid,
>   				  NULL);
>   	if (ret =3D=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 31b47a20186e..bd40ef5f57c4 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -887,26 +887,26 @@ static efi_status_t get_dp_device(u16 *boot_var,
>   }
>=20
>   /**
> - * device_is_present_and_system_part - check if a device exists
> + * device_has_esp - check if an ESP exists on a device or partition
>    *
>    * Check if a device pointed to by the device path, @dp, exists and is
> - * located in UEFI system partition.
> + * either located in or contains a UEFI system partition.
>    *
>    * @dp		device path
>    * Return:	true - yes, false - no
>    */
> -static bool device_is_present_and_system_part(struct efi_device_path *d=
p)
> +static bool device_has_esp(struct efi_device_path *dp,
> +			   struct efi_device_path **rem)
>   {
>   	efi_handle_t handle;
> -	struct efi_device_path *rem;
>=20
>   	/* Check device exists */
> -	handle =3D efi_dp_find_obj(dp, NULL, NULL);
> +	handle =3D efi_dp_find_obj(dp, NULL, NULL, false);
>   	if (!handle)
>   		return false;
>=20
> -	/* Check device is on system partition */
> -	handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
> +	/* Check device is on system partition or contains one */
> +	handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, rem, true);
>   	if (!handle)
>   		return false;
>=20
> @@ -918,6 +918,9 @@ static bool device_is_present_and_system_part(struct=
 efi_device_path *dp)
>    *
>    * Identify the boot device from boot-related variables as UEFI
>    * specification describes and put its handle into bootdev_root.
> + * The function iterates through the active boot options, including
> + * the one defined in BootNext and tries to detect if an ESP is
> + * present on the disk or partition of the disk defined in the boot ent=
ry.
>    *
>    * Return:	status code
>    */
> @@ -928,7 +931,7 @@ static efi_status_t find_boot_device(void)
>   	efi_uintn_t size;
>   	int i, num;
>   	struct efi_simple_file_system_protocol *volume;
> -	struct efi_device_path *boot_dev =3D NULL;
> +	struct efi_device_path *boot_dev =3D NULL, *rem =3D NULL;
>   	efi_status_t ret;
>=20
>   	/* find active boot device in BootNext */
> @@ -949,7 +952,7 @@ static efi_status_t find_boot_device(void)
>=20
>   		ret =3D get_dp_device(boot_var16, &boot_dev);
>   		if (ret =3D=3D EFI_SUCCESS) {
> -			if (device_is_present_and_system_part(boot_dev)) {
> +			if (device_has_esp(boot_dev, &rem)) {
>   				goto found;
>   			} else {
>   				efi_free_pool(boot_dev);
> @@ -987,7 +990,7 @@ skip:
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
>=20
> -		if (device_is_present_and_system_part(boot_dev))
> +		if (device_has_esp(boot_dev, &rem))
>   			break;
>=20
>   		efi_free_pool(boot_dev);
> @@ -997,7 +1000,11 @@ found:
>   	if (boot_dev) {
>   		log_debug("Boot device %pD\n", boot_dev);
>=20
> -		volume =3D efi_fs_from_path(boot_dev);
> +		if (rem->type =3D=3D DEVICE_PATH_TYPE_END)
> +			volume =3D efi_fs_from_path(boot_dev);
> +		else
> +			volume =3D efi_fs_from_path(rem);
> +
>   		if (!volume)
>   			ret =3D EFI_DEVICE_ERROR;
>   		else
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index b3fb20b2501e..e5b113c331bd 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -30,6 +30,19 @@ const struct efi_device_path EFI_DP_END =3D {
>   	.length   =3D sizeof(EFI_DP_END),
>   };
>=20
> +/**
> + * enum match - Options for device path matching
> + *
> + * @EXACT:   Only match an identical device path
> + * @SHORTER: Match device paths that are shorter than the provided one
> + * @LONGER:  Match device paths that are longer than the provided one
> + */
> +enum match {
> +	EXACT,
> +	SHORTER,
> +	LONGER
> +};
> +
>   #if defined(CONFIG_MMC)
>   /*
>    * Determine if an MMC device is an SD card.
> @@ -109,10 +122,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_=
device_path *dp)
>    */
>   static efi_handle_t find_handle(struct efi_device_path *dp,
>   				const efi_guid_t *guid, bool short_path,
> -				struct efi_device_path **rem)
> +				struct efi_device_path **rem,
> +				enum match match)
>   {
>   	efi_handle_t handle, best_handle =3D NULL;
> -	efi_uintn_t len, best_len =3D 0;
> +	efi_uintn_t len, match_len =3D 0, best_len =3D 0;
>=20
>   	len =3D efi_dp_instance_size(dp);
>=20

Where is the documentation update for find_handle()?

> @@ -137,22 +151,35 @@ static efi_handle_t find_handle(struct efi_device_=
path *dp,
>   			if (!dp_current)
>   				continue;
>   		}
> -		len_current =3D efi_dp_instance_size(dp_current);
> -		if (rem) {

Before this patch calling efi_dp_find_obj(rem =3D=3D NULL) would only retu=
rn=20
exact matches.

With the patch efi_dp_find_obj(rem =3D=3D NULL) matches shorter paths.

Your commit message does not describe that you want to change the logic=20
of efi_fs_from_path().

> +
> +		match_len =3D len_current =3D efi_dp_instance_size(dp_current);
> +		switch (match) {
> +		case EXACT:
> +			if (len_current !=3D len)
> +				continue;
> +			break;
> +		case SHORTER:
>   			if (len_current > len)
>   				continue;
> -		} else {
> -			if (len_current !=3D len)
> +			break;
> +		case LONGER:
> +			if (len_current < len)
>   				continue;

So here the logic is:

When search for \a\b;

\a\b\c\d is a better match than \a\b\c

Is this intended?
I can't find it in the function description of find_handle().

> +			match_len =3D len;
> +			break;
>   		}
> -		if (memcmp(dp_current, dp, len_current))
> +
> +		if (memcmp(dp_current, dp, match_len))
>   			continue;
>   		if (!rem)
>   			return handle;
>   		if (len_current > best_len) {
>   			best_len =3D len_current;
>   			best_handle =3D handle;
> -			*rem =3D (void*)((u8 *)dp + len_current);
> +			if (len_current <=3D len)
> +				*rem =3D (void *)((uintptr_t)dp + len_current);
> +			else
> +				*rem =3D (void *)((uintptr_t)dp_current + match_len);
>   		}
>   	}
>   	return best_handle;
> @@ -160,14 +187,25 @@ static efi_handle_t find_handle(struct efi_device_=
path *dp,
>=20
>   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
>   			     const efi_guid_t *guid,
> -			     struct efi_device_path **rem)
> +			     struct efi_device_path **rem, bool match_longer)
>   {
>   	efi_handle_t handle;
>=20
> -	handle =3D find_handle(dp, guid, false, rem);
> +	handle =3D find_handle(dp, guid, false, rem, EXACT);

Here you are tweaking the logic a lot without really describing it:

efi_dp_find(rem !=3D NULL) used to match in sequence:

1) exact long path
2) longest long path with dp as start
3) exact short path
4) longest short path with dp as start

now you have

1) exact long path
2) exact short path
3) longest long path with dp as start
4) longest short path with dp as start

This might be intended. But it is neither described in the commit=20
message nor in the function description.

>   	if (!handle)
> -		/* Match short form device path */
> -		handle =3D find_handle(dp, guid, true, rem);
> +		handle =3D find_handle(dp, guid, true, rem, EXACT);
> +	if (handle)
> +		return handle;
> +

Check the value of rem here (see comment above).

Having both rem !=3D NULL and match_longer =3D=3D true wouldn't make much =
sense.

Theorectically we could use *rem =3D=3D LONGER for allowing longer DPs and=
=20
*rem =3D=3D SHORTER for other cases to avoid the extra argument.

#define LONGER ((void *)(uintptr_t) - 1)
#define SHORTER (NULL)

Best regards

Heinrich

> +	handle =3D find_handle(dp, guid, false, rem, SHORTER);
> +	if (!handle)
> +		handle =3D find_handle(dp, guid, true, rem, SHORTER);
> +
> +	if (match_longer && !handle) {
> +		handle =3D find_handle(dp, guid, false, rem, LONGER);
> +		if (!handle)
> +			handle =3D find_handle(dp, guid, true, rem, LONGER);
> +	}
>=20
>   	return handle;
>   }
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606f..0d3d7c187d72 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
>   	efi_free_pool(file_path);
>=20
>   	/* Get the EFI object for the partition */
> -	efiobj =3D efi_dp_find_obj(device_path, NULL, NULL);
> +	efiobj =3D efi_dp_find_obj(device_path, NULL, NULL, false);
>   	efi_free_pool(device_path);
>   	if (!efiobj)
>   		return NULL;
> --
> 2.43.0
>=20

