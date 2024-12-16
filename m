Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4874E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 12:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCAA801CF;
	Mon, 16 Dec 2024 13:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EuKwoD1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB058005B; Mon, 16 Dec 2024 13:45:47 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65B38003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 13:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so3382705a91.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734353143; x=1734957943;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JW3/WexMzyYrrorzCRRu1dZvYusq58Tt877TlXACW8=;
 b=EuKwoD1eDBLICeRxOb6La8FKNbTpg/nW0TWaA3Ybsw/vp1hqKnq6wM0AeuM4fIWF5z
 j388nDrnZsfoDO8k1j3ER1nDJ0v0NoILwm8VReS2coTaK6L+3gj2qmFwHu6OZ2vRc4BI
 +JUANdBSckx7Y6HbGkH+Cj56ceXtpnkr4lNnFxwhUdaUr6UFKOJZS4xk/FbjQk++pkA1
 tt13qSB8IqB2W/BMfSpDm9lycqbvsIF6LI32ZoXfUK15Wz6LIQm1AbsQ/jzLVjAWmuxy
 lJtxcKHtDT7OguzN1OqZpnqY5C1/Vk8qxqMU8lonGx6M15uwvdpAnz5MyAfjYq/i2FCO
 Im+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734353143; x=1734957943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JW3/WexMzyYrrorzCRRu1dZvYusq58Tt877TlXACW8=;
 b=vZdFll6Hfjn1U+tyK6wA7r6R7tXIwdVd36H+yvPXOKEwz3DbgrI2kvoOT4Lns6pAfb
 aJCXszyQABSgAEMkJJnMBg3gj0c/JSTfKgxWksJp/dtkhW3P9Fq9w+QUBh4D4JQ0liyM
 iQzrZx2L9STVqz1SGE5WTluBsIdddv9ZChQ9+kSm8fhGjYKNU6wYKrfJYwzZyDkM6Era
 ZdTrgwtPj/ykFQpdpzhjUFALuM4EqfigMjrYra4ARGNsMaZpTKE51D/wF2efSi7vKstT
 QypdkjrY6Ar/EdURgRhYNXxmSqmovDfNw/O3L1BDwszpMSL/XhV4raJJmYTKjRl1F1iH
 Eu4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf2YC9F9tbR/2TNzL8D0QLCC6U3tpMndLiZZdGUNlXuKtman9UAmS030pH/thPvGHu1g/s/TM=@lists.denx.de
X-Gm-Message-State: AOJu0YwZttYjgdHq/Go0chXFFS0GzEzE53JUPGoDJOZQI8Ph13ZcXPew
 ABtyUr0zxW1pj22w3R56EJC/h65WYXuhiZ0Ud2QkFzR9ZKjnWaukehXGJgvHin3stRxMypBMS6P
 wv+kGDTGwEd8yOAukoQDMKswEMf2JkMF2+p3z+g==
X-Gm-Gg: ASbGncs65NCy7YiR9UGQd2E04zJNq7qyJZFidDm79VFNu9VWFRM017nygAKaIG30d6P
 TgJ2/M3O9BfjCyqqbyJx9HCxE2EiKvSvdLKpcDEkTjnO5VGAupVlqOu4gY99Qj5qUqhlqdA==
X-Google-Smtp-Source: AGHT+IFvf1ilcNBSn7ysqaHne9HN9c1YfgiULcJT2KqWiwF6d3icpx/CrZP/9GpNyKmHCxhBVQmnTqbV0oq8DlrpBLU=
X-Received: by 2002:a17:90b:4a01:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2f2900a2bbemr19441623a91.24.1734353143249; Mon, 16 Dec 2024
 04:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
 <20241211-fix-bootargs-concatenation-v1-3-c6752bcb9dde@baylibre.com>
 <87cyhsxboe.fsf@baylibre.com>
In-Reply-To: <87cyhsxboe.fsf@baylibre.com>
From: Nicolas Belin <nbelin@baylibre.com>
Date: Mon, 16 Dec 2024 13:45:32 +0100
Message-ID: <CAJZgTGF33UiPaHkUpQYXb_j9uduq6k4A6X5X8esvASOeNzkLDQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] boot: android: rework bootargs concatenation
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, Ahmad Draidi <ar2000jp@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Dec 2024 13:47:56 +0100
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

