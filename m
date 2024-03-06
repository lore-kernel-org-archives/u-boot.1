Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD27C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C89D877AF;
	Wed,  6 Mar 2024 15:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GiAl9pUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9207D8780A; Wed,  6 Mar 2024 15:29:13 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6FE876A4
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412f62edf25so4748275e9.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709735349; x=1710340149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/NseuMChl6bDFv6vPmtF+iZJfiCO3aRnOLwtXMuLAw=;
 b=GiAl9pURETHaetWK6ywx0ug1uF/T54e6J8tylEaz5BL08D6QofAhJD8nU5Bka82+xU
 hTl1+PSxtIAxr6h2D2ciV+SkkTZPfS3/c4B0PvGEQtNcn3sSJUq+Sr4QPIA8dc35QQPb
 0tvO2LEjXh+57PDRKLJ3Qf6pMPNJrsz6mZIy4qXUDIn8IQEf67kjcEl0d9ISqkZgHj77
 HPHRPA4AUMk+FHl9t6DnN+l5zqIQoZgYh1zplG0dHIRiIucPtOb/hzZU675L+z6+Akob
 MWvpa0pvT8eYvp4zRrvUKaNdpb6I/FPZnmGYe44uGINoGqusEtY5GGyf9MxMygJ3N0zQ
 MtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709735349; x=1710340149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/NseuMChl6bDFv6vPmtF+iZJfiCO3aRnOLwtXMuLAw=;
 b=Ge/fgGZvxCzzPQDbkjhJZgtlvO8wOzc/pF44q/ZL8jwwT4B0MuRDZiMt2vjLr2//H+
 Gxl+AGAIhOUZaCduzGUOYukAQfut6QaXtmq+0Or8I1rLkrPO0r0F0/taIlKQ5eqELBnZ
 yivAY4X4NrihVtqUlWjXiiXb28MTg+6yDAxeD6HrmKgUeLewsnHFFR8YN7JbOw9/2s/q
 W5dKQeF9PObegcBAL9sRd6zz/WZZsnGW31RZsPWddzD08dWM4UTv0mIIsQFIPDMCQmmN
 y9zBM9umsjwmlFYyNyCcX1BDn1D+1w9LvCieomBsPErGrGS0FkqKiJqAsyvz5tdrG3kW
 wvfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbcX5GNsIowYU9AyMJlr0pXaA5pFozd+hnri73znDJMH4u+H/KFoe33K2TfJDmzR/Xy3YszrLbE+p2ds1Yr8yJHI6dNQ==
X-Gm-Message-State: AOJu0Yxr0oAMiP/b1VyQymd4jMxsiEb/I/8zXbeTufeYhk4LqW1EtyvO
 TiZYPMA2/HvRA6egrvgVosNhI1BIdG1I/HWCtxY8oCuM3N/0gu3/ymw0mwkEITw=
X-Google-Smtp-Source: AGHT+IEjqHNXuULArKtgislJJWUcezc/p2+APD176ObG3pPb3Z3L1MOL/qd3s8mkLblQc7huyKR1AQ==
X-Received: by 2002:a05:600c:4e54:b0:412:f6f4:a542 with SMTP id
 e20-20020a05600c4e5400b00412f6f4a542mr1227294wmq.19.1709735349218; 
 Wed, 06 Mar 2024 06:29:09 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a05600c4f4b00b00413011933e6sm399256wmq.39.2024.03.06.06.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 06:29:08 -0800 (PST)
Message-ID: <dc8683c5-b27c-4119-b86e-591743a467cd@linaro.org>
Date: Wed, 6 Mar 2024 14:29:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 06/03/2024 00:53, Volodymyr Babchuk wrote:
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
> +	/* Populate memory node with actual memory configuration */
> +	memory@80000000 {
> +		reg = <0x00 0x80000000 0x00 0x39900000>,
> +		<0x02 0x0        0x1  0x7fd00000>,
> +		<0x00 0xC0000000 0x1  0x40000000>;
> +	};
> +};
> +
> +&ethernet {
> +	/* Ethernet driver tries to find reset by name */
> +	reset-names = "emac";
> +};
> +
> +&tlmm {
> +	/* U-Boot pinctrl driver does not understand multiple tiles */
> +	reg = <0x0 0x03000000 0x0 0x1000000>;
could you follow the other pinctrl drivers and just define the tile
offsets relative to the first tile specified in DT? Otherwise every
sm8150 board will need this DTS hack. Fixing this in the driver would
also make it possible to use the same DT to boot Linux which is quite
useful.
> +	/delete-property/ reg-names;
There's no need to drop this property, and Linux depends on it.

With those changes:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> +
> +	/* U-Boot ethernet driver wants to drive reset as GPIO */
> +	/delete-node/ phy-reset-pins;
> +};
> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155p-adp/MAINTAINERS
> new file mode 100644
> index 0000000000..03fac84f51
> --- /dev/null
> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
> @@ -0,0 +1,5 @@
> +Qualcomm SA8155P Automotive Development Platform
> +M:	Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> +S:	Maintained
> +F:	board/qualcomm/sa8155p-adp/
> +F:	configs/sa8155p-adp_defconfig
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
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sa8155p-adp"
> +CONFIG_IDENT_STRING="\nQualcomm SA8155P-ADP"
> +CONFIG_SYS_LOAD_ADDR=0x85710000
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
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make sa8155p_adp_defconfig
> +	$ make
> +
> +This will build ``u-boot.bin`` in the configured output directory.
> +
> +Boot in EL1 mode instead of Android boot image
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Create a dummy ramdisk image:::
> +
> +	$ echo "This is not a ramdisk" > ramdisk.img
> +
> +Compress u-boot binary:::
> +
> +	$ gzip -c u-boot.bin > u-boot.bin.gz
> +
> +Append DTB again (binary we use already have DTB embedded in, but
> +Android boot image format requires another DTB at the end of the
> +archive):::
> +
> +	$ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
> +
> +Now we've got everything to build android boot image:::
> +
> +	$ mkbootimg --kernel u-boot.bin.gz-dtb \
> +	--ramdisk ramdisk.img --pagesize 4096 \
> +	--base 0x80000000 -o boot.img
> +
> +Finally you can flash new boot image with fastboot:::
> +
> +	$ fastboot flash boot boot.img
> +
> +Or just boot U-Boot without flashing anything:::
> +
> +	$ fastboot boot boot.img
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
> +	$ ../qtestsign/qtestsign.py -v6 hyp u-boot.elf
> +
> +Resulting ``u-boot-test-signed.mbn`` then can be written to the
> +board. Easiest way is to use ``edl`` tool: ::
> +
> +	$ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=ufs --lun=4
> +
> +Be sure to backup existing hyp_a loader before flashing U-Boot.

-- 
// Caleb (they/them)
