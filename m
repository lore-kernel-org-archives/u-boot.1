Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D141C61CE2
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 11:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F8080DD1;
	Mon, 24 Aug 2026 11:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKZNvBiVHUpF; Mon, 24 Aug 2026 11:10:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787569810;
	bh=5J5qH8A5YI3Zt0U7lhBOriUepOLaBx4VVIEnsxDAjas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adNtHDeuTkMkNz7BvssY0RZ1hp70WPl7Xz7fZDfeFJxAJpAoIvDuJbo+utlmIfu5f
	 LoH0EUxZOQGc96mMardgw5ilA89uLVwIGa2HKvZvqRDEBI+fwmiLtVh6SfVYP5OFw7
	 yrQJYVyGIs8mlxIrUVHUsB0rgCukB7hZbQw/Yqs2+jGAvp/jlIH6n3AlxgXTseS7vu
	 SCzOPV3eVfb6eh2ApXmjpyqnQwVkeKSvvpruAZgIJqAsIqLAReGw20D/nlop49sTsQ
	 O3fBFPtunB0PbmyXncqcotPzUCe5TdStQquBDExQ6HciHxg4c3AmzBKzbikemNT4PW
	 MSbsNTPazsiWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73D7880CEA;
	Mon, 24 Aug 2026 11:10:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 190443DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9762400F6
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPYvmqURcYp1 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 11:10:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a03:4000:b:d08:14a9:1bff:fedc:75ad; helo=mail.kernel-space.org;
 envelope-from=angelo@kernel-space.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=kernel-space.org header.i=@kernel-space.org
 header.a=rsa-sha256 header.s=s1 header.b=f6EBR8iV
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F00E940077
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1787569803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J5qH8A5YI3Zt0U7lhBOriUepOLaBx4VVIEnsxDAjas=;
 b=f6EBR8iVM/PJUzplP2sqDKaScrSYtIbQkoo8cAE+zKwRQQf40NKMz9VB+KEj+8f0oD7uvS
 yoqqEPHCwo/NCTwQSCuQVmaNqBdeg0pXja/s2y/UNGls/46h5VL6Q+WvBl3iJZn08F7n0u
 rRmaf75tqFArApXK37XFgiOV5IQUcQA=
Received: from [192.168.0.2] (host93-7-32-195.dimensionesrl.eu [195.32.7.93])
 by oreshnik (OpenSMTPD) with ESMTPSA id ca261e45
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 24 Aug 2026 11:10:02 +0000 (UTC)
Message-ID: <f7c4c39c-f45b-4a02-922f-4d1474c14cc2@kernel-space.org>
Date: Mon, 24 Aug 2026 13:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com
Cc: Andre Przywara <andre.przywara@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Michal,

