Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B72DC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D54C808AF;
	Mon, 24 Mar 2025 19:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCiTdJwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CD1809D0; Mon, 24 Mar 2025 19:19:42 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52D6801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a823036so48492605e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840379; x=1743445179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKoh3U2cniPsOJVZrUmv/s2Yqz4VAxnjhyMnci+HV00=;
 b=CCiTdJwtfgzP27kPr1DBsaE33Yxwvmh6SYKJAPZo6E8ULu+Hyy5nZjjrVeUVM0Eokc
 HEw1G9q0XE92bC5DKHPGfwHr7IqCAhpOf+VMIFn2cjmEqeliLE/zcgu4YT6pr4bKVtQj
 7VIka6ylpKbeszVlhwVE8vQWJ3c/xFxA/ouyJZmVi2xmhWbT4u4geVZyZd8fmnmjXi1E
 KGdEWLGrRQ8tmspvy2fVi9dlSC/8wB9YQnwdV+yINF8cNzKFrVr2AWkAl3mcD+6H6ryW
 N+JNRVD/viMWz5+bYnOz/PG6OW0oq4Q6czEwSHtUidgKvCcdf9e/FfY6pzXi42nDmQEp
 Kvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840379; x=1743445179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKoh3U2cniPsOJVZrUmv/s2Yqz4VAxnjhyMnci+HV00=;
 b=rescHdGTW/LxUiyTV5PMevEgzs1mFVQP600ZNTwxc9S39RY3P249Z9k+mCKdNMDMq8
 x9v6FtYpQVduFMv+s9Hfr4eRO46di+MrwKzVWJ4ZWXTkcd1VeOCZibf5uigRCLvP4god
 BxDu+2vAeirAGdinmA1X4B/FVE4G81i/079/VFf1rkZnstRLVQeMle94g8ozOVaBjAWq
 fy+RQfE/R4ih0d0h3bkkJuiBFQyCkFZ1WlPCcS8zsVKtkaNjk73vgG67rVqnRtdg1utg
 epvlJ2Yqnc+jzZzWw0FZV5X9gxpsRuW+lvlakrU2nTYWtH8z9XMPk3JpQe+OH2su3Bl2
 lCnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9EyKNxgZatdgOV71AgiRl33WS/Qj/v+OE5Xzszb4stWKt3eSMonWQQbyGxeS2GaowDNsAHWo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz21HAug8jguQiNbXxkcpPxw5viYOvdQKi+XE9t6QdfoMYPP1er
 p1sfRHyapwZ0DHiZEViaHRRqePbU5xlFlvXkaiC9f4LEq4+1SVWrTBV2irkkkEg=
X-Gm-Gg: ASbGncuDCKuww8b4EyEH6vYz3E+SYPhr4cli1aAjbRUfdKI6iDti35Zml9dxusSQwrq
 8qlf6JuKwGYwbtXXufmSkvLedtsbVwCTVbiZUNBC7k6N4vYDtS3T26MwmlJAieBAa/Cs9g9w/2U
 7Z568WT2Gv0rW0rCWT/U+bpcJ9PxYrq/TREAlpHZPKjhs2aAEMnKqTJ2ZiB/Sn2pnpXfDBINalH
 z3hAhJZDX1fs9X3TrLbISjIQs2VwXyDOEEE6aj7FKuAe5PAjdt0Hv/8DmQOP9RD2stdgrzmAcq8
 o5uemD1+EN4XHsZWblDKIF4IC8OuV8roS57BUPfSwoqah3t4ZAgyxKaYbsS7foniQ43Qz1WlvY+
 Xw5fcnIeNV9o3
X-Google-Smtp-Source: AGHT+IF3a/ChbVgk8gGnxvUNoyLknpAB6zYuzFhmlimhwW4A0N8YA7O0muUWh/xZO51Spf92PCizgQ==
X-Received: by 2002:a05:600c:1e26:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-43d50a4e498mr141418715e9.31.1742840379284; 
 Mon, 24 Mar 2025 11:19:39 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6445sm11650983f8f.71.2025.03.24.11.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:19:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-20250324
Date: Mon, 24 Mar 2025 19:18:12 +0100
Message-ID: <20250324181903.499245-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Take 2, this includes that build failure fix, sorry about that.

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/25297

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

  Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-20250324

for you to fetch changes up to dcb6a5e7651f4a6cebfad4389119407e2a852783:

  mach-snapdragon: always select SYSRESET_PSCI for ARCH_SNAPDRAGON (2025-03-18 11:55:14 +0000)

----------------------------------------------------------------
qcom-next-20230324

take 2

----------------------------------------------------------------
Caleb Connolly (8):
      pinctrl: qcom: add sc7280 pinctrl driver
      qcom_defconfig: enable PINCTRL_QCOM_SC7280
      clk/qcom: bubble up qcom_gate_clk_en() errors
      clk/qcom: sc7280: add some debug data
      clk/qcom: sc7280: add GENI, PCIe, and more USB clocks
      pinctrl/qcom: fix kconfig option names
      clk/stub: add sc7280-rpmh clock
      mach-snapdragon: always select SYSRESET_PSCI for ARCH_SNAPDRAGON

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

 arch/arm/Kconfig                        |   2 +
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi |  25 ++++
 arch/arm/mach-snapdragon/board.c        | 123 ++++++++++++-----
 configs/qcom_defconfig                  |   2 +
 configs/qcom_ipq9574_mmc_defconfig      |  83 ++++++++++++
 doc/board/qualcomm/index.rst            |   1 +
 doc/board/qualcomm/rdp.rst              |  55 ++++++++
 drivers/clk/clk-stub.c                  |   1 +
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
 44 files changed, 906 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9574_mmc_defconfig
 create mode 100644 doc/board/qualcomm/rdp.rst
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280.c
