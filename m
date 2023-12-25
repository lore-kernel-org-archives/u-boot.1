Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77668C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 09:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8C9877BB;
	Mon, 25 Dec 2023 10:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="omdiI5/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB56877CB; Mon, 25 Dec 2023 10:17:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9243A87719
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 10:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703495832; x=1704100632; i=xypron.glpk@gmx.de;
 bh=ZPc0p8BXVzBbDhiLjDPreJadKbqhSnIOvpw2jK2143Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=omdiI5/wlm9VjFm4uJ5SAslXRc1AlWpXXoPmutjDHsrFRhOH+6y5L/pMyk8QvfJw
 3YZ/1OchhYnyzmRmkvki5jtBRGurBWUfheXNIV6sEOU6mnlzVwQg6QlFCXIpGU9a4
 mt1vxhdBNpYR7iKmYMbybuoAtAFZe2mxadYi4bie+CgQMn4I36Tkte9mgjo2j3GCE
 JWNJ9NoSNQOVE09MOaQ94GMsNeXm2Q2FOzNE4IY25pQr+Gv2TFuArlr1qCu4fcS+F
 bjHqimas+uuLcynSUgSr0RXkuHT5vjt6bxEGq3lid88WK/507CBToEDjBHjBKav8n
 lgwVYTdbAmUrT64BLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1rGrs03HrD-004EX6; Mon, 25
 Dec 2023 10:17:11 +0100
Message-ID: <cdd81b7f-fdc3-43a2-a69f-803aec2d0e3c@gmx.de>
Date: Mon, 25 Dec 2023 10:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] efi_loader: split unrelated code from efi_bootmgr.c
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-2-takahiro.akashi@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231218023842.281336-2-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:11WqeDp+wengUwVTI75G8685FUDctx0asNvUbEjruC3LNRNFvF4
 LF/kb0WBruQeMyJiUZQr57WRGEYu44q6kBevfk4LHlFIm6rZBNvlyi776YRCJeVuZAErK2T
 OJbeRDYmCT1svw1p5zkRJz2x5uyq68rejxMkVIG9Jn3xz0GSF7yYpQyh0S9AZrfug3HwNCk
 nqXBn8mHOkAgzPZ1Kk/NA==
UI-OutboundReport: notjunk:1;M01:P0:aIlser/xlmI=;ZgK4u9OxPclm/uN2p8dYTd90LXm
 JT0eXeV1BdFWZq0jtjqRlJ4gyLgEzgKdvqmpU2amnk0EgheuMs0eEOMdfH4A20F6YDQetvG+W
 ufaXkAZVrD5faOE05pgDSPtEDm1UYzho7t9xEVxv2fQhP4tI4suvl5gswiemr1oWfM+Lk7UzX
 oVO81ADqfREbrRWpbZLSX4TRttDzCX7U89hiI9lvm67ZzrBjtZg5fSrUTdSYgrw8mrpVQ4EOD
 CE1s2qyagwJ+99XvHVZc4HPg89gdBhczwZH3zaaJgpnq/sPl9JKezyt73obBKAlnCPHOvHsxd
 r5j5ROkN8ouT6M2H9ErL6lxtyKt8wvG9cVxDkgVta7mATYKkTOWBYVs8gfW/CWmWjpgl2qBPz
 fuogfqBvZGLlBiJAX4lEKyecqGvG2EsWrmpz7lMy1lMgVqwQ4tf1VB/suH1kqMbCSkuc1//iD
 h2rW+SGw6hQ7nP1sngP42flUKhQ/uVAUvOJv7BPI74iFLIe3LFIbgX3Lp6b/JlkCt491wbQTu
 7iqrd5vWXOh0/XZoKAVZaIz0ITEdb9QivsiIcKbAuiOfQs+0UB819M3Of0beKCJni65Y8vh4K
 D5klfBrEiZ2QbycwR8TDqqGJFLFIj2yi0n9ANxKIEdUFpLEE5xGmh6UAcSZHYE1Tl5qdWT3uT
 sIhTwmvT9R2sS+a2BncLqNLx0hH3CDQChyiI64rh7FrHfxjiiBJ+7Duyy93nQDMPrdH+aL4rm
 ReFTxJnDuB/dv24NRc+ItM0RhjZ5K5KcGwPq1EF8mghJi8xf6eWCC+B/Ec7aEM+2cGxAgbqEG
 EFRL5XivyTalql347fro9/etumMSmFLe8dx6rDuEDG1EP4fuZIRZgeA5ZUvXlLrEDLaniew1u
 d094eIZa8Eimn5e6lUUd0HWZQSdpsLNdBoq5C95ANVjAiY7xNgXJhmNK4PIaXj0rArENxsghl
 fb2NEDeidOfIx1lLB5kTbqEUJXo=
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

On 12/18/23 03:38, AKASHI Takahiro wrote:
> Some code moved from cmd/bootefi.c is actually necessary only for "boote=
fi
> <addr>" command (starting an image manually loaded by a user using U-Boo=
t
> load commands or other methods (like JTAG debugger).
>
> The code will never been opted out as unused code by a compiler which
> doesn't know how EFI boot manager is implemented. So introduce a new
> configuration, CONFIG_EFI_BINARY_EXEC, to enforce theem opted out
> explicitly.

We build with -ffunction-sections. The linker removes unreferenced
functions.

>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   boot/Kconfig                     |   4 +-
>   cmd/Kconfig                      |   6 +-
>   include/efi_loader.h             |  28 +-
>   lib/efi_loader/Kconfig           |   9 +
>   lib/efi_loader/efi_bootmgr.c     | 493 ------------------------------
>   lib/efi_loader/efi_device_path.c |   3 +-
>   lib/efi_loader/efi_helper.c      | 499 ++++++++++++++++++++++++++++++-

