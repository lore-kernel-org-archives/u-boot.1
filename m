Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CC9C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EB8879CE;
	Wed, 27 Dec 2023 18:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PmZ/Fa+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F44879C7; Wed, 27 Dec 2023 18:49:11 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D7A879CB
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ba14203a34so5483278b6e.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699346; x=1704304146; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUhY3v5VuJP6kgEaMhWGkPyYoLLOvf5K7f5mkwVSyJU=;
 b=PmZ/Fa+lDh5p7XiXuRhv0bnWN37YDbqGee924Nl912HzYf+Q438cTkahMO/Eea/D9y
 sM+wvxm5E6QDGkp19HsBSFtrrY6dgUtZdtKtBYFWi85PgHbJPeENOlvNH+ZI43OniWcq
 fL7gUVEPc+Om344EAO9xTKCfQ8eOxfOa26pbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699346; x=1704304146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUhY3v5VuJP6kgEaMhWGkPyYoLLOvf5K7f5mkwVSyJU=;
 b=tWBp+ZJ/ohgvifjzJyJa+8pYYot1WEq9WwMi/KQrZMhHBrkQSU2RcaPlOxOHlNaQZN
 NFokqNdFbgFvLXzhXqrgrd6S86vIL5wO6RJ2pJK1vxeZ1gKE1424/JUs48mSdYKzM1kG
 JucA4Sl4MSX0/QmvxLYxz9mJyVvnFW6xEVk7ABFC+KK8qJswEdSWxK3SBJ7Y0GzQbMtN
 Uyxruk+SKot6c3WhSR8hJW1YYLAs8Te1ZN8hLrPq2zqgsh4zZTW2nBp6Ilzz6CaFLFnm
 eqQPSCmk76O3QEUM3nZLPwgZgi+PT/AR4+UC6Qlfo8O15hF5tqcaxOM3DlRha6oCrDji
 q7Jg==
X-Gm-Message-State: AOJu0YzzNVRcYI0SjrpZm73jeWeIItPG/POB6Gb475Rn5SYcr8xtnuxF
 w39l/4gKxismjnd8W9BjtPA02NdtsrAd7VrRb54VfhIO5vLP
X-Google-Smtp-Source: AGHT+IFOd0Z9OkSZlP6/Vhf6C3P7TjR+i5T4NyGtlb2AlTWD/Apcgu5PNZ4Ylt0+ennySRY9h4pHJBoo3fxdvFJ2DxA=
X-Received: by 2002:a05:6808:2224:b0:3bb:cf5e:7833 with SMTP id
 bd36-20020a056808222400b003bbcf5e7833mr87610oib.85.1703699346175; Wed, 27 Dec
 2023 09:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-5-clamor95@gmail.com>
In-Reply-To: <20231115153836.16537-5-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:55 +0000
Message-ID: <CAFLszTjVb2U0sr3++LmocrFCJnTkThtEDuiziYv8Xcb5cBOaDQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] lib: membuff: fix readline not returning line in
 case of overflow
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

On Wed, Nov 15, 2023 at 3:39=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> If line overflows readline it will not be returned, fix this behavior,
> make it optional and documented properly.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  boot/bootmeth_extlinux.c | 2 +-
>  common/console.c         | 2 +-
>  include/membuff.h        | 5 +++--
>  lib/membuff.c            | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index aa2a4591eb..ae0ad1d53e 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
>         log_debug("parsing bflow file size %x\n", bflow->size);
>         membuff_init(&mb, bflow->buf, bflow->size);
>         membuff_putraw(&mb, bflow->size, true, &data);
> -       while (len =3D membuff_readline(&mb, line, sizeof(line) - 1, ' ')=
, len) {
> +       while (len =3D membuff_readline(&mb, line, sizeof(line) - 1, ' ',=
 true), len) {
>                 char *tok, *p =3D line;
>
>                 tok =3D strsep(&p, " ");
> diff --git a/common/console.c b/common/console.c
> index 8a869b137e..cd56035171 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -846,7 +846,7 @@ bool console_record_overflow(void)
>  int console_record_readline(char *str, int maxlen)
>  {
>         return membuff_readline((struct membuff *)&gd->console_out, str,
> -                               maxlen, '\0');
> +                               maxlen, '\0', false);
>  }
>
>  int console_record_avail(void)
> diff --git a/include/membuff.h b/include/membuff.h
> index 21051b0c54..4eba626ce1 100644
> --- a/include/membuff.h
> +++ b/include/membuff.h
> @@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
>   * @mb: membuff to adjust
>   * @str: Place to put the line
>   * @maxlen: Maximum line length (excluding terminator)
> + * @must_fit: If true then str is empty if line doesn't fit
>   * Return: number of bytes read (including terminator) if a line has bee=
n
> - *        read, 0 if nothing was there
> + *        read, 0 if nothing was there or line didn't fit when must_fit =
is set
>   */
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minc=
h);
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minc=
h, bool must_fit);
>
>  /**
>   * membuff_extend_by() - expand a membuff
> diff --git a/lib/membuff.c b/lib/membuff.c
> index 36dc43a523..964e504d5b 100644
> --- a/lib/membuff.c
> +++ b/lib/membuff.c
> @@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
>                         (mb->end - mb->start) - 1 - membuff_avail(mb);
>  }
>
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minc=
h)
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minc=
h, bool must_fit)
>  {
>         int len;  /* number of bytes read (!=3D string length) */
>         char *s, *end;
> @@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str, i=
nt maxlen, int minch)
>         }
>
>         /* couldn't get the whole string */
> -       if (!ok) {
> +       if (!ok && must_fit) {
>                 if (maxlen)
>                         *orig =3D '\0';
>                 return 0;
> --
> 2.40.1
>
