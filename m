Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36777E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2346C86DB9;
	Tue, 26 Sep 2023 16:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZKQCMP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DCAE86D87; Tue, 26 Sep 2023 16:15:26 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43BB86D9C
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34961362f67so27302645ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737721; x=1696342521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+/va+hm41YfOzSG4ekH6tEu5DWYS/uOyeYUpj1kSEqU=;
 b=bZKQCMP3caQvKGwvJdcrdSzHHqHXeGoNftXArsAaBd8vivyayNEYp4Pnj6pz+5RkQP
 iZMpoiVxBH/17KyNffIi/5T3AFYA8yzA2dGyMBjh20jbf8rd4f9f89UH0Ja170m+cD+o
 Boa5xgVtcFBbRGm3zlo9725fG45YNeV6Qu4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737721; x=1696342521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/va+hm41YfOzSG4ekH6tEu5DWYS/uOyeYUpj1kSEqU=;
 b=Rrk+IlAdBMkxMuaRjbTjagKJZNOjJgGde0bT+79i2pQLG5gBUYlIAYYRbvGPBv5X35
 Rkx6To1wp3HxPBIg2HSi2hv5RfxeJV34yFXYwfEPhB7dRrgawufxZsXQcWabQjELJ+QD
 UNY41Af2S8DYW+P9ldOpBtuS6jAkqxPC+8wY23RW6tA2oNlSFwaEARL5iBDsMUhyluWL
 uAiX7kskQZB4F3THHgR7WR60BPQjIzZEDFOkGpi/Rz/VBox/E324bMX3I3RDxNhoxfDc
 MdJTSI3WJ26vXSJXQ6XgzGOjh6/u3j8QfmA6xYF6uhAckqkaGtq080Zv131DWRAb7eYn
 ctSA==
X-Gm-Message-State: AOJu0Yzmbu6rmmwgnYKPGw8NmLLO0WC18JmaalvJbK4PSg7X5tZdkWMg
 UhVwWKLG4kWyux3DtqMI3SOUVzoTJH5ILWZsesM=
X-Google-Smtp-Source: AGHT+IGKjPS68nU+gxWhjJjyC5suPYmuSK7+d9rxecP08sHyGc0KUJDJW8jlaKXcRLUhBltl5uOttg==
X-Received: by 2002:a05:6e02:12eb:b0:351:35d9:f18f with SMTP id
 l11-20020a056e0212eb00b0035135d9f18fmr2715617iln.2.1695737720954; 
 Tue, 26 Sep 2023 07:15:20 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerry Van Baren <vanbaren@cideas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v4 00/44] spl: Preparation for Universal Payload
Date: Tue, 26 Sep 2023 08:14:14 -0600
Message-ID: <20230926141514.2101787-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This series tidies up SPL a little and adds some core ofnode functions
needed to support Universal Payload. It also includes a few minor fix-ups
for sandbox.

For SPL the changes include CONFIG naming, removing various #ifdefs and
tidying up the FIT code.

One notable piece of the ofnode improvements is support for flattening
a livetree. This should be useful in future as we move FDT fixups to use
the ofnode API.

With v4 an attempt is made to reduce code-size impact, resulting in this
for lion-rk3368 :

45: pci: serial: Support reading PCI-register size with base
   aarch64: (for 1/1 boards) all +318.0 rodata +46.0
     spl/u-boot-spl:all -136.0 spl/u-boot-spl:rodata +16.0
        spl/u-boot-spl:text -152.0 text +272.0
     tpl/u-boot-tpl:all -109.0 tpl/u-boot-tpl:rodata +19.0
        tpl/u-boot-tpl:text -128.0

The U-Boot proper growth is due to using dev_read_addr_size() instead of
dev_read_addr() in ns16550.

Changes in v4:
- Add new patch to drop mention of SPL/TPL_SYS_MALLOC_F
- Take account of CONFIG_BOOTSTAGE_STASH for stashing, to avoid size inc
- Split all new bloblist names into a separate patch
- Use an #ifdef to avoid adding a string
- Add new patch with C-based runtime detection of SPL
- Add new patch to drop ns16550 serial_getinfo() in SPL
- Add new patch to tweak device_is_on_pci_bus() for code size
- Avoid reading size except in SPL

Changes in v3:
- Mention testing on qemu-ppce500
- Add new patch to create a proper symbol for enabling the malloc() pool
- Add new patch to enable CONFIG_SPL_SYS_MALLOC_F where needed
- Add new patch to nable CONFIG_TPL_SYS_MALLOC_F where needed
- Add new patch to use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
- Add new patch to tidy up uses of CONFIG_SYS_MALLOC_F_LEN
- Add new patch to clean up SYS_MALLOC_SIMPLE documentation
- Add new patch to correct help in TPL_DM and VPL_DM
- Rebase on the new patch

Changes in v2:
- Rename based on Tom's feedback
- Improve readability by moving the size part to the header file
- Explicitly copy two maintainers as it seems only Mario was auto-cc'd
- Change the approach to use the header file
- Use the same condition for both pieces to avoid possible problems
- No changes as it still seems unclear what should be done

