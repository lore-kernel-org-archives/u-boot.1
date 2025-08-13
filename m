Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F637CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 20:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB9B8334F;
	Wed, 13 Aug 2025 22:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ic9MO+pp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A58283564; Wed, 13 Aug 2025 22:46:21 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A5482C84
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 22:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4b10c1abfe4so498341cf.2
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755117977; x=1755722777; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgOlnyjDdKMdnKuBUB194SGfyTTpAavWSYqYGFMRpBM=;
 b=ic9MO+pp4hV5B/vk+nh3iqPNvHTVtGNvhqK6X5TMFAwa0pk8vwcmZKzycXuFnIWlCe
 ZiLScopBQJT428bcAARhFehWeb7wr6IIJaRiH8d64GBh93FN4zk8yBiT7qEkhjYnsxgp
 noDwK9gLPlvCrqrv/PPybaSXecDpbkI31rhi4LG2LzR+Dv0cQdQpAN+MKehM5fXfTbjT
 2GfCwWhwNPFz2FsOVW8/+k6YfxhdU8/JzBOF/jPI+HwlezVzyd+Es4nrlQTlMc9i+l7L
 cmFr+V7HF9w2wEBxfWTlUuQgIbEnbp1KOv2NUWimCd9FIbOmiNzW2X5X5U3UXe6krvqy
 g/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755117977; x=1755722777;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LgOlnyjDdKMdnKuBUB194SGfyTTpAavWSYqYGFMRpBM=;
 b=DhsFWvr6Shyc/gBIEx4RNDuBgh54d2YXKWLE/zce6I4AINTHiKIrYug7rxsarR28VK
 +02oGimwWJM2+MxHoD/sYV8jaWu0emY/E1NL3WctmXl7VquXZFqxLf8NFH+9pAHYZHRA
 TWSj79vn6JXh6xMEeQ0BQu2H3GQJsDSe0MZ9a4BMcCbSi6StMgZJK2YzwpKdNX8bXpqs
 u8jf+F6bB3h5yAo5EA9xPbz8NhhLwWyElhKZKQgDrezNjZbJmbvzvSfkFnGFuVgDNLat
 ICzQ54EECF8AHMPk7jJDPzWOYQQypU6bMSTwLCqHzAQTVx0LTsuP0KC+bmgTgVQirv6f
 7sqg==
X-Gm-Message-State: AOJu0Yw3ty60RWmmJQKEV/D8RTGEoBPeObPcOPZvsqC3efdrxQfHXn4z
 mxFt/46RJvv0w45iGQ1vceWdD+KeO3h/vUQEUOFBIvyvLgwhgO4fU4SaMGb+V8Lko+o=
X-Gm-Gg: ASbGnctfNZuk6WQJ+L9LBm6xKTnGtvo+7ZguiZHQWcTd1ujDR0ho/zAicI7BLzNsDZW
 hRVii4AwdmDo6wsB+l/HBDVitsjOow3Pz7ru9c7DlLfuA5P4Vs75Hn5Rm2xR95NLa6svyTuclnx
 3CDywdrvh+vGTrPvrBsb5QF7OALXZdeFCLCTxVFbgLsLFHBKem/Xt8GF/6Pzb6zQq/GX7g9kY/B
 ReIUV1nlsfi0sKgB1hGftAZ5KoOuN6Drx4LIE6g0uE0McmiPPyV4sBBxpzKpGBp8dy2VcMnWoHT
 QdmC9jF+3b6ISTMuNaT+iC8O+fBW994xdFj1j+Bon6x8N3C3IqZ2RQsbKYJHDTSjbeYRWu6Hypx
 JSj8Ep4w/fV2pySYGYPmlx2wO/hrXNpxV9tnqthjEPBgGQr9sIvVyh/nM1TzLK+t24daOoWkBMR
 qciH6sqKyWuPFZ5A==
X-Google-Smtp-Source: AGHT+IF2l2kPfBCosvo4+OWr/i1X/K5i8RN4B0cR0hdv6m/wf2R+VTPCMPeW8LzFRa6he1BQxqdoIA==
X-Received: by 2002:ac8:5784:0:b0:4af:195a:b92e with SMTP id
 d75a77b69052e-4b10aa7a6c0mr9290961cf.39.1755117976175; 
 Wed, 13 Aug 2025 13:46:16 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06ea8cec8sm142496651cf.25.2025.08.13.13.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:46:15 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id D7E6BF40066;
 Wed, 13 Aug 2025 16:46:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 16:46:14 -0400
