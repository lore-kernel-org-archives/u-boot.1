Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A991C072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 06:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BED48718E;
	Wed, 22 Nov 2023 07:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/NC2JK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C823F86FE9; Wed, 22 Nov 2023 07:21:47 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B568749C
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 07:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7c3fd1b5817so310957241.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 22:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700634101; x=1701238901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xPQAc5X/QOHP/SbMWodlklmK5zo/yDXO7rqPSoGaIL0=;
 b=h/NC2JK9l7oBTl9iQH7aBWbl0vuQU1sXeHqRYEYQG8lEQbqLlgzc9P5y/jvEczTNuO
 DE/pmGtQDclEf9SJElvy0RZ8wFz9SkbkdMGqXlPWYGF7LGh6ZWsukqM35XcGJIdvezAw
 LCO2+hN1hLgiUSB7EStmAWrP2EVn1h//d3VFiv05AXLZJtTRgU7duAx2aZ0ska2iqRV2
 YBmaKw6ReAmTS0RP22BrGoWald3Xnb09ecJlVrRSb2WAAvJ4DQgLyA4XT02njaWLRNha
 KDyfg+M3MvsNiMbuQtvlPR1UumS7QGtQ/7fSMBwAiAF6K1ABLBKWyu/vtngHDJVPfqMV
 iYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700634101; x=1701238901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPQAc5X/QOHP/SbMWodlklmK5zo/yDXO7rqPSoGaIL0=;
 b=RXz/E4DbDrNYWizN7+EzMWF4gmZ4ZS1h6KhCq2nz+k6QI2Oj8CJSHC/pxFouhHOsL4
 MTXiYXcVi8CVFAjVl7/Byrgda2NyRdkJNVN/u7saB3tC3F9AEbKJVQnj0E9mMu7NMQA5
 3wpQCSWvxmk6a9Ggbm0uj4rQFCoa4LPBaPgIvvzYaSvZcdl9QwHLw2Jb5VlovqVK30KH
 fienUpgkL6WQ6klMu1/e7NAolY+xu1Pw5yHfVEkhJwU8M8uI7Zj7j+iFQSfm3ck2r022
 L5R1cBPt519IaJzSIByOTqlIK18DPxSG1j8DyOAzoobA2iRQIOUsQaq9dzdsUf99Vt00
 HGew==
X-Gm-Message-State: AOJu0YzLGMvTEspXUO6Qbnv7lus4H12dh366hO6OkCwS8ppEZ8yUf60x
 /ZJECvUeATgNdC9UceDzEmkBUzONKGDpSTvoRXyWWg==
X-Google-Smtp-Source: AGHT+IHPgyeVkMsOzl7Sik4GSACEFDJEyRlVY3N7Z6Yl+WAt1VYqCrmwN+84fgQmnJyIBz3Tifmajw1PPq/IMBE1NJ4=
X-Received: by 2002:a67:e9d2:0:b0:45d:773b:f57b with SMTP id
 q18-20020a67e9d2000000b0045d773bf57bmr5186022vso.17.1700634101091; Tue, 21
 Nov 2023 22:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 22 Nov 2023 11:51:29 +0530
