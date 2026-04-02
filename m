Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95FDD6AAF2
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C83184056;
	Thu,  2 Apr 2026 18:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Htejt/70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04958840B0; Thu,  2 Apr 2026 18:32:38 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B5284020
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-953943f7a33so510919241.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775147554; x=1775752354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u5H6tUmCgaUyd+yO3Zz/xnA2rAACB83kMkDZoKO1how=;
 b=Htejt/70blN76I8cWRHSz124fWhEW+0OuatTiSnnnBOCtnOI+57UWaRE2XDfLHtGIi
 KVR16c75UyGgLSSbdtju6UTpaQAqVLcAaAdPR28gA0qoUeFk7ogMSFSzewJ7g396CVMI
 az8ceAi9toW8G4xCkbHKZRLGHQjT1geqmdyqy5LnD9Mo0sY06P432+/ZDsHOYo+Y6f4V
 71LKmInYgzwXaUvqGe21qVFF8MKkqfhXuLg00OgEnTThtKc5s31/MgqK0xfVVfsF8ohW
 +f7oCTjdIct50QqJQDArSAoeOaFupvdF2mAAVg/rxzDCN5kAFZfDGuy4EABPW7zrPP/T
 DLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147554; x=1775752354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5H6tUmCgaUyd+yO3Zz/xnA2rAACB83kMkDZoKO1how=;
 b=IbR7uqR6UVHyXYstmeTWdXrvxgLVhcTQma+v2+DGgDToIwWbiAUZp8XuDmmqYhdYhH
 GvC3UL9k8VAF6iKzVSPKe0Q4EVML7uY+QcTyAZP1QLVeJ0lIj2F8a5Tdf18w3PaOCATb
 Vr7ilazj7q9LJmvd+8F2T+9ajubtsMt9ucV4C2HJYE7Vu/Od5ck+WJYqAdbPL7wMmwRF
 fdAuDSBZFUTFtq4DUDcffd6XSoHF6RkD9fVW8cnuatEvEFO4ZuhRs3SYvaDlRQVgwOL2
 9aJk8lDl91saY/AZvoy+b2qsbPeiaLdaAUL6lzzzVs5UStBvMApVL5xPQtkY7BCXp1dD
 xzaA==
X-Gm-Message-State: AOJu0Yz/gLP7s61g4kLeSKBFKMhrdz4KREazeh6WSNSagL5Zt/FoBqsQ
 KI3R2UAnEM8voAoi0lsWpXuzM638zSy+McAWnv1nt04C6LIOhEmEvLfdKBWsrA==
X-Gm-Gg: ATEYQzyLWi/e7pIh2Y4PQc2DerkkxNxduD22pdxy827UFGHscXRo4hL3i2bwiivRfhl
 nVTVTZEVJCZ6qLSm5IPr493QBJdoWOnw8WpeX1cEE+jZ3F0RCOYjzM6vTDF8AmGQOS5mbd4H2Ez
 kaTZCXGzxTLuDwtcFAsdxKAj7NF9HRIJRRQMMOYi4QHXiDKtB2aCtiovDr5Hqmy0YluYVlRVOcJ
 4y6Q5f5l5cyw9gsF5Tl9wHahN4C9vzp7Ysws3N0sbM98cJAT+Anc8IqbiKmbt7KosPhFmbUIZsu
 yn15lxpGJav0G54FFHcUFyzc87e1fH9X2JMI7eE69QgihBveHB4OcS1nG8/Ccpa5aUzAVo06xeT
 PS11YXYbxrQFFme9O/MBMImaPq02Yi9YZyol2dFspUkZdiLfhQg1x1R0jGBb9x4BY7vXttZ56GS
 WkuJIKZooLe+G8CvPn4GR0sYyEXA5FYNyo8dWOSnRBYeSd4pAQiTHb6q+sONWckuk9MvOAOZkF6
 vcJ9y06
X-Received: by 2002:a05:6122:848a:b0:56d:9def:20c8 with SMTP id
 71dfb90a1353d-56d9def22d5mr905003e0c.6.1775147553894; 
 Thu, 02 Apr 2026 09:32:33 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:fafb:81f5:aa68:8741:23b8])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9ba826f6sm3862429e0c.2.2026.04.02.09.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 09:32:33 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, fra.schnyder@gmail.com, hs@nabladev.com,
 krzysztof.kozlowski@oss.qualcomm.com, Markus.Niebel@ew.tq-group.com,
 Max.Merchel@ew.tq-group.com, peng.fan@oss.nxp.com,
 tomas.alvarez-vanoli@hitachienergy.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260402
