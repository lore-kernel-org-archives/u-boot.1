Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA3CC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EBB86F42;
	Tue, 19 Dec 2023 21:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUmr6VfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B22087527; Tue, 19 Dec 2023 21:14:21 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F9D86F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cc5a0130faso49222391fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703016858; x=1703621658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U4W+vVM6IKcXVS07HkuLv3x3yRgYCeIJyPGUemo7f9s=;
 b=MUmr6VfN6ji6TLex8fdLNb5B0avbAy8icwZ2OPMloEe1mUdePzGmeDq8iQFbYu+oWc
 fAjWhHuuYRc+CqdNym+W7DELBH1hzlTK1Ix2aDVPLcty23Ttldts2wMJOe0jRRwjG3un
 PXa74Q8B30Rc0f/9/AxzWRQshQ0LzZdqGa3/eR/RH8OARqvN8GVBKYAb+svpA5MrqfuN
 ZTI4iyvt49KGHmQnADRhJU9e2yDC+U8r/ftVcc9nLOg8YWJTmG6n5RzEiAy50amJPC1C
 Ty6fM3/8xdKI9MU0QauRJddH9DUQBXJMG7OAcbn4rsk7b1fybQV+TENuUnJ7RDu3sLDS
 pUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703016858; x=1703621658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U4W+vVM6IKcXVS07HkuLv3x3yRgYCeIJyPGUemo7f9s=;
 b=qUD+UBgQWY8VwobdHAUl1r3y+q8+ml8rgbIcZ+5AAgogOBU1jBGCjhre4Uetch4g97
 uy18go+iKWvuzSzrrc82q/vLQJP5aCI8lEo04KTa6vhs+3Amnt8ysvbY/TUvijRoVH16
 AoPw6LehLcdV4KAs4cLFP8a3+YtH0SJyRz6dA/W3b/YfL9t7bsSFAraWniCxx4BCVP7c
 IycoNDCS5v14XSHSDfbA3M0/RqdRO8ZEw/FMOV7TkWlfL4P47LaoKEKGOuo8Y5kzagoe
 1L9fCCsr0Tw7UX1TdES5T8Su+7Xn1t+2if7pDrvbsh7iPB10umHsIWoIoNbP/sS9u+Qc
 fnFA==
X-Gm-Message-State: AOJu0YwqOMvaiiX9+v6UopBqT+sULdqCtxDQS2ZUIU9gLAwYN7iEzBFt
 7QLQ2bogI6pSoQEAFV8/x04RGn14Hac=
X-Google-Smtp-Source: AGHT+IGA7Sl9LmcJQFoeNTPy5/WhsYjOHNV8HDfwgT/7bmGV48Ob7Ucu49lL9PoMRTcSCqjkSJYKXw==
X-Received: by 2002:a2e:a705:0:b0:2cc:300a:937d with SMTP id
 s5-20020a2ea705000000b002cc300a937dmr5226769lje.61.1703016858000; 
 Tue, 19 Dec 2023 12:14:18 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 o12-20020a50c90c000000b0054da352618asm11842548edh.94.2023.12.19.12.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 12:14:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Tue, 19 Dec 2023 22:13:53 +0200
Message-Id: <20231219201353.433090-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Dear Tom,

