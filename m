Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B14C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424E087527;
	Wed, 20 Dec 2023 09:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DBevjMLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1534F87530; Wed, 20 Dec 2023 09:07:22 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A3B8744F
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d05ebe642so2424805e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 00:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703059639; x=1703664439; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXXdgTeqljSRucGStyH795FlCqj+fw4SfIbJM0iFVuM=;
 b=DBevjMLGjjqOaxAFXrv2JdnSemnv8mGe+qDp6ylCZdp/6SvIMJTPPR949HipYPAQbM
 a0D0cCjWru1UItEPAaye4F89iQC/4SDETQLyRnH+UHTT5Lcmo1zQU7silPFqJVcvrMh7
 zd/9WPsmEoTAa4N29EVmoWN2m0A0WZxeESlXUCh6jCoLbDycrcvS8ec0BIgMpzBPQPmc
 2PX54jpOPFB9pe+kwx1Rzf+CpkIo1YSna1RZyr0slltsqUUujbrvwSu2NHhvvwqe7UX7
 HFF0nQjdmk89y5JJ4vNkLJ/3goMMw9PgPb5GNDXUMCH2b6X1pJXda6V4Z0ybJZr4P5M/
 WIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703059639; x=1703664439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXXdgTeqljSRucGStyH795FlCqj+fw4SfIbJM0iFVuM=;
 b=RcXZTo88KfI9dICagZjzhtwApmEKPaRXMWLyQZT4Hk5enI8EqMQPyQHbiELPg5A/2r
 zVEauvp5ZQl2+cyWRW9T/BZO9P1HhiuTt7ghlwN28Gpn18UJjSgQhs41LaKjkUhVSbI/
 hc8PZzImdnhiSGvaT9RXnqhpRNBBFs+COq4qNPSd0f53QW5u7ydcUMb9qSdMJndDoYzA
 W5rWi2YuAUg8mOfBYfN6EecOvEm85n2dBbnvd8HuvuM9J2zFTNQWHGrPCbIQ5N+VLtFq
 x0nzK6siAnjOL01ZSpJmyB2J8V1XIyVZLuaRQg0gQcZnRxq6q24sa4bB/KB4R+zmdWr6
 YuyQ==
X-Gm-Message-State: AOJu0YxnDwKL7+7ujX0XyJ52ySMY9pYp7HQKBdzpcwemCIpImt+MXnEU
 ub0POU3ykZFm+kg0U1RaGcDexRz6PtCeCAVoyuU=
X-Google-Smtp-Source: AGHT+IFRpxP/tGID5bqFIPRNwJTcjYXpG+blAKFYXOtJxCj9UKaLl99qDpBU3+3s68Hylr66MDnw1ctSOH9HhjTk8Cw=
X-Received: by 2002:a7b:c409:0:b0:40c:6e98:7c50 with SMTP id
 k9-20020a7bc409000000b0040c6e987c50mr1373532wmi.165.1703059638711; Wed, 20
 Dec 2023 00:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20231219201353.433090-1-clamor95@gmail.com>
In-Reply-To: <20231219201353.433090-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 Dec 2023 10:07:07 +0200
Message-ID: <CAPVz0n3q6k5zWcE38RTv=hbXxW6Faq85GDZXLU9m542mRQOQKQ@mail.gmail.com>
Subject: Re: Please pull u-boot-tegra staging
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

=D0=B2=D1=82, 19 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 22:1=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Dear Tom,
>
> The following changes since commit 936d0f9dd713a913fe952eae576c893e1d5ecb=
d1:
>
>   Merge patch series "Fix J7200 kernel boot when using upstream u-boot" (=
2023-12-19 11:42:03 -0500)
>
> are available in the Git repository at:
>
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>
> for you to fetch changes up to 4989628c1d2b6ea19a38aae34b1c08b12141c64b:
>
>   board: compal: paz00: clean up the board (2023-12-19 21:24:30 +0200)
>
> ----------------------------------------------------------------
> Peter Geis (1):
>       mmc: tegra: use max-frequency from device tree if provided
>
> Svyatoslav Ryhel (14):
>       drivers: gpio: implement MAX77663 GPIO cell
>       drivers: gpio: implement PALMAS GPIO cell
>       drivers: gpio-uclass: support PMIC GPIO children
>       ARM: tegra: clock: support get and set rate for simple PLL
>       ARM: tegra30: clock: implement PLLD2 support
>       ARM: tegra114: clock: implement PLLD2 support
>       ARM: mach-tegra: rearrange SPL configs
>       drivers: pinctrl: create Tegra DM pinctrl driver
>       drivers: pinctrl: tegra: incorporate existing code
>       board: asus: grouper: switch to DM pinmux
>       board: lg: x3-t30: switch to DM pinmux
>       board: asus: transformer: switch to DM pinmux
>       board: htc: endeavoru: switch to DM pinmux
>       board: compal: paz00: clean up the board
>
>  arch/arm/dts/tegra20-paz00.dts                                          =
   |    4 +-
