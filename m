Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65841C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 08:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53ACB87F26;
	Mon, 19 Feb 2024 09:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLelqlbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2B687F28; Mon, 19 Feb 2024 09:46:14 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C86C87DE0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 09:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4704750edd7so74641137.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708332361; x=1708937161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4q+sbFoutos19ubRDPLvFR7uB87tBWpUNdq80QddWw=;
 b=OLelqlbttnpTIGK4n8E0C5ocS8c2sBRxUGzj+iNtryUkbbaGz2wR8q61bCfujfc8Hr
 xoypWYkoP69s1CxOm3q9YQIngrD8KzgveGC4q3rIMCikUTxcuEo4w+3sWUJLHPhRlXO8
 tCSS3xnOSi/ZX2onvSC0hJTN/5S8RQeZshT52+qLw3H45OMjAgzZCtu7X4FpNA073joK
 2sOOoQNI8buhqOmRLfw42R9nh/jbEIZkux0UalySRcd87acVmocAGNu7KYg2KScfLBNo
 h4dpOam629dwJiVAy7hFHy+iBLGV9N9XJrS/D//SxtkOtTEzYZV8QJSwbx1DVKtUSnuj
 kRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708332361; x=1708937161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4q+sbFoutos19ubRDPLvFR7uB87tBWpUNdq80QddWw=;
 b=eQBVcvdGCiQx5QEp7XwU4UyaQS2bQpRzA863FvAmDRQtQA0r6vjxPbvZLAoz95FhYs
 fuFXK65vR6Y4gJvzZ9g/H3olSua82eBds2MXm5rD7Bcg3Q6Md5cwmp8x4rGJWo59zMx1
 EclsB/PE4i13D2TcPFWiWzUo5gIbtt8s8kwSe0LK4QRHRiyTga2ybBQgdPAzVJulOhDv
 +EyVaBfXIXgLTsRrzmZo7FagrPLMsH6vVzXXvgTukEB+FI6Pb7mtZxFFQdTQbcWNN9Lc
 3iJENy6VmDTXw8GQr5Xbh2X5e+RzlFtnuKIBXnfhSc6C0YsL0RY3JynRwRv++ElWugp2
 ZkOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQr7RRBomhdofBTimmrY84qm5/AUXE2/ohoKXlxNIhTg1GrSYHD2PyP9lYLrSZBVz7/HgF/3WU6TIECQ5aIWiM4sZlnw==
X-Gm-Message-State: AOJu0YyPjvenFKIDAXKfx5stnpR/IjCNsKlyvRp7QOAzpria5/ZE9Ftz
 RjiRoH51qM94X9b/DKsoQ9ruh7iyQk4xJKMk8OtU9DSAe64rLVyDLQ6pNVlhIYNCgDuddMcjnzv
 Z7ps23s/GbYzMueimlC+ga9w6J23JEQqExy00PA==
X-Google-Smtp-Source: AGHT+IHBNodtT7cQRq09ypxmsblkFKbQ8ItCQewuA+Ybo5hh0aw6Oa7OQCXGtpzxcCnWaU3mjHjZ2ntviVL92M60+e8=
X-Received: by 2002:a67:ec0a:0:b0:470:4dd8:b18 with SMTP id
 d10-20020a67ec0a000000b004704dd80b18mr2294439vso.19.1708332361231; Mon, 19
 Feb 2024 00:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 19 Feb 2024 14:15:50 +0530
Message-ID: <CAFA6WYN548WA9JNEs+VEAGnvdqXDUhGopZhfRBbNwP69cFCHgQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/39] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
> All Qualcomm boards have had their devicetree files replaced with the
> upstream versions. Previous patch series made the necessary driver
> adjustments to fully support the upstream DT format. All future
> Qualcomm boards should use upstream DTS by default.
>
> Once Sumit's work to import dt-rebasing has been merged, we will drop
> the imported DT and bindings again.
>
> ---
> I have tested this series on the Dragonboard410c, Dragonboard820c, and
> Dragonboard845c. I unfortunately don't have access to a QCS404 EVB board
> to test.

Thanks for incorporating my feedback (on ML as well as offline) to
resolve regressions seen on db41c and qcs404.

Feel free to add following to corresponding patches:

Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404

-Sumit

