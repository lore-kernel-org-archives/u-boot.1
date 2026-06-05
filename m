Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF77CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D5F8495B;
	Fri,  5 Jun 2026 18:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWeC5ghS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3566884971; Fri,  5 Jun 2026 18:51:29 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBBB84956
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 18:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-13807d2f898so855811c88.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780678285; x=1781283085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5EsU5M6tD8OGSy9JBpLpnWSjLtrO19HtCVr4s3ZNDKU=;
 b=jWeC5ghSo+ELlm8eVksWwPjkVDnQ9q2vQzIL6keSPZIPdqA0UzicAE5HEtnayJDtg4
 GwnSV/pR+gn+G0D4ozYIKcoeCdhRzMB26f7Z17RdTVXjtqfYVDnhEcFuvRnWldmT67uB
 SAIVH8294xJeeCZYq7xv8Ilo1AVGitPFVjY5oZIieNtTPS+gI6JueHz+I6nZRZsLfbF+
 eXOj9KVp1iAWfzN8wp8U+rIWGpSKIJ6GGjGDQxyktm6iJpeOdliPyVN5fKIRaQUhGAdH
 DY1ST00IjWXyBnzbi/bhyt2ZW/KEzzoXknEp0QVCZ3moooAz35rPjJTrhAjuAFiExGgA
 6Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780678285; x=1781283085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EsU5M6tD8OGSy9JBpLpnWSjLtrO19HtCVr4s3ZNDKU=;
 b=bntdc51dryu+4tc8lFy4svkOrDkJ1ecCksn5LRkTleg2ZvkZXkbDP1JOBDcAI7N9b+
 6IoQy49Hr0HcCv+tQLzy2EptQlFlgU2AW8fSZC3O0w3AF1s2XrqHduu1xJ9gx+vu8mNC
 sAq6Q+t+XMJ0rQChD31doaew2NiDIYCTF0mTuENYg4WYDpJyyvxBerc1JNi9y4Nw5YQu
 /mIn7KUHyh7CAVaA3RE2R1HNKLuBaymFMMHjADbN35JpPEGzO6HP4EBuoprvvdWEwQaO
 lJlgONB6Np1h4/MLojfxu9+Ex8WKNGLExPY3oECtnf4pMlYR/BPn90PlRcad0IUNqaq6
 zipg==
X-Gm-Message-State: AOJu0YxNxEoFdFFH0FXQSL3xcHFzJPSwPCLmeR5Ii62OL/6zgFS3opE8
 mRzaJx7p6P/lTa/wV/+rafiRh/Gh7kDt1rqO1esfQ6NYNKfk3Yc36IV8
X-Gm-Gg: Acq92OEDU2dAdllZ5e8uvizgUFDW5ixqozujNXhFVELV1NSvyqf+tUkwwaAWugr0Buq
 jEYqQYElpe0ZEsZPyHOi1qBgoaGim+0qYLyqeUB7gKEGwkzbzn2OS1r/aQtgihtf3ocYsKkcW/j
 5b1P0okFb1WIuWx8uFR4N/nKeIx3RDkk+A2tViHaSpsaj/7+aBQsGqYYPmS7BbX321KNz2h5xSD
 Jn3FT9clnmeZt/RtAt4wF6nER96eP2Vm2fJPTDsSo1g2EPYtNd9sXP8yXqpgv5vNX9QG1n3EsVl
 wUh6Qqm4CH3isvs5YuvKLYB4BpVaL0q5t59rYqIZoL1BALHDkR6uswpTaJtlKLNgM8faf0B8kPI
 fv/pyAFhj6lHAJvyU5bfXU+TwXKSlt1YXb+PtoupKFM82UiQZF+8C2uuJXplMZmCB0yRTj87dhw
 Qj6q3eQzfBnbfRfMp1wcoxNp0vwCcYrlOG3aIayUNwfOCN/vQPouTf9sBS6opXR/cRTQixwPOUl
 DSmbzE=
