Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13586C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 15:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B72D8081A;
	Mon, 17 Mar 2025 16:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpZvDcrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBC880F4C; Mon, 17 Mar 2025 16:23:57 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D8480107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 16:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso16255135e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742225034; x=1742829834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hFpAx9BU5h9opAHkh3Pxu+ripw5ZWbCHt7LD3FqDp40=;
 b=GpZvDcrROwq21piwCu2t3CZCpl7dXxc+FdtAmr2LfW9gyFusxcL9hvrjrlEtXVUKCs
 JMOOmrOY1u2Qd6wIdXkmos32FvZNNo7wIa7RvQjmhjUPl38WeACDd+YBojynmqMpnNh8
 AfXOhJIOeFVIuRhmFDY26MOoa9rAH0+h8saroCAnw9LvLkfDXCWIW3yBl6Lhtfl1m/e3
 X1bLei5cU0GwYAZ5K8HQtH44l1XZrIKdj59Cmns8ZqJSYnJ7fldzmspXbff9TJ7uQOFN
 JK64L779i8MqwQxj55DdOywmPhJLi6vkBEzJeNP7B1iPSXnLp+mJYcjl2R/034vdNBQ9
 k8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225034; x=1742829834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFpAx9BU5h9opAHkh3Pxu+ripw5ZWbCHt7LD3FqDp40=;
 b=HbtcTayneAW0r8jxrz5cevBBFPs4nGaTpx5xhC2xbu+ZCKP91VrvJYhl3E0PUrVJtx
 E8BKnl+bMKkdBTyPb9V16rkoNl0mfm0GAv7l40Upof/g/jCvB6fSjiyG672/k3zhHGPK
 YCDNqlsVOnwhjcfcRCV52uepgKiM9NEPG5G4/fw1TBt48g9U/KXfP/ZikNjXK5n+Upwb
 bYLdhgdMjVhHw8/pHcHqy86+JBE6EYN3B2xh0rQCan8R8yWaDxFg/x5X5AUN3YsGiWxU
 S9ijqXZ+9ArCHsUSBT1WKgxAnqHyZ7UpgjYr9dDsVYaB0z2tkmBHiaGDkCwSSXbizeec
 tu0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRmZumkvVuV+jku2fKFJpvFrLxhiS+zZdmwnJ5OSRrD1R90Fp/slxWkaKtpiX5zA2h858sOAQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv835c9DAf0RIOpntxJhCwLuNDwR5CAf3Pg1EoqlE5A7L3slVR
 X2t5NY2UpIVjC46vC8SHcxU2CxZPb12w60xaKlC3kqNeVovwh1vbwX87/Tbs4ys=
X-Gm-Gg: ASbGncvBsmvk26G5ls300oKiYnCdyL+A4o6o4FgeJ8o5wZ0+l5zoo3MPaOmFAIX3l87
 BYNKY9JoLehx3ZL3crJmjGHXUFd89gLjpC5rWyB7e7oM+L8rNuEVEZAYGW4oIh3q50fMVWsll8D
 74jsILNpnv0Y71yXx/OmA6hsNVOMw6hz1R6D8pqRq/IZboVrak9dWjFR5j9dRPIiiumSUehL1s1
 YyeiqK6aZAd/rZzfRSXp6MuGJ8MrO4xSqYk36u9tTY/dYiLLyLkCk5yfXDxZE3yAcmAkIAqJY/v
 jxs9XJYFstsKbKCbuHY45RX2X/7uDp7gqmXBhCTZS9dBdF29rwUMH7hMkwRMQNzo0yLwfjo=
X-Google-Smtp-Source: AGHT+IE6SVAITf6wIpelL8mks19pw3COHfb/9QSr35Ot56eqFaGkdtRVPQgBGhpPgjnHyWEQTVI2eQ==
X-Received: by 2002:a05:6000:1848:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-3971f7f794fmr12968224f8f.44.1742225034314; 
 Mon, 17 Mar 2025 08:23:54 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8881544sm14981174f8f.43.2025.03.17.08.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:23:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-20250317
Date: Mon, 17 Mar 2025 15:16:24 +0000
Message-ID: <20250317152328.107426-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
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

A new platform and a nice handful of improvements for Qualcomm so far
this cycle:

* msm8916 gets proper sysreset and spin-table support
* the first new IPQ platform is added - the IPQ9574. The IPQ series are
  used in routers. The flashing process is also documented