Le lun. 16 d=C3=A9c. 2024 =C3=A0 09:41, Mattijs Korpershoek
<mkorpershoek@baylibre.com> a =C3=A9crit :
>
> Hi Nicolas,
>
> Thank you for the patch.
>
> On mer., d=C3=A9c. 11, 2024 at 14:53, Nicolas Belin <nbelin@baylibre.com>=
 wrote:
>
> > Rework the bootargs concatenation allocating more accurately
> > the length that is needed.
> > Do not forget an extra byte for the null termination byte as,
> > in some cases, the allocation was 1 byte short.
> >
> > Fixes: 86f4695b ("image: Fix Android boot image support")
> > Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> > ---
> >  boot/image-android.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/boot/image-android.c b/boot/image-android.c
> > index 362a5c7435a3a8bcf7b674b96e31069a91a892b5..ed72a5c30424a453c1800bc=
61edbe8f33b31b341 100644
> > --- a/boot/image-android.c
> > +++ b/boot/image-android.c
> > @@ -289,7 +289,7 @@ int android_image_get_kernel(const void *hdr,
> >       int len =3D 0;
> >       if (*img_data.kcmdline) {
> >               printf("Kernel command line: %s\n", img_data.kcmdline);
> > -             len +=3D strlen(img_data.kcmdline);
> > +             len +=3D strlen(img_data.kcmdline) + 1; /* Extra space ch=
aracter needed */
> >       }
> >
> >       if (*img_data.kcmdline_extra) {
> > @@ -299,28 +299,28 @@ int android_image_get_kernel(const void *hdr,
> >
> >       char *bootargs =3D env_get("bootargs");
> >       if (bootargs)
> > -             len +=3D strlen(bootargs);
> > +             len +=3D strlen(bootargs) + 1; /* Extra space character n=
eeded */
>
> In some cases, we will allocate for an extra space character when this
> is not needed.
>
> For example, with:
> * bootargs =3D "b"
> * kcmdline =3D NULL
> * kcmdline_extra =3D NULL
>
> We will allocate strlen("b") + 1 + 1. But we only need to allocate
> strlen("b") + 1.
>
> Another example:
> * bootargs =3D "b"
> * kcmdline =3D "k"
> * kcmdline_extra =3D NULL
>
> Will allocate strlen("b") + 1 + strlen("k") + 1 + 1. But we only need:
> strlen("b") + 1 + strlen("k") + 1.
>
> How about we count the amount of elements that are not NULL to compute
> the amount of spaces:
> * 0 -> 0 space
> * 1 -> 0 space
> * 2 -> 1 space
> * 3 -> 2 spaces
>
> >
> > -     char *newbootargs =3D malloc(len + 2);
> > +     char *newbootargs =3D malloc(len + 1); /* +1 for the '\0' */
> >       if (!newbootargs) {
> >               puts("Error: malloc in android_image_get_kernel failed!\n=
");
> >               return -ENOMEM;
> >       }
> > -     *newbootargs =3D '\0';
> > +     *newbootargs =3D '\0'; /* set to NULL in case no components below=
 are present */
>
> The comment should state Null, not NULL. NULL is the pointer and Null is
> the \0 character.
>
> >
> >       if (bootargs) {
> >               strcpy(newbootargs, bootargs);
> >               strcat(newbootargs, " ");
>
> A similar thing can be stated here. Sometimes, we add spaces which are
> not needed.
>
> Can we rework this a little to only add what is needed?

Will do for v2

>
> >       }
> >
> > -     if (*img_data.kcmdline)
> > +     if (*img_data.kcmdline) {
> >               strcat(newbootargs, img_data.kcmdline);
> > -
> > -     if (*img_data.kcmdline_extra) {
> >               strcat(newbootargs, " ");
> > -             strcat(newbootargs, img_data.kcmdline_extra);
> >       }
> >
> > +     if (*img_data.kcmdline_extra)
> > +             strcat(newbootargs, img_data.kcmdline_extra);
> > +
> >       env_set("bootargs", newbootargs);
> >       free(newbootargs);
> >
> >
> > --
> > 2.34.1
