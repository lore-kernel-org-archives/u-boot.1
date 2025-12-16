Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEFD609AF
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF2F80325;
	Tue, 16 Dec 2025 16:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XCDpz2Qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385468042F; Tue, 16 Dec 2025 16:25:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1623580107
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765898727; x=1766503527; i=xypron.glpk@gmx.de;
 bh=o2xGyRmf1G70t6gGJway/O3ta0WITvkS/1dphVdI9pM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XCDpz2QnvrA/9hEbT7Nom7TB+rDfEYF970aZa1DHAMOoqtz9Y7mcu1ifMuxZwKFI
 oEIJcK8GpemDuI2ZnDLACsUv8Ms8fYs3H7HjZ/SbsHkt8mHFSrvUAg5pL9pMCWm9K
 eOY5h+81YXy5FlqtDdSFHMFBTRNvcSi+CwiB4eJnO4yooJP+GzZb9KPtMEJrhZCWW
 OW0RpF/wUHBiJkYRae7TMpIoB6rVvL5fkzSr6g+RDSGmpMRCEwFgjR8oG/ZYiGeu2
 LhtwLgvCRdAmFNcPLd6LK5/ZRk/OhFoRPa6OHpTTQP140YOS+qNS2V0MCkcyDLgPx
 tTW3/bkpC6Ni6ZMLmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1vvgZz42Wv-00uYzI; Tue, 16
 Dec 2025 16:25:27 +0100
Message-ID: <d70c8dad-dc9e-461d-a0f8-afc27d818b50@gmx.de>
Date: Tue, 16 Dec 2025 16:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 andrew.goodbody@linaro.org
References: <20251216074710.270479-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251216074710.270479-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rlTcsTbnXucTcxdy6CpQfT1vqdHzjfE/j17/dpgwTJngrPiVK2H
 S/X91mK6y6CHGQeNiLaeK4rliJ3bwHU4+u3cArxjKkXFDIl8jpDkzhiM2pISTFphDlCQl4m
 CXCwJmdXd/WQcypddAT7uJddVYM6xMxmQP6Ml3BPc7/g3DQxqO9O2vBk/3qSNt/DK+9fPw+
 5agRnrY27Tlwe8VR75dCA==
UI-OutboundReport: notjunk:1;M01:P0:JrjWxVoeeJs=;SzCMdCANske9l6yhJiacbl4Y6ko
 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
 +amG0MNhJWI
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

