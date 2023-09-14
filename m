Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48715EEAA4F
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 14:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F7486A5A;
	Thu, 14 Sep 2023 16:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QxVjnlhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE1486A68; Thu, 14 Sep 2023 16:55:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A6B86A14
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694703330; x=1695308130; i=xypron.glpk@gmx.de;
 bh=pcRLSvpZ9qWjrXdYf+8jfxOpU+OnCsbIyiKqZaNCrxA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QxVjnlhdw7Ux/ICqlQWOOFldQ2Xv6VMImfKH6Wcs93alyE/dy1MmjuWt98k9XBCRW/v4gsyZulg
 vXL9gzGy8ochL5nVZKlcppmwRyGhpDgJDAQ18a9/iEQ3Ethi48pt3qGEcvtsD0q/J26sX3TQiE0f5
 KSCc/EK9+ujRief4aoTW7MF6FEtI8K2RiFMHmG12yoX2Zm4qver/iy4Egf7IU5CR60BUaqgcI2utA
 NnpAzS9bPNVKEh3JdTC0Yn3vSR5YZa/1ERaIFNssjCG7b3iVvDhII+eKjPaboqlw9UJpOq81GG7ks
 w/QA6FYho4JjAJbF2L+mJvN6hJqdVCBcjRkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1rfoLx2tff-010es4; Thu, 14
 Sep 2023 16:55:30 +0200
Message-ID: <8b9f5c70-ebd9-48e0-8d4f-738cc950dfb7@gmx.de>
Date: Thu, 14 Sep 2023 16:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230901102542.609239-5-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9CZY4LwQ12mSIc5NMeTNoN38Oy7jfXacveYvFBEmnp7lqUB4mWI
 83fvdb0cv7B4+63jOpNYQecBRnwvtsAYniTKoIK5kpZCAFnTl0TOKGsokvei5auV2t4V6iD
 kWbKX3r1HudWW7YEEGR6cIwuyxIRDsWv+JXHI/0WhPvOPn7X+boXF3u+QrTZ5g/5c4Fhf0g
 YSplSp9gDV1Y85TgnT7FQ==
UI-OutboundReport: notjunk:1;M01:P0:D4c7sktKYZU=;Mn2gRKk9UIJDoYfv6ek05LQ2TvH
 fFzh1tPcXqvIKrOI/Bul2nz5E3isZUM+WmUj3h+2S2TOAek3GL7kZZpJCo/XNwpknZZTDJiwk
 I2mq05h4fh+uPcN6S07fOtgpP37+D87ju94qY9DijxZbEWHBqgxxRLvi7wxPJdRK6PzjLbZhL
 10CBMbDPoxa9GOv0peOyNKaQyQaCfSBWFvWgBZEF+XXW0EGtTyFBly5vprncdLFOwgmNtjc+o
 JNskp92VGCl1V1kQEWyMfO3tNu8nZtG1fsKmJobz5SnZPJrpmXWF3hnUloUzxmlgViuGUDRwR
 sUe7Q/n4vaZBV8iaQH4dYo0W5dCxtbXe6s+wVmgcbVOJYQr34Aw7YKMVKWMqNf3RaFMEGcqsR
 PpyiVWCH3oWdlELL6dTanv4qbd1AHWNjr/ICQ0tjHjH5kj78MMwhgflnVfhnmk5qZ/surlldB
 lbL3diTFSLsaxl22BSQ52UiNp2iyblPw8o1jyXS0CEEDAzri+Ts+q9WO+K0Rqul+6n24BKpWF
 9doSxBEfNcq62Mjw38VhvTdgfauLB5ys7MO09BsPECmpAU4kSKIsRa88oowG27EiGEan6XvHX
 /b4xnQRIiWA+PV5i0mg3Z9TIGcvvLOEFf9e3fsN2hpCRAtB+tYazyDznTSdQ5Up5VUpGTjvBQ
 zDfZ8LYFqAgYrcoYSNYSNH7eZJXp4MPzNekNEky4fnYlCZdKLwVrsSnjHNayGFGuyT3obwFqf
 MPMvo5wQ65scmDOwbPWiXvUIkOd/J7MkQflvkJlCwgKipRrAnV3EA9aK6E+acCmj+UmWHBkMA
 doqzbP3uygVGB+CpPbKNFEKOwytB5gsU7KtjRfAB7sxCyodnhGUfnGp5raekPBNtpR6UOFfYy
 32uMBvVPl6KZR4DxAWgnYB/Z9EnwYdXkUGypinEErEVcLMulZa0tCO/XT97vuLhKOWm9K4C8u
 G0Rh3o4a7/XAvci9p1TqOk+/PYg=
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

