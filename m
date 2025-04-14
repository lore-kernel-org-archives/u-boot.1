Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF48C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 21:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E123826AD;
	Mon, 14 Apr 2025 23:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mtlrr6XK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 308F1820E8; Mon, 14 Apr 2025 14:54:44 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB642800B3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e6cea43bb31so3140158276.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744635281; x=1745240081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AP3zN8N9i7m5oxpEkIVa7Uj2K9dQT4SyAz1ObLMberE=;
 b=Mtlrr6XKU+aKXUAVv7kp5OAxHh+OwPokvg/tycjWQPgKIwnYZuuM1IygiJqZhMzUbz
 jDl2vdH/1BBx/oMBquqY7x6OUcUkL/l3qoDWbUytsxvU3XdkN+yg486gvp+JmLv+vY1+
 Y7RA/8691EGm9uIAk8FYfnltuERLCj0/ID3U7c/RtaakevvgbDvCDHIgFG7WrIy4n5UV
 U5lAxfnM5urt2LqzR9mEvIzlHA9+4EDwS6KEbtLoJoSdbtz/TAjQokC5d5SzmyLcHI3P
 sN+0EnsLyOp0OIJFwDFTpr3x9PjskaN9wg/oxYm/YyJ/+GEj5yKRS5JRuQP2cwiXus0E
 sxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744635281; x=1745240081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AP3zN8N9i7m5oxpEkIVa7Uj2K9dQT4SyAz1ObLMberE=;
 b=qVpkQFYwZLneGtZeKFKpfuMSzE8lat1pU+qACDqF7oY1qAVPZyP+9rd2PP1h1Il1u7
 VUNU2BlmlceiUkUnDHYQ9kZC/L3XqaTaKOLXRsHq1eNxEe1uk2EP3a4nDNHEULbvNHu0
 oVbE1bQAfDxgREzQElebQAGWNZNPdOIWtikGWh7jYF10NsA6D1riaoGP9w6WqFpTme1Z
 Aq+1v+/3I+ZZM+ZSQSfjffhe2uBFGqpPoNeP9Yg2rf22klYa8x3kYRxzGd/hz21gel9N
 f1fLvwuteCRaIBR3k/JhyDC/5y+oPUUJd18ZS74QmljioGx2+smafmCFRU1pU7gqr9ce
 e2Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB0Ea6W8xkPz0ILamCKLBi1GcMwsdzyIHmAxDJ/7AL3mIFPlqAhHfxgsUb1Xxx6ge/ZqfcpB8=@lists.denx.de
X-Gm-Message-State: AOJu0YxcCSTkIrnQNK6xMeqoqC7b5vDEOp1UI2Vj4kYsXmrj/+9kEXMR
 oGuyIvybNjY5M+ij6t4MTfrTqgRN6HlJ1tPJJdOXTqeynpgnDifa6jGBxtuJt12mfn3hUgnC6r8
 rgHQfAtpnhKDQCk7QG3Kkov2NeKwgn1Nz
X-Gm-Gg: ASbGncsXb2neLW99rtNroCw178JZj5mWD6fNJ8Z5OaGKXq8SEdfEzSVq0J/IqUPriuE
 if3pAKXJ8P3qpq3ynB5lIMQv01BT1I8Q8jN2YyVl9w3T1ZhD5zX7T2w3STp7HeHXiggM+mK+vsE
 CoWPFMhaDPK0x1a4HQLk+0vxvFQP2K2mFwlUJ9nnQxmUhXheM+z/h9wk5n0/CWHkdGDA==
X-Google-Smtp-Source: AGHT+IEdp3dhTsNy17kwecnqxhcWPunmSpDu1N4yoB4qoOMvfgta/rtg2a+1cQ5ZQhAB/PW+R6h+7a+ORgysSqeTsmE=
X-Received: by 2002:a05:6902:2589:b0:e6b:8256:5d6d with SMTP id
 3f1490d57ef6-e704de63eb0mr20781300276.10.1744635280558; Mon, 14 Apr 2025
 05:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250411071900.36136-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250411071900.36136-1-heinrich.schuchardt@canonical.com>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Mon, 14 Apr 2025 14:54:29 +0200
X-Gm-Features: ATxdqUEesqdIAs6vhheQkXJ541dnd7P50ypzWv7jcbZlHqmwz5Senv4lHu3j8-w
Message-ID: <CABfBAmCxrZL2UgmbwFe=ZDg4DAK732eyPodU8tJ3P2TA8f32tg@mail.gmail.com>
Subject: Re: [PATCH] fs/sqaushfs: avoid illegal free() in sqfs_opendir()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 14 Apr 2025 23:16:34 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello, Heinrich

Em sex., 11 de abr. de 2025 =C3=A0s 09:19, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> escreveu:

> * Use calloc() to allocate token_list. This avoids an illegal free if
>   sqfs_tokenize() fails.
> * Do not iterate over token_list if it has not been allocated.
>
> Addresses-Coverity-ID: 510453:  Null pointer dereferences  (FORWARD_NULL)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/squashfs/sqfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 7c364686f14..2dcdd60f683 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -949,7 +949,7 @@ static int sqfs_opendir_nest(const char *filename,
> struct fs_dir_stream **dirsp)
>                 goto out;
>         }
>
> -       token_list =3D malloc(token_count * sizeof(char *));
> +       token_list =3D calloc(token_count, sizeof(char *));
>         if (!token_list) {
>                 ret =3D -EINVAL;
>                 goto out;
> @@ -987,9 +987,11 @@ static int sqfs_opendir_nest(const char *filename,
> struct fs_dir_stream **dirsp)
>         *dirsp =3D (struct fs_dir_stream *)dirs;
>
>  out:
> -       for (j =3D 0; j < token_count; j++)
> -               free(token_list[j]);
> -       free(token_list);
> +       if (token_list) {
> +               for (j =3D 0; j < token_count; j++)
> +                       free(token_list[j]);
> +               free(token_list);
> +       }
>         free(pos_list);
>         free(path);
>         if (ret) {
> --
> 2.48.1
>
>
Thanks for your patch. Just a nit, though: there's a typo in the patch
title ('sqaushfs').

Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>
--=20
Best regards,
Jo=C3=A3o Marcos Costa
