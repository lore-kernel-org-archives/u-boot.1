Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FA7C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD9B82B07;
	Wed,  4 Jun 2025 08:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HZjidQrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B990D82BD9; Wed,  4 Jun 2025 08:50:35 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2A182103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-312b0d83a10so2565146a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749019831; x=1749624631;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEzhklvbmmNLKlGfAIXyq569jonJx8S/LCvR3PIEW1E=;
 b=HZjidQrg/n69J+MAFUUhcUtgSM7rhjapzvnmzmKZyVr7wAybY2tis63sNf6SfxGQhP
 DIeLtGVs63AlUUl65QAMPw1sVi2b3sqWi3SwASBxO+8GooptJ1aostySARBaWFhTZBSz
 nobpbYMxFlTbpg5pL8huEYpL/SHYwi5ljVq+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749019831; x=1749624631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEzhklvbmmNLKlGfAIXyq569jonJx8S/LCvR3PIEW1E=;
 b=Hakj9qiGEQHAypw3q2Z5ZMHfstEJOdWUYkiiLDPZ5TtyA8pspUJeCi5NV+9h0Ffked
 GMHeBXcIJjuQS2mzAGZ+wY0Ini2rrOHE08ORyjalFTwwXDbYAuBX7v1atp0+B9xnwfbm
 QeAgh8sRgGD+FZZGUxoDb1kqLMnv1lWe1RRkPO5z9w2CICRVD1wO/di+49bXtR1UXJgc
 ahav31zFshqay2TYABqqnq79wq83AoWRPhY3LVaEsYTQjLwjFfq+jKRc6QpKiSS8wpfT
 13XxYd1rt0VYS2q42PiamzI6rbNesYB/6djzAvLCGVEvUo4xyvyPwMfFTlzuc52lpe7x
 mIWw==
X-Gm-Message-State: AOJu0YwOvPj91zupsVxvugcV4cQnkqMbCf2ocz8EYgzRJOb7S95X+81A
 RKx7e5/Z1fU3qSfvnVd2W57Q3xGNjuEcPKpCYWjA6ji6f+gHKavfC3jMUN60ZSOO3A8+b3fPOiv
 SULX4k3JNJMlu5wQK3DsAZ/MjT5jkb6ZLM8+EkTJOfw==
X-Gm-Gg: ASbGncsjCGptBee+GwUKbGjk8IDTu1iek0cmgije7V4rGUIAjmMGwko+CvjTBK4vl9H
 4Hb50JCC0Ag4eLdTo4Yl9COVpTUur9Zp/wIj3p/YsjKplaAmpGZBeIFQPkWDvcAOC6rKzi7CAHc
 nCZM65TbepTViwlm+svBHg5I8clGW2/kFceEAYDRyY3dMYPA==
X-Google-Smtp-Source: AGHT+IEekhB6DR94/asztc6rQO/50HhPjTykAUBNu/q9tx/JiKseFq+Wj43yHFstA8zSraNKYR87QKR7QJdjr8F8qFo=
X-Received: by 2002:a17:90b:4d:b0:311:ea13:2e6e with SMTP id
 98e67ed59e1d1-3130cd4d77dmr2776215a91.28.1749019831341; Tue, 03 Jun 2025
 23:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-5-patrice.chotard@foss.st.com>
 <156e1773-fa76-4b22-80e7-cf26cb7bf7b3@foss.st.com>
 <CAOf5uwmNz3JRoEoEVxMYk1Mb5PnYEMSWKbbh=kMXp=tqufPB2g@mail.gmail.com>
 <05a41190-87a4-4d32-b3d9-44e3101ea858@foss.st.com>
 <CAOf5uwkpj9HA+nhiOTPFz8WTGihyiVgZoCfZDKyCPu68zrRe9A@mail.gmail.com>
In-Reply-To: <CAOf5uwkpj9HA+nhiOTPFz8WTGihyiVgZoCfZDKyCPu68zrRe9A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 4 Jun 2025 08:50:19 +0200
X-Gm-Features: AX0GCFvyxyp1-FHxXOh-1dzYtZo5BvWyZpQwbGp2ucCWbjLbc5fRWZwIf4-3SHw
Message-ID: <CAOf5uwn0VBV_swPt=JVJEazWrLh6hzhXDn8P2RSN34dmuu_aNA@mail.gmail.com>
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

