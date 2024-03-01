Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D619EC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A6887DDA;
	Fri,  1 Mar 2024 16:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UIKzBnvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34CF87DF3; Fri,  1 Mar 2024 16:58:25 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D41787DBB
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 16:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d2ab9c5e83so23481971fa.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709308703; x=1709913503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=axOAoBte9Ub6uuUZgewCxU2S7w1kBZr8yv3WsaSdBF8=;
 b=UIKzBnvVjMrEysdue1i9pt0YYHQOZkz86u7a1XQJm4jRxZf92cepR69nyU4sfeAr7w
 XAMzXtZq3dW9URaaMu95mqG7sCIJPGh33QUpWzlbHeQvmoxl0CFIM1VH4j6BQ1HZfr2U
 DUC8mf3P9yQJmxOC4WAtXA8wPhYuoQvulluG5XCNsG0RrbPqnow7qxc2Y1Thz8zUqIDn
 P1MF6bKoI0gn4iksRt+VR45Y09VtaPEcKdxrqBXB5zSYlz48X0+IWM4C98sxFactSIQ2
 ttW/eIR9PrI0KQCyR6/YblIMWnzXOFJoGh5k1TavLCkYIvp4AlyEsuuUorg+MGcnByA+
 lqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709308703; x=1709913503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axOAoBte9Ub6uuUZgewCxU2S7w1kBZr8yv3WsaSdBF8=;
 b=bsOcQyXA/IwggrVemyQJgLFuGSRpBfTIJ6U6UhI8b0Q1axg/WrfB13CF7yzoQb6dCw
 1RWZvJxCxfVMewas7BywJzJmPAhmbi0cUgZRJ+K9Lc66xyjCYBcO8YWQC2vD3uA9eErG
 IYOTNyA26zWagsKpO7yhuD1u99SmTWOIRK6U3a07aELpGoRiopTHjSF6K4JhX5dVUBUZ
 2EVM3m8vyWrCUaIkX/NHokxFxqkp0fPxczL5FnZhoYiMwRc5tPaAImOVEqLYA9BkTQQ9
 u8EiMEIwJBpC02DR2Tum4no9DgC1VjzpjZpVAP+ovRwSnTgzLKGfUcpodl3IK0x1IIKM
 ntOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyGVsEUzD8K4XD20qhluAK90ysY/ROeLVH/ARdw8ewKdTcEzFnhzZjMoDMfT11F1qmhMYY8YZq8CT4/YoYdg8mJBcejA==
X-Gm-Message-State: AOJu0YwONIa9ZuRb9GWDjr7kwNTKHFdDGSWeCETeuzpUmiAFl2CNVPSU
 A35eT1GQ3UxoJji1CmRQ2ogm0QoIZ6PS7NittzYsDozkU+HUnSO9xpD4IBdJdwY=
X-Google-Smtp-Source: AGHT+IFLbXkDtH7b+vR6XosNsSwWHodpybhg7zaAInyjZ444ZKbrKcxbfyAGkSmk828jmW8EQVBeIQ==
X-Received: by 2002:ac2:446a:0:b0:512:e218:db7f with SMTP id
 y10-20020ac2446a000000b00512e218db7fmr1463029lfl.67.1709308702693; 
 Fri, 01 Mar 2024 07:58:22 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm8746243wmb.39.2024.03.01.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 07:58:22 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-next
Date: Fri,  1 Mar 2024 15:45:21 +0000
Message-ID: <20240301155815.49606-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
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

I know Sumits dt-rebasing series just landed, so the timing isn't fantastic with
this series importing a bunch of DT stuff from Linux. However we've had two new
contributors this week adding new Qualcomm boards - I'd really like to get
this rework in so those folks aren't blocked on it and we can get out of this
limbo state.

I'll follow this up with a switch to OF_UPSTREAM asap!

Thanks and regards,
// Caleb

The following changes since commit 5b825032957c2613ef2f8f639e949ae02cb5bdff:

  Merge patch series "An effort to bring DT bindings compliance within U-Boot" (2024-02-29 22:24:23 -0500)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD

for you to fetch changes up to cbf3152f6afff25c25aa69ae06488671ca0aa765:

  clk/qcom: apq8016: allow apq8016_clk_init_uart() to be called externally (2024-03-01 15:08:59 +0000)

