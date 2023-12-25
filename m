Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F53C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 10:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B818758C;
	Mon, 25 Dec 2023 11:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PzOMRaN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0337874F6; Mon, 25 Dec 2023 11:49:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8168885E44
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 11:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703501379; x=1704106179; i=xypron.glpk@gmx.de;
 bh=XIYOVFYW+ikjpCD40ST/cUTO/wya4gJzRlY7NTRkILE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=PzOMRaN8Ws/bvygqSH/zShDZ/SkxBg10NF0o9iDFsFbCdO0nrfNZyCl9llTYUS3M
 VEVQZ0vj9lTDmMH8oJONi/cR70OK8wuVb5ry9eTRIMm6LZLPWMtABnFWZG8INAreu
 t6z99t7PBTqSsuNQatrhsmuDFUVLUgDYaVEAVH8wbEfdm6w/vDq8qqyMDmRD24bSS
 FrZrHxEJXn2GaC1HDJBadSXTnPpAw7RsoraIz5EUMqdXHH9dHoL/7Hoh1otdOFEEy
 7SJEtvjxeawighugigEJZuqqW36MRhSngsz3Px6NZ1+agy9tb96Qiq9Krth3wR88J
 oAZEcjOiBI4Xv7Wvwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1rJcLL3fy5-006xzN; Mon, 25
 Dec 2023 11:49:38 +0100
Message-ID: <30a091ae-c045-4e91-93dd-484c66808b32@gmx.de>
Date: Mon, 25 Dec 2023 11:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi: Avoid using dm_scan_other()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231219142731.2389788-1-sjg@chromium.org>
 <20231219142731.2389788-2-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231219142731.2389788-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BAseS1ZdHfppCALfEYitBiDEHJXCHr6JZ5CDUR11Ldwj+E9EfKD
 tBQFhro/D5owh1U3kkc0VKuYSfVD2d9tuh1xLYk9nUSOpWytKT4z4RZlAaD1i7KJBU2VMPA
 zZJPz7CtGQkPlaXOOyMlurnZSTC9CJAj85Gnf9gkatibWR45Z33KICUYzGIjQycehIR7OW7
 FohvH7ErkQizXRK/KkRlg==
UI-OutboundReport: notjunk:1;M01:P0:eR0aZPYyxEk=;mTS1PgS/7hhSFdAMFx5YOdrJpic
 7gTc/9y0Sx5xVAb67ZYIV/D70nrbvP7ontyKvhnNIfWWOR1u3IyuQfs4LS9kn8qJP48CBJsp4
 YNqzoO1Aou3JSJo18XaTLU4cEp0D+6rLvivjgf17jiqUeA5VwtYUCaUfQCk0+zfe+VnmTttQe
 U9Wu0/U1xivNI/0X0XBHQjkfJncxj+pYvy09DuGgxEt5lTRWOq57o3pxWNMYnIU0Y+PmAmy79
 EAQHexbqtEAcj1mNrdd5r9iJRUqK3WELlR/zwJtmG0CONS/3ya1LxIGT+d0kvBdd/Y6mMPQ/n
 jduBWWD9iZ+vT/67NPfUmONUhaMA0TUIGUhaeDzYoWYh801LsspvtMNb2nwcNnvPnWNK4dgW4
 KGjIls1Zim2di9kg2tE3i7SjCQKcU0hbA2sL8xjeLADEBw/rzBaApEvNuw0Sf5wvxqSqLcOTc
 DFiY7XIqnkQxJiiJk+q605G7FQOe8PDphf+JG1MfXbrz3T1TDhiiagqNd9VBfU3vjY2yPHvmD
 HH7PZLF6RHlFJ8IlmBtbm77Akcoo5RbaJJQxNkAciTA3bfhYy/xW1L7JIB/Ceivycc/oBCBp4
 qkogIOxDCSfC+xdB9RguEG/SCMTxr5TWxpo98c2LIovgnlJ48kIJY3zuXqEcZQU3khKhYO+67
 l4UV+Cj/dmZCsjNwdKe1qC5nPip/gWr+7oqfpfn4YVhjyrwkJXzLmSc+1KhtOeVlIO3FToE/q
 3pHSp2ZkwnNwhkftW0FsrLKUo/4Q8dZyqkhdQilRb7h5Tn0fPl8Q2JymgT2+hX0So4FLLBZWI
 Tj25OAIpRz+LN8t9q1B/ncERBBF/ju69KVL2RL/6fKDsXJBlknGseJbeNmJaMDJgIs0XUCsZD
 Bh3dOwbuta1BlbI4vEaD5LXfdlGFznfTwcxZLPLfvIXSIfOdXY2dGKjx/1Q5v9kJsI2iaF8qb
 znxrIziSqTG2zmDF6V3Y04kLrC0=
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

On 12/19/23 15:27, Simon Glass wrote:
> This function is defined by bootstd so using it precludes using that
> feature. Use the board_early_init_r() feature instead.
>
> Nove the affected code into a new file, so that it is clear that
> this relates to board init.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v4:
> - Create a new file inside lib/efi instead of board/
>
> Changes in v2:
> - Drop duplicate acpi_xsdt patch
> - Put the board_early_init_r code into board/
>
>   configs/efi-x86_app64_defconfig |   1 +
>   lib/efi/Makefile                |   2 +-
>   lib/efi/efi_app.c               | 187 -----------------------------
>   lib/efi/efi_app_init.c          | 205 ++++++++++++++++++++++++++++++++
>   4 files changed, 207 insertions(+), 188 deletions(-)
>   create mode 100644 lib/efi/efi_app_init.c
>
> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_def=
config
> index 14b5cd0fa0ee..ed0506fe25cb 100644
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
> diff --git a/lib/efi/Makefile b/lib/efi/Makefile
> index a790d2d554cd..232fa684360e 100644
> --- a/lib/efi/Makefile
> +++ b/lib/efi/Makefile
> @@ -2,7 +2,7 @@
>   #
>   # (C) Copyright 2015 Google, Inc
>
> -obj-$(CONFIG_EFI_APP) +=3D efi_app.o efi.o
> +obj-$(CONFIG_EFI_APP) +=3D efi_app.o efi.o efi_app_init.o
>   obj-$(CONFIG_EFI_STUB) +=3D efi_info.o
>
>   CFLAGS_REMOVE_efi_stub.o :=3D -mregparm=3D3 \
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
> diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> new file mode 100644
> index 000000000000..c5e4192fe06c
> --- /dev/null
> +++ b/lib/efi/efi_app_init.c
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

