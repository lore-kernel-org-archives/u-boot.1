Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB150C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 10:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B2C82D05;
	Sat, 12 Apr 2025 12:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cfnUF4fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8760882D08; Sat, 12 Apr 2025 12:11:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9C582CF6
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 12:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so4695794a12.3
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744452714; x=1745057514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KR4UHuTBRv9JwcHr3sAKINnvm89rMC2GDUP6HH/BgFQ=;
 b=cfnUF4fMg9jI2fpmlwZjzEc3Ds5OQs829UCsO6s5BcgAfml8P5yjouph6PM+zCM+g6
 bR0bl3dy8FWAD/B2hV21rK4T/hLOgUWOBN7TR2prwW0fW7qvMGEhu9B83ngJTZArQMiD
 iqRv2JaO1WTTc8ACXwwm8l8Z9detAIh26h0lvFbvaWDjNgBwHkiXNHY4KSbZRas/CCXO
 mwjX6b6beea5sPX/Jz6guZXD4sFHns3hJhuHVpXG++kt12Vc0Yt9K0LLbm3dAoBpKM/S
 7OjeamdvLwL88brYGfI8xe62I/K+ixBXNJ3mPQ4ZP8NP8JXsBcEmLzQ4w6DmrK6sf3ZR
 jEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744452714; x=1745057514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KR4UHuTBRv9JwcHr3sAKINnvm89rMC2GDUP6HH/BgFQ=;
 b=EOfHpxFRdwLzPEoIKNBFFzkOB0InpKggyOjBuO4civfAstsUUeSFdGYgPWU2pCy77T
 r1Jx8FuSHw/68nXhpeq9+bnuxC5folbdgLUYAUGWjf5xiwK9yRbvS88lu9M5CFSrXK9q
 1WCE5lw/yi81iPTrQ8qTn+57CTdu3aop4JuGnjyxUOecAG+Bco2GlOu2lA/kEmfpGiB1
 fDL17vuc4E4malLHhiFGyPJXtcgAWfbApk1ZrxPsV8zJs7JuHM1Rt22cAWPOgxUBXDzI
 bUwcW0av/lOzOukzI5fGYzgww2bGipwIDeWrqzVfY69mbvPb//4jHml+ISRWiCUra1Nd
 xuXg==
X-Gm-Message-State: AOJu0Yxm+oNoRKcSAdrIVOhE9Xc3sCqm4z2JD+oViW7wSpWsdFPrSUVY
 R7Blqx7XtuorLDeziA6D1KaJCi0yTMnqHgLdZb9Ip7YyC6ieS3La
X-Gm-Gg: ASbGncu3xtJ2XJADhjv4TSqqO6T7jYiYy3njokCI2/n9gKwkj07HyfZAM1mgLx54i7K
 g1KWD8Vf8X88t3L1P3MCjiTePUSuEKXoT4kpvOErmzl6da10dwfn0DPVUbYYRYHHNhyAMh0kpa8
 rKZ05fSFme1T+/yBZCwN3tC8ASN07hk9DPhEDoFc7QxAbKax2QS3rlsjzpEVAsQBF7+7PAdnjWM
 FP3HaIGW2uVvmxIzQoz/vwzG3NVAS+3csnKy5dSXCtHQarzGPubkUxTOPnZ/Rv+gWiw2vzUIpJh
 BJmNIY0c/EHoSR3YFlV1Ae4jsFRGali3
X-Google-Smtp-Source: AGHT+IGUczXkienHQgm5Ijq0hJSdM9nzxzP5YLpRg8xgwq65qqaUOOyZfsgyC0f7ekiEqcAwO3NPJQ==
X-Received: by 2002:a05:6402:1ecc:b0:5e4:99af:b7c with SMTP id
 4fb4d7f45d1cf-5f36f644fa1mr3913868a12.9.1744452714042; 
 Sat, 12 Apr 2025 03:11:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f5056c4sm2106345a12.62.2025.04.12.03.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 03:11:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Sat, 12 Apr 2025 13:11:28 +0300
