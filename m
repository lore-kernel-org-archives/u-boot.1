Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881D7C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E3D87C5E;
	Sun, 29 Oct 2023 04:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmVdxlnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903E487733; Sun, 29 Oct 2023 04:48:54 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321B987738
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d264e67d8so23401476d6.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551330; x=1699156130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=buCjTelXO/lyNIl/iydL5UWQaKyMdR0TOdYuRNwL2J0=;
 b=dmVdxlnN6n0sac7ftNlzMrpNF6cpLAwzcYegPp4hso2UF2pt3oqXSJw7YmLGdCCIwK
 6BwfnaVD2V3uFWIdEKQFTxIRduTEwGImHIT1JHa6/RQeUKXCDrE2cZEPl8wQsJjRoZOg
 jhxHGR0wKOuyzKdcbOlAmKFUHfmFPNsqPLUJHY0CTenPDueDMSH8MuuaygeejOV+v9f7
 CfoeJzGT1BYDVUmdacpZqyD1nRxJ9IZkDl9DejZ7M/1f/+j7+2Mm3ekjwonY5/l5/d7m
 pH/v1Fg4nUFvi+33x5jv3CUxCtRLYb0wAQPXwEgsl5W6W1Id2JJ57f+RwRepHGaCtFa0
 zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551330; x=1699156130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=buCjTelXO/lyNIl/iydL5UWQaKyMdR0TOdYuRNwL2J0=;
 b=FMYGATOYhdFA7D19UNjvFAXG80iT+L6KdgMFdVxVQxvULMHUOklmFSBup3jnxmZHOm
 8yCTkDIaSQWpM6xsXAZLa8pOukLMYSPXRqI3cw7CiV89hoC6r5JmzIW3Hah2ctQVo45c
 SMhlF84Hs//Y1M1oLPrYED8XhVBudH+p2I4ldKvniiHp2E5vOKPezuwcGFtqUN0wHRbo
 qCInyxNqeACc4MBc8ds4KMIMz8UJ+jE2SdVtWrlN/EHySbGp6Fgm+Q1kN6CSLLortlNZ
 N07sa09atBF0xnGd4uMk3hT7lzs2RSPNesSD9Rhw+4GtOb4QvaeyH5IUNQCXa3k58s9x
 YHJg==
X-Gm-Message-State: AOJu0Yyo/1y1YzhQ++qt8bNDgJpoJLmEtSf8TlanSAmTSZI3LQkot8M8
 gHy5xcbaC6ZJO/sS1RoFA960G/i+VlBloA==
X-Google-Smtp-Source: AGHT+IFZODyHtDAqr7NaE6Wpbawj5n/ESB49QZ3VllQtt0HMt8XHCwf5Fel6AD/rv5RtDI8hEEU4sg==
X-Received: by 2002:a05:6214:260c:b0:66d:37bc:bb91 with SMTP id
 gu12-20020a056214260c00b0066d37bcbb91mr9564029qvb.56.1698551328555; 
 Sat, 28 Oct 2023 20:48:48 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 k15-20020a05621414ef00b0065b14fcfca6sm2176030qvw.118.2023.10.28.20.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:48 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 00/15] nand: Add sandbox tests
Date: Sat, 28 Oct 2023 23:48:30 -0400
Message-Id: <20231029034845.1169614-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series tests raw nand flash in sandbox and fixes various bugs discovered in
the process. I've tried to do things in a contemporary manner, avoiding the
(numerous) variations present on only a few boards. The test is pretty minimal.
Future work could test the rest of the nand API as well as the MTD API.

Bloat at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
everything grows by a few bytes due to nand_page_size. A few boards grow more,
mostly those using nand_spl_loaders.c.

