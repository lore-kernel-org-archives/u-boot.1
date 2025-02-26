Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC92C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CD280F12;
	Wed, 26 Feb 2025 18:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJh+gCRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB078807FB; Wed, 26 Feb 2025 18:32:58 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876D6807FB
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so5351171276.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591175; x=1741195975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CcoMeCfNWD/es0k+fj0eFo1DlfO5zDx+XgdONwMwUgI=;
 b=dJh+gCRgWdNPfxcV0d+5RoapCgaYCruQzprpymp65TDo3cXGhRQkGSMj9rokHoZp3g
 9sUuVU5+iS27oWiYAmv5jFimHEi3V8U+/mBCVrU11AptjJchhVJjVEJlONUf9TZ7Fo+3
 mrFLeEwjTyd+onI+gEcAxGitj51G0v4f0lf5zwCmIj7KQmFMH5gAWrZSMe0cY+hQ65V7
 HNRCPaScsarxWLW9Y/R065+w9PDANMqbEm1kht54f7m+ItBr1qIMI/1puuA6zHO4Vw0H
 tQNLPyuafyz2JI7eSYDhqV6cDG1LOH7Fca7N2MTbJhrv29ZLPIenZkl+m1MZjkMikTen
 73xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591175; x=1741195975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcoMeCfNWD/es0k+fj0eFo1DlfO5zDx+XgdONwMwUgI=;
 b=SiuP+R6uR+ljDZzuoKWJbaZSnSW2uk3FCvqLvFcLNxJ51VwY2ewCSYZOypjNEJh/Dq
 fq+ueWAACUxt4lLaTDo2d7yi37sxxIiMeIQ4ioeVnYWvs+gtZH8EZ64GApSpKDhApBzr
 h4AKIhIjKCAZsB60orfOsgR9rNV47LrUqlgo+N7oFGXQjTeaM2QbqJl6ZjsEuaoO3lzN
 2Ne9ROFBe1kibDD+bnOsQhE8ICxbry5TtR9FMVV9UdWTk4pe6AWcAr4V3QiCCi5c3WlP
 lQ8Hrosu7RCTZKzH1rCsLfzjI0CW/8L/CkooiApc5Zo0uwp4UhNUxrhQfJhcgK+hqWtT
 2pEA==
X-Gm-Message-State: AOJu0YyC4ERneTkerm/aauENxYm8uUlRzbcA7OI0yC8xn6K7Hj8yvP5Z
 +HG4I2b3Kloft+rOdITUk14UHClC2mCnilz4cw8yptzLPJau+FT+WsEXk1A=
X-Gm-Gg: ASbGnctPxfASM7kkC7SHd0+EbmvUSntb1/9WBQ9R3MlEbIyi4OSkbvmb8qPJVvsgOQp
 BLQGX4aHezXykblfgNOWIZPVt8VHkzUcIsO0+RdjzlbQJaGKSPI1BF3EWcLarI/etmu9IWPQrM3
 +nasXGwUbxytKd0mGMrppO+TTN0ebNRr3B4xkmHrF6kXRRqGR3OKJvpC4D2VqmWxcCJNpwy2c/s
 nx9QIauUSHf+6W4LkXbJp9MDKKHlzs/ycIKa2egPuROeyX4JW4KSEMEtPjXEqqDT0ifhVwLEa/6
 sGO9hWaUKZ/cayyrVq6HrVKwl8vrAgANv9CSQxnVDw==
X-Google-Smtp-Source: AGHT+IGEHZCaIA2BY/6AAHe2l+wJhye8eqchgpVeEtwuu6r1nmJ094O0M+14gVCCGWY+ZS650jdOCA==
X-Received: by 2002:a05:6902:124e:b0:e5d:ac56:c3cd with SMTP id
 3f1490d57ef6-e608a6b723amr3437350276.14.1740591174658; 
 Wed, 26 Feb 2025 09:32:54 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:54 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 David Virag <virag.david003@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Erik Schumacher <erik.schumacher@iris-sensing.com>,
 Fabio Estevam <festevam@gmail.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 John Watts <contact@jookia.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 MD Danish Anwar <danishanwar@ti.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Markus Gothe <markus.gothe@genexis.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 00/12] drivers: Driver support for ADI SC5xx SoCs
Date: Wed, 26 Feb 2025 12:30:22 -0500
Message-ID: <20250226173150.13198-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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


This series adds all of the supported peripheral drivers for the sc5xx
series of SoCs from Analog Devices and other drivers that are used by
the evaluation kits, such as a GPIO expander used by the EZLITE carrier
boards. This series passes gitlab CI tests.

