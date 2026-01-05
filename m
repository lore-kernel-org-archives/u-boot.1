Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ECFC79F89
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0E883E0E;
	Mon,  5 Jan 2026 14:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="roo0wIaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9171983CE3; Mon,  5 Jan 2026 13:19:25 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9AE839DD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 13:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinguyen@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3947243572;
 Mon,  5 Jan 2026 12:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBB9C116D0;
 Mon,  5 Jan 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767615561;
 bh=MWCtKk94steEnFXuCm1rJZMCjcI6chevVRVkQxB5bbM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=roo0wIaLB6D3cjWHQ9I+rhJWqbqnNHPL1uiXEpSeyRcCt3IlDDrVKdtVLtb1TNbQv
 8eSsp1aLJtx2dOhNIpfmRIDEf7XoJenh+nDmkt3sdzs8FTWvcbw1iYxRlYAhldUTss
 xqSOJd6GACJs5oSChxagaRsg7c4Do3/Wi+ry+TEiG0hifWaI2XJ+g9Bv1X0vXkgxoc
 eiAmHWehpxPMZzjoH49XIY58dqIagggtigPNuvnk/PsTC6NdcspXagWR5bMPCJ2j/0
 2AxLZz9a6wRiajg9R6ub8goIUUVaMqzNRD6oMcYAr3kU+cR/KAu5E90DmLwXRwmt5c
 pM7ExOx9XCS8w==
Message-ID: <7b6d2042-d29e-4647-ab54-05cec24c1974@kernel.org>
Date: Mon, 5 Jan 2026 06:19:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Add CoreCourse socfpga Board - AC501
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
References: <20251229153354.5558-1-briansune@gmail.com>
 <20251229153354.5558-2-briansune@gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251229153354.5558-2-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

Hi Brian,

On 12/29/25 09:33, Brian Sune wrote:
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
> 
> [1] https://corecourse.cn/forum.php?mod=viewthread&tid=27704&highlight=AC501
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   2 +
>   arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  86 +++
>   .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
>   arch/arm/mach-socfpga/Kconfig                 |  14 +
>   board/corecourse/ac501soc/MAINTAINERS         |   6 +
>   board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac501soc_defconfig            |  85 +++
>   include/configs/socfpga_ac501soc.h            |  16 +
>   11 files changed, 1574 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
>   create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
>   create mode 100644 board/corecourse/ac501soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac501soc_defconfig
>   create mode 100644 include/configs/socfpga_ac501soc.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index fcad6fb2fc7..40a69a13c4b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -468,6 +468,8 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_socrates.dtb			\
>   	socfpga_cyclone5_sr1500.dtb			\
>   	socfpga_cyclone5_vining_fpga.dtb		\
> +	socfpga_cyclone5_ac501soc.dtb			\
> +	socfpga_cyclone5_ac550soc.dtb			\

You should include the build for the ac550 board in the AC550 patch.

>   	socfpga_n5x_socdk.dtb				\
>   	socfpga_stratix10_socdk.dtb
>   
> diff --git a/arch/arm/dts/socfpga_cyclone5_ac501soc.dts b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> new file mode 100644
> index 00000000000..2c11e2088e3
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025, Brian Sune
> + *

<snip>

> +
> +&portc {
> +	bank-name = "portc";
> +};
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..69af0b48348 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -239,6 +239,14 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
>   	bool "Terasic SoCkit (Cyclone V)"
>   	select TARGET_SOCFPGA_CYCLONE5
>   
> +config TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +	bool "CoreCourse AC501SoC (Cyclone V)"
> +	select TARGET_SOCFPGA_CYCLONE5
> +
> +config TARGET_SOCFPGA_CORECOURSE_AC550SOC
> +	bool "CoreCourse AC550SoC (Cyclone V)"
> +	select TARGET_SOCFPGA_CYCLONE5
> +
>   endchoice
>   
>   config SYS_BOARD
> @@ -263,6 +271,8 @@ config SYS_BOARD
>   	default "sr1500" if TARGET_SOCFPGA_SR1500
>   	default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>   	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +	default "ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +	default "ac550soc" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
>   
>   config SYS_VENDOR
>   	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
> @@ -284,6 +294,8 @@ config SYS_VENDOR
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
> +	default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +	default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
>   
>   config SYS_SOC
>   	default "socfpga"
> @@ -310,5 +322,7 @@ config SYS_CONFIG_NAME
>   	default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
>   	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>   	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +	default "socfpga_ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +	default "socfpga_ac550soc" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
>   

Same comment...

Dinh
