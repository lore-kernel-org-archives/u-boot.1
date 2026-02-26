Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABE6FC5930
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 11:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F82D83E63;
	Thu, 26 Feb 2026 12:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="nj4alNXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A072E83AA9; Thu, 26 Feb 2026 12:11:50 +0100 (CET)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0E583642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772104306; x=1772363506;
 bh=Fzr2JfjXTE/UIbW1npCMLvUFD5T2+U6GSfKYLM0Ojbs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nj4alNXjkP7Ir8v/fD8uagcAq68aue24aig7EjK0KUWdlRRSTpvi06wSJ/eFwZsHb
 ulsZO3HPop6nairMHrv7bVCx8E/b1WWYhkBeCASApFieNvQLZ1fUezndT9LqYHANT4
 7CtVZ0bEhApKPABYBwugnnf2TKfOR7CoABXpcqRn+zbRHMRfT2T8s6qDaNfx6hpfzp
 9YYXznjhLlaCjEkI/yXH87tg3hFmv5xHDLwUwBhJJ9lTHZAc/THwB6Khjwzz+cmz1j
 YYpqs/DlEjEQUopHe/7q7DJY8fSzcfQQhTL8qulNzxCrQ6RsUOr0EjwnVXT/hDTg8Y
 w16tLlj0um8WQ==
Date: Thu, 26 Feb 2026 11:11:42 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip@philipmolloy.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, E Shattow <e@freeshell.de>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
Subject: [PATCH 0/2] MAINTAINERS: Update ADI ADSP platform maintainers
Message-ID: <20260226111136.354009-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: c7b7faee33c9243999daebfe528e56f791a747d8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This series updates the maintainers for the ADI ADSP platform. It
follows Greg's series adding support for ADI ADSP SoCs.[1]

Timesys spent years developing and maintaining Linux support for ADI
ADSP SoCs. The maintenance contract has ended and ADI has brought
that effort in-house. Additionally, Timesys was acquired by another
company.

Thanks to everyone at Timesys for all of their hard work over the years!

[1]: https://lore.kernel.org/u-boot/176920759551.2792764.439374450249464601=
9.b4-ty@konsulko.com/

Philip Molloy (2):
  MAINTAINERS: Update ARM SC5xx
  treewide: Remove Timesys from ADI ADSP maintenance

 MAINTAINERS                                  | 7 ++-----
 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 4 +---
 arch/arm/include/asm/arch-adi/sc5xx/soc.h    | 4 +---
 arch/arm/include/asm/arch-adi/sc5xx/spl.h    | 4 +---
 arch/arm/mach-sc5xx/Kconfig                  | 5 +----
 arch/arm/mach-sc5xx/Makefile                 | 5 +----
 arch/arm/mach-sc5xx/config.mk                | 5 +----
 arch/arm/mach-sc5xx/init/Makefile            | 5 +----
 arch/arm/mach-sc5xx/init/clkinit.c           | 4 +---
 arch/arm/mach-sc5xx/init/clkinit.h           | 4 +---
 arch/arm/mach-sc5xx/init/dmcinit.c           | 4 +---
 arch/arm/mach-sc5xx/init/dmcinit.h           | 4 +---
 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h | 4 +---
 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h | 4 +---
 arch/arm/mach-sc5xx/rcu.c                    | 3 +--
 arch/arm/mach-sc5xx/sc57x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc58x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc59x.c                  | 4 +---
 arch/arm/mach-sc5xx/sc59x_64.c               | 4 +---
 arch/arm/mach-sc5xx/soc.c                    | 4 +---
 arch/arm/mach-sc5xx/spl.c                    | 4 +---
 drivers/clk/adi/Kconfig                      | 5 +----
 drivers/clk/adi/Makefile                     | 5 +----
 drivers/clk/adi/clk-adi-pll.c                | 2 +-
 drivers/clk/adi/clk-adi-sc57x.c              | 2 +-
 drivers/clk/adi/clk-adi-sc58x.c              | 2 +-
 drivers/clk/adi/clk-adi-sc594.c              | 2 +-
 drivers/clk/adi/clk-adi-sc598.c              | 2 +-
 drivers/clk/adi/clk-shared.c                 | 2 +-
 drivers/clk/adi/clk.h                        | 2 +-
 drivers/dma/adi_dma.c                        | 5 +----
 drivers/gpio/adp5588_gpio.c                  | 4 +---
 drivers/gpio/gpio-adi-adsp.c                 | 3 +--
 drivers/i2c/adi_i2c.c                        | 4 +---
 drivers/mmc/adi_sdhci.c                      | 4 +---
 drivers/net/dwc_eth_qos_adi.c                | 3 +--
 drivers/pinctrl/pinctrl-adi-adsp.c           | 3 +--
 drivers/remoteproc/adi_sc5xx_rproc.c         | 4 +---
 drivers/serial/serial_adi_uart4.c            | 4 +---
 drivers/spi/adi_spi3.c                       | 6 +-----
 drivers/timer/adi_sc5xx_timer.c              | 3 +--
 drivers/usb/musb-new/sc5xx.c                 | 2 +-
 drivers/watchdog/adi_wdt.c                   | 4 +---
 include/dt-bindings/clock/adi-sc5xx-clock.h  | 4 +---
 include/dt-bindings/pinctrl/adi-adsp.h       | 4 +---
 47 files changed, 48 insertions(+), 131 deletions(-)

--=20
2.52.0

base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d

