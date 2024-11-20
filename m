Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D42D63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFE4892DE;
	Wed, 20 Nov 2024 14:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gTzTGniU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC8C89301; Wed, 20 Nov 2024 14:37:19 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E78F89270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso3448552b3a.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109835; x=1732714635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyV+bNhWOaKCx3lO6wdRzrZqJgMiKrTpoh3zEGA1U+0=;
 b=gTzTGniUEFgsz75zdm6dJ6vFQIrF8sG3onjj0zwAJxFu/jXUBQM20qUVyRGLlEZe1a
 vPNzA0zrctpe6RRa+ocf2tzEXpgErDInNAb2vRfBKtfzVkdUelXTK+LShD8VUo2nO+O1
 UCqc60/CzEEQIXWA0ARQduf7mV3NTEfZrC5Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109835; x=1732714635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyV+bNhWOaKCx3lO6wdRzrZqJgMiKrTpoh3zEGA1U+0=;
 b=Aj5Y0cDNRNXVURHFtK/gyZM/X+ty1Hloh2yt7eKmVlbfFTbepAyYM7ohJaRSeS5zeV
 SrK1UHI+KANf/sfRyDjt2m3aIwIDHYx/8qGYDv8sVOnM0LQOzYygmSj/KmA34nZI5inq
 MRAg+WT7A82wBt4KqhuGjOOOOdfy8DYH+vgrIg745l2LIY2pO1xQHmoP4lR41fZzc6LE
 wFck1+hMv3oVVanBj5IqZonlpN+PhsHG2wObWfrYOUJ2n8pmXyLcn2l51e6rhwf3mc1U
 OGmx8MTbg/YCcPccOqr93YXaahcTq1tYZcqx6m2cTv9p1X9nhaIF9WZk49SN0sly95pl
 LWXA==
X-Gm-Message-State: AOJu0YzdCUv8thePGAhMZg78WnMSYurzXJmCkS8cIMprgjJiZEQG5Skx
 +vyrXQ7Z0k7ucEpb7dR6f0PV2RVUEo89YYIrbslPpy2+wMUETuKOn7RJce/U0oM/pGxsxGPn6uS
 nUEGjsIEPhTqzrSQWmmpfbheGfnfT32GXoOgy
X-Google-Smtp-Source: AGHT+IF3YGZdULAXRYCbCZ/TjbHF6O9uRkfHT5nyeSXljeewYXVmqASV5fov2PJMkxOBssgxAnhSd15GVEscHJwdsR8=
X-Received: by 2002:a05:6a00:850:b0:71e:e3:608 with SMTP id
 d2e1a72fcca58-724bee43e49mr3922935b3a.26.1732109835158; Wed, 20 Nov 2024
 05:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:47 -0700
Message-ID: <CAFLszTgGn=x-cZB_9gJuESD2jauDhZwjEc7VX0JWvpxQ_Ro+dQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] aes: Allow to store randomly generated IV in the
 FIT
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, al.kochet@gmail.com, paul.henrysd@gmail.com
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

Hi Paul,

On Wed, 20 Nov 2024 at 03:09, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> When the initialisation vector is randomly generated, its value shall be
> stored in the FIT together with the encrypted data. The changes allow to
> store the IV in the FIT also in the case where the key is not stored in
> the DTB but retrieved somewhere else at runtime.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  lib/aes/aes-encrypt.c | 7 +++++++
>  tools/image-host.c    | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>

I see that struct cipher_algo does not have a function comment for
add_cipher_data(), so it is not clear that keydest can be NULL, etc.
Can you please add one?

Otherwise this seems good to me.

> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index e74e35eaa2..90e1407b4f 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -84,6 +84,13 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
>         char name[128];
>         int ret = 0;
>
> +       if (!keydest && !info->ivname) {
> +               /* At least, store the IV in the FIT image */
> +               ret = fdt_setprop(fit, node_noffset, "iv",
> +                                 info->iv, info->cipher->iv_len);
> +               goto done;
> +       }
> +
>         /* Either create or overwrite the named cipher node */
>         parent = fdt_subnode_offset(keydest, 0, FIT_CIPHER_NODENAME);
>         if (parent == -FDT_ERR_NOTFOUND) {
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 5e01b853c5..16389bd488 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -535,7 +535,7 @@ fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
>          * size values
>          * And, if needed, write the iv in the FIT file
>          */
> -       if (keydest) {
> +       if (keydest || (!keydest && !info.ivname)) {
>                 ret = info.cipher->add_cipher_data(&info, keydest, fit, node_noffset);
>                 if (ret) {
>                         fprintf(stderr,
> --
> 2.43.0
>

[..]

Regards,
SImon
