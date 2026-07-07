Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C06FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E89484A4A;
	Tue,  7 Jul 2026 18:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DoZaLEq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA00849F6; Tue,  7 Jul 2026 17:32:22 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFCF8497A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so1780911fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438338; x=1784043138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3VoNW1Ipxm6vnLUzCB/B0/YGtu4POmjIiPcqxbcnkSM=;
 b=DoZaLEq3Hk878UC5IRoKcgTSr9/WUgLSvh8KUaMD3WnVTG+jT2mml8YHf2PTsRZNHC
 Hux18YQWujsO8230knjKgUeRdd9O00A9bERLOc6iOLvCsYMNpzHVxtb31179/7hOg5pN
 BTVxFyauyyyY+Tnx/6mK7jFO38CghgyODWD9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438338; x=1784043138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VoNW1Ipxm6vnLUzCB/B0/YGtu4POmjIiPcqxbcnkSM=;
 b=dvqUfK7YSr4lBM3aYAaK4UeYXcFWYwso8WWT32XxIdMqIwpJ9aTCjJfjJx+jMq5ava
 jlPpgOsfCVb+dXmDDdD+DAJyoVRqhsj2trMZ/dNIhzG2ischvgkFb0NkWG3Ew+N04wkR
 HIfANtms6hvISSh5QKLt4zaSxofCezzZSa75gnPA1xb0ZY6WaT92nZDTkRii0pQVRhV1
 CsqX1WALd59Aj4uXjpFjCD71NGdtBKTKEQzi8JtijdV/mrj6nb1RR81FVsi6EXJDX6c8
 qruA4g0cI3eKLU8rDwiq8/XF/RPls8kVaBQQoTlfS/GwV0HrTZRb3GXOztrrIaMATV6k
 hgAg==
X-Gm-Message-State: AOJu0Yw8/EJChqZhlG0Tg7XynrZG9BS5se3pxg5wfb2rNMExTqCLrbCR
 OmHwQdtCpWJEtb1jenztbHINNxiCbgSrXADIqv8Dbd5Hq4F858+EwtX+iryhuys38m4G5wnFuV7
 F1zUz8Q==
X-Gm-Gg: AfdE7cm+B5jC9MNPsLyT8CbZ9i6OUczuYBHnPLRkkxLD8Eyk58axrhqOqLJ/bDoGn+a
 iypAUi10aMutkUyfnk/u2GZ6Kr2qyQTXdRMTA7iy/CQlczXr0aNCg7hzbAY4E0yq09dy72/WnDi
 2Mx2zL/qy/8NCN/ri7tELvaqui5qFgMxH1wrAV4nogGBQdXLx9mcDYblApMvRcJQI+9B/12OKkf
 EpmXPRkOzGPW3yDGBp4nm5Aep7gEPpaTtwugDcq65w9/A6alLOh1EwATKn/+h206YejRZmVVCrQ
 pBS47Ku5kluSzHiMGkKxVJ6RRvHDCfowfiLj6NITxQ3RFIbTgvgEa1cD3RNCGY+DSJr8BfPIP6w
 kBug9G9Sa5IUdcrwkVwx0ACbmzEhvGEIvC+E31L6LIgwpOImXeD9YP5uEUt7jlUMD/R+qluvcop
 oPlg/dFoc=
X-Received: by 2002:a05:6808:3a0e:b0:485:5f3f:bd1b with SMTP id
 5614622812f47-49fdbb379f7mr3929001b6e.3.1783438337977; 
 Tue, 07 Jul 2026 08:32:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Alexey Charkov <alchark@flipper.net>, Alexey Charkov <alchark@gmail.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Ye Zhang <ye.zhang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 00/15] rockchip: Add support for the RV1103B,
 RV1103 and RV1106
Date: Tue,  7 Jul 2026 09:30:58 -0600
Message-ID: <20260707153135.2048115-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

This series adds support for three small Rockchip camera SoCs and two
boards which use them.

The first eight patches are Fabio Estevam's series adding the RV1103B
and the Onion Omega4 board, updated here to address the review
comments on v2: the board patch is split into SoC and board patches,
the devicetree files move into the patches where they belong and the
pinctrl driver uses regmap_update_bits() throughout. All credit for
this work goes to Fabio. The devicetree concern raised in the v2
review is also resolved now: the devicetree files carried here are the
versions merged in Linux v7.1, verbatim, and can be dropped once the
next dts/upstream sync brings them in.

The remaining patches add the RV1106 and its RV1103 package variant,
following the same structure as the RV1103B patches, together with
the Luckfox Pico Mini B board. These SoCs have no mainline Linux
support yet, so their devicetrees are local for now. The clock and
pinctrl drivers are ported from the Rockchip vendor tree and are the
work of Elaine Zhang and Ye Zhang. The final patch makes the
maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
which both of these boards rely on.

Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the USB
maskrom path and both the SPI NAND and a microSD card are usable. THe
board is running in my lab.

Changes in v3:
- Move the board devicetrees to the board patch and the SoC u-boot.dtsi
  to the SoC patch (Jonas)
