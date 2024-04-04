Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A198C67861
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 21:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2C1882A3;
	Thu,  4 Apr 2024 23:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kGehxb0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE6087DCA; Thu,  4 Apr 2024 23:54:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2980F882B6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 23:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso209703166b.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712267668; x=1712872468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxmJkGKh2t5bnk3OrDqRYpAJhA8sqM/1wqs3K5yuQlI=;
 b=kGehxb0JvlGKrPJ6tMNMtc1eIp3MGgNyeF8Q84jqZFSQJRk19BABcVHlWpV1EOzbI4
 zftKZHVA6wd4E+18We8QiJs1TtN8pufseHzsZc2Hj1E7wNBb8BJKWkoGCyP23iIOZvsD
 ZCxmgoUM6FwRAI9K86e784Ce7cqxYN/LBD3Wa2ar7nYSMsSKRyv9W1K5N5UlXMOK+EzO
 sZjsRh90YMMAxqYQ9wxZU785d7Vq+I4n0deXqERzmKsR6L5GtLCoI++Zn0mpzYPfrFXh
 zTO2jW1eOnxNq3ZGbR6F6nyWD6Zx5zCG2A6TOOGiJ8l37SAZAJD7A2QZbunj//dWDY/w
 Nw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712267668; x=1712872468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxmJkGKh2t5bnk3OrDqRYpAJhA8sqM/1wqs3K5yuQlI=;
 b=LEag5PzoALywdMtFhqJDnGHAo/XiPNoks3XD9ceOQ9HgNNoDQs6+KasBAgJyPta3TU
 7+aff6zgaEa3AeX3NZ8+53S1PxIs4GSPk6k6F7Ag2b5bI4WKGQyaCeZMrYSoL/CGSep4
 fuMxUSnF431vJDQFRJ+QXYXGASA19rWphaHEN/wC/4KJakKeszYqiI2rgTZBR1fAP+uw
 I/D4XT8ist0dB/cS2vx6gS/kX6Ku5Lr8qfk/ro5TDBDgRk69vA6/TFiA8MsMdLoWLTi/
 6sbsrIdgXFNhfC7HCnEFCNUYwYe2Vdcau6iI67hXc10WGzbMyiFKD0q0oyIEB4HrqUSv
 BZ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVIPY5jWlnwBLJLu+PEZd47LSu+fxXs5VXy/SJLC8g9ILk0ySOoF9YMtXjpZ8eXwBu0Rgmi/u9q+mjicPl5PALSGbapA==
X-Gm-Message-State: AOJu0YzKv+mD+6BwV4P8mcC+0n4Rt/V/JMctRGUkblpA2w5u0sYtMEd6
 7//2DELJRXjvDYQSf63jd6cgzRUdi0VpVSL5Qttj+fQkPWvSSTm/a4242NXO8pk=
X-Google-Smtp-Source: AGHT+IFDCf+lPMcUpOv79kqq1zRmlVD9FSnYOFIZ6zmqYNNgYRJtaayP/yN2foeyFkdXrj876rPQMw==
X-Received: by 2002:a17:906:1397:b0:a4e:37ac:79c8 with SMTP id
 f23-20020a170906139700b00a4e37ac79c8mr481334ejc.5.1712267668392; 
 Thu, 04 Apr 2024 14:54:28 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a170906488700b00a471481ef3csm53756ejq.124.2024.04.04.14.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 14:54:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-2024Apr04 (attempt 2)
Date: Thu,  4 Apr 2024 23:52:57 +0200
Message-ID: <20240404215421.2151698-1-caleb.connolly@linaro.org>
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

Hi Tom,

Sorry for the noise, totally fluffed that PR... Please ignore the previous
email.

Some new Qualcomm features for you:

* Ethernet, i2c, and USB support are now enabled by default
* The clock driver gets some bug fixes and cleanup
* Invalid FDTs are now properly detected in board_fdt_blob_setup().
* The pinctrl driver gains preparatory support for per-pin function muxes.
* Support is added for two generations of Qualcomm HighSpeed USB PHY
* A power domain driver is added for the Globall Distributed Switch Controllers
  on the GCC hardware block.
* SDM845 gains USB host mode support.
* OF_LIVE is enabled by default for Qualcomm platforms
* Some U-Boot devicetree compatibility fixups are added during init to improve
  compatbility with upstream DT.

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

  Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 -0400)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-2024Apr04

for you to fetch changes up to b2511143fba4c0631446c968fb4c0d962b01d850:

  qcom_defconfig: enable USB (2024-04-04 17:46:48 +0200)

----------------------------------------------------------------
Bhupesh Sharma (2):
      phy: qcom: add Qualcomm QUSB2 USB PHY driver
      phy: qcom: Add SNPS femto v2 USB HS phy

Caleb Connolly (13):
      mailmap: update Bhupesh's email address
      mach-snapdragon: disable power-domains for pre-reloc drivers
      clk/qcom: use offsets for RCG registers
      clk/qcom: sdm845: add gdscs
      clk/qcom: sdm845: add USB clocks
      gpio: msm_gpio: add .set_flags op
      serial: msm-geni: support livetree
      mach-snapdragon: fixup USB nodes
      mach-snapdragon: fixup power-domains
      mach-snapdragon: call regulators_enable_boot_on()
      dts: sdm845-db845c: add u-boot fixups
      qcom_defconfig: enable livetree
      qcom_defconfig: enable USB

Sumit Garg (1):
      qcom_defconfig: Enable ethernet and I2C support

Volodymyr Babchuk (4):
      qcom: board: validate fdt before trying to use it
      clk: qcom: clear div mask before assigning a new divider
      clk: qcom: add support for power domains uclass
      pinctrl: qcom: pass pin number to get_function_mux callback

 .mailmap                                  |   1 +
 arch/arm/Kconfig                          |   1 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi    |   9 +
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |  10 +-
 arch/arm/mach-snapdragon/of_fixup.c       | 155 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |  20 ++
 configs/qcom_defconfig                    |  31 ++-
 drivers/clk/qcom/Kconfig                  |   2 +-
 drivers/clk/qcom/clock-apq8016.c          |  39 +--
 drivers/clk/qcom/clock-apq8096.c          |  28 +-
 drivers/clk/qcom/clock-qcom.c             | 159 +++++++++--
 drivers/clk/qcom/clock-qcom.h             |  22 +-
 drivers/clk/qcom/clock-qcs404.c           | 122 ++-------
 drivers/clk/qcom/clock-sdm845.c           |  61 +++--
 drivers/gpio/msm_gpio.c                   |  27 +-
 drivers/phy/qcom/Kconfig                  |  15 ++
 drivers/phy/qcom/Makefile                 |   2 +
 drivers/phy/qcom/phy-qcom-qusb2.c         | 429 ++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 216 +++++++++++++++
 drivers/pinctrl/qcom/pinctrl-apq8016.c    |   3 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c    |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c    |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c       |   4 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h       |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c     |   3 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c     |   3 +-
 drivers/serial/serial_msm_geni.c          |  15 +-
 28 files changed, 1150 insertions(+), 237 deletions(-)
 create mode 100644 arch/arm/dts/sdm845-db845c-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/of_fixup.c
 create mode 100644 arch/arm/mach-snapdragon/qcom-priv.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qusb2.c
 create mode 100644 drivers/phy/qcom/phy-qcom-snps-femto-v2.c