On 01.09.23 12:25, Masahisa Kojima wrote:
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> If the file is .efi file, load and start the downloaded file.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 197 +++++++++++++++++++++++++++++++++++
>   1 file changed, 197 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c..0e8d2ca9d1 100644
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
> @@ -168,6 +172,193 @@ out:
>   	return ret;
>   }
>
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENA=
BLED(CONFIG_CMD_DNS))
> +/**
> + * mount_image() - mount the image with blkmap
> + *
> + * @lo_label	u16 label string of load option
> + * @image_addr:	image address
> + * @image_size	image size
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
> + * try_load_default_file() - try to load the default file
> + *
> + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.E=
FI).
> + *
> + * @dev			pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> + * @image_handle:	pointer to handle for newly installed image
> + * Return:		status code
> + */
> +static efi_status_t try_load_default_file(struct udevice *dev,
> +					  efi_handle_t *image_handle)
> +{
> +	efi_status_t ret;
> +	efi_handle_t bm_handle;
> +	struct efi_handler *handler;
> +	struct efi_device_path *file_path;
> +	struct efi_device_path *device_path;
> +
> +	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
> +		log_warning("DM_TAG_EFI not found\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	ret =3D efi_search_protocol(bm_handle,
> +				  &efi_simple_file_system_protocol_guid, &handler);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	ret =3D efi_search_protocol(bm_handle, &efi_guid_device_path, &handler=
);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	ret =3D efi_protocol_open(handler, (void **)&device_path, efi_root, NU=
LL,
> +				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	file_path =3D expand_media_path(device_path);
> +	ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> +				      image_handle));
> +
> +	efi_free_pool(file_path);
> +
> +	return ret;
> +}
> +
> +/**
> + * load_default_file_from_blk_dev() - load the default file
> + *
> + * @blk		pointer to the UCLASS_BLK udevice
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> +						   efi_handle_t *handle)
> +{
> +	efi_status_t ret;
> +	struct udevice *partition;
> +
> +	/* image that has no partition table but a file system */
> +	ret =3D try_load_default_file(blk, handle);
> +	if (ret =3D=3D EFI_SUCCESS)
> +		return ret;
> +
> +	/* try the partitions */
> +	device_foreach_child(partition, blk) {
> +		enum uclass_id id;
> +
> +		id =3D device_get_uclass_id(partition);
> +		if (id !=3D UCLASS_PARTITION)
> +			continue;
> +
> +		ret =3D try_load_default_file(partition, handle);
> +		if (ret =3D=3D EFI_SUCCESS)
> +			return ret;
> +	}
> +
> +	return EFI_NOT_FOUND;
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:	uri device path
> + * @lo_label	label of load option
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *=
uridp,
> +					   u16 *lo_label,
> +					   efi_handle_t *handle)
> +{
> +	char *s;
> +	int uri_len;
> +	int image_size;
> +	efi_status_t ret;
> +	ulong image_addr;
> +
> +	s =3D env_get("loadaddr");
> +	if (!s) {
> +		log_err("Error: loadaddr is not set\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +	image_addr =3D hextoul(s, NULL);
> +	image_size =3D wget_with_dns(image_addr, uridp->uri);
> +	if (image_size < 0)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/*
> +	 * If the file extension is ".iso" or ".img", mount it and try to load
> +	 * the default file.
> +	 * If the file is ".efi" and PE-COFF image, load the downloaded file.
> +	 */

There is no requirement that EFI binaries have an .efi extension.
Does EDK II require it?

Best regards

Heinrich


> +	uri_len =3D strlen(uridp->uri); /* todo: directly use uridp->uri */
> +	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> +	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +		struct udevice *blk;
> +
> +		blk =3D mount_image(lo_label, image_addr, image_size);
> +		if (!blk)
> +			return EFI_INVALID_PARAMETER;
> +
> +		ret =3D load_default_file_from_blk_dev(blk, handle);
> +	} else if (!strncmp(&uridp->uri[uri_len - 4], ".efi", 4)) {
> +		efi_handle_t mem_handle =3D NULL;
> +		struct efi_device_path *file_path =3D NULL;
> +
> +		ret =3D efi_check_pe((void *)image_addr, image_size, NULL);
> +		if (ret !=3D EFI_SUCCESS) {
> +			log_err("Error: downloaded image is not a PE-COFF image\n");
> +			return EFI_INVALID_PARAMETER;
> +		}
> +
> +		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +					    (uintptr_t)image_addr, image_size);
> +		ret =3D efi_install_multiple_protocol_interfaces(
> +			&mem_handle, &efi_guid_device_path, file_path, NULL);
> +		if (ret !=3D EFI_SUCCESS)
> +			return EFI_INVALID_PARAMETER;
> +
> +		ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path,
> +					      (void *)image_addr, image_size,
> +					      handle));
> +	} else {
> +		log_err("Error: file type is not supported\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	return ret;
> +}
> +#endif
> +
>   /**
>    * try_load_entry() - try to load image for boot option
>    *
> @@ -211,6 +402,12 @@ static efi_status_t try_load_entry(u16 n, efi_handl=
e_t *handle,
>   		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>   			/* file_path doesn't contain a device path */
>   			ret =3D try_load_from_short_path(lo.file_path, handle);
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENA=
BLED(CONFIG_CMD_DNS))
> +		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +			ret =3D try_load_from_uri_path(
> +				(struct efi_device_path_uri *)lo.file_path,
> +				lo.label, handle);
> +#endif
>   		} else {
>   			file_path =3D expand_media_path(lo.file_path);
>   			ret =3D EFI_CALL(efi_load_image(true, efi_root, file_path,