Simon Glass (44):
  configs: Resync with savedefconfig
  spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
  spl: Rename SYS_SPL_ARGS_ADDR to SPL_PAYLOAD_ARGS_ADDR
  spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
  spl: mx6: powerpc: Drop the condition on timer_init()
  spl: Drop #ifdefs for BOARD_INIT and watchdog
  spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
  spl: Drop the switch() statement for OS selection
  serial: Drop mention of SPL/TPL_SYS_MALLOC_F
  spl: Create proper symbols for enabling the malloc() pool
  spl: Enable CONFIG_SPL_SYS_MALLOC_F where needed
  tpl: Enable CONFIG_TPL_SYS_MALLOC_F where needed
  spl: Use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
  Tidy up uses of CONFIG_SYS_MALLOC_F_LEN
  doc: Clean up SYS_MALLOC_SIMPLE
  dm: core: Correct help in TPL_DM and VPL_DM
  spl: Avoid an #ifdef when printing gd->malloc_ptr
  spl: Remove #ifdefs with BOOTSTAGE
  spl: Rename spl_load_fit_image() to load_simple_fit()
  spl: Move the full FIT code to spl_fit.c
  spl: Use the correct FIT_..._PROP constants
  spl: Move bloblist writing until the image is known
  dm: core: Reverse the argument order in ofnode_copy_props()
  dm: core: Ensure we run flattree tests on ofnode
  dm: core: Tidy up comments in the ofnode tests
  dm: core: Add a function to create an empty tree
  dm: core: Add a way to copy a node
  dm: core: Add a way to delete a node
  dm: core: Add a way to convert a devicetree to a dtb
  dm: core: Support writing a boolean
  dm: core: Support writing a 64-bit value
  dm: core: Add tests for oftree_path()
  sandbox: Move reading the RAM buffer into a better place
  sandbox: Init the EC properly even if no state file is available
  sandbox: Only read the state if we have a state file
  sandbox: Move the bloblist down a little in memory
  bloblist: Support initing from multiple places
  bloblist: Add missing name
  fdt: Allow the devicetree to come from a bloblist
  command: Include a required header in command.h
  spl: Add C-based runtime detection of SPL
  serial: Drop ns16550 serial_getinfo() in SPL
  dm: core: Tweak device_is_on_pci_bus() for code size
  pci: serial: Support reading PCI-register size with base

 Kconfig                                       |  69 +++--
 Makefile                                      |   2 +-
 README                                        |  18 --
 arch/arm/cpu/armv7/ls102xa/fdt.c              |   2 +-
 .../armv8/fsl-layerscape/doc/README.falcon    |   2 +-
 arch/arm/lib/bdinfo.c                         |   2 +-
 arch/arm/mach-rockchip/rv1126/Kconfig         |   3 +
 arch/arm/mach-snapdragon/Kconfig              |   3 +
 arch/arm/mach-socfpga/Kconfig                 |   3 +
 arch/mips/cpu/start.S                         |   4 +-
 arch/mips/mach-mtmips/mt7621/spl/start.S      |   4 +-
 arch/powerpc/cpu/mpc83xx/start.S              |   2 +-
 arch/powerpc/cpu/mpc85xx/start.S              |   4 +-
 arch/sandbox/cpu/start.c                      |  29 +-
 arch/sandbox/cpu/state.c                      |   2 +
 arch/sandbox/dts/test.dts                     |   6 +-
 arch/sh/lib/start.S                           |   4 +-
 boot/vbe_request.c                            |   2 +-
 boot/vbe_simple_os.c                          |   2 +-
 common/Kconfig                                |   2 +-
 common/Makefile                               |   6 +-
 common/bloblist.c                             |  15 +-
 common/board_f.c                              |   6 +-
 common/board_r.c                              |   2 +-
 common/bootstage.c                            |  14 +
 common/dlmalloc.c                             |  12 +-
 common/init/board_init.c                      |   4 +-
 common/spl/Kconfig                            |  16 +-
 common/spl/Kconfig.nxp                        |   2 +-
 common/spl/spl.c                              | 226 ++++-----------
 common/spl/spl_ext.c                          |   4 +-
 common/spl/spl_fat.c                          |   4 +-
 common/spl/spl_fit.c                          | 127 +++++++--
 common/spl/spl_mmc.c                          |   2 +-
 common/spl/spl_nand.c                         |  10 +-
 common/spl/spl_nor.c                          |   8 +-
 common/spl/spl_spi.c                          |   2 +-
 common/spl/spl_ubi.c                          |   2 +-
 common/spl/spl_xip.c                          |   2 +-
 configs/10m50_defconfig                       |   2 +-
 configs/3c120_defconfig                       |   2 +-
 configs/CMPC885_defconfig                     |   2 +-
 configs/CMPCPRO_defconfig                     |   4 +-
 configs/MCR3000_defconfig                     |   4 +-
 configs/MPC837XERDB_defconfig                 |   2 +-
 configs/MPC8548CDS_36BIT_defconfig            |   4 +-
 configs/MPC8548CDS_defconfig                  |   4 +-
 configs/MPC8548CDS_legacy_defconfig           |   4 +-
 configs/P1010RDB-PA_36BIT_NAND_defconfig      |   4 +-
 configs/P1010RDB-PA_36BIT_NOR_defconfig       |   4 +-
 configs/P1010RDB-PA_36BIT_SDCARD_defconfig    |   4 +-
 configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig  |   4 +-
 configs/P1010RDB-PA_NAND_defconfig            |   4 +-
 configs/P1010RDB-PA_NOR_defconfig             |   4 +-
 configs/P1010RDB-PA_SDCARD_defconfig          |   4 +-
 configs/P1010RDB-PA_SPIFLASH_defconfig        |   4 +-
 configs/P1010RDB-PB_36BIT_NAND_defconfig      |   4 +-
 configs/P1010RDB-PB_36BIT_NOR_defconfig       |   4 +-
 configs/P1010RDB-PB_36BIT_SDCARD_defconfig    |   4 +-
 configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig  |   4 +-
 configs/P1010RDB-PB_NAND_defconfig            |   4 +-
 configs/P1010RDB-PB_NOR_defconfig             |   4 +-
 configs/P1010RDB-PB_SDCARD_defconfig          |   4 +-
 configs/P1010RDB-PB_SPIFLASH_defconfig        |   4 +-
 configs/P1020RDB-PC_36BIT_NAND_defconfig      |   4 +-
 configs/P1020RDB-PC_36BIT_SDCARD_defconfig    |   6 +-
 configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig  |   6 +-
 configs/P1020RDB-PC_36BIT_defconfig           |   4 +-
 configs/P1020RDB-PC_NAND_defconfig            |   4 +-
 configs/P1020RDB-PC_SDCARD_defconfig          |   6 +-
 configs/P1020RDB-PC_SPIFLASH_defconfig        |   6 +-
 configs/P1020RDB-PC_defconfig                 |   4 +-
 configs/P1020RDB-PD_NAND_defconfig            |   4 +-
 configs/P1020RDB-PD_SDCARD_defconfig          |   6 +-
 configs/P1020RDB-PD_SPIFLASH_defconfig        |   6 +-
 configs/P1020RDB-PD_defconfig                 |   4 +-
 configs/P2020RDB-PC_36BIT_NAND_defconfig      |   4 +-
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig    |   6 +-
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig  |   6 +-
 configs/P2020RDB-PC_36BIT_defconfig           |   4 +-
 configs/P2020RDB-PC_NAND_defconfig            |   4 +-
 configs/P2020RDB-PC_SDCARD_defconfig          |   6 +-
 configs/P2020RDB-PC_SPIFLASH_defconfig        |   6 +-
 configs/P2020RDB-PC_defconfig                 |   4 +-
 configs/P2041RDB_NAND_defconfig               |   6 +-
 configs/P2041RDB_SDCARD_defconfig             |   6 +-
 configs/P2041RDB_SPIFLASH_defconfig           |   6 +-
 configs/P2041RDB_defconfig                    |   4 +-
 configs/T1024RDB_NAND_defconfig               |   4 +-
 configs/T1024RDB_SDCARD_defconfig             |   4 +-
 configs/T1024RDB_SPIFLASH_defconfig           |   4 +-
 configs/T1024RDB_defconfig                    |   2 +-
 configs/T1042D4RDB_NAND_defconfig             |   4 +-
 configs/T1042D4RDB_SDCARD_defconfig           |   4 +-
 configs/T1042D4RDB_SPIFLASH_defconfig         |   4 +-
 configs/T1042D4RDB_defconfig                  |   2 +-
 configs/T2080QDS_NAND_defconfig               |   6 +-
 configs/T2080QDS_SDCARD_defconfig             |   6 +-
 configs/T2080QDS_SECURE_BOOT_defconfig        |   4 +-
 configs/T2080QDS_SPIFLASH_defconfig           |   6 +-
 configs/T2080QDS_SRIO_PCIE_BOOT_defconfig     |   4 +-
 configs/T2080QDS_defconfig                    |   4 +-
 configs/T2080RDB_NAND_defconfig               |   4 +-
 configs/T2080RDB_SDCARD_defconfig             |   4 +-
 configs/T2080RDB_SPIFLASH_defconfig           |   4 +-
 configs/T2080RDB_defconfig                    |   2 +-
 configs/T2080RDB_revD_NAND_defconfig          |   4 +-
 configs/T2080RDB_revD_SDCARD_defconfig        |   4 +-
 configs/T2080RDB_revD_SPIFLASH_defconfig      |   4 +-
 configs/T2080RDB_revD_defconfig               |   2 +-
 configs/T4240RDB_SDCARD_defconfig             |   4 +-
 configs/T4240RDB_defconfig                    |   2 +-
 configs/ae350_rv32_defconfig                  |   2 +-
 configs/ae350_rv32_spl_defconfig              |   2 +-
 configs/ae350_rv32_spl_xip_defconfig          |   2 +-
 configs/ae350_rv32_xip_defconfig              |   2 +-
 configs/ae350_rv64_defconfig                  |   2 +-
 configs/ae350_rv64_spl_defconfig              |   2 +-
 configs/ae350_rv64_spl_xip_defconfig          |   2 +-
 configs/ae350_rv64_xip_defconfig              |   2 +-
 configs/am335x_baltos_defconfig               |   6 +-
 configs/am335x_boneblack_vboot_defconfig      |   4 +-
 configs/am335x_evm_defconfig                  |   6 +-
 configs/am335x_evm_spiboot_defconfig          |   6 +-
 configs/am335x_guardian_defconfig             |   4 +-
 configs/am335x_hs_evm_defconfig               |   6 +-
 configs/am335x_hs_evm_uart_defconfig          |   6 +-
 configs/am335x_igep003x_defconfig             |   8 +-
 configs/am335x_pdu001_defconfig               |   4 +-
 configs/am335x_shc_defconfig                  |   4 +-
 configs/am335x_shc_ict_defconfig              |   4 +-
 configs/am335x_shc_netboot_defconfig          |   4 +-
 configs/am335x_shc_sdboot_defconfig           |   4 +-
 configs/am335x_sl50_defconfig                 |   4 +-
 configs/am3517_evm_defconfig                  |   6 +-
 configs/am43xx_evm_defconfig                  |   4 +-
 configs/am43xx_evm_rtconly_defconfig          |   4 +-
 configs/am43xx_evm_usbhost_boot_defconfig     |   4 +-
 configs/am43xx_hs_evm_defconfig               |   6 +-
 configs/am57xx_evm_defconfig                  |   6 +-
 configs/am57xx_hs_evm_defconfig               |   6 +-
 configs/am57xx_hs_evm_usb_defconfig           |   7 +-
 configs/am62ax_evm_r5_defconfig               |   6 +-
 configs/am62x_evm_r5_defconfig                |   8 +-
 configs/am64x_evm_a53_defconfig               |   4 +-
 configs/am64x_evm_r5_defconfig                |   8 +-
 configs/am65x_evm_a53_defconfig               |   6 +-
 configs/am65x_evm_r5_defconfig                |   8 +-
 configs/am65x_evm_r5_usbdfu_defconfig         |   8 +-
 configs/am65x_evm_r5_usbmsc_defconfig         |   8 +-
 configs/am65x_hs_evm_a53_defconfig            |   6 +-
 configs/am65x_hs_evm_r5_defconfig             |   8 +-
 configs/apalis-imx8_defconfig                 |   2 +-
 configs/apalis-tk1_defconfig                  |  10 +-
 configs/apalis_imx6_defconfig                 |   2 +-
 configs/apalis_t30_defconfig                  |   8 +-
 configs/axm_defconfig                         |   8 +-
 configs/bayleybay_defconfig                   |   1 -
 configs/bcmns_defconfig                       |   4 +-
 configs/beaver_defconfig                      |   8 +-
 configs/bitmain_antminer_s9_defconfig         |   4 +-
 configs/boston32r2_defconfig                  |   2 +-
 configs/boston32r2el_defconfig                |   2 +-
 configs/boston32r6_defconfig                  |   2 +-
 configs/boston32r6el_defconfig                |   2 +-
 configs/boston64r2_defconfig                  |   2 +-
 configs/boston64r2el_defconfig                |   2 +-
 configs/boston64r6_defconfig                  |   2 +-
 configs/boston64r6el_defconfig                |   2 +-
 configs/brppt1_mmc_defconfig                  |   6 +-
 configs/brppt2_defconfig                      |   4 +-
 configs/brsmarc1_defconfig                    |   6 +-
 configs/brxre1_defconfig                      |   6 +-
 configs/cardhu_defconfig                      |   8 +-
 configs/cei-tk1-som_defconfig                 |   8 +-
 configs/cgtqmx8_defconfig                     |  10 +-
 configs/cherryhill_defconfig                  |   1 -
 configs/chiliboard_defconfig                  |   4 +-
 configs/chromebook_coral_defconfig            |   3 +-
 configs/chromebook_link_defconfig             |   1 -
 configs/chromebook_samus_defconfig            |   1 -
 configs/chromebook_samus_tpl_defconfig        |   6 +-
 configs/chromebox_panther_defconfig           |   1 -
 configs/cl-som-imx7_defconfig                 |   2 +-
 configs/cm_fx6_defconfig                      |   6 +-
 configs/cm_t43_defconfig                      |   4 +-
 configs/colibri-imx8x_defconfig               |   2 +-
 configs/colibri_imx6_defconfig                |   2 +-
 configs/colibri_t20_defconfig                 |   8 +-
 configs/colibri_t30_defconfig                 |   8 +-
 configs/colibri_vf_defconfig                  |   2 +-
 ...-qeval20-qa3-e3845-internal-uart_defconfig |   1 -
 configs/conga-qeval20-qa3-e3845_defconfig     |   1 -
 configs/coreboot64_defconfig                  |   2 +-
 configs/coreboot_defconfig                    |   2 +-
 configs/cortina_presidio-asic-emmc_defconfig  |   1 -
 configs/cougarcanyon2_defconfig               |   1 -
 configs/crownbay_defconfig                    |   1 -
 configs/da850evm_defconfig                    |   8 +-
 configs/da850evm_nand_defconfig               |   8 +-
 configs/dalmore_defconfig                     |   8 +-
 configs/deneb_defconfig                       |  12 +-
 configs/devkit8000_defconfig                  |   8 +-
 configs/dfi-bt700-q7x-151_defconfig           |   1 -
 configs/dh_imx6_defconfig                     |   2 +-
 configs/display5_defconfig                    |   4 +-
 configs/display5_factory_defconfig            |   6 +-
 configs/dra7xx_evm_defconfig                  |   6 +-
 configs/dra7xx_hs_evm_defconfig               |   6 +-
 configs/dra7xx_hs_evm_usb_defconfig           |   6 +-
 configs/draco_defconfig                       |   6 +-
 configs/dragonboard410c_defconfig             |   2 +-
 configs/durian_defconfig                      |   1 -
 configs/ea-lpc3250devkitv2_defconfig          |   2 +-
 configs/efi-x86_payload32_defconfig           |   1 -
 configs/efi-x86_payload64_defconfig           |   2 -
 configs/endeavoru_defconfig                   |  14 +-
 configs/etamin_defconfig                      |   6 +-
 configs/galileo_defconfig                     |   1 -
 .../gardena-smart-gateway-at91sam_defconfig   |   4 +-
 .../gardena-smart-gateway-mt7688_defconfig    |   2 +-
 configs/gazerbeam_defconfig                   |   4 +-
 configs/ge_b1x5v2_defconfig                   |   4 +-
 configs/ge_bx50v3_defconfig                   |   2 +-
 configs/giedi_defconfig                       |  12 +-
 configs/grouper_common_defconfig              |  14 +-
 configs/gwventana_emmc_defconfig              |   8 +-
 configs/gwventana_nand_defconfig              |   8 +-
 configs/harmony_defconfig                     |   8 +-
 configs/highbank_defconfig                    |   2 +-
 configs/igep00x0_defconfig                    |  10 +-
 configs/imx28_xea_defconfig                   |   4 +-
 configs/imx6dl_icore_nand_defconfig           |   2 +-
 configs/imx6dl_mamoj_defconfig                |   4 +-
 configs/imx6q_bosch_acc_defconfig             |   2 +-
 configs/imx6q_icore_nand_defconfig            |   2 +-
 configs/imx6q_logic_defconfig                 |   4 +-
 configs/imx6qdl_icore_mipi_defconfig          |   4 +-
 configs/imx6qdl_icore_mmc_defconfig           |   4 +-
 configs/imx6qdl_icore_nand_defconfig          |   2 +-
 configs/imx6qdl_icore_rqs_defconfig           |   4 +-
 configs/imx6ul_geam_mmc_defconfig             |   2 +-
 configs/imx6ul_geam_nand_defconfig            |   2 +-
 configs/imx6ul_isiot_emmc_defconfig           |   2 +-
 configs/imx6ul_isiot_nand_defconfig           |   2 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/imx7_cm_defconfig                     |   2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |  10 +-
 configs/imx8mm-cl-iot-gate_defconfig          |  10 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  10 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  10 +-
 configs/imx8mm-mx8menlo_defconfig             |  10 +-
 configs/imx8mm_beacon_defconfig               |   8 +-
 configs/imx8mm_beacon_fspi_defconfig          |   8 +-
 configs/imx8mm_data_modul_edm_sbc_defconfig   |   8 +-
 configs/imx8mm_evk_defconfig                  |  10 +-
 configs/imx8mm_evk_fspi_defconfig             |  10 +-
 configs/imx8mm_phg_defconfig                  |  10 +-
 configs/imx8mm_venice_defconfig               |   8 +-
 configs/imx8mn_beacon_2g_defconfig            |   8 +-
 configs/imx8mn_beacon_defconfig               |   8 +-
 configs/imx8mn_beacon_fspi_defconfig          |   8 +-
 configs/imx8mn_bsh_smm_s2_defconfig           |  10 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig        |  10 +-
 configs/imx8mn_ddr4_evk_defconfig             |  10 +-
 configs/imx8mn_evk_defconfig                  |  10 +-
 configs/imx8mn_var_som_defconfig              |  10 +-
 configs/imx8mn_venice_defconfig               |  10 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |  10 +-
 configs/imx8mp_beacon_defconfig               |  10 +-
 configs/imx8mp_data_modul_edm_sbc_defconfig   |   8 +-
 configs/imx8mp_dhcom_pdk2_defconfig           |   8 +-
 configs/imx8mp_dhcom_pdk3_defconfig           |   8 +-
 configs/imx8mp_evk_defconfig                  |  10 +-
 configs/imx8mp_rsb3720a1_4G_defconfig         |  10 +-
 configs/imx8mp_rsb3720a1_6G_defconfig         |  10 +-
 configs/imx8mp_venice_defconfig               |  10 +-
 configs/imx8mq_cm_defconfig                   |  10 +-
 configs/imx8mq_evk_defconfig                  |  10 +-
 configs/imx8mq_phanbell_defconfig             |  10 +-
 configs/imx8mq_reform2_defconfig              |  10 +-
 configs/imx8qm_dmsse20a1_defconfig            |   2 +-
 configs/imx8qm_mek_defconfig                  |  10 +-
 configs/imx8qxp_mek_defconfig                 |  10 +-
 configs/imx8ulp_evk_defconfig                 |   8 +-
 configs/imx93_11x11_evk_defconfig             |   8 +-
 configs/imx93_11x11_evk_ld_defconfig          |   8 +-
 configs/iot2050_defconfig                     |   8 +-
 configs/j7200_evm_a72_defconfig               |   6 +-
 configs/j7200_evm_r5_defconfig                |   8 +-
 configs/j721e_evm_a72_defconfig               |   6 +-
 configs/j721e_evm_r5_defconfig                |   8 +-
 configs/j721s2_evm_a72_defconfig              |   6 +-
 configs/j721s2_evm_r5_defconfig               |   8 +-
 configs/jetson-tk1_defconfig                  |   8 +-
 configs/k2e_evm_defconfig                     |   6 +-
 configs/k2e_hs_evm_defconfig                  |   2 +-
 configs/k2g_evm_defconfig                     |   6 +-
 configs/k2g_hs_evm_defconfig                  |   2 +-
 configs/k2hk_evm_defconfig                    |   6 +-
 configs/k2hk_hs_evm_defconfig                 |   2 +-
 configs/k2l_evm_defconfig                     |   6 +-
 configs/kmcent2_defconfig                     |   2 +-
 configs/kmcoge5ne_defconfig                   |   4 +-
 configs/kmeter1_defconfig                     |   4 +-
 configs/kmopti2_defconfig                     |   4 +-
 configs/kmsupx5_defconfig                     |   4 +-
 configs/kmtepr2_defconfig                     |   4 +-
 configs/kontron-sl-mx6ul_defconfig            |   6 +-
 configs/kontron-sl-mx8mm_defconfig            |  10 +-
 configs/kontron_pitx_imx8m_defconfig          |  10 +-
 configs/kontron_sl28_defconfig                |   6 +-
 configs/kp_imx6q_tpc_defconfig                |   2 +-
 configs/librem5_defconfig                     |  10 +-
 configs/liteboard_defconfig                   |   2 +-
 configs/ls1012a2g5rdb_qspi_defconfig          |   4 +-
 configs/ls1012a2g5rdb_tfa_defconfig           |   4 +-
 configs/ls1012afrdm_qspi_defconfig            |   4 +-
 configs/ls1012afrdm_tfa_defconfig             |   4 +-
 .../ls1012afrwy_qspi_SECURE_BOOT_defconfig    |   4 +-
 configs/ls1012afrwy_qspi_defconfig            |   4 +-
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig |   4 +-
 configs/ls1012afrwy_tfa_defconfig             |   4 +-
 configs/ls1012aqds_qspi_defconfig             |   4 +-
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1012aqds_tfa_defconfig              |   4 +-
 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig |   4 +-
 configs/ls1012ardb_qspi_defconfig             |   4 +-
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1012ardb_tfa_defconfig              |   4 +-
 configs/ls1021aiot_qspi_defconfig             |   2 +-
 configs/ls1021aiot_sdcard_defconfig           |  10 +-
 configs/ls1021aqds_ddr4_nor_defconfig         |   4 +-
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig  |   4 +-
 configs/ls1021aqds_nand_defconfig             |  12 +-
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1021aqds_nor_defconfig              |   4 +-
 configs/ls1021aqds_nor_lpuart_defconfig       |   4 +-
 configs/ls1021aqds_qspi_defconfig             |   4 +-
 configs/ls1021aqds_sdcard_ifc_defconfig       |   8 +-
 configs/ls1021aqds_sdcard_qspi_defconfig      |   6 +-
 configs/ls1021atsn_qspi_defconfig             |   4 +-
 configs/ls1021atsn_sdcard_defconfig           |  10 +-
 configs/ls1021atwr_nor_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1021atwr_nor_defconfig              |   4 +-
 configs/ls1021atwr_nor_lpuart_defconfig       |   4 +-
 configs/ls1021atwr_qspi_defconfig             |   4 +-
 ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  10 +-
 configs/ls1021atwr_sdcard_ifc_defconfig       |  10 +-
 configs/ls1021atwr_sdcard_qspi_defconfig      |  10 +-
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1028aqds_tfa_defconfig              |   4 +-
 configs/ls1028aqds_tfa_lpuart_defconfig       |   4 +-
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1028ardb_tfa_defconfig              |   4 +-
 configs/ls1043aqds_defconfig                  |   4 +-
 configs/ls1043aqds_lpuart_defconfig           |   4 +-
 configs/ls1043aqds_nand_defconfig             |  10 +-
 configs/ls1043aqds_nor_ddr3_defconfig         |   4 +-
 configs/ls1043aqds_qspi_defconfig             |   4 +-
 configs/ls1043aqds_sdcard_ifc_defconfig       |   6 +-
 configs/ls1043aqds_sdcard_qspi_defconfig      |   6 +-
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1043aqds_tfa_defconfig              |   4 +-
 configs/ls1043ardb_SECURE_BOOT_defconfig      |   2 +-
 configs/ls1043ardb_defconfig                  |   2 +-
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig |   8 +-
 configs/ls1043ardb_nand_defconfig             |   8 +-
 .../ls1043ardb_sdcard_SECURE_BOOT_defconfig   |   4 +-
 configs/ls1043ardb_sdcard_defconfig           |   4 +-
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/ls1043ardb_tfa_defconfig              |   2 +-
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig |   2 +-
 configs/ls1046afrwy_tfa_defconfig             |   2 +-
 configs/ls1046aqds_SECURE_BOOT_defconfig      |   4 +-
 configs/ls1046aqds_defconfig                  |   4 +-
 configs/ls1046aqds_lpuart_defconfig           |   4 +-
 configs/ls1046aqds_nand_defconfig             |   6 +-
 configs/ls1046aqds_qspi_defconfig             |   4 +-
 configs/ls1046aqds_sdcard_ifc_defconfig       |   6 +-
 configs/ls1046aqds_sdcard_qspi_defconfig      |   6 +-
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls1046aqds_tfa_defconfig              |   4 +-
 configs/ls1046ardb_emmc_defconfig             |   4 +-
 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig |   2 +-
 configs/ls1046ardb_qspi_defconfig             |   2 +-
 configs/ls1046ardb_qspi_spl_defconfig         |   6 +-
 .../ls1046ardb_sdcard_SECURE_BOOT_defconfig   |   4 +-
 configs/ls1046ardb_sdcard_defconfig           |   4 +-
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/ls1046ardb_tfa_defconfig              |   2 +-
 configs/ls1088aqds_defconfig                  |   2 +-
 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig |   4 +-
 configs/ls1088aqds_qspi_defconfig             |   4 +-
 configs/ls1088aqds_sdcard_ifc_defconfig       |   4 +-
 configs/ls1088aqds_sdcard_qspi_defconfig      |   4 +-
 configs/ls1088aqds_tfa_defconfig              |   4 +-
 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig |   4 +-
 configs/ls1088ardb_qspi_defconfig             |   4 +-
 ...1088ardb_sdcard_qspi_SECURE_BOOT_defconfig |   4 +-
 configs/ls1088ardb_sdcard_qspi_defconfig      |   4 +-
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/ls1088ardb_tfa_defconfig              |   2 +-
 configs/ls2080aqds_SECURE_BOOT_defconfig      |   4 +-
 configs/ls2080aqds_defconfig                  |   4 +-
 configs/ls2080aqds_nand_defconfig             |   8 +-
 configs/ls2080aqds_qspi_defconfig             |   6 +-
 configs/ls2080aqds_sdcard_defconfig           |   8 +-
 configs/ls2080ardb_SECURE_BOOT_defconfig      |   4 +-
 configs/ls2080ardb_defconfig                  |   4 +-
 configs/ls2080ardb_nand_defconfig             |   8 +-
 configs/ls2081ardb_defconfig                  |   6 +-
 configs/ls2088aqds_tfa_defconfig              |   4 +-
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig |   6 +-
 configs/ls2088ardb_qspi_defconfig             |   6 +-
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig  |   4 +-
 configs/ls2088ardb_tfa_defconfig              |   4 +-
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/lx2160aqds_tfa_defconfig              |   4 +-
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/lx2160ardb_tfa_defconfig              |   4 +-
 configs/lx2160ardb_tfa_stmm_defconfig         |   4 +-
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig  |   2 +-
 configs/lx2162aqds_tfa_defconfig              |   4 +-
 .../lx2162aqds_tfa_verified_boot_defconfig    |   4 +-
 configs/m53menlo_defconfig                    |   2 +-
 configs/mccmon6_nor_defconfig                 |   4 +-
 configs/mccmon6_sd_defconfig                  |   2 +-
 configs/medcom-wide_defconfig                 |   8 +-
 configs/minnowmax_defconfig                   |   1 -
 configs/msc_sm2s_imx8mp_defconfig             |  10 +-
 configs/mvebu_espressobin-88f3720_defconfig   |   3 +-
 configs/mx53ppd_defconfig                     |   2 +-
 configs/mx6cuboxi_defconfig                   |   4 +-
 configs/mx6memcal_defconfig                   |   2 +-
 configs/mx6sabreauto_defconfig                |   2 +-
 configs/mx6sabresd_defconfig                  |   2 +-
 configs/mx6slevk_spl_defconfig                |   2 +-
 configs/mx6ul_14x14_evk_defconfig             |   2 +-
 configs/mx6ul_9x9_evk_defconfig               |   2 +-
 configs/myir_mys_6ulx_defconfig               |   2 +-
 configs/novena_defconfig                      |   2 +-
 configs/nyan-big_defconfig                    |  10 +-
 configs/octeontx2_95xx_defconfig              |   3 +-
 configs/octeontx2_96xx_defconfig              |   3 +-
 configs/octeontx_81xx_defconfig               |   2 +-
 configs/octeontx_83xx_defconfig               |   2 +-
 configs/odroid-xu3_defconfig                  |   1 -
 configs/odroid_defconfig                      |   1 -
 configs/omap35_logic_defconfig                |   6 +-
 configs/omap35_logic_somlv_defconfig          |   8 +-
 configs/omap3_beagle_defconfig                |   4 +-
 configs/omap3_evm_defconfig                   |   4 +-
 configs/omap3_logic_defconfig                 |   6 +-
 configs/omap3_logic_somlv_defconfig           |   8 +-
 configs/omap4_panda_defconfig                 |   4 +-
 configs/omap4_sdp4430_defconfig               |   4 +-
 configs/omapl138_lcdk_defconfig               |   8 +-
 configs/openpiton_riscv64_spl_defconfig       |   2 +-
 configs/opos6uldev_defconfig                  |   2 +-
 configs/origen_defconfig                      |   1 -
 configs/paz00_defconfig                       |   8 +-
 configs/pcm051_rev3_defconfig                 |   2 +-
 configs/pcm058_defconfig                      |   2 +-
 configs/pg_wcom_expu1_defconfig               |   4 +-
 configs/pg_wcom_expu1_update_defconfig        |   4 +-
 configs/pg_wcom_seli8_defconfig               |   4 +-
 configs/pg_wcom_seli8_update_defconfig        |   4 +-
 configs/phycore-am335x-r2-regor_defconfig     |   6 +-
 configs/phycore-am335x-r2-wega_defconfig      |   6 +-
 configs/phycore-imx8mm_defconfig              |   8 +-
 configs/phycore-imx8mp_defconfig              |   8 +-
 configs/phycore_pcl063_defconfig              |   2 +-
 configs/phycore_pcl063_ull_defconfig          |   2 +-
 configs/pico-dwarf-imx6ul_defconfig           |   2 +-
 configs/pico-dwarf-imx7d_defconfig            |   2 +-
 configs/pico-hobbit-imx6ul_defconfig          |   2 +-
 configs/pico-hobbit-imx7d_defconfig           |   2 +-
 configs/pico-imx6_defconfig                   |   2 +-
 configs/pico-imx6ul_defconfig                 |   2 +-
 configs/pico-imx7d_bl33_defconfig             |   2 +-
 configs/pico-imx7d_defconfig                  |   2 +-
 configs/pico-imx8mq_defconfig                 |   8 +-
 configs/pico-nymph-imx7d_defconfig            |   2 +-
 configs/pico-pi-imx6ul_defconfig              |   2 +-
 configs/pico-pi-imx7d_defconfig               |   2 +-
 configs/plutux_defconfig                      |   8 +-
 configs/pomelo_defconfig                      |   1 -
 configs/pxm2_defconfig                        |   6 +-
 configs/qemu-ppce500_defconfig                |   4 +-
 configs/qemu-riscv32_spl_defconfig            |   2 +-
 configs/qemu-riscv64_spl_defconfig            |   2 +-
 configs/qemu-x86_64_defconfig                 |   2 +-
 configs/r8a77990_ebisu_defconfig              |   2 +-
 configs/r8a77995_draak_defconfig              |   2 +-
 configs/rastaban_defconfig                    |   6 +-
 configs/rcar3_salvator-x_defconfig            |   2 +-
 configs/rcar3_ulcb_defconfig                  |   2 +-
 configs/ringneck-px30_defconfig               |   2 +-
 configs/riotboard_defconfig                   |   4 +-
 configs/rock64-rk3328_defconfig               |   4 +-
 configs/rpi_0_w_defconfig                     |   2 +-
 configs/rpi_2_defconfig                       |   2 +-
 configs/rpi_3_32b_defconfig                   |   2 +-
 configs/rpi_3_b_plus_defconfig                |   2 +-
 configs/rpi_3_defconfig                       |   2 +-
 configs/rpi_4_32b_defconfig                   |   4 +-
 configs/rpi_4_defconfig                       |   4 +-
 configs/rpi_arm64_defconfig                   |   4 +-
 configs/rpi_defconfig                         |   2 +-
 configs/rut_defconfig                         |   6 +-
 configs/s5p4418_nanopi2_defconfig             |   2 +-
 configs/s5p_goni_defconfig                    |   1 -
 configs/s5pc210_universal_defconfig           |   1 -
 configs/sama5d27_giantboard_defconfig         |   4 +-
 configs/sama5d27_som1_ek_mmc1_defconfig       |   4 +-
 configs/sama5d27_som1_ek_mmc_defconfig        |   4 +-
 configs/sama5d27_som1_ek_qspiflash_defconfig  |   4 +-
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |   4 +-
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |   4 +-
 configs/sama5d29_curiosity_mmc1_defconfig     |   1 -
 configs/sama5d29_curiosity_mmc_defconfig      |   1 -
 configs/sama5d2_icp_mmc_defconfig             |   4 +-
 configs/sama5d2_xplained_emmc_defconfig       |   4 +-
 configs/sama5d2_xplained_mmc_defconfig        |   4 +-
 configs/sama5d2_xplained_qspiflash_defconfig  |   4 +-
 configs/sama5d2_xplained_spiflash_defconfig   |   4 +-
 configs/sama5d3_xplained_mmc_defconfig        |   4 +-
 configs/sama5d3_xplained_nandflash_defconfig  |   4 +-
 configs/sama5d3xek_mmc_defconfig              |   4 +-
 configs/sama5d3xek_nandflash_defconfig        |   4 +-
 configs/sama5d3xek_spiflash_defconfig         |   4 +-
 configs/sama5d4_xplained_mmc_defconfig        |   4 +-
 configs/sama5d4_xplained_nandflash_defconfig  |   4 +-
 configs/sama5d4_xplained_spiflash_defconfig   |   4 +-
 configs/sama5d4ek_mmc_defconfig               |   4 +-
 configs/sama5d4ek_nandflash_defconfig         |   4 +-
 configs/sama5d4ek_spiflash_defconfig          |   4 +-
 configs/sandbox64_defconfig                   |   3 +-
 configs/sandbox_defconfig                     |   5 +-
 configs/seaboard_defconfig                    |   8 +-
 configs/seeed_npi_imx6ull_defconfig           |   2 +-
 configs/sifive_unleashed_defconfig            |   2 +-
 configs/sifive_unmatched_defconfig            |   2 +-
 configs/slimbootloader_defconfig              |   2 -
 configs/smartweb_defconfig                    |   4 +-
 configs/sniper_defconfig                      |   6 +-
 configs/socfpga_agilex_atf_defconfig          |   8 +-
 configs/socfpga_agilex_defconfig              |   8 +-
 configs/socfpga_agilex_vab_defconfig          |   8 +-
 configs/socfpga_arria10_defconfig             |  10 +-
 configs/socfpga_arria5_defconfig              |   2 +-
 configs/socfpga_chameleonv3_defconfig         |   8 +-
 configs/socfpga_cyclone5_defconfig            |   2 +-
 configs/socfpga_dbm_soc1_defconfig            |   2 +-
 configs/socfpga_de0_nano_soc_defconfig        |   2 +-
 configs/socfpga_de10_nano_defconfig           |   2 +-
 configs/socfpga_de10_standard_defconfig       |   2 +-
 configs/socfpga_de1_soc_defconfig             |   2 +-
 configs/socfpga_is1_defconfig                 |   2 +-
 configs/socfpga_mcvevk_defconfig              |   2 +-
 configs/socfpga_n5x_atf_defconfig             |   8 +-
 configs/socfpga_n5x_defconfig                 |   8 +-
 configs/socfpga_n5x_vab_defconfig             |   8 +-
 configs/socfpga_sockit_defconfig              |   2 +-
 configs/socfpga_sr1500_defconfig              |   2 +-
 configs/socfpga_stratix10_atf_defconfig       |   8 +-
 configs/socfpga_stratix10_defconfig           |   8 +-
 configs/socfpga_vining_fpga_defconfig         |   2 +-
 configs/socrates_defconfig                    |   2 +-
 configs/som-db5800-som-6867_defconfig         |   1 -
 configs/starfive_visionfive2_defconfig        |  19 +-
 configs/stm32746g-eval_spl_defconfig          |   2 +-
 configs/stm32f746-disco_spl_defconfig         |   2 +-
 configs/stm32f769-disco_spl_defconfig         |   2 +-
 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |   8 +-
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |   8 +-
 ...-microgea-stm32mp1-microdev2-of7_defconfig |   8 +-
 ...mp15-microgea-stm32mp1-microdev2_defconfig |   8 +-
 configs/stm32mp15_basic_defconfig             |  10 +-
 configs/stm32mp15_defconfig                   |   2 +-
 configs/stm32mp15_dhcom_basic_defconfig       |   8 +-
 configs/stm32mp15_dhcor_basic_defconfig       |   8 +-
 configs/stm32mp15_trusted_defconfig           |   2 +-
 configs/stmark2_defconfig                     |   2 +-
 configs/syzygy_hub_defconfig                  |   6 +-
 configs/taurus_defconfig                      |   8 +-
 configs/tec-ng_defconfig                      |   8 +-
 configs/tec_defconfig                         |   8 +-
 configs/ten64_tfa_defconfig                   |   2 +-
 ...able-x86-conga-qa3-e3845-pcie-x4_defconfig |   1 -
 .../theadorable-x86-conga-qa3-e3845_defconfig |   1 -
 configs/theadorable-x86-dfi-bt700_defconfig   |   1 -
 configs/thuban_defconfig                      |   6 +-
 configs/tools-only_defconfig                  |   2 +-
 configs/topic_miami_defconfig                 |   5 +-
 configs/topic_miamilite_defconfig             |   5 +-
 configs/topic_miamiplus_defconfig             |   5 +-
 configs/tqma6dl_mba6_mmc_defconfig            |   2 +-
 configs/tqma6dl_mba6_spi_defconfig            |   2 +-
 configs/tqma6q_mba6_mmc_defconfig             |   2 +-
 configs/tqma6q_mba6_spi_defconfig             |   2 +-
 configs/tqma6s_mba6_mmc_defconfig             |   2 +-
 configs/tqma6s_mba6_spi_defconfig             |   2 +-
 configs/transformer_t30_defconfig             |  14 +-
 configs/trats2_defconfig                      |   1 -
 configs/trats_defconfig                       |   1 -
 configs/trimslice_defconfig                   |   8 +-
 configs/tuge1_defconfig                       |   4 +-
 configs/turris_mox_defconfig                  |   3 +-
 configs/turris_omnia_defconfig                |   2 +-
 configs/tuxx1_defconfig                       |   4 +-
 configs/udoo_defconfig                        |   2 +-
 configs/udoo_neo_defconfig                    |   2 +-
 configs/uniphier_ld4_sld8_defconfig           |   2 +-
 configs/uniphier_v7_defconfig                 |   2 +-
 configs/uniphier_v8_defconfig                 |   2 +-
 configs/variscite_dart6ul_defconfig           |   2 +-
 configs/venice2_defconfig                     |   8 +-
 configs/ventana_defconfig                     |   8 +-
 configs/verdin-am62_a53_defconfig             |   2 +-
 configs/verdin-am62_r5_defconfig              |   8 +-
 configs/verdin-imx8mm_defconfig               |  10 +-
 configs/verdin-imx8mp_defconfig               |  10 +-
 configs/vining_2000_defconfig                 |   2 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 configs/wandboard_defconfig                   |   2 +-
 configs/warp7_defconfig                       |   2 +-
 configs/x3_t30_defconfig                      |  14 +-
 configs/xenguest_arm64_defconfig              |   2 +-
 configs/xilinx_versal_mini_qspi_defconfig     |   2 +-
 configs/xilinx_versal_net_mini_defconfig      |   2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig |   2 +-
 configs/xilinx_versal_net_virt_defconfig      |   2 +-
 configs/xilinx_versal_virt_defconfig          |   2 +-
 configs/xilinx_zynq_virt_defconfig            |   9 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   8 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   8 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig     |  10 +-
 configs/xilinx_zynqmp_virt_defconfig          |  13 +-
 configs/zynq_cse_nand_defconfig               |   8 +-
 configs/zynq_cse_nor_defconfig                |   8 +-
 configs/zynq_cse_qspi_defconfig               |  10 +-
 doc/arch/sandbox/sandbox.rst                  |   4 +-
 doc/develop/devicetree/control.rst            |   3 +
 doc/develop/falcon.rst                        |   2 +-
 doc/usage/cmd/bdinfo.rst                      |   2 +-
 drivers/core/Kconfig                          |  14 +-
 drivers/core/fdtaddr.c                        |   6 +-
 drivers/core/of_access.c                      |  65 +++++
 drivers/core/ofnode.c                         | 183 ++++++++++++-
 drivers/core/read.c                           |   6 +-
 drivers/core/util.c                           |   2 +-
 drivers/misc/cros_ec_sandbox.c                |   9 +-
 drivers/pci/pci-uclass.c                      |   2 +-
 drivers/pci/pci_mvebu.c                       |   3 +-
 drivers/pci/pci_tegra.c                       |   2 +-
 drivers/pci/pcie_mediatek.c                   |   4 +-
 drivers/serial/Kconfig                        |   2 -
 drivers/serial/ns16550.c                      |  21 +-
 dts/Kconfig                                   |   8 +
 include/asm-generic/global_data.h             |  12 +-
 include/bloblist.h                            |  23 ++
 include/bootstage.h                           |  22 ++
 include/command.h                             |   3 +
 include/configs/socfpga_common.h              |   2 +-
 include/configs/socfpga_soc64_common.h        |   2 +-
 include/dm/device.h                           |   3 +-
 include/dm/fdtaddr.h                          |   3 +-
 include/dm/of_access.h                        |  18 ++
 include/dm/ofnode.h                           | 102 ++++++-
 include/dm/read.h                             |   8 +-
 include/fdtdec.h                              |   3 +-
 include/ns16550.h                             |   4 +-
 include/of_live.h                             |  18 ++
 include/serial.h                              |   2 +
 include/spl.h                                 |  38 ++-
 include/system-constants.h                    |  20 +-
 lib/asm-offsets.c                             |   2 +-
 lib/fdtdec.c                                  |  46 +++-
 lib/of_live.c                                 | 141 ++++++++++
 test/dm/ofnode.c                              | 258 ++++++++++++++++--
 test/dm/pci.c                                 |  14 +-
 test/lib/kconfig.c                            |   4 +-
 684 files changed, 2689 insertions(+), 1851 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

