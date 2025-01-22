Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A64C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A780809A5;
	Wed, 22 Jan 2025 17:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r+c9igbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A0380977; Wed, 22 Jan 2025 17:24:19 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE38809A5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so11964908a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737563056; x=1738167856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oa43CnP2oz8OyIrZ5Y5LOfGfR3maOBtzlfA/ACPB4QU=;
 b=r+c9igbSq6hDNKi7ko22RIsjJKPoJnI6gJZy4c6AklBaqUh1VBmtjp886phgXiXzjC
 yE1Zpebaec2GlLj7BNBC72r7W98nff84p/YJOb6yUhVhuOMy9GoiOmJPOOzsPLURSrd9
 5q9YqFyg8cXBrDss0yHRFX3yzThrjGFqNpqQE4DUldWUyplnvNgO/A2+u9ijljdO7upC
 04lvhOQFOWFYtjxfW/u1mvZNsO6U+9g+15cAAsTMiFf616mDGFial7BZxvhog0/LEk4X
 i7Iwlpba2E40WempiIFtb0LslVwBQgsOkg59QgZiXt/yL/v2rOrEiOr49oFVy/vxMlTE
 /0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737563056; x=1738167856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oa43CnP2oz8OyIrZ5Y5LOfGfR3maOBtzlfA/ACPB4QU=;
 b=TG91Xu1+FE6PLNB5pbJRz/rZXqYDDlgxWjgSRT6LSVvlslPGCSICLc9vt43HLKeWu5
 yWZxGsjyuRpWl+Ju5VB5t4ORxBSWWJ271pwgEKDq7sIX3EcA9JpYLgl9T2jcyE5UllEE
 /qmtm6zMrDo825D165Yoj/6eexVf2qCTHtxDDB8OfqRHbDAhdZVrO3ctofnp55dkR/nE
 gvPHEc5FMxPiq0JycMs+VK+GINmVkfnqmPpJxZgX2zvssbL0ZL/MmTHjFE5p3MnhxeRU
 g1sDl6HR+UgiE9I61GTFQft2Y2D8k1gURe0vZegZzDPN6olLrIikppGl6VcANfbsacJe
 iaUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWddLoeFWbgvuINmKciobsqe+FkaLm2vU3UkUBiry0N5jq+nqeGFg3ujBsaQ7uApC6SEO0eUbo=@lists.denx.de
X-Gm-Message-State: AOJu0YydYcpIuK7+gZTnVyjT3EyjbPJuDN3U2g225+hREPx4JlKMzesq
 mdkM0v5f1kqd66B7vlDJLXQGUON8yG1aQRjaWAiVks++gISm4lr4T8O40AOc7FE=
X-Gm-Gg: ASbGnctdTNMvj46QiClxgULoBD91evuqz5Uaj2It/K1zb/VcpPa4D11WoWvResJdnrI
 aux/8122BSLV8j/EJ07UqAKZoMe+PZKryOv4WCO2V71d4te0R7Z8bo3aUAeDlm0DnGrAtiWLFMs
 qnq9CV2AWh9S1NuPrKk/rgk6Fm6WdeIuRixwamvL+X0WFzvCznL7WLwqhEz60rK8cCX5o7MngAB
 5aU0R5iMFy9iHc0e51cW6N+HVXbCLxA6z+T54RnuTlKa+33iidNkk1cldBIgWcY4Ylfb049ZcN6
 71ZacZm41tYGFGZnvGLbhNO7vKac
X-Google-Smtp-Source: AGHT+IEuopFj+NrM8L9Lq6uempQ+5HKXIL+BKYu0pow8tN3T6bzREVzfgVTFdAIVbQQZ1Kd3vuuUVQ==
X-Received: by 2002:a17:906:d54f:b0:aa6:1e9a:e45a with SMTP id
 a640c23a62f3a-ab38b3893c1mr1965094066b.46.1737563055709; 
 Wed, 22 Jan 2025 08:24:15 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5ad7bsm929333566b.36.2025.01.22.08.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:24:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>,
 =?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 u-boot@lists.denx.de, u-boot-qcom@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-next
Date: Wed, 22 Jan 2025 17:17:45 +0100
Message-ID: <20250122162407.1870390-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The highlights are:

* Fixed boot regression due to broken memory parsing
* Enable HW RNG and KASLR on all platforms
* Add support for Snapdragon X1 Elite hardware (clk/pinctrl)
* Add support for QCS9100 ride automotive development platform (clk/ufs)
* Add support for PCIe on SM8550, SM8650 and X1E
* Implement software debounce for PMIC buttons

Additionally, some minor improvements to "ufetch" have been pulled in:

* Show CPU architecture (arm/mips/etc)
* Make CONFIG_BLK optional
* Fix 32-bit support

The following changes since commit 82d262ae162d859d3b0bbcd40a9464e890b009da:

  Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)" (2025-01-21 09:29:05 -0600)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD

