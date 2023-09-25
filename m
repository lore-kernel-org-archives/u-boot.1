Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA2CCE7A91
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 02:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E514286B73;
	Mon, 25 Sep 2023 04:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cgOKezP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C5A86B5A; Mon, 25 Sep 2023 04:40:12 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832178692B
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 04:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79f9acc857cso153659039f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695609606; x=1696214406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7a5SO60XYiQEoepIyynWpCbYenJ52qWeIPCTtvubNxw=;
 b=cgOKezP4ttUfxyN6wJNi+1G/e3Ue5ug/xP7jSVJBCTaLMzogWYY2PZDF5WaIfdgxJo
 1loHbHGX28GRnZq4F4AXXYdDmvI2cCzB3iCXQFP/qEaJCWryJJvT4JCQYGdREEuDUwsl
 FY53Lo1mez8+uuhBZBgFDtiXI5fOeTkq/6Ckc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609606; x=1696214406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7a5SO60XYiQEoepIyynWpCbYenJ52qWeIPCTtvubNxw=;
 b=kiCeqxn9OUSODKNcb0Y9VOrvEq7TlCukZt4fsB8yf5uG4UJsVsLzjcPZsMB5hh0dRt
 1nH/b9cmKJ9L8mDaqgXVlHAgXJmuckli15lCFuJY8XnyhM984AHhxYWThum1+gj1gvOC
 1mQwHZjfA2M9StozlclJ7oExDLO1sOOSSqA6ySlSWqIByVNVKQVy+ZUBitOWhZjEu4Rg
 SuWUSLMS1v3EmWVSUSVuF8//HSdu8djTvxIi9el9WkjaFM5TboFG4eXikyyVzsisuJON
 6tStQEX1KPExMAp9F4pkmxEzbnQ1n8sq75fZm+jH5EsXQ2XmDV4fDH13W1+YVy65q/5V
 DLOw==
X-Gm-Message-State: AOJu0YyMaQSRpQl10/cJNxRE4AYprC5CDxAusS717E6MpAVhnjZErgRc
 MrUnjOZgeUVX9fpYdOPz252x8WTa7j4V/dIn2DA=
X-Google-Smtp-Source: AGHT+IFBxTuAcWEpRQjcNMEidb2aiyvgJFezzw2xLjrT/FIcHtUB5rBsLJ6FurWAHVmxmq12q+UizQ==
X-Received: by 2002:a05:6e02:1288:b0:351:80c:bc29 with SMTP id
 y8-20020a056e02128800b00351080cbc29mr6214364ilq.17.1695609605824; 
 Sun, 24 Sep 2023 19:40:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 q8-20020a0566380ec800b00439e3c9f958sm2477252jas.129.2023.09.24.19.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:40:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] common: Drop time.h from common header
Date: Sun, 24 Sep 2023 20:39:51 -0600
Message-ID: <20230925023958.1913268-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230925023958.1913268-1-sjg@chromium.org>
References: <20230925023958.1913268-1-sjg@chromium.org>
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