Date: Thu,  2 Apr 2026 13:32:27 -0300
Message-ID: <20260402163227.1538209-1-festevam@gmail.com>
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

The following changes since commit 98cf83d81617f489d7ff7bf78d33e693e2799254:

  Merge tag 'net-20260331' of https://source.denx.de/u-boot/custodians/u-boot-net into next (2026-03-31 13:06:00 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260402

for you to fetch changes up to 4d612ec4354b9bdfc42bc5a9e3120d5d490ba34b:

  tqma6: remove board MAINTAINERS (2026-04-02 11:12:22 -0300)

u-boot-imx-next-20260402
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29745

- Migrate imx95-toradex-smarc to use upstream devicetree.
- Force fsl crypto driver to select ARCH_MISC_INIT to avoid crashes when
using CAAM.
- Support upstream Linux reset-gpios property for the i.MX PCI driver.
- Avoid duplication of DDR tables on i.MX8MP DHCOM SoM.
- Several cleanups on tqma6 platform.
- Convert i.MX8MP boards to DM_PMIC.
- Add phyCORE-i.MX91 support.
- Drop unnecessary BOARD_EARLY_INIT_F usage.
----------------------------------------------------------------
Franz Schnyder (2):
      arm: dts: imx95-toradex-smarc: migrate to OF_UPSTREAM
      configs: toradex-smarc-imx95: Add gpio-hog support

Heiko Schocher (1):
      crypto: fsl: Select ARCH_MISC_INIT for CAAM driver

Krzysztof Kozlowski (1):
      pci: imx: Properly support upstream Linux reset-gpios property

Marek Vasut (4):
      arm64: imx8mp: Fold inline ECC into spl.c on DH i.MX8MP DHCOM SoM
      arm64: imx8mp: Deduplicate DRAM size tables on DH i.MX8MP DHCOM SoM
      arm64: imx8mp: Deduplicate 2G and 4G 2r DRAM timings on DH i.MX8MP DHCOM SoM
      arm64: imx8mp: Add 4G 1r DRAM timings on DH i.MX8MP DHCOM SoM

Markus Niebel (3):
      env: tq: add shareable environment settings
      board/tq: Add common baseboard API
      MAINTAINERS: update entry for TQ-Systems

Max Merchel (8):
      configs: tqma6.h: remove unused define for PHYS_SDRAM_SIZE
      configs: tqma6.h: remove unused define for PFUZE100_I2C
      board: tqma6: change to use shareable tq environment
      configs: tqma6: change to include tqma6.h in baseboard headers
      board/tq: Add common mmc API
      board: tqma6: use common TQ mmc function
      tq: add TQ board MAINTAINERS
      tqma6: remove board MAINTAINERS

Paul Gerber (2):
      board: tqma6: use common TQ baseboard
      board: tqma6: update eMMC DSR handling

Peng Fan (4):
      imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
      imx8mp: verdin: Convert to DM_PMIC
      imx8mp: libra-fpsc: Convert to DM_PMIC
      imx8mp: icore-edimm2.2: Convert to DM_PMIC

Primoz Fiser (1):
      board: phytec: phycore-imx91-93: Add phyCORE-i.MX91 support

Tom Rini (9):
      engicam: Drop unnecessary BOARD_EARLY_INIT_F usage
      osm-s-mx93: Drop unnecessary BOARD_EARLY_INIT_F usage
      imx8ulp_evk: Drop unnecessary BOARD_EARLY_INIT_F usage
      imx93_frdm: Drop unnecessary BOARD_EARLY_INIT_F usage
      mx6sllevk: Drop unnecessary BOARD_EARLY_INIT_F usage
      mx6sxsabreauto: Drop unnecessary BOARD_EARLY_INIT_F usage
      mx6ullevk: Drop unnecessary BOARD_EARLY_INIT_F usage
      o4-imx6ull-nano: Drop unnecessary BOARD_EARLY_INIT_F usage
      librem5: Drop unnecessary BOARD_EARLY_INIT_F usage

