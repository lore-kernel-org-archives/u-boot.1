Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECE4C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A832C81FEE;
	Wed,  4 Jun 2025 08:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HdJkZBrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AEF82103; Wed,  4 Jun 2025 08:14:55 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACE781F0D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3127cc662e2so633365a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749017690; x=1749622490;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4sthzf6uV2fhd3fICjbxlvf7+vZQtAbYItjc5XE1E/8=;
 b=HdJkZBrQgpRhSp3PFWlT36fx7rlAeKwscqHdPlyYAlU1HcO9joW2k7SlItqDwWzMv1
 BvyHAiD4bcwsqLnb+VgA/ObawUnX0sesODsI7HAktggxO7cDIsF+TCE+VjKDQwn3upvp
 BXEZLYJKvy3hsqZa/JASe4+PcuxRyJNoqNDOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749017690; x=1749622490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sthzf6uV2fhd3fICjbxlvf7+vZQtAbYItjc5XE1E/8=;
 b=TH7rFlcyA1ZKpFW+wBtetbfCRT5k8drOf4Hj/TQtiQi9M15plzEokOe9fCttVBPujs
 IS6dhn5PMkRfB8pwMOpn+pg0v99XEobr1hoTO7l5H+sBNsxDxmz2moYrmWidw5B2wFg2
 nWfkKCuvt4q+FWJR36h4RcSXJ5I2JWvKs/ijEtWnwuGaAAzlRwD8ZBvNnwYiQEWEA5os
 otaxHj7dx1h/P1UGn5DVX9F76GxRj2DsIN/g5pWrzbCcnMCxBNDEqmi1QGSqF7g0Bo3d
 IAkSdkXa469NeQCZYUVqPTSEcNvY2k0RLTG1ZXyHQ8+NkWLtKsG40yxFpHgg2JNwW4bG
 Urmw==
X-Gm-Message-State: AOJu0YyrZBmpvAuR+H0kxwDMUxQUXWIQXARJ7Si/G72zEf54aEOnBcqE
 WPc2llRT6o7XiJxcQULvaaGZDBX+JM9IY7U8jBMlf70WfUHRpfaXR4KzBwTRrgRRR5NbQUleBzO
 dc0HPHg81miKZjL1Xo/356W8vnyqtcgipynkcS6Nttw==
X-Gm-Gg: ASbGncsYjbHg2x2RR8m3/bqIgSmcjlGgOuVpGlfbOOtwdrGes0gTj41BVeqS4/LXrnU
 CLHhlkORoSzwBTgO3MPiYuf1Zn06HUrSDvzqstQzmPNnmqJ5sfGryZCNf1Bq8M94sTafa8d9iKJ
 3IKDAHhsLUUn2I3V+5F0TI5ult73U/LdsFbXM=
X-Google-Smtp-Source: AGHT+IFn9wxNZKaUAm3pU2sjn4r7I2E78k1w5GgMU5RNTqHSBkDR04e6G2bQIEQWCpu5iRE6+HV+WiB7FsRgeor6FK0=
X-Received: by 2002:a17:90b:5585:b0:310:c8ec:4192 with SMTP id
 98e67ed59e1d1-312e7eed903mr7823863a91.10.1749017690068; Tue, 03 Jun 2025
 23:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-5-patrice.chotard@foss.st.com>
 <156e1773-fa76-4b22-80e7-cf26cb7bf7b3@foss.st.com>
In-Reply-To: <156e1773-fa76-4b22-80e7-cf26cb7bf7b3@foss.st.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 4 Jun 2025 08:14:38 +0200
X-Gm-Features: AX0GCFs9yM5gG8JymYP41Bm7LJS9ERbLVGZ7EKQPtwHjL19pQT45rcOhAz-_s1A
Message-ID: <CAOf5uwmNz3JRoEoEVxMYk1Mb5PnYEMSWKbbh=kMXp=tqufPB2g@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] clk: add CONFIG_CLK_AUTO_ID
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>, 
 Marek Vasut <marex@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi

On Wed, Jun 4, 2025 at 8:02=E2=80=AFAM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 5/27/25 15:27, Patrice Chotard wrote:
> > From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >
> > Add a new config CONFIG_CLK_AUTO_ID to support a unique clk id
> > for all the clock providers, managed by clk uclass, when the clock
> > reference arg[0] is the same.
> >
> > When the CONFIG is activated, the clock id is limited to the lower
> > CLK_ID_SZ =3D 24 bits in default clock xlate function
> > and the sequence number + 1 of the clk provider device is
> > added for the 8 higher bits.
> >
> > We use sequence number + 1 to avoid the "dummy" clock id =3D 0,
> > used for invalid clock when CCF is activated.
> >
> > When this config is activated, the new function clk_get_id()
> > should be used to get back the internal reference to clock
> > for the each clock provider.
> >
> > Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Lukasz Majewski <lukma@denx.de>
> > Cc: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/clk/Kconfig                | 10 ++++++++++
> >  drivers/clk/clk-uclass.c           |  9 +++++++--
> >  drivers/clk/stm32/clk-stm32-core.c |  3 ++-
> >  include/clk.h                      | 24 ++++++++++++++++++++++++
> >  include/linux/clk-provider.h       |  9 ++++++++-
> >  5 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 18bd640a68b..b2e53fe325e 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -10,6 +10,16 @@ config CLK
> >         feed into other clocks in a tree structure, with multiplexers t=
o
> >         choose the source for each clock.
> >
> > +config CLK_AUTO_ID
> > +     bool "Enable support of an unique clock id with several provider"
> > +     depends on CLK
> > +     help
> > +       Add the uclass sequence number of clock provider in the 8 highe=
r bits
> > +       of the clk id to guaranty an unique clock identifier in clk ucl=
ass
> > +       when several clock providers are present on the device and when
> > +       default xlate are used.
> > +       This feature limit each identifier for each clock providers (24=
 bits).