thanks a lot, i should do it for m68k.

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 8/24/26 10:32, Michal Simek wrote:
> There are 5 domains which no longer exist. Remove all email addresses that
> reference them. Where such an address was the board's only maintainer, mark
> the board as Orphan.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> This was the way how to find if domain doesn't exist.
> 
> git ls-files '*MAINTAINERS' 'MAINTAINERS' \
>   | xargs grep -hoE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' \
>   | sed 's/.*@//' | tr 'A-Z' 'a-z' | sort -u \
>   | while IFS= read -r dom; do
>       if [ -z "$(dig +short MX "$dom")" ] && [ -z "$(dig +short A "$dom")" ]; then
>         echo "$dom"
>       fi
>     done
> 
> ---
>  MAINTAINERS                                          | 1 -
>  arch/arm/dts/sun9i-a80-cx-a99.dts                    | 2 +-
>  arch/arm/include/asm/arch-lpc32xx/gpio.h             | 2 +-
>  arch/arm/include/asm/arch-lpc32xx/mux.h              | 2 +-
>  arch/arm/mach-lpc32xx/dram.c                         | 2 +-
>  arch/arm/mach-lpc32xx/lowlevel_init.S                | 2 +-
>  arch/m68k/cpu/mcf530x/Makefile                       | 2 +-
>  arch/m68k/cpu/mcf530x/cpu.c                          | 2 +-
>  arch/m68k/cpu/mcf530x/cpu_init.c                     | 2 +-
>  arch/m68k/cpu/mcf530x/interrupts.c                   | 2 +-
>  arch/m68k/cpu/mcf530x/speed.c                        | 2 +-
>  arch/m68k/cpu/mcf530x/start.S                        | 2 +-
>  arch/m68k/cpu/mcf5445x/dspi.c                        | 2 +-
>  arch/m68k/cpu/u-boot.lds                             | 2 +-
>  arch/m68k/dts/M5208EVBE.dts                          | 2 +-
>  arch/m68k/dts/M5235EVB.dts                           | 2 +-
>  arch/m68k/dts/M5235EVB_Flash32.dts                   | 2 +-
>  arch/m68k/dts/M5249EVB.dts                           | 2 +-
>  arch/m68k/dts/M5253DEMO.dts                          | 2 +-
>  arch/m68k/dts/M5272C3.dts                            | 2 +-
>  arch/m68k/dts/M5275EVB.dts                           | 2 +-
>  arch/m68k/dts/M5282EVB.dts                           | 2 +-
>  arch/m68k/dts/M53017EVB.dts                          | 2 +-
>  arch/m68k/dts/M5329AFEE.dts                          | 2 +-
>  arch/m68k/dts/M5329BFEE.dts                          | 2 +-
>  arch/m68k/dts/M5373EVB.dts                           | 2 +-
>  arch/m68k/dts/amcore.dts                             | 2 +-
>  arch/m68k/dts/cobra5272.dts                          | 2 +-
>  arch/m68k/dts/eb_cpu5282.dts                         | 2 +-
>  arch/m68k/dts/eb_cpu5282_internal.dts                | 2 +-
>  arch/m68k/dts/mcf5208.dtsi                           | 2 +-
>  arch/m68k/dts/mcf523x.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5249.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5253.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5271.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5272.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5275.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5282.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5301x.dtsi                          | 2 +-
>  arch/m68k/dts/mcf5307.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5329.dtsi                           | 2 +-
>  arch/m68k/dts/mcf537x.dtsi                           | 2 +-
>  arch/m68k/dts/mcf5441x.dtsi                          | 2 +-
>  arch/m68k/dts/mcf54xx.dtsi                           | 2 +-
>  arch/m68k/dts/stmark2.dts                            | 2 +-
>  arch/m68k/include/asm/immap_5307.h                   | 2 +-
>  arch/m68k/include/asm/m5307.h                        | 2 +-
>  board/embest/mx6boards/MAINTAINERS                   | 3 +--
>  board/embest/mx6boards/mx6boards.c                   | 2 +-
>  board/phytec/pcm052/MAINTAINERS                      | 3 +--
>  board/sunxi/MAINTAINERS                              | 3 +--
>  board/sysam/amcore/MAINTAINERS                       | 3 +--
>  board/sysam/amcore/Makefile                          | 2 +-
>  board/sysam/amcore/amcore.c                          | 2 +-
>  board/sysam/stmark2/MAINTAINERS                      | 3 +--
>  board/sysam/stmark2/Makefile                         | 2 +-
>  board/sysam/stmark2/sbf_dram_init.S                  | 2 +-
>  board/sysam/stmark2/stmark2.c                        | 2 +-
>  board/work-microwave/work_92105/MAINTAINERS          | 3 +--
>  board/work-microwave/work_92105/Makefile             | 2 +-
>  board/work-microwave/work_92105/work_92105.c         | 2 +-
>  board/work-microwave/work_92105/work_92105_display.c | 2 +-
>  board/work-microwave/work_92105/work_92105_display.h | 2 +-
>  board/work-microwave/work_92105/work_92105_spl.c     | 2 +-
>  cmd/dfu.c                                            | 2 +-
>  cmd/gpt.c                                            | 2 +-
>  common/dfu.c                                         | 2 +-
>  doc/README.dfutftp                                   | 2 +-
>  doc/git-mailrc                                       | 1 -
>  drivers/dfu/dfu_alt.c                                | 2 +-
>  drivers/gpio/lpc32xx_gpio.c                          | 2 +-
>  drivers/i2c/lpc32xx_i2c.c                            | 2 +-
>  drivers/mtd/nand/raw/lpc32xx_nand_mlc.c              | 2 +-
>  drivers/serial/serial_mcf.c                          | 4 ++--
>  drivers/spi/cf_spi.c                                 | 2 +-
>  drivers/usb/host/ohci-hcd.c                          | 2 +-
>  include/configs/amcore.h                             | 2 +-
>  include/configs/bk4r1.h                              | 2 +-
>  include/configs/embestmx6boards.h                    | 2 +-
>  include/configs/stmark2.h                            | 2 +-
>  include/configs/work_92105.h                         | 2 +-
>  include/dm/platform_data/serial_coldfire.h           | 2 +-
>  include/dm/platform_data/spi_coldfire.h              | 2 +-
>  scripts/get_default_envs.sh                          | 2 +-
>  tools/lpc32xximage.c                                 | 2 +-
>  tools/vybridimage.c                                  | 2 +-
>  86 files changed, 85 insertions(+), 93 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e655790433ab..06369c6bb593 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1400,7 +1400,6 @@ S:	Maintained
>  F:	drivers/net/phy/nxp-c45-tja11xx.c
>  
>  ONENAND
> -#M:	Lukasz Majewski <l.majewski@majess.pl>
>  S:	Orphan (Since 2017-01)
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.git
>  F:	drivers/mtd/onenand/
> diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-cx-a99.dts
> index cf126bbd2c57..0642161ec969 100644
> --- a/arch/arm/dts/sun9i-a80-cx-a99.dts
> +++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
> @@ -1,7 +1,7 @@
>  /*
>   * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
>   *
> - * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
> + * Copyright (C) 2017 Rask Ingemann Lambertsen
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual
> diff --git a/arch/arm/include/asm/arch-lpc32xx/gpio.h b/arch/arm/include/asm/arch-lpc32xx/gpio.h
> index 93e7a8875215..103c0219c194 100644
> --- a/arch/arm/include/asm/arch-lpc32xx/gpio.h
> +++ b/arch/arm/include/asm/arch-lpc32xx/gpio.h
> @@ -3,7 +3,7 @@
>   * LPC32xx GPIO interface
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  /**
> diff --git a/arch/arm/include/asm/arch-lpc32xx/mux.h b/arch/arm/include/asm/arch-lpc32xx/mux.h
> index d661e8236f32..ec69a5da2feb 100644
> --- a/arch/arm/include/asm/arch-lpc32xx/mux.h
> +++ b/arch/arm/include/asm/arch-lpc32xx/mux.h
> @@ -3,7 +3,7 @@
>   * LPC32xx MUX interface
>   *
>   * (C) Copyright 2015  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  /**
> diff --git a/arch/arm/mach-lpc32xx/dram.c b/arch/arm/mach-lpc32xx/dram.c
> index ab7c13512a5a..a311455cd4d7 100644
> --- a/arch/arm/mach-lpc32xx/dram.c
> +++ b/arch/arm/mach-lpc32xx/dram.c
> @@ -3,7 +3,7 @@
>   * LPC32xx dram init
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * This is called by SPL to gain access to the SDR DRAM.
>   *
> diff --git a/arch/arm/mach-lpc32xx/lowlevel_init.S b/arch/arm/mach-lpc32xx/lowlevel_init.S
> index d42da2bc5672..55c47c5a433b 100644
> --- a/arch/arm/mach-lpc32xx/lowlevel_init.S
> +++ b/arch/arm/mach-lpc32xx/lowlevel_init.S
> @@ -3,7 +3,7 @@
>   * WORK Microwave work_92105 board low level init
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * Low level init is called from SPL to set up the clocks.
>   * On entry, the LPC3250 is in Direct Run mode with all clocks
> diff --git a/arch/m68k/cpu/mcf530x/Makefile b/arch/m68k/cpu/mcf530x/Makefile
> index 6bd7cd3591dc..4e2f4b1e8409 100644
> --- a/arch/m68k/cpu/mcf530x/Makefile
> +++ b/arch/m68k/cpu/mcf530x/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
> -# (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> +# (C) Copyright 2014  Angelo Dureghello
>  
>  extra-y	= start.o
>  obj-y	= interrupts.o cpu.o speed.o cpu_init.o
> diff --git a/arch/m68k/cpu/mcf530x/cpu.c b/arch/m68k/cpu/mcf530x/cpu.c
> index 92a0ef76895c..88ab9726ecd5 100644
> --- a/arch/m68k/cpu/mcf530x/cpu.c
> +++ b/arch/m68k/cpu/mcf530x/cpu.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/arch/m68k/cpu/mcf530x/cpu_init.c b/arch/m68k/cpu/mcf530x/cpu_init.c
> index 8f6e668d103a..e0f8179815dd 100644
> --- a/arch/m68k/cpu/mcf530x/cpu_init.c
> +++ b/arch/m68k/cpu/mcf530x/cpu_init.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/arch/m68k/cpu/mcf530x/interrupts.c b/arch/m68k/cpu/mcf530x/interrupts.c
> index 99cf86385037..27196fa0566e 100644
> --- a/arch/m68k/cpu/mcf530x/interrupts.c
> +++ b/arch/m68k/cpu/mcf530x/interrupts.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/arch/m68k/cpu/mcf530x/speed.c b/arch/m68k/cpu/mcf530x/speed.c
> index 6542fc43ab10..afcc9d2d7f83 100644
> --- a/arch/m68k/cpu/mcf530x/speed.c
> +++ b/arch/m68k/cpu/mcf530x/speed.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/arch/m68k/cpu/mcf530x/start.S b/arch/m68k/cpu/mcf530x/start.S
> index 552e0204b771..47cf3e7e08e2 100644
> --- a/arch/m68k/cpu/mcf530x/start.S
> +++ b/arch/m68k/cpu/mcf530x/start.S
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * (C) Copyright 2015  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2015  Angelo Dureghello
>   * Based on code from Bernhard Kuhn <bkuhn@metrowerks.com>
>   */
>  
> diff --git a/arch/m68k/cpu/mcf5445x/dspi.c b/arch/m68k/cpu/mcf5445x/dspi.c
> index 13eb6ecee101..f45264e5d167 100644
> --- a/arch/m68k/cpu/mcf5445x/dspi.c
> +++ b/arch/m68k/cpu/mcf5445x/dspi.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2019
> - * Angelo Dureghello <angleo@sysam.it>
> + * Angelo Dureghello
>   *
>   * CPU specific dspi routines
>   */
> diff --git a/arch/m68k/cpu/u-boot.lds b/arch/m68k/cpu/u-boot.lds
> index 452003ff43cb..5d1cae52afb9 100644
> --- a/arch/m68k/cpu/u-boot.lds
> +++ b/arch/m68k/cpu/u-boot.lds
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2000
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   * (C) Copyright 2015
> - * Angelo Dureghello, Sysam Firmware, angelo@sysam.it
> + * Angelo Dureghello, Sysam Firmware
>   */
>  
>  #include <config.h>
> diff --git a/arch/m68k/dts/M5208EVBE.dts b/arch/m68k/dts/M5208EVBE.dts
> index ec203e8b698a..d27cacd29adc 100644
> --- a/arch/m68k/dts/M5208EVBE.dts
> +++ b/arch/m68k/dts/M5208EVBE.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5235EVB.dts b/arch/m68k/dts/M5235EVB.dts
> index e8b22c921669..0194a864aef3 100644
> --- a/arch/m68k/dts/M5235EVB.dts
> +++ b/arch/m68k/dts/M5235EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5235EVB_Flash32.dts b/arch/m68k/dts/M5235EVB_Flash32.dts
> index 60b28c07f766..05dc9b08cfe9 100644
> --- a/arch/m68k/dts/M5235EVB_Flash32.dts
> +++ b/arch/m68k/dts/M5235EVB_Flash32.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5249EVB.dts b/arch/m68k/dts/M5249EVB.dts
> index 84ba4f188b47..d26bc751eb5d 100644
> --- a/arch/m68k/dts/M5249EVB.dts
> +++ b/arch/m68k/dts/M5249EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5253DEMO.dts b/arch/m68k/dts/M5253DEMO.dts
> index a3f070661ea9..41d5d165af27 100644
> --- a/arch/m68k/dts/M5253DEMO.dts
> +++ b/arch/m68k/dts/M5253DEMO.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5272C3.dts b/arch/m68k/dts/M5272C3.dts
> index a22893790720..189a61b795ae 100644
> --- a/arch/m68k/dts/M5272C3.dts
> +++ b/arch/m68k/dts/M5272C3.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5275EVB.dts b/arch/m68k/dts/M5275EVB.dts
> index d79f8a788579..9cc3e23c062e 100644
> --- a/arch/m68k/dts/M5275EVB.dts
> +++ b/arch/m68k/dts/M5275EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5282EVB.dts b/arch/m68k/dts/M5282EVB.dts
> index 51788f9654ab..2e3656757b5e 100644
> --- a/arch/m68k/dts/M5282EVB.dts
> +++ b/arch/m68k/dts/M5282EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M53017EVB.dts b/arch/m68k/dts/M53017EVB.dts
> index 90851dd0af43..38d049268226 100644
> --- a/arch/m68k/dts/M53017EVB.dts
> +++ b/arch/m68k/dts/M53017EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5329AFEE.dts b/arch/m68k/dts/M5329AFEE.dts
> index c1cd2845a387..b441c56ec07d 100644
> --- a/arch/m68k/dts/M5329AFEE.dts
> +++ b/arch/m68k/dts/M5329AFEE.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5329BFEE.dts b/arch/m68k/dts/M5329BFEE.dts
> index 51ec4b5d1aa9..eeb89dae1e4f 100644
> --- a/arch/m68k/dts/M5329BFEE.dts
> +++ b/arch/m68k/dts/M5329BFEE.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/M5373EVB.dts b/arch/m68k/dts/M5373EVB.dts
> index 27ce800caeb2..101ddc77f7a1 100644
> --- a/arch/m68k/dts/M5373EVB.dts
> +++ b/arch/m68k/dts/M5373EVB.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/amcore.dts b/arch/m68k/dts/amcore.dts
> index d43202a3ab4b..bfb7f5bbe064 100644
> --- a/arch/m68k/dts/amcore.dts
> +++ b/arch/m68k/dts/amcore.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/cobra5272.dts b/arch/m68k/dts/cobra5272.dts
> index 2b5767d96d1d..cf1b91630560 100644
> --- a/arch/m68k/dts/cobra5272.dts
> +++ b/arch/m68k/dts/cobra5272.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/eb_cpu5282.dts b/arch/m68k/dts/eb_cpu5282.dts
> index 27f33b9f9002..72059dcec426 100644
> --- a/arch/m68k/dts/eb_cpu5282.dts
> +++ b/arch/m68k/dts/eb_cpu5282.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/eb_cpu5282_internal.dts b/arch/m68k/dts/eb_cpu5282_internal.dts
> index 53a94ea7f759..385b2d910105 100644
> --- a/arch/m68k/dts/eb_cpu5282_internal.dts
> +++ b/arch/m68k/dts/eb_cpu5282_internal.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/dts/mcf5208.dtsi b/arch/m68k/dts/mcf5208.dtsi
> index c61dbf355701..3a465d842ca9 100644
> --- a/arch/m68k/dts/mcf5208.dtsi
> +++ b/arch/m68k/dts/mcf5208.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf523x.dtsi b/arch/m68k/dts/mcf523x.dtsi
> index cae7b4f86166..fc7493951504 100644
> --- a/arch/m68k/dts/mcf523x.dtsi
> +++ b/arch/m68k/dts/mcf523x.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5249.dtsi b/arch/m68k/dts/mcf5249.dtsi
> index d45d5532cafa..1900c99de210 100644
> --- a/arch/m68k/dts/mcf5249.dtsi
> +++ b/arch/m68k/dts/mcf5249.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5253.dtsi b/arch/m68k/dts/mcf5253.dtsi
> index b9816f4754be..9df57f9562ed 100644
> --- a/arch/m68k/dts/mcf5253.dtsi
> +++ b/arch/m68k/dts/mcf5253.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5271.dtsi b/arch/m68k/dts/mcf5271.dtsi
> index 5acf6994af36..c9d4ab244cd2 100644
> --- a/arch/m68k/dts/mcf5271.dtsi
> +++ b/arch/m68k/dts/mcf5271.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5272.dtsi b/arch/m68k/dts/mcf5272.dtsi
> index 173baaba3f2b..bba88c43c47b 100644
> --- a/arch/m68k/dts/mcf5272.dtsi
> +++ b/arch/m68k/dts/mcf5272.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5275.dtsi b/arch/m68k/dts/mcf5275.dtsi
> index 3df17b445c4d..4d19db6f75b2 100644
> --- a/arch/m68k/dts/mcf5275.dtsi
> +++ b/arch/m68k/dts/mcf5275.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2019 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2019 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5282.dtsi b/arch/m68k/dts/mcf5282.dtsi
> index 640c1a32e41b..409d796b301e 100644
> --- a/arch/m68k/dts/mcf5282.dtsi
> +++ b/arch/m68k/dts/mcf5282.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5301x.dtsi b/arch/m68k/dts/mcf5301x.dtsi
> index a13afad093ad..f9d7e5ee73a0 100644
> --- a/arch/m68k/dts/mcf5301x.dtsi
> +++ b/arch/m68k/dts/mcf5301x.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5307.dtsi b/arch/m68k/dts/mcf5307.dtsi
> index d6d386b22e13..117eb4f60783 100644
> --- a/arch/m68k/dts/mcf5307.dtsi
> +++ b/arch/m68k/dts/mcf5307.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5329.dtsi b/arch/m68k/dts/mcf5329.dtsi
> index 991985e48cf8..36d35ed5b46d 100644
> --- a/arch/m68k/dts/mcf5329.dtsi
> +++ b/arch/m68k/dts/mcf5329.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf537x.dtsi b/arch/m68k/dts/mcf537x.dtsi
> index 4fa0f4bc3dad..f6bc0debf470 100644
> --- a/arch/m68k/dts/mcf537x.dtsi
> +++ b/arch/m68k/dts/mcf537x.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf5441x.dtsi b/arch/m68k/dts/mcf5441x.dtsi
> index 7cd6072d4a5d..c0aa16939800 100644
> --- a/arch/m68k/dts/mcf5441x.dtsi
> +++ b/arch/m68k/dts/mcf5441x.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/mcf54xx.dtsi b/arch/m68k/dts/mcf54xx.dtsi
> index e9cebb9f742b..f2f5f8531293 100644
> --- a/arch/m68k/dts/mcf54xx.dtsi
> +++ b/arch/m68k/dts/mcf54xx.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  / {
> diff --git a/arch/m68k/dts/stmark2.dts b/arch/m68k/dts/stmark2.dts
> index 8e196fa65ffb..405c1357b377 100644
> --- a/arch/m68k/dts/stmark2.dts
> +++ b/arch/m68k/dts/stmark2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   */
>  
>  /dts-v1/;
> diff --git a/arch/m68k/include/asm/immap_5307.h b/arch/m68k/include/asm/immap_5307.h
> index d96dd146efb0..8b9cb3aee0d1 100644
> --- a/arch/m68k/include/asm/immap_5307.h
> +++ b/arch/m68k/include/asm/immap_5307.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/arch/m68k/include/asm/m5307.h b/arch/m68k/include/asm/m5307.h
> index 67547d2dd9d9..b7ca681ec3ec 100644
> --- a/arch/m68k/include/asm/m5307.h
> +++ b/arch/m68k/include/asm/m5307.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2014  Angelo Dureghello
>   *
>   */
>  
> diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/MAINTAINERS
> index 0ffd4668b42d..6c9d590c4b77 100644
> --- a/board/embest/mx6boards/MAINTAINERS
> +++ b/board/embest/mx6boards/MAINTAINERS
> @@ -1,6 +1,5 @@
>  MX6BOARDS BOARD
> -M:	Eric Bénard <eric@eukrea.com>
> -S:	Maintained
> +S:	Orphan
>  F:	board/embest/mx6boards/
>  F:	include/configs/embestmx6boards.h
>  F:	configs/marsboard_defconfig
> diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
> index 5ed41d01d9ba..0269259269e5 100644
> --- a/board/embest/mx6boards/mx6boards.c
> +++ b/board/embest/mx6boards/mx6boards.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2014 Eukréa Electromatique
> - * Author: Eric Bénard <eric@eukrea.com>
> + * Author: Eric Bénard
>   *         Fabio Estevam <fabio.estevam@freescale.com>
>   *         Jon Nettleton <jon.nettleton@gmail.com>
>   *
> diff --git a/board/phytec/pcm052/MAINTAINERS b/board/phytec/pcm052/MAINTAINERS
> index 66fe06e49c0b..4883e2ff4d6e 100644
> --- a/board/phytec/pcm052/MAINTAINERS
> +++ b/board/phytec/pcm052/MAINTAINERS
> @@ -1,6 +1,5 @@
>  PCM052 BOARD
> -M:	Albert ARIBAUD (3ADEV) <albert.aribaud@3adev.fr>
> -S:	Maintained
> +S:	Orphan
>  F:	board/phytec/pcm052/
>  F:	include/configs/bk4r1.h
>  F:	include/configs/pcm052.h
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 91ca165fab97..bce412c5f389 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -570,8 +570,7 @@ S:	Maintained
>  F:	configs/sopine_baseboard_defconfig
>  
>  SUNCHIP CX-A99 BOARD
> -M:	Rask Ingemann Lambertsen <rask@formelder.dk>
> -S:	Maintained
> +S:	Orphan
>  F:	configs/Sunchip_CX-A99_defconfig
>  W:	https://linux-sunxi.org/Sunchip_CX-A99
>  
> diff --git a/board/sysam/amcore/MAINTAINERS b/board/sysam/amcore/MAINTAINERS
> index fe5dd9bf39c7..86ef47080767 100644
> --- a/board/sysam/amcore/MAINTAINERS
> +++ b/board/sysam/amcore/MAINTAINERS
> @@ -1,6 +1,5 @@
>  AMCORE BOARD
> -M:	Angelo Dureghello <angelo@sysam.it>
> -S:	Maintained
> +S:	Orphan
>  F:	board/sysam/amcore/
>  F:	include/configs/amcore.h
>  F:      configs/amcore_defconfig
> diff --git a/board/sysam/amcore/Makefile b/board/sysam/amcore/Makefile
> index 051186f0d5cb..29b9bab12aad 100644
> --- a/board/sysam/amcore/Makefile
> +++ b/board/sysam/amcore/Makefile
> @@ -1,5 +1,5 @@
>  #
> -# (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> +# (C) Copyright 2014  Angelo Dureghello
>  #
>  # SPDX-License-Identifier:     GPL-2.0+
>  #
> diff --git a/board/sysam/amcore/amcore.c b/board/sysam/amcore/amcore.c
> index d5aa1f0776fd..6800a22ab136 100644
> --- a/board/sysam/amcore/amcore.c
> +++ b/board/sysam/amcore/amcore.c
> @@ -2,7 +2,7 @@
>  /*
>   * Board functions for Sysam AMCORE (MCF5307 based) board
>   *
> - * (C) Copyright 2016  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2016  Angelo Dureghello
>   *
>   * This file copies memory testdram() from sandburst/common/sb_common.c
>   */
> diff --git a/board/sysam/stmark2/MAINTAINERS b/board/sysam/stmark2/MAINTAINERS
> index b87f432bb3f2..afe6d171c5f1 100644
> --- a/board/sysam/stmark2/MAINTAINERS
> +++ b/board/sysam/stmark2/MAINTAINERS
> @@ -1,6 +1,5 @@
>  STMARK2 BOARD
> -M:	Angelo Dureghello <angelo@sysam.it>
> -S:	Maintained
> +S:	Orphan
>  F:	board/sysam/stmark2/
>  F:	include/configs/stmark2.h
>  F:	configs/stmark2_defconfig
> diff --git a/board/sysam/stmark2/Makefile b/board/sysam/stmark2/Makefile
> index 064a57ea05ec..19e4aa266fa4 100644
> --- a/board/sysam/stmark2/Makefile
> +++ b/board/sysam/stmark2/Makefile
> @@ -1,5 +1,5 @@
>  #
> -# (C) Copyright 2014  Angelo Dureghello <angelo@sysam.it>
> +# (C) Copyright 2014  Angelo Dureghello
>  #
>  # SPDX-License-Identifier:     GPL-2.0+
>  #
> diff --git a/board/sysam/stmark2/sbf_dram_init.S b/board/sysam/stmark2/sbf_dram_init.S
> index b6f38731f11e..8334e2e3b1d0 100644
> --- a/board/sysam/stmark2/sbf_dram_init.S
> +++ b/board/sysam/stmark2/sbf_dram_init.S
> @@ -2,7 +2,7 @@
>  /*
>   * Board-specific early ddr/sdram init.
>   *
> - * (C) Copyright 2017 Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2017 Angelo Dureghello
>   */
>  
>  .equ	PPMCR0,		0xfc04002d
> diff --git a/board/sysam/stmark2/stmark2.c b/board/sysam/stmark2/stmark2.c
> index 7818f2671d5a..b85907868547 100644
> --- a/board/sysam/stmark2/stmark2.c
> +++ b/board/sysam/stmark2/stmark2.c
> @@ -2,7 +2,7 @@
>  /*
>   * Board-specific init.
>   *
> - * (C) Copyright 2017 Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2017 Angelo Dureghello
>   */
>  
>  #include <config.h>
> diff --git a/board/work-microwave/work_92105/MAINTAINERS b/board/work-microwave/work_92105/MAINTAINERS
> index 29a92c5ffe26..e81a90cb7be9 100644
> --- a/board/work-microwave/work_92105/MAINTAINERS
> +++ b/board/work-microwave/work_92105/MAINTAINERS
> @@ -1,6 +1,5 @@
>  WORK_92105 BOARD
> -M:	Albert ARIBAUD <albert.aribaud@3adev.fr>
> -S:	Maintained
> +S:	Orphan
>  F:	board/work-microwave/work_92105/
>  F:	include/configs/work_92105.h
>  F:	configs/work_92105_defconfig
> diff --git a/board/work-microwave/work_92105/Makefile b/board/work-microwave/work_92105/Makefile
> index a96098d0f2a5..e63901a0c2b1 100644
> --- a/board/work-microwave/work_92105/Makefile
> +++ b/board/work-microwave/work_92105/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # (C) Copyright 2014  DENX Software Engineering GmbH
> -# Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> +# Written-by: Albert ARIBAUD
>  
>  ifdef CONFIG_XPL_BUILD
>  obj-y	+= work_92105_spl.o
> diff --git a/board/work-microwave/work_92105/work_92105.c b/board/work-microwave/work_92105/work_92105.c
> index 9a236880e3cc..641c1cd0e6fa 100644
> --- a/board/work-microwave/work_92105/work_92105.c
> +++ b/board/work-microwave/work_92105/work_92105.c
> @@ -3,7 +3,7 @@
>   * WORK Microwave work_92105 board support
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  #include <config.h>
> diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
> index d4ab2299895d..0cc4272e8841 100644
> --- a/board/work-microwave/work_92105/work_92105_display.c
> +++ b/board/work-microwave/work_92105/work_92105_display.c
> @@ -3,7 +3,7 @@
>   * work_92105 display support
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * The work_92105 display is a HD44780-compatible module
>   * controlled through a MAX6957AAX SPI port expander, two
> diff --git a/board/work-microwave/work_92105/work_92105_display.h b/board/work-microwave/work_92105/work_92105_display.h
> index 17a9aa04e022..be67d929c750 100644
> --- a/board/work-microwave/work_92105/work_92105_display.h
> +++ b/board/work-microwave/work_92105/work_92105_display.h
> @@ -3,7 +3,7 @@
>   * work_92105 display support interface
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * The work_92105 display is a HD44780-compatible module
>   * controlled through a MAX6957AAX SPI port expander, two
> diff --git a/board/work-microwave/work_92105/work_92105_spl.c b/board/work-microwave/work_92105/work_92105_spl.c
> index 3f91221ce8b1..bc841e979b18 100644
> --- a/board/work-microwave/work_92105/work_92105_spl.c
> +++ b/board/work-microwave/work_92105/work_92105_spl.c
> @@ -3,7 +3,7 @@
>   * WORK Microwave work_92105 board support
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  #include <asm/io.h>
> diff --git a/cmd/dfu.c b/cmd/dfu.c
> index 46f0190588e0..b571137c1aa9 100644
> --- a/cmd/dfu.c
> +++ b/cmd/dfu.c
> @@ -3,7 +3,7 @@
>   * cmd_dfu.c -- dfu command
>   *
>   * Copyright (C) 2015
> - * Lukasz Majewski <l.majewski@majess.pl>
> + * Lukasz Majewski
>   *
>   * Copyright (C) 2012 Samsung Electronics
>   * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 205f696c8072..abbfc0fe46ae 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -3,7 +3,7 @@
>   * cmd_gpt.c -- GPT (GUID Partition Table) handling command
>   *
>   * Copyright (C) 2015
> - * Lukasz Majewski <l.majewski@majess.pl>
> + * Lukasz Majewski
>   *
>   * Copyright (C) 2012 Samsung Electronics
>   * author: Lukasz Majewski <l.majewski@samsung.com>
> diff --git a/common/dfu.c b/common/dfu.c
> index 1af8194139c3..341fd7ca7812 100644
> --- a/common/dfu.c
> +++ b/common/dfu.c
> @@ -3,7 +3,7 @@
>   * dfu.c -- dfu command
>   *
>   * Copyright (C) 2015
> - * Lukasz Majewski <l.majewski@majess.pl>
> + * Lukasz Majewski
>   *
>   * Copyright (C) 2012 Samsung Electronics
>   * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> diff --git a/doc/README.dfutftp b/doc/README.dfutftp
> index b25f398ee2e0..184dec50f975 100644
> --- a/doc/README.dfutftp
> +++ b/doc/README.dfutftp
> @@ -2,7 +2,7 @@
>  #
>  #  Copyright (C) 2015
>  #
> -#  Lukasz Majewski <l.majewski@majess.pl>
> +#  Lukasz Majewski
>  
>  Device Firmware Upgrade (DFU) - extension to use TFTP
>  =====================================================
> diff --git a/doc/git-mailrc b/doc/git-mailrc
> index 62d457e6bb35..dc230ee78d5d 100644
> --- a/doc/git-mailrc
> +++ b/doc/git-mailrc
> @@ -17,7 +17,6 @@ alias ag             Anatolij Gustschin <ag.dev.uboot@gmail.com>
>  alias agraf          Alexander Graf <agraf@csgraf.de>
>  alias alexnemirovsky Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
>  alias alisonwang     Alison Wang <alison.wang@nxp.com>
> -alias angelo_ts      Angelo Dureghello <angelo@sysam.it>
>  alias apritzel       Andre Przywara <andre.przywara@arm.com>
>  alias bmeng          Bin Meng <bmeng.cn@gmail.com>
>  alias danielschwierzeck Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
> index e9132936a90b..8d2e85856e5d 100644
> --- a/drivers/dfu/dfu_alt.c
> +++ b/drivers/dfu/dfu_alt.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2015
> - * Lukasz Majewski <l.majewski@majess.pl>
> + * Lukasz Majewski
>   */
>  
>  #include <log.h>
> diff --git a/drivers/gpio/lpc32xx_gpio.c b/drivers/gpio/lpc32xx_gpio.c
> index 2b537e007ba9..9c35f45d5487 100644
> --- a/drivers/gpio/lpc32xx_gpio.c
> +++ b/drivers/gpio/lpc32xx_gpio.c
> @@ -3,7 +3,7 @@
>   * LPC32xxGPIO driver
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  #include <asm/io.h>
> diff --git a/drivers/i2c/lpc32xx_i2c.c b/drivers/i2c/lpc32xx_i2c.c
> index a4e42e64a9b8..31fdea7c4054 100644
> --- a/drivers/i2c/lpc32xx_i2c.c
> +++ b/drivers/i2c/lpc32xx_i2c.c
> @@ -3,7 +3,7 @@
>   * LPC32xx I2C interface driver
>   *
>   * (C) Copyright 2014-2015  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD - 3ADEV <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD - 3ADEV
>   */
>  
>  #include <config.h>
> diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
> index 7779e63fa5d1..d9b05aa42fbc 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
> @@ -3,7 +3,7 @@
>   * LPC32xx MLC NAND flash controller driver
>   *
>   * (C) Copyright 2014 3ADEV <http://3adev.com>
> - * Written by Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written by Albert ARIBAUD
>   *
>   * NOTE:
>   *
> diff --git a/drivers/serial/serial_mcf.c b/drivers/serial/serial_mcf.c
> index 76143575fa98..94de25fde1e3 100644
> --- a/drivers/serial/serial_mcf.c
> +++ b/drivers/serial/serial_mcf.c
> @@ -4,10 +4,10 @@
>   * TsiChung Liew, Tsi-Chung.Liew@freescale.com.
>   *
>   * Modified to add device model (DM) support
> - * (C) Copyright 2015  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2015  Angelo Dureghello
>   *
>   * Modified to add DM and fdt support, removed non DM code
> - * (C) Copyright 2018  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2018  Angelo Dureghello
>   */
>  
>  /*
> diff --git a/drivers/spi/cf_spi.c b/drivers/spi/cf_spi.c
> index 84077c01d836..03100c0715b8 100644
> --- a/drivers/spi/cf_spi.c
> +++ b/drivers/spi/cf_spi.c
> @@ -8,7 +8,7 @@
>   * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
>   *
>   * Support for DM and DT, non-DM code removed.
> - * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
> + * Copyright (C) 2018 Angelo Dureghello
>   *
>   * TODO: fsl_dspi.c should work as a driver for the DSPI module.
>   */
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 3fcf9d53d598..761da36acb23 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -16,7 +16,7 @@
>   * (C) Copyright 2000-2002 David Brownell
>   *
>   * Modified for the MP2USB by (C) Copyright 2005 Eric Benard
> - * ebenard@eukrea.com - based on s3c24x0's driver
> + * based on s3c24x0's driver
>   */
>  /*
>   * IMPORTANT NOTES
> diff --git a/include/configs/amcore.h b/include/configs/amcore.h
> index 4c695fb9df99..4d7ed9a48b13 100644
> --- a/include/configs/amcore.h
> +++ b/include/configs/amcore.h
> @@ -2,7 +2,7 @@
>  /*
>   * Sysam AMCORE board configuration
>   *
> - * (C) Copyright 2016  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2016  Angelo Dureghello
>   */
>  
>  #ifndef __AMCORE_CONFIG_H
> diff --git a/include/configs/bk4r1.h b/include/configs/bk4r1.h
> index 4a0b9edf4579..ba81c04eee55 100644
> --- a/include/configs/bk4r1.h
> +++ b/include/configs/bk4r1.h
> @@ -4,7 +4,7 @@
>   * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
>   *
>   * Copyright 2016 3ADEV <http://3adev.com>
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * Configuration settings for BK4R1.
>   */
> diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
> index 61c0d755a8d9..1d398a4e4a02 100644
> --- a/include/configs/embestmx6boards.h
> +++ b/include/configs/embestmx6boards.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright (C) 2014 Eukréa Electromatique
> - * Author: Eric Bénard <eric@eukrea.com>
> + * Author: Eric Bénard
>   *
>   * Configuration settings for the Embest RIoTboard
>   *
> diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
> index c10963983590..98b4b8c2f6ab 100644
> --- a/include/configs/stmark2.h
> +++ b/include/configs/stmark2.h
> @@ -2,7 +2,7 @@
>  /*
>   * Sysam stmark2 board configuration
>   *
> - * (C) Copyright 2017  Angelo Dureghello <angelo@sysam.it>
> + * (C) Copyright 2017  Angelo Dureghello
>   */
>  
>  #ifndef __STMARK2_CONFIG_H
> diff --git a/include/configs/work_92105.h b/include/configs/work_92105.h
> index f1a7853a80e6..6c4f57f61b5c 100644
> --- a/include/configs/work_92105.h
> +++ b/include/configs/work_92105.h
> @@ -3,7 +3,7 @@
>   * WORK Microwave work_92105 board configuration file
>   *
>   * (C) Copyright 2014  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  #ifndef __CONFIG_WORK_92105_H__
> diff --git a/include/dm/platform_data/serial_coldfire.h b/include/dm/platform_data/serial_coldfire.h
> index 5e265e9087d9..ff8afe82dd66 100644
> --- a/include/dm/platform_data/serial_coldfire.h
> +++ b/include/dm/platform_data/serial_coldfire.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Copyright (c) 2015  Angelo Dureghello <angelo@sysam.it>
> + * Copyright (c) 2015  Angelo Dureghello
>   */
>  
>  #ifndef __serial_coldfire_h
> diff --git a/include/dm/platform_data/spi_coldfire.h b/include/dm/platform_data/spi_coldfire.h
> index 0d534b1d6654..152e144419b4 100644
> --- a/include/dm/platform_data/spi_coldfire.h
> +++ b/include/dm/platform_data/spi_coldfire.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Copyright (c) 2018  Angelo Dureghello <angelo@sysam.it>
> + * Copyright (c) 2018  Angelo Dureghello
>   */
>  
>  #ifndef __spi_coldfire_h
> diff --git a/scripts/get_default_envs.sh b/scripts/get_default_envs.sh
> index fedf7206fe12..b2432bb88d28 100755
> --- a/scripts/get_default_envs.sh
> +++ b/scripts/get_default_envs.sh
> @@ -1,7 +1,7 @@
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0+
>  #
> -# Copyright (C) 2016, Lukasz Majewski <l.majewski@majess.pl>
> +# Copyright (C) 2016, Lukasz Majewski
>  #
>  
>  # This file extracts default envs from built u-boot
> diff --git a/tools/lpc32xximage.c b/tools/lpc32xximage.c
> index 715a55a5b5b3..52e96bb3df42 100644
> --- a/tools/lpc32xximage.c
> +++ b/tools/lpc32xximage.c
> @@ -3,7 +3,7 @@
>   * Image manipulator for LPC32XX SoCs
>   *
>   * (C) Copyright 2015  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   *
>   * Derived from omapimage.c:
>   *
> diff --git a/tools/vybridimage.c b/tools/vybridimage.c
> index c38886fa9039..7177e78d74c2 100644
> --- a/tools/vybridimage.c
> +++ b/tools/vybridimage.c
> @@ -5,7 +5,7 @@
>   * Derived from vybridimage.c
>   *
>   * (C) Copyright 2016  DENX Software Engineering GmbH
> - * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
> + * Written-by: Albert ARIBAUD
>   */
>  
>  #include "imagetool.h"
> ---
> base-commit: c8c1345985d4b1a566e1297b62cf6159d0803a68
> branch: xnext/maintainers-all
> 

-- Angelo

