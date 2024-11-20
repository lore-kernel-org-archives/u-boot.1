Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2412D711CF
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 17:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C32189229;
	Wed, 20 Nov 2024 18:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pM2Bs5cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD9E8933E; Wed, 20 Nov 2024 18:32:17 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A3A88F3C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 18:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so36761fa.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732123934; x=1732728734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dt5FpCQw1H2jOCTD298z+CqFvazNKRTgkfn5IbIBLck=;
 b=pM2Bs5cbOn09F76uR2inXz86gySro6cBNYfl1RsDYO7gxr6vWaea5LLj82+SVm/w5d
 zZ+LcMFXbpKZgQs4W6ss7FN6Adk9E68xRQtJ2aIURMIECz/5hR2zGfmIlU8wbqExhWyc
 6zLQFrhdAAQRevsV0xFtXXTB1+gOG5GsmON3oWQWt3aKOq2s09UGRCD8Of85hIaKMVSr
 OUp7VcYI8+F44Kk+Db0+JFf0rAJiQFrO9a9tnQ/tfAK8wHh4LuSgr1gf/+qNqmPfaF9X
 sG8454FeEeNGn+gK3ji6KSKjjy4gX7sjMIHjLr3ca9V5r15LChtJDI0N7LJG9yLlwtxW
 1NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732123934; x=1732728734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dt5FpCQw1H2jOCTD298z+CqFvazNKRTgkfn5IbIBLck=;
 b=uK/jqk97tXlBABAhczINmK23oji+Q2X6v4rvszgolydR/awTrtO2y7LB6q6aZh63hf
 s/qKxXGEl7FonIOEiQvB+y5x+ikHLRIwnup56JGadLfzCADufCRJZ1jC7CpL8zyxmDO1
 EViPv5UPDCz7+/BvSTrQ9PwNjHUDOphSQ8OLg1s6q1jiTBa92UBxA+DwOeuSWDravq3e
 ideXVSpj3uSd8oWWV+RnLlh6APyVIlXmNZcA29db5MfkZhPIG3xak4jcpBUX/DWopyaP
 ottfuNdEEJlTJ9bwTcE9bV87uPaaM2MLOP6KsBzQ2tiP/W83sqJJNu/eJZ1NuKrRYECh
 3C9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUvMCRn4XLL1mwBmDmmLt+4GSRU59rZLa3TJjEqukCQzoxUY0BCwj1Nq6H6sKHelMYXGBDCtU=@lists.denx.de
X-Gm-Message-State: AOJu0YxMY8+gYk668S0VvqVX4/zjWVzROY/LS9guZ1g9DnxXZn19WUkD
 MwVgptLw8fxMo5oubsvRPtSzlV51b4gFC2qQ6nrmwAzkPjdVtYBxt3JFWVpZx6w=
X-Google-Smtp-Source: AGHT+IEGX5c8gDDGk+86UeaX8mXwhK5tDsnRnYdpY5dwiQRBa/F+XUeCxiux44yBelrRifNwnklm8g==
X-Received: by 2002:a2e:be07:0:b0:2fb:6057:e695 with SMTP id
 38308e7fff4ca-2ff8dc4ba22mr22359531fa.18.1732123934082; 
 Wed, 20 Nov 2024 09:32:14 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cff453f4dfsm1006802a12.62.2024.11.20.09.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 09:32:13 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Julius Lehmann <lehmanju@devpi.de>,
 u-boot@lists.denx.de, u-boot-qcom@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-main
Date: Wed, 20 Nov 2024 18:16:50 +0100
Message-ID: <20241120173127.977520-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Some nice new features this cycle and a few cleanups for rc3.

* UFS support is enabled for SC7280 and SM8150 platforms.
* Qualcomm dt-bindings headers are all dropped in favour of dts/upstream.
* The SMMU driver now correctly handles stream ID 0 and is disabled in EL2.
* Initial support for capsule updates (using the new dynamic UUIDs) is added
  for the RB3 Gen 2 board alongside a new SCSI backend for DFU.
* CONFIG_PINCONF is enabled in qcom_defconfig.
* The vqmmc supply is now enabled for sdcard support on boards that need it.
* A quirk is added for reading GPIOs on the PM8550 PMIC

CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/23474

Previous CI run prior to rebase: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/23364

The following changes since commit 8573ea4105829b9a915b23f56d1577b3f09ed918:

  Merge patch series "labgrid: Provide an integration with Labgrid" (2024-11-13 16:39:19 -0600)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD

for you to fetch changes up to 7aad7833323aa9260935d172744a50f56356d52a:

  treewide: remove Qualcomm dt-binding headers that are available upstream (2024-11-20 17:57:58 +0100)

----------------------------------------------------------------
Caleb Connolly (9):
      mach-snapdragon: configure logging
      phy: qcom: ufs: add sc7280
      dfu: add scsi backend
      disk: expose partition type flags
      mach-snapdragon: implement capsule update support
      qcom_defconfig: enable capsule update support
      iommu: qcom-smmu: allow SID 0
      iommu: qcom-smmu: handle running in el2
      treewide: remove Qualcomm dt-binding headers that are available upstream

Julius Lehmann (1):
      phy: qcom: Add SM8150 to QMP UFS PHY driver

