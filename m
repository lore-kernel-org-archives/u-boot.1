Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00233CDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 00:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C8986C6E;
	Wed, 18 Oct 2023 02:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QI6wTVIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E74F86ECF; Wed, 18 Oct 2023 02:42:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6568647E
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 02:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697589760; x=1698194560; i=xypron.glpk@gmx.de;
 bh=XFgODoKh+IHk/us6Q6oRJ3mYwwIRIf5Kdtt0bymfAlg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QI6wTVIfqHOxGU7+1+6RvX2Zf6QLREabecpKP7+RXcPzN4vgwi7IoINyF2HYcWC7
 NoHyMeyFPU8/OiX5NlPIRIs/XbQG3yfFPPX5kctap0zQ1FBSZAvsEMEdD4lM4Zy8t
 xohvoGfsQBOoRTcKi6HLNAPTVtB/e+5ft5h6DFf2nkwXFvohZ4O/lQl5A33RqD+/r
 9wfssXyN4j5pIptPctzyH5yGeeN6gKojAOIENTiyf0Tj67a+F0gBLBQpVJbXkHGVF
 XJRpaG7CwcThn8H9I8EGXa5neeJ4y2WGBTqm8gzSlhcTqIjaphvgR/1RIPP/lNV7x
 88cQLvvU0FPSeYfAng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1quZLO1RmM-007HZk; Wed, 18
 Oct 2023 02:42:40 +0200
Message-ID: <4da03160-889b-4a7e-8476-0f93cf3998c2@gmx.de>
Date: Wed, 18 Oct 2023 02:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/9] efi_loader: support boot from URI device path
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-6-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231016064526.2410856-6-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TTw569TFPhQu6XMUFs6OaSI6mWL5HhwTtPzq3+FUoyt4f3um67Q
 jP7rr284eXshqYkhOQRoGYXX4Ml3gvXOKBMdGHfxZBG74hl8PxvrChhF6a3ApYxxTlYPK2J
 6iGGukYCcjkcfPj1f/MZbiLptysuYjPsiSd9/H8mxyNydKzLf0M6NaQPtRyT2uOlgKPr+CX
 fZk/yaTU8BSohnN9SJOog==
UI-OutboundReport: notjunk:1;M01:P0:NPesmoiQFh4=;GaKocHJ3dZPRYw4Yv2UfdMvASdE
 WYdcZDORSb0WxbrHG6onLe66+E6vct0LNAKnIpeYdgrPuONOQSiJwdKGeUxoZXQvHeiBTIRzU
 raJR/Q9QVjCF7V2+zArFJ5xyw8BoV1t42gzywh0osS2CJ8Xo4TC0UH4w3Gbzln9MFShLvE4Rc
 dFvgM1X4X/WmvqdxyXO4QTG3gplaE1tu2yWMoDCQTQhj1KIYsh/s0u6DidBqpYsyxqv164wud
 WxRo73cqPbILvkGSJhkllADE+eFu1GssHJL8ZoKyxRBzmsqYLUAKPQ/+cMb+T/2o5vDt70mRz
 k5gybyWo/zvqYUkrmPzvJ2pG/KZL/xYYqDrRM3mTCOsSNykCzyIok7iRxBvyRJn6rbBd9R47y
 s1caw2NmwlOWQWUreMiqeiZH4y3eaoIiVlymnq+biXkfQro5I8p2wWoZJmU27rL/e4KNr05+Y
 V+EEgUB+kNeH4gKR+690TselDfZB+uMPK6gEWmjS0zt8h/GZFTkSYI6h0IxBM0f4aIMsVE5Eq
 RjTZo72U85wSJl6ePV5vTdZDzF538I4m/Zi4ZcoOndL/3REWKAW82rs6NuHKOhq/6VgVCYns3
 92zPl/pFllTUUaToBa/hKZ4q1jbIz2DOZ1a8nY0mWlLb74w7wccr05hGVF6Hf3nEfLIuiFNAJ
 9ROz9bGYHWuUbUJ6tKJ/QG1aWR78+xnek8so/S8EUvhdYtxdgueaN+jwAco/szzbrIjD5wQxk
 exYC51BUyLTSN5QqL+SbwRBJcjl8MEZjGMLMyk9yGLs1DB+PZoIhYyxRaCwyrDq0kEPQq6qcs
 B+mPy++z73cRyS9ofS8o20iY7huTvqdvqCoawhz4O6HiJy0SpmdTiS99A3i8g9bmL049taXM9
 hvGiDZ9g+ai5jgSGowaQZS5x7RxthzG3vycFiMFkjZKspXqBIiLT1IPeXIh+EWruYApsmI/x6
 CC2kL/yT6pVsqiOiigiE5wrXvBk=
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

