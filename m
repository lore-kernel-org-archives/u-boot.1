Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7B1C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5864840DE;
	Fri, 11 Apr 2025 16:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DZTbuZIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DB582114; Fri, 11 Apr 2025 16:31:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AA7840D7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so18658385e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744381892; x=1744986692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrOoMtCwcPcrmBa+GKkK8x8Qf0vKi4GSoh9dctXxTR4=;
 b=DZTbuZIKyZDgkSkoRd/3iXl+vNCyohkJ4nHv1sODb8NsC/qsOpZPxUOuq1eIEH5uMq
 3PA7G/Da1wXbdKdGeSz2XGD4nDQk7RsKt5IMmkpzBZK2v/3zJU3vHNGITnnCWfqUGjPD
 2F3R3ufMJIb1kyE6V5fjPlkAoYKp6esK6VfO4mxBIKew/iuWH6ygWlmuJjTKWHf1ENC6
 etBqfDqWZ/jGssK8byLTO0mUqM9jrYyrZQFq1D0RLhKGLyKwht2C7p0ZnbH34Jr3GJiI
 eYwQ4XqqeWmzOFkLU+Hx43goXWt8/A/69TFe+LA68ytrCxUkeUbMomg3UZfwV9Kyh9u6
 R0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744381892; x=1744986692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrOoMtCwcPcrmBa+GKkK8x8Qf0vKi4GSoh9dctXxTR4=;
 b=j8IiwgOn6hrotWqSUPwglYWP3bnuhgb7K3+8xV2pLEDN34LAxHG7tUPb94JcnMDR6n
 ZGI1t9m+BZuG/5MnF3VAVXV8uM4s+rZPzx8LGQjZsVfyLRfLSSHZ/53D60TvgAQNmNn0
 OnbHvkc4HbgCzPs3mS0QNabBckod9K1/qvIlu5epi80ISJm7+ckuI3dcKV8pSo+nsLsr
 WuArwxYTcvsXFnxCGQVaGUXrCQtddoT+hmC6qimRI8taBiebWBAx7wTZSwLpeziHlDf4
 1QGTSerT3E/BD/ZoFNGQcp7IHxfK2C30qcnusYMy0qMZgvmlenuhpys5T0MBVWccHFTd
 6msg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuoaAZ+eHy2VBkh6zeqXuoEm0zqSlxgUk00eRmdXXf2IqjdqvGooiXTUcJABv6m4vAtd62LM4=@lists.denx.de
X-Gm-Message-State: AOJu0YyfG0lt8kmj+qk/70YLijV/rVH2ysbJTQIvG8jyltdM8ObJSQ6F
 kt9s08JZnetbxUgz5weCd7LvPo1wNsh14DuNJSUjxvV33tmNJ/IH3JlJi6IHkmo=
X-Gm-Gg: ASbGncut7In7pPKlc1hMOUNFqRsPzrZQ8OWWTJnrZaPpkTftLg0fJi35VoVDL+aSRXD
 x+JnkVjgTd2pxQqkrgA1HjTqYZBstMIzxQQykOZPQvSwPAKQEYe3vDpsiE9UTRkHmx+V4Lt+coG
 2EM+xdSGW/6eLrCYv4pJCSVypTrk/Z9VtmhpTxq5bmWrjk2rd4ihSRWNQcA6BiwItG0R0u6SfsO
 iDXVwY6v6VP7ZFl84DEgi1gXjrATm15YU4Tk7bWUkG6l/shi8ZnaX3XejNivi6KYznnVLNqj9mV
 vVngJ2XQiqbVqkF24Qk26jr+l2r3u6If80q/J6wLXKhUbuiBQi230E6YObuBYcTbMY1AZ45C0/j
 k2Oerk0t1LkxOyg==
X-Google-Smtp-Source: AGHT+IEEm00cd5HxcbvJ+tIQoc6ADLdAnAh67WMmq00w4/LQwnr/Kx+jmgK436BRHpen8x5LleBaaA==
X-Received: by 2002:a05:600c:3483:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-43f3a93c7c7mr26230655e9.9.1744381892582; 
 Fri, 11 Apr 2025 07:31:32 -0700 (PDT)