for you to fetch changes up to 599a1f9076d34c29d3683e0f833706478d62d9e0:

  MAINTAINERS: maintain qcs9100_defconfig (2025-01-22 17:14:24 +0100)

----------------------------------------------------------------
Caleb Connolly (2):
      button: qcom-pmic: add software debounce
      MAINTAINERS: maintain qcs9100_defconfig

J. Neuschäfer (3):
      cmd: ufetch: Fix type mismatch on 32-bit
      cmd: Allow building ufetch without CONFIG_BLK
      cmd: ufetch: Show CPU architecture under "CPU"

Neil Armstrong (17):
      clk: qcom: Add X1E80100 clock driver
      qcom_defconfig: enable X1E80100 clock driver
      pinctrl: qcom: Add X1E80100 pinctrl driver
      qcom_defconfig: enable X1E80100 pinctrl driver
      pinctrl: qcom: sm8550: add pcie1_clk_req_n function
      pinctrl: qcom: sm8650: add pcie[01]_clk_req_n function
      pinctrl: qcom: x1e80100: add pcie[3456ab]_clk functions
      regulator: qcom-rpmh-regulator: add support for pmc8380 regulators
      clk: qcom: add clk_phy_mux_enable() for PCIe PIPE clock
      clk: qcom: sm8550: add support for PCIe clocks
      clk: qcom: sm8650: add support for PCIe clocks
      clk: qcom: x1e80100: add support for PCIe clocks
      rng: msm: add support for newer Qualcomm hwrandom IPs
      configs: qcom_defconfig: enable RNG driver and command
      pci: pcie_dw_common: introduce pcie_dw_find_capability()
      pci: Add support for Qualcomm PCIe controller
      phy: qcom: add QMP PCIe PHY driver

Sam Day (1):
      mach-snapdragon: pass fdt to qcom_parse_memory

Tengfei Fan (1):
      arm64: dts: qcom: qcs9100: Add support for the QCS9100 Ride and Ride Rev3 boards

Varadarajan Narayanan (5):
      dts: qcs9100-ride-r3-u-boot: add override dtsi
      clk/qcom: add initial clock driver for qcs9100
      phy: qcom: Add SA8775 to QMP UFS PHY driver
      qcom_defconfig: enable SA8775P clock driver
      configs: add qcs9100_defconfig

 MAINTAINERS                                        |    1 +
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi           |   20 +
 arch/arm/mach-snapdragon/board.c                   |   15 +-
 cmd/Kconfig                                        |    1 -
 cmd/ufetch.c                                       |   17 +-
 configs/qcom_defconfig                             |    6 +
 configs/qcs9100_defconfig                          |   18 +
 drivers/button/button-qcom-pmic.c                  |   14 +-
 drivers/clk/qcom/Kconfig                           |   16 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clock-qcom.c                      |   19 +
 drivers/clk/qcom/clock-qcom.h                      |    2 +
 drivers/clk/qcom/clock-sa8775p.c                   |  142 +++
 drivers/clk/qcom/clock-sm8550.c                    |   36 +
 drivers/clk/qcom/clock-sm8650.c                    |   36 +
 drivers/clk/qcom/clock-x1e80100.c                  |  402 +++++++
 drivers/pci/Kconfig                                |    8 +
 drivers/pci/Makefile                               |    1 +
 drivers/pci/pcie_dw_common.c                       |   42 +
 drivers/pci/pcie_dw_common.h                       |    2 +
 drivers/pci/pcie_dw_qcom.c                         |  571 ++++++++++
 drivers/phy/qcom/Kconfig                           |    6 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-qmp-pcie-qhp.h           |  123 +++
 drivers/phy/qcom/phy-qcom-qmp-pcie.c               | 1131 ++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v3.h        |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v4.h        |   72 ++
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v4_20.h     |   19 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v5.h        |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v5_20.h     |   23 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v6.h        |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v6_20.h     |   25 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v5.h             |   34 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h             |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6_20.h          |   19 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h     |  124 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v6.h |   32 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h    |  231 ++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h    |   83 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_20.h |   51 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                |  171 +++
 drivers/pinctrl/qcom/Kconfig                       |    7 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-sm8550.c              |    1 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c              |    2 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c            |  105 ++
 drivers/power/regulator/qcom-rpmh-regulator.c      |   19 +
 drivers/rng/msm_rng.c                              |   13 +-
 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts    |   11 +
 dts/upstream/src/arm64/qcom/qcs9100-ride.dts       |   11 +
 include/pci.h                                      |    4 +
 51 files changed, 3756 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
 create mode 100644 configs/qcs9100_defconfig
 create mode 100644 drivers/clk/qcom/clock-sa8775p.c
 create mode 100644 drivers/clk/qcom/clock-x1e80100.c
 create mode 100644 drivers/pci/pcie_dw_qcom.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcie-qhp.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcie.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v4_20.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v5_20.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_20.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-x1e80100.c
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride.dts
