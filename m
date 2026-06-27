Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63683C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 18:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB0E841C2;
	Sat, 27 Jun 2026 20:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qbIFaVjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33970842FC; Sat, 27 Jun 2026 20:30:49 +0200 (CEST)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B25D83FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 20:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-30c965eab27so2768911eec.0
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782585045; x=1783189845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXd/+N0x26VVttnOU6gvtIKaP0yCuysBEBEmxQ1Sc+E=;
 b=qbIFaVjM5nKPfJNsfz28mowqeuiE5AIlKSqeJiyQo9IYSIMgQE2oQPTebh8pavJnqg
 nwhSrCWmgDIoH7fqRagn0N5xHhCUJDbCDBQpmzu+pHN1UoXbf2NvOzq4QVjmeepkUpMj
 2nVefsoydTDhpjpf6WfLXGM5lTuKvPmeDZbaEu+2VArxFdM/9Je5nd0Wq32sK8PdXXKD
 N0IwOp+/r23F5TJaJHK7iMIpefUbtssqE24mnvrXhyVNkxiokk2UmpBXXT3mjfSlyurJ
 +tkVin+vyW0+daXs37+AtpOtkhPxrEG/R6NcgmZIpU6hKstJvNxgFWyaMGuofikK1qyL
 oMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782585045; x=1783189845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXd/+N0x26VVttnOU6gvtIKaP0yCuysBEBEmxQ1Sc+E=;
 b=d2mebS4h8qPRc9UfeWJU9flkO6FHPH8hFwNjkMX8KrpHondxSmKu7aVev99GG5clk7
 z89n3gkSIER2I+t00tom3eyzlvz+7aV2BLG94G84aNI604KKRwi0CjSvyq9Kv+Zn7dFz
 wxGsKjU375/bn7xCOENOkFecMf2X8m1YwJtUF4IlpISomWEz6i045AN8bjTAk3VMkcHg
 KARe2/qoYwVBvGgrjP9chVdAQ+/Z2IS911DGs+m7SfAT9ntoZsdOouiViHtqyCEMwTWh
 U6FqkMicb9UrRZHdVeerAvW787D8uLzMtCe5P0Vcisj1g7OiHCNMnTad4+oMbnSa7Ef1
 tIRQ==
X-Gm-Message-State: AOJu0YxQVixb6gEZriCLnLN0gdrl5nbW/adHeq84NIYXo29s9aT3kIyn
 sLY5sOfCoREh26QVnpXV13Md1wJ6i5FBUupv3febq/n4novj/hdIRoRN
X-Gm-Gg: AfdE7cm7FhyMA+A2d8LZR2k/KOCeba0kKmJyGoe1FI3w4GBOPa5aVhfo136lF7ZHZ+/
 beBCXQTGbaAkyIeKba4OXvGDlEfPpFuag9sFvvfkQABJgqHPea4NgYRKL/Wp97aPyzSRWjTDYwh
 4Uw67j+uARSzXFhxMli1WHY/PaqwwGLlYi8A3ol1ca0wkq/VciBqLUj1aOvGF998rREHsFVF6ZP
 DlF/cAd69hmbWYrbAP8GyppVk5+AdaPR6awozG+ezTrtHkflSvkVDDm33DGjHrOhE58BENFpq08
 UJZQLm1HJDW2p5soeD5pM2O05Td3JY6fyUj4G5OkzxDS5UFsGwz9V3kUuz+e15hXpmJu5aTydEX
 fO5PTHbVxY75EqpraYo+ArieT/Ju/g4G5ypQ4P77NhWe6KDfxqLHf67+7c43iN42Ytg76c+9S6e
 3nrJo9TSred0dhcb247Yz06tZeo12/iEwsmu9/l940Q7IyWGaLSwPXjmib8aheAnlCO3VxCw==
X-Received: by 2002:a05:7300:510:b0:304:de2b:446f with SMTP id
 5a478bee46e88-30c84e31eccmr12286516eec.28.1782585044531; 
 Sat, 27 Jun 2026 11:30:44 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:55ea:47fd:ff91:9f95])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c58831asm33026593eec.13.2026.06.27.11.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 11:30:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com,
 brian.ruley@gehealthcare.com, franz.schnyder@toradex.com,
 frieder.schrempf@kontron.de, krzysztof@kd-solutions.pl,
 mathieu.dubois-briand@bootlin.com, marex@nabladev.com,
 peng.fan@oss.nxp.com, ye.li@oss.nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260627
