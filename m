Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8013CD149F8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD1488D47;
	Sat, 26 Oct 2024 02:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wg2iKMQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A7188EDD; Sat, 26 Oct 2024 02:20:15 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF2888730
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so2456063b3a.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729902005; x=1730506805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fYqKsmI8Lueyx+5tbLRRQvlZvmF/o8PJkqSLTEto+d4=;
 b=Wg2iKMQKlvLjLU5Lu2gdeeJ8i5AIZo98lCHDO1ryLJdWj6PyN9Ga1w0xmDuCs5qNUl
 xA0rNAZNrLnk0JP/kWBd4oFiWSOI6Deiq45lvI51zktdHvEwfj9F4YVXpYEs8eG2pwE/
 MWtzf89Z9nF/BZe6c8E/fJUSZBEbop30ekO72F9KOjHym7U+Ve5/f2lmeGkfgjy119EN
 eeYvRbnK3n2hdTsMCBJNJvwTyW2cWMygBTgJuMcJt47J2Nmr03idMLkF3tSk31HXZbod
 oVUJ8WPWNbgxwqte5x4hsTx5XW9ErmHPQXmYOSSH8Ao4TtaH129FNlOy68TrriETVQG7
 Oqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902005; x=1730506805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYqKsmI8Lueyx+5tbLRRQvlZvmF/o8PJkqSLTEto+d4=;
 b=c4xYq3jvDiwYv7toAlFzrtROBHVcrCgOTjz9AQ6HLgnX5w34ENrOx5lSUI7zDDOOWF
 ljI0/ecHhAEirJdaNl8nzCr4F0Q35sLa00A97C7e+MVu1CFTPOBwmOn/qZI4Hoo248vS
 QRbj799J0kqNVay1BDTVGLTK/a30N/NTRe83+kLAl9itkoS7yIcV5vnuwdC3zJ57TTZ/
 6iAoY3+fzG9cF8MDof/kG3SeRB8blfbU2QSvOT9mkobdZGp73t675sGKdz+noAruqVJ3
 inyVvBWG7ZXht74aBk/oAI21AU7vIlnrqqOm7cXRz2PEZ5xYvdt3ibvJjdDqpxfZW+9f
 xm+A==
X-Gm-Message-State: AOJu0YyjwIQy7/rWj0MC8zOpWfQEbxh+6sJDaJ3UX2tILI+oFsLsPMGg
 z5OGWBa7eiYrBemcbrBCxME3cgQw/dzSsl5Q/6rvIJ0It5uvfHtzaRLSnw==
X-Google-Smtp-Source: AGHT+IGAlB3mqjABy5XOjVgbCfxoL+yu2LNm3kFyzMMiG7GFoV2X2n7YRlwW8R2cUGpPmtFmXuOitA==
X-Received: by 2002:a05:6a00:1888:b0:71e:6f09:c0a8 with SMTP id
 d2e1a72fcca58-72045436b6cmr13837837b3a.10.1729902005182; 
 Fri, 25 Oct 2024 17:20:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ee4e:802c:106a:fda1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057935dafsm1682694b3a.87.2024.10.25.17.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 17:20:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL v2] Please pull u-boot-imx-master-20241025a
Date: Fri, 25 Oct 2024 21:20:00 -0300
Message-Id: <20241026002000.3667382-1-festevam@gmail.com>
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

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241025a

for you to fetch changes up to 0ccff7f8dca1e30863374a69c9292c82c142eb5e:

  ARM: imx: soc: Move default TEXT_BASE for i.MX7 (2024-10-25 20:22:01 -0300)

u-boot-imx-master-20241025a
---------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22989

- Remove unneeded USB board code and fix reset on mx6ul_14x14_evk.
- Update fastboot buffer size/address for verdin-imx8m{m|p}.
- Fix imxrt1050-evk boot and convert it to standard boot.
- Fix imx8qxp-mek and imx8qm-mek boot.
- Add support for the i.MX93 9X9 QSB board.
- Make livetree API to work on i.MX.
- Set sane default value for i.MX8M SPL_LOAD_FIT_ADDRESS.
- Deduplicate DH i.MX8MP/i.MX6 DHSOM defconfigs.
- Select default TEXT_BASE for i.MX6/i.MX7.
- Several updates for DH i.MX8MP DRC02.
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

Marek Vasut (7):
      arm64: imx: imx8mp: Enable DM regulator on DH i.MX8MP DHCOM SoM on DRC02 board
      arm64: imx: imx8mp: Disable PCI support on DH i.MX8MP DHCOM SoM on DRC02 board
      arm64: imx: imx8mp: Disable PCA954x I2C mux on DH i.MX8MP DRC02 and PicoITX
      arm64: imx: Deduplicate DH i.MX8MP DHSOM defconfigs
      arm64: imx: Deduplicate DH i.MX6 DHSOM defconfig
      ARM: imx: soc: Select default TEXT_BASE for i.MX6
      ARM: imx: soc: Move default TEXT_BASE for i.MX7

Peng Fan (4):
      arm: dts: imx8qxp-mek: fix boot
      arm: dts: imx8qm-mek: fix boot
      imx9: clock: Add 800MHz fracpll entry
      imx: Support i.MX93 9X9 QSB board

Rasmus Villemoes (1):
      imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS

Tim Harvey (4):
      pinctrl: imx: Convert to use livetree API for fdt access
      imx: power-domain: Convert to use livetree API for fdt access
      i2c: mxc_i2c: Convert to use livetree API for fdt access
      mmc: fsl_esdhc: Convert to use livetree API for fdt access

 Kconfig                                            |    2 +
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
 arch/arm/mach-imx/mx7/Kconfig                      |    7 -
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
 common/spl/Kconfig                                 |    2 +
 configs/apalis_imx6_defconfig                      |    2 -
 configs/aristainetos2c_defconfig                   |    1 -
 configs/aristainetos2ccslb_defconfig               |    1 -
 configs/brppt2_defconfig                           |    1 -
 configs/cm_fx6_defconfig                           |    2 -
 configs/colibri_imx6_defconfig                     |    2 -
 configs/dh_imx6_defconfig                          |  167 +-
 configs/dhsom.config                               |   56 +
 configs/display5_defconfig                         |    2 -
 configs/display5_factory_defconfig                 |    2 -
 configs/ge_b1x5v2_defconfig                        |    2 -
 configs/ge_bx50v3_defconfig                        |    1 -
 configs/gwventana_emmc_defconfig                   |    2 -
 configs/gwventana_nand_defconfig                   |    2 -
 configs/imx6dl_icore_nand_defconfig                |    2 -
 configs/imx6dl_mamoj_defconfig                     |    2 -
 configs/imx6dl_sielaff_defconfig                   |    2 -
 configs/imx6q_bosch_acc_defconfig                  |    1 -
 configs/imx6q_icore_nand_defconfig                 |    2 -
 configs/imx6q_logic_defconfig                      |    2 -
 configs/imx6qdl_icore_mipi_defconfig               |    2 -
 configs/imx6qdl_icore_mmc_defconfig                |    2 -
 configs/imx6qdl_icore_nand_defconfig               |    2 -
 configs/imx6qdl_icore_rqs_defconfig                |    2 -
 configs/imx6ul_geam_mmc_defconfig                  |    1 -
 configs/imx6ul_geam_nand_defconfig                 |    1 -
 configs/imx6ul_isiot_emmc_defconfig                |    1 -
 configs/imx6ul_isiot_nand_defconfig                |    1 -
 configs/imx6ulz_smm_m2_defconfig                   |    1 -
 configs/imx8mp_dhcom_drc02_defconfig               |  274 +--
 configs/imx8mp_dhcom_pdk2_defconfig                |  270 +--
 configs/imx8mp_dhcom_pdk3_defconfig                |  276 +--
 configs/imx8mp_dhcom_picoitx_defconfig             |  272 +--
 configs/imx8mp_dhsom.config                        |  158 ++
 configs/imx93_9x9_qsb_defconfig                    |  139 ++
 configs/imx93_9x9_qsb_inline_ecc_defconfig         |  140 ++
 configs/imx_dhsom.config                           |   96 +
 configs/imxrt1020-evk_defconfig                    |    1 +
 configs/imxrt1050-evk_defconfig                    |    5 +-
 configs/imxrt1050-evk_fspi_defconfig               |    6 +-
 configs/imxrt1170-evk_defconfig                    |    1 +
 configs/kontron-sl-mx6ul_defconfig                 |    1 -
 configs/kp_imx6q_tpc_defconfig                     |    2 -
 configs/liteboard_defconfig                        |    1 -
 configs/lxr2_defconfig                             |    2 -
 configs/marsboard_defconfig                        |    1 -
 configs/mccmon6_nor_defconfig                      |    2 -
 configs/mccmon6_sd_defconfig                       |    2 -
 configs/mx6cuboxi_defconfig                        |    2 -
 configs/mx6memcal_defconfig                        |    2 -
 configs/mx6qsabrelite_defconfig                    |    1 -
 configs/mx6sabreauto_defconfig                     |    2 -
 configs/mx6sabresd_defconfig                       |    2 -
 configs/mx6ul_14x14_evk_defconfig                  |    6 +-
 configs/mx6ul_9x9_evk_defconfig                    |    1 -
 configs/nitrogen6dl2g_defconfig                    |    1 -
 configs/nitrogen6dl_defconfig                      |    1 -
 configs/nitrogen6q2g_defconfig                     |    1 -
 configs/nitrogen6q_defconfig                       |    1 -
 configs/nitrogen6s1g_defconfig                     |    1 -
 configs/nitrogen6s_defconfig                       |    1 -
 configs/novena_defconfig                           |    2 -
 configs/opos6uldev_defconfig                       |    1 -
 configs/pcm058_defconfig                           |    2 -
 configs/pico-hobbit-imx6ul_defconfig               |    1 -
 configs/pico-imx6_defconfig                        |    2 -
 configs/pico-imx6ul_defconfig                      |    1 -
 configs/pico-pi-imx6ul_defconfig                   |    1 -
 configs/riotboard_defconfig                        |    2 -
 configs/tbs2910_defconfig                          |    1 -
 configs/udoo_defconfig                             |    2 -
 configs/udoo_neo_defconfig                         |    1 -
 configs/variscite_dart6ul_defconfig                |    1 -
 configs/verdin-imx8mm_defconfig                    |    3 +-
 configs/verdin-imx8mp_defconfig                    |    3 +-
 configs/vining_2000_defconfig                      |    1 -
 configs/wandboard_defconfig                        |    2 -
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
 112 files changed, 5362 insertions(+), 1400 deletions(-)
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
 create mode 100644 configs/dhsom.config
 create mode 100644 configs/imx8mp_dhsom.config
 create mode 100644 configs/imx93_9x9_qsb_defconfig
 create mode 100644 configs/imx93_9x9_qsb_inline_ecc_defconfig
 create mode 100644 configs/imx_dhsom.config
 create mode 100644 doc/board/nxp/imx93_9x9_qsb.rst
 create mode 100644 include/configs/imx93_qsb.h
