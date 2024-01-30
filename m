Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD565C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E1687751;
	Tue, 30 Jan 2024 05:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lFo1Ypj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A7E87BDB; Tue, 30 Jan 2024 05:43:28 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DFD8772A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42ab03a5aeeso6316331cf.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 20:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706589804; x=1707194604; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvhV13/dVLpLn802RCJASIhxdkS2110fdTbnDBbe2M0=;
 b=lFo1Ypj0pkEZP66Sg3gUoznBI+C5gG8t26Tju/PZAU5HVdUVCJlW4ldRYpaaQUzGUr
 AT9jWjFzXyGMqso/lt8OExpgJ2U8vju6AQ32nQ5R/J7ua8JlJfSsUD5o7dkXrfXF4BIx
 2mfbZmVgZ8S1AoVf5uUPbYgLfAiUx24OkycE0bS7Vj4hPHArcieHqvrvS7pQmLXxrTt4
 5cFQYreEHeE9FBk6IaeqgrSL0LfSHZMxyn+k/FzogXcvO3zmXPd8uKtVy9+Cba9cxEza
 ekU4AIYARtnWfBn5OxCX4EcNy4gTIek8xOLJR4eivCCTVf5yrhUqPabOnPB5rsieffaf
 T6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589804; x=1707194604;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IvhV13/dVLpLn802RCJASIhxdkS2110fdTbnDBbe2M0=;
 b=jHGON346VVQTBlF6ssf+zNKy5cRgs4aGzFJXsjsMx0+SmclnMEgA9UTo2bIC5Yt1jU
 BcphgLiaFxGnp9iX0KK+Bpq0TtMoM12SiGx+1i8Y9xMG4aUXFkr6B2R+TlONMexQklXK
 7uWPEKjy03jZOQyX+LgVEq2Ab7HLewissHnFUsrdEZ4wXQPRt5NQrQbHRix+D08h1cpH
 1HCeOs61vvPh0OydDs1IrzVCyDY5NLb3w1rzI1pKFw2jBV91qxYlNrClzzmpt+vT8cmQ
 f0VCtjASu2Gq5kUZck5QF4beYeoBeoup8Llqw5oI0+rllqUreQexxbufgi1OEaSr7O/0
 NEVQ==
X-Gm-Message-State: AOJu0YzUwXMsY2V9K8EkVgLYt+tyDGupXCImn1HY3VSLsplgCvbLjqIc
 gUFA7l2EqJ8WHZIvwx1QJGuLbkU3lleF75S0pXon5VQMX2U8lt+z
X-Google-Smtp-Source: AGHT+IGOFBbyNlZZ8ph/9mivAgsS9m4g9r/3EiHFAuYBq4HIPA+xBxSrGb42N4eCK5EDtjydZBQPoA==
X-Received: by 2002:ac8:5bcd:0:b0:42a:b264:f4e1 with SMTP id
 b13-20020ac85bcd000000b0042ab264f4e1mr1582725qtb.1.1706589804218; 
 Mon, 29 Jan 2024 20:43:24 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fi12-20020a05622a58cc00b0042a09928c10sm4185035qtb.33.2024.01.29.20.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 20:43:23 -0800 (PST)
Message-ID: <5d0147ae-e2f4-df22-d696-543aaaa01bb6@gmail.com>
Date: Mon, 29 Jan 2024 23:43:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Svyatoslav Ryhel <clamor95@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
Subject: [GIT PULL] Clock changes for v2024.04
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The following changes since commit 6faba41927bdc8973b59678649ef83c564cc421e:

   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.04-rc2

for you to fetch changes up to a8dc4965f09d28a59c156437673ddb66860c847e:

   clk: clk-gpio: add actual gated clock (2024-01-29 22:35:34 -0500)

----------------------------------------------------------------
Clock changes for v2024.04

This pull has the usual fixes and new (clock-adjacent) drivers. It also has some
cleanups for the clock API; in particular removing the unused rfree callback.

CI: https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/19486

----------------------------------------------------------------
Julien Masson (1):
       clk: fix clk_get_rate() always return ulong

Neil Armstrong (1):
       clk: meson: add Hardware Clock measure driver

Sean Anderson (3):
       clk: Remove rfree
       treewide: Remove clk_free
       clk: Document clk_ops return codes and behavior

Svyatoslav Ryhel (1):
       clk: clk-gpio: add actual gated clock

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
  drivers/clk/clk-gpio.c                        |  38 +++++-
  drivers/clk/clk-uclass.c                      |  47 +------
  drivers/clk/clk-xlnx-clock-wizard.c           |   1 -
  drivers/clk/clk_sandbox.c                     |  12 --
  drivers/clk/clk_sandbox_test.c                |  12 --
  drivers/clk/clk_versaclock.c                  |  12 +-
  drivers/clk/clk_zynq.c                        |   2 -
  drivers/clk/clk_zynqmp.c                      |   2 -
  drivers/clk/imx/clk-imx8.c                    |   2 -
  drivers/clk/meson/Kconfig                     |  10 ++
  drivers/clk/meson/Makefile                    |   1 +
  drivers/clk/meson/clk-measure.c               | 634 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
  include/clk-uclass.h                          | 123 ++++++++++++++---
  include/clk.h                                 |  31 -----
  test/dm/clk.c                                 |   9 --
  104 files changed, 853 insertions(+), 526 deletions(-)
  create mode 100644 drivers/clk/meson/clk-measure.c
