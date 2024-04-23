Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD941C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600A387F30;
	Tue, 23 Apr 2024 15:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Az/KlxnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBF987F65; Tue, 23 Apr 2024 15:50:27 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5778387F1C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 15:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8b2389e73so68474241fa.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713880225; x=1714485025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6qRKhH8jWVHz2muKi2M9bL4zQE5x/tRTH1AYVocIZE=;
 b=Az/KlxnKZeDXOBWPdoq+N3vayGDXGhR17ek3QB5oDAy9EQtfmmPtwBxHHeXT9Ji6gT
 lkMYyvkuUvlISb/gp5ZAhZGLnZrW/3hhTRpHifd8fidS+a+miO3BJ5OgX80NB2TGqHtd
 3cItBbkP7nCb/CKRzD06vJQbVSKbKZsthXG/5Go/25MLc66E5ZTbr6S89k3rq3bBkz5+
 bq5frQ0yJg1BHP97si54jgrp5J3/T4ce0+vi4voR8U+yBsOZ27W5Au/PScvAOGjk4DmR
 wJmsoxhElq+KgU5m9AgtWBhMe2FNdLmc6SKaXr4UBKN4MTleeQhQWMlrMSSEhgQ0nKrb
 Crrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713880225; x=1714485025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6qRKhH8jWVHz2muKi2M9bL4zQE5x/tRTH1AYVocIZE=;
 b=a1zWcE7HsUja5eAUTr4//AqyEH3GOGGSMGlIoTNnSZ4iHBd7J/bpz/6TRlg466Sk8/
 lIY9YInmEoT2y9O9/cKZn1DSnoB/uQKbbiBsUEyI2T8fVuWqhwqAXi8Ac2z/JteJP68r
 FqJXPcdr69H9d0TKkLyFiZF0tjuttBrY3MA/dSl1yLqPN7WCogQ6Y5yRx0HEfXambX8P
 SOxGbtvrBEdTRSSFc/uwOVnmtPWsZGxA9Z6BWOcoUZxdaxxFzkyCX5RgscPTa7oFEWv2
 ALbpHVC88TsDCt66sKr5S1ypYNpHWchiJYQLPkNKMM7IOy/3cJsjQoJcN0utr5RoKr3L
 HZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAQk1upZfydU3RTrAPHeFu3UXu3mojrmzIRWWWFJlxHJK+dP73oje8mkZ7y5ieEL6uPhHKy3HNxDR74jrkIPDt8ki90Q==
X-Gm-Message-State: AOJu0YwQCA3nV/+u85bhfgZf0Ar/nv7M9ffB5mBIgF59ZRrzElMFfyl1
 EdQXE5GiJqpp6HyImvjYHw2Jt20DCB9HtpaBUM2y+VDbWMnl66ClV7sFDCD2NHs=
X-Google-Smtp-Source: AGHT+IES8MIw6yniiBnvSO/ors1bspdZSqrKT3ykiiud3w/+STUrId7S12cbx4tdVDwqi+5bTGUDeg==
X-Received: by 2002:a2e:9357:0:b0:2db:196a:a8d2 with SMTP id
 m23-20020a2e9357000000b002db196aa8d2mr7361598ljh.17.1713880224540; 
 Tue, 23 Apr 2024 06:50:24 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a056402111900b005720c59dc57sm2357871edv.23.2024.04.23.06.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:50:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-main
Date: Tue, 23 Apr 2024 15:46:19 +0200
Message-ID: <20240423134951.2380045-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

Overshot the -rc1 deadline, but I hope these can still make in for 2024.07.

Support is added for 5 new Qualcomm SoCs:

* QCM2290 and SM6115 are low and mid range SoCs used on the RB1 and RB2
  respectively. SM6115 is also used in some mid-range smartphones/tablets.
  Initial support includes buttons and USB (host and gadget).
* SM8250 is a flagship SoC from 2020 used on the RB5, as well as many flagship
  smartphones. The board can boot to a U-Boot prompt, but is missing regulators
  necessary for USB support.
* SM8550, and SM8650 are flagship mobile SoCs from 2023 and 2024
  respectively. Found on many high end smartphones.

