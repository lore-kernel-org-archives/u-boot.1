Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C237C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 12:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F416875A1;
	Tue, 21 Nov 2023 13:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VnlSJPP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7B2871DA; Tue, 21 Nov 2023 13:18:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60CC875B9
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700569090; x=1701173890; i=xypron.glpk@gmx.de;
 bh=h6hpO2Rq2Vqfsgkq0lL49bdlKk7+urZicc0ip4w2vys=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=VnlSJPP44ioPxPbByjLAAYmZHE6JFiLpdTmjRsSLyqJwrhSyx8zR7J+bZpU8PE/h
 bcGQP+kKpq6byXvKotyruS9FNnXDf4uLmnO+9quk+bfaypPgEX4VehIwxKj/URcLB
 OtM++fVZtxomXEsKsUl4gJny7Qq1q6ACypXWlkQERXwxA5CMje0FgZGdSONlAxl+T
 rfFDTKDaonJlrOItc5kjZK3oxWAUvExSEk4N/YNNs/veF0ohkqE0w3+XAtVN23EF6
 3nnp12NgMbBWStP8vkEaNsiaqBxlI0iTF/VebVs6sOiRuEACcmoIKswDVKb9VdO5l
 iPp5wdaXF/MDiKoGug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1rhlH40CV2-00niCv; Tue, 21
 Nov 2023 13:18:10 +0100
Message-ID: <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
Date: Tue, 21 Nov 2023 13:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112205516.183410-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3BsJP+FiuU0xsjPnEXVj/goKBiELEIcccBinGeq9XaoyAxutoUt
 aRGEpA6wnhtT3n7YCOXXm/q4OC06l+dHMIKFNZcehEwWdt/ELe3j7zpfL9smmbvh/YLjFLH
 5DzpDVmD6NVF1/goK/NO2fnGWt0HzN4Hl3/ovZFkObqPURMfhGgd1p87hLgCq3pRffBPuaa
 84+B5tXK0fdvLn9GK7oOQ==
UI-OutboundReport: notjunk:1;M01:P0:3rVwCeaj8W8=;ozq8svhY/e53LgNNNG8imVPe8fL
 IKngfx2GXkyfrvsoJGEgEWrborpPAihOI7g+RqyA7JzvmEPQZwEbP6vYzsqUPi57c4Xz8MfM+
 yoQjxCJAQChLG0oSRbfaOLeJPyttudznwgqwIRqHLDXfWpkBouHaBUM1xhTEkV2X1Dra+7T94
 ebTCP4ipEGGoj6qpQRTRFwUaycXZWrCKiCutngFAQjpedC9xiq8L0N8S8zH3eAMb8EwRnvbKr
 iGNP0rX5YmZRNiwgzIyvSlf7w2rTdQlmaFAto0EsRAlr9gwI2U5hhrAIjM51ApU5qo7LKUQQ1
 vqL5LZgH0XJY4o6aKLER+ch/zM9PfM7ucHMrOfFKDUS/uJhUepsTNJKWbZmwAfTHGf0I8iQWn
 jBwasC8n6x7L/appK+SypZVKK8Nx6MnMlLYWyjq07jaw7ZYZd7vXpL++q2ZpMLd314pCZqIgW
 PveaQ6TQnTtX7pmEc0t9EtcxvyHvUUMj00ywqI6Ldivrwf4o1RKHLPEvFyBFClrjJwPCvhHUW
 Qay1AaYnxArz59+SCHajUayiQZA6ppFf32m+4JJPprQFvdzfhLYU9xi57HqF2Q0mD0uJtCd24
 J4g4/QkxCtvoY3w6kFHzMwnTZNKlfE1kYxnY0hAWgth/N0NRGyB0bSLPl2lULsbjIr560GEA7
 r/uwfD61E+CqAUAwUlgzct+wHq/mpTfJpLVABBk7zax3XFy02ca8w+0Nnnc+BVb4ieYuJ7oiL
 bLDYJ/GZlKMjzMyqT/Ao36NOu4D6LwScYkBxD9rZIApPNNlQj/CUKE5XspD68u7IcCSJoGwGv
 M08s1R4CUbXTxgcs3h9V/JWCnb2N5WlcICsLvt7StCjXiZwP+lSypEfmyHfioq4bO8KLgzbnJ
 XyGuhM7NXymd9b+DZpSpj+K7kuwCoqZ79Rz1VcWfR+3JhKb2ZDJI1NjMkCEwaI6TFQCp9ayNh
 kkomPRsNYlal+OUF//MRR1V4jKc=
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

