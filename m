Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C473DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 15:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A28887ED;
	Mon, 22 Apr 2024 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkP///3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4D5887FA; Mon, 22 Apr 2024 17:04:04 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988EC8833C
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 17:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6eb82af305dso2527348a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713798239; x=1714403039; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFV7NW1dErhbMG9lGfxKl05VnhQLayFbmgvZSWLEeog=;
 b=DkP///3v5bVFp/I/r+beCWD0qCMU6LnovG20/Vg0PEO9woJMwMm1JfmgIi4itdiArb
 jQiKqI0GaVwvxrrPL65LYM0fda25PD+4WYUk8FmW+qgsm9yq5xEAP6gIT1/phRjN52W/
 2Rps7JoXBOtBYqKOmvkze3VkJvwE6s33tCETCP/oaoZ0d4PeMhzgy04yH6rrR8sTV7Bf
 mFPFr0kb1qHLhzuxU4xVHzy05WbJ/bAAIPCWQoAfu2Y3smvZvCg9WspQZdhHjjiGH7+p
 5+ntMNwI2E2yKavPVGyS9ptaii5gE1LdhouZaS/9+Xa/b+vZsfmNM0dbwC9PL7SdWngs
 qCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713798239; x=1714403039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFV7NW1dErhbMG9lGfxKl05VnhQLayFbmgvZSWLEeog=;
 b=N4nCHQ9graxsgOzjlbiCbcIV2ag/4lOuWpKl+Nq6v9G+f/c4vWWY9V+yRUCBw3UMiO
 0Q55NfhvqgS3msUHnp/dU75/6GopqJOGoX1C/v3AyGJyP1HYXTYKb9w17gmdFjrwgF9S
 dpF0H+5FA51lcZPnHW4eAnBw+ESmlw78jE8/O55PsIU0lu5gZQwke7FcUJ7zdu5L0St5
 L9Yrcc+iJym7GUfQS3OiuzDdZnn23dBhXRLnfcHgdat4xTg3Sm3Xibxnn2D4r8/C+WgA
 mVDi0NNviJ8zr2ESFsdWngI8wlp4JMg5+6M6M6pytSZc5RQ09LEn5fS6ae42MPeL0nq+
 MSfw==
X-Gm-Message-State: AOJu0YyrEqWo861jljfUOxIJfTt2Q5SmyX9Eo4/+W4OHZk6Ws75+fCB/
 uD3pcYptY5f20ZqeUaCDULg0GeQ2tis/XFa7uXjK1oZwS/vfePb+JgNGML7G6w+kav8wcta+URD
 8GmbQ57yNj+rfcsJEsCyG2r/4aus=
X-Google-Smtp-Source: AGHT+IFDgF5629GWELqm0U3p5QcvXKloWZSqqvgExun+iaYH8QK0kqJ/l9SsalPME0k1B/7vRkLV/jng8DE6xxUI6pA=
X-Received: by 2002:a05:6808:2d4:b0:3c7:4a2c:a19b with SMTP id
 a20-20020a05680802d400b003c74a2ca19bmr11436406oid.12.1713798239355; Mon, 22
 Apr 2024 08:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
 <20240422131613.84304-3-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240422131613.84304-3-lukas.funke-oss@weidmueller.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 22 Apr 2024 08:03:47 -0700
Message-ID: <CANV2PTPDrbjbOQnEwEjBTsC95=aypJTHDg26eThumJei6wbQsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] board: sifive: Call spl_dram_init() for DRAM
 initialization
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Green Wan <green.wan@sifive.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Vincent Chen <vincent.chen@sifive.com>, Zong Li <zong.li@sifve.com>
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

On Mon, Apr 22, 2024 at 6:16=E2=80=AFAM <lukas.funke-oss@weidmueller.com> w=
rote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Call spl_dram_init() since this is commonly used for dram initialization
> in u-boot.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  board/sifive/unleashed/spl.c | 4 ++--
>  board/sifive/unmatched/spl.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/board/sifive/unleashed/spl.c b/board/sifive/unleashed/spl.c
> index fe27316b2d..d6725a0e0e 100644
> --- a/board/sifive/unleashed/spl.c
> +++ b/board/sifive/unleashed/spl.c
> @@ -27,9 +27,9 @@ int spl_board_init_f(void)
>  {
>         int ret;
>
> -       ret =3D spl_soc_init();
> +       ret =3D spl_dram_init();
>         if (ret) {
> -               debug("FU540 SPL init failed: %d\n", ret);
> +               debug("FU540 dram init failed: %d\n", ret);
>                 return ret;
>         }
>
> diff --git a/board/sifive/unmatched/spl.c b/board/sifive/unmatched/spl.c
> index e69bed9d99..500f484844 100644
> --- a/board/sifive/unmatched/spl.c
> +++ b/board/sifive/unmatched/spl.c
> @@ -134,9 +134,9 @@ int spl_board_init_f(void)
>  {
>         int ret;
>
> -       ret =3D spl_soc_init();
> +       ret =3D spl_dram_init();
>         if (ret) {
> -               debug("HiFive Unmatched FU740 SPL init failed: %d\n", ret=
);
> +               debug("HiFive Unmatched FU740 dram init failed: %d\n", re=
t);
>                 goto end;
>         }
>
> --
> 2.30.2
>

Acronym DRAM should be all capitalized letters in strings.

-E