Neil Armstrong (7):
      qcom_defconfig: enable PINCONF
      ARM: mach-snapdragon: configure a larger default SYS_MALLOC_LEN for fastboot
      mmc: msm_sdhci: enable vqmmc at probe if available
      gpio: qcom_pmic: add again the quirk to skip GPIO configuration on PM8550
      phy: qcom: ufs: drop unused ufsphy_v2_regs_layout
      dt-bindings: remove phy/phy-qcom-qmp.h in favor of dts/upstream
      qcom_defconfig: enable UFS Qualcomm controller and PHY drivers

 arch/arm/mach-snapdragon/Kconfig                   |   6 +
 arch/arm/mach-snapdragon/Makefile                  |   1 +
 arch/arm/mach-snapdragon/board.c                   |   8 +-
 arch/arm/mach-snapdragon/capsule_update.c          | 153 ++++++++
 arch/arm/mach-snapdragon/qcom-priv.h               |   6 +
 configs/qcm6490_defconfig                          |   6 +
 configs/qcom_defconfig                             |   9 +
 disk/part_efi.c                                    |   1 +
 doc/usage/dfu.rst                                  |  33 ++
 drivers/dfu/Kconfig                                |   7 +
 drivers/dfu/Makefile                               |   1 +
 drivers/dfu/dfu.c                                  |   5 +-
 drivers/dfu/dfu_scsi.c                             | 435 +++++++++++++++++++++
 drivers/gpio/qcom_pmic_gpio.c                      |  21 +-
 drivers/iommu/qcom-hyp-smmu.c                      |   9 +-
 drivers/mmc/msm_sdhci.c                            |  12 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                | 210 +++++++++-
 include/configs/qcom.h                             |   5 +
 include/dfu.h                                      |  27 ++
 include/dt-bindings/clock/qcom,camcc-sdm845.h      | 116 ------
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  56 ---
 include/dt-bindings/clock/qcom,gcc-msm8916.h       | 179 ---------
 include/dt-bindings/clock/qcom,gcc-msm8996.h       | 361 -----------------
 include/dt-bindings/clock/qcom,gcc-qcs404.h        | 180 ---------
 include/dt-bindings/clock/qcom,gcc-sdm845.h        | 246 ------------
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |  24 --
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  15 -
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      | 295 --------------
 include/dt-bindings/clock/qcom,rpmcc.h             | 174 ---------
 include/dt-bindings/clock/qcom,rpmh.h              |  36 --
 include/dt-bindings/clock/qcom,turingcc-qcs404.h   |  15 -
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |  35 --
 include/dt-bindings/dma/qcom-gpi.h                 |  11 -
 include/dt-bindings/firmware/qcom,scm.h            |  39 --
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 300 --------------
 include/dt-bindings/interconnect/qcom,msm8916.h    | 100 -----
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |  12 -
 include/dt-bindings/interconnect/qcom,msm8996.h    | 163 --------
 include/dt-bindings/interconnect/qcom,osm-l3.h     |  15 -
 include/dt-bindings/interconnect/qcom,sdm845.h     | 150 -------
 include/dt-bindings/phy/phy-qcom-qmp.h             |  20 -
 include/dt-bindings/phy/phy-qcom-qusb2.h           |  37 --
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       | 164 --------
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h        | 106 -----
 include/dt-bindings/power/qcom-rpmpd.h             | 412 -------------------
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 --
 include/dt-bindings/reset/qcom,gcc-msm8916.h       | 100 -----
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |  17 -
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |  22 --
 include/dt-bindings/soc/qcom,apr.h                 |  28 --
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 -
 include/dt-bindings/sound/qcom,lpass.h             |  46 ---
 include/dt-bindings/sound/qcom,q6afe.h             |   9 -
 include/dt-bindings/sound/qcom,q6asm.h             |  26 --
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 234 -----------
 include/dt-bindings/sound/qcom,wcd9335.h           |  15 -
 include/part.h                                     |   1 +
 57 files changed, 945 insertions(+), 3819 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/capsule_update.c
 create mode 100644 drivers/dfu/dfu_scsi.c
 delete mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h
 delete mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-msm8916.h
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-msm8996.h
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-qcs404.h
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h
 delete mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h
 delete mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
 delete mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8996.h
 delete mode 100644 include/dt-bindings/clock/qcom,rpmcc.h
 delete mode 100644 include/dt-bindings/clock/qcom,rpmh.h
 delete mode 100644 include/dt-bindings/clock/qcom,turingcc-qcs404.h
 delete mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h
 delete mode 100644 include/dt-bindings/dma/qcom-gpi.h
 delete mode 100644 include/dt-bindings/firmware/qcom,scm.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
 delete mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
 delete mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 delete mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
 delete mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
 delete mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
 delete mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h
 delete mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
 delete mode 100644 include/dt-bindings/pinctrl/qcom,pmic-gpio.h
 delete mode 100644 include/dt-bindings/pinctrl/qcom,pmic-mpp.h
 delete mode 100644 include/dt-bindings/power/qcom-rpmpd.h
 delete mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h
 delete mode 100644 include/dt-bindings/reset/qcom,gcc-msm8916.h
 delete mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
 delete mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
 delete mode 100644 include/dt-bindings/soc/qcom,apr.h
 delete mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 delete mode 100644 include/dt-bindings/sound/qcom,lpass.h
 delete mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 delete mode 100644 include/dt-bindings/sound/qcom,q6asm.h
 delete mode 100644 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
 delete mode 100644 include/dt-bindings/sound/qcom,wcd9335.h
