Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB8BC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 23:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA62386EF1;
	Thu, 11 Jan 2024 00:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cvxJxcdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D3D86314; Thu, 11 Jan 2024 00:49:06 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4DF88783C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 00:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28cc07d8876so2893918a91.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704930542; x=1705535342; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJoeDI6o7CqHtCc0w9O5EnUvNGzyluxLUSNnd0ceZcM=;
 b=cvxJxcdjn3YB9XoL71198k0YdnOrRvByfFk6skaLltid0yfoUjGORrw9+/+R0oOevK
 kMWbYT7SFbe46+XK8q9ts3VT0kkLtYHiYSy5Hx2YM/KcWDejnySWNw2PG9hA75SXlpFG
 dK9PHw+8ONsScsPPj9VBpa1l/FYNaa0mWZoqAnsOdN61sEkZhW3jK7luyz7Q01PlAsIz
 DcYTPo1Jj+eLSv2vDvty+RceU0luD/CwYa+mp6BSV5v6Ij2UlRZVjs3N73U58FFUhz1d
 v+7yE6F8cL192Qqqlcn9IqXP0pyiQZMy/jS25Vc76Ee9XanIsegpIiu2GME9U9bI81QS
 ZJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704930542; x=1705535342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJoeDI6o7CqHtCc0w9O5EnUvNGzyluxLUSNnd0ceZcM=;
 b=m8zPN6qZm9rnoHym1E5ANGf1djUW4Ibg+6zJkh5MMnaNc8cTy753ojvyIBSTrzMREr
 9WbjOuIT3SejgvfC36LREki+O0btN5UQl6N4Q0kKyN/aPTT2MFQ5HAsALYgWmR90JXff
 s5iV6GMNUzpOc3XMClhMi6MOmUeo6c9NtZ/KX1NJf3BoOUV4J/jQ/Hv7KtJRulNKA+Jg
 ud50K1KW6etItHmYJDTL1YseJ+HLqrQQzM8tiUcMxU2eAe5gpAJ1xuWhD4Eqa5rztGOQ
 Eddty9edqGl7EiDSWqsmJtE7DdRarhYf941t9piOfHZxta0XNNrPjz6ENmIw1ov+o5Nt
 b0PA==
X-Gm-Message-State: AOJu0Yz5qJAkdDWJUfNeRkjYBIu/BGrBTEPI+kz8A0yrbveZROHJlhn1
 x1E316IKFDyqRX506YFURi2GyyTEsejJ410aUvm2R9zaqqsxkw==
X-Google-Smtp-Source: AGHT+IHGXCCc74ghjoW5Fv4eR/kKSs3lTAPq2Dk1sTEbIYI2EF0d/LufOh56x41tQ/MOpgkmCYC63sdrWONvWjhifHQ=
X-Received: by 2002:a17:90a:290:b0:28d:44f8:c1b1 with SMTP id
 w16-20020a17090a029000b0028d44f8c1b1mr291898pja.19.1704930542165; Wed, 10 Jan
 2024 15:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031852epcas2p26c39b053e650e928ff43ad569e8da76c@epcas2p2.samsung.com>
 <20231213031646.28828-10-semen.protsenko@linaro.org>
 <006c01da326f$16b59ad0$4420d070$@samsung.com>
In-Reply-To: <006c01da326f$16b59ad0$4420d070$@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jan 2024 17:48:51 -0600
Message-ID: <CAPLW+4kYR8KrS4ftpaTu+fF0dzw28iZA2qX94K6x+WT1ABio0g@mail.gmail.com>
Subject: Re: [PATCH 09/13] pinctrl: exynos: Add pinctrl support for Exynos850
To: Chanho Park <chanho61.park@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 5:32=E2=80=AFAM Chanho Park <chanho61.park@samsung.=
com> wrote:
>
> > -----Original Message-----
> > From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Sam Protsenko
> > Sent: Wednesday, December 13, 2023 12:17 PM
> > To: Minkyu Kang <mk7.kang@samsung.com>; Tom Rini <trini@konsulko.com>;
> > Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>; Heinrich Schuchardt
> > <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> > Subject: [PATCH 09/13] pinctrl: exynos: Add pinctrl support for Exynos8=
50
> >
> > Add pinctrl support for Exynos850 SoC. It was mostly extracted from
> > corresponding Linux kernel code [1]. Power down modes and external
> > interrupt data were removed while converting the code for U-Boot, but
> > everything else was kept almost unchanged.
> >
> > [1] drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/pinctrl/exynos/Kconfig             |   8 ++
> >  drivers/pinctrl/exynos/Makefile            |   1 +
> >  drivers/pinctrl/exynos/pinctrl-exynos850.c | 125 +++++++++++++++++++++
> >  3 files changed, 134 insertions(+)
> >  create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c
> >
> > diff --git a/drivers/pinctrl/exynos/Kconfig
> > b/drivers/pinctrl/exynos/Kconfig
> > index a60f49869b45..1b7fb62bc4ba 100644
> > --- a/drivers/pinctrl/exynos/Kconfig
> > +++ b/drivers/pinctrl/exynos/Kconfig
> > @@ -16,3 +16,11 @@ config PINCTRL_EXYNOS78x0
> >       help
> >         Support pin multiplexing and pin configuration control on
> >         Samsung's Exynos78x0 SoC.
> > +
> > +config PINCTRL_EXYNOS850
> > +     bool "Samsung Exynos850 pinctrl driver"
> > +     depends on ARCH_EXYNOS && PINCTRL_FULL
> > +     select PINCTRL_EXYNOS
> > +     help
> > +       Support pin multiplexing and pin configuration control on
> > +       Samsung's Exynos850 SoC.
> > diff --git a/drivers/pinctrl/exynos/Makefile
> > b/drivers/pinctrl/exynos/Makefile
> > index 07db970ca942..3abe1226eb74 100644
> > --- a/drivers/pinctrl/exynos/Makefile
> > +++ b/drivers/pinctrl/exynos/Makefile
> > @@ -6,3 +6,4 @@
> >  obj-$(CONFIG_PINCTRL_EXYNOS)         +=3D pinctrl-exynos.o
> >  obj-$(CONFIG_PINCTRL_EXYNOS7420)     +=3D pinctrl-exynos7420.o
> >  obj-$(CONFIG_PINCTRL_EXYNOS78x0)     +=3D pinctrl-exynos78x0.o
> > +obj-$(CONFIG_PINCTRL_EXYNOS850)              +=3D pinctrl-exynos850.o
> > diff --git a/drivers/pinctrl/exynos/pinctrl-exynos850.c
> > b/drivers/pinctrl/exynos/pinctrl-exynos850.c
> > new file mode 100644
> > index 000000000000..2445dd752ea8
> > --- /dev/null
> > +++ b/drivers/pinctrl/exynos/pinctrl-exynos850.c
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Linaro Ltd.
> > + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> > + *
> > + * Samsung Exynos USI driver (Universal Serial Interface).
>
> Typo. It should be a subject for the pinctrl driver.
>

Nice catch! Will be fixed in v2.

> Otherwise,
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Thanks for the review!

>