- Use the devicetree files as merged in Linux v7.1
- Use regmap_update_bits() in all the remaining places (Jonas)
- Align continuation lines with the open parenthesis (checkpatch)
- Use CONFIG_IS_ENABLED() to guard the set_parent operation, matching
  clk_rk3588.c, since plain IS_ENABLED() needs the CONFIG_ prefix
- Guard the spi-nand checks with SPI_NAND_LOAD so that boards without
  SPI NAND support do not grow in size
- New patch, split out from the board patch (Jonas)
- Include the SoC u-boot.dtsi here (Jonas)
- Match the pmu-grf compatible used by the devicetree merged in Linux
  v7.1
- Split out the SoC support into its own patch (Jonas)
- Move the board devicetree files into this patch (Jonas)
- Add the board to the list in the Rockchip documentation
- Extend the MAINTAINERS entry to cover all the RV1103B files
- Use the board devicetree files as merged in Linux v7.1 and switch
  the default devicetree to rv1103b-omega4-evb

Changes in v2:
- Use the devicetrees submitted to upstream Linux
- Use the original author from Rockchip's vendor U-Boot tree
- Use regmap_update_bits()
- Remove unneeded blank lines
- Remove unneeded logging functions
- Use the original author from Rockchip's vendor U-Boot tree
- Use RV1103B rather than RV1103, which is the correct SoC name

Elaine Zhang (1):
  clk: rockchip: Add RV1103B clock driver

Fabio Estevam (5):
  ARM: dts: Add the RV1103B devicetree files
  rockchip: spl-boot-order: Add SPI NAND support
  spl: Add SPI NAND support via MTD in SPL
  rockchip: rv1103b: Add SoC support
  omega4-rv1103b: Add the initial support

Simon Glass (7):
  tools: rkcommon: Add RV1106 support
  pinctrl: rockchip: Add RV1106 support
  ARM: dts: Add the RV1103/RV1106 devicetree files
  clk: rockchip: Add RV1106 clock driver
  rockchip: rv1106: Add SoC support
  luckfox-pico: Add the initial support
  rockchip: Support legacy images when booting from RAM

Xuhui Lin (1):
  tools: rkcommon: Add RV1103B support