On Wed, Jun 4, 2025 at 8:48=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Patrice
>
> On Wed, Jun 4, 2025 at 8:46=E2=80=AFAM Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
> >
> >
> >
> > On 6/4/25 08:14, Michael Nazzareno Trimarchi wrote:
> > > Hi
> > >
> > > On Wed, Jun 4, 2025 at 8:02=E2=80=AFAM Patrice CHOTARD
> > > <patrice.chotard@foss.st.com> wrote:
> > >>
> > >>
> > >>
> > >> On 5/27/25 15:27, Patrice Chotard wrote:
> > >>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > >>>
> > >>> Add a new config CONFIG_CLK_AUTO_ID to support a unique clk id
> > >>> for all the clock providers, managed by clk uclass, when the clock
> > >>> reference arg[0] is the same.
> > >>>
> > >>> When the CONFIG is activated, the clock id is limited to the lower
> > >>> CLK_ID_SZ =3D 24 bits in default clock xlate function
> > >>> and the sequence number + 1 of the clk provider device is
> > >>> added for the 8 higher bits.
> > >>>
> > >>> We use sequence number + 1 to avoid the "dummy" clock id =3D 0,
> > >>> used for invalid clock when CCF is activated.
> > >>>
> > >>> When this config is activated, the new function clk_get_id()
> > >>> should be used to get back the internal reference to clock
> > >>> for the each clock provider.
> > >>>
> > >>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > >>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > >>> Cc: Lukasz Majewski <lukma@denx.de>
> > >>> Cc: Sean Anderson <seanga2@gmail.com>
> > >>> ---
> > >>>
> > >>> (no changes since v1)
> > >>>
> > >>>  drivers/clk/Kconfig                | 10 ++++++++++
> > >>>  drivers/clk/clk-uclass.c           |  9 +++++++--
> > >>>  drivers/clk/stm32/clk-stm32-core.c |  3 ++-
> > >>>  include/clk.h                      | 24 ++++++++++++++++++++++++
> > >>>  include/linux/clk-provider.h       |  9 ++++++++-
> > >>>  5 files changed, 51 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > >>> index 18bd640a68b..b2e53fe325e 100644
> > >>> --- a/drivers/clk/Kconfig
> > >>> +++ b/drivers/clk/Kconfig
> > >>> @@ -10,6 +10,16 @@ config CLK
> > >>>         feed into other clocks in a tree structure, with multiplexe=
rs to
> > >>>         choose the source for each clock.
> > >>>
> > >>> +config CLK_AUTO_ID
> > >>> +     bool "Enable support of an unique clock id with several provi=
der"
> > >>> +     depends on CLK
> > >>> +     help
> > >>> +       Add the uclass sequence number of clock provider in the 8 h=
igher bits
> > >>> +       of the clk id to guaranty an unique clock identifier in clk=
 uclass
> > >>> +       when several clock providers are present on the device and =
when
> > >>> +       default xlate are used.
> > >>> +       This feature limit each identifier for each clock providers=
 (24 bits).
