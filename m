Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624BAC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 08:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4B9883A9;
	Tue, 30 Jul 2024 10:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GY6VCB6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB736887BF; Tue, 30 Jul 2024 10:51:27 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D083387A55
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 10:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f035ae0fe0so51209221fa.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722329485; x=1722934285;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LcIXKGEK0Q22+pGBNuCmq7e0+hRlXAdVe1zj6qQkanI=;
 b=GY6VCB6mwWcqTnnEcj0gfFaz6YnHqNPNNRITDGC8vbhMnyPUgWvffNmx52p82TGGQP
 5YHRln+pZ8S+d6E43+SwMwteV5LA9rGdwmeifmsGt9qPXI+yVmjj/BqpGWnbVfS1osDp
 k+rLRy5FXjSQ24nN03E7diW0vQJBWkto8Wuxky0DPiPS3awT1ZwBoYY6x/I765+0CKsu
 NQYhMGgT1mzEpyMxW9jC1rtxXf75OrPofsD25oxy5FVsO2cal3VNC4UhmwQXvPJqEA5h
 by+Med1oNgAbjlaKJgo+KHCTv8Swb3lap6/lD53S/tKg8JGmlsIYdPzjJXdc2FDpCOR/
 8q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722329485; x=1722934285;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LcIXKGEK0Q22+pGBNuCmq7e0+hRlXAdVe1zj6qQkanI=;
 b=apMEySaErrDAhcmhcWvhngcWlc7yz0Vhb1tAipUa3gt/HZQ6rhkBFRhGukt8IkwKcB
 Ja9yjPrQdejTDwdV3lQzLau1L1+54RMo9XQGHqvdGG/++jEtQ/rZlBRlJBqunTZWcb02
 eDPsGddHd44BSiz4R/BfizhyRwkGA8UtkVRoefdaqKGrPayGoZmv5FJH86ibQ0N7n2Gc
 FCzwXMRWi3FfGBtTbUpFfbAqyMmQsExWoxpD2iGu+wVnesmyND5KUScPGjBEAmHOOU/z
 wK2VnuG4Rq6+j/pmr0j5hazfHuOKOPGjq636EWl/gBe1LrhMcKAQCW1F0RzYjH6zAad/
 vLWA==
X-Gm-Message-State: AOJu0Yy58oF5VebjEPe8OR8yU/fbB8hgz1wN/s1wPR23nlhmNuJQvTVM
 HyV7BwXaNe+P+vAVmEM3+MHWCc1O5YzLpTL84ZzoyVT3oO6kOvdzYpDfOuTZOwQ=
X-Google-Smtp-Source: AGHT+IEq6srsCRLY/G5FvWd4ROr8itx0xQrdzaqdBQ5kF0XvGrRBnB7p1Huj+0WSmXLORnvjT+ZaYg==
X-Received: by 2002:a2e:8198:0:b0:2ef:28ee:944 with SMTP id
 38308e7fff4ca-2f12ee2f300mr63820851fa.45.1722329484693; 
 Tue, 30 Jul 2024 01:51:24 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574b0e8sm211170855e9.26.2024.07.30.01.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 01:51:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v2] boot: android: fix booting without a ramdisk
In-Reply-To: <20240729213657.2550935-1-mwalle@kernel.org>
References: <20240729213657.2550935-1-mwalle@kernel.org>
Date: Tue, 30 Jul 2024 10:51:21 +0200
Message-ID: <875xsnqn3q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Michael,

Thank you for the patch.

On lun., juil. 29, 2024 at 23:36, Michael Walle <mwalle@kernel.org> wrote:

> android_image_get_ramdisk() will return an error if there is no ramdisk.
> Using the android image without a ramdisk worked until commit
> 1ce8e10f3b4b ("image: Fix up ANDROID_BOOT_IMAGE ramdisk code") because
> the return code wasn't checked until then. Return -ENOENT in case
> there is no ramdisk and translate that into -ENOPKG in the calling
> code, which will then indicate "no ramdisk" to its caller
> (boot_get_ramdisk()).
>
> This way, we can get rid of the "*rd_data = *rd_len = 0;" in the error
> path, too.
>
> With this, I'm able to boot a linux kernel using fastboot again:
>
>   fastboot --base 0x41000000 --header-version 2 --dtb /path/to/dtb \
>   --cmdline "root=/dev/mmcblk0p1 rootwait" boot path/to/Image
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 7 +++----
>  boot/image-board.c   | 4 +++-
>  include/image.h      | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 09c7a44e058..774565fd1fe 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -393,10 +393,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
>  		return -EINVAL;
>  
> -	if (!img_data.ramdisk_size) {
> -		*rd_data = *rd_len = 0;
> -		return -1;
> -	}
> +	if (!img_data.ramdisk_size)
> +		return -ENOENT;
> +
>  	if (img_data.header_version > 2) {
>  		ramdisk_ptr = img_data.ramdisk_addr;
>  		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
> diff --git a/boot/image-board.c b/boot/image-board.c
> index f2124013046..eca1b1d2bff 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -427,7 +427,9 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
>  				unmap_sysmem(ptr);
>  			}
>  
> -			if (ret)
> +			if (ret == -ENOENT)
> +				return -ENOPKG;
> +			else if (ret)
>  				return ret;
>  			done = true;
>  		}
> diff --git a/include/image.h b/include/image.h
> index dd4042d1bd9..2ab17075287 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1858,7 +1858,7 @@ int android_image_get_kernel(const void *hdr,
>   * @vendor_boot_img : Pointer to vendor boot image header
>   * @rd_data:	Pointer to a ulong variable, will hold ramdisk address
>   * @rd_len:	Pointer to a ulong variable, will hold ramdisk length
> - * Return: 0 if succeeded, -1 if ramdisk size is 0
> + * Return: 0 if OK, -ENOPKG if no ramdisk, -EINVAL if invalid image
>   */
>  int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  			      ulong *rd_data, ulong *rd_len);
> -- 
> 2.39.2
