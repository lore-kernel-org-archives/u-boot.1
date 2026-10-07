Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA3CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 11:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7540D40688;
	Wed,  7 Oct 2026 11:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_rU8WC6D7R9; Wed,  7 Oct 2026 11:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 04B0A4066A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791370926;
	b=IlJ9wNm70+sGS3CA04wXy924bb33rJVsNqIPA6OHl/thHRNnD2cW0EdzBTJBf0pUdRj8
	 oHt1WXETlGLAagW1vPjVEwjvm7bi0H1PekSThkHEqf1Lk7WsqBzYvoC47Djs4X6y+uatI
	 oVyjl59KwYJWgbt6I5wrMVFMdWglXmxE1DfBk5EdB1FMoBz3QU0/XzyQtZXz9JjkVU27A
	 cSwk21oNcWLdGfDNiWaPf4FUa8Dpd4Pk3gL24ehFM6MUwotZOlFAqGBZPiM9rs4rCLosx
	 wQ5QqIZrWrPfoZvX3MmiWftmCeclqxfGqIFnrYRWUfJ6cOEOHDuIjtH6bYzHjHJNMHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791370926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d0GYN2uImXjC0CrfekZT6XrtzKtdd097zvQh16F+NS8=;
	b=sUtr1g9/fuSIn+sd57CUxPpk68QyqLEh8oHh85o1Zeiq22ux4Vwfl4lj7rSnCQUQPg52
	 BIu0MEO9/IeMlvh3cF3xFwg2NfylQ8liX1bnwPZ4FxAbz4vZG6xRdYRplpWHWITG9o6+n
	 MrgLHBfQhfKvm3HvI/SVWWG/Us8fYA5wVzLKRUmrrxzu72NDbA4VlbCo6MRb1RHQXN0Gb
	 EqbNpVVUMxxh9+S4VQ2KtYKzOaCjuzCOAr5WOLuIfgpplNvX41X3BmrZuN1VP7C/xeyai
	 e7Qopr+j3lt5uoT+cSV1z+wVWJppWr7x/8WxiLtDnjIS+pPunBaJDLrCKhDnxbPqeCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791370926;
	bh=d0GYN2uImXjC0CrfekZT6XrtzKtdd097zvQh16F+NS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWbgqedhrJkpuy8r7sz7NcymVI0Tpxt2PQw7jPlnhrt0d51T/sk+RWT1o/2ToHQ9Y
	 6Bo834StXZhpINjaDIQIY6IKI+ZbQdtVNZlraVft5UNcRyKKobh4jXMvvgfboULRvF
	 CnzCCZyQ65EGIt2wzBnjXGPrUTUm62ivapOrXYtO42uoUmdl4NHrpUfEWgB5sXEdzZ
	 xxdlXMhwZbSQnGxVqWPy5fokSjX94Y68iKdOXV7sNvo6SZYIrceOxO5gTvE31zEuyl
	 +lA+CagAYiMe8BF0Q7uGl2J6avVFMhsg2QHjQTd4tQXzHUOEpYKzHvOf2W9ZZFRaaL
	 oD+SjVtazGXOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04B0A4066A;
	Wed,  7 Oct 2026 11:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 284F675
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D6E0606B0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zf1CxzTgyuzd for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 10:51:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D7ED960670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791370300;
 b=KlNHed6J73b1EGpnenPe75jERixW66Us0GiTJZt4qJ5oqjNDopU73Cb7+BW+UrsnUkPR
 UWE97H7TlM51ABbef3PVWR984CPGWu7Hi50hsJsV3mxFMmWgO6MwbQSSPVbAyVsCY9L5c
 QF1RBcuR6E9F0APkEJdbQOR263M45YjFZcEKZsu+3c4IH2PZsVxoyLfiZFbwp0VOFrmZS
 eWVFrBAGRmFJ5lCsPp5pPm05pZPVtVeu3j9aUKUjxnyevfOaLKLwHIvz0CCHBjq4aEgTT
 aRarTI1nDGHqY3kj0ArvOsmNlaLE0XBYM/RHj0krSGicIUylbIDz6l7+0MCvxNEuQ7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791370300;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=d0GYN2uImXjC0CrfekZT6XrtzKtdd097zvQh16F+NS8=;
 b=X/sq+yi0DOIME/wFSbpmIJHMt1INdNd+fV+Dpx8t57Y19C42m/6IM771dCYONyHP5+qL
 RXZZxkYVvMKVUVa4joYuIkdP9sPr9SJKUy7wISyqCWejT4KK66b3wItFscxwtafPZ1rbu
 aRTZlIOvN/YWavG4yx6EZpZd3Xuh6ASFzjbYgvAAyVH7BofgGUD3x9ZH8hBR9dbBOWLnM
 5iilp55K/nAsk5sF4rFJejM3SqDS0mkF3B/a/x0lVm7uRwYGkJzSg85spFcmbWh0zTTC+
 Y0YVdF9BrMq8eDTCGsO8TojVoq72M+C5uUcRrDCMbvlzUhVE8z+uZ+jHCg63+eibERg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mpigyNWv; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mpigyNWv
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7ED960670
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791370268;
 bh=d0GYN2uImXjC0CrfekZT6XrtzKtdd097zvQh16F+NS8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mpigyNWvc0Ianb0WEEVyNE0qGQ6Hx4CQ1kSPaakwPZgG6SUMbyfhh95dpkSIsfhOI
 uJFu7Sy0RxHRC/w7xCi9Cq47Z7Pi/0C5ll/IzsPvCIf6eP1LsXWrZm9wgr82jKrL/O
 SIbRkrq+zpzJpgklLs8NRK7ObonKFMmifVF3JOxGNB7JxnmvCmfRSq7LHYdToTUbpd
 6tTNBnEh82yVOT1TdhXPpDKBS+wJdj8DcHpZZJQczAzF/VN4B5TXfRe6oVe/umHEdf
 nA9aIoPkNDQGjFL1uBoiqv2zwAz2/eDYkgblPOh5JRHAB3P+25XOivqFjUH0cv7uRb
 Cgk4pDzOKRnwQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1BEF3B221B9A;
 Wed,  7 Oct 2026 12:51:05 +0200 (CEST)
