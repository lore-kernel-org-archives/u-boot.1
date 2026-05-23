Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013AECD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 13:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EEA84881;
	Sat, 23 May 2026 15:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="L99jWiIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C340F84874; Sat, 23 May 2026 15:12:05 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF69F84886
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 15:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c21049dafso7435466d50.2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 06:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779541921; cv=none;
 d=google.com; s=arc-20240605;
 b=lIw0YcpXgm6CtQFNOCKnT+hSGIJn0f7bYoEuYm7Muv8AuoFAFaOILYjJ8sIM/G6D+B
 BfemFDy+M49dbdjkItE5cQW4tMOQtxERdD6Rpch/axInWu68ynF1IWiQkrJcozzNqpuy
 I0VIOGvWri8sAUBsCuCNBr7TUVTKx8XN/UWiDsB90dY6id7NRy9+pv5ZcdnIKMwNxwfG
 CB2Q13K8U/GXLDsbLi16YDfomg9ci0IJDTE7mt2nVFxI7krNpxqTj+c88uF+c7dOb8xh
 srFoRTc1MNQ6hS4nPl2qyG+wk2WlAAdNuAZczHxjfIqkicQ6SrLKLjvXVcTrCA2Hf/Bq
 50nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VT+sWJHGV3eLaFcOngQvJcaCh3TwaPaRWmyysNpPDvc=;
 fh=kROA/TNbHIMJ7793yqT7YnuXoMLI2gQN+V/tNBS0vvw=;
 b=g/8XmKRC4IyL1VxvQ5CWHDrrQ0z0b8m+9GTuhcfdD87d6hWKi8CKY2uH8KtNfX69lV
 vQ2k5UWZHHASnYz0ImdFgvUS6jnJ2eZE4nOZfSjf2fs8NwOqOaWJKeVAuO2pvzb2ByX6
 o8la2oFyTZda0WwZ2aRwoygJSiAiJgHg/+/PEsnQqIoQGQ0XPZLsyuyIFW8dmqrkrjQF
 K6FMbjY+XBTKE/cgbncH6Xo62SiIxHTKj+GN926R3ee2ZRXcNomMqgdeLTQnEK8xf+MR
 0DODnQY0rSx/VnevzABHn0+WkQ6kzJNqqRjug/7W8whjZN0QZwjN4aCmVg3KsewLZwle
 Cq1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779541921; x=1780146721;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VT+sWJHGV3eLaFcOngQvJcaCh3TwaPaRWmyysNpPDvc=;
 b=L99jWiIAJJElmTq62w2Mzn+vfQQDE+AKlFfI3oJQ7nwjmwCKIAD0SzpWOhJxaP7Z6j
 rznCtmS4ucUkNQ51yLKwR7xcpQW3FTjnnHlN/MeweET27SUybnl9uRoOCZLcHuKSCrY7
 HoxEXnLnf7sSMPA3Bhit0T7ryF1/6tYl82Vf5rSSzGeCDVgWx8HSVRAB4YmppggO1X5Q
 1Ugs5VgXf1zyv8t1brHn4sCeE8SmOYd/DGyy3CiMEAdfaXzgrre6pmPBohPReokbQ3Wj
 +gtHQurjWj0pKu4rRb4sYDm1Ep2gW5I+bAfqlqwHy7iaoVKdf9GE99IZW/SUK4xqgvMJ
 YmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779541921; x=1780146721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VT+sWJHGV3eLaFcOngQvJcaCh3TwaPaRWmyysNpPDvc=;
 b=MBpQxDMkeanpCvKYI3PND5k+m3JbSe8S6U3R2BmMIuUVr0bWhVI2tx85Lre8wVQkSA
 2ZUZLkHhR/NaHjRWw62vUFi20dVW3rg7a+mCuoEOvUBX/dOpu4TyyR+uo3Mx/EkYg6pI
 iISWCnr937SgzVD6AZe4PIglGMqH0oVdfDvU3FpU9f9A6QuEDr8tjonzD2BKNZTT14ts
 hBPhIzC8cnwrsWfdsPX2rX+GAIZxFehsc0OY2UVAqH1mLhyUzodRnayQA0KxI3nfn/cm
 w+RU8jO5De1khHIsDjk35T/z7YKN9X5vtoeLdd2Qm+cf2shXD/A347Tl+cKAGLJX9duA
 GQJA==
