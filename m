Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE37C87FDA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 06:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B4D83E18;
	Mon,  4 Aug 2025 08:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQr3R4ZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E8AB83E23; Mon,  4 Aug 2025 08:24:41 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A44D83E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 08:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61580eb7995so8897516a12.0
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 23:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754288678; x=1754893478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgk5lXFzkr8n4Ei0qOsFtZXiT/2uXGTNBmYU3RFKEIk=;
 b=OQr3R4ZOI1DkD6o2Bj6EH0ztO4P+qgQxeuqx+I4t7qqWdQrPKuq79iMSgnfTYWsQSc
 8GisFzFzZQ8gMHMKshyWDu6o/Gu6XXZBOVNyc1CGqbKC4ol+NYQNhKTDMQ+ww7OIVfRi
 fMZcfJZ7saGDbzUmkC22wOjM7ARhRH2+MMxu1g+V1r5a7DXzqEGwLcANhD00c1ztpSJw
 pFjtneQ3lJLAkBVz9XmYtK09VGgYInjzhLEqfC6PGxmSr+UCVqXYOC57vLA8kqIR7dx9
 +umEOJXgI6WJsXE3jcL06ov49i0fWIxpmJH/+CfSwlJAA4+7pveJde4EePhaBXJ7iAWr
 cVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754288678; x=1754893478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgk5lXFzkr8n4Ei0qOsFtZXiT/2uXGTNBmYU3RFKEIk=;
 b=KCzf1brYDXxKewSQg+ai7UZq3psywZPWNqda/7sC5woMEh9dnAVJG9SHG6icB3lHb5
 08DsXyKdYs00+R/7eEZpqX6cSJG8/bcRHj7K4CS0nIfFpbJRGOUNRvFLlkt+RzjVi+VF
 ODfU/CnXnVRC/TrWfviUouacnbgevANuvl5ICwp5XaxXhYQpkgE35LejIx6wNWlm6H1Z
 F4MJPfPAr10R+tPHIezhisYlJJs/yLbn/QSuMFvoq07uuVzuMwecoahdyu+beerMoQPm
 4XS54F3Dqkpb1+FjPvDKL2pzO8GDj1Jx2IVBsbn4P/0md0yM3x8KtVU6mGkVEvcVL0KP
 qY2g==
X-Gm-Message-State: AOJu0YweOTcABddUSrkhnx9RjTeysBikHSjGJtf8IHgqRRyh/r5caiBw
 qUMQcYYGPu4D5AXB8R6Ohny7annVux1/RVwp/Whr0JyLkmtYkfdqmQJM
X-Gm-Gg: ASbGnctA/7cfM96/jKXDmcMgpOQWpsuTi7H6HOl4lPlmKhPuV6umkfxGOJ2H2jfN3wt
 5ii+tz3Ub+pG81wwdKeTVFqJxaTHPKYtfrHgcz0ltWAoonalc0aOCWbPs8XZYFLGisna5fZABdQ
 2NrYnG8j70PbOmmtAD/e/1R/dQHSe8bF8nt/UWq3E0A6aDKHC4q3SmJRpqvWiKD69X9xnrdLFa4
 hAjJfDJJ1XamIG01JKDGEFvyQb6IW58qgSD5+luLvHKlixAGkMhoR5mlFS6q7MF3g9T7BaTwu8r
 O9bULehXfFatcd+47C937++lJ+ez9ELiDU1Hth6YmuTGYOE2Xf6PpKNT1mts3hJ30akBo1n+djB
 NHkx5Pe8b2OPVMbnHGvdL49Xu
X-Google-Smtp-Source: AGHT+IHa3d1aUGW0coAIwKycIqOK0w1lU3vLczI1XqUHEiCOgifNvsQOTVUDhtva/Gg3qnDe7Ww6jA==
X-Received: by 2002:a17:907:c13:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-af940920db5mr745045766b.27.1754288678183; 
 Sun, 03 Aug 2025 23:24:38 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a23fec4sm682909466b.121.2025.08.03.23.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 23:24:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Mon,  4 Aug 2025 09:24:17 +0300
