Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C0CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 08:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B508319C;
	Wed, 27 Aug 2025 10:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8Dd74Io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7D48319C; Wed, 27 Aug 2025 10:11:59 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CE783145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 10:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso2064624f8f.3
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756282316; x=1756887116; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jPQTm4M5ugPgmhPxARLDxOWbRFSikZsXf5/kxU2Yeo=;
 b=j8Dd74IoxrQQ6dSPXe9ijvfJBVO2GLXCD6GuTZYJ8g4PchVC6Bt3r3eWiNJLoK8qt7
 XjOEfZBMgFBmNt/ezkewby/mUo0W1ZP/eeThVpzkVyoSmcU+INE3gr8oybAfH9kb0mq8
 ioEDelrTGqwhZIt7eAOTlqj0M/wJlgQ8JsmDZanRfNftiwlPKddXdTCtOBxyOJIsYeYa
 2Gxl/+GOwzGatgK/Dvwh2Olh+PaLWaQDV5qllqksiW4GW9t9b4RkY0gXTfLDrp4Phwt1
 zonrXNAoUGvwvWgxZiamvKUFtnlOJEOyo2/vLeq3Vm7eX6GfF2IWxgeWJcSmOfXqAeJ0
 50Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756282316; x=1756887116;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8jPQTm4M5ugPgmhPxARLDxOWbRFSikZsXf5/kxU2Yeo=;
 b=p690pDx2Fi7DagTbWu5q2uJr8lCNPsurBVCGsOcLeyKQ20L7ZdrXabHNG8yo4cNb6o
 QfyRcytdE6O3RFpi/gnFXwm5kf/2sv2j2RZ7iNrQSpeC0FdyP5FOXZTUWhqzAdBBV2b7
 PGqiwiuhgTYKkF0XOZwk288d9fkjfIbw8tzqln8qc4JhFfahGO6lWabtzd8uaPy8y0KA
 MN7IR+nU8zxffCUuEnTO3kMVVXxfl1s+C5c2Q2YQrbTKqtNsXr0ADBFu/mibJ/MjVB6K
 WOHW2leeF0cV2ZlmMbZ+yLoCL2GxLOuC38C/VY3gctAltqNg+p9WwUgv23k47RZS7atQ
 4DIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXuyc+xUrFzY9CEe/KF4SJIRH0rqdslHfWhlj/1zZ0GPzx6zUL9djdI3QbMaF/vUWXsM3QsEY=@lists.denx.de
X-Gm-Message-State: AOJu0YzhrUqy0IGKn5YpPNE9aihw7uYZb3iDl8LZEo9Tx9p7SGi9OLGf
 b07mbKmblRc3pJroywyCU3qwZ3zxtyoA9qlnWieQ5rBe9OUJ3D2MeLsThdY/+Yr12P0=
X-Gm-Gg: ASbGncvFpTZFhBW/iL+8EwMdLBkj2+m4hm71sB5T3UPOaTof8YWUt+rFUhqkanUWHme
 KYYmCIOXc2T9LpZusTqG2AHLLvsVqdsWwYb/63mw6ith0Ec3LvGMSEWqC3VPtzsOPLUCBlzHZYv
 So7YGv2YqiFCSm10mUIVaMM8HBqy66y/H2odaG3oyzGcZXa1IddA40nmJbKZXmZrIkhj7SRLJjM
 nNTDyxzinG/9Q4N4l9OLVf3I24abbqB4zPf/XRl07KXMWZCRfRBIp9CimYL7y5LeNse0okwUNVe
 FHMT+4zJSUtH/lv1GnTVWtMVxmckjNu8p3D9DWpMG3QSWY7XhMTOycDqAfMNjN+RrOcC+r8YFCO
 0eNGBC3GXSGT/ac7NqrT6la0RZ+cFmhSlb49VOe/n0sbco4L61hAOvdaCmFIM8d1XhQdkuvPlo9
 tfbGyNQZa153KbhRlIM4U7L48SodtTuX8KNxYc6bzNI4u2lmgr8d0aQJWIT7nHiYbmH3qIeN9bP
 hPxykRN+rvV0/bO0lCHuK6CKypp9eSqzQegBBRvgCE2P+fe68X1K0BX865lV1M=
X-Google-Smtp-Source: AGHT+IHyTk/YkObCshxq/GXuAOyhQ7z4b8vYn7trKCwf/YsEN/DYASUvugAf5wTPwjW8RqVkJOBXkw==
X-Received: by 2002:a5d:588b:0:b0:3b8:dabe:bd78 with SMTP id
 ffacd0b85a97d-3c5dcdfbfd3mr17525358f8f.54.1756282316295; 
 Wed, 27 Aug 2025 01:11:56 -0700 (PDT)
