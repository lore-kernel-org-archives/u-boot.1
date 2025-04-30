Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B73C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C908081A;
	Wed, 30 Apr 2025 15:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hf/A1fLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B1582887; Wed, 30 Apr 2025 15:54:31 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251928070C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5f728aeedacso8895128a12.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021268; x=1746626068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iUQ8cCo+YQa+/Tieu+y2bitsu6X+GahAYWkcO0NqpGY=;
 b=Hf/A1fLyGT9p6E1q2iMZ1Aw/zOPwMCGKH9eNKd7QXHjofBoRhg7c24DxokQDnxIh/h
 EwbBODfG/2FeFTOtxBI2xNo5IM7n9jTm2GdOv/rJDDzghXDXRaXA0JUIcJiKKOst4dLC
 yRPb+hT4XgfiwYCtRaVPHK0roQ/U/0fRG3uww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021268; x=1746626068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUQ8cCo+YQa+/Tieu+y2bitsu6X+GahAYWkcO0NqpGY=;
 b=G8CN1cslSUVoqu5nbfIchZ6fWOQ7mtNUzV9D4M6tmnD3cOd2OQECNHQ0jJjIyjovxD
 HTIBS08/S+oqb+6cs1h4oi92Y+mqs8wEr2ZM+mrCrMW4UdEzl6Fs9Lz1nHckxeu4haLD
 lpjaZ5wlpD+eLpbQIJFp1kIYWmiMES8dDJcvrUCiq5mapMp2KgHQAHwa2ciYTuA92usg
 25e/eGqSndaInREhRg4dtDEgKdBnfVnix0kVuWVB0qYWKLAu3WLTK/ef6LQ1pBH/n2Ql
 nKhnQzmVOZhWo2v48cFO+9po8pyHTjoBIp8xuORAj0bFyQsHnnx0ydTpWjzaP8fPClgt
 q34g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfOcWTtfktsC1K8juXKyxvPNLBE3uatyhlmGTzgdDHLyG4gOqaTgb7nc/4Mf6aOtt4WwcRov0=@lists.denx.de
X-Gm-Message-State: AOJu0YzW8SG26jEDSSwZdMnG3NLwf6Hwd+DWRQqlntW9brApuCfekuhH
 pVpdXe1LTATUuamNYiaqlT0xnZyeQfgmTjpr3/u3hC6AE55UKsapMt3GbeCOGhH19/6g2iz0ypf
 CIglee4gbwKdGdoU4FUKup6c/21x3GOGFw7WE
X-Gm-Gg: ASbGncst4nHOD/OZCn2+jAJqNDmZAaSGWdvvwFnm0YUhSKiPtsNmn81dI8Ph5ft+70k
 eU+QQoZA0rRVUd7E8MEjmmDe0m6ovs1dYqN8Iu7g+IZ+ESxFzN4OPkCbfwFgE8HMVhbUEUyX8Vh
 bdOGBnrh4CN9mp2lcVjJaIZ0s=
X-Google-Smtp-Source: AGHT+IEBvzWGCdlX/JZE+/l6TLy1rBTQoZnQZEtmQKismxtt3mNPxdMwoqtfFXQMU3oR0sRGrV4lDzIOfFI2ZHCRwds=
X-Received: by 2002:a17:907:6ea2:b0:ace:d95f:6582 with SMTP id
 a640c23a62f3a-acedc766b9emr347755166b.53.1746021268567; Wed, 30 Apr 2025
 06:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:15 -0600
X-Gm-Features: ATxdqUHCkCUYI0xmaIxoC3l8qBsuplxmUtDcldZHiCLBWEyWudgT3Fi9AgSAPT8
Message-ID: <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI sub-system needs the load address and not the entry point
> to boot the binary passed from the bootm command. The entry point
> is derived from the PE-COFF header of the binary.
>
> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootm_os.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index dc9d3e61fca..a3c7cb5332e 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>         /* We expect to return */
>         images->os.type = IH_TYPE_STANDALONE;
>
> -       image_buf = map_sysmem(images->ep, images->os.image_len);
> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
>
>         /* Run EFI image */
>         printf("## Transferring control to EFI (at address %08lx) ...\n",
> -              images->ep);
> +              images->os.image_start);
>         bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>
>         ret = efi_binary_run(image_buf, images->os.image_len,

In this case ep should be set to image_start as it is with many
methods. How come it isn't in this case?

> --
> 2.48.1
>

Regards,
Simon
