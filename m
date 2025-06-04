Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58DAC5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F212D82BD9;
	Wed,  4 Jun 2025 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ouwVwvN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C57E82CB9; Wed,  4 Jun 2025 08:49:11 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F4982103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af51596da56so4668822a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749019746; x=1749624546;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7OtPU1rfyoPh5LDAiEhURZmbrlDMOpqfdU9WJhXYgI=;
 b=ouwVwvN+HEo2R89Q2NFj7LHicfb2gWvleqPGGY/ncJXU6MYdRZ41aK3J/hBNISO19m
 pKQBq2nblWc5yOWR3lzTjMREGAOhxAQroUXpuXKEmZdBntplQA8ftUE+yKxZk0QNHop7
 XlRN9TLschbMlomGvV+v6UwkLXIhOqC4wytr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749019746; x=1749624546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7OtPU1rfyoPh5LDAiEhURZmbrlDMOpqfdU9WJhXYgI=;
 b=oWvCXTQOqw7L6BBsAe0LUa3bhzsdIQrLrB3sEWa7caUicgR6Nn5f6P48luXhmueru0
 HFrPS187ZYRDl9phrVQezwqOc38szmNeg5MpS94pL1MFSbRzKMGuuGmIh5tjKFYvclh7
 wBJBMdVgdT24Bgt7d4gicTSzTdGUABTKxjwzkfyGC75fSAOK2RLuNX2y+g/jYAysRNJH
 kBLW5MHR6jXrtc+ncZwjBB3+FfGe6JUAlF/+iDhHykdUUu2yneAgX3Dfee+qe8eIy9ot
 yPofDgLBlhDdmAin12GZrTzyfMGvwvcDspHgmHLQgzBwpdVANoFxW/z/Q2z3J9NtYPoS
 mUuA==
X-Gm-Message-State: AOJu0YzgEcX/Mylvby+I4C0sD1Mtyp0s6GpK6U+rVyzGnEuK3bCUU3/4
 yo5x8iPStnfujf7L5slqbPPVa6ve83etBI/50i5UVmsKbIvfgCS1MOTul1a57KPh1L0HoyR1tAA
 xYKHBX+tE93cET0+CmGeWhNolQ5Ozg/sEXgZ3pEiO6A==
X-Gm-Gg: ASbGncsRBOGPifyOCf5waxnsJRLqKidF0L3274Po0sohulMGHl7W72SM337foE4OBWM
 CKh/9PvvWxzlG7/5I0gF2viSEmVpRglnG6awBJpJJ3trOeDgq145hE09zknW6JbulENC6idJlfL
 ZtfRTdwB9Qid3v0auMpmibKnuWbqwjNf314Z4=
X-Google-Smtp-Source: AGHT+IGrMhkKTjMoLy/Zo7MEp9BdXh84vQr/YdjnQtShADkjSbiuoRvdq+fHQqNvnZ4ajG3yWNapMz/TQ/SOL7yWPLM=
X-Received: by 2002:a17:90b:3fc7:b0:311:b3e7:fb31 with SMTP id
 98e67ed59e1d1-3130cc284d3mr3188627a91.0.1749019745750; Tue, 03 Jun 2025
 23:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-5-patrice.chotard@foss.st.com>
 <156e1773-fa76-4b22-80e7-cf26cb7bf7b3@foss.st.com>
 <CAOf5uwmNz3JRoEoEVxMYk1Mb5PnYEMSWKbbh=kMXp=tqufPB2g@mail.gmail.com>
 <05a41190-87a4-4d32-b3d9-44e3101ea858@foss.st.com>
In-Reply-To: <05a41190-87a4-4d32-b3d9-44e3101ea858@foss.st.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 4 Jun 2025 08:48:54 +0200
X-Gm-Features: AX0GCFvul3twTk2NvIKO8GoklB8FOmQ5VstwbNlN_8Vwr8QpqhROGR54Abuj9qA
Message-ID: <CAOf5uwkpj9HA+nhiOTPFz8WTGihyiVgZoCfZDKyCPu68zrRe9A@mail.gmail.com>
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

Hi Patrice