* mach-snapdragon gains the ability to boot with an internal FDT and
  still parse memory from an externally provided one
* SC7280 gets a pinctrl driver and various clock driver improvements.
* Qualcom clock drivers will now actually return an error when attempting
  to enable a clock which isn't described.
* Qualcomm pinctrl drivers will now return an error when attempting to
  configure an invalid function mux

Kind regards,
Caleb

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

  Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-20250317

for you to fetch changes up to 69aab567407efe67b8b2a10a3843656101b402ca:

  pinctrl/qcom: fix kconfig option names (2025-03-17 15:12:26 +0000)

----------------------------------------------------------------
Qualcomm patches for U-Boot next 2025-03-17

----------------------------------------------------------------
Caleb Connolly (6):
      pinctrl: qcom: add sc7280 pinctrl driver
      qcom_defconfig: enable PINCTRL_QCOM_SC7280
      clk/qcom: bubble up qcom_gate_clk_en() errors
      clk/qcom: sc7280: add some debug data
      clk/qcom: sc7280: add GENI, PCIe, and more USB clocks
      pinctrl/qcom: fix kconfig option names

Sam Day (10):
      clk/qcom: apq8016: use BIT macro for clk en_vals
      clk/qcom: apq8016: add PRNG_AHB_CLK
      rng: msm: don't enable PRNG if it's already enabled
      clk/qcom: apq8016: improve clk_enable logging
      rng: msm: keep core clock disabled when PRNG not in use
      mach-snapdragon: support parsing memory info from external FDT
      mach-snapdragon: handle platforms without PSCI support
      mach-snapdragon: use PSCI sysreset driver
      sysreset: qcom-pshold: remove ARCH_IPQ40XX dependency
      qcom_defconfig: enable SYSRESET_QCOM_PSHOLD

Varadarajan Narayanan (7):
      doc: board/qualcomm: document RDP building/flashing
      dts: ipq9574-rdp433-u-boot: add override dtsi
      clk/qcom: add initial clock driver for ipq9574
      pinctrl: qcom: Handle get_function_mux failure
      pinctrl: qcom: Add ipq9574 pinctrl driver
      mmc: msm_sdhci: Reset clocks before reconfiguration
      configs: add qcom_ipq9574_mmc_defconfig

 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi |  25 ++++
 arch/arm/mach-snapdragon/board.c        | 123 ++++++++++++-----
 configs/qcom_defconfig                  |   4 +
 configs/qcom_ipq9574_mmc_defconfig      |  83 ++++++++++++
 doc/board/qualcomm/index.rst            |   1 +
 doc/board/qualcomm/rdp.rst              |  55 ++++++++
 drivers/clk/qcom/Kconfig                |   8 ++
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-apq8016.c        |  12 +-
 drivers/clk/qcom/clock-ipq9574.c        |  94 +++++++++++++
 drivers/clk/qcom/clock-qcm2290.c        |   4 +-
 drivers/clk/qcom/clock-qcom.h           |  13 +-
 drivers/clk/qcom/clock-sa8775p.c        |   4 +-
 drivers/clk/qcom/clock-sc7280.c         | 124 ++++++++++++++++--
 drivers/clk/qcom/clock-sdm845.c         |   4 +-
 drivers/clk/qcom/clock-sm6115.c         |   4 +-
 drivers/clk/qcom/clock-sm8150.c         |   4 +-
 drivers/clk/qcom/clock-sm8250.c         |   4 +-
 drivers/clk/qcom/clock-sm8550.c         |   4 +-
 drivers/clk/qcom/clock-sm8650.c         |   4 +-
 drivers/clk/qcom/clock-x1e80100.c       |   4 +-
 drivers/mmc/msm_sdhci.c                 |  10 ++
 drivers/pinctrl/qcom/Kconfig            |  38 ++++--
 drivers/pinctrl/qcom/Makefile           |   2 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq9574.c  | 226 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcm2290.c  |   2 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c     |   5 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h     |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sc7280.c   | 106 +++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sdm845.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm6115.c   |   2 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm8250.c   |   2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm8650.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-x1e80100.c |   4 +-
 drivers/rng/msm_rng.c                   |  13 +-
 drivers/sysreset/Kconfig                |   1 -
 42 files changed, 905 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9574_mmc_defconfig
 create mode 100644 doc/board/qualcomm/rdp.rst
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280.c
