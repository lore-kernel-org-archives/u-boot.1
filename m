Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF977F94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B6784198;
	Wed, 22 Apr 2026 03:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1WMvrkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B7983936; Wed, 22 Apr 2026 03:46:39 +0200 (CEST)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD6684198
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2e622a9da9cso4339479eec.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776822394; x=1777427194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zR2sFkgAVL71+IAnaB6tRnzJKwuZ39Qf9A4AoP9dpUg=;
 b=q1WMvrkbWQ4T3OYR8oOrWpl/LBi8MI0bIgQRIM7bpiaPQbriRqXrvYAfreSmMm5WlW
 vbAzxFsvUegpvrn7a2C/dVNW4XNJDdl+cw40hMb9X0975yuwcuFli/ec5//+YdL01IT4
 WOw9b0t4Z624ITiVen0vGLElUmxU6xURWx7mNnNBsxRAvW7KCqQ5VfneOwh0prn65GR1
 9icbd9OUHzAJEIQ46evwoXj8d80eiXBRQh3RxZc5No9gvwV3OeQ3P5O1ugJvT+GaEkoI
 LGRcato6iFtNt5pDmt0+unKGbRYb3niqsXoptyprzlTEoHI5eVvxn9QP0In0yRYWg53S
 388w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822394; x=1777427194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR2sFkgAVL71+IAnaB6tRnzJKwuZ39Qf9A4AoP9dpUg=;
 b=Crk46JRIbQBJ/y2O5epoVwwKtAcrOZeNcMgALZIQFUhhWyNqfh48SZOMNxcvBY+JOm
 jhYGKvOWwpKwkyvRcWifP53YI4yl1XN+dlM+Z90fjbtTm5cTNW1amBIC3Ca04767SJEV
 erdij9bMv8ku/VaZ6y0EGbdVuNPoR4cNOC8HpI6ZrzJ9ceXsHD/FYAaJP5pMrPu+L6SS
 WYFo8GLrVSc02d4Qw6WKarpKfaXJXG0eUoPTwQSAS43vvrslYtlnWNz+osIpvPbUB2ik
 ux5bhLCt+cq9gvG7cP5SNIotrgKWlQDZdKZMIAXjv+QDC31z4JSIcQmGcsltPE1Me7uA
 kCyA==
X-Gm-Message-State: AOJu0YxT9dWNAsqIMA8KSqhSqqZ1gKTAFCFPuAVXuMaSaAumlWewHoQD
 KElevmaIuZA9r/alBtWi5flthNm+o8+Tmwb3eZEO+xjMla9ccdtg3JWz
X-Gm-Gg: AeBDievuYZeLR/OMGC9r9ebL1mlEQMdoMPJoZYbA5bN2EQSFJ+ZNJhBxvFVwJxV4T4n
 3k4MFGhTMFicNNy9viyEWOkFIfQi3fSntswZrv22u4oP3xKHRWMtoc4n9y7/o8HshZrAdwyuCoH
 XSJ+SMvrG9MS98dAvAFUWT6Yb5yzlPcCT66u5ZuUHKeSWq1Vjf8WucxIAzgblrVdz8g2gCqeyAN
 W4C3JcP4plP0T/hIVyUBLHrVO7aUx3NV++b2rQk2skZTM2jiaTVUXAsXHWOlFOyvuLq7xjAdQED
 s4e8K1g/EJhEDAmYUixQM6EAdqYaZI3ZHooAPW6QMwgoUnzu9uv6WBPhM1Q7/hiZFg2bOlLvhWz
 thOv+x/3vB/6eLUHszG6lwaC1Zo0BvBdHslVFrQFYx5bge0XCGUYwauUNtkZCcAayMcDDDHDK4b
 z4hTGFlrCkmdQI/UhqIXRvaBZigL72WCzlViToUlkw0gUz1q0goMVQVw1+yoI2xhnR+Tt5PK25j
 h7WXVuYaXUWzARpb14=