X-ME-Sender: <xms:lvmcaEhSZmx9r6oNaZFhWNCXYDgntI74TyGa0omRX0Rpysi7C_iSQw>
 <xme:lvmcaNDU06fXioFq8CpVHetU3PJt9xTul3naQMBdIqkNZZ377YVxugWfv3B5mr-IB
 upgsCoGx7KQt6fTQ7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfgrvhhi
 vghrucfvihgrfdcuoehjrghvihgvrhdrthhirgeslhhinhgrrhhordhorhhgqeenucggtf
 frrghtthgvrhhnpefhfeetvdfhgfeifeeuudefudeuvdfhueehteeftddvkeehtdetveei
 gfekhedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhgrshhtmhgrihhlodhmvghsmhht
 phgruhhthhhpvghrshhonhgrlhhithihqdduhedvkeekleehkeefqdefudefieegvdelie
 dqjhgrvhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhgsehjvghtmhdrmhgvpdhnsggp
 rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeighihprhhonh
 drghhlphhksehgmhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdr
 tghomhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:lvmcaKHZ21tTgcP_6MlqPNgvbJ4QHJRdtwQUz_uVOJzMHFTcczA-_w>
 <xmx:lvmcaGydJC8AKORMuldT3zSIN7IDAe-4hjZZGTHLe5DeoBcJiI7ULg>
 <xmx:lvmcaHoigUet9g6D4lmOW_y5GZy_PZEc8re_IOrGQ3Jh-0Jv6pYTUA>
 <xmx:lvmcaIgwmib9gG3UNbJ6MxXsT3xt6HWJaX-GWEegYvuDS2E9v0QaaQ>
 <xmx:lvmcaMhss0f43DINWXLDEvTwAFMNg2uwBCUI4csP9GIbDtuTqcYnhDRf>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id ADF711EA0066; Wed, 13 Aug 2025 16:46:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AtFO-h5AtSNc
Date: Wed, 13 Aug 2025 14:45:38 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>
Message-Id: <0f607d0b-a8f0-403c-b69e-cdb227d6c37a@app.fastmail.com>
In-Reply-To: <20250808213627.649669-1-javier.tia@linaro.org>
References: <20250808213627.649669-1-javier.tia@linaro.org>
Subject: Re: [PATCH v2] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello,

Thank you very much for your feedback on my previous patch. I=E2=80=99ve=
 addressed your comments and updated with [1] for your review.

[1] https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@li=
naro.org/#r

If this change is already in your review queue, please ignore it.=20

If you have any further suggestions or anything else I can improve, plea=
se let me know.

Thank you again for your time and support.

Best regards,