On 16.10.23 08:45, Masahisa Kojima wrote:
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> Since boot option indicating the default file is automatically
> created when new disk is detected, system can boot by selecting
> the automatically created blkmap boot option.
> If the file is PE-COFF file, load and start the downloaded file.
>
> The buffer used to download the ISO image file must be
> reserved to avoid the unintended access to the image.
> For PE-COFF file case, this memory reservation is done
> in LoadImage Boot Service.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   include/efi_loader.h          |   2 +
>   lib/efi_loader/Kconfig        |   9 ++
>   lib/efi_loader/efi_bootmgr.c  | 198 ++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_dt_fixup.c |   2 +-
>   4 files changed, 210 insertions(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f..106006127b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -554,6 +554,8 @@ void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
>   efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
>   					void **address);
> +/* add reserved memory to memory map */
> +void efi_reserve_memory(u64 addr, u64 size, bool nomap);
>   /* Carve out DT reserved memory ranges */
>   void efi_carve_out_dt_rsv(void *fdt);
>   /* Purge unused kaslr-seed */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d20aaab6db..5d99206dc3 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
>   	  replace the transfer via the device-tree. The latter is not
>   	  possible on systems using ACPI.
>
> +config EFI_HTTP_BOOT
> +	bool "EFI HTTP Boot support"
> +	depends on CMD_DNS
> +	depends on CMD_WGET
> +	depends on BLKMAP
> +	help
> +	  Enabling this option adds EFI HTTP Boot support. It allows to
> +	  directly boot from network.
> +
>   endif
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c8cf1c5506..c90b68f783 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -7,10 +7,14 @@
>
>   #define LOG_CATEGORY LOGC_EFI
>
> +#include <blk.h>
> +#include <blkmap.h>
>   #include <common.h>
>   #include <charset.h>
> +#include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <net.h>
>   #include <efi_default_filename.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> @@ -168,6 +172,192 @@ out:
>   	return ret;
>   }
>
> +/**
> + * mount_image() - mount the image with blkmap
> + *
> + * @lo_label:	u16 label string of load option
> + * @image_addr:	image address
> + * @image_size:	image size
> + * Return:	pointer to the UCLASS_BLK udevice, NULL if failed
> + */
> +static struct udevice *mount_image(u16 *lo_label, ulong image_addr, int=
 image_size)