Changes in v3:
- Add check if PORT peripheral base address was mapped successfully
- replace read*/write* with ioread* and iowrite* and friends across all
  drivers
- update for compatibility with changes to dwc qos driver between 2024.04
  and 2025.01
- (spi) Primarily addressed issues identified in earlier feedback:
  - Removed unused pins and memory_map priv members
  - Added __iomem to device mmio pointers
  - Replaced readl/writel calls with iowrite32/ioread32 and friends
  - Added map_sysmem() call to prepare device mmio pointer
- (sdhci) Removed struct adi_sdhc and replaced with the struct that was its
  only member

Changes in v2:
- Clean up some whitespace errors
- Modify Kconfigs to reflect changes to mach-sc5xx/Kconfig

Greg Malysa (5):
  pinctrl: Add support for ADI SC5XX-family pinctrl
  doc: Add dt-bindings and descriptions for ADI SC5xx-family pinctrl
  gpio: Add support for SC5XX-family processor GPIO driver
  net: Add support for ADI SC5xx SoCs with DWC QoS ethernet
  dma: Add driver for ADI SC5xx-family SoC MDMA functionality

Nathan Barrett-Morrison (7):
  gpio: Add support for ADI ADP5588 GPIO expander chips
  usb: musb-new: Add support for Analog Devices SC5xx SoCs
  i2c: Add support for ADI SC5XX-family I2C peripheral
  watchdog: Add support for ADI SC5XX-family watchdog peripheral
  remoteproc: Add in SHARC loading for ADI SC5XX-family processors
  spi: Add support for ADI SC5XX-family processor SPI peripherals
  mmc: Add support for ADI SC5XX-family processor SDHCI peripherals

 MAINTAINERS                                   |  13 +
 .../pinctrl/adi,adsp-pinctrl.yaml             |  73 ++
 drivers/dma/Kconfig                           |   7 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/adi_dma.c                         | 253 +++++++
 drivers/gpio/Kconfig                          |  17 +
 drivers/gpio/Makefile                         |   2 +
 drivers/gpio/adp5588_gpio.c                   | 208 ++++++
 drivers/gpio/gpio-adi-adsp.c                  | 179 +++++
 drivers/i2c/Kconfig                           |   7 +
 drivers/i2c/Makefile                          |   1 +
 drivers/i2c/adi_i2c.c                         | 386 ++++++++++
 drivers/mmc/Kconfig                           |   9 +
 drivers/mmc/Makefile                          |   1 +
 drivers/mmc/adi_sdhci.c                       | 148 ++++
 drivers/net/Kconfig                           |   7 +
 drivers/net/Makefile                          |   1 +
 drivers/net/dwc_eth_qos.c                     |   6 +
 drivers/net/dwc_eth_qos.h                     |   2 +
 drivers/net/dwc_eth_qos_adi.c                 | 103 +++
 drivers/pinctrl/Kconfig                       |   8 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c            | 161 +++++
 drivers/remoteproc/Kconfig                    |  11 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/adi_sc5xx_rproc.c          | 277 +++++++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/adi_spi3.c                        | 679 ++++++++++++++++++
 drivers/usb/musb-new/Kconfig                  |   7 +
 drivers/usb/musb-new/Makefile                 |   1 +
 drivers/usb/musb-new/sc5xx.c                  | 202 ++++++
 drivers/watchdog/Kconfig                      |   9 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/adi_wdt.c                    | 143 ++++
 include/dt-bindings/pinctrl/adi-adsp.h        |  21 +
 36 files changed, 2954 insertions(+)
 create mode 100644 doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 create mode 100644 drivers/dma/adi_dma.c
 create mode 100644 drivers/gpio/adp5588_gpio.c
 create mode 100644 drivers/gpio/gpio-adi-adsp.c
 create mode 100644 drivers/i2c/adi_i2c.c
 create mode 100644 drivers/mmc/adi_sdhci.c
 create mode 100644 drivers/net/dwc_eth_qos_adi.c
 create mode 100644 drivers/pinctrl/pinctrl-adi-adsp.c
 create mode 100644 drivers/remoteproc/adi_sc5xx_rproc.c
 create mode 100644 drivers/spi/adi_spi3.c
 create mode 100644 drivers/usb/musb-new/sc5xx.c
 create mode 100644 drivers/watchdog/adi_wdt.c
 create mode 100644 include/dt-bindings/pinctrl/adi-adsp.h

-- 
2.45.2

