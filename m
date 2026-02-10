Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A96EA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C63C83CB5;
	Tue, 10 Feb 2026 16:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfomiFAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2291483CBD; Tue, 10 Feb 2026 16:15:09 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0CA83A5A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-505aaab61d9so8127941cf.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736505; x=1771341305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AsRkx9KlKA+//J2xV0wyuHLF5sRLzNusITJAMBRT/so=;
 b=QfomiFAGVnE/gKmwXGao1IgJFdDD5xvSei8sPdFaMqiTdddXpKNj+7AVV3T1HA4d6w
 6AScTwkNwFx2Y7g6BJ93sKUG5MT0P+xoMH+4uQZvhCL5FzJyXy6rL6qHy0IJHSKLNCDB
 /ByB+ZN6+FlyJBQt0dv8nNWQcE2t638ACHx+ZJfS+5Z4RsBbeFkQo9gMUtCQWP6LsrJx
 DAfXghTdlD83y6u/YL9RZEltQGnZC1FpW2+ka7Hpz1lmrJTCeDPn6vHwmBAdfRf/6YsJ
 AJfaGeNrOk+NV/mUvA7gJwk1QrB7PU9dC+yhaCcbWqdemVwdR5r41XDY4LQsM/yWzEWY
 gwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736505; x=1771341305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsRkx9KlKA+//J2xV0wyuHLF5sRLzNusITJAMBRT/so=;
 b=aK+vJiCp/kbhT1GxYHjfgguYClbtPDqvig+fWXcvGsBEiFNPvD+k4ARPex1Z1L6hnl
 WWQLjFExG6mpS57E5puKFRzytT8Rcd5yKQiNnFuC6Pz7Lde0jCFRlJXuS7gZPxKhHfj7
 QTFw91NsxZIj5HoifiM2JE3iXfM/UypUVsGCm0bZd9nNhuL5r152iz128t2wbSnOlX7e
 ptbd2bAtQ2otdiGT4/XLCWOfAinyAiE3tdNR2hJeZo1ufxsnYdU9OrVgbJjIY0vIj+z/
 seqbx4bSPaiNr1smH7eagBmP+8eC4jD10roJQi77+xwX5ii7HYumKzUUKUJFQorS4jeD
 5VKA==
X-Gm-Message-State: AOJu0YzbLbQVCiG7wZgnPanh+45NJyixqcFP9lIRdUp7SPAWEqGMfH0G
 1+3ckhF6TuJaAZ3lqhiiKuZwN2srOSxB7ToZZ/Q2wBdHA2f9N5jXAlYZWt8aFA==
X-Gm-Gg: AZuq6aIp1H64Wi//UkOlk/MBK3VKWazeYDH7bxUw/j3VhVYuQo2gLZhKWk4D1AI1068
 /BSaVrIR3dUY9scnO8bomsFex7gsyLruXnT51TxZrDcBdJJ/kGzgUEObDs5KNocSs95XRg7tOXc
 EU3yT3F2KAc3HG/4GmPujk322iv/iKyz+yhTaMYgPzTvMzkvmnZ/ewzqD9J4Auysx+1rHlPdnYp
 OOlWKk7eioy12lVnt9sx3cFTPn8ZnUKIaKkrsLIbxsb5seDSN3q7KcQLmp+mI2dEHuL2uENDX7r
 fH2yc2qsKgwUHdtdxxHoRKkPF3/s2GClSgdGBsFJppYuXD6BLHLS+bHhHtxSP9Kk6748U9OAHr8
 dut0kbCOPmcpqieGPaTFzbKZyVXQuEc8cGHdsQQtX2211J/++bUOdjTeREXsL7l0dPrhzY1ea7K
 P7HzpUljrgAP+ma3Q4u1K+64PTMgD6B9O8yHTX/7XqmgFHaZCc4/uKJVOdvacNy+Qmv6GIs8cQc
 /NGjj/+n08=
X-Received: by 2002:a05:622a:40b:b0:501:863a:a887 with SMTP id
 d75a77b69052e-50639a20177mr232033611cf.79.1770736505257; 
 Tue, 10 Feb 2026 07:15:05 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:04 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 00/16] Add board support for Spacemit K1 SoC in SPL
Date: Tue, 10 Feb 2026 10:14:43 -0500
Message-Id: <20260210151459.2348758-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

This patch series introduces full support for the k1 SoC in SPL for
multiple boards.

The series enables the board by:
1. Adding the base board definition with device tree.
2. Bringing up essential clock sources and tree.
3. Initializing I2C buses for peripheral communication.
4. Integrating the PMIC driver for power management.
5. Adding regulator drivers for voltage domain control.

Change in v2:
  - Use read_poll_timeout() in k1 i2c driver.
  - Abandon to parse offset and size from Kconfig & Makefile for binman.
  - Abandon to attach firmware image into the patch set.
  - Update the related document and some minor changes.

