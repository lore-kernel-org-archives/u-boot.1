Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D4AC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 06:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5798457D;
	Fri,  8 Aug 2025 08:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SzwnC/CL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0008457E; Fri,  8 Aug 2025 08:51:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B490584559
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 08:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1754635837; x=1755240637; i=xypron.glpk@gmx.de;
 bh=TTrTczdkUl0l70o79Kcx9ZiGyANHdsT6TNC9vW/5qPs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SzwnC/CLcRb8CGu1HwrHdElTKTylXjOxcd6p6cFkqNK8UhGPCfOycy/Sb42ZLx93
 BQnYqZG7VdczGqtjBaULvDWstT4j7p8lN8az+3RipDn5/7GpD7tupzy7EEKOk+URA
 zukBZL8T+U/HfZpmTjQBZJNtFXC3i4Dpcyc1dypGOBsMGXTMVwVPKtPErOCb7dx0f
 Eol6LqL6eTf9RN7t4fdcN1rfMzsHrdNtyiED48PlYx/gZy9RcouLWLMXH7nwxzCm9
 /ImALYweDS24/eYM/Fiu06H9PsdfBI99JpNgOS6st4euvzz4hejHmcQSlJGkEmYXD
 hoUEMwWDS12CwN2DPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1v4PBO0t1n-00Ryr5; Fri, 08
 Aug 2025 08:50:37 +0200
Message-ID: <bd9f40ef-d644-4d1b-b21d-b17cfa74d2ca@gmx.de>
Date: Fri, 8 Aug 2025 08:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
To: Javier Tia <javier.tia@linaro.org>
References: <20250805162158.117876-1-javier.tia@linaro.org>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250805162158.117876-1-javier.tia@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:asVwhyXY/RFHHVm8J5jtSiZz+IddZcjkCWQf1akq4sF9PKVCIRw
 NSb5pAlxxfbGc0O1/BASXgyeVXpyAoBUt85Xm8XFDnLsMIYZ9etHbrOeCLKwy29ac/fMqBt
 uKf8zZMf3vRswjv5YNfYTyUPpG7ewPpsA88fQwxWI0kg3MU/4ULVJyflsgXENPlpZWYaEy9
 A2Wld2MboFNz/6CamTLxA==
UI-OutboundReport: notjunk:1;M01:P0:GCzxAU+mXJw=;mdLx4v5PGzuogOs/LuaiK3nP+RS
 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
 Xo3ylCFU9wQ==
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

On 05.08.25 18:21, Javier Tia wrote:
> Refines the disk image detection mechanism in the EFI boot manager.
> Instead of relying on file extensions, the updated code uses the
> partition driver lookup function to determine if a downloaded file is a
> valid disk image.
>=20
> The change enhances the robustness of the boot manager by providing a
> more accurate disk image detection. It also improves error handling by
> adding a cleanup function for temporary block devices.
>=20
> The partition driver lookup function is also made public to enable its
> use in the EFI boot manager. The function documentation is updated
> accordingly.
>=20
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>   disk/part.c                  |  3 +-
>   include/part.h               | 18 +++++++++++
>   lib/efi_loader/efi_bootmgr.c | 59 ++++++++++++++++++++++++++++++------
>   3 files changed, 70 insertions(+), 10 deletions(-)
>=20
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..adc24976624 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int pa=
rt_type)
>    * @dev_desc: Device descriptor
>    * Return: Driver found, or NULL if none
>    */
> -static struct part_driver *part_driver_lookup_type(struct blk_desc *des=
c)
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>   {
>   	struct part_driver *drv =3D
>   		ll_entry_start(struct part_driver, part_driver);
> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>  =20
>   	return 0;
>   }
> +
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..3fc3186f4c4 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
>    */
>   int part_get_bootable(struct blk_desc *desc);
>  =20
> +/**
> + * part_driver_lookup_type() - Look up the partition driver for a blk d=
evice
> + *
> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition=
 driver
> + * against the blk device to see if there is a valid partition table ac=
ceptable
> + * to that driver.
> + *
> + * If @desc->part_type is already set, it just returns the driver for t=
hat
> + * type, without testing if the driver can find a valid partition on th=
e
> + * descriptor.
> + *
> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN o=
n entry
> + *
> + * @desc: Device descriptor
> + * Return: Driver found, or NULL if none
> + */
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
> +
>   #else
>   static inline int part_driver_get_count(void)
>   { return 0; }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..7acb4f4e92b 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -17,6 +17,7 @@
>   #include <log.h>
>   #include <malloc.h>
>   #include <net.h>
> +#include <part.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <asm/unaligned.h>
> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct=
 uridp_context *ctx)
