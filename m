Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF9EE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B519C86545;
	Fri, 15 Sep 2023 13:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M5cYtXZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4CE86660; Fri, 15 Sep 2023 02:21:58 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B858648D
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso59783939f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737311; x=1695342111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bDGS+6tavXcc4kSdWofMPzMTo9lRR9alB+B/lf0Px8U=;
 b=M5cYtXZOVsTqK708mGCIx9vkXeQAJFb71z5BkltvrvmlEThv+PCRFipuv55ivnDHcu
 RtIZgNGOcmjC/tKN31WBLWijTR48GXuPAX9LYau2lc8lJE+dv/yqU7VtPpMKQO/j2vCJ
 wnQZheq0xHnToEOiynrfcaG8Z64Px/WSFuE7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737311; x=1695342111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bDGS+6tavXcc4kSdWofMPzMTo9lRR9alB+B/lf0Px8U=;
 b=RrvJ2BxE3japoN4txZ9Yxfm1OO3tkXQ7CjXocB+c/xanGpMnF9+HiPa7bOQAHWyU4O
 TjYL5/zT4Hq+NbCHHwFArl/IUSFJsyjK7sGuu60x/EFIwVha6unybFQ7/dOXSyhjWeMb
 BMzHhcM5zk+4p8PMdKN6XKmyE9rZk3qo6lK/sAzywvjMSXv9hd0QjIrGPqrvAQ5ffcAD
 qO+f7gHZOMdKNMQ/JMbXCF6Yli9SWT/GIoOnGFdWMMFA21oZzOBxwNdSo49lyAHundNS
 GJB41IkdLHPnoBWwiqYk4nZQJsY1EkcHmurMY137kl+g818Qi95gYG62ApR5+8ticNuY
 A8NA==
X-Gm-Message-State: AOJu0YxjLkMxL1d/iavU8xRkBXW6XWoqGHxyCr8AyDjzrTNaxgvN+BFB
 nN++ngAd1SDiIxI6KdHe53NNrYC+npQLWbRp6Gg=
X-Google-Smtp-Source: AGHT+IFtJQLH7vfeOJrhDY26HBtdZq4hp3Bz/BXlAYPJg+tqtjSYBWh9UkNwvJCGbZF4VlNKbgoy3w==
X-Received: by 2002:a05:6e02:2145:b0:34f:7eaa:1156 with SMTP id
 d5-20020a056e02214500b0034f7eaa1156mr426661ilv.11.1694737310506; 
 Thu, 14 Sep 2023 17:21:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ft10-20020a056638660a00b0042b3bf0baacsm710952jab.138.2023.09.14.17.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:21:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] common: Drop linux/printk.h from common header
Date: Thu, 14 Sep 2023 18:21:46 -0600
Message-ID: <20230915002147.797352-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

This old patch was marked as deferred. Bring it back to life, to continue
towards the removal of common.h

Move this out of the common header and include it only where needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/gic-v3-its.c                              | 1 +
 arch/arm/mach-imx/imx8/fdt.c                           | 1 +
 arch/arm/mach-k3/common.c                              | 1 +
 arch/arm/mach-meson/board-gx.c                         | 1 +
 arch/arm/mach-omap2/am33xx/board.c                     | 1 +
 arch/arm/mach-omap2/utils.c                            | 1 +
 arch/arm/mach-rockchip/boot_mode.c                     | 1 +
 arch/arm/mach-rockchip/rk3188/rk3188.c                 | 1 +
 arch/arm/mach-rockchip/rk3399/rk3399.c                 | 1 +
 arch/arm/mach-socfpga/misc.c                           | 1 +
 arch/arm/mach-stm32mp/bsec.c                           | 1 +
 arch/arm/mach-stm32mp/cmd_stm32key.c                   | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c    | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c        | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h        | 2 ++
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c    | 1 +
 arch/arm/mach-stm32mp/cpu.c                            | 3 ++-
 arch/arm/mach-stm32mp/include/mach/stm32mp1_smc.h      | 1 +
 arch/arm/mach-tegra/cboot.c                            | 1 +
 arch/arm/mach-tegra/ivc.c                              | 1 +
 arch/arm/mach-tegra/tegra124/xusb-padctl.c             | 1 +
 arch/arm/mach-tegra/tegra20/clock.c                    | 1 +
 arch/arm/mach-tegra/tegra210/xusb-padctl.c             | 1 +
 arch/arm/mach-tegra/tegra30/clock.c                    | 1 +
 arch/arm/mach-tegra/xusb-padctl-common.c               | 1 +
 arch/arm/mach-uniphier/boot-device/boot-device.c       | 1 +
 arch/arm/mach-uniphier/clk/dpll-ld4.c                  | 1 +
 arch/arm/mach-uniphier/clk/dpll-pro4.c                 | 1 +
 arch/arm/mach-uniphier/dram/umc-ld4.c                  | 1 +
 arch/arm/mach-uniphier/dram/umc-pro4.c                 | 1 +
 arch/arm/mach-uniphier/dram/umc-sld8.c                 | 1 +
 arch/arm/mach-uniphier/memconf.c                       | 1 +
 arch/arm/mach-uniphier/spl_board_init.c                | 1 +
 arch/riscv/lib/smp.c                                   | 1 +
 arch/x86/cpu/tangier/pinmux.c                          | 1 +
 arch/x86/cpu/tangier/sdram.c                           | 1 +
 board/dhelectronics/dh_stm32mp1/board.c                | 1 +
 board/mediatek/mt8518/mt8518_ap1.c                     | 1 +
 board/mscc/ocelot/ocelot.c                             | 1 +
 board/nvidia/jetson-tk1/jetson-tk1.c                   | 1 +
 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c | 1 +
 board/samsung/common/exynos5-dt.c                      | 1 +
 board/samsung/common/misc.c                            | 1 +
 board/samsung/goni/goni.c                              | 1 +
 board/samsung/odroid/odroid.c                          | 1 +
 board/st/common/stm32mp_dfu.c                          | 1 +
 board/st/stm32mp1/stm32mp1.c                           | 1 +
 board/sunxi/board.c                                    | 1 +
 board/synopsys/hsdk/clk-lib.c                          | 1 +
 board/synopsys/hsdk/env-lib.c                          | 1 +
 board/ti/am65x/evm.c                                   | 1 +
 board/ti/common/board_detect.c                         | 1 +
 board/ti/j721e/evm.c                                   | 1 +
 board/toradex/apalis-tk1/apalis-tk1.c                  | 1 +
 cmd/adc.c                                              | 1 +
 cmd/fastboot.c                                         | 1 +
 cmd/nvedit.c                                           | 1 +
 cmd/onenand.c                                          | 1 +
 cmd/regulator.c                                        | 1 +
 cmd/thordown.c                                         | 1 +
 cmd/tpm_test.c                                         | 1 +
 cmd/usb_gadget_sdp.c                                   | 1 +
 cmd/usb_mass_storage.c                                 | 1 +
 common/dfu.c                                           | 1 +
 common/spl/spl_dfu.c                                   | 1 +
 common/spl/spl_fit.c                                   | 1 +
 common/spl/spl_opensbi.c                               | 1 +
 common/spl/spl_sdp.c                                   | 1 +
 common/update.c                                        | 1 +
 disk/part_efi.c                                        | 1 +
 drivers/adc/adc-uclass.c                               | 1 +
 drivers/adc/exynos-adc.c                               | 1 +
 drivers/adc/meson-saradc.c                             | 1 +
 drivers/adc/rockchip-saradc.c                          | 1 +
 drivers/adc/sandbox.c                                  | 1 +
 drivers/ata/dwc_ahci.c                                 | 1 +
 drivers/bios_emulator/include/x86emu/debug.h           | 1 +
 drivers/bios_emulator/include/x86emu/regs.h            | 1 +
 drivers/bios_emulator/x86emu/debug.c                   | 1 +
 drivers/bios_emulator/x86emu/decode.c                  | 1 +
 drivers/bios_emulator/x86emu/ops.c                     | 1 +
 drivers/bios_emulator/x86emu/ops2.c                    | 1 +
 drivers/bios_emulator/x86emu/sys.c                     | 1 +
 drivers/bootcount/bootcount-uclass.c                   | 1 +
 drivers/clk/analogbits/wrpll-cln28hpc.c                | 1 +
 drivers/clk/clk-divider.c                              | 1 +
 drivers/clk/clk-gate.c                                 | 1 +
 drivers/clk/clk-hsdk-cgu.c                             | 1 +
 drivers/clk/clk-mux.c                                  | 1 +
 drivers/clk/clk_boston.c                               | 1 +
 drivers/clk/imx/clk-pll14xx.c                          | 1 +
 drivers/clk/rockchip/clk_rk3368.c                      | 1 +
 drivers/clk/rockchip/clk_rk3399.c                      | 1 +
 drivers/core/device.c                                  | 1 +
 drivers/core/of_addr.c                                 | 1 +
 drivers/core/root.c                                    | 1 +
 drivers/dfu/dfu.c                                      | 1 +
 drivers/dfu/dfu_mmc.c                                  | 1 +
 drivers/dfu/dfu_ram.c                                  | 1 +
 drivers/dma/bcm6348-iudma.c                            | 1 +
 drivers/dma/dma-uclass.c                               | 1 +
 drivers/dma/lpc32xx_dma.c                              | 1 +
 drivers/dma/sandbox-dma-test.c                         | 1 +
 drivers/dma/ti-edma3.c                                 | 1 +
 drivers/dma/ti/k3-udma.c                               | 1 +
 drivers/fastboot/fb_command.c                          | 1 +
 drivers/fastboot/fb_getvar.c                           | 1 +
 drivers/fastboot/fb_mmc.c                              | 1 +
 drivers/fastboot/fb_nand.c                             | 1 +
 drivers/i2c/i2c-gpio.c                                 | 1 +
 drivers/i2c/iproc_i2c.c                                | 1 +
 drivers/i2c/omap24xx_i2c.c                             | 1 +
 drivers/i2c/stm32f7_i2c.c                              | 1 +
 drivers/i2c/tegra_i2c.c                                | 1 +
 drivers/misc/sifive-otp.c                              | 1 +
 drivers/misc/tegra186_bpmp.c                           | 1 +
 drivers/mmc/exynos_dw_mmc.c                            | 1 +
 drivers/mmc/fsl_esdhc_imx.c                            | 1 +
 drivers/mmc/mmc.c                                      | 1 +
 drivers/mmc/mtk-sd.c                                   | 1 +
 drivers/mmc/sdhci.c                                    | 1 +
 drivers/mmc/sti_sdhci.c                                | 1 +
 drivers/mmc/stm32_sdmmc2.c                             | 1 +
 drivers/mmc/xenon_sdhci.c                              | 1 +
 drivers/mtd/mtdconcat.c                                | 1 +
 drivers/mtd/mtdcore.c                                  | 1 +
 drivers/mtd/mtdpart.c                                  | 1 +
 drivers/mtd/nand/bbt.c                                 | 1 +
 drivers/mtd/nand/core.c                                | 1 +
 drivers/mtd/nand/raw/arasan_nfc.c                      | 1 +
 drivers/mtd/nand/raw/atmel_nand.c                      | 1 +
 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c          | 1 +
 drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c           | 1 +
 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c          | 1 +
 drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c           | 1 +
 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c           | 1 +
 drivers/mtd/nand/raw/davinci_nand.c                    | 1 +
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c                | 1 +
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c                | 1 +
 drivers/mtd/nand/raw/mxc_nand.c                        | 1 +
 drivers/mtd/nand/raw/nand_base.c                       | 1 +
 drivers/mtd/nand/raw/nand_bbt.c                        | 1 +
 drivers/mtd/nand/raw/nand_bch.c                        | 1 +
 drivers/mtd/nand/raw/pxa3xx_nand.c                     | 1 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                 | 1 +
 drivers/mtd/nand/raw/sunxi_nand.c                      | 1 +
 drivers/mtd/nand/raw/tegra_nand.c                      | 1 +
 drivers/mtd/nand/raw/vf610_nfc.c                       | 1 +
 drivers/mtd/nand/raw/zynq_nand.c                       | 1 +
 drivers/mtd/nand/spi/core.c                            | 1 +
 drivers/mtd/onenand/onenand_base.c                     | 1 +
 drivers/mtd/onenand/onenand_bbt.c                      | 1 +
 drivers/mtd/onenand/samsung.c                          | 1 +
 drivers/mtd/spi/spi-nor-core.c                         | 1 +
 drivers/mtd/spi/spi-nor-tiny.c                         | 1 +
 drivers/mtd/ubi/attach.c                               | 1 +
 drivers/mtd/ubi/build.c                                | 1 +
 drivers/mtd/ubi/debug.c                                | 1 +
 drivers/mtd/ubi/debug.h                                | 1 +
 drivers/mtd/ubi/ubi.h                                  | 1 +
 drivers/net/bcm-sf2-eth-gmac.c                         | 1 +
 drivers/net/bcm-sf2-eth.c                              | 1 +
 drivers/net/bcm6348-eth.c                              | 1 +
 drivers/net/bcm6368-eth.c                              | 1 +
 drivers/net/designware.c                               | 1 +
 drivers/net/dwc_eth_qos.c                              | 1 +
 drivers/net/fsl-mc/dpio/qbman_sys.h                    | 1 +
 drivers/net/ftgmac100.c                                | 1 +
 drivers/net/mscc_eswitch/jr2_switch.c                  | 1 +
 drivers/net/mscc_eswitch/ocelot_switch.c               | 1 +
 drivers/net/mscc_eswitch/serval_switch.c               | 1 +
 drivers/net/mscc_eswitch/servalt_switch.c              | 1 +
 drivers/net/mt7628-eth.c                               | 1 +
 drivers/net/mtk_eth.c                                  | 1 +
 drivers/net/mvmdio.c                                   | 1 +
 drivers/net/phy/dp83867.c                              | 1 +
 drivers/net/phy/mscc.c                                 | 1 +
 drivers/net/rtl8169.c                                  | 1 +
 drivers/net/sni_ave.c                                  | 1 +
 drivers/net/ti/am65-cpsw-nuss.c                        | 1 +
 drivers/net/ti/cpsw-common.c                           | 1 +
 drivers/net/ti/cpsw.c                                  | 1 +
 drivers/net/ti/keystone_net.c                          | 1 +
 drivers/pci/pci-uclass.c                               | 1 +
 drivers/pci/pci_mvebu.c                                | 1 +
 drivers/pci/pci_tegra.c                                | 1 +
 drivers/pci/pcie_ecam_generic.c                        | 1 +
 drivers/pci/pcie_fsl.c                                 | 1 +
 drivers/pci/pcie_mediatek.c                            | 1 +
 drivers/pci/pcie_phytium.c                             | 1 +
 drivers/pci/pcie_xilinx.c                              | 1 +
 drivers/phy/keystone-usb-phy.c                         | 1 +
 drivers/phy/marvell/comphy_cp110.c                     | 1 +
 drivers/phy/meson-g12a-usb2.c                          | 1 +
 drivers/phy/meson-g12a-usb3-pcie.c                     | 1 +
 drivers/phy/meson-gxbb-usb2.c                          | 1 +
 drivers/phy/meson-gxl-usb2.c                           | 3 ++-
 drivers/phy/phy-rcar-gen3.c                            | 1 +
 drivers/phy/phy-stm32-usbphyc.c                        | 1 +
 drivers/phy/phy-uclass.c                               | 1 +
 drivers/phy/sti_usb_phy.c                              | 1 +
 drivers/phy/ti-pipe3-phy.c                             | 1 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c            | 1 +
 drivers/pinctrl/pinctrl-sti.c                          | 1 +
 drivers/pinctrl/pinctrl_stm32.c                        | 1 +
 drivers/power/palmas.c                                 | 1 +
 drivers/power/pmic/as3722.c                            | 1 +
 drivers/power/pmic/as3722_gpio.c                       | 1 +
 drivers/power/pmic/bd71837.c                           | 1 +
 drivers/power/pmic/da9063.c                            | 1 +
 drivers/power/pmic/fan53555.c                          | 1 +
 drivers/power/pmic/i2c_pmic_emul.c                     | 1 +
 drivers/power/pmic/lp873x.c                            | 1 +
 drivers/power/pmic/lp87565.c                           | 1 +
 drivers/power/pmic/max77686.c                          | 1 +
 drivers/power/pmic/max8997.c                           | 1 +
 drivers/power/pmic/max8998.c                           | 1 +
 drivers/power/pmic/palmas.c                            | 1 +
 drivers/power/pmic/pca9450.c                           | 1 +
 drivers/power/pmic/pfuze100.c                          | 1 +
 drivers/power/pmic/pmic_tps65910_dm.c                  | 1 +
 drivers/power/pmic/s2mps11.c                           | 1 +
 drivers/power/pmic/s5m8767.c                           | 1 +
 drivers/power/pmic/sandbox.c                           | 1 +
 drivers/power/pmic/tps65090.c                          | 1 +
 drivers/power/pmic/tps65941.c                          | 1 +
 drivers/power/regulator/bd71837.c                      | 1 +
 drivers/power/regulator/fan53555.c                     | 1 +
 drivers/power/regulator/fixed.c                        | 2 ++
 drivers/power/regulator/gpio-regulator.c               | 2 ++
 drivers/power/regulator/max77686.c                     | 1 +
 drivers/power/regulator/pbias_regulator.c              | 1 +
 drivers/power/regulator/regulator_common.c             | 2 ++
 drivers/power/regulator/s2mps11_regulator.c            | 1 +
 drivers/power/regulator/sandbox.c                      | 1 +
 drivers/power/regulator/tps65910_regulator.c           | 1 +
 drivers/power/twl4030.c                                | 1 +
 drivers/power/twl6030.c                                | 1 +
 drivers/ram/imxrt_sdram.c                              | 1 +
 drivers/ram/rockchip/dmc-rk3368.c                      | 1 +
 drivers/ram/stm32_sdram.c                              | 1 +
 drivers/ram/stm32mp1/stm32mp1_ddr.c                    | 1 +
 drivers/ram/stm32mp1/stm32mp1_ram.c                    | 1 +
 drivers/remoteproc/rproc-elf-loader.c                  | 1 +
 drivers/remoteproc/rproc-uclass.c                      | 1 +
 drivers/remoteproc/sandbox_testproc.c                  | 1 +
 drivers/remoteproc/stm32_copro.c                       | 1 +
 drivers/remoteproc/ti_power_proc.c                     | 1 +
 drivers/remoteproc/ti_sci_proc.h                       | 1 +
 drivers/reset/sti-reset.c                              | 1 +
 drivers/serial/serial_mtk.c                            | 1 +
 drivers/soc/ti/k3-navss-ringacc.c                      | 1 +
 drivers/spi/atmel_spi.c                                | 1 +
 drivers/spi/fsl_dspi.c                                 | 1 +
 drivers/spi/mt7621_spi.c                               | 1 +
 drivers/spi/mxc_spi.c                                  | 1 +
 drivers/spi/pl022_spi.c                                | 1 +
 drivers/spi/stm32_qspi.c                               | 1 +
 drivers/spi/stm32_spi.c                                | 1 +
 drivers/spi/uniphier_spi.c                             | 1 +
 drivers/sysreset/sysreset_sti.c                        | 1 +
 drivers/sysreset/sysreset_syscon.c                     | 1 +
 drivers/sysreset/sysreset_watchdog.c                   | 1 +
 drivers/tpm/tpm_tis_infineon.c                         | 1 +
 drivers/usb/cdns3/gadget.c                             | 1 +
 drivers/usb/common/common.c                            | 1 +
 drivers/usb/dwc3/dwc3-generic.c                        | 1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                     | 1 +
 drivers/usb/dwc3/gadget.c                              | 1 +
 drivers/usb/eth/mcs7830.c                              | 1 +
 drivers/usb/gadget/at91_udc.c                          | 1 +
 drivers/usb/gadget/atmel_usba_udc.c                    | 1 +
 drivers/usb/gadget/dwc2_udc_otg.c                      | 1 +
 drivers/usb/gadget/ether.c                             | 1 +
 drivers/usb/gadget/f_fastboot.c                        | 1 +
 drivers/usb/gadget/f_sdp.c                             | 1 +
 drivers/usb/gadget/f_thor.c                            | 1 +
 drivers/usb/gadget/udc/udc-uclass.c                    | 1 +
 drivers/usb/host/dwc3-sti-glue.c                       | 1 +
 drivers/usb/musb-new/mt85xx.c                          | 1 +
 drivers/usb/musb-new/musb_core.c                       | 1 +
 drivers/usb/musb-new/musb_debug.h                      | 1 +
 drivers/usb/musb-new/musb_dsps.c                       | 1 +
 drivers/usb/musb-new/musb_gadget.c                     | 1 +
 drivers/usb/musb-new/musb_gadget_ep0.c                 | 1 +
 drivers/usb/musb-new/omap2430.c                        | 1 +
 drivers/usb/musb-new/sunxi.c                           | 1 +
 drivers/usb/musb-new/ti-musb.c                         | 1 +
 drivers/video/meson/meson_dw_hdmi.c                    | 1 +
 drivers/video/meson/meson_vclk.c                       | 1 +
 drivers/video/stm32/stm32_dsi.c                        | 1 +
 drivers/video/stm32/stm32_ltdc.c                       | 1 +
 drivers/video/tegra124/sor.c                           | 1 +
 drivers/watchdog/stm32mp_wdt.c                         | 1 +
 env/common.c                                           | 1 +
 fs/ubifs/debug.c                                       | 1 +
 fs/ubifs/debug.h                                       | 1 +
 fs/ubifs/lpt_commit.c                                  | 1 +
 fs/ubifs/super.c                                       | 1 +
 fs/ubifs/ubifs.h                                       | 1 +
 fs/yaffs2/yaffs_uboot_glue.c                           | 1 +
 include/common.h                                       | 1 -
 include/crypto/pkcs7_parser.h                          | 1 +
 include/dm/device_compat.h                             | 1 +
 include/linux/soc/ti/cppi5.h                           | 1 +
 lib/asn1_decoder.c                                     | 1 +
 lib/bch.c                                              | 1 +
 lib/crypto/asymmetric_type.c                           | 1 +
 lib/crypto/pkcs7_parser.c                              | 1 +
 lib/crypto/pkcs7_verify.c                              | 1 +
 lib/crypto/public_key.c                                | 1 +
 lib/crypto/rsa_helper.c                                | 1 +
 lib/crypto/x509_cert_parser.c                          | 1 +
 lib/crypto/x509_public_key.c                           | 1 +
 lib/list_sort.c                                        | 1 +
 net/fastboot_udp.c                                     | 1 +
 317 files changed, 322 insertions(+), 3 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index f6211a2d92c5..f4bbd21da915 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -9,6 +9,7 @@
 #include <asm/gic-v3.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 static u32 lpi_id_bits;
diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index 491c8bb8c759..c2bed3e0c1fb 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -11,6 +11,7 @@
 #include <dm/ofnode.h>
 #include <fdt_support.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index a35110429b23..cc755dd1bf6e 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include "common.h"
 #include <dm.h>
 #include <remoteproc.h>
diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index f28f84d86f6e..c3fbdfffeae8 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -15,6 +15,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index a6307251c1fc..c0b6f9039952 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/musb.h>
diff --git a/arch/arm/mach-omap2/utils.c b/arch/arm/mach-omap2/utils.c
index 7d938724f841..0623281a3c7d 100644
--- a/arch/arm/mach-omap2/utils.c
+++ b/arch/arm/mach-omap2/utils.c
@@ -9,6 +9,7 @@
 #include <asm/setup.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/omap_common.h>
+#include <linux/printk.h>
 
 static void do_cancel_out(u32 *num, u32 *den, u32 factor)
 {
diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index 1a1a887fc2cd..eb8f65ae4e9d 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -12,6 +12,7 @@
 #include <asm/arch-rockchip/boot_mode.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/printk.h>
 
 #if (CONFIG_ROCKCHIP_BOOT_MODE_REG == 0)
 
diff --git a/arch/arm/mach-rockchip/rk3188/rk3188.c b/arch/arm/mach-rockchip/rk3188/rk3188.c
index df8fa1566f07..c807221f33f1 100644
--- a/arch/arm/mach-rockchip/rk3188/rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/rk3188.c
@@ -17,6 +17,7 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <dm/ofnode.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #define GRF_BASE	0x20008000
 
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index cbd2ea047dcf..14565d2ed9fa 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -20,6 +20,7 @@
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 5b5a81a255d5..80ad0870341b 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -25,6 +25,7 @@
 #include <asm/arch/nic301.h>
 #include <asm/arch/scu.h>
 #include <asm/pl310.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
index 0dc1e5c3fdc4..599e63a93dd9 100644
--- a/arch/arm/mach-stm32mp/bsec.c
+++ b/arch/arm/mach-stm32mp/bsec.c
@@ -18,6 +18,7 @@
 #include <dm/device_compat.h>
 #include <linux/arm-smccc.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 
 #define BSEC_OTP_MAX_VALUE		95
 #define BSEC_OTP_UPPER_START		32
diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
index 85be8e23bdba..e16fcf4424dc 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32key.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
@@ -11,6 +11,7 @@
 #include <asm/arch/bsec.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/printk.h>
 
 /*
  * Closed device: OTP0
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index c695cc11232b..2411bcf06d8f 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -8,6 +8,7 @@
 #include <dfu.h>
 #include <image.h>
 #include <asm/arch/stm32prog.h>
+#include <linux/printk.h>
 #include "stm32prog.h"
 
 struct stm32prog_data *stm32prog_data;
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
index 9ba94be804ee..393f9a1b411c 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/mtd/mtd.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 #include "stm32prog.h"
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
index feba29501d8b..ae4bd8842f53 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h
@@ -6,6 +6,8 @@
 #ifndef _STM32PROG_H_
 #define _STM32PROG_H_
 
+#include <linux/printk.h>
+
 /* - phase defines ------------------------------------------------*/
 #define PHASE_FLASHLAYOUT	0x00
 #define PHASE_FIRST_USER	0x10
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
index f1bed7d1a33b..35bed3199422 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
@@ -14,6 +14,7 @@
 #include <dm/lists.h>
 #include <dm/device-internal.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <asm/global_data.h>
 #include "stm32prog.h"
 
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
index be38ff239b28..d18455bf36f1 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
@@ -9,6 +9,7 @@
 #include <usb.h>
 #include <asm/arch/stm32prog.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/printk.h>
 #include "stm32prog.h"
 
 static int stm32prog_set_phase(struct stm32prog_data *data, u8 phase,
diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
index e2f67fc42333..e07abbe21c1a 100644
--- a/arch/arm/mach-stm32mp/cpu.c
+++ b/arch/arm/mach-stm32mp/cpu.c
@@ -15,6 +15,7 @@
 #include <lmb.h>
 #include <misc.h>
 #include <net.h>
+#include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 #include <asm/arch/sys_proto.h>
@@ -22,7 +23,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <linux/bitops.h>
-#include <spl.h>
+#include <linux/printk.h>
 
 /*
  * early TLB into the .data section so that it not get cleared
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32mp1_smc.h b/arch/arm/mach-stm32mp/include/mach/stm32mp1_smc.h
index 4ad14f963b46..1b2bba3d34c2 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32mp1_smc.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32mp1_smc.h
@@ -7,6 +7,7 @@
 #define __STM32MP1_SMC_H__
 
 #include <linux/arm-smccc.h>
+#include <linux/printk.h>
 
 /*
  * SMC function IDs for STM32 Service queries
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index 55eb81986048..8f5bb2f261a9 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 
 #include <linux/ctype.h>
 #include <linux/sizes.h>
diff --git a/arch/arm/mach-tegra/ivc.c b/arch/arm/mach-tegra/ivc.c
index b69a458fdf0c..66c1276f4b87 100644
--- a/arch/arm/mach-tegra/ivc.c
+++ b/arch/arm/mach-tegra/ivc.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch-tegra/ivc.h>
 #include <linux/bug.h>
+#include <linux/printk.h>
 
 #define TEGRA_IVC_ALIGN 64
 
diff --git a/arch/arm/mach-tegra/tegra124/xusb-padctl.c b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
index d3c7719c3dda..69736aa39255 100644
--- a/arch/arm/mach-tegra/tegra124/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
@@ -11,6 +11,7 @@
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <asm/global_data.h>
 
 #include "../xusb-padctl-common.h"
diff --git a/arch/arm/mach-tegra/tegra20/clock.c b/arch/arm/mach-tegra/tegra20/clock.c
index 067a9f1a2f12..abd6e3917acd 100644
--- a/arch/arm/mach-tegra/tegra20/clock.c
+++ b/arch/arm/mach-tegra/tegra20/clock.c
@@ -19,6 +19,7 @@
 #include <div64.h>
 #include <fdtdec.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <dt-bindings/clock/tegra20-car.h>
 
diff --git a/arch/arm/mach-tegra/tegra210/xusb-padctl.c b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
index c414dfd3b86f..30d0395bb0e5 100644
--- a/arch/arm/mach-tegra/tegra210/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
@@ -12,6 +12,7 @@
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include "../xusb-padctl-common.h"
 
diff --git a/arch/arm/mach-tegra/tegra30/clock.c b/arch/arm/mach-tegra/tegra30/clock.c
index 1dc9d09dba86..698c7ab9560d 100644
--- a/arch/arm/mach-tegra/tegra30/clock.c
+++ b/arch/arm/mach-tegra/tegra30/clock.c
@@ -18,6 +18,7 @@
 #include <div64.h>
 #include <fdtdec.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <dt-bindings/clock/tegra30-car.h>
 
diff --git a/arch/arm/mach-tegra/xusb-padctl-common.c b/arch/arm/mach-tegra/xusb-padctl-common.c
index 388ec4996882..28fdebe50a33 100644
--- a/arch/arm/mach-tegra/xusb-padctl-common.c
+++ b/arch/arm/mach-tegra/xusb-padctl-common.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <linux/printk.h>
 
 #include "xusb-padctl-common.h"
 
diff --git a/arch/arm/mach-uniphier/boot-device/boot-device.c b/arch/arm/mach-uniphier/boot-device/boot-device.c
index 98ff34cfa713..1e6bc8433f7d 100644
--- a/arch/arm/mach-uniphier/boot-device/boot-device.c
+++ b/arch/arm/mach-uniphier/boot-device/boot-device.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/printk.h>
 
 #include "../init.h"
 #include "../sg-regs.h"
diff --git a/arch/arm/mach-uniphier/clk/dpll-ld4.c b/arch/arm/mach-uniphier/clk/dpll-ld4.c
index 3ccaf02242c6..f24a0eb0b827 100644
--- a/arch/arm/mach-uniphier/clk/dpll-ld4.c
+++ b/arch/arm/mach-uniphier/clk/dpll-ld4.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 #include "../init.h"
 #include "../sc-regs.h"
diff --git a/arch/arm/mach-uniphier/clk/dpll-pro4.c b/arch/arm/mach-uniphier/clk/dpll-pro4.c
index 44006ae6dc44..204aee1a62c0 100644
--- a/arch/arm/mach-uniphier/clk/dpll-pro4.c
+++ b/arch/arm/mach-uniphier/clk/dpll-pro4.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 #include "../init.h"
 #include "../sc-regs.h"
diff --git a/arch/arm/mach-uniphier/dram/umc-ld4.c b/arch/arm/mach-uniphier/dram/umc-ld4.c
index 96acca2562fa..1eb15b611fd3 100644
--- a/arch/arm/mach-uniphier/dram/umc-ld4.c
+++ b/arch/arm/mach-uniphier/dram/umc-ld4.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 #include <asm/processor.h>
 
diff --git a/arch/arm/mach-uniphier/dram/umc-pro4.c b/arch/arm/mach-uniphier/dram/umc-pro4.c
index cde39b499bf6..0114df782b4f 100644
--- a/arch/arm/mach-uniphier/dram/umc-pro4.c
+++ b/arch/arm/mach-uniphier/dram/umc-pro4.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 #include <asm/processor.h>
 
diff --git a/arch/arm/mach-uniphier/dram/umc-sld8.c b/arch/arm/mach-uniphier/dram/umc-sld8.c
index a11586952d84..583a1bad8b74 100644
--- a/arch/arm/mach-uniphier/dram/umc-sld8.c
+++ b/arch/arm/mach-uniphier/dram/umc-sld8.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 #include <asm/processor.h>
 
diff --git a/arch/arm/mach-uniphier/memconf.c b/arch/arm/mach-uniphier/memconf.c
index 57192f0154aa..ab0d187a1faa 100644
--- a/arch/arm/mach-uniphier/memconf.c
+++ b/arch/arm/mach-uniphier/memconf.c
@@ -7,6 +7,7 @@
 
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 #include "sg-regs.h"
diff --git a/arch/arm/mach-uniphier/spl_board_init.c b/arch/arm/mach-uniphier/spl_board_init.c
index a93b8cdc04d2..0f2e3504c813 100644
--- a/arch/arm/mach-uniphier/spl_board_init.c
+++ b/arch/arm/mach-uniphier/spl_board_init.c
@@ -7,6 +7,7 @@
 #include <debug_uart.h>
 #include <hang.h>
 #include <spl.h>
+#include <linux/printk.h>
 
 #include "init.h"
 #include "micro-support-card.h"
diff --git a/arch/riscv/lib/smp.c b/arch/riscv/lib/smp.c
index 4f073a016ffd..f3cd8b9044a8 100644
--- a/arch/riscv/lib/smp.c
+++ b/arch/riscv/lib/smp.c
@@ -10,6 +10,7 @@
 #include <asm/barrier.h>
 #include <asm/global_data.h>
 #include <asm/smp.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/tangier/pinmux.c b/arch/x86/cpu/tangier/pinmux.c
index 7b2c35fbf794..23bfa7c18d2c 100644
--- a/arch/x86/cpu/tangier/pinmux.c
+++ b/arch/x86/cpu/tangier/pinmux.c
@@ -13,6 +13,7 @@
 #include <asm/cpu.h>
 #include <asm/scu.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 #define BUFCFG_OFFSET				0x100
 
diff --git a/arch/x86/cpu/tangier/sdram.c b/arch/x86/cpu/tangier/sdram.c
index ee74a1f0433c..374b262b1348 100644
--- a/arch/x86/cpu/tangier/sdram.c
+++ b/arch/x86/cpu/tangier/sdram.c
@@ -9,6 +9,7 @@
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/sfi.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index f9cfabe24209..341d095d689d 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -34,6 +34,7 @@
 #include <phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <remoteproc.h>
 #include <reset.h>
diff --git a/board/mediatek/mt8518/mt8518_ap1.c b/board/mediatek/mt8518/mt8518_ap1.c
index 2490b15ec78f..e03da63b1d92 100644
--- a/board/mediatek/mt8518/mt8518_ap1.c
+++ b/board/mediatek/mt8518/mt8518_ap1.c
@@ -8,6 +8,7 @@
 #include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/mscc/ocelot/ocelot.c b/board/mscc/ocelot/ocelot.c
index f261346b358d..d69db04de664 100644
--- a/board/mscc/ocelot/ocelot.c
+++ b/board/mscc/ocelot/ocelot.c
@@ -16,6 +16,7 @@
 #include <wait_bit.h>
 #include <miiphy.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/nvidia/jetson-tk1/jetson-tk1.c b/board/nvidia/jetson-tk1/jetson-tk1.c
index d349531261ed..7f3cdd70fe77 100644
--- a/board/nvidia/jetson-tk1/jetson-tk1.c
+++ b/board/nvidia/jetson-tk1/jetson-tk1.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/as3722.h>
 #include <power/pmic.h>
 
diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
index 516292aaa598..4ad780767ead 100644
--- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
+++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
@@ -12,6 +12,7 @@
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/misc.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define GRF_IO_VSEL_BT565_SHIFT 0
diff --git a/board/samsung/common/exynos5-dt.c b/board/samsung/common/exynos5-dt.c
index cde77d79a0f6..d585c4f3b100 100644
--- a/board/samsung/common/exynos5-dt.c
+++ b/board/samsung/common/exynos5-dt.c
@@ -26,6 +26,7 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
 #include <asm/arch/sromc.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/max77686_pmic.h>
 #include <power/regulator.h>
diff --git a/board/samsung/common/misc.c b/board/samsung/common/misc.c
index 5ffa216e2e5d..cc114aaaa6d3 100644
--- a/board/samsung/common/misc.c
+++ b/board/samsung/common/misc.c
@@ -10,6 +10,7 @@
 #include <libtizen.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <samsung/misc.h>
 #include <errno.h>
 #include <version.h>
diff --git a/board/samsung/goni/goni.c b/board/samsung/goni/goni.c
index 535f8e1e0129..c8f5a153bb47 100644
--- a/board/samsung/goni/goni.c
+++ b/board/samsung/goni/goni.c
@@ -13,6 +13,7 @@
 #include <asm/arch/mmc.h>
 #include <dm.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <usb/dwc2_udc.h>
 #include <asm/arch/cpu.h>
diff --git a/board/samsung/odroid/odroid.c b/board/samsung/odroid/odroid.c
index 39a60e4ad295..d237828364c6 100644
--- a/board/samsung/odroid/odroid.c
+++ b/board/samsung/odroid/odroid.c
@@ -15,6 +15,7 @@
 #include <asm/arch/cpu.h>
 #include <dm.h>
 #include <env.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/max77686_pmic.h>
diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index 1cf4a3d5fa1b..faee953cd4bb 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -14,6 +14,7 @@
 #include <mtd.h>
 #include <mtd_node.h>
 #include <asm/arch/stm32prog.h>
+#include <linux/printk.h>
 
 #define DFU_ALT_BUF_LEN SZ_1K
 
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 3205a31c6d0f..8f5719c28b33 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <usb/dwc2_udc.h>
 
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index de0f3505e528..ebaa94319846 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -33,6 +33,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #ifndef CONFIG_ARM64
 #include <asm/armv7.h>
 #endif
diff --git a/board/synopsys/hsdk/clk-lib.c b/board/synopsys/hsdk/clk-lib.c
index bd43179fc796..be76d6c8f471 100644
--- a/board/synopsys/hsdk/clk-lib.c
+++ b/board/synopsys/hsdk/clk-lib.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <dm/device.h>
+#include <linux/printk.h>
 
 #include "clk-lib.h"
 
diff --git a/board/synopsys/hsdk/env-lib.c b/board/synopsys/hsdk/env-lib.c
index fd54ac75f204..d85e8167332f 100644
--- a/board/synopsys/hsdk/env-lib.c
+++ b/board/synopsys/hsdk/env-lib.c
@@ -7,6 +7,7 @@
 #include "env-lib.h"
 #include <env.h>
 #include <log.h>
+#include <linux/printk.h>
 
 #define MAX_CMD_LEN	25
 
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index d52ac332f811..8bb13ef5b2b3 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -20,6 +20,7 @@
 #include <asm/omap_common.h>
 #include <env.h>
 #include <spl.h>
+#include <linux/printk.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index 9a53884c98e0..ac39b25cd426 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -19,6 +19,7 @@
 #include <mmc.h>
 #include <errno.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include "board_detect.h"
 
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 38fe447d8fac..d4f7c1d9f938 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -22,6 +22,7 @@
 #include <spl.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#include <linux/printk.h>
 
 #include "../common/board_detect.h"
 
diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index 86b10400ffac..851343159186 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -17,6 +17,7 @@
 #include <fdt_support.h>
 #include <pci_tegra.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/as3722.h>
 #include <power/pmic.h>
 
diff --git a/cmd/adc.c b/cmd/adc.c
index a739d9e46411..4cb18b66d4aa 100644
--- a/cmd/adc.c
+++ b/cmd/adc.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <dm.h>
 #include <adc.h>
+#include <linux/printk.h>
 
 static int do_adc_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index 3d5ff951eb63..f163b4069d81 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -14,6 +14,7 @@
 #include <net.h>
 #include <usb.h>
 #include <watchdog.h>
+#include <linux/printk.h>
 #include <linux/stringify.h>
 
 static int do_fastboot_udp(int argc, char *const argv[],
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 9e4ee4b0177b..f1579b654af4 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -36,6 +36,7 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <u-boot/crc.h>
 #include <linux/stddef.h>
 #include <asm/byteorder.h>
diff --git a/cmd/onenand.c b/cmd/onenand.c
index d633f19d3bb2..72f491cf8f56 100644
--- a/cmd/onenand.c
+++ b/cmd/onenand.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <command.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
diff --git a/cmd/regulator.c b/cmd/regulator.c
index 8988c9010877..635a9add5856 100644
--- a/cmd/regulator.c
+++ b/cmd/regulator.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define LIMIT_DEVNAME	20
diff --git a/cmd/thordown.c b/cmd/thordown.c
index 838764ccef79..0981c309a179 100644
--- a/cmd/thordown.c
+++ b/cmd/thordown.c
@@ -12,6 +12,7 @@
 #include <dfu.h>
 #include <g_dnl.h>
 #include <usb.h>
+#include <linux/printk.h>
 
 int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index 9bdc9c660fd0..c7fa6e775f55 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <tpm-v1.h>
+#include <linux/printk.h>
 #include "tpm-user-utils.h"
 #include <tpm_api.h>
 
diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
index 1af82e113665..651a3ebcb5d4 100644
--- a/cmd/usb_gadget_sdp.c
+++ b/cmd/usb_gadget_sdp.c
@@ -11,6 +11,7 @@
 #include <g_dnl.h>
 #include <sdp.h>
 #include <usb.h>
+#include <linux/printk.h>
 
 static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index c3cc1975f9d8..9afb3bc54393 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -18,6 +18,7 @@
 #include <usb_mass_storage.h>
 #include <watchdog.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 static int ums_read_sector(struct ums *ums_dev,
 			   ulong start, lbaint_t blkcnt, void *buf)
diff --git a/common/dfu.c b/common/dfu.c
index 96190889ab77..7391067fe86b 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -19,6 +19,7 @@
 #include <g_dnl.h>
 #include <usb.h>
 #include <net.h>
+#include <linux/printk.h>
 
 int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 {
diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
index 5728d43ad3f2..8a779da8fa1e 100644
--- a/common/spl/spl_dfu.c
+++ b/common/spl/spl_dfu.c
@@ -15,6 +15,7 @@
 #include <g_dnl.h>
 #include <usb.h>
 #include <dfu.h>
+#include <linux/printk.h>
 
 static int run_dfu(int usb_index, char *interface, char *devstring)
 {
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f7562c..cd73b2565658 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -17,6 +17,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index b0f40076c345..9e98a566f894 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -15,6 +15,7 @@
 #include <asm/smp.h>
 #include <opensbi.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
index cc4fb4f7cca2..c28bfdf4173d 100644
--- a/common/spl/spl_sdp.c
+++ b/common/spl/spl_sdp.c
@@ -10,6 +10,7 @@
 #include <usb.h>
 #include <g_dnl.h>
 #include <sdp.h>
+#include <linux/printk.h>
 
 static int spl_sdp_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
diff --git a/common/update.c b/common/update.c
index 3502713d7d83..ec302ca68fb0 100644
--- a/common/update.c
+++ b/common/update.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <image.h>
+#include <linux/printk.h>
 
 #include <command.h>
 #include <env.h>
diff --git a/disk/part_efi.c b/disk/part_efi.c
index 39382c5faee0..afe6aef4d768 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -29,6 +29,7 @@
 #include <dm/ofnode.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/printk.h>
 #include <u-boot/crc.h>
 
 /* GUID for basic data partitons */
diff --git a/drivers/adc/adc-uclass.c b/drivers/adc/adc-uclass.c
index 6074eccbf097..1b35bf22014f 100644
--- a/drivers/adc/adc-uclass.c
+++ b/drivers/adc/adc-uclass.c
@@ -15,6 +15,7 @@
 #include <dm/uclass-internal.h>
 #include <adc.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define ADC_UCLASS_PLATDATA_SIZE	sizeof(struct adc_uclass_plat)
diff --git a/drivers/adc/exynos-adc.c b/drivers/adc/exynos-adc.c
index 65898170858d..2bda733af90d 100644
--- a/drivers/adc/exynos-adc.c
+++ b/drivers/adc/exynos-adc.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <adc.h>
 #include <asm/arch/adc.h>
+#include <linux/printk.h>
 
 struct exynos_adc_priv {
 	int active_channel;
diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 37023512f0d4..c15c7fea47fe 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/math64.h>
 #include <linux/bitfield.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define MESON_SAR_ADC_REG0					0x00
diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 809486eba27d..03caca78b5f2 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define SARADC_CTRL_CHN_MASK		GENMASK(2, 0)
diff --git a/drivers/adc/sandbox.c b/drivers/adc/sandbox.c
index 6e435462ab85..43cad34ffebf 100644
--- a/drivers/adc/sandbox.c
+++ b/drivers/adc/sandbox.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <adc.h>
 #include <sandbox-adc.h>
+#include <linux/printk.h>
 
 /**
  * struct sandbox_adc_priv - sandbox ADC device's operation status and data
diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 1dc91e7fce70..15fd3e365b2b 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -18,6 +18,7 @@
 #endif
 #include <asm/io.h>
 #include <generic-phy.h>
+#include <linux/printk.h>
 
 struct dwc_ahci_priv {
 	void *base;
diff --git a/drivers/bios_emulator/include/x86emu/debug.h b/drivers/bios_emulator/include/x86emu/debug.h
index 4962a2acaf1c..859b54d86000 100644
--- a/drivers/bios_emulator/include/x86emu/debug.h
+++ b/drivers/bios_emulator/include/x86emu/debug.h
@@ -43,6 +43,7 @@
 
 /* checks to be enabled for "runtime" */
 
+#include <linux/printk.h>
 #define CHECK_IP_FETCH_F		0x1
 #define CHECK_SP_ACCESS_F		0x2
 #define CHECK_MEM_ACCESS_F		0x4	/*using regular linear pointer */
diff --git a/drivers/bios_emulator/include/x86emu/regs.h b/drivers/bios_emulator/include/x86emu/regs.h
index 29341297d966..4b4c59089239 100644
--- a/drivers/bios_emulator/include/x86emu/regs.h
+++ b/drivers/bios_emulator/include/x86emu/regs.h
@@ -41,6 +41,7 @@
 
 /*---------------------- Macros and type definitions ----------------------*/
 
+#include <linux/printk.h>
 #pragma pack(1)
 
 /*
diff --git a/drivers/bios_emulator/x86emu/debug.c b/drivers/bios_emulator/x86emu/debug.c
index 27e90e441aa4..95f3cc09aad5 100644
--- a/drivers/bios_emulator/x86emu/debug.c
+++ b/drivers/bios_emulator/x86emu/debug.c
@@ -40,6 +40,7 @@
 #include <stdarg.h>
 #include <common.h>
 #include <linux/ctype.h>
+#include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
 /*----------------------------- Implementation ----------------------------*/
diff --git a/drivers/bios_emulator/x86emu/decode.c b/drivers/bios_emulator/x86emu/decode.c
index a9a01b52d6cd..e2028eaf0833 100644
--- a/drivers/bios_emulator/x86emu/decode.c
+++ b/drivers/bios_emulator/x86emu/decode.c
@@ -37,6 +37,7 @@
 *
 ****************************************************************************/
 #include <common.h>
+#include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
 /*----------------------------- Implementation ----------------------------*/
diff --git a/drivers/bios_emulator/x86emu/ops.c b/drivers/bios_emulator/x86emu/ops.c
index ba18135fe13c..8c1a146165c9 100644
--- a/drivers/bios_emulator/x86emu/ops.c
+++ b/drivers/bios_emulator/x86emu/ops.c
@@ -73,6 +73,7 @@
 ****************************************************************************/
 
 #include <common.h>
+#include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
 /*----------------------------- Implementation ----------------------------*/
diff --git a/drivers/bios_emulator/x86emu/ops2.c b/drivers/bios_emulator/x86emu/ops2.c
index be4ef3644320..6cd1ac398252 100644
--- a/drivers/bios_emulator/x86emu/ops2.c
+++ b/drivers/bios_emulator/x86emu/ops2.c
@@ -43,6 +43,7 @@
 
 #include <common.h>
 #include <linux/compiler.h>
+#include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
 /*----------------------------- Implementation ----------------------------*/
diff --git a/drivers/bios_emulator/x86emu/sys.c b/drivers/bios_emulator/x86emu/sys.c
index 882a8a34cc3e..f96652415cd3 100644
--- a/drivers/bios_emulator/x86emu/sys.c
+++ b/drivers/bios_emulator/x86emu/sys.c
@@ -40,6 +40,7 @@
 ****************************************************************************/
 
 #include <common.h>
+#include <linux/printk.h>
 #include "x86emu/x86emui.h"
 
 /*------------------------- Global Variables ------------------------------*/
diff --git a/drivers/bootcount/bootcount-uclass.c b/drivers/bootcount/bootcount-uclass.c
index c747c9ab276b..5a369c82f1c5 100644
--- a/drivers/bootcount/bootcount-uclass.c
+++ b/drivers/bootcount/bootcount-uclass.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <bootcount.h>
 #include <log.h>
+#include <linux/printk.h>
 
 int dm_bootcount_get(struct udevice *dev, u32 *bootcount)
 {
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 776ead319ae9..a3cb109d3575 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -26,6 +26,7 @@
 #include <linux/log2.h>
 #include <linux/math64.h>
 #include <linux/clk/analogbits-wrpll-cln28hpc.h>
+#include <linux/printk.h>
 
 /* MIN_INPUT_FREQ: minimum input clock frequency, in Hz (Fref_min) */
 #define MIN_INPUT_FREQ			7000000
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 6ab137a72bef..2ad682b8fe2c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -28,6 +28,7 @@
 #include <linux/log2.h>
 #include <div64.h>
 #include <clk.h>
+#include <linux/printk.h>
 #include "clk.h"
 
 #define UBOOT_DM_CLK_CCF_DIVIDER "ccf_clk_divider"
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index a8775c77dc2e..cfd90b717e73 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/clk-hsdk-cgu.c b/drivers/clk/clk-hsdk-cgu.c
index e28543ef78b4..85074f1b86e8 100644
--- a/drivers/clk/clk-hsdk-cgu.c
+++ b/drivers/clk/clk-hsdk-cgu.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <asm/arcregs.h>
+#include <linux/printk.h>
 
 #include <dt-bindings/clock/snps,hsdk-cgu.h>
 
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 017f25f7a5a3..f410518461e9 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -36,6 +36,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
index 2e81777b7037..4bcf91175512 100644
--- a/drivers/clk/clk_boston.c
+++ b/drivers/clk/clk_boston.c
@@ -10,6 +10,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 struct clk_boston {
 	struct regmap *regmap;
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index b93c0bc64e72..1cb685ee9abd 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -18,6 +18,7 @@
 #include <linux/iopoll.h>
 #include <clk.h>
 #include <div64.h>
+#include <linux/printk.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index a47c431cf5f7..3406ff592e17 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -23,6 +23,7 @@
 #include <dm/lists.h>
 #include <dt-bindings/clock/rk3368-cru.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/stringify.h>
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index f748fb5189e0..c37e8a53a268 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -24,6 +24,7 @@
 #include <dt-bindings/clock/rk3399-cru.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/device.c b/drivers/core/device.c
index 60f8d6700ad4..bf7f261cbce0 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -33,6 +33,7 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <power-domain.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
index 431dd4e565d5..b3b3d7ccdd56 100644
--- a/drivers/core/of_addr.c
+++ b/drivers/core/of_addr.c
@@ -14,6 +14,7 @@
 #include <dm/of_addr.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
+#include <linux/printk.h>
 
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 79d871ab291a..2cc6b17d4cc2 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -29,6 +29,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/util.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index b2ee5f1ede6d..2adf26e2fe24 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -17,6 +17,7 @@
 #include <hash.h>
 #include <linux/list.h>
 #include <linux/compiler.h>
+#include <linux/printk.h>
 
 LIST_HEAD(dfu_list);
 static int dfu_alt_num;
diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index f5832083ba1a..cdb3c18b01db 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -17,6 +17,7 @@
 #include <mmc.h>
 #include <part.h>
 #include <command.h>
+#include <linux/printk.h>
 
 static unsigned char *dfu_file_buf;
 static u64 dfu_file_buf_len;
diff --git a/drivers/dfu/dfu_ram.c b/drivers/dfu/dfu_ram.c
index 9d10303164e2..c4f4bd2e482f 100644
--- a/drivers/dfu/dfu_ram.c
+++ b/drivers/dfu/dfu_ram.c
@@ -13,6 +13,7 @@
 #include <mapmem.h>
 #include <errno.h>
 #include <dfu.h>
+#include <linux/printk.h>
 
 static int dfu_transfer_medium_ram(enum dfu_op op, struct dfu_entity *dfu,
 				   u64 offset, void *buf, long *len)
diff --git a/drivers/dma/bcm6348-iudma.c b/drivers/dma/bcm6348-iudma.c
index 4fc650272d9e..d4cfe0c18681 100644
--- a/drivers/dma/bcm6348-iudma.c
+++ b/drivers/dma/bcm6348-iudma.c
@@ -28,6 +28,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #define DMA_RX_DESC	6
 #define DMA_TX_DESC	1
diff --git a/drivers/dma/dma-uclass.c b/drivers/dma/dma-uclass.c
index 34f72fa5dc88..0c1d88e10c65 100644
--- a/drivers/dma/dma-uclass.c
+++ b/drivers/dma/dma-uclass.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <dt-structs.h>
 #include <errno.h>
+#include <linux/printk.h>
 
 #ifdef CONFIG_DMA_CHANNELS
 static inline struct dma_ops *dma_dev_ops(struct udevice *dev)
diff --git a/drivers/dma/lpc32xx_dma.c b/drivers/dma/lpc32xx_dma.c
index ab58e97bfe27..0efdfd028cfd 100644
--- a/drivers/dma/lpc32xx_dma.c
+++ b/drivers/dma/lpc32xx_dma.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 /* DMA controller channel register structure */
 struct dmac_chan_reg {
diff --git a/drivers/dma/sandbox-dma-test.c b/drivers/dma/sandbox-dma-test.c
index 2b8259a35b4d..a19e5e37fb9d 100644
--- a/drivers/dma/sandbox-dma-test.c
+++ b/drivers/dma/sandbox-dma-test.c
@@ -15,6 +15,7 @@
 #include <dma-uclass.h>
 #include <dt-structs.h>
 #include <errno.h>
+#include <linux/printk.h>
 
 #define SANDBOX_DMA_CH_CNT 3
 #define SANDBOX_DMA_BUF_SIZE 1024
diff --git a/drivers/dma/ti-edma3.c b/drivers/dma/ti-edma3.c
index 1ad3b92dbf48..31ffff07f5b3 100644
--- a/drivers/dma/ti-edma3.c
+++ b/drivers/dma/ti-edma3.c
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/omap_common.h>
 #include <asm/ti-common/ti-edma3.h>
+#include <linux/printk.h>
 
 #define EDMA3_SL_BASE(slot)			(0x4000 + ((slot) << 5))
 #define EDMA3_SL_MAX_NUM			512
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 05c3a4311ced..4f2effd39a80 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/bitmap.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <linux/soc/ti/k3-navss-ringacc.h>
 #include <linux/soc/ti/cppi5.h>
 #include <linux/soc/ti/ti-udma.h>
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 71cfaec6e9dc..5fcadcdf503d 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -12,6 +12,7 @@
 #include <fb_nand.h>
 #include <part.h>
 #include <stdlib.h>
+#include <linux/printk.h>
 
 /**
  * image_size - final fastboot image size
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index d9f0f07b2bcd..8cb8ffa2c6c8 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -12,6 +12,7 @@
 #include <fs.h>
 #include <part.h>
 #include <version.h>
+#include <linux/printk.h>
 
 static void getvar_version(char *var_parameter, char *response);
 static void getvar_version_bootloader(char *var_parameter, char *response);
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 060918e49109..62e4267344fb 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -18,6 +18,7 @@
 #include <div64.h>
 #include <linux/compat.h>
 #include <android_image.h>
+#include <linux/printk.h>
 
 #define BOOT_PARTITION_NAME "boot"
 
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index 6d3a900c7728..bbe26ddcc9be 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -11,6 +11,7 @@
 #include <fastboot.h>
 #include <image-sparse.h>
 
+#include <linux/printk.h>
 #include <linux/mtd/mtd.h>
 #include <jffs2/jffs2.h>
 #include <nand.h>
diff --git a/drivers/i2c/i2c-gpio.c b/drivers/i2c/i2c-gpio.c
index c1fc290bd253..5fc3cfe42ef7 100644
--- a/drivers/i2c/i2c-gpio.c
+++ b/drivers/i2c/i2c-gpio.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #define DEFAULT_UDELAY	5
 #define RETRIES		0
diff --git a/drivers/i2c/iproc_i2c.c b/drivers/i2c/iproc_i2c.c
index d975e782649a..39af49c4ec54 100644
--- a/drivers/i2c/iproc_i2c.c
+++ b/drivers/i2c/iproc_i2c.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <config.h>
 #include <dm.h>
+#include <linux/printk.h>
 #include "errno.h"
 #include <i2c.h>
 #include "iproc_i2c.h"
diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index c656cf8b7a13..6fc9d1eba9d1 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -43,6 +43,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 #include <asm/omap_i2c.h>
diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index 836148e4c1a0..b6c71789eec0 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 /* STM32 I2C registers */
 struct stm32_i2c_regs {
diff --git a/drivers/i2c/tegra_i2c.c b/drivers/i2c/tegra_i2c.c
index 5864a1ad5bce..57d77d56ea55 100644
--- a/drivers/i2c/tegra_i2c.c
+++ b/drivers/i2c/tegra_i2c.c
@@ -21,6 +21,7 @@
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 enum i2c_type {
 	TYPE_114,
diff --git a/drivers/misc/sifive-otp.c b/drivers/misc/sifive-otp.c
index 3e658b356629..a624a358802c 100644
--- a/drivers/misc/sifive-otp.c
+++ b/drivers/misc/sifive-otp.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <misc.h>
+#include <linux/printk.h>
 
 #define BYTES_PER_FUSE		4
 
diff --git a/drivers/misc/tegra186_bpmp.c b/drivers/misc/tegra186_bpmp.c
index dbee7f77db3f..fecac9c4d902 100644
--- a/drivers/misc/tegra186_bpmp.c
+++ b/drivers/misc/tegra186_bpmp.c
@@ -17,6 +17,7 @@
 #include <asm/arch-tegra/ivc.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #define BPMP_IVC_FRAME_COUNT 1
 #define BPMP_IVC_FRAME_SIZE 128
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 544798bb71d1..2f849c43b129 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -16,6 +16,7 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch/power.h>
 #include <asm/gpio.h>
+#include <linux/printk.h>
 
 #define	DWMMC_MAX_CH_NUM		4
 #define	DWMMC_MAX_FREQ			52000000
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 66caf683f741..7c39c86c5e9c 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -26,6 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <malloc.h>
 #include <fsl_esdhc_imx.h>
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 089a0442568c..d96db7a0f836 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -19,6 +19,7 @@
 #include <part.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index b206b0a08585..d21a30c9543e 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 
 /* MSDC_CFG */
 #define MSDC_CFG_HS400_CK_MODE_EXT	BIT(22)
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 9cbe126106c5..fc9c6c379964 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/printk.h>
 #include <phys2bus.h>
 #include <power/regulator.h>
 
diff --git a/drivers/mmc/sti_sdhci.c b/drivers/mmc/sti_sdhci.c
index 6194768fd727..23a1dd43c9b2 100644
--- a/drivers/mmc/sti_sdhci.c
+++ b/drivers/mmc/sti_sdhci.c
@@ -12,6 +12,7 @@
 #include <sdhci.h>
 #include <asm/arch/sdhci.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
index b68594de3732..5ff5e1a4d8b5 100644
--- a/drivers/mmc/stm32_sdmmc2.c
+++ b/drivers/mmc/stm32_sdmmc2.c
@@ -27,6 +27,7 @@
 #include <linux/iopoll.h>
 #include <power/regulator.h>
 #include <watchdog.h>
+#include <linux/printk.h>
 
 struct stm32_sdmmc2_plat {
 	struct mmc_config cfg;
diff --git a/drivers/mmc/xenon_sdhci.c b/drivers/mmc/xenon_sdhci.c
index 16ac84a24a63..27dbe0404e04 100644
--- a/drivers/mmc/xenon_sdhci.c
+++ b/drivers/mmc/xenon_sdhci.c
@@ -23,6 +23,7 @@
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <sdhci.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index af3c4765c4df..51232581d966 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -23,6 +23,7 @@
 #include <div64.h>
 #include <linux/bug.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 #endif
 
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index aa78d41a55e6..4a096b3b57d6 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -30,6 +30,7 @@
 #include <linux/bug.h>
 #include <linux/err.h>
 #include <ubi_uboot.h>
+#include <linux/printk.h>
 #endif
 
 #include <linux/log2.h>
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 4886392a1cfa..d4994c6810df 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/compat.h>
 #include <ubi_uboot.h>
+#include <linux/printk.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 294daee7b224..972aec6e2666 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -16,6 +16,7 @@
 #ifndef __UBOOT__
 #include <linux/slab.h>
 #endif
+#include <linux/printk.h>
 
 /**
  * nanddev_bbt_init() - Initialize the BBT (Bad Block Table)
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 4b9dd6a92694..f6d9c584f786 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -17,6 +17,7 @@
 #endif
 #include <linux/bitops.h>
 #include <linux/mtd/nand.h>
+#include <linux/printk.h>
 
 /**
  * nanddev_isbad() - Check if a block is bad
diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 587941290dcc..14766401bf68 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -18,6 +18,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
 #include <nand.h>
+#include <linux/printk.h>
 
 struct nand_config {
 	u32 page;
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index b7e473c598d0..6b17e744a692 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <malloc.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
index aa095c439ba1..4e6d99fd3ca4 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "brcmnand.h"
 
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
index e4bf1936810a..6164989b9378 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "brcmnand.h"
 
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
index 586ea3d8fbb4..dbd85af7079d 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "brcmnand.h"
 
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
index 85f318bd779a..ef3649688c66 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "brcmnand.h"
 
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
index a5e159ad521f..027fdd37da3b 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "brcmnand.h"
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index e4e144bd7c83..71bbb8231bfb 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -35,6 +35,7 @@
 #include <nand.h>
 #include <dm/uclass.h>
 #include <asm/ti-common/davinci_nand.h>
+#include <linux/printk.h>
 
 /* Definitions for 4-bit hardware ECC */
 #define NAND_TIMEOUT			10240
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index 285411776096..ac2e669d46b3 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -28,6 +28,7 @@
 #include <nand.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/sys_proto.h>
+#include <linux/printk.h>
 
 /*
  * MLC NAND controller registers.
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
index 356f8d9440bb..b21a0b9d293f 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
@@ -23,6 +23,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/cpu.h>
+#include <linux/printk.h>
 
 struct lpc32xx_nand_slc_regs {
 	u32 data;
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 051ded6a240a..dbdc5b0bca1c 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -15,6 +15,7 @@
 #if defined(CONFIG_MX51) || defined(CONFIG_MX53)
 #include <asm/arch/imx-regs.h>
 #endif
+#include <linux/printk.h>
 #include "mxc_nand.h"
 
 #define DRIVER_NAME "mxc_nand"
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b4adcf6bdc9..6e067163f47a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -47,6 +47,7 @@
 #endif
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <linux/printk.h>
 
 /* Define default oob placement schemes for large and small page devices */
 #ifndef CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index cd451870a6f9..84a36f3a57b9 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -67,6 +67,7 @@
 #include <linux/mtd/bbm.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <linux/string.h>
 
 #define BBT_BLOCK_GOOD		0x00
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index 734d1c6204eb..bb48ebbb96c7 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <log.h>
 #include <dm/devres.h>
+#include <linux/printk.h>
 /*#include <asm/io.h>*/
 #include <linux/types.h>
 
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index d502e967f92c..1d9a6d107b17 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -22,6 +22,7 @@
 #include <asm/arch/cpu.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/printk.h>
 #include <linux/types.h>
 #include <syscon.h>
 #include <regmap.h>
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 69dbb629e931..64be6486b4e0 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -21,6 +21,7 @@
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/mtd/rawnand.h>
+#include <linux/printk.h>
 
 /* Bad block marker length */
 #define FMC2_BBM_LEN			2
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c0fa1e310c66..0b5b74dc242d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -36,6 +36,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 #include <linux/kernel.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 139d978a49b3..6086ecdfa3db 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -24,6 +24,7 @@
 #include <fdtdec.h>
 #include <bouncebuf.h>
 #include <dm.h>
+#include <linux/printk.h>
 #include "tegra_nand.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index d4b40e810f08..d2363a0662e2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -24,6 +24,7 @@
 #include <common.h>
 #include <malloc.h>
 #include <dm/device_compat.h>
+#include <linux/printk.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 545fdd7b6973..bacaf13c570d 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -21,6 +21,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 /* The NAND flash driver defines */
 #define ZYNQ_NAND_CMD_PHASE		1
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 70d8ae531eeb..4ee11e812d84 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -30,6 +30,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
+#include <linux/printk.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 08fe7d427acf..762b01c1b0f0 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -26,6 +26,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
+#include <linux/printk.h>
 #include "linux/mtd/flashchip.h"
 #include <linux/mtd/onenand.h>
 
diff --git a/drivers/mtd/onenand/onenand_bbt.c b/drivers/mtd/onenand/onenand_bbt.c
index eca9edff6039..cc1e449f4a72 100644
--- a/drivers/mtd/onenand/onenand_bbt.c
+++ b/drivers/mtd/onenand/onenand_bbt.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include <linux/errno.h>
 
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 657abaab8f41..c415e5149a01 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/samsung_onenand.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 #include <linux/errno.h>
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6093277f1713..db20feb4daed 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 7aa24e129f96..0719fe845ca9 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index e488caa5547b..2ef8fde3d324 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -81,6 +81,7 @@
 #include <div64.h>
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #endif
 
 #include <linux/math64.h>
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 3ac0b1940283..a1941b8eb88e 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -33,6 +33,7 @@
 #else
 #include <linux/bug.h>
 #include <linux/log2.h>
+#include <linux/printk.h>
 #endif
 #include <linux/err.h>
 #include <ubi_uboot.h>
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index d2b7ca5e33fd..b119cb6e9c05 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -8,6 +8,7 @@
 #include <hexdump.h>
 #include <malloc.h>
 #include <ubi_uboot.h>
+#include <linux/printk.h>
 #include "ubi.h"
 #ifndef __UBOOT__
 #include <linux/debugfs.h>
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index 9c8ce51636b1..2e13ebb2fb75 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -17,6 +17,7 @@ void ubi_dump_vid_hdr(const struct ubi_vid_hdr *vid_hdr);
 #endif
 
 #include <hexdump.h>
+#include <linux/printk.h>
 
 #ifndef __UBOOT__
 #define ubi_assert(expr)  do {                                               \
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index f44960186bbd..175988899c39 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -28,6 +28,7 @@
 #include <asm/pgtable.h>
 #else
 #include <ubi_uboot.h>
+#include <linux/printk.h>
 #endif
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/ubi.h>
diff --git a/drivers/net/bcm-sf2-eth-gmac.c b/drivers/net/bcm-sf2-eth-gmac.c
index 3caf0f33109b..cbe1e85222fa 100644
--- a/drivers/net/bcm-sf2-eth-gmac.c
+++ b/drivers/net/bcm-sf2-eth-gmac.c
@@ -6,6 +6,7 @@
 #ifdef BCM_GMAC_DEBUG
 #ifndef DEBUG
 #define DEBUG
+#include <linux/printk.h>
 #endif
 #endif
 
diff --git a/drivers/net/bcm-sf2-eth.c b/drivers/net/bcm-sf2-eth.c
index 88dc3ab38466..1524f5c99890 100644
--- a/drivers/net/bcm-sf2-eth.c
+++ b/drivers/net/bcm-sf2-eth.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <config.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <phy.h>
 #include <miiphy.h>
diff --git a/drivers/net/bcm6348-eth.c b/drivers/net/bcm6348-eth.c
index 53171736117c..72dcd07d30dd 100644
--- a/drivers/net/bcm6348-eth.c
+++ b/drivers/net/bcm6348-eth.c
@@ -18,6 +18,7 @@
 #include <reset.h>
 #include <wait_bit.h>
 #include <asm/io.h>
+#include <linux/printk.h>
 
 #define ETH_RX_DESC			PKTBUFSRX
 #define ETH_MAX_MTU_SIZE		1518
diff --git a/drivers/net/bcm6368-eth.c b/drivers/net/bcm6368-eth.c
index c2a8b9f05765..fdd938ce0dd8 100644
--- a/drivers/net/bcm6368-eth.c
+++ b/drivers/net/bcm6368-eth.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #define ETH_PORT_STR			"brcm,enetsw-port"
 
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index e09ca3313dd3..20b86e74cecf 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -29,6 +29,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include "designware.h"
 
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 1e92bd9ca9c0..9b1a9e69bf88 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -52,6 +52,7 @@
 #include <asm/mach-imx/sys_proto.h>
 #endif
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include "dwc_eth_qos.h"
 
diff --git a/drivers/net/fsl-mc/dpio/qbman_sys.h b/drivers/net/fsl-mc/dpio/qbman_sys.h
index ff998d49dc4c..1c6e48913028 100644
--- a/drivers/net/fsl-mc/dpio/qbman_sys.h
+++ b/drivers/net/fsl-mc/dpio/qbman_sys.h
@@ -21,6 +21,7 @@
 /* Trace the 3 different classes of read/write access to QBMan. #undef as
  * required. */
 #include <linux/bug.h>
+#include <linux/printk.h>
 #undef QBMAN_CCSR_TRACE
 #undef QBMAN_CINH_TRACE
 #undef QBMAN_CENA_TRACE
diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index a50cde338a2a..587d3658fa9f 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -25,6 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 
 #include "ftgmac100.h"
 
diff --git a/drivers/net/mscc_eswitch/jr2_switch.c b/drivers/net/mscc_eswitch/jr2_switch.c
index 1462b8f3bc8d..7157428a685e 100644
--- a/drivers/net/mscc_eswitch/jr2_switch.c
+++ b/drivers/net/mscc_eswitch/jr2_switch.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 #include <dt-bindings/mscc/jr2_data.h>
 #include "mscc_xfer.h"
diff --git a/drivers/net/mscc_eswitch/ocelot_switch.c b/drivers/net/mscc_eswitch/ocelot_switch.c
index 1bf6c42c0fc5..7ea1f551a11a 100644
--- a/drivers/net/mscc_eswitch/ocelot_switch.c
+++ b/drivers/net/mscc_eswitch/ocelot_switch.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 #include "mscc_xfer.h"
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/serval_switch.c b/drivers/net/mscc_eswitch/serval_switch.c
index 38ddba12b664..be06e4833733 100644
--- a/drivers/net/mscc_eswitch/serval_switch.c
+++ b/drivers/net/mscc_eswitch/serval_switch.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 #include "mscc_xfer.h"
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/servalt_switch.c b/drivers/net/mscc_eswitch/servalt_switch.c
index db863c2a9fff..2d2329c204ae 100644
--- a/drivers/net/mscc_eswitch/servalt_switch.c
+++ b/drivers/net/mscc_eswitch/servalt_switch.c
@@ -16,6 +16,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 #include "mscc_xfer.h"
 #include "mscc_miim.h"
diff --git a/drivers/net/mt7628-eth.c b/drivers/net/mt7628-eth.c
index 0a9bdb3ddbd6..b95de474fb02 100644
--- a/drivers/net/mt7628-eth.c
+++ b/drivers/net/mt7628-eth.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 /* Ethernet frame engine register */
 #define PDMA_RELATED		0x0800
diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index d4111e73df1d..3cfce058451d 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -26,6 +26,7 @@
 #include <linux/ioport.h>
 #include <linux/mdio.h>
 #include <linux/mii.h>
+#include <linux/printk.h>
 
 #include "mtk_eth.h"
 
diff --git a/drivers/net/mvmdio.c b/drivers/net/mvmdio.c
index c0ebcdb1f68a..5ebcfe14b7fb 100644
--- a/drivers/net/mvmdio.c
+++ b/drivers/net/mvmdio.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <wait_bit.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 #define MVMDIO_SMI_DATA_SHIFT		0
 #define MVMDIO_SMI_PHY_ADDR_SHIFT	16
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 7111e36aa0d0..b6726031ebb8 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include <dm.h>
 #include <dt-bindings/net/ti-dp83867.h>
diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index ef1761a8bda9..bd9cd9529759 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 /* Microsemi PHY ID's */
 #define PHY_ID_VSC8530                  0x00070560
diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 963702777c23..93e83661cec4 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -51,6 +51,7 @@
 #include <asm/io.h>
 #include <pci.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #undef DEBUG_RTL8169
 #undef DEBUG_RTL8169_TX
diff --git a/drivers/net/sni_ave.c b/drivers/net/sni_ave.c
index f5a0d80af7a4..8eeecbc4cf3b 100644
--- a/drivers/net/sni_ave.c
+++ b/drivers/net/sni_ave.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 
 #define AVE_GRST_DELAY_MSEC	40
 #define AVE_MIN_XMITSIZE	60
diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index f4e58093805d..18a33c4c0e3c 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -28,6 +28,7 @@
 #include <syscon.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/soc/ti/ti-udma.h>
 
 #include "cpsw_mdio.h"
diff --git a/drivers/net/ti/cpsw-common.c b/drivers/net/ti/cpsw-common.c
index 3140f2515fbf..d5428274d190 100644
--- a/drivers/net/ti/cpsw-common.c
+++ b/drivers/net/ti/cpsw-common.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <cpsw.h>
 #include <dm/device_compat.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 3a8cc9c52a51..877be7fca52d 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -24,6 +24,7 @@
 #include <phy.h>
 #include <asm/arch/cpu.h>
 #include <dm.h>
+#include <linux/printk.h>
 
 #include "cpsw_mdio.h"
 
diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
index 89b04b6fbdae..43dbf3f10670 100644
--- a/drivers/net/ti/keystone_net.c
+++ b/drivers/net/ti/keystone_net.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <dm.h>
 #include <dm/lists.h>
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 0adcdceb1d34..ae7350aaff98 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -24,6 +24,7 @@
 #endif
 #include <dt-bindings/pci/pci.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include "pci_internal.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
index 93a7508d8a2a..3697cd8d6521 100644
--- a/drivers/pci/pci_mvebu.c
+++ b/drivers/pci/pci_mvebu.c
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/mbus.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 /* PCIe unit register offsets */
diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
index 29d54117e939..131c21b7684e 100644
--- a/drivers/pci/pci_tegra.c
+++ b/drivers/pci/pci_tegra.c
@@ -22,6 +22,7 @@
 #include <power-domain.h>
 #include <reset.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/drivers/pci/pcie_ecam_generic.c b/drivers/pci/pcie_ecam_generic.c
index 1a9f9aec2ee1..2e089b0e0332 100644
--- a/drivers/pci/pcie_ecam_generic.c
+++ b/drivers/pci/pcie_ecam_generic.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <pci.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 
diff --git a/drivers/pci/pcie_fsl.c b/drivers/pci/pcie_fsl.c
index 8d89a1e5919c..ec917ee7d5b8 100644
--- a/drivers/pci/pcie_fsl.c
+++ b/drivers/pci/pcie_fsl.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include "pcie_fsl.h"
 #include <dm/device_compat.h>
 
diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
index c6e30e246227..ed25a10bcf0f 100644
--- a/drivers/pci/pcie_mediatek.c
+++ b/drivers/pci/pcie_mediatek.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 #include "pci_internal.h"
 
 /* PCIe shared registers */
diff --git a/drivers/pci/pcie_phytium.c b/drivers/pci/pcie_phytium.c
index a80727625428..3bd1f5cd6d91 100644
--- a/drivers/pci/pcie_phytium.c
+++ b/drivers/pci/pcie_phytium.c
@@ -12,6 +12,7 @@
 #include <pci.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/printk.h>
 
 /**
  * struct phytium_pcie - phytium PCIe controller state
diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index eb9ec97b74f3..53fd121e905c 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -10,6 +10,7 @@
 #include <pci.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 
diff --git a/drivers/phy/keystone-usb-phy.c b/drivers/phy/keystone-usb-phy.c
index 12f8a265f772..6799e2323707 100644
--- a/drivers/phy/keystone-usb-phy.c
+++ b/drivers/phy/keystone-usb-phy.c
@@ -13,6 +13,7 @@
 #include <asm/arch/psc_defs.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 /* USB PHY control register offsets */
 #define USB_PHY_CTL_UTMI		0x0000
diff --git a/drivers/phy/marvell/comphy_cp110.c b/drivers/phy/marvell/comphy_cp110.c
index a7e0099045ff..bb15fbaf347e 100644
--- a/drivers/phy/marvell/comphy_cp110.c
+++ b/drivers/phy/marvell/comphy_cp110.c
@@ -12,6 +12,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include "comphy_core.h"
 #include "sata.h"
diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 650b88bd1803..8b2432251561 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -17,6 +17,7 @@
 #include <generic-phy.h>
 #include <regmap.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <reset.h>
 #include <clk.h>
diff --git a/drivers/phy/meson-g12a-usb3-pcie.c b/drivers/phy/meson-g12a-usb3-pcie.c
index 8f72b5a6a74b..40a5da948dc1 100644
--- a/drivers/phy/meson-g12a-usb3-pcie.c
+++ b/drivers/phy/meson-g12a-usb3-pcie.c
@@ -18,6 +18,7 @@
 #include <bitfield.h>
 #include <generic-phy.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <linux/bitops.h>
 #include <linux/compat.h>
diff --git a/drivers/phy/meson-gxbb-usb2.c b/drivers/phy/meson-gxbb-usb2.c
index 70a80b863819..725b056a71a7 100644
--- a/drivers/phy/meson-gxbb-usb2.c
+++ b/drivers/phy/meson-gxbb-usb2.c
@@ -15,6 +15,7 @@
 #include <regmap.h>
 #include <reset.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 #define REG_CONFIG					0x00
 	#define REG_CONFIG_CLK_EN			BIT(0)
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index 4c631310efac..8f5e4a436615 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -11,12 +11,13 @@
 #include <malloc.h>
 #include <asm/io.h>
 #include <bitfield.h>
+#include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <generic-phy.h>
 #include <regmap.h>
 #include <linux/delay.h>
-#include <clk.h>
+#include <linux/printk.h>
 #include <linux/usb/otg.h>
 
 #include <asm/arch/usb-gx.h>
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index 8c59631428bc..7159e7e8716d 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -17,6 +17,7 @@
 #include <usb.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 /* USB2.0 Host registers (original offset is +0x200) */
diff --git a/drivers/phy/phy-stm32-usbphyc.c b/drivers/phy/phy-stm32-usbphyc.c
index 15bd60ca8c5e..000e495dbd4e 100644
--- a/drivers/phy/phy-stm32-usbphyc.c
+++ b/drivers/phy/phy-stm32-usbphyc.c
@@ -23,6 +23,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 /* USBPHYC registers */
diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 629ef3aa3de5..594dd0f5bfcf 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -12,6 +12,7 @@
 #include <dm/devres.h>
 #include <generic-phy.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 /**
diff --git a/drivers/phy/sti_usb_phy.c b/drivers/phy/sti_usb_phy.c
index ce4caafce7e4..9e5ac9bfde67 100644
--- a/drivers/phy/sti_usb_phy.c
+++ b/drivers/phy/sti_usb_phy.c
@@ -18,6 +18,7 @@
 #include <reset-uclass.h>
 #include <syscon.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 #include <linux/bitops.h>
 #include <linux/compat.h>
diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
index b5b3c3f1522a..313735844ab8 100644
--- a/drivers/phy/ti-pipe3-phy.c
+++ b/drivers/phy/ti-pipe3-phy.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 /* PLLCTRL Registers */
 #define PLL_STATUS              0x00000004
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 1be6252227d3..e834dddfd137 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/pinctrl-sti.c b/drivers/pinctrl/pinctrl-sti.c
index 20cdbb0702e6..1ff7ea005551 100644
--- a/drivers/pinctrl/pinctrl-sti.c
+++ b/drivers/pinctrl/pinctrl-sti.c
@@ -17,6 +17,7 @@
 #include <dm/pinctrl.h>
 #include <linux/bug.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index b06da50b2cd5..8bb7588714a4 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/libfdt.h>
+#include <linux/printk.h>
 
 #include "../gpio/stm32_gpio_priv.h"
 
diff --git a/drivers/power/palmas.c b/drivers/power/palmas.c
index 0959445364e8..3ac971234013 100644
--- a/drivers/power/palmas.c
+++ b/drivers/power/palmas.c
@@ -5,6 +5,7 @@
  */
 #include <config.h>
 #include <palmas.h>
+#include <linux/printk.h>
 
 void palmas_init_settings(void)
 {
diff --git a/drivers/power/pmic/as3722.c b/drivers/power/pmic/as3722.c
index 3aa3cce945e7..c7dd9705d189 100644
--- a/drivers/power/pmic/as3722.c
+++ b/drivers/power/pmic/as3722.c
@@ -12,6 +12,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <dm/lists.h>
+#include <linux/printk.h>
 #include <power/as3722.h>
 #include <power/pmic.h>
 
diff --git a/drivers/power/pmic/as3722_gpio.c b/drivers/power/pmic/as3722_gpio.c
index 96943bc1ad5d..987fbdf9bc08 100644
--- a/drivers/power/pmic/as3722_gpio.c
+++ b/drivers/power/pmic/as3722_gpio.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <dm.h>
 #include <asm/gpio.h>
+#include <linux/printk.h>
 #include <power/as3722.h>
 #include <power/pmic.h>
 
diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
index fdbbd6f55938..ee6ae78e5c4c 100644
--- a/drivers/power/pmic/bd71837.c
+++ b/drivers/power/pmic/bd71837.c
@@ -9,6 +9,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/bd71837.h>
diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
index 25101d18f74b..ca95b82e6d01 100644
--- a/drivers/power/pmic/da9063.c
+++ b/drivers/power/pmic/da9063.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/da9063_pmic.h>
diff --git a/drivers/power/pmic/fan53555.c b/drivers/power/pmic/fan53555.c
index 0d91628f572d..d556b9a5878a 100644
--- a/drivers/power/pmic/fan53555.c
+++ b/drivers/power/pmic/fan53555.c
@@ -10,6 +10,7 @@
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <i2c.h>
+#include <linux/printk.h>
 #include <power/fan53555.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/pmic/i2c_pmic_emul.c b/drivers/power/pmic/i2c_pmic_emul.c
index abe3a1051f14..f0a03742f87b 100644
--- a/drivers/power/pmic/i2c_pmic_emul.c
+++ b/drivers/power/pmic/i2c_pmic_emul.c
@@ -10,6 +10,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/sandbox_pmic.h>
 
diff --git a/drivers/power/pmic/lp873x.c b/drivers/power/pmic/lp873x.c
index 2b1260ec6b1f..fda5bc151642 100644
--- a/drivers/power/pmic/lp873x.c
+++ b/drivers/power/pmic/lp873x.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/lp873x.h>
diff --git a/drivers/power/pmic/lp87565.c b/drivers/power/pmic/lp87565.c
index f4a4bd03d704..904e02c4d818 100644
--- a/drivers/power/pmic/lp87565.c
+++ b/drivers/power/pmic/lp87565.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/lp87565.h>
diff --git a/drivers/power/pmic/max77686.c b/drivers/power/pmic/max77686.c
index 9f02c0b6f6fb..7e6f7d1966f1 100644
--- a/drivers/power/pmic/max77686.c
+++ b/drivers/power/pmic/max77686.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/max77686_pmic.h>
diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
index dbae155fb342..504a63bf7431 100644
--- a/drivers/power/pmic/max8997.c
+++ b/drivers/power/pmic/max8997.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <i2c.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/max8997_pmic.h>
 #include <errno.h>
diff --git a/drivers/power/pmic/max8998.c b/drivers/power/pmic/max8998.c
index f58d9f2d74c1..d155474447f5 100644
--- a/drivers/power/pmic/max8998.c
+++ b/drivers/power/pmic/max8998.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/max8998_pmic.h>
 
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index 6080cbff0bee..eb83c88d5641 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/palmas.h>
diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index e99ece8fb083..0bbe98cd8a29 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm-generic/gpio.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/pca9450.h>
diff --git a/drivers/power/pmic/pfuze100.c b/drivers/power/pmic/pfuze100.c
index 65c4456977cc..15420acb4725 100644
--- a/drivers/power/pmic/pfuze100.c
+++ b/drivers/power/pmic/pfuze100.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/pfuze100_pmic.h>
diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index e03ddc98d730..8ead1db802a2 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/tps65910_pmic.h>
diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 1ba1640a8df3..5ff4f2052113 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/s2mps11.h>
 
diff --git a/drivers/power/pmic/s5m8767.c b/drivers/power/pmic/s5m8767.c
index db6d0357ee4c..eea072ae824f 100644
--- a/drivers/power/pmic/s5m8767.c
+++ b/drivers/power/pmic/s5m8767.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/s5m8767.h>
diff --git a/drivers/power/pmic/sandbox.c b/drivers/power/pmic/sandbox.c
index acfeae2df970..14b82455f5fb 100644
--- a/drivers/power/pmic/sandbox.c
+++ b/drivers/power/pmic/sandbox.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/sandbox_pmic.h>
diff --git a/drivers/power/pmic/tps65090.c b/drivers/power/pmic/tps65090.c
index b81df0dff1a5..2a04d5948a5e 100644
--- a/drivers/power/pmic/tps65090.c
+++ b/drivers/power/pmic/tps65090.c
@@ -10,6 +10,7 @@
 #include <fdtdec.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/tps65090.h>
 
diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 83d0f83c64ae..727b42747ab6 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/tps65941.h>
diff --git a/drivers/power/regulator/bd71837.c b/drivers/power/regulator/bd71837.c
index d4f8da80ad74..913ed88d45f7 100644
--- a/drivers/power/regulator/bd71837.c
+++ b/drivers/power/regulator/bd71837.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <log.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <power/bd71837.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/fan53555.c b/drivers/power/regulator/fan53555.c
index 815f96beef61..fa8d88f2e0dc 100644
--- a/drivers/power/regulator/fan53555.c
+++ b/drivers/power/regulator/fan53555.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <asm/gpio.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <power/fan53555.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index f7ddba8b45e4..590c288d6575 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -11,8 +11,10 @@
 #include <dm.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <asm/gpio.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
+#include "regulator_common.h"
 
 #include "regulator_common.h"
 
diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
index ded7be059bb0..74137b7b876f 100644
--- a/drivers/power/regulator/gpio-regulator.c
+++ b/drivers/power/regulator/gpio-regulator.c
@@ -10,8 +10,10 @@
 #include <dm.h>
 #include <log.h>
 #include <asm/gpio.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
+#include "regulator_common.h"
 
 #include "regulator_common.h"
 
diff --git a/drivers/power/regulator/max77686.c b/drivers/power/regulator/max77686.c
index cef20e11897c..3a2080399340 100644
--- a/drivers/power/regulator/max77686.c
+++ b/drivers/power/regulator/max77686.c
@@ -10,6 +10,7 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/max77686_pmic.h>
diff --git a/drivers/power/regulator/pbias_regulator.c b/drivers/power/regulator/pbias_regulator.c
index 5bf186e4d4c1..cf4e2858443d 100644
--- a/drivers/power/regulator/pbias_regulator.c
+++ b/drivers/power/regulator/pbias_regulator.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <regmap.h>
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index e26f5ebec347..0116fa01bbfe 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -7,8 +7,10 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <asm/gpio.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
+#include "regulator_common.h"
 
 #include "regulator_common.h"
 
diff --git a/drivers/power/regulator/s2mps11_regulator.c b/drivers/power/regulator/s2mps11_regulator.c
index 93fb580407ab..987a1f9d8638 100644
--- a/drivers/power/regulator/s2mps11_regulator.c
+++ b/drivers/power/regulator/s2mps11_regulator.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/s2mps11.h>
diff --git a/drivers/power/regulator/sandbox.c b/drivers/power/regulator/sandbox.c
index e8b66bf2b142..71ef0c5441af 100644
--- a/drivers/power/regulator/sandbox.c
+++ b/drivers/power/regulator/sandbox.c
@@ -8,6 +8,7 @@
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/sandbox_pmic.h>
diff --git a/drivers/power/regulator/tps65910_regulator.c b/drivers/power/regulator/tps65910_regulator.c
index 0ed4952a1e0f..a4b9d449274b 100644
--- a/drivers/power/regulator/tps65910_regulator.c
+++ b/drivers/power/regulator/tps65910_regulator.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
 #include <power/tps65910_pmic.h>
diff --git a/drivers/power/twl4030.c b/drivers/power/twl4030.c
index d3e8949af996..0c7c3960904c 100644
--- a/drivers/power/twl4030.c
+++ b/drivers/power/twl4030.c
@@ -25,6 +25,7 @@
 #include <command.h>
 #include <twl4030.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 /*
  * Power Reset
diff --git a/drivers/power/twl6030.c b/drivers/power/twl6030.c
index 2b50a56faf8f..39c05f9b7d37 100644
--- a/drivers/power/twl6030.c
+++ b/drivers/power/twl6030.c
@@ -5,6 +5,7 @@
  */
 #include <config.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <twl6030.h>
 
diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
index d0a88845cf9b..6a15242c20cc 100644
--- a/drivers/ram/imxrt_sdram.c
+++ b/drivers/ram/imxrt_sdram.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 /* SDRAM Command Code */
 #define SD_CC_ARD		0x0     /* Master Bus (AXI) command - Read */
diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index dd5b19174455..f36be941a38c 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 struct dram_info {
 	struct ram_info info;
diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
index 47a930ee9540..891f4137813e 100644
--- a/drivers/ram/stm32_sdram.c
+++ b/drivers/ram/stm32_sdram.c
@@ -16,6 +16,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #define MEM_MODE_MASK	GENMASK(2, 0)
 #define SWP_FMC_OFFSET 10
diff --git a/drivers/ram/stm32mp1/stm32mp1_ddr.c b/drivers/ram/stm32mp1/stm32mp1_ddr.c
index ab913a68761f..8ee4e24f39df 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ddr.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ddr.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 #include "stm32mp1_ddr.h"
 #include "stm32mp1_ddr_regs.h"
 
diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index a6c19af97220..61bc002d979d 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -15,6 +15,7 @@
 #include <syscon.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/printk.h>
 #include "stm32mp1_ddr.h"
 #include "stm32mp1_ddr_regs.h"
 
diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
index b185a6cafb82..5e070e5076e1 100644
--- a/drivers/remoteproc/rproc-elf-loader.c
+++ b/drivers/remoteproc/rproc-elf-loader.c
@@ -11,6 +11,7 @@
 #include <asm/cache.h>
 #include <dm/device_compat.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 
 /**
  * struct resource_table - firmware resource table header
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 19fe4053be81..ece534c3c0e3 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -20,6 +20,7 @@
 #include <dm/uclass.h>
 #include <dm/uclass-internal.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/remoteproc/sandbox_testproc.c b/drivers/remoteproc/sandbox_testproc.c
index 78b108184bbb..d360cf3169ff 100644
--- a/drivers/remoteproc/sandbox_testproc.c
+++ b/drivers/remoteproc/sandbox_testproc.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <remoteproc.h>
 #include <asm/io.h>
+#include <linux/printk.h>
 
 /**
  * enum sandbox_state - different device states
diff --git a/drivers/remoteproc/stm32_copro.c b/drivers/remoteproc/stm32_copro.c
index 5271f83bc0b0..3e322c4d7191 100644
--- a/drivers/remoteproc/stm32_copro.c
+++ b/drivers/remoteproc/stm32_copro.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 /**
  * struct stm32_copro_privdata - power processor private data
diff --git a/drivers/remoteproc/ti_power_proc.c b/drivers/remoteproc/ti_power_proc.c
index 86d544cc8540..6887a3c8541f 100644
--- a/drivers/remoteproc/ti_power_proc.c
+++ b/drivers/remoteproc/ti_power_proc.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <remoteproc.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include <mach/psc_defs.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
index f8299d1aff92..36351da63fcc 100644
--- a/drivers/remoteproc/ti_sci_proc.h
+++ b/drivers/remoteproc/ti_sci_proc.h
@@ -10,6 +10,7 @@
 #ifndef REMOTEPROC_TI_SCI_PROC_H
 #define REMOTEPROC_TI_SCI_PROC_H
 
+#include <linux/printk.h>
 #define TISCI_INVALID_HOST 0xff
 
 /**
diff --git a/drivers/reset/sti-reset.c b/drivers/reset/sti-reset.c
index ea449bbaaf07..5305270fbf20 100644
--- a/drivers/reset/sti-reset.c
+++ b/drivers/reset/sti-reset.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <dt-bindings/reset/stih407-resets.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 2dffa14ea757..f146f2b006e8 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <asm/types.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 struct mtk_serial_regs {
 	u32 rbr;
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index f110d78ce10f..9881bffc8e17 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -21,6 +21,7 @@
 #include <linux/compat.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <linux/soc/ti/k3-navss-ringacc.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/cppi5.h>
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 702e22535811..aec6f4eca9ae 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -17,6 +17,7 @@
 #include <asm/gpio.h>
 #endif
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 /*
  * Register definitions for the Atmel AT32/AT91 SPI Controller
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index 8e5cc5552f09..f8ec268812ca 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -26,6 +26,7 @@
 #include <fsl_dspi.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 /* linux/include/time.h */
 #define NSEC_PER_SEC	1000000000L
diff --git a/drivers/spi/mt7621_spi.c b/drivers/spi/mt7621_spi.c
index eb0931747b74..3d0080998625 100644
--- a/drivers/spi/mt7621_spi.c
+++ b/drivers/spi/mt7621_spi.c
@@ -16,6 +16,7 @@
 #include <wait_bit.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 #define MT7621_RX_FIFO_LEN	32
 #define MT7621_TX_FIFO_LEN	36
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 840660ffe9a3..33360a183294 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -19,6 +19,7 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/spi.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/spi/pl022_spi.c b/drivers/spi/pl022_spi.c
index fc7388b379d4..e2b49ebd149a 100644
--- a/drivers/spi/pl022_spi.c
+++ b/drivers/spi/pl022_spi.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <spi.h>
+#include <linux/printk.h>
 
 #define SSP_CR0		0x000
 #define SSP_CR1		0x004
diff --git a/drivers/spi/stm32_qspi.c b/drivers/spi/stm32_qspi.c
index eb52ff73b23d..2ffa201a66ed 100644
--- a/drivers/spi/stm32_qspi.c
+++ b/drivers/spi/stm32_qspi.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
+#include <linux/printk.h>
 #include <linux/sizes.h>
 
 struct stm32_qspi_regs {
diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index fe5419e85182..82f6ed783f9e 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -18,6 +18,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <asm/io.h>
 #include <asm/gpio.h>
diff --git a/drivers/spi/uniphier_spi.c b/drivers/spi/uniphier_spi.c
index fcc1bfe64b65..6402acbf14a1 100644
--- a/drivers/spi/uniphier_spi.c
+++ b/drivers/spi/uniphier_spi.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <spi.h>
 #include <wait_bit.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/sysreset/sysreset_sti.c b/drivers/sysreset/sysreset_sti.c
index f0f445f22edc..edd90aab061d 100644
--- a/drivers/sysreset/sysreset_sti.c
+++ b/drivers/sysreset/sysreset_sti.c
@@ -12,6 +12,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
index 525faf2f89e2..e468dac0e902 100644
--- a/drivers/sysreset/sysreset_syscon.c
+++ b/drivers/sysreset/sysreset_syscon.c
@@ -14,6 +14,7 @@
 #include <sysreset.h>
 #include <syscon.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 
 struct syscon_reboot_priv {
 	struct regmap *regmap;
diff --git a/drivers/sysreset/sysreset_watchdog.c b/drivers/sysreset/sysreset_watchdog.c
index 8a659ee9b972..ceada2e47b54 100644
--- a/drivers/sysreset/sysreset_watchdog.c
+++ b/drivers/sysreset/sysreset_watchdog.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <sysreset.h>
 #include <wdt.h>
+#include <linux/printk.h>
 
 struct wdt_reboot_plat {
 	struct udevice *wdt;
diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index 525ad72f4c92..16f4af0e331e 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
+#include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/unaligned/be_byteshift.h>
 
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index cae570cf5984..7aa0c6b2beef 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -62,6 +62,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <linux/usb/gadget.h>
 #include <linux/compat.h>
 #include <linux/iopoll.h>
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index cff86a51ae00..7137a569d97c 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/phy.h>
diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7f0af05855ab..8a5e451a5e8a 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -17,6 +17,7 @@
 #include <generic-phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index c62e42de73f7..dc5a976f71aa 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -15,6 +15,7 @@
 #include <dwc3-uboot.h>
 #include <generic-phy.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <malloc.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eb416b832aad..68cf32cd189c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/eth/mcs7830.c b/drivers/usb/eth/mcs7830.c
index 8a256b3e3469..d94204f22d5f 100644
--- a/drivers/usb/eth/mcs7830.c
+++ b/drivers/usb/eth/mcs7830.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <usb.h>
+#include <linux/printk.h>
 
 #include "usb_ether.h"
 
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 1feed417d68e..e198ef1d34d6 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -21,6 +21,7 @@
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <asm/hardware.h>
+#include <linux/printk.h>
 #include <mach/at91_matrix.h>
 #include <linux/list.h>
 #include <linux/usb/ch9.h>
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 7d51821497b4..ed3b3c14e609 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -13,6 +13,7 @@
 #include <asm/gpio.h>
 #include <asm/hardware.h>
 #include <linux/list.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 2bf7ed8d6046..5be696bc13b7 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -28,6 +28,7 @@
 #include <dm/devres.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 
 #include <linux/errno.h>
 #include <linux/list.h>
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 5ff06d3814b8..13ef8cb77ffa 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -14,6 +14,7 @@
 #include <part.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/cdc.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 6d97b4bbdc30..741775a7bcf2 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -17,6 +17,7 @@
 #include <fastboot.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 4da5a160a098..9133693350cf 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -22,6 +22,7 @@
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 47ef55b2fd31..5a14f11373f8 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -24,6 +24,7 @@
 #include <memalign.h>
 #include <version.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index de8861829c73..53e34105744b 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
+#include <linux/printk.h>
 #include <linux/usb/gadget.h>
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
diff --git a/drivers/usb/host/dwc3-sti-glue.c b/drivers/usb/host/dwc3-sti-glue.c
index 239b671ac381..4a3ab6111276 100644
--- a/drivers/usb/host/dwc3-sti-glue.c
+++ b/drivers/usb/host/dwc3-sti-glue.c
@@ -17,6 +17,7 @@
 #include <reset-uclass.h>
 #include <syscon.h>
 #include <usb.h>
+#include <linux/printk.h>
 
 #include <linux/usb/dwc3.h>
 #include <linux/usb/otg.h>
diff --git a/drivers/usb/musb-new/mt85xx.c b/drivers/usb/musb-new/mt85xx.c
index 730045cf9a73..1e632dca0462 100644
--- a/drivers/usb/musb-new/mt85xx.c
+++ b/drivers/usb/musb-new/mt85xx.c
@@ -16,6 +16,7 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/usb/musb.h>
 #include <usb.h>
 #include "linux-compat.h"
diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb_core.c
index a42d98ece9b1..00da554982fe 100644
--- a/drivers/usb/musb-new/musb_core.c
+++ b/drivers/usb/musb-new/musb_core.c
@@ -86,6 +86,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/musb.h>
diff --git a/drivers/usb/musb-new/musb_debug.h b/drivers/usb/musb-new/musb_debug.h
index c468bda9ff2f..94375b72c702 100644
--- a/drivers/usb/musb-new/musb_debug.h
+++ b/drivers/usb/musb-new/musb_debug.h
@@ -10,6 +10,7 @@
 #ifndef __MUSB_LINUX_DEBUG_H__
 #define __MUSB_LINUX_DEBUG_H__
 
+#include <linux/printk.h>
 #define yprintk(facility, format, args...) \
 	do { printk(facility "%s %d: " format , \
 	__func__, __LINE__ , ## args); } while (0)
diff --git a/drivers/usb/musb-new/musb_dsps.c b/drivers/usb/musb-new/musb_dsps.c
index d55a920ae59c..a8ff7434c9f7 100644
--- a/drivers/usb/musb-new/musb_dsps.c
+++ b/drivers/usb/musb-new/musb_dsps.c
@@ -35,6 +35,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <asm/omap_musb.h>
+#include <linux/printk.h>
 #include "linux-compat.h"
 #endif
 
diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 05bd94878574..c6083963ede9 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -26,6 +26,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <linux/bug.h>
+#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include "linux-compat.h"
 #endif
diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 7fdd24005e76..55ce8de99bb1 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -21,6 +21,7 @@
 #include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <linux/printk.h>
 #include <asm/processor.h>
 #include "linux-compat.h"
 #endif
diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index 482dfdc6be61..308eff832c9e 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -16,6 +16,7 @@
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <asm/global_data.h>
 #include <asm/omap_common.h>
diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index 485b9dce156c..91f082fe05ef 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -30,6 +30,7 @@
 #include <dm/root.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include <linux/usb/musb.h>
 #include "linux-compat.h"
 #include "musb_core.h"
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 3be3f93dd85d..ed5e5194d8c9 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index e5f281320534..5db01904b538 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -14,6 +14,7 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 #include <clk.h>
 #include <linux/delay.h>
diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
index cd1e69040f75..e718a0074ed6 100644
--- a/drivers/video/meson/meson_vclk.c
+++ b/drivers/video/meson/meson_vclk.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <edid.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #include "meson_vpu.h"
 #include <log.h>
 #include <linux/iopoll.h>
diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
index a7420fb2ee7f..a18c1e027a87 100644
--- a/drivers/video/stm32/stm32_dsi.c
+++ b/drivers/video/stm32/stm32_dsi.c
@@ -26,6 +26,7 @@
 #include <dm/lists.h>
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 #include <power/regulator.h>
 
 #define HWVER_130			0x31333000	/* IP version 1.30 */
diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index f48badc517a8..6fd90e33919d 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -20,6 +20,7 @@
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
+#include <linux/printk.h>
 
 struct stm32_ltdc_priv {
 	void __iomem *regs;
diff --git a/drivers/video/tegra124/sor.c b/drivers/video/tegra124/sor.c
index f291db3dc766..258685182c7d 100644
--- a/drivers/video/tegra124/sor.c
+++ b/drivers/video/tegra124/sor.c
@@ -15,6 +15,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/dc.h>
 #include <linux/delay.h>
+#include <linux/printk.h>
 #include "displayport.h"
 #include "sor.h"
 #include <linux/err.h>
diff --git a/drivers/watchdog/stm32mp_wdt.c b/drivers/watchdog/stm32mp_wdt.c
index 4be616c1b6b5..7ebcd2552668 100644
--- a/drivers/watchdog/stm32mp_wdt.c
+++ b/drivers/watchdog/stm32mp_wdt.c
@@ -15,6 +15,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
+#include <linux/printk.h>
 
 /* IWDG registers */
 #define IWDG_KR		0x00	/* Key register */
diff --git a/env/common.c b/env/common.c
index 0ecdb248a082..8c9b6f9fe78a 100644
--- a/env/common.c
+++ b/env/common.c
@@ -15,6 +15,7 @@
 #include <log.h>
 #include <sort.h>
 #include <asm/global_data.h>
+#include <linux/printk.h>
 #include <linux/stddef.h>
 #include <search.h>
 #include <errno.h>
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index bede7d01cab0..ff2a5719c3eb 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -18,6 +18,7 @@
 #include <hexdump.h>
 #include <log.h>
 #include <dm/devres.h>
+#include <linux/printk.h>
 
 #ifndef __UBOOT__
 #include <linux/module.h>
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index 0ecc2e0c8e98..d8324aea5f7d 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -12,6 +12,7 @@
 #define __UBIFS_DEBUG_H__
 
 /* Checking helper functions */
+#include <linux/printk.h>
 typedef int (*dbg_leaf_callback)(struct ubifs_info *c,
 				 struct ubifs_zbranch *zbr, void *priv);
 typedef int (*dbg_znode_callback)(struct ubifs_info *c,
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index ba0b19a1f2b2..2e50c08f4dfa 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -24,6 +24,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/crc16.h>
+#include <linux/printk.h>
 #endif
 #include "ubifs.h"
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 034c41a70356..3e7160352e6c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -35,6 +35,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/log2.h>
+#include <linux/printk.h>
 #include <linux/stat.h>
 #include <linux/err.h>
 #include "ubifs.h"
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 46dfbd0b5aba..67b13c83b568 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -35,6 +35,7 @@
 #include <asm-generic/atomic-long.h>
 #include <ubi_uboot.h>
 #include <ubifs_uboot.h>
+#include <linux/printk.h>
 
 #include <linux/ctype.h>
 #include <linux/time.h>
diff --git a/fs/yaffs2/yaffs_uboot_glue.c b/fs/yaffs2/yaffs_uboot_glue.c
index ec8d028316a0..0a920561149a 100644
--- a/fs/yaffs2/yaffs_uboot_glue.c
+++ b/fs/yaffs2/yaffs_uboot_glue.c
@@ -22,6 +22,7 @@
 #include <common.h>
 #include <div64.h>
 #include <malloc.h>
+#include <linux/printk.h>
 
 #include <config.h>
 #include "nand.h"
diff --git a/include/common.h b/include/common.h
index 25c317f44392..a79c2bb49931 100644
--- a/include/common.h
+++ b/include/common.h
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include <time.h>
 #include <linux/types.h>
-#include <linux/printk.h>
 #include <linux/string.h>
 #include <stdarg.h>
 #include <stdio.h>
diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
index 906033a90eb4..2c45cce52348 100644
--- a/include/crypto/pkcs7_parser.h
+++ b/include/crypto/pkcs7_parser.h
@@ -11,6 +11,7 @@
 #include <linux/oid_registry.h>
 #include <crypto/pkcs7.h>
 #include <crypto/x509_parser.h>
+#include <linux/printk.h>
 
 #define kenter(FMT, ...) \
 	pr_devel("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
index 82d7a7d49249..aa9a6fbb5e3f 100644
--- a/include/dm/device_compat.h
+++ b/include/dm/device_compat.h
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <linux/build_bug.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 
 /*
  * Define a new identifier which can be tested on by C code. A similar
diff --git a/include/linux/soc/ti/cppi5.h b/include/linux/soc/ti/cppi5.h
index cfdf7ea29fc3..3a55c3ec46f5 100644
--- a/include/linux/soc/ti/cppi5.h
+++ b/include/linux/soc/ti/cppi5.h
@@ -11,6 +11,7 @@
 #include <hexdump.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/printk.h>
 
 /**
  * Descriptor header, present in all types of descriptors
diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
index bcb0390eb41c..1191fc364871 100644
--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -8,6 +8,7 @@
 #ifdef __UBOOT__
 #include <log.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 #else
 #include <linux/export.h>
 #endif
diff --git a/lib/bch.c b/lib/bch.c
index de66b1acba54..72b4fdcc9c44 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -61,6 +61,7 @@
 #include <dm/devres.h>
 
 #include <linux/bitops.h>
+#include <linux/printk.h>
 #else
 #include <errno.h>
 #if defined(__FreeBSD__)
diff --git a/lib/crypto/asymmetric_type.c b/lib/crypto/asymmetric_type.c
index 1d0532d0f2e0..24c2d15ef97a 100644
--- a/lib/crypto/asymmetric_type.c
+++ b/lib/crypto/asymmetric_type.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #include <linux/string.h>
 #else
 #include <linux/seq_file.h>
diff --git a/lib/crypto/pkcs7_parser.c b/lib/crypto/pkcs7_parser.c
index 0b85fe8286c7..d5efa828d6aa 100644
--- a/lib/crypto/pkcs7_parser.c
+++ b/lib/crypto/pkcs7_parser.c
@@ -11,6 +11,7 @@
 #include <dm/devres.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <linux/printk.h>
 #endif
 #include <linux/kernel.h>
 #ifndef __UBOOT__
diff --git a/lib/crypto/pkcs7_verify.c b/lib/crypto/pkcs7_verify.c
index b832f013566f..9d7b9f6bce83 100644
--- a/lib/crypto/pkcs7_verify.c
+++ b/lib/crypto/pkcs7_verify.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/asn1.h>
+#include <linux/printk.h>
 #include <u-boot/hash-checksum.h>
 #include <crypto/public_key.h>
 #include <crypto/pkcs7_parser.h>
diff --git a/lib/crypto/public_key.c b/lib/crypto/public_key.c
index 3671ed138559..6efe951c057c 100644
--- a/lib/crypto/public_key.c
+++ b/lib/crypto/public_key.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/compat.h>
 #include <linux/err.h>
+#include <linux/printk.h>
 #else
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/lib/crypto/rsa_helper.c b/lib/crypto/rsa_helper.c
index cc0c0d6637bd..c941d40fd7a8 100644
--- a/lib/crypto/rsa_helper.c
+++ b/lib/crypto/rsa_helper.c
@@ -15,6 +15,7 @@
 #include <linux/fips.h>
 #endif
 #include <crypto/internal/rsa.h>
+#include <linux/printk.h>
 #include "rsapubkey.asn1.h"
 #ifndef __UBOOT__
 #include "rsaprivkey.asn1.h"
diff --git a/lib/crypto/x509_cert_parser.c b/lib/crypto/x509_cert_parser.c
index eb24349460c2..a0f0689118f6 100644
--- a/lib/crypto/x509_cert_parser.c
+++ b/lib/crypto/x509_cert_parser.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/oid_registry.h>
 #ifdef __UBOOT__
+#include <linux/printk.h>
 #include <linux/string.h>
 #endif
 #include <crypto/public_key.h>
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index 5c0e2b622db4..30071233ee79 100644
--- a/lib/crypto/x509_public_key.c
+++ b/lib/crypto/x509_public_key.c
@@ -13,6 +13,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/printk.h>
 #else
 #include <linux/module.h>
 #endif
diff --git a/lib/list_sort.c b/lib/list_sort.c
index 58e1e1614a57..1c9e06173270 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -8,6 +8,7 @@
 #include <linux/compat.h>
 #include <common.h>
 #include <malloc.h>
+#include <linux/printk.h>
 #endif
 #include <linux/list.h>
 #include <linux/list_sort.h>
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index d706928d1687..d6907874787e 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -8,6 +8,7 @@
 #include <fastboot.h>
 #include <net.h>
 #include <net/fastboot_udp.h>
+#include <linux/printk.h>
 
 enum {
 	FASTBOOT_ERROR = 0,
-- 
2.42.0.459.ge4e396fd5e-goog

