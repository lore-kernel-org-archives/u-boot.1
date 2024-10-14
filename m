Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4073CFC501
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5136788FE8;
	Mon, 14 Oct 2024 09:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iPmgjHjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D4288FD6; Mon, 14 Oct 2024 09:19:41 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4059D88FEC
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso592150366b.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728890375; x=1729495175;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNzmdKNfhrBZebm0Tb7suphkLoWGKG9g/fGm16Nv2fU=;
 b=iPmgjHjm6+MpmXbhT8oYLqq5wvebtcYaFQx1U3WEBwUeChkOcMEPC06aZ33kc0km2i
 Ic4/Q1JZ4e8HvnSuYH2cpGhH9tk2BE14htMtJy0IPoPGWei/De+CCGRI9TE/izWA1ZTG
 qXjo6h3UqKaVmPFO+VwY8QkCfHsn0wSTmwTRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728890375; x=1729495175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNzmdKNfhrBZebm0Tb7suphkLoWGKG9g/fGm16Nv2fU=;
 b=RFK3D4H/6mD4JqMi0RFxuze2IOEDn5vb/3EfTw1k4qtESOD6jJiZr1hKDPk9DfxtDo
 mHjHzHkYvSrRo2TBWqFXHgfE4lmN+yOoUVn7MJUQMDlmV71Q5i0T/9bhQsaq9YPd1bi2
 heZQc5HRY/vwwy51RZin9YirzyuzufF8GG3+I6KfynQvwFZLVnJT+MNfrW2BVDyQ5hV5
 s3W4b27moRNid4LbEH/qzj/6EioSUCCtC4tu+U7dPxiYEOHc5qEDimerPEwmb3jUyT20
 08dxwDPAptcREGaRNvtcBTTbfSQXrUv7mtkjG5703UfxPtpYDWpyQT9eQx/xA66TKFBf
 nE8A==
X-Gm-Message-State: AOJu0YxKvlb1Ic6NYBWtPM0HGALikNuGSCw58PL+MHefUgpZ3vloYOXc
 d11o7BoseAnFEFDfJy9rvj5zLXQ7UCHdazTJPkyqByToE7o6nzr5k7869a6tHYSUJcLSo1QQp6x
 I4hSLYhrVl2gKk56yTbmoh6pKQMSY+bdilCU4XQ==
X-Google-Smtp-Source: AGHT+IFSIVmGGHl+Olt4I1Simklt0H35kBPgvJDyNTg5TtYA5vZ5F9kZuxkaxJcVzCOfkkv81aKTHAFmOvwycl5fYuw=
X-Received: by 2002:a17:907:1c92:b0:a99:fdb7:4822 with SMTP id
 a640c23a62f3a-a99fdb748bdmr441350266b.45.1728890374766; Mon, 14 Oct 2024
 00:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
 <CAOf5uwm8p6WgzSBAB__V09zqcYnXO8YkFjdjEyTLHPOO-M+eGg@mail.gmail.com>
In-Reply-To: <CAOf5uwm8p6WgzSBAB__V09zqcYnXO8YkFjdjEyTLHPOO-M+eGg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 14 Oct 2024 09:19:21 +0200
Message-ID: <CAOf5uwmi6PTsfkcJDYBu_h7HsLJj5N7+fZv-ypfJq8+s=USk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mtd: rawnand: brcmnand: Add BCMBCA support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Fri, Oct 11, 2024 at 9:54=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Oct 11, 2024 at 4:49=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> >
> > This adds support for the NAND controller on the Broadcom
> > BCA (Broadband Access) platforms.
> >
> > This requires the series with brcmnand fixes that I sent
> > separately to be merged first. See:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D424109
> >
> > The development was done on the Genexis XG6846B which is
> > a derivative of the BCM96846 reference design, but probably
> > has a different flash layout, be sure to check the last
> > patch in the series for a comment on that.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Changes in v2:
> > - Switch to using OF_UPSTREAM instead of syncing DTS files.
> > - Mention the Linux version the BCMBCA NAND driver is based on.
> > - Link to v1: https://lore.kernel.org/r/20240930-bcmbca-nand-support-v1=
-0-e637c65de947@linaro.org
> >
>
> Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> I will queue in weekend

Applied thanks

Michael

>
> Michael
>
> > ---
> > Linus Walleij (4):
> >       mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
> >       drivers: nand: bcmbca: Enable on BCM6846
> >       board: bcm96846: Enable NAND options
> >       board: bcm96846: Switch to using OF_UPSTREAM
> >
> >  arch/arm/dts/bcm6846.dtsi                   | 103 -------------------
> >  arch/arm/dts/bcm96846.dts                   |  30 ------
> >  arch/arm/mach-bcmbca/bcm6846/Kconfig        |   4 +
> >  configs/bcm96846_defconfig                  |  15 ++-
> >  drivers/mtd/nand/raw/Kconfig                |   7 ++
> >  drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
> >  drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++=
++++++++
> >  7 files changed, 178 insertions(+), 134 deletions(-)
> > ---
> > base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
> > change-id: 20240930-bcmbca-nand-support-4447e176bbbd
> >
> > Best regards,
> > --
> > Linus Walleij <linus.walleij@linaro.org>
> >
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
