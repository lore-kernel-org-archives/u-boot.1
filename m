Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190EAC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237C28760C;
	Tue, 21 Nov 2023 18:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQpdQp4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DADF87605; Tue, 21 Nov 2023 18:09:33 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93356875A7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c59a4dd14cso70365571fa.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586569; x=1701191369; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+iH3y3g3PL0R++kqazM2kAIEWVn98MpM7wCs+8lqBU=;
 b=oQpdQp4hi+QbqmepkI7QveIvs+UefIDrTYtY9i0GvXsLh/EUyQ7M81LFxoWzXaHaJT
 Jj5v3wLHJDULafnvo4w76Wko0wP1KEdJJvK74/vHsLRJMJCKVJArVA3Q1ZglwptKEuzv
 f9lRUdL0W+gZtC0FVNw380UCKybWTa8F3mOzaBCWkYKnNm+TSrGjpK6dijInP8wnAgZB
 2Q2rAplRlIZjzjNbjMgLqlvfyGKnmSq9KxNw1BU+0RsDIzPJwxXyh8e+S+nJAAxvyrNA
 vmQuBAoW3kno0IxidlA202iyR/+92xZ9ia89l432EqeI2hc6QPKbpTusCGyP1vAUE74I
 VKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586569; x=1701191369;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+iH3y3g3PL0R++kqazM2kAIEWVn98MpM7wCs+8lqBU=;
 b=QxjMhjG6YJUMgb0MhToep0Bh2yzENs8WU1utHu7Iu7MujKhKL0g3XaPSyfAAMNONQD
 Z8njtfcOuKRp4PXAlx0uh0mv+zpF/4hn7PKdQV8yum9egHmLAuaw2rqXUAWcyAdLLx2G
 zOKvYNbiMAJaDTY4iKctExAN5N8JSHkmdiY/P3LBLZCMtuJjF+Jmp8cK6PRk7j3G15tO
 9OQfR1GceljzWKG1zgHJZHqPZCPRWMHUDvXCJ0h+8bWJWslK8ri5o48sWYOurCZxMkOi
 +DwlouvKIwvKRmht3gdsp/UOIhpn7/sRGuIXke1QKvU8O98RwdW7JQmG+HSlT6G1SZJj
 vZkQ==
X-Gm-Message-State: AOJu0YwP1SSBevUgoMKRgfQG2p264JCSuEKUt65intjgaqX0Ziim32pI
 TDqSZdOoPShHl76q38rpW61Fsw==
X-Google-Smtp-Source: AGHT+IEz6a44UK7naTWOG3cTwoaBsm/sS9wlceDQf3Rhdm2/2FE7+kIAguzoG/njh6Ts4s6DgxQdjA==
X-Received: by 2002:a2e:bc1e:0:b0:2c8:8b61:ea13 with SMTP id
 b30-20020a2ebc1e000000b002c88b61ea13mr2704065ljf.18.1700586568692; 
 Tue, 21 Nov 2023 09:09:28 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 00/21] Qualcomm generic board support
Date: Tue, 21 Nov 2023 17:09:23 +0000
Message-Id: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEPkXGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0MT3SQT3cLk/FxdIM7Nz9MtSSxKTy3RNUmzTDU0NzEzTk01VQLqLSh
 KTcusAJsbHVtbCwCuMOjIZwAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=13638;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=AM9BVJunu7L3Rjbpqge5c4vQf+9raQtWKdMq2OewGSA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ67HZc9e3pZxQDz1ks/9ErPVb9Q/MzjOMJ+lmX+gm
 d9t9cTmjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjAR33OMDHsENI6+rLDcfjPg
 4VEbCYkv6hOYc/f9EfkcU2F85uQm8RJGhuUFBif13GOdYoJ+xC+wX/xF9Gp9ruHO8KZ90ftemf2
 UKQUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Historically, Qualcomm boards in U-Boot have all had their own
board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
own hardcoded sysmap-xyz.c file, and their own U-Boot specific
devicetree with little/no compatibility with upstream DT.

This series makes a few final prepatory changes, and then replaces
almost all of the board specific code with generic alternatives. The end
result is that all Qualcomm boards both current and future (with the
exception of the db410c and db820c) can be supported by a single U-Boot
binary by just providing the correct DT. New boards can be added without
introducing any addition mach/ or board/ code or config options.