> > +
> >  config SPL_CLK
> >       bool "Enable clock support in SPL"
> >       depends on CLK && SPL && SPL_DM
> > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > index 2167cd5ad0f..7262e89b512 100644
> > --- a/drivers/clk/clk-uclass.c
> > +++ b/drivers/clk/clk-uclass.c
> > @@ -34,6 +34,11 @@ struct clk *dev_get_clk_ptr(struct udevice *dev)
> >       return (struct clk *)dev_get_uclass_priv(dev);
> >  }
> >
> > +ulong clk_get_id(const struct clk *clk)
> > +{
> > +     return (ulong)(clk->id & CLK_ID_MSK);
> > +}
> > +
> >  #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >  int clk_get_by_phandle(struct udevice *dev, const struct phandle_1_arg=
 *cells,
> >                      struct clk *clk)
> > @@ -43,7 +48,7 @@ int clk_get_by_phandle(struct udevice *dev, const str=
uct phandle_1_arg *cells,
> >       ret =3D device_get_by_ofplat_idx(cells->idx, &clk->dev);
> >       if (ret)
> >               return ret;
> > -     clk->id =3D cells->arg[0];
> > +     clk->id =3D CLK_ID(dev, cells->arg[0]);
> >
> >       return 0;
> >  }
> > @@ -61,7 +66,7 @@ static int clk_of_xlate_default(struct clk *clk,
> >       }
> >
> >       if (args->args_count)
> > -             clk->id =3D args->args[0];
> > +             clk->id =3D CLK_ID(clk->dev, args->args[0]);
> >       else
> >               clk->id =3D 0;
> >
> > diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk=
-stm32-core.c
> > index 358ee56682a..df3b35b1003 100644
> > --- a/drivers/clk/stm32/clk-stm32-core.c
> > +++ b/drivers/clk/stm32/clk-stm32-core.c
> > @@ -46,7 +46,8 @@ int stm32_rcc_init(struct udevice *dev,
> >
> >               if (cfg->setup) {
> >                       clk =3D cfg->setup(dev, cfg);
> > -                     clk->id =3D cfg->id;
> > +                     /* set identifier of clock provider*/
> > +                     dev_clk_dm(dev, cfg->id, clk);
> >               } else {
> >                       dev_err(dev, "failed to register clock %s\n", cfg=
->name);
> >                       return -ENOENT;
> > diff --git a/include/clk.h b/include/clk.h
> > index a6ef4e02692..f94135ff778 100644
> > --- a/include/clk.h
> > +++ b/include/clk.h
> > @@ -13,6 +13,15 @@
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> >
> > +#ifdef CONFIG_CLK_AUTO_ID
> > +#define CLK_ID_SZ    24
> > +#define CLK_ID_MSK   GENMASK(23, 0)
> > +#define CLK_ID(dev, id)      (((dev_seq(dev) + 1) << CLK_ID_SZ) | ((id=
) & CLK_ID_MSK))
> > +#else
> > +#define CLK_ID_MSK   (~0UL)
> > +#define CLK_ID(dev, id)      id
> > +#endif
> > +
> >  /**
> >   * DOC: Overview
> >   *
> > @@ -570,6 +579,16 @@ int clk_get_by_id(ulong id, struct clk **clkp);
> >   */
> >  bool clk_dev_binded(struct clk *clk);
> >
> > +/**
> > + * clk_get_id - get clk id
> > + *
> > + * @clk:     A clock struct
> > + *
> > + * Return: the clock identifier as it is defined by the clock provider=
 in
> > + * device tree or in platdata
> > + */
> > +ulong clk_get_id(const struct clk *clk);
> > +
> >  #else /* CONFIG_IS_ENABLED(CLK) */
> >
> >  static inline int clk_request(struct udevice *dev, struct clk *clk)
> > @@ -641,6 +660,11 @@ static inline bool clk_dev_binded(struct clk *clk)
> >  {
> >       return false;
> >  }
> > +
> > +static inline ulong clk_get_id(const struct clk *clk)
> > +{
> > +     return 0;
> > +}
> >  #endif /* CONFIG_IS_ENABLED(CLK) */
> >
> >  /**
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.=
h
> > index 267757939e0..2d754fa4287 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -15,10 +15,17 @@
> >
> >  struct udevice;
> >
> > +/* update clock ID for the dev =3D clock provider, compatible with CLK=
_AUTO_ID */
> > +static inline void dev_clk_dm(const struct udevice *dev, ulong id, str=
uct clk *clk)
> > +{
> > +     if (!IS_ERR(clk))
> > +             clk->id =3D CLK_ID(dev, id);
> > +}
> > +
> >  static inline void clk_dm(ulong id, struct clk *clk)
> >  {
> >       if (!IS_ERR(clk))
> > -             clk->id =3D id;
> > +             clk->id =3D CLK_ID(clk->dev, id);
> >  }
> >
> >  /*
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>

I think you should ask to be picked by Tom. I don't have objection on this =
patch

Michael

> Thanks
> Patrice



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
