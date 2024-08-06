Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A89C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4197988D01;
	Tue,  6 Aug 2024 23:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TJLYfDX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A9488CF2; Tue,  6 Aug 2024 23:51:58 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361B588CC0
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cdadce1a57so919352a91.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981114; x=1723585914; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAme/GQzk1YxP9tyBK3bCcgq51r7GzsPYIzN+Mk90hw=;
 b=TJLYfDX1f8NRgS8LgKlbQFqlr5JYd/PTrHNEM1nu/BE2P/FnBK2zRuFP2zXnsHTVQJ
 6nLY5s3PoWUVThDdHyFu+b9r66xOBl2wDHdQ/PMt6mypRlM4/TYuWBHP8VKCkFk20+9B
 1kAycb8YjQq8cUSruBLn7lZ1YD8m3pnnhBaLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981114; x=1723585914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAme/GQzk1YxP9tyBK3bCcgq51r7GzsPYIzN+Mk90hw=;
 b=U0hLGmIpucKF0IlXGlmbc9UjiKvxUvgRqSbbCGNsyy8jUZA7mceGnHLUYg8RjfVQeW
 YJM3KCQA1bbC6xsz8VbNq5Cg9NaTG0wSDcaSEXuyvwY8xpv9Q9U0hw+Kd/yfdXpckgX1
 E4TXCl7XAIpgZO+d0I902n5CZSCarxQfyeOY29luGQurjpEyDQc6eDMODhL7RZxIqucG
 Ksg5CM9WwfFykD6Otg4MlI8z6L/y736m9I0+qUnZDSJg8AtF8U6FXzmWIjuKYGW+k0aY
 0rTsehIifKOZ4qQZLeY1fIqAYT/hAOON00TAkWNR7WxrG2D4hT/R9NVoMRo9NeXcnBVj
 RN7g==
X-Gm-Message-State: AOJu0YwN8miZAkUyyUBJC01NJR21W0PPPk+5KtSKDWlCZCaRLL/eLzU1
 Qcv/GVbCNcFFgnadTpOhsIOsjcAfVInXNRp+sfgJZL68oFlU2k2nARZwDNrab8q8p0sqVlpVFcd
 yzJtbcAwb0YB6W7ubcV8KigomOOV0KzoYnqvZ
X-Google-Smtp-Source: AGHT+IF2CAi+7n+vSh0Aj1Lrd8ziEyDoOlDEDz31fLPl2bstmxArDy+P1945XX5HH9ingYcSP3YD2tbOwEVR+Zhh0rY=
X-Received: by 2002:a17:90a:ba92:b0:2cb:4b08:1bbe with SMTP id
 98e67ed59e1d1-2cff9541cc3mr15509641a91.30.1722981114113; Tue, 06 Aug 2024
 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:51:41 -0600
Message-ID: <CAFLszTgc1HdrPKrXSCru1YPzyG5uCFDaXgbDUX8EBqSSW+dRjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] aes: Allow to store randomly generated IV in the
 FIT
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 5 Aug 2024 at 07:35, Paul HENRYS <paul.henrys_ext@softathome.com> w=
rote:
>
> When the initialisation vector is randomly generated, its value shall be
> stored in the FIT together with the encrypted data. The changes allow to
> store the IV in the FIT also in the case where the key is not stored in
> the DTB but retrieved somewhere else at runtime.

What is the IV? Can you please write it out in full?

>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  lib/aes/aes-encrypt.c | 7 +++++++
>  tools/image-host.c    | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index e74e35eaa28..90e1407b4f0 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -84,6 +84,13 @@ int image_aes_add_cipher_data(struct image_cipher_info=
 *info, void *keydest,
>         char name[128];
>         int ret =3D 0;
>
> +       if (!keydest && !info->ivname) {
> +               /* At least, store the IV in the FIT image */
> +               ret =3D fdt_setprop(fit, node_noffset, "iv",
> +                                 info->iv, info->cipher->iv_len);
> +               goto done;
> +       }
> +
>         /* Either create or overwrite the named cipher node */
>         parent =3D fdt_subnode_offset(keydest, 0, FIT_CIPHER_NODENAME);
>         if (parent =3D=3D -FDT_ERR_NOTFOUND) {
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 49ce7436bb9..3424b8d9a1d 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -535,7 +535,7 @@ fit_image_process_cipher(const char *keydir, void *ke=
ydest, void *fit,
>          * size values
>          * And, if needed, write the iv in the FIT file
>          */
> -       if (keydest) {
> +       if (keydest || (!keydest && !info.ivname)) {
>                 ret =3D info.cipher->add_cipher_data(&info, keydest, fit,=
 node_noffset);
>                 if (ret) {
>                         fprintf(stderr,
> --
> 2.25.1
>
> -- This message and any attachments herein are confidential, intended sol=
ely for the addressees and are SoftAtHome=E2=80=99s ownership. Any unauthor=
ized use or dissemination is prohibited. If you are not the intended addres=
see of this message, please cancel it immediately and inform the sender.

Did you mean to include this?

Regards,
Simon
