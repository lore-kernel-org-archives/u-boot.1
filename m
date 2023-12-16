Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C787EC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CC487C14;
	Sat, 16 Dec 2023 20:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lv1KsHRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6AD87716; Sat, 16 Dec 2023 20:38:49 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF4A87650
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58d1b767b2bso1322186eaf.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702755526; x=1703360326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a2xHVtkrJtH9FDgQIcpFIMv+E4VtCO2OSjpQOW5nWH0=;
 b=Lv1KsHRwccbeVj3YRb2e8P0ZQ6R+hcXFwoQPV5AOtvvzwx5/RJsgQAkwza6Cfpe15w
 o8uzFZZTPhT35OqALkc329sOHoS5fWlWvvlhJ5QIIc6F1ED7SbBRVP0kAf0nOP90BOYy
 hNfgms9TZxhRDXjkZokLBuHWGsPx7RN+cjZe1EcDk7+ENzs0dvH5/QA3Eg/I1QNqxG3K
 fSVYG1mktAPzmmYl+U8CjMFgwl/TQREe3dEVxuyoAoEbklRqAkgBiIIqMchZX7xMHdRH
 sPiZXPWnhwCdmCWdXavw1JGAef47+yP1PZqLdN2yDZwP6eoNzPga4z8A1sGGynjmL1/S
 H25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702755526; x=1703360326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2xHVtkrJtH9FDgQIcpFIMv+E4VtCO2OSjpQOW5nWH0=;
 b=RGmOY0zBF6YMMs5j4046HZFoPYliUHhwwv5G0UoLLcoOLzR0kT3c3EdxaZBEnhX2JI
 5eMZU2m1a7McVPqn2QUCAK/ix7ePBtrrEFQpodYDD+12+ZKQeVrsR35OelLYdPRKfY9j
 4hrKcQ0/17KfPPy8KmmuNIHpoD898yeNQs398J1Qdw9jgkROtV8dgVc4CdU6nbn8L3Yz
 eHlQNk40c6keGb4IDxkBwl8QEvBmxixgfK3clYHL1+b1DpRYLAW9Nkhw6yySnqO8bCf0
 Duj1WBXi8zyMQWJkpigDcL7mDUjp/zw+W/5et8EBaEDwjSV4pNTIJIQNDd4Mq+KX55ef
 GiCA==
X-Gm-Message-State: AOJu0Yw1mwyGS08AK7mJdEe48WEjWhB0DRlnHwPyzyQhHMoSlEqOm9wE
 tE0CvqhW8B5v7gg9si288VFvO9w4b8xwyg==
X-Google-Smtp-Source: AGHT+IH0gzRv6S7hjMI+qAn51CyUBTKPqY86c7LwEWSsDcssFFjlL8GInqDuDeU+/+JpWeisV0r+MA==
X-Received: by 2002:a05:6358:e484:b0:16d:fc53:8528 with SMTP id
 by4-20020a056358e48400b0016dfc538528mr14229813rwb.7.1702755525660; 
 Sat, 16 Dec 2023 11:38:45 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 u14-20020a05620a120e00b0077d73fde842sm6948960qkj.56.2023.12.16.11.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 11:38:45 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/3] clk: Remove clk_free and better document clk_ops
Date: Sat, 16 Dec 2023 14:38:40 -0500
Message-Id: <20231216193843.2463779-1-seanga2@gmail.com>
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

This series contains two unrelated changes. They are included together because
they touch the same files and would otherwise conflict. The first change is to
completely remove clk_free. This is because the op it calls (rfree) is
completely unused. I believe the original intent of this op was to allow clock
drivers to free resources allocated in request. However, no clock drivers do
this, so we can remove the function and all its callers.

The second change is to document the expected behavior and return codes of all
clock functions. At the moment, drivers are very inconsistent. I would like to
have some easily-verified expected behavior we can use when reviewing clock
drivers. Existing code is not fixed, but I hope to make some conversions in the
future.


