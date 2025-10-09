Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C21CCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 10:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8E3844E4;
	Thu,  9 Oct 2025 12:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="izmORPTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEC4844EC; Thu,  9 Oct 2025 12:46:44 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB4E844DE
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 531F525F1B;
 Thu,  9 Oct 2025 12:46:42 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iz5sLhZWmPwF; Thu,  9 Oct 2025 12:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760006801; bh=59hujK09DDn7PEcVgCootsHsEphjhvHwTnGJT/PaBu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=izmORPTVRaaGdAX0WMn7ARZoPLy2uBd3DU3P9/9UpSnMEj9NUo0RylBhRcYePp5zB
 gOcQBVhzH6wVF0uzJlulHRT3Xy/az0Q9VlsxzWqqRubTrYfH3zjpzSR528Igs8jG1U
 YUydBdVbfGhs5ZYUfbdHPnI34mfD4zoKp/x3hzpM27Rs/DKSJTNxZ/NlzzgF3qrH/3
 /9yFyG4LUV3krPorQmltDeficfJqQ/BD2tq6j8+f4ggCk0o4WXZyxjASz+SNTp0f+h
 nRshnXwUQYf7pZ6jO5vt27UOLPcP0BEyatSOdSTRBELzB0VmrvV+QTGHjSz5ieiFv9
 d7lowixdleWDw==
Date: Thu, 9 Oct 2025 10:46:35 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v4 02/10] board: boston-riscv: Add initial support for
 P8700 Boston board
Message-ID: <aOeSiyNupfNaKqfH@pie>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-3-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819103021.1518687-3-uros.stajic@htecgroup.com>
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

On Tue, Aug 19, 2025 at 10:32:00AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Implement initial board-level support for the P8700 Boston SoC.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/Kconfig                      |  10 +
>  arch/riscv/cpu/p8700/Kconfig            |   2 +-
>  arch/riscv/dts/Makefile                 |   1 +
>  arch/riscv/dts/boston-p8700.dts         | 263 ++++++++++++++++++++++++
>  board/mips/boston-riscv/Kconfig         |  43 ++++
>  board/mips/boston-riscv/MAINTAINERS     |   9 +
>  board/mips/boston-riscv/Makefile        |   8 +
>  board/mips/boston-riscv/boston-lcd.h    |  20 ++
>  board/mips/boston-riscv/boston-regs.h   |  38 ++++
>  board/mips/boston-riscv/boston-riscv.c  |   9 +
>  board/mips/boston-riscv/checkboard.c    |  43 ++++
>  board/mips/boston-riscv/config.mk       |  15 ++
>  board/mips/boston-riscv/lowlevel_init.S |  18 ++
>  board/mips/boston-riscv/reset.c         |  15 ++
>  configs/boston-p8700_defconfig          |  94 +++++++++
>  drivers/clk/Kconfig                     |   2 +-
>  include/asm-generic/global_data.h       |   5 +
>  include/configs/boston-riscv.h          |  11 +
>  18 files changed, 604 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/dts/boston-p8700.dts
>  create mode 100644 board/mips/boston-riscv/Kconfig
>  create mode 100644 board/mips/boston-riscv/MAINTAINERS
>  create mode 100644 board/mips/boston-riscv/Makefile
>  create mode 100644 board/mips/boston-riscv/boston-lcd.h
>  create mode 100644 board/mips/boston-riscv/boston-regs.h
>  create mode 100644 board/mips/boston-riscv/boston-riscv.c
>  create mode 100644 board/mips/boston-riscv/checkboard.c
>  create mode 100644 board/mips/boston-riscv/config.mk
>  create mode 100644 board/mips/boston-riscv/lowlevel_init.S
>  create mode 100644 board/mips/boston-riscv/reset.c
>  create mode 100644 configs/boston-p8700_defconfig
>  create mode 100644 include/configs/boston-riscv.h

...

> diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
> index 7023575a6be..0913a6ce8f2 100644
> --- a/arch/riscv/cpu/p8700/Kconfig
> +++ b/arch/riscv/cpu/p8700/Kconfig
> @@ -7,7 +7,7 @@ config P8700_RISCV
>  	select ARCH_EARLY_INIT_R
>  	imply CPU
>  	imply CPU_RISCV
> -	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
> +	imply RISCV_ACLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
>  	imply CMD_CPU
>  	imply SPL_CPU_SUPPORT
>  	imply SPL_OPENSBI

As mentioned before, this should probably be squashed into PATCH 1.

...

> diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.dts
> new file mode 100644
> index 00000000000..5a5c8826318
> --- /dev/null
> +++ b/arch/riscv/dts/boston-p8700.dts
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/boston-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "p8700";
> +	compatible = "img,boston";
> +
> +	chosen {
> +		stdout-path = &uart0;

Per device-tree specification, stdout-path should be a string instead of
a phandle.

	A string that specifies the full path to the node representing
	the device to be used for boot console output. If the character
	“:” is present in the value it terminates the path. The value
	may be an alias. If the stdin-path property is not spec-ified,
	stdout-path should be assumed to define the input device

> +		bootargs = "root=/dev/sda rw earlycon console=ttyS0,115200n8r";

And I don't think it's the appropriate way to pass cmdline arguments.

...

> diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-riscv/boston-riscv.c
> new file mode 100644
> index 00000000000..e5cd6c42cf7
> --- /dev/null
> +++ b/board/mips/boston-riscv/boston-riscv.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}

You could omit the empty board_init() by set CONFIG_BOARD_INIT to n.

...

> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 506ee51cdb0..7b25de7bb68 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -702,6 +702,11 @@ enum gd_flags {
>  	 * drivers shall not be called.
>  	 */
>  	GD_FLG_HAVE_CONSOLE = 0x8000000,
> +	/**
> +	 * @GD_FLG_COHERENT_DMA: DMA is cache-coherent.
> +	 *
> +	 */
> +	GD_FLG_COHERENT_DMA = 0x10000000,
>  };

I don't think it's a flag generic enough to be put in the
platform-independent header. It may sound even more appropriate to add a
private API to indicate whether IO DMA is configured as coherent.

>  #endif /* __ASSEMBLY__ */
> diff --git a/include/configs/boston-riscv.h b/include/configs/boston-riscv.h
> new file mode 100644
> index 00000000000..3b3e2567214
> --- /dev/null
> +++ b/include/configs/boston-riscv.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#ifndef __CONFIG_BOSTON_RISCV_H
> +#define __CONFIG_BOSTON_RISCV_H
> +
> +#include <linux/sizes.h>

The header defines nothing for now, so I think the include is
unnecessary, at least in this patch.

> +#endif /* __CONFIG_BOSTON_RISCV_H */
> -- 
> 2.34.1

Best regards,
Yao Zi
