Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D133DC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 12:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061D48786C;
	Tue, 16 Jan 2024 13:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x7MU8Pt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5327B8787B; Tue, 16 Jan 2024 13:36:29 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197F187716
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-337bea8682dso221089f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705408585; x=1706013385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GHUOQPku3tgmFOTBCnRGcSPl7/Ey5hDIRi6jDLseebA=;
 b=x7MU8Pt0ZueNk5kftfgW5FHeYwkjMr+o1wRZwcsblFs+UIOm8Li+HlHf700wcxglKb
 Y4dlETgYsrsHqKqZJzWLy8neUaMAVo5IpWVvzPpdbKUnACbU5yzeVlHdi/r+9b2O2+BT
 ofSoa2SlBt/gJS+Zao7Yp/oJsX4QqGSE102SmV4q2Kh2NjuWRLhl8hHVwGFXoyA8VLqZ
 wwg7uEUt/n3Rz97m3A8sLIe1M2GSVvQRcRW7SXrLVGbh2bJv8ywD2SNZ9WDmThzvfu9z
 0rgyg9z9tHVf7SOCZjP993EE/EeWuBhx1qeIxFXTO6ap+pMFzRdIVwPQBNLKZSf/PAgU
 Rr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705408585; x=1706013385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHUOQPku3tgmFOTBCnRGcSPl7/Ey5hDIRi6jDLseebA=;
 b=QCC3FQQyq/Ug9GvxMbNhGMz9uro0ksoW9adhskiF7sFcK04NPUORVjDqOCcbTx8JK/
 h3Uic+X7qnB9tzXQoBL4Exqj3hm7cOE1iUmqf6hBGvyOMP328UTI66xeiGbM1Lgf0VkE
 59y72Pl1uToujh9XhV+FeF+lRV36DgtGwPtOEKa4urKK5DQ5MiP/qAdJjmtXrr+uhgky
 k3KggJQYlR2iH9zYI7JfW3vLUyvpCpkK1r++SRMrMtplM5GQ4hjXFSIK1HGgIpgve2Ck
 7B/oHnNTAuHNdAoa5j+FyEWruFgi7ExhEODoYeUi0BccFk60Xl6iIHRWSD96AUMIg1Hp
 ueGg==
X-Gm-Message-State: AOJu0YzeZNcfgyrPBzwdhO+Cm0clzIFVp+esKacfT/1gRfnRfR0/RvAl
 o618Fbz91Fp/gqiqulyaCciSEF+9pwFfRA==
X-Google-Smtp-Source: AGHT+IEv6empqcA95rtXiOoWOvZBMA09qcgcXccvOxgK0eoQtZJ2lYHuaAmS9T6SnOr4g0/VcjHhKg==
X-Received: by 2002:adf:ea49:0:b0:337:bc4c:48a8 with SMTP id
 j9-20020adfea49000000b00337bc4c48a8mr456886wrn.26.1705408585470; 
 Tue, 16 Jan 2024 04:36:25 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 o10-20020a056000010a00b00336cbbf2e0fsm14444586wrx.27.2024.01.16.04.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 04:36:25 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Please pull qcom-2024.04-rc1
Date: Tue, 16 Jan 2024 12:33:18 +0000
Message-ID: <20240116123343.1038689-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.0
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

The following changes since commit 697758e7c81131da6db0e3b10515019fe3aca8c9:

  Merge branch 'master-sync-dts-663' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-14 18:07:49 -0500)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git tags/qcom-2024.04-rc1

for you to fetch changes up to 4c3dfa1b8babf9fc0575ce08eed99f950d3bab84:

  sandbox_flattree: enable button support (2024-01-16 12:26:54 +0000)
----------------------------------------------------------------
Qualcomm architecture changes:

* Move clock and pinctrl drivers out of mach-snapdragon
* Various clock driver improvements
* Convert PMIC power/reset key driver to use the button API
* Preparetory work for migrating to upstream DT
----------------------------------------------------------------
Caleb Connolly (23):
      clk/qcom: move from mach-snapdragon
      clk/qcom: move ipq4019 driver from mach-ipq40xx
      clk/qcom: sdm845: add register map for simple gate clocks
      clk/qcom: use function pointers for enable and set_rate
      clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
      clk/qcom: fix rcg divider value
      pinctrl: qcom: move out of mach-snapdragon
      pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
      pinctrl: qcom: make compatible with linux DTs
      msm_gpio: use unsigned int
      serial: msm-geni: don't rely on parent misc device
      serial: msm-geni: handle devm_clk_get() errors
      gpio: qcom_pmic: fix silent dev_read_addr downcast
      button: qcom-pmic: introduce Qualcomm PMIC button driver
      mach-snapdragon: switch to PMIC button driver
      gpio: qcom_pmic: drop pon GPIO driver
      gpio: qcom_pmic: support upstream DT
      dts: qcom: adjust pmic gpio to use upstream bindings
      gpio: qcom_pmic: drop gpio-count property
      spmi: msm: fix register range names
      pmic: qcom: dont use dev_read_addr to get USID
      test: spmi: fix tests
      sandbox_flattree: enable button support