>   	if (!ctx)
>   		return ret;
>  =20
> -	/* cleanup for iso or img image */
> +	/* cleanup for disk image */
>   	if (ctx->ramdisk_blk_dev) {
>   		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>   					 EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +453,20 @@ static void EFIAPI efi_bootmgr_http_return(struct e=
fi_event *event,
>   	EFI_EXIT(ret);
>   }
>  =20
> +/**
> + * cleanup_temp_blkdev() - Clean up temporary block device
> + *
> + * @temp_bdev: temporary block device to clean up
> + */
> +static void cleanup_temp_blkdev(struct udevice *temp_bdev)
> +{
> +	if (!temp_bdev)
> +		return;
> +
> +	if (blkmap_destroy(temp_bdev->parent))
> +		log_err("Destroying temporary blkmap failed\n");
> +}
> +
>   /**
>    * try_load_from_uri_path() - Handle the URI device path
>    *
> @@ -466,7 +481,6 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   {
>   	char *s;
>   	int err;
> -	int uri_len;
>   	efi_status_t ret;
>   	void *source_buffer;
>   	efi_uintn_t source_size;
> @@ -516,13 +530,37 @@ static efi_status_t try_load_from_uri_path(struct =
efi_device_path_uri *uridp,
>   	image_size =3D ALIGN(image_size, SZ_2M);
>  =20
>   	/*
> -	 * If the file extension is ".iso" or ".img", mount it and try to load
> -	 * the default file.
> -	 * If the file is PE-COFF image, load the downloaded file.
> +	 * Check if the downloaded file is a disk image or PE-COFF image.
> +	 * Use partition driver lookup for disk image detection.
>   	 */
> -	uri_len =3D strlen(uridp->uri);
> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +	struct udevice *temp_bdev;
> +	struct part_driver *part_drv =3D NULL;
> +
> +	/* Create temporary block device from the downloaded image for testing=
 */
> +	temp_bdev =3D mount_image(lo_label, image_addr, image_size);
> +	if (!temp_bdev) {
> +		log_debug("mount_image() failed, will attempt PE-COFF detection\n");
> +	}
> +	if (temp_bdev) {
> +		struct blk_desc *desc =3D dev_get_uclass_plat(temp_bdev);
> +		if (!desc) {
> +			/* Clean up temporary device when dev_get_uclass_plat() returns NULL=
 */
> +			cleanup_temp_blkdev(temp_bdev);
> +		} else {
> +			/* Use part_driver_lookup_type for comprehensive partition detection=
 */
> +			part_drv =3D part_driver_lookup_type(desc);
> +
> +			/*
> +			 * If it's a disk image with valid partition type,
> +			 * prepare_loaded_image will create the final block device
> +			 */
> +			if (part_drv)
> +				/* Clean up temporary device, prepare_loaded_image will create a ne=
w one */
> +				cleanup_temp_blkdev(temp_bdev);

Why wouldn't you remove the temporary disk if there is no partition driver=
?

Why wouldn't we keep the temporary disk if it is usable instead of=20
creating a new one?

Best regards

Heinrich

> +		}
> +	}
> +
> +	if (part_drv) {
>   		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
>   					   &loaded_dp, &blk);
>   		if (ret !=3D EFI_SUCCESS)
> @@ -545,7 +583,10 @@ static efi_status_t try_load_from_uri_path(struct e=
fi_device_path_uri *uridp,
>   		source_buffer =3D (void *)image_addr;
>   		source_size =3D image_size;
>   	} else {
> -		log_err("Error: file type is not supported\n");
> +		/* Clean up temporary device if it was created but not a valid disk i=
mage */
> +		cleanup_temp_blkdev(temp_bdev);
> +
> +		log_err("Error: disk image is not supported\n");
>   		ret =3D EFI_UNSUPPORTED;
>   		goto err;
>   	}

