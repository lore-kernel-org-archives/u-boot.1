Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D7F99C95
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B7E83B99;
	Sun, 19 Apr 2026 05:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VRWDJwJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B883A83BC8; Sun, 19 Apr 2026 05:06:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83CE839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso24733075e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776567976; x=1777172776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cy1e7Af/Lob58Ex9M8m/N6gOZ50YnYsk/W0/q+0FcFI=;
 b=VRWDJwJzCCajRZSskA3c4HJRcUY/VWNS4qZ++jFOiUEEsi8T+urKw8ZEhsBXOAQj4G
 bEZhf4gqaffR9Dcym+YBxCssdz7r6OudIoFCZB+PR60tbld/Qna7KnaXJ7hmVNR4d83V
 K9RTd/3idXOnNeMTQ6DbydYeSj48S7I7SG3UJnj6qVGQFJkTTZOMxpLixUtyJWGFDY8r
 NIje5kKuJsNPDWtuWHQkU0t899kF9Q4V0idqd8lSXJDVrY6yxkaPwgRAVgcguYlnF1Ns
 jCldzVDDdTOH0dsPL7PNnuzeYRSI7OgrS1k8vCoQ4peT/Mgg/amxdP2PYwf3zWTHQJ4s
 0MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776567976; x=1777172776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cy1e7Af/Lob58Ex9M8m/N6gOZ50YnYsk/W0/q+0FcFI=;
 b=d2aSRXdkQobO5voNDSma9PTENvojlc19JdH2vVUKplu49NKK3ux2bj5duD115+MgUY
 Du4mra2n2ChWV3AmMRzQjLlPoHpvvdRfPy6ae0CgYDRksou7lZ+oUUCKBNtTdej86feC
 d1kDtv3shZT/UM9yf1Ul0GMYijml88uXhvTHAK/5Pbj1/aJBOfz7hsSYXyFEOPoC3jAq
 K2daOYr71JpfNLe5NK0pn3Csyjp+Xrr1SIAhc3TT/q92i6Xycjqv0LZDIAKCNukDLDOk
 CHWQsmZ5NQEQOoC3pRUMwDzx99i0BJlPfSby8DHym44S+Fl0tK18OJOnnG490bAdQh3+
 rTCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JfmOL5x6G4qIkf2984V0IuszaoR11mie8y3D+R11ZDjMJsOD48eAVtAo67p43DnVRNXIL1NE=@lists.denx.de
X-Gm-Message-State: AOJu0YygLnUIhf3GM1zlgwHj0IbAgVDUCByepsel42Wo/CFePPcNdyIO
 r0GMkgP8QW6jcXg5Eim6pqnhUfvhHkUSl1qF7aFS6KpgoU15q6QtrdJiVxEngkOUpAU=
X-Gm-Gg: AeBDievAut6CZUThknUvXQYHMZQowmFus0UbwSx0w9bVYsktGMazRcWwkCM5gfOhyQH
 zH0cbXe7PVGGB0LkCoxdqyGj2mhhWPPRE3LzHpK+ZwHX3tHbWVuZuPGg06c+HGxSuQOAehQUoMV
 DHirDYuxDm1il0Vr3mwZ1O3l782IpchqWQ765o5pkuMVK2Ag3jCq87pwenLL62GZdgHBLhQ8NRx
 TsPfQYi08hdbVqOgBn/FjUCYmL2q35bmeHUgaKx0Jt0RLp4HW5c25ONfPqhsK2ArHeVl5leYA58
 TAnq4nxgRx+VK0yawzZ3ADYmNtmqybHxfPNC8XAjhiyy5RSr01VAM027P+z9IXh19D+p9q3xGum
 m+K2QcEnPQp8h6q1GYFsP69LdZj+Oxo4J35hZ9QN0qmCU8InQ4QcsntHLFeio1j9V/gcqumkxXs
 q5O38YwTDlfODYNmtrEchMCSs2RQd0xximZzlYdDq4IGMONjzRKn8NxRfzlLiV7m9AMUq3rkmwW
 qptssS8Dhb6jlk=
X-Received: by 2002:a05:600c:4fc7:b0:488:dbcb:ca08 with SMTP id
 5b1f17b1804b1-488fb787a62mr117463845e9.30.1776567976222; 
 Sat, 18 Apr 2026 20:06:16 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm81569905e9.5.2026.04.18.20.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 20:06:15 -0700 (PDT)
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
Date: Sun, 19 Apr 2026 05:03:16 +0200
Message-ID: <20260419030602.2470577-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Various Qualcomm additions this cycle:
* USB superspeed support for 1 platform
* Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
* Improved support for booting with OP-TEE on supported platforms
* Initial basic power domain support

Notably there is a generic change to the device core, missing power
domains will no longer cause a device to fail probe and instead will
just print a warning. This shouldn't affect any existing platforms.

Kind regards,

The following changes since commit e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2026-04-09 16:34:38 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git casey/qcom-main-13Apr2026

for you to fetch changes up to 7f531b27688d94f4ba8663b63bc3b5f82f83c97f:

  qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig (2026-04-13 15:06:46 +0200)

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
 arch/arm/mach-snapdragon/of_fixup.c           | 178 +++++--
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
 drivers/phy/qcom/phy-qcom-qmp-combo.c         | 644 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h        |  62 +++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h     |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |  34 ++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |  88 ++++
 drivers/phy/qcom/phy-qcom-qmp.h               |  17 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-milos.c          | 103 ++++
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
 44 files changed, 2353 insertions(+), 52 deletions(-)
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
