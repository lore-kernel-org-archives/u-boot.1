Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D7C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37D58770C;
	Sat, 16 Dec 2023 18:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="horcnQ8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F66787714; Sat, 16 Dec 2023 18:20:48 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386798770A
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c236624edso18638605e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702747245; x=1703352045; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlVYvuYttBlz4MvOEXzDyVsI9sjQaLQLZx7gGfaU1Zs=;
 b=horcnQ8gJJX7/8E66WBogz86GiQs1vPoHDXGQjv3orjX069EIJ4ld6AOJbgL59h9Zu
 //3VkgvxQF5ub1hqiVh/1mg0eQm6XaMAbElHIddcwR3YN/Xewsn1J3Mulgx/GhJS+qxt
 ZldpgCF06sOmRsf/sI0UBf9TBckKF5YjVZcSADknx1ZbuREGZD/+u53U4oBVnqrTvbMm
 yvwTGyJuHZpCPfAgA74dxvoLjp5UFmB/9oE2VqvA2Z7yyPhFOxa+HkBw8sQBKTcn9n73
 0/nJw6PIZgVhUtCFIftWVxg3lnTOSNJPY3V1XimXdeYgOl6Kj48OT9UPAzqRIWy8eHRb
 7fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702747245; x=1703352045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlVYvuYttBlz4MvOEXzDyVsI9sjQaLQLZx7gGfaU1Zs=;
 b=fWNOek9KOQUnQ3HIumiEwdNOtIgkPLlkAPRDPKgnKuzEdbw6EYuEiCYCHBNQg2oV63
 HIZOT6mWxfCklVSMGrhdat8un3pyNRFYGVGuDrSlRwFwJPCIqq60anA8WguBx5sfUsC/
 f/kC4nAkuRceLE0fi7sbaZ4+l7D+A/obiFCYPFuonmRP/rJ46ij6OhbaEi/SElFO8V9I
 0AG6xGPzAa91of1GdypRQU2cmWB/DY/he65+TE6ULU1koyVlc1NNC2qcHMyKWq7CCZP+
 pBf/t8YkGMDachJYrscKPrBjSi8jioQo2EwyGYstRuj9PlZWXfCSUbTNwNImvO59iPG0
 w9qQ==
X-Gm-Message-State: AOJu0YxT7wKvW0FimjZF7iTd8QFySz+/0cvSB7nHgQ6WcuR+cPAz2t/+
 KS+hdivYEeN/jseDHL/S1IX+XfOLrn6Ux6q17VQ=
X-Google-Smtp-Source: AGHT+IFC6/Asg7AyHWPZ4sapBoV9ZyuTToXaEyXSNFCIEnJVdReRloQI89lwtnNIfubrb3gvCNvhRUBWcrdH6GjdX2Y=
X-Received: by 2002:a5d:6b8e:0:b0:336:4e43:b6cb with SMTP id
 n14-20020a5d6b8e000000b003364e43b6cbmr1567926wrx.41.1702747245353; Sat, 16
 Dec 2023 09:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20231204082054.4943-1-clamor95@gmail.com>
 <ZW2pYqo6hjGqKo_-@orome.fritz.box>
 <CAPVz0n1XDNvD8G06i_qEdr3SNXwWtFfkyURp6uZbr86rbH2jQA@mail.gmail.com>
 <20231209141406.GF2513409@bill-the-cat>
In-Reply-To: <20231209141406.GF2513409@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 16 Dec 2023 19:20:34 +0200
Message-ID: <CAPVz0n09nOSzn7nYkOBrr4_DL1Tk_czJnt-gdOYibpPfeL38RA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Convert Tegra pinctrl to DM
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>
Cc: Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, 
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

=D1=81=D0=B1, 9 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 16:14=
 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Dec 04, 2023 at 04:45:38PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 4 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 1=
