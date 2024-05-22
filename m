Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B7AC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 13:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5331788831;
	Wed, 22 May 2024 15:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QK1el1Iz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FB688832; Wed, 22 May 2024 15:30:47 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A37882DA
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 15:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e45c0a8360so55460651fa.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716384645; x=1716989445;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CoSjT04sg8Cl2q/LjJgDzBO8nfCgkXv1Wi3EFMdb+CA=;
 b=QK1el1IzFMvSZdPFQ2ESf+WdpAxDZNfWboVO29xfERTi03KJbGVRZpuFdr1p8tIknN
 f0SeQQ8PF+cXaRM/dmAj0mralaRxvYxvXEIode9heQHwOGGG+bPcaDvhRRJ3URNCyV5M
 CvynZK+NSKjLezhtlRMKtgZOG/b0JUt2WwikLNN5ISyyTnl9IoBwpmToYR95ODGCkAWX
 CgUcPlRg8WZvRXsk2qW+HR1jSIhQe/zeO7yMLArwlXRWCjZ5KcR0XMtJH5+fSD7UQ9FG
 ZsMG/0NBhrLwSZvZvYbPAsH14bSkzU1LZi5LTpZie3SdXJqe8sUvczi4SFI6LSfPKw3d
 j6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716384645; x=1716989445;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CoSjT04sg8Cl2q/LjJgDzBO8nfCgkXv1Wi3EFMdb+CA=;
 b=H+Y/3QfX0eqt/a2kMimiirVK/+Eu7/a+yNSpt25ul4yyuXqaDVMxQ57fe8KxpFbCBk
 pn9zyY5pkTU95mf5zYomZeSMVnTcGhKgLDCkDXZyBkCO6d3eopUc/ZWLv7ZRatKMUKgr
 fuBklp/tZX5/FOP4qTEA+ZwbOMBWhkoEdTPcmsVFkIxZtRedL/YmJZjJCdwgyCRAgpf8
 /T7ybRFZhB+SJje1Pb8lJBtLcSbyMyn6i1u482Q0ie2XtgOE1VU6rmH2gW2kbUNHRZWI
 7ODPrQnOK80nv+KDI7xuttw9XR0CAeOjUkEZfNDkUAWWXsaJYagRC6sR2uqLn4rPzuHH
 65WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr1ytvXfG1RZDMRuk5us5Zv8yW6EcL4ii9nqap+SIEqe6Oa50qx44hGfaWv9hZ/L9nvAXd+Kt0JJg9GXlpaWHFX3M3qQ==
X-Gm-Message-State: AOJu0YyGaLSBTF9hoseuHUdNdJreg2ej2221a5LYD/3MLUwKIZ1OJxiF
 AO3Qc9MI43BUAAmbI8VdokNxlzVBVs7tEBC1K0fosjkJxQ0gyCcKM4DgzPKsW7Vs+OiY2jhsD+5
 gvek=
X-Google-Smtp-Source: AGHT+IEniqygoy5iAQbXlRrLrjpSW9j+5PLCuE24wqsvcvCiUNYWnOFvi9xEMrfIS5W5X97R5MaXhg==
X-Received: by 2002:a2e:9207:0:b0:2e5:67bc:6f2 with SMTP id
 38308e7fff4ca-2e949562b34mr12767711fa.44.1716384644684; 
 Wed, 22 May 2024 06:30:44 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354cdbfb964sm4743935f8f.25.2024.05.22.06.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 06:30:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, r.stratiienko@gmail.com,
 u-boot@lists.denx.de
Cc: sjg@chromium.org, igor.opaniuk@gmail.com, semen.protsenko@linaro.org,
 souajih@baylibre.com
Subject: Re: [PATCH] android: Fix ramdisk loading for bootimage v3+
In-Reply-To: <20240519130951.2558467-1-r.stratiienko@gmail.com>
References: <20240519130951.2558467-1-r.stratiienko@gmail.com>
Date: Wed, 22 May 2024 15:30:41 +0200
Message-ID: <877cfmynwe.fsf@baylibre.com>
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

Hi Roman,

Thank you for the patch.

I know you reported this problem quite a while ago [1].
Sorry I did not follow up.

On dim., mai 19, 2024 at 13:09, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

> The boot_ramdisk and vendor_ramdisk must be both concatenated together.
> Without this change, Android root is missing some of the necessary tools
> to complete virtual AB OTA.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[1] https://lore.kernel.org/r/CAGphcdnC124V_D6x06P6apnE+L+PVJSp+88h0FFY449CBgY=Pw@mail.gmail.com

> ---
>  boot/image-android.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 04f2a8015e..499eae9bcd 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -64,7 +64,6 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
>  
>  	data->kcmdline = hdr->cmdline;
>  	data->header_version = hdr->header_version;
> -	data->ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
>  
>  	/*
>  	 * The header takes a full page, the remaining components are aligned
> @@ -75,6 +74,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
>  	data->kernel_ptr = end;
>  	data->kernel_size = hdr->kernel_size;
>  	end += ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
> +	data->ramdisk_ptr = end;
>  	data->ramdisk_size = hdr->ramdisk_size;
>  	data->boot_ramdisk_size = hdr->ramdisk_size;
>  	end += ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
> @@ -462,25 +462,24 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>  		return -1;
>  	}
>  	if (img_data.header_version > 2) {
> -		ramdisk_ptr = img_data.ramdisk_ptr;
> +		ramdisk_ptr = img_data.ramdisk_addr;
>  		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>  		       img_data.vendor_ramdisk_size);
> -		memcpy((void *)(ramdisk_ptr + img_data.vendor_ramdisk_size),
> -		       (void *)img_data.ramdisk_ptr,
> +		ramdisk_ptr += img_data.vendor_ramdisk_size;
> +		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
>  		       img_data.boot_ramdisk_size);
> +		ramdisk_ptr += img_data.boot_ramdisk_size;
>  		if (img_data.bootconfig_size) {
>  			memcpy((void *)
> -			       (ramdisk_ptr + img_data.vendor_ramdisk_size +
> -			       img_data.boot_ramdisk_size),
> -			       (void *)img_data.bootconfig_addr,
> +			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
>  			       img_data.bootconfig_size);
>  		}
>  	}
>  
>  	printf("RAM disk load addr 0x%08lx size %u KiB\n",
> -	       img_data.ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
> +	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>  
> -	*rd_data = img_data.ramdisk_ptr;
> +	*rd_data = img_data.ramdisk_addr;
>  
>  	*rd_len = img_data.ramdisk_size;
>  	return 0;
> -- 
> 2.40.1
