Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8CDE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B903D892E6;
	Mon,  9 Dec 2024 13:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LH3qspO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B13889318; Mon,  9 Dec 2024 13:20:51 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D767B89207
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7273967f2f0so268824b3a.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733746847; x=1734351647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kmrArKjLkPRy3wX+YnhRgwa86SWcImB7bN6YGh+Ln0A=;
 b=LH3qspO7qKp84oAtlLW8lyt5D5VKhYge6AKJyv/fT4JsTn82JReiGipBCrqatq5vCE
 mQC3Krw10S/w9Ty+EvN9hKjYB7ZmMabI5/FI92pKYX6nQvPt9BW9AnrB5FDILyqPLrjj
 kb3t8/3JERsJSUbjulthRBwTWhzH7qkdg7hJjdCgyRu3gKITSTztaizfUijhm48V5nU7
 EhJU1neP6bGzExtesux08VIYcWApO4hToEO5Q3BlXz7T2GPAKE7xvQl0NRJPe8Pmake6
 qV+uMybnLq2R0qAbV+M11MjvSLvLid2XkX/FVrVwSPwILcrYauTe/8An+xOxgZvZZ5/i
 H7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733746847; x=1734351647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmrArKjLkPRy3wX+YnhRgwa86SWcImB7bN6YGh+Ln0A=;
 b=MnLtsbmGveO0z1LkNRLbA61TPDbtTOdWKDLWDWVemKx8UC4ilQVqMs1c+hhk80eQ2N
 qyVv3OjqngO3X3+aM609IcLdvIpJ5JBStvqM7WZ+BKSQuyOKz8t3mxL+gUzE1OHS5dAk
 l5SylFPIMFCmoaTxtZK9B1mnHDtSOlbsK4k12j2rWs1pawHZKcLucQZ463SMHAhdACP6
 C/DawRKR9wxInWY19XqcwTlAxDoChlea/lXEO+0H5jY9HS1UArhatuH3nkb9jfKI5LOJ
 ZhEcDBaUpQ+lyKfRBG663Kz9BGDeNQFshBLQWDmursjuQ1TGYEO/051JNt89+hU4obON
 mngQ==
X-Gm-Message-State: AOJu0YzrsDk+0cz2FnMJk/jsCI4f5HC1/T9456Lmh4SyKYqO3j43ERG2
 mGfyiD/fU+eZCYHBw41dn/annYLd6uQ296c/aQndmA27vGrbq5Gd50asJg==
X-Gm-Gg: ASbGncvS/tZDZeoUD7b7MebnQ0tV8XN9WjtuG9gX2f6lXdrM2f34gp9Ge3dY5Nn0Shn
 r389DLXbjSwy2MGhOZo4ptmR4ktnyseO8x/hp4LAYUqWUUuKo6lprZuERfElf8EN+NH/Srr+yiY
 W2yj1js1BQfilMo6ZO/BE0AeVRRUue0hIr8UuTq1yuH3GaVpqrKP6XdFaxOw2EXl8ItRTjBf7cp
 NwFX7f1YzAxcvLhoq5S2TefAyCPptlVY07nCYPpKNnHja/vDKbz++OkAMWOIZYh
X-Google-Smtp-Source: AGHT+IELSu+sG7IgQHDq0BKeXlxHVvl4+GzdmM+KRHKY2gtfFrxwgjO5SFdx7L6TygGcH1g2ejqt/Q==
X-Received: by 2002:a05:6a20:3d85:b0:1db:eead:c588 with SMTP id
 adf61e73a8af0-1e1b1b4e060mr283560637.29.1733746847048; 
 Mon, 09 Dec 2024 04:20:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fdbe:460b:c250:a651])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725dc0b3ed5sm3352091b3a.87.2024.12.09.04.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:20:46 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20241209