Received: from localhost (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0e5982sm20172305e9.11.2025.08.27.01.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 01:11:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 11:11:54 +0300
Message-Id: <DCD24CZ60XZB.IBE4FUJAV7WE@linaro.org>
To: "Javier Tia" <javier.tia@linaro.org>, <u-boot@lists.denx.de>, "Tom Rini"
 <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250808213627.649669-1-javier.tia@linaro.org>
In-Reply-To: <20250808213627.649669-1-javier.tia@linaro.org>
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

Hi Javier

> On Sat Aug 9, 2025 at 12:27 AM EEST, Javier Tia wrote:
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
>  	struct part_driver *drv =3D
>  		ll_entry_start(struct part_driver, part_driver);
> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>
>  	return 0;
>  }
> +

You don't need a new line here

[...]

>   * @blk:	pointer to created blk udevice
> + * @reuse_blk:	optional existing block device to reuse (can be NULL)
>   * Return:	status code
>   */
>  static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong s=
ize,
>  					 struct efi_device_path **dp,
> -					 struct udevice **blk)
> +					 struct udevice **blk,
> +					 struct udevice *reuse_blk)
>  {
>  	u64 pages;
>  	efi_status_t ret;
>  	struct udevice *ramdisk_blk;
>
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

Why do we need this? With the new code the image is always going to be moun=
ted beforehand.
The function is only used locally as well. So can't we get rid of the 'else=
' and always
expect a loaded image. The only difference is that the  *reuse_blk can't be=
 NULL

>
>  	ret =3D fill_default_file_path(ramdisk_blk, dp);
>  	if (ret !=3D EFI_SUCCESS) {
> @@ -387,7 +396,8 @@ static efi_status_t prepare_loaded_image(u16 *label, =
ulong addr, ulong size,
>  	return EFI_SUCCESS;
>
>  err:
> -	if (blkmap_destroy(ramdisk_blk->parent))
> +	/* Only destroy if we created it (not reused) */
> +	if (!reuse_blk && blkmap_destroy(ramdisk_blk->parent))
>  		log_err("Destroying blkmap failed\n");
>
>  	return ret;
> @@ -407,7 +417,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct =
uridp_context *ctx)
>  	if (!ctx)
>  		return ret;
>
> -	/* cleanup for iso or img image */
> +	/* cleanup for disk image */
>  	if (ctx->ramdisk_blk_dev) {
>  		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
>  					 EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +462,20 @@ static void EFIAPI efi_bootmgr_http_return(struct ef=
i_event *event,
>  	EFI_EXIT(ret);
>  }
>
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
> @@ -466,7 +490,6 @@ static efi_status_t try_load_from_uri_path(struct efi=
_device_path_uri *uridp,
>  {
>  	char *s;
>  	int err;
> -	int uri_len;
>  	efi_status_t ret;
>  	void *source_buffer;
>  	efi_uintn_t source_size;
> @@ -516,21 +539,43 @@ static efi_status_t try_load_from_uri_path(struct e=
fi_device_path_uri *uridp,
>  	image_size =3D ALIGN(image_size, SZ_2M);
>
>  	/*
> -	 * If the file extension is ".iso" or ".img", mount it and try to load
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

Mixed declarations are not allowed. You need to move these up with the rest=
.

> +
> +	/* Create temporary block device from the downloaded image for testing =
*/
> +	temp_bdev =3D mount_image(lo_label, image_addr, image_size);
> +	if (!temp_bdev) {
> +		log_debug("mount_image() failed, will attempt PE-COFF detection\n");
> +	}

Get rid of this and move the log_debug() in the 'else if'

> +	if (temp_bdev) {
> +		struct blk_desc *desc =3D dev_get_uclass_plat(temp_bdev);
> +		if (!desc) {
> +			/* Clean up temporary device when dev_get_uclass_plat() returns NULL =
*/
> +			cleanup_temp_blkdev(temp_bdev);
> +		} else {
> +			/*
> +			 * Use part_driver_lookup_type for comprehensive partition detection
> +			 */
> +			part_drv =3D part_driver_lookup_type(desc);
> +		}
> +	}
> +
> +	if (part_drv) {
> +		/* Reuse the temporary device instead of destroying and recreating */
>  		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> -					   &loaded_dp, &blk);
> +					   &loaded_dp, &blk, temp_bdev);
>  		if (ret !=3D EFI_SUCCESS)
>  			goto err;
>
>  		source_buffer =3D NULL;
>  		source_size =3D 0;
>  	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D EF=
I_SUCCESS) {
> +		/* Clean up temporary device if it was created but not a valid disk im=
age */
> +		cleanup_temp_blkdev(temp_bdev);

Is this really needed ? Since we ended up here part_drv is NULL which means=
 dev_get_uclass_plat()
returned NULL and the cleanup has already executed.

> +
>  		/*
>  		 * loaded_dp must exist until efi application returns,
>  		 * will be freed in return_to_efibootmgr event callback.
> @@ -545,7 +590,10 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>  		source_buffer =3D (void *)image_addr;
>  		source_size =3D image_size;
>  	} else {
> -		log_err("Error: file type is not supported\n");
> +		/* Clean up temporary device if it was created but not a valid disk im=
age */
> +		cleanup_temp_blkdev(temp_bdev);
> +
> +		log_err("Error: disk image is not supported\n");
>  		ret =3D EFI_UNSUPPORTED;
>  		goto err;
>  	}

Thanks
/Ilias
