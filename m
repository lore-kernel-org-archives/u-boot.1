Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA941103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB31839A8;
	Wed, 18 Mar 2026 15:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InFkEkTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B24983AC5; Wed, 18 Mar 2026 15:43:04 +0100 (CET)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE87838FA
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2beab594d8eso2864887eec.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844980; x=1774449780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fV+b21KwTfCNwzSedkVE/jJP6MkGbS5QXd72ZaPQHlI=;
 b=InFkEkTWKIYDBdL51uGOTieLgSLVe5qE+eQnIilkmeWBkOVHwwuACmdsjyX9jUk6jC
 x4SXlRSb2Hr7pGMmcMcDkqmqwXW5hApwDYsLVlnTJtz7YisAhNZZxrNkKr57LkEIM7/c
 BW+TCy1iGGjiajCh09WmW/HPuf4MGm9KHrpJyXukSweNCoSROTYXgeYl52U+Fz1iKxQ9
 6eb3bDfoy+91xtnUhMAHXLTyeWWT51Xp9eJewLVrzbX5j9M1+QbCQszltITefNa2LCOB
 /chDdElkijUy//2cmImu9QPWJUEJFMzAqDOzRgkwwNGJLFIBaNuco7z9eUNSpKfz5m3Z
 j3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844980; x=1774449780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fV+b21KwTfCNwzSedkVE/jJP6MkGbS5QXd72ZaPQHlI=;
 b=aqxcahaii6hl2CVUKSt5Cqk6RlPdK+QN+363ZTZIMV+ddl9iwchCMmRgq2dFRX6Msv
 6jrWJtrefN2puYh7BTlaPCkbz4eiRAYM9MWR9u1OBwIFrp5pxLvvIkuOFDQDDNYK8OJU
 DQ2+OpKZEZuL7eiqfNdTxAyBWDRa/oFwjNQ+63kGT565BjiGmYRAUb3G9LawVix1sdix
 USIttVNPVyGOcV14l7Am0YoC8M9lpPmEllCaI9ELYjO6oFLqsjeX42FWCXD2rDdLLyGH
 NyjB+Rq1Dg2ywoByQ0L5ZhM8xbLZVHtrrpUI8mZViibgn8TU4ruXXq7ggG+gP9CR8FFg
 Mupg==
X-Gm-Message-State: AOJu0YwXV8ViAsWvUXDcKAZ91tvuciH11wGl0rLZKLQl99hgVjmevG/w
 W2rMHGsjtMioKX6dImFNWkO9danON7H1JNph0W6rPI4Ywp+NbcYDgO/h
X-Gm-Gg: ATEYQzzAW7yiUgXYsganbapDvbOagW/c27Dikj7DoIwDTQIncxNkH7QgKs9Xuibes+X
 kP1ykFqBI4nID0mCabqQI35qxsH2SVBFYPPr/dVZCqPmIFFTuQ80175G3I8MR8XhdNvA+OCPVG8
 pLM4z7VUlz5Mpild5u1JdjGOyn68mkfMX/wMIFgiiw9C7GSgTZbVGKyCNtNnSGWZLox4ZfpvsKi
 WC2eMKei9K+Lj/y6FMoEpGlIExzNCFgbvOWj4BYawDGBlx7jDEJsQsYRAVSPwAGXRamLh1FvTKD
 vClgbs0JqqvJwDTiKCEdJbtS5N0hijFsfkRvuHV6Og45NRdUp0qfFjBP7lwswfY+7ww0b6jxztA
 JGnZBiH3t4K9JNUVpgUUEDgTOlw6dVoPPFyZIJRFFnODDHTarikj8XHHeHS+pKdFlVn1uR/2aDE
 u+tOWooXJeF2XgiJ+VPv8jn90y4gge8WJx/k8Mstf4JkOjc/nCWJV1pyMYGxsSTXfLkBr5hg==
X-Received: by 2002:a05:7300:ed0b:b0:2ba:6b03:909b with SMTP id
 5a478bee46e88-2c0e50206cbmr1745301eec.19.1773844979382; 
 Wed, 18 Mar 2026 07:42:59 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:7024:b42e:466a:c302:6c55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e5368a96sm4322689eec.4.2026.03.18.07.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:42:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, fberder@outlook.fr,
 niko.mauno@vaisala.com, peng.fan@oss.nxp.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260318
