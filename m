Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F48EC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D449C87F5B;
	Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fzdCYZol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1008D87F48; Mon, 26 Feb 2024 18:26:28 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D486087F09
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d568fbf62so1828431f8f.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968382; x=1709573182; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MDOgdEBHq1GX0a8tCmaaak29VQn5BdVwaaKmpzLa88I=;
 b=fzdCYZolNrX+XdMZQ+UfueOsKV2EOenT9TA8AnaVK2k59LkxZoo1MDKr6/Mz7C7Ehd
 lRz1R6JmXOMwkc9uaooNOIMCNUkZmz964XlLJwybHv68OteBPw4AtL+Jr9W1D0Y3k4nB
 7lU2UDFbMKdiQKfQNMaslJpEu/mirZrCtYqmCR8FcqmldLHyGUtJIgSOjaRxITmr3bON
 UpJ2GyhShGkWLcjTmbh9FITsmNx7vi7emAASkreqiGbJZJmuaBwgM5wnbf0MaLS+2XwO
 Hyhwr73wb9+EocncP+Qu4PWNH2aAnb2P3ay4yxjRdTFHhn6c4aBjjl1/U+RFnK6bD5TY
 urUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968382; x=1709573182;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDOgdEBHq1GX0a8tCmaaak29VQn5BdVwaaKmpzLa88I=;
 b=tc20Ome98dSDr5bcYWB3WdjTRqB3wPfXSOxFPLdtBWcI+vbDwGE6s+dBktTwpCFk6j
 PzOGkfxUJ5gRBOB7RZT3fxdgoPokUIXMulSqaTsW2qRP9gedQErMtWL+h9U+m3PzJ43l
 PceZTI+sHThOfLOuxAszyGlUUam6vKPkJnthZf5Z4r6/DYSDCiWDbRfzICVcLAtxiQuk
 +r5RIEqLNveZmYfiB/k9vC8FHKAqTfhUYkytua3kB2BOxuLPPK9OUjK2y/ITSS5G/Rsp
 ED7re0hO8Z96cPvkgtfaqPd+Cn1FiVqeGuodTVLWWm0fmOzWwZAbgFme6AA6Lb9qeuhx
 UFrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDew4OCUQwa6M/9v+RkBdH7UCWqKZAHoX/PVj+Q3mziwvoMkzTO2XM47pOB6Xh9nsyovwDbr46LmJNX24p7UMzFn1jig==
X-Gm-Message-State: AOJu0YzTagm9yi1KmWW4bL1sAVbxT9AquCWibaNdjpU/WxW1XuGlu8m4
 LddLRANhNsxgPDucqlfnsB3aprcPdzp5bkovz9J4zEmu5mki9Pvfadm4Bhomp5o=
X-Google-Smtp-Source: AGHT+IEzslniMmSQ1p4sfcPkrE3RbpN0hFAy+Qa8NciMaP9iJuh/9GBDOMBd+wOSj8wTuPZsZGlfWQ==
X-Received: by 2002:adf:edc3:0:b0:33d:2eba:f5cb with SMTP id
 v3-20020adfedc3000000b0033d2ebaf5cbmr5631207wro.24.1708968382139; 
 Mon, 26 Feb 2024 09:26:22 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:21 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 00/39] Qualcomm generic board support
Date: Mon, 26 Feb 2024 17:26:04 +0000
Message-Id: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzJ3GUC/3XPwWrDMAwG4FcpPs/FsiV37mnvUXZIHDU1tHHnh
 NAR8u5TykopJQcdfiF9QpPquSTu1X4zqcJj6lPuJNDHRsVT1bWsUyNZWWMdAKCuUf/EfNFSl9z
 poSotDxqPgWGH3jGTkt1r4WO63d3Dt+RT6odcfu9nRli6/6KFFXEEbXTAYCF8solAX+fUVSVvc
 2nVQo72ycjQGmOFqX3ThJ1BGeM3xj0YNODMGuOEYbIu1vIpkX9j8MlYoDUGF6Yx3hFF77B6YeZ
 5/gNspm8MkAEAAA==
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
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=19182;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6goYycQy5hiYTTyS+GZQD1UZwYN4pgB1l1nkJj99+lU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3fMjU9axfvzV/T63aoRk07cz3NXuBTVcI2ZdZ3d7
 owXf6dM7yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATUWtn+Ge72DdSKrTVL1B8
 urlEf4+zba6ZuuxFL3v3FTJ3mFbl9DH8r/d7Y7PkZbPF2bevN3R+fq/m0ZzlOGHlgQTfhamnxBg
 9VwIA
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

