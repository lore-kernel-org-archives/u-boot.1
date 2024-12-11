Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307A3E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693D080351;
	Wed, 11 Dec 2024 16:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JQq/L5tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F0F80331; Wed, 11 Dec 2024 16:52:51 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87AA80304
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so8563690a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932369; x=1734537169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HjxvP8D7xlR6O54v+zn9SmX9n56xUZrWm08c+LIhcn8=;
 b=JQq/L5trFFWritqMv7GNZngFeJiNTmgoR+yudIq+cLCkK7uwm+VAPeMqTpn2PMscLl
 z9jtoElHfAznTdnqITtycwLjrgTHBOeVtdPSvH8VJbcIqDvAnzuBKeyLfOwdklugGSqQ
 y3indE6gvIiCyZ50I0MwmWoULMYkL61L58Ypo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932369; x=1734537169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjxvP8D7xlR6O54v+zn9SmX9n56xUZrWm08c+LIhcn8=;
 b=f1dzSzaN2jHQf+a4VxFK4j0L1QHObZgJOk0U6LJaER1mKszgBEfcJJ28Pi4NAPAa6t
 Ew619AYTIJLTLTWUm2a/R69l0Ikaueg5C4n77O+Yp1vbH/XHqz8pE/NWp2M/pq2NBqq2
 ya38meiasi4fBLwng2OdB58QgNH4M57ik9mxoeCrWB2yRFbTbaLGYoPAWPLsM/iqu/vX
 2SA4j2G4g2N3e/1gUxXsAjvsBtBMAXNG8iN2Y3FC47Fpqyqdcv2BjFEAJ8YFbfpn1rwf
 OB08te9jtr0mx23jjP9QVzYIw1YdyRK309XfT6Klz02GJGynJzV7rMPld+RRZWpysv3y
 3m0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjKlw1dbuE53h22r+GzRcP6ZLsfDOoF7XueITmwXJuM8DrISLYumROns31AvLfNBiOJiA881A=@lists.denx.de
X-Gm-Message-State: AOJu0YyKldmQVJSS4Eztz8TK49dr1H7Voyj44Ka91pE7nkBkQBClhadN
 GsvkQMBBrtX6HVPSV7lJtN/sN7MURYUbg08m8A51ZUZ7oauiii+BRj77MJzqovdj1PRnuhAppHk
 /5LIIOnqLB2/dgk+WmNOEIBKS8dtlrxMg0329
X-Gm-Gg: ASbGnctcwXno3nYdKDNKeq1nLE2vb/3aqdDN2I6IDFmUx1+mabuaSqBmrPO19KuCswD
 FnNMpAv4f8TgRTT39hlMj3Dt1BHhpVTWacNps
X-Google-Smtp-Source: AGHT+IGX2d7pkqJ83uH4eC5uNUU9uSNDb6VjpzCpkVGlZZnme+R/zSZv5OpqzP1Pd5Sxpe1ZQwitYgoag7ZaZQb0Ws8=
X-Received: by 2002:a17:907:9518:b0:aa6:256a:40a7 with SMTP id
 a640c23a62f3a-aa6b117f953mr305673366b.22.1733932369207; Wed, 11 Dec 2024
 07:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
 <20241211-dtb_dt_embedded_within_fdtdec-v1-2-7840469f0084@salutedevices.com>
In-Reply-To: <20241211-dtb_dt_embedded_within_fdtdec-v1-2-7840469f0084@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:52:36 -0700
Message-ID: <CAFLszTghndgVyHQ_vttUeRHet9iubKJyG_KsXjXK3LO=iKqgDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fdtdec: dtb_dt_embedded: replace ifdefs by
 IS_ENABLED()
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 kernel@salutedevices.com, evgen89bachinin@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 10 Dec 2024 at 15:40, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Patch fixes the checkpatch warnings like:
> ```
>   WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
>   #94: FILE: lib/fdtdec.c:102:
>   +#ifdef CONFIG_OF_EMBED
> ```
>
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  lib/fdtdec.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Yes that is better and I'm pleased that it works


> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 9cb94a158441cfd291a0f173c321a722e896bcb2..7f1418890860a759efcf2b84551d24a3697e4a4b 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -99,15 +99,15 @@ extern u8 __dtb_dt_spl_begin[];     /* embedded device tree blob for SPL/TPL */
>  /* Get a pointer to the embedded devicetree, if there is one, else NULL */
>  static u8 *dtb_dt_embedded(void)
>  {
> -#ifdef CONFIG_OF_EMBED
> -# ifdef CONFIG_XPL_BUILD
> -       return __dtb_dt_spl_begin;
> -# else
> -       return __dtb_dt_begin;
> -# endif
> -#else
> -       return NULL;
> -#endif
> +       u8 *addr = NULL;
> +
> +       if (IS_ENABLED(CONFIG_OF_EMBED)) {
> +               addr = __dtb_dt_begin;
> +
> +               if (IS_ENABLED(CONFIG_XPL_BUILD))
> +                       addr = __dtb_dt_spl_begin;
> +       }
> +       return addr;
>  }
>
>  const char *fdtdec_get_srcname(void)
>
> --
> 2.34.1
>