Received: from localhost.localdomain (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2c53sm84727525e9.14.2025.04.11.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:31:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-for-2025.07
Date: Fri, 11 Apr 2025 16:30:41 +0200
Message-ID: <20250411143052.2630675-1-caleb.connolly@linaro.org>
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

Hi Tom,

There's been a surprising amount of activity lately on the Qualcomm
side with the two oldest boards getting some fresh attention and a lot
of cleanup and polish going on across the board.

* SDM660 gets USB phy fixes and a pinctrl driver
* The recently added SA8775P/QCS9100 SoC gets a pinctrl driver
* The Qualcomm pinctrl driver now handles reserved pins correctly,
  fixing crashes on some boards when running "gpio status -a"
* OF_UPSTREAM_BUILD_VENDOR is enabled in qcom_defconfig
* SDM845 and SC7280 get missing clocks added (since we're now stricter
  about those). This gets USB working more reliably in more cases.
* DM_USB_GADGET is enabled for all boards using DWC3 and fasbtoot is
  enabled too
* A bug in the livetree fixup code is fixed (making USB work on a lot
  more platforms)
* Button label lookup is made case insensitive
* bootretry becomes more dynamic, allowing it to be hijacked to make a
  "persistent" boot menu that allows dropping to U-Boot shell later on
* A new qcom-phone.config fragment is added along with a phone-specific
  default environment and phone-specific debugging/bringup docs. These
  make U-Boot more usable on devices without a serial port or keyboard.
* The db820c gets fixed up and updated documentation
* The db410c also gets some love and modernisation as well as a new
  reviewer.
* A new driver is added for the USB VBUS regulator found on various
  Qualcomm PMICs
* The Qualcomm SPMI driver gets some fixes and cleanup for SPMI v5 and
  v7 support.

CI pipeline: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/25653

---

The following changes since commit 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2:

  CI: Disable evb-ast2600 (2025-04-09 18:34:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-for-2025.07

for you to fetch changes up to f3563fc30356c8079527b90e532407050dff7c7b:

  board: dragonboard410c: Update maintainers (2025-04-11 15:34:12 +0200)

----------------------------------------------------------------
Qualcomm changes for v2025.07

----------------------------------------------------------------
Alexey Minnekhanov (2):
      phy: Add SDM660 support to Qualcomm QUSB2 phy
      drivers: pinctrl: Add Qualcomm SDM630/660 TLMM driver

Caleb Connolly (15):
      qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
      clk/stub: add sdm845 rpmh clock
      clk/qcom: sdm845: add GCC_AGGRE_UFS_PHY_AXI_CLK
      mach-snapdragon: enable DM_USB_GADGET by default
      qcom_defconfig: enable fastboot
      clk/qcom: sc7280: add missing UFS and MMC clocks
      mach-snapdragon: of_fixup: fix condition check in ft_board_setup()
      hmibsc_defconfig: disable DM_USB_GADGET
      board/qualcomm: introduce phone config
      cli_hush: support running bootcmd on boot retry
      bootretry: check for bootretry variable changes
      doc: board/qualcomm: describe phone support and bringup
      button: qcom-pmic: prettify and standardise button labels
      button: make button_get_by_label() case insensitive
      pinctrl: qcom: handle reserved ranges

Jorge Ramirez-Ortiz (5):
      board: qualcomm: dragonboard820c: update readme
      clk/qcom: apq8096: fix set rate for the uart clock
      clk/qcom: apq8096: fix the sdhci clock
      clk: stub: add qcom,glink-smd-rpm
      configs: dragonboard820: updates

Neil Armstrong (6):
      spmi: msm: use real number of channels for v5 & v7
      spmi: msm: factor out channel mapping for v5 & v7
      spmi: msm: introduce SPMI_CHANNEL_VALID flag
      spmi: msm: correctly handle multiple mapping entries
      gpio: msm: fix get_function return for special pins
      gpio: msm: return correct value return for special output pins

Rui Miguel Silva (2):
      mach-snapdragon: of_fixup: fix property length at writing
      power: regulator: add qcom-usb-vbus

Sam Day (1):
      clk/qcom: sdm845: add missing USB3 clocks

Stephan Gerhold (13):
      mach-snapdragon: Fix EL2 boot on DragonBoard 410c
      board: dragonboard410c: Fix RAM size
      board: dragonboard410c: Fix BD address
      board: dragonboard410c: Drop UNSTUFF_BITS() macro
      board: dragonboard410c: Drop reflash functionality
      board: dragonboard410c: Drop unused linux_image
      board: dragonboard410c: Use dynamically allocated load addresses
      board: dragonboard410c: Fix counter frequency
      board: dragonboard410c: Enable RTL8152 ethernet
      board: dragonboard410c: Use BOOTSTD instead of DISTRO_DEFAULTS
      board: dragonboard410c: Enable support for Android boot images
      board: dragonboard410c: Use button_cmd instead of custom code
      board: dragonboard410c: Update maintainers

Sumit Garg (2):
      qcom_defconfig: Disable MMC HS200 mode support
      phy: phy-qcom-qusb2: Fix USB PHY power on sequence

Varadarajan Narayanan (3):
      regulator: qcom-rpmh-regulator: add support for pmm8654 regulators
      pinctrl: qcom: add driver for SA8775P SoC
      qcom_defconfig: enable pinctrl for SA8775P

 arch/arm/Kconfig                                   |   3 +-
 arch/arm/dts/apq8016-sbc-u-boot.dtsi               |   2 +-
 arch/arm/mach-snapdragon/include/mach/gpio.h       |  15 +
 arch/arm/mach-snapdragon/of_fixup.c                |  20 +-
 board/qualcomm/dragonboard410c/MAINTAINERS         |   3 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  67 +--
 board/qualcomm/dragonboard410c/dragonboard410c.env |  38 +-
 board/qualcomm/dragonboard820c/dragonboard820c.c   |   2 +-
 board/qualcomm/dragonboard820c/readme.txt          |  47 +-
 board/qualcomm/qcom-phone.config                   |  29 +
 board/qualcomm/qcom-phone.env                      |  47 ++
 boot/Kconfig                                       |   7 +
 boot/bootretry.c                                   |   2 +
 common/cli_hush.c                                  |   6 +-
 common/cli_hush_upstream.c                         |   6 +-
 configs/dragonboard410c_defconfig                  |  11 +-
 configs/dragonboard820c_defconfig                  |   2 +
 configs/hmibsc_defconfig                           |   1 +
 configs/qcom_defconfig                             |   8 +-
 doc/board/qualcomm/board.rst                       |   5 +
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/phones.rst                      | 144 +++++
 drivers/button/button-qcom-pmic.c                  |   8 +-
 drivers/button/button-uclass.c                     |   2 +-
 drivers/clk/clk-stub.c                             |   3 +-
 drivers/clk/qcom/clock-apq8096.c                   |   5 +-
 drivers/clk/qcom/clock-sc7280.c                    |  11 +
 drivers/clk/qcom/clock-sdm845.c                    |   3 +
 drivers/gpio/msm_gpio.c                            |  53 +-
 drivers/phy/qcom/phy-qcom-qusb2.c                  |  44 +-
 drivers/pinctrl/qcom/Kconfig                       |  15 +-
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-qcom.c                |  67 +++
 drivers/pinctrl/qcom/pinctrl-sa8775p.c             | 623 +++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sdm660.c              | 226 ++++++++
 drivers/power/regulator/Kconfig                    |   7 +
 drivers/power/regulator/Makefile                   |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c      |  45 ++
 drivers/power/regulator/qcom_usb_vbus_regulator.c  | 111 ++++
 drivers/spmi/spmi-msm.c                            |  59 +-
 include/configs/dragonboard410c.h                  |  11 -
 41 files changed, 1598 insertions(+), 164 deletions(-)
 create mode 100644 board/qualcomm/qcom-phone.config
 create mode 100644 board/qualcomm/qcom-phone.env
 create mode 100644 doc/board/qualcomm/phones.rst
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sa8775p.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm660.c
 create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c
