Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F114AC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 06:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F868786E;
	Fri, 26 Jan 2024 07:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hS8Wxq2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C61C87897; Fri, 26 Jan 2024 07:07:15 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68EFA87801
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 07:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-21424f34003so28112fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 22:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706249231; x=1706854031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2OoPgC3cZRZDCEBgM2//JYGHvmZDvA4DfE0icwMINKA=;
 b=hS8Wxq2pu7aw6Igh/q0RXhb9f3NjKDVnIwAE5bIzSAnknXGpGYQDOqJ0YqVMq/aiJh
 Gef1cpp0KPMMqpoHhWH3i/H023ojttAMj7mbKxx9OwQc/y3pvhexHN1SVk/O4+75DAYa
 S+xGBbGnbPw+spvUl7/nRdNwmTD1OziolB5qyG6dI42D/27JOFW8ke8QQkvdQSjqzq8J
 YVXsWU+8K/hHDddbibOosf2Pw5XKy4fUR8SMCirujPzGi1cFRY1oHhXy3B8JfyujP5/Y
 gjseVa1PBCrwRYPRgmHBYGoXsAM5OClGHRU2UrrCqyTp71sfsQ/gpxaesyPaekQ6VxcG
 AEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706249231; x=1706854031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2OoPgC3cZRZDCEBgM2//JYGHvmZDvA4DfE0icwMINKA=;
 b=FXk8RaXcaIY5Fgz2f8U0vCShaJbJt1ko7QTBg50E1gPiT9ob7oR2caNu0NjdX5AnOP
 /Jl91KWQqyadp+86xURpETrl4j1bUkT66Nj2jupRW6uEHkiUKo1ax7Z5kyegH7cdfl0G
 HyIBnVvWHNCJVVXTi847aFtYVDh35D55SSxyswyFCDFkPtaf4ZQLEpE9fx18BBTnSo/s
 eqjuFmHNriI/hC7no1xLpgYyySWKhgfCbDjLy5FV9HMqiAANuOEIaCqSIttt+XTz95hP
 7rw6Pvy0GnzGtNDYG+z2mn3FZ8ZhXUSXh6kxS/S9uMayDvPeiBtzpRmEfj+Pb5jxrH7Z
 U/Ig==
X-Gm-Message-State: AOJu0YzVZ2MjylBiMwvnHagbm3bkcm1Og0VroyiINT/WMOb9VzvKLx6r
 ZRxIPeG6BFlxQy3iKDgAg2B8G4qHTxtDaEKozs5CnpD9mNW7WpFy9TrDA3UT9aXjmYUlfQEh5MU
 suLwOZMyZ2hGhkiH8TMoyNe14y3o=
X-Google-Smtp-Source: AGHT+IFwk6ZgO9IaVWFyTtriv0SgYsTcNUuetYTbWYtoyYZtuzUukuzdLS5VvKzr5KoSarX+n5YRbQS5rmJ7sxZYtj8=
X-Received: by 2002:a05:6870:219c:b0:210:7a6e:1042 with SMTP id
 l28-20020a056870219c00b002107a6e1042mr803944oae.119.1706249230775; Thu, 25
 Jan 2024 22:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
 <CAPLW+4kdpQZtwmXH6kGqOOkXqzniagiaQHzVwP6zKBZ7Ze0ZFQ@mail.gmail.com>
In-Reply-To: <CAPLW+4kdpQZtwmXH6kGqOOkXqzniagiaQHzVwP6zKBZ7Ze0ZFQ@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 26 Jan 2024 15:06:59 +0900
Message-ID: <CALrBrZ2JgyG8L4Xdm36jz9-VhZYB8GY1G+qb5WGvx7k5BS_qOQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] arm: exynos: Add E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On Tue, 23 Jan 2024 at 04:52, Sam Protsenko <semen.protsenko@linaro.org>
wrote:

