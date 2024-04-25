Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FC9C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 00:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5313F88725;
	Thu, 25 Apr 2024 02:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="BbyL+9Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB39C88737; Thu, 25 Apr 2024 02:06:04 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF9588726
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 02:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-61804067da0so4058417b3.0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714003558; x=1714608358;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2RvQKopehkocZn3YNjmvkFmpW8RgEa8B7Uq+Xxxmuew=;
 b=BbyL+9CfCtC3Rl9yQXxTbRxEAPrvQvFJD8QQjUwjFu2DuE1Ab9L7LZiLJ7JZD/Y6Gm
 je/P33LGBKY/fEZOFgD60NlJMV4ZHQ9cIVL8iShNdGnbyxS13qTgEdlT3yqv8JHLlVRG
 JaCZPNfXmQcn7/kl/uesm8wLsSf8Q+XlzePbHpRMt5Ee8YvvsnEhGyb7Rw7xSoKi+1n5
 LpOdH1+QSrm2yn6+9cpi7zcDam8jOEpMrEURKS1n1NtqtV2/3ocWVV4XIePZm51hD/fn
 RNXYlscG9lDfv7haUIXFlY2ASdzkFXFNmtCklDTbUgn0IOfZmbm60w6pL9gkBdMRvulT
 /YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003558; x=1714608358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RvQKopehkocZn3YNjmvkFmpW8RgEa8B7Uq+Xxxmuew=;
 b=Un28flWRERxa2QOQiqqlKMuYcjFCR0VKPODmC5GrU4zTTZLGSTjd0DdwXEWf8w0y8V
 JgcB7lSBKT15nC5ySl7i+RMZqbHc9Fp7chfLUKt27AqZxRrAqEwde/DLx2HTvhtb1i79
 2ZxAAJeu9UCmjHHIgAmSTLtGRTtMEFz+rfVE5lVPeuOTWA0wXU2njSzAOvPwLZ1b0Fw+
 J3hNNm1fwNTHLS2+ARk7tVYjJx9zzvIdFFwjz4ZRr/k+uBeikdhaCXY5pPw3R5kjagFs
 aftSmlkI57Ldk5KzS3s5NPx3OBI1AKs7834tBmroyVjZ8HOv7GPvYEUSkwVauShitzqi
 PNbQ==
X-Gm-Message-State: AOJu0Yw1pO6aYDIWzjSInse9ie/PgBN4d2jLxy/SDGg5d6O1p0X/Ic5E
 5wCwhgNC4pBNvQhWbMA0vb8CIzL0MSJxu1U1Y/HK07KaTdqXZPrt85iPWZEClZL7IuQmFCFZ44+
 48w==
X-Google-Smtp-Source: AGHT+IELMd1ddcPQQ4nVwoDGNK+abGBlkerb+7FZcT8h/J4IaziCcp0uCfO1RX9ZZjhrzUqV7nTE6w==
X-Received: by 2002:a05:690c:f12:b0:61a:b548:93a8 with SMTP id
 dc18-20020a05690c0f1200b0061ab54893a8mr4687668ywb.1.1714003557599; 
 Wed, 24 Apr 2024 17:05:57 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 t201-20020a8183d2000000b0061870c6e41csm3291753ywf.6.2024.04.24.17.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:05:57 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Thomas Chou <thomas@wytron.com.tw>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 0/4] arm: Add Analog Devices SC5xx Machine Type
Date: Wed, 24 Apr 2024 20:03:59 -0400
Message-ID: <20240425000515.21896-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Apr 2024 02:06:59 +0200
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


This series adds support for the ADI SC5xx machine type and includes two
core drivers that are required for being able to boot any board--a UART
driver, the gptimer driver which is used as a clock reference (CNTVCNT
is not supported on the armv7 sc5xx SoCs) and the clock tree driver. Our
corresponding Linux support relies on u-boot configuring the clocks
correctly before booting, so it is not possible to boot any board
without the CGU/CDU configuration happening here. There are also no
board files, device trees, or defconfigs included here, but some common
definitions that will be used to build board files currently are. The
sc5xx SoCs themselves include many armv7 families (sc57x, sc58x, and
sc594) all using an ARM Cortex-A5, and one armv8 family (sc598) indended
to be a drop-in replacement for the SC594 in terms of peripherals, with
a Cortex-A55 instead.

Some of the configuration code in dmcinit and clkinit is quite scary and
causes a lot of checkpatch violations. It is modified from code
initially provided by ADI, but it has not been fully rewritten. There's
a question of how important it is to clean up this code--it has some
quality violations, but it has been in use (including in production) for
over two years and is known to work for performing the low level SoC
initialization, while a rewrite might introduce timing or sequence bugs
that could take a significant amount of time to detect in the future.

Thank you!

Changes in v2:
- Removed MACH_TYPE constants and any references to setting the
  MACH_TYPE as it is not used by this platform
- Removed additional compiler flags from config.mk
- Converted to text env. Each board is expected to provide a text env
  and #include env/adi/adi_boot.env if it wants to use the reference ADI
  boot flow
- Some further cleanup on use of Kconfigs--some per board settings
  affecting dmcinit and clkinit have been converted to Kconfigs instead
  of config header constants