Message-ID: <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Historically, Qualcomm boards in U-Boot have all had their own
> board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> devicetree with little/no compatibility with upstream DT.
>
> This series makes a few final prepatory changes, and then replaces
> almost all of the board specific code with generic alternatives. The end
> result is that all Qualcomm boards both current and future (with the
> exception of the db410c and db820c) can be supported by a single U-Boot
> binary by just providing the correct DT. New boards can be added without
> introducing any addition mach/ or board/ code or config options.
>
> Due to the nature of this change, the patch ("mach-snapdragon:
> generalise board support") has become pretty big, I tried a few
> different ways to represent this in git history, but the other methods
> (e.g. adding a stub "generic" target and removing it again) were more
> confusing and made for much messier git history. The current patch is
> mostly atomic, but requires regenerating the config.
>
> The QCS404 EVB board had some code to enable the USB VBUS regulator,
> this is dropped in favour of a adding a new vbus-supply property to the
> dwc3-generic driver. This will also be used by the dragonboard845c in a
> future patch. This handles the common case of a board requiring some
> regulator be enabled for USB host mode.
>

Thanks for your work. It is a good step towards a generalized u-boot
on Qcom platforms. Although I would like to give it an in-depth
review, I have a common discussion point about DT, see below.

> A more detailed description of the changes is below.
>
> == Memory map ==
>
> The memory map was historically hardcoded into U-Boot, this meant that
> U-Boot had to be built for a specific variant of a device. This is
> changed to instead read the memory map from the DT /memory node.
>
> Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> null pointer access happens then it will cause a bus stall (and board
> hang). This is fixed so that null pointer accesses will now correctly
> throw an exception.
>
> == DT loading ==
>
> Previously, boards used the FDT blob embedded into U-Boot (via
> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> bootloader, so we can instead rely on the first-stage bootloader to
> populate some useful FDT properties for us (notably the /memory node and
> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> map changes above, this let's us entirely avoid configuring the memory
> map explicitly.

Since with this change, we don't need to embed FDT blob in the u-boot
binary, so I was thinking if we really need to import DTs from Linux
for different platforms and then play a catchup game?

IMO, the build command would look like following if we import
pre-built FDT blob from Linux:

- Build u-boot::

       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
       $ make qcom_defconfig
       $ make

- gzip u-boot::

       gzip u-boot-nodtb.bin

- Append dtb to gzipped u-boot::

        cat u-boot-nodtb.bin.gz
<linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
u-boot-nodtb.bin.gz-dtb

This would avoid the maintenance burden to keep DT in sync with that
of Linux. And since DT bindings in Linux are backwards compatible, we
can say u-boot should work with DTB picked up from any Linux kernel
stable release.

-Sumit

>
> == defconfig ==
>
> Most of the board defconfigs and config headers were quite similar, to
> simplify maintenance going forward, all the fully generic boards (sdm845
> and qcs404-evb so far) are adapted to use the new qcom_defconfig. Going
> forward, all new Qualcomm boards should be supported by this defconfig.
> A notable exception is for specific usecases (like U-Boot as the primary
> bootloader).
>
> == The older dragonboards ==
>
> The db410c and db820c both have some custom board init code, as a result
> they aren't yet binary compatible. mach-snapdragon is adjusted so
> that all the necessary config options (e.g. CONFIG_SYS_BOARD) can be set
> from their defconfigs, this makes it possible to enable support for new
> boards without introducing additional config options.
>
> The db410c can run U-Boot either chainloaded like the other boards, or
> as a first-stage bootloader replacing aboot. However it was hardcoded to
> only build for the latter option. This series introduces a new
> "chainloaded" defconfig to enable easier testing via fastboot.
>
> == dynamic environment variables ==
>
> This series also introduces runtime-allocated load addresses via the lmb
> allocator. This allows for booting on boards with vastly different
> memory layouts without any pre-calculation or macro magic in the config
> header. This feature is based on similar code in mach-apple.
>
> The soc, board, and fdtfile environment variables are also generated
> automatically. Many Qualcomm boards follow a similar scheme for DTB
> naming such that the name can often be derived from the root compatible
> properties. This is intended to cover the most common cases and be a
> simple solution for booting generic distro images without having to
> explicitly choose the right DTB. The U-Boot DTS can be tweaked if
> necessary to produce the correct name, the variable can be overwritten,
> or a bootloader like GRUB can load the devicetree instead.
>
> == Upstream DT ==
>
> All Qualcomm boards have had their devicetree files rewritten to be
> based on the upstream SoC/PMIC DTSI files. Previous patch series made
> the necessary driver adjustments to fully support the upstream DT
> format. All future Qualcomm boards should use upstream DTS by default.
>
> ---
> I have tested this series on the Dragonboard410c, Dragonboard820c, and
> Dragonboard845c. I unfortunately don't have access to a QCS404 EVB board
> to test.
>
> This series is based on the qcom-next branch [1] and depends on my PMIC
> fixes series [2], an integration branch for testing can be found at [3].
> The non-qualcomm-specific changes (patches 1, 2, and 3) don't have any
> dependencies.
>
> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
> [2]: https://lore.kernel.org/u-boot/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org/
> [3]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-common-target
>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@linaro.org>
> To: Ramon Fried <rfried.dev@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> To: Dzmitry Sankouski <dsankouski@gmail.com>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Peng Fan <peng.fan@nxp.com>
> To: Jaehoon Chung <jh80.chung@samsung.com>
> To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> To: Lukasz Majewski <lukma@denx.de>
> To: Sean Anderson <seanga2@gmail.com>
> To: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> To: Stephan Gerhold <stephan@gerhold.net>
> Cc:  <u-boot@lists.denx.de>
>
> ---
> Caleb Connolly (21):
>       arm: init: export prev_bl_fdt_addr
>       arm: allow CONFIG_LINUX_KERNEL_IMAGE_HEADER to be set in defconfig
>       usb: dwc3-generic: support external vbus regulator
>       mmc: msm_sdhci: use modern clock handling
>       dt-bindings: drop msm_sdhci binding
>       clk/qcom: use upstream compatible properties
>       serial: msm: add debug UART
>       serial: msm: fix clock handling
>       configs: add dragonboard410c_chainloaded_defconfig
>       dts: dragonboard410c: fix compatible and clocks
>       board: dragonboard410c: import board code from mach-snapdragon
>       board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
>       mach-snapdragon: generalise board support
>       mach-snapdragon: dynamic load addresses
>       mach-snapdragon: generate fdtfile automatically
>       doc: board/qualcomm: document generic targets
>       dts: sdm845: import DT from Linux
>       dts: msm8916: import DT from Linux
>       dts: msm8996: import DT from Linux
>       dts: qcs404-evb: import DT from Linux
>       MAINTAINERS: Qualcomm: add some missing paths
>
>  MAINTAINERS                                        |   16 +-
>  arch/arm/Kconfig                                   |    6 +-
>  arch/arm/dts/Makefile                              |    9 +-
>  arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
>  arch/arm/dts/dragonboard410c.dts                   |  198 +-
>  arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
>  arch/arm/dts/dragonboard820c.dts                   |  129 +-
>  arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
>  arch/arm/dts/dragonboard845c.dts                   |   23 +-
>  arch/arm/dts/msm8916-pins.dtsi                     |  582 ++
>  arch/arm/dts/msm8916-pm8916.dtsi                   |   76 +
>  arch/arm/dts/msm8916.dtsi                          | 2194 ++++++++
>  arch/arm/dts/msm8996.dtsi                          | 3959 +++++++++++++
>  arch/arm/dts/pm8916.dtsi                           |  183 +
>  arch/arm/dts/pm8994.dtsi                           |  152 +
>  arch/arm/dts/pm8998.dtsi                           |  130 +
>  arch/arm/dts/pms405.dtsi                           |  149 +
>  arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
>  arch/arm/dts/qcs404-evb.dts                        |  441 +-
>  arch/arm/dts/qcs404.dtsi                           | 1830 ++++++
>  arch/arm/dts/sdm845.dtsi                           | 5850 +++++++++++++++++++-
>  arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
>  arch/arm/dts/starqltechn.dts                       |   34 +-
>  arch/arm/lib/save_prev_bl_data.c                   |    5 +
>  arch/arm/mach-snapdragon/Kconfig                   |   95 +-
>  arch/arm/mach-snapdragon/Makefile                  |    8 +-
>  arch/arm/mach-snapdragon/board.c                   |  303 +
>  arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
>  arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
>  arch/arm/mach-snapdragon/misc.c                    |   55 -
>  arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
>  arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
>  arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
>  arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
>  board/qualcomm/dragonboard410c/Kconfig             |   15 -
>  board/qualcomm/dragonboard410c/MAINTAINERS         |    1 +
>  board/qualcomm/dragonboard410c/Makefile            |    3 +-
>  board/qualcomm/dragonboard410c/dragonboard410c.c   |   31 +-
>  .../qualcomm/dragonboard410c/misc.c                |   51 +-
>  .../mach => board/qualcomm/dragonboard410c}/misc.h |    1 +
>  board/qualcomm/dragonboard820c/Kconfig             |   15 -
>  board/qualcomm/dragonboard820c/Makefile            |    1 -
>  board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
>  board/qualcomm/dragonboard820c/head.S              |   33 -
>  board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
>  board/qualcomm/dragonboard845c/Kconfig             |   12 -
>  board/qualcomm/qcs404-evb/Kconfig                  |   15 -
>  board/qualcomm/qcs404-evb/qcs404-evb.c             |   21 +-
>  configs/dragonboard410c_chainloaded_defconfig      |   72 +
>  configs/dragonboard410c_defconfig                  |    6 +-
>  configs/dragonboard820c_defconfig                  |    6 +-
>  configs/dragonboard845c_defconfig                  |   29 -
>  configs/qcom_defconfig                             |   71 +
>  configs/qcs404evb_defconfig                        |   55 -
>  configs/starqltechn_defconfig                      |   41 -
>  doc/board/qualcomm/board.rst                       |  119 +
>  doc/board/qualcomm/debugging.rst                   |   61 +
>  doc/board/qualcomm/index.rst                       |    4 +-
>  doc/board/qualcomm/qcs404.rst                      |   79 -
>  doc/board/qualcomm/sdm845.rst                      |  162 -
>  doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
>  doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
>  drivers/clk/qcom/clock-apq8016.c                   |    9 +-
>  drivers/clk/qcom/clock-apq8096.c                   |    7 +-
>  drivers/mmc/msm_sdhci.c                            |   69 +-
>  drivers/phy/qcom/msm8916-usbh-phy.c                |    2 +-
>  drivers/pinctrl/qcom/pinctrl-apq8016.c             |    2 +-
>  drivers/serial/Kconfig                             |    8 +
>  drivers/serial/serial_msm.c                        |   61 +-
>  drivers/usb/dwc3/dwc3-generic.c                    |   12 +
>  drivers/usb/host/ehci-msm.c                        |    2 +-
>  include/configs/dragonboard845c.h                  |   20 -
>  include/configs/qcom.h                             |   21 +
>  include/configs/qcs404-evb.h                       |   20 -
>  include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
>  include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
>  include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
>  include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
>  include/dt-bindings/clock/qcom,gcc-msm8996.h       |  360 ++
>  include/dt-bindings/clock/qcom,gcc-qcs404.h        |    4 +
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
>  include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
>  include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
>  include/dt-bindings/clock/qcom,rpmh.h              |   37 +
>  include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
>  include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
>  include/dt-bindings/dma/qcom-gpi.h                 |   11 +
>  include/dt-bindings/firmware/qcom,scm.h            |   18 +
>  include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
>  include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
>  .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
>  include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
>  include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
>  include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
>  include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
>  include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
>  include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
>  include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
>  include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
>  include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
>  include/dt-bindings/soc/qcom,apr.h                 |   28 +
>  include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
>  include/init.h                                     |   11 +
>  104 files changed, 18987 insertions(+), 2063 deletions(-)
> ---
> base-commit: 516584b4d50880cb5e2361e55f8c5b4fc6c35901
>
> // Caleb (they/them)
>
