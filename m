Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801F4C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 13:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399ED82B7F;
	Wed, 30 Apr 2025 15:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LPdkpdXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7362A82B7C; Wed, 30 Apr 2025 15:54:44 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715F78070C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso39044766b.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021282; x=1746626082; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kqby9Oyz2/8caO7rjq9zhT0Bw8KDvVVJGiR8EvPuPXM=;
 b=LPdkpdXbj74m6AYqM1zQBQC+jVDyRBL9HSLoDA5hp+q/Q3gKm0hdZ50ok9itjZACIm
 0mB6BiJvpUMZEIwUfrtj13swOCyJ5e7mEQs9R1xZDHSQfWuDjVCyAIHfZEHwzaC6FBoS
 s7XEr+namGumw/EnYDByWlBCzQTIZgx+i9yJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021282; x=1746626082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kqby9Oyz2/8caO7rjq9zhT0Bw8KDvVVJGiR8EvPuPXM=;
 b=p1yr8S/7C/9BTIBWwLCHYYO3YQcbmtJerdxoXZd2c1mtgNHBdC2uLKMCRfbKXQBMh1
 tvHKT+Ha1i/HmTySh+tnxP6poPm4GrrgvKyIlU/cIegNoO7gT1+rY4+a/JCEcXuAQACd
 eNAq2kzzXKJlxkoDKC+KbIUEOeC23kCmcyVzxQ3dbyR9va7nG9zV++pIS6AkC/undfn+
 1A7cwMTGRUk7vtgTdD2hIO4bELwMs+YPp6kW7mjGYHyRt6uHllCcaN19aprCF17dklp5
 Klk/ZHYXgyDtgXIsTVZY95SLmyDrkC6wX4pUAVER1i5DE7ofJDG+nAtkq//St1THgjp1
 y6nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmcGR4swhMdUrS3T7ig/emgIkI/Xc3T67e4RiHcNeKn71ThgwCpDZDSXWimF2LOp6Pv/C/tX8=@lists.denx.de
X-Gm-Message-State: AOJu0YwaUAgFQ50fCCGPTK1oZARONpt6UZ/DsG2yWevV9kOtvg/zS2vq
 zVELVowsAhfNxXI2LDU8kC1Y0gXk1pFXqms/UI5l0pX8Bnes8nqXjvZ1HTLHuDC4fq1j7P1kVbR
 42oV8wDeiKp26VnxEjmskDlkIUTgN/gkIAoxH
X-Gm-Gg: ASbGncuVimUI8Q7Wpme4wrIUR8F10iKH1KK8po6xsRgjpzGtFsXUk6QInQXpq5VqxlE
 2kviWQhtNR6SNsuzX7wr45oyxcipeq07CHavGBqsYFpLfQ4Tltd66oUSHCNNTFAvHcMtw56q8SA
 0EL6k3UQ+QwP7NFUqUUzFrO9e+20Fq/VWKbg==
X-Google-Smtp-Source: AGHT+IFRIzR3lRNVa52p/OliDAUwR1sR7AIvMEHvnPFz8dGYxV4k8h6WF05v2vMaCdxYzEZF4X6zPJOPM7N0fiwmXRA=
X-Received: by 2002:a17:907:9801:b0:ace:c225:c721 with SMTP id
 a640c23a62f3a-acedc56d9cemr289911966b.8.1746021281912; Wed, 30 Apr 2025
 06:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250430071613.13508-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430071613.13508-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:54:28 -0600
X-Gm-Features: ATxdqUFXMvsunvL8Zlr31m9nyXZCkQ3bLih75CpWmgkt_tpnNjYjnO7FgqVbuHw
Message-ID: <CAFLszTgoo=_0WK+ks8nccOUX4X8CqTryQnUQZuP8EwwLy0SEgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot/image-fit: improve 'No Image' message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

On Wed, 30 Apr 2025 at 01:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If an initrd is invalid, we see output like
>
>     No Unknown OS RISC-V RAMDisk Image Image
>     Ramdisk image is corrupt or invalid
>
> As most image type descriptions end on Image, we should not repeat that
> word.

Instead of that, remove the 'Image' from all the types and reduce the
size of U-Boot by 200+ bytes.

> Instead of misleading 'No' we should write 'Invalid' here.
>
>     Invalid Unknown OS RISC-V RAMDisk Image
>     Ramdisk image is corrupt or invalid

What this is actually saying is that the image is not of the requested
type. It may be a valid image but it doesn't match the requested
image_type. So calling it invalid is going to be very confusing.
People might then start trying to figure out whether the image was
created incorrectly, etc.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 41ab1f552b0..856de6b731a 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2196,7 +2196,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>          */
>         if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
>                 fit_image_get_os(fit, noffset, &os);
> -               printf("No %s %s %s Image\n",
> +               printf("Invalid %s %s %s\n",
>                        genimg_get_os_name(os),
>                        genimg_get_arch_name(arch),
>                        genimg_get_type_name(image_type));
> --
> 2.48.1
>

Regards,
Simon