>  arch/arm/dts/tegra30-asus-grouper-common.dtsi                           =
   |  712 +++++++++++++++++++++
>  arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts                      =
   |  113 ++++
>  arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts                      =
   |  113 ++++
>  arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts                      =
   |  149 +++++
>  arch/arm/dts/tegra30-asus-p1801-t.dts                                   =
   |  982 +++++++++++++++++++++++++++++
>  arch/arm/dts/tegra30-asus-tf201.dts                                     =
   |   45 ++
>  arch/arm/dts/tegra30-asus-tf300t.dts                                    =
   |   45 ++
>  arch/arm/dts/tegra30-asus-tf300tg.dts                                   =
   |  128 ++++
>  arch/arm/dts/tegra30-asus-tf300tl.dts                                   =
   |  163 +++++
>  arch/arm/dts/tegra30-asus-tf600t.dts                                    =
   |  889 ++++++++++++++++++++++++++
>  arch/arm/dts/tegra30-asus-tf700t.dts                                    =
   |   53 ++
>  arch/arm/dts/tegra30-asus-transformer.dtsi                              =
   |  984 +++++++++++++++++++++++++++++
>  arch/arm/dts/tegra30-htc-endeavoru.dts                                  =
   | 1147 ++++++++++++++++++++++++++++++++++
>  arch/arm/dts/tegra30-lg-p880.dts                                        =
   |   90 +++
>  arch/arm/dts/tegra30-lg-p895.dts                                        =
   |   93 +++
>  arch/arm/dts/tegra30-lg-x3.dtsi                                         =
   |  845 +++++++++++++++++++++++++
>  arch/arm/include/asm/arch-tegra/clk_rst.h                               =
   |    3 +-
>  arch/arm/include/asm/arch-tegra114/clock-tables.h                       =
   |    2 +-
>  arch/arm/include/asm/arch-tegra114/pinmux.h                             =
   |  303 +++++++++
>  arch/arm/include/asm/arch-tegra124/pinmux.h                             =
   |  327 ++++++++++
>  arch/arm/include/asm/arch-tegra20/pinmux.h                              =
   |  291 +++++++++
>  arch/arm/include/asm/arch-tegra210/pinmux.h                             =
   |  394 ++++++++++++
>  arch/arm/include/asm/arch-tegra30/clock-tables.h                        =
   |    2 +-
>  arch/arm/include/asm/arch-tegra30/pinmux.h                              =
   |  381 +++++++++++
>  arch/arm/mach-tegra/Kconfig                                             =
   |   16 +-
>  arch/arm/mach-tegra/Makefile                                            =
   |    1 -
>  arch/arm/mach-tegra/board.c                                             =
   |    6 +-
>  arch/arm/mach-tegra/board2.c                                            =
   |    2 +-
>  arch/arm/mach-tegra/clock.c                                             =
   |   78 ++-
>  arch/arm/mach-tegra/tegra114/Makefile                                   =
   |    2 +-
>  arch/arm/mach-tegra/tegra114/clock.c                                    =
   |   22 +
>  arch/arm/mach-tegra/tegra124/Makefile                                   =
   |    2 -
>  arch/arm/mach-tegra/tegra124/clock.c                                    =
   |   12 +-
>  arch/arm/mach-tegra/tegra20/Makefile                                    =
   |    2 +-
