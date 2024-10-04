Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B557CF8842
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A66888975;
	Fri,  4 Oct 2024 16:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jUQDSxz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EA98897F; Fri,  4 Oct 2024 16:22:36 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C1188915
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cd8a5aac9so1303215f8f.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728051753; x=1728656553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7MGB0FkD8K3YoRtQvthJibmvmYtfqurNF4GNWfO4i2w=;
 b=jUQDSxz6bjnbPba8WJTzPUIJWk2G6LkUz7+hcvl+FZQgdzl8+wv0i3BVaRTg+0AdMa
 5HIdW6YFjT2hKpwxHLDgZ8HzJH4EE5VY39hiU2vDPGfH4qVtExHByD1F3ETvPsKQBWc/
 Ork+ugEiqMN2kkzeS699al9s4pE9q6nx1TGB/s/maPCUeoZOoz1YGeiMPK50ohyIQsY8
 Qf1be2aCt+Faqw/IcWBGzsKq5GtQd3dAzvGIy8cXGux2xXFTgPMNc1htM6P8Q/MbPLTF
 n/gZ/gOS8EdyhTWXjLfJTN8Q3GpzcHMVqajiTEqVEOtdz0JEeYVSDNPM+WzTivMe45Vt
 EVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728051753; x=1728656553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7MGB0FkD8K3YoRtQvthJibmvmYtfqurNF4GNWfO4i2w=;
 b=CRBLVows73MVIZNxzlYdE3ONu+AezsbklIfp9VoGlOyo/yXK8TrTDOiulejq1p2iBK
 PqEpvdSqYUFvHooh+QmiY7EYWwNdoKu9fy3ETVU+trK3d8iBEJG5CZmAqGgz3hfmESVI
 DwT2YDeWWK/AvXTnoZiX2fqF/f25cfHsRqVoEdAuTqziJAomYclfhZBC9cZ97OMWgfyU
 VkOXt/+UXLPqCKQu3zKq0SVmbRfSm0yrskCQKX7MGm1AeHgg4MK7peY5qLghiu8jmI8D
 JUcwkag47R9+cNOBexXNXv8kx2tIhC0IByHooP64jZXZsOqPo1Sq0asGwOPIzfL3Dyhn
 O8rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcc9lVGXtNXJBwU8asqHZkcapOoMQHjiQfVW8BV5iTYrG2p/cEtWOV+GI6pHLfDU96NjWk+o0=@lists.denx.de
X-Gm-Message-State: AOJu0YzedktGQGwzXeIRjJAJlqr2RrrruXabI4O22Tu29/wXGJ3YNX1u
 ZDnPSE0AIHbjMofyydiTILK5yPbVtK9uJ5cubhC+wSNcZ1YMrEvse3tNRiSA+Lw=
X-Google-Smtp-Source: AGHT+IFFBB0UZ85/28657jk2pX9MH7IDHYfPCR9+Ghkc2eedpk+5yC4yv+DVZO5EnuQ7hpUawhgVsA==
X-Received: by 2002:adf:e014:0:b0:37c:cc5e:9996 with SMTP id
 ffacd0b85a97d-37d0e6bc9aemr1698944f8f.8.1728051753242; 
 Fri, 04 Oct 2024 07:22:33 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a1f6casm16912315e9.3.2024.10.04.07.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 07:22:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-next
Date: Fri,  4 Oct 2024 16:22:19 +0200
Message-ID: <20241004142228.271558-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.2
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

Various improvements and fixes for Qualcomm

* Initial UFS PHY driver
* Support for SM8150 (clock and pinctrl)
* Allow writing configuration to PMIC GPIOs again
* Support for configuring "special" pins (e.g. UFS reset or sdhc pins)
* Support for "clk dump" command to decode various clocks.

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/22527
---
The following changes since commit 00292c6b39b3f7dcb34e8c3ae6ef276ac862a146:

  Merge tag 'u-boot-dfu-next-20241003' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2024-10-03 16:09:40 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-next

for you to fetch changes up to 04584089e12e34aa91ef06aeb91b1550facb0312:

  clk/qcom: sm8250: add debug data (2024-10-04 14:57:04 +0200)

----------------------------------------------------------------
Bhupesh Sharma (2):
      phy: qcom: Import QMP phy related header files from Linux
      phy: qcom: Add QMP UFS PHY driver

Caleb Connolly (5):
      Revert "gpio: qcom_pmic: add a quirk to skip GPIO configuration"
      clk/qcom: implement clk dump
      clk/qcom: sdm845: add dump data
      clk/qcom: sm6115: add debug data
      clk/qcom: sm8250: add debug data

Julius Lehmann (3):
      clk: qcom: add driver for SM8150 SoC
      pinctrl: qcom: add driver for SM8150 SoC
      config: qcom: add sm8150 to qcom_defconfig

Neil Armstrong (2):
      gpio: msm: add support for special pins
      pinctr: qcom: sm8250: add special pins pins configuration data

 configs/qcom_defconfig                             |    2 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clock-qcom.c                      |  119 +++
 drivers/clk/qcom/clock-qcom.h                      |    6 +
 drivers/clk/qcom/clock-sdm845.c                    |   93 ++
 drivers/clk/qcom/clock-sm6115.c                    |   63 ++
 drivers/clk/qcom/clock-sm8150.c                    |  319 ++++++
 drivers/clk/qcom/clock-sm8250.c                    |  115 ++
 drivers/gpio/msm_gpio.c                            |  101 +-
 drivers/gpio/qcom_pmic_gpio.c                      |   27 +-
 drivers/phy/qcom/Kconfig                           |    6 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h         |   25 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h         |   21 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h         |   31 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h         |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h         |   38 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h             |   43 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h             |  145 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h             |  135 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h     |  111 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h     |  123 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |   89 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        |  140 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h        |   69 ++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   52 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h    |   68 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h    |  233 ++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h       |  205 ++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                | 1116 ++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h                    |  115 ++
 drivers/pinctrl/qcom/Kconfig                       |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-sm8150.c              |  156 +++
 drivers/pinctrl/qcom/pinctrl-sm8250.c              |   42 +-
 36 files changed, 3824 insertions(+), 36 deletions(-)
 create mode 100644 drivers/clk/qcom/clock-sm8150.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-ufs.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