X-Received: by 2002:a05:7022:221e:b0:137:fe07:8a2c with SMTP id
 a92af1059eb24-1380671fdfamr1881033c88.22.1780678284305; 
 Fri, 05 Jun 2026 09:51:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a803:5a2:9dd3:33da:6402:543c])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-138063de4a5sm2066366c88.13.2026.06.05.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 09:51:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, alexander.feilke@ew.tq-group.com,
 alexander.sverdlin@siemens.com, alice.guo@nxp.com, fberder@outlook.fr,
 frieder.schrempf@kontron.de, marex@nabladev.com,
 Max.Merchel@ew.tq-group.com, nora.schiffer@ew.tq-group.com,
 peng.fan@nxp.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260605
Date: Fri,  5 Jun 2026 13:51:14 -0300
Message-ID: <20260605165114.610245-1-festevam@gmail.com>
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

The following changes since commit 397a14dd7142f381bbd316a13cd7e82c88c7287c:

  Merge patch series "sc5xx Environment Cleanup and Fixes" (2026-06-04 13:04:11 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260605

for you to fetch changes up to 3782bf8a0ad1abee3a2a537b9180b63d7ed22d40:

  cpu: imx8_cpu: fix the mpidr check (2026-06-05 12:57:02 -0300)

u-boot-imx-next-20260605
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30357

- Several conversions to OF_UPSTREAM.
- Improvements for TQMa6UL boards.
- Add iMX8MP UltraLite Part CPU type.
----------------------------------------------------------------
Alexander Feilke (4):
      board: tqma7: update fastboot env
      arm: dts: tqma7: add eeprom nvmem-layout
      arm: dts: tqma7: integrate tq,eeprom sysinfo driver
      boards: tqma7: call tq-sysinfo setup

Alexander Sverdlin (1):
      clk: imx: don't build i.MX/RTxxxx code for all users of CCF

Alice Guo (8):
      imx7ulp: Switch to OF_UPSTREAM
      imx91: Switch to OF_UPSTREAM
      imx93-frdm: Switch to OF_UPSTREAM
      imx93_var_som: Switch to OF_UPSTREAM
      arm: dts: imx: Update watchdog nodes for dynamic base address lookup
      imx: soc: Get watchdog base addresses from device tree
      watchdog: ulp_wdog: Use driver model for reset_cpu()
      imx: Remove hardcoded watchdog base address macros

Francois Berder (1):
      arch: imx9: Fix blk_dwrite/blk_derase error checking

Frieder Schrempf (1):
      imx: kontron-sl-mx6ul: Enable I2C support

Lyrix liu (1):
      arm: gic-v3-its: Fix LPI pending table size calculation

Marek Vasut (1):
      arm: imx9: Fix broken formatting

Max Merchel (3):
      ARM: dts: add TQMa6UL[L]x[L] u-boot device tree fragments
      ARM: dts: tqma6ul: add boot phase properties
      configs: add defconfigs for TQMa6UL[L]x[L] SOM on MBa6ULx baseboard

Nora Schiffer (5):
      board: tq: add TQMa6UL[L]x[L] SOM and MBa6ULx baseboard
      sysinfo: uclass: use sysinfo_priv size for per_device_auto
      sysinfo: add sysinfo_get_and_detect() helper
      sysinfo: tq_eeprom: new driver
      board: tq: common: add sysinfo setup helper

Peng Fan (5):
      imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
      imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM
      imx8mm: pgh: Switch to OF_UPSTREAM
      imx8mp: msc-sm2s: Switch to OF_UPSTREAM
      cpu: imx8_cpu: fix the mpidr check

Ye Li (2):
      arm: imx8mp: Add new variant parts support
      cpu: imx8_cpu: Add iMX8MP UltraLite Part cpu type

 MAINTAINERS                                        |   1 +
 arch/arm/dts/Makefile                              |  11 +-
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi     |  49 ++
 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |  10 +
 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |  10 +
 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |  10 +
 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |  10 +
 .../arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi |  10 +
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi               |  20 +
 arch/arm/dts/imx7ulp-com-u-boot.dtsi               |   2 +
 arch/arm/dts/imx7ulp-com.dts                       |  79 --
 arch/arm/dts/imx7ulp-evk-u-boot.dtsi               |   6 +
 arch/arm/dts/imx7ulp-evk.dts                       | 133 ---
 arch/arm/dts/imx7ulp-u-boot.dtsi                   |  17 +
 arch/arm/dts/imx7ulp.dtsi                          | 461 -----------
 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts        |  96 ---
 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts       |  96 ---
 arch/arm/dts/imx8mm-icore-mx8mm.dtsi               | 232 ------
 arch/arm/dts/imx8mm-phg.dts                        | 266 ------
 arch/arm/dts/imx8mm-tqma8mqml.dtsi                 | 341 --------
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts       | 175 ----
 arch/arm/dts/imx8mp-icore-mx8mp.dtsi               | 186 -----
 ...u-boot.dtsi => imx8mp-msc-sm2s-ep1-u-boot.dtsi} |   0
 arch/arm/dts/imx8mp-msc-sm2s.dts                   | 820 -------------------
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi               |   4 -
 arch/arm/dts/imx8ulp-u-boot.dtsi                   |   4 +
 arch/arm/dts/imx91-11x11-evk.dts                   | 875 --------------------
 arch/arm/dts/imx91-11x11-frdm.dts                  | 773 ------------------
 arch/arm/dts/imx91-pinfunc.h                       | 770 -----------------
 arch/arm/dts/imx91-u-boot.dtsi                     |  12 +
 arch/arm/dts/imx91.dtsi                            |  53 --
 arch/arm/dts/imx93-11x11-frdm.dts                  | 603 --------------
 arch/arm/dts/imx93-u-boot.dtsi                     |  12 +
 arch/arm/dts/imx93-var-som-symphony.dts            | 323 --------
 arch/arm/dts/imx93-var-som.dtsi                    | 111 ---
 arch/arm/dts/imx93.dtsi                            | 906 ---------------------
 arch/arm/dts/imx943-evk-u-boot.dtsi                |   4 -
 arch/arm/dts/imx943-u-boot.dtsi                    |  19 +
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi           |   4 -
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi           |   4 -
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi   |   4 -
 arch/arm/dts/imx95-u-boot.dtsi                     |  14 +
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi     |   4 -
 arch/arm/dts/imx952-u-boot.dtsi                    |  14 +
 arch/arm/dts/mba6ulx-u-boot.dtsi                   |  26 +
 arch/arm/include/asm/arch-imx/cpu.h                |   2 +
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h       |   2 -
 arch/arm/include/asm/arch-imx9/ddr.h               |  30 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h          |   9 -
 arch/arm/include/asm/mach-imx/sys_proto.h          |   5 +-
 arch/arm/lib/gic-v3-its.c                          |   3 +-
 arch/arm/mach-imx/cmd_qb.c                         |   2 +-
 arch/arm/mach-imx/cpu.c                            |   4 +
 arch/arm/mach-imx/imx8m/Kconfig                    |   4 +
 arch/arm/mach-imx/imx8m/soc.c                      |  16 +-
 arch/arm/mach-imx/imx8ulp/soc.c                    |  12 +-
 arch/arm/mach-imx/imx9/Kconfig                     |   4 +
 arch/arm/mach-imx/imx9/qb.c                        |  28 +-
 arch/arm/mach-imx/imx9/scmi/soc.c                  |  13 +-
 arch/arm/mach-imx/imx9/soc.c                       |  14 +-
 arch/arm/mach-imx/mx6/Kconfig                      |  21 +
 arch/arm/mach-imx/mx7ulp/Kconfig                   |   2 +
 arch/arm/mach-imx/mx7ulp/soc.c                     |  22 +-
 board/tq/MAINTAINERS                               |   2 +-
 board/tq/common/Kconfig                            |   5 +
 board/tq/common/Makefile                           |   1 +
 board/tq/common/tq_sysinfo.c                       |  37 +
 board/tq/common/tq_sysinfo.h                       |  15 +
 board/tq/tqma6ul/Kconfig                           | 114 +++
 board/tq/tqma6ul/Makefile                          |  16 +
 board/tq/tqma6ul/spl.c                             | 128 +++
 board/tq/tqma6ul/spl_mba6ul.c                      | 177 ++++
 board/tq/tqma6ul/spl_tqma6ul_ram.c                 | 209 +++++
 board/tq/tqma6ul/tqma6ul.c                         | 184 +++++
 board/tq/tqma6ul/tqma6ul.cfg                       |  23 +
 board/tq/tqma6ul/tqma6ul.env                       |  47 ++
 board/tq/tqma6ul/tqma6ul.h                         |  25 +
 board/tq/tqma6ul/tqma6ul_mba6ul.c                  | 138 ++++
 board/tq/tqma7/tqma7.c                             |   6 +
 board/tq/tqma7/tqma7.env                           |  11 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |   2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |   2 +-
 configs/imx8mm_phg_defconfig                       |   5 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |   2 +-
 configs/imx8ulp_evk_defconfig                      |   1 +
 configs/imx91_11x11_evk_defconfig                  |   2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig       |   2 +-
 configs/imx91_11x11_frdm_defconfig                 |   2 +-
 configs/imx93-phycore_defconfig                    |   1 +
 configs/imx93_frdm_defconfig                       |   2 +-
 configs/imx93_var_som_defconfig                    |   2 +-
 configs/imx943_evk_defconfig                       |   1 +
 configs/imx95_15x15_evk_defconfig                  |   1 +
 configs/imx95_evk.config                           |   1 +
 configs/kontron-sl-mx6ul_defconfig                 |   1 +
 configs/msc_sm2s_imx8mp_defconfig                  |   2 +-
 configs/mx7ulp_com_defconfig                       |   3 +-
 configs/mx7ulp_evk_defconfig                       |   2 +-
 configs/mx7ulp_evk_plugin_defconfig                |   2 +-
 configs/toradex-smarc-imx95_defconfig              |   1 +
 configs/tqma6ul_common.config                      | 125 +++
 configs/tqma6ul_mmc.config                         |   3 +
 configs/tqma6ul_spi.config                         |   2 +
 configs/tqma6ul_uuu.config                         |  20 +
 configs/tqma6ullx_mba6ul_mmc_defconfig             |   5 +
 configs/tqma6ullx_mba6ul_qspi_defconfig            |   5 +
 configs/tqma6ullx_mba6ul_uuu_defconfig             |   5 +
 configs/tqma6ullxl_mba6ul_mmc_defconfig            |   6 +
 configs/tqma6ullxl_mba6ul_qspi_defconfig           |   6 +
 configs/tqma6ullxl_mba6ul_uuu_defconfig            |   6 +
 configs/tqma6ulx_mba6ul_mmc_defconfig              |   6 +
 configs/tqma6ulx_mba6ul_qspi_defconfig             |   6 +
 configs/tqma6ulx_mba6ul_uuu_defconfig              |   6 +
 configs/tqma6ulxl_mba6ul_mmc_defconfig             |   6 +
 configs/tqma6ulxl_mba6ul_qspi_defconfig            |   6 +
 configs/tqma6ulxl_mba6ul_uuu_defconfig             |   6 +
 configs/tqma7_common.config                        |   1 +
 configs/verdin-imx95_defconfig                     |   1 +
 doc/board/tq/index.rst                             |   1 +
 doc/board/tq/tqma6ul.rst                           | 105 +++
 .../sysinfo/tq,eeprom-sysinfo.txt                  |  36 +
 drivers/clk/Makefile                               |   2 +-
 drivers/cpu/imx8_cpu.c                             |  13 +-
 drivers/sysinfo/Kconfig                            |   8 +
 drivers/sysinfo/Makefile                           |   1 +
 drivers/sysinfo/sysinfo-uclass.c                   |  12 +-
 drivers/sysinfo/tq_eeprom.c                        | 203 +++++
 drivers/watchdog/ulp_wdog.c                        |  79 +-
 include/configs/imx8ulp_evk.h                      |   2 -
 include/configs/imx91_evk.h                        |   2 -
 include/configs/imx91_frdm.h                       |   2 -
 include/configs/imx93_evk.h                        |   3 -
 include/configs/imx93_frdm.h                       |   3 -
 include/configs/imx93_qsb.h                        |   2 -
 include/configs/imx93_var_som.h                    |   3 -
 include/configs/imx94_evk.h                        |   3 -
 include/configs/imx95_evk.h                        |   2 -
 include/configs/kontron-osm-s-mx93.h               |   2 -
 include/configs/mx7ulp_com.h                       |   3 -
 include/configs/mx7ulp_evk.h                       |   3 -
 include/configs/phycore_imx91_93.h                 |   3 -
 include/configs/toradex-smarc-imx95.h              |   2 -
 include/configs/tqma6ul.h                          |  53 ++
 include/configs/tqma6ul_mba6ul.h                   |  19 +
 include/sysinfo.h                                  |  17 +
 include/sysinfo/tq_eeprom.h                        |  24 +
 test/dm/sysinfo.c                                  |  16 +
 147 files changed, 2294 insertions(+), 7499 deletions(-)
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx7ulp-com.dts
 create mode 100644 arch/arm/dts/imx7ulp-evk-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/dts/imx7ulp-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx7ulp.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts
 delete mode 100644 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts
 delete mode 100644 arch/arm/dts/imx8mm-icore-mx8mm.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-phg.dts
 delete mode 100644 arch/arm/dts/imx8mm-tqma8mqml.dtsi
 delete mode 100644 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts
 delete mode 100644 arch/arm/dts/imx8mp-icore-mx8mp.dtsi
 rename arch/arm/dts/{imx8mp-msc-sm2s-u-boot.dtsi => imx8mp-msc-sm2s-ep1-u-boot.dtsi} (100%)
 delete mode 100644 arch/arm/dts/imx8mp-msc-sm2s.dts
 delete mode 100644 arch/arm/dts/imx91-11x11-evk.dts
 delete mode 100644 arch/arm/dts/imx91-11x11-frdm.dts
 delete mode 100644 arch/arm/dts/imx91-pinfunc.h
 delete mode 100644 arch/arm/dts/imx91.dtsi
 delete mode 100644 arch/arm/dts/imx93-11x11-frdm.dts
 delete mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
 delete mode 100644 arch/arm/dts/imx93-var-som.dtsi
 delete mode 100644 arch/arm/dts/imx93.dtsi
 create mode 100644 arch/arm/dts/mba6ulx-u-boot.dtsi
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h
 create mode 100644 board/tq/tqma6ul/Kconfig
 create mode 100644 board/tq/tqma6ul/Makefile
 create mode 100644 board/tq/tqma6ul/spl.c
 create mode 100644 board/tq/tqma6ul/spl_mba6ul.c
 create mode 100644 board/tq/tqma6ul/spl_tqma6ul_ram.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.cfg
 create mode 100644 board/tq/tqma6ul/tqma6ul.env
 create mode 100644 board/tq/tqma6ul/tqma6ul.h
 create mode 100644 board/tq/tqma6ul/tqma6ul_mba6ul.c
 create mode 100644 configs/tqma6ul_common.config
 create mode 100644 configs/tqma6ul_mmc.config
 create mode 100644 configs/tqma6ul_spi.config
 create mode 100644 configs/tqma6ul_uuu.config
 create mode 100644 configs/tqma6ullx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_uuu_defconfig
 create mode 100644 doc/board/tq/tqma6ul.rst
 create mode 100644 doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/configs/tqma6ul.h
 create mode 100644 include/configs/tqma6ul_mba6ul.h
 create mode 100644 include/sysinfo/tq_eeprom.h
