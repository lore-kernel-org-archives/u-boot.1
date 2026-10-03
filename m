Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7909ECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 10:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CC0740FAA;
	Sat,  3 Oct 2026 10:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMRjymLhHDVE; Sat,  3 Oct 2026 10:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D52540F9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021788;
	b=pDcknE9Yyn0s0QpaZ/ZW6NuiyIJq0pexK5ZBdEcCtdLVxWzJdmzpgkYVmkBULRqy2QGX
	 7/eiUX3Ew6xo18HAGkZVSyein45G+Ou5O8idMxul7LFdtHLzc2+NJvJHt2ygWjsNvr9WT
	 xDVhxzDDOWiGO0zjZ6Gp+b0EZ8BaAJIzMWwkqQ4VNzVVOEEbA9kCEa7AeoCtCBN84hPsh
	 HLB9eVWIpBWYjBBtfaYlC6ejaOKrRqy5pn+yapXGi1/4H3uSHSgIT4o7/gy9T/aBuXes3
	 UUbLAxFYyFCeWDxyXWPvOsNIXuBc/nRbLsI8OZBYty/O4UMQTcNhF2qq/FPu4OnDuBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BEgOoIYNyZdWsSx6qJQ4gC5Vzv3GspOi29Zo8gtqBQg=;
	b=g0x4dfS0pikI++9AqyeVxebo/X68bljO9RFa/dznNxcYW1GsTjOGGSHi6Z3VeZJrDuGd
	 03lH5f4bnKUcqq5t73eFPKZbbCp36pfpHz6qdzNyF7hJujcGZVCiccL0b/bTf2tQbPTLI
	 V/z4mhYFz8GsyeoW8XHIQfoPzBiTWVWxR6I+I0hQ0l4Zs/QCnM+fyOzJu5G+kOl32oh1e
	 6rXdqAZhnQbIJcVU5zcSWKTiiV0gR3GZ5H0W15bqeT5i4neQEJDPZ5g+p7snvT4GSV6o7
	 LEtvvq3l6I9m0dVoqWgHO7H6NO/Z7vXPnjbW9jFPlfNEwTeRYnT4HMcQEnBU/E7EjMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791021788;
	bh=BEgOoIYNyZdWsSx6qJQ4gC5Vzv3GspOi29Zo8gtqBQg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3Fi+/FNwd9A6XWHcX3EjjNUfdB9ObvkIgCnMPbkrGcF93Du0jKC34ikZXNNja49w
	 Il3MPiM/4WtwKP27TgvzntLdN4h2f8wFll0h9dR6Lc72kDX/ImDfe3o9JG6S6GZqXa
	 aSu8E3xw/UAIE9M1wYTWX/oIdjMW2CKXaEbb2L8SNNtw/aSdiruTKGt3vbgpTAdD4I
	 bYVbuwsc1BveE3tAq9f8I00+UaTUVtztW3Xto8HqNf+TXe4KcsU5wGwj0e9kYH7k/i
	 ngftjq5+Ax7iJdGKNcTBC/WPtCbwUa9UYgt6y6kbkjOIWQQUeHsomZBOt8KkFfGuhE
	 a+F8kH8TJB7tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D52540F9C;
	Sat,  3 Oct 2026 10:03:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B458179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D19C4007C
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SL5oz9Bb3TIe for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 10:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DAFB140059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021784;
 b=i+wXvaL0aB9Bmv4VZACwHT1YxbqiDUcRlmEqKzngLA5+SdBat0w4Ka9AreyhdyCOgq5U
 Wx/V4sZYRA6OX1INhdedDD9ImTlxPvMFYXIKMRziwGSYMbMoF5F/Gl3hsSqSZiZuO4+uc
 2bPSxkOdckXGwIx7+ap2RasjFfu0BszUlYXaIs4kTVr/aB6MIFjIU2ID04szFL3MBWwRy
 EjXN49ivsTbAvlb716nS2Z9unJ+a1maAxY9FYx7HTP2oDwgrXkiYyX+tFFfVweZp57BEw
 an/9NJi9cfye8hndZmlJ0fOgBQhYSmCdie3yWufIUc8K2s6iDZC7OGsu3cKB94hDeYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021784;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=BEgOoIYNyZdWsSx6qJQ4gC5Vzv3GspOi29Zo8gtqBQg=;
 b=lYSxMykZdynKH196y5vM9Kc6mOXCC8PesIhBJtCkYRsOrmBkyNcZM/7vm7gAhbjpoCGk
 aq/IrY6GtqQ+BcnhHLs7Yc5wDcNN1hmik0D8MyhgCydpECnmTQ8V94KaWcwNFf2vdlvQc
 qZ6bpNre/HWu+svuEcQ/DGQoGczTzyGfzQFU+HWgw0eaO+toTKSIR0cgqCr+BoB/USOoK
 D+XW88j+RYrTx/lfxlL3Ao8yFJH/qMUY2P5UdBQw6L8Q0ud95ESwJxel1xYtmKiquLQ0b
 LTf06K1o5uJ52vg1xupq9LD/uWZy89s0Xajp9BxO8udm8hvdb2aMLPrhiDL12lvu4Cw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mIQBHvYR; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mIQBHvYR
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAFB140059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791021745;
 bh=BEgOoIYNyZdWsSx6qJQ4gC5Vzv3GspOi29Zo8gtqBQg=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=mIQBHvYRH4xaSRJAxsbZ3H67SGa4RGdG3ohRAoccnfvOBkBbYHYZz03L0k9E2geMq
 RdKuManQKsw8Cyd2tMkEaITbEScr10z3dRODLeZXJ9OY9o1DRWJBv09C999Tt/ROu0
 nnQ4cmZYgVP7a/0LNcUsY9K0Vf7px5yr0JO6Hlku1rMokfOa7Nad/eClzYL6/QQNGv
 3LPJdwYuCVaxFfhxogV14pCsI16xeMPi0tECvHUhw1fw8j+Gopkuw8HCcQa4NEJ3hF
 BxvK5AJJ73DPYGokIgppGow1Jk1kafjhpEOF4WJGz1zEQjTZKCd7rNa2gEMeX+IKcT
 Qg7N8/1Wc63Qw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id CCD82B22264E;
 Sat,  3 Oct 2026 12:02:23 +0200 (CEST)