All Qualcomm boards have had their devicetree files replaced with the
upstream versions. Previous patch series made the necessary driver
adjustments to fully support the upstream DT format. All future
Qualcomm boards should use upstream DTS by default.

Once Sumit's work to import dt-rebasing has been merged, we will drop
the imported DT and bindings again.

---
I have tested this series on the Dragonboard410c, Dragonboard820c, and
Dragonboard845c. Sumit has tested this on the db410c and QCS404 EVB
board.

---
Changes in v5:
- Adjust msm_sdhci clock handling patch to have clearer error handling based on feedback from Dan.
- Adjust dwc3 vbus-supply patch to be more readable and handle error
  paths better based on feedback from Jonas.
- Add a helper function for determining if a pin is "special" in the
  pinctrl/gpio drivers, set special_pins_start for all SoCs and avoid
  modifying const driver data at runtime.
- Add a comment to clarify that the pmic gpio readonly quirk is a
  workaround and not expected behaviour for the platforms where it's
  necessary.
- Link to v4: https://lore.kernel.org/r/20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org

Changes in v4:
- Drop unreachable return in ehci_usb_of_bind()
- Adjust error reporting in msm_sdc_clk_init() to not print ret which
  will always be 0.
- Simplify qcom_pmic_gpio and associated pinctrrl driver.
- Fix the bit clock divider on QCS404 (thanks Sumit).
- Make QCS404 pinctrl driver compatible with upstream DT.
- Fix qcs404_clk_set_rate() return values + move some things that should
  be in enable.
- Optimise reserved memory carveout algorithm and fix the last regions
  always getting skipped.
- Adjust APQ8016 to probe the pinctrl driver pre-relocation so that UART
  can be initialised.
- Stub in support for special pins in the Qualcomm pinctrl driver - we
  don't support them yet but in most cases they're already configured
  correctly and can be safely skipped.
- Improve readability of sdhci msm_sdc_clk_init() and use log_warning()
  instead of printf().
- Add missing CONFIG_SAVE_PREV_BL options to qcom_defconfig
- Document known issue only affecting qcs404 where in the msm_sdhci driver
  the xo_board clock somehow becomes associated with the qcom_clock device
  resulting in qcs404_clk_set_rate() being called for clock id 0. This
  doesn't seem to cause any issues but has proven somewhat elusive to debug.
- Add a link to the APQ8016 TRM in doc/board/qualcomm/dragonboard410c.rst
- Link to v3: https://lore.kernel.org/r/20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org

Changes in v3:
- Remove dragonboard410c.dts file
- Introduce generic board_usb_init() function.
- Remove db410c specific dead code (smem RAM layout)
- Fix pinctrl DT compatibility for msm8916/msm8996
- Reference git tag where DT and headers were taken from Linux.
- Adjust ramdisk allocation size to 128M
- Improve documentation wording, reference buildman
- Fix mapping for reserved regions to avoid speculative pre-fetching
- Apply quicksort to memory banks read from DT to ensure ordering
- Link to v2: https://lore.kernel.org/r/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org

Changes in v2:
- Split DTS changes to reduce patch size.
- Import full board DTS files from Linux too, and introduce -u-boot.dtsi
  files where necessary to make any U-Boot specific changes.