On Fri, Aug 8, 2025, at 3:27 PM, Javier Tia wrote:
> Refines the disk image detection mechanism in the EFI boot manager.
> Instead of relying on file extensions, the updated code uses the
> partition driver lookup function to determine if a downloaded file is a
> valid disk image.
>
> The change enhances the robustness of the boot manager by providing a
> more accurate disk image detection. Extend prepare_loaded_image() to
> accept an optional reuse_blk parameter. When a partition driver is
> detected, the existing temporary device is passed to
> prepare_loaded_image() instead of being destroyed and recreated.
>
> The partition driver lookup function is also made public to enable its
> use in the EFI boot manager. The function documentation is updated
> accordingly.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>
> ---
> Changes in v2:
> - Extend prepare_loaded_image() to accept an optional reuse_blk
>   parameter. When a partition driver is detected, the existing tempora=
ry
>   device is passed to prepare_loaded_image() instead of being destroyed
>   and recreated.
> - v1 link:=20
> https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@lina=
ro.org/
>
> ---
>  disk/part.c                  |  3 +-
>  include/part.h               | 18 +++++++++
>  lib/efi_loader/efi_bootmgr.c | 78 +++++++++++++++++++++++++++++-------
>  3 files changed, 83 insertions(+), 16 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..adc24976624 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int =
part_type)
>   * @dev_desc: Device descriptor
>   * Return: Driver found, or NULL if none
>   */
> -static struct part_driver *part_driver_lookup_type(struct blk_desc *d=
esc)
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>  {
>  	struct part_driver *drv =3D
>  		ll_entry_start(struct part_driver, part_driver);
> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>=20
>  	return 0;
>  }
> +
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..3fc3186f4c4 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
>   */
>  int part_get_bootable(struct blk_desc *desc);
>=20
> +/**
> + * part_driver_lookup_type() - Look up the partition driver for a blk=20
> device
> + *
> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each=20
> partition driver
> + * against the blk device to see if there is a valid partition table=20
> acceptable
> + * to that driver.
> + *
> + * If @desc->part_type is already set, it just returns the driver for=20
> that
> + * type, without testing if the driver can find a valid partition on=20
> the
> + * descriptor.
> + *
> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN=20
> on entry
> + *
> + * @desc: Device descriptor
> + * Return: Driver found, or NULL if none
> + */
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
> +
>  #else
>  static inline int part_driver_get_count(void)
>  { return 0; }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
> index 662993fb809..9c97fd7812d 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -17,6 +17,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <net.h>
> +#include <part.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <asm/unaligned.h>
> @@ -346,19 +347,27 @@ static efi_status_t fill_default_file_path(struc=
t=20
> udevice *blk,
>   * @size:	image size
>   * @dp:		pointer to default file device path
>   * @blk:	pointer to created blk udevice
> + * @reuse_blk:	optional existing block device to reuse (can be NULL)
>   * Return:	status code
>   */
>  static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulon=
g=20
> size,
>  					 struct efi_device_path **dp,
> -					 struct udevice **blk)
> +					 struct udevice **blk,
> +					 struct udevice *reuse_blk)
>  {
>  	u64 pages;
>  	efi_status_t ret;
>  	struct udevice *ramdisk_blk;
>=20
> -	ramdisk_blk =3D mount_image(label, addr, size);
> -	if (!ramdisk_blk)
> -		return EFI_LOAD_ERROR;
> +	if (reuse_blk) {
> +		/* Reuse existing block device */
> +		ramdisk_blk =3D reuse_blk;
> +	} else {
> +		/* Create new block device */
> +		ramdisk_blk =3D mount_image(label, addr, size);
> +		if (!ramdisk_blk)
> +			return EFI_LOAD_ERROR;
> +	}
>=20
>  	ret =3D fill_default_file_path(ramdisk_blk, dp);
>  	if (ret !=3D EFI_SUCCESS) {
> @@ -387,7 +396,8 @@ static efi_status_t prepare_loaded_image(u16=20
> *label, ulong addr, ulong size,
>  	return EFI_SUCCESS;
>=20
>  err:
> -	if (blkmap_destroy(ramdisk_blk->parent))
> +	/* Only destroy if we created it (not reused) */
> +	if (!reuse_blk && blkmap_destroy(ramdisk_blk->parent))
>  		log_err("Destroying blkmap failed\n");
>=20
>  	return ret;
> @@ -407,7 +417,7 @@ static efi_status_t=20
> efi_bootmgr_release_uridp(struct uridp_context *ctx)
>  	if (!ctx)
>  		return ret;
>=20
> -	/* cleanup for iso or img image */
> +	/* cleanup for disk image */
>  	if (ctx->ramdisk_blk_dev) {
>  		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>  					 EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +462,20 @@ static void EFIAPI efi_bootmgr_http_return(struct=20
> efi_event *event,
>  	EFI_EXIT(ret);
>  }
>=20
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
>  /**
>   * try_load_from_uri_path() - Handle the URI device path
>   *
> @@ -466,7 +490,6 @@ static efi_status_t try_load_from_uri_path(struct=20
> efi_device_path_uri *uridp,
>  {
>  	char *s;
>  	int err;
> -	int uri_len;
>  	efi_status_t ret;
>  	void *source_buffer;
>  	efi_uintn_t source_size;
> @@ -516,21 +539,43 @@ static efi_status_t try_load_from_uri_path(struc=
t=20
> efi_device_path_uri *uridp,
>  	image_size =3D ALIGN(image_size, SZ_2M);
>=20
>  	/*
> -	 * If the file extension is ".iso" or ".img", mount it and try to lo=
ad
> -	 * the default file.
> -	 * If the file is PE-COFF image, load the downloaded file.
> +	 * Check if the downloaded file is a disk image or PE-COFF image.
> +	 * Use partition driver lookup for disk image detection.
>  	 */
> -	uri_len =3D strlen(uridp->uri);
> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +	struct udevice *temp_bdev;
> +	struct part_driver *part_drv =3D NULL;
> +
> +	/* Create temporary block device from the downloaded image for testi=
ng */
> +	temp_bdev =3D mount_image(lo_label, image_addr, image_size);
> +	if (!temp_bdev) {
> +		log_debug("mount_image() failed, will attempt PE-COFF detection\n");
> +	}
> +	if (temp_bdev) {
> +		struct blk_desc *desc =3D dev_get_uclass_plat(temp_bdev);
> +		if (!desc) {
> +			/* Clean up temporary device when dev_get_uclass_plat() returns NU=
LL */
> +			cleanup_temp_blkdev(temp_bdev);
> +		} else {
> +			/*
> +			 * Use part_driver_lookup_type for comprehensive partition detecti=
on
> +			 */
> +			part_drv =3D part_driver_lookup_type(desc);
> +		}
> +	}
> +
> +	if (part_drv) {
> +		/* Reuse the temporary device instead of destroying and recreating =
*/
>  		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> -					   &loaded_dp, &blk);
> +					   &loaded_dp, &blk, temp_bdev);
>  		if (ret !=3D EFI_SUCCESS)
>  			goto err;
>=20
>  		source_buffer =3D NULL;
>  		source_size =3D 0;
>  	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D=20
> EFI_SUCCESS) {
> +		/* Clean up temporary device if it was created but not a valid disk=20
> image */
> +		cleanup_temp_blkdev(temp_bdev);
> +
>  		/*
>  		 * loaded_dp must exist until efi application returns,
>  		 * will be freed in return_to_efibootmgr event callback.
> @@ -545,7 +590,10 @@ static efi_status_t try_load_from_uri_path(struct=20
> efi_device_path_uri *uridp,
>  		source_buffer =3D (void *)image_addr;
>  		source_size =3D image_size;
>  	} else {
> -		log_err("Error: file type is not supported\n");
> +		/* Clean up temporary device if it was created but not a valid disk=20
> image */
> +		cleanup_temp_blkdev(temp_bdev);
> +
> +		log_err("Error: disk image is not supported\n");
>  		ret =3D EFI_UNSUPPORTED;
>  		goto err;
>  	}
> --=20
> 2.50.1

--=20
=C2=BB Javier Tia =E2=9C=8D
