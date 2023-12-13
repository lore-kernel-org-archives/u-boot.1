Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2611FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322BC877CD;
	Wed, 13 Dec 2023 04:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BKYavOVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6947C877B0; Wed, 13 Dec 2023 04:16:51 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC2D0871AA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-59093f6c94aso2110808eaf.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437407; x=1703042207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1K368W7qnxXXXLB2AmfhnVTE5LHj+M2vhhZpXZI0BqQ=;
 b=BKYavOVWbm9h2uQVebSZ/rJiucS7gfsj+D8rP0OYAWVumCpn+EDt5r/nZwjwll32l8
 0IuM5CpoRvWhc2x88WQsf0+iF6OdI8VrV1qZXatpncUb/ZtLDBD9fUsP2lMnagiAc8+h
 GnOazXsUQ9ys5xWUDn+cXMPTezS2M15HNJxYY/h5PZPTw/zTavEtkB9KRuAFqaV0uGxE
 5yfPfkN/D5KsmPYfxIxnNRa8V20wX9AUM9usftW03p/j9P5vvHMurOxweljv0A8evvmt
 R2PhEJTxxJt6eViE67hmmOOAyQDpu45nvxeyExbQCZ4P9GC40bktEsgBvLUZVWHTyEQZ
 FNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437407; x=1703042207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1K368W7qnxXXXLB2AmfhnVTE5LHj+M2vhhZpXZI0BqQ=;
 b=XGpBjYYTxYSq8i8O6MbFbcOhJmSc0ZF2Qgiw3QrgUcChebKPyaW+hvIMIMqJ0GKoVJ
 dmmRNy6bHRpm6ItB3gMRj2U6xUbBPyxp7HDY96gqfimPkjaspXL0D7dtR0AHEsL8U+Ju
 XlB7yrCdrvBUIS+PcEOAb+dTTi9tEFMZFeq9weDNFrn3cuN6874NnHPrSy26i3I4GcfD
 yE7/g/+JvrTHfW96HbqI0cz6cr1hBFd1JTLyZCfRg9XFVUICZ2+gj4g0kLUYUFjqqEF1
 DOweagANluIXtezETFugmqF0w5CJlpOEyezke0ZTvEphK6UTQtQq2Vr58P8Q0G5W25bL
 k15Q==
X-Gm-Message-State: AOJu0YyCVsiEnguu1qoJEXEgzH5anzllVY0Z0NtcKfh7qnhjp/VSI5mO
 6QVY0a5BBwp3ed8Ct83LSHt6dQ==
X-Google-Smtp-Source: AGHT+IHZK/xZj8k40ASlvKD477fj07qtWsUmZTjFDKgz0HO/mjmtahSRhYAhvEA7FfIQIhAhvAWxxQ==
X-Received: by 2002:a4a:cf19:0:b0:58e:2e3f:937c with SMTP id
 l25-20020a4acf19000000b0058e2e3f937cmr3931616oos.4.1702437407263; 
 Tue, 12 Dec 2023 19:16:47 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 u23-20020a4a6c57000000b0059034d09dd2sm2838551oof.12.2023.12.12.19.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:46 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 00/13] arm: exynos: Add E850-96 board
Date: Tue, 12 Dec 2023 21:16:33 -0600
Message-Id: <20231213031646.28828-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

NOTE: This patch series depends on "pinctrl: exynos: Prepare for other
SoCs support" series [1]. It should be applied first.

Add Exynos850 SoC and WinLink's E850-96 board support. A short overview
of series additions and modifications:
  * USI driver: configures UART block
  * PMU driver: connects AP UART lines to uart1 pins)
  * Exynos850 clock driver: generates UART clocks
  * Exynos850 pinctrl driver: mux UART pins
  * serial_s5p: UART driver
  * Exynos850 SoC: dtsi files and MMU maps
  * E850-96 board: dts files, defconfig, board file and doc