On Wed, Jun 4, 2025 at 8:46=E2=80=AFAM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 6/4/25 08:14, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Wed, Jun 4, 2025 at 8:02=E2=80=AFAM Patrice CHOTARD
> > <patrice.chotard@foss.st.com> wrote:
> >>
> >>
> >>
> >> On 5/27/25 15:27, Patrice Chotard wrote:
> >>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >>>
> >>> Add a new config CONFIG_CLK_AUTO_ID to support a unique clk id
> >>> for all the clock providers, managed by clk uclass, when the clock
> >>> reference arg[0] is the same.
> >>>
> >>> When the CONFIG is activated, the clock id is limited to the lower
> >>> CLK_ID_SZ =3D 24 bits in default clock xlate function
> >>> and the sequence number + 1 of the clk provider device is
> >>> added for the 8 higher bits.
> >>>
> >>> We use sequence number + 1 to avoid the "dummy" clock id =3D 0,
> >>> used for invalid clock when CCF is activated.
> >>>
> >>> When this config is activated, the new function clk_get_id()
> >>> should be used to get back the internal reference to clock
> >>> for the each clock provider.
> >>>
> >>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >>> Cc: Lukasz Majewski <lukma@denx.de>
> >>> Cc: Sean Anderson <seanga2@gmail.com>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>  drivers/clk/Kconfig                | 10 ++++++++++
> >>>  drivers/clk/clk-uclass.c           |  9 +++++++--
> >>>  drivers/clk/stm32/clk-stm32-core.c |  3 ++-
> >>>  include/clk.h                      | 24 ++++++++++++++++++++++++
> >>>  include/linux/clk-provider.h       |  9 ++++++++-
> >>>  5 files changed, 51 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> >>> index 18bd640a68b..b2e53fe325e 100644
> >>> --- a/drivers/clk/Kconfig
> >>> +++ b/drivers/clk/Kconfig
> >>> @@ -10,6 +10,16 @@ config CLK
> >>>         feed into other clocks in a tree structure, with multiplexers=
 to