X-Gm-Message-State: AOJu0YxUGPlyYCI4ooBT8ug6y8RbSUSYkLCONv+jfY9rQUHRe6lCksRm
 EarJaV3CLPycwv0jGxd5SS0tbvr5+MUO4qKnAH2WppRG5hqKJ2tv+STgSbFTDZGox1r2brtot8s
 /hWyfHLzsqEn+XJ0HrVQUY05JME0BCV0Rm2JwmbJf0Q==
X-Gm-Gg: Acq92OHHkz3j3GylAvaUWD9wFHwdLj1NcIbw+mhakvhAfnDFvWBMIUDY27+bUu8vrgl
 ufOG5WP+HgiNzQSUPvXKQrVCqmjaE+6IdPr4KBjl9t2+2QCoRLQrn6dyPdduKek6CJ31KLslob4
 Ra3t3mwPhyB9Q+IFtldi+bZSChJkZx8tYGqFrTWYYwqWHjeRikEquhpvR/Ux9Q9FIdEYy/9bkAR
 kedhG7zfnaYQ+Z3s+NxbZINJol1Uoa+azkPM/XID0FHWUnHDwNRhAE4t0IPQmD8C7BHhb21rKmJ
 uDLZqC5qofaL5FFiTp9SLO6ejTTNcACtRc5LhRruQwGg10uPmRHCnmuNIelhYTgYyhpWd0m6AFf
 B1A==
X-Received: by 2002:a05:690e:140d:b0:65e:1d95:29d5 with SMTP id
 956f58d0204a3-65ec98a9bdbmr7354242d50.41.1779541920883; Sat, 23 May 2026
 06:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
 <20260510-b4-k1-clk-reset-upstream-dts-v1-1-db0b0503ee44@riscstar.com>
 <ahB_xeaHbMHkIxO6@pie>
In-Reply-To: <ahB_xeaHbMHkIxO6@pie>
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 23 May 2026 21:11:50 +0800
X-Gm-Features: AVHnY4KzdunOL1R8K_tVdfUCMiWVUFmbYeWFvJR1yPzd9pXdGJi8OuB7XpEw8KQ
Message-ID: <CAH1PCMZoSSqcbFC92rn=aVndPr5+3p1pPtgpUQuoAOYxgH-ytQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk: spacemit: Add support for K1 SoC
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi, Yao Zi

On Sat, May 23, 2026 at 12:10=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Sun, May 10, 2026 at 08:06:23AM -0400, Guodong Xu wrote:
> > From: Junhui Liu <junhui.liu@pigmoral.tech>
> >
> > The K1 SoC exposes four clock providers in the kernel mainline DT: one
> > PLL controller ("spacemit,k1-pll") and three syscon clock nodes
> > ("spacemit,k1-syscon-{mpmu,apbc,apmu}"). Register a separate
> > U_BOOT_DRIVER for each.
> >
> > Inter-controller ordering is enforced where the registers actually
> > depend on each other.
>
> What do you mean by "registers actually depend on each other"? Do you
> refer to the fact that some APBC clocks are derived from APMU/PLL
> controllers thus must be registered after them? If so, would this

Yes, exactly. I can change the wording in next version. But yes,
I mean that dependency in K1's PLL controller and syscon nodes:
      MPMU <- PLL
      APMU <- PLL + MPMU
      APBC <- PLL + MPMU + APMU

> series[1] help which allows arbitrary clock registration order and
> handles dependencies in CCF instead?

I have concerns. This series [1] doesn't allow xPL useage. As the author
stated in his cover letter "This feature is disabled for xPLs by default..
no clean way to enable it for xPL". And SPL registration is exactly what
K1 needs. Also, Tom Rini reported a boot failure on TI board in that
thread, still unresolved.

I will keep an eye on it, but at this moment, I don't think it is the right
solution for my case.

