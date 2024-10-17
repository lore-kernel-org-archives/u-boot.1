Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC81D2127F
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976E988F57;
	Thu, 17 Oct 2024 13:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OFpGI8zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BA688FBA; Thu, 17 Oct 2024 13:36:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50288E5C
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4314a26002bso9524635e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729164975; x=1729769775;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kZcXenYJkJ6I1w/gnkSsEhjpCMCa2zdURaWktGPMr08=;
 b=OFpGI8zrfiBLert0pNaN5Ujs9Xcsg85He8HsqMDHe3uRiczfCwxrBucmVetuC+nlJr
 ECcLFzvAhHXaUrhrUockI9zrVNKhwxsRxbjRn+rfC2QwZbUyLIYQzV8RELaHBTKMz2YR
 TJPjlGZWp7qD1BrTq+qmw3gN2FB+dNg0bnKHRFeow1d/f4f1NuUGLb0c/yG7WC+1k+3E
 aBSRI8/+l4/cF2BjXlRIl21DbTcW0633g9ETH2Hncbfh7I9Sdu+K9Kl6LURKNB0BuZ83
 Ki2ZHf6ok+ZFkYXStoeL71akm8LEc5zqMPMpn8GAtIbWs+wxZ11UQZcsZLkO0zuOeDZe
 RSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729164975; x=1729769775;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZcXenYJkJ6I1w/gnkSsEhjpCMCa2zdURaWktGPMr08=;
 b=POn99vo7DhI4irQUg9tuvu+bQn+fg3Esv4tCJiuaNrYdqAN05jyYxB75o+/Zcm3V/R
 c5CI0YtmrGhid5S5u73cnpdO80tQn25cv0xqez0+X5XfDfhe4Majfzo6mfmrb1B4DMmR
 oa0BAsYzNwnt1q9TFLJKwBIXGM78DE6Fc+mJYudrOcOy+E7Asot2eXMQ9YiERz6GEJgo
 fpmf4Vll5L4gSfDSJu0zVCBMSlomfwnMoiOh5XB6K98e0jG5m/luGK/XFDmujMtZTNyJ
 O98LpN9DCwIgv70iDEQEo0BkmabIKvZov1x4va/UVCJyAHlpUs5+VPa0b10O782Xmz8N
 zVlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Z/+kfIf0/e0jUdhAP6V4m0I2rOMyuKOkvUwzMR2W2e1IO6OCb6bWwVBF6aO1+arQCA44gPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxUD67EGEXjbWhFTqgryvG67b/PWGBeWAdEwzzN4EY6J5TRzbpY
 AargkZeedQJAnMLz+z8Bad08xGXFtBVrqIZNjt3jbhF7E78unTbT/niJodAm6Zo=
X-Google-Smtp-Source: AGHT+IFLJ/ieo61mDQ/iBcdWCWLogSgzgf0pnqzWSQpGZSVPUEIr6XXfxoJUs3aUg9XRMWdVJkbf+g==
X-Received: by 2002:a05:600c:45ce:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-4314a283c8fmr65768185e9.7.1729164974716; 
 Thu, 17 Oct 2024 04:36:14 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43150455e1esm33735565e9.1.2024.10.17.04.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 04:36:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] image: android: handle ramdisk default address
In-Reply-To: <20241016-topic-fastboot-fixes-mkbootimg-v1-3-94fd9340722b@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <20241016-topic-fastboot-fixes-mkbootimg-v1-3-94fd9340722b@linaro.org>
Date: Thu, 17 Oct 2024 13:36:12 +0200
Message-ID: <87bjzj2c7n.fsf@baylibre.com>
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

Hi Neil,

Thank you for the patch.

On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The two tools that create android boot images, mkbootimg and the fastboot
> client, set the kernel address by default to 0x11008000.
>
> U-boot always honors this field, and will try to copy the ramdisk to
> whatever value is set in the header, which won't be mapped to the actual RAM on
> most platforms, resulting in the kernel obviously not booting.
>
> All the targets in U-Boot right now will download the android boot image to
> CONFIG_SYS_LOAD_ADDR, which means that it will already have been downloaded to
> some location that is suitable to use the ramdisk in-place for header
> version 0 to 2. For header version 3 and later, the ramdisk can't be
> used in-place to use ramdisk_addr_r in this case.

Is said in [1] I found some boot issues on Beagle Play with boot image
v4.

If a new series need to be send, please also adapt the commit message a
bit as it fails checkpatch:

$ ~/work/amlogic/u-boot/ neil/android-fixes ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10: 
whatever value is set in the header, which won't be mapped to the actual RAM on

total: 0 errors, 1 warnings, 0 checks, 59 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Commit 19a75a41096f ("image: android: handle ramdisk default address") has style problems, please review.

NOTE: Ignored message types: COMPLEX_MACRO CONSIDER_KSTRTO ENOSYS MINMAX MULTISTATEMENT_MACRO_USE_DO_WHILE NETWORKING_BLOCK_COMMENT_STYLE PREFER_ETHER_ADDR_COPY USLEEP_RANGE

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[1] https://lore.kernel.org/r/all/87ed4f2ccc.fsf@baylibre.com/
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  boot/image-android.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 3adcc69a392..a261bb63999 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -14,6 +14,7 @@
>  #include <linux/libfdt.h>
>  
>  #define ANDROID_IMAGE_DEFAULT_KERNEL_ADDR	0x10008000
> +#define ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR	0x11000000
>  
>  static char andr_tmp_str[ANDR_BOOT_ARGS_SIZE + 1];
>  
> @@ -405,9 +406,24 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  
>  	if (!img_data.ramdisk_size)
>  		return -ENOENT;
> -
> +	/*
> +	 * Android tools can generate a boot.img with default load address
> +	 * or 0, even though it doesn't really make a lot of sense, and it
> +	 * might be valid on some platforms, we treat that address as
> +	 * the default value for this field, and try to pass ramdisk
> +	 * in place if possible.
> +	 */
>  	if (img_data.header_version > 2) {
> -		ramdisk_ptr = img_data.ramdisk_addr;
> +		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
> +		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
> +			if (!ramdisk_ptr) {
> +				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
> +				return -EINVAL;
> +			}
> +		} else {
> +			ramdisk_ptr = img_data.ramdisk_addr;
> +		}
>  		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>  		       img_data.vendor_ramdisk_size);
>  		ramdisk_ptr += img_data.vendor_ramdisk_size;
> @@ -420,15 +436,21 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  			       img_data.bootconfig_size);
>  		}
>  	} else {
> -		ramdisk_ptr = img_data.ramdisk_addr;
> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> -		       img_data.ramdisk_size);
> +		/* Ramdisk can be used in-place, use current ptr */
> +		if (img_data.ramdisk_addr == 0 ||
> +		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +			ramdisk_ptr = img_data.ramdisk_ptr;
> +		} else {
> +			ramdisk_ptr = img_data.ramdisk_addr;
> +			memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> +			       img_data.ramdisk_size);
> +		}
>  	}
>  
>  	printf("RAM disk load addr 0x%08lx size %u KiB\n",
> -	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
> +	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>  
> -	*rd_data = img_data.ramdisk_addr;
> +	*rd_data = ramdisk_ptr;
>  
>  	*rd_len = img_data.ramdisk_size;
>  	return 0;
>
> -- 
> 2.34.1
