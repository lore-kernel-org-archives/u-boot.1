Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48055C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ECA87842;
	Sun, 31 Dec 2023 13:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nTwwCHlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24607875FC; Sun, 31 Dec 2023 13:49:15 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD0A8783A
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67f9f6caabcso62981776d6.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026947; x=1704631747; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on0lERBFR2pS4OFSjGESMif1Ph8jL2ZkaobHqg14jb8=;
 b=nTwwCHlmrxLhdbcTxqrEaid5rhJjt9sInMKTXs9APsjUtJOw3QmzdpVEK1uvLqOLYo
 l1O4+rb7oN9ueAGDeImHAUZiegWJfKUHKrsOBL55VI8m05/Npp7T1W4DeJ7nzkRi6hR7
 UbxEsYVPD43vdE7YBOPxd3mqbds3wqwriaXOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026947; x=1704631747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on0lERBFR2pS4OFSjGESMif1Ph8jL2ZkaobHqg14jb8=;
 b=gqPmT/vYxL8krLdFPBT1aUFYqUJYeoqp23oGjFkyBKF7M7fFrGixvIhMrMBnBzp0oe
 xa94TIr1r/Gu87ZKZJbSer+q0XurKzympBJimtK+aCDlDeJJaokrVt4oxWL0lGjT72Z7
 MlZY0a+bRaldIJgF7dnqgvpEYWtXEfOu61kVyqu0d1PpxrOqVhaKy9VckpP/4c9mjWR4
 0nF+zTV6EhWgG8os7NK54wB5/zN1FCki86lJctjjYmOUiVIB+EInvvx0Uox4+Lj0YdxK
 FYFPoZr03MvHrMSMyLCGRALdFbjCvWiN921OgtdxJPEEuFgftgcqh73UGAHFuglS3CSr
 UfMA==
X-Gm-Message-State: AOJu0Ywmanct1siW/HPchtlYVeCdnGTpSxDfHnvOD1M9TBOf8EnTCXCp
 HjXn7mdMD5urphWnh2gRoMUbHpo/FNojH70f4eo5NGBdGLNj
X-Google-Smtp-Source: AGHT+IGVxmkjMc27WGocq10lcM59NjPgf+yftMknUYZvfl/TPGQAe2i6V7JrQ8u3x/Vk1bHkoUMzWNF291gKryusuvk=
X-Received: by 2002:ad4:420d:0:b0:67f:a5d4:5b18 with SMTP id
 k13-20020ad4420d000000b0067fa5d45b18mr16499438qvp.64.1704026946815; Sun, 31
 Dec 2023 04:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20231229210738.82387-1-hugo.cornelis@essensium.com>
In-Reply-To: <20231229210738.82387-1-hugo.cornelis@essensium.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:48:56 -0700
Message-ID: <CAFLszTgUwDUWSRwJZ0Jk8Bw6UUXDt72vnaj4rB72bLFoo3Lozw@mail.gmail.com>
Subject: Re: [PATCH 1/2] image-host: add a check of the return value of
 snprintf.
To: Hugo Cornelis <hugo.cornelis@essensium.com>
Cc: u-boot@lists.denx.de, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Hugo,

On Fri, Dec 29, 2023 at 2:07=E2=80=AFPM Hugo Cornelis
<hugo.cornelis@essensium.com> wrote:
>
> This patch allows to generate a sensible error message when generating
> binary images using very long filenames.
>
> This can happen with Buildroot and Yocto builds.
>
> Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
> ---
>
>  tools/image-host.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>

Good to see this, but I would like a refactoring, please see below.

> diff --git a/tools/image-host.c b/tools/image-host.c
> index ca4950312f..3719f36117 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -378,6 +378,7 @@ static int fit_image_setup_cipher(struct image_cipher=
_info *info,
>         char *algo_name;
>         char filename[128];
>         int ret =3D -1;
> +       int snprintf_return;

sret ? We try to use 'ret' for return values. But really I would
prefer if you could split this function in two, since it is too long.
Then you probably can use 'ret' in both functions.

>
>         if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
>                 fprintf(stderr, "Can't get algo name for cipher in image =
'%s'\n",
> @@ -414,8 +415,18 @@ static int fit_image_setup_cipher(struct image_ciphe=
r_info *info,
>         }
>
>         /* Read the key in the file */
> -       snprintf(filename, sizeof(filename), "%s/%s%s",
> -                info->keydir, info->keyname, ".bin");
> +       snprintf_return =3D snprintf(filename, sizeof(filename), "%s/%s%s=
",
> +                                  info->keydir, info->keyname, ".bin");
> +       if (snprintf_return >=3D sizeof(filename)) {
> +               printf("Can't format the key filename when setting up the=
 cipher: insufficient buffer space\n");
> +               ret =3D -1;
> +               goto out;
> +       }
> +       if (snprintf_return < 0) {
> +               printf("Can't format the key filename when setting up the=
 cipher: snprintf error\n");
> +               ret =3D -1;
> +               goto out;
> +       }
>         info->key =3D malloc(info->cipher->key_len);
>         if (!info->key) {
>                 fprintf(stderr, "Can't allocate memory for key\n");
> @@ -436,8 +447,18 @@ static int fit_image_setup_cipher(struct image_ciphe=
r_info *info,
>
>         if (info->ivname) {
>                 /* Read the IV in the file */
> -               snprintf(filename, sizeof(filename), "%s/%s%s",
> -                        info->keydir, info->ivname, ".bin");
> +               snprintf_return =3D snprintf(filename, sizeof(filename), =
"%s/%s%s",
> +                                          info->keydir, info->ivname, ".=
bin");
> +               if (snprintf_return >=3D sizeof(filename)) {
> +                       printf("Can't format the IV filename when setting=
 up the cipher: insufficient buffer space\n");
> +                       ret =3D -1;
> +                       goto out;
> +               }
> +               if (snprintf_return < 0) {
> +                       printf("Can't format the IV filename when setting=
 up the cipher: snprintf error\n");
> +                       ret =3D -1;
> +                       goto out;
> +               }
>                 ret =3D fit_image_read_data(filename, (unsigned char *)in=
fo->iv,
>                                           info->cipher->iv_len);
>         } else {
> --
> 2.34.1
>

Regards,
Simon
