Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDA9C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D53F885A0;
	Tue, 27 Aug 2024 20:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VA7IGdiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B87886E5; Tue, 27 Aug 2024 20:41:14 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755AE88581
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso2280982a12.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724784072; x=1725388872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YmwXs4Fcmsff49hiINu6TZLUrQCrAA8NvtCat7khufc=;
 b=VA7IGdiNWr2bjTX7QrPTaSTg7b1/suQtqUsgu5vGDgmZI1nmEX+kk73VwHr3fhku57
 g1DK0yuAKfu+0rG9X3r40jY7famgnwvFSUF4uE620NPVaDX5mwN/tpvhpGWV9Gx/uDrh
 MJZdpKuDV025rjtQtwhwTvUCsV7WFIg7om5LDMF+H/T2jIEhPIaBmE0+hoQ6wSYPwbqS
 Ao17GLH3zb7eCgJutQYf8jn63fwGdQlJx18O0e9AtVFwSXUWgjhuJnBGXvw83nX6TOFr
 P2Ysn3Hmf0Esz9VouwqP7YIKnliKvvc/7mAR3A5bAK/dDctl3QgI7nBRpmyjmNo8FXLG
 3s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784072; x=1725388872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmwXs4Fcmsff49hiINu6TZLUrQCrAA8NvtCat7khufc=;
 b=gYaP4idiNy3kbERwKMI8hN1cbJfsMgi8QyQcmFf9SClKwMq0NGQEFR/cHY/yfjAQzn
 AkHUzzZqvD1xHKmNge9ZeULsbuy1ojCDwdCqUDjciUCoG0uy1zHm1DX+r9RVvuqEUZsS
 yrRLo81FaGn2+ZpvduBcrYBKLvn492Pwu2fcDYKxrVLZT6oJS5FgU0jd2o8JNRmA3BDs
 A5Ktgy/bpo+KEL3+OiC2RXXL6bwiHB2Wxm/chz3kkz5x/EsLBZEodZTW72Wbxq8/NGXg
 yY+sEspEkZo09RVrcHWJhu9FmlvAinJHsDtgwzSj8Tw04u4DwwnHuntVUZ3bdbgRoAAg
 j4wQ==
X-Gm-Message-State: AOJu0Yw6V5qvgTotoLW5k/Sd0bQU/8WPzGgso1xqDyV7KcybB5FBVrDz
 lb0eyIQ3ZEhYUrvOva2ef2AFcWCrdXE/X+WLYgcnJo+U4gSstVR8OowQMm02R2cp3ezFbNYH2Y3
 tlIIBR/6JTQeIk7RqRCi1Icf+syGI/UY7
X-Google-Smtp-Source: AGHT+IHHCJl1PYCydxvGkkfmASA7+vhqv0r/jsx9PNlGrhKpq9G/DfrJbOVkGSFECUo6vzvdTp7AhVSjKAROEhU1bl0=
X-Received: by 2002:a05:6402:2811:b0:5bf:256a:a19e with SMTP id
 4fb4d7f45d1cf-5c211812ecbmr153730a12.4.1724784071202; Tue, 27 Aug 2024
 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240827160054.26819-1-matthias@pritschet.eu>
In-Reply-To: <20240827160054.26819-1-matthias@pritschet.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 27 Aug 2024 19:40:59 +0100
Message-ID: <CALeDE9MLsyxNstkTy6SarjvtxO9_qu3=DA3NEfheSU=gehpahA@mail.gmail.com>
Subject: Re: [PATCH] mkimage: ecdsa: add signature/key nodes to dtb if missing
To: Matthias Pritschet <matthias@pritschet.eu>
Cc: u-boot@lists.denx.de, 
 Matthias Pritschet <matthias.pritschet@itk-engineering.de>
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

On Tue, 27 Aug 2024 at 18:52, Matthias Pritschet <matthias@pritschet.eu> wrote:
>
> From: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
>
> If the signature/key node(s) are not yet present in the U-Boot device
> tree, ecdsa_add_verify_data simply fails if it can't find the nodes.
> This behaviour differs from rsa_add_verify_data, wich does add the missing
> nodes and proceeds in that case.
>
> This change is mainly copy&paste from rsa_add_verify_data to add the
> same behaviour to ecdsa_add_verify_data.

Could the duplicated code be moved out into a function shared between
the two *_add_verify_data bits of code?

> Signed-off-by: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
> ---
>  lib/ecdsa/ecdsa-libcrypto.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 5fa9be10b4..db0a828a29 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -281,16 +281,35 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
>         BIGNUM *x, *y;
>
>         signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
> -       if (signature_node < 0) {
> -               fprintf(stderr, "Could not find 'signature node: %s\n",
> +       if (signature_node == -FDT_ERR_NOTFOUND) {
> +               signature_node = fdt_add_subnode(fdt, 0, FIT_SIG_NODENAME);
> +               if (signature_node < 0) {
> +                       if (signature_node != -FDT_ERR_NOSPACE) {
> +                               fprintf(stderr, "Couldn't create signature node: %s\n",
> +                                       fdt_strerror(signature_node));
> +                       }
> +                       return signature_node;
> +               }
> +       } else if (signature_node < 0) {
> +               fprintf(stderr, "Cannot select keys signature_node: %s\n",
>                         fdt_strerror(signature_node));
>                 return signature_node;
>         }
>
> -       key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
> -       if (key_node < 0) {
> -               fprintf(stderr, "Could not create '%s' node: %s\n",
> -                       key_node_name, fdt_strerror(key_node));
> +       /* Either create or overwrite the named key node */
> +       key_node = fdt_subnode_offset(fdt, signature_node, key_node_name);
> +       if (key_node == -FDT_ERR_NOTFOUND) {
> +               key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
> +               if (key_node < 0) {
> +                       if (key_node != -FDT_ERR_NOSPACE) {
> +                               fprintf(stderr, "Could not create key subnode: %s\n",
> +                                       fdt_strerror(key_node));
> +                       }
> +                       return key_node;
> +               }
> +       } else if (key_node < 0) {
> +               fprintf(stderr, "Cannot select keys key_node: %s\n",
> +                       fdt_strerror(key_node));
>                 return key_node;
>         }
>
> @@ -326,8 +345,11 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
>
>         fdt_key_name = info->keyname ? info->keyname : "default-key";
>         ret = prepare_ctx(&ctx, info);
> -       if (ret >= 0)
> +       if (ret >= 0){
>                 ret = do_add(&ctx, fdt, fdt_key_name);
> +               if (ret < 0)
> +                       ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
> +       }
>
>         free_ctx(&ctx);
>         return ret;
> --
> 2.34.1
>
