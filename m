Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D470C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7588883E;
	Wed, 24 Jul 2024 11:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H2v/BXru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1008888C1; Wed, 24 Jul 2024 11:44:50 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363168883E
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a79a7d1a0dbso201650266b.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721814287; x=1722419087;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX8dIKm2xif95PPt8pFkD1rTo+mG0+20QfbHWygzPsQ=;
 b=H2v/BXruYibX7A9fcZRRDwrFvlFGBG6ewGC0/ekt1yYsPV4jrpYqPo2Ap9ykMU+x1n
 1B7VGt/RvDn/DRMeq/O4563GnttkwMEhdpFKEZE65lSJzUt0Xw7UEVovPwYjX7r1bH5I
 SKXGdPyDWU3pQXYQqWgeo3x6bOqbwyO0MDtSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814287; x=1722419087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CX8dIKm2xif95PPt8pFkD1rTo+mG0+20QfbHWygzPsQ=;
 b=Td+g4kYvcYbFy0xMlr1a3tJr0/2IsUcPizvoB3xC2TvLoQg7iVQLr/oZ6l36BS0G03
 SkziVlKgT2K63FIEvdJYd2gwzF69eROImB8sfkzvmvgZroe7yBGBgck+1oiwY+awVerG
 by1vnywcm7F6KqeWYozRxZvVWGaGvfY8fa+MG3fKT3uV2/EQ7TFxFElakBvwX1y6DKqt
 iOcIfS7fcLJv0RO+sSO6baUO2bQmE4wf5Bj3dfXsQ6gHw8VMHUd73cq/oYpuZvW7txE3
 Dav2PO6q2liu+8O9gwtlTtQt4J4W+iSsBRKcKmzJ/2wRDh7QihK/5K/G0zssEDvMVq3e
 bK5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOXWdLu8WICncGNE44xhk6dO/IajHXP8hYEDZYzULeso0UHtBqu4n2urPO3G/V/xgofJBAOZQmRYKziTqm2QFHnxC//A==
X-Gm-Message-State: AOJu0YznIotdfI3AjzeTnj2zmYaHNjdeZP5xd2Ib+/aYdCzQ7GyQ2bSX
 PG5Shho1VkOmA+byVnfROLyQ466hunjjhk+COIxODdt1iT9HGOdHD4fo2SGAAw3sqkJwrFrnRxI
 J8VFKVsvrY7KCHVxJOVuVinYj7UmqJJgn9sziCw==
X-Google-Smtp-Source: AGHT+IFkXRzvTt/UOfegbZihkTl0OO9HZ9QWuMPUt/cFAY5fxdHlHw2vzuEH+KE0Dr6lXumvsz664iOfu1BkHtiLOwA=
X-Received: by 2002:a17:907:7d86:b0:a77:cca9:b216 with SMTP id
 a640c23a62f3a-a7aabb420a4mr141043766b.33.1721814287469; Wed, 24 Jul 2024
 02:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240705071419.11521-1-michael@amarulasolutions.com>
 <CAPLW+4n0j+5Sz7jrAVZx068Vxy2GQVFBCcA0ovsPL-ip0R0WLw@mail.gmail.com>
 <CAOf5uwk8xjgsrVysDgEeOsr6uR5u=LYP3N2s67eBf5eqqtS_MQ@mail.gmail.com>
In-Reply-To: <CAOf5uwk8xjgsrVysDgEeOsr6uR5u=LYP3N2s67eBf5eqqtS_MQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 24 Jul 2024 11:44:35 +0200
Message-ID: <CAOf5uw=5QVsWe0thmTPjUyKFTKo98YsQZosTm0803hVGhZRZmw@mail.gmail.com>
Subject: Re: [PATCH V2] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present for gate and mux
To: Sam Protsenko <semen.protsenko@linaro.org>
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

Hi Sam

