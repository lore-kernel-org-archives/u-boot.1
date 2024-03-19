Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B513C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D259E88013;
	Tue, 19 Mar 2024 19:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NVssHdXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD8087F77; Tue, 19 Mar 2024 19:42:36 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B47388013
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-609fb19ae76so63048417b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710873752; x=1711478552; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLscs0DO7cCbiMRiwo3Tzs7ef6zxcPwgjcMj6RiRBvI=;
 b=NVssHdXCfMk2LatIfFkWzwyMsm/2JXnaS5ZrFpLlk8sYcv0VotUd9LLef7pSjbmsGo
 zE4NZc+zvh+22N+9H2miOrgPKbwQ3yTvrOU3Sb5kakxuKhX54NpedNSTOOZpkiFybxSr
 kvT6L9/ggwloW5i/l8B6nTb6/B8lgf0C1+/DX3Vql0jZvvRovJXhdbM7KKKxcKCQaioH
 fBreBmv9yNITcLUmLVwck0hhWQsLkZtFxzQKMdSFC9FpvWguJsFSeA+MSqqLSkRuqCju
 tjR19YB1z4UezSpL77fxTKElp9SU3Q7NcdTFMrhk0lU7f6SzNIkLfN5dFofbNlX8if9Q
 Ukzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710873752; x=1711478552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLscs0DO7cCbiMRiwo3Tzs7ef6zxcPwgjcMj6RiRBvI=;
 b=r+4NxkEbV3ATs6wS8DC/KGnHjTdS+uDxJ7hpXZ1YRctC/0vemhvCFUgwdyAU0K4WB3
 3vKo1IUpr0E42ANDLEi2O0uimLsD2pxM4YDlBMhEVYHoVgGbzDgsa4tgvVuFaqOgXFxD
 KVVaJLQSINp916wl6tso2XokHpTkimelqY5qm3DGXfT6Trlg4LxqWVy26rYjKiD0HhTQ
 1hVTO1ytoVs1LxtV+IUpMXqMdMNehPWsgBZnD7tr9NeEkMvhVgd3wxYG+taQe2sg5puP
 tSbQPLnH7lYahlO+5eMwqqY0RbdGfYmbl4VY3Deladonl1LuGUkKJ2TKtSMqvX3CN0DR
 +0Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsc4Amz2TWBLnf/fgoLdEqMn+euMorGY3o5cJoXDyvm2jIomBhtRk3bjTgqmb9dSuz/GjqOcgq75g+fEXdgacDtWUOSg==
X-Gm-Message-State: AOJu0YyvZRy31DeB6JOYmE7vZ2npjzwaOHLoPoR4uywtnYk25gbDyRjZ
 uvePJaLJ+AF4BBZKZK839AEeEUvwWbxkb4171yLjQ/YGkKKnV+657HQ3yp03h5a9O7sDxk+rr59
 GfI/sjXf0ZvUF9Cr1LyxjBhiqIZTsgkrJLeDj0Q==
X-Google-Smtp-Source: AGHT+IH9+GVcgneo2JyY680Ner9tzq1zdCjmiU0HC6XmWXpw/yYZOxuO0S9L0fYNeYVsZxDNsJpKSQCoX8o9hKZnK7Y=
X-Received: by 2002:a0d:c103:0:b0:610:be9e:87b5 with SMTP id
 c3-20020a0dc103000000b00610be9e87b5mr7249361ywd.29.1710873752184; Tue, 19 Mar
 2024 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
In-Reply-To: <20240308000432.32369-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 19 Mar 2024 13:42:21 -0500
Message-ID: <CAPLW+4nqmeFNPRibP2PKSOpR67Ud=2wPL1V=XSxnMYDiSM20-A@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>,
 u-boot@lists.denx.de
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

On Thu, Mar 7, 2024 at 6:04=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> Sometimes clocks provided to a consumer might not have .set_rate
> operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
> set. In that case it's usually possible to find a parent up the tree
> which is capable of setting the rate (div, pll, etc). Implement a simple
> lookup procedure for such cases, to traverse the clock tree until
> .set_rate capable parent is found, and use that parent to actually
> change the rate. The search will stop once the first .set_rate capable
> clock is found, which is usually enough to handle most cases.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Hi Lukasz, Sean, Tom,

If this patch looks good to you and there are no outstanding comments,
can you please apply it? It's needed as a part of eMMC enablement for
E850-96 board, as eMMC gate (leaf) clock is specified as ciu clock in
dts, which requires further clock rate change propagation up to
divider clock.

Thanks!

>  drivers/clk/clk-uclass.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc4841..755f05f34669 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -571,8 +571,20 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
>                 return 0;
>         ops =3D clk_dev_ops(clk->dev);
>
> -       if (!ops->set_rate)
> -               return -ENOSYS;
> +       /* Try to find parents which can set rate */
> +       while (!ops->set_rate) {
> +               struct clk *parent;
> +
> +               if (!(clk->flags & CLK_SET_RATE_PARENT))
> +                       return -ENOSYS;
> +
> +               parent =3D clk_get_parent(clk);
> +               if (IS_ERR_OR_NULL(parent) || !clk_valid(parent))
> +                       return -ENODEV;
> +
> +               clk =3D parent;
> +               ops =3D clk_dev_ops(clk->dev);
> +       }
>
>         /* get private clock struct used for cache */
>         clk_get_priv(clk, &clkp);
> --
> 2.39.2
>
