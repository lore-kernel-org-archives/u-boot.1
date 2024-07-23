Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D27C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 20:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E92387E9F;
	Tue, 23 Jul 2024 22:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ke5J4ksq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764F087E9F; Tue, 23 Jul 2024 22:38:01 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D56887876
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 22:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6694b50a937so51984037b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767071; x=1722371871; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxTwJULvL60KtdcKTJl3rtIJVO46eWBUQeqsw+xpT3U=;
 b=ke5J4ksqZgC/43htmRU7AO5hylX60vxLNG94MwTlSuehXbEa/hh+uFlPMuBB+/+xqr
 8Adcs+dwiPzAnVchb9R5H3ZQGoaPQrOTFx2Gi+D6QUlzVY3x6rwseUtysn4cgDA2KbYD
 9Rc5FXpmZd5vkWmJH+0JOl9r/XahtZuRiof85S8lMc++s+rgvhl4ss/eTma8Qsz52Xu5
 XSsa0iGEE4Ylnq5QP16/JN4H0DJ64yzY1FQVd+dzZgiQAdpxX/CJ7B6epp9Ce9eIPA8t
 SrmgWwE/GusgB05+ZhIvDcLZkQwusAVqneE213+2ebByNanRlZWxuWbbYXzIry/a7Y7J
 nP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767071; x=1722371871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxTwJULvL60KtdcKTJl3rtIJVO46eWBUQeqsw+xpT3U=;
 b=j3eHXwl6KCDRRXIk2S/SOtEPdJ7iiCZpKwgjqqtauP1KO6CcFgkU8ebFaYqDI2RBcM
 l637RTDJCR4dVKBk1mfJ/vnvsGbIuKBJVlpP8lVAq5SnX4O5rFln1HjIKzzYlHaqw5/h
 L8G3Jw4KbcDrR0pYwKyfZLWU561q2+21dw8i0wIyPy4wBaf7/pLj6pxkadrQP1K57JXB
 RL6sVKOKfl64ebxEw8ATkl5iw6+CIFUWSXStHkIOB4Tr65C2KTi0N27gllDGfEv+ggoA
 5zKjT1yyrVnABwUHEePqUdFcJ2EFYnmGGpDgfXPTVhri/IBmufXy9mY3+xAKrrwiDaCa
 hvFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzoJofPdBzhKn1SY90ppoe28ft/t9Dn3323wcr/g2PPlFI1NmEGy1UToAlgMvIIgDdaYNBzQQhlYy92RpIHVDY9R/cPA==
X-Gm-Message-State: AOJu0Yy8Tr0UJsXj+93yYgwXMy1fd/48WcB3yCZ8LYXx2GqIXYtyAaeP
 JSLbVqRy9y0TaotWnwfAnOtbFit9xE4OkAgpYDT/JVDAkAoguEoRcJ8mgExt4BTWLC+qK1ZRSnC
 BegrBULN6OFQj1i0KsdGMhxsjCjlKS847D3bwlsf/6ps2xuCCJ6Q=
X-Google-Smtp-Source: AGHT+IHBDLE77xxoyLsgOqsk25/OgQprm1McS0NGHNBL4qtK3id0sl7OAou92uNh73JcehQlaqC+33i2y+fGmLxqBWA=
X-Received: by 2002:a81:eb08:0:b0:65b:a403:9ec8 with SMTP id
 00721157ae682-671f55b48c5mr10423587b3.38.1721767070990; Tue, 23 Jul 2024
 13:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240705071419.11521-1-michael@amarulasolutions.com>
In-Reply-To: <20240705071419.11521-1-michael@amarulasolutions.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 15:37:40 -0500
Message-ID: <CAPLW+4n0j+5Sz7jrAVZx068Vxy2GQVFBCcA0ovsPL-ip0R0WLw@mail.gmail.com>
Subject: Re: [PATCH V2] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
To: Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, linux-amarula@amarulasolutions.com,
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

