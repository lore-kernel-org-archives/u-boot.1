Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E632C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 05:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A3987D33;
	Wed,  6 Mar 2024 06:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lo9xOdLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD73487D7E; Wed,  6 Mar 2024 06:53:13 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF68387D25
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 06:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4725acb539cso1755530137.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 21:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709704389; x=1710309189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zemimyx6AXl/fNuOhDTi5WYJ8GXOLHVHhh621M9cJbw=;
 b=Lo9xOdLmUIkzz+Je4KwO3FCBNwm/mhL9dYLgu5NhCArRFX/d42JCkpQwQEusl7mqlN
 1GfOH0QCAfN5zEdO6ImyMOmhSFBAsFk1s7KHJMO/9MxBmYf7+YjieEOaF6X9+q28ikLs
 NuqgJ/Jtyo6EfYQTpg2XypRBrTUk0nd8dYeGmotrDJyHoZ0y6LS9AXZNiBPs2SY99N5c
 i6P1RwwkCpqsfPjaLuPeZkj9ekPsl/Ux7bBLt0ersJcyirM/q9qMq5TgFzyG+oHcdFjD
 GuP92Yp5FOyAQ9gBANJXca2AGP3FsFmdhcNRDA2CqS7Stg9DrgPrqlGFISP370eby41U
 Vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709704389; x=1710309189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zemimyx6AXl/fNuOhDTi5WYJ8GXOLHVHhh621M9cJbw=;
 b=EV0SP6rH3mAxrBvwBP2ALgRONLli4VnZXtP3jsqLRGzb4ORc/rvakvBzJ6xh4SGzp7
 oPMpx9sfue6gcfl/3GTj+V/MbC/OUTBJJVqJ9l2Eu+MVOBswvsO40VeLBVznP90BPFs5
 IzXXYGbVzbGJ/hJMdfS6X1TFcOHOZl+TCtUlGnIheg6RMTye526M/nU6a/t9Y+H0pl+q
 WLaWoT1xIH0WcYJuRdlX63qXfGkBP0TN2DSnwMG26THgGoxWFuhjR8GdkVI0yCLx/pzZ
 m456YuldjQ5eALbvteuIvx4HQRN12hN8NipNlT8tFwwFhiSM68Yc4HAWi6q2KAlHsRwz
 g6EA==
X-Gm-Message-State: AOJu0Yxs7f3KXgzvCUWxvax4qptoaZM2aNklpfVL9U/u4yAJrnv9au2T
 AHiE0W6lol6qeAThPPlDtPbQFmvniSYxADhUI37/PS7dL7qvgEuFY+hczB86YF4vXPvtMO+BAH6
 3b67qNQPlJw3ZSUJ/mcqTdYDRtbgIKPtzj4JHXA==
X-Google-Smtp-Source: AGHT+IE1XtwOxmmRkM9cbcRTU65SQ1ka3mxFV874fR8aaBLtBlCOBK/mc6zIrFCzsE65ZaMX/mo7oQRQkUEq6/wUm6s=
X-Received: by 2002:a67:b106:0:b0:472:e77a:dbb9 with SMTP id
 w6-20020a67b106000000b00472e77adbb9mr2004775vsl.10.1709704389535; Tue, 05 Mar
 2024 21:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 11:22:58 +0530
Message-ID: <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Volodymyr,

On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> SA8155P Automotive Development Platform is Qualcomm SA8155-based board
> for developers. The nice thing that it has unlocked loaders with test
> keys support, which means that U-Boot for this platform can be
> launched at earlier stages.
>
> This patch adds basic board support with only serial port and
> networking operation. I am using U-Boot to ease up Xen porting onto
> this board, so I am mostly interesting in booting U-Boot in EL2. But
> more conventional setup with Android boot image is supported as well.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>
> ---
>
> Changes in v2:
>  - Rebased onto qcom-next branch
>  - Removed unnecessary files thanks to generic qualcomm board support
>  - Enabled CONFIG_REMAKE_ELF (this removes one extra step in the
>    readme)

Thanks for the rebase.

>
>  arch/arm/dts/sa8155p-adp-u-boot.dtsi   | 30 +++++++++
>  board/qualcomm/sa8155p-adp/MAINTAINERS |  5 ++
>  configs/sa8155p_adp_defconfig          | 35 +++++++++++
>  doc/board/qualcomm/index.rst           |  1 +
>  doc/board/qualcomm/sa8155p-adp.rst     | 87 ++++++++++++++++++++++++++
>  5 files changed, 158 insertions(+)
>  create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
>  create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
>  create mode 100644 configs/sa8155p_adp_defconfig
>  create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
>
> diff --git a/arch/arm/dts/sa8155p-adp-u-boot.dtsi b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
> new file mode 100644
> index 0000000000..ffbf0933c7
> --- /dev/null
> +++ b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Qualcomm SA8155P-ADP device tree fixups for U-BOot
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + */
> +
> +/ {
> +       /* Populate memory node with actual memory configuration */
> +       memory@80000000 {
> +               reg = <0x00 0x80000000 0x00 0x39900000>,
> +               <0x02 0x0        0x1  0x7fd00000>,
> +               <0x00 0xC0000000 0x1  0x40000000>;
> +       };
> +};
> +
> +&ethernet {
> +       /* Ethernet driver tries to find reset by name */
> +       reset-names = "emac";

This deserves to be pushed upstream in Linux kernel DT. In the
meantime we can carry it here.

> +};
> +
> +&tlmm {
> +       /* U-Boot pinctrl driver does not understand multiple tiles */
> +       reg = <0x0 0x03000000 0x0 0x1000000>;
> +       /delete-property/ reg-names;

This won't be needed if we can make the tiles offset in the pinctrl
driver compatible:

#define WEST   0x00000000
#define EAST   0x00400000
#define NORTH  0x00800000
#define SOUTH  0x00C00000

> +
> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
> +       /delete-node/ phy-reset-pins;

I suppose this is not needed as phy-reset-pins also configures the pin
as GPIO only.

> +};
> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155p-adp/MAINTAINERS
> new file mode 100644
> index 0000000000..03fac84f51
> --- /dev/null
> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
> @@ -0,0 +1,5 @@
> +Qualcomm SA8155P Automotive Development Platform
> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> +S:     Maintained
> +F:     board/qualcomm/sa8155p-adp/
> +F:     configs/sa8155p-adp_defconfig
> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
> new file mode 100644
> index 0000000000..b6969767f8
> --- /dev/null
> +++ b/configs/sa8155p_adp_defconfig
> @@ -0,0 +1,35 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=19000000
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_TEXT_BASE=0x85710000