Message-ID: <f5f4086a-3208-4f1b-b2f3-06c1a60ff3d8@freeshell.de>
Date: Wed, 7 Oct 2026 03:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-1-c44d09937088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-1-c44d09937088@kernel.org>
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

Hi Yixun, we should refresh MAINTAINERS such as file rename and added
changes requested are now settled. Keep R-by tag from me on the refresh
if there's no v5 before merge, thanks!

On 10/6/26 22:11, Yixun Lan wrote:
> Add initial support for K3 Pico-ITX board, in this version, the DRAM
> information is parsed from DTS "/memory" node. And with UART enabled,
> the U-Boot serial console works fine now.
> 
> Reviewed-by: E Shattow <e@freeshell.de>
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

-F:	include/configs/k3.h
+F:	include/configs/spacemit-k3.h

> +F:	arch/riscv/dts/k3-u-boot.dtsi

-F:	arch/riscv/dts/k3-u-boot.dtsi
+F:	arch/riscv/dts/spacemit-k3-binman.dtsi
+F:	arch/riscv/dts/spacemit-k3-u-boot.dtsi

Note aside that K1 dtsi are listed in source tree root MAINTAINERS,
which is probably needing to be changed separately and follow the
example of per-board like you are doing here for K3. We are missing
something in per-board MAINTAINERS here for
doc/board/spacemit/spacemit-pico-itx.rst and it could be added here or
not, it is matching anyways by the source tree root MAINTAINERS on
'spacemit' search.

Other modified files (with required dependency patches applied) for our
reference:

not applicable arch/riscv/Kconfig
drivers/clk/spacemit/Kconfig
drivers/clk/spacemit/Makefile
drivers/clk/spacemit/clk-k3.c
drivers/clk/spacemit/clk_common.h
drivers/clk/spacemit/clk_mix.c
drivers/clk/spacemit/clk_mix.h
drivers/clk/spacemit/clk_pll.c
drivers/clk/spacemit/clk_pll.h
drivers/gpio/Kconfig
drivers/gpio/spacemit_gpio.c
not applicable drivers/reset/Kconfig
not applicable drivers/reset/Makefile
drivers/reset/spacemit/Kconfig
drivers/reset/spacemit/Makefile
drivers/reset/spacemit/reset-spacemit-common.c
drivers/reset/spacemit/reset-spacemit-common.h
drivers/reset/spacemit/reset-spacemit-k1.c
drivers/reset/spacemit/reset-spacemit-k3.c
include/soc/spacemit/k3-reset.h
include/soc/spacemit/k3-syscon.h

With the expectation that those drivers' patches are to be merged
in-order before this K3 Pico-ITX series, I think this all makes good
sense, and all dependency series will be covered by source tree root
MAINTAINERS on 'spacemit' search.

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

Reviewed-by: E Shattow <e@freeshell.de>