Junhui Liu (1):
  clk: spacemit: Add support for K1 SoC

Raymond Mao (15):
  spacemit: k1: support multi-board infrastructure
  spacemit: k1: enable SPL with debug UART
  configs: k1: enable early timer support
  reset: k1: add SPL support and enable TWSI8 reset
  dt-bindings: clock: import k1-syscon from upstream
  dts: k1: import dts file from upstream folder
  dts: k1: enable clocks in SPL
  board: k1: initialize clock and serial devices in SPL
  configs: k1: add default option for clock driver in SPL
  i2c: k1: add I2C driver support
  spacemit: k1: add TLV EEPROM support in SPL
  spacemit: k1: Add DDR firmware support to SPL
  power: pmic: add support for Spacemit P1 PMIC
  power: regulator: add support for Spacemit P1 SoC
  board: k1: enable pmic in spl

 arch/riscv/Kconfig                            |   10 +-
 arch/riscv/cpu/k1/Kconfig                     |    6 +
 arch/riscv/dts/Makefile                       |    1 +
 arch/riscv/dts/k1-spl.dts                     |  228 +++
 arch/riscv/dts/k1.dtsi                        |  666 +++++-
 board/spacemit/bananapi-f3/MAINTAINERS        |    6 -
 board/spacemit/bananapi-f3/Makefile           |    5 -
 board/spacemit/{bananapi-f3 => k1}/Kconfig    |   11 +-
 board/spacemit/k1/MAINTAINERS                 |   11 +
 board/spacemit/k1/Makefile                    |   27 +
 board/spacemit/{bananapi-f3 => k1}/board.c    |    0
 board/spacemit/k1/spl.c                       |  347 ++++
 board/spacemit/k1/tlv_codes.h                 |   22 +
 configs/bananapi-f3_defconfig                 |   24 -
 configs/spacemit_k1_defconfig                 |   76 +
 doc/board/spacemit/bananapi-f3.rst            |    2 +-
 drivers/clk/Kconfig                           |    5 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/spacemit/Kconfig                  |   31 +
 drivers/clk/spacemit/Makefile                 |    7 +
 drivers/clk/spacemit/clk-k1.c                 | 1795 +++++++++++++++++
 drivers/clk/spacemit/clk_common.h             |   79 +
 drivers/clk/spacemit/clk_ddn.c                |   93 +
 drivers/clk/spacemit/clk_ddn.h                |   53 +
 drivers/clk/spacemit/clk_mix.c                |  403 ++++
 drivers/clk/spacemit/clk_mix.h                |  224 ++
 drivers/clk/spacemit/clk_pll.c                |  157 ++
 drivers/clk/spacemit/clk_pll.h                |   81 +
 drivers/i2c/Kconfig                           |    7 +
 drivers/i2c/Makefile                          |    1 +
 drivers/i2c/k1_i2c.c                          |  516 +++++
 drivers/i2c/k1_i2c.h                          |   69 +
 drivers/power/pmic/Kconfig                    |   17 +
 drivers/power/pmic/Makefile                   |    1 +
 drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
 drivers/power/regulator/Kconfig               |   15 +
 drivers/power/regulator/Makefile              |    1 +
 .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
 drivers/reset/Kconfig                         |    7 +
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/reset-spacemit-k1.c             |    4 -
 include/configs/bananapi-f3.h                 |   13 -
 include/configs/k1.h                          |   19 +
 .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
 include/power/spacemit_p1.h                   |  163 ++
 include/soc/spacemit/k1-syscon.h              |  149 ++
 46 files changed, 5997 insertions(+), 165 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 delete mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
 delete mode 100644 board/spacemit/bananapi-f3/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (63%)
 create mode 100644 board/spacemit/k1/MAINTAINERS
 create mode 100644 board/spacemit/k1/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 create mode 100644 board/spacemit/k1/spl.c
 create mode 100644 board/spacemit/k1/tlv_codes.h
 delete mode 100644 configs/bananapi-f3_defconfig
 create mode 100644 configs/spacemit_k1_defconfig
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/clk-k1.c
 create mode 100644 drivers/clk/spacemit/clk_common.h
 create mode 100644 drivers/clk/spacemit/clk_ddn.c
 create mode 100644 drivers/clk/spacemit/clk_ddn.h
 create mode 100644 drivers/clk/spacemit/clk_mix.c
 create mode 100644 drivers/clk/spacemit/clk_mix.h
 create mode 100644 drivers/clk/spacemit/clk_pll.c
 create mode 100644 drivers/clk/spacemit/clk_pll.h
 create mode 100644 drivers/i2c/k1_i2c.c
 create mode 100644 drivers/i2c/k1_i2c.h
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
 delete mode 100644 include/configs/bananapi-f3.h
 create mode 100644 include/configs/k1.h
 create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h
 create mode 100644 include/power/spacemit_p1.h
 create mode 100644 include/soc/spacemit/k1-syscon.h

-- 
2.25.1