Date: Wed, 18 Mar 2026 11:42:53 -0300
Message-ID: <20260318144253.173160-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:

  kbuild: strip sub_make_done from test-script environment (2026-03-16 10:41:40 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260318

for you to fetch changes up to e4be6fc6cad5ed93ff44ab9756fec0bbc6525781:

  doc: imx95_evk: Fix the binary name (2026-03-16 18:45:26 -0300)

u-boot-imx-next-20260318
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29557

- Add support for i.MX952.
- Add support for XPI1 on imx943_evk.
----------------------------------------------------------------
Alice Guo (9):
      arm: imx: Add i.MX952 CPU type support
      imx: ele_ahab: Add i.MX952 support to display_life_cycle()
      imx: container: Add i.MX952 support to get_imageset_end()
      arm: imx9: Add i.MX952 SoC support
      cpu: imx952: Add i.MX952 support
      arm: imx9: Keep WDG3/WDG4 untouched for i.MX952
      arm: dts: Add U-Boot device tree for i.MX952 EVK
      spi: nxp_xspi: Add new driver for NXP XSPI controller
      imx943_evk: Enable XSPI1

Fabio Estevam (2):
      doc: imx95_evk: Update Arm GNU toolchain version to 14.2
      doc: imx95_evk: Fix the binary name

Francois Berder (1):
      liebherr: btt: Fix buffer overflow in board_fit_config_name_match

Niko Mauno (1):
      misc: imx_ele: Fix compile without CMD_FUSE

Peng Fan (3):
      arm64: dts: freescale: Add initial device tree for i.MX952
      arm64: dts: freescale: Add i.MX952 EVK basic device tree
      board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x board support

Ye Li (5):
      imx9: scmi: Get DDR size through SM SCMI API
      imx95/imx94: Remove board_phys_sdram_size from each board
      pinctrl: nxp: Add i.MX952 support
      misc: ele_api: Add support for XSPI SET GMID command
      imx94_evk: Get ownership of XSPI control registers protected by GMID in SPL

 MAINTAINERS                                       |    1 +
 arch/arm/dts/imx943-evk-u-boot.dtsi               |   34 +
 arch/arm/dts/imx943-u-boot.dtsi                   |   16 +
 arch/arm/dts/imx952-evk-u-boot.dtsi               |   10 +
 arch/arm/dts/imx952-u-boot.dtsi                   |  290 +++++
 arch/arm/include/asm/arch-imx/cpu.h               |    1 +
 arch/arm/include/asm/mach-imx/ele_api.h           |    2 +
 arch/arm/include/asm/mach-imx/sys_proto.h         |   38 +
 arch/arm/mach-imx/Makefile                        |    2 +-
 arch/arm/mach-imx/ele_ahab.c                      |    2 +-
 arch/arm/mach-imx/image-container.c               |    4 +-
 arch/arm/mach-imx/imx9/Kconfig                    |   21 +
 arch/arm/mach-imx/imx9/scmi/common.h              |   10 +
 arch/arm/mach-imx/imx9/scmi/soc.c                 |   81 +-
 board/liebherr/btt/btt.c                          |    4 +-
 board/nxp/imx94_evk/imx94_evk.c                   |    7 -
 board/nxp/imx94_evk/spl.c                         |   12 +
 board/nxp/imx952_evk/Kconfig                      |   12 +
 board/nxp/imx952_evk/MAINTAINERS                  |    6 +
 board/nxp/imx952_evk/Makefile                     |   14 +
 board/nxp/imx952_evk/imx952_evk.c                 |   26 +
 board/nxp/imx952_evk/imx952_evk.env               |  137 +++
 board/nxp/imx952_evk/spl.c                        |  113 ++
 board/nxp/imx95_evk/imx95_evk.c                   |    7 -
 configs/imx943_evk_defconfig                      |    9 +
 configs/imx952_evk_defconfig                      |  175 +++
 doc/board/nxp/imx952_evk.rst                      |  112 ++
 doc/board/nxp/imx95_evk.rst                       |   10 +-
 doc/board/nxp/index.rst                           |    1 +
 drivers/cpu/imx8_cpu.c                            |    2 +
 drivers/misc/imx_ele/Makefile                     |    3 +-
 drivers/misc/imx_ele/ele_api.c                    |   28 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c            |    6 +-
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/nxp_xspi.c                            |  914 +++++++++++++++
 drivers/spi/nxp_xspi.h                            |  703 ++++++++++++
 dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
 dts/upstream/src/arm64/freescale/imx952-evk.dts   |  217 ++++
 dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
 dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
 dts/upstream/src/arm64/freescale/imx952.dtsi      | 1248 +++++++++++++++++++++
 include/configs/imx952_evk.h                      |   25 +
 include/scmi_protocols.h                          |    3 +-
 44 files changed, 5397 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/dts/imx952-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx952-u-boot.dtsi
 create mode 100644 board/nxp/imx952_evk/Kconfig
 create mode 100644 board/nxp/imx952_evk/MAINTAINERS
 create mode 100644 board/nxp/imx952_evk/Makefile
 create mode 100644 board/nxp/imx952_evk/imx952_evk.c
 create mode 100644 board/nxp/imx952_evk/imx952_evk.env
 create mode 100644 board/nxp/imx952_evk/spl.c
 create mode 100644 configs/imx952_evk_defconfig
 create mode 100644 doc/board/nxp/imx952_evk.rst
 create mode 100644 drivers/spi/nxp_xspi.c
 create mode 100644 drivers/spi/nxp_xspi.h
 create mode 100644 dts/upstream/src/arm64/freescale/imx952-clock.h
 create mode 100644 dts/upstream/src/arm64/freescale/imx952-evk.dts
 create mode 100644 dts/upstream/src/arm64/freescale/imx952-pinfunc.h
 create mode 100644 dts/upstream/src/arm64/freescale/imx952-power.h
 create mode 100644 dts/upstream/src/arm64/freescale/imx952.dtsi
 create mode 100644 include/configs/imx952_evk.h