Message-ID: <b8a9bb83-7839-4833-8750-1ca55e318f03@freeshell.de>
Date: Sat, 3 Oct 2026 03:02:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH v3 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-1-dea68cd1bd7d@kernel.org>
Content-Language: en-US
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-1-dea68cd1bd7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Yixun,

On 10/2/26 17:34, Yixun Lan wrote:
> Add initial support for K3 Pico-ITX board, in this version, the DRAM
> information is parsed from DTS "/memory" node. And with UART enabled,
> the U-Boot serial console works fine now.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/Kconfig            |  5 +++++
>  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
>  arch/riscv/cpu/k3/Makefile    |  5 +++++
>  arch/riscv/cpu/k3/dram.c      | 21 +++++++++++++++++++++
>  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
>  board/spacemit/k3/MAINTAINERS |  8 ++++++++
>  include/configs/spacemit-k3.h | 13 +++++++++++++
>  7 files changed, 100 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c1b2890f1f3..386241efd4a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -53,6 +53,9 @@ config TARGET_SIPEED_MAIX
>  config TARGET_SPACEMIT_K1
>  	bool "Support Spacemit K1 SoC"
>  
> +config TARGET_SPACEMIT_K3
> +	bool "Support SpacemiT K3 SoC"
> +
>  config TARGET_STARFIVE_VISIONFIVE2
>  	bool "Support StarFive VisionFive2 Board"
>  	select BOARD_LATE_INIT
> @@ -124,6 +127,7 @@ source "board/sophgo/milkv_duo/Kconfig"
>  source "board/sophgo/milkv_duo_256m/Kconfig"
>  source "board/sophgo/licheerv_nano/Kconfig"
>  source "board/spacemit/k1/Kconfig"
> +source "board/spacemit/k3/Kconfig"
>  source "board/starfive/visionfive2/Kconfig"
>  source "board/thead/th1520_lpi4a/Kconfig"
>  source "board/xilinx/mbv/Kconfig"
> @@ -138,6 +142,7 @@ source "arch/riscv/cpu/mpfs/Kconfig"
>  source "arch/riscv/cpu/generic/Kconfig"
>  source "arch/riscv/cpu/jh7110/Kconfig"
>  source "arch/riscv/cpu/k1/Kconfig"
> +source "arch/riscv/cpu/k3/Kconfig"
>  source "arch/riscv/cpu/k230/Kconfig"
>  source "arch/riscv/cpu/th1520/Kconfig"
>  
> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
> new file mode 100644
> index 00000000000..5474ac11243
> --- /dev/null
> +++ b/arch/riscv/cpu/k3/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> +
> +if TARGET_SPACEMIT_K3
> +
> +config SPACEMIT_K3
> +	bool
> +	select BINMAN
> +	select ARCH_EARLY_INIT_R
> +	select SYS_CACHE_SHIFT_6
> +	imply CPU
> +	imply CPU_RISCV
> +	imply RISCV_TIMER if RISCV_SMODE
> +	imply CMD_CPU
> +	imply OF_UPSTREAM
> +
> +endif
> diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
> new file mode 100644
> index 00000000000..fba4e4b0a3f
> --- /dev/null
> +++ b/arch/riscv/cpu/k3/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> +
> +obj-y += dram.o
> diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
> new file mode 100644
> index 00000000000..e20d35dc1bf
> --- /dev/null
> +++ b/arch/riscv/cpu/k3/dram.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <linux/sizes.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	return fdtdec_setup_memory_banksize();
> +}
> diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
> new file mode 100644
> index 00000000000..1a63c73b6bb
> --- /dev/null
> +++ b/board/spacemit/k3/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> +
> +if TARGET_SPACEMIT_K3
> +