- Converted some #ifdef blocks into soc-specific functions with common
  functionality in soc.c, such as configuring SECUREC0, 1, and 2.
- Reviewed #include usage and pruned unnecessary files
- Passes gitlab CI run locally
- Added gptimer driver to this series because a minimal system can't
  boot without it

Greg Malysa (1):
  drivers: timer: Add in driver support for ADI SC5XX-family GP timer
    peripheral

Nathan Barrett-Morrison (3):
  arch: arm: Add Analog Devices SC5xx machine type
  drivers: clk: adi: Add in SC5XX-family clock driver
  drivers: serial: Add in UART for ADI SC5XX-family processors

 MAINTAINERS                                  |  16 +
 arch/arm/Kconfig                             |   5 +
 arch/arm/Makefile                            |   1 +
 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  |  39 +
 arch/arm/include/asm/arch-adi/sc5xx/soc.h    |  18 +
 arch/arm/include/asm/arch-adi/sc5xx/spl.h    |  43 +
 arch/arm/mach-sc5xx/Kconfig                  | 475 +++++++++
 arch/arm/mach-sc5xx/Makefile                 |  19 +
 arch/arm/mach-sc5xx/config.mk                |  16 +
 arch/arm/mach-sc5xx/init/Makefile            |  11 +
 arch/arm/mach-sc5xx/init/clkinit.c           | 558 +++++++++++
 arch/arm/mach-sc5xx/init/clkinit.h           |  18 +
 arch/arm/mach-sc5xx/init/dmcinit.c           | 954 +++++++++++++++++++
 arch/arm/mach-sc5xx/init/dmcinit.h           |  31 +
 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h |  62 ++
 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h |  50 +
 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h |  50 +
 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h |  49 +
 arch/arm/mach-sc5xx/rcu.c                    |  22 +
 arch/arm/mach-sc5xx/sc57x.c                  |  32 +
 arch/arm/mach-sc5xx/sc58x.c                  |  32 +
 arch/arm/mach-sc5xx/sc59x.c                  |  43 +
 arch/arm/mach-sc5xx/sc59x_64.c               |  97 ++
 arch/arm/mach-sc5xx/soc.c                    | 179 ++++
 arch/arm/mach-sc5xx/spl.c                    | 102 ++
 drivers/clk/Kconfig                          |   1 +
 drivers/clk/Makefile                         |   1 +
 drivers/clk/adi/Kconfig                      |  83 ++
 drivers/clk/adi/Makefile                     |  16 +
 drivers/clk/adi/clk-adi-pll.c                |  93 ++
 drivers/clk/adi/clk-adi-sc57x.c              | 206 ++++
 drivers/clk/adi/clk-adi-sc58x.c              | 222 +++++
 drivers/clk/adi/clk-adi-sc594.c              | 231 +++++
 drivers/clk/adi/clk-adi-sc598.c              | 308 ++++++
 drivers/clk/adi/clk-shared.c                 |  48 +
 drivers/clk/adi/clk.h                        | 123 +++
 drivers/serial/Makefile                      |   1 +
 drivers/serial/serial_adi_uart4.c            | 225 +++++
 drivers/timer/Kconfig                        |   8 +
 drivers/timer/Makefile                       |   1 +
 drivers/timer/adi_sc5xx_timer.c              | 145 +++
 include/dt-bindings/clock/adi-sc5xx-clock.h  | 271 ++++++
 include/env/adi/adi_boot.env                 | 122 +++
 43 files changed, 5027 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/soc.h
 create mode 100644 arch/arm/include/asm/arch-adi/sc5xx/spl.h
 create mode 100644 arch/arm/mach-sc5xx/Kconfig
 create mode 100644 arch/arm/mach-sc5xx/Makefile
 create mode 100644 arch/arm/mach-sc5xx/config.mk
 create mode 100644 arch/arm/mach-sc5xx/init/Makefile
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/clkinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.c
 create mode 100644 arch/arm/mach-sc5xx/init/dmcinit.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h
 create mode 100644 arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h
 create mode 100644 arch/arm/mach-sc5xx/rcu.c
 create mode 100644 arch/arm/mach-sc5xx/sc57x.c
 create mode 100644 arch/arm/mach-sc5xx/sc58x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x.c
 create mode 100644 arch/arm/mach-sc5xx/sc59x_64.c
 create mode 100644 arch/arm/mach-sc5xx/soc.c
 create mode 100644 arch/arm/mach-sc5xx/spl.c
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-adi-pll.c
 create mode 100644 drivers/clk/adi/clk-adi-sc57x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc58x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc594.c
 create mode 100644 drivers/clk/adi/clk-adi-sc598.c
 create mode 100644 drivers/clk/adi/clk-shared.c
 create mode 100644 drivers/clk/adi/clk.h
 create mode 100644 drivers/serial/serial_adi_uart4.c
 create mode 100644 drivers/timer/adi_sc5xx_timer.c
 create mode 100644 include/dt-bindings/clock/adi-sc5xx-clock.h
 create mode 100644 include/env/adi/adi_boot.env

-- 
2.43.2

