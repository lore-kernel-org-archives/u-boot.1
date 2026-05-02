Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73D7CD3424
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 07:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F103380F0E;
	Sat,  2 May 2026 09:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BbMjf3Ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFCB83693; Sat,  2 May 2026 09:29:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6272080077
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 09:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 077F63F1CC
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777706939;
 bh=qfQeC77jcppN9Q88H4ZJjMod+lf6yKV2+SV13V9aihI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BbMjf3AiNi0uewlCJmOv651OhVm1xAUY2dCD2SClWPzvrkUlNW/ITFfu2X8MMmZAF
 zi/UtlqGoUA4CG26GubpmED58h9l7YDvABJfhzVnW67Cy0uhCQjn3bbvbgVgUTieVm
 Q/b9y4jXgyjXRcUUKraDsu5xk4ExGKDA7i3PEgeY3GaQvCTeo8dNkCRlrxINkUZUM2
 ZnOIXvaz2aPPiqf7MDEyBKjL/2piEPXryPNg1nn5HsiPqI61AAk5IHtrDehzw3sATw
 JkcINMqU81nlTSw4l1XbDIshKFtOuQYguCUr9tusU5VNE2ZYqbJsmUyJnxHMInsgew
 3ipf9qbK1PSorhQk6PUTVUf2kPBuTboE898nXddMsbFf9YwtWb2Nm3zqz+IGYAGfRp
 0jr2sJcB9gZpEl8n8/Tk+wVI9nbZxHLFJZzrFpRjuTatlrhORoTr8q9b3YTGchAcOO
 iPgjdyM/m2hjCIZkCY/h1p5cIJTUqZcgZEkNe3YG5oE6h1A8gEWz82oHSDSD3fFfkz
 TyYVUbx3UgeWOOduoC7zvO/dn+nwtSeIH/xmjmo2zXgrINcFaApHAez1WI+4oqC2/6
 3MVRS7YeY9OQd5VTKyDp/7QHcgPZEgByeGi+337CXyzrq5FrNEiSgvoqVzp1Jewuvn
 JHNqm2p+GhYuT/2bkrg2j9aU=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a122a5128so1322614f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 00:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777706938; x=1778311738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfQeC77jcppN9Q88H4ZJjMod+lf6yKV2+SV13V9aihI=;
 b=JJhv4ak9LkR0eu3UcCLsNOBGWNe93zy44f6ATTr08VIJlJD+/ZXbyGy3Ef+yrV0fnD
 JmiZ2WdkOXiIOU4Lg0JdybevahBhdF+A1FFRavCIq3wQmE/9fJZxvkvQWzRhCEtngbWY
 9uO3SqIf6MKoUnvezr1b1xAV9AMzOtqfIdot1Lp3FH+H+7fqP62BfsKC67yuT1hw5o5m
 kpXI0bJ4xqCT12m9/WeshNo03/RaA8A/r0ussb4/rZjQmtfWXZygeCr8YGeQKUPbjdNq
 8NUmjtu6e0DClKFBUYUUOVgveac9e7Cv2uDa7hYMIXDBcZp4nNRkJeXJ7sM0AK/6ypyP
 AdyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ82zcLc0vHKMTzA0qJmMw3yz8o2NHLPdWBOjCSpMOk+d7PxkByurDw37U3n3P17UWaIWFZ+gWE=@lists.denx.de
X-Gm-Message-State: AOJu0YyNEW4nmLvf0v9Hu60D4f/JP7+Vj1Fx0ivWLN4jQIRXl0rI2j/d
 zCDXyRvf4LkY7gHHDQiPn/0ShMLy1CTNj7QgBjollbvLtmy/b1VvaYNLBdCd5G4nu9hWY1cSs5M
 Fa0vxygJYIhozr0AXpAZ2cVFrDC51e2+dd9AO77zTyJxo+YuOIsaFZbHglRsJa/qn/2QIT7Q=