- Add a pinctrl driver for qcom PMIC GPIOs
- Always enable LINUX_KERNEL_IMAGE_HEADER
- Link to v1: https://lore.kernel.org/r/20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org

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
Caleb Connolly (39):
      arm: init: export prev_bl_fdt_addr
      usb: dwc3-generic: support external vbus regulator
      mmc: msm_sdhci: use modern clock handling
      dt-bindings: drop msm_sdhci binding
      clk/qcom: use upstream compatible properties
      clock/qcom: qcs404: fix clk_set_rate
      serial: msm: add debug UART
      serial: msm: fix clock handling and pinctrl
      gpio: qcom_pmic: 1-based GPIOs
      gpio: qcom_pmic: add a quirk to skip GPIO configuration
      gpio: qcom_pmic: add pinctrl driver
      sandbox: dts: fix qcom pmic gpio
      pinctrl: qcom: stub support for special GPIOs
      pinctrl: qcom: fix DT compatibility
      pinctrl: qcom: apq8016: init pre-reloaction
      board: dragonboard410c: add chainloaded config fragment
      board: dragonboard410c: upstream DT compat
      board: dragonboard410c: import board code from mach-snapdragon
      board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
      mach-snapdragon: generalise board support
      mach-snapdragon: dynamic load addresses
      mach-snapdragon: generate fdtfile automatically
      mach-snapdragon: carve out no-map regions
      board: qcs404-evb: drop board code
      doc: board/qualcomm: document generic targets
      doc: board/qualcomm: link to APQ8016 TRM
      dt-bindings: import headers for SDM845
      dts: sdm845: import supporting dtsi files
      dts: sdm845: replace with upstream DTS
      dt-bindings: import headers for MSM8916
      dts: msm8916: import PMIC dtsi files
      dts: msm8916: replace with upstream DTS
      dt-bindings: import headers for MSM8996
      dts: msm8996: import PMIC dtsi files
      dts: dragonboard820c: use correct bindings for clocks
      dts: msm8996: replace with upstream DTS
      dt-bindings: import headers for qcs404
      dts: qcs404-evb: replace with upstream DT
      MAINTAINERS: Qualcomm: add some missing paths

 MAINTAINERS                                        |   12 +-
 arch/arm/Kconfig                                   |    4 +
 arch/arm/dts/Makefile                              |    9 +-
 arch/arm/dts/apq8016-sbc-u-boot.dtsi               |   20 +
 arch/arm/dts/apq8016-sbc.dts                       |  729 +++
 arch/arm/dts/apq8096-db820c-u-boot.dtsi            |   14 +
 arch/arm/dts/apq8096-db820c.dts                    | 1137 ++++
 arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
 arch/arm/dts/dragonboard410c.dts                   |  209 -
 arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
 arch/arm/dts/dragonboard820c.dts                   |  151 -
 arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
 arch/arm/dts/dragonboard845c.dts                   |   48 -
 arch/arm/dts/msm8916-pm8916.dtsi                   |  157 +
 arch/arm/dts/msm8916.dtsi                          | 2702 +++++++++
 arch/arm/dts/msm8996.dtsi                          | 3884 +++++++++++++
 arch/arm/dts/pm8916.dtsi                           |  178 +
 arch/arm/dts/pm8994.dtsi                           |  152 +
 arch/arm/dts/pm8998.dtsi                           |  130 +
 arch/arm/dts/pmi8994.dtsi                          |   65 +
 arch/arm/dts/pmi8998.dtsi                          |   98 +
 arch/arm/dts/pms405.dtsi                           |  149 +
 arch/arm/dts/qcs404-evb-4000-u-boot.dtsi           |   48 +
 arch/arm/dts/qcs404-evb-4000.dts                   |   96 +
 arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
 arch/arm/dts/qcs404-evb.dts                        |  390 --
 arch/arm/dts/qcs404-evb.dtsi                       |  389 ++
 arch/arm/dts/qcs404.dtsi                           | 1829 ++++++
 arch/arm/dts/sdm845-db845c.dts                     | 1190 ++++
 .../arm/dts/sdm845-samsung-starqltechn-u-boot.dtsi |   16 +
 arch/arm/dts/sdm845-samsung-starqltechn.dts        |  460 ++
 arch/arm/dts/sdm845-wcd9340.dtsi                   |   86 +
 arch/arm/dts/sdm845.dtsi                           | 5801 +++++++++++++++++++-
 arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
 arch/arm/dts/starqltechn.dts                       |   68 -
 arch/arm/lib/save_prev_bl_data.c                   |    5 +
 arch/arm/mach-snapdragon/Kconfig                   |   95 +-
 arch/arm/mach-snapdragon/Makefile                  |    8 +-
 arch/arm/mach-snapdragon/board.c                   |  468 ++
 arch/arm/mach-snapdragon/dram.c                    |   99 -
 arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
 arch/arm/mach-snapdragon/include/mach/gpio.h       |    7 +
 arch/arm/mach-snapdragon/include/mach/misc.h       |   13 -
 arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
 arch/arm/mach-snapdragon/misc.c                    |   55 -
 arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
 arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
 arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
 arch/sandbox/dts/sandbox.dtsi                      |    9 +-
 board/qualcomm/dragonboard410c/Kconfig             |   15 -
 board/qualcomm/dragonboard410c/Makefile            |    2 +-
 .../dragonboard410c/configs/chainloaded.config     |    7 +
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  130 +-
 board/qualcomm/dragonboard820c/Kconfig             |   15 -
 board/qualcomm/dragonboard820c/Makefile            |    1 -
 board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
 board/qualcomm/dragonboard820c/head.S              |   33 -
 board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
 board/qualcomm/dragonboard845c/Kconfig             |   12 -
 board/qualcomm/qcs404-evb/Kconfig                  |   15 -
 board/qualcomm/qcs404-evb/Makefile                 |    6 -
 board/qualcomm/qcs404-evb/qcs404-evb.c             |   62 -
 configs/dragonboard410c_defconfig                  |    8 +-
 configs/dragonboard820c_defconfig                  |    8 +-
 configs/dragonboard845c_defconfig                  |   29 -
 configs/qcom_defconfig                             |   67 +
 configs/qcs404evb_defconfig                        |   55 -
 configs/starqltechn_defconfig                      |   41 -
 doc/board/qualcomm/board.rst                       |  125 +
 doc/board/qualcomm/debugging.rst                   |   61 +
 doc/board/qualcomm/dragonboard410c.rst             |    2 +
 doc/board/qualcomm/index.rst                       |    4 +-
 doc/board/qualcomm/qcs404.rst                      |   79 -
 doc/board/qualcomm/sdm845.rst                      |  167 -
 doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
 doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
 drivers/clk/qcom/clock-apq8016.c                   |    9 +-
 drivers/clk/qcom/clock-apq8096.c                   |    7 +-
 drivers/clk/qcom/clock-qcs404.c                    |   25 +-
 drivers/gpio/msm_gpio.c                            |   20 +
 drivers/gpio/qcom_pmic_gpio.c                      |  277 +-
 drivers/mmc/msm_sdhci.c                            |   69 +-
 drivers/phy/qcom/msm8916-usbh-phy.c                |    4 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c             |   34 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c             |   21 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             |    5 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c                |   12 +
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |   64 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |    5 +-
 drivers/serial/Kconfig                             |    8 +
 drivers/serial/serial_msm.c                        |   62 +-
 drivers/usb/dwc3/dwc3-generic.c                    |   24 +-
 drivers/usb/host/ehci-msm.c                        |   22 +-
 include/configs/dragonboard845c.h                  |   20 -
 include/configs/qcom.h                             |   21 +
 include/configs/qcs404-evb.h                       |   20 -
 include/configs/sdm845.h                           |   26 -
 include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
 include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
 include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
 include/dt-bindings/clock/qcom,gcc-msm8996.h       |  362 ++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
 include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
 include/dt-bindings/clock/qcom,rpmh.h              |   37 +
 include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
 include/dt-bindings/dma/qcom-gpi.h                 |   11 +
 include/dt-bindings/firmware/qcom,scm.h            |   39 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
 include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
 include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
 include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
 include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
 include/dt-bindings/phy/phy-qcom-qmp.h             |   20 +
 include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h        |  106 +
 include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |   36 +
 include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
 include/dt-bindings/soc/qcom,apr.h                 |   28 +
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
 include/dt-bindings/sound/apq8016-lpass.h          |    9 +
 include/dt-bindings/sound/qcom,lpass.h             |   46 +
 include/dt-bindings/sound/qcom,q6afe.h             |    9 +
 include/dt-bindings/sound/qcom,q6asm.h             |   26 +
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |  234 +
 include/dt-bindings/sound/qcom,wcd9335.h           |   15 +
 include/init.h                                     |   11 +
 136 files changed, 24033 insertions(+), 2652 deletions(-)
---
base-commit: 1a66a7768af7e8106c2cd93a19f4013877fb85ae

// Caleb (they/them)

