Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC61DD0C61D
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1FE89016;
	Fri, 25 Oct 2024 16:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhKAOQ9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C8189011; Fri, 25 Oct 2024 16:46:56 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A3888FFB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c77459558so17362385ad.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867609; x=1730472409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NCVGsGxdqn5MdM8WWpyoq0pNJDFgkJluuqjedgoMDII=;
 b=PhKAOQ9oL7uCgyB9wLxceiqHD1W6q6DvklTntnDHPy4D+luUOTwLt8kVgBqgf9V4/v
 q64u7D5DCNO5rpfqwD8yQVVgDbx0XosV22/tzSSXlyWMaDf+b1yB65ojlgQwDPLlMEnP
 PekzlemV+Dw8T+tFWWqsttjqZFJqxB+LxNhQiVfFQaKp1JXBcywzPwk2WzQJLEZHe1oV
 W8t0H1me3sH/NWnumgcT6ANL1/GV/zy6TIHyMgl5qMz5HSrDGoEGr3KY9vsmx5FM+Hpb
 aCD71qc89rymbKgldY8/GcCYINeD0FJat+Q4Ob6mYtpnwZzgFCTegE1l72+a85biIBJ2
 vHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867609; x=1730472409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCVGsGxdqn5MdM8WWpyoq0pNJDFgkJluuqjedgoMDII=;
 b=a+B9bLWPFEa3NysPv2/sxMbs1N13xsQ+cMPG2D8JrS6MxgPhaCaaZdGh9e+AaKrGmA
 wR4uMZH4Zy3zMYw6hWVu9300/0MsPh+WAAGwA/BaJUrx99FoK45egyh2iJwV/sWorAiR
 rL/oEnMFy/J89MlKCj0L3aFQUfScIkh/zqxCBmFGLvq4e7GVWTsYI3F7OmBpDUjdJjiX
 DS/tIVJ6hksFff5V8tDT2e9PtxOr2VS92lI5196qjVmTuCwOchlypl7tOyNy9JESK0Lq
 mUfZwQU/jAwbcQWPZWd+xreYdpfjgmXKUthjiS1pcDYYNU7l8kCKNF9gzEsmj+QgwS1T
 WMVA==
X-Gm-Message-State: AOJu0YwgLW8tOHvS6TlvJFrcap4syYABgBjgD6DGiMjb5tKBZZS0MBYj
 2lMgK+TcYLgiDSTDzk1gkVTnvBrJbnI1pdWxVbinje+/3PH9U9xiVD3RJw==
X-Google-Smtp-Source: AGHT+IEpRyIZFdPgaiHnaSeYkro5Yn3S0RcsC1EjX3W292tCx7JBprNCpxkJREwAIYNc8IEk68V0gA==
X-Received: by 2002:a17:902:f542:b0:20c:b9ca:c12d with SMTP id
 d9443c01a7336-20fa9e99ademr134200375ad.38.1729867609001; 
 Fri, 25 Oct 2024 07:46:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ee4e:802c:106a:fda1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e3555c28sm1533247a91.6.2024.10.25.07.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:46:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241025