Date: Sat, 27 Jun 2026 15:30:37 -0300
Message-ID: <20260627183038.3071171-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0:

  Merge patch series "Kconfig restyle part 2" (2026-06-25 15:01:03 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260627

for you to fetch changes up to 8757c2428252eac46de7d1cadc43cf11211e867e:

  imx9: Add v2x_status and ele_info commands (2026-06-26 23:02:46 -0300)

u-boot-imx-next-20260627
------------------------

CI:https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30547

- Move environment variables to .env file on imx7ul-evk/imx6ull-evk/mx6-sabre
- imx ipuv3 improvements.
- Initial support for aquila imx95
- Add support for OPTEE on i.MX93
- Allow users to inhibit i.MX trip point setup
- Add support for imx93_frdm 2CS 2GB DRAM support
- Add optee binary to i.MX9 platform types
- Enable booting Image.gz on imx8m-evk/imx9-evk
----------------------------------------------------------------
Aristo Chen (3):
      mx7ulp_evk: Move environment variables to .env file
      mx6ullevk: Move environment variables to .env file
      mx6sabre: Move environment variables to .env files

Brian Ruley (8):
      clk: imx6q: cosmetic: keep pll definitions together
      clk: imx6q: guard video clocks behind config
      clk: imx6q: add missing pll bypasses
      imx6: clock: allow different clock sources for ldb
      clk: imx6q: configure ldb clock selectors
      video: imx: ipuv3: enable ipu clk before writing registers in CCF
      clk: clk-divider: add clk_register_divider_table()
      clk: imx6q: use clk_divider_table instead of fixed factor for pll5 divs

Franz Schnyder (1):
      board: toradex: add initial support for aquila imx95

Frieder Schrempf (1):
      imx: kontron-sl-mx8mm: Enable the watchdog at boot

Krzysztof Drobiński (1):
      imx93: Add support for OPTEE

Marek Vasut (1):
      imx: fdt: Allow users to inhibit trip point setup

Mathieu Dubois-Briand (2):
      binman: Add optee binary to i.MX9 platform types
      imx93_frdm: Add support for 2CS 2GB DRAM support

Peng Fan (18):
      imx8m: Imply DM_THERMAL
      imx952: Update gpio node regs
      imx8ulp: cleanup get_imx_type
      imx7ulp: cleanup get_imx_type
      imx: Guard print_cpuinfo with !CONFIG_IS_ENABLED(CPU)
      imx8m: dts: Update ddr firmware name
      serial: lpuart: Use livetree API for fdt access
      gpio: imx_rgpio2p: Use dev_read_addr_index
      misc: ele: Use dev_read_addr
      imx9: soc: Use livetree API for fdt access
      imx8m_evk: Select OF_LIVE
      imx9: Select OF_LIVE
      imx8mp_evk: enable booting Image.gz and avoid extra memcpy
      imx8mq_evk: enable booting Image.gz and avoid extra memcpy
      imx8mm/n_evk: enable booting Image.gz and avoid extra memcpy
      imx93_evk/qsb/frdm: enable booting Image.gz and avoid extra memcpy
      imx95/952/94_evk/: enable booting Image.gz
      imx952_evk: Correct CONFIG_DEFAULT_FDT_FILE

Ye Li (2):
      misc: ele_api: Add V2X Get State API
      imx9: Add v2x_status and ele_info commands

 arch/arm/dts/imx8mm-u-boot.dtsi                    |    8 +-
 arch/arm/dts/imx8mn-u-boot.dtsi                    |    8 +-
 arch/arm/dts/imx8mq-u-boot.dtsi                    |    8 +-
 arch/arm/dts/imx93-u-boot.dtsi                     |    3 +
 arch/arm/dts/imx95-aquila-dev-u-boot.dtsi          |   40 +
 arch/arm/dts/imx95-aquila-dev.dts                  |  389 ++++
 arch/arm/dts/imx95-aquila.dtsi                     | 1160 +++++++++++
 arch/arm/dts/imx952-u-boot.dtsi                    |    8 -
 arch/arm/include/asm/arch-mx6/clock.h              |    2 +-
 arch/arm/include/asm/mach-imx/ele_api.h            |    8 +
 arch/arm/mach-imx/cpu.c                            |   60 +-
 arch/arm/mach-imx/fdt.c                            |   10 +
 arch/arm/mach-imx/imx8m/Kconfig                    |    1 +
 arch/arm/mach-imx/imx8m/soc.c                      |   30 +
 arch/arm/mach-imx/imx8ulp/soc.c                    |    8 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +
 arch/arm/mach-imx/imx9/Makefile                    |    2 +-
 arch/arm/mach-imx/imx9/misc.c                      |   98 +
 arch/arm/mach-imx/imx9/soc.c                       |   10 +-
 arch/arm/mach-imx/mx6/clock.c                      |    6 +-
 arch/arm/mach-imx/mx7ulp/soc.c                     |    8 +-
 board/aristainetos/aristainetos.c                  |    2 +-
 board/ge/b1x5v2/b1x5v2.c                           |    2 +-
 board/ge/bx50v3/bx50v3.c                           |    2 +-
 board/nxp/imx8mm_evk/imx8mm_evk.env                |    2 +
 board/nxp/imx8mn_evk/imx8mn_evk.env                |    2 +
 board/nxp/imx8mp_evk/imx8mp_evk.env                |    2 +
 board/nxp/imx8mq_evk/imx8mq_evk.env                |    2 +
 board/nxp/imx93_evk/imx93_evk.env                  |    5 +-
 board/nxp/imx93_frdm/Makefile                      |    2 +-
 board/nxp/imx93_frdm/imx93_frdm.env                |    5 +-
 board/nxp/imx93_frdm/lpddr4_timing.h               |    3 +-
 ...ddr4x_2gb_timing.c => lpddr4x_1cs_2gb_timing.c} |    2 +-
 board/nxp/imx93_frdm/lpddr4x_2cs_2gb_timing.c      | 2006 ++++++++++++++++++++
 board/nxp/imx93_frdm/spl.c                         |    5 +-
 board/nxp/imx93_qsb/imx93_qsb.env                  |    4 +
 board/nxp/imx94_evk/imx94_evk.env                  |    3 +
 board/nxp/imx952_evk/imx952_evk.env                |    3 +
 board/nxp/imx95_evk/imx95_evk.env                  |    5 +-
 board/nxp/mx6sabreauto/mx6sabreauto.env            |    5 +
 board/nxp/mx6sabresd/mx6sabresd.env                |    5 +
 board/nxp/mx6ullevk/mx6ullevk.env                  |   69 +
 board/nxp/mx7ulp_evk/mx7ulp_evk.env                |   59 +
 board/toradex/aquila-imx95/Kconfig                 |   36 +
 board/toradex/aquila-imx95/MAINTAINERS             |   11 +
 board/toradex/aquila-imx95/Makefile                |    8 +
 board/toradex/aquila-imx95/aquila-imx95.c          |   23 +
 board/toradex/aquila-imx95/aquila-imx95.env        |   20 +
 board/toradex/aquila-imx95/spl.c                   |   75 +
 configs/aquila-imx95_defconfig                     |  186 ++
 configs/imx8mm-cl-iot-gate-optee_defconfig         |    1 -
 configs/imx8mm-cl-iot-gate_defconfig               |    1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |    1 -
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |    1 -
 configs/imx8mm-mx8menlo_defconfig                  |    1 -
 configs/imx8mm-phygate-tauri-l_defconfig           |    1 -
 configs/imx8mm_beacon_defconfig                    |    1 -
 configs/imx8mm_beacon_fspi_defconfig               |    1 -
 configs/imx8mm_evk_defconfig                       |    4 +-
 configs/imx8mm_evk_fspi_defconfig                  |    4 +-
 configs/imx8mm_phg_defconfig                       |    1 -
 configs/imx8mm_venice_defconfig                    |    1 -
 configs/imx8mn_beacon_2g_defconfig                 |    1 -
 configs/imx8mn_beacon_defconfig                    |    1 -
 configs/imx8mn_beacon_fspi_defconfig               |    1 -
 configs/imx8mn_ddr4_evk_defconfig                  |    2 +-
 configs/imx8mn_evk_defconfig                       |    2 +-
 configs/imx8mn_venice_defconfig                    |    1 -
 configs/imx8mp-libra-fpsc_defconfig                |    1 -
 configs/imx8mp_beacon_defconfig                    |    1 -
 configs/imx8mp_evk_defconfig                       |    3 +-
 configs/imx8mp_rsb3720a1_4G_defconfig              |    1 -
 configs/imx8mp_rsb3720a1_6G_defconfig              |    1 -
 configs/imx8mp_venice_defconfig                    |    1 -
 configs/imx8mq_cm_defconfig                        |    1 -
 configs/imx8mq_evk_defconfig                       |    4 +-
 configs/imx8mq_phanbell_defconfig                  |    1 -
 configs/imx8mq_reform2_defconfig                   |    1 -
 configs/imx952_evk_defconfig                       |    2 +-
 configs/kontron-sl-mx8mm_defconfig                 |    2 -
 configs/kontron_pitx_imx8m_defconfig               |    1 -
 configs/librem5_defconfig                          |    1 -
 configs/phycore-imx8mm_defconfig                   |    1 -
 configs/phycore-imx8mp_defconfig                   |    1 -
 configs/pico-imx8mq_defconfig                      |    1 -
 configs/toradex-smarc-imx8mp_defconfig             |    1 -
 configs/verdin-imx8mm_defconfig                    |    1 -
 configs/verdin-imx8mp_defconfig                    |    1 -
 doc/board/toradex/aquila-imx95.rst                 |  175 ++
 doc/board/toradex/index.rst                        |    1 +
 drivers/clk/clk-divider.c                          |   16 +-
 drivers/clk/imx/clk-imx6q.c                        |  255 ++-
 drivers/gpio/imx_rgpio2p.c                         |    4 +-
 drivers/misc/imx_ele/ele_api.c                     |   32 +
 drivers/misc/imx_ele/ele_mu.c                      |    2 +-
 drivers/serial/serial_lpuart.c                     |   15 +-
 drivers/video/imx/ipu.h                            |    1 -
 drivers/video/imx/ipu_common.c                     |   13 +-
 include/configs/aquila-imx95.h                     |   28 +
 include/configs/mx6sabre_common.h                  |  122 --
 include/configs/mx6sabreauto.h                     |    1 -
 include/configs/mx6sabresd.h                       |    1 -
 include/configs/mx6ullevk.h                        |   73 -
 include/configs/mx7ulp_evk.h                       |   63 -
 include/env/nxp/mx6sabre_common.env                |  114 ++
 include/linux/clk-provider.h                       |    5 +
 tools/binman/etype/nxp_imx9image.py                |    3 +-
 107 files changed, 4949 insertions(+), 455 deletions(-)
 create mode 100644 arch/arm/dts/imx95-aquila-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-aquila-dev.dts
 create mode 100644 arch/arm/dts/imx95-aquila.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/misc.c
 rename board/nxp/imx93_frdm/{lpddr4x_2gb_timing.c => lpddr4x_1cs_2gb_timing.c} (99%)
 create mode 100644 board/nxp/imx93_frdm/lpddr4x_2cs_2gb_timing.c
 create mode 100644 board/nxp/mx6sabreauto/mx6sabreauto.env
 create mode 100644 board/nxp/mx6sabresd/mx6sabresd.env
 create mode 100644 board/nxp/mx6ullevk/mx6ullevk.env
 create mode 100644 board/nxp/mx7ulp_evk/mx7ulp_evk.env
 create mode 100644 board/toradex/aquila-imx95/Kconfig
 create mode 100644 board/toradex/aquila-imx95/MAINTAINERS
 create mode 100644 board/toradex/aquila-imx95/Makefile
 create mode 100644 board/toradex/aquila-imx95/aquila-imx95.c
 create mode 100644 board/toradex/aquila-imx95/aquila-imx95.env
 create mode 100644 board/toradex/aquila-imx95/spl.c
 create mode 100644 configs/aquila-imx95_defconfig
 create mode 100644 doc/board/toradex/aquila-imx95.rst
 create mode 100644 include/configs/aquila-imx95.h
 create mode 100644 include/env/nxp/mx6sabre_common.env