> >>>         choose the source for each clock.
> >>>
> >>> +config CLK_AUTO_ID
> >>> +     bool "Enable support of an unique clock id with several provide=
r"
> >>> +     depends on CLK
> >>> +     help
> >>> +       Add the uclass sequence number of clock provider in the 8 hig=
her bits
> >>> +       of the clk id to guaranty an unique clock identifier in clk u=
class
> >>> +       when several clock providers are present on the device and wh=
en
> >>> +       default xlate are used.
> >>> +       This feature limit each identifier for each clock providers (=
24 bits).
> >>> +
> >>>  config SPL_CLK
> >>>       bool "Enable clock support in SPL"
> >>>       depends on CLK && SPL && SPL_DM
> >>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> >>> index 2167cd5ad0f..7262e89b512 100644
> >>> --- a/drivers/clk/clk-uclass.c
> >>> +++ b/drivers/clk/clk-uclass.c
> >>> @@ -34,6 +34,11 @@ struct clk *dev_get_clk_ptr(struct udevice *dev)
> >>>       return (struct clk *)dev_get_uclass_priv(dev);
> >>>  }
> >>>
> >>> +ulong clk_get_id(const struct clk *clk)
> >>> +{
> >>> +     return (ulong)(clk->id & CLK_ID_MSK);
> >>> +}
> >>> +
> >>>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >>>  int clk_get_by_phandle(struct udevice *dev, const struct phandle_1_a=
rg *cells,
> >>>                      struct clk *clk)
> >>> @@ -43,7 +48,7 @@ int clk_get_by_phandle(struct udevice *dev, const s=
truct phandle_1_arg *cells,
> >>>       ret =3D device_get_by_ofplat_idx(cells->idx, &clk->dev);
> >>>       if (ret)
> >>>               return ret;
> >>> -     clk->id =3D cells->arg[0];
> >>> +     clk->id =3D CLK_ID(dev, cells->arg[0]);
> >>>
> >>>       return 0;
> >>>  }
> >>> @@ -61,7 +66,7 @@ static int clk_of_xlate_default(struct clk *clk,
> >>>       }
> >>>
> >>>       if (args->args_count)
> >>> -             clk->id =3D args->args[0];
> >>> +             clk->id =3D CLK_ID(clk->dev, args->args[0]);
> >>>       else
> >>>               clk->id =3D 0;
> >>>
> >>> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/c=
lk-stm32-core.c
> >>> index 358ee56682a..df3b35b1003 100644
> >>> --- a/drivers/clk/stm32/clk-stm32-core.c
> >>> +++ b/drivers/clk/stm32/clk-stm32-core.c
> >>> @@ -46,7 +46,8 @@ int stm32_rcc_init(struct udevice *dev,
> >>>
> >>>               if (cfg->setup) {
> >>>                       clk =3D cfg->setup(dev, cfg);
> >>> -                     clk->id =3D cfg->id;
> >>> +                     /* set identifier of clock provider*/
> >>> +                     dev_clk_dm(dev, cfg->id, clk);
> >>>               } else {
> >>>                       dev_err(dev, "failed to register clock %s\n", c=
fg->name);
> >>>                       return -ENOENT;
> >>> diff --git a/include/clk.h b/include/clk.h
> >>> index a6ef4e02692..f94135ff778 100644
> >>> --- a/include/clk.h
> >>> +++ b/include/clk.h
> >>> @@ -13,6 +13,15 @@
> >>>  #include <linux/errno.h>
> >>>  #include <linux/types.h>
> >>>
> >>> +#ifdef CONFIG_CLK_AUTO_ID
> >>> +#define CLK_ID_SZ    24
> >>> +#define CLK_ID_MSK   GENMASK(23, 0)
> >>> +#define CLK_ID(dev, id)      (((dev_seq(dev) + 1) << CLK_ID_SZ) | ((=
id) & CLK_ID_MSK))
> >>> +#else
> >>> +#define CLK_ID_MSK   (~0UL)
> >>> +#define CLK_ID(dev, id)      id
> >>> +#endif
> >>> +
> >>>  /**
> >>>   * DOC: Overview
> >>>   *
> >>> @@ -570,6 +579,16 @@ int clk_get_by_id(ulong id, struct clk **clkp);
> >>>   */
> >>>  bool clk_dev_binded(struct clk *clk);
> >>>
> >>> +/**
> >>> + * clk_get_id - get clk id
> >>> + *
> >>> + * @clk:     A clock struct
> >>> + *
> >>> + * Return: the clock identifier as it is defined by the clock provid=
er in
> >>> + * device tree or in platdata
> >>> + */
> >>> +ulong clk_get_id(const struct clk *clk);
> >>> +
> >>>  #else /* CONFIG_IS_ENABLED(CLK) */
> >>>
> >>>  static inline int clk_request(struct udevice *dev, struct clk *clk)
> >>> @@ -641,6 +660,11 @@ static inline bool clk_dev_binded(struct clk *cl=
k)
> >>>  {
> >>>       return false;
> >>>  }
> >>> +
> >>> +static inline ulong clk_get_id(const struct clk *clk)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>>  #endif /* CONFIG_IS_ENABLED(CLK) */
> >>>
> >>>  /**
> >>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> >>> index 267757939e0..2d754fa4287 100644
> >>> --- a/include/linux/clk-provider.h
> >>> +++ b/include/linux/clk-provider.h
> >>> @@ -15,10 +15,17 @@
> >>>
> >>>  struct udevice;
> >>>
> >>> +/* update clock ID for the dev =3D clock provider, compatible with C=
LK_AUTO_ID */
> >>> +static inline void dev_clk_dm(const struct udevice *dev, ulong id, s=
truct clk *clk)
> >>> +{
> >>> +     if (!IS_ERR(clk))
> >>> +             clk->id =3D CLK_ID(dev, id);
> >>> +}
> >>> +
> >>>  static inline void clk_dm(ulong id, struct clk *clk)
> >>>  {
> >>>       if (!IS_ERR(clk))
> >>> -             clk->id =3D id;
> >>> +             clk->id =3D CLK_ID(clk->dev, id);
> >>>  }
> >>>
> >>>  /*
> >> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >>
> >
> > I think you should ask to be picked by Tom. I don't have objection on t=
his patch
> >
> > Michael
>
> Hi Michael
>
> For which reason ?
> For information, this series has been submitted to CI test : https://sour=
ce.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26358
> without any issue.

Because I haven't seen activity on the clock maintainer for months.

Michael


>
> Thanks
> Patrice
>
> >
> >> Thanks
> >> Patrice
> >
> >
> >



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