On Fri, Jul 5, 2024 at 2:14=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Gate and mux does not have .set_rate operation, but they could have
> CLK_SET_PARENT_RATE flag set. In that case it's usually possible to find =
a
> parent up the tree which is capable of setting the rate (div, pll, etc).
> Add clk_generic_set_rate to allow them to trasverse the clock tree.
>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/clk/clk-gate.c       |  1 +
>  drivers/clk/clk-mux.c        |  2 +-
>  drivers/clk/clk-uclass.c     | 20 ++++++++++++++++++++
>  drivers/clk/clk.c            |  9 +++++++++
>  include/clk.h                |  9 +++++++++
>  include/linux/clk-provider.h |  1 +
>  6 files changed, 41 insertions(+), 1 deletion(-)
> ---
> V1->V2:
>         Fix missing include
> ---
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index cfd90b717e7..c86083ac5a3 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -116,6 +116,7 @@ const struct clk_ops clk_gate_ops =3D {
>         .enable =3D clk_gate_enable,
>         .disable =3D clk_gate_disable,
>         .get_rate =3D clk_generic_get_rate,
> +       .set_rate =3D clk_generic_set_rate,

I can see that clk_generic_get_rate() already exists here, and adding
clk_generic_set_rate() tries to mimic that existing design. But
frankly, I'm not sure it was a very good design choice in the first
place. I mean, to have get/set rate operations for the clock types
that clearly don't have such ability. I think it would be better to
model the CCF clocks after real world clocks, and handle the
propagation on the clock logic level. In fact, that's how it's already
implemented in Linux kernel [1]. That keeps the particular clock
implementations simple and brings the propagation logic to the actual
clk API (clk_set_rate()), which in turn is able to cover all possible
cases: even if some new clock types are implemented later, they will
be covered already. That also reduces some code duplication and makes
it easier to control that behavior in a centralized manner. The patch
with the discussed implementation was already submitted a while ago
[2], and still pending on the review.

Can I ask you if patch [2] doesn't cover some of your cases? Or maybe
I'm missing something out and having .set_rate op in gate/mux would
actually be better for some particular reason?

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/clk-gate.c#n120
[2] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html


>  };
>
>  struct clk *clk_register_gate(struct device *dev, const char *name,
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index e3481be95fa..f99a67ebd35 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -151,13 +151,13 @@ static int clk_mux_set_parent(struct clk *clk, stru=
ct clk *parent)
>  #else
>         writel(reg, mux->reg);
>  #endif
> -
>         return 0;
>  }
>
>  const struct clk_ops clk_mux_ops =3D {
>         .get_rate =3D clk_generic_get_rate,
>         .set_parent =3D clk_mux_set_parent,
> +       .set_rate =3D clk_generic_set_rate,
>  };
>
>  struct clk *clk_hw_register_mux_table(struct device *dev, const char *na=
me,
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc484..638864e6774 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -517,6 +517,26 @@ ulong clk_get_parent_rate(struct clk *clk)
>         return pclk->rate;
>  }
>
> +ulong clk_set_parent_rate(struct clk *clk, ulong rate)
> +{
> +       const struct clk_ops *ops;
> +       struct clk *pclk;
> +
> +       debug("%s(clk=3D%p)\n", __func__, clk);
> +       if (!clk_valid(clk))
> +               return 0;
> +
> +       pclk =3D clk_get_parent(clk);
> +       if (IS_ERR(pclk))
> +               return -ENODEV;
> +
> +       ops =3D clk_dev_ops(pclk->dev);
> +       if (!ops->set_rate)
> +               return -ENOSYS;
> +
> +       return clk_set_rate(pclk, rate);
> +}
> +
>  ulong clk_round_rate(struct clk *clk, ulong rate)
>  {
>         const struct clk_ops *ops;
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 6ede1b4d4dc..febd5314df2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -14,6 +14,7 @@
>  #include <dm/uclass.h>
>  #include <dm/lists.h>
>  #include <dm/device-internal.h>
> +#include <linux/clk-provider.h>
>
>  int clk_register(struct clk *clk, const char *drv_name,
>                  const char *name, const char *parent_name)
> @@ -61,6 +62,14 @@ ulong clk_generic_get_rate(struct clk *clk)
>         return clk_get_parent_rate(clk);
>  }
>
> +ulong clk_generic_set_rate(struct clk *clk, ulong rate)
> +{
> +       if (clk->flags & CLK_SET_RATE_PARENT)
> +               return clk_set_parent_rate(clk, rate);
> +
> +       return clk_get_parent_rate(clk);
> +}
> +
>  const char *clk_hw_get_name(const struct clk *hw)
>  {
>         assert(hw);
> diff --git a/include/clk.h b/include/clk.h
> index af23e4f3475..1900377eddb 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -452,6 +452,15 @@ struct clk *clk_get_parent(struct clk *clk);
>   */
>  ulong clk_get_parent_rate(struct clk *clk);
>
> +/**
> + * clk_set_parent_rate() - Set parent of current clock rate.
> + * @clk:       A clock struct that was previously successfully requested=
 by
> + *             clk_request/get_by_*().
> + *
> + * Return: clock rate in Hz, or -ve error code.
> + */
> +ulong clk_set_parent_rate(struct clk *clk, ulong rate);
> +
>  /**
>   * clk_round_rate() - Adjust a rate to the exact rate a clock can provid=
e
>   * @clk: A clock struct that was previously successfully requested by
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 59f9c241b84..459fa2d15ce 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -253,6 +253,7 @@ struct clk *clk_register_fixed_rate(struct device *de=
v, const char *name,
>
>  const char *clk_hw_get_name(const struct clk *hw);
>  ulong clk_generic_get_rate(struct clk *clk);
> +ulong clk_generic_set_rate(struct clk *clk, ulong rate);
>
>  struct clk *dev_get_clk_ptr(struct udevice *dev);
>
> --
> 2.43.0
>