We expect that after each patch we can compile the code. This requires
that the Makefile change is in the same patch as the creation of
efi_helper.c.

>   7 files changed, 529 insertions(+), 513 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 987ca7314117..8ab7e6f63d34 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -523,7 +523,7 @@ config BOOTMETH_EXTLINUX_PXE
>
>   config BOOTMETH_EFILOADER
>   	bool "Bootdev support for EFI boot"
> -	depends on BOOTEFI_BOOTMGR
> +	depends on EFI_BINARY_EXEC

Why do we need a symbol CONFIG_EFI_BINARY_EXEC? CONFIG_EFI_LOADER=3Dy
without the ability to execute an EFI binary makes no sense to me.

Best regards

Heinrich

>   	default y
>   	help
>   	  Enables support for EFI boot using bootdevs. This makes the
> @@ -558,7 +558,7 @@ config BOOTMETH_DISTRO
>   	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>   	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>   	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
> -	select BOOTMETH_EFILOADER if BOOTEFI_BOOTMGR # E.g. Ubuntu uses this
> +	select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>
>   config SPL_BOOTMETH_VBE
>   	bool "Bootdev support for Verified Boot for Embedded (SPL)"
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 24bfbe505722..2c993496b70e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -273,7 +273,7 @@ config CMD_BOOTMETH
>
>   config BOOTM_EFI
>   	bool "Support booting UEFI FIT images"
> -	depends on BOOTEFI_BOOTMGR && CMD_BOOTM && FIT
> +	depends on EFI_BINARY_EXEC && CMD_BOOTM && FIT
>   	default y
>   	help
>   	  Support booting UEFI FIT images via the bootm command.
> @@ -365,7 +365,7 @@ config CMD_BOOTEFI
>   if CMD_BOOTEFI
>   config CMD_BOOTEFI_BINARY
>   	bool "Allow booting an EFI binary directly"
> -	depends on BOOTEFI_BOOTMGR
> +	depends on EFI_BINARY_EXEC
>   	default y
>   	help
>   	  Select this option to enable direct execution of binary at 'bootefi=
'.
> @@ -395,7 +395,7 @@ config CMD_BOOTEFI_HELLO_COMPILE
>
>   config CMD_BOOTEFI_HELLO
>   	bool "Allow booting a standard EFI hello world for testing"
> -	depends on CMD_BOOTEFI_HELLO_COMPILE
> +	depends on CMD_BOOTEFI_BINARY && CMD_BOOTEFI_HELLO_COMPILE
>   	default y if CMD_BOOTEFI_SELFTEST
>   	help
>   	  This adds a standard EFI hello world application to U-Boot so that
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 34e7fbbf1840..484c9fad239f 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -90,11 +90,7 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64=
 len);