2:26 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, Dec 04, 2023 at 10:20:46AM +0200, Svyatoslav Ryhel wrote:
> > > > Create a DM supported wrapper arround existing Tegra pinmux logic.
> > > > This implementation is backwards compatible with all existing board
> > > > setups and early stages of setup. All new boards must be device tre=
e
> > > > based. Linux dts pinmux nodes are fully compatible with this driver=
.
> > > >
> > > > As an example I have converted recently merged T30 boards to this
> > > > layout (I have those devices and was able to test them properly) an=
d
> > > > Paz00 T20 board which was tested as well by owner.
> > > >
> > > > Svyatoslav Ryhel (8):
> > > >   ARM: mach-tegra: rearrange SPL configs
> > > >   drivers: pinctrl: create Tegra DM pinctrl driver
> > > >   drivers: pinctrl: tegra: incorporate existing code
> > > >   board: asus: grouper: switch to DM pinmux
> > > >   board: lg: x3-t30: switch to DM pinmux
> > > >   board: asus: transformer: switch to DM pinmux
> > > >   board: htc: endeavoru: switch to DM pinmux
> > > >   board: compal: paz00: clean up the board
> > > >
> > > >  arch/arm/dts/tegra20-paz00.dts                |    4 +-
> > > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |  712 ++++++++++
> > > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  113 ++
> > > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  113 ++
> > > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  149 +++
> > > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  982 +++++++++++++=
+
> > > >  arch/arm/dts/tegra30-asus-tf201.dts           |   45 +
> > > >  arch/arm/dts/tegra30-asus-tf300t.dts          |   45 +
> > > >  arch/arm/dts/tegra30-asus-tf300tg.dts         |  128 ++
> > > >  arch/arm/dts/tegra30-asus-tf300tl.dts         |  163 +++
> > > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  889 +++++++++++++
> > > >  arch/arm/dts/tegra30-asus-tf700t.dts          |   53 +
> > > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |  984 +++++++++++++=
+
> > > >  arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 +++++++++++++=
++++
> > > >  arch/arm/dts/tegra30-lg-p880.dts              |   90 ++
> > > >  arch/arm/dts/tegra30-lg-p895.dts              |   93 ++
> > > >  arch/arm/dts/tegra30-lg-x3.dtsi               |  845 ++++++++++++
> > > >  arch/arm/include/asm/arch-tegra114/pinmux.h   |  303 +++++
> > > >  arch/arm/include/asm/arch-tegra124/pinmux.h   |  327 +++++
> > > >  arch/arm/include/asm/arch-tegra20/pinmux.h    |  291 +++++
> > > >  arch/arm/include/asm/arch-tegra210/pinmux.h   |  394 ++++++
> > > >  arch/arm/include/asm/arch-tegra30/pinmux.h    |  381 ++++++
> > > >  arch/arm/mach-tegra/Kconfig                   |   16 +-
> > > >  arch/arm/mach-tegra/Makefile                  |    1 -
> > > >  arch/arm/mach-tegra/board.c                   |    6 +-
> > > >  arch/arm/mach-tegra/board2.c                  |    2 +-
> > > >  arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
> > > >  arch/arm/mach-tegra/tegra124/Makefile         |    2 -
> > > >  arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
> > > >  arch/arm/mach-tegra/tegra210/Makefile         |    1 -
> > > >  arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
> > > >  board/asus/grouper/grouper.c                  |   18 -
> > > >  board/asus/grouper/pinmux-config-grouper.h    |  362 ------
> > > >  .../pinmux-config-transformer.h               |  365 ------
> > > >  board/asus/transformer-t30/transformer-t30.c  |   23 -
> > > >  board/compal/paz00/Makefile                   |    8 -
> > > >  board/compal/paz00/paz00.c                    |   53 -
> > > >  board/htc/endeavoru/endeavoru.c               |   14 -
> > > >  board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
> > > >  board/lg/x3-t30/Kconfig                       |   12 -
> > > >  board/lg/x3-t30/configs/p880.config           |    1 -
> > > >  board/lg/x3-t30/configs/p895.config           |    1 -
> > > >  board/lg/x3-t30/pinmux-config-x3.h            |  449 -------
> > > >  board/lg/x3-t30/x3-t30.c                      |   23 -
> > > >  configs/paz00_defconfig                       |    3 +
> > > >  drivers/pinctrl/Kconfig                       |    1 +
> > > >  drivers/pinctrl/Makefile                      |    1 +
> > > >  drivers/pinctrl/tegra/Kconfig                 |   18 +
> > > >  drivers/pinctrl/tegra/Makefile                |   16 +
> > > >  .../pinctrl/tegra/funcmux-tegra114.c          |    0
> > > >  .../pinctrl/tegra/funcmux-tegra124.c          |    0
> > > >  .../pinctrl/tegra/funcmux-tegra20.c           |    0
> > > >  .../pinctrl/tegra/funcmux-tegra210.c          |    0
> > > >  .../pinctrl/tegra/funcmux-tegra30.c           |    0
> > > >  drivers/pinctrl/tegra/pinctrl-tegra.c         |  248 ++++
> > > >  drivers/pinctrl/tegra/pinctrl-tegra20.c       |  177 +++
> > > >  .../pinctrl/tegra}/pinmux-common.c            |    0
> > > >  .../pinctrl/tegra/pinmux-tegra114.c           |    0
> > > >  .../pinctrl/tegra/pinmux-tegra124.c           |    0
> > > >  .../pinctrl/tegra/pinmux-tegra20.c            |    0
> > > >  drivers/pinctrl/tegra/pinmux-tegra210.c       |  190 +++
> > > >  .../pinctrl/tegra/pinmux-tegra30.c            |    0
> > > >  include/configs/x3-t30.h                      |   13 +-
> > > >  63 files changed, 8920 insertions(+), 1723 deletions(-)
> > >
> > > So we're adding 7000 extra lines here just to get the same level of
> > > functionality? Do we really want this?
> >
> > Tom, as a project maintainer, may you answer? Does U-Boot really want
> > this? And ensure there will never ever be a forced pinmux DM
> > migration.
> >
> > >
> > > For things like the kernel this makes a bit more sense because we can
> > > have generic kernel images for a wide variety of boards, and
> > > additionally we can have dynamic reconfiguration of the pinmux at
> > > runtime. We have neither of those in U-Boot, so do we really need to
> > > move all this into DT and add this extra overhead?
> >
> > There would not be so much overhead if Linux kernel used numbers for
> > pin definitions, not strings.
>
> Well, yes, this is the right direction. One of the goals is to be able
> to use the linux device trees as-is and be able to pass that along to
> the OS to use. And so we move a little away from the absolute thinnest
> case that we used to be and a bit more towards a generic case just like
> Linux did. In some cases, one can just change the device tree passed to
> U-Boot and re-use the same binary. And if Tegra platforms moved in that
> direction that's nice too.
>
> --
> Tom

Tom and Thierry.
I have examined the size increase of the produced u-boot binary.

With only conversion code binary size increased by around 15 kb (based
on cardhu board examination). While, if dts conversion is performed as
well I have got a 27.5 kb binary increase (based on lg-x3 board
examination). Yes, this is a lot so it is up to you to decide if these
patches should be implemented in any way or if they should be
rejected.

From my perspective this increase is acceptable since even the oldest
devices should have 2 mb of bootloader size reserved. Devices I own
can easily have a 2 mb bootloader extendable to 3.5 mb and even
further if use stages. Same time header pinmux setup is preserved and
DM wrapper should protect Tegra from being dropped as it was in case
of timer DM conversion.

Best regards,
Svyatoslav R.