>
> This series is based on the qcom-next branch [1] and depends on my PMIC
> fixes series [2], an integration branch for testing can be found at [3].
> The non-qualcomm-specific changes (patches 1 and 2) don't have any
> dependencies.
>
> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
> [2]: https://lore.kernel.org/u-boot/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org/
> [3]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-common-target
>
> ---
> Changes in v4:
> - Drop unreachable return in ehci_usb_of_bind()
> - Adjust error reporting in msm_sdc_clk_init() to not print ret which
>   will always be 0.
> - Simplify qcom_pmic_gpio and associated pinctrrl driver.
> - Fix the bit clock divider on QCS404 (thanks Sumit).
> - Make QCS404 pinctrl driver compatible with upstream DT.
> - Fix qcs404_clk_set_rate() return values + move some things that should
>   be in enable.
> - Optimise reserved memory carveout algorithm and fix the last regions
>   always getting skipped.
> - Adjust APQ8016 to probe the pinctrl driver pre-relocation so that UART
>   can be initialised.
> - Stub in support for special pins in the Qualcomm pinctrl driver - we
>   don't support them yet but in most cases they're already configured
>   correctly and can be safely skipped.
> - Improve readability of sdhci msm_sdc_clk_init() and use log_warning()
>   instead of printf().
> - Add missing CONFIG_SAVE_PREV_BL options to qcom_defconfig
> - Document known issue only affecting qcs404 where in the msm_sdhci driver
>   the xo_board clock somehow becomes associated with the qcom_clock device
>   resulting in qcs404_clk_set_rate() being called for clock id 0. This
>   doesn't seem to cause any issues but has proven somewhat elusive to debug.
> - Add a link to the APQ8016 TRM in doc/board/qualcomm/dragonboard410c.rst
> - Link to v3: https://lore.kernel.org/r/20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org
>
> Changes in v3:
> - Remove dragonboard410c.dts file
> - Introduce generic board_usb_init() function.
> - Remove db410c specific dead code (smem RAM layout)
> - Fix pinctrl DT compatibility for msm8916/msm8996
> - Reference git tag where DT and headers were taken from Linux.
> - Adjust ramdisk allocation size to 128M
> - Improve documentation wording, reference buildman
> - Fix mapping for reserved regions to avoid speculative pre-fetching
> - Apply quicksort to memory banks read from DT to ensure ordering
> - Link to v2: https://lore.kernel.org/r/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org
>
> Changes in v2:
> - Split DTS changes to reduce patch size.
> - Import full board DTS files from Linux too, and introduce -u-boot.dtsi
>   files where necessary to make any U-Boot specific changes.
> - Add a pinctrl driver for qcom PMIC GPIOs
> - Always enable LINUX_KERNEL_IMAGE_HEADER
> - Link to v1: https://lore.kernel.org/r/20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org
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
> Caleb Connolly (39):
>       arm: init: export prev_bl_fdt_addr
>       usb: dwc3-generic: support external vbus regulator
>       mmc: msm_sdhci: use modern clock handling
>       dt-bindings: drop msm_sdhci binding
>       clk/qcom: use upstream compatible properties
>       clock/qcom: qcs404: fix clk_set_rate
>       serial: msm: add debug UART
>       serial: msm: fix clock handling and pinctrl
>       gpio: qcom_pmic: 1-based GPIOs
>       gpio: qcom_pmic: add a quirk to skip GPIO configuration
>       gpio: qcom_pmic: add pinctrl driver
>       sandbox: dts: fix qcom pmic gpio
>       pinctrl: qcom: stub support for special GPIOs
>       pinctrl: qcom: fix DT compatibility
>       pinctrl: qcom: apq8016: init pre-reloaction
>       board: dragonboard410c: add chainloaded config fragment
>       board: dragonboard410c: upstream DT compat
>       board: dragonboard410c: import board code from mach-snapdragon
>       board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
>       mach-snapdragon: generalise board support
>       mach-snapdragon: dynamic load addresses
>       mach-snapdragon: generate fdtfile automatically
>       mach-snapdragon: carve out no-map regions
>       board: qcs404-evb: drop board code
>       doc: board/qualcomm: document generic targets
>       doc: board/qualcomm: link to APQ8016 TRM
>       dt-bindings: import headers for SDM845
>       dts: sdm845: import supporting dtsi files
>       dts: sdm845: replace with upstream DTS
>       dt-bindings: import headers for MSM8916
>       dts: msm8916: import PMIC dtsi files
>       dts: msm8916: replace with upstream DTS
>       dt-bindings: import headers for MSM8996
>       dts: msm8996: import PMIC dtsi files
>       dts: dragonboard820c: use correct bindings for clocks
>       dts: msm8996: replace with upstream DTS
>       dt-bindings: import headers for qcs404
>       dts: qcs404-evb: replace with upstream DT
>       MAINTAINERS: Qualcomm: add some missing paths
>
>  MAINTAINERS                                        |   12 +-
>  arch/arm/Kconfig                                   |    4 +
>  arch/arm/dts/Makefile                              |    9 +-
>  arch/arm/dts/apq8016-sbc-u-boot.dtsi               |   20 +
>  arch/arm/dts/apq8016-sbc.dts                       |  729 +++
>  arch/arm/dts/apq8096-db820c-u-boot.dtsi            |   14 +
>  arch/arm/dts/apq8096-db820c.dts                    | 1137 ++++
>  arch/arm/dts/dragonboard410c-uboot.dtsi            |   44 -
>  arch/arm/dts/dragonboard410c.dts                   |  209 -
>  arch/arm/dts/dragonboard820c-uboot.dtsi            |   32 -
>  arch/arm/dts/dragonboard820c.dts                   |  151 -
>  arch/arm/dts/dragonboard845c-uboot.dtsi            |   26 -
>  arch/arm/dts/dragonboard845c.dts                   |   48 -
>  arch/arm/dts/msm8916-pm8916.dtsi                   |  157 +
>  arch/arm/dts/msm8916.dtsi                          | 2702 +++++++++
>  arch/arm/dts/msm8996.dtsi                          | 3884 +++++++++++++
>  arch/arm/dts/pm8916.dtsi                           |  178 +
>  arch/arm/dts/pm8994.dtsi                           |  152 +
>  arch/arm/dts/pm8998.dtsi                           |  130 +
>  arch/arm/dts/pmi8994.dtsi                          |   65 +
>  arch/arm/dts/pmi8998.dtsi                          |   98 +
>  arch/arm/dts/pms405.dtsi                           |  149 +
>  arch/arm/dts/qcs404-evb-4000-u-boot.dtsi           |   48 +
>  arch/arm/dts/qcs404-evb-4000.dts                   |   96 +
>  arch/arm/dts/qcs404-evb-uboot.dtsi                 |   30 -
>  arch/arm/dts/qcs404-evb.dts                        |  390 --
>  arch/arm/dts/qcs404-evb.dtsi                       |  389 ++
>  arch/arm/dts/qcs404.dtsi                           | 1829 ++++++
>  arch/arm/dts/sdm845-db845c.dts                     | 1190 ++++
>  .../arm/dts/sdm845-samsung-starqltechn-u-boot.dtsi |   16 +
>  arch/arm/dts/sdm845-samsung-starqltechn.dts        |  460 ++
>  arch/arm/dts/sdm845-wcd9340.dtsi                   |   86 +
>  arch/arm/dts/sdm845.dtsi                           | 5801 +++++++++++++++++++-
>  arch/arm/dts/starqltechn-uboot.dtsi                |   27 -
>  arch/arm/dts/starqltechn.dts                       |   68 -
>  arch/arm/lib/save_prev_bl_data.c                   |    5 +
>  arch/arm/mach-snapdragon/Kconfig                   |   95 +-
>  arch/arm/mach-snapdragon/Makefile                  |    8 +-
>  arch/arm/mach-snapdragon/board.c                   |  468 ++
>  arch/arm/mach-snapdragon/dram.c                    |   99 -
>  arch/arm/mach-snapdragon/include/mach/dram.h       |   12 -
>  arch/arm/mach-snapdragon/include/mach/gpio.h       |    2 +
>  arch/arm/mach-snapdragon/include/mach/misc.h       |   13 -
>  arch/arm/mach-snapdragon/init_sdm845.c             |   73 -
>  arch/arm/mach-snapdragon/misc.c                    |   55 -
>  arch/arm/mach-snapdragon/sysmap-apq8016.c          |   31 -
>  arch/arm/mach-snapdragon/sysmap-apq8096.c          |   31 -
>  arch/arm/mach-snapdragon/sysmap-qcs404.c           |   43 -
>  arch/arm/mach-snapdragon/sysmap-sdm845.c           |   31 -
>  arch/sandbox/dts/sandbox.dtsi                      |    9 +-
>  board/qualcomm/dragonboard410c/Kconfig             |   15 -
>  board/qualcomm/dragonboard410c/Makefile            |    2 +-
>  .../dragonboard410c/configs/chainloaded.config     |    7 +
>  board/qualcomm/dragonboard410c/dragonboard410c.c   |  130 +-
>  board/qualcomm/dragonboard820c/Kconfig             |   15 -
>  board/qualcomm/dragonboard820c/Makefile            |    1 -
>  board/qualcomm/dragonboard820c/dragonboard820c.c   |   39 +-
>  board/qualcomm/dragonboard820c/head.S              |   33 -
>  board/qualcomm/dragonboard820c/u-boot.lds          |  111 -
>  board/qualcomm/dragonboard845c/Kconfig             |   12 -
>  board/qualcomm/qcs404-evb/Kconfig                  |   15 -
>  board/qualcomm/qcs404-evb/Makefile                 |    6 -
>  board/qualcomm/qcs404-evb/qcs404-evb.c             |   62 -
>  configs/dragonboard410c_defconfig                  |    8 +-
>  configs/dragonboard820c_defconfig                  |    8 +-
>  configs/dragonboard845c_defconfig                  |   29 -
>  configs/qcom_defconfig                             |   67 +
>  configs/qcs404evb_defconfig                        |   55 -
>  configs/starqltechn_defconfig                      |   41 -
>  doc/board/qualcomm/board.rst                       |  125 +
>  doc/board/qualcomm/debugging.rst                   |   61 +
>  doc/board/qualcomm/dragonboard410c.rst             |    2 +
>  doc/board/qualcomm/index.rst                       |    4 +-
>  doc/board/qualcomm/qcs404.rst                      |   79 -
>  doc/board/qualcomm/sdm845.rst                      |  167 -
>  doc/device-tree-bindings/mmc/msm_sdhci.txt         |   25 -
>  doc/device-tree-bindings/usb/ehci-msm.txt          |   10 -
>  drivers/clk/qcom/clock-apq8016.c                   |    9 +-
>  drivers/clk/qcom/clock-apq8096.c                   |    7 +-
>  drivers/clk/qcom/clock-qcs404.c                    |   25 +-
>  drivers/gpio/msm_gpio.c                            |   20 +
>  drivers/gpio/qcom_pmic_gpio.c                      |  275 +-
>  drivers/mmc/msm_sdhci.c                            |   69 +-
>  drivers/phy/qcom/msm8916-usbh-phy.c                |    4 +-
>  drivers/pinctrl/qcom/pinctrl-apq8016.c             |   29 +-
>  drivers/pinctrl/qcom/pinctrl-apq8096.c             |   16 +-
>  drivers/pinctrl/qcom/pinctrl-qcom.c                |   12 +
>  drivers/pinctrl/qcom/pinctrl-qcs404.c              |   58 +-
>  drivers/serial/Kconfig                             |    8 +
>  drivers/serial/serial_msm.c                        |   62 +-
>  drivers/usb/dwc3/dwc3-generic.c                    |   12 +
>  drivers/usb/host/ehci-msm.c                        |   22 +-
>  include/configs/dragonboard845c.h                  |   20 -
>  include/configs/qcom.h                             |   21 +
>  include/configs/qcs404-evb.h                       |   20 -
>  include/configs/sdm845.h                           |   26 -
>  include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
>  include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
>  include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   56 +
>  include/dt-bindings/clock/qcom,gcc-msm8916.h       |  179 +
>  include/dt-bindings/clock/qcom,gcc-msm8996.h       |  362 ++
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      |   24 +
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      |   15 +
>  include/dt-bindings/clock/qcom,mmcc-msm8996.h      |  295 +
>  include/dt-bindings/clock/qcom,rpmcc.h             |  174 +
>  include/dt-bindings/clock/qcom,rpmh.h              |   37 +
>  include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
>  include/dt-bindings/clock/qcom,videocc-sdm845.h    |   35 +
>  include/dt-bindings/dma/qcom-gpi.h                 |   11 +
>  include/dt-bindings/firmware/qcom,scm.h            |   39 +
>  include/dt-bindings/iio/qcom,spmi-vadc.h           |  300 +
>  include/dt-bindings/interconnect/qcom,msm8916.h    |  100 +
>  .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |   12 +
>  include/dt-bindings/interconnect/qcom,msm8996.h    |  163 +
>  include/dt-bindings/interconnect/qcom,osm-l3.h     |   15 +
>  include/dt-bindings/interconnect/qcom,sdm845.h     |  150 +
>  include/dt-bindings/phy/phy-qcom-qmp.h             |   20 +
>  include/dt-bindings/phy/phy-qcom-qusb2.h           |   37 +
>  include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |  164 +
>  include/dt-bindings/pinctrl/qcom,pmic-mpp.h        |  106 +
>  include/dt-bindings/power/qcom-rpmpd.h             |  412 ++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |   36 +
>  include/dt-bindings/reset/qcom,gcc-msm8916.h       |  100 +
>  include/dt-bindings/reset/qcom,sdm845-aoss.h       |   17 +
>  include/dt-bindings/reset/qcom,sdm845-pdc.h        |   22 +
>  include/dt-bindings/soc/qcom,apr.h                 |   28 +
>  include/dt-bindings/soc/qcom,rpmh-rsc.h            |   14 +
>  include/dt-bindings/sound/apq8016-lpass.h          |    9 +
>  include/dt-bindings/sound/qcom,lpass.h             |   46 +
>  include/dt-bindings/sound/qcom,q6afe.h             |    9 +
>  include/dt-bindings/sound/qcom,q6asm.h             |   26 +
>  include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |  234 +
>  include/dt-bindings/sound/qcom,wcd9335.h           |   15 +
>  include/init.h                                     |   11 +
>  134 files changed, 23997 insertions(+), 2643 deletions(-)
> ---
> base-commit: 22f391e8be11986bae824509470cf11e7bac31b0
>
> // Caleb (they/them)
>