> Hey Tom, Minkyu,
>
> If there are no outstanding concerns about this series, can you please
> apply it?
>
> Thanks!
>
> On Wed, Jan 10, 2024 at 9:09=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > Add Exynos850 SoC and WinLink's E850-96 board support. A short overview
> > of series additions and modifications:
> >   * USI driver: configures UART block
> >   * PMU driver: connects AP UART lines to uart1 pins)
> >   * Exynos850 clock driver: generates UART clocks
> >   * Exynos850 pinctrl driver: mux UART pins
> >   * serial_s5p: UART driver
> >   * Exynos850 SoC: dtsi files and MMU maps
> >   * E850-96 board: dts files, defconfig, board file and doc
> >
> > Most of the code was borrowed from mainline Linux kernel (where this
> > board is already enabled) and adapted for U-Boot. Preliminary
> > preparation for this series includes next patches / series (already
> > merged):
> >
> >   * commit 585a2aaac2ac ("arm: exynos: Include missing CPU header in
> >                           soc.c")
> >   * commit c9ab9f30c8e4 ("arm: exynos: Include missing CPU header in
> >                           gpio.h")
> >   * commit 11bd2787deff ("watchdog: s5p_wdt: Include missing CPU
> >                           header")
> >   * commit 08cfa971a717 ("exynos: Avoid duplicate reset_cpu with
> >                           SYSRESET enabled")
> >   * commit f655090901dc ("clk: exynos: Add header guard for clk-pll.h")
> >   * commit 2227f4c0afed ("serial: s5p: Fix clk_get_by_index() error cod=
e
> >                           check")
> >   * commit a0615ffc99a5 ("serial: s5p: Remove common.h inclusion")
> >   * commit 5ad21de6bae0 ("serial: s5p: Use livetree API to get "id"
> >                           property")
> >   * commit e79f630dbf67 ("serial: s5p: Use named constants for register
> >                           values")
> >   * commit a627f2802a71 ("serial: s5p: Improve coding style")
> >   * commit 33e7ca5a9b6a ("serial: s5p: Use dev_read_addr_ptr() to get
> >                           base address")
> >   * commit 6219b47c4d91 ("board: samsung: Fix SYS_CONFIG_NAME configs i=
n
> >                           axy17lte Kconfig")
> >   * commit 470682ace1e0 ("configs: Remove unneeded SYS_CONFIG_NAME from
> >                           a*y17lte defconfigs")
> >
> > and series [1]. For more detailed description please see the board
> > documentation (added in PATCH #12) and corresponding commit messages.
> >
> > Changes in v2:
> >   - PATCH 4: Removed unnecessary mode param
> >   - PATCH 4: Removed usi->dev and used priv data instead
> >   - PATCH 4: Used .of_plat_data callback for dts parsing
> >   - PATCH 7: Fixed Thomas Abraham e-mail
> >   - PATCH 9: Fixed incorrect driver description (comment)
> >   - Collected Reviewed-by tags
> >   - Rebased on top of most recent U-Boot/master
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2023-November/539033.html
> >
> > Sam Protsenko (13):
> >   dt-bindings: soc: samsung: Add Exynos USI
> >   dt-bindings: soc: samsung: Add Exynos PMU
> >   dt-bindings: clock: Add Exynos850 clock controller
> >   soc: samsung: Add Exynos USI driver
> >   soc: samsung: Add Exynos PMU driver
> >   clk: exynos: Move pll code into clk-exynos7420
> >   clk: exynos: Add Samsung clock framework
> >   clk: exynos: Add Exynos850 clock driver
> >   pinctrl: exynos: Add pinctrl support for Exynos850
> >   serial: s5p: Add Exynos850 compatible
> >   arm: exynos: Add Exynos850 SoC support
> >   board: samsung: Add support for E850-96 board
> >   MAINTAINERS: Add new Samsung subsystems
> >
> >  MAINTAINERS                                   |   25 +
> >  arch/arm/dts/Makefile                         |    1 +
> >  arch/arm/dts/exynos-pinctrl.h                 |   79 +
> >  arch/arm/dts/exynos850-e850-96-u-boot.dtsi    |   37 +
> >  arch/arm/dts/exynos850-e850-96.dts            |  273 ++++
> >  arch/arm/dts/exynos850-pinctrl.dtsi           |  663 +++++++++
> >  arch/arm/dts/exynos850.dtsi                   |  809 +++++++++++
> >  arch/arm/mach-exynos/Kconfig                  |   28 +-
> >  arch/arm/mach-exynos/mmu-arm64.c              |   34 +
> >  board/samsung/e850-96/Kconfig                 |   16 +
> >  board/samsung/e850-96/MAINTAINERS             |    9 +
> >  board/samsung/e850-96/Makefile                |    6 +
> >  board/samsung/e850-96/e850-96.c               |   22 +
> >  configs/e850-96_defconfig                     |   21 +
> >  doc/board/samsung/e850-96.rst                 |   87 ++
> >  .../img/exynos850-boot-architecture.svg       | 1283 +++++++++++++++++
> >  doc/board/samsung/index.rst                   |    1 +
> >  .../clock/samsung,exynos850-clock.yaml        |  307 ++++
> >  .../soc/samsung/exynos-pmu.yaml               |   85 ++
> >  .../soc/samsung/exynos-usi.yaml               |  162 +++
> >  drivers/clk/exynos/Kconfig                    |    7 +
> >  drivers/clk/exynos/Makefile                   |   11 +-
> >  drivers/clk/exynos/clk-exynos7420.c           |   25 +-
> >  drivers/clk/exynos/clk-exynos850.c            |  189 +++
> >  drivers/clk/exynos/clk-pll.c                  |  167 ++-
> >  drivers/clk/exynos/clk-pll.h                  |   16 +-
> >  drivers/clk/exynos/clk.c                      |  121 ++
> >  drivers/clk/exynos/clk.h                      |  228 +++
> >  drivers/pinctrl/exynos/Kconfig                |    8 +
> >  drivers/pinctrl/exynos/Makefile               |    1 +
> >  drivers/pinctrl/exynos/pinctrl-exynos850.c    |  125 ++
> >  drivers/serial/serial_s5p.c                   |    1 +
> >  drivers/soc/Kconfig                           |    1 +
> >  drivers/soc/Makefile                          |    1 +
> >  drivers/soc/samsung/Kconfig                   |   33 +
> >  drivers/soc/samsung/Makefile                  |    4 +
> >  drivers/soc/samsung/exynos-pmu.c              |  102 ++
> >  drivers/soc/samsung/exynos-usi.c              |  208 +++
> >  include/configs/e850-96.h                     |   12 +
> >  include/dt-bindings/clock/exynos850.h         |  337 +++++
> >  include/dt-bindings/soc/samsung,exynos-usi.h  |   17 +
> >  41 files changed, 5538 insertions(+), 24 deletions(-)
> >  create mode 100644 arch/arm/dts/exynos-pinctrl.h
> >  create mode 100644 arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/exynos850-e850-96.dts
> >  create mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
> >  create mode 100644 arch/arm/dts/exynos850.dtsi
> >  create mode 100644 board/samsung/e850-96/Kconfig
> >  create mode 100644 board/samsung/e850-96/MAINTAINERS
> >  create mode 100644 board/samsung/e850-96/Makefile
> >  create mode 100644 board/samsung/e850-96/e850-96.c
> >  create mode 100644 configs/e850-96_defconfig
> >  create mode 100644 doc/board/samsung/e850-96.rst
> >  create mode 100644 doc/board/samsung/img/exynos850-boot-architecture.s=
vg
> >  create mode 100644
> doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
> >  create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-pmu.yam=
l
> >  create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yam=
l
> >  create mode 100644 drivers/clk/exynos/clk-exynos850.c
> >  create mode 100644 drivers/clk/exynos/clk.c
> >  create mode 100644 drivers/clk/exynos/clk.h
> >  create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c
> >  create mode 100644 drivers/soc/samsung/Kconfig
> >  create mode 100644 drivers/soc/samsung/Makefile
> >  create mode 100644 drivers/soc/samsung/exynos-pmu.c
> >  create mode 100644 drivers/soc/samsung/exynos-usi.c
> >  create mode 100644 include/configs/e850-96.h
> >  create mode 100644 include/dt-bindings/clock/exynos850.h
> >  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> >
> > --
> > 2.39.2
> >
>

applied to u-boot-samsung

--=20
Thanks,
Minkyu Kang.
