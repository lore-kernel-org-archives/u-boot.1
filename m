Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C201C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874AC8784C;
	Mon,  4 Dec 2023 09:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/Q2WSYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D20876A3; Mon,  4 Dec 2023 09:07:13 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFB387716
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so3375078f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701677230; x=1702282030; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhBSbzVUOCFZ5r3U5+QJgg7hWkG9vh0zASLGsEtXd98=;
 b=S/Q2WSYZM6agvBWdqca9LiKMtgOn6PjSj6LnR1lqlFmraU0Mfk3/GYbVCx3j+QUJZE
 kPBMkTnSOrgRLtjCnynvnpE+/0yq86CyJ0K92FOGtY/6NLhh5kqk206EG93xEL2tUApm
 qbdQpl3J/rKBlV0WOCFT6keBYZp4Hd0Fvzh4j9L9DKzhq1XRAZNljBNg4S9c+WeiJrxA
 Gzq5Osm9ZkhmePg8Y8RWfpQTXfGyC/0yTempiq38yijwXcqJwupTY4XI0ukx5fejhHCH
 s+T06zaz8/u10aNIyEJtmp7sP9f2WM9VuhJUXJ9DV9YbUqgXGcJt8/7S051SjFtoxhBD
 0y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701677230; x=1702282030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhBSbzVUOCFZ5r3U5+QJgg7hWkG9vh0zASLGsEtXd98=;
 b=P891UsFOyUnds1MEbv54eeGt6G/qhQa9QPOpZv/9ARf+4VVbyA5Qt2ejSDx00X5Zre
 qKwQBaWzEO9LT6gUppgAE85c83BHD9JmCjaaFFC/TgiLMawHhPqRJCKciRjWsSTAZdH0
 RiEFxJYgN0xSxMuD0n5MMscO0r2oqrwLlUQVKPHU6LwNeRH5heeMKB1y8WDy5tsFpPDp
 s3uyPV1nFhB+48lLluAGux86dm2Y4TPIXyuRQRNJZdTTCWQtCodxD6i1wixjtwb67VZ9
 q/8spr3KFM/TiHCCaIb0SccK98zj3e4xI+UOUylwx4ug8W1P/YY7AxDrPBb4Zgkh2HKN
 AlXA==
X-Gm-Message-State: AOJu0YyH8hDx8jciTfKJwz9a0yyuE9xaonHzHkPRgIxslcQZc7pJ58Ui
 W//GM0A/A6r7q6OaWNpeMK8oWAf1XippOaXpp+c=
X-Google-Smtp-Source: AGHT+IF3eMW/f+Jy9VGKFsiPFf9rbfF5mHLbGZyLvq0WWTzwdPYtfiYFN8PIvD0Hq+5EI5DaGqh6iI2L7ZGP3LGXaAw=
X-Received: by 2002:a5d:460b:0:b0:333:2fd2:6f7e with SMTP id
 t11-20020a5d460b000000b003332fd26f7emr3161409wrq.136.1701677230329; Mon, 04
 Dec 2023 00:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20231123110222.15116-1-clamor95@gmail.com>
 <20231123110222.15116-5-clamor95@gmail.com>
In-Reply-To: <20231123110222.15116-5-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 4 Dec 2023 10:06:59 +0200
Message-ID: <CAPVz0n29nSiJb6oV_dVDtPLuKgm0-g=ZT3jiiQWuZQp-pub-Mg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] lib: membuff: fix readline not returning line in
 case of overflow
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

Hello Simon!

This is the latest iteration of commit, one you have checked is
already outdated.
Sorry for misunderstanding.

Best regards,
Svyatoslav R.

=D1=87=D1=82, 23 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 13:0=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ion Agorria <ion@agorria.com>
>
> If a line overflows readline's maxlen it won't advance the membuffer
> and will return 0 as read amount which isn't even documented.
> Fix by removing this behavior alltogether.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  lib/membuff.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/lib/membuff.c b/lib/membuff.c
> index 36dc43a523..f582193dcd 100644
> --- a/lib/membuff.c
> +++ b/lib/membuff.c
> @@ -292,15 +292,12 @@ int membuff_readline(struct membuff *mb, char *str,=
 int maxlen, int minch)
>  {
>         int len;  /* number of bytes read (!=3D string length) */
>         char *s, *end;
> -       bool ok =3D false;
> -       char *orig =3D str;
>
>         end =3D mb->head >=3D mb->tail ? mb->head : mb->end;
>         for (len =3D 0, s =3D mb->tail; s < end && len < maxlen - 1; str+=
+) {
>                 *str =3D *s++;
>                 len++;
>                 if (*str =3D=3D '\n' || *str < minch) {
> -                       ok =3D true;
>                         break;
>                 }
>                 if (s =3D=3D end && mb->tail > mb->head) {
> @@ -309,13 +306,6 @@ int membuff_readline(struct membuff *mb, char *str, =
int maxlen, int minch)
>                 }
>         }
>
> -       /* couldn't get the whole string */
> -       if (!ok) {
> -               if (maxlen)
> -                       *orig =3D '\0';
> -               return 0;
> -       }
> -
>         /* terminate the string, update the membuff and return success */
>         *str =3D '\0';
>         mb->tail =3D s =3D=3D mb->end ? mb->start : s;
> --
> 2.40.1
>