X-Gm-Gg: AeBDietvQn6pVppGF8B4W6BkqLhIHF6mGD7WqXWKc1pO2gpdRbJrPLE3BF7yspLFo1M
 JwP+6un3kqbAWHoNpn64A+p6jMW+LQAkPDRJqDwvVcfeWlFNyliZVZzWRrf8mP9FtOIFTgSH+2N
 RQNTcz3/6JrT0eU+LMgij+PQYRqMU6DEvM6mV2MbGNlj64cW2NSooxecRWX4iF+KDWt9Gq2zCee
 S8vndaMTpfBfELL+kNtjBw7W8du1d7wtJdKP6pdFw9V83gU3XDsUhsTTazB/9O5usbFwtLSxnF+
 QyB8aMZvKBBNjfMdaC7yiqez+nhyiyA6bxC/XF6gpwWXwYLTvEfY4NeUVIWsOfK4CXrSHpV3mmh
 fKkX48RVJl3gbWUANWwFp1rGDHVt94SFZkyStAkaq3uilwJWYgf1v5PpiBTdqAyoKyLdpYcqD9S
 cjd5fOApFVp10UWwE2M3I5M1wuPdA0CgKVhMK2k5ZlCGszrhPtAdyV+tW7fV7RFwglFCI=
X-Received: by 2002:a05:6000:220c:b0:448:5ec1:dcb5 with SMTP id
 ffacd0b85a97d-44bb2e2e7cbmr3492048f8f.7.1777706938592; 
 Sat, 02 May 2026 00:28:58 -0700 (PDT)
X-Received: by 2002:a05:6000:220c:b0:448:5ec1:dcb5 with SMTP id
 ffacd0b85a97d-44bb2e2e7cbmr3492023f8f.7.1777706938201; 
 Sat, 02 May 2026 00:28:58 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7cf97sm11208698f8f.6.2026.05.02.00.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 May 2026 00:28:57 -0700 (PDT)
Message-ID: <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
Date: Sat, 2 May 2026 09:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/1/26 17:05, Heinrich Schuchardt wrote:
> If we use video copy, bit image transfers need to write to the in memory
> copy of the physical frame buffer. Damage control will sync the changes
> to the physical frame buffer.
> 
> Cyclic video copy will catch all changes done by EFI applications directly
> accessing the frame buffer copy.
> 
> gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
> sandbox address.
> 
> With this change the block image transfer test works again on the sandbox.
> 
>      setenv efi_selftest block image transfer
>      bootefi selftest
> 
> Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   lib/efi_loader/efi_gop.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index 9403e09691e..ae44d140289 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
>   {
>   	struct efi_gop_obj *gopobj;
>   	u32 bpix, format, col, row;
> -	u64 fb_base, fb_size;
> +	u64 fb_size;
>   	efi_status_t ret;
>   	struct udevice *vdev;
>   	struct video_priv *priv;
> @@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
>   	row = video_get_ysize(vdev);
>   
>   	plat = dev_get_uclass_plat(vdev);
> -	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
>   	fb_size = plat->size;
>   
>   	switch (bpix) {
> @@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
>   	gopobj->mode.info = &gopobj->info;
>   	gopobj->mode.info_size = sizeof(gopobj->info);
>   
> -	gopobj->mode.fb_base = fb_base;
> +	gopobj->mode.fb_base = (uintptr_t)priv->fb;

I discussed the value of FrameBufferBase with Simon.

The code before the patch is incorrect, as on the sandbox it does not 
provide a pointer value but a sandbox virtual address. EFI applications 
may use the pointer for directly writing to the frame buffer. This would 
lead to a crash on the sandbox.

For the case of CONFIG_VIDEO_COPY=y it is problematic to pass the memory 
buffer address here, as Linux has an EFI framebuffer driver and would 
write to the buffer instead of the physical framebuffer. But our memory 
buffer is neither reserved memory not is it copied to the physical 
framebuffer after ExitBootServices.

If we pass the physical framebuffer address here, then an EFI 
application might write to it and the cyclic video sync would overwrite 
the changed pixels.

Setting PixelBltOnly in field Mode.PixelFormat forbids EFI applications 
to directly write to the framebuffer.

So if plat->copy_base is set we should pass PixelBltOnly as PixelFormat 
and copy_base as FrameBufferBase.

We the aforementioned change we will need to change function 
gop_get_bpp() to not rely on PixelFormat. Instead we need to pass 
priv->format in a private field of the graphics protocol.


>   	gopobj->mode.fb_size = fb_size;
>   
>   	gopobj->info.version = 0;
> @@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
>   	}
>   	gopobj->info.pixels_per_scanline = col;
>   	gopobj->bpix = bpix;
> -	gopobj->fb = map_sysmem(fb_base, fb_size);
> +	gopobj->fb = priv->fb;

priv->fb is also the value used by the TrueType drivers.

Best regards

Heinrich

>   	gopobj->vdev = vdev;
>   
>   	return EFI_SUCCESS;