> > >>> +
> > >>>  config SPL_CLK
> > >>>       bool "Enable clock support in SPL"
> > >>>       depends on CLK && SPL && SPL_DM
> > >>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > >>> index 2167cd5ad0f..7262e89b512 100644
> > >>> --- a/drivers/clk/clk-uclass.c
> > >>> +++ b/drivers/clk/clk-uclass.c
> > >>> @@ -34,6 +34,11 @@ struct clk *dev_get_clk_ptr(struct udevice *dev)
> > >>>       return (struct clk *)dev_get_uclass_priv(dev);
> > >>>  }
> > >>>
> > >>> +ulong clk_get_id(const struct clk *clk)
> > >>> +{
> > >>> +     return (ulong)(clk->id & CLK_ID_MSK);
> > >>> +}
> > >>> +
> > >>>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
> > >>>  int clk_get_by_phandle(struct udevice *dev, const struct phandle_1=
_arg *cells,
> > >>>                      struct clk *clk)
> > >>> @@ -43,7 +48,7 @@ int clk_get_by_phandle(struct udevice *dev, const=
 struct phandle_1_arg *cells,
> > >>>       ret =3D device_get_by_ofplat_idx(cells->idx, &clk->dev);
> > >>>       if (ret)
> > >>>               return ret;
> > >>> -     clk->id =3D cells->arg[0];
> > >>> +     clk->id =3D CLK_ID(dev, cells->arg[0]);
> > >>>
> > >>>       return 0;
> > >>>  }
> > >>> @@ -61,7 +66,7 @@ static int clk_of_xlate_default(struct clk *clk,
> > >>>       }
> > >>>
> > >>>       if (args->args_count)
> > >>> -             clk->id =3D args->args[0];
> > >>> +             clk->id =3D CLK_ID(clk->dev, args->args[0]);
> > >>>       else
> > >>>               clk->id =3D 0;
> > >>>
> > >>> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32=
/clk-stm32-core.c
> > >>> index 358ee56682a..df3b35b1003 100644
> > >>> --- a/drivers/clk/stm32/clk-stm32-core.c
> > >>> +++ b/drivers/clk/stm32/clk-stm32-core.c
> > >>> @@ -46,7 +46,8 @@ int stm32_rcc_init(struct udevice *dev,
> > >>>
> > >>>               if (cfg->setup) {
> > >>>                       clk =3D cfg->setup(dev, cfg);
> > >>> -                     clk->id =3D cfg->id;
> > >>> +                     /* set identifier of clock provider*/
> > >>> +                     dev_clk_dm(dev, cfg->id, clk);
> > >>>               } else {
> > >>>                       dev_err(dev, "failed to register clock %s\n",=
 cfg->name);
> > >>>                       return -ENOENT;
> > >>> diff --git a/include/clk.h b/include/clk.h
> > >>> index a6ef4e02692..f94135ff778 100644
> > >>> --- a/include/clk.h
> > >>> +++ b/include/clk.h
> > >>> @@ -13,6 +13,15 @@
> > >>>  #include <linux/errno.h>
> > >>>  #include <linux/types.h>
> > >>>
> > >>> +#ifdef CONFIG_CLK_AUTO_ID
> > >>> +#define CLK_ID_SZ    24
> > >>> +#define CLK_ID_MSK   GENMASK(23, 0)
> > >>> +#define CLK_ID(dev, id)      (((dev_seq(dev) + 1) << CLK_ID_SZ) | =
((id) & CLK_ID_MSK))
> > >>> +#else
> > >>> +#define CLK_ID_MSK   (~0UL)
> > >>> +#define CLK_ID(dev, id)      id
> > >>> +#endif
> > >>> +
> > >>>  /**
> > >>>   * DOC: Overview
> > >>>   *
> > >>> @@ -570,6 +579,16 @@ int clk_get_by_id(ulong id, struct clk **clkp)=
;
> > >>>   */
> > >>>  bool clk_dev_binded(struct clk *clk);
> > >>>
> > >>> +/**
> > >>> + * clk_get_id - get clk id
> > >>> + *
> > >>> + * @clk:     A clock struct
> > >>> + *
> > >>> + * Return: the clock identifier as it is defined by the clock prov=
ider in
> > >>> + * device tree or in platdata
> > >>> + */
> > >>> +ulong clk_get_id(const struct clk *clk);
> > >>> +
> > >>>  #else /* CONFIG_IS_ENABLED(CLK) */
> > >>>
> > >>>  static inline int clk_request(struct udevice *dev, struct clk *clk=
)
> > >>> @@ -641,6 +660,11 @@ static inline bool clk_dev_binded(struct clk *=
clk)
> > >>>  {
> > >>>       return false;
> > >>>  }
> > >>> +
> > >>> +static inline ulong clk_get_id(const struct clk *clk)
> > >>> +{
> > >>> +     return 0;
> > >>> +}
> > >>>  #endif /* CONFIG_IS_ENABLED(CLK) */
> > >>>
> > >>>  /**
> > >>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provi=
der.h
> > >>> index 267757939e0..2d754fa4287 100644
> > >>> --- a/include/linux/clk-provider.h
> > >>> +++ b/include/linux/clk-provider.h
> > >>> @@ -15,10 +15,17 @@
> > >>>
> > >>>  struct udevice;
> > >>>
> > >>> +/* update clock ID for the dev =3D clock provider, compatible with=
 CLK_AUTO_ID */
> > >>> +static inline void dev_clk_dm(const struct udevice *dev, ulong id,=
 struct clk *clk)
> > >>> +{
> > >>> +     if (!IS_ERR(clk))
> > >>> +             clk->id =3D CLK_ID(dev, id);
> > >>> +}
> > >>> +
> > >>>  static inline void clk_dm(ulong id, struct clk *clk)
> > >>>  {
> > >>>       if (!IS_ERR(clk))
> > >>> -             clk->id =3D id;
> > >>> +             clk->id =3D CLK_ID(clk->dev, id);
> > >>>  }
> > >>>
> > >>>  /*
> > >> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > >>
> > >
> > > I think you should ask to be picked by Tom. I don't have objection on=
 this patch
> > >
> > > Michael
> >
> > Hi Michael
> >
> > For which reason ?
> > For information, this series has been submitted to CI test : https://so=
urce.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26358
> > without any issue.
>
> Because I haven't seen activity on the clock maintainer for months.
>

I think you misread it (or my english was really bad). Anyway I'm fine
with this change

Michael


> Michael
>
>
> >
> > Thanks
> > Patrice
> >
> > >
> > >> Thanks
> > >> Patrice
> > >
> > >
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
