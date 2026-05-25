Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C3CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36FE848BD;
	Mon, 25 May 2026 17:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PauYMoFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524B2848FC; Mon, 25 May 2026 17:36:51 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1BF847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-56f6afbd205so5876691e0c.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723408; cv=none;
 d=google.com; s=arc-20240605;
 b=DcJl3f4C5THAcIoOSXP7l3oaCcuxVsdeXb2my4lngufKsM0LRnrK/SV0ISvQFNc5pN
 rHphPpd/Qpnq4gJQy75KBkvpJtp1OTD8C2gl44R5xHq1gqDt04aYql1XVnISWwLMlg+c
 uEy+zG6SebfHnRV5byifboBEOUeQaKKjwE/nz5jPiYv1vXF/ZvPdCmf5QLFEdQFbGDJX
 0BIZ4MVbiFEWBPna8E51hSGVssWIus5ndB79Ang3Aw8RhzqsUSFS6tncSRGMzjg4UETm
 KSCNLe+5howUcKiOJoyAjUsW3w6b08eVNbeFoshHVvTWBQnufWfFH+JLfOdTd0TryCvd
 rr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5eCJHO5Y/e/GB7AmyEb6uVrV8JJqenbsN4+mJDMjsaU=;
 fh=0Dt8/IqQKYD2nvuGsB9rRw0IzMtZWseYQjEFPzUGRa4=;
 b=P+9GZLiCnxzXp5VkCwdFVQ1MnSJLd1OZqqkoZzSnJle2SMVovxOYTtbjbzYQxc83F1
 +KSTkTr5D5bfLlH0DlrcMPWBGuGgP3D4mdCcyStmUPYxuBZtI7+ClURJpJ7qoqIdu07W
 7/ddDqZ33CW4YvOQ32IJQ/gZqeIoJp5/0KfXHnq4ZWbiGp6fFE7QO3X8uGBQdE0IfsOC
 rm3mKnDH8+7pJFEr55u2FQn9/EDXr2WMow8krmLeXdUDYFOSs0sn891/lSyt8Oudn9HU
 XWugQYFtRM7+ko93yz4q/L1uWKJ5frcclHvvbPmKV2PMHeuO638vYi5AW/2vLf12hkqo
 9WeQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723408; x=1780328208; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eCJHO5Y/e/GB7AmyEb6uVrV8JJqenbsN4+mJDMjsaU=;
 b=PauYMoFRyZxLOdz+QmJqOWo6STCYEQ5mASBtHVOUaV215OWWu7ujn+XkVKmKNYo32c
 Bs+f8gE8P1DBTOCtg0GgVis68XB8RK/1TcXsMFQvbzmkvVbFs/oYaWNUjkte7zI2uNjN
 WXh590SOmmVsflZxprAxfpCqMcYi5R+3ohtCel9Jbar3SIfMR+MmygocK48UYWc8rN8r
 ZMoZm81qpRPdXgp8hGViGa+NhVo66sN+D0+HWnQU2CzyQu/KFobRMIwK33hUBaZtm9iR
 ifjDRYrSeLSzsurMqHt5ARS6AABgpFtqRKB+InNN5IGCDsTKAr4SiALgirWm1d9O+2gB
 KWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723408; x=1780328208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5eCJHO5Y/e/GB7AmyEb6uVrV8JJqenbsN4+mJDMjsaU=;
 b=EpLIhrM3QqPYNK2zMKzJrBONzq8VGME6mZRA2YCPIJoXHdmtelcO/bW8lEGn0AUwwC
 Pn4f9/jk1ADN/JMNf1QJ42lApehlxw4ffexX0BA7/NEurtokA6/2d5pAC3igFFMpBbvZ
 kZ9Vkjisa90R6zJJ+x513QGBq0Y6+tX4QgHeQ6nJ9Q5Hu8+Bk5U/eaJzns+d2CP1soNF
 Xi3/0wyOOEN8FTsGDlcUIsOYFuozSJOt0wUdSNAvbXxSoypyRz7W4nujmLfjo9S870NI
 WykTgzuV7OWIE+Ll6e0/igFBEiUQwZxA7gGMZwxli0gI3avukqt8P+baxsKg31w6UAIp
 +gmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jJKocsD2ckC3NiGyu6HthMHTF0fNpLBKj4DUCRv79qlVAtnqKsIUKd9iX0uk8Dt8aevj/548=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2clzG9w+JnPiim3PSSjulvyI0PQVgWCmrPKlaEAP1vn1q+Bqw
 7tUgpos27x7TY+SfxPbIlGUXQYPW9P27cvLD8FZ4Px5EgTrAcefqZVxWO94TGQN5UCkxWAVxyh9
 HgozDOB5jkZMF7z+Hzbjk2OF74HlJC9U=