Message-ID: <20250804062417.7932-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

The following changes since commit f5e968a28e7cdc2c4365f5a382e02f074ee03fac:

  Merge tag 'u-boot-stm32-20250731' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-07-31 10:04:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to c55cbaf133b3d31a21b54507d74faeca109b8746:

  board: samsung: add Samsung Galaxy R (GT-I9103) and Captivate Glide (SGH-i927) support (2025-08-01 08:46:53 +0300)

----------------------------------------------------------------
Ion Agorria (11):
      ARM: tegra: Relocate fuse code from warmboot file
      crypto: tegra: Add Tegra AES engine driver
      ARM: tegra: Add LP0 support for ODM production
      ARM: tegra: Add BSE bindings
      ARM: tegra: Enable BSEV for devices that use CMD_EBTUPDATE
      ARM: tegra: Use AES engine for crypto functions
      video: panel: add Sony L4F00430T01 panel driver
      video: panel: add Samsung S6E63M0 panel driver
      video: bridge: add Samsung CMC623 image converter driver
      video: backlight: add Samsung CMC623 backlight PWM driver
      board: samsung: add Samsung Galaxy R (GT-I9103) and Captivate Glide (SGH-i927) support

Svyatoslav Ryhel (2):
      board: chagall: add Pegatron Chagall support
      video: tegra: parametrize PCLK and DE polarity

 arch/arm/dts/Makefile                           |    3 +
 arch/arm/dts/tegra20-acer-a500-picasso.dts      |    4 +
 arch/arm/dts/tegra20-asus-transformer.dtsi      |    4 +
 arch/arm/dts/tegra20-lg-star.dts                |    4 +
 arch/arm/dts/tegra20-motorola-mot.dtsi          |    4 +
 arch/arm/dts/tegra20-samsung-bose.dts           |  119 ++++++
 arch/arm/dts/tegra20-samsung-n1-common.dtsi     |  428 ++++++++++++++++++++
 arch/arm/dts/tegra20-samsung-n1.dts             |  184 +++++++++
 arch/arm/dts/tegra20.dtsi                       |   29 ++
 arch/arm/dts/tegra30-asus-grouper-common.dtsi   |    4 +
 arch/arm/dts/tegra30-asus-p1801-t.dts           |    4 +
 arch/arm/dts/tegra30-asus-tf600t.dts            |    4 +
 arch/arm/dts/tegra30-asus-transformer.dtsi      |    4 +
 arch/arm/dts/tegra30-htc-endeavoru.dts          |    4 +
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts |    4 +
 arch/arm/dts/tegra30-lg-x3.dtsi                 |    4 +
 arch/arm/dts/tegra30-ouya.dts                   |    4 +
 arch/arm/dts/tegra30-pegatron-chagall.dts       | 1291 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-wexler-qc750.dts           |    4 +
 arch/arm/dts/tegra30.dtsi                       |   29 ++
 arch/arm/include/asm/arch-tegra/ap.h            |    7 +
 arch/arm/include/asm/arch-tegra/crypto.h        |   43 +-
 arch/arm/include/asm/arch-tegra/dc.h            |    3 +
 arch/arm/include/asm/arch-tegra/fuse.h          |   21 +
 arch/arm/include/asm/arch-tegra/warmboot.h      |    7 -
 arch/arm/mach-tegra/Kconfig                     |    2 +
 arch/arm/mach-tegra/ap.c                        |    8 +
 arch/arm/mach-tegra/cpu.h                       |    1 +
 arch/arm/mach-tegra/crypto.c                    |  184 +++------
 arch/arm/mach-tegra/fuse.c                      |   63 ++-
 arch/arm/mach-tegra/tegra124/bct.c              |   20 +-
 arch/arm/mach-tegra/tegra20/Kconfig             |    5 +
 arch/arm/mach-tegra/tegra20/bct.c               |   20 +-
 arch/arm/mach-tegra/tegra20/warmboot.c          |  117 ++----
 arch/arm/mach-tegra/tegra30/Kconfig             |    5 +
 arch/arm/mach-tegra/tegra30/bct.c               |   20 +-
 board/pegatron/chagall/Kconfig                  |   13 +
 board/pegatron/chagall/MAINTAINERS              |    7 +
 board/pegatron/chagall/Makefile                 |   11 +
 board/pegatron/chagall/chagall-spl.c            |   41 ++
 board/pegatron/chagall/chagall.c                |   23 ++
 board/pegatron/chagall/chagall.env              |    9 +
 board/samsung/n1/Kconfig                        |   13 +
 board/samsung/n1/MAINTAINERS                    |    9 +
 board/samsung/n1/bose.config                    |    6 +
 board/samsung/n1/n1.env                         |   16 +
 configs/chagall_defconfig                       |   80 ++++
 configs/n1_defconfig                            |   92 +++++
 doc/board/index.rst                             |    1 +
 doc/board/pegatron/chagall.rst                  |   41 ++
 doc/board/pegatron/index.rst                    |    9 +
 doc/board/samsung/index.rst                     |    1 +
 doc/board/samsung/n1.rst                        |   51 +++
 drivers/crypto/Kconfig                          |    2 +
 drivers/crypto/Makefile                         |    1 +
 drivers/crypto/tegra/Kconfig                    |    7 +
 drivers/crypto/tegra/Makefile                   |    3 +
 drivers/crypto/tegra/tegra_aes.c                |  591 ++++++++++++++++++++++++++++
 drivers/video/Kconfig                           |   24 ++
 drivers/video/Makefile                          |    3 +
 drivers/video/bridge/Kconfig                    |    8 +
 drivers/video/bridge/Makefile                   |    1 +
 drivers/video/bridge/cmc623.c                   |  234 +++++++++++
 drivers/video/cmc623_backlight.c                |  124 ++++++
 drivers/video/samsung-s6e63m0.c                 |  393 +++++++++++++++++++
 drivers/video/sony-l4f00430t01.c                |  210 ++++++++++
 drivers/video/tegra/dc.c                        |   16 +
 67 files changed, 4397 insertions(+), 304 deletions(-)
 create mode 100644 arch/arm/dts/tegra20-samsung-bose.dts
 create mode 100644 arch/arm/dts/tegra20-samsung-n1-common.dtsi
 create mode 100644 arch/arm/dts/tegra20-samsung-n1.dts
 create mode 100644 arch/arm/dts/tegra30-pegatron-chagall.dts
 create mode 100644 board/pegatron/chagall/Kconfig
 create mode 100644 board/pegatron/chagall/MAINTAINERS
 create mode 100644 board/pegatron/chagall/Makefile
 create mode 100644 board/pegatron/chagall/chagall-spl.c
 create mode 100644 board/pegatron/chagall/chagall.c
 create mode 100644 board/pegatron/chagall/chagall.env
 create mode 100644 board/samsung/n1/Kconfig
 create mode 100644 board/samsung/n1/MAINTAINERS
 create mode 100644 board/samsung/n1/bose.config
 create mode 100644 board/samsung/n1/n1.env
 create mode 100644 configs/chagall_defconfig
 create mode 100644 configs/n1_defconfig
 create mode 100644 doc/board/pegatron/chagall.rst
 create mode 100644 doc/board/pegatron/index.rst
 create mode 100644 doc/board/samsung/n1.rst
 create mode 100644 drivers/crypto/tegra/Kconfig
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra_aes.c
 create mode 100644 drivers/video/bridge/cmc623.c
 create mode 100644 drivers/video/cmc623_backlight.c
 create mode 100644 drivers/video/samsung-s6e63m0.c
 create mode 100644 drivers/video/sony-l4f00430t01.c

Branch contains Tegra AES engine implementation as a real world example for
the recently added AES UCLASS along with conversion of all ebtupdate users
to use it. Two new boards are introduced, Pegatron Chagall a Tegra 3 tablet
and Samsung Tegra 2 N1 board which incudes Galaxy R and Captivate Glide
smartphones. 

All commits passed U-Boot CI.

Thank you,
Svyatoslav Ryhel.