On 12/16/25 08:47, Ilias Apalodimas wrote:
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
> \EFI\UpdateCapsule directory.
>=20
> So, let's change device_is_present_and_system_part() and check if the
> supplied device path contains an ESP. If it does return the handle of
> the device. Otherwise, iterate over child devices and return the handle
> of the first child that contains an ESP.
>=20
> The returned handle can then be reused later. Rather than calling
> efi_fs_from_path(), we can simply look up the EFI_SIMPLE_FILE_SYSTEM_PRO=
TOCOL
> on the discovered handle, avoiding the need to re-parse device paths.
>=20
> Reported-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reported-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes from v2:
> - Changing efi_dp_find_obj() wasn't too intuitive, since we only matched
>    the longest device path we found from a prefix and made the code comp=
lex.
> - Change the implementation and iterate over the device children to loca=
te an
>    ESP, if the supplied DP is not one.
>=20
>   lib/efi_loader/efi_capsule.c | 67 +++++++++++++++++++++++++-----------
>   1 file changed, 46 insertions(+), 21 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index eafc647f558f..60ce03b4254a 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -8,6 +8,7 @@
>=20
>   #define LOG_CATEGORY LOGC_EFI
>=20
> +#include <dm/device.h>
>   #include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> @@ -878,30 +879,48 @@ static efi_status_t get_dp_device(u16 *boot_var,
>   }
>=20
>   /**
> - * device_is_present_and_system_part - check if a device exists
> + * get_esp_handle - check if a device exists and contains an ESP

The logic looks ok. Yet, the descriptions need rework.

"check if a device exists and contains an ESP":
This is not what this function does. It checks if a device has an ESP as=
=20
immediate child.

>    *
>    * Check if a device pointed to by the device path, @dp, exists and is
> - * located in UEFI system partition.
> + * either an ESP or a disk containing an ESP.

Nowhere do you check if the device is a disk. The end node of @dp could=20
be anything.

An NVMe drive may have many namespaces, a SCSI drive many LUNs.

The partition is not the child of the drive but of the namespace or the LU=
N.

An NVMe(NSID,EUI) node in a device-path is for a namespace not for a=20
drive. Similarly an Scsi(PUN,LUN) node is for the LUN and not for the=20
drive (PUN).

Please, provide an accurate function description.

>    *
>    * @dp		device path
> - * Return:	true - yes, false - no
> + * Return:	ESP handle or NULL
>    */
> -static bool device_is_present_and_system_part(struct efi_device_path *d=
p)
> +efi_handle_t get_esp_handle(struct efi_device_path *dp)
>   {
> -	efi_handle_t handle;
> +	efi_handle_t handle, dev_handle;
> +	struct udevice *child_dev;
>   	struct efi_device_path *rem;
> +	efi_status_t ret;
>=20
>   	/* Check device exists */
> -	handle =3D efi_dp_find_obj(dp, NULL, NULL);
> -	if (!handle)
> -		return false;
> +	dev_handle =3D efi_dp_find_obj(dp, NULL, NULL);
> +	if (!dev_handle)
> +		return NULL;
>=20
>   	/* Check device is on system partition */

Should this be
"Check if the device path points to an EFI system partition"?

>   	handle =3D efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
> -	if (!handle)
> -		return false;
> +	if (handle)
> +		return handle;
> +
> +	/* If it's a disk check its children */

The object that you check may be anything, not necessarily a disk.

Best regards

Heinrich

> +	list_for_each_entry(child_dev, &dev_handle->dev->child_head, sibling_n=
ode) {
> +		if (device_get_uclass_id(child_dev) !=3D UCLASS_PARTITION)
> +			continue;
> +		if (dev_tag_get_ptr(child_dev, DM_TAG_EFI, (void **)&handle))
> +			continue;
> +
> +		ret =3D EFI_CALL(systab.boottime->open_protocol(
> +			       handle, &efi_system_partition_guid, NULL, NULL,
> +			       NULL, EFI_OPEN_PROTOCOL_TEST_PROTOCOL));
> +		if (ret !=3D EFI_SUCCESS)
> +			continue;
>=20
> -	return true;
> +		return handle;
> +	}
> +
> +	return NULL;
>   }
>=20
>   /**
> @@ -920,6 +939,8 @@ static efi_status_t find_boot_device(void)
>   	int i, num;
>   	struct efi_simple_file_system_protocol *volume;
>   	struct efi_device_path *boot_dev =3D NULL;
> +	struct efi_handler *handler;
> +	efi_handle_t esp =3D NULL;
>   	efi_status_t ret;
>=20
>   	/* find active boot device in BootNext */
> @@ -940,7 +961,8 @@ static efi_status_t find_boot_device(void)
>=20
>   		ret =3D get_dp_device(boot_var16, &boot_dev);
>   		if (ret =3D=3D EFI_SUCCESS) {
> -			if (device_is_present_and_system_part(boot_dev)) {
> +			esp =3D get_esp_handle(boot_dev);
> +			if (esp) {
>   				goto found;
>   			} else {
>   				efi_free_pool(boot_dev);
> @@ -967,26 +989,29 @@ skip:
>   		if (ret !=3D EFI_SUCCESS)
>   			continue;
>=20
> -		if (device_is_present_and_system_part(boot_dev))
> +		esp =3D get_esp_handle(boot_dev);
> +		if (esp)
>   			break;
>=20
>   		efi_free_pool(boot_dev);
>   		boot_dev =3D NULL;
>   	}
> +
>   found:
> -	if (boot_dev) {
> +	ret =3D EFI_NOT_FOUND;
> +	if (esp) {
>   		log_debug("Boot device %pD\n", boot_dev);
>=20
> -		volume =3D efi_fs_from_path(boot_dev);
> -		if (!volume)
> -			ret =3D EFI_DEVICE_ERROR;
> -		else
> +		efi_free_pool(boot_dev);
> +		ret =3D efi_search_protocol(esp, &efi_simple_file_system_protocol_gui=
d,
> +					  &handler);
> +		if (ret =3D=3D EFI_SUCCESS) {
> +			volume =3D handler->protocol_interface;
>   			ret =3D EFI_CALL(volume->open_volume(volume,
>   							   &bootdev_root));
> -		efi_free_pool(boot_dev);
> -	} else {
> -		ret =3D EFI_NOT_FOUND;
> +		}
>   	}
> +
>   out:
>   	free(boot_order);
>=20
> --
> 2.43.0
>=20

