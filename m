Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B65FD1CDC7
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D9888F50;
	Tue, 22 Oct 2024 11:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZEI074Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A10588FA5; Tue, 22 Oct 2024 11:20:43 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7195588F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so27767925e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729588841; x=1730193641;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=J0O1mhMetq5CnE7K4iiqKSrt+s0FH2MrOyrlLmCCNeo=;
 b=ZEI074Mlpt/QckDx4v8er73NrQOrTvILJWWvPIvrAZx3wujNJHhTfJzpJnWSpTwByS
 BZ4yDDfDdbiANnoQiOHp3wM/hvInOpP/H9Nw7q2nBHT/iLU2NibB+kau6BkylXQU9EuO
 rjMPgYYddvc9mzOs7h09Ka5KJFELSTtzmCbedRDqMcse9kkPJADMNw+Ce1pLVs3lkeVf
 +uokJhUE0l2aqnUR1W/Gr2bOBj+Veur0XOvbxoar1rktsa1lyy4FFvYv9gD3WiuuKvwr
 MduqauVZuDOkLTeXwBGrktbS1S95RRU1VHOsPpsCnj/yYpXq2SLOFjRWLuf/Brh/l8CD
 Aa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729588841; x=1730193641;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J0O1mhMetq5CnE7K4iiqKSrt+s0FH2MrOyrlLmCCNeo=;
 b=iCnKVWWRK6YytAlZwVPhKjklp0EDL2+n4fnDyTtPmm7VLczDuGYZf6GdiJ3AgABLfT
 VccJFfp9nEpgtvLVOKDSiKaXEheIJTzB2R8+xbkuxAMczTNiXW/fLaeVnxY8e9i3o7WZ
 za0nDd8ByPpU7pzDeXSYfcK1Lnxq6WEY/vKjBh95hN2/mjMUx2oq2qVEhZw+BAHhxvBR
 ro2pvO9cyJsp6bzH4r98tAZyjpVNfrLyKO4kIYvaFn9VcTVfOkKYBtcxVf6RG5zSvScn
 L7BvJT2hAYS6bdP8FKFURwfCFBkEAfjMCy/l/49x0EH3FEGO0Fdk9nLJoOvz3Ozn90UR
 UNMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIq3nlX2/DFCsWddycJC/75KsExdU0SjwGePwba9B3Zn/dUG+D5ohdvH/wEYJ3vP+luuU2/8s=@lists.denx.de
X-Gm-Message-State: AOJu0YyYqlkb+C4LZLNwqZw2h+3GNDUyiJPn3k21fkWB2fvK1s/kSdD9
 bhu31T0E5s7Omdb8GdVWmroUDVfVmhMK5/ZncxkJM4p6MfGNCo9pgo/GpIrTsF4=
X-Google-Smtp-Source: AGHT+IGH6GO4DdfW82elU34QMHf7q+ObQBXhFEfV7NaNreBrGxNrivLUfgS7G1W3QjQDnl0OoMS17w==
X-Received: by 2002:a05:600c:474e:b0:431:47d4:19bd with SMTP id
 5b1f17b1804b1-431616287aamr128223225e9.9.1729588840895; 
 Tue, 22 Oct 2024 02:20:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2fa7sm83843545e9.34.2024.10.22.02.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 02:20:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/3] image: android: handle ramdisk default address
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-3-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
 <20241017-topic-fastboot-fixes-mkbootimg-v2-3-c3927102d931@linaro.org>
Date: Tue, 22 Oct 2024 11:20:37 +0200
Message-ID: <878qugwl22.fsf@baylibre.com>
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

On jeu., oct. 17, 2024 at 16:44, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The two tools that create android boot images, mkbootimg and the fastboot
> client, set the kernel address by default to 0x11008000.
>
> U-boot always honors this field, and will try to copy the ramdisk to
> whatever value is set in the header, which won't be mapped to the actual
> RAM on most platforms, resulting in the kernel obviously not booting.
>
> All the targets in U-Boot right now will download the android boot image
> to CONFIG_SYS_LOAD_ADDR, which means that it will already have been
> downloaded to some location that is suitable to use the ramdisk in-place
> for header version 0 to 2. For header version 3 and later, the ramdisk
> can't be used in-place to use ramdisk_addr_r in this case.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 3adcc69a392f74ae64f3fbcf1b85204f60ac9aff..cd01278f211d63262f2bdad7aa1176e2c1bbfedd 100644
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
> @@ -405,9 +406,25 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
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
> +		*rd_data = ramdisk_ptr;
>  		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>  		       img_data.vendor_ramdisk_size);
>  		ramdisk_ptr += img_data.vendor_ramdisk_size;
> @@ -420,15 +437,20 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  			       img_data.bootconfig_size);
>  		}
>  	} else {
> -		ramdisk_ptr = img_data.ramdisk_addr;
> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> -		       img_data.ramdisk_size);
> +		/* Ramdisk can be used in-place, use current ptr */
> +		if (img_data.ramdisk_addr == 0 ||
> +		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> +			*rd_data = img_data.ramdisk_ptr;
> +		} else {
> +			ramdisk_ptr = img_data.ramdisk_addr;
> +			*rd_data = ramdisk_ptr;
> +			memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> +			       img_data.ramdisk_size);
> +		}
>  	}
>  
>  	printf("RAM disk load addr 0x%08lx size %u KiB\n",
> -	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
> -
> -	*rd_data = img_data.ramdisk_addr;
> +	       *rd_data, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>  
>  	*rd_len = img_data.ramdisk_size;
>  	return 0;
>
> -- 
> 2.34.1
