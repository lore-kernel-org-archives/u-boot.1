Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB03C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E6787FA4;
	Mon,  4 Mar 2024 15:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PiSoAU6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B54587FB8; Mon,  4 Mar 2024 15:47:46 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAA987F92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5132010e5d1so4704489e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563663; x=1710168463; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhSL9L6i0aOAZo8N8suydoKY/g4js+qYkf15ZwPPRKs=;
 b=PiSoAU6fBkomlehLAN0DE2uX5sn3Bb46yWwOeYZtNgSNR8FuKDj6OCTW+rrtHePeOc
 mTSBzgZ/ka4BvSMvA0g21Ff2dIvVz3zfb56e1sg3hPwNIWW8Rll4jGrzY/v112RRmdk6
 MvKUf/RggONS8HoS3H/F5+31yx+zd9PP1k/A9Z4473CO3S2TfTyEHRAGmM9cmRhA5pDn
 E5YeoKsIG5RWpqpKwvvqXHs88jdIsfy4hK8APlDktF5/ud2uvuHEmUv1vqdrYNaoMwvd
 CE2HhioQ7CoKMxf2xJi2EB72fNAfrXP62xIK5D3eOBKHGrN91BXP0pQCtkavUjsdCv97
 pRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563663; x=1710168463;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhSL9L6i0aOAZo8N8suydoKY/g4js+qYkf15ZwPPRKs=;
 b=b+TiNOupIdeXx1SrOAooUBfQ4Sd+7EHF7Te9Fn23C+1I7UEycG5t98wEEh0Uo94/pY
 hpmHv3z4a4YTdc7+6hskwMftgakO0GA+h78iAxZ+pJF/P6hvkUmFqy/mb1Fc0wHVXy/U
 Eo9vl4OOBQUzH/gB5oOu+lx+HiekZ33+hj0BoxinJcgnC+TcRzVJmAup/dzsoR23d3fW
 cbXf/YrW8Y3v5COZU/xSD6T++Xj6vzxzFp7T0KnUYa0aDWrdLB231ApdbmKSwPt7mvkA
 10IhRonoF0Chf1rTor3xmFKO7N0IgblgsJ1NG6+FffhR6xLvD6cpkeK/ZbXIJvIfWaxs
 jaQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMJiNW7IgBNdgePINug4Qdi3hR7JQF3pe3tuZG8oJU+b/ClmGnW0hppVTYxZ7LtP9HT0WNPcwpW0J5AWfSa2WdX7V4Ww==
X-Gm-Message-State: AOJu0YxHHFGW0LIm+Gvw2jqDq7KXNkulSZ53IdTmQ4pyYFCXhVlXXjdY
 EmLIUD7TFeWd+xsvGCImw1qFL4Qb5sf8zIOZ3DeeS6n5kNQBKQ8DcEfMvJt+Eh+DzW+vusgL+Dz
 MnEBab3zTBzngmX530aFc9u7N0x8=
X-Google-Smtp-Source: AGHT+IHLJ+99NxFR6y/V5jONHdDeqtTze6FomJY8smeWPgON794hvVf+vDmTgP5qFrUDXqsq4GSkdfxNUG2UYKQBz08=
X-Received: by 2002:a05:6512:251:b0:512:d877:df6f with SMTP id
 b17-20020a056512025100b00512d877df6fmr5796768lfo.2.1709563663303; Mon, 04 Mar
 2024 06:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
In-Reply-To: <20240104114619.280513-1-o451686892@gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 4 Mar 2024 22:47:32 +0800
Message-ID: <CAHk0Hov+uwanmDK9wh9ke6c2JX7TRw9_qsF9Vq+Hrs6rqFqD6Q@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
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

Gentle ping. Not merged yet.

BR,
Weizhao

On Thu, Jan 4, 2024 at 7:46=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.com=
> wrote:
>
> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> crashes.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  cmd/sf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/sf.c b/cmd/sf.c
> index 730996c02b..e3866899f6 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const a=
rgv[])
>         }
>         flash =3D NULL;
>         if (use_dt) {
> -               spi_flash_probe_bus_cs(bus, cs, &new);
> -               flash =3D dev_get_uclass_priv(new);
> +               ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> +               if (!ret)
> +                       flash =3D dev_get_uclass_priv(new);
>         } else {
>                 flash =3D spi_flash_probe(bus, cs, speed, mode);
>         }
> --
> 2.39.2
>