>    * back to u-boot world
>    */
>   void efi_restore_gd(void);
> -/* Call this to unset the current device name */
> -void efi_clear_bootdev(void);
> -/* Call this to set the current device name */
> -void efi_set_bootdev(const char *dev, const char *devnr, const char *pa=
th,
> -		     void *buffer, size_t buffer_size);
> +
>   /* Called by networking code to memorize the dhcp ack package */
>   void efi_net_set_dhcp_ack(void *pkt, int len);
>   /* Print information about all loaded images */
> @@ -116,10 +112,6 @@ static inline efi_status_t efi_add_runtime_mmio(voi=
d *mmio_ptr, u64 len)
>
>   /* No loader configured, stub out EFI_ENTRY */
>   static inline void efi_restore_gd(void) { }
> -static inline void efi_clear_bootdev(void) { }
> -static inline void efi_set_bootdev(const char *dev, const char *devnr,
> -				   const char *path, void *buffer,
> -				   size_t buffer_size) { }
>   static inline void efi_net_set_dhcp_ack(void *pkt, int len) { }
>   static inline void efi_print_image_infos(void *pc) { }
>   static inline efi_status_t efi_launch_capsules(void)
> @@ -129,6 +121,20 @@ static inline efi_status_t efi_launch_capsules(void=
)
>
>   #endif /* CONFIG_IS_ENABLED(EFI_LOADER) */
>
> +#if CONFIG_IS_ENABLED(EFI_BINARY_EXEC)
> +/* Call this to unset the current device name */
> +void efi_clear_bootdev(void);
> +/* Call this to set the current device name */
> +void efi_set_bootdev(const char *dev, const char *devnr, const char *pa=
th,
> +		     void *buffer, size_t buffer_size);
> +#else
> +static inline void efi_clear_bootdev(void) { }
> +
> +static inline void efi_set_bootdev(const char *dev, const char *devnr,
> +				   const char *path, void *buffer,
> +				   size_t buffer_size) { }
> +#endif
> +
>   /* Maximum number of configuration tables */
>   #define EFI_MAX_CONFIGURATION_TABLES 16
>
> @@ -541,8 +547,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t h=
andle, const char *env_var,
>   				      u16 **load_options);
>   /* Install device tree */
>   efi_status_t efi_install_fdt(void *fdt);
> -/* Run loaded UEFI image */
> -efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size=
);
> +/* Execute loaded UEFI image */
> +efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>   /* Run loaded UEFI image with given fdt */
>   efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
>   /* Initialize variable services */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ea807342f02f..64f2f1cdd161 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -32,6 +32,15 @@ config EFI_LOADER
>
>   if EFI_LOADER
>
> +config EFI_BINARY_EXEC
> +	bool "Execute UEFI binary"
> +	default y
> +	help
> +	  Select this option if you want to execute the UEFI binary after
> +	  loading it with U-Boot load commands or other methods.
> +	  You may enable CMD_BOOTEFI_BINARY so that you can use bootefi
> +	  command to do that.
> +
>   config BOOTEFI_BOOTMGR
>   	bool "UEFI Boot Manager"
>   	default y
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 56d97f23827b..e3b27cd7db3e 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -3,8 +3,6 @@
>    *  EFI boot manager
>    *
>    *  Copyright (c) 2017 Rob Clark
> - *  For the code moved from cmd/bootefi.c
> - *  Copyright (c) 2016 Alexander Graf
>    */
>
>   #define LOG_CATEGORY LOGC_EFI
> @@ -22,17 +20,6 @@
>   #include <efi_variable.h>
>   #include <asm/unaligned.h>
>
> -/* TODO: temporarily added here; clean up later */
> -#include <bootm.h>
> -#include <efi_selftest.h>
> -#include <env.h>
> -#include <mapmem.h>
> -#include <asm/global_data.h>
> -#include <linux/libfdt.h>
> -#include <linux/libfdt_env.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   static const struct efi_boot_services *bs;
>   static const struct efi_runtime_services *rs;
>
> @@ -1129,389 +1116,6 @@ out:
>   	return ret;
>   }
>
> -static struct efi_device_path *bootefi_image_path;
> -static struct efi_device_path *bootefi_device_path;
> -static void *image_addr;
> -static size_t image_size;
> -
> -/**
> - * efi_get_image_parameters() - return image parameters
> - *
> - * @img_addr:		address of loaded image in memory
> - * @img_size:		size of loaded image
> - */
> -void efi_get_image_parameters(void **img_addr, size_t *img_size)
> -{
> -	*img_addr =3D image_addr;
> -	*img_size =3D image_size;
> -}
> -
> -/**
> - * efi_clear_bootdev() - clear boot device
> - */
> -void efi_clear_bootdev(void)
> -{
> -	efi_free_pool(bootefi_device_path);
> -	efi_free_pool(bootefi_image_path);
> -	bootefi_device_path =3D NULL;
> -	bootefi_image_path =3D NULL;
> -	image_addr =3D NULL;
> -	image_size =3D 0;
> -}
> -
> -/**
> - * efi_set_bootdev() - set boot device
> - *
> - * This function is called when a file is loaded, e.g. via the 'load' c=
ommand.
> - * We use the path to this file to inform the UEFI binary about the boo=
t device.
> - *
> - * @dev:		device, e.g. "MMC"
> - * @devnr:		number of the device, e.g. "1:2"
> - * @path:		path to file loaded
> - * @buffer:		buffer with file loaded
> - * @buffer_size:	size of file loaded
> - */
> -void efi_set_bootdev(const char *dev, const char *devnr, const char *pa=
th,
> -		     void *buffer, size_t buffer_size)
> -{
> -	struct efi_device_path *device, *image;
> -	efi_status_t ret;
> -
> -	log_debug("dev=3D%s, devnr=3D%s, path=3D%s, buffer=3D%p, size=3D%zx\n"=
, dev,
> -		  devnr, path, buffer, buffer_size);
> -
> -	/* Forget overwritten image */
> -	if (buffer + buffer_size >=3D image_addr &&
> -	    image_addr + image_size >=3D buffer)
> -		efi_clear_bootdev();
> -
> -	/* Remember only PE-COFF and FIT images */
> -	if (efi_check_pe(buffer, buffer_size, NULL) !=3D EFI_SUCCESS) {
> -		if (IS_ENABLED(CONFIG_FIT) &&
> -		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
> -			/*
> -			 * FIT images of type EFI_OS are started via command
> -			 * bootm. We should not use their boot device with the
> -			 * bootefi command.
> -			 */
> -			buffer =3D 0;
> -			buffer_size =3D 0;
> -		} else {
> -			log_debug("- not remembering image\n");
> -			return;
> -		}
> -	}
> -
> -	/* efi_set_bootdev() is typically called repeatedly, recover memory */
> -	efi_clear_bootdev();
> -
> -	image_addr =3D buffer;
> -	image_size =3D buffer_size;
> -
> -	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
> -	if (ret =3D=3D EFI_SUCCESS) {
> -		bootefi_device_path =3D device;
> -		if (image) {
> -			/* FIXME: image should not contain device */
> -			struct efi_device_path *image_tmp =3D image;
> -
> -			efi_dp_split_file_path(image, &device, &image);
> -			efi_free_pool(image_tmp);
> -		}
> -		bootefi_image_path =3D image;
> -		log_debug("- boot device %pD\n", device);
> -		if (image)
> -			log_debug("- image %pD\n", image);
> -	} else {
> -		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> -		efi_clear_bootdev();
> -	}
> -}
> -
> -/**
> - * efi_env_set_load_options() - set load options from environment varia=
ble
> - *
> - * @handle:		the image handle
> - * @env_var:		name of the environment variable
> - * @load_options:	pointer to load options (output)
> - * Return:		status code
> - */
> -efi_status_t efi_env_set_load_options(efi_handle_t handle,
> -				      const char *env_var,
> -				      u16 **load_options)
> -{
> -	const char *env =3D env_get(env_var);
> -	size_t size;
> -	u16 *pos;
> -	efi_status_t ret;
> -
> -	*load_options =3D NULL;
> -	if (!env)
> -		return EFI_SUCCESS;
> -	size =3D sizeof(u16) * (utf8_utf16_strlen(env) + 1);
> -	pos =3D calloc(size, 1);
> -	if (!pos)
> -		return EFI_OUT_OF_RESOURCES;
> -	*load_options =3D pos;
> -	utf8_utf16_strcpy(&pos, env);
> -	ret =3D efi_set_load_options(handle, size, *load_options);
> -	if (ret !=3D EFI_SUCCESS) {
> -		free(*load_options);
> -		*load_options =3D NULL;
> -	}
> -	return ret;
> -}
> -
> -#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
> -
> -/**
> - * copy_fdt() - Copy the device tree to a new location available to EFI
> - *
> - * The FDT is copied to a suitable location within the EFI memory map.
> - * Additional 12 KiB are added to the space in case the device tree nee=
ds to be
> - * expanded later with fdt_open_into().
> - *
> - * @fdtp:	On entry a pointer to the flattened device tree.
> - *		On exit a pointer to the copy of the flattened device tree.
> - *		FDT start
> - * Return:	status code
> - */
> -static efi_status_t copy_fdt(void **fdtp)
> -{
> -	unsigned long fdt_ram_start =3D -1L, fdt_pages;
> -	efi_status_t ret =3D 0;
> -	void *fdt, *new_fdt;
> -	u64 new_fdt_addr;
> -	uint fdt_size;
> -	int i;
> -
> -	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -		u64 ram_start =3D gd->bd->bi_dram[i].start;
> -		u64 ram_size =3D gd->bd->bi_dram[i].size;
> -
> -		if (!ram_size)
> -			continue;
> -
> -		if (ram_start < fdt_ram_start)
> -			fdt_ram_start =3D ram_start;
> -	}
> -
> -	/*
> -	 * Give us at least 12 KiB of breathing room in case the device tree
> -	 * needs to be expanded later.
> -	 */
> -	fdt =3D *fdtp;
> -	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> -	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
> -
> -	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> -				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
> -				 &new_fdt_addr);
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("ERROR: Failed to reserve space for FDT\n");
> -		goto done;
> -	}
> -	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;
> -	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
> -	fdt_set_totalsize(new_fdt, fdt_size);
> -
> -	*fdtp =3D (void *)(uintptr_t)new_fdt_addr;
> -done:
> -	return ret;
> -}
> -
> -/**
> - * get_config_table() - get configuration table
> - *
> - * @guid:	GUID of the configuration table
> - * Return:	pointer to configuration table or NULL
> - */
> -static void *get_config_table(const efi_guid_t *guid)
> -{
> -	size_t i;
> -
> -	for (i =3D 0; i < systab.nr_tables; i++) {
> -		if (!guidcmp(guid, &systab.tables[i].guid))
> -			return systab.tables[i].table;
> -	}
> -	return NULL;
> -}
> -
> -#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
> -
> -/**
> - * efi_install_fdt() - install device tree
> - *
> - * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that =
memory
> - * address will be installed as configuration table, otherwise the devi=
ce
> - * tree located at the address indicated by environment variable fdt_ad=
dr or as
> - * fallback fdtcontroladdr will be used.
> - *
> - * On architectures using ACPI tables device trees shall not be install=
ed as
> - * configuration table.
> - *
> - * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use
> - *		the hardware device tree as indicated by environment variable
> - *		fdt_addr or as fallback the internal device tree as indicated by
> - *		the environment variable fdtcontroladdr
> - * Return:	status code
> - */
> -efi_status_t efi_install_fdt(void *fdt)
> -{
> -	/*
> -	 * The EBBR spec requires that we have either an FDT or an ACPI table
> -	 * but not both.
> -	 */
> -#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
> -	if (fdt) {
> -		log_warning("WARNING: Can't have ACPI table and device tree - ignorin=
g DT.\n");
> -		return EFI_SUCCESS;
> -	}
> -#else
> -	struct bootm_headers img =3D { 0 };
> -	efi_status_t ret;
> -
> -	if (fdt =3D=3D EFI_FDT_USE_INTERNAL) {
> -		const char *fdt_opt;
> -		uintptr_t fdt_addr;
> -
> -		/* Look for device tree that is already installed */
> -		if (get_config_table(&efi_guid_fdt))
> -			return EFI_SUCCESS;
> -		/* Check if there is a hardware device tree */
> -		fdt_opt =3D env_get("fdt_addr");
> -		/* Use our own device tree as fallback */
> -		if (!fdt_opt) {
> -			fdt_opt =3D env_get("fdtcontroladdr");
> -			if (!fdt_opt) {
> -				log_err("ERROR: need device tree\n");
> -				return EFI_NOT_FOUND;
> -			}
> -		}
> -		fdt_addr =3D hextoul(fdt_opt, NULL);
> -		if (!fdt_addr) {
> -			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
> -			return EFI_LOAD_ERROR;
> -		}
> -		fdt =3D map_sysmem(fdt_addr, 0);
> -	}
> -
> -	/* Install device tree */
> -	if (fdt_check_header(fdt)) {
> -		log_err("ERROR: invalid device tree\n");
> -		return EFI_LOAD_ERROR;
> -	}
> -
> -	/* Prepare device tree for payload */
> -	ret =3D copy_fdt(&fdt);
> -	if (ret) {
> -		log_err("ERROR: out of memory\n");
> -		return EFI_OUT_OF_RESOURCES;
> -	}
> -
> -	if (image_setup_libfdt(&img, fdt, NULL)) {
> -		log_err("ERROR: failed to process device tree\n");
> -		return EFI_LOAD_ERROR;
> -	}
> -
> -	/* Create memory reservations as indicated by the device tree */
> -	efi_carve_out_dt_rsv(fdt);
> -
> -	efi_try_purge_kaslr_seed(fdt);
> -
> -	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> -		ret =3D efi_tcg2_measure_dtb(fdt);
> -		if (ret =3D=3D EFI_SECURITY_VIOLATION) {
> -			log_err("ERROR: failed to measure DTB\n");
> -			return ret;
> -		}
> -	}
> -
> -	/* Install device tree as UEFI table */
> -	ret =3D efi_install_configuration_table(&efi_guid_fdt, fdt);
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("ERROR: failed to install device tree\n");
> -		return ret;
> -	}
> -#endif /* GENERATE_ACPI_TABLE */
> -
> -	return EFI_SUCCESS;
> -}
> -
> -/**
> - * do_bootefi_exec() - execute EFI binary
> - *
> - * The image indicated by @handle is started. When it returns the alloc=
ated
> - * memory for the @load_options is freed.
> - *
> - * @handle:		handle of loaded image
> - * @load_options:	load options
> - * Return:		status code
> - *
> - * Load the EFI binary into a newly assigned memory unwinding the reloc=
ation
> - * information, install the loaded image protocol, and call the binary.
> - */
> -static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_opt=
ions)
> -{
> -	efi_status_t ret;
> -	efi_uintn_t exit_data_size =3D 0;
> -	u16 *exit_data =3D NULL;
> -	struct efi_event *evt;
> -
> -	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
> -	switch_to_non_secure_mode();
> -
> -	/*
> -	 * The UEFI standard requires that the watchdog timer is set to five
> -	 * minutes when invoking an EFI boot option.
> -	 *
> -	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
> -	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTim=
er
> -	 */
> -	ret =3D efi_set_watchdog(300);
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("ERROR: Failed to set watchdog timer\n");
> -		goto out;
> -	}
> -
> -	/* Call our payload! */
> -	ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data))=
;
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("## Application failed, r =3D %lu\n",
> -			ret & ~EFI_ERROR_MASK);
> -		if (exit_data) {
> -			log_err("## %ls\n", exit_data);
> -			efi_free_pool(exit_data);
> -		}
> -	}
> -
> -	efi_restore_gd();
> -
> -out:
> -	free(load_options);
> -
> -	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -		if (efi_initrd_deregister() !=3D EFI_SUCCESS)
> -			log_err("Failed to remove loadfile2 for initrd\n");
> -	}
> -
> -	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
> -	list_for_each_entry(evt, &efi_events, link) {
> -		if (evt->group &&
> -		    !guidcmp(evt->group,
> -			     &efi_guid_event_group_return_to_efibootmgr)) {
> -			efi_signal_event(evt);
> -			EFI_CALL(systab.boottime->close_event(evt));
> -			break;
> -		}
> -	}
> -
> -	/* Control is returned to U-Boot, disable EFI watchdog */
> -	efi_set_watchdog(0);
> -
> -	return ret;
> -}
> -
>   /**
>    * efi_bootmgr_run() - execute EFI boot manager
>    * @fdt:	Flat device tree
> @@ -1548,100 +1152,3 @@ efi_status_t efi_bootmgr_run(void *fdt)
>
>   	return do_bootefi_exec(handle, load_options);
>   }
> -
> -/**
> - * efi_run_image() - run loaded UEFI image
> - *
> - * @source_buffer:	memory address of the UEFI image
> - * @source_size:	size of the UEFI image
> - * Return:		status code
> - */
> -efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size=
)
> -{
> -	efi_handle_t mem_handle =3D NULL, handle;
> -	struct efi_device_path *file_path =3D NULL;
> -	struct efi_device_path *msg_path;
> -	efi_status_t ret, ret2;
> -	u16 *load_options;
> -
> -	if (!bootefi_device_path || !bootefi_image_path) {
> -		log_debug("Not loaded from disk\n");
> -		/*
> -		 * Special case for efi payload not loaded from disk,
> -		 * such as 'bootefi hello' or for example payload
> -		 * loaded directly into memory via JTAG, etc:
> -		 */
> -		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -					    (uintptr_t)source_buffer,
> -					    source_size);
> -		/*
> -		 * Make sure that device for device_path exist
> -		 * in load_image(). Otherwise, shell and grub will fail.
> -		 */
> -		ret =3D efi_install_multiple_protocol_interfaces(&mem_handle,
> -							       &efi_guid_device_path,
> -							       file_path, NULL);
> -		if (ret !=3D EFI_SUCCESS)
> -			goto out;
> -		msg_path =3D file_path;
> -	} else {
> -		file_path =3D efi_dp_append(bootefi_device_path,
> -					  bootefi_image_path);
> -		msg_path =3D bootefi_image_path;
> -		log_debug("Loaded from disk\n");
> -	}
> -
> -	log_info("Booting %pD\n", msg_path);
> -
> -	ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path, source_buf=
fer,
> -				      source_size, &handle));
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("Loading image failed\n");
> -		goto out;
> -	}
> -
> -	/* Transfer environment variable as load options */
> -	ret =3D efi_env_set_load_options(handle, "bootargs", &load_options);
> -	if (ret !=3D EFI_SUCCESS)
> -		goto out;
> -
> -	ret =3D do_bootefi_exec(handle, load_options);
> -
> -out:
> -	ret2 =3D efi_uninstall_multiple_protocol_interfaces(mem_handle,
> -							  &efi_guid_device_path,
> -							  file_path, NULL);
> -	efi_free_pool(file_path);
> -	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
> -}
> -
> -/**
> - * efi_binary_run() - run loaded UEFI image
> - *
> - * @image:	memory address of the UEFI image
> - * @size:	size of the UEFI image
> - * @fdt:	device-tree
> - *
> - * Execute an EFI binary image loaded at @image.
> - * @size may be zero if the binary is loaded with U-Boot load command.
> - *
> - * Return:	status code
> - */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> -{
> -	efi_status_t ret;
> -
> -	/* Initialize EFI drivers */
> -	ret =3D efi_init_obj_list();
> -	if (ret !=3D EFI_SUCCESS) {
> -		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> -			ret & ~EFI_ERROR_MASK);
> -		return -1;
> -	}
> -
> -	ret =3D efi_install_fdt(fdt);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> -
> -	return efi_run_image(image, size);
> -}
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index ed7214f3a347..786d8a70e2ad 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1090,7 +1090,8 @@ efi_status_t efi_dp_from_name(const char *dev, con=
st char *devnr,
>   	if (path && !file)
>   		return EFI_INVALID_PARAMETER;
>
> -	if (!strcmp(dev, "Mem") || !strcmp(dev, "hostfs"))  {
> +	if (IS_ENABLED(CONFIG_EFI_BINARY_EXEC) &&
> +	    (!strcmp(dev, "Mem") || !strcmp(dev, "hostfs")))  {
>   		/* loadm command and semihosting */
>   		efi_get_image_parameters(&image_addr, &image_size);
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index cdfd16ea7742..79a2a579e901 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -1,17 +1,28 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Copyright (c) 2020, Linaro Limited
> + * For the code moved from cmd/bootefi.c
> + * Copyright (c) 2016 Alexander Graf
>    */
>
>   #define LOG_CATEGORY LOGC_EFI
> +#include <bootm.h>
>   #include <common.h>
> -#include <env.h>
> -#include <malloc.h>
>   #include <dm.h>
> -#include <fs.h>
>   #include <efi_load_initrd.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <vsprintf.h>
> +#include <asm/global_data.h>
> +#include <linux/libfdt.h>
> +#include <linux/libfdt_env.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
>
>   #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INIT=
RD)
>   /* GUID used by Linux to identify the LoadFile2 protocol with the init=
rd */
> @@ -282,3 +293,485 @@ bool efi_search_bootorder(u16 *bootorder, efi_uint=
n_t num, u32 target, u32 *inde
>
>   	return false;
>   }
> +
> +#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
> +
> +/**
> + * copy_fdt() - Copy the device tree to a new location available to EFI
> + *
> + * The FDT is copied to a suitable location within the EFI memory map.
> + * Additional 12 KiB are added to the space in case the device tree nee=
ds to be
> + * expanded later with fdt_open_into().
> + *
> + * @fdtp:	On entry a pointer to the flattened device tree.
> + *		On exit a pointer to the copy of the flattened device tree.
> + *		FDT start
> + * Return:	status code
> + */
> +static efi_status_t copy_fdt(void **fdtp)
> +{
> +	unsigned long fdt_ram_start =3D -1L, fdt_pages;
> +	efi_status_t ret =3D 0;
> +	void *fdt, *new_fdt;
> +	u64 new_fdt_addr;
> +	uint fdt_size;
> +	int i;
> +
> +	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		u64 ram_start =3D gd->bd->bi_dram[i].start;
> +		u64 ram_size =3D gd->bd->bi_dram[i].size;
> +
> +		if (!ram_size)
> +			continue;
> +
> +		if (ram_start < fdt_ram_start)
> +			fdt_ram_start =3D ram_start;
> +	}
> +
> +	/*
> +	 * Give us at least 12 KiB of breathing room in case the device tree
> +	 * needs to be expanded later.
> +	 */
> +	fdt =3D *fdtp;
> +	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> +	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
> +
> +	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
> +				 &new_fdt_addr);
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("ERROR: Failed to reserve space for FDT\n");
> +		goto done;
> +	}
> +	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;
> +	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
> +	fdt_set_totalsize(new_fdt, fdt_size);
> +
> +	*fdtp =3D (void *)(uintptr_t)new_fdt_addr;
> +done:
> +	return ret;
> +}
> +
> +/**
> + * get_config_table() - get configuration table
> + *
> + * @guid:	GUID of the configuration table
> + * Return:	pointer to configuration table or NULL
> + */
> +static void *get_config_table(const efi_guid_t *guid)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < systab.nr_tables; i++) {
> +		if (!guidcmp(guid, &systab.tables[i].guid))
> +			return systab.tables[i].table;
> +	}
> +	return NULL;
> +}
> +
> +#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
> +
> +/**
> + * efi_install_fdt() - install device tree
> + *
> + * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that =
memory
> + * address will be installed as configuration table, otherwise the devi=
ce
> + * tree located at the address indicated by environment variable fdt_ad=
dr or as
> + * fallback fdtcontroladdr will be used.
> + *
> + * On architectures using ACPI tables device trees shall not be install=
ed as
> + * configuration table.
> + *
> + * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use
> + *		the hardware device tree as indicated by environment variable
> + *		fdt_addr or as fallback the internal device tree as indicated by
> + *		the environment variable fdtcontroladdr
> + * Return:	status code
> + */
> +efi_status_t efi_install_fdt(void *fdt)
> +{
> +	/*
> +	 * The EBBR spec requires that we have either an FDT or an ACPI table
> +	 * but not both.
> +	 */
> +#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
> +	if (fdt) {
> +		log_warning("WARNING: Can't have ACPI table and device tree - ignorin=
g DT.\n");
> +		return EFI_SUCCESS;
> +	}
> +#else
> +	struct bootm_headers img =3D { 0 };
> +	efi_status_t ret;
> +
> +	if (fdt =3D=3D EFI_FDT_USE_INTERNAL) {
> +		const char *fdt_opt;
> +		uintptr_t fdt_addr;
> +
> +		/* Look for device tree that is already installed */
> +		if (get_config_table(&efi_guid_fdt))
> +			return EFI_SUCCESS;
> +		/* Check if there is a hardware device tree */
> +		fdt_opt =3D env_get("fdt_addr");
> +		/* Use our own device tree as fallback */
> +		if (!fdt_opt) {
> +			fdt_opt =3D env_get("fdtcontroladdr");
> +			if (!fdt_opt) {
> +				log_err("ERROR: need device tree\n");
> +				return EFI_NOT_FOUND;
> +			}
> +		}
> +		fdt_addr =3D hextoul(fdt_opt, NULL);
> +		if (!fdt_addr) {
> +			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
> +			return EFI_LOAD_ERROR;
> +		}
> +		fdt =3D map_sysmem(fdt_addr, 0);
> +	}
> +
> +	/* Install device tree */
> +	if (fdt_check_header(fdt)) {
> +		log_err("ERROR: invalid device tree\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +
> +	/* Prepare device tree for payload */
> +	ret =3D copy_fdt(&fdt);
> +	if (ret) {
> +		log_err("ERROR: out of memory\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	if (image_setup_libfdt(&img, fdt, NULL)) {
> +		log_err("ERROR: failed to process device tree\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +
> +	/* Create memory reservations as indicated by the device tree */
> +	efi_carve_out_dt_rsv(fdt);
> +
> +	efi_try_purge_kaslr_seed(fdt);
> +
> +	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> +		ret =3D efi_tcg2_measure_dtb(fdt);
> +		if (ret =3D=3D EFI_SECURITY_VIOLATION) {
> +			log_err("ERROR: failed to measure DTB\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Install device tree as UEFI table */
> +	ret =3D efi_install_configuration_table(&efi_guid_fdt, fdt);
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("ERROR: failed to install device tree\n");
> +		return ret;
> +	}
> +#endif /* GENERATE_ACPI_TABLE */
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * do_bootefi_exec() - execute EFI binary
> + *
> + * The image indicated by @handle is started. When it returns the alloc=
ated
> + * memory for the @load_options is freed.
> + *
> + * @handle:		handle of loaded image
> + * @load_options:	load options
> + * Return:		status code
> + *
> + * Load the EFI binary into a newly assigned memory unwinding the reloc=
ation
> + * information, install the loaded image protocol, and call the binary.
> + */
> +efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
> +{
> +	efi_status_t ret;
> +	efi_uintn_t exit_data_size =3D 0;
> +	u16 *exit_data =3D NULL;
> +	struct efi_event *evt;
> +
> +	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
> +	switch_to_non_secure_mode();
> +
> +	/*
> +	 * The UEFI standard requires that the watchdog timer is set to five
> +	 * minutes when invoking an EFI boot option.
> +	 *
> +	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
> +	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTim=
er
> +	 */
> +	ret =3D efi_set_watchdog(300);
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("ERROR: Failed to set watchdog timer\n");
> +		goto out;
> +	}
> +
> +	/* Call our payload! */
> +	ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data))=
;
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("## Application failed, r =3D %lu\n",
> +			ret & ~EFI_ERROR_MASK);
> +		if (exit_data) {
> +			log_err("## %ls\n", exit_data);
> +			efi_free_pool(exit_data);
> +		}
> +	}
> +
> +	efi_restore_gd();
> +
> +out:
> +	free(load_options);
> +
> +	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> +		if (efi_initrd_deregister() !=3D EFI_SUCCESS)
> +			log_err("Failed to remove loadfile2 for initrd\n");
> +	}
> +
> +	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
> +	list_for_each_entry(evt, &efi_events, link) {
> +		if (evt->group &&
> +		    !guidcmp(evt->group,
> +			     &efi_guid_event_group_return_to_efibootmgr)) {
> +			efi_signal_event(evt);
> +			EFI_CALL(systab.boottime->close_event(evt));
> +			break;
> +		}
> +	}
> +
> +	/* Control is returned to U-Boot, disable EFI watchdog */
> +	efi_set_watchdog(0);
> +
> +	return ret;
> +}
> +
> +#if CONFIG_IS_ENABLED(EFI_BINARY_EXEC)
> +static struct efi_device_path *bootefi_image_path;
> +static struct efi_device_path *bootefi_device_path;
> +static void *image_addr;
> +static size_t image_size;
> +
> +/**
> + * efi_get_image_parameters() - return image parameters
> + *
> + * @img_addr:		address of loaded image in memory
> + * @img_size:		size of loaded image
> + */
> +void efi_get_image_parameters(void **img_addr, size_t *img_size)
> +{
> +	*img_addr =3D image_addr;
> +	*img_size =3D image_size;
> +}
> +
> +/**
> + * efi_clear_bootdev() - clear boot device
> + */
> +void efi_clear_bootdev(void)
> +{
> +	efi_free_pool(bootefi_device_path);
> +	efi_free_pool(bootefi_image_path);
> +	bootefi_device_path =3D NULL;
> +	bootefi_image_path =3D NULL;
> +	image_addr =3D NULL;
> +	image_size =3D 0;
> +}
> +
> +/**
> + * efi_set_bootdev() - set boot device
> + *
> + * This function is called when a file is loaded, e.g. via the 'load' c=
ommand.
> + * We use the path to this file to inform the UEFI binary about the boo=
t device.
> + *
> + * @dev:		device, e.g. "MMC"
> + * @devnr:		number of the device, e.g. "1:2"
> + * @path:		path to file loaded
> + * @buffer:		buffer with file loaded
> + * @buffer_size:	size of file loaded
> + */
> +void efi_set_bootdev(const char *dev, const char *devnr, const char *pa=
th,
> +		     void *buffer, size_t buffer_size)
> +{
> +	struct efi_device_path *device, *image;
> +	efi_status_t ret;
> +
> +	log_debug("dev=3D%s, devnr=3D%s, path=3D%s, buffer=3D%p, size=3D%zx\n"=
, dev,
> +		  devnr, path, buffer, buffer_size);
> +
> +	/* Forget overwritten image */
> +	if (buffer + buffer_size >=3D image_addr &&
> +	    image_addr + image_size >=3D buffer)
> +		efi_clear_bootdev();
> +
> +	/* Remember only PE-COFF and FIT images */
> +	if (efi_check_pe(buffer, buffer_size, NULL) !=3D EFI_SUCCESS) {
> +		if (IS_ENABLED(CONFIG_FIT) &&
> +		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
> +			/*
> +			 * FIT images of type EFI_OS are started via command
> +			 * bootm. We should not use their boot device with the
> +			 * bootefi command.
> +			 */
> +			buffer =3D 0;
> +			buffer_size =3D 0;
> +		} else {
> +			log_debug("- not remembering image\n");
> +			return;
> +		}
> +	}
> +
> +	/* efi_set_bootdev() is typically called repeatedly, recover memory */
> +	efi_clear_bootdev();
> +
> +	image_addr =3D buffer;
> +	image_size =3D buffer_size;
> +
> +	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
> +	if (ret =3D=3D EFI_SUCCESS) {
> +		bootefi_device_path =3D device;
> +		if (image) {
> +			/* FIXME: image should not contain device */
> +			struct efi_device_path *image_tmp =3D image;
> +
> +			efi_dp_split_file_path(image, &device, &image);
> +			efi_free_pool(image_tmp);
> +		}
> +		bootefi_image_path =3D image;
> +		log_debug("- boot device %pD\n", device);
> +		if (image)
> +			log_debug("- image %pD\n", image);
> +	} else {
> +		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
> +		efi_clear_bootdev();
> +	}
> +}
> +
> +/**
> + * efi_env_set_load_options() - set load options from environment varia=
ble
> + *
> + * @handle:		the image handle
> + * @env_var:		name of the environment variable
> + * @load_options:	pointer to load options (output)
> + * Return:		status code
> + */
> +efi_status_t efi_env_set_load_options(efi_handle_t handle,
> +				      const char *env_var,
> +				      u16 **load_options)
> +{
> +	const char *env =3D env_get(env_var);
> +	size_t size;
> +	u16 *pos;
> +	efi_status_t ret;
> +
> +	*load_options =3D NULL;
> +	if (!env)
> +		return EFI_SUCCESS;
> +	size =3D sizeof(u16) * (utf8_utf16_strlen(env) + 1);
> +	pos =3D calloc(size, 1);
> +	if (!pos)
> +		return EFI_OUT_OF_RESOURCES;
> +	*load_options =3D pos;
> +	utf8_utf16_strcpy(&pos, env);
> +	ret =3D efi_set_load_options(handle, size, *load_options);
> +	if (ret !=3D EFI_SUCCESS) {
> +		free(*load_options);
> +		*load_options =3D NULL;
> +	}
> +	return ret;
> +}
> +
> +/**
> + * efi_run_image() - run loaded UEFI image
> + *
> + * @source_buffer:	memory address of the UEFI image
> + * @source_size:	size of the UEFI image
> + * Return:		status code
> + */
> +efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size=
)
> +{
> +	efi_handle_t mem_handle =3D NULL, handle;
> +	struct efi_device_path *file_path =3D NULL;
> +	struct efi_device_path *msg_path;
> +	efi_status_t ret, ret2;
> +	u16 *load_options;
> +
> +	if (!bootefi_device_path || !bootefi_image_path) {
> +		log_debug("Not loaded from disk\n");
> +		/*
> +		 * Special case for efi payload not loaded from disk,
> +		 * such as 'bootefi hello' or for example payload
> +		 * loaded directly into memory via JTAG, etc:
> +		 */
> +		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +					    (uintptr_t)source_buffer,
> +					    source_size);
> +		/*
> +		 * Make sure that device for device_path exist
> +		 * in load_image(). Otherwise, shell and grub will fail.
> +		 */
> +		ret =3D efi_install_multiple_protocol_interfaces(&mem_handle,
> +							       &efi_guid_device_path,
> +							       file_path, NULL);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +		msg_path =3D file_path;
> +	} else {
> +		file_path =3D efi_dp_append(bootefi_device_path,
> +					  bootefi_image_path);
> +		msg_path =3D bootefi_image_path;
> +		log_debug("Loaded from disk\n");
> +	}
> +
> +	log_info("Booting %pD\n", msg_path);
> +
> +	ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path, source_buf=
fer,
> +				      source_size, &handle));
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("Loading image failed\n");
> +		goto out;
> +	}
> +
> +	/* Transfer environment variable as load options */
> +	ret =3D efi_env_set_load_options(handle, "bootargs", &load_options);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	ret =3D do_bootefi_exec(handle, load_options);
> +
> +out:
> +	ret2 =3D efi_uninstall_multiple_protocol_interfaces(mem_handle,
> +							  &efi_guid_device_path,
> +							  file_path, NULL);
> +	efi_free_pool(file_path);
> +	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
> +}
> +
> +/**
> + * efi_binary_run() - run loaded UEFI image
> + *
> + * @image:	memory address of the UEFI image
> + * @size:	size of the UEFI image
> + * @fdt:	device-tree
> + *
> + * Execute an EFI binary image loaded at @image.
> + * @size may be zero if the binary is loaded with U-Boot load command.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +{
> +	efi_status_t ret;
> +
> +	/* Initialize EFI drivers */
> +	ret =3D efi_init_obj_list();
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +			ret & ~EFI_ERROR_MASK);
> +		return -1;
> +	}
> +
> +	ret =3D efi_install_fdt(fdt);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	return efi_run_image(image, size);
> +}
> +#endif /* CONFIG_BINARY_EXEC */

