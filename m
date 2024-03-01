Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3A9C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 14:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B70488130;
	Fri,  1 Mar 2024 15:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RqAr1g+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A28A88130; Fri,  1 Mar 2024 15:51:31 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED57487DCC
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 15:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-472751180f6so694713137.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 06:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709304685; x=1709909485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e0oeADaISJsPnnzbzMj+MQlszzVJRtACSdt1fEVGDII=;
 b=RqAr1g+MBbmv4qpbWyqQ5taOlDk6q5TfFUOXC++JHdz8Gis13uSQLbbyr4RMQFm5mv
 R/t0RIMOyVfAd2jFUEwnOwloG5Km036nqkCltbjMUHz3RwZLN5i9KEuIOahljvQfcIWo
 vFDVymSAgceCgkm4JjKtycEqul2ScUjBA03Zfv6TzFkmpDpfZEeM83tPt2kWisiykE5n
 aHMRm6532yokM1Ygnts24zKqWViSkr972PMiRFhVyUWP3zKFRWVqmzer22Gbgaey3Kpg
 OAuq0rwWywxI0q9B6WnwJ1QuHSjwyN/gxj54XDnGqtvGMEkugf3l5Q8PYfSfjVvz6599
 G1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709304685; x=1709909485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0oeADaISJsPnnzbzMj+MQlszzVJRtACSdt1fEVGDII=;
 b=o6dK0GoOx8XAw5/r27dWC6/tcBGMpT88OEZHMhLlCJbBo723M0b3gHpfVdGHhi5fgG
 W3Q2XXq73gAft22YnVsfu8kzcPl8JH0gW64urwmrw/Vd76eMRl3b158sm515bK6wWG4j
 7Tx5+2rtSR2bPhWiBWmWSNoM07PNfWlii/jRjCn1toqloJrCtB64MNPds+IpUjRuVq16
 XEaRMQdyijseaE6+9v7T/itYSR0xGgYdGE16ZVuhlBJKP6L4Hfn7IcZlIaxmTsn+lYun
 i1O78P7ygR/cUGGwctc3itanZGle3laGElurotKvd47w4eQocd+83Ojkp5joxw1auFrs
 KNCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL2Px+mNJNGS3l5Gf0fGktrNb26ww6pzSJeQk7wYZ9Ps6FMKkho3zXxD7NTZs5Cmk43/iOSER7njmdu2Fg4LQVVKhggQ==
X-Gm-Message-State: AOJu0YwnToSZbaib9QWhdFXJmJX2O6YCNkYmCBxRdjiIpek0fuQ9Isfw
 dnwtXrmJ9HNZ7HUOfbC72k85sjr2t94oqXnfa8fcSGZzrscxVQNUAmmfhcuy00SaS+CD0BOf+cN
 o48roJfwLg9oy0GKcZbJBcQdqZrflpChKrS69JA==
X-Google-Smtp-Source: AGHT+IGEu47W7rb3bEeH+s1NpmjeWuTwaL3ifat5eKlgSHA/GwMTniDigvU9Kb6e8K7/HYrgfPgsIqXSA0qxgE58r6A=
X-Received: by 2002:a05:6102:5f74:b0:472:7058:c45a with SMTP id
 ix20-20020a0561025f7400b004727058c45amr1426846vsb.9.1709304684790; Fri, 01
 Mar 2024 06:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 20:21:13 +0530
Message-ID: <CAFA6WYNXE3x8sKRB8BBpODCfXbZeeVpKPu0-qt7ezsY-R7unQQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/39] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 26 Feb 2024 at 22:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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

I suppose we are just in time for this as the OF_UPSTREAM work has
been merged into U-Boot next branch [1]. Can you rebase this patch-set
on top of that? I suppose many of the DT import patches won't be
needed at all.

[1] https://source.denx.de/u-boot/u-boot/-/commits/next/?ref_type=heads

-Sumit

>
> ---
> I have tested this series on the Dragonboard410c, Dragonboard820c, and
> Dragonboard845c. Sumit has tested this on the db410c and QCS404 EVB
> board.
>
> ---
> Changes in v5:
> - Adjust msm_sdhci clock handling patch to have clearer error handling based on feedback from Dan.
> - Adjust dwc3 vbus-supply patch to be more readable and handle error
>   paths better based on feedback from Jonas.
> - Add a helper function for determining if a pin is "special" in the
>   pinctrl/gpio drivers, set special_pins_start for all SoCs and avoid
>   modifying const driver data at runtime.
> - Add a comment to clarify that the pmic gpio readonly quirk is a
>   workaround and not expected behaviour for the platforms where it's
>   necessary.
> - Link to v4: https://lore.kernel.org/r/20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org
>
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
>  arch/arm/mach-snapdragon/include/mach/gpio.h       |    7 +
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
>  drivers/gpio/qcom_pmic_gpio.c                      |  277 +-
>  drivers/mmc/msm_sdhci.c                            |   69 +-
>  drivers/phy/qcom/msm8916-usbh-phy.c                |    4 +-
>  drivers/pinctrl/qcom/pinctrl-apq8016.c             |   34 +-
>  drivers/pinctrl/qcom/pinctrl-apq8096.c             |   21 +-
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c             |    5 +-
>  drivers/pinctrl/qcom/pinctrl-qcom.c                |   12 +
>  drivers/pinctrl/qcom/pinctrl-qcs404.c              |   64 +-
>  drivers/pinctrl/qcom/pinctrl-sdm845.c              |    5 +-
>  drivers/serial/Kconfig                             |    8 +
>  drivers/serial/serial_msm.c                        |   62 +-
>  drivers/usb/dwc3/dwc3-generic.c                    |   24 +-
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
>  136 files changed, 24033 insertions(+), 2652 deletions(-)
> ---
> base-commit: 1a66a7768af7e8106c2cd93a19f4013877fb85ae
>
> // Caleb (they/them)
>