Date: Mon,  9 Dec 2024 09:20:43 -0300
Message-Id: <20241209122043.1208400-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 39759bf9fe3a5b6d4788164fc046f5f8aee5cbff:

  Merge patch series "board: ti: k3-am65: covert last board to OF_UPSTREAM" (2024-12-06 16:39:26 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20241209

for you to fetch changes up to 1c9fe756edba755679e8e4dc525d12e7deda3808:

  board: dhelectronics: Sync env variable dh_som_serial_number with SN (2024-12-07 09:07:45 -0300)

u-boot-imx-next-20241209
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23736

- Add support for the NXP i.MX91 EVK board.
- Improve EEPRON suport on i.MX8MP DHCOM board.
- Switch phycore_imx8mm to using environment text files and
improve environment handling.
----------------------------------------------------------------
Christoph Niedermaier (4):
      arm64: dts: imx8mp: Add aliases for the access to the EEPROM ID page node
      arm64: imx8mp: Read values from M24C32-D write-lockable page on DHCOM i.MX8MP
      lib: hashtable: Prevent recursive calling of callback functions
      board: dhelectronics: Sync env variable dh_som_serial_number with SN

Peng Fan (8):
      gpio: imx_rgpio2p: Move 8ulp_data to data section
      imx9: trdc: correct DEBUG usage
      imx9: gpio: include types.h header
      imx: Add iMX91 support
      clk: imx93: support i.MX91
      pinctrl: imx93: support i.MX91
      arm64: dts: add NXP i.MX91 device tree
      imx: Support i.MX91 11x11 EVK board

Ye Li (3):
      imx93: Update 9x9 part fuses checking
      clk: imx: clk-fracn-gppll: Add new PLL rate
      ddr: imx: Add new rates for i.MX91

Yunus Bas (3):
      phycore_imx8mm: Switch to using env text files
      phycore_imx8mm: Move default bootcmd to board env
      board: phytec: phycore_imx8mm: Add RAUC boot logic to environment

 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi              |    2 +
 arch/arm/dts/imx91-11x11-evk-u-boot.dtsi           |  195 ++
 arch/arm/dts/imx91-u-boot.dtsi                     |   92 +
 arch/arm/include/asm/arch-imx/cpu.h                |    5 +
 arch/arm/include/asm/arch-imx9/clock.h             |    7 +
 arch/arm/include/asm/arch-imx9/gpio.h              |    2 +
 arch/arm/include/asm/arch-imx9/imx91_pins.h        |  770 ++++++++
 arch/arm/include/asm/mach-imx/iomux-v3.h           |    2 +-
 arch/arm/include/asm/mach-imx/sys_proto.h          |    6 +
 arch/arm/mach-imx/imx9/Kconfig                     |   13 +
 arch/arm/mach-imx/imx9/clock.c                     |   37 +-
 arch/arm/mach-imx/imx9/container.cfg               |    6 +-
 arch/arm/mach-imx/imx9/imximage.cfg                |    6 +-
 arch/arm/mach-imx/imx9/soc.c                       |   47 +-
 arch/arm/mach-imx/imx9/trdc.c                      |    2 +-
 board/dhelectronics/common/dh_common.c             |  166 +-
 board/dhelectronics/common/dh_common.h             |   79 +-
 board/dhelectronics/dh_imx6/dh_imx6.c              |    4 +-
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |   75 +-
 board/freescale/imx91_evk/Kconfig                  |   19 +
 board/freescale/imx91_evk/MAINTAINERS              |    7 +
 board/freescale/imx91_evk/Makefile                 |   16 +
 board/freescale/imx91_evk/imx91_evk.c              |   33 +
 board/freescale/imx91_evk/imx91_evk.env            |   63 +
 board/freescale/imx91_evk/lpddr4_timing_1600mts.c  | 1995 ++++++++++++++++++++
 .../imx91_evk/lpddr4_timing_1600mts_ecc.c          | 1995 ++++++++++++++++++++
 board/freescale/imx91_evk/lpddr4_timing_2400mts.c  | 1995 ++++++++++++++++++++
 .../imx91_evk/lpddr4_timing_2400mts_ecc.c          | 1995 ++++++++++++++++++++
 board/freescale/imx91_evk/spl.c                    |  167 ++
 board/phytec/phycore_imx8mm/phycore_imx8mm.env     |   65 +
 configs/dhsom.config                               |    1 +
 configs/imx91_11x11_evk_defconfig                  |  145 ++
 configs/imx91_11x11_evk_inline_ecc_defconfig       |  146 ++
 configs/phycore-imx8mm_defconfig                   |    2 -
 doc/board/nxp/imx91_11x11_evk.rst                  |   70 +
 doc/board/nxp/index.rst                            |    1 +
 drivers/clk/imx/clk-fracn-gppll.c                  |    5 +-
 drivers/clk/imx/clk-imx93.c                        |   52 +-
 drivers/cpu/imx8_cpu.c                             |   10 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    8 +
 drivers/gpio/imx_rgpio2p.c                         |    2 +-
 drivers/pinctrl/nxp/pinctrl-imx93.c                |    1 +
 .../include/dt-bindings/clock/imx93-clock.h        |    6 +-
 .../src/arm64/freescale/imx91-11x11-evk.dts        |  875 +++++++++
 dts/upstream/src/arm64/freescale/imx91-pinfunc.h   |  770 ++++++++
 dts/upstream/src/arm64/freescale/imx91.dtsi        |   70 +
 include/configs/imx91_evk.h                        |   21 +
 include/configs/phycore_imx8mm.h                   |   46 -
 lib/hashtable.c                                    |   27 +-
 49 files changed, 12023 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/dts/imx91-11x11-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx91-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-imx9/imx91_pins.h
 create mode 100644 board/freescale/imx91_evk/Kconfig
 create mode 100644 board/freescale/imx91_evk/MAINTAINERS
 create mode 100644 board/freescale/imx91_evk/Makefile
 create mode 100644 board/freescale/imx91_evk/imx91_evk.c
 create mode 100644 board/freescale/imx91_evk/imx91_evk.env
 create mode 100644 board/freescale/imx91_evk/lpddr4_timing_1600mts.c
 create mode 100644 board/freescale/imx91_evk/lpddr4_timing_1600mts_ecc.c
 create mode 100644 board/freescale/imx91_evk/lpddr4_timing_2400mts.c
 create mode 100644 board/freescale/imx91_evk/lpddr4_timing_2400mts_ecc.c
 create mode 100644 board/freescale/imx91_evk/spl.c
 create mode 100644 board/phytec/phycore_imx8mm/phycore_imx8mm.env
 create mode 100644 configs/imx91_11x11_evk_defconfig
 create mode 100644 configs/imx91_11x11_evk_inline_ecc_defconfig
 create mode 100644 doc/board/nxp/imx91_11x11_evk.rst
 create mode 100644 dts/upstream/src/arm64/freescale/imx91-11x11-evk.dts
 create mode 100644 dts/upstream/src/arm64/freescale/imx91-pinfunc.h
 create mode 100644 dts/upstream/src/arm64/freescale/imx91.dtsi
 create mode 100644 include/configs/imx91_evk.h
