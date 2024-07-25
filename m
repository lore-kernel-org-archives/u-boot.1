Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E0CC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 02:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4F6889CB;
	Thu, 25 Jul 2024 04:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LjDZETX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC8888998; Thu, 25 Jul 2024 04:41:29 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D53A889CB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 04:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-65f9708c50dso4320857b3.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 19:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721875286; x=1722480086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqaM/RmH0FgGS5DTcCfPw6sy2ss3RVfRBbMzaRh21Nk=;
 b=LjDZETX0nngFOeiujk8o+SGOL3c3YuA7PZtB+tFs4lE/XED2210PGZG2RZYgeEYV/t
 trD+VmBpRGlRik8iaWjFDSyNSOPv0438UIXW7oHt5Tox1Uhhwb8l/ywIV6eZZk8Tiowv
 ubBvD8hJJxYSV1fbUxpxDK8z+lwUyXdnTiYyVl+JTifL5LT2q0hCYh83pDrhdGO90VnB
 rxY6TIO2n6Ew/0WPYVfDy1o0qp5zoTmPTHdBEtMMagF4RmsvWF6fT+cYczP0K6rxFdwW
 F4r26jeZf7Cd2rsX47oLKMnz/QxGaWugAvJFzyTDAA9+2F+pPZAPlr7SSekd4EitFGFa
 QXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721875286; x=1722480086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqaM/RmH0FgGS5DTcCfPw6sy2ss3RVfRBbMzaRh21Nk=;
 b=uE1JDxrGqkULc/MbIao8f2lxHPPQQyPrQznjooSL6Lcg1ISKSIKFtmxgARj8+/4iYb
 zk+2wVtW24v3dPaIlCq25hZxnU0pIYCxTCkkJ9aupUjABY6S0y/Gk00j/NJ1zmhEKSFk
 Z8qOMiHr3WJ6O3NtfHUS9lbbvTHTrfmhASE3TJaMdJOCeYTlmuIaeg7kU12ryekJQHUk
 fFIqk1gZ4NSODz1syPtScugRruRA0Z8kDe3fNyFBdKyJqclbPaOUSXnhTgWyUc/F+waG
 tKSsYqQYIqeacgMC6Ni3MjiTWptMy17hvt2ICg0ZmgpfgX1PL7lWAXaHy70um3vWdArU
 EPzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVve0kQ4Bq24+fqk2qBwd7xH1qP1wtvAWTNruewNVf/cn3GuhvxSpSyaUT5SqEKKiLGg4qQvNfL+WzPlomZ2aEfGD3PlQ==
X-Gm-Message-State: AOJu0YyERRbm7L3mKJUlHuqk2VeQZGWTSE6g41xuuWYuXlAgjZ2VwprW
 txjohpqNwG3ZjVGq5qgI83HU90yHWOHhy6ErTjM/VzHQaEYBLOvhoeVnVi9SlFxA3MxmhaYP0x1
 aHs/S66N3Ef1AN3Ml1HfJoKPmBnX3VFoN/k9QAQ==
X-Google-Smtp-Source: AGHT+IEm/7+bLJHoQssMBTE2AcH/Al2uk9Wa3VA+MmYVdh2PNiXNKevS5CgoK9HoCK8WgSuYG/53iJh/Znw35C7c6N0=
X-Received: by 2002:a81:9485:0:b0:65f:851d:8fb with SMTP id
 00721157ae682-675124f3029mr16627637b3.19.1721875285785; Wed, 24 Jul 2024
 19:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240705071419.11521-1-michael@amarulasolutions.com>
 <CAPLW+4n0j+5Sz7jrAVZx068Vxy2GQVFBCcA0ovsPL-ip0R0WLw@mail.gmail.com>
 <CAOf5uwk8xjgsrVysDgEeOsr6uR5u=LYP3N2s67eBf5eqqtS_MQ@mail.gmail.com>
 <CAOf5uw=5QVsWe0thmTPjUyKFTKo98YsQZosTm0803hVGhZRZmw@mail.gmail.com>
In-Reply-To: <CAOf5uw=5QVsWe0thmTPjUyKFTKo98YsQZosTm0803hVGhZRZmw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jul 2024 21:41:14 -0500
Message-ID: <CAPLW+4kHuTeCo8XBmEZeH3PzZ_jx2X0b7ypc1Mr2Vuaz_J0XBg@mail.gmail.com>
Subject: Re: [PATCH V2] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Wed, Jul 24, 2024 at 4:44=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

[snip]

> > Ok , so you suggest to have something like in the core
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 8faf5a56e1..a309108dd4 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -467,8 +467,14 @@ ulong clk_get_rate(struct clk *clk)
>                 return 0;
>         ops =3D clk_dev_ops(clk->dev);
>
> -       if (!ops->get_rate)
> -               return -ENOSYS;
> +       if (!ops->get_rate) {
> +               parent =3D clk_get_parent(clk);
> +               if (!clk_is_valid(parent))
> +                       return -ENOSYS;
> +               ops =3D clk_dev_ops(parent->dev);
> +               if (!ops->get_rate)
> +                       return -ENOSYS;
> +       }
>
>         return ops->get_rate(clk);
>  }
>
> You suggest to remove get_rate, set_rate function in mux and gate and
> use some propagation in the core, am I right?

Something like that, yes. But maybe instead of

    if (!ops->get_rate)

use something like:

    while (!ops->get_rate)

like I did in my patch [1] for clk_set_rate(). That while loop is
needed to handle cases when there are multiple clocks without
.get_rate() operation connected together (like mux or gate clocks). So
you'd have to iterate them all up the tree to find some DIV clock
which actually has .get_rate() defined.

But at the moment I'm more concerned about .set_rate() propagation of
course, which is really needed for my E850-96 MMC enablement series
[2], which has already been pending on the review for a while.

[1] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html
[2] https://lists.denx.de/pipermail/u-boot/2024-July/559602.html

[snip]

> > > implementations simple and brings the propagation logic to the actual
> > > clk API (clk_set_rate()), which in turn is able to cover all possible
> > > cases: even if some new clock types are implemented later, they will
> > > be covered already. That also reduces some code duplication and makes
> > > it easier to control that behavior in a centralized manner. The patch
> > > with the discussed implementation was already submitted a while ago
> > > [2], and still pending on the review.
> >
> > I have seen it and because I'm extending the clk framework a bit more [=
1]
> > I was thinking about a more complete approach. Nothing against your
> > patch, but just
> > I have observed in my use case (display) that I need more from the
> > clock framework we have
> >

I see. Do you think it'd possible for you to use my patch for
clk_set_rate() propagation for your case, and base your patches (for
CLK_OPS_PARENT_ENABLE, etc) on top of that? Will it cover your
requirements?

Would be also nice to hear what maintainers think about that :)

Thanks!

> > Michael
> >
> > [1] https://patchwork.amarulasolutions.com/patch/3291/
> >
> > >

[snip]