On Wed, Jul 24, 2024 at 9:25=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Sam
>
> On Tue, Jul 23, 2024 at 10:37=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Fri, Jul 5, 2024 at 2:14=E2=80=AFAM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Gate and mux does not have .set_rate operation, but they could have
> > > CLK_SET_PARENT_RATE flag set. In that case it's usually possible to f=
ind a
> > > parent up the tree which is capable of setting the rate (div, pll, et=
c).
> > > Add clk_generic_set_rate to allow them to trasverse the clock tree.
> > >
> > > Cc: Sam Protsenko <semen.protsenko@linaro.org>
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >  drivers/clk/clk-gate.c       |  1 +
> > >  drivers/clk/clk-mux.c        |  2 +-
> > >  drivers/clk/clk-uclass.c     | 20 ++++++++++++++++++++
> > >  drivers/clk/clk.c            |  9 +++++++++
> > >  include/clk.h                |  9 +++++++++
> > >  include/linux/clk-provider.h |  1 +
> > >  6 files changed, 41 insertions(+), 1 deletion(-)
> > > ---
> > > V1->V2:
> > >         Fix missing include
> > > ---
> > > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > > index cfd90b717e7..c86083ac5a3 100644
> > > --- a/drivers/clk/clk-gate.c
> > > +++ b/drivers/clk/clk-gate.c
> > > @@ -116,6 +116,7 @@ const struct clk_ops clk_gate_ops =3D {
> > >         .enable =3D clk_gate_enable,
> > >         .disable =3D clk_gate_disable,
> > >         .get_rate =3D clk_generic_get_rate,
> > > +       .set_rate =3D clk_generic_set_rate,
> >
> > I can see that clk_generic_get_rate() already exists here, and adding
> > clk_generic_set_rate() tries to mimic that existing design. But
> > frankly, I'm not sure it was a very good design choice in the first
> > place. I mean, to have get/set rate operations for the clock types
> > that clearly don't have such ability. I think it would be better to
> > model the CCF clocks after real world clocks, and handle the
> > propagation on the clock logic level. In fact, that's how it's already
> > implemented in Linux kernel [1]. That keeps the particular clock
>
> Ok , so you suggest to have something like in the core
>
> if (p->set_rate)
> {
>      set_rate())
>
> }
> else
> {
>     set_generic_rate()
> }
>

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 8faf5a56e1..a309108dd4 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -467,8 +467,14 @@ ulong clk_get_rate(struct clk *clk)
                return 0;
        ops =3D clk_dev_ops(clk->dev);

-       if (!ops->get_rate)
-               return -ENOSYS;
+       if (!ops->get_rate) {
+               parent =3D clk_get_parent(clk);
+               if (!clk_is_valid(parent))
+                       return -ENOSYS;
+               ops =3D clk_dev_ops(parent->dev);
+               if (!ops->get_rate)
+                       return -ENOSYS;
+       }

        return ops->get_rate(clk);
 }

You suggest to remove get_rate, set_rate function in mux and gate and
use some propagation in the core, am I right?


