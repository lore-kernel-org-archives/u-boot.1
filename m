Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE023109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0271783DA6;
	Wed, 25 Mar 2026 23:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCJBs0yU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE37E83CD3; Wed, 25 Mar 2026 23:32:48 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F46F83A1B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cfc5941028so69111785a.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477965; x=1775082765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7VitL2nNi3RtoistSWoQ30IOXBiAV/qxWUvkeAzMnHc=;
 b=LCJBs0yUixH/fI4sZ241M/dEemGVOuHUbTDTBdBkBTdE/MMJprK7M3h2wNr/wWxURw
 TgNRKI1xTD6aXySEooxYAXv3H/Dms0fQEY0pXRQgkD4sctU5tybFFYlvnzHTN2L6fcZV
 w5zdyIYtb6RbcKRE3Rz6MX8RLD7fTOZbf9pa5h66Jr4jYUOHGu2/vUoI0reQBQyf2znP
 qGIKzP48oXBMWoJvAWncpe8c63kKiTLmHqXb6iosX2C8BoS4N1Sg6gaXD1QtEHq+LQWZ
 ujdC8wmQgJtwlSPponmpSmYUMCEbxjJjBVpaCZlyrdumf+FQ5+Gok8cr27I67P2jOywH
 E1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477965; x=1775082765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VitL2nNi3RtoistSWoQ30IOXBiAV/qxWUvkeAzMnHc=;
 b=dILLHDZPpnm63NRf/JbXaInMGpJSEZ+hkaNWy3zOAK5yIWQq9HdXzqDcUSSymqw/mv
 tcFOjZNr0koOq/raIVvxGmxsZdOLB79KAZ0lXAB3V5PW216uB6vG2/I/KTLEhqHeOfqY
 PtsakV6LvmoUjHUjG/RnzQsEqFgrbo77UUbViwNdXU6/E6LS7Tq6yAjfOch+numtK/zi
 PWae1z4HBun3+QC9KCE4ACbwjLhuUPLcCjaoFdg6eRdqLh1EFGVBIe3QSjbIEsXB8Cqy
 BuN/CSH4Rlm6/zzEYNHR7BxkyN88gV8tyl2q9Bl+CzB/A5o/3qCJ65iK7U8YQUei1vqo
 UYvQ==
X-Gm-Message-State: AOJu0Yz0izcyZa8T418kh4kiCXgakhKv88BVfrBu2UjAZ734n846fNG3
 WQMxc8tG15nmp55MRq0BH9AUtr+H9WpCGaRXAno6Bsoopgs2OGTy0vUdYalIY9bg
X-Gm-Gg: ATEYQzziFJcGtL4UYd15OsXkptgyHFsajHO5klNx5izrrZtrl+eaE4UC1H9FQXmqcFE
 9fM0HngVRuH2RDu76hyHNJPWISiycu4/Pft9d0Ctr/X9a0loWNJFVmQ6ftU4bKznGeX0NhO8OED
 eNIJCBwDHtQKvctN1NKkItBI7oxSPjPvsMyfaPLXyPW8aYQN7tpbbkw49ZrMjX1M1ZHjFbZBXu+
 AqinfuXf4vw1j2c5Ixj9vnfphTS5b/pHwE37qTC3VE/hDr+gTMD/WGc7HD8sdcwkJymjyu/3x08
 yW+0IEXJxk5TqgaFo1hDusZgfO53o2idqOZpK0/O8bSslaRuNLy+OSbJ2sa/L+Otur847aIJDMC
 wTI211xRUSmit1e4Gng4S9WhhwmUqhg7n4YSfA2VhUTx4pXm6+XoPZG7b2wPi+grdxsXMk9O7Mb
 Bvnj98klDG26mrPwt6ATDoptKK1w7K2qE/FOE6l3RYUBmahrEkB5tihdYPXaJW4HUFzI8yGw/C5
 Ep04lxqpDNjRBr9QQHNDA==
X-Received: by 2002:a05:620a:2584:b0:8cf:d65d:ada2 with SMTP id
 af79cd13be357-8d000f6b26cmr744753385a.32.1774477964521; 
 Wed, 25 Mar 2026 15:32:44 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:32:43 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
Date: Wed, 25 Mar 2026 18:32:16 -0400
Message-Id: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

This series adds SPL support for the SpacemiT K1 SoC, enabling boot
on K1-based boards such as the BananaPi F3.

To verify, please refer to the doc patch "doc: spacemit: add K1 SPL build
and test guide" [1], which is still valid and suggest to be included to
riscv/next.

[1] https://lore.kernel.org/u-boot/20260311073741.80616-1-guodong@riscstar.com/

Changes in v3:
- Merge CONFIG_ARCH_K1 and CONFIG_TARGET_BANANAPI_F3 into
  CONFIG_TARGET_SPACEMIT_K1. This configuration should be used for all
  boards with Spacemit K1 SoC.
- Remove CONFIG_SPL_RESET_SPACEMIT_K1, CONFIG_SPL_CLK_SPACEMIT_K1,
  CONFIG_SPL_PMIC_SPACEMIT_P1, CONFIG_SPL_DM_REGULATOR_SPACEMIT_P1.
  Since they're redundant for SPL stage.
- Fix the calculation on clock ID. While the clock driver is
  initialized in uboot stage, it'll be run twice. Without the
  protection, it'll cause panic in the second time.

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
  reset: k1: remove TWSI8 reset restriction
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

 arch/riscv/Kconfig                            |    8 +-
 arch/riscv/cpu/k1/Kconfig                     |    6 +
 arch/riscv/dts/Makefile                       |    2 +-
 arch/riscv/dts/k1-spl.dts                     |  228 +++
 arch/riscv/dts/k1.dtsi                        |  666 +++++-
 board/spacemit/bananapi-f3/MAINTAINERS        |    6 -
 board/spacemit/bananapi-f3/Makefile           |    5 -
 board/spacemit/{bananapi-f3 => k1}/Kconfig    |    6 +-
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
 drivers/clk/spacemit/Kconfig                  |   22 +
 drivers/clk/spacemit/Makefile                 |    7 +
 drivers/clk/spacemit/clk-k1.c                 | 1798 +++++++++++++++++
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
 drivers/power/pmic/Kconfig                    |    8 +
 drivers/power/pmic/Makefile                   |    1 +
 drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
 drivers/power/regulator/Kconfig               |    8 +
 drivers/power/regulator/Makefile              |    1 +
 .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
 drivers/reset/reset-spacemit-k1.c             |    4 -
 include/configs/bananapi-f3.h                 |   13 -
 include/configs/k1.h                          |   19 +
 .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
 include/power/spacemit_p1.h                   |  163 ++
 include/soc/spacemit/k1-syscon.h              |  149 ++
 44 files changed, 5960 insertions(+), 165 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 delete mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
 delete mode 100644 board/spacemit/bananapi-f3/Makefile
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (79%)
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

