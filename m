Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B524EFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2813083BC4;
	Mon, 27 Apr 2026 13:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PxbedlpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2ED583C14; Mon, 27 Apr 2026 13:47:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AAD183AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso93668095e9.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777290454; x=1777895254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2UhAU63Hk2lm5ghSWUJOVxV/nZMGSicb8LEK6MTupx8=;
 b=PxbedlpKPnoAdUOA5zpsomE8bjPCWI+b+oU/JMK2+tLd8LF/EkUUTeq4iDaTpIqlUX
 hnplwuJ3+DCcmjnW91yG1HbsfZwmo2WT7NYyKYnJcvHRQhYpqFXUo5B9h/xDCK0j4Uwk
 OuCs93SdsB37FPFJD6DCDeXK1y1Q9T1sqCghD4Op3Es+65OWmpNO/kgXQC/Pjuoh+Qe5
 TDmUk1HnvnjhnuSDwrY6jIz6jQEcGpnXKwm41mc1A7x60OEHxBAX3qbLy53jlVjRCnuy
 0xhgp0ZcqYQn+1wXC0x497fQx/jU9qfbi+YoccW0g4GdKcxMo/F34GqFtxME3CXKE94l
 0/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777290454; x=1777895254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UhAU63Hk2lm5ghSWUJOVxV/nZMGSicb8LEK6MTupx8=;
 b=W+C+jEZy3RTmqu/GEuyEN2k6szI/LY5zqLfhOl3BmfVEYpZaVdJyOozK1Ao2Wy8u8L
 gq5PtTpMu+66Fkt0RBLsVYhAqjE7JdHd4CD19kdwab9bfAuRSSaaYvfLT6wNxAGF8krt
 Lt8aclUJ6wvd2e2uUEXTPFpdtNcfPglinT2v+gVjLOau8Jdiz5NqvhOBV4lf5GuAJ3YW
 SNz07RzoAZT4AASYKZ6+sMpi+I7iCdAcqN3rgVOkueTJImiHSjTp0HdBX2Ojm3SSvZmi
 B9X0XxT4v6kES8TtteF1VjNCqB0xQ/coKaYKmowyENqZXfy6BvEVT2FA/rst0O2R2Qia
 zyYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4d2UUkCkQs2vmKt9kyXl+CKte83j1mdfh+CqY6LBi7UcD9UyLe0RwZf+mQUD1D6Jzd1wgV5c=@lists.denx.de
X-Gm-Message-State: AOJu0YwIeeQu/8rFC45Clqznrn3dGFCC2fTjsQysx6oPOx/10ma6Gi4l
 pqZ/cbQoUxsijflimZ/FL8F7+9dppTRDehVHVIiFR67Xlq3FXVuIYL67X/D7DSpkD4I=
X-Gm-Gg: AeBDietnWnEaQoB9LMdUSmWjimhV/wAqpK+v8aov41Lp1fRjJrVOWT2cuF5Mb3dGB8w
 NWO/e3NXFRRqNIcCIemI1LuIcTuuUGM68p/tHA8mnv2G8N9BsxrSFVlNiURHuG53vt5oImAWHp2
 08VdCmZqhXoH65SCcVOxgDKlBUSqEaLv0XJ8gn2wFbhBChGS8yBS0Wpg8x46cJNGcXrE8KFxn3I
 3rNrdCTNXhefbbP4+gOeXHWGI/U8cMAFcmccP8vFBXt/9pVtwk1XoksNJz++7rtgBhrr3EVSGo+
 DoNLmhAH8XoriS5cCr0Umh9sCS7FuKGvH+oOlI+uWPg36Piy42QQv3YcK4Ga9JujsdptnBfIRoP
 fp5INekz32P7Pl9KdQJXNXozRB7mWYQIFsHg3znlGKDkU3EyWm8Bg09PEsirbXSyl7uo0xGfZ5w
 3K/hgshXCmb/uLdMJlgJkM0/GA4MptZfqvYNQB6NFGedESXXBmV3i/hiNwPz0a3m3xlnGZa3mb5
 bzhNLOWL76c5uw=
X-Received: by 2002:a05:600c:a106:b0:48a:58ae:9933 with SMTP id
 5b1f17b1804b1-48a58ae9fbdmr248660765e9.18.1777290453502; 
 Mon, 27 Apr 2026 04:47:33 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm392085445e9.5.2026.04.27.04.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 04:47:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Ajit Singh <blfizzyy@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull casey/qcom-main-13Apr2026
Date: Mon, 27 Apr 2026 13:46:26 +0200
Message-ID: <20260427114730.558468-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Resend of 20260419030602.2470577-1-casey.connolly@linaro.org with the CI issue fixed.

Various Qualcomm additions this cycle:
* USB superspeed support for 1 platform
* Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
* Improved support for booting with OP-TEE on supported platforms
* Initial basic power domain support