On 11/12/23 21:55, Simon Glass wrote:
> This function is defined by bootstd so using it precludes using that
> feature. Use the board_early_init_r() feature instead.
>
> This requires moving quite a lot of code into the board directory, butt
> this is the normal place for code called by board_early_init_r()
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Drop duplicate acpi_xsdt patch
> - Put the board_early_init_r code into board/
>
>   board/efi/efi-x86_app/Makefile  |   5 +
>   board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++

Our target should be to enable building the EFI app on all architectures.

Only x86 specific code should be added to board/efi/efi-x86_app/efi_app.c.

Best regards

Heinrich

>   configs/efi-x86_app64_defconfig |   1 +
>   lib/efi/efi_app.c               | 187 -----------------------------
>   4 files changed, 211 insertions(+), 187 deletions(-)
>   create mode 100644 board/efi/efi-x86_app/Makefile
>   create mode 100644 board/efi/efi-x86_app/efi_app.c
>
> diff --git a/board/efi/efi-x86_app/Makefile b/board/efi/efi-x86_app/Make=
file
> new file mode 100644
> index 000000000000..682f8754b44d
> --- /dev/null
> +++ b/board/efi/efi-x86_app/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2023 Google LLC
> +
> +obj-y	+=3D efi_app.o
> diff --git a/board/efi/efi-x86_app/efi_app.c b/board/efi/efi-x86_app/efi=
_app.c
> new file mode 100644
> index 000000000000..c5e4192fe06c
> --- /dev/null
> +++ b/board/efi/efi-x86_app/efi_app.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * EFI-app board implementation
> + *
> + * Copyright 2023 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <dm.h>
> +#include <efi.h>
> +#include <efi_api.h>
> +#include <errno.h>
> +#include <malloc.h>
> +#include <asm/global_data.h>
> +#include <dm/device-internal.h>
> +#include <dm/root.h>
> +#include <linux/types.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/**
> + * efi_bind_block() - bind a new block device to an EFI device
> + *
> + * Binds a new top-level EFI_MEDIA device as well as a child block devi=
ce so
> + * that the block device can be accessed in U-Boot.
> + *
> + * The device can then be accessed using 'part list efi 0', 'fat ls efi=
 0:1',