In addition:

* Support is added for the Schneider HMIBSC board.
* mach-snapdragon switches to OF_UPSTREAM
* IPQ40xx gets several regressions fixed and some overall cleanup.
* The MSM serial driver gains the ability to generate the bit-clock
  automatically, no longer relying on a custom DT property.
* The Qualcomm SMMU driver gets a generic compatible (so per-SoC compatibles
  don't need to be added).
* Support for the GENI I2C controller is added.
* The qcom SPMI driver has SPMI v5 support fixed, and v7 support added.
* The qcom sdhci driver gets some fixes for SDCC v5 support.
* SDM845 gains sdcard support
* Support is added for the Synopsys eUSB2 PHY driver (used on SM8550 and SM8650)
* SYS_INIT_SP_BSS_OFFSET is set to 1.5M to give us more space for FDTs.
* RB2 gets a work-around to fix the USB dr_mode property before booting Linux.

---

The following changes since commit 38ea74d6d5c05224acdb03f799897c1bdd56f8cc:

  Prepare v2024.07-rc1 (2024-04-22 15:10:21 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to ad12acd7a8f5aeea5816d5c2fc37c205c403eee0:

  configs: qcom_defconfig: enable GENI I2C Driver (2024-04-23 13:29:32 +0200)

----------------------------------------------------------------
Caleb Connolly (32):
      pinctrl: qcom: add qcm2290 pinctrl driver
      pinctrl: qcom: add sm6115 pinctrl driver
      pinctrl: qcom: add sm8250 pinctrl driver
      qcom_defconfig: enable pinctrl for new qcm2290/sm6115/sm8250
      clk/qcom: add driver for qcm2290 GCC
      clk/qcom: add driver for sm6115 GCC
      clk/qcom: add driver for sm8250 GCC
      qcom_defconfig: enable clocks for qcm2290/sm6115/sm8250
      mmc: msm_sdhci: correct vendor_spec_cap0 register for v5
      mmc: msm_sdhci: use modern DT handling
      mmc: msm_sdhci: print core version
      mmc: msm_sdhci: use a more sensible default clock rate
      clk/qcom: sdm845: enable SDCC2 core clock
      pinctrl: qcom: sdm845: add special pin names
      dts: sdm845-db845c-u-boot: adjust MMC clocks
      MAINTAINERS: add Qualcomm mailing list
      mmc: msm_sdhci: fix vendor_spec_cap0 registers
      clk/qcom: apq8016: return valid rate when setting UART clock
      clk/qcom: ipq4019: return valid rate when setting UART clock
      serial: msm: calculate bit clock divider
      mach-snapdragon: use OF_UPSTREAM
      arm: dts: drop qcom dts files
      qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET
      gpio: qcom_pmic: add pm6125
      gpio: qcom_pmic: add pm8150l
      iommu: qcom-smmu: add qcom generic compatible
      phy: qcom: snps-femto-v2: drop clocks
      arm: dts: qrb4210-rb2-u-boot: add u-boot fixups
      mach-snapdragon: implement ft_board_setup() for USB role selection
      qcom_defconfig: enable OF_BOARD_SETUP
      qcom_defconfig: define safe default SYS_LOAD_ADDR
      qcom_defconfig: generate SMBIOS tables

Neil Armstrong (17):
      phy: qcom: add Synopsys eUSB2 PHY driver
      qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY driver
      pinctrl: qcom: Add SM8550 pinctrl driver
      pinctrl: qcom: Add SM8650 pinctrl driver
      qcom_defconfig: enable SM8550 & SM8650 pinctrl driver
      gpio: qcom_pmic_gpio: add support for pm8550-gpio
      button: qcom-pmic: move node name checks to btn_data struct
      button: qcom-pmic: add support for pmk8350 button configs
      clk: qcom: Add SM8550 clock driver
      clk: qcom: Add SM8650 clock driver
      qcom_defconfig: enable SM8550 & SM8650 clock driver
      spmi: msm: fix version 5 support
      spmi: msm: properly format command
      spmi: msm: handle peripheral ownership
      spmi: msm: support controller version 7
      i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
      configs: qcom_defconfig: enable GENI I2C Driver

Robert Marko (8):
      serial: allow selecting MSM debug UART with ARCH_IPQ40XX
      serial: msm_serial: remove .clk_rate from debug UART
      arm: mach-ipq40xx: dont select SMEM by default
      pinctrl: qcom: allow selecting with ARCH_IPQ40XX
      mach-ipq40xx: import GPIO header from mach-snapgradon
      pinctrl: qcom: ipq4019: adapt pin name lookup to upstream DTS
      pinctrl: qcom: ipq4019: enable DM_FLAG_PRE_RELOC
      pinctrl: qcom: ipq4019: support all pin functions

Sumit Garg (8):
      mach-snapdragon: Allow other board vendors apart from Qcom
      qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
      apq8016: Add support for UART1 clocks and pinmux
      serial_msm: Enable RS232 flow control
      pinctrl: qcom: Add support for driving GPIO pins output
      pinctrl: qcom: apq8016: Add GPIO pinctrl function
      arm: dts: qcom: Add Schneider HMIBSC board dts
      board: add support for Schneider HMIBSC board

 MAINTAINERS                                        |    6 +-
 arch/arm/Kconfig                                   |    5 +-
 arch/arm/dts/Makefile                              |    6 -
 ...pq8016-sbc.dts => apq8016-schneider-hmibsc.dts} |  706 +--
 arch/arm/dts/apq8096-db820c.dts                    | 1137 ----
 arch/arm/dts/msm8916-pm8916.dtsi                   |  157 -
 arch/arm/dts/msm8916.dtsi                          | 2702 ---------
 arch/arm/dts/msm8996.dtsi                          | 3884 -------------
 arch/arm/dts/pm8916.dtsi                           |  178 -
 arch/arm/dts/pm8994.dtsi                           |  152 -
 arch/arm/dts/pm8998.dtsi                           |  130 -
 arch/arm/dts/pmi8994.dtsi                          |   65 -
 arch/arm/dts/pmi8998.dtsi                          |   98 -
 arch/arm/dts/pms405.dtsi                           |  149 -
 arch/arm/dts/qcs404-evb-4000.dts                   |   96 -
 arch/arm/dts/qcs404-evb.dtsi                       |  389 --
 arch/arm/dts/qcs404.dtsi                           | 1829 -------
 arch/arm/dts/qrb4210-rb2-u-boot.dtsi               |    6 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi             |    7 +
 arch/arm/dts/sdm845-db845c.dts                     | 1190 ----
 arch/arm/dts/sdm845-samsung-starqltechn.dts        |  460 --
 arch/arm/dts/sdm845-wcd9340.dtsi                   |   86 -
 arch/arm/dts/sdm845.dtsi                           | 5752 --------------------
 arch/arm/mach-ipq40xx/include/mach/gpio.h          |   37 +-
 arch/arm/mach-snapdragon/Kconfig                   |   14 +-
 arch/arm/mach-snapdragon/of_fixup.c                |   20 +
 board/schneider/hmibsc/MAINTAINERS                 |    6 +
 board/schneider/hmibsc/hmibsc.env                  |   40 +
 configs/dragonboard410c_defconfig                  |    2 +-
 configs/dragonboard820c_defconfig                  |    2 +-
 configs/hmibsc_defconfig                           |   87 +
 configs/qcom_defconfig                             |   20 +-
 doc/board/index.rst                                |    1 +
 doc/board/schneider/hmibsc.rst                     |   45 +
 doc/board/schneider/index.rst                      |    9 +
 doc/device-tree-bindings/serial/msm-serial.txt     |   10 -
 drivers/button/button-qcom-pmic.c                  |   99 +-
 drivers/clk/qcom/Kconfig                           |   39 +
 drivers/clk/qcom/Makefile                          |    5 +
 drivers/clk/qcom/clock-apq8016.c                   |   39 +-
 drivers/clk/qcom/clock-ipq4019.c                   |    2 +-
 drivers/clk/qcom/clock-qcm2290.c                   |  192 +
 drivers/clk/qcom/clock-qcom.h                      |    5 +
 drivers/clk/qcom/clock-sdm845.c                    |   17 +
 drivers/clk/qcom/clock-sm6115.c                    |  199 +
 drivers/clk/qcom/clock-sm8250.c                    |  282 +
 drivers/clk/qcom/clock-sm8550.c                    |  335 ++
 drivers/clk/qcom/clock-sm8650.c                    |  332 ++
 drivers/gpio/qcom_pmic_gpio.c                      |   20 +-
 drivers/i2c/Kconfig                                |   10 +
 drivers/i2c/Makefile                               |    1 +
 drivers/i2c/geni_i2c.c                             |  575 ++
 drivers/iommu/qcom-hyp-smmu.c                      |    1 +
 drivers/mmc/msm_sdhci.c                            |   43 +-
 drivers/phy/qcom/Kconfig                           |    8 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-snps-eusb2.c             |  366 ++
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c          |   14 -
 drivers/pinctrl/qcom/Kconfig                       |   36 +-
 drivers/pinctrl/qcom/Makefile                      |    5 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c             |    2 +
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             |  311 +-
 drivers/pinctrl/qcom/pinctrl-qcm2290.c             |   70 +
 drivers/pinctrl/qcom/pinctrl-qcom.c                |   25 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |   13 +-
 drivers/pinctrl/qcom/pinctrl-sm6115.c              |  200 +
 drivers/pinctrl/qcom/pinctrl-sm8250.c              |   99 +
 drivers/pinctrl/qcom/pinctrl-sm8550.c              |   75 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c              |   75 +
 drivers/serial/Kconfig                             |    2 +-
 drivers/serial/serial_msm.c                        |  109 +-
 drivers/spmi/spmi-msm.c                            |  152 +-
 include/configs/hmibsc.h                           |   16 +
 include/soc/qcom/geni-se.h                         |  265 +
 74 files changed, 4405 insertions(+), 19118 deletions(-)
 rename arch/arm/dts/{apq8016-sbc.dts => apq8016-schneider-hmibsc.dts} (50%)
 delete mode 100644 arch/arm/dts/apq8096-db820c.dts
 delete mode 100644 arch/arm/dts/msm8916-pm8916.dtsi
 delete mode 100644 arch/arm/dts/msm8916.dtsi
 delete mode 100644 arch/arm/dts/msm8996.dtsi
 delete mode 100644 arch/arm/dts/pm8916.dtsi
 delete mode 100644 arch/arm/dts/pm8994.dtsi
 delete mode 100644 arch/arm/dts/pm8998.dtsi
 delete mode 100644 arch/arm/dts/pmi8994.dtsi
 delete mode 100644 arch/arm/dts/pmi8998.dtsi
 delete mode 100644 arch/arm/dts/pms405.dtsi
 delete mode 100644 arch/arm/dts/qcs404-evb-4000.dts
 delete mode 100644 arch/arm/dts/qcs404-evb.dtsi
 delete mode 100644 arch/arm/dts/qcs404.dtsi
 create mode 100644 arch/arm/dts/qrb4210-rb2-u-boot.dtsi
 delete mode 100644 arch/arm/dts/sdm845-db845c.dts
 delete mode 100644 arch/arm/dts/sdm845-samsung-starqltechn.dts
 delete mode 100644 arch/arm/dts/sdm845-wcd9340.dtsi
 delete mode 100644 arch/arm/dts/sdm845.dtsi
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 board/schneider/hmibsc/hmibsc.env
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 delete mode 100644 doc/device-tree-bindings/serial/msm-serial.txt
 create mode 100644 drivers/clk/qcom/clock-qcm2290.c
 create mode 100644 drivers/clk/qcom/clock-sm6115.c
 create mode 100644 drivers/clk/qcom/clock-sm8250.c
 create mode 100644 drivers/clk/qcom/clock-sm8550.c
 create mode 100644 drivers/clk/qcom/clock-sm8650.c
 create mode 100644 drivers/i2c/geni_i2c.c
 create mode 100644 drivers/phy/qcom/phy-qcom-snps-eusb2.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcm2290.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm6115.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8550.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8650.c
 create mode 100644 include/configs/hmibsc.h
 create mode 100644 include/soc/qcom/geni-se.h
