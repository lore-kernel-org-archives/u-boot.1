Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03405C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 14:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFC983857;
	Thu, 31 Jul 2025 16:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iG06K2CR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9A8838E6; Thu, 31 Jul 2025 16:05:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051D583852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 16:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753970745; x=1754575545; i=xypron.glpk@gmx.de;
 bh=tPmP7mu6Re+JayHoODDMFm93hYLWLzWSl1D8kPDX6x0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iG06K2CRf/La18HsfCVHo3aFPb9insx1Ry1K50yyTCponhYo5Riaulb5p5z/qxdF
 4C6UKNqDh7mxlkBpZhZmf0FFUZS5WOgypfFsRhTBWAgjB7LhdjVupB1po6D8wN4uI
 pAG40K0HbS4HB37pK7etN1ATIEK0ZBDzYkF75xdM4dobfcfBxeDF+5W93/fpWLkqP
 kHzONy0CU2IGks3L2auGnVcAUZs2Ony/AGPEXgh4krQxPFHRXhnYyJUmql5+oLzVp
 wDzb66eGYMjCQwZGgvhi2weP6S/6/1iUWc4jdhW0RUskhtV7dTzBdcmRvoxoLE/g3
 XBgp34UU0Si93Jt6Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1uej1X1hUY-007cKf; Thu, 31
 Jul 2025 16:05:45 +0200
Message-ID: <d151f1a5-40de-4084-9a0d-e2727d65e97c@gmx.de>
Date: Thu, 31 Jul 2025 16:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: efi_loader: Add function to detect disk image type
To: Javier Tia <javier.tia@linaro.org>
References: <20250730224942.755510-1-javier.tia@linaro.org>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250730224942.755510-1-javier.tia@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DrBjERHmOnFrrVqtBX78MSbPYwREuDA2bOxPm7qunEp+1Xpcr7y
 Msqzz45cYKPvQczWb953DHGTxyA8dujKGBiX5FT+gMLQNdfLLBzC7s5qyFFl7+1gek2JLG8
 4hj0bHfhojD2kRC//3QQyquUA2aCX8aKz50uyug7OLHZPcIAwnnm7epwcZU/ZleAbd4K8kn
 /Q07OhBQEsWXcV3xDl4sg==
UI-OutboundReport: notjunk:1;M01:P0:GWgf6i0KvD4=;eFrud/uNs6eDjgTxseHzsqB4+aE
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

On 31.07.25 00:49, Javier Tia wrote:
> This commit introduces a new function, detect_disk_image_type(), which
> checks if a buffer contains a disk image. This function is used to
> detect disk images based on their headers, rather than relying on file
> extensions.
>=20
> The function checks for ISO 9660, DOS MBR, and GPT protective MBR
> signatures. It returns 1 if a disk image is detected, and 0 otherwise.
>=20
> This function is then used in the efi_bootmgr.c file to determine if a
> downloaded file is a PE-COFF image or a disk image. This change
> improves the reliability of disk image detection, as it no longer
> relies on file extensions, which can be easily changed or omitted.
>=20
> Signed-off-by: Javier Tia <javier.tia@linaro.org>

It would be easier to use efi_check_pe() to identify if the downloaded=20
file is a PE-COFF image. Otherwise try booting it as a disk image.

You could use part_driver_lookup_type() to determine the partition type.

Best regards

Heinrich