X-Received: by 2002:a05:7300:2392:b0:2ce:f3d7:221 with SMTP id
 5a478bee46e88-2e478a2f29cmr13065922eec.17.1776822393962; 
 Tue, 21 Apr 2026 18:46:33 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:bd17:4311:47b3:4c2c:8e76])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b3dd9sm21280409eec.27.2026.04.21.18.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 18:46:33 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, franz.schnyder@toradex.com,
 alexander.feilke@ew.tq-group.com, cniedermaier@dh-electronics.com,
 emanuele.ghidoli@toradex.com, peng.fan@oss.nxp.com, primoz.fiser@norik.com,
 simona.toaca@oss.nxp.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20260421
Date: Tue, 21 Apr 2026 22:46:27 -0300
Message-ID: <20260422014627.1870805-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:

  Merge patch series "Linux compat improvements and CCF prep" (2026-04-21 11:21:59 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260421

for you to fetch changes up to 589153f6070a285a60411d032ce9b08598acd707:

  imx8mq: phanbell: enable SPL DM (2026-04-21 20:49:40 -0300)

u-boot-imx-master-20260421
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29880

- Convert TQMA7 boards to SPL.
- Use second Ethernet MAC also from fuse on i.MX dhelectronics boards.
- Add support for Toradex Verdin iMX95.
- Drop SPL_POWER_LEGACY from imx8m boards.
- Increase the Aquantia Ethernet PHY reset timeout.
----------------------------------------------------------------
Alexander Feilke (7):
      Kconfig: update build-target for MX7 with SPL
      board/tq: Add common SoM API
      arch: arm: dts: tqma7x: add u-boot device tree fragments
      arch: arm: dts: tqma7x: add boot phase properties
      board: tqma7: add code for u-boot with spl
      configs: tqma7: add defconfigs
      doc: tqma7: add documentation

Christoph Niedermaier (1):
      board: dhelectronics: imx: Use second Ethernet MAC also from fuse

Emanuele Ghidoli (3):
      common: memsize: add RAM size probe based on alias detection
      board: toradex: add Toradex Verdin iMX95
      toradex: tdx-cfg-block: add verdin imx95 0226, 0227 and 0228 pid4

Nora Schiffer (1):
      env: add env_set_runtime() helper

Peng Fan (15):
      imx8mq: evk: drop redundant gd clearing in board_init_f
      imx8mq: pitx: drop redundant gd clearing in board_init_f
      imx8mq: phanbell: drop redundant gd clearing in board_init_f
      imx8mq: reform2: drop redundant gd clearing in board_init_f
      imx8mq: pico: drop redundant gd clearing in board_init_f
      imx8mq: cm: drop redundant gd clearing in board_init_f
      imx8mq: Correct signed_hdmi firmware position
      mx6: sabreauto/sd: Exclude power_init_board from SPL build
      board: nxp: common: fix PFUZE100 DM build and unify DM/non-DM handling
      imx8mq: evk: Migrate to DM PMIC framework
      imx8mq: phanbell: Drop SPL_POWER_LEGACY
      imx8mq: reform2: Drop SPL_POWER_LEGACY
      imx8mq: pico: Drop SPL_POWER_LEGACY
      imx8mq: kontron: migrate PITX-IMX8M to DM PMIC framework
      imx8mq: phanbell: enable SPL DM

Primoz Fiser (1):
      imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs

Simona Toaca (2):
      drivers: ddr: imx: Fix Kconfig for SAVED_DRAM_TIMING_BASE
      configs: imx9{43, 5}: Enable SPI SFDP support

Ye Li (2):
      net: phy: aquantia: Increase timeout for out of reset
      net: fsl_enetc: Add iMX95 enetc4 10Gbps port support

 Kconfig                                            |    2 +-
 arch/arm/dts/imx7d-mba7-u-boot.dtsi                |   10 +
 arch/arm/dts/imx7s-mba7-u-boot.dtsi                |   48 +
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi               |   22 +
 arch/arm/dts/imx8mq-evk-u-boot.dtsi                |   88 +-
 arch/arm/dts/imx8mq-kontron-pitx-imx8m-u-boot.dtsi |   64 ++
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi         |    2 +-
 arch/arm/dts/imx8mq-phanbell-u-boot.dtsi           |   41 +
 arch/arm/dts/imx8mq-u-boot.dtsi                    |  240 ++--
 arch/arm/dts/imx95-verdin-dev.dtsi                 |  239 ++++
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi     |  112 ++
 arch/arm/dts/imx95-verdin-wifi-dev.dts             |   21 +
 arch/arm/dts/imx95-verdin-wifi.dtsi                |   50 +
 arch/arm/dts/imx95-verdin.dtsi                     | 1172 ++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                     |    8 +-
 arch/arm/mach-imx/mx7/Kconfig                      |   16 +
 board/dhelectronics/common/dh_imx.c                |    4 +-
 board/dhelectronics/common/dh_imx.h                |    3 +-
 board/dhelectronics/dh_imx6/dh_imx6.c              |    2 +-
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |    6 +-
 board/google/imx8mq_phanbell/spl.c                 |  127 +--
 board/kontron/pitx_imx8m/spl.c                     |  188 +---
 board/mntre/imx8mq_reform2/spl.c                   |    6 -
 board/nxp/common/Makefile                          |    2 +-
 board/nxp/common/pfuze.c                           |   96 +-
 board/nxp/common/pfuze.h                           |    2 +-
 board/nxp/imx8mq_evk/spl.c                         |  186 +---
 board/nxp/mx6sabreauto/mx6sabreauto.c              |    2 +
 board/nxp/mx6sabresd/mx6sabresd.c                  |    2 +
 board/ronetix/imx8mq-cm/spl.c                      |    5 -
 board/technexion/pico-imx8mq/spl.c                 |    6 -
 board/toradex/common/tdx-cfg-block.c               |    3 +
 board/toradex/common/tdx-cfg-block.h               |    3 +
 board/toradex/verdin-imx95/Kconfig                 |   36 +
 board/toradex/verdin-imx95/MAINTAINERS             |   13 +
 board/toradex/verdin-imx95/Makefile                |    8 +
 board/toradex/verdin-imx95/spl.c                   |   75 ++
 board/toradex/verdin-imx95/verdin-imx95.c          |   80 ++
 board/toradex/verdin-imx95/verdin-imx95.env        |   20 +
 board/tq/MAINTAINERS                               |    9 +
 board/tq/common/Kconfig                            |    3 +
 board/tq/common/Makefile                           |    1 +
 board/tq/common/tq_som.c                           |   32 +
 board/tq/common/tq_som.h                           |   35 +
 board/tq/tqma7/Kconfig                             |  103 ++
 board/tq/tqma7/Makefile                            |   14 +
 board/tq/tqma7/spl.c                               |  123 ++
 board/tq/tqma7/spl_mba7.c                          |  182 +++
 board/tq/tqma7/spl_tqma7_ram.c                     |  171 +++
 board/tq/tqma7/tqma7.c                             |   96 ++
 board/tq/tqma7/tqma7.cfg                           |   26 +
 board/tq/tqma7/tqma7.env                           |   35 +
 board/tq/tqma7/tqma7_mba7.c                        |  148 +++
 common/memsize.c                                   |   59 +
 configs/imx8mq_evk_defconfig                       |   21 +-
 configs/imx8mq_phanbell_defconfig                  |   14 +-
 configs/imx8mq_reform2_defconfig                   |    1 -
 configs/imx943_evk_defconfig                       |    1 +
 configs/imx95_evk.config                           |    1 +
 configs/kontron_pitx_imx8m_defconfig               |   16 +-
 configs/pico-imx8mq_defconfig                      |    1 -
 configs/tqma7_common.config                        |  119 ++
 configs/tqma7_mba7_mmc_defconfig                   |    2 +
 configs/tqma7_mba7_qspi_defconfig                  |    2 +
 configs/tqma7_mba7_uuu_defconfig                   |    2 +
 configs/tqma7_mmc.config                           |    4 +
 configs/tqma7_qspi.config                          |    7 +
 configs/tqma7_uuu.config                           |   22 +
 configs/verdin-imx95_defconfig                     |  183 +++
 doc/board/index.rst                                |    1 +
 doc/board/nxp/imx8mq_evk.rst                       |    4 +-
 doc/board/toradex/index.rst                        |    1 +
 doc/board/toradex/verdin-imx95.rst                 |  171 +++
 doc/board/tq/index.rst                             |   12 +
 doc/board/tq/tqma7.rst                             |   77 ++
 drivers/ddr/imx/imx9/Kconfig                       |    2 +-
 drivers/ddr/imx/phy/helper.c                       |   13 +
 drivers/net/fsl_enetc.c                            |   57 +-
 drivers/net/fsl_enetc.h                            |    1 +
 drivers/net/fsl_enetc_xpcs_phy.c                   |  970 ++++++++++++++++
 drivers/net/phy/aquantia.c                         |    2 +-
 include/configs/tqma7.h                            |   71 ++
 include/configs/tqma7_mba7.h                       |   16 +
 include/configs/verdin-imx95.h                     |   27 +
 include/env.h                                      |   20 +
 include/env/tq/spi.env                             |    4 +
 include/init.h                                     |    7 +
 87 files changed, 5233 insertions(+), 666 deletions(-)
 create mode 100644 arch/arm/dts/imx7d-mba7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-mba7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-tqma7-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-dev.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev.dts
 create mode 100644 arch/arm/dts/imx95-verdin-wifi.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin.dtsi
 create mode 100644 board/toradex/verdin-imx95/Kconfig
 create mode 100644 board/toradex/verdin-imx95/MAINTAINERS
 create mode 100644 board/toradex/verdin-imx95/Makefile
 create mode 100644 board/toradex/verdin-imx95/spl.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.env
 create mode 100644 board/tq/common/tq_som.c
 create mode 100644 board/tq/common/tq_som.h
 create mode 100644 board/tq/tqma7/Kconfig
 create mode 100644 board/tq/tqma7/Makefile
 create mode 100644 board/tq/tqma7/spl.c
 create mode 100644 board/tq/tqma7/spl_mba7.c
 create mode 100644 board/tq/tqma7/spl_tqma7_ram.c
 create mode 100644 board/tq/tqma7/tqma7.c
 create mode 100644 board/tq/tqma7/tqma7.cfg
 create mode 100644 board/tq/tqma7/tqma7.env
 create mode 100644 board/tq/tqma7/tqma7_mba7.c
 create mode 100644 configs/tqma7_common.config
 create mode 100644 configs/tqma7_mba7_mmc_defconfig
 create mode 100644 configs/tqma7_mba7_qspi_defconfig
 create mode 100644 configs/tqma7_mba7_uuu_defconfig
 create mode 100644 configs/tqma7_mmc.config
 create mode 100644 configs/tqma7_qspi.config
 create mode 100644 configs/tqma7_uuu.config
 create mode 100644 configs/verdin-imx95_defconfig
 create mode 100644 doc/board/toradex/verdin-imx95.rst
 create mode 100644 doc/board/tq/index.rst
 create mode 100644 doc/board/tq/tqma7.rst
 create mode 100644 drivers/net/fsl_enetc_xpcs_phy.c
 create mode 100644 include/configs/tqma7.h
 create mode 100644 include/configs/tqma7_mba7.h
 create mode 100644 include/configs/verdin-imx95.h
