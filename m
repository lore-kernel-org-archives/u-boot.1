Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C3C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84CA81B4B;
	Tue, 28 Jan 2025 09:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1WSF5t/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB30781BC0; Tue, 28 Jan 2025 09:29:09 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EA78197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so37011875e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738052947; x=1738657747;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3rdb0dhxP+KPq6QGsJuAh2nkaNIsekcJqMIh7M0hWs=;
 b=1WSF5t/fFsd9vS594TEsDCn0pECHviVKBWGQmbCKHmPGfYhHX0J7eBBhXegbXIYgam
 s65V1XF0onzRfVshC5CZ3XB6ILkF0mW2mNpV0mseKG4kGbtuqmQ2Wy4otDk1cTA5IrAw
 2K5qpDo9G+sKiSMLgcQLW2y5mVfYIiXdkoP91oiv6KR//0yYSWixSGGxEZ+pMO+SJkm1
 m/GucpcgLkUmY13nHEmNvMpHmIV47bfPF0MzvrB8e83UHJpDoqVm7RjS6HINMmoQ3e4L
 oLoNzIH89nJhp4Vo1EMpkIqKZGpvy4dIRaygFzA+iIDVL2igLg9Bc1l/ppiuZ2GhZkbi
 2XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738052947; x=1738657747;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3rdb0dhxP+KPq6QGsJuAh2nkaNIsekcJqMIh7M0hWs=;
 b=U+fQ1vcswIYrabXEjyp4cVdeEJQxcrIgJV16gS2KW3x9QLtmwJGfDusJSX2f1Vw0H3
 YR3l/NHLkDe4zjg+bpUc0skMVBgIVVoKjUCC48lnKbnP+slAaAqy+kt2l+jidma9OkxI
 DrECkYw5koigr+bwEE6N+aJTAaYxCRHQeOwRH2AC4fBZGcFZImNPGiVLWSCyW4ng8gBf
 h+7qPUxFdJNzYBnJXsdykHY+IdHm7A/DGS01XKvkjrlAnr3og/DV8qUnsaZ/QJfwStzz
 ZNQuv3DhbanSKdqxg7vOgpVnwGDiad/8BEKpEt8FMU0CrHeI62OtOQRawW6+kxuKCvho
 ATCg==
X-Gm-Message-State: AOJu0Yy8SdSFCn8p8DnC3LEaz1C/1m4bj7kSJ+Do9MiYp9Z7vtoONxjK
 roGSW6VULWIXpqWbL/27qfTghrskAVYR2QY+KCXoZ0XtDK9PaaKiUmOsyq7KkqI=
X-Gm-Gg: ASbGncuB1rGlWJXQoRtQGkzfSsOAl2toxEYjRafTcg9/WsVw9JFE6rXJbR45H+7RmA1
 38Svw0NTgUEbgbFrSUc5FPLRfW8IBbT0BWobqeEqcIJjwMHUGDazm+ItaqrMAFqr9/xbiRBIeX4
 jKGDt3z8xEMVZ9SoRSIA6x2U/lAHEMk1gBnikzWHLTcaQ7KELDkk/ksv6uwc7Rzz5xtEBnqbWJD
 vtkD5JfBXkYU1DQUbz0VZ4KSahFOeesMBLMk3YufhkSzlnv2iCPTACkr86WRsaH9nk4f0rUG0a3
 QsOkR6YVcICsOCb9/Fa5jVKJ
X-Google-Smtp-Source: AGHT+IE/O/DoVHtx+NDv5t8PO6CRnf+QSCbg3xSFcUFzhoRX87eTfReInBN7nSSE5ukSe6H0tZzOIQ==
X-Received: by 2002:a05:600c:1e21:b0:434:eb86:aeca with SMTP id
 5b1f17b1804b1-438913d2d6emr444730545e9.10.1738052946726; 
 Tue, 28 Jan 2025 00:29:06 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507e0csm158138645e9.20.2025.01.28.00.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 00:29:06 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>, Safae Ouajih
 <souajih@baylibre.com>
Cc: u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: Re: [PATCH] boot: android: handle boot images with missing DTB
In-Reply-To: <20250123-android-handle-no-dtb-v1-1-1cb7373247da@samcday.com>
References: <20250123-android-handle-no-dtb-v1-1-1cb7373247da@samcday.com>
Date: Tue, 28 Jan 2025 09:29:05 +0100
Message-ID: <878qqvs5ny.fsf@baylibre.com>
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

Hi Sam,

Thank you for the patch.

On jeu., janv. 23, 2025 at 14:35, Sam Day <me@samcday.com> wrote:

> 607b07554e2 removed the check on the return status of the
> android_image_get_dtb_img_addr call from android_image_get_dtb_by_index,
> which results in null pointer accesses shortly after when trying to
> check the header of a nonexistent DTB.
>
> Fixes: 607b07554e2 ("android: boot: move to andr_image_data structure")
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/image-android.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..4fdf56dd1bd4ee26cd4d030532f75d8f48c0b8ee 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -696,7 +696,10 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
>  	ulong dtb_addr;		/* address of DTB blob with specified index  */
>  	u32 i;			/* index iterator */
>  
> -	android_image_get_dtb_img_addr(hdr_addr, vendor_boot_img, &dtb_img_addr);
> +	if (!android_image_get_dtb_img_addr(hdr_addr, vendor_boot_img,
> +					    &dtb_img_addr))
> +		return false;
> +
>  	/* Check if DTB area of boot image is in DTBO format */
>  	if (android_dt_check_header(dtb_img_addr)) {
>  		return android_dt_get_fdt_by_index(dtb_img_addr, index, addr,
>
> ---
> base-commit: a3b71cc6f5cc74d4edc5808790a3d2999ea3f7fe
> change-id: 20250123-android-handle-no-dtb-ac3e49f7bec6
>
> Best regards,
> -- 
> Sam Day <me@samcday.com>
