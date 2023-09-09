Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3610BEEB589
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 11:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F8F68669D;
	Sat,  9 Sep 2023 13:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CWHr+4IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC7186906; Sat,  9 Sep 2023 13:29:32 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32D6867EA
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 13:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3FEAAB8069E;
 Sat,  9 Sep 2023 11:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E7DC433C7;
 Sat,  9 Sep 2023 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694258968;
 bh=26pBKH9gGSgtzPDjAsgNNjUMHAEE7WFPA9ToDvsbC7U=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=CWHr+4ICQ46ZxR/kIVPjSU/joNqRGDkOHCGjVxBxpguSgQPJ9ebZja5ReNUMrdePf
 1C7mCpGulHHUMDN7xCXLSIIwmprTnOdv/UQ6uPI4pDuAR8nzglPh/kg3pPor8H1Dw5
 aES5MOTq4jx2PxaxKRTbP7dsSIG1jXpHhiAhASBHKZ7ngRkPUsMyM0zApDgeKiwhyv
 vBKVbfKEdvl1JZOBDcfheiYgqr+d2mvYOhWkr/itC1Y0Qdzwd2m3GFdiO7TIiFXWWx
 iQWoyYRCvvATys3t/xFnzn2tS8Sg3bR4/6l0M9wQXo+yqoNL7gIXzPiAw+IaJVu+LN
 qQ7TDKd/dPjHg==
Message-ID: <9bc5aa14-b03c-d2d0-947c-692a200db996@kernel.org>
Date: Sat, 9 Sep 2023 14:29:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 08/16] board: ti: j784s4: Add board support for J784S4
 EVM
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jason Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-9-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230908110551.861575-9-a-nandan@ti.com>
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



On 08/09/2023 14:05, Apurva Nandan wrote:
> Add board files for J784S4 EVM.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add env and board specific yaml files for binman ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ cleaned up the env files ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig         |    1 +
>  board/ti/j784s4/Kconfig          |   63 +
>  board/ti/j784s4/MAINTAINERS      |   20 +
>  board/ti/j784s4/Makefile         |    8 +
>  board/ti/j784s4/board-cfg.yaml   |   36 +
>  board/ti/j784s4/evm.c            |   87 +
>  board/ti/j784s4/j784s4.env       |   35 +
>  board/ti/j784s4/pm-cfg.yaml      |   12 +
>  board/ti/j784s4/rm-cfg.yaml      | 3057 ++++++++++++++++++++++++++++++
>  board/ti/j784s4/sec-cfg.yaml     |  379 ++++
>  board/ti/j784s4/tifs-rm-cfg.yaml | 2655 ++++++++++++++++++++++++++
>  include/configs/j784s4_evm.h     |   20 +
>  12 files changed, 6373 insertions(+)
>  create mode 100644 board/ti/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/MAINTAINERS
>  create mode 100644 board/ti/j784s4/Makefile
>  create mode 100644 board/ti/j784s4/board-cfg.yaml
>  create mode 100644 board/ti/j784s4/evm.c
>  create mode 100644 board/ti/j784s4/j784s4.env
>  create mode 100644 board/ti/j784s4/pm-cfg.yaml
>  create mode 100644 board/ti/j784s4/rm-cfg.yaml
>  create mode 100644 board/ti/j784s4/sec-cfg.yaml
>  create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>  create mode 100644 include/configs/j784s4_evm.h
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 0af2ec6ddb..ba3dd393e3 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -197,4 +197,5 @@ source "board/ti/j721e/Kconfig"
>  source "board/siemens/iot2050/Kconfig"
>  source "board/ti/j721s2/Kconfig"
>  source "board/toradex/verdin-am62/Kconfig"
> +source "board/ti/j784s4/Kconfig"
>  endif
> diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
> new file mode 100644
> index 0000000000..7eeb21f451
> --- /dev/null
> +++ b/board/ti/j784s4/Kconfig
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> +#	Hari Nagalla <hnagalla@ti.com>
> +
> +choice
> +	prompt "K3 J784S4 board"
> +	optional
> +
> +config TARGET_J784S4_A72_EVM
> +	bool "TI K3 based J784S4 EVM running on A72"
> +	select ARM64
> +	select SOC_K3_J784S4
> +	select BOARD_LATE_INIT
> +	select SYS_DISABLE_DCACHE_OPS
> +	select BINMAN
> +
> +config TARGET_J784S4_R5_EVM
> +	bool "TI K3 based J784S4 EVM running on R5"
> +	select CPU_V7R
> +	select SYS_THUMB_BUILD
> +	select SOC_K3_J784S4
> +	select K3_LOAD_SYSFW
> +	select RAM
> +	select SPL_RAM
> +	select K3_DDRSS
> +	select BINMAN
> +	imply SYS_K3_SPL_ATF
> +
> +endchoice
> +
> +if TARGET_J784S4_A72_EVM
> +
> +config SYS_BOARD
> +       default "j784s4"
> +
> +config SYS_VENDOR
> +       default "ti"
> +
> +config SYS_CONFIG_NAME
> +       default "j784s4_evm"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
> +
> +if TARGET_J784S4_R5_EVM
> +
> +config SYS_BOARD
> +       default "j784s4"
> +
> +config SYS_VENDOR
> +       default "ti"
> +
> +config SYS_CONFIG_NAME
> +       default "j784s4_evm"
> +
> +config SPL_LDSCRIPT
> +	default "arch/arm/mach-omap2/u-boot-spl.lds"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
> new file mode 100644
> index 0000000000..7d3549dd31
> --- /dev/null
> +++ b/board/ti/j784s4/MAINTAINERS
> @@ -0,0 +1,20 @@
> +J784S4 BOARD
> +M:	Hari Nagalla <hnagalla@ti.com>
> +S:	Maintained
> +F:	board/ti/j784s4
> +F:	arch/arm/mach-k3/j784s4
> +F:	include/configs/j784s4_evm.h
> +F:	configs/j784s4_evm_r5_defconfig
> +F:	configs/j784s4_evm_a72_defconfig
> +F:	arch/arm/dts/k3-j784s4.dtsi
> +F:	arch/arm/dts/k3-j784s4-main.dtsi
> +F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
> +F:	arch/arm/dts/k3-j784s4-thermal.dtsi
> +F:	arch/arm/dts/k3-j784s4-evm.dts
> +F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +F:	arch/arm/dts/k3-j784s4-r5-evm.dts
> +F:	arch/arm/dts/k3-j784s4-ddr.dtsi
> +F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
> +F:	arch/arm/dts/k3-am69-sk.dts
> +F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +F:	arch/arm/dts/k3-am69-r5-sk.dts

These 3 files are not part of J724S4 EVM.

-- 
cheers,
-roger
