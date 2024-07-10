Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F96EC2BD09
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 02:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B27788675;
	Wed, 10 Jul 2024 04:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tPh6TH25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99B888685; Wed, 10 Jul 2024 04:00:23 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6972C88675
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 04:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-65240d22f7cso51791367b3.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720576820; x=1721181620; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eJZR82uaHmq4qs8W+Acwsi7s9EmuMlDYZm+E94VbAs=;
 b=tPh6TH25NIhS6RqVpN3x3vgSLnrwtRT/rljEXAN9YA4g/FzNayokEe7/+hCuIcP783
 6zidoNA8+8mdII2jB0vaFkNxowVjBTC2D29z6bffX1j9hpImSuX/TAkDV8133msoE9jd
 p8PbzUKy0c4z2TcMaFa92G2lwhU6xtaQwrGOOrynhQz8LUp04zsEwy5Jy2bs5mIv4G81
 Kg1cYk2U83YLqi+xYrRP+Z3X4L35/xBKO3ZZr1/eSvC3sTFG5OXJTFUCOiTXRfRxCZrZ
 czAOU3LZskLwm7gpXDqvLMLveDaeDHcz+CqPetQIDdRT7A5dIf0NW/r/bl/2mkgLgqBc
 m9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720576820; x=1721181620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eJZR82uaHmq4qs8W+Acwsi7s9EmuMlDYZm+E94VbAs=;
 b=NvDAYngi2DehAKyzYUWmMGaW2sLarbKAn45E0jtxeN8kViddvlAFNa7cTqNE0Vsh9R
 NVFq0eL7tSSCXydTMEsrfFGTIHh46rRpr2CkZZ6MJvXdP0wZQAkRRRwVnJSFgvlWVc8/
 SPB5mMgqN5QWBvfv3bT5UN1tVtgvPS6i9Uy737bC5+Elf6VYjVxyy3hfvuKpsSz/NXtP
 xCqcNw2kiS0iNsdCGNhcLVAEsGWYVwWNVfpRPE+mVkWnSl37Df2K3HfpcfdUEe34jqxb
 W9nsH2ll/Q/kbXnb/HNTNN9PKtrToxWLP9SQYNBAsz3fjb2gODamW+FcXfE1tFrPbgL1
 kx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD/2LqmgC/xDBzqQYIjtND8rihH2+PtIuPmAPxpbQ2KoGgr9e2DoLIp0Vgm4UF0pNrurycGrYSYny9fObbWRlIdIOD8A==
X-Gm-Message-State: AOJu0YydXAA6zO2mbwPmhFygg1UMu3nQaoUVJi0CWiieJpnE+NZtGsJV
 /ExFjdvgBaJ9QOJu05axMaNBT0R4V8xn7OUBLzTY5nbMuO4MzL6Tj7gUmnVBw+IR6ny9WtRLHDo
 qVmyl5mEVcnsDXpNDl8BygQlU33dOn7HNfU4kZg==
X-Google-Smtp-Source: AGHT+IFIyz6SNI1lyKsC0I2IKvRTIcl71+StSM1QSiutB4+8rUP4USYBKVIyvrEl0NKe7jKGIfWEuxUU5Phegnuglk0=
X-Received: by 2002:a81:fe07:0:b0:632:12b:8315 with SMTP id
 00721157ae682-658eed5ea7dmr45199907b3.22.1720576820232; Tue, 09 Jul 2024
 19:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 9 Jul 2024 21:00:08 -0500
Message-ID: <CAPLW+4=n5B39=KnUma7=ZedAnX1FBiw1AtoRTnFO7UNfkecsJQ@mail.gmail.com>
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>, 
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
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

On Thu, Jun 27, 2024 at 6:29=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This allows spliting partition list to several lines in environment file
>
> ex:
> --------------------
> gpt_partition_list=3D
>         name=3Dboot1,size=3D5MiB,start=3D0x100000;
>         name=3Dboot2,size=3D5MiB;
>         name=3Drootfs1,size=3D70MiB;
>         name=3Drootfs2,size=3D70MiB;
>         name=3Doverlay1,size=3D20MiB;
>         name=3Doverlay2,size=3D20MiB;
>         name=3Dart,size=3D4MiB;
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---

Feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>

With this patch the next command succeeds, when having $partitions
described in multi-line variable in .env file:

    =3D> gpt verify mmc 0 "$partitions"

I wonder if it makes sense to also change cmd_gen_envp command in
Makefile to avoid adding spaces in place of newlines, in the first
place? It would allow us to specify unbroken multi-line variables in
.env, though I'm not sure if anyone actually relies on that behavior
in their .env files.

>  cmd/gpt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 7aaf1889a5a..2b29ab98ccc 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char =
*key)
>                 k =3D strsep(&v, "=3D");
>                 if (!k)
>                         break;
> +               k +=3D strspn(k, " \t");
>                 if  (strcmp(k, key) =3D=3D 0) {
>                         new =3D strdup(v);
>                         break;
> @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *ke=
y)
>                 k =3D strsep(&s, ",");
>                 if (!k)
>                         break;
> +               k +=3D strspn(k, " \t");
>                 if  (strcmp(k, key) =3D=3D 0) {
>                         result =3D true;
>                         break;
> --
> 2.43.0
>