Move this out of the common header and include it only where needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 api/api.c                                              | 1 +
 arch/arm/include/asm/arch-tegra/timer.h                | 1 +
 arch/arm/mach-at91/arm920t/clock.c                     | 1 +
 arch/arm/mach-at91/arm926ejs/clock.c                   | 1 +
 arch/arm/mach-at91/clock.c                             | 1 +
 arch/arm/mach-at91/phy.c                               | 1 +
 arch/arm/mach-bcm283x/mbox.c                           | 1 +
 arch/arm/mach-bcmstb/include/mach/timer.h              | 1 +
 arch/arm/mach-exynos/clock.c                           | 1 +
 arch/arm/mach-imx/i2c-mxv7.c                           | 1 +
 arch/arm/mach-imx/mx6/clock.c                          | 1 +
 arch/arm/mach-imx/mx7/clock.c                          | 1 +
 arch/arm/mach-nexell/timer.c                           | 1 +
 arch/arm/mach-omap2/omap3/am35x_musb.c                 | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c | 1 +
 arch/arm/mach-stm32mp/pwr_regulator.c                  | 1 +
 arch/arm/mach-tegra/powergate.c                        | 1 +
 arch/arm/mach-tegra/tegra124/xusb-padctl.c             | 1 +
 arch/arm/mach-tegra/tegra210/clock.c                   | 1 +
 arch/arm/mach-tegra/tegra210/xusb-padctl.c             | 1 +
 arch/mips/mach-mtmips/mt7620/init.c                    | 1 +
 arch/mips/mach-mtmips/mt7621/init.c                    | 1 +
 arch/mips/mach-mtmips/mt7628/init.c                    | 1 +
 arch/mips/mach-octeon/clock.c                          | 1 +
 arch/mips/mach-octeon/cvmx-helper-bgx.c                | 1 +
 arch/mips/mach-octeon/cvmx-pcie.c                      | 1 +
 arch/mips/mach-octeon/include/mach/cvmx-mdio.h         | 1 +
 arch/mips/mach-octeon/include/mach/cvmx-regs.h         | 1 +
 arch/powerpc/lib/interrupts.c                          | 1 +
 arch/x86/cpu/acpi_gpe.c                                | 1 +
 arch/x86/cpu/apollolake/punit.c                        | 1 +
 arch/x86/cpu/intel_common/mrc.c                        | 1 +
 arch/x86/cpu/mp_init.c                                 | 1 +
 board/astro/mcf5373l/mcf5373l.c                        | 1 +
 board/cobra5272/flash.c                                | 1 +
 board/freescale/m5253demo/flash.c                      | 1 +
 board/nokia/rx51/rx51.c                                | 1 +
 board/sandbox/sandbox.c                                | 1 +
 board/theadorable/fpga.c                               | 1 +
 board/theadorable/theadorable.c                        | 1 +
 cmd/clone.c                                            | 1 +
 cmd/cyclic.c                                           | 1 +
 cmd/gettime.c                                          | 1 +
 cmd/mem.c                                              | 1 +
 cmd/sf.c                                               | 1 +
 cmd/sleep.c                                            | 1 +
 cmd/timer.c                                            | 1 +
 cmd/tpm_test.c                                         | 1 +
 common/command.c                                       | 1 +
 common/dfu.c                                           | 1 +
 common/usb_hub.c                                       | 1 +
 common/usb_kbd.c                                       | 1 +
 common/xyzModem.c                                      | 1 +
 drivers/ata/ahci.c                                     | 1 +
 drivers/ata/sata_mv.c                                  | 1 +
 drivers/crypto/nuvoton/npcm_aes.c                      | 1 +
 drivers/ddr/altera/sdram_n5x.c                         | 1 +
 drivers/ddr/altera/sdram_soc64.c                       | 1 +
 drivers/dma/lpc32xx_dma.c                              | 1 +
 drivers/fpga/ACEX1K.c                                  | 1 +
 drivers/fpga/cyclon2.c                                 | 1 +
 drivers/fpga/intel_sdm_mb.c                            | 1 +
 drivers/fpga/socfpga_arria10.c                         | 1 +
 drivers/fpga/spartan2.c                                | 1 +
 drivers/fpga/spartan3.c                                | 1 +
 drivers/fpga/virtex2.c                                 | 1 +
 drivers/fpga/zynqpl.c                                  | 1 +
 drivers/hwspinlock/hwspinlock-uclass.c                 | 1 +
 drivers/i2c/at91_i2c.c                                 | 1 +
 drivers/i2c/designware_i2c.c                           | 1 +
 drivers/i2c/i2c-cortina.c                              | 1 +
 drivers/i2c/imx_lpi2c.c                                | 1 +
 drivers/i2c/intel_i2c.c                                | 1 +
 drivers/i2c/meson_i2c.c                                | 1 +
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c             | 1 +
 drivers/i2c/mxc_i2c.c                                  | 1 +
 drivers/i2c/npcm_i2c.c                                 | 1 +
 drivers/i2c/nx_i2c.c                                   | 1 +
 drivers/i2c/rk_i2c.c                                   | 1 +
 drivers/i2c/s3c24x0_i2c.c                              | 1 +
 drivers/i2c/stm32f7_i2c.c                              | 1 +
 drivers/input/input.c                                  | 1 +
 drivers/input/tegra-kbc.c                              | 1 +
 drivers/misc/cros_ec.c                                 | 1 +
 drivers/misc/cros_ec_lpc.c                             | 1 +
 drivers/misc/cros_ec_sandbox.c                         | 1 +
 drivers/misc/cros_ec_spi.c                             | 1 +
 drivers/mmc/am654_sdhci.c                              | 1 +
 drivers/mmc/bcm2835_sdhost.c                           | 1 +
 drivers/mmc/dw_mmc.c                                   | 1 +
 drivers/mmc/fsl_esdhc.c                                | 1 +
 drivers/mmc/fsl_esdhc_imx.c                            | 1 +
 drivers/mmc/ftsdc010_mci.c                             | 1 +
 drivers/mmc/meson_gx_mmc.c                             | 1 +
 drivers/mmc/mmc.c                                      | 1 +
 drivers/mmc/mvebu_mmc.c                                | 1 +
 drivers/mmc/omap_hsmmc.c                               | 1 +
 drivers/mmc/sdhci.c                                    | 1 +
 drivers/mmc/sunxi_mmc.c                                | 1 +
 drivers/mmc/tegra_mmc.c                                | 1 +
 drivers/mtd/cfi_flash.c                                | 1 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c               | 1 +
 drivers/mtd/nand/raw/fsl_elbc_nand.c                   | 1 +
 drivers/mtd/nand/raw/fsl_ifc_nand.c                    | 1 +
 drivers/mtd/nand/raw/mxs_nand_spl.c                    | 1 +
 drivers/mtd/nand/raw/nand_base.c                       | 1 +
 drivers/mtd/nand/raw/pxa3xx_nand.c                     | 1 +
 drivers/mtd/nand/raw/rockchip_nfc.c                    | 1 +
 drivers/mtd/nand/raw/sunxi_nand.c                      | 1 +
 drivers/mtd/nand/raw/vf610_nfc.c                       | 1 +
 drivers/mtd/nand/spi/core.c                            | 1 +
 drivers/mtd/onenand/onenand_base.c                     | 1 +
 drivers/mtd/spi/sf_dataflash.c                         | 1 +
 drivers/mtd/spi/spi-nor-core.c                         | 1 +
 drivers/mtd/spi/spi-nor-tiny.c                         | 1 +
 drivers/net/ag7xxx.c                                   | 1 +
 drivers/net/altera_tse.c                               | 1 +
 drivers/net/cortina_ni.c                               | 1 +
 drivers/net/designware.c                               | 1 +
 drivers/net/dm9000x.c                                  | 1 +
 drivers/net/ethoc.c                                    | 1 +
 drivers/net/fec_mxc.c                                  | 1 +
 drivers/net/ftmac100.c                                 | 1 +
 drivers/net/ldpaa_eth/ldpaa_eth.c                      | 1 +
 drivers/net/mtk_eth.c                                  | 1 +
 drivers/net/npcm750_eth.c                              | 1 +
 drivers/net/octeontx/smi.c                             | 1 +
 drivers/net/octeontx2/nix_af.c                         | 1 +
 drivers/net/pch_gbe.c                                  | 1 +
 drivers/net/ravb.c                                     | 1 +
 drivers/net/rswitch.c                                  | 1 +
 drivers/net/rtl8169.c                                  | 1 +
 drivers/net/sandbox.c                                  | 1 +
 drivers/net/xilinx_emaclite.c                          | 1 +
 drivers/pci/pci_rom.c                                  | 1 +
 drivers/pci/pci_tegra.c                                | 1 +
 drivers/pci/pcie_dw_mvebu.c                            | 1 +
 drivers/pci/pcie_dw_ti.c                               | 1 +
 drivers/pci/pcie_uniphier.c                            | 1 +
 drivers/phy/phy-da8xx-usb.c                            | 1 +
 drivers/power/exynos-tmu.c                             | 1 +
 drivers/power/regulator/tps65090_regulator.c           | 1 +
 drivers/ram/rockchip/dmc-rk3368.c                      | 1 +
 drivers/ram/stm32mp1/stm32mp1_interactive.c            | 1 +
 drivers/rng/sandbox_rng.c                              | 1 +
 drivers/rtc/emul_rtc.c                                 | 1 +
 drivers/rtc/rv3029.c                                   | 1 +
 drivers/sound/samsung-i2s.c                            | 1 +
 drivers/sound/tegra_ahub.c                             | 1 +
 drivers/spi/altera_spi.c                               | 1 +
 drivers/spi/apple_spi.c                                | 1 +
 drivers/spi/cadence_qspi_apb.c                         | 1 +
 drivers/spi/ich.c                                      | 1 +
 drivers/spi/mpc8xxx_spi.c                              | 1 +
 drivers/spi/mxc_spi.c                                  | 1 +
 drivers/spi/omap3_spi.c                                | 1 +
 drivers/spi/pic32_spi.c                                | 1 +
 drivers/spi/rockchip_sfc.c                             | 1 +
 drivers/spi/zynq_qspi.c                                | 1 +
 drivers/timer/sandbox_timer.c                          | 1 +
 drivers/tpm/cr50_i2c.c                                 | 1 +
 drivers/tpm/tpm-uclass.c                               | 1 +
 drivers/tpm/tpm2_tis_core.c                            | 1 +
 drivers/tpm/tpm2_tis_spi.c                             | 1 +
 drivers/tpm/tpm_atmel_twi.c                            | 1 +
 drivers/tpm/tpm_tis_infineon.c                         | 1 +
 drivers/tpm/tpm_tis_st33zp24_i2c.c                     | 1 +
 drivers/tpm/tpm_tis_st33zp24_spi.c                     | 1 +
 drivers/ufs/ufs.c                                      | 1 +
 drivers/usb/eth/smsc95xx.c                             | 1 +
 drivers/usb/gadget/ether.c                             | 1 +
 drivers/usb/host/dwc2.c                                | 1 +
 drivers/usb/host/ehci-hcd.c                            | 1 +
 drivers/usb/host/ehci-omap.c                           | 1 +
 drivers/usb/host/ohci-da8xx.c                          | 1 +
 drivers/usb/host/xhci-ring.c                           | 1 +
 drivers/usb/isp1760/isp1760-hcd.c                      | 1 +
 drivers/usb/musb-new/am35x.c                           | 1 +
 drivers/usb/musb-new/musb_dsps.c                       | 1 +
 drivers/usb/musb-new/musb_uboot.c                      | 1 +
 drivers/usb/musb-new/omap2430.c                        | 1 +
 drivers/video/broadwell_igd.c                          | 1 +
 drivers/video/dw_hdmi.c                                | 1 +
 drivers/video/rockchip/rk_edp.c                        | 1 +
 drivers/video/tegra124/display.c                       | 1 +
 drivers/video/tegra124/dp.c                            | 1 +
 drivers/video/tegra124/sor.c                           | 1 +
 drivers/video/video-uclass.c                           | 1 +
 drivers/watchdog/booke_wdt.c                           | 1 +
 drivers/watchdog/sbsa_gwdt.c                           | 1 +
 fs/fs.c                                                | 1 +
 fs/ubifs/debug.c                                       | 1 +
 include/cli.h                                          | 1 +
 include/exports.h                                      | 1 +
 include/regmap.h                                       | 1 +
 include/time.h                                         | 1 +
 lib/dhry/cmd_dhry.c                                    | 1 +
 net/arp.c                                              | 1 +
 net/bootp.c                                            | 1 +
 net/dhcpv6.c                                           | 1 +
 net/dns.c                                              | 1 +
 net/fastboot_udp.c                                     | 1 +
 net/link_local.c                                       | 1 +
 net/ndisc.c                                            | 1 +
 net/net.c                                              | 1 +
 net/net6.c                                             | 1 +
 net/ping6.c                                            | 1 +
 net/sntp.c                                             | 1 +
 net/tcp.c                                              | 1 +
 net/tftp.c                                             | 1 +
 net/wget.c                                             | 1 +
 post/drivers/rtc.c                                     | 1 +
 test/common/cread.c                                    | 1 +
 test/dm/mux-cmd.c                                      | 1 +
 test/dm/regmap.c                                       | 1 +
 test/dm/wdt.c                                          | 1 +
 216 files changed, 216 insertions(+)

diff --git a/api/api.c b/api/api.c
index 89003c161c2f..0bd93759f7be 100644
--- a/api/api.c
+++ b/api/api.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <malloc.h>
 #include <env_internal.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <api_public.h>
diff --git a/arch/arm/include/asm/arch-tegra/timer.h b/arch/arm/include/asm/arch-tegra/timer.h
index 1c4decacd338..c5e9d841031a 100644
--- a/arch/arm/include/asm/arch-tegra/timer.h
+++ b/arch/arm/include/asm/arch-tegra/timer.h
@@ -9,6 +9,7 @@
 #define _TEGRA_TIMER_H
 
 /* returns the current monotonic timer value in microseconds */
+#include <time.h>
 unsigned long timer_get_us(void);
 
 #endif
diff --git a/arch/arm/mach-at91/arm920t/clock.c b/arch/arm/mach-at91/arm920t/clock.c
index 09ac66d619d2..5312798356b7 100644
--- a/arch/arm/mach-at91/arm920t/clock.c
+++ b/arch/arm/mach-at91/arm920t/clock.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2009 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 #include <common.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm926ejs/clock.c b/arch/arm/mach-at91/arm926ejs/clock.c
index 013daf43b742..90de2153dd48 100644
--- a/arch/arm/mach-at91/arm926ejs/clock.c
+++ b/arch/arm/mach-at91/arm926ejs/clock.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 8344daeb39a2..5b8ce52f5c1e 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <wdt.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/phy.c b/arch/arm/mach-at91/phy.c
index f4484a77c7de..3b6901bc9f76 100644
--- a/arch/arm/mach-at91/phy.c
+++ b/arch/arm/mach-at91/phy.c
@@ -12,6 +12,7 @@
  */
 
 #include <common.h>
+#include <time.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-bcm283x/mbox.c b/arch/arm/mach-bcm283x/mbox.c
index da9faafe1ddc..940699337f1e 100644
--- a/arch/arm/mach-bcm283x/mbox.c
+++ b/arch/arm/mach-bcm283x/mbox.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/base.h>
diff --git a/arch/arm/mach-bcmstb/include/mach/timer.h b/arch/arm/mach-bcmstb/include/mach/timer.h
index 039dd664c2c0..8505d2c4b537 100644
--- a/arch/arm/mach-bcmstb/include/mach/timer.h
+++ b/arch/arm/mach-bcmstb/include/mach/timer.h
@@ -8,6 +8,7 @@
 #ifndef _BCMSTB_TIMER_H
 #define _BCMSTB_TIMER_H
 
