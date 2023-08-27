Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A082EC83F01
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 14:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF4B833CF;
	Sun, 27 Aug 2023 16:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pHsgiezf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977BD83F7D; Sun, 27 Aug 2023 16:56:57 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04543807C4
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 16:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso22615845e9.3
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693148214; x=1693753014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wVc514hcDXak7OoSzZPCIiFsq6TRgmR96Ji4SyUd/2g=;
 b=pHsgiezfjSiAJNyZhuDFjTf3ZpirIqRak36V7sPKJ+XFK6eODPvrIa/d1VMciNMBsL
 G7Yudg8Fd3TCrC3rhGXZ+BCk2u9+0FELVfDx8dpINI3xEeCbcJC+5B2lBHT4svdtVhH8
 UcY7KrU0Rtc4fHkMx7A0Bo6Rb1baxNh2BkneHb9KCzJBOfB3nyi4C3jrT46Yr3JZ5+Z/
 L8vh2fIfuob3JDJKhW0awI3XlDdVV6R/EN4c3rB4qfonj6FX2hD0VI83mYHAAtcLac/z
 Z7zJsTcBV7x4A2WzdOU1DTe8yA8D2HHMe3JDn0yC1BPBbj2e8RRHOJoa3zdhEc1MuD7i
 MJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693148214; x=1693753014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVc514hcDXak7OoSzZPCIiFsq6TRgmR96Ji4SyUd/2g=;
 b=XrW4BsSbJ6++Sx488/+kA9jA87pTjHUAaBVwM/aaVBF0ipCT3JmKX7aak8iTCO+jeC
 FLKNWZVBQf8VDGwF7RynmeeWKV91DDMO0TiWk73yB9L9SPUqQ/GJEUapWptmmuE2D3w4
 ODKaCV0f4IJ2RieU2wD9Jo5eKNQVY3QfBkQKaN9l/Oj9180Mw9KpkBD1xFXKN/LmfU6t
 Y3xK5BOqFLct7zS3LQuF4Teej4VyJb/Lg8oQf+VzstWZaxakhmFy7+U/7WlIcYyHEfFA
 1KGkJSAHswSRNyOrTBr2FSLblRV5M2nOly/sqHme/rOCAXmMSuqb+9O+D3X3R/wptlut
 WDQg==
X-Gm-Message-State: AOJu0YxKmHMBZyTHMdLzzI7GiFBFwLiQCORD2LoUApsVk5nSLq8DzH8y
 00TNhmYEoIBwLyZn1b5rQlg=
X-Google-Smtp-Source: AGHT+IF2gQYTYQS5gOths0Y06A0iO8qblDJOWxTm5rBGz56gbAVDpTy3gnG2WHBA/mLz4yolLz9Ezg==
X-Received: by 2002:a5d:53cc:0:b0:319:8cc9:6d9b with SMTP id
 a12-20020a5d53cc000000b003198cc96d9bmr16146233wrw.8.1693148214090; 
 Sun, 27 Aug 2023 07:56:54 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a5d638e000000b0031971ab70c9sm7797477wru.73.2023.08.27.07.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 07:56:53 -0700 (PDT)
Message-ID: <af866d03-d097-48b9-994a-450ac4702d34@gmail.com>
Date: Sun, 27 Aug 2023 17:56:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Correct handling of frame buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230825192842.1957055-1-sjg@chromium.org>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <20230825192842.1957055-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2023-08-25 22:28 +03:00, Simon Glass wrote:
> The efi_gop driver uses private fields from the video uclass to obtain a
> pointer to the frame buffer. Use the platform data instead.
> 
> Check the VIDEO_COPY setting to determine which frame buffer to use. Once
> the next stage is running (and making use of U-Boot's EFI boot services)
> U-Boot does not handle copying from priv->fb to the hardware framebuffer,

So far this copying seems to be done case-by-case like calling
vidconsole_sync_copy() any time vidconsole does something, but the video
damage tracking series moves that to video_sync(), so this change is
incompatible with that (it will keep overwriting copy_fb with fb).

> so we must allow EFI to write directly to the hardware framebuffer.

If you want a fix independent of that series, I think the proper
approach here is having EFI draw to fb as it already does, then copying
from that to copy_fb at the end of gop_blt_int().

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  lib/efi_loader/efi_gop.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index 778b693f983..a09db31eb46 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -10,6 +10,7 @@
>  #include <efi_loader.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <video.h>
>  #include <asm/global_data.h>
>  
> @@ -467,10 +468,10 @@ efi_status_t efi_gop_register(void)
>  	struct efi_gop_obj *gopobj;
>  	u32 bpix, format, col, row;
>  	u64 fb_base, fb_size;
> -	void *fb;
>  	efi_status_t ret;
>  	struct udevice *vdev;
>  	struct video_priv *priv;
> +	struct video_uc_plat *plat;
>  
>  	/* We only support a single video output device for now */
>  	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
> @@ -483,9 +484,10 @@ efi_status_t efi_gop_register(void)
>  	format = priv->format;
>  	col = video_get_xsize(vdev);
>  	row = video_get_ysize(vdev);
> -	fb_base = (uintptr_t)priv->fb;
> -	fb_size = priv->fb_size;
> -	fb = priv->fb;
> +
> +	plat = dev_get_uclass_plat(vdev);
> +	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
> +	fb_size = plat->size;
>  
>  	switch (bpix) {
>  	case VIDEO_BPP16:
> @@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
>  	}
>  	gopobj->info.pixels_per_scanline = col;
>  	gopobj->bpix = bpix;
> -	gopobj->fb = fb;
> +	gopobj->fb = map_sysmem(fb_base, fb_size);
>  
>  	return EFI_SUCCESS;
>  }