> + * for example, just like any other interface type.
> + *
> + * @handle: handle of the controller on which this driver is installed
> + * @blkio: block io protocol proxied by this driver
> + * @device_path: EFI device path structure for this
> + * @len: Length of @device_path in bytes
> + * @devp: Returns the bound device
> + * Return: 0 if OK, -ve on error
> + */
> +int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
> +		   struct efi_device_path *device_path, int len,
> +		   struct udevice **devp)
> +{
> +	struct efi_media_plat plat;
> +	struct udevice *dev;
> +	char name[18];
> +	int ret;
> +
> +	plat.handle =3D handle;
> +	plat.blkio =3D blkio;
> +	plat.device_path =3D malloc(device_path->length);
> +	if (!plat.device_path)
> +		return log_msg_ret("path", -ENOMEM);
> +	memcpy(plat.device_path, device_path, device_path->length);
> +	ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> +			  &plat, ofnode_null(), &dev);
> +	if (ret)
> +		return log_msg_ret("bind", ret);
> +
> +	snprintf(name, sizeof(name), "efi_media_%x", dev_seq(dev));
> +	device_set_name(dev, name);
> +	*devp =3D dev;
> +
> +	return 0;
> +}
> +
> +/**
> + * devpath_is_partition() - Figure out if a device path is a partition
> + *
> + * Checks if a device path refers to a partition on some media device. =
This
> + * works by checking for a valid partition number in a hard-driver medi=
a device
> + * as the final component of the device path.
> + *
> + * @path:	device path
> + * Return:	true if a partition, false if not
> + *		(e.g. it might be media which contains partitions)
> + */
> +static bool devpath_is_partition(const struct efi_device_path *path)
> +{
> +	const struct efi_device_path *p;
> +	bool was_part =3D false;
> +
> +	for (p =3D path; p->type !=3D DEVICE_PATH_TYPE_END;
> +	     p =3D (void *)p + p->length) {
> +		was_part =3D false;
> +		if (p->type =3D=3D DEVICE_PATH_TYPE_MEDIA_DEVICE &&
> +		    p->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
> +			struct efi_device_path_hard_drive_path *hd =3D
> +				(void *)path;
> +
> +			if (hd->partition_number)
> +				was_part =3D true;
> +		}
> +	}
> +
> +	return was_part;
> +}
> +
> +/**
> + * setup_block() - Find all block devices and setup EFI devices for the=
m
> + *
> + * Partitions are ignored, since U-Boot has partition handling. Errors =
with
> + * particular devices produce a warning but execution continues to try =
to
> + * find others.
> + *
> + * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENO=
TSUPP
> + *	if a required protocol is not supported
> + */
> +static int setup_block(void)
> +{
> +	efi_guid_t efi_blkio_guid =3D EFI_BLOCK_IO_PROTOCOL_GUID;
> +	efi_guid_t efi_devpath_guid =3D EFI_DEVICE_PATH_PROTOCOL_GUID;
> +	efi_guid_t efi_pathutil_guid =3D EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GU=
ID;
> +	efi_guid_t efi_pathtext_guid =3D EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID=
;
> +	struct efi_boot_services *boot =3D efi_get_boot();
> +	struct efi_device_path_utilities_protocol *util;
> +	struct efi_device_path_to_text_protocol *text;
> +	struct efi_device_path *path;
> +	struct efi_block_io *blkio;
> +	efi_uintn_t num_handles;
> +	efi_handle_t *handle;
> +	int ret, i;
> +
> +	if (!boot)
> +		return log_msg_ret("sys", -ENOSYS);
> +
> +	/* Find all devices which support the block I/O protocol */
> +	ret =3D boot->locate_handle_buffer(BY_PROTOCOL, &efi_blkio_guid, NULL,
> +				  &num_handles, &handle);
> +	if (ret)
> +		return log_msg_ret("loc", -ENOTSUPP);
> +	log_debug("Found %d handles:\n", (int)num_handles);
> +
> +	/* We need to look up the path size and convert it to text */
> +	ret =3D boot->locate_protocol(&efi_pathutil_guid, NULL, (void **)&util=
);
> +	if (ret)
> +		return log_msg_ret("util", -ENOTSUPP);
> +	ret =3D boot->locate_protocol(&efi_pathtext_guid, NULL, (void **)&text=
);
> +	if (ret)
> +		return log_msg_ret("text", -ENOTSUPP);
> +
> +	for (i =3D 0; i < num_handles; i++) {
> +		struct udevice *dev;
> +		const u16 *name;
> +		bool is_part;
> +		int len;
> +
> +		ret =3D boot->handle_protocol(handle[i], &efi_devpath_guid,
> +					    (void **)&path);
> +		if (ret) {
> +			log_warning("- devpath %d failed (ret=3D%d)\n", i, ret);
> +			continue;
> +		}
> +
> +		ret =3D boot->handle_protocol(handle[i], &efi_blkio_guid,
> +					    (void **)&blkio);
> +		if (ret) {
> +			log_warning("- blkio %d failed (ret=3D%d)\n", i, ret);
> +			continue;
> +		}
> +
> +		name =3D text->convert_device_path_to_text(path, true, false);
> +		is_part =3D devpath_is_partition(path);
> +
> +		if (!is_part) {
> +			len =3D util->get_device_path_size(path);
> +			ret =3D efi_bind_block(handle[i], blkio, path, len, &dev);
> +			if (ret) {
> +				log_warning("- blkio bind %d failed (ret=3D%d)\n",
> +					    i, ret);
> +				continue;
> +			}
> +		} else {
> +			dev =3D NULL;
> +		}
> +
> +		/*
> +		 * Show the device name if we created one. Otherwise indicate
> +		 * that it is a partition.
> +		 */
> +		printf("%2d: %-12s %ls\n", i, dev ? dev->name : "<partition>",
> +		       name);
> +	}
> +	boot->free_pool(handle);
> +
> +	return 0;
> +}
> +
> +/**
> + * board_early_init_r() - Scan for UEFI devices that should be availabl=
e
> + *
> + * This sets up block devices within U-Boot for those found in UEFI. Wi=
th this,
> + * U-Boot can access those devices
> + *
> + * Returns: 0 on success, -ve on error
> + */
> +int board_early_init_r(void)
> +{
> +	if (gd->flags & GD_FLG_RELOC) {
> +		int ret;
> +
> +		ret =3D setup_block();
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_def=
config
> index d6b6c3d82995..e6a62b30dd09 100644
> --- a/configs/efi-x86_app64_defconfig
> +++ b/configs/efi-x86_app64_defconfig
> @@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>   CONFIG_BOOTCOMMAND=3D"ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot =
01000000"
>   CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>   CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_BOARD_EARLY_INIT_R=3Dy
>   CONFIG_HUSH_PARSER=3Dy
>   CONFIG_SYS_PBSIZE=3D532
>   CONFIG_CMD_BOOTZ=3Dy
> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> index c5eb816655ea..e79fa5dad176 100644
> --- a/lib/efi/efi_app.c
> +++ b/lib/efi/efi_app.c
> @@ -68,49 +68,6 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *si=
zep, uint *keyp,
>   	return 0;
>   }
>
> -/**
> - * efi_bind_block() - bind a new block device to an EFI device
> - *
> - * Binds a new top-level EFI_MEDIA device as well as a child block devi=
ce so
> - * that the block device can be accessed in U-Boot.
> - *
> - * The device can then be accessed using 'part list efi 0', 'fat ls efi=
 0:1',
> - * for example, just like any other interface type.
> - *
> - * @handle: handle of the controller on which this driver is installed
> - * @blkio: block io protocol proxied by this driver
> - * @device_path: EFI device path structure for this
> - * @len: Length of @device_path in bytes
> - * @devp: Returns the bound device
> - * Return: 0 if OK, -ve on error
> - */
> -int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
> -		   struct efi_device_path *device_path, int len,
> -		   struct udevice **devp)
> -{
> -	struct efi_media_plat plat;
> -	struct udevice *dev;
> -	char name[18];
> -	int ret;
> -
> -	plat.handle =3D handle;
> -	plat.blkio =3D blkio;
> -	plat.device_path =3D malloc(device_path->length);
> -	if (!plat.device_path)
> -		return log_msg_ret("path", -ENOMEM);
> -	memcpy(plat.device_path, device_path, device_path->length);
> -	ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> -			  &plat, ofnode_null(), &dev);
> -	if (ret)
> -		return log_msg_ret("bind", ret);
> -
> -	snprintf(name, sizeof(name), "efi_media_%x", dev_seq(dev));
> -	device_set_name(dev, name);
> -	*devp =3D dev;
> -
> -	return 0;
> -}
> -
>   static efi_status_t setup_memory(struct efi_priv *priv)
>   {
>   	struct efi_boot_services *boot =3D priv->boot;
> @@ -179,150 +136,6 @@ static void free_memory(struct efi_priv *priv)
>   	global_data_ptr =3D NULL;
>   }
>
> -/**
> - * devpath_is_partition() - Figure out if a device path is a partition
> - *
> - * Checks if a device path refers to a partition on some media device. =
This
> - * works by checking for a valid partition number in a hard-driver medi=
a device
> - * as the final component of the device path.
> - *
> - * @path:	device path
> - * Return:	true if a partition, false if not
> - *		(e.g. it might be media which contains partitions)
> - */
> -static bool devpath_is_partition(const struct efi_device_path *path)
> -{
> -	const struct efi_device_path *p;
> -	bool was_part =3D false;
> -
> -	for (p =3D path; p->type !=3D DEVICE_PATH_TYPE_END;
> -	     p =3D (void *)p + p->length) {
> -		was_part =3D false;
> -		if (p->type =3D=3D DEVICE_PATH_TYPE_MEDIA_DEVICE &&
> -		    p->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
> -			struct efi_device_path_hard_drive_path *hd =3D
> -				(void *)path;
> -
> -			if (hd->partition_number)
> -				was_part =3D true;
> -		}
> -	}
> -
> -	return was_part;
> -}
> -
> -/**
> - * setup_block() - Find all block devices and setup EFI devices for the=
m
> - *
> - * Partitions are ignored, since U-Boot has partition handling. Errors =
with
> - * particular devices produce a warning but execution continues to try =
to
> - * find others.
> - *
> - * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENO=
TSUPP
> - *	if a required protocol is not supported
> - */
> -static int setup_block(void)
> -{
> -	efi_guid_t efi_blkio_guid =3D EFI_BLOCK_IO_PROTOCOL_GUID;
> -	efi_guid_t efi_devpath_guid =3D EFI_DEVICE_PATH_PROTOCOL_GUID;
> -	efi_guid_t efi_pathutil_guid =3D EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GU=
ID;
> -	efi_guid_t efi_pathtext_guid =3D EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID=
;
> -	struct efi_boot_services *boot =3D efi_get_boot();
> -	struct efi_device_path_utilities_protocol *util;
> -	struct efi_device_path_to_text_protocol *text;
> -	struct efi_device_path *path;
> -	struct efi_block_io *blkio;
> -	efi_uintn_t num_handles;
> -	efi_handle_t *handle;
> -	int ret, i;
> -
> -	if (!boot)
> -		return log_msg_ret("sys", -ENOSYS);
> -
> -	/* Find all devices which support the block I/O protocol */
> -	ret =3D boot->locate_handle_buffer(BY_PROTOCOL, &efi_blkio_guid, NULL,
> -				  &num_handles, &handle);
> -	if (ret)
> -		return log_msg_ret("loc", -ENOTSUPP);
> -	log_debug("Found %d handles:\n", (int)num_handles);
> -
> -	/* We need to look up the path size and convert it to text */
> -	ret =3D boot->locate_protocol(&efi_pathutil_guid, NULL, (void **)&util=
);
> -	if (ret)
> -		return log_msg_ret("util", -ENOTSUPP);
> -	ret =3D boot->locate_protocol(&efi_pathtext_guid, NULL, (void **)&text=
);
> -	if (ret)
> -		return log_msg_ret("text", -ENOTSUPP);
> -
> -	for (i =3D 0; i < num_handles; i++) {
> -		struct udevice *dev;
> -		const u16 *name;
> -		bool is_part;
> -		int len;
> -
> -		ret =3D boot->handle_protocol(handle[i], &efi_devpath_guid,
> -					    (void **)&path);
> -		if (ret) {
> -			log_warning("- devpath %d failed (ret=3D%d)\n", i, ret);
> -			continue;
> -		}
> -
> -		ret =3D boot->handle_protocol(handle[i], &efi_blkio_guid,
> -					    (void **)&blkio);
> -		if (ret) {
> -			log_warning("- blkio %d failed (ret=3D%d)\n", i, ret);
> -			continue;
> -		}
> -
> -		name =3D text->convert_device_path_to_text(path, true, false);
> -		is_part =3D devpath_is_partition(path);
> -
> -		if (!is_part) {
> -			len =3D util->get_device_path_size(path);
> -			ret =3D efi_bind_block(handle[i], blkio, path, len, &dev);
> -			if (ret) {
> -				log_warning("- blkio bind %d failed (ret=3D%d)\n",
> -					    i, ret);
> -				continue;
> -			}
> -		} else {
> -			dev =3D NULL;
> -		}
> -
> -		/*
> -		 * Show the device name if we created one. Otherwise indicate
> -		 * that it is a partition.
> -		 */
> -		printf("%2d: %-12s %ls\n", i, dev ? dev->name : "<partition>",
> -		       name);
> -	}
> -	boot->free_pool(handle);
> -
> -	return 0;
> -}
> -
> -/**
> - * dm_scan_other() - Scan for UEFI devices that should be available to =
U-Boot
> - *
> - * This sets up block devices within U-Boot for those found in UEFI. Wi=
th this,
> - * U-Boot can access those devices
> - *
> - * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
> - * Returns: 0 on success, -ve on error
> - */
> -int dm_scan_other(bool pre_reloc_only)
> -{
> -	if (gd->flags & GD_FLG_RELOC) {
> -		int ret;
> -
> -		ret =3D setup_block();
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static void scan_tables(struct efi_system_table *sys_table)
>   {
>   	efi_guid_t acpi =3D EFI_ACPI_TABLE_GUID;

