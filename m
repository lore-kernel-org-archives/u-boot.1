Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC5BC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5691082063;
	Thu,  3 Jul 2025 18:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q0Sxlbm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325308206E; Thu,  3 Jul 2025 18:00:52 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D851780E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e898fb745beso1040278276.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558449; x=1752163249; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnVvl0dc7jHH+B+z/GgQvnlysDHygPDS/laZ+ZHfhiE=;
 b=q0Sxlbm7QAbsz/YbpUSmqBVA4LxM6H7X8wm/OdZVHi+pyS+NeA1o+MLLyjjJwHrGgQ
 Ef9hQgmTs7gYfY4lOqBYuivF7KQDfP7cYh6ygVjenxDHyo7+7iGvAaQYJZ43hKhhkayQ
 Ap4yc//y8IBYQt4+LQpyaicd0POKLN1T0BV6aC4hXWmNxBzKZT3O15KG4VFnunJK6jBe
 H93uyKkDdyzPTJJ8ppWL0HXFqBXqroPUi521wNl76exTWhcOcmm7zEdsHONhSuizMAwK
 fT5LOPB18/GqPLLfoKq+WDVQ6PMjXZtKcZJXa5IYuYPJeRrW21NUvvshAxv6bsSCslKn
 +5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558449; x=1752163249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnVvl0dc7jHH+B+z/GgQvnlysDHygPDS/laZ+ZHfhiE=;
 b=PlkIfOjqvnwbneFlkd3pwsXvCgJuYnNWEEbzsBYQEjBZ8UMLh8Ua8L2Cz1Zss/yajm
 oRsBbsz3MoC7ZFfQx4oBmjYIlbXdYeCNafqHp5zLvS2Obk55BKtSw2wt9bJC6jU17hgp
 0Muibp5CaEEV6LFPljHImq6gBtKITnJWNQDcQO338s2CEDqW02qWGX1vdojMLO2mpMkg
 omsoQ3L7BwLZnn47DpTDSvfyxAd+/Mzo1PqFlLCNDF5sa6ycMPkuuju9yh0Kpxgga7ZN
 D1b5V+YVe8cZ7ncky7+gQfcFiJBz2N+XjPHehXhMvWkprNBa5o2F8cI5BUQbGhQoOI+q
 o7fg==
X-Gm-Message-State: AOJu0Yyk5Q+dkxyLIOuLrXSFGBUeqUJT3jKOvNxroZ0CWCiOaKqSpiEl
 GRIrT9caSzzJiUBOTKQmgA2nGuuXxw2je5I0O3ntILbOx8aVJFB8vRafHrqvl5Ii5HGU74mIvaF
 SbJcq2ECMyPQl+gNAXdgsbPscjX0da5e51W4UT7LkUA==
X-Gm-Gg: ASbGncspaT4Rog+TftAGQM9w/JjO4kE2HzDx+E8/idMG0nzydpfBjwabfH15IHeAp55
 7Ml6Rx66VreGipD8s0Ze7yKsEp5w00T0OF1xj9fhT4icY5mSfEqV8KMaZ2byigk0Xr+nxHdGMJF
 rZCxlRp655bFy2iNip/lBjBwffUdvWpxz6Fa+2fy5LN3Q=
X-Google-Smtp-Source: AGHT+IG5gKXTdhYKOYkG5Vaitpr0822uQh7mN59MFym20+xSBqt+FRznmtLzkelynBDISEb/LYeLFOdlj3mHk49HLWY=
X-Received: by 2002:a05:690c:b17:b0:712:cc11:aff with SMTP id
 00721157ae682-7165cafa274mr37474757b3.11.1751558447915; Thu, 03 Jul 2025
 09:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250702010603.19354-1-trini@konsulko.com>
In-Reply-To: <20250702010603.19354-1-trini@konsulko.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 3 Jul 2025 11:00:35 -0500
X-Gm-Features: Ac12FXzeHvhHMgELKqmp1cCjycAhjYQajX5cFdiE6-8hjfJNjDj2izYGoqfRI4w
Message-ID: <CAPLW+4=5+kNz0cedjeEP9==-vDZ819JkBx++BVHQmHgt9jt94Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot/android_ab.c: Make use of LBAF for printing
 lbaint_t
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Tue, Jul 1, 2025 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness. Furthermore, printed message should not be split as that
> makes finding them harder, so bring this back to a single line.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  boot/android_ab.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index a287eac04fe8..13e82dbcb7fe 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -101,8 +101,7 @@ static int ab_control_create_from_disk(struct blk_des=
c *dev_desc,
>         abc_blocks =3D DIV_ROUND_UP(sizeof(struct bootloader_control),
>                                   part_info->blksz);
>         if (abc_offset + abc_blocks > part_info->size) {
> -               log_err("ANDROID: boot control partition too small. Need =
at");
> -               log_err(" least %lu blocks but have %lu blocks.\n",
> +               log_err("ANDROID: boot control partition too small. Need =
at least %lu blocks but have " LBAF " blocks.\n",
>                         abc_offset + abc_blocks, part_info->size);
>                 return -EINVAL;
>         }
> --
> 2.43.0
>