> ---
>   disk/part.c                  | 46 ++++++++++++++++++++++++++++++++++++
>   include/part.h               |  9 +++++++
>   lib/efi_loader/efi_bootmgr.c | 29 ++++++++++-------------
>   3 files changed, 68 insertions(+), 16 deletions(-)
>=20
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..9d9483b216c 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -855,3 +855,49 @@ int part_get_bootable(struct blk_desc *desc)
>  =20
>   	return 0;
>   }
> +
> +/**
> +* detect_disk_image_type() - Detect if buffer contains a disk image
> +*
> +* @buffer:  Buffer containing potential disk image data
> +* @size:    Size of the buffer
> +* Return:   1 if disk image detected, 0 otherwise
> +*/
> +int detect_disk_image_type(void *buffer, size_t size)
> +{
> +	unsigned char *buf =3D (unsigned char *)buffer;
> +
> +	/* Need at least 512 bytes for basic checks */
> +	if (!buffer || size < 512)
> +		return 0;
> +
> +#if IS_ENABLED(CONFIG_ISO_PARTITION)
> +	/* Check for ISO 9660 signature "CD001" at offset 0x8001 */
> +	if (size > 0x8005) {
> +		if (buf[0x8001] =3D=3D 'C' && buf[0x8002] =3D=3D 'D' &&
> +		    buf[0x8003] =3D=3D '0' && buf[0x8004] =3D=3D '0' &&
> +		    buf[0x8005] =3D=3D '1') {
> +			return 1;
> +		}
> +	}
> +#endif
> +
> +#if IS_ENABLED(CONFIG_DOS_PARTITION)
> +	/* Check for DOS MBR signature 0x55AA at offset 0x1FE */
> +	if (buf[0x1FE] =3D=3D 0x55 && buf[0x1FF] =3D=3D 0xAA) {
> +		return 1;
> +	}
> +#endif
> +
> +#if IS_ENABLED(CONFIG_EFI_PARTITION)
> +	/* Check for GPT protective MBR */
> +	if (buf[0x1FE] =3D=3D 0x55 && buf[0x1FF] =3D=3D 0xAA) {
> +		/* Check if partition type is 0xEE (GPT protective) */
> +		if (buf[0x1C2] =3D=3D 0xEE) {
> +			return 1;
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..39c04e0c8f7 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,15 @@ int part_get_type_by_name(const char *name);
>    */
>   int part_get_bootable(struct blk_desc *desc);
>  =20
> +/**
> + * detect_disk_image_type() - Detect if buffer contains a disk image
> + *
> + * @buffer: Buffer containing potential disk image data
> + * @size:   Size of the buffer
> + * Return:  1 if disk image detected, 0 otherwise
> + */
> +int detect_disk_image_type(void *buffer, size_t size);
> +
>   #else
>   static inline int part_driver_get_count(void)
>   { return 0; }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..da63ad41b40 100644
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
> +	/* cleanup for image file */
>   	if (ctx->ramdisk_blk_dev) {
>   		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>   					 EFI_CONVENTIONAL_MEMORY);
> @@ -466,7 +467,6 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   {
>   	char *s;
>   	int err;
> -	int uri_len;
>   	efi_status_t ret;
>   	void *source_buffer;
>   	efi_uintn_t source_size;
> @@ -516,21 +516,10 @@ static efi_status_t try_load_from_uri_path(struct =
efi_device_path_uri *uridp,
>   	image_size =3D ALIGN(image_size, SZ_2M);
>  =20
>   	/*
> -	 * If the file extension is ".iso" or ".img", mount it and try to load
> -	 * the default file.
> -	 * If the file is PE-COFF image, load the downloaded file.
> +	 * Check if the downloaded file is a PE-COFF image or a disk image.
> +	 * Use header-based detection instead of file extensions.
>   	 */
> -	uri_len =3D strlen(uridp->uri);
> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> -		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> -					   &loaded_dp, &blk);
> -		if (ret !=3D EFI_SUCCESS)
> -			goto err;
> -
> -		source_buffer =3D NULL;
> -		source_size =3D 0;
> -	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D E=
FI_SUCCESS) {
> +	if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D EFI_SUCC=
ESS) {
>   		/*
>   		 * loaded_dp must exist until efi application returns,
>   		 * will be freed in return_to_efibootmgr event callback.
> @@ -544,6 +533,14 @@ static efi_status_t try_load_from_uri_path(struct e=
fi_device_path_uri *uridp,
>  =20
>   		source_buffer =3D (void *)image_addr;
>   		source_size =3D image_size;
> +	} else if (detect_disk_image_type((void *)image_addr, image_size)) {
> +		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> +					   &loaded_dp, &blk);
> +		if (ret !=3D EFI_SUCCESS)
> +			goto err;
> +
> +		source_buffer =3D NULL;
> +		source_size =3D 0;
>   	} else {
>   		log_err("Error: file type is not supported\n");
>   		ret =3D EFI_UNSUPPORTED;