>  arch/arm/mach-tegra/tegra20/clock.c                                     =
   |   15 +
>  arch/arm/mach-tegra/tegra210/Makefile                                   =
   |    1 -
>  arch/arm/mach-tegra/tegra210/clock.c                                    =
   |   15 +
>  arch/arm/mach-tegra/tegra30/Makefile                                    =
   |    2 +-
>  arch/arm/mach-tegra/tegra30/clock.c                                     =
   |   22 +
>  board/asus/grouper/grouper.c                                            =
   |   18 -
>  board/asus/grouper/pinmux-config-grouper.h                              =
   |  362 -----------
>  board/asus/transformer-t30/pinmux-config-transformer.h                  =
   |  365 -----------
>  board/asus/transformer-t30/transformer-t30.c                            =
   |   23 -
>  board/compal/paz00/Makefile                                             =
   |    8 -
>  board/compal/paz00/paz00.c                                              =
   |   53 --
>  board/htc/endeavoru/endeavoru.c                                         =
   |   14 -
>  board/htc/endeavoru/pinmux-config-endeavoru.h                           =
   |  362 -----------
>  board/lg/x3-t30/Kconfig                                                 =
   |   12 -
>  board/lg/x3-t30/configs/p880.config                                     =
   |    1 -
>  board/lg/x3-t30/configs/p895.config                                     =
   |    1 -
>  board/lg/x3-t30/pinmux-config-x3.h                                      =
   |  449 -------------
>  board/lg/x3-t30/x3-t30.c                                                =
   |   23 -
>  configs/paz00_defconfig                                                 =
   |    3 +
>  drivers/gpio/Kconfig                                                    =
   |   16 +
>  drivers/gpio/Makefile                                                   =
   |    2 +
>  drivers/gpio/gpio-uclass.c                                              =
   |   20 +
>  drivers/gpio/max77663_gpio.c                                            =
   |  178 ++++++
>  drivers/gpio/palmas_gpio.c                                              =
   |  132 ++++
>  drivers/mmc/tegra_mmc.c                                                 =
   |    2 +-
>  drivers/pinctrl/Kconfig                                                 =
   |    1 +
>  drivers/pinctrl/Makefile                                                =
   |    1 +
>  drivers/pinctrl/tegra/Kconfig                                           =
   |   18 +
>  drivers/pinctrl/tegra/Makefile                                          =
   |   16 +
>  .../tegra114/funcmux.c =3D> drivers/pinctrl/tegra/funcmux-tegra114.c    =
     |    0
>  .../tegra124/funcmux.c =3D> drivers/pinctrl/tegra/funcmux-tegra124.c    =
     |    0
>  .../tegra20/funcmux.c =3D> drivers/pinctrl/tegra/funcmux-tegra20.c      =
     |    0
>  .../tegra210/funcmux.c =3D> drivers/pinctrl/tegra/funcmux-tegra210.c    =
     |    0
>  .../tegra30/funcmux.c =3D> drivers/pinctrl/tegra/funcmux-tegra30.c      =
     |    0
>  drivers/pinctrl/tegra/pinctrl-tegra.c                                   =
   |  248 ++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c                                 =
   |  177 ++++++
>  {arch/arm/mach-tegra =3D> drivers/pinctrl/tegra}/pinmux-common.c        =
     |    0
>  .../tegra114/pinmux.c =3D> drivers/pinctrl/tegra/pinmux-tegra114.c      =
     |    0
>  .../tegra124/pinmux.c =3D> drivers/pinctrl/tegra/pinmux-tegra124.c      =
     |    0
>  .../mach-tegra/tegra20/pinmux.c =3D> drivers/pinctrl/tegra/pinmux-tegra2=
0.c  |    0
>  drivers/pinctrl/tegra/pinmux-tegra210.c                                 =
   |  190 ++++++
>  .../mach-tegra/tegra30/pinmux.c =3D> drivers/pinctrl/tegra/pinmux-tegra3=
0.c  |    0
>  drivers/power/pmic/max77663.c                                           =
   |    9 +
>  drivers/power/pmic/palmas.c                                             =
   |   10 +-
>  include/configs/x3-t30.h                                                =
   |   13 +-