Most of the code was borrowed from mainline Linux kernel (where this
board is already enabled) and adapted for U-Boot. Preliminary
preparation for this series includes next patches / series (already
merged):

  * commit 585a2aaac2ac ("arm: exynos: Include missing CPU header in
                          soc.c")
  * commit c9ab9f30c8e4 ("arm: exynos: Include missing CPU header in
                          gpio.h")
  * commit 11bd2787deff ("watchdog: s5p_wdt: Include missing CPU
                          header")
  * commit 08cfa971a717 ("exynos: Avoid duplicate reset_cpu with
                          SYSRESET enabled")
  * commit f655090901dc ("clk: exynos: Add header guard for clk-pll.h")
  * commit 2227f4c0afed ("serial: s5p: Fix clk_get_by_index() error code
                          check")
  * commit a0615ffc99a5 ("serial: s5p: Remove common.h inclusion")
  * commit 5ad21de6bae0 ("serial: s5p: Use livetree API to get "id"
                          property")
  * commit e79f630dbf67 ("serial: s5p: Use named constants for register
                          values")
  * commit a627f2802a71 ("serial: s5p: Improve coding style")
  * commit 33e7ca5a9b6a ("serial: s5p: Use dev_read_addr_ptr() to get
                          base address")
  * commit 6219b47c4d91 ("board: samsung: Fix SYS_CONFIG_NAME configs in
                          axy17lte Kconfig")
  * commit 470682ace1e0 ("configs: Remove unneeded SYS_CONFIG_NAME from
                          a*y17lte defconfigs")

and series [1] (dependency) is still pending.

For more detailed description please see the board documentation (added
in PATCH #12) and corresponding commit messages.

[1] https://lists.denx.de/pipermail/u-boot/2023-November/539033.html

Sam Protsenko (13):
  dt-bindings: soc: samsung: Add Exynos USI
  dt-bindings: soc: samsung: Add Exynos PMU
  dt-bindings: clock: Add Exynos850 clock controller
  soc: samsung: Add Exynos USI driver
  soc: samsung: Add Exynos PMU driver
  clk: exynos: Move pll code into clk-exynos7420
  clk: exynos: Add Samsung clock framework
  clk: exynos: Add Exynos850 clock driver
  pinctrl: exynos: Add pinctrl support for Exynos850
  serial: s5p: Add Exynos850 compatible
  arm: exynos: Add Exynos850 SoC support
  board: samsung: Add support for E850-96 board
  MAINTAINERS: Add new Samsung subsystems

 MAINTAINERS                                   |   25 +
 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/exynos-pinctrl.h                 |   79 +
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi    |   37 +
 arch/arm/dts/exynos850-e850-96.dts            |  273 ++++
 arch/arm/dts/exynos850-pinctrl.dtsi           |  663 +++++++++
 arch/arm/dts/exynos850.dtsi                   |  809 +++++++++++
 arch/arm/mach-exynos/Kconfig                  |   28 +-
 arch/arm/mach-exynos/mmu-arm64.c              |   34 +
 board/samsung/e850-96/Kconfig                 |   16 +
 board/samsung/e850-96/MAINTAINERS             |    9 +
 board/samsung/e850-96/Makefile                |    6 +
 board/samsung/e850-96/e850-96.c               |   22 +
 configs/e850-96_defconfig                     |   21 +
 doc/board/samsung/e850-96.rst                 |   87 ++
 .../img/exynos850-boot-architecture.svg       | 1283 +++++++++++++++++
 doc/board/samsung/index.rst                   |    1 +
 .../clock/samsung,exynos850-clock.yaml        |  307 ++++
 .../soc/samsung/exynos-pmu.yaml               |   85 ++
 .../soc/samsung/exynos-usi.yaml               |  162 +++
 drivers/clk/exynos/Kconfig                    |    7 +
 drivers/clk/exynos/Makefile                   |   11 +-
 drivers/clk/exynos/clk-exynos7420.c           |   25 +-
 drivers/clk/exynos/clk-exynos850.c            |  189 +++
 drivers/clk/exynos/clk-pll.c                  |  167 ++-
 drivers/clk/exynos/clk-pll.h                  |   16 +-
 drivers/clk/exynos/clk.c                      |  121 ++
 drivers/clk/exynos/clk.h                      |  228 +++
 drivers/pinctrl/exynos/Kconfig                |    8 +
 drivers/pinctrl/exynos/Makefile               |    1 +
 drivers/pinctrl/exynos/pinctrl-exynos850.c    |  125 ++
 drivers/serial/serial_s5p.c                   |    1 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/samsung/Kconfig                   |   33 +
 drivers/soc/samsung/Makefile                  |    4 +
 drivers/soc/samsung/exynos-pmu.c              |  102 ++
 drivers/soc/samsung/exynos-usi.c              |  218 +++
 include/configs/e850-96.h                     |   12 +
 include/dt-bindings/clock/exynos850.h         |  337 +++++
 include/dt-bindings/soc/samsung,exynos-usi.h  |   17 +
 41 files changed, 5548 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/exynos-pinctrl.h
 create mode 100644 arch/arm/dts/exynos850-e850-96-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos850-e850-96.dts
 create mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm/dts/exynos850.dtsi
 create mode 100644 board/samsung/e850-96/Kconfig
 create mode 100644 board/samsung/e850-96/MAINTAINERS
 create mode 100644 board/samsung/e850-96/Makefile
 create mode 100644 board/samsung/e850-96/e850-96.c
 create mode 100644 configs/e850-96_defconfig
 create mode 100644 doc/board/samsung/e850-96.rst
 create mode 100644 doc/board/samsung/img/exynos850-boot-architecture.svg
 create mode 100644 doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 drivers/clk/exynos/clk-exynos850.c
 create mode 100644 drivers/clk/exynos/clk.c
 create mode 100644 drivers/clk/exynos/clk.h
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-usi.c
 create mode 100644 include/configs/e850-96.h
 create mode 100644 include/dt-bindings/clock/exynos850.h
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

-- 
2.39.2