Michael
> The same for get_rate()
>
> > implementations simple and brings the propagation logic to the actual
> > clk API (clk_set_rate()), which in turn is able to cover all possible
> > cases: even if some new clock types are implemented later, they will
> > be covered already. That also reduces some code duplication and makes
> > it easier to control that behavior in a centralized manner. The patch
> > with the discussed implementation was already submitted a while ago
> > [2], and still pending on the review.
>
> I have seen it and because I'm extending the clk framework a bit more [1]
> I was thinking about a more complete approach. Nothing against your
> patch, but just
> I have observed in my use case (display) that I need more from the
> clock framework we have
>
> Michael
>
> [1] https://patchwork.amarulasolutions.com/patch/3291/
>
> >
> > Can I ask you if patch [2] doesn't cover some of your cases? Or maybe
> > I'm missing something out and having .set_rate op in gate/mux would
> > actually be better for some particular reason?
> >
> > Thanks!
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/clk/clk-gate.c#n120
> > [2] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html
> >
> >
> > >  };
> > >
> > >  struct clk *clk_register_gate(struct device *dev, const char *name,
> > > diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> > > index e3481be95fa..f99a67ebd35 100644
> > > --- a/drivers/clk/clk-mux.c
> > > +++ b/drivers/clk/clk-mux.c
> > > @@ -151,13 +151,13 @@ static int clk_mux_set_parent(struct clk *clk, =
struct clk *parent)
> > >  #else
> > >         writel(reg, mux->reg);
> > >  #endif
> > > -
> > >         return 0;
> > >  }
> > >
> > >  const struct clk_ops clk_mux_ops =3D {
> > >         .get_rate =3D clk_generic_get_rate,
> > >         .set_parent =3D clk_mux_set_parent,
> > > +       .set_rate =3D clk_generic_set_rate,
> > >  };
> > >
> > >  struct clk *clk_hw_register_mux_table(struct device *dev, const char=
 *name,
> > > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > > index ed6e60bc484..638864e6774 100644
> > > --- a/drivers/clk/clk-uclass.c
> > > +++ b/drivers/clk/clk-uclass.c
> > > @@ -517,6 +517,26 @@ ulong clk_get_parent_rate(struct clk *clk)
> > >         return pclk->rate;
> > >  }
> > >
> > > +ulong clk_set_parent_rate(struct clk *clk, ulong rate)
> > > +{
> > > +       const struct clk_ops *ops;
> > > +       struct clk *pclk;
> > > +
> > > +       debug("%s(clk=3D%p)\n", __func__, clk);
> > > +       if (!clk_valid(clk))
> > > +               return 0;
> > > +
> > > +       pclk =3D clk_get_parent(clk);
> > > +       if (IS_ERR(pclk))
> > > +               return -ENODEV;
> > > +
> > > +       ops =3D clk_dev_ops(pclk->dev);
> > > +       if (!ops->set_rate)
> > > +               return -ENOSYS;
> > > +
> > > +       return clk_set_rate(pclk, rate);
> > > +}
> > > +
> > >  ulong clk_round_rate(struct clk *clk, ulong rate)
> > >  {
> > >         const struct clk_ops *ops;
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 6ede1b4d4dc..febd5314df2 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -14,6 +14,7 @@
> > >  #include <dm/uclass.h>
> > >  #include <dm/lists.h>
> > >  #include <dm/device-internal.h>
> > > +#include <linux/clk-provider.h>
> > >
> > >  int clk_register(struct clk *clk, const char *drv_name,
> > >                  const char *name, const char *parent_name)
> > > @@ -61,6 +62,14 @@ ulong clk_generic_get_rate(struct clk *clk)
> > >         return clk_get_parent_rate(clk);
> > >  }
> > >
> > > +ulong clk_generic_set_rate(struct clk *clk, ulong rate)
> > > +{
> > > +       if (clk->flags & CLK_SET_RATE_PARENT)
> > > +               return clk_set_parent_rate(clk, rate);
> > > +
> > > +       return clk_get_parent_rate(clk);
> > > +}
> > > +
> > >  const char *clk_hw_get_name(const struct clk *hw)
> > >  {
> > >         assert(hw);
> > > diff --git a/include/clk.h b/include/clk.h
> > > index af23e4f3475..1900377eddb 100644
> > > --- a/include/clk.h
> > > +++ b/include/clk.h
> > > @@ -452,6 +452,15 @@ struct clk *clk_get_parent(struct clk *clk);
> > >   */
> > >  ulong clk_get_parent_rate(struct clk *clk);
> > >
> > > +/**
> > > + * clk_set_parent_rate() - Set parent of current clock rate.
> > > + * @clk:       A clock struct that was previously successfully reque=
sted by
> > > + *             clk_request/get_by_*().
> > > + *
> > > + * Return: clock rate in Hz, or -ve error code.
> > > + */
> > > +ulong clk_set_parent_rate(struct clk *clk, ulong rate);
> > > +
> > >  /**
> > >   * clk_round_rate() - Adjust a rate to the exact rate a clock can pr=
ovide
> > >   * @clk: A clock struct that was previously successfully requested b=
y
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> > > index 59f9c241b84..459fa2d15ce 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -253,6 +253,7 @@ struct clk *clk_register_fixed_rate(struct device=
 *dev, const char *name,
> > >
> > >  const char *clk_hw_get_name(const struct clk *hw);
> > >  ulong clk_generic_get_rate(struct clk *clk);
> > > +ulong clk_generic_set_rate(struct clk *clk, ulong rate);
> > >
> > >  struct clk *dev_get_clk_ptr(struct udevice *dev);
> > >
> > > --
> > > 2.43.0
> > >
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
