Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1205C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236AC86FB8;
	Tue, 16 Jan 2024 17:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cv1HcO8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99F1871BB; Tue, 16 Jan 2024 17:30:10 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BC286FB0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a28b1095064so1134358066b.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705422608; x=1706027408; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah+KpIFxINeqjKoWk0Est9A8em2cueX7ZTdn5KWqH3g=;
 b=Cv1HcO8iyxX8ncgQa2lBen4juUqiZtfKtx9paYWnJmvgR77LGwlVvsQo+nR+yVoMBK
 92U27eqGR9nqmVWQbuQWfY8RaYmODOYyjpYNXdA34uTcgZ5afBv1NtXCnOuNi1g18Mgl
 IgKYn8HUtEzLH/IHMslDkrtdEuzsklFzjrcmKpBlkvxT+Gzi4l40n++lorIqL/noeKlP
 x1GyeUOfgWjcQmHckiAYJ6hOjE+4CSnca61e2VNEQ7KiK1/vdoXZc4UzTVtNAvLA5BV3
 Om1X/SqAdn8zprBSkIdo8SZK/BIuvbxIhWeBMt8BnbS8ke1Pzh+TQudov/mpp+DtqC4W
 dlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705422608; x=1706027408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah+KpIFxINeqjKoWk0Est9A8em2cueX7ZTdn5KWqH3g=;
 b=K+wvg8OXwr/k7cVgoOGjjZBVf4nnxykMkBuXJBDZFUNnF1w/vbsVEF02HG6GiwHtYY
 m/O530giqe3HBb11pliL6yyJb63pQde/ydaC2DbcmkDjjPiVC4RBH6ZDvAfQCOMKKxWI
 N5fo+L/88Qves2mwoc7eckLLBAdGHAD0SH4vSZ5JwuKg6nK4XeAsfgTATw9tMtDxXk8H
 XbCV25p6UxuFHFJiC/C4swFKighMQlld7GxiggNpBdGv14l68FhFUZP7vvJkmz+urH5w
 yBwM8dd2Aa8B8Voyb5vHteEeiSF6bapFKK/Z4yUfg3o3/cES05hRabX2V7hm6BZyxRDE
 yeRw==
X-Gm-Message-State: AOJu0YyFNVnWCOGGwxLW68tBcmFiMKLoPbE1xJUWNq69xa8PBWcqzS/O
 a4K5vCab2RQ+jyx5PAiW8XElU21nH3a9aem6F+o=
X-Google-Smtp-Source: AGHT+IFGfYdIvMft5RT7ZH1jll3NhxB2kiGblL97kbok8B/4PzLB/H4e9p6JtgvH0RmI1Cw+TdiPZ3L0Yj587MNLJmw=
X-Received: by 2002:a17:907:b023:b0:a2b:684:11d with SMTP id
 fu35-20020a170907b02300b00a2b0684011dmr1518646ejc.255.1705422608048; Tue, 16
 Jan 2024 08:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20240116161231.741794-1-patrice.chotard@foss.st.com>
In-Reply-To: <20240116161231.741794-1-patrice.chotard@foss.st.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 17 Jan 2024 00:29:57 +0800
Message-ID: <CAEUhbmUOy-iJ9SEiA8atU=V5CG+DAAxtQ9HJXO2A5_W=hwe1jw@mail.gmail.com>
Subject: Re: [PATCH] common: console: Fix print complete stdio device list
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Wed, Jan 17, 2024 at 12:13=E2=80=AFAM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
> stdin or stdout or stderr are missing in environment, as fallback, get
> these either from stdio_devices[std] or stdio_devices[std]->name.
>
> Fixes: 6b343ab38d ("console: Print out complete stdio device list")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>  common/console.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index cad65891fc9..8bfcfce5643 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -1049,6 +1049,11 @@ int console_clear(void)
>         return 0;
>  }
>
> +static char *get_stdio(const u8 std)
> +{
> +       return stdio_devices[std] ? stdio_devices[std]->name : "No device=
s available!";
> +}
> +
>  static void stdio_print_current_devices(void)
>  {
>         char *stdinname, *stdoutname, *stderrname;
> @@ -1060,19 +1065,13 @@ static void stdio_print_current_devices(void)
>                 stdoutname =3D env_get("stdout");
>                 stderrname =3D env_get("stderr");
>
> -               stdinname =3D stdinname ? : "No input devices available!"=
;
> -               stdoutname =3D stdoutname ? : "No output devices availabl=
e!";
> -               stderrname =3D stderrname ? : "No error devices available=
!";
> +               stdinname =3D stdinname ? : get_stdio(stdin);
> +               stdoutname =3D stdoutname ? : get_stdio(stdout);
> +               stderrname =3D stderrname ? : get_stdio(stderr);
>         } else {
> -               stdinname =3D stdio_devices[stdin] ?
> -                       stdio_devices[stdin]->name :
> -                       "No input devices available!";
> -               stdoutname =3D stdio_devices[stdout] ?
> -                       stdio_devices[stdout]->name :
> -                       "No output devices available!";
> -               stderrname =3D stdio_devices[stderr] ?
> -                       stdio_devices[stderr]->name :
> -                       "No error devices available!";
> +               stdinname =3D get_stdio(stdin);
> +               stdoutname =3D get_stdio(stdout);
> +               stderrname =3D get_stdio(stderr);
>         }
>
>         /* Print information */
> --

This can be further simplified to:

char *stdinname =3D NULL;
char *stdoutname =3D NULL;
char *stderrname NULL;

    if (CONFIG_IS_ENABLED(CONSOLE_MUX) &&
         CONFIG_IS_ENABLED(SYS_CONSOLE_IS_IN_ENV)) {
               /* stdin stdout and stderr are in environment */
               stdinname  =3D env_get("stdin");
               stdoutname =3D env_get("stdout");
               stderrname =3D env_get("stderr");
    }

   stdinname =3D stdinname ? : get_stdio(stdin);
   stdoutname =3D stdoutname ? : get_stdio(stdout);
   stderrname =3D stderrname ? : get_stdio(stderr);

Regards,
Bin
