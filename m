Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B893CCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 10:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCA7844DE;
	Thu,  9 Oct 2025 12:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Bt+ao+C1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951D9844E4; Thu,  9 Oct 2025 12:23:30 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6631B844D8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0AEF9263AD;
 Thu,  9 Oct 2025 12:23:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKkgO_8quVzf; Thu,  9 Oct 2025 12:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760005407; bh=JxerEVpvLc0cC6r1LborW2msWojFZwW9IGyYjFaU6RM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bt+ao+C1CcS33pm3wI+x73HXva7os2mkNruMMz8pKcdJSMlEbj56RUl9xB7vHEIlY
 D+v2UTGVxL59ickn1Z4faGJR3apc11E+z6J0KPfwpQN25XtMiosxRsNezGcirCnZ9R
 FunTbOQ3XWS10v4M9k0bJw+5qzhw+iePUA9S9YPBnefyfpkHDYEz+FZ7BgEawUZuH5
 NJ8dIiSTNl1MgW13I5TGfzJVrT4GreCM+2Oq2QnzBDA4o8vTmP5DLg27wwrvhHbdPu
 o76HwAFxFpUXehIj46M1gGUGVTXqSUpd/MLfcC+yV58DiwomG4uptdGIU3KsJyyC7S
 /c5mZ/xKxCcMw==
Date: Thu, 9 Oct 2025 10:23:08 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v4 01/10] riscv: Add initial support for P8700 SoC
Message-ID: <aOeNDPxxdq6oZ6wt@pie>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-2-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103021.1518687-2-uros.stajic@htecgroup.com>
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

On Tue, Aug 19, 2025 at 10:31:42AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add initial platform support for the P8700-F, a high-performance
> multi-core RV64GC SoC with optional multi-cluster configuration and
> hardware multithreading.
> 
> This patch introduces the initial platform code necessary to support
> the P8700 CPU in U-Boot.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/Kconfig                          |   1 +
>  arch/riscv/cpu/p8700/Kconfig                |  14 ++
>  arch/riscv/cpu/p8700/Makefile               |   9 ++
>  arch/riscv/cpu/p8700/cache.c                |  93 +++++++++++
>  arch/riscv/cpu/p8700/cpu.c                  |  13 ++
>  arch/riscv/cpu/p8700/dram.c                 |  37 +++++
>  arch/riscv/cpu/p8700/p8700_platform_setup.S | 169 ++++++++++++++++++++
>  arch/riscv/include/asm/arch-p8700/p8700.h   | 110 +++++++++++++
>  8 files changed, 446 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/Kconfig
>  create mode 100644 arch/riscv/cpu/p8700/Makefile
>  create mode 100644 arch/riscv/cpu/p8700/cache.c
>  create mode 100644 arch/riscv/cpu/p8700/cpu.c
>  create mode 100644 arch/riscv/cpu/p8700/dram.c
>  create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
>  create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 04eb0e6f23c..4eaf0e3db71 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -131,6 +131,7 @@ source "arch/riscv/cpu/jh7110/Kconfig"
>  source "arch/riscv/cpu/k1/Kconfig"
>  source "arch/riscv/cpu/k230/Kconfig"
>  source "arch/riscv/cpu/th1520/Kconfig"
> +source "arch/riscv/cpu/p8700/Kconfig"
>  
>  # architecture-specific options below
>  
> diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
> new file mode 100644
> index 00000000000..7023575a6be
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> +
> +config P8700_RISCV
> +	bool
> +	select ARCH_EARLY_INIT_R
> +	imply CPU
> +	imply CPU_RISCV
> +	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)

SIFIVE_CLINT has been renamed as RISCV_ACLINT back to 2023, and in
PATCH 2 you change SIFIVE_CLINT to RISCV_ACLINT. I think you should
squash the change into PATCH 1.

> +	imply CMD_CPU
> +	imply SPL_CPU_SUPPORT
> +	imply SPL_OPENSBI
> +	imply SPL_LOAD_FIT

...

> diff --git a/arch/riscv/cpu/p8700/p8700_platform_setup.S b/arch/riscv/cpu/p8700/p8700_platform_setup.S
> new file mode 100644
> index 00000000000..7c4475a03dd
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/p8700_platform_setup.S

Could this file be converted to C language? Then it'll be easier to
maintain. I think nothing prevents this if you could put the
initialization off until harts_early_init().

Futhermore I don't see this file is included in any of your Makefile,
which is suspicious.

...

> diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include/asm/arch-p8700/p8700.h
> new file mode 100644
> index 00000000000..5ca9b4b9497
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch-p8700/p8700.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#ifndef __P8700_H__
> +#define __P8700_H__
> +
> +#define CSR_MIPSCONFIG7		0x7d7
> +#define CSR_PMACFG0			0x7e0
> +
> +#define MHARTID_HART_SHIFT	0
> +#define MHARTID_HART_MASK	0xf
> +#define MHARTID_CORE_SHIFT	4
> +#define MHARTID_CORE_MASK	0xff
> +#define MHARTID_CLUSTER_SHIFT	16
> +#define MHARTID_CLUSTER_MASK	0xf
> +
> +#define MARCHID_UARCH_SHIFT	0
> +#define MARCHID_UARCH_MASK	0xff
> +#define MARCHID_CLASS_SHIFT	8
> +#define MARCHID_CLASS_MASK	0xff

If you convert p8700_platform_setup.S to a C file, these macros could be
simplified with GENMASK() and FIELD_GET/PUT().

Best regards,
Yao Zi