> +config SYS_BOARD
> +	default "k3"

Let's arbitrarily change user-facing SYS_BOARD to "spacemit_k3" stem of
u-boot config filename "spacemit_k3_defconfig":

+config SYS_BOARD
-	default "k3"
+	default "spacemit_k3"

The use of SYS_BOARD is compiled-in as various runtime outputs e.g.
SMBIOS data structure. I think "spacemit_k3" is not a very interesting
or descriptive name to communicate all the boards that may be supported,
but it is better for a user to see this defconfig filename stem than
simply "k3" as the board name. I do not have any better suggestion
because it is a compile-time substitution and board selection is likely
to be at runtime.

> +
> +config SYS_VENDOR
> +	default "spacemit"
> +
> +config SYS_CPU
> +	default "k3"
> +
> +config SYS_CONFIG_NAME
> +	default "spacemit-k3"
> +

Looks good, thanks for picking up that rename.

> +config TEXT_BASE
> +	default 0x102000000
> +
> +config SPL_OPENSBI_LOAD_ADDR
> +	hex
> +	default 0x100000000
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +	select SPACEMIT_K3
> +
> +endif
> diff --git a/board/spacemit/k3/MAINTAINERS b/board/spacemit/k3/MAINTAINERS
> new file mode 100644
> index 00000000000..34cf1ed4453
> --- /dev/null
> +++ b/board/spacemit/k3/MAINTAINERS
> @@ -0,0 +1,8 @@
> +SPACEMIT K3
> +M:	Yixun Lan <dlan@kernel.org>
> +S:	Maintained
> +F:	arch/riscv/cpu/k3/
> +F:	board/spacemit/k3/
> +F:	configs/spacemit_k3_defconfig
> +F:	include/configs/k3.h
> +F:	arch/riscv/dts/k3-u-boot.dtsi
> diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
> new file mode 100644
> index 00000000000..9dd545e2a3b
> --- /dev/null
> +++ b/include/configs/spacemit-k3.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#ifndef __SPACEMIT_K3_H
> +#define __SPACEMIT_K3_H
> +
> +#define CFG_SYS_NS16550_IER	0x40
> +
> +#define RISCV_SMODE_TIMER_FREQ	24000000
> +
> +#endif /* __SPACEMIT_K3_H */
> 

With that, looks good to me.

Reviewed-by: E Shattow <e@freeshell.de>