+#include <time.h>
 uint64_t get_ticks(void);
 
 #endif /* _BCMSTB_TIMER_H */
diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index f91f2ee862de..2e5aac4ecf38 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <clock_legacy.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-imx/i2c-mxv7.c b/arch/arm/mach-imx/i2c-mxv7.c
index a5866cf9f703..94b30823cca8 100644
--- a/arch/arm/mach-imx/i2c-mxv7.c
+++ b/arch/arm/mach-imx/i2c-mxv7.c
@@ -4,6 +4,7 @@
  */
 #include <common.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index 1bdc568f9b14..a51be6189311 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <div64.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/imx-regs.h>
diff --git a/arch/arm/mach-imx/mx7/clock.c b/arch/arm/mach-imx/mx7/clock.c
index 4e232385afc3..460eabc3ade3 100644
--- a/arch/arm/mach-imx/mx7/clock.c
+++ b/arch/arm/mach-imx/mx7/clock.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <div64.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-nexell/timer.c b/arch/arm/mach-nexell/timer.c
index 3b311fd22a56..437697329220 100644
--- a/arch/arm/mach-nexell/timer.c
+++ b/arch/arm/mach-nexell/timer.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
diff --git a/arch/arm/mach-omap2/omap3/am35x_musb.c b/arch/arm/mach-omap2/omap3/am35x_musb.c
index 1121acc00589..1c3f78a42101 100644
--- a/arch/arm/mach-omap2/omap3/am35x_musb.c
+++ b/arch/arm/mach-omap2/omap3/am35x_musb.c
@@ -10,6 +10,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
index 35bed3199422..31decc413d1e 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
@@ -9,6 +9,7 @@
 #include <dfu.h>
 #include <malloc.h>
 #include <serial.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/lists.h>
diff --git a/arch/arm/mach-stm32mp/pwr_regulator.c b/arch/arm/mach-stm32mp/pwr_regulator.c
index 846637ab162e..90401018adcc 100644
--- a/arch/arm/mach-stm32mp/pwr_regulator.c
+++ b/arch/arm/mach-stm32mp/pwr_regulator.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 631bc04e9506..c5ced7e3f389 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <errno.h>
+#include <time.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/tegra124/xusb-padctl.c b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
index 69736aa39255..a27ccfb260e0 100644
--- a/arch/arm/mach-tegra/tegra124/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-tegra/tegra210/clock.c b/arch/arm/mach-tegra/tegra210/clock.c
index 900537afbe50..73d9f9dd592e 100644
--- a/arch/arm/mach-tegra/tegra210/clock.c
+++ b/arch/arm/mach-tegra/tegra210/clock.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <init.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-tegra/tegra210/xusb-padctl.c b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
index 30d0395bb0e5..0af6e256ad18 100644
--- a/arch/arm/mach-tegra/tegra210/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
diff --git a/arch/mips/mach-mtmips/mt7620/init.c b/arch/mips/mach-mtmips/mt7620/init.c
index 93abf9228d68..b2e8e2882e22 100644
--- a/arch/mips/mach-mtmips/mt7620/init.c
+++ b/arch/mips/mach-mtmips/mt7620/init.c
@@ -6,6 +6,7 @@
  */
 
 #include <config.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <linux/io.h>
 #include "mt7620.h"
diff --git a/arch/mips/mach-mtmips/mt7621/init.c b/arch/mips/mach-mtmips/mt7621/init.c
index d21848ad23ba..a768cadce3d7 100644
--- a/arch/mips/mach-mtmips/mt7621/init.c
+++ b/arch/mips/mach-mtmips/mt7621/init.c
@@ -7,6 +7,7 @@
 
 #include <clk.h>
 #include <dm.h>
+#include <time.h>
 #include <dm/uclass.h>
 #include <dt-bindings/clock/mt7621-clk.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/mach-mtmips/mt7628/init.c b/arch/mips/mach-mtmips/mt7628/init.c
index 6b535129df12..df93b4343848 100644
--- a/arch/mips/mach-mtmips/mt7628/init.c
+++ b/arch/mips/mach-mtmips/mt7628/init.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <clk.h>
 #include <dm.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
 #include <dt-bindings/clock/mt7628-clk.h>
diff --git a/arch/mips/mach-octeon/clock.c b/arch/mips/mach-octeon/clock.c
index 119b3ac50b42..8984bfd74458 100644
--- a/arch/mips/mach-octeon/clock.c
+++ b/arch/mips/mach-octeon/clock.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018, 2019 Marvell International Ltd.
  */
 
+#include <time.h>
 #include <asm/global_data.h>
 #include <mach/clock.h>
 
diff --git a/arch/mips/mach-octeon/cvmx-helper-bgx.c b/arch/mips/mach-octeon/cvmx-helper-bgx.c
index 7d6e178a447a..f6e5a929a327 100644
--- a/arch/mips/mach-octeon/cvmx-helper-bgx.c
+++ b/arch/mips/mach-octeon/cvmx-helper-bgx.c
@@ -6,6 +6,7 @@
  */
 
 #include <log.h>
+#include <time.h>
 #include <linux/delay.h>
 
 #include <mach/cvmx-regs.h>
diff --git a/arch/mips/mach-octeon/cvmx-pcie.c b/arch/mips/mach-octeon/cvmx-pcie.c
index c2a2018a1f70..e46bb609af7c 100644
--- a/arch/mips/mach-octeon/cvmx-pcie.c
+++ b/arch/mips/mach-octeon/cvmx-pcie.c
@@ -6,6 +6,7 @@
  */
 
 #include <log.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
 
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-mdio.h b/arch/mips/mach-octeon/include/mach/cvmx-mdio.h
index 9bc138fa2770..8cd7d9df88cb 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-mdio.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-mdio.h
@@ -12,6 +12,7 @@
 /**
  * PHY register 0 from the 802.3 spec
  */