Being position independent shouldn't require a hardcoded U-Boot text
base. Can you try if we can get rid of this?

> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sa8155p-adp"
> +CONFIG_IDENT_STRING="\nQualcomm SA8155P-ADP"
> +CONFIG_SYS_LOAD_ADDR=0x85710000

Ditto.

> +CONFIG_REMAKE_ELF=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_SYS_CBSIZE=512
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM_SM8150=y
> +CONFIG_MSM_GPIO=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_SM8150=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SPMI_MSM=y
> +CONFIG_LMB_MAX_REGIONS=64

Apart from above, I think this platform should be able to reuse
qcom_defconfig as you can find most of the config options there. Can
you try to reuse it?

> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 4955274a39..268218b05f 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -7,5 +7,6 @@ Qualcomm
>     :maxdepth: 2
>
>     dragonboard410c
> +   sa8155p-adp
>     board
>     debugging
> diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8155p-adp.rst
> new file mode 100644
> index 0000000000..66db512b52
> --- /dev/null
> +++ b/doc/board/qualcomm/sa8155p-adp.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +.. sectionauthor:: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> +
> +SA8155P Automotive Development Platform
> +=======================================
> +
> +About
> +-----
> +This document describes the information about SA8155P Automotive
> +Development Platform aka SA8155P-ADP.
> +
> +Currently U-Boot can be booted either as Android boot image, or in EL2
> +mode, instead of hypervisor image. In the latter case it is possible
> +to use U-Boot to either boot Linux with KVM support or to boot Xen
> +Hypervisor on this board.
> +
> +Supported HW modules
> +^^^^^^^^^^^^^^^^^^^^
> +Port for this board is in early development state. Right now U-Boot
> +supports serial console and networking. No USB/fastboot or UFS support
> +yet. So it is not possible to save environment variables as
> +well. Nevertheless this is enough for development as user can download
> +all required images via TFTP.
> +
> +Installation
> +------------
> +Build
> +^^^^^
> +Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> +
> +       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +       $ make sa8155p_adp_defconfig
> +       $ make
> +
> +This will build ``u-boot.bin`` in the configured output directory.
> +
> +Boot in EL1 mode instead of Android boot image
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Create a dummy ramdisk image:::
> +
> +       $ echo "This is not a ramdisk" > ramdisk.img
> +
> +Compress u-boot binary:::
> +
> +       $ gzip -c u-boot.bin > u-boot.bin.gz
> +
> +Append DTB again (binary we use already have DTB embedded in, but
> +Android boot image format requires another DTB at the end of the
> +archive):::
> +
> +       $ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
> +
> +Now we've got everything to build android boot image:::
> +
> +       $ mkbootimg --kernel u-boot.bin.gz-dtb \
> +       --ramdisk ramdisk.img --pagesize 4096 \
> +       --base 0x80000000 -o boot.img
> +
> +Finally you can flash new boot image with fastboot:::
> +
> +       $ fastboot flash boot boot.img
> +
> +Or just boot U-Boot without flashing anything:::
> +
> +       $ fastboot boot boot.img
> +
> +Boot in EL2 mode instead of Qualcomm's hypervisor stub
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +This approach ensures that U-Boot is booted in EL2 and it is possible
> +to run virtualization software (like Xen or KVM) on the board. You
> +must understand that this approach breaks Qualcomm's boot chain. You
> +will not be able to call all subsequent loaders, so you will not be
> +able to use fastboot for example. Use this approach only if you want
> +to experiment with virtualization on SA8155P-ADP.
> +
> +U-Boot ELF file needs to be signed with test keys. `qtestsign
> +<https://github.com/msm8916-mainline/qtestsign>`_ tool can be used ::
> +
> +       $ ../qtestsign/qtestsign.py -v6 hyp u-boot.elf
> +
> +Resulting ``u-boot-test-signed.mbn`` then can be written to the
> +board. Easiest way is to use ``edl`` tool: ::
> +
> +       $ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=ufs --lun=4
> +

Can you provide reference to the EDL tool and its usage so that people
can recover their board if it gets bricked?

-Sumit

> +Be sure to backup existing hyp_a loader before flashing U-Boot.
> --
> 2.43.0
