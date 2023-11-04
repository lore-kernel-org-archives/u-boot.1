Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13388C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1148F87049;
	Sat,  4 Nov 2023 21:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2L9c5bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D05886FA7; Sat,  4 Nov 2023 21:38:04 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1866386F5F
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6705379b835so19938126d6.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130276; x=1699735076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eXUMmWGc1nXDgZ0EufEO+nj/lNAm173QJ1FoP8dmfIs=;
 b=H2L9c5bpzPLjhICXf+XEUhSXobR/jEu7FFn5/OBk8PKGUVMqMPmS0otISwe2OLKVU+
 7rsNdo6bz1sa/UBUte8rJUn2uIFJ4vghMpMHozWJIKKzAb9vCIzO43poHJyyB5iy9hw2
 b5tVmhFKUPn1CtjNYGdJJ/VJEudLr874HdpirtyyKQQCPP+q3lz2YyGEwqdZFQapQMmd
 HQbmL/cb0Di47LJUO+D+AikDG7m51F8zKEZrgWzatfGPUASNsp0LckxTMtXU8kqIXJO5
 ewnJ3ZgsSVQto/FMi0Tx5IFNTOrFhfwTAV8To/6QBA78y6nTH2t45bzfqumP8TUgIr9C
 Vblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130276; x=1699735076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXUMmWGc1nXDgZ0EufEO+nj/lNAm173QJ1FoP8dmfIs=;
 b=RTOV8CKdwnrCgR+whfvQJHMTcQEn0B1j9onv09s/aMij2iyedX+vMl+LrT7b/FSdKF
 A2Rs7gPO4UnWFvZIEt2UVFvQ3LiSHcohJkuNRO8LmbzlDCQ5obx5Vg/2/xpiS3DugjUI
 t7ZXZoqtcR22ihCoZuRtiWw0sZj1yJTSfeAi11On33wvBaoc6lMhasEfqSOBO5e7WbSy
 mGYvPKYS88OdtKWkgLir3QivSKAc7MbRk3YUaXCv80nUosXFtS8TcibrAbsJ+rx6WzDu
 pTMpV1Edcz01zWgNuTEfj5f+5l+orG1H7mAgTEdWu4fHopaI0C00QvUD5jcTRubLOVgA
 K0Kg==
X-Gm-Message-State: AOJu0YzOE4IK3zIrsBuiP7pjPdAvk4kVlWXej/wN7cKfmeePxBG/k4af
 DTjWUzXDaF5/toHYR2RIBy7UW3d9icAG/g==
X-Google-Smtp-Source: AGHT+IHOlzLqUr461uEVy7g1ORGmeWDCKYcTqdEWI9Si9GxB1CMfwdF2mB5OwHcdKfXAmOh5GdLRIg==
X-Received: by 2002:a05:6214:c65:b0:66d:43be:7e45 with SMTP id
 t5-20020a0562140c6500b0066d43be7e45mr29877800qvj.43.1699130276014; 
 Sat, 04 Nov 2023 13:37:56 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 l6-20020ad44246000000b00671b009412asm1905703qvq.141.2023.11.04.13.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:37:55 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 00/15] nand: Add sandbox tests
Date: Sat,  4 Nov 2023 16:37:38 -0400
Message-Id: <20231104203753.1579217-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This series tests raw nand flash in sandbox and fixes various bugs discovered in
the process. I've tried to do things in a contemporary manner, avoiding the
(numerous) variations present on only a few boards. The test is pretty minimal.
Future work could test the rest of the nand API as well as the MTD API.

Bloat (for v1) at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
everything grows by a few bytes due to nand_page_size. A few boards grow more,
mostly those using nand_spl_loaders.c. CI at [2].

[1] https://gist.github.com/Forty-Bot/9694f3401893c9e706ccc374922de6c2
[2] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18443

Changes in v2:
- Don't set load->priv for spl_nand_legacy_read since it doesn't use it.
- Rename SYS_NAND_PAGE_COUNT to SYS_NAND_BLOCK_PAGES
- Remove spurious form feed character
- Use ECC bytes from the layout, since we already are using the layout for the
  ECC byte position.
- Add some documentation for the device tree binding
- Fix unused expression warning with clang

Sean Anderson (15):
  spl: nand: Fix NULL-pointer dereference
  nand: Don't dereference NULL manufacturer_desc
  nand: Calculate SYS_NAND_BLOCK_PAGES (neé SYS_NAND_PAGE_COUNT)
    automatically
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
 arch/sandbox/dts/test.dts                     |  65 ++
 arch/sandbox/include/asm/spl.h                |   1 +
 cmd/nand.c                                    |  26 +-
 common/spl/Kconfig                            |   2 +-
 common/spl/spl_legacy.c                       |  18 +-
 common/spl/spl_nand.c                         |  20 +-
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
 .../nand/sandbox,nand.txt                     |  57 ++
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
 drivers/mtd/nand/raw/sand_nand.c              | 707 ++++++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c         |   8 +-
 drivers/mtd/onenand/onenand_uboot.c           |   2 -
 include/linux/mtd/mtd.h                       |  12 +
 include/mtd/cfi_flash.h                       |   2 +-
 include/nand.h                                |   3 +
 include/os.h                                  |  13 +
 include/system-constants.h                    |   4 +
 test/dm/Makefile                              |   1 +
 test/dm/nand.c                                | 104 +++
 test/image/Kconfig                            |   9 +
 test/image/Makefile                           |   1 +
 test/image/spl_load_nand.c                    |  54 ++
 103 files changed, 1318 insertions(+), 152 deletions(-)
 create mode 100644 doc/device-tree-bindings/nand/sandbox,nand.txt
 create mode 100644 drivers/mtd/nand/raw/sand_nand.c
 create mode 100644 test/dm/nand.c
 create mode 100644 test/image/spl_load_nand.c

-- 
2.37.1

