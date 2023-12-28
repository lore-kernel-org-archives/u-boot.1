Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D95C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F0F87A15;
	Thu, 28 Dec 2023 14:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LrP/khq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD5787A7F; Thu, 28 Dec 2023 14:37:54 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD46887A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35ffb15244dso28112565ab.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770669; x=1704375469; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5QmaLi1uIurEbSUzZs7dDecqAt3GvGMXoOoR0Nh3jI=;
 b=LrP/khq8119c8X7yc5nQu6mwEQC6j+ZVU35mBshhTtNtypQ/VtBnIXdJo8IZ45g4Vr
 VWoEDoeiadCkJe6+vGEkWGao6K0965TAOBY+EzyU4rhxg23/HheZ5CvWamTKdQb1g/li
 UJW2xTO5uNX8f8a/lnFX+gvuvGXfkLY82ks1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770669; x=1704375469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5QmaLi1uIurEbSUzZs7dDecqAt3GvGMXoOoR0Nh3jI=;
 b=iAie0J4yna0hgOzjgvMoBDIZm51KHFnVUu3nxPmOljyrh1xo3H5t6lKItP/ZqcUlNY
 pzE4GlW0cB0Vl5fL/T+RJ3EKE7fSCDShTIE+kafB+IFpcXaBMfqrb8IJ2iDZBdvZiV3n
 T9tk1sC/47VoLUOGN05mrD2xN8m/pMog4HL1WWI4CK8Sd7YvlBJ6hmB20pY/U23zF0ru
 pQ6Hu98g5RSpgmU4u1MmQIyVz94po/N8W1A7EU/660lzxJu20GQX0YeuPTbzrAlwS4mC
 D+alsmMinvC8S3UueI3kEJCP+lknrHzSwrbTiR2LnJoUOEhPH0FnHtFt4N165QLRF/ZM
 ZX1Q==
X-Gm-Message-State: AOJu0YwAyApY1te4kCVzMZdi3dpfiB8fguhIIdn17jZlC/XM2TvPEggp
 ySetUWnPfzS20DMZVO6gCKLOn2LVz/ByFV7huuM0MZd4xEnw
X-Google-Smtp-Source: AGHT+IFlyfCcGsZOMgMXaYOUTEUdB//XAy+0AtLl69p6JipAeG7V1/caHAa1l6LdNPcGYtDnn97ovku2os8UWCYGLc0=
X-Received: by 2002:a05:6e02:3105:b0:360:18f:dc14 with SMTP id
 bg5-20020a056e02310500b00360018fdc14mr8020223ilb.54.1703770669509; Thu, 28
 Dec 2023 05:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20231228090240.18011-1-clamor95@gmail.com>
 <20231228090240.18011-4-clamor95@gmail.com>
In-Reply-To: <20231228090240.18011-4-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:17 +0000
Message-ID: <CAFLszTgCbtB8d52bmASAsX49WAYemqYQqsZOnWDkNC1xgA=PrQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] common: console: introduce overflow and isempty
 calls
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Thu, Dec 28, 2023 at 9:03=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> Separate record overflow logic and add console_record_isempty
> as available calls don't serve to know output has been read
> fully with readline's.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  common/console.c  | 15 ++++++++++++---
>  include/console.h | 26 ++++++++++++++++++++++++++
>  test/ut.c         |  9 ++++-----
>  3 files changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index 1ffda49c87..833da61733 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -821,6 +821,8 @@ int console_record_init(void)
>         ret =3D membuff_new((struct membuff *)&gd->console_in,
>                           CONFIG_CONSOLE_RECORD_IN_SIZE);
>
> +       gd->flags |=3D GD_FLG_RECORD;

Why is this here? It is currently enabled by
console_record_reset_enable(). In any case it looks like this needs it
own patch.

> +
>         return ret;
>  }
>
> @@ -839,11 +841,13 @@ int console_record_reset_enable(void)
>         return 0;
>  }
>
> -int console_record_readline(char *str, int maxlen)
> +bool console_record_overflow(void)

There is too much going on in this patch. Why is
console_record_overflow() changing? Can that go in its own patch?

>  {
> -       if (gd->flags & GD_FLG_RECORD_OVF)
> -               return -ENOSPC;
> +       return gd->flags & GD_FLG_RECORD_OVF ? true : false;
> +}
>
> +int console_record_readline(char *str, int maxlen)
> +{
>         return membuff_readline((struct membuff *)&gd->console_out, str,
>                                 maxlen, '\0');
>  }
> @@ -853,6 +857,11 @@ int console_record_avail(void)
>         return membuff_avail((struct membuff *)&gd->console_out);
>  }
>
> +bool console_record_isempty(void)
> +{
> +       return membuff_isempty((struct membuff *)&gd->console_out);
> +}
> +
>  int console_in_puts(const char *str)
>  {
>         return membuff_put((struct membuff *)&gd->console_in, str, strlen=
(str));
> diff --git a/include/console.h b/include/console.h
> index e29817e57b..21466d51a9 100644
> --- a/include/console.h
> +++ b/include/console.h
> @@ -64,6 +64,13 @@ void console_record_reset(void);
>   */
>  int console_record_reset_enable(void);
>
> +/**
> + * console_record_overflow() - returns state of buffers overflow
> + *
> + * Return: true if the console buffer was overflowed
> + */
> +bool console_record_overflow(void);
> +
>  /**
>   * console_record_readline() - Read a line from the console output
>   *
> @@ -84,6 +91,13 @@ int console_record_readline(char *str, int maxlen);
>   */
>  int console_record_avail(void);
>
> +/**
> + * console_record_isempty() - Returns if console output is empty
> + *
> + * Return: true if empty
> + */
> +bool console_record_isempty(void);
> +
>  /**
>   * console_in_puts() - Write a string to the console input buffer
>   *
> @@ -113,6 +127,12 @@ static inline int console_record_reset_enable(void)
>         return -ENOSYS;
>  }
>
> +static inline bool console_record_overflow(void)
> +{
> +       /* No overflow */
> +       return false;
> +}
> +
>  static inline int console_record_readline(char *str, int maxlen)
>  {
>         /* Nothing to read */
> @@ -131,6 +151,12 @@ static inline int console_in_puts(const char *str)
>         return 0;
>  }
>
> +static inline bool console_record_isempty(void)
> +{
> +       /* Always empty */
> +       return true;
> +}
> +
>  #endif /* !CONFIG_CONSOLE_RECORD */
>
>  /**
> diff --git a/test/ut.c b/test/ut.c
> index 628e9dc980..2a3bb8133a 100644
> --- a/test/ut.c
> +++ b/test/ut.c
> @@ -53,15 +53,14 @@ long ut_check_delta(ulong last)
>
>  static int readline_check(struct unit_test_state *uts)
>  {
> -       int ret;
> -
> -       ret =3D console_record_readline(uts->actual_str, sizeof(uts->actu=
al_str));
> -       if (ret =3D=3D -ENOSPC) {
> +       if (console_record_overflow()) {
>                 ut_fail(uts, __FILE__, __LINE__, __func__,
>                         "Console record buffer too small - increase CONFI=
G_CONSOLE_RECORD_OUT_SIZE");
> -               return ret;
> +               return -ENOSPC;
>         }
>
> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str))=
;

I don't see why these are changing. We can use -ENOSPC for overflow, right?

> +
>         return 0;
>  }
>
> --
> 2.40.1
>

Regards,
SImon