> +{
> +	int err;
> +	struct blkmap *bm;
> +	struct udevice *bm_dev;
> +	char *label =3D NULL, *p;
> +
> +	label =3D efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> +	if (!label)
> +		return NULL;
> +
> +	p =3D label;
> +	utf16_utf8_strcpy(&p, lo_label);
> +	err =3D blkmap_create_ramdisk(label, image_addr, image_size, &bm_dev);
> +	if (err) {
> +		efi_free_pool(label);
> +		return NULL;
> +	}
> +	bm =3D dev_get_plat(bm_dev);
> +
> +	efi_free_pool(label);
> +
> +	return bm->blk;
> +}
> +
> +/**
> + * load_mounted_image() - load mounted image with default file
> + *
> + * @devnum:	target blkmap device
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t load_mounted_image(int devnum, efi_handle_t *handle=
)
> +{
> +	u32 i;
> +	u16 *bm_label, *p;
> +	char device_name[12];
> +	u16 *bootorder =3D NULL;
> +	efi_uintn_t num, size;
> +	void *load_option =3D NULL;
> +	struct efi_load_option lo;
> +	u16 varname[] =3D u"Boot####";
> +	efi_status_t ret =3D EFI_NOT_FOUND;
> +
> +	snprintf(device_name, 12, "blkmap %d", devnum);
> +	bm_label =3D calloc(1, (strlen(device_name) + 1) * sizeof(u16));
> +	if (!bm_label)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	p =3D bm_label;
> +	utf8_utf16_strcpy(&p, device_name);
> +
> +	bootorder =3D efi_get_var(u"BootOrder", &efi_global_variable_guid, &si=
ze);
> +	if (!bootorder)
> +		goto out;
> +
> +	num =3D size / sizeof(u16);
> +	for (i =3D 0; i < num; i++) {
> +		efi_create_indexed_name(varname, sizeof(varname), "Boot",
> +					bootorder[i]);
> +		load_option =3D efi_get_var(varname, &efi_global_variable_guid, &size=
);
> +		if (!load_option)
> +			continue;
> +
> +		ret =3D efi_deserialize_load_option(&lo, load_option, &size);
> +		if (ret !=3D EFI_SUCCESS) {
> +			free(load_option);
> +			continue;
> +		}
> +
> +		/* check whether the label indicates the target blkmap device */
> +		if (u16_strncmp(bm_label, lo.label, u16_strlen(bm_label))) {
> +			free(load_option);
> +			continue;
> +		}
> +
> +		/* check whether the boot option is automatically generated */
> +		if (guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated)) {
> +			free(load_option);
> +			continue;
> +		}
> +
> +		ret =3D EFI_CALL(efi_load_image(true, efi_root, lo.file_path,
> +					      NULL, 0, handle));
> +		free(load_option);
> +		goto out;
> +	}
> +
> +	if (i =3D=3D num)
> +		ret =3D EFI_NOT_FOUND;
> +out:
> +	free(bm_label);
> +	free(bootorder);
> +
> +	return ret;
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:	uri device path
> + * @lo_label:	label of load option
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *=
uridp,
> +					   u16 *lo_label,
> +					   efi_handle_t *handle)
> +{
> +	char *s;
> +	int err;
> +	int uri_len;
> +	u32 image_size;
> +	efi_status_t ret;
> +	ulong image_addr;
> +
> +	s =3D env_get("loadaddr");
> +	if (!s) {
> +		log_err("Error: loadaddr is not set\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +	image_addr =3D hextoul(s, NULL);
> +	err =3D wget_with_dns(image_addr, uridp->uri);
> +	if (err < 0)
> +		return EFI_INVALID_PARAMETER;
> +	image_size =3D env_get_hex("filesize", 0);
> +	if (!image_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/*
> +	 * If the file extension is ".iso" or ".img", mount it and try to load
> +	 * the default file.
> +	 * If the file is PE-COFF image, load the downloaded file.
> +	 */
> +	uri_len =3D strlen(uridp->uri);
> +	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> +	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +		struct udevice *blk;
> +		struct blk_desc *desc;
> +
> +		blk =3D mount_image(lo_label, image_addr, image_size);
> +		if (!blk)
> +			return EFI_LOAD_ERROR;
> +
> +		/*
> +		 * When the new disk is detected, boot option is automatically
> +		 * created if it has a default file.
> +		 * Let's load the automatically created boot option.
> +		 */
> +		desc =3D dev_get_uclass_plat(blk);
> +		ret =3D load_mounted_image(desc->devnum, handle);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +
> +		/* whole ramdisk must be reserved */
> +		efi_reserve_memory(image_addr, image_size, true);

This comment is not enough to explain why you make the reservation.

Our blkmap driver is gone after ExitBootServices().
Why is EFI_LOADER_DATA not good enough?
How will the image be passed to Linux?

Best regards

Heinrich


> +	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D E=
FI_SUCCESS) {
> +		efi_handle_t mem_handle =3D NULL;
> +		struct efi_device_path *file_path;
> +
> +		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +					    (uintptr_t)image_addr, image_size);
> +		ret =3D efi_install_multiple_protocol_interfaces(
> +			&mem_handle, &efi_guid_device_path, file_path, NULL);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +
> +		ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path,
> +					      (void *)image_addr, image_size,
> +					      handle));
> +	} else {
> +		log_err("Error: file type is not supported\n");
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * try_load_entry() - try to load image for boot option
>    *
> @@ -211,6 +401,14 @@ static efi_status_t try_load_entry(u16 n, efi_handl=
e_t *handle,
>   		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>   			/* file_path doesn't contain a device path */
>   			ret =3D try_load_from_short_path(lo.file_path, handle);
> +		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +				ret =3D try_load_from_uri_path(
> +					(struct efi_device_path_uri *)
> +						lo.file_path,
> +					lo.label, handle);
> +			else
> +				ret =3D EFI_LOAD_ERROR;
>   		} else {
>   			file_path =3D expand_media_path(lo.file_path);
>   			ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path,
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup=
.c
> index 838023c78f..edc515b9ff 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -22,7 +22,7 @@ const efi_guid_t efi_guid_dt_fixup_protocol =3D EFI_DT=
_FIXUP_PROTOCOL_GUID;
>    * @nomap:	indicates that the memory range shall not be accessed by th=
e
>    *		UEFI payload
>    */
> -static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
> +void efi_reserve_memory(u64 addr, u64 size, bool nomap)
>   {
>   	int type;
>   	efi_uintn_t ret;