Ye Zhang (1):
  pinctrl: rockchip: Add RV1103B support

 .../rv1103-luckfox-pico-mini-b-u-boot.dtsi    |   10 +
 arch/arm/dts/rv1103-luckfox-pico-mini-b.dts   |   85 ++
 arch/arm/dts/rv1103.dtsi                      |   16 +
 arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi   |   10 +
 arch/arm/dts/rv1103b-omega4-evb.dts           |   63 +
 arch/arm/dts/rv1103b-omega4.dtsi              |  147 ++
 arch/arm/dts/rv1103b-pinctrl.dtsi             |  816 ++++++++++
 arch/arm/dts/rv1103b-u-boot.dtsi              |    4 +
 arch/arm/dts/rv1103b.dtsi                     |  239 +++
 arch/arm/dts/rv1106-pinctrl.dtsi              | 1102 ++++++++++++++
 arch/arm/dts/rv1106-u-boot.dtsi               |    4 +
 arch/arm/dts/rv1106.dtsi                      |  328 ++++
 .../include/asm/arch-rockchip/cru_rv1103b.h   |  266 ++++
 .../include/asm/arch-rockchip/cru_rv1106.h    |  305 ++++
 .../include/asm/arch-rockchip/grf_rv1103b.h   |   31 +
 arch/arm/include/asm/arch-rv1103b/boot0.h     |   11 +
 arch/arm/include/asm/arch-rv1106/boot0.h      |   11 +
 arch/arm/mach-rockchip/Kconfig                |   28 +
 arch/arm/mach-rockchip/Makefile               |    2 +
 arch/arm/mach-rockchip/rv1103b/Kconfig        |   22 +
 arch/arm/mach-rockchip/rv1103b/Makefile       |   12 +
 arch/arm/mach-rockchip/rv1103b/boot0.h        |    5 +
 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c  |   32 +
 arch/arm/mach-rockchip/rv1103b/rv1103b.c      |  133 ++
 .../mach-rockchip/rv1103b/syscon_rv1103b.c    |   19 +
 arch/arm/mach-rockchip/rv1106/Kconfig         |   28 +
 arch/arm/mach-rockchip/rv1106/Makefile        |   12 +
 arch/arm/mach-rockchip/rv1106/clk_rv1106.c    |   31 +
 arch/arm/mach-rockchip/rv1106/rv1106.c        |  118 ++
 arch/arm/mach-rockchip/rv1106/syscon_rv1106.c |   19 +
 arch/arm/mach-rockchip/spl-boot-order.c       |   12 +-
 arch/arm/mach-rockchip/spl.c                  |   53 +-
 board/luckfox/pico/Kconfig                    |   12 +
 board/luckfox/pico/MAINTAINERS                |    6 +
 board/luckfox/pico/Makefile                   |    7 +
 board/luckfox/pico/pico.c                     |   19 +
 board/luckfox/pico/pico.env                   |    4 +
 board/onion/omega4_rv1103b/Kconfig            |   12 +
 board/onion/omega4_rv1103b/MAINTAINERS        |   15 +
 board/onion/omega4_rv1103b/Makefile           |    7 +
 board/onion/omega4_rv1103b/omega4_rv1103b.c   |   19 +
 board/onion/omega4_rv1103b/omega4_rv1103b.env |    5 +
 common/spl/Kconfig                            |   10 +-
 common/spl/Makefile                           |    1 +
 common/spl/spl_spi_nand.c                     |   82 +
 configs/luckfox-pico-mini-b-rv1103_defconfig  |   79 +
 configs/omega4-rv1103b_defconfig              |   82 +
 doc/board/index.rst                           |    2 +
 doc/board/luckfox/index.rst                   |    9 +
 doc/board/luckfox/luckfox-pico.rst            |   71 +
 doc/board/onion/index.rst                     |    9 +
 doc/board/onion/omega4-rv1103b.rst            |   56 +
 doc/board/rockchip/rockchip.rst               |    7 +
 drivers/clk/rockchip/Makefile                 |    2 +
 drivers/clk/rockchip/clk_rv1103b.c            | 1068 +++++++++++++
 drivers/clk/rockchip/clk_rv1106.c             | 1319 +++++++++++++++++
 drivers/mtd/Makefile                          |    1 +
 drivers/mtd/nand/Makefile                     |   13 +-
 drivers/pinctrl/rockchip/Makefile             |    2 +
 drivers/pinctrl/rockchip/pinctrl-rv1103b.c    |  402 +++++
 drivers/pinctrl/rockchip/pinctrl-rv1106.c     |  320 ++++
 include/configs/luckfox_pico.h                |   11 +
 include/configs/omega4_rv1103b.h              |   11 +
 include/configs/rv1103b_common.h              |   14 +
 include/configs/rv1106_common.h               |   13 +
 .../dt-bindings/clock/rockchip,rv1103b-cru.h  |  220 +++
 include/dt-bindings/clock/rv1106-cru.h        |  572 +++++++
 tools/rkcommon.c                              |    2 +
 68 files changed, 8436 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/dts/rv1103-luckfox-pico-mini-b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103-luckfox-pico-mini-b.dts
 create mode 100644 arch/arm/dts/rv1103.dtsi
 create mode 100644 arch/arm/dts/rv1103b-omega4-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b-omega4-evb.dts
 create mode 100644 arch/arm/dts/rv1103b-omega4.dtsi
 create mode 100644 arch/arm/dts/rv1103b-pinctrl.dtsi
 create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b.dtsi
 create mode 100644 arch/arm/dts/rv1106-pinctrl.dtsi
 create mode 100644 arch/arm/dts/rv1106-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1106.dtsi
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103b.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1106.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103b.h
 create mode 100644 arch/arm/include/asm/arch-rv1103b/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rv1106/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1103b/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1103b/boot0.h
 create mode 100644 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
 create mode 100644 arch/arm/mach-rockchip/rv1106/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rv1106/Makefile
 create mode 100644 arch/arm/mach-rockchip/rv1106/clk_rv1106.c
 create mode 100644 arch/arm/mach-rockchip/rv1106/rv1106.c
 create mode 100644 arch/arm/mach-rockchip/rv1106/syscon_rv1106.c
 create mode 100644 board/luckfox/pico/Kconfig
 create mode 100644 board/luckfox/pico/MAINTAINERS
 create mode 100644 board/luckfox/pico/Makefile
 create mode 100644 board/luckfox/pico/pico.c
 create mode 100644 board/luckfox/pico/pico.env
 create mode 100644 board/onion/omega4_rv1103b/Kconfig
 create mode 100644 board/onion/omega4_rv1103b/MAINTAINERS
 create mode 100644 board/onion/omega4_rv1103b/Makefile
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.c
 create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.env
 create mode 100644 common/spl/spl_spi_nand.c
 create mode 100644 configs/luckfox-pico-mini-b-rv1103_defconfig
 create mode 100644 configs/omega4-rv1103b_defconfig
 create mode 100644 doc/board/luckfox/index.rst
 create mode 100644 doc/board/luckfox/luckfox-pico.rst
 create mode 100644 doc/board/onion/index.rst
 create mode 100644 doc/board/onion/omega4-rv1103b.rst
 create mode 100644 drivers/clk/rockchip/clk_rv1103b.c
 create mode 100644 drivers/clk/rockchip/clk_rv1106.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1106.c
 create mode 100644 include/configs/luckfox_pico.h
 create mode 100644 include/configs/omega4_rv1103b.h
 create mode 100644 include/configs/rv1103b_common.h
 create mode 100644 include/configs/rv1106_common.h
 create mode 100644 include/dt-bindings/clock/rockchip,rv1103b-cru.h
 create mode 100644 include/dt-bindings/clock/rv1106-cru.h

---
base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
branch: rocka-us3

-- 
2.43.0