Date: Fri, 25 Oct 2024 11:46:45 -0300
Message-Id: <20241025144645.1969367-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457c2:

  Mark a few functions static inline (2024-10-24 11:21:48 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241025

for you to fetch changes up to 7ba5eef4543203d2b70c2355c79b932876aa3025:

  ARM: dts: imxrt1170: Fix default cells value warnings (2024-10-25 09:08:34 -0300)

u-boot-imx-master-20241025
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22967

- Remove unneeded USB board code and fix reset on mx6ul_14x14_evk.
- Update fastboot buffer size/address for verdin-imx8m{m|p}.
- Fix imxrt1050-evk boot and convert it to standard boot.
- Fix imx8qxp-mek and imx8qm-mek boot.
- Add support for the i.MX93 9X9 QSB board.
- Make livetree API to work on i.MX.
- Fix size of IVT + CSF blob tacked on to u-boot.itb
- set sane default value for i.MX8M SPL_LOAD_FIT_ADDRESS.
----------------------------------------------------------------
Fabio Estevam (2):
      mx6ul_14x14_evk: Remove unneeded USB board code
      mx6ul_14x14_evk: Convert to watchdog driver model

Hiago De Franco (1):
      verdin-imx8m{m|p}: defconfig: update fastboot buffer size/address

Jesse Taube (4):
      imx: imxrt*: Fix binman breaking boot
      imx: imxrt1050-evk: Fix missing clocks for mmc
      configs: imxrt1050-evk: Enable standard boot
      ARM: dts: imxrt1170: Fix default cells value warnings

Peng Fan (4):
      arm: dts: imx8qxp-mek: fix boot
      arm: dts: imx8qm-mek: fix boot
      imx9: clock: Add 800MHz fracpll entry
      imx: Support i.MX93 9X9 QSB board

Rasmus Villemoes (2):
      imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
      imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb

Tim Harvey (4):
      pinctrl: imx: Convert to use livetree API for fdt access
      imx: power-domain: Convert to use livetree API for fdt access
      i2c: mxc_i2c: Convert to use livetree API for fdt access
      mmc: fsl_esdhc: Convert to use livetree API for fdt access

 arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi            |   33 +
 arch/arm/dts/fsl-imx8qm-mek.dts                    |    1 -
 arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi           |   18 +-
 arch/arm/dts/fsl-imx8qxp-mek.dts                   |    1 -
 arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi             |  162 ++
 arch/arm/dts/imxrt1050.dtsi                        |    2 +-
 arch/arm/dts/imxrt1170-evk.dts                     |    2 +
 arch/arm/mach-imx/imx9/Kconfig                     |    8 +
 arch/arm/mach-imx/imx9/clock.c                     |    1 +
 arch/arm/mach-imx/imx9/clock_root.c                |    3 +-
 board/freescale/imx93_qsb/Kconfig                  |   12 +
 board/freescale/imx93_qsb/MAINTAINERS              |    7 +
 board/freescale/imx93_qsb/Makefile                 |   16 +
 board/freescale/imx93_qsb/imx93_qsb.c              |   33 +
 board/freescale/imx93_qsb/imx93_qsb.env            |   63 +
 board/freescale/imx93_qsb/lpddr4_timing.c          | 1995 ++++++++++++++++++++
 board/freescale/imx93_qsb/lpddr4_timing_ecc.c      | 1995 ++++++++++++++++++++
 board/freescale/imx93_qsb/spl.c                    |  172 ++
 .../freescale/imxrt1050-evk/imxrt1050-evk-nor.env  |   13 +
 board/freescale/imxrt1050-evk/imxrt1050-evk.env    |   13 +
 board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c  |   51 -
 boot/Kconfig                                       |    1 +
 configs/imx93_9x9_qsb_defconfig                    |  139 ++
 configs/imx93_9x9_qsb_inline_ecc_defconfig         |  140 ++
 configs/imxrt1020-evk_defconfig                    |    1 +
 configs/imxrt1050-evk_defconfig                    |    5 +-
 configs/imxrt1050-evk_fspi_defconfig               |    6 +-
 configs/imxrt1170-evk_defconfig                    |    1 +
 configs/mx6ul_14x14_evk_defconfig                  |    5 +-
 configs/verdin-imx8mm_defconfig                    |    3 +-
 configs/verdin-imx8mp_defconfig                    |    3 +-
 doc/board/nxp/imx93_9x9_qsb.rst                    |   70 +
 doc/board/nxp/index.rst                            |    1 +
 drivers/clk/imx/clk-imxrt1050.c                    |    3 +
 drivers/ddr/imx/imx9/Kconfig                       |    5 +
 drivers/i2c/mxc_i2c.c                              |   16 +-
 drivers/mmc/fsl_esdhc_imx.c                        |   15 +-
 drivers/pinctrl/nxp/pinctrl-imx.c                  |   25 +-
 drivers/power/domain/imx8m-power-domain.c          |   18 +-
 include/configs/imx93_qsb.h                        |   25 +
 include/configs/imxrt1050-evk.h                    |    7 -
 tools/binman/etype/nxp_imx8mcst.py                 |    2 +
 42 files changed, 4978 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi
 create mode 100644 board/freescale/imx93_qsb/Kconfig
 create mode 100644 board/freescale/imx93_qsb/MAINTAINERS
 create mode 100644 board/freescale/imx93_qsb/Makefile
 create mode 100644 board/freescale/imx93_qsb/imx93_qsb.c
 create mode 100644 board/freescale/imx93_qsb/imx93_qsb.env
 create mode 100644 board/freescale/imx93_qsb/lpddr4_timing.c
 create mode 100644 board/freescale/imx93_qsb/lpddr4_timing_ecc.c
 create mode 100644 board/freescale/imx93_qsb/spl.c
 create mode 100644 board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env
 create mode 100644 board/freescale/imxrt1050-evk/imxrt1050-evk.env
 create mode 100644 configs/imx93_9x9_qsb_defconfig
 create mode 100644 configs/imx93_9x9_qsb_inline_ecc_defconfig
 create mode 100644 doc/board/nxp/imx93_9x9_qsb.rst
 create mode 100644 include/configs/imx93_qsb.h
