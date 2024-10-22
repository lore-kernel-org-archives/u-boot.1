Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFFDD1CDC7
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302C988F50;
	Tue, 22 Oct 2024 11:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2fLBzyZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F182A88F6B; Tue, 22 Oct 2024 11:19:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3E188F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431688d5127so30528665e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729588741; x=1730193541;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1FO/ZjVbOHcv5nPN1JpPwS4t8Ca0vxFn5UIhvi4WibA=;
 b=2fLBzyZ98ABwzGW+HcPCm4o/gAynSBHTG9WiYgGglDd8+7VprReu+1Z7nJWvIPT1Aj
 /v/Twp1yr/Fhj3PYKPiz/12a5nRauoIFMDp+1Pn7rbRWTRr9nimxIJ6sN0Ak41Q/hOk3
 MG876UEY70d8dCT48TyeTXppeYww+yd1j62LKVw/cZGmYy1rarWH2AdA/IxZLvdeLke2
 DaG/dlAqWeu8YdL0ed0xrS1MCuPWI9a9gSdAGGEuIdYnSnVurD6O1USeDM6ewiZfPAuF
 2pZQOFVz3dPObDrl9SqeAWCx0iDrRczH28Qj5NOdOeRu0PDdProO347YAYEgjwuyixf+
 9IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729588741; x=1730193541;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1FO/ZjVbOHcv5nPN1JpPwS4t8Ca0vxFn5UIhvi4WibA=;
 b=eu5IQKpbDxtEBp1bRZKWN0WPTuw82kGyBZ99qiNeUhak/s9wqm6fiEsLYheQRIIJ4f
 TOm97ctNhCEvEANkDZZQ0F5REMrFAMqZVAYohl6o6FKm+Mdi8uey0RKip3nOhSUc/Eok
 LYZy0kWAOtXVgEaXnxXHf4UYNzDDXNLWf2UibIctDadpfRwWdTBYvBJF6nqc6rCyYiw3
 3kLQnTKw+0bB3YMv2Ex7KsUmaRJbymqSCZHcXjTbO5S4XDj/Bw6LB6/TpnLQoJ9DgSa0
 FFXNfDYAaU3wzwtk9A5x/BjuzMfxwYCA2Z3MRXC8dCrfsvI8NTgqrEqnjjqqbT2BzN+b
 grKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5PQ7ailFURtOuugS4jS95/2tB0uxCl3jy6jPr7CE8ELnVV0QJG4NDHIGia33fidyJc5/FxYk=@lists.denx.de
X-Gm-Message-State: AOJu0Yylh0BiUiH6FhMZqND+IFifDQ3XMlNZfwibxU24x9HenBZs9K0I
 deqW+YzSWp5y6Gxlwmna8voegNr8VjCEbig8TvTfirDGWAMY71AcpjCwkmUvsiA=
X-Google-Smtp-Source: AGHT+IEEylCyV/xDAcHHos9GvulqZ0X5UnHUkxXTGLnrD799WBbavsQywPQ56tKbrFbACT7jAZOqQw==
X-Received: by 2002:a05:600c:4f0c:b0:431:5522:e009 with SMTP id
 5b1f17b1804b1-43161631ee9mr105491895e9.12.1729588741340; 
 Tue, 22 Oct 2024 02:19:01 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57fc17sm81078105e9.15.2024.10.22.02.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 02:19:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/3] image: android: do not boot XIP when kernel is
 compressed
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-2-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
 <20241017-topic-fastboot-fixes-mkbootimg-v2-2-c3927102d931@linaro.org>
Date: Tue, 22 Oct 2024 11:18:58 +0200
Message-ID: <87bjzcwl4t.fsf@baylibre.com>
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

> When trying to boot an android boot image with a compressed
> kernel, if the kernel is used in-place because it was created
> with mkbootimg, the space will be too small to properly
> uncompress.
>
> Take in account the compressed state, and if compressed
> use the kernel_addr_r which should be big enough.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index bb5f4f84487d40e0cf24dc3b57042993967e66d5..3adcc69a392f74ae64f3fbcf1b85204f60ac9aff 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -208,7 +208,8 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
>  	return true;
>  }
>  
> -static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
> +static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
> +					   ulong comp)
>  {
>  	/*
>  	 * All the Android tools that generate a boot.img use this
> @@ -221,8 +222,11 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
>  	 *
>  	 * Otherwise, we will return the actual value set by the user.
>  	 */
> -	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR)
> -		return img_data->kernel_ptr;
> +	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR) {
> +		if (comp == IH_COMP_NONE)
> +			return img_data->kernel_ptr;
> +		return env_get_ulong("kernel_addr_r", 16, 0);
> +	}
>  
>  	/*
>  	 * abootimg creates images where all load addresses are 0
> @@ -258,11 +262,14 @@ int android_image_get_kernel(const void *hdr,
>  	struct andr_image_data img_data = {0};
>  	ulong kernel_addr;
>  	const struct legacy_img_hdr *ihdr;
> +	ulong comp;
>  
>  	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
>  		return -EINVAL;
>  
> -	kernel_addr = android_image_get_kernel_addr(&img_data);
> +	comp = android_image_get_kcomp(hdr, vendor_boot_img);
> +
> +	kernel_addr = android_image_get_kernel_addr(&img_data, comp);
>  	ihdr = (const struct legacy_img_hdr *)img_data.kernel_ptr;
>  
>  	/*
> @@ -359,11 +366,14 @@ ulong android_image_get_kload(const void *hdr,
>  			      const void *vendor_boot_img)
>  {
>  	struct andr_image_data img_data;
> +	ulong comp;
>  
>  	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
>  		return -EINVAL;
>  
> -	return android_image_get_kernel_addr(&img_data);
> +	comp = android_image_get_kcomp(hdr, vendor_boot_img);
> +
> +	return android_image_get_kernel_addr(&img_data, comp);
>  }
>  
>  ulong android_image_get_kcomp(const void *hdr,
>
> -- 
> 2.34.1