+#include <time.h>
 #define CVMX_MDIO_PHY_REG_CONTROL 0
 
 typedef union {
diff --git a/arch/mips/mach-octeon/include/mach/cvmx-regs.h b/arch/mips/mach-octeon/include/mach/cvmx-regs.h
index f97c1e907f0b..21e65985cd0e 100644
--- a/arch/mips/mach-octeon/include/mach/cvmx-regs.h
+++ b/arch/mips/mach-octeon/include/mach/cvmx-regs.h
@@ -7,6 +7,7 @@
 #define __CVMX_REGS_H__
 
 #include <log.h>
+#include <time.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index 2add2ff95405..70bd4a0f0f58 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -9,6 +9,7 @@
 
 #include <common.h>
 #include <irq_func.h>
+#include <time.h>
 #include <asm/processor.h>
 #include <watchdog.h>
 #ifdef CONFIG_LED_STATUS
diff --git a/arch/x86/cpu/acpi_gpe.c b/arch/x86/cpu/acpi_gpe.c
index da01e71335f1..f44f0e4c2b24 100644
--- a/arch/x86/cpu/acpi_gpe.c
+++ b/arch/x86/cpu/acpi_gpe.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <irq.h>
 #include <log.h>
+#include <time.h>
 #include <acpi/acpi_device.h>
 #include <asm/io.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/x86/cpu/apollolake/punit.c b/arch/x86/cpu/apollolake/punit.c
index 5ed7963579ea..8320d81b5630 100644
--- a/arch/x86/cpu/apollolake/punit.c
+++ b/arch/x86/cpu/apollolake/punit.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <log.h>
 #include <spl.h>
+#include <time.h>
 #include <asm/cpu.h>
 #include <asm/cpu_common.h>
 #include <asm/intel_regs.h>
diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index ff959d1bd8d8..615ba64df715 100644
--- a/arch/x86/cpu/intel_common/mrc.c
+++ b/arch/x86/cpu/intel_common/mrc.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <spl.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
diff --git a/arch/x86/cpu/mp_init.c b/arch/x86/cpu/mp_init.c
index a133a5d81161..9f0f6372dd56 100644
--- a/arch/x86/cpu/mp_init.c
+++ b/arch/x86/cpu/mp_init.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <qfw.h>
+#include <time.h>
 #include <asm/atomic.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
diff --git a/board/astro/mcf5373l/mcf5373l.c b/board/astro/mcf5373l/mcf5373l.c
index 43563c412793..8c5185b62322 100644
--- a/board/astro/mcf5373l/mcf5373l.c
+++ b/board/astro/mcf5373l/mcf5373l.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <init.h>
 #include <serial.h>
+#include <time.h>
 #include <watchdog.h>
 #include <command.h>
 #include <asm/global_data.h>
diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 8416af163ad1..04b0738bff6d 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -9,6 +9,7 @@
 #include <cpu_func.h>
 #include <flash.h>
 #include <irq_func.h>
+#include <time.h>
 #include <uuid.h>
 #include <linux/delay.h>
 
diff --git a/board/freescale/m5253demo/flash.c b/board/freescale/m5253demo/flash.c
index eeb9cfd31259..dd269c3c65db 100644
--- a/board/freescale/m5253demo/flash.c
+++ b/board/freescale/m5253demo/flash.c
@@ -11,6 +11,7 @@
 #include <flash.h>
 #include <init.h>
 #include <irq_func.h>
+#include <time.h>
 
 #include <asm/immap.h>
 
diff --git a/board/nokia/rx51/rx51.c b/board/nokia/rx51/rx51.c
index 238b9637badd..ca3bc5133d45 100644
--- a/board/nokia/rx51/rx51.c
+++ b/board/nokia/rx51/rx51.c
@@ -25,6 +25,7 @@
 #include <dm.h>
 #include <env.h>
 #include <init.h>
+#include <time.h>
 #include <watchdog.h>
 #include <wdt.h>
 #include <malloc.h>
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 9d58860451c5..867515837ee0 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <os.h>
+#include <time.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
 #include <asm/test.h>
diff --git a/board/theadorable/fpga.c b/board/theadorable/fpga.c
index bc8379cccf6d..3a33e15eacc6 100644
--- a/board/theadorable/fpga.c
+++ b/board/theadorable/fpga.c
@@ -7,6 +7,7 @@
 #include <altera.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/board/theadorable/theadorable.c b/board/theadorable/theadorable.c
index 144f122bb206..6f35a43e4e0d 100644
--- a/board/theadorable/theadorable.c
+++ b/board/theadorable/theadorable.c
@@ -14,6 +14,7 @@
 #if !defined(CONFIG_SPL_BUILD)
 #include <bootcount.h>
 #endif
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/cmd/clone.c b/cmd/clone.c
index a90620775712..4c7e6d2e8281 100644
--- a/cmd/clone.c
+++ b/cmd/clone.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <blk.h>
+#include <time.h>
 #include <vsprintf.h>
 
 #define BUFSIZE (1 * 1024 * 1024)
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 946f1d78184d..f12edfa6b727 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+#include <time.h>
  * A general-purpose cyclic execution infrastructure, to allow "small"
  * (run-time wise) functions to be executed at a specified frequency.
  * Things like LED blinking or watchdog triggering are examples for such
diff --git a/cmd/gettime.c b/cmd/gettime.c
index 2e74e02b4998..ebaa45812a68 100644
--- a/cmd/gettime.c
+++ b/cmd/gettime.c
@@ -13,6 +13,7 @@
  */
 #include <common.h>
 #include <command.h>
+#include <time.h>
 
 static int do_gettime(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
diff --git a/cmd/mem.c b/cmd/mem.c
index 66c2d36a1480..d0abf71f2333 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -24,6 +24,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <rand.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/cmd/sf.c b/cmd/sf.c
index 977ffcb63c10..e1a42d21518f 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -15,6 +15,7 @@
 #include <mapmem.h>
 #include <spi.h>
 #include <spi_flash.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <jffs2/jffs2.h>
 #include <linux/mtd/mtd.h>
diff --git a/cmd/sleep.c b/cmd/sleep.c
index c741b4aa029b..0cbbceccc313 100644
--- a/cmd/sleep.c
+++ b/cmd/sleep.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <command.h>
 #include <console.h>
+#include <time.h>
 #include <linux/delay.h>
 
 static int do_sleep(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/timer.c b/cmd/timer.c
index 551be5dd54ee..507a99562635 100644
--- a/cmd/timer.c
+++ b/cmd/timer.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <time.h>
 
 static int do_timer(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index c7fa6e775f55..3aca3fddba04 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <linux/printk.h>
 #include "tpm-user-utils.h"
diff --git a/common/command.c b/common/command.c
index 846e16e2ada2..efe825e82250 100644
--- a/common/command.c
+++ b/common/command.c
@@ -16,6 +16,7 @@
 #include <image.h>
 #include <log.h>
 #include <mapmem.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <linux/ctype.h>
 
diff --git a/common/dfu.c b/common/dfu.c
index 0d154e8d4c48..6d33cb32babe 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <command.h>
 #include <log.h>
+#include <time.h>
 #include <watchdog.h>
 #include <dfu.h>
 #include <console.h>
diff --git a/common/usb_hub.c b/common/usb_hub.c
index 85c0822d8b7b..bcc332693a45 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -29,6 +29,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <time.h>
 #include <asm/processor.h>
 #include <asm/unaligned.h>
 #include <linux/ctype.h>
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 4cbc9acb7380..e7d2aa9cf090 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <stdio_dev.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
 #ifdef CONFIG_SANDBOX
diff --git a/common/xyzModem.c b/common/xyzModem.c
index fb319f711907..cb9d3036b063 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -22,6 +22,7 @@
  *==========================================================================
  */
 #include <common.h>
+#include <time.h>
 #include <xyzModem.h>
 #include <stdarg.h>
 #include <u-boot/crc.h>
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cb2c648a91fd..725bd2f16816 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -12,6 +12,7 @@
 #include <blk.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 18c7a66db1bf..78395b173c0f 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -37,6 +37,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
diff --git a/drivers/crypto/nuvoton/npcm_aes.c b/drivers/crypto/nuvoton/npcm_aes.c
index 6493ea108ec7..b01292a19362 100644
--- a/drivers/crypto/nuvoton/npcm_aes.c
+++ b/drivers/crypto/nuvoton/npcm_aes.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <uboot_aes.h>
 #include <asm/io.h>
 #include <asm/arch/aes.h>
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index d9039443b91c..cb8ab1118295 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -13,6 +13,7 @@
 #include <hang.h>
 #include <ram.h>
 #include <reset.h>
+#include <time.h>
 #include "sdram_soc64.h"
 #include <wait_bit.h>
 #include <asm/arch/firewall.h>
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 4716abfc9a8b..f2cd16628c4b 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -15,6 +15,7 @@
 #include <log.h>
 #include <ram.h>
 #include <reset.h>
+#include <time.h>
 #include "sdram_soc64.h"
 #include <wait_bit.h>
 #include <asm/arch/firewall.h>
diff --git a/drivers/dma/lpc32xx_dma.c b/drivers/dma/lpc32xx_dma.c
index 0efdfd028cfd..3fd56053faee 100644
--- a/drivers/dma/lpc32xx_dma.c
+++ b/drivers/dma/lpc32xx_dma.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <errno.h>
 #include <init.h>
+#include <time.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clk.h>
diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
index 2e788c7a8ef5..bd31609818f2 100644
--- a/drivers/fpga/ACEX1K.c
+++ b/drivers/fpga/ACEX1K.c
@@ -13,6 +13,7 @@
 #include <console.h>
 #include <log.h>
 #include <ACEX1K.h>		/* ACEX device family */
+#include <time.h>
 #include <linux/delay.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
diff --git a/drivers/fpga/cyclon2.c b/drivers/fpga/cyclon2.c
index 6e8a313db35b..ca64af67c556 100644
--- a/drivers/fpga/cyclon2.c
+++ b/drivers/fpga/cyclon2.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <altera.h>
 #include <ACEX1K.h>		/* ACEX device family */
+#include <time.h>
 #include <linux/delay.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 903d143a361c..fbb4ea70914a 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <altera.h>
 #include <log.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index 96b195063e08..33adbd215293 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -4,6 +4,7 @@
  */
 #include <image.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/fpga_manager.h>
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index dd84e2e8cbb9..e9be356458bd 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -9,6 +9,7 @@
 #include <common.h>		/* core U-Boot definitions */
 #include <log.h>
 #include <spartan2.h>		/* Spartan-II device family */
+#include <time.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
  * overrun the device (the Slave Parallel mode can free run at 50MHz).
diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
index 95d4dd7d78b5..401f12f6d4c3 100644
--- a/drivers/fpga/spartan3.c
+++ b/drivers/fpga/spartan3.c
@@ -14,6 +14,7 @@
 #include <common.h>		/* core U-Boot definitions */
 #include <log.h>
 #include <spartan3.h>		/* Spartan-II device family */
+#include <time.h>
 
 /* Note: The assumption is that we cannot possibly run fast enough to
  * overrun the device (the Slave Parallel mode can free run at 50MHz).
diff --git a/drivers/fpga/virtex2.c b/drivers/fpga/virtex2.c
index 3ded27f9b3ff..ca2026ad03e1 100644
--- a/drivers/fpga/virtex2.c
+++ b/drivers/fpga/virtex2.c
@@ -17,6 +17,7 @@
 #include <common.h>
 #include <console.h>
 #include <log.h>
+#include <time.h>
 #include <virtex2.h>
 #include <linux/delay.h>
 
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index a2e3b305fa41..a6b3d413d703 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -10,6 +10,7 @@
 #include <console.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <fs.h>
diff --git a/drivers/hwspinlock/hwspinlock-uclass.c b/drivers/hwspinlock/hwspinlock-uclass.c
index e9a4d7f9fbbd..116bd6a00072 100644
--- a/drivers/hwspinlock/hwspinlock-uclass.c
+++ b/drivers/hwspinlock/hwspinlock-uclass.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <hwspinlock.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <linux/compat.h>
diff --git a/drivers/i2c/at91_i2c.c b/drivers/i2c/at91_i2c.c
index e743d2a849a3..ab6878031271 100644
--- a/drivers/i2c/at91_i2c.c
+++ b/drivers/i2c/at91_i2c.c
@@ -6,6 +6,7 @@
  */
 
 #include <malloc.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <common.h>
diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index e54de42abc39..594d5b298c86 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <pci.h>
 #include <reset.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include "designware_i2c.h"
diff --git a/drivers/i2c/i2c-cortina.c b/drivers/i2c/i2c-cortina.c
index 960ae8c700f9..bda600fb8414 100644
--- a/drivers/i2c/i2c-cortina.c
+++ b/drivers/i2c/i2c-cortina.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <mapmem.h>
diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index ad9293c92e1a..5746b93ed65d 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
diff --git a/drivers/i2c/intel_i2c.c b/drivers/i2c/intel_i2c.c
index 4fc6f1a11a75..bbc527ffddc8 100644
--- a/drivers/i2c/intel_i2c.c
+++ b/drivers/i2c/intel_i2c.c
@@ -12,6 +12,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <pci.h>
+#include <time.h>
 #include <asm/io.h>
 
 /* PCI Configuration Space (D31:F3): SMBus */
diff --git a/drivers/i2c/meson_i2c.c b/drivers/i2c/meson_i2c.c
index 434e3461b1dd..34e6fefee3cd 100644
--- a/drivers/i2c/meson_i2c.c
+++ b/drivers/i2c/meson_i2c.c
@@ -4,6 +4,7 @@
  */
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index ad730e0e79ff..9ad70f19bd2d 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -10,6 +10,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index d501133a0c8f..52110ad8d295 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -16,6 +16,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/global_data.h>
diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index ea4ef532565a..4f97263ca81c 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -6,6 +6,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <i2c.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/iopoll.h>
 #include <asm/arch/gcr.h>
diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
index 07cda0fa6793..adaa7988132c 100644
--- a/drivers/i2c/nx_i2c.c
+++ b/drivers/i2c/nx_i2c.c
@@ -3,6 +3,7 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <asm/arch/nexell.h>
 #include <asm/arch/reset.h>
 #include <asm/arch/clk.h>
diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
index 9927af94a80b..e55b08cc04b1 100644
--- a/drivers/i2c/rk_i2c.c
+++ b/drivers/i2c/rk_i2c.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/i2c.h>
diff --git a/drivers/i2c/s3c24x0_i2c.c b/drivers/i2c/s3c24x0_i2c.c
index 505e20bc61c8..746ee86f65ce 100644
--- a/drivers/i2c/s3c24x0_i2c.c
+++ b/drivers/i2c/s3c24x0_i2c.c
@@ -16,6 +16,7 @@
 #else
 #include <asm/arch/s3c24x0_cpu.h>
 #endif
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <i2c.h>
diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index b6c71789eec0..914ea2c06487 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -13,6 +13,7 @@
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
+#include <time.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/input/input.c b/drivers/input/input.c
index a4341e8c7ce9..d5ed5ac65019 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_DM_KEYBOARD
 #include <keyboard.h>
 #endif
+#include <time.h>
 #include <linux/input.h>
 
 enum {
diff --git a/drivers/input/tegra-kbc.c b/drivers/input/tegra-kbc.c
index d4741a76663e..cf11d57fdeff 100644
--- a/drivers/input/tegra-kbc.c
+++ b/drivers/input/tegra-kbc.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <stdio_dev.h>
 #include <tegra-kbc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
diff --git a/drivers/misc/cros_ec.c b/drivers/misc/cros_ec.c
index 9c1e6a5e3e70..060cb5124da9 100644
--- a/drivers/misc/cros_ec.c
+++ b/drivers/misc/cros_ec.c
@@ -24,6 +24,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <asm/io.h>
diff --git a/drivers/misc/cros_ec_lpc.c b/drivers/misc/cros_ec_lpc.c
index 1a8a81349c3a..21cd24de901d 100644
--- a/drivers/misc/cros_ec_lpc.c
+++ b/drivers/misc/cros_ec_lpc.c
@@ -17,6 +17,7 @@
 #include <command.h>
 #include <cros_ec.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 
 #ifdef DEBUG_TRACE
diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 8dbe0b188a48..0a9ede73c855 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -15,6 +15,7 @@
 #include <hash.h>
 #include <log.h>
 #include <os.h>
+#include <time.h>
 #include <u-boot/sha256.h>
 #include <spi.h>
 #include <asm/malloc.h>
diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
index 001f0a85ca98..d78890162571 100644
--- a/drivers/misc/cros_ec_spi.c
+++ b/drivers/misc/cros_ec_spi.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <log.h>
 #include <spi.h>
+#include <time.h>
 
 int cros_ec_spi_packet(struct udevice *udev, int out_bytes, int in_bytes)
 {
diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index fd667aeafdaa..71f6811e583f 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -14,6 +14,7 @@
 #include <regmap.h>
 #include <sdhci.h>
 #include <soc.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
index 5c23c03d10d7..1bb445fcd6ee 100644
--- a/drivers/mmc/bcm2835_sdhost.c
+++ b/drivers/mmc/bcm2835_sdhost.c
@@ -33,6 +33,7 @@
 #include <common.h>
 #include <dm.h>
 #include <mmc.h>
+#include <time.h>
 #include <asm/arch/msg.h>
 #include <asm/arch/mbox.h>
 #include <asm/unaligned.h>
diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 400066fa99a2..c8180761854d 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -14,6 +14,7 @@
 #include <memalign.h>
 #include <mmc.h>
 #include <dwmmc.h>
+#include <time.h>
 #include <wait_bit.h>
 #include <asm/cache.h>
 #include <linux/delay.h>
diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index d5066666698c..e087ba9795eb 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -20,6 +20,7 @@
 #include <malloc.h>
 #include <fsl_esdhc.h>
 #include <fdt_support.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 7c39c86c5e9c..57cfa2b31a99 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -20,6 +20,7 @@
 #include <log.h>
 #include <mmc.h>
 #include <part.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
diff --git a/drivers/mmc/ftsdc010_mci.c b/drivers/mmc/ftsdc010_mci.c
index cabb747fbbdb..8d60687dbd34 100644
--- a/drivers/mmc/ftsdc010_mci.c
+++ b/drivers/mmc/ftsdc010_mci.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <mmc.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index fcf4f03d1e24..ca6e2bd01b29 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <pwrseq.h>
 #include <mmc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index d96db7a0f836..ee9339152c10 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device-internal.h>
 #include <errno.h>
 #include <mmc.h>
diff --git a/drivers/mmc/mvebu_mmc.c b/drivers/mmc/mvebu_mmc.c
index fea55c61ed7d..7ac11ec34c2a 100644
--- a/drivers/mmc/mvebu_mmc.c
+++ b/drivers/mmc/mvebu_mmc.c
@@ -15,6 +15,7 @@
 #include <fdtdec.h>
 #include <part.h>
 #include <mmc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index a2595d19e7f6..fb7c4ed23b8d 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -34,6 +34,7 @@
 #if defined(CONFIG_OMAP54XX) || defined(CONFIG_OMAP44XX)
 #include <palmas.h>
 #endif
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index fc9c6c379964..b30ea6149939 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <mmc.h>
 #include <sdhci.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 23bc7da917a9..628727aa7087 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -21,6 +21,7 @@
 #include <mmc.h>
 #include <clk.h>
 #include <reset.h>
+#include <time.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
index f76fee3ea0f5..bdb8f2063fec 100644
--- a/drivers/mmc/tegra_mmc.c
+++ b/drivers/mmc/tegra_mmc.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <log.h>
 #include <mmc.h>
+#include <time.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/tegra_mmc.h>
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index 8ade7949a68e..c14d8cd98c62 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -26,6 +26,7 @@
 #include <init.h>
 #include <irq_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index efbf9a3120a4..6c4ccc2607b3 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -13,6 +13,7 @@
  */
 
 #include <common.h>
+#include <time.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 7853c3f74e2a..6d131dafaa18 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <malloc.h>
 #include <nand.h>
+#include <time.h>
 #include <dm/devres.h>
 
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 1d7c1fddd3f6..0524f29754e6 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <malloc.h>
 #include <nand.h>
+#include <time.h>
 #include <dm/devres.h>
 
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/mxs_nand_spl.c b/drivers/mtd/nand/raw/mxs_nand_spl.c
index 300662994cf2..65680f740169 100644
--- a/drivers/mtd/nand/raw/mxs_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxs_nand_spl.c
@@ -9,6 +9,7 @@
 #include <nand.h>
 #include <malloc.h>
 #include <mxs_nand.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b4adcf6bdc9..2dbbb40b49c0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -31,6 +31,7 @@
 #include <common.h>
 #include <log.h>
 #include <malloc.h>
+#include <time.h>
 #include <watchdog.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 1d9a6d107b17..5f92dd8e7415 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <fdtdec.h>
 #include <nand.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index 274489ecbc65..0c8b0e8c6901 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <time.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 0b5b74dc242d..bcd03f0a5473 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -31,6 +31,7 @@
 #include <memalign.h>
 #include <nand.h>
 #include <reset.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index d2363a0662e2..8736dd289b48 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -23,6 +23,7 @@
 
 #include <common.h>
 #include <malloc.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <linux/printk.h>
 
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4ee11e812d84..b8326df0598d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -22,6 +22,7 @@
 #else
 #include <common.h>
 #include <errno.h>
+#include <time.h>
 #include <watchdog.h>
 #include <spi.h>
 #include <spi-mem.h>
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 762b01c1b0f0..8f11472ee23d 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -21,6 +21,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <watchdog.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 6a0d953a7290..7960e4247711 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -15,6 +15,7 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <div64.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/math64.h>
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index db20feb4daed..a8d7cc9c7beb 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <display_options.h>
 #include <log.h>
+#include <time.h>
 #include <watchdog.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 0719fe845ca9..ffc0074d50cb 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -11,6 +11,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/errno.h>
diff --git a/drivers/net/ag7xxx.c b/drivers/net/ag7xxx.c
index da1f3f458080..92d50591fcfb 100644
--- a/drivers/net/ag7xxx.c
+++ b/drivers/net/ag7xxx.c
@@ -15,6 +15,7 @@
 #include <miiphy.h>
 #include <malloc.h>
 #include <net.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
diff --git a/drivers/net/altera_tse.c b/drivers/net/altera_tse.c
index e2340936fa62..c46040156ab9 100644
--- a/drivers/net/altera_tse.c
+++ b/drivers/net/altera_tse.c
@@ -17,6 +17,7 @@
 #include <memalign.h>
 #include <miiphy.h>
 #include <net.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/net/cortina_ni.c b/drivers/net/cortina_ni.c
index ef6ecd88b0ce..8d1a7bf44306 100644
--- a/drivers/net/cortina_ni.c
+++ b/drivers/net/cortina_ni.c
@@ -13,6 +13,7 @@
 #include <net.h>
 #include <miiphy.h>
 #include <env.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <u-boot/crc.h>
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 20b86e74cecf..90ddda5edc6d 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -19,6 +19,7 @@
 #include <net.h>
 #include <pci.h>
 #include <reset.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
index bec8d67dad0f..2add9a29770b 100644
--- a/drivers/net/dm9000x.c
+++ b/drivers/net/dm9000x.c
@@ -54,6 +54,7 @@
 #include <dm.h>
 #include <malloc.h>
 #include <net.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 
diff --git a/drivers/net/ethoc.c b/drivers/net/ethoc.c
index 13fad8119bb5..15b9d38a6d1d 100644
--- a/drivers/net/ethoc.c
+++ b/drivers/net/ethoc.c
@@ -13,6 +13,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <dm/platform_data/net_ethoc.h>
 #include <linux/io.h>
 #include <malloc.h>
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index ac937676f9c1..471eb2ef4fdf 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -17,6 +17,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <netdev.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index fae3adc3de34..a66d8041f9c6 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -14,6 +14,7 @@
 #include <net.h>
 #include <phy.h>
 #include <miiphy.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index 87fbada06ba2..1f60a70aac70 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <fsl-mc/fsl_dpmac.h>
 #include <fsl-mc/ldpaa_wriop.h>
diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 3cfce058451d..52a8fb9c9391 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -16,6 +16,7 @@
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
+#include <time.h>
 #include <wait_bit.h>
 #include <asm/cache.h>
 #include <asm/gpio.h>
diff --git a/drivers/net/npcm750_eth.c b/drivers/net/npcm750_eth.c
index 2028f4ae286e..8354626efae9 100644
--- a/drivers/net/npcm750_eth.c
+++ b/drivers/net/npcm750_eth.c
@@ -13,6 +13,7 @@
 #include <regmap.h>
 #include <serial.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
diff --git a/drivers/net/octeontx/smi.c b/drivers/net/octeontx/smi.c
index 233c26f7319a..7e247c96f43b 100644
--- a/drivers/net/octeontx/smi.c
+++ b/drivers/net/octeontx/smi.c
@@ -10,6 +10,7 @@
 #include <pci.h>
 #include <pci_ids.h>
 #include <phy.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/ctype.h>
diff --git a/drivers/net/octeontx2/nix_af.c b/drivers/net/octeontx2/nix_af.c
index c945ea0f5f22..c755dad55b7b 100644
--- a/drivers/net/octeontx2/nix_af.c
+++ b/drivers/net/octeontx2/nix_af.c
@@ -10,6 +10,7 @@
 #include <misc.h>
 #include <net.h>
 #include <pci.h>
+#include <time.h>
 #include <watchdog.h>
 #include <linux/types.h>
 #include <linux/list.h>
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index ecf8c28fe41b..1efc40911487 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <pci.h>
 #include <miiphy.h>
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 0bcd6cfd3f35..ca66c7ba699b 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <miiphy.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 5a69ca1a0f9e..fd9f9797658b 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -7,6 +7,7 @@
  * Based on the Renesas Ethernet AVB driver.
  */
 
+#include <time.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <common.h>
diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 93e83661cec4..270fe08be991 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -47,6 +47,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <net.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <pci.h>
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index 13022addb6a3..bf2ee3cc869c 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <time.h>
 #include <asm/eth.h>
 #include <asm/global_data.h>
 #include <asm/test.h>
diff --git a/drivers/net/xilinx_emaclite.c b/drivers/net/xilinx_emaclite.c
index 16ba915fbaaf..2bb6fa8a45dd 100644
--- a/drivers/net/xilinx_emaclite.c
+++ b/drivers/net/xilinx_emaclite.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <console.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <phy.h>
 #include <miiphy.h>
diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 438583aa0179..15302164aa63 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -36,6 +36,7 @@
 #include <pci.h>
 #include <pci_rom.h>
 #include <spl.h>
+#include <time.h>
 #include <vesa.h>
 #include <video.h>
 #include <acpi/acpi_s3.h>
diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
index 131c21b7684e..2fb1fe8dea4d 100644
--- a/drivers/pci/pci_tegra.c
+++ b/drivers/pci/pci_tegra.c
@@ -21,6 +21,7 @@
 #include <pci_tegra.h>
 #include <power-domain.h>
 #include <reset.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 
diff --git a/drivers/pci/pcie_dw_mvebu.c b/drivers/pci/pcie_dw_mvebu.c
index c41f3f153044..9451f5a58ef4 100644
--- a/drivers/pci/pcie_dw_mvebu.c
+++ b/drivers/pci/pcie_dw_mvebu.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 4195a02de390..2166af1fa071 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -11,6 +11,7 @@
 #include <power-domain.h>
 #include <regmap.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
diff --git a/drivers/pci/pcie_uniphier.c b/drivers/pci/pcie_uniphier.c
index f2edea9899a4..e73c573404c3 100644
--- a/drivers/pci/pcie_uniphier.c
+++ b/drivers/pci/pcie_uniphier.c
@@ -7,6 +7,7 @@
 #include <clk.h>
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
 #include <linux/bitfield.h>
diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
index d025188eae98..ec87d3fea2d0 100644
--- a/drivers/phy/phy-da8xx-usb.c
+++ b/drivers/phy/phy-da8xx-usb.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <asm/arch/hardware.h>
diff --git a/drivers/power/exynos-tmu.c b/drivers/power/exynos-tmu.c
index 6d62f6cae40d..4f1f1f112429 100644
--- a/drivers/power/exynos-tmu.c
+++ b/drivers/power/exynos-tmu.c
@@ -21,6 +21,7 @@
 #include <errno.h>
 #include <fdtdec.h>
 #include <log.h>
+#include <time.h>
 #include <tmu.h>
 #include <asm/arch/tmu.h>
 #include <asm/arch/power.h>
diff --git a/drivers/power/regulator/tps65090_regulator.c b/drivers/power/regulator/tps65090_regulator.c
index fa15e61a10e0..c253811e9d64 100644
--- a/drivers/power/regulator/tps65090_regulator.c
+++ b/drivers/power/regulator/tps65090_regulator.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index f36be941a38c..e8fb668ce2b0 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <hang.h>
 #include <log.h>
+#include <time.h>
 #include <dt-bindings/memory/rk3368-dmc.h>
 #include <dt-structs.h>
 #include <ram.h>
diff --git a/drivers/ram/stm32mp1/stm32mp1_interactive.c b/drivers/ram/stm32mp1/stm32mp1_interactive.c
index 2c19847c6633..a64867178df6 100644
--- a/drivers/ram/stm32mp1/stm32mp1_interactive.c
+++ b/drivers/ram/stm32mp1/stm32mp1_interactive.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <ram.h>
 #include <reset.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include "stm32mp1_ddr.h"
 #include "stm32mp1_tests.h"
diff --git a/drivers/rng/sandbox_rng.c b/drivers/rng/sandbox_rng.c
index cc5e1f6e25b6..a55e552177a6 100644
--- a/drivers/rng/sandbox_rng.c
+++ b/drivers/rng/sandbox_rng.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <rand.h>
 #include <rng.h>
+#include <time.h>
 
 #include <linux/string.h>
 
diff --git a/drivers/rtc/emul_rtc.c b/drivers/rtc/emul_rtc.c
index 6f47d82522ba..2ac067f2ffcd 100644
--- a/drivers/rtc/emul_rtc.c
+++ b/drivers/rtc/emul_rtc.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <env.h>
 #include <rtc.h>
+#include <time.h>
 #include <timestamp.h>
 
 /**
diff --git a/drivers/rtc/rv3029.c b/drivers/rtc/rv3029.c
index 3afe5b2fdd67..188560d3d459 100644
--- a/drivers/rtc/rv3029.c
+++ b/drivers/rtc/rv3029.c
@@ -14,6 +14,7 @@
 #include <i2c.h>
 #include <log.h>
 #include <rtc.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/sound/samsung-i2s.c b/drivers/sound/samsung-i2s.c
index dc5a2789aeed..001afc4ed738 100644
--- a/drivers/sound/samsung-i2s.c
+++ b/drivers/sound/samsung-i2s.c
@@ -9,6 +9,7 @@
 #include <i2s.h>
 #include <log.h>
 #include <sound.h>
+#include <time.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/i2s-regs.h>
diff --git a/drivers/sound/tegra_ahub.c b/drivers/sound/tegra_ahub.c
index 495a29c5137c..99d2dcded0b3 100644
--- a/drivers/sound/tegra_ahub.c
+++ b/drivers/sound/tegra_ahub.c
@@ -12,6 +12,7 @@
 #include <i2s.h>
 #include <log.h>
 #include <misc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/tegra_ahub.h>
 #include <asm/arch-tegra/tegra_i2s.h>
diff --git a/drivers/spi/altera_spi.c b/drivers/spi/altera_spi.c
index 989679e881b5..115efea9c2ef 100644
--- a/drivers/spi/altera_spi.c
+++ b/drivers/spi/altera_spi.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <fdtdec.h>
 #include <spi.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 
diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
index f35f5af1f6f8..032aeec714cc 100644
--- a/drivers/spi/apple_spi.c
+++ b/drivers/spi/apple_spi.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <clk.h>
 #include <spi.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 9ce2c0f254f3..895f57981b4d 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -27,6 +27,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <dma.h>
 #include <linux/bitops.h>
diff --git a/drivers/spi/ich.c b/drivers/spi/ich.c
index 9142ffd23870..705abc9cd9b3 100644
--- a/drivers/spi/ich.c
+++ b/drivers/spi/ich.c
@@ -22,6 +22,7 @@
 #include <spi_flash.h>
 #include <spi-mem.h>
 #include <spl.h>
+#include <time.h>
 #include <asm/fast_spi.h>
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
diff --git a/drivers/spi/mpc8xxx_spi.c b/drivers/spi/mpc8xxx_spi.c
index 7d15390c56b3..aeb2d1080cb8 100644
--- a/drivers/spi/mpc8xxx_spi.c
+++ b/drivers/spi/mpc8xxx_spi.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
+#include <time.h>
 #include <asm/mpc8xxx_spi.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 33360a183294..9125acafe836 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index ff7b55f8707e..e9a597d4e128 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -20,6 +20,7 @@
 #include <dm.h>
 #include <spi.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
diff --git a/drivers/spi/pic32_spi.c b/drivers/spi/pic32_spi.c
index 45f07f083da8..4fe40dd39ea2 100644
--- a/drivers/spi/pic32_spi.c
+++ b/drivers/spi/pic32_spi.c
@@ -10,6 +10,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 596c22aa0108..914eadad9273 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -8,6 +8,7 @@
  *	   Jon Lin <Jon.lin@rock-chips.com>
  */
 
+#include <time.h>
 #include <asm/io.h>
 #include <bouncebuf.h>
 #include <clk.h>
diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index cb52c0f30721..a987a4f79560 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -9,6 +9,7 @@
 #include <clk.h>
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/timer/sandbox_timer.c b/drivers/timer/sandbox_timer.c
index 1da7e0c3a768..113d58b4cb14 100644
--- a/drivers/timer/sandbox_timer.c
+++ b/drivers/timer/sandbox_timer.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
+#include <time.h>
 #include <timer.h>
 #include <os.h>
 
diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index acf4c7859a9f..35d8067c384c 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -13,6 +13,7 @@
 #include <irq.h>
 #include <log.h>
 #include <spl.h>
+#include <time.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
 #include <acpi/acpigen.h>
diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
index b2286f7e7edc..fcd5c3668eea 100644
--- a/drivers/tpm/tpm-uclass.c
+++ b/drivers/tpm/tpm-uclass.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <tpm_api.h>
 #include <tpm-v1.h>
 #include <tpm-v2.h>
diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
index 985a81621986..517fbf0f0c09 100644
--- a/drivers/tpm/tpm2_tis_core.c
+++ b/drivers/tpm/tpm2_tis_core.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <tpm-v2.h>
 #include <linux/delay.h>
 #include <linux/unaligned/be_byteshift.h>
diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index de9cf8f21e07..06c761d15d40 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -18,6 +18,7 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <spi.h>
+#include <time.h>
 #include <tpm-v2.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/tpm/tpm_atmel_twi.c b/drivers/tpm/tpm_atmel_twi.c
index fd2a45d34b03..106a48fea1cf 100644
--- a/drivers/tpm/tpm_atmel_twi.c
+++ b/drivers/tpm/tpm_atmel_twi.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <display_options.h>
 #include <dm.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <i2c.h>
 #include <asm/unaligned.h>
diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index 16f4af0e331e..a7d780a8bac5 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -24,6 +24,7 @@
 #include <fdtdec.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/tpm/tpm_tis_st33zp24_i2c.c b/drivers/tpm/tpm_tis_st33zp24_i2c.c
index e0eeabb93371..5deae5f47c4e 100644
--- a/drivers/tpm/tpm_tis_st33zp24_i2c.c
+++ b/drivers/tpm/tpm_tis_st33zp24_i2c.c
@@ -17,6 +17,7 @@
 #include <fdtdec.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <errno.h>
 #include <linux/delay.h>
diff --git a/drivers/tpm/tpm_tis_st33zp24_spi.c b/drivers/tpm/tpm_tis_st33zp24_spi.c
index f0de8a65b093..4aec9200cb75 100644
--- a/drivers/tpm/tpm_tis_st33zp24_spi.c
+++ b/drivers/tpm/tpm_tis_st33zp24_spi.c
@@ -17,6 +17,7 @@
 #include <fdtdec.h>
 #include <log.h>
 #include <spi.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <errno.h>
 #include <linux/delay.h>
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 7c48d57f99d6..ad5dc1ac7952 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
diff --git a/drivers/usb/eth/smsc95xx.c b/drivers/usb/eth/smsc95xx.c
index de6586e62639..7a686cc3b72f 100644
--- a/drivers/usb/eth/smsc95xx.c
+++ b/drivers/usb/eth/smsc95xx.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <net.h>
+#include <time.h>
 #include <usb.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 36618f0bdf36..6616aef9b7bf 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <log.h>
 #include <part.h>
+#include <time.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 637eb2dd06f5..59172e529ac9 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <phys2bus.h>
+#include <time.h>
 #include <usb.h>
 #include <usbroothubdes.h>
 #include <wait_bit.h>
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 9839aa17492d..d5dcfbbfa7ed 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <asm/unaligned.h>
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 765336a3c42b..d0edabcf39e6 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -12,6 +12,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <time.h>
 #include <usb.h>
 #include <linux/delay.h>
 #include <usb/ulpi.h>
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 33c4a911a090..faea8c185e6b 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <malloc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c8260cbdf94b..52b24b8204b9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -16,6 +16,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/byteorder.h>
 #include <usb.h>
 #include <asm/unaligned.h>
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index a6c4d97aee3f..efacca8485fa 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -8,6 +8,7 @@
 
 #include <hexdump.h>
 #include <common.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
index 0a52e09e19f1..ea0a944a87bb 100644
--- a/drivers/usb/musb-new/am35x.c
+++ b/drivers/usb/musb-new/am35x.c
@@ -25,6 +25,7 @@
 #include <plat/usb.h>
 #else
 #include <common.h>
+#include <time.h>
 #include <asm/omap_musb.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
diff --git a/drivers/usb/musb-new/musb_dsps.c b/drivers/usb/musb-new/musb_dsps.c
index a8ff7434c9f7..2facd168ec4f 100644
--- a/drivers/usb/musb-new/musb_dsps.c
+++ b/drivers/usb/musb-new/musb_dsps.c
@@ -33,6 +33,7 @@
 #else
 #include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <asm/omap_musb.h>
 #include <linux/printk.h>
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 7cea9a2ed65c..303284622707 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -2,6 +2,7 @@
 #include <console.h>
 #include <dm.h>
 #include <malloc.h>
+#include <time.h>
 #include <watchdog.h>
 #include <linux/delay.h>
 #include <linux/err.h>
diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index 308eff832c9e..cc6f03c3a377 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <log.h>
 #include <serial.h>
+#include <time.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
diff --git a/drivers/video/broadwell_igd.c b/drivers/video/broadwell_igd.c
index 83b6c908a8db..71fc79d6bc67 100644
--- a/drivers/video/broadwell_igd.c
+++ b/drivers/video/broadwell_igd.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <init.h>
 #include <log.h>
+#include <time.h>
 #include <vesa.h>
 #include <video.h>
 #include <asm/cpu.h>
diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index c4fbb1829446..16db3d38a2c2 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <fdtdec.h>
 #include <log.h>
+#include <time.h>
 #include <asm/io.h>
 #include <i2c.h>
 #include <media_bus_format.h>
diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 3697d582510a..8208f0ead4a9 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -8,6 +8,7 @@
 #include <clk.h>
 #include <display.h>
 #include <dm.h>
+#include <time.h>
 #include <dm/device_compat.h>
 #include <edid.h>
 #include <log.h>
diff --git a/drivers/video/tegra124/display.c b/drivers/video/tegra124/display.c
index 9261cc9384a2..5691364849b7 100644
--- a/drivers/video/tegra124/display.c
+++ b/drivers/video/tegra124/display.c
@@ -14,6 +14,7 @@
 #include <edid.h>
 #include <log.h>
 #include <part.h>
+#include <time.h>
 #include <video.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/drivers/video/tegra124/dp.c b/drivers/video/tegra124/dp.c
index b27b1633bab5..5f14d41bb688 100644
--- a/drivers/video/tegra124/dp.c
+++ b/drivers/video/tegra124/dp.c
@@ -10,6 +10,7 @@
 #include <div64.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <video_bridge.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/dc.h>
diff --git a/drivers/video/tegra124/sor.c b/drivers/video/tegra124/sor.c
index 258685182c7d..415324366282 100644
--- a/drivers/video/tegra124/sor.c
+++ b/drivers/video/tegra124/sor.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <panel.h>
 #include <syscon.h>
+#include <time.h>
 #include <video_bridge.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c818..bd1bcd6f66c4 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -15,6 +15,7 @@
 #include <mapmem.h>
 #include <spl.h>
 #include <stdio_dev.h>
+#include <time.h>
 #include <video.h>
 #include <video_console.h>
 #include <asm/cache.h>
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 50c091956e73..b0050e7c386d 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -5,6 +5,7 @@
 
 #include <div64.h>
 #include <dm.h>
+#include <time.h>
 #include <wdt.h>
 #include <asm/processor.h>
 
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 96d04665d52c..b9debdedd36c 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -5,6 +5,7 @@
  * Copyright 2020 NXP
  */
 
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <common.h>
diff --git a/fs/fs.c b/fs/fs.c
index cfc781bbb8d8..5351c560e721 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -21,6 +21,7 @@
 #include <fs.h>
 #include <sandboxfs.h>
 #include <semihostingfs.h>
+#include <time.h>
 #include <ubifs_uboot.h>
 #include <btrfs.h>
 #include <asm/global_data.h>
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index ff2a5719c3eb..de9c644a952e 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -17,6 +17,7 @@
 
 #include <hexdump.h>
 #include <log.h>
+#include <time.h>
 #include <dm/devres.h>
 #include <linux/printk.h>
 
diff --git a/include/cli.h b/include/cli.h
index 094a6602d70e..9ac9f80a86b5 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -8,6 +8,7 @@
 #define __CLI_H
 
 #include <stdbool.h>
+#include <time.h>
 
 /**
  * struct cli_ch_state - state information for reading cmdline characters
diff --git a/include/exports.h b/include/exports.h
index 6f8c9cf4517e..0452de735b9c 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -12,6 +12,7 @@
 #endif
 
 #include <irq_func.h>
+#include <time.h>
 
 struct cmd_tbl;
 struct spi_slave;
diff --git a/include/regmap.h b/include/regmap.h
index 22b043408acb..135cb7fcbcdf 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -7,6 +7,7 @@
 #ifndef __REGMAP_H
 #define __REGMAP_H
 
+#include <time.h>
 #include <linux/delay.h>
 
 /**
diff --git a/include/time.h b/include/time.h
index 3b2ba0912470..0b357df1e268 100644
--- a/include/time.h
+++ b/include/time.h
@@ -3,6 +3,7 @@
 #ifndef _TIME_H
 #define _TIME_H
 
+#include <time.h>
 #include <linux/typecheck.h>
 #include <linux/types.h>
 
diff --git a/lib/dhry/cmd_dhry.c b/lib/dhry/cmd_dhry.c
index 77b52a23003c..3101235058e3 100644
--- a/lib/dhry/cmd_dhry.c
+++ b/lib/dhry/cmd_dhry.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <command.h>
 #include <div64.h>
+#include <time.h>
 #include "dhry.h"
 
 static int do_dhry(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/net/arp.c b/net/arp.c
index 37848ad32fbd..742e0438130b 100644
--- a/net/arp.c
+++ b/net/arp.c
@@ -13,6 +13,7 @@
 #include <env.h>
 #include <log.h>
 #include <net.h>
+#include <time.h>
 #include <linux/delay.h>
 
 #include "arp.h"
diff --git a/net/bootp.c b/net/bootp.c
index 8b1a4ae2ef8a..594eeb196dc9 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <net.h>
 #include <rand.h>
+#include <time.h>
 #include <uuid.h>
 #include <linux/delay.h>
 #include <net/tftp.h>
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 73a1067877cf..34ac66b40254 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <net6.h>
 #include <malloc.h>
+#include <time.h>
 #include <linux/delay.h>
 #include "net_rand.h"
 #include "dhcpv6.h"
diff --git a/net/dns.c b/net/dns.c
index 5b1fe5b01037..677e39dd0318 100644
--- a/net/dns.c
+++ b/net/dns.c
@@ -27,6 +27,7 @@
 #include <env.h>
 #include <log.h>
 #include <net.h>
+#include <time.h>
 #include <asm/unaligned.h>
 
 #include "dns.h"
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index d6907874787e..58cd3c7ae1c2 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <fastboot.h>
 #include <net.h>
+#include <time.h>
 #include <net/fastboot_udp.h>
 #include <linux/printk.h>
 
diff --git a/net/link_local.c b/net/link_local.c
index 8aec3c79969b..16bc5c8b90ad 100644
--- a/net/link_local.c
+++ b/net/link_local.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <net.h>
 #include <rand.h>
+#include <time.h>
 #include "arp.h"
 #include "net_rand.h"
 
diff --git a/net/ndisc.c b/net/ndisc.c
index d1cec0601c83..4518f34b2078 100644
--- a/net/ndisc.c
+++ b/net/ndisc.c
@@ -14,6 +14,7 @@
 #include <net6.h>
 #include <ndisc.h>
 #include <stdlib.h>
+#include <time.h>
 #include <linux/delay.h>
 
 /* IPv6 destination address of packet waiting for ND */
diff --git a/net/net.c b/net/net.c
index e6f61f0f8f6a..ee10fb61d6f9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -93,6 +93,7 @@
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
+#include <time.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/tftp.h>
diff --git a/net/net6.c b/net/net6.c
index 2dd64c0e1618..cb47b79109da 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
+#include <time.h>
 
 /* NULL IPv6 address */
 struct in6_addr const net_null_addr_ip6 = ZERO_IPV6_ADDR;
diff --git a/net/ping6.c b/net/ping6.c
index 4882a17f510b..1707da21c3d6 100644
--- a/net/ping6.c
+++ b/net/ping6.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <net.h>
 #include <net6.h>
+#include <time.h>
 #include "ndisc.h"
 
 static ushort seq_no;
diff --git a/net/sntp.c b/net/sntp.c
index dac0f8ceea1b..81c85e3c2f93 100644
--- a/net/sntp.c
+++ b/net/sntp.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <net.h>
 #include <rtc.h>
+#include <time.h>
 
 #include <net/sntp.h>
 
diff --git a/net/tcp.c b/net/tcp.c
index a713e1dd6096..6c56a38f0830 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -23,6 +23,7 @@
 #include <env_internal.h>
 #include <errno.h>
 #include <net.h>
+#include <time.h>
 #include <net/tcp.h>
 
 /*
diff --git a/net/tftp.c b/net/tftp.c
index 88e71e67de35..e1e5925aabf8 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -16,6 +16,7 @@
 #include <mapmem.h>
 #include <net.h>
 #include <net6.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
diff --git a/net/wget.c b/net/wget.c
index 2dbfeb1a1d5b..07b274bf0f21 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -11,6 +11,7 @@
 #include <image.h>
 #include <mapmem.h>
 #include <net.h>
+#include <time.h>
 #include <net/tcp.h>
 #include <net/wget.h>
 
diff --git a/post/drivers/rtc.c b/post/drivers/rtc.c
index 9eeb02794715..45303c48f435 100644
--- a/post/drivers/rtc.c
+++ b/post/drivers/rtc.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <time.h>
 
 /*
  * RTC test
diff --git a/test/common/cread.c b/test/common/cread.c
index 2fdd29a265f7..a6ce72f1386f 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <cli.h>
+#include <time.h>
 #include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/dm/mux-cmd.c b/test/dm/mux-cmd.c
index 11c237b5da90..a14bfa8e3fbd 100644
--- a/test/dm/mux-cmd.c
+++ b/test/dm/mux-cmd.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <mux.h>
 #include <mux-internal.h>
+#include <time.h>
 #include <dt-bindings/mux/mux.h>
 #include <asm/test.h>
 #include <dm/test.h>
diff --git a/test/dm/regmap.c b/test/dm/regmap.c
index 8560f2afc2d1..ea71d795ca7e 100644
--- a/test/dm/regmap.c
+++ b/test/dm/regmap.c
@@ -10,6 +10,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <rand.h>
+#include <time.h>
 #include <asm/test.h>
 #include <dm/test.h>
 #include <dm/devres.h>
diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 653d7b1c8b36..3d7adb169dae 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <cyclic.h>
 #include <dm.h>
+#include <time.h>
 #include <wdt.h>
 #include <asm/gpio.h>
 #include <asm/state.h>
-- 
2.42.0.515.g380fc7ccd1-goog