Sean Anderson (3):
  clk: Remove rfree
  treewide: Remove clk_free
  clk: Document clk_ops return codes and behavior

 arch/arm/mach-rockchip/rk3288/rk3288.c        |   2 -
 arch/arm/mach-socfpga/clock_manager_agilex.c  |   2 -
 arch/arm/mach-socfpga/clock_manager_arria10.c |   7 +-
 arch/arm/mach-socfpga/clock_manager_n5x.c     |   2 -
 arch/arm/mach-zynq/clk.c                      |   2 -
 arch/mips/mach-pic32/cpu.c                    |   7 +-
 arch/sandbox/include/asm/clk.h                |   8 --
 board/microchip/pic32mzda/pic32mzda.c         |   2 -
 board/sipeed/maix/maix.c                      |   1 -
 board/synopsys/hsdk/clk-lib.c                 |   2 -
 drivers/clk/aspeed/clk_ast2600.c              |   2 -
 drivers/clk/at91/compat.c                     |  14 +-
 drivers/clk/clk-uclass.c                      |  40 +-----
 drivers/clk/clk-xlnx-clock-wizard.c           |   1 -
 drivers/clk/clk_sandbox.c                     |  12 --
 drivers/clk/clk_sandbox_test.c                |  12 --
 drivers/clk/clk_versaclock.c                  |  12 +-
 drivers/clk/clk_zynq.c                        |   2 -
 drivers/clk/clk_zynqmp.c                      |   2 -
 drivers/clk/imx/clk-imx8.c                    |   2 -
 drivers/clk/mvebu/armada-37xx-periph.c        |   2 -
 drivers/cpu/riscv_cpu.c                       |   2 -
 drivers/dma/bcm6348-iudma.c                   |   2 -
 drivers/gpio/at91_gpio.c                      |   2 -
 drivers/gpio/atmel_pio4.c                     |   2 -
 drivers/gpio/gpio-rcar.c                      |   1 -
 drivers/hwspinlock/stm32_hwspinlock.c         |   6 +-
 drivers/i2c/at91_i2c.c                        |   2 -
 drivers/i2c/designware_i2c.c                  |   2 -
 drivers/i2c/i2c-microchip.c                   |   2 -
 drivers/i2c/npcm_i2c.c                        |   1 -
 drivers/i2c/ocores_i2c.c                      |   2 -
 drivers/i2c/stm32f7_i2c.c                     |   4 +-
 drivers/mailbox/stm32-ipcc.c                  |   7 +-
 drivers/misc/ls2_sfp.c                        |   1 -
 drivers/mmc/arm_pl180_mmci.c                  |   1 -
 drivers/mmc/aspeed_sdhci.c                    |   4 +-
 drivers/mmc/atmel_sdhci.c                     |   2 -
 drivers/mmc/gen_atmel_mci.c                   |  19 +--
 drivers/mmc/msm_sdhci.c                       |   1 -
 drivers/mmc/pic32_sdhci.c                     |   1 -
 drivers/mmc/renesas-sdhi.c                    |  21 +--
 drivers/mmc/snps_dw_mmc.c                     |   8 +-
 drivers/mmc/socfpga_dw_mmc.c                  |   1 -
 drivers/mmc/stm32_sdmmc2.c                    |   4 +-
 drivers/mmc/uniphier-sd.c                     |   1 -
 drivers/mtd/nand/raw/atmel/nand-controller.c  |   4 +-
 drivers/mtd/renesas_rpc_hf.c                  |   1 -
 drivers/net/bcm6348-eth.c                     |   2 -
 drivers/net/bcm6368-eth.c                     |   2 -
 drivers/net/designware.c                      |   1 -
 drivers/net/dwc_eth_qos.c                     |  43 +-----
 drivers/net/dwc_eth_qos_imx.c                 |  21 +--
 drivers/net/dwc_eth_qos_qcom.c                |   1 -
 drivers/net/dwc_eth_qos_rockchip.c            |   6 +-
 drivers/net/sni_ave.c                         |   5 +-
 drivers/net/ti/am65-cpsw-nuss.c               |   1 -
 drivers/phy/bcm6318-usbh-phy.c                |   2 -
 drivers/phy/bcm6348-usbh-phy.c                |   2 -
 drivers/phy/bcm6368-usbh-phy.c                |   4 -
 drivers/phy/meson-axg-mipi-dphy.c             |   1 -
 drivers/phy/meson-g12a-usb3-pcie.c            |   1 -
 drivers/phy/meson-gxl-usb2.c                  |   1 -
 drivers/phy/phy-rcar-gen2.c                   |   1 -
 drivers/phy/phy-rcar-gen3.c                   |   1 -
 drivers/pinctrl/pinctrl-k210.c                |  20 +--
 drivers/power/domain/imx8mp-hsiomix.c         |   4 +-
 drivers/rtc/stm32_rtc.c                       |  16 +--
 drivers/serial/atmel_usart.c                  |   2 -
 drivers/serial/serial_bcm6345.c               |   1 -
 drivers/serial/serial_msm.c                   |   1 -
 drivers/serial/serial_pic32.c                 |   1 -
 drivers/spi/atcspi200_spi.c                   |   1 -
 drivers/spi/atmel-quadspi.c                   |  14 +-
 drivers/spi/atmel_spi.c                       |   2 -
 drivers/spi/bcm63xx_hsspi.c                   |   4 -
 drivers/spi/bcm63xx_spi.c                     |   2 -
 drivers/spi/bcmbca_hsspi.c                    |   4 -
 drivers/spi/cadence_qspi.c                    |   1 -
 drivers/spi/designware_spi.c                  |   5 -
 drivers/spi/meson_spifc_a1.c                  |  10 --
 drivers/spi/mvebu_a3700_spi.c                 |  10 --
 drivers/spi/spi-aspeed-smc.c                  |   1 -
 drivers/spi/stm32_spi.c                       |  19 +--
 drivers/timer/dw-apb-timer.c                  |   2 -
 drivers/timer/ostm_timer.c                    |   2 -
 drivers/usb/dwc3/dwc3-meson-g12a.c            |   4 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c             |   4 +-
 drivers/usb/host/ehci-atmel.c                 |   8 +-
 drivers/usb/host/ohci-da8xx.c                 |   1 -
 drivers/usb/host/xhci-rcar.c                  |   5 +-
 drivers/video/atmel_hlcdfb.c                  |   2 -
 drivers/video/mali_dp.c                       |  11 +-
 drivers/video/rockchip/rk3288_hdmi.c          |   4 +-
 drivers/video/rockchip/rk_edp.c               |   8 +-
 drivers/watchdog/designware_wdt.c             |  18 +--
 drivers/watchdog/meson_gxbb_wdt.c             |   4 +-
 include/clk-uclass.h                          | 123 +++++++++++++++---
 include/clk.h                                 |  31 -----
 test/dm/clk.c                                 |   9 --
 100 files changed, 174 insertions(+), 515 deletions(-)

-- 
2.37.1