Tomas Alvarez Vanoli (1):
      spi: fsl_espi: fix din offset

 MAINTAINERS                                        |   12 +-
 .../dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi    |   18 +-
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     |   22 +-
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |   22 +-
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    |   20 +-
 .../dts/imx91-93-phyboard-segin-common-u-boot.dtsi |  228 +++
 arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi      |   18 +
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi      |  221 +--
 arch/arm/dts/imx95-toradex-smarc-dev.dts           |  277 ---
 arch/arm/dts/imx95-toradex-smarc.dtsi              | 1153 -----------
 arch/arm/mach-imx/imx9/Kconfig                     |   11 +-
 arch/arm/mach-imx/imx9/soc.c                       |    3 +-
 arch/arm/mach-imx/mx6/Kconfig                      |    1 -
 board/dhelectronics/dh_imx8mp/Makefile             |    2 +-
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |    3 +-
 board/dhelectronics/dh_imx8mp/lpddr4_timing.h      |   14 +-
 .../dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c  |  201 +-
 .../dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c  | 1873 ------------------
 board/dhelectronics/dh_imx8mp/spl.c                |   62 +-
 board/engicam/imx8mm/spl.c                         |    7 -
 board/engicam/imx8mp/spl.c                         |   53 +-
 board/kontron/osm-s-mx93/osm-s-mx93.c              |    5 -
 board/kontron/osm-s-mx93/spl.c                     |    2 -
 board/nxp/imx8ulp_evk/imx8ulp_evk.c                |    5 -
 board/nxp/imx8ulp_evk/spl.c                        |    2 -
 board/nxp/imx93_frdm/imx93_frdm.c                  |    5 -
 board/nxp/imx93_frdm/spl.c                         |    2 -
 board/nxp/mx6sllevk/mx6sllevk.c                    |    5 -
 board/nxp/mx6sxsabreauto/mx6sxsabreauto.c          |    5 -
 board/nxp/mx6ullevk/mx6ullevk.c                    |    5 -
 board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c       |    5 -
 board/phytec/common/Kconfig                        |    6 +-
 board/phytec/common/Makefile                       |    2 +-
 ...93_som_detection.c => imx91_93_som_detection.c} |   39 +-
 board/phytec/common/imx91_93_som_detection.h       |   51 +
 board/phytec/common/imx93_som_detection.h          |   51 -
 board/phytec/imx8mp-libra-fpsc/spl.c               |   46 +-
 board/phytec/phycore_imx8mp/spl.c                  |   43 +-
 board/phytec/phycore_imx91_93/Kconfig              |   47 +
 board/phytec/phycore_imx91_93/MAINTAINERS          |   16 +
 .../{phycore_imx93 => phycore_imx91_93}/Makefile   |    9 +-
 .../phytec/phycore_imx91_93/lpddr4_timing_imx91.c  | 1998 ++++++++++++++++++++
 .../lpddr4_timing_imx93.c}                         |    0
 .../phycore-imx91-93.c}                            |    8 +-
 .../phycore_imx91_93.env}                          |    2 +
 .../{phycore_imx93 => phycore_imx91_93}/spl.c      |   46 +-
 board/phytec/phycore_imx93/Kconfig                 |   41 -
 board/phytec/phycore_imx93/MAINTAINERS             |   12 -
 board/purism/librem5/librem5.c                     |    5 -
 board/purism/librem5/spl.c                         |    2 -
 board/toradex/smarc-imx95/MAINTAINERS              |    2 -
 board/toradex/verdin-imx8mp/spl.c                  |   55 +-
 board/tq/MAINTAINERS                               |    8 +
 board/tq/common/Kconfig                            |   13 +
 board/tq/common/Makefile                           |    9 +
 board/tq/common/tq_bb.c                            |   78 +
 board/tq/common/tq_bb.h                            |   39 +
 board/tq/common/tq_sdmmc.c                         |   46 +
 board/tq/tqma6/Kconfig                             |    8 +-
 board/tq/tqma6/MAINTAINERS                         |    7 -
 board/tq/tqma6/Makefile                            |    1 +
 board/tq/tqma6/tqma6.c                             |   39 +-
 board/tq/tqma6/tqma6.env                           |   47 +
 board/tq/tqma6/tqma6_bb.h                          |   28 -
 board/tq/tqma6/tqma6_emmc.c                        |   88 +
 board/tq/tqma6/tqma6_emmc.h                        |   19 +
 board/tq/tqma6/tqma6_mba6.c                        |   26 +-
 board/tq/tqma6/tqma6_wru4.c                        |   29 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |   12 +-
 configs/imx8mp-libra-fpsc_defconfig                |   10 +-
 configs/imx8ulp_evk_defconfig                      |    1 -
 configs/imx91-phycore_defconfig                    |  167 ++
 configs/imx93-phycore_defconfig                    |    2 +-
 configs/imx93_frdm_defconfig                       |    1 -
 configs/librem5_defconfig                          |    1 -
 configs/mx6sllevk_defconfig                        |    1 -
 configs/mx6sllevk_plugin_defconfig                 |    1 -
 configs/mx6ull_14x14_evk_defconfig                 |    1 -
 configs/mx6ull_14x14_evk_plugin_defconfig          |    1 -
 configs/mx6ulz_14x14_evk_defconfig                 |    1 -
 configs/phycore-imx8mp_defconfig                   |   10 +-
 configs/toradex-smarc-imx95_defconfig              |    3 +-
 configs/verdin-imx8mp_defconfig                    |   13 +-
 .../{imx93-phycore.rst => imx91-93-phycore.rst}    |   38 +-
 doc/board/phytec/index.rst                         |    2 +-
 drivers/crypto/fsl/Kconfig                         |    1 +
 drivers/pci/pcie_imx.c                             |   22 +-
 drivers/spi/fsl_espi.c                             |    2 +-
 .../{phycore_imx93.h => phycore_imx91_93.h}        |    6 +-
 include/configs/tqma6.h                            |  266 +--
 include/configs/tqma6_mba6.h                       |    3 +-
 include/configs/tqma6_wru4.h                       |    2 +
 include/env/tq/mmc.env                             |   82 +
 include/env/tq/nfs.env                             |   51 +
 include/env/tq/spi.env                             |   23 +
 include/env/tq/tq-imx-shared.env                   |   38 +
 include/env/tq/ubi.env                             |   47 +
 97 files changed, 3716 insertions(+), 4320 deletions(-)
 create mode 100644 arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx95-toradex-smarc-dev.dts
 delete mode 100644 arch/arm/dts/imx95-toradex-smarc.dtsi
 delete mode 100644 board/dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c
 rename board/phytec/common/{imx93_som_detection.c => imx91_93_som_detection.c} (56%)
 create mode 100644 board/phytec/common/imx91_93_som_detection.h
 delete mode 100644 board/phytec/common/imx93_som_detection.h
 create mode 100644 board/phytec/phycore_imx91_93/Kconfig
 create mode 100644 board/phytec/phycore_imx91_93/MAINTAINERS
 rename board/phytec/{phycore_imx93 => phycore_imx91_93}/Makefile (58%)
 create mode 100644 board/phytec/phycore_imx91_93/lpddr4_timing_imx91.c
 rename board/phytec/{phycore_imx93/lpddr4_timing.c => phycore_imx91_93/lpddr4_timing_imx93.c} (100%)
 rename board/phytec/{phycore_imx93/phycore-imx93.c => phycore_imx91_93/phycore-imx91-93.c} (90%)
 rename board/phytec/{phycore_imx93/phycore_imx93.env => phycore_imx91_93/phycore_imx91_93.env} (94%)
 rename board/phytec/{phycore_imx93 => phycore_imx91_93}/spl.c (75%)
 delete mode 100644 board/phytec/phycore_imx93/Kconfig
 delete mode 100644 board/phytec/phycore_imx93/MAINTAINERS
 create mode 100644 board/tq/MAINTAINERS
 create mode 100644 board/tq/common/Kconfig
 create mode 100644 board/tq/common/Makefile
 create mode 100644 board/tq/common/tq_bb.c
 create mode 100644 board/tq/common/tq_bb.h
 create mode 100644 board/tq/common/tq_sdmmc.c
 delete mode 100644 board/tq/tqma6/MAINTAINERS
 create mode 100644 board/tq/tqma6/tqma6.env
 delete mode 100644 board/tq/tqma6/tqma6_bb.h
 create mode 100644 board/tq/tqma6/tqma6_emmc.c
 create mode 100644 board/tq/tqma6/tqma6_emmc.h
 create mode 100644 configs/imx91-phycore_defconfig
 rename doc/board/phytec/{imx93-phycore.rst => imx91-93-phycore.rst} (52%)
 rename include/configs/{phycore_imx93.h => phycore_imx91_93.h} (88%)
 create mode 100644 include/env/tq/mmc.env
 create mode 100644 include/env/tq/nfs.env
 create mode 100644 include/env/tq/spi.env
 create mode 100644 include/env/tq/tq-imx-shared.env
 create mode 100644 include/env/tq/ubi.env