----------------------------------------------------------------
Caleb Connolly (40):
      arm: init: export prev_bl_fdt_addr
      usb: dwc3-generic: support external vbus regulator
      mmc: msm_sdhci: use modern clock handling
      dt-bindings: drop msm_sdhci binding
      clk/qcom: use upstream compatible properties
      clock/qcom: qcs404: fix clk_set_rate
      serial: msm: add debug UART
      serial: msm: fix clock handling and pinctrl
      gpio: qcom_pmic: 1-based GPIOs
      gpio: qcom_pmic: add a quirk to skip GPIO configuration
      gpio: qcom_pmic: add pinctrl driver
      sandbox: dts: fix qcom pmic gpio
      pinctrl: qcom: stub support for special GPIOs
      pinctrl: qcom: fix DT compatibility
      pinctrl: qcom: apq8016: init pre-reloaction
      board: dragonboard410c: add chainloaded config fragment
      board: dragonboard410c: upstream DT compat
      board: dragonboard410c: import board code from mach-snapdragon
      board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
      mach-snapdragon: generalise board support
      mach-snapdragon: dynamic load addresses
      mach-snapdragon: generate fdtfile automatically
      mach-snapdragon: carve out no-map regions
      board: qcs404-evb: drop board code
      doc: board/qualcomm: document generic targets
      doc: board/qualcomm: link to APQ8016 TRM
      dt-bindings: import headers for SDM845
      dts: sdm845: import supporting dtsi files
      dts: sdm845: replace with upstream DTS
      dt-bindings: import headers for MSM8916
      dts: msm8916: import PMIC dtsi files
      dts: msm8916: replace with upstream DTS
      dt-bindings: import headers for MSM8996
      dts: msm8996: import PMIC dtsi files
      dts: dragonboard820c: use correct bindings for clocks
      dts: msm8996: replace with upstream DTS
      dt-bindings: import headers for qcs404
      dts: qcs404-evb: replace with upstream DT
      MAINTAINERS: Qualcomm: add some missing paths
      clk/qcom: apq8016: allow apq8016_clk_init_uart() to be called externally

 MAINTAINERS                                        |   12 +-
 arch/arm/Kconfig                                   |    4 +
 arch/arm/dts/Makefile                              |    9 +-
 arch/arm/dts/apq8016-sbc-u-boot.dtsi               |   20 +
 arch/arm/dts/apq8016-sbc.dts                       |  729 +++
 arch/arm/dts/apq8096-db820c-u-boot.dtsi            |   14 +
 arch/arm/dts/apq8096-db820c.dts                    | 1137 ++++
 arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
 arch/arm/dts/dragonboard410c.dts                   |  209 -
 arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
 arch/arm/dts/dragonboard820c.dts                   |  151 -
 arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
 arch/arm/dts/dragonboard845c.dts                   |   48 -
 arch/arm/dts/msm8916-pm8916.dtsi                   |  157 +
 arch/arm/dts/msm8916.dtsi                          | 2702 +++++++++
 arch/arm/dts/msm8996.dtsi                          | 3884 +++++++++++++
 arch/arm/dts/pm8916.dtsi                           |  178 +
 arch/arm/dts/pm8994.dtsi                           |  152 +
 arch/arm/dts/pm8998.dtsi                           |  130 +
 arch/arm/dts/pmi8994.dtsi                          |   65 +
 arch/arm/dts/pmi8998.dtsi                          |   98 +
 arch/arm/dts/pms405.dtsi                           |  149 +
 arch/arm/dts/qcs404-evb-4000-u-boot.dtsi           |   48 +
 arch/arm/dts/qcs404-evb-4000.dts                   |   96 +
 arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
 arch/arm/dts/qcs404-evb.dts                        |  390 --
 arch/arm/dts/qcs404-evb.dtsi                       |  389 ++
 arch/arm/dts/qcs404.dtsi                           | 1829 ++++++
 arch/arm/dts/sdm845-db845c.dts                     | 1190 ++++
 .../arm/dts/sdm845-samsung-starqltechn-u-boot.dtsi |   16 +
 arch/arm/dts/sdm845-samsung-starqltechn.dts        |  460 ++
 arch/arm/dts/sdm845-wcd9340.dtsi                   |   86 +
 arch/arm/dts/sdm845.dtsi                           | 5801 +++++++++++++++++++-
 arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
 arch/arm/dts/starqltechn.dts                       |   68 -
 arch/arm/lib/save_prev_bl_data.c                   |    5 +
 arch/arm/mach-snapdragon/Kconfig                   |   95 +-
 arch/arm/mach-snapdragon/Makefile                  |    8 +-
 arch/arm/mach-snapdragon/board.c                   |  468 ++
 arch/arm/mach-snapdragon/dram.c                    |   99 -
 arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
 arch/arm/mach-snapdragon/include/mach/gpio.h       |    7 +
 arch/arm/mach-snapdragon/include/mach/misc.h       |   13 -
 arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
 arch/arm/mach-snapdragon/misc.c                    |   55 -
 arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
 arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
 arch/sandbox/dts/sandbox.dtsi                      |    9 +-
 board/qualcomm/dragonboard410c/Kconfig             |   15 -
 board/qualcomm/dragonboard410c/Makefile            |    2 +-
 .../dragonboard410c/configs/chainloaded.config     |    7 +
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  130 +-
 board/qualcomm/dragonboard820c/Kconfig             |   15 -
 board/qualcomm/dragonboard820c/Makefile            |    1 -
 board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
 board/qualcomm/dragonboard820c/head.S              |   33 -
 board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
 board/qualcomm/dragonboard845c/Kconfig             |   12 -
 board/qualcomm/qcs404-evb/Kconfig                  |   15 -
 board/qualcomm/qcs404-evb/Makefile                 |    6 -
 board/qualcomm/qcs404-evb/qcs404-evb.c             |   62 -
 configs/dragonboard410c_defconfig                  |    8 +-
 configs/dragonboard820c_defconfig                  |    8 +-
 configs/dragonboard845c_defconfig                  |   29 -
 configs/qcom_defconfig                             |   67 +
 configs/qcs404evb_defconfig                        |   55 -
 configs/starqltechn_defconfig                      |   41 -
 doc/board/qualcomm/board.rst                       |  125 +
 doc/board/qualcomm/debugging.rst                   |   61 +
 doc/board/qualcomm/dragonboard410c.rst             |    2 +
 doc/board/qualcomm/index.rst                       |    4 +-
 doc/board/qualcomm/qcs404.rst                      |   79 -
 doc/board/qualcomm/sdm845.rst                      |  167 -
 doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
 doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
 drivers/clk/qcom/clock-apq8016.c                   |   21 +-
 drivers/clk/qcom/clock-apq8096.c                   |    7 +-
 drivers/clk/qcom/clock-qcs404.c                    |   25 +-
 drivers/gpio/msm_gpio.c                            |   20 +
 drivers/gpio/qcom_pmic_gpio.c                      |  277 +-
 drivers/mmc/msm_sdhci.c                            |   69 +-
 drivers/phy/qcom/msm8916-usbh-phy.c                |    4 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c             |   34 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c             |   21 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             |    5 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c                |   12 +
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |   64 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |    5 +-
 drivers/serial/Kconfig                             |    8 +
 drivers/serial/serial_msm.c                        |   62 +-
 drivers/usb/dwc3/dwc3-generic.c                    |   24 +-
 drivers/usb/host/ehci-msm.c                        |   22 +-
 include/configs/dragonboard845c.h                  |   20 -
 include/configs/qcom.h                             |   21 +
 include/configs/qcs404-evb.h                       |   20 -
 include/configs/sdm845.h                           |   26 -
 include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
 include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
 include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
 include/dt-bindings/clock/qcom,gcc-msm8996.h       |  362 ++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
 include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
 include/dt-bindings/clock/qcom,rpmh.h              |   37 +
 include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
 include/dt-bindings/dma/qcom-gpi.h                 |   11 +
 include/dt-bindings/firmware/qcom,scm.h            |   39 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
 include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
 include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
 include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
 include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
 include/dt-bindings/phy/phy-qcom-qmp.h             |   20 +
 include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h        |  106 +
 include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |   36 +
 include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
 include/dt-bindings/soc/qcom,apr.h                 |   28 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
 include/dt-bindings/sound/apq8016-lpass.h          |    9 +
 include/dt-bindings/sound/qcom,lpass.h             |   46 +
 include/dt-bindings/sound/qcom,q6afe.h             |    9 +
 include/dt-bindings/sound/qcom,q6asm.h             |   26 +
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |  234 +
 include/dt-bindings/sound/qcom,wcd9335.h           |   15 +
 include/init.h                                     |   11 +
 136 files changed, 24039 insertions(+), 2658 deletions(-)
 create mode 100644 arch/arm/dts/apq8016-sbc-u-boot.dtsi
 create mode 100644 arch/arm/dts/apq8016-sbc.dts
 create mode 100644 arch/arm/dts/apq8096-db820c-u-boot.dtsi
 create mode 100644 arch/arm/dts/apq8096-db820c.dts
 delete mode 100644 arch/arm/dts/dragonboard410c-uboot.dtsi
 delete mode 100644 arch/arm/dts/dragonboard410c.dts
 delete mode 100644 arch/arm/dts/dragonboard820c-uboot.dtsi
 delete mode 100644 arch/arm/dts/dragonboard820c.dts
 delete mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
 delete mode 100644 arch/arm/dts/dragonboard845c.dts
 create mode 100644 arch/arm/dts/msm8916-pm8916.dtsi
 create mode 100644 arch/arm/dts/msm8916.dtsi
 create mode 100644 arch/arm/dts/msm8996.dtsi
 create mode 100644 arch/arm/dts/pm8916.dtsi
 create mode 100644 arch/arm/dts/pm8994.dtsi
 create mode 100644 arch/arm/dts/pm8998.dtsi
 create mode 100644 arch/arm/dts/pmi8994.dtsi
 create mode 100644 arch/arm/dts/pmi8998.dtsi
 create mode 100644 arch/arm/dts/pms405.dtsi
 create mode 100644 arch/arm/dts/qcs404-evb-4000-u-boot.dtsi
 create mode 100644 arch/arm/dts/qcs404-evb-4000.dts
 delete mode 100644 arch/arm/dts/qcs404-evb-uboot.dtsi
 delete mode 100644 arch/arm/dts/qcs404-evb.dts
 create mode 100644 arch/arm/dts/qcs404-evb.dtsi
 create mode 100644 arch/arm/dts/qcs404.dtsi
 create mode 100644 arch/arm/dts/sdm845-db845c.dts
 create mode 100644 arch/arm/dts/sdm845-samsung-starqltechn-u-boot.dtsi
 create mode 100644 arch/arm/dts/sdm845-samsung-starqltechn.dts
 create mode 100644 arch/arm/dts/sdm845-wcd9340.dtsi
 delete mode 100644 arch/arm/dts/starqltechn-uboot.dtsi
 delete mode 100644 arch/arm/dts/starqltechn.dts
 create mode 100644 arch/arm/mach-snapdragon/board.c
 delete mode 100644 arch/arm/mach-snapdragon/dram.c
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/dram.h
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/misc.h
 delete mode 100644 arch/arm/mach-snapdragon/init_sdm845.c
 delete mode 100644 arch/arm/mach-snapdragon/misc.c
 delete mode 100644 arch/arm/mach-snapdragon/sysmap-apq8016.c
 delete mode 100644 arch/arm/mach-snapdragon/sysmap-apq8096.c
 delete mode 100644 arch/arm/mach-snapdragon/sysmap-qcs404.c
 delete mode 100644 arch/arm/mach-snapdragon/sysmap-sdm845.c
 delete mode 100644 board/qualcomm/dragonboard410c/Kconfig
 create mode 100644 board/qualcomm/dragonboard410c/configs/chainloaded.config
 delete mode 100644 board/qualcomm/dragonboard820c/Kconfig
 delete mode 100644 board/qualcomm/dragonboard820c/head.S
 delete mode 100644 board/qualcomm/dragonboard820c/u-boot.lds
 delete mode 100644 board/qualcomm/dragonboard845c/Kconfig
 delete mode 100644 board/qualcomm/qcs404-evb/Kconfig
 delete mode 100644 board/qualcomm/qcs404-evb/Makefile
 delete mode 100644 board/qualcomm/qcs404-evb/qcs404-evb.c
 delete mode 100644 configs/dragonboard845c_defconfig
 create mode 100644 configs/qcom_defconfig
 delete mode 100644 configs/qcs404evb_defconfig
 delete mode 100644 configs/starqltechn_defconfig
 create mode 100644 doc/board/qualcomm/board.rst
 create mode 100644 doc/board/qualcomm/debugging.rst
 delete mode 100644 doc/board/qualcomm/qcs404.rst
 delete mode 100644 doc/board/qualcomm/sdm845.rst
 delete mode 100644 doc/device-tree-bindings/mmc/msm_sdhci.txt
 delete mode 100644 doc/device-tree-bindings/usb/ehci-msm.txt
 delete mode 100644 include/configs/dragonboard845c.h
 create mode 100644 include/configs/qcom.h
 delete mode 100644 include/configs/qcs404-evb.h
 delete mode 100644 include/configs/sdm845.h
 create mode 100644 include/dt-bindings/arm/coresight-cti-dt.h
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8916.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8996.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8996.h
 create mode 100644 include/dt-bindings/clock/qcom,rpmcc.h
 create mode 100644 include/dt-bindings/clock/qcom,rpmh.h
 create mode 100644 include/dt-bindings/clock/qcom,turingcc-qcs404.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h
 create mode 100644 include/dt-bindings/firmware/qcom,scm.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
 create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
 create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
 create mode 100644 include/dt-bindings/pinctrl/qcom,pmic-gpio.h
 create mode 100644 include/dt-bindings/pinctrl/qcom,pmic-mpp.h
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-msm8916.h
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
 create mode 100644 include/dt-bindings/soc/qcom,apr.h
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/dt-bindings/sound/apq8016-lpass.h
 create mode 100644 include/dt-bindings/sound/qcom,lpass.h
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
 create mode 100644 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
 create mode 100644 include/dt-bindings/sound/qcom,wcd9335.h