Message-ID: <20250412101129.70838-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The following changes since commit 407d68638fe32418d61681407effba2a303bb9ee:

  Merge patch series "Switch to using $(PHASE_) in Makefiles" (2025-04-11 12:16:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 427dd4dd27eef00306a94800d66a6b82e2b11ad8:

  ARM: tegra20: add funcmux for exposing UART over uSD slot on Tegra 20 (2025-04-12 11:12:06 +0300)

----------------------------------------------------------------
Artur Kowalski (2):
      pinctrl: tegra20: detect unknown/invalid pin/func configurations
      ARM: tegra20: add funcmux for exposing UART over uSD slot on Tegra 20

Svyatoslav Ryhel (22):
      spi: tegra20_slink: fix CS polarity setup
      ARM: tegra: clock: take in account PLLD/D2 enable bit on clock_set_rate
      ARM: tegra: clock: fix PLLD2 info table entry on Tegra124 and Tegra210
      sysreset: diverge GPIO reset and poweroff configs per-phase
      video: tegra20: dsi: add Tegra20 support
      video: rename tegra20 to tegra
      video: move tegra124 into common tegra dir
      video: tegra: drop prefix from file names
      video: tegra: adjust DC and DSI config names
      power: pmic: add the basic CPCAP PMIC support
      power: regulator: add regulator support for CPCAP PMIC
      input: add support for CPCAP power button
      video: panel: add Motorola Atrix 4G and Droid X2 panel
      video: backlight: add TI LM3532 led controller
      board: motorola: add Atrix 4G MB860 and Droid X2 MB870 support
      pinctrl: tegra: detect unknown/invalid pin/func configurations
      ARM: tegra: board: set CFG_SYS_NS16550_COM1 according to TEGRA_ENABLE_UART
      ARM: tegra: convert CFG_TEGRA_BOARD_STRING into Kconfig option
      ARM: tegra: replace per-device config headers with generic Tegra
      ARM: tegra114: clock: avoid touching DISP clocks on init
      board: asus: transformer: add ASUS Transformer Pad TF701T support
      board: nvidia: tegratab: add Nvidia Tegra Note 7 support

 arch/arm/dts/Makefile                                                     |    4 +
 arch/arm/dts/tegra114-asus-tf701t.dts                                     | 1245 +++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra114-nvidia-tegratab.dts                                 | 1041 +++++++++++++++++++++++++++++
 arch/arm/dts/tegra20-motorola-daytona.dts                                 |    9 +
 arch/arm/dts/tegra20-motorola-mot.dtsi                                    |  490 ++++++++++++++
 arch/arm/dts/tegra20-motorola-olympus.dts                                 |    9 +
 arch/arm/include/asm/arch-tegra20/funcmux.h                               |    1 +
 arch/arm/mach-tegra/board.c                                               |    7 +
 arch/arm/mach-tegra/board2.c                                              |    2 +-
 arch/arm/mach-tegra/clock.c                                               |    6 +
 arch/arm/mach-tegra/tegra114/Kconfig                                      |   10 +
 arch/arm/mach-tegra/tegra114/clock.c                                      |    1 -
 arch/arm/mach-tegra/tegra124/clock.c                                      |    4 +-
 arch/arm/mach-tegra/tegra20/Kconfig                                       |    8 +
 arch/arm/mach-tegra/tegra210/clock.c                                      |    4 +-
 board/acer/picasso/Kconfig                                                |    6 +-
 board/asus/grouper/Kconfig                                                |    6 +-
 board/asus/transformer-t114/Kconfig                                       |   16 +
 board/asus/transformer-t114/MAINTAINERS                                   |    8 +
 board/asus/transformer-t114/Makefile                                      |   10 +
 board/asus/transformer-t114/transformer-t114-spl.c                        |   42 ++
 board/asus/transformer-t114/transformer-t114.c                            |   57 ++
 board/asus/transformer-t114/transformer-t114.env                          |   15 +
 board/asus/transformer-t20/Kconfig                                        |    6 +-
 board/asus/transformer-t30/Kconfig                                        |    6 +-
 board/avionic-design/medcom-wide/Kconfig                                  |    6 +-
 board/avionic-design/plutux/Kconfig                                       |    6 +-
 board/avionic-design/tec-ng/Kconfig                                       |    6 +-
 board/avionic-design/tec/Kconfig                                          |    6 +-
 board/cei/cei-tk1-som/Kconfig                                             |    6 +-
 board/compal/paz00/Kconfig                                                |    6 +-
 board/compulab/trimslice/Kconfig                                          |    6 +-
 board/htc/endeavoru/Kconfig                                               |    6 +-
 board/lenovo/ideapad-yoga-11/Kconfig                                      |    6 +-
 board/lg/x3-t30/Kconfig                                                   |    6 +-
 board/microsoft/surface-rt/Kconfig                                        |    6 +-
 board/motorola/mot/Kconfig                                                |   16 +
 board/motorola/mot/MAINTAINERS                                            |    7 +
 board/motorola/mot/Makefile                                               |    9 +
 board/motorola/mot/configs/daytona.config                                 |    2 +
 board/motorola/mot/configs/olympus.config                                 |    2 +
 board/motorola/mot/mot-spl.c                                              |   58 ++
 board/motorola/mot/mot.env                                                |   15 +
 board/nvidia/beaver/Kconfig                                               |    6 +-
 board/nvidia/cardhu/Kconfig                                               |    6 +-
 board/nvidia/dalmore/Kconfig                                              |    6 +-
 board/nvidia/harmony/Kconfig                                              |    6 +-
 board/nvidia/jetson-tk1/Kconfig                                           |    6 +-
 board/nvidia/nyan-big/Kconfig                                             |    6 +-
 board/nvidia/p2371-0000/Kconfig                                           |    6 +-
 board/nvidia/p2371-2180/Kconfig                                           |    6 +-
 board/nvidia/p2571/Kconfig                                                |    6 +-
 board/nvidia/p2771-0000/Kconfig                                           |    6 +-
 board/nvidia/p3450-0000/Kconfig                                           |    6 +-
 board/nvidia/seaboard/Kconfig                                             |    6 +-
 board/nvidia/tegratab/Kconfig                                             |   16 +
 board/nvidia/tegratab/MAINTAINERS                                         |    8 +
 board/nvidia/tegratab/Makefile                                            |   10 +
 board/nvidia/tegratab/tegratab-spl.c                                      |   42 ++
 board/nvidia/tegratab/tegratab.c                                          |   56 ++
 board/nvidia/tegratab/tegratab.env                                        |   15 +
 board/nvidia/venice2/Kconfig                                              |    6 +-
 board/nvidia/ventana/Kconfig                                              |    6 +-
 board/ouya/ouya/Kconfig                                                   |    6 +-
 board/sifive/unleashed/Kconfig                                            |    1 +
 board/sifive/unmatched/Kconfig                                            |    1 +
 board/toradex/apalis_t30/Kconfig                                          |    2 +-
 board/toradex/apalis_t30/apalis_t30.env                                   |    9 +
 board/toradex/colibri_t20/Kconfig                                         |    2 +-
 board/toradex/colibri_t20/colibri_t20.c                                   |    2 +-
 board/toradex/colibri_t30/Kconfig                                         |    2 +-
 board/toradex/colibri_t30/colibri_t30.env                                 |    8 +
 board/wexler/qc750/Kconfig                                                |    6 +-
 board/xiaomi/mocha/Kconfig                                                |    4 +
 configs/endeavoru_defconfig                                               |    2 +-
 configs/ge_b1x5v2_defconfig                                               |    1 +
 configs/grouper_defconfig                                                 |    2 +-
 configs/harmony_defconfig                                                 |    2 +-
 configs/ideapad-yoga-11_defconfig                                         |    2 +-
 configs/medcom-wide_defconfig                                             |    2 +-
 configs/microblaze-generic_defconfig                                      |    1 +
 configs/mocha_defconfig                                                   |    2 +-
 configs/mot_defconfig                                                     |   93 +++
 configs/paz00_defconfig                                                   |    2 +-
 configs/picasso_defconfig                                                 |    2 +-
 configs/qc750_defconfig                                                   |    2 +-
 configs/seaboard_defconfig                                                |    2 +-
 configs/surface-rt_defconfig                                              |    2 +-
 configs/tec_defconfig                                                     |    2 +-
 configs/tegratab_defconfig                                                |   84 +++
 configs/tf701t_defconfig                                                  |   89 +++
 configs/transformer_t20_defconfig                                         |    2 +-
 configs/transformer_t30_defconfig                                         |    2 +-
 configs/ventana_defconfig                                                 |    2 +-
 configs/x3_t30_defconfig                                                  |    2 +-
 doc/board/asus/index.rst                                                  |    1 +
 doc/board/asus/transformer_t114.rst                                       |   74 +++
 doc/board/index.rst                                                       |    2 +
 doc/board/motorola/index.rst                                              |    9 +
 doc/board/motorola/mot.rst                                                |  104 +++
 doc/board/nvidia/index.rst                                                |    9 +
 doc/board/nvidia/tegratab.rst                                             |   74 +++
 drivers/input/Kconfig                                                     |    6 +
 drivers/input/Makefile                                                    |    1 +
 drivers/input/cpcap_pwrbutton.c                                           |  134 ++++
 drivers/pinctrl/tegra/funcmux-tegra20.c                                   |    9 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c                                     |   75 ++-
 drivers/pinctrl/tegra/pinctrl-tegra20.c                                   |   18 +-
 drivers/power/pmic/Kconfig                                                |   10 +
 drivers/power/pmic/Makefile                                               |    1 +
 drivers/power/pmic/cpcap.c                                                |  125 ++++
 drivers/power/regulator/Kconfig                                           |    9 +
 drivers/power/regulator/Makefile                                          |    1 +
 drivers/power/regulator/cpcap_regulator.c                                 |  275 ++++++++
 drivers/spi/tegra20_slink.c                                               |   18 +
 drivers/sysreset/Kconfig                                                  |   45 ++
 drivers/sysreset/Makefile                                                 |    4 +-
 drivers/video/Kconfig                                                     |   29 +-
 drivers/video/Makefile                                                    |    5 +-
 drivers/video/lm3532_backlight.c                                          |  380 +++++++++++
 drivers/video/mot-panel.c                                                 |  308 +++++++++
 drivers/video/tegra/Kconfig                                               |   51 ++
 drivers/video/tegra/Makefile                                              |    9 +
 drivers/video/tegra/TODO                                                  |    5 +
 drivers/video/{tegra20/tegra-pwm-backlight.c => tegra/dc-pwm-backlight.c} |    2 +-
 drivers/video/{tegra20/tegra-dc.c => tegra/dc.c}                          |    2 +-
 drivers/video/{tegra20/tegra-dc.h => tegra/dc.h}                          |    0
 drivers/video/{tegra20/tegra-dsi.c => tegra/dsi.c}                        |    5 +-
 drivers/video/{tegra20/tegra-dsi.h => tegra/dsi.h}                        |    0
 drivers/video/{tegra20/tegra-hdmi.c => tegra/hdmi.c}                      |    4 +-
 drivers/video/{tegra20/tegra-hdmi.h => tegra/hdmi.h}                      |    0
 drivers/video/{tegra20/tegra-host1x.c => tegra/host1x.c}                  |    0
 drivers/video/{tegra20 => tegra}/mipi-phy.c                               |    0
 drivers/video/{tegra20 => tegra}/mipi-phy.h                               |    0
 drivers/video/{tegra20/tegra-mipi.c => tegra/mipi.c}                      |    0
 drivers/video/{ => tegra}/tegra124/Makefile                               |    0
 drivers/video/{ => tegra}/tegra124/display.c                              |    0
 drivers/video/{ => tegra}/tegra124/displayport.h                          |    0
 drivers/video/{ => tegra}/tegra124/dp.c                                   |    0
 drivers/video/{ => tegra}/tegra124/sor.c                                  |    0
 drivers/video/{ => tegra}/tegra124/sor.h                                  |    0
 drivers/video/tegra20/Kconfig                                             |   38 --
 drivers/video/tegra20/Makefile                                            |    7 -
 include/configs/apalis-tk1.h                                              |    3 -
 include/configs/apalis_t30.h                                              |   27 -
 include/configs/beaver.h                                                  |   21 -
 include/configs/cardhu.h                                                  |   21 -
 include/configs/cei-tk1-som.h                                             |   26 -
 include/configs/colibri_t20.h                                             |   18 -
 include/configs/colibri_t30.h                                             |   28 -
 include/configs/dalmore.h                                                 |   23 -
 include/configs/endeavoru.h                                               |   23 -
 include/configs/grouper.h                                                 |   19 -
 include/configs/harmony.h                                                 |   31 -
 include/configs/ideapad-yoga-11.h                                         |   19 -
 include/configs/jetson-tk1.h                                              |   22 -
 include/configs/medcom-wide.h                                             |   26 -
 include/configs/mocha.h                                                   |    6 -
 include/configs/mot.h                                                     |   19 +
 include/configs/nyan-big.h                                                |   22 -
 include/configs/ouya.h                                                    |   23 -
 include/configs/p2371-0000.h                                              |   23 -
 include/configs/p2371-2180.h                                              |   23 -
 include/configs/p2571.h                                                   |   23 -
 include/configs/p2771-0000.h                                              |   20 -
 include/configs/p3450-0000.h                                              |   21 -
 include/configs/paz00.h                                                   |   25 -
 include/configs/picasso.h                                                 |   23 -
 include/configs/plutux.h                                                  |   26 -
 include/configs/qc750.h                                                   |   23 -
 include/configs/seaboard.h                                                |   28 -
 include/configs/surface-rt.h                                              |   21 -
 include/configs/tec-ng.h                                                  |   20 -
 include/configs/tec.h                                                     |   26 -
 include/configs/tegra.h                                                   |   34 +
 include/configs/tegratab.h                                                |   19 +
 include/configs/transformer-t114.h                                        |   19 +
 include/configs/transformer-t20.h                                         |   23 -
 include/configs/transformer-t30.h                                         |   23 -
 include/configs/trimslice.h                                               |   26 -
 include/configs/venice2.h                                                 |   24 -
 include/configs/ventana.h                                                 |   23 -
 include/configs/x3-t30.h                                                  |   23 -
 include/power/cpcap.h                                                     |  373 +++++++++++
 184 files changed, 5935 insertions(+), 942 deletions(-)
 create mode 100644 arch/arm/dts/tegra114-asus-tf701t.dts
 create mode 100644 arch/arm/dts/tegra114-nvidia-tegratab.dts
 create mode 100644 arch/arm/dts/tegra20-motorola-daytona.dts
 create mode 100644 arch/arm/dts/tegra20-motorola-mot.dtsi
 create mode 100644 arch/arm/dts/tegra20-motorola-olympus.dts
 create mode 100644 board/asus/transformer-t114/Kconfig
 create mode 100644 board/asus/transformer-t114/MAINTAINERS
 create mode 100644 board/asus/transformer-t114/Makefile
 create mode 100644 board/asus/transformer-t114/transformer-t114-spl.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.env
 create mode 100644 board/motorola/mot/Kconfig
 create mode 100644 board/motorola/mot/MAINTAINERS
 create mode 100644 board/motorola/mot/Makefile
 create mode 100644 board/motorola/mot/configs/daytona.config
 create mode 100644 board/motorola/mot/configs/olympus.config
 create mode 100644 board/motorola/mot/mot-spl.c
 create mode 100644 board/motorola/mot/mot.env
 create mode 100644 board/nvidia/tegratab/Kconfig
 create mode 100644 board/nvidia/tegratab/MAINTAINERS
 create mode 100644 board/nvidia/tegratab/Makefile
 create mode 100644 board/nvidia/tegratab/tegratab-spl.c
 create mode 100644 board/nvidia/tegratab/tegratab.c
 create mode 100644 board/nvidia/tegratab/tegratab.env
 create mode 100644 configs/mot_defconfig
 create mode 100644 configs/tegratab_defconfig
 create mode 100644 configs/tf701t_defconfig
 create mode 100644 doc/board/asus/transformer_t114.rst
 create mode 100644 doc/board/motorola/index.rst
 create mode 100644 doc/board/motorola/mot.rst
 create mode 100644 doc/board/nvidia/index.rst
 create mode 100644 doc/board/nvidia/tegratab.rst
 create mode 100644 drivers/input/cpcap_pwrbutton.c
 create mode 100644 drivers/power/pmic/cpcap.c
 create mode 100644 drivers/power/regulator/cpcap_regulator.c
 create mode 100644 drivers/video/lm3532_backlight.c
 create mode 100644 drivers/video/mot-panel.c
 create mode 100644 drivers/video/tegra/Kconfig
 create mode 100644 drivers/video/tegra/Makefile
 create mode 100644 drivers/video/tegra/TODO
 rename drivers/video/{tegra20/tegra-pwm-backlight.c => tegra/dc-pwm-backlight.c} (99%)
 rename drivers/video/{tegra20/tegra-dc.c => tegra/dc.c} (99%)
 rename drivers/video/{tegra20/tegra-dc.h => tegra/dc.h} (100%)
 rename drivers/video/{tegra20/tegra-dsi.c => tegra/dsi.c} (99%)
 rename drivers/video/{tegra20/tegra-dsi.h => tegra/dsi.h} (100%)
 rename drivers/video/{tegra20/tegra-hdmi.c => tegra/hdmi.c} (99%)
 rename drivers/video/{tegra20/tegra-hdmi.h => tegra/hdmi.h} (100%)
 rename drivers/video/{tegra20/tegra-host1x.c => tegra/host1x.c} (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.c (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.h (100%)
 rename drivers/video/{tegra20/tegra-mipi.c => tegra/mipi.c} (100%)
 rename drivers/video/{ => tegra}/tegra124/Makefile (100%)
 rename drivers/video/{ => tegra}/tegra124/display.c (100%)
 rename drivers/video/{ => tegra}/tegra124/displayport.h (100%)
 rename drivers/video/{ => tegra}/tegra124/dp.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.h (100%)
 delete mode 100644 drivers/video/tegra20/Kconfig
 delete mode 100644 drivers/video/tegra20/Makefile
 delete mode 100644 include/configs/apalis_t30.h
 delete mode 100644 include/configs/beaver.h
 delete mode 100644 include/configs/cardhu.h
 delete mode 100644 include/configs/cei-tk1-som.h
 delete mode 100644 include/configs/colibri_t20.h
 delete mode 100644 include/configs/colibri_t30.h
 delete mode 100644 include/configs/dalmore.h
 delete mode 100644 include/configs/endeavoru.h
 delete mode 100644 include/configs/grouper.h
 delete mode 100644 include/configs/harmony.h
 delete mode 100644 include/configs/ideapad-yoga-11.h
 delete mode 100644 include/configs/jetson-tk1.h
 delete mode 100644 include/configs/medcom-wide.h
 create mode 100644 include/configs/mot.h
 delete mode 100644 include/configs/nyan-big.h
 delete mode 100644 include/configs/ouya.h
 delete mode 100644 include/configs/p2371-0000.h
 delete mode 100644 include/configs/p2371-2180.h
 delete mode 100644 include/configs/p2571.h
 delete mode 100644 include/configs/p2771-0000.h
 delete mode 100644 include/configs/p3450-0000.h
 delete mode 100644 include/configs/paz00.h
 delete mode 100644 include/configs/picasso.h
 delete mode 100644 include/configs/plutux.h
 delete mode 100644 include/configs/qc750.h
 delete mode 100644 include/configs/seaboard.h
 delete mode 100644 include/configs/surface-rt.h
 delete mode 100644 include/configs/tec-ng.h
 delete mode 100644 include/configs/tec.h
 create mode 100644 include/configs/tegra.h
 create mode 100644 include/configs/tegratab.h
 create mode 100644 include/configs/transformer-t114.h
 delete mode 100644 include/configs/transformer-t20.h
 delete mode 100644 include/configs/transformer-t30.h
 delete mode 100644 include/configs/trimslice.h
 delete mode 100644 include/configs/venice2.h
 delete mode 100644 include/configs/ventana.h
 delete mode 100644 include/configs/x3-t30.h
 create mode 100644 include/power/cpcap.h

This branch incorporates the following changes:
- minor enhancements to the Tegra SPI slink and pinmux drivers
- adjustments to the PLLD and D2 clock configurations
- separation of the GPIO sysreset and poweroff drivers for every stage
- restructuring of the Tegra video directory
- consolidation of per-device config headers
- support for Atrix 4G and Droid X2 (Tegra 2) with PMIC, backlight, and
  panel drivers
- support for ASUS TF701 and Nvidia Tegratab (Tegra 4) tablets

All changes are on top of latest u-boot/master, passed CI and were tested
on devices of all Tegra SoC generations which are affected by changes.

Thanks,
Svyatoslav Ryhel.
