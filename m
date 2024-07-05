Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A887C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 11:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A7588605;
	Fri,  5 Jul 2024 13:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dj+GjUYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF9888885; Fri,  5 Jul 2024 13:24:40 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909FA8851B
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 13:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77c9d3e593so73670466b.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720178678; x=1720783478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hKsU7c5DIzDqvnv2IGy3NQ/e0gPeLHd5yJDEFMUhrRY=;
 b=dj+GjUYzPv6GMfkshnBZ6NXy0nPFIeDVMKD0uTBFmJfW27tiLCSMaTwdNWDRGe/IMB
 Xiz7EaBTZd+KU3XN/zIE4VJEdahogzmwFNagKW7m9Hz12oIXf3WmBJHPj/ab4PcnLcV/
 SpHLgSwvPYdH3seyffIUWziR2d9LAIvjDSS/Ki12vyrphbiPBo4uFQmGZf6B8aNy9UwE
 lXN7T4r2f4rEQignz41KryrZgvs7IBeuB65jmJNKFYY2CxcLGLJX5cbf7ONHkrVXSeHP
 U9yJp4M+6JyBrbwFWzNqAw1xU8/wtPOry5FscYWv9eA0vaiN6dxNBKm91K7Vly44qtQi
 Qppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720178678; x=1720783478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKsU7c5DIzDqvnv2IGy3NQ/e0gPeLHd5yJDEFMUhrRY=;
 b=uU2MP9It1+Tf5u7Mvbk4ce2zr3FuzOWzrvaafc9n4qdyvbFshUJGj23z4Yt3jGPDcB
 FpbVfHPaauDf5CjIc7oBEguCvzApfFp4gvSdAOqmG8FiUj6kTbw8XuDZb7MvaS+7xPd7
 dbZCvivvmP/GFAE/ih1bYKeUmtgiU2I5QVW7yzDmOHSK8WOsTmK9kWLmH1rQdBldF3yo
 Llrt+OH2medrtQBWkSnPf06+Fl1XupC1y6xjkN2bdDF1unjaGZQSErYyCinsluCNOwY8
 x1otO9OOHmpGaLyUHUbmNMpni/Zs18jHzpMjDy/EV8mK4f4MbiWSJaNkdPpi3hRA3RJ8
 XTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAxdlYgtlqQ3W13gQHSjluljvOmpsZixsw24kBmZ0Lvi8NDL9I3Ute0d7AIGdoSFGH7RbUutFJkzfgeyexZbMZYYcX3A==
X-Gm-Message-State: AOJu0YwO5OYh7USs0+tfJ1Xu0wd3xogp7jUyo619tApbiiGVcuTakVDY
 lQA2l6Q3sZBPwZzfVwkJaKHb1aXc14I9lxQq0uGqWRs85vgfaLVTYdHRK/XQXDI=
X-Google-Smtp-Source: AGHT+IGVbKnDTlM8K/xPUuevyc9mcEaZmk9DBIbq6UhnvkkWiFoz+SqLxJBl91poV5ijmUALljuQgg==
X-Received: by 2002:a17:906:19c8:b0:a6f:b428:30fa with SMTP id
 a640c23a62f3a-a77ba71197cmr277393666b.59.1720178677955; 
 Fri, 05 Jul 2024 04:24:37 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b348bsm674796966b.190.2024.07.05.04.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 04:24:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Early Qualcomm changes for v2024.10
Date: Fri,  5 Jul 2024 13:22:46 +0200
Message-ID: <20240705112414.655154-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Various minor fixes and improvements:

* Fix Qualcomm SPMI v5 support
* Move default environment to a file
* Add support for special pins (e.g ufs/mmc reset/data pins)
* IPQ moves to OF_UPSTREAM and receives some cleanup and MAINTAINERS changes
* Add a reset driver for devices without PSCI
* msm8916 USB clock improvements for mobile devices

The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea9e:

  Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11:08 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to 69b37f1625ac0c9d0c867d591564af91c0b52d18:

  spmi: msm: correct max_channels for v5 controllers (2024-07-05 12:07:37 +0200)

----------------------------------------------------------------
Caleb Connolly (4):
      qcom_defconfig: enable msm8916 and msm8996
      spmi: msm: demote to debug()
      mach-snapdragon: move default environment to a file
      spmi: msm: correct max_channels for v5 controllers

Neil Armstrong (5):
      pinctrl: qcom: add support for bias-pull-down
      arm: mach-snapdragon: gpio: introduce msm_special_pin_data
      pinctrl: qcom: add support setting pin configuration for special pins
      pinctrl: qcom: sm8550: add special pins pins configuration data
      pinctrl: qcom: sm8650: add special pins pins configuration data

Robert Marko (9):
      sysreset: add Qualcomm PSHOLD reset driver
      mach-ipq40xx: add CPU specific code
      mach-ipq40xx: use OF_UPSTREAM
      arm: dts: drop downstream IPQ4019 DTSI
      MAINTAINERS: IPQ40XX: remove Luka Kovacic as maintainer
      MAINTAINERS: IPQ40XX: update GCC dt-bindings
      MAINTAINERS: IPQ40XX: add clock-ipq4019 instead of reset driver
      MAINTAINERS: IPQ40XX: add pinctrl driver
      clock: qcom: ipq4019: add I2C clocks

Sam Day (2):
      clk/qcom: apq8016: add support for USB_HS clocks
      ehci: msm: bring up iface + core clocks

 MAINTAINERS                                  |   7 +-
 arch/arm/Kconfig                             |   1 +
 arch/arm/dts/qcom-ipq4019.dtsi               | 202 ---------------------------
 arch/arm/mach-ipq40xx/Makefile               |   7 +
 arch/arm/mach-ipq40xx/cpu.c                  |  43 ++++++
 arch/arm/mach-snapdragon/include/mach/gpio.h |  16 ++-
 board/qualcomm/default.env                   |  11 ++
 configs/qcom_defconfig                       |   6 +
 drivers/clk/qcom/clock-apq8016.c             |  32 +++++
 drivers/clk/qcom/clock-ipq4019.c             |  21 +++
 drivers/pinctrl/qcom/pinctrl-qcom.c          |  38 ++++-
 drivers/pinctrl/qcom/pinctrl-sm8550.c        |  42 ++++--
 drivers/pinctrl/qcom/pinctrl-sm8650.c        |  42 ++++--
 drivers/spmi/spmi-msm.c                      |   6 +-
 drivers/sysreset/Kconfig                     |   6 +
 drivers/sysreset/Makefile                    |   1 +
 drivers/sysreset/sysreset_qcom-pshold.c      |  55 ++++++++
 drivers/usb/host/ehci-msm.c                  |  37 ++++-
 include/configs/qcom.h                       |   7 -
 19 files changed, 343 insertions(+), 237 deletions(-)
 delete mode 100644 arch/arm/dts/qcom-ipq4019.dtsi
 create mode 100644 arch/arm/mach-ipq40xx/Makefile
 create mode 100644 arch/arm/mach-ipq40xx/cpu.c
 create mode 100644 board/qualcomm/default.env
 create mode 100644 drivers/sysreset/sysreset_qcom-pshold.c