Konrad Dybcio (1):
      clk/qcom: handle resets and clocks in one device

 MAINTAINERS                                        |   3 +
 arch/arm/Kconfig                                   |   3 +
 arch/arm/dts/dragonboard410c-uboot.dtsi            |  11 -
 arch/arm/dts/dragonboard410c.dts                   |  25 +-
 arch/arm/dts/dragonboard820c-uboot.dtsi            |  12 -
 arch/arm/dts/dragonboard820c.dts                   |  26 +-
 arch/arm/dts/dragonboard845c-uboot.dtsi            |  13 +-
 arch/arm/dts/dragonboard845c.dts                   |   4 +
 arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
 arch/arm/dts/qcs404-evb.dts                        |  29 +-
 arch/arm/dts/sdm845.dtsi                           |  44 +--
 arch/arm/dts/starqltechn-uboot.dtsi                |  15 +-
 arch/arm/dts/starqltechn.dts                       |  36 +--
 arch/arm/mach-ipq40xx/Makefile                     |   9 -
 arch/arm/mach-ipq40xx/clock-ipq4019.c              |  88 ------
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.c         | 166 -----------
 arch/arm/mach-snapdragon/Kconfig                   |  11 +
 arch/arm/mach-snapdragon/Makefile                  |  10 -
 arch/arm/mach-snapdragon/clock-sdm845.c            |  98 -------
 arch/arm/mach-snapdragon/clock-snapdragon.c        | 181 ------------
 arch/arm/mach-snapdragon/clock-snapdragon.h        |  48 ----
 arch/arm/mach-snapdragon/include/mach/gpio.h       |  28 +-
 .../mach-snapdragon/include/mach/sysmap-apq8016.h  |  39 ---
 .../mach-snapdragon/include/mach/sysmap-apq8096.h  |  37 ---
 .../mach-snapdragon/include/mach/sysmap-qcs404.h   |  88 ------
 .../mach-snapdragon/include/mach/sysmap-sdm845.h   |  42 ---
 arch/arm/mach-snapdragon/init_sdm845.c             |  45 +--
 arch/arm/mach-snapdragon/pinctrl-sdm845.c          |  44 ---
 arch/arm/mach-snapdragon/pinctrl-snapdragon.h      |  33 ---
 arch/sandbox/dts/test.dts                          |   2 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  31 +--
 board/qualcomm/dragonboard820c/dragonboard820c.c   |  35 +--
 configs/sandbox_flattree_defconfig                 |   3 +
 doc/device-tree-bindings/gpio/pm8916_gpio.txt      |  48 ----
 doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt   |  94 -------
 doc/device-tree-bindings/spmi/spmi-msm.txt         |  26 --
 drivers/button/Kconfig                             |   9 +
 drivers/button/Makefile                            |   1 +
 drivers/button/button-qcom-pmic.c                  | 165 +++++++++++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/qcom/Kconfig                           |  52 ++++
 drivers/clk/qcom/Makefile                          |  10 +
 .../clk/qcom}/clock-apq8016.c                      |  60 +++-
 .../clk/qcom}/clock-apq8096.c                      |  56 +++-
 .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 160 ++++-------
 drivers/clk/qcom/clock-qcom.c                      | 307 +++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h                      | 100 +++++++
 .../clk/qcom}/clock-qcs404.c                       | 167 +++++++++--
 drivers/clk/qcom/clock-sdm845.c                    | 187 +++++++++++++
 drivers/gpio/Kconfig                               |   5 +-
 drivers/gpio/msm_gpio.c                            |  42 +--
 drivers/gpio/qcom_pmic_gpio.c                      | 138 +++------
 drivers/misc/Kconfig                               |   7 -
 drivers/misc/Makefile                              |   1 -
 drivers/misc/qcom-geni-se.c                        |  41 ---
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/qcom/Kconfig                       |  46 +++
 drivers/pinctrl/qcom/Makefile                      |  10 +
 .../pinctrl/qcom}/pinctrl-apq8016.c                |  21 +-
 .../pinctrl/qcom}/pinctrl-apq8096.c                |  21 +-
 .../pinctrl/qcom}/pinctrl-ipq4019.c                |  25 +-
 .../pinctrl/qcom/pinctrl-qcom.c                    |  70 +++--
 .../pinctrl/qcom/pinctrl-qcom.h                    |  15 +-
 .../pinctrl/qcom}/pinctrl-qcs404.c                 |  21 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              | 100 +++++++
 drivers/power/pmic/pmic_qcom.c                     |  13 +-
 drivers/reset/Kconfig                              |   7 -
 drivers/reset/Makefile                             |   1 -
 drivers/serial/Kconfig                             |   2 -
 drivers/serial/serial_msm_geni.c                   |  38 ++-
 drivers/spmi/spmi-msm.c                            |  46 ++-
 include/configs/dragonboard410c.h                  |   1 -
 include/configs/dragonboard820c.h                  |   1 -
 include/configs/dragonboard845c.h                  |   1 -
 include/configs/qcs404-evb.h                       |   1 -
 include/configs/sdm845.h                           |   1 -
 .../{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h}     |  73 +++++
 include/dt-bindings/reset/qcom,ipq4019-reset.h     |  92 ------
 test/dm/spmi.c                                     |   4 +-
 81 files changed, 1772 insertions(+), 1791 deletions(-)
 delete mode 100644 arch/arm/mach-ipq40xx/Makefile
 delete mode 100644 arch/arm/mach-ipq40xx/clock-ipq4019.c
 delete mode 100644 arch/arm/mach-ipq40xx/pinctrl-snapdragon.c
 delete mode 100644 arch/arm/mach-snapdragon/clock-sdm845.c
 delete mode 100644 arch/arm/mach-snapdragon/clock-snapdragon.c
 delete mode 100644 arch/arm/mach-snapdragon/clock-snapdragon.h
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-apq8016.h
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-apq8096.h
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-qcs404.h
 delete mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
 delete mode 100644 arch/arm/mach-snapdragon/pinctrl-sdm845.c
 delete mode 100644 arch/arm/mach-snapdragon/pinctrl-snapdragon.h
 delete mode 100644 doc/device-tree-bindings/gpio/pm8916_gpio.txt
 delete mode 100644 doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt
 delete mode 100644 doc/device-tree-bindings/spmi/spmi-msm.txt
 create mode 100644 drivers/button/button-qcom-pmic.c
 create mode 100644 drivers/clk/qcom/Kconfig
 create mode 100644 drivers/clk/qcom/Makefile
 rename {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8016.c (60%)
 rename {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8096.c (61%)
 rename drivers/{reset/reset-qcom.c => clk/qcom/clock-ipq4019.c} (50%)
 create mode 100644 drivers/clk/qcom/clock-qcom.c
 create mode 100644 drivers/clk/qcom/clock-qcom.h
 rename {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-qcs404.c (52%)
 create mode 100644 drivers/clk/qcom/clock-sdm845.c
 delete mode 100644 drivers/misc/qcom-geni-se.c
 create mode 100644 drivers/pinctrl/qcom/Kconfig
 create mode 100644 drivers/pinctrl/qcom/Makefile
 rename {arch/arm/mach-snapdragon => drivers/pinctrl/qcom}/pinctrl-apq8016.c (73%)
 rename {arch/arm/mach-snapdragon => drivers/pinctrl/qcom}/pinctrl-apq8096.c (72%)
 rename {arch/arm/mach-ipq40xx => drivers/pinctrl/qcom}/pinctrl-ipq4019.c (71%)
 rename arch/arm/mach-snapdragon/pinctrl-snapdragon.c => drivers/pinctrl/qcom/pinctrl-qcom.c (69%)
 rename arch/arm/mach-ipq40xx/pinctrl-snapdragon.h => drivers/pinctrl/qcom/pinctrl-qcom.h (67%)
 rename {arch/arm/mach-snapdragon => drivers/pinctrl/qcom}/pinctrl-qcs404.c (76%)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm845.c
 rename include/dt-bindings/clock/{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h} (58%)
 delete mode 100644 include/dt-bindings/reset/qcom,ipq4019-reset.h
