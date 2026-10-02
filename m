Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6770CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 07:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 033E740BB5;
	Fri,  2 Oct 2026 07:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GX0ay9isIIJD; Fri,  2 Oct 2026 07:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98B0E40BA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790924601;
	b=U/V6EPrzCoZkGPJeWEpujgMt5JDsmqLHKv+3cyURW1s0za2ObigRLlSpCR6lct+OMvxs
	 7f9AWwpvrrZ+OB58+vRr6XkT8JE9MkOAyyRKLRQ2a70dYFrQ9PyG4ufZmY0qlm7OUD1C2
	 rUKqyko3aLn8t0ppSg9KgaHrPZ53vm2VWjc8D+L4TtESgi+pjzTBgAwcKvrWbj0SGz1Hh
	 wHANAl62d8Nv9NYBz9Pommuw1YNZB6geiUjUBBX+Ww/b5tw2DbUoyfFjDCeD/FK1+/b+K
	 KRAbqvDORiFBSrF+r5TOKzNtAXUvIX0Han+vQqtBA7SMc9TOazSM6g1NrE3yXl3Kacg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790924601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FA3+sqdMAY82E7wZbfi3y6cAr/v1Z536nHPQYFQtWYw=;
	b=UD8+U1eAXAd/JXyilHypOIQiNSKfMJahgbC7LW0qb6jEF6vfKDMEsuhaa9p6WQf3IhIw
	 1qK7KgRkPtCz6V8BhIwbFVsq0Bf4x/xRdAXAeKjLPLDDCw4gStDiX99sRKmwD86Yzbgv0
	 ZRqJkRlhlRB/+v5ttS+cfvfRE687f8fGL4ugJLCgJDIHT0WApuvQjJXYzLc8qHMbwoUa5
	 KHrcEqp0bt3UoZIy8O72FUZmMg3lpsO2ZldnivRZ9tIArZAob03M5I+dsdqnfGdT8oexG
	 jvEFuC3lCHZDT435cSxz95sM+vfZmlYiN0kL62oO6HIeK6kK43ZhIEmufSgEnak3NDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790924601;
	bh=FA3+sqdMAY82E7wZbfi3y6cAr/v1Z536nHPQYFQtWYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oUEuS3WCcqRTIKTMhZ9asTJCHGoKQVy16GXwSV0UesktMO+M54B4cWAoRoFDBjMgq
	 OrzxLkEvhKrY2qLwfsjg6hm8PMXMxrzf4oxHHKwZQ9eqTif9b3CBoLeVzJpx0FvAt8
	 GAso65NWDmnn81yu67PZ5ZRWiUd5hdAt53oPP0kKOjdXbCDzEGWxJxZ4FFOyixYLrO
	 r1rCTWCcp09USG0Sehk1KCH8nADmH66ogDBINmBnyAdRMbBCAf3YcdH/Qh7ZUxJk65
	 Kwc4FZHkk7zOv8Y9RRdYE7UP5Ov8eGOxO6MbtnUgZ1MPBO2mI2cbdkrXoHQORBbT+8
	 6ASJ7h0uI3nhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98B0E40BA0;
	Fri,  2 Oct 2026 07:03:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 868BD32F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8417D607F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDQbdNa4Xui4 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C15C6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790924599;
 b=lv5U8bmefcwouFZcMV5BCVK1hp8lrvzvfmLpVMXRail+PxJ/2DEvXulaHQHT3mMVf7on
 kZoCQT07bfj1G3w2W3HTZeQIuUNAyJhhzBgCAboXQrufkIlR3kmg6EytorSj0Xw2HO4Hf
 l7S3fngEr5aWUr5d5YHK7xNK9chReLBg6cuvEHUYx9IHfZ9ZeLSvkGaBlQNPd6RVyg9oV
 vu+eqyuFUtZXaVq+UudrKgQOtF5N1eyqH6nPI+5dA3ErKHR6Pz1CDQ/lb0mdxuAyM/AAN
 RR4VB50e+03h1Sy7tmE0jly1GYMN0pNrs7d69r6WU3gK1w0g1Ra1YC5K/HOp0jXqa7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790924599;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=FA3+sqdMAY82E7wZbfi3y6cAr/v1Z536nHPQYFQtWYw=;
 b=qMdmQJlnEqlWWAUtcZ+3N7g/TTTJGGPyTRy4zQpeJrnkd5qoqVs2U4Mq3xCJBUxlcKM1
 9639eW3TujnvjoMO5o6GqtR5V5MOpcApGzKf4lQjAQOQfCmJA+Xt/xt0X0CY3LVGGRQ8f
 IeUvLvdtoX71uvPY12xPas/PX1CWOnkSw1UHrxgkcRJQkC7gKEL6XZL8DZFuqQg1jRSAT
 8Tpcg6cT1DDiuS67NvoOKLKjjkxqB3x+lrBfT52hARwcFXjyk5B18ukMns5qgnKOODrO6
 +Np6ZPUf8HvZQEKlChrAIOXLU09Qfa3O2U/fbUlN53N6GZ+AsUwsnKEINgrqQaKXJFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=er7hzHX4; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=er7hzHX4
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C15C6061C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790924558;
 bh=FA3+sqdMAY82E7wZbfi3y6cAr/v1Z536nHPQYFQtWYw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=er7hzHX44AkoG5LN8pkxWnrGG6qSKkGGQBIMJOszVtKR142BadV2cDDUtIEBbKpic
 WYZqmX99z9aPeAVvgvROkithWsrah4lkEwOYRrbW9gqnVjgXKbmxeJLSuszphRnG+I
 ZzxIF0uDTNsIFTITB4oGB1VLWtwif4Rl0Vh/kgDJcBwBE9WlE7m2StCze5c/WPWgmI
 VDYlmSgZH/bTaYaRlPJvS5PjygC8XnYVZoTiX4QHNrYl/9aHBm3gjK1uS3YOk9IB7Y
 seadzCDlBF6zSjyLcRiixHLBnmcEMCH6zKdJYzMRcAMXDNdAKgt9wd2EhaMI/ITaeQ
 G59wnB/fEIO0g==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id CFD31B222683;
 Fri,  2 Oct 2026 09:02:36 +0200 (CEST)
Message-ID: <20fc5895-ac3a-4516-b302-7f1893dc370d@freeshell.de>
Date: Fri, 2 Oct 2026 00:02:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
 <20261002-00-basic-spacemit-k3-v2-1-fd6779a0317c@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-1-fd6779a0317c@kernel.org>
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

On 10/1/26 18:03, Yixun Lan wrote:
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
>  include/configs/k3.h          | 13 +++++++++++++
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
> index 00000000000..b0e423d829c
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
> +	default "k3"
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
> +F:	arch/riscv/dts/k3-u-boot.dtsi
> diff --git a/include/configs/k3.h b/include/configs/k3.h
> new file mode 100644
> index 00000000000..83e4945d2b3
> --- /dev/null
> +++ b/include/configs/k3.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define CFG_SYS_NS16550_IER	0x40
> +
> +#define RISCV_SMODE_TIMER_FREQ	24000000
> +
> +#endif /* __CONFIG_H */
> 

There is a Texas Instruments K3 SoC referred to as "k3" in u-boot
discussion. Let's not add to the confusion here on a global include file
that is named "configs/k3.h"

Please rename "include/configs/k3.h" as "include/configs/spacemit-k3.h"
or "include/configs/spacemit_k3.h" to be consistent with the target
defconfig name. "k1.h" global config header name may be renamed later
when development pace slows that it would not be too disruptive, and to
follow whatever hyphen or underscore delineation is decided for K3.

Thanks,

-E