Notably there is a generic change to the device core, missing power
domains will no longer cause a device to fail probe and instead will
just print a warning. This shouldn't affect any existing platforms.

Kind regards,

The following changes since commit 9f61fd5b80a43ae20ba115e3a2933d47d720ab82:

  Makefile: fix host CPP pollution in cmd_gen_envp (2026-04-24 12:49:27 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git casey/qcom-main-13Apr2026

for you to fetch changes up to fabf5878bb86b3e1e2b19301afc2a9180bf79cf6:

  qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig (2026-04-27 12:38:45 +0200)

----------------------------------------------------------------
Ajit Singh (1):
      clk: qcom: sc7280: add missing SDCC1 clocks

Antony Kurniawan Soemardi (1):
      mach-snapdragon: allocate memory for DT overlays

Aswin Murugan (6):
      pinctrl: qcom: Add pingroup definitions for SC7280
      power-domain: Add warning when power-domain driver is missing
      mach-snapdragon: Remove RPMH power domain DT fixup code
      qcom_defconfig: Add QCOM_RPMH_POWER_DOMAIN config
      efi_loader: make EFI_HAVE_RUNTIME_RESET a user-selectable option
      qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig

Balaji Selvanathan (8):
      power-domain: Add QCOM RPMH Power Domain Driver Support
      drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
      drivers: usb: dwc3: Add delay after core soft reset
      drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
      arch: arm: mach-snapdragon: Auto-detect USB SSPHY driver support
      configs: qcm6490: Enable super-speed USB support
      MAINTAINERS: Add entry for Qualcomm PHY drivers
      dts: qcs6490-rb3gen2: Remove USB controller dr_mode override

Luca Weiss (7):
      drivers: pinctrl: Add Qualcomm Milos TLMM driver
      clk/qcom: Add Milos clock driver
      phy: qcom: Add Milos to QMP UFS PHY driver
      regulator: qcom-rpmh-regulator: add support for PM7550 regulators
      gpio: qcom: Support GPIOs on PM7550 PMIC
      qcom_defconfig: Enable Milos clock driver
      board/qualcomm: add debug config fragment for Milos

Sumit Garg (3):
      tee: optee: Export OP-TEE message UID check API
      mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
      board/qualcomm: Introduce TF-A and OP-TEE config fragment

Varadarajan Narayanan (5):
      arm: psci: Add API to check for support of specific PSCI function
      drivers: sysreset: Add sysreset op that can take arguments
      sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
      cmd: boot: Add '-edl' option to reset command documentation
      qcom_defconfig: enable psci based sysreset

 MAINTAINERS                                   |   1 +
 arch/arm/cpu/armv8/fwcall.c                   |  15 +
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi      |   4 -
 arch/arm/include/asm/system.h                 |   1 +
 arch/arm/mach-snapdragon/board.c              |   5 +
 arch/arm/mach-snapdragon/of_fixup.c           | 176 +++++--
 board/qualcomm/debug-milos.config             |   5 +
 board/qualcomm/tfa-optee.config               |   4 +
 cmd/boot.c                                    |   3 +
 configs/qcm6490_defconfig                     |   1 +
 configs/qcom_defconfig                        |   5 +
 doc/usage/cmd/reset.rst                       |   2 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-milos.c                | 196 ++++++++
 drivers/clk/qcom/clock-sc7280.c               |   3 +
 drivers/firmware/psci.c                       |   4 +
 drivers/gpio/qcom_spmi_gpio.c                 |   1 +
 drivers/phy/qcom/Kconfig                      |   8 +
 drivers/phy/qcom/Makefile                     |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c         | 643 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h        |  62 +++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h     |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |  34 ++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |  88 ++++
 drivers/phy/qcom/phy-qcom-qmp.h               |  17 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c          | 103 +++++
 drivers/pinctrl/qcom/pinctrl-sc7280.c         | 522 ++++++++++++++++++++-
 drivers/power/domain/Kconfig                  |   8 +
 drivers/power/domain/Makefile                 |   1 +
 drivers/power/domain/power-domain-uclass.c    |   7 +
 drivers/power/domain/qcom-rpmhpd.c            | 278 +++++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  33 ++
 drivers/sysreset/Kconfig                      |  15 +
 drivers/sysreset/Makefile                     |   1 +
 drivers/sysreset/sysreset-uclass.c            |  37 ++
 drivers/sysreset/sysreset_qcom-psci.c         |  45 ++
 drivers/tee/optee/core.c                      |   5 +
 drivers/usb/dwc3/core.c                       |   2 +
 include/sysreset.h                            |  18 +
 include/tee/optee.h                           |   9 +
 lib/efi_loader/Kconfig                        |   3 +-
 44 files changed, 2351 insertions(+), 51 deletions(-)
 create mode 100644 board/qualcomm/debug-milos.config
 create mode 100644 board/qualcomm/tfa-optee.config
 create mode 100644 drivers/clk/qcom/clock-milos.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-milos.c
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
