Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1498CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6175188D28;
	Fri, 20 Sep 2024 18:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h3EtXyFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AA888D28; Fri, 20 Sep 2024 18:01:55 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C7F88C41
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7197970e2aeso1631954b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848112; x=1727452912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SOWFlKy/AzWsqeuHSxbVrscX6/qJdktMDa0AHgHh3PU=;
 b=h3EtXyFesgp5Y841Me6+z/UiPcNyUn86qCxEEwMZhipyiXE0EeiYjy4r+3a+O5qvXm
 fdpkptrv0zlShJLfKImaQ+fg6hYGvNnOnkMwkFgOEzhCiIcz9G+DQArc+ksdOrmXOeeO
 9j8l+vuCTjNroSDvY0cYPj90DLzokGk2FMjAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848112; x=1727452912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOWFlKy/AzWsqeuHSxbVrscX6/qJdktMDa0AHgHh3PU=;
 b=fEdlXMjYSi1NUFiCjj8RzdCmIPZMrBOttuW/36Xnwlas5svSMtTACC+o5P4x7IC3Qz
 VjYN9kh1XBJlO2Y6nTZp1/ANOMy2iqOq+/zf+jg1E99D1ZenZHKHoFz38k66pOAK4V7j
 X5R6Jge8F+LaN7McYIZltahZt0WV2Hj/Lb4C5sIRSE5vR7kslHEkUrjJZ3206a8Dy7Mf
 9sDJRsAdTvmkJzUoUFpDrLHckO3W0z9tmOEzNQs2RQdoGNnOSGkjg+Khw/I0zDD4Jzgt
 hK/6yd3L+Oa/HWnJ7BTVtl5VNbE2Kjr6TPOV0iJcRg2C0mdLSEFGkTogh8UaKLIxQaH3
 sKxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvM2k9Vn4w1Im0f6v3Qsr1jf1rn7PcrD4SK6qCZdTHpTyskUEMGLq+D5ri3gBT7sPCxgQL+vU=@lists.denx.de
X-Gm-Message-State: AOJu0YzycbywWyOKlcitDvYBYlkkWXx5/399I1sDXhbnMc+C7Kape+XJ
 6UcxZatHXnj4LhObqndjZ1FTzoGReh3VuoidE+k53Av3D+aO4tphDb3bR4hUHOuiNdwsCKj1mfx
 dCSnYM3PL8oJzVy5bWnNhMVdzZVrkBwoS4GEDbacLftnaUf7ESTFu
X-Google-Smtp-Source: AGHT+IECxpYlA+wuG7UelwRo9nuUVeGJ8lrBLaLYZqY+yH6VW9EGGaYOMM/9vYQr3Bg95tiXob4721bv1s/ABJSwjpw=
X-Received: by 2002:a05:6a00:1823:b0:718:d5f4:6e95 with SMTP id
 d2e1a72fcca58-7199c97ce0dmr4456913b3a.3.1726848111968; Fri, 20 Sep 2024
 09:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-3-chiawei_wang@aspeedtech.com>
In-Reply-To: <20240902053326.3273410-3-chiawei_wang@aspeedtech.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:40 +0200
Message-ID: <CAFLszThedscRNb8+X2pw0aLAjUQC8iof238GFQTOVVxOqXdhAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] lib: ecdsa: Create device tree node automatically
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: trini@konsulko.com, bob.wolff68@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Sept 2024 at 07:33, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Both the signature and the public key are stored as DTS nodes
> in the FIT image and SPL/U-Boot DTBs.
>
> Like the RSA signing & verification do, this patch either creates
> the nodes or overwirte the content automatically.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  lib/ecdsa/ecdsa-libcrypto.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 5fa9be10b4b..cd0c09ca6e4 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -281,15 +281,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
>         BIGNUM *x, *y;
>
>         signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
> -       if (signature_node < 0) {
> -               fprintf(stderr, "Could not find 'signature node: %s\n",
> -                       fdt_strerror(signature_node));
> -               return signature_node;
> +       if (signature_node == -FDT_ERR_NOTFOUND) {
> +               signature_node = fdt_add_subnode(fdt, 0, FIT_SIG_NODENAME);
> +               if (signature_node < 0) {
> +                       fprintf(stderr, "Could not find 'signature node: %s\n",

s/find/add/ ?


> +                               fdt_strerror(signature_node));
> +                       return signature_node;
> +               }
>         }
>
> -       key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
> -       if (key_node < 0) {
> -               fprintf(stderr, "Could not create '%s' node: %s\n",
> +       /* Either create or overwrite the named key node */
> +       key_node = fdt_subnode_offset(fdt, signature_node, key_node_name);
> +       if (key_node == -FDT_ERR_NOTFOUND) {
> +               key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
> +               if (key_node < 0) {
> +                       fprintf(stderr, "Could not create '%s' node: %s\n",
> +                               key_node_name, fdt_strerror(key_node));
> +                       return key_node;
> +               }
> +       } else if (key_node < 0) {
> +               fprintf(stderr, "cannot select '%s' node: %s\n",
>                         key_node_name, fdt_strerror(key_node));
>                 return key_node;
>         }
> --
> 2.25.1
>