The following changes since commit 936d0f9dd713a913fe952eae576c893e1d5ecbd1:

  Merge patch series "Fix J7200 kernel boot when using upstream u-boot" (2023-12-19 11:42:03 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 4989628c1d2b6ea19a38aae34b1c08b12141c64b:

  board: compal: paz00: clean up the board (2023-12-19 21:24:30 +0200)

----------------------------------------------------------------
Peter Geis (1):
      mmc: tegra: use max-frequency from device tree if provided

Svyatoslav Ryhel (14):
      drivers: gpio: implement MAX77663 GPIO cell
      drivers: gpio: implement PALMAS GPIO cell
      drivers: gpio-uclass: support PMIC GPIO children
      ARM: tegra: clock: support get and set rate for simple PLL
      ARM: tegra30: clock: implement PLLD2 support
      ARM: tegra114: clock: implement PLLD2 support
      ARM: mach-tegra: rearrange SPL configs
      drivers: pinctrl: create Tegra DM pinctrl driver
      drivers: pinctrl: tegra: incorporate existing code
      board: asus: grouper: switch to DM pinmux
      board: lg: x3-t30: switch to DM pinmux
      board: asus: transformer: switch to DM pinmux
      board: htc: endeavoru: switch to DM pinmux
      board: compal: paz00: clean up the board

 arch/arm/dts/tegra20-paz00.dts                                             |    4 +-
 arch/arm/dts/tegra30-asus-grouper-common.dtsi                              |  712 +++++++++++++++++++++
 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts                         |  113 ++++
 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts                         |  113 ++++
 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts                         |  149 +++++
 arch/arm/dts/tegra30-asus-p1801-t.dts                                      |  982 +++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-asus-tf201.dts                                        |   45 ++
 arch/arm/dts/tegra30-asus-tf300t.dts                                       |   45 ++
 arch/arm/dts/tegra30-asus-tf300tg.dts                                      |  128 ++++
 arch/arm/dts/tegra30-asus-tf300tl.dts                                      |  163 +++++
 arch/arm/dts/tegra30-asus-tf600t.dts                                       |  889 ++++++++++++++++++++++++++
 arch/arm/dts/tegra30-asus-tf700t.dts                                       |   53 ++
 arch/arm/dts/tegra30-asus-transformer.dtsi                                 |  984 +++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-htc-endeavoru.dts                                     | 1147 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-lg-p880.dts                                           |   90 +++
 arch/arm/dts/tegra30-lg-p895.dts                                           |   93 +++
 arch/arm/dts/tegra30-lg-x3.dtsi                                            |  845 +++++++++++++++++++++++++
 arch/arm/include/asm/arch-tegra/clk_rst.h                                  |    3 +-
 arch/arm/include/asm/arch-tegra114/clock-tables.h                          |    2 +-
 arch/arm/include/asm/arch-tegra114/pinmux.h                                |  303 +++++++++
 arch/arm/include/asm/arch-tegra124/pinmux.h                                |  327 ++++++++++
 arch/arm/include/asm/arch-tegra20/pinmux.h                                 |  291 +++++++++
 arch/arm/include/asm/arch-tegra210/pinmux.h                                |  394 ++++++++++++
 arch/arm/include/asm/arch-tegra30/clock-tables.h                           |    2 +-
 arch/arm/include/asm/arch-tegra30/pinmux.h                                 |  381 +++++++++++
 arch/arm/mach-tegra/Kconfig                                                |   16 +-
 arch/arm/mach-tegra/Makefile                                               |    1 -
 arch/arm/mach-tegra/board.c                                                |    6 +-
 arch/arm/mach-tegra/board2.c                                               |    2 +-
 arch/arm/mach-tegra/clock.c                                                |   78 ++-
 arch/arm/mach-tegra/tegra114/Makefile                                      |    2 +-
 arch/arm/mach-tegra/tegra114/clock.c                                       |   22 +
 arch/arm/mach-tegra/tegra124/Makefile                                      |    2 -
 arch/arm/mach-tegra/tegra124/clock.c                                       |   12 +-
 arch/arm/mach-tegra/tegra20/Makefile                                       |    2 +-
 arch/arm/mach-tegra/tegra20/clock.c                                        |   15 +
 arch/arm/mach-tegra/tegra210/Makefile                                      |    1 -
 arch/arm/mach-tegra/tegra210/clock.c                                       |   15 +
 arch/arm/mach-tegra/tegra30/Makefile                                       |    2 +-
 arch/arm/mach-tegra/tegra30/clock.c                                        |   22 +
 board/asus/grouper/grouper.c                                               |   18 -
 board/asus/grouper/pinmux-config-grouper.h                                 |  362 -----------
 board/asus/transformer-t30/pinmux-config-transformer.h                     |  365 -----------
 board/asus/transformer-t30/transformer-t30.c                               |   23 -
 board/compal/paz00/Makefile                                                |    8 -
 board/compal/paz00/paz00.c                                                 |   53 --
 board/htc/endeavoru/endeavoru.c                                            |   14 -
 board/htc/endeavoru/pinmux-config-endeavoru.h                              |  362 -----------
 board/lg/x3-t30/Kconfig                                                    |   12 -
 board/lg/x3-t30/configs/p880.config                                        |    1 -
 board/lg/x3-t30/configs/p895.config                                        |    1 -
 board/lg/x3-t30/pinmux-config-x3.h                                         |  449 -------------
 board/lg/x3-t30/x3-t30.c                                                   |   23 -
 configs/paz00_defconfig                                                    |    3 +
 drivers/gpio/Kconfig                                                       |   16 +
 drivers/gpio/Makefile                                                      |    2 +
 drivers/gpio/gpio-uclass.c                                                 |   20 +
 drivers/gpio/max77663_gpio.c                                               |  178 ++++++
 drivers/gpio/palmas_gpio.c                                                 |  132 ++++
 drivers/mmc/tegra_mmc.c                                                    |    2 +-
 drivers/pinctrl/Kconfig                                                    |    1 +
 drivers/pinctrl/Makefile                                                   |    1 +
 drivers/pinctrl/tegra/Kconfig                                              |   18 +
 drivers/pinctrl/tegra/Makefile                                             |   16 +
 .../tegra114/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra114.c         |    0
 .../tegra124/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra124.c         |    0
 .../tegra20/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra20.c           |    0
 .../tegra210/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra210.c         |    0
 .../tegra30/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra30.c           |    0
 drivers/pinctrl/tegra/pinctrl-tegra.c                                      |  248 ++++++++
 drivers/pinctrl/tegra/pinctrl-tegra20.c                                    |  177 ++++++
 {arch/arm/mach-tegra => drivers/pinctrl/tegra}/pinmux-common.c             |    0
 .../tegra114/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra114.c           |    0
 .../tegra124/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra124.c           |    0
 .../mach-tegra/tegra20/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra20.c  |    0
 drivers/pinctrl/tegra/pinmux-tegra210.c                                    |  190 ++++++
 .../mach-tegra/tegra30/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra30.c  |    0
 drivers/power/pmic/max77663.c                                              |    9 +
 drivers/power/pmic/palmas.c                                                |   10 +-
 include/configs/x3-t30.h                                                   |   13 +-
 include/dt-bindings/pmic/max77663.h                                        |   18 +
 include/power/max77663.h                                                   |    1 +
 include/power/palmas.h                                                     |   12 +
 83 files changed, 9464 insertions(+), 1750 deletions(-)
 delete mode 100644 board/asus/grouper/pinmux-config-grouper.h
 delete mode 100644 board/asus/transformer-t30/pinmux-config-transformer.h
 delete mode 100644 board/compal/paz00/Makefile
 delete mode 100644 board/compal/paz00/paz00.c
 delete mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h
 delete mode 100644 board/lg/x3-t30/pinmux-config-x3.h
 create mode 100644 drivers/gpio/max77663_gpio.c
 create mode 100644 drivers/gpio/palmas_gpio.c
 create mode 100644 drivers/pinctrl/tegra/Kconfig
 create mode 100644 drivers/pinctrl/tegra/Makefile
 rename arch/arm/mach-tegra/tegra114/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra20.c (100%)
 rename arch/arm/mach-tegra/tegra210/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra210.c (100%)
 rename arch/arm/mach-tegra/tegra30/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra30.c (100%)
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra.c
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra20.c
 rename {arch/arm/mach-tegra => drivers/pinctrl/tegra}/pinmux-common.c (100%)
 rename arch/arm/mach-tegra/tegra114/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra20.c (100%)
 create mode 100644 drivers/pinctrl/tegra/pinmux-tegra210.c
 rename arch/arm/mach-tegra/tegra30/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra30.c (100%)
 create mode 100644 include/dt-bindings/pmic/max77663.h


Branch contains PMIC GPIO cells bringup, simple PLL support for Tegra and
DM convertion of Tegra pinmux.

Thanks,
Svyatoslav Ryhel.
