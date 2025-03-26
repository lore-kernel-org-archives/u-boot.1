Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8C7C3600B
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F48810E8;
	Wed, 26 Mar 2025 18:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3ZyFujJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B1D81951; Wed, 26 Mar 2025 18:10:10 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B22A8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab771575040so233456466b.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743009007; x=1743613807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I5ZbMflQF+XUYKl7ES2UXMMgreEb/cSyVA5Lgw+Giak=;
 b=A3ZyFujJWfVCXWhVjbFoRd1B8DcUu9bM2pQOSKq3rqYUOlgnMM2Yx+GbxA8+AdXzla
 L/LVPZ2PbZjfF6WA/ZvpwVxdmHG1QjOQCB08pVt/gdKJJCIp1ZfROPmhyMfFMGKfAaI5
 KrqvClL5gfALEPYEqandbEV4Lh/G8onVPTn6pYLJKnayBiRfmaDKel5xL9bCrAyDki+Q
 4Z9qc9fDDbB0oyb6EzTj97czcIlGTFpT3feA4PS9FVIscl+HujeD/+maRaHm142YVm93
 MQ2EhRu/ebIVXibTR+r3WDR8wnbHpZvHP0RknurpS6YHxzGEWqCgZ7XxhS8UI6nmVOGc
 Z9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743009007; x=1743613807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5ZbMflQF+XUYKl7ES2UXMMgreEb/cSyVA5Lgw+Giak=;
 b=a6oWnC36GP7ggDqVF8rNWxc7ziMUdk+6DwWZZ86z7EKcN5T2zw2OfdUd+a9+LFpxgr
 APLBzy89yO78JEKbEypYcPgUKt32mQUoIdDWaw98JKVdOmaPRdGmIFAnArv6zArOSTzH
 JLvrjgNjSa83kpLC9FXl6zhXcuv2BG6pjJcRDDu+pK6oTAy979h4WkIedstWuFDcJeNS
 9EPHu9ELmhTntoTjBVwdrqn7rekjmxQBul5jsqYFUiw5fjUsYE3QwwFdNCyzpSZ8MfMQ
 5IEdGIjNRvoravqehDd6Hp5c4yzpEM5DSxIqhD0QdoMa3zq/XjGWg861KNtSLEFdjwOm
 iW6Q==
X-Gm-Message-State: AOJu0YwBxz2KKyP4KZb+p4OhoCkGogEspLmuPfWJ7i+yRE0AS0qqV8Wv
 oPNMaTpyRHMEq+eLjCWRzZlkP0+0mUwOcs57AUn9sywPpXLbV6W1ijVQtA==
X-Gm-Gg: ASbGncv1CwfGY8MPpg3zrku7ELHvT3/3DaBLs34b8GTyZliZwEjcydyGfiQ8ZDGrrG9
 Bo4VCisbNbM9YDBB0SjQ8j/qalL3WA+Viyy3qZS1MTTMKmwcExQuFo3g6tuI13pU4Wgj3DehAZ5
 tVOA2CJfbTBha2v0HfpgdGk6LtevesO7tx6uSzDkrDR0GJcWX8JOvLs74IPLq+oRr15NPEp6gTg
 UlmsluFIaq0I+pM0SC28CCpErPKamdMpePK9E1RCg8MRWHxKUPBZcuBKpEGGLbEhrZ70HFnAHbT
 8JcIP4A+LJzZf3fCoxz3usfqjmMKrCceqhJr+ZwmMCJZNSo=
X-Google-Smtp-Source: AGHT+IH53qDLtilugKl/JhWfsJhGxBeQ4ivskM5bwBvZntDJVo3GfcrNs/5fvP5BnTHOjOG5OIRFXw==
X-Received: by 2002:a17:907:3ea1:b0:ac6:fc40:c999 with SMTP id
 a640c23a62f3a-ac6fc40ca6amr1626766b.6.1743009007013; 
 Wed, 26 Mar 2025 10:10:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef869f56sm1076582066b.17.2025.03.26.10.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:10:06 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra staging
Date: Wed, 26 Mar 2025 19:09:37 +0200
Message-ID: <20250326170937.95794-1-clamor95@gmail.com>
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

The following changes since commit eeefcacb851f7f0bccabc3089a725f5ce86f5c70:

  Merge tag 'u-boot-stm32-20250312' of https://source.denx.de/u-boot/custodians/u-boot-stm into next (2025-03-12 21:36:52 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging

for you to fetch changes up to 03f61b153965101f21783e8e6a1e5e86496598ff:

  board: ouya: add Ouya Game Console support (2025-03-19 11:04:41 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (47):
      video: tegra20: implement a minimal HOST1X driver for essential clock and reset setup
      video: tegra20: provide driver support for the HDMI controller
      video: tegra20: dc: add video bridge support
      video: tegra20: dc: convert to use of_graph
      video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI is used
      video: tegra20: dc: remove unused video operations
      video: tegra20: dc: support binding child devices
      video: tegra20: pwm-backlight: convert into DC child
      video: tegra20: dsi: convert to video bridge UCLASS
      video: tegra20: dsi: respect speed mode used for DSI commands transfer
      video: bridge: dp501: convert to video bridge UCLASS
      video: bridge: tc358768: convert to video bridge UCLASS
      video: bridge: tc358768: convert to use of_graph
      video: bridge: tc358768: simplify power supplies request
      video: bridge: tc358768: remove need in clock name
      video: bridge: ssd2825: convert to video bridge UCLASS
      video: bridge: ssd2825: convert to use of_graph
      video: bridge: ssd2825: move post configuration from transfer function
      video: bridge: ssd2825: add HS delays configuration
      video: bridge: ssd2825: make pixel format calculation more obvious
      video: bridge: ssd2825: set default minimum tx_clk
      video: bridge: ssd2825: add power supplies
      video: bridge: ssd2825: fix reset gpio direction
      video: endeavoru-panel: move backlight request after probe
      video: endeavoru-panel: add missing LPM flag
      video: lg-ld070wx3: add missing LPM flag
      video: renesas-r61307: add missing mode flags
      video: renesas-r61307: adjust compatible
      video: renesas-r61307: fix reset gpio direction
      video: renesas-r69328: add missing mode flags
      video: renesas-r69328: fix reset gpio direction
      video: renesas-r69328: add power supplies
      video: samsung-ltl106hl02: add missing LPM flag
      video: sharp-lq101r1sx01: add missing LPM flag
      video: backlight: lm3533: add more flexibility with device tree
      video: backlight: lm3533: configure core in the probe
      video: backlight: lm3533: set up backlight according to device tree
      video: edid: guard standard timings EDID expansion behind kconfig
      ARM: tegra: lg_x3: upgrade video bindings
      ARM: tegra: endeavoru: upgrade video bindings
      ARM: tegra: p1801-t: configure HDMI binding
      ARM: tegra: tf700t: upgrade video bindings
      pinctrl: tegra: adjust default values of pins
      pinctrl: tegra: adjust pin state lists
      pinctrl: tegra20: fix function naming mismatches
      ARM: tegra: dts: fix lock, io-reset and open-drain properties
      board: ouya: add Ouya Game Console support

 arch/arm/dts/Makefile                           |    1 +
 arch/arm/dts/tegra124-xiaomi-mocha.dts          |   14 +-
 arch/arm/dts/tegra30-asus-p1801-t.dts           |   40 +-
 arch/arm/dts/tegra30-asus-tf600t.dts            |   44 +-
 arch/arm/dts/tegra30-asus-tf700t.dts            |   96 ++-
 arch/arm/dts/tegra30-asus-transformer.dtsi      |   26 +-
 arch/arm/dts/tegra30-htc-endeavoru.dts          |   17 +-
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts |   46 +-
 arch/arm/dts/tegra30-lg-p880.dts                |   34 +-
 arch/arm/dts/tegra30-lg-p895.dts                |   55 +-
 arch/arm/dts/tegra30-lg-x3.dtsi                 |   82 ++-
 arch/arm/dts/tegra30-microsoft-surface-rt.dts   |   38 +-
 arch/arm/dts/tegra30-ouya.dts                   | 2063 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/tegra30-wexler-qc750.dts           |   10 +-
 arch/arm/include/asm/arch-tegra/dc.h            |   46 +-
 arch/arm/include/asm/arch-tegra/pinmux.h        |   20 +-
 arch/arm/include/asm/arch-tegra20/pinmux.h      |    6 +-
 arch/arm/mach-tegra/tegra30/Kconfig             |    5 +
 board/ouya/ouya/Kconfig                         |   12 +
 board/ouya/ouya/MAINTAINERS                     |    8 +
 board/ouya/ouya/Makefile                        |   11 +
 board/ouya/ouya/ouya-spl.c                      |   41 ++
 board/ouya/ouya/ouya.c                          |   21 +
 board/ouya/ouya/ouya.env                        |   12 +
 common/edid.c                                   |    6 +
 configs/endeavoru_defconfig                     |    1 +
 configs/ouya_defconfig                          |   86 +++
 configs/transformer_t30_defconfig               |    2 +
 configs/x3_t30_defconfig                        |    1 +
 doc/board/index.rst                             |    1 +
 doc/board/ouya/index.rst                        |    9 +
 doc/board/ouya/ouya.rst                         |  124 ++++
 drivers/pinctrl/tegra/pinctrl-tegra.c           |   34 +-
 drivers/video/Kconfig                           |    6 +
 drivers/video/bridge/Kconfig                    |    8 +-
 drivers/video/bridge/dp501.c                    |   27 +-
 drivers/video/bridge/ssd2825.c                  |  159 +++--
 drivers/video/bridge/tc358768.c                 |  101 +--
 drivers/video/endeavoru-panel.c                 |   21 +-
 drivers/video/lg-ld070wx3.c                     |    2 +-
 drivers/video/lm3533_backlight.c                |  142 ++++-
 drivers/video/renesas-r61307.c                  |   13 +-
 drivers/video/renesas-r69328.c                  |   37 +-
 drivers/video/samsung-ltl106hl02.c              |    2 +-
 drivers/video/sharp-lq101r1sx01.c               |    1 +
 drivers/video/tegra20/Kconfig                   |   16 +-
 drivers/video/tegra20/Makefile                  |    2 +
 drivers/video/tegra20/tegra-dc.c                |  233 +++++--
 drivers/video/tegra20/tegra-dc.h                |    3 -
 drivers/video/tegra20/tegra-dsi.c               |   12 +-
 drivers/video/tegra20/tegra-hdmi.c              |  623 +++++++++++++++++++
 drivers/video/tegra20/tegra-hdmi.h              |  648 +++++++++++++++++++
 drivers/video/tegra20/tegra-host1x.c            |   86 +++
 drivers/video/tegra20/tegra-pwm-backlight.c     |   12 +-
 include/configs/ouya.h                          |   23 +
 include/env/nvidia/prod_upd.env                 |    5 +-
 56 files changed, 4712 insertions(+), 482 deletions(-)
 create mode 100644 arch/arm/dts/tegra30-ouya.dts
 create mode 100644 board/ouya/ouya/Kconfig
 create mode 100644 board/ouya/ouya/MAINTAINERS
 create mode 100644 board/ouya/ouya/Makefile
 create mode 100644 board/ouya/ouya/ouya-spl.c
 create mode 100644 board/ouya/ouya/ouya.c
 create mode 100644 board/ouya/ouya/ouya.env
 create mode 100644 configs/ouya_defconfig
 create mode 100644 doc/board/ouya/index.rst
 create mode 100644 doc/board/ouya/ouya.rst
 create mode 100644 drivers/video/tegra20/tegra-hdmi.c
 create mode 100644 drivers/video/tegra20/tegra-hdmi.h
 create mode 100644 drivers/video/tegra20/tegra-host1x.c
 create mode 100644 include/configs/ouya.h

This branch contains a set of changes mostly targeting video support on
various Tegra-based devices:

- added a simple HOST1x driver to have a dedicated place for clock and
  reset configurations of the bus
- added HDMI support for Tegra20 and Tegra30
- improved DC configuration and added support for interaction with various
  internal and external bridges and panels (backwards compatibility
  preserved) along with Linux-style OF graph bindings
- Tegra DSI, DP501, TC358768, and SSD2825 converted to VIDEO_BRIDGE UCLASS
- TC358768 and SSD2825 converted to use OF graph-style bindings
- various TC358768 and SSD2825 fixes for supplies, clocks, GPIO, and
  calculations in general
- Endeavour panel adjusted to better work with Tegra PWM backlight
- corrected GPIO and supplies behavior on Renesas-based panels used in
  LG P880/P895
- added missing LPM flag to various panels used in Tegra devices
- added a more flexible device tree configuration layout for LM3533
  backlight
- added guards for recently added standard timings EDID expansion
- upgraded device tree bindings according to the listed changes

Miscellaneous fixes:

- resolved the conflict of Linux pin control bindings with the Tegra
  pinctrl driver regarding lock, io-reset, and open-drain properties
- adjusted pinmux bindings on affected devices
- fixed pin and function label mismatches in Tegra20 pinctrl

Additionally, a new Tegra30-based device is being added, which is an Ouya
game console.

All changes were tested on supported devices of all affected Tegra SoC
generations. CI tests passed.

Thanks,
Svyatoslav Ryhel.