Due to the nature of this change, the patch ("mach-snapdragon:
generalise board support") has become pretty big, I tried a few
different ways to represent this in git history, but the other methods
(e.g. adding a stub "generic" target and removing it again) were more
confusing and made for much messier git history. The current patch is
mostly atomic, but requires regenerating the config.

The QCS404 EVB board had some code to enable the USB VBUS regulator,
this is dropped in favour of a adding a new vbus-supply property to the
dwc3-generic driver. This will also be used by the dragonboard845c in a
future patch. This handles the common case of a board requiring some
regulator be enabled for USB host mode.

A more detailed description of the changes is below.

== Memory map ==

The memory map was historically hardcoded into U-Boot, this meant that
U-Boot had to be built for a specific variant of a device. This is
changed to instead read the memory map from the DT /memory node.

Additionally, most boards mapped addresss 0x0 as valid, as a result if a
null pointer access happens then it will cause a bus stall (and board
hang). This is fixed so that null pointer accesses will now correctly
throw an exception.

== DT loading ==

Previously, boards used the FDT blob embedded into U-Boot (via
OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
bootloader, so we can instead rely on the first-stage bootloader to
populate some useful FDT properties for us (notably the /memory node and
KASLR seed) and fetch the DTB that it provides. Combined with the memory
map changes above, this let's us entirely avoid configuring the memory
map explicitly.

== defconfig ==

Most of the board defconfigs and config headers were quite similar, to
simplify maintenance going forward, all the fully generic boards (sdm845
and qcs404-evb so far) are adapted to use the new qcom_defconfig. Going
forward, all new Qualcomm boards should be supported by this defconfig.
A notable exception is for specific usecases (like U-Boot as the primary
bootloader).

== The older dragonboards ==

The db410c and db820c both have some custom board init code, as a result
they aren't yet binary compatible. mach-snapdragon is adjusted so
that all the necessary config options (e.g. CONFIG_SYS_BOARD) can be set
from their defconfigs, this makes it possible to enable support for new
boards without introducing additional config options.

The db410c can run U-Boot either chainloaded like the other boards, or
as a first-stage bootloader replacing aboot. However it was hardcoded to
only build for the latter option. This series introduces a new
"chainloaded" defconfig to enable easier testing via fastboot.

== dynamic environment variables ==

This series also introduces runtime-allocated load addresses via the lmb
allocator. This allows for booting on boards with vastly different
memory layouts without any pre-calculation or macro magic in the config
header. This feature is based on similar code in mach-apple.

The soc, board, and fdtfile environment variables are also generated
automatically. Many Qualcomm boards follow a similar scheme for DTB
naming such that the name can often be derived from the root compatible
properties. This is intended to cover the most common cases and be a
simple solution for booting generic distro images without having to
explicitly choose the right DTB. The U-Boot DTS can be tweaked if
necessary to produce the correct name, the variable can be overwritten,
or a bootloader like GRUB can load the devicetree instead.

== Upstream DT ==

All Qualcomm boards have had their devicetree files rewritten to be
based on the upstream SoC/PMIC DTSI files. Previous patch series made
the necessary driver adjustments to fully support the upstream DT
format. All future Qualcomm boards should use upstream DTS by default.

---
I have tested this series on the Dragonboard410c, Dragonboard820c, and
Dragonboard845c. I unfortunately don't have access to a QCS404 EVB board
to test.

This series is based on the qcom-next branch [1] and depends on my PMIC
fixes series [2], an integration branch for testing can be found at [3].
The non-qualcomm-specific changes (patches 1, 2, and 3) don't have any
dependencies.

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
[2]: https://lore.kernel.org/u-boot/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org/
[3]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-common-target

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Marek Vasut <marex@denx.de>
To: Dzmitry Sankouski <dsankouski@gmail.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To: Lukasz Majewski <lukma@denx.de>
To: Sean Anderson <seanga2@gmail.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
To: Stephan Gerhold <stephan@gerhold.net>
Cc:  <u-boot@lists.denx.de>

---
Caleb Connolly (21):
      arm: init: export prev_bl_fdt_addr
      arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be set in defconfig
      usb: dwc3-generic: support external vbus regulator
      mmc: msm_sdhci: use modern clock handling
      dt-bindings: drop msm_sdhci binding
      clk/qcom: use upstream compatible properties
      serial: msm: add debug UART
      serial: msm: fix clock handling
      configs: add dragonboard410c_chainloaded_defconfig
      dts: dragonboard410c: fix compatible and clocks
      board: dragonboard410c: import board code from mach-snapdragon
      board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
      mach-snapdragon: generalise board support
      mach-snapdragon: dynamic load addresses
      mach-snapdragon: generate fdtfile automatically
      doc: board/qualcomm: document generic targets
      dts: sdm845: import DT from Linux
      dts: msm8916: import DT from Linux
      dts: msm8996: import DT from Linux
      dts: qcs404-evb: import DT from Linux
      MAINTAINERS: Qualcomm: add some missing paths

 MAINTAINERS                                        |   16 +-
 arch/arm/Kconfig                                   |    6 +-
 arch/arm/dts/Makefile                              |    9 +-
 arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
 arch/arm/dts/dragonboard410c.dts                   |  198 +-
 arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
 arch/arm/dts/dragonboard820c.dts                   |  129 +-
 arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
 arch/arm/dts/dragonboard845c.dts                   |   23 +-
 arch/arm/dts/msm8916-pins.dtsi                     |  582 ++
 arch/arm/dts/msm8916-pm8916.dtsi                   |   76 +
 arch/arm/dts/msm8916.dtsi                          | 2194 ++++++++
 arch/arm/dts/msm8996.dtsi                          | 3959 +++++++++++++
 arch/arm/dts/pm8916.dtsi                           |  183 +
 arch/arm/dts/pm8994.dtsi                           |  152 +
 arch/arm/dts/pm8998.dtsi                           |  130 +
 arch/arm/dts/pms405.dtsi                           |  149 +
 arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
 arch/arm/dts/qcs404-evb.dts                        |  441 +-
 arch/arm/dts/qcs404.dtsi                           | 1830 ++++++
 arch/arm/dts/sdm845.dtsi                           | 5850 +++++++++++++++++++-
 arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
 arch/arm/dts/starqltechn.dts                       |   34 +-
 arch/arm/lib/save_prev_bl_data.c                   |    5 +
 arch/arm/mach-snapdragon/Kconfig                   |   95 +-
 arch/arm/mach-snapdragon/Makefile                  |    8 +-
 arch/arm/mach-snapdragon/board.c                   |  303 +
 arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
 arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
 arch/arm/mach-snapdragon/misc.c                    |   55 -
 arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
 arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
 board/qualcomm/dragonboard410c/Kconfig             |   15 -
 board/qualcomm/dragonboard410c/MAINTAINERS         |    1 +
 board/qualcomm/dragonboard410c/Makefile            |    3 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   |   31 +-
 .../qualcomm/dragonboard410c/misc.c                |   51 +-
 .../mach => board/qualcomm/dragonboard410c}/misc.h |    1 +
 board/qualcomm/dragonboard820c/Kconfig             |   15 -
 board/qualcomm/dragonboard820c/Makefile            |    1 -
 board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
 board/qualcomm/dragonboard820c/head.S              |   33 -
 board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
 board/qualcomm/dragonboard845c/Kconfig             |   12 -
 board/qualcomm/qcs404-evb/Kconfig                  |   15 -
 board/qualcomm/qcs404-evb/qcs404-evb.c             |   21 +-
 configs/dragonboard410c_chainloaded_defconfig      |   72 +
 configs/dragonboard410c_defconfig                  |    6 +-
 configs/dragonboard820c_defconfig                  |    6 +-
 configs/dragonboard845c_defconfig                  |   29 -
 configs/qcom_defconfig                             |   71 +
 configs/qcs404evb_defconfig                        |   55 -
 configs/starqltechn_defconfig                      |   41 -
 doc/board/qualcomm/board.rst                       |  119 +
 doc/board/qualcomm/debugging.rst                   |   61 +
 doc/board/qualcomm/index.rst                       |    4 +-
 doc/board/qualcomm/qcs404.rst                      |   79 -
 doc/board/qualcomm/sdm845.rst                      |  162 -
 doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
 doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
 drivers/clk/qcom/clock-apq8016.c                   |    9 +-
 drivers/clk/qcom/clock-apq8096.c                   |    7 +-
 drivers/mmc/msm_sdhci.c                            |   69 +-
 drivers/phy/qcom/msm8916-usbh-phy.c                |    2 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c             |    2 +-
 drivers/serial/Kconfig                             |    8 +
 drivers/serial/serial_msm.c                        |   61 +-
 drivers/usb/dwc3/dwc3-generic.c                    |   12 +
 drivers/usb/host/ehci-msm.c                        |    2 +-
 include/configs/dragonboard845c.h                  |   20 -
 include/configs/qcom.h                             |   21 +
 include/configs/qcs404-evb.h                       |   20 -
 include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
 include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
 include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
 include/dt-bindings/clock/qcom,gcc-msm8996.h       |  360 ++
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |    4 +
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
 include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
 include/dt-bindings/clock/qcom,rpmh.h              |   37 +
 include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
 include/dt-bindings/dma/qcom-gpi.h                 |   11 +
 include/dt-bindings/firmware/qcom,scm.h            |   18 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
 include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
 include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
 include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
 include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
 include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
 include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
 include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
 include/dt-bindings/soc/qcom,apr.h                 |   28 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
 include/init.h                                     |   11 +
 104 files changed, 18987 insertions(+), 2063 deletions(-)
---
base-commit: 516584b4d50880cb5e2361e55f8c5b4fc6c35901

// Caleb (they/them)