>
> > Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  drivers/clk/Kconfig               |    5 +-
> >  drivers/clk/Makefile              |    1 +
> >  drivers/clk/spacemit/Kconfig      |   23 +
> >  drivers/clk/spacemit/Makefile     |    7 +
> >  drivers/clk/spacemit/clk-k1.c     | 1722 +++++++++++++++++++++++++++++=
++++++++
> >  drivers/clk/spacemit/clk_common.h |   79 ++
> >  drivers/clk/spacemit/clk_ddn.c    |   93 ++
> >  drivers/clk/spacemit/clk_ddn.h    |   53 ++
> >  drivers/clk/spacemit/clk_mix.c    |  403 +++++++++
> >  drivers/clk/spacemit/clk_mix.h    |  224 +++++
> >  drivers/clk/spacemit/clk_pll.c    |  157 ++++
> >  drivers/clk/spacemit/clk_pll.h    |   81 ++
> >  include/soc/spacemit/k1-syscon.h  |  149 ++++
> >  13 files changed, 2995 insertions(+), 2 deletions(-)
>
> ...
>
> > diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfi=
g
> > new file mode 100644
> > index 00000000000..03aecefddc4
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/Kconfig
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
> > +
> > +config CLK_SPACEMIT
> > +     bool "Clock support for SpacemiT SoCs"
> > +     depends on CLK
>
> What about
>
>         depends on CLK || COMPILE_TEST
>
> to allow building-only tests?

Yes, agree. Will add that.

>
> > +     select REGMAP
> > +     help
> > +       This enables support clock driver for Spacemit SoC
> > +       family.
> > +
> > +if CLK_SPACEMIT
> > +
> > +config CLK_SPACEMIT_K1
> > +     bool "SpacemiT K1 clock support"
> > +     select CLK_CCF
> > +     select LIB_RATIONAL
>
> CLK_SPACEMIT instead of CLK_SPACEMIT_K1 should selects LIB_RATIONAL...
>

Agree. I will fix that.

> > +     help
> > +       This enables support clock driver for Spacemit K1 SoC.
> > +       It's based on Common Clock Framework.
> > +
> > +endif
> > diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makef=
ile
> > new file mode 100644
> > index 00000000000..824e94d1f74
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
> > +
> > +obj-$(CONFIG_CLK_SPACEMIT) +=3D clk_ddn.o clk_mix.o clk_pll.o
>
> ... since the driver actually makes use of rational routines, clk_ddn.o,
> is guarded by CONFIG_CLK_SPACEMIT, not CONFIG_CLK_SPACEMIT_K1.
>
> > +obj-$(CONFIG_CLK_SPACEMIT_K1)        +=3D clk-k1.o
> > diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k=
1.c
> > new file mode 100644
> > index 00000000000..4c0972d952e
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/clk-k1.c
>
> ...
>
> > +struct clk_retry_item {
> > +     struct ccu_common *common;
> > +     struct list_head link;
> > +};
> > +
> > +static LIST_HEAD(retry_list);
> > +
> > +static int k1_clk_retry_register(void)
> > +{
> > +     struct clk_retry_item *item, *tmp;
> > +     int retries =3D 5;
> > +     int ret;
> > +
> > +     while (!list_empty(&retry_list) && retries) {
> > +             list_for_each_entry_safe(item, tmp, &retry_list, link) {
> > +                     struct ccu_common *common =3D item->common;
> > +
> > +                     ret =3D common->init(common);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     list_del(&item->link);
> > +                     kfree(item);
> > +             }
> > +             retries--;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Is retrying for handling dependencies between clocks? Could the series
> I mentioned above help? This version looks very hacking...
>
> Another solution might be carefully specify the order in which clocks
> are registered to ensure parents are always registered before children.
>

Agreed that explicit ordering is the right idea.

To keep the order, I will do it at controller side via force-probe, letting
the dependent controller (eg. APBC)'s own .probe function forces its parent
controller (eg. PLL) to probe, by calling
  uclass_get_device_by_driver(..,DM_DRIVER_GET(k1_pll_clk),..).

This way also removes the clk_get_by_index(4/5/6) magic-index.

BR,
Guodong Xu

> ...
>
> > diff --git a/drivers/clk/spacemit/clk_ddn.c b/drivers/clk/spacemit/clk_=
ddn.c
> > new file mode 100644
> > index 00000000000..7b93f30d5c3
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/clk_ddn.c
>
> ...
>
> > +static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
> > +                                         unsigned long rate, unsigned =
long prate,
> > +                                         unsigned long *num, unsigned =
long *den)
> > +{
> > +     rational_best_approximation(rate, prate / ddn->pre_div,
> > +                                 ddn->den_mask >> ddn->den_shift,
> > +                                 ddn->num_mask >> ddn->num_shift,
> > +                                 den, num);
>
> Rational routines are used here.
>
> > +     return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
> > +}
>
> Best regards,
> Yao Zi
>
> [1]: https://lore.kernel.org/u-boot/20260120-clk-reparent-v3-0-0d43d4b362=
ac@outlook.com/