>  include/dt-bindings/pmic/max77663.h                                     =
   |   18 +
>  include/power/max77663.h                                                =
   |    1 +
>  include/power/palmas.h                                                  =
   |   12 +
>  83 files changed, 9464 insertions(+), 1750 deletions(-)
>  delete mode 100644 board/asus/grouper/pinmux-config-grouper.h
>  delete mode 100644 board/asus/transformer-t30/pinmux-config-transformer.=
h
>  delete mode 100644 board/compal/paz00/Makefile
>  delete mode 100644 board/compal/paz00/paz00.c
>  delete mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h
>  delete mode 100644 board/lg/x3-t30/pinmux-config-x3.h
>  create mode 100644 drivers/gpio/max77663_gpio.c
>  create mode 100644 drivers/gpio/palmas_gpio.c
>  create mode 100644 drivers/pinctrl/tegra/Kconfig
>  create mode 100644 drivers/pinctrl/tegra/Makefile
>  rename arch/arm/mach-tegra/tegra114/funcmux.c =3D> drivers/pinctrl/tegra=
/funcmux-tegra114.c (100%)
>  rename arch/arm/mach-tegra/tegra124/funcmux.c =3D> drivers/pinctrl/tegra=
/funcmux-tegra124.c (100%)
>  rename arch/arm/mach-tegra/tegra20/funcmux.c =3D> drivers/pinctrl/tegra/=
funcmux-tegra20.c (100%)
>  rename arch/arm/mach-tegra/tegra210/funcmux.c =3D> drivers/pinctrl/tegra=
/funcmux-tegra210.c (100%)
>  rename arch/arm/mach-tegra/tegra30/funcmux.c =3D> drivers/pinctrl/tegra/=
funcmux-tegra30.c (100%)
>  create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra.c
>  create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra20.c
>  rename {arch/arm/mach-tegra =3D> drivers/pinctrl/tegra}/pinmux-common.c =
(100%)
>  rename arch/arm/mach-tegra/tegra114/pinmux.c =3D> drivers/pinctrl/tegra/=
pinmux-tegra114.c (100%)
>  rename arch/arm/mach-tegra/tegra124/pinmux.c =3D> drivers/pinctrl/tegra/=
pinmux-tegra124.c (100%)
>  rename arch/arm/mach-tegra/tegra20/pinmux.c =3D> drivers/pinctrl/tegra/p=
inmux-tegra20.c (100%)
>  create mode 100644 drivers/pinctrl/tegra/pinmux-tegra210.c
>  rename arch/arm/mach-tegra/tegra30/pinmux.c =3D> drivers/pinctrl/tegra/p=
inmux-tegra30.c (100%)
>  create mode 100644 include/dt-bindings/pmic/max77663.h
>
>
> Branch contains PMIC GPIO cells bringup, simple PLL support for Tegra and
> DM convertion of Tegra pinmux.
>
> Thanks,
> Svyatoslav Ryhel.

This PR contains 4 patchsets:

1. PMIC GPIO cells bringup. Created drivers for MAX7663 and Palmas
PMICs and gpio-uclass patch isolated behind configs for these 2
drivers. No unintentional size increase on any board. (proposed
2023-11-06 without any reaction)

2. Simple PLL clocks support in common tegra clock code which allows
use of simple PLL the same way main PLLs are used (before only
clock_start_pll was available). PLLD2 is an example of simple PLL, it
is used as a video subsystem parent clock and was used to test this
code. So far everything worked as expected. (proposed 2023-11-16
without any reaction)

3. A small patch for tegra emmc to allow pass max frequency from
device tree since some devices may not support full speed.

4. Pinmux DM conversion. Patchset consists of commit with DM wrapper
for existing pinmux code for t20/t30/t114, pinmux and funcmux files
relocation into a dedicated folder inside pinctrl, conversion of some
tegra boards to device tree pinmux setup.

With only conversion code binary size increased by around 15 kb for
all tegra boards which is connected with pinmux DM enabled and the
wrapper itself. While, if dts conversion is performed as well I have
got a 27.5 kb binary increase (based on lg-x3 board examination).
(proposed 2023-12-04 with ambiguous comments from tagr).

Best regards,
Svyatoslav R.