[1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922de6c2


Sean Anderson (15):
  spl: nand: Fix NULL-pointer dereference
  nand: Don't dereference NULL manufacturer_desc
  nand: Calculate SYS_NAND_PAGE_COUNT automatically
  nand: spl_loaders: Only read enough pages to load the image
  spl: legacy: Honor bl_len when decompressing
  spl: nand: Set bl_len to page size
  cmd: nand: Map memory before accessing it
  spl: nand: Map memory before accessing it
  mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
  mtd: Add some fallbacks for add/del_mtd_device
  nand: Add function to unregister NAND devices
  nand: Allow reinitialization
  arch: sandbox: Add function to create temporary files
  nand: Add sandbox driver
  test: spl: Add a test for NAND

 README                                        |   9 +-
 arch/sandbox/cpu/os.c                         |  17 +
 arch/sandbox/dts/test.dts                     |  67 ++
 arch/sandbox/include/asm/spl.h                |   1 +
 cmd/nand.c                                    |  26 +-
 common/spl/Kconfig                            |   2 +-
 common/spl/spl_legacy.c                       |  18 +-
 common/spl/spl_nand.c                         |  22 +-
 configs/am335x_baltos_defconfig               |   3 +-
 configs/am335x_evm_defconfig                  |   3 +-
 configs/am335x_evm_spiboot_defconfig          |   2 +-
 configs/am335x_guardian_defconfig             |   1 -
 configs/am335x_hs_evm_defconfig               |   2 +-
 configs/am335x_hs_evm_uart_defconfig          |   2 +-
 configs/am335x_igep003x_defconfig             |   3 +-
 configs/am335x_sl50_defconfig                 |   2 +-
 configs/am3517_evm_defconfig                  |   3 +-
 configs/am43xx_evm_defconfig                  |   3 +-
 configs/am43xx_evm_rtconly_defconfig          |   3 +-
 configs/am43xx_evm_usbhost_boot_defconfig     |   3 +-
 configs/am43xx_hs_evm_defconfig               |   3 +-
 configs/am62ax_evm_r5_defconfig               |   2 +-
 configs/am65x_evm_a53_defconfig               |   2 +-
 configs/axm_defconfig                         |   1 -
 configs/chiliboard_defconfig                  |   1 -
 configs/cm_t43_defconfig                      |   2 +-
 configs/corvus_defconfig                      |   1 -
 configs/da850evm_nand_defconfig               |   1 -
 configs/devkit3250_defconfig                  |   1 -
 configs/devkit8000_defconfig                  |   1 -
 configs/dra7xx_evm_defconfig                  |   1 -
 configs/draco_defconfig                       |   1 -
 configs/etamin_defconfig                      |   1 -
 .../gardena-smart-gateway-at91sam_defconfig   |   1 -
 configs/igep00x0_defconfig                    |   3 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/imx8mn_bsh_smm_s2_defconfig           |   2 +-
 configs/j7200_evm_a72_defconfig               |   2 +-
 configs/j7200_evm_r5_defconfig                |   2 +-
 configs/j721e_evm_a72_defconfig               |   2 +-
 configs/j721e_evm_r5_defconfig                |   2 +-
 configs/j721s2_evm_a72_defconfig              |   2 +-
 configs/j721s2_evm_r5_defconfig               |   2 +-
 configs/m53menlo_defconfig                    |   1 -
 configs/omap35_logic_defconfig                |   3 +-
 configs/omap35_logic_somlv_defconfig          |   3 +-
 configs/omap3_beagle_defconfig                |   3 +-
 configs/omap3_evm_defconfig                   |   3 +-
 configs/omap3_logic_defconfig                 |   3 +-
 configs/omap3_logic_somlv_defconfig           |   3 +-
 configs/omapl138_lcdk_defconfig               |   1 -
 configs/phycore-am335x-r2-regor_defconfig     |   3 +-
 configs/phycore-am335x-r2-wega_defconfig      |   3 +-
 configs/pxm2_defconfig                        |   1 -
 configs/rastaban_defconfig                    |   1 -
 configs/rut_defconfig                         |   1 -
 configs/sama5d3_xplained_nandflash_defconfig  |   1 -
 configs/sama5d3xek_nandflash_defconfig        |   1 -
 configs/sama5d4_xplained_nandflash_defconfig  |   1 -
 configs/sama5d4ek_nandflash_defconfig         |   1 -
 configs/sandbox64_defconfig                   |  10 +-
 configs/sandbox_defconfig                     |   9 +
 configs/sandbox_noinst_defconfig              |  21 +-
 configs/smartweb_defconfig                    |   1 -
 configs/socfpga_secu1_defconfig               |   2 +-
 configs/stm32746g-eval_spl_defconfig          |   2 +-
 configs/stm32f746-disco_spl_defconfig         |   2 +-
 configs/stm32f769-disco_spl_defconfig         |   2 +-
 configs/stm32mp15_basic_defconfig             |   2 +-
 configs/stm32mp15_dhcom_basic_defconfig       |   2 +-
 configs/stm32mp15_dhcor_basic_defconfig       |   2 +-
 configs/taurus_defconfig                      |   1 -
 configs/thuban_defconfig                      |   1 -
 drivers/mtd/Makefile                          |   2 +-
 drivers/mtd/nand/raw/Kconfig                  |  27 +-
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/am335x_spl_bch.c         |   8 +-
 drivers/mtd/nand/raw/atmel_nand.c             |  10 +-
 drivers/mtd/nand/raw/denali_spl.c             |   5 +
 drivers/mtd/nand/raw/fsl_ifc_spl.c            |   8 +
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |   5 +
 drivers/mtd/nand/raw/mt7621_nand_spl.c        |   5 +
 drivers/mtd/nand/raw/mxc_nand_spl.c           |  10 +-
 drivers/mtd/nand/raw/mxs_nand_spl.c           |   5 +
 drivers/mtd/nand/raw/nand.c                   |  66 +-
 drivers/mtd/nand/raw/nand_base.c              |   7 +-
 drivers/mtd/nand/raw/nand_spl_loaders.c       |   5 +-
 drivers/mtd/nand/raw/nand_spl_simple.c        |  10 +-
 drivers/mtd/nand/raw/omap_gpmc.c              |   3 +-
 drivers/mtd/nand/raw/sand_nand.c              | 711 ++++++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
 drivers/mtd/onenand/onenand_uboot.c           |   2 -
 include/linux/mtd/mtd.h                       |  12 +
 include/mtd/cfi_flash.h                       |   2 +-
 include/nand.h                                |   3 +
 include/os.h                                  |  13 +
 include/system-constants.h                    |   3 +
 test/dm/Makefile                              |   1 +
 test/dm/nand.c                                | 106 +++
 test/image/Kconfig                            |   9 +
 test/image/Makefile                           |   1 +
 test/image/spl_load_nand.c                    |  54 ++
 102 files changed, 1269 insertions(+), 153 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sand_nand.c
 create mode 100644 test/dm/nand.c
 create mode 100644 test/image/spl_load_nand.c

-- 
2.37.1