X-Gm-Gg: Acq92OG0xenW/OrgzLpC3u+Dke1wNW+RGecToEErJ/MbN/jaisPTRskkEuGcCf05f+K
 uubgxGRa4YqvYpdXoqzBQ69CALDGaGXhzh62yEAMLY/fX2QT1kN3uMYPTo3SNclzRGA0TJfjgz+
 3mq9q5fqc0MlO0pNztG6HBZc6369l9dtq5TQhVwrsw7afH6h9PWS7carqvnHXq/YqwG7V7nu1CQ
 0T0j936vd9gRFz6BAE34ld3aY21WAipJfchGOKfeygxLOtbS8WMhQN1ZdpbevlZDCQMt1BRBmEk
 UC58j2WL
X-Received: by 2002:a05:6122:490a:b0:575:fa0b:bc23 with SMTP id
 71dfb90a1353d-586890d0d70mr2575418e0c.2.1779723407723; Mon, 25 May 2026
 08:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-13-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-13-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:36:36 -0400
X-Gm-Features: AVHnY4IptMHDcM48k_H-NV7L_DFMZGiByhNKhIkMfw4IAwpMBKwIGRhIh26D82k
Message-ID: <CAMDkj5xumTB-Kt74qPVTRM4Wq0+OooX1CM5UG_knxzTM0NtfMA@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] boot: pre-load: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Right now, u-boot can only boot image with a
> pre-load header with rsa. We add the support
> of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - avoid calling image_get_crypto_algo several times
> v5:
> - simplify the function is_ecdsa
> - re-use already computed crypto in function image_pre_load_sig_setup
> v6:
> - no change
>
>  boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 12 deletions(-)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
> index 2f851ebb28c..af72ea6d547 100644
> --- a/boot/image-pre-load.c
> +++ b/boot/image-pre-load.c
> @@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_i=
nfo *info)
>         return 0;
>  }
>  #else
> +
> +static int is_ecdsa(struct crypto_algo *crypto)
> +{
> +       return crypto && !strncmp(crypto->name, "ecdsa", 5);
> +}
> +
>  /*
>   * This function gathers information about the signature check
>   * that could be done before launching the image.
> @@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_in=
fo *info)
>         int key_len;
>         int node, ret =3D 0;
>         char *sig_info_path =3D NULL;
> +       struct crypto_algo *crypto;
>
>         if (!info) {
>                 log_err("ERROR: info is NULL for image pre-load sig check=
\n");
> @@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_si=
g_info *info)
>                 goto out;
>         }
>
> -       padding_name =3D fdt_getprop(gd_fdt_blob(), node,
> -                                  IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL=
);
> -       if (!padding_name) {
> -               log_info("INFO: no padding_name provided, so using pkcs-1=
.5\n");
> -               padding_name =3D "pkcs-1.5";
> +       crypto =3D image_get_crypto_algo(algo_name);
> +       if (!crypto) {
> +               printf("ERROR: can't find a valid crypto algo from %s\n",
> +                      (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (is_ecdsa(crypto)) {
> +               padding_name =3D NULL;
> +       } else {
> +               padding_name =3D fdt_getprop(gd_fdt_blob(), node,
> +                                          IMAGE_PRE_LOAD_PROP_PADDING_NA=
ME,
> +                                          NULL);
> +               if (!padding_name) {
> +                       log_info("INFO: no padding_name provided, so usin=
g pkcs-1.5\n");
> +                       padding_name =3D "pkcs-1.5";
> +               }
>         }
>
>         sig_size =3D fdt_getprop(gd_fdt_blob(), node,
> @@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_si=
g_info *info)
>                 goto out;
>         }
>
> -       key =3D fdt_getprop(gd_fdt_blob(), node,
> -                         IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
> -       if (!key) {
> -               log_err("ERROR: no key for image pre-load sig check\n");
> -               ret =3D -EINVAL;
> -               goto out;
> +       if (is_ecdsa(crypto)) {
> +               key =3D NULL;
> +               key_len =3D 0;
> +       } else {
> +               key =3D fdt_getprop(gd_fdt_blob(), node,
> +                                 IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_le=
n);
> +               if (!key) {
> +                       log_err("ERROR: no key for image pre-load sig che=
ck\n");
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
>         }
>
>         info->algo_name         =3D (char *)algo_name;
> @@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig=
_info *info)
>         info->sig_info.name     =3D info->algo_name;
>         info->sig_info.padding  =3D image_get_padding_algo(info->padding_=
name);
>         info->sig_info.checksum =3D image_get_checksum_algo(info->sig_inf=
o.name);
> -       info->sig_info.crypto   =3D image_get_crypto_algo(info->sig_info.=
name);
> +       info->sig_info.crypto   =3D crypto;
>         info->sig_info.key      =3D info->key;
>         info->sig_info.keylen   =3D info->key_len;
> +       if (is_ecdsa(crypto)) {
> +               info->sig_info.required_keynode =3D node;
> +               info->sig_info.fdt_blob =3D gd_fdt_blob();
> +       }
>
>   out:
>         return ret;
> --
> 2.43.0
>
