Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8752CE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 21:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E352801BE;
	Thu, 12 Dec 2024 22:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OU1Kokme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A533E801CF; Thu, 12 Dec 2024 22:10:11 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F87801BD
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 22:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6efa5bf5202so9149557b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734037808; x=1734642608; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dblv2IOXCBI7f71ezDoEWVbjVtA5YRc6tyrFzCXOYU4=;
 b=OU1KokmesLmtmbkl01on+Uw2FsFDWhSUPxAazE4gLCwtRParOvCwPuaGFnXzjC2j7+
 9OF8yUujbIaF6Nkb8LuQfeFiuJGRgROESEcNAxbODZutAAX246NMP9ABb7FI+CWQzShp
 BAFArrdsWQJ1nUhbDrr1iA7Q5VsRGTnqsdnCNYkNJz6ACW8VltmPDI3jxVbQY0dQ9Hs0
 3bfAPzDtlJIG+WDZmHz1JixKuCQKDApefr8Cswtve7z+tnvlIE2xPT+pz59Q2PTL2IU1
 FMdzOAXb1wFa81cwXIyM/EHP/+Fpk13/6IdC+wu2p2/kRYrTBvuMSm/TdCwcWKEvJjOf
 kMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734037808; x=1734642608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dblv2IOXCBI7f71ezDoEWVbjVtA5YRc6tyrFzCXOYU4=;
 b=l+eeE8jhWijjkWrBgNyWKFq7QXkLnR+H5UwFmLFWW0AhwDYHfXcd+JlbZjAyTZKXzJ
 At56+4Ze00BDK3D+ScaAUmv4eH5aSara9DthGaUmcl0pMf5Szb2W/0uTjRJmkxRElXBd
 SMCwkK1QQdpTSIMM7J9EHUQwlqF+qlU31QZq7TDuj/uoBp7iaBv5ShFYBwHiROwV//dz
 hg6qC7lxL5PIG6hrlqCdyjdigwTz3b499T0/BHjT5LjGY2D6/yGaXUfclqdyfLHjV5ja
 ggSMWIV038y61Yf759m/OHigNCSEO+57CDpcVZrm0Pzta6Wflo5s3SoR7P5Za7uJwnfg
 Uefw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLmxJ6DOGqKcjOAHdgL3DB0pQMLneublQdsjFyKFbG5FXddqMXdGHPoLfeeIHF319OQxykgqw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt2/4xWmDqqXACojnkKFIRMLuxwtUCtu2toyoFFo+oPUhbLWRT
 GakKU13NR+ZBOmf92DNm8b/u9Qpfr/cIm23XwdgmGUncTPS/pzPKdFp7YmicnNT3vLVsVpP0W/c
 1jVZJfqz3kReA8waceOcgRrBQGGWt/VfHg1hgqg==
X-Gm-Gg: ASbGnctymhKvRdEtQl7Ov9lklGh1eAbfG4wmmHITdyTjx+1OedCl2udXWcf79E0k8MV
 QPaTAJ5AGKumf7vZUfeFEAkB6kOydSBbHsxIq5w==
X-Google-Smtp-Source: AGHT+IH6NNvcMXdq2YMDvBT2Dgy774dL1QeGgdaUVv26ovYdTt6bnDTK/YwRQCNplcC++s36L/bb2AEp1fSxGB42RFY=
X-Received: by 2002:a05:690c:6a05:b0:6ef:6a91:4966 with SMTP id
 00721157ae682-6f279b9cab1mr1832847b3.38.1734037808098; Thu, 12 Dec 2024
 13:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-2-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 15:09:57 -0600
Message-ID: <CAPLW+4=A6CrxZTd4FKjn8do3KaJf0N-wKer7EBzy2RMjgqOL-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] lmb: Remove lmb_align_down()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We already have a macro for this. Use it instead of adding yet another
> variant for alignment.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  lib/lmb.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index f9880a8dc62b..b9c26cb02e10 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -342,11 +342,6 @@ static long lmb_overlaps_region(struct alist *lmb_rg=
n_lst, phys_addr_t base,
>         return (i < lmb_rgn_lst->count) ? i : -1;
>  }
>
> -static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> -{
> -       return addr & ~(size - 1);
> -}
> -
>  /*
>   * IOVA LMB memory maps using lmb pointers instead of the global LMB mem=
ory map.
>   */
> @@ -400,7 +395,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_siz=
e_t size, ulong align)
>
>                 if (lmbsize < size)
>                         continue;
> -               base =3D lmb_align_down(lmbbase + lmbsize - size, align);
> +               base =3D ALIGN_DOWN(lmbbase + lmbsize - size, align);
>
>                 while (base && lmbbase <=3D base) {
>                         rgn =3D lmb_overlaps_region(&io_lmb->used_mem, ba=
se, size);
> @@ -416,7 +411,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_siz=
e_t size, ulong align)
>                         res_base =3D lmb_used[rgn].base;
>                         if (res_base < size)
>                                 break;
> -                       base =3D lmb_align_down(res_base - size, align);
> +                       base =3D ALIGN_DOWN(res_base - size, align);
>                 }
>         }
>         return 0;
> @@ -709,13 +704,13 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size=
, ulong align,
>                         continue;
>
>                 if (max_addr =3D=3D LMB_ALLOC_ANYWHERE) {
> -                       base =3D lmb_align_down(lmbbase + lmbsize - size,=
 align);
> +                       base =3D ALIGN_DOWN(lmbbase + lmbsize - size, ali=
gn);
>                 } else if (lmbbase < max_addr) {
>                         base =3D lmbbase + lmbsize;
>                         if (base < lmbbase)
>                                 base =3D -1;
>                         base =3D min(base, max_addr);
> -                       base =3D lmb_align_down(base - size, align);
> +                       base =3D ALIGN_DOWN(base - size, align);
>                 } else {
>                         continue;
>                 }
> @@ -740,7 +735,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, =
ulong align,
>                         res_base =3D lmb_used[rgn].base;
>                         if (res_base < size)
>                                 break;
> -                       base =3D lmb_align_down(res_base - size, align);
> +                       base =3D ALIGN_DOWN(res_base - size, align);
>                 }
>         }
>         return 0;
> --
> 2.45.2
>
