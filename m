Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB44C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DF18826B;
	Thu, 13 Jun 2024 17:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2vhNbrUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1635787D87; Thu, 13 Jun 2024 17:42:22 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0380488315
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f1a7386d5so1188600f8f.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718293339; x=1718898139;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1KJvrvZoEAQAVQ/Cst/cJQ1kEEQ0Pp/LCu8FRuP3Q2M=;
 b=2vhNbrUmz3QGNKvyhVOXTXKcudMqUPzDSlJ+LrS2N8B1XDKZX8K8jxFSkqKEDAZ13F
 I/rsOYVNCAmBq5iU9zzq/fdaIjHo/q34VZjRLVn+wIVerwpFmnqHRJ/JKvoDuv0ubyov
 4/V1dcI/SI4FwFNTcnYXQD/XswcRuHGW5TlcD4HNoyZh+/892bXTSEOaXrjmaoGwZwHb
 Bt1nD67dsiC/3ZSxuzgoEOgpEBzufdhoeWZ1Iwxu6lk17+j5hh/YYTYY54HVNie4WRKc
 2vJVonP69uko/dT22dpjI4OAtQJqw4O7zmdThfa61SFB52myiliaJflBXuPI0XFmP4mh
 CwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718293339; x=1718898139;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KJvrvZoEAQAVQ/Cst/cJQ1kEEQ0Pp/LCu8FRuP3Q2M=;
 b=a6zvnQvLggx01ZpZn0fWvDJ+Q67FhWYdlMfgnw4KJOZLpgyGQj1h4OdXAtx3U5kQ3T
 517Jvfh8cWldkgwiTmNfn5U622qABn5lnjm3CxToV/ZLRkdK3v5LwTNgC/P5YSmqH7zF
 6HwjLhs9K2Q/koq3KBCzFktV4mxEAvXJHPQYu1n1rcbqvCMTSZ9kadpurlkXMeKnW/Q/
 hTLXmxp/zi5BeHAFkdgiCVZBiimXRIacX9MEsio5R8Oi9WB7+2PyV9xYcjBVGzf7yu/s
 7p1SVKmN0HXrkzE+V0si27fTZ/twtiMh+zHFw4lsjXNEoAVw1rMPE1kyJzv+EX/aEsBL
 Dq7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEIxPWAVfetgweNbiafujQBRAmOOOvcHv13nORmL/c+5eWTiz11SXNn4gPJxMH/oA1cl/WVzM5BUhtmyP6N922aWqJag==
X-Gm-Message-State: AOJu0YxoQ8jABbQfAZ63bs0Ev5JOj2a++Awg9AOkcFa/BnURW8YIuzTe
 2S37Za+MoolDcr6Qc80uJk5kQ2HaMvNU3L+gbP/ItG5hjt7vc4It9v6tqkw3rpM=
X-Google-Smtp-Source: AGHT+IHCnZOVlzlarph36f3ZVtfw21N8QO/tOCb+/4+V5KXLkaJ9onh2lE6xEYc3V0NQYk1PT1mO6w==
X-Received: by 2002:adf:e948:0:b0:360:6fba:40fd with SMTP id
 ffacd0b85a97d-3606fba419amr3112677f8f.51.1718293339308; 
 Thu, 13 Jun 2024 08:42:19 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36079192f17sm1279425f8f.74.2024.06.13.08.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:42:18 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Roman
 Stratiienko <r.stratiienko@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
In-Reply-To: <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Date: Thu, 13 Jun 2024 17:42:17 +0200
Message-ID: <878qz8n92e.fsf@baylibre.com>
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


On Thu 13 Jun 2024 at 17:42, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> When calling android_image_get_dtb_by_index() using boot image v3+,
> we should also pass the vendor_boot ramdisk address.
> 
> Use get_avendor_bootimg_addr() to do so.
> 
> Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr()
>        returns -1.
>        for legacy implementations that don't have CMD_ABOOTIMG, add a weak
>        implementation to avoid linking errors.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/image-android.c | 5 +++++
>  boot/image-fdt.c     | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/image-android.c b/boot/image-android.c
> index ee626972c114..09c7a44e058a 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -56,6 +56,11 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
>  	return BOOTCONFIG_TRAILER_SIZE;
>  }
>  
> +__weak ulong get_avendor_bootimg_addr(void)
> +{
> +	return -1;
> +}
> +
>  static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3 *hdr,
>  					       struct andr_image_data *data)
>  {
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 56dd7687f51c..8332792b8e80 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
>  		 * Firstly check if this android boot image has dtb field.
>  		 */
>  		dtb_idx = (u32)env_get_ulong("adtb_idx", 10, 0);
> -		if (android_image_get_dtb_by_index((ulong)hdr, 0,
> +		if (android_image_get_dtb_by_index((ulong)hdr, get_avendor_bootimg_addr(),
>  						   dtb_idx, &fdt_addr, &fdt_size)) {
>  			fdt_blob = (char *)map_sysmem(fdt_addr, 0);
>  			if (fdt_check_header(fdt_blob))
> 
> -- 
> 2.45.2
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
