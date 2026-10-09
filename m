Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E49CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 998C6608A7;
	Fri,  9 Oct 2026 09:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67TjnbEWJMlD; Fri,  9 Oct 2026 09:09:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A53F060727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791536981;
	b=lfvd1M9xng37a/+LG9r9D2q90DgfUmV970MEecOrMGCxUCbrt8DvWnzAKv/w2OjizLfZ
	 35JFDbjfiJkH4PdPT4/n2kRRxqd2L3YlsYCQJwenfoARa8Ub3hAzREBMFPo7sL2t1VCls
	 ikYUWt7JVDAO7rr+ElxVtZGP9CRBQ8gx4WtgRwDikS3P34YWBccozungbT42OHIfN4HzG
	 MW5ffMFAmMgQatLNmwHSak0NcEIjjzfHZB4gTU8PNMSvRpig6Hvrsc7UyTMBH7zzcUyp2
	 AmK10FKpYffVrFdI0FlA59ArGFQ8S7uRZ1ACYhqXjfKGWmq3Jrw6NfDDYWAW9fZCs+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791536981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/PE3KEBrvnptHGAJMALvxrNpwNBKG3VnStio1m9tRyk=;
	b=n2ZwYzadDCEY3HFdk3hOAI1hgdEgAnjkDokrTCy3risl8E1+ceOtZxMybC1ZzZuwRhT0
	 XuzRXu22GtLttU3mrHZDzWI9+o4qT1eqykuFQ8PD7P9FbefKxGOLz5pUIF6vfFdwtu6kf
	 WnTaNyMLPoOH5JhNhhEB+GtYa2vIneUK0VutpaXQJUutDEDmSMfFj2jSmMkzkRp/+RLIH
	 WZxzczlHhezfQKIRxfXnZ9Ltr4yK6DNriTBjXt9H0aQkHlO2Wz8MjYFfG15s+o6xVqcLA
	 6wq5+jjb28bWg22IlkRw30RwzlFm/y4zTJEdYn5WaValQeH+/k6TmEsVcvZOUDGu2EA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=dAhtzeew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791536981;
	bh=/PE3KEBrvnptHGAJMALvxrNpwNBKG3VnStio1m9tRyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HW/+Yb45LK2tycmEwypLzO6go5WUKnm1tr2p6xI3AOHc4/PsxF3eCpfcgzbD524jW
	 elB1E+P//UDFjDgEkLX//DJwFbZihlovHlFHVx5G7P93xm3SELl8oQ3D6OY7WlWgcE
	 RbpWq/mHZ5EHsPr3DG04MBUI16fbq+FvQ4xG84ICosM8ufeT8FyniekUSApMpQJ+NA
	 Fu2Wf9FQR0/NCnRLWgwYbC1nuTEJBx4ToEgy9tMmXjlPwKA7D3Uv2lcQulmXnB/bKs
	 7SwIyBBtd6v6wVxbXVFu7sgobCUd2q/bc1NP+jPczCEOfsVF3+Nr2RSc2wgd1Q2JWI
	 NydDue94665Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A53F060727;
	Fri,  9 Oct 2026 09:09:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 069DC184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 040D960727
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftCjh3jnZwYf for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:09:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1FA9606C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791536979;
 b=VEm1rHIityMBdJGSaw3Uk+D2CeHDid1HIoL8/ErArzQrUTZ0VhplIKJRtPFOD5jtQ4Gz
 Oi6N5u2lTK79tbfWQsxJLqPFTA6zYEteJ2S8kMTqpOclYNiPqFgwbnip2KxIKRLARnFr3
 86SgSzU8xvP2K7LXZ+cV/90e93Af51jNda4iLgey8M0/FGR64QURutLqctc5uusVPcx6R
 3cwda+wq9OjcLtxYK5jqjOLMdDlWfPU8vshm6rHzM1Z+mKP/KRJIdtg47xlgYR0ruDpoy
 KpoYhrXPevLsfnEmsHbMqcMAKQwcfAWUiro2elssBC35ubN/T1/B50S1+yOnvjPje3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791536979;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=/PE3KEBrvnptHGAJMALvxrNpwNBKG3VnStio1m9tRyk=;
 b=LEU7Y1UXq3Xyziy+wJlNVlRqO90+QrZBJicZXSXPTjVw9bGsVAl+n8bJUrgwqYxm3J73
 SSfW8n7rb9BIZKamkWXnpjaY3QZEnDoCwu3XyFFKoLG9STSbTlRQyZhPe2P3eTaHG1evQ
 MhNNaYFUVfIchGX5JyS9CNznW4NydcSj4hiSa9Slr/HoHIt8qC8QLZ1kYMSNNjCqAXAHm
 8wR7ps3fMvflMnnl6zegfNc6QOi45n+N9dVDQm4AXhgsCf4lFqe2rlCpAKmStUmQeDl1A
 xufgV8YwepWfm72tu6XB1PJzW9+gFRBdOBnosxJ1ITNjCL9hACkQ6Z+1K+g39QGBu7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dAhtzeew; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dAhtzeew
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1FA9606C7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791536939;
 bh=/PE3KEBrvnptHGAJMALvxrNpwNBKG3VnStio1m9tRyk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dAhtzeewsm0GS0vZCq7u8nk68Om3QJB4KKo1CqP89rWxmUjpZUG/vVeOInmtE0W/K
 2HyGKn+5wmf7miX//VgQmnnv+hlvggfvif/9+5Df2SaWIdazP+gJ4CNfojZ7RKgUIG
 2uyq5ZNUJuiFdF71oRurGqov9gifslg+H8yAsk/szDdY8qeBP6RgD5Iw3Omx0Co61p
 5bpo4POVTY/OIy96VU+FoiewTARvCNHGUjHIY+nrqI5DGXfj0R+SDtu+RDkDCqlcYr
 hDFAM9Z9THuuTC6snaIDNL/ABAqPKsPlcMObSZ8OpX0KjNrSPeZtTvEojNw0G40PgA
 x7OCKrelFUIMA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 93FF4B2210B3;
 Fri,  9 Oct 2026 11:08:57 +0200 (CEST)
Message-ID: <746bba21-879b-47a9-abc2-943add9db38d@freeshell.de>
Date: Fri, 9 Oct 2026 02:08:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-1-c44d09937088@kernel.org>
 <f5f4086a-3208-4f1b-b2f3-06c1a60ff3d8@freeshell.de>
 <20261009062619-GKD2005@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261009062619-GKD2005@kernel.org>
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

On 10/8/26 23:26, Yixun Lan wrote:
> Hi E Shattow,
> 
> On 03:51 Wed 07 Oct     , E Shattow wrote:
>> Hi Yixun, we should refresh MAINTAINERS such as file rename and added
>> changes requested are now settled. Keep R-by tag from me on the refresh
>> if there's no v5 before merge, thanks!
>>
> Ok, I will no send a new version, since it's really minor changes 
> 
>> On 10/6/26 22:11, Yixun Lan wrote:
>>> Add initial support for K3 Pico-ITX board, in this version, the DRAM
>>> information is parsed from DTS "/memory" node. And with UART enabled,
>>> the U-Boot serial console works fine now.
>>>
>>> Reviewed-by: E Shattow <e@freeshell.de>
>>> Signed-off-by: Yixun Lan <dlan@kernel.org>
>>> ---
>>>  arch/riscv/Kconfig            |  5 +++++
>>>  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
>>>  arch/riscv/cpu/k3/Makefile    |  5 +++++
>>>  arch/riscv/cpu/k3/dram.c      | 21 +++++++++++++++++++++
>>>  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
>>>  board/spacemit/k3/MAINTAINERS |  8 ++++++++
>>>  include/configs/spacemit-k3.h | 13 +++++++++++++
>>>  7 files changed, 100 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index c1b2890f1f3..386241efd4a 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -53,6 +53,9 @@ config TARGET_SIPEED_MAIX
>>>  config TARGET_SPACEMIT_K1
>>>  	bool "Support Spacemit K1 SoC"
>>>  
>>> +config TARGET_SPACEMIT_K3
>>> +	bool "Support SpacemiT K3 SoC"
>>> +
>>>  config TARGET_STARFIVE_VISIONFIVE2
>>>  	bool "Support StarFive VisionFive2 Board"
>>>  	select BOARD_LATE_INIT
>>> @@ -124,6 +127,7 @@ source "board/sophgo/milkv_duo/Kconfig"
>>>  source "board/sophgo/milkv_duo_256m/Kconfig"
>>>  source "board/sophgo/licheerv_nano/Kconfig"
>>>  source "board/spacemit/k1/Kconfig"
>>> +source "board/spacemit/k3/Kconfig"
>>>  source "board/starfive/visionfive2/Kconfig"
>>>  source "board/thead/th1520_lpi4a/Kconfig"
>>>  source "board/xilinx/mbv/Kconfig"
>>> @@ -138,6 +142,7 @@ source "arch/riscv/cpu/mpfs/Kconfig"
>>>  source "arch/riscv/cpu/generic/Kconfig"
>>>  source "arch/riscv/cpu/jh7110/Kconfig"
>>>  source "arch/riscv/cpu/k1/Kconfig"
>>> +source "arch/riscv/cpu/k3/Kconfig"
>>>  source "arch/riscv/cpu/k230/Kconfig"
>>>  source "arch/riscv/cpu/th1520/Kconfig"
>>>  
>>> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
>>> new file mode 100644
>>> index 00000000000..5474ac11243
>>> --- /dev/null
>>> +++ b/arch/riscv/cpu/k3/Kconfig
>>> @@ -0,0 +1,18 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> +
>>> +if TARGET_SPACEMIT_K3
>>> +
>>> +config SPACEMIT_K3
>>> +	bool
>>> +	select BINMAN
>>> +	select ARCH_EARLY_INIT_R
>>> +	select SYS_CACHE_SHIFT_6
>>> +	imply CPU
>>> +	imply CPU_RISCV
>>> +	imply RISCV_TIMER if RISCV_SMODE
>>> +	imply CMD_CPU
>>> +	imply OF_UPSTREAM
>>> +
>>> +endif
>>> diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
>>> new file mode 100644
>>> index 00000000000..fba4e4b0a3f
>>> --- /dev/null
>>> +++ b/arch/riscv/cpu/k3/Makefile
>>> @@ -0,0 +1,5 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> +
>>> +obj-y += dram.o
>>> diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
>>> new file mode 100644
>>> index 00000000000..e20d35dc1bf
>>> --- /dev/null
>>> +++ b/arch/riscv/cpu/k3/dram.c
>>> @@ -0,0 +1,21 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> + */
>>> +
>>> +#include <fdtdec.h>
>>> +#include <init.h>
>>> +#include <linux/sizes.h>
>>> +#include <asm/global_data.h>
>>> +
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>> +int dram_init(void)
>>> +{
>>> +	return fdtdec_setup_mem_size_base();
>>> +}
>>> +
>>> +int dram_init_banksize(void)
>>> +{
>>> +	return fdtdec_setup_memory_banksize();
>>> +}
>>> diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
>>> new file mode 100644
>>> index 00000000000..1a63c73b6bb
>>> --- /dev/null
>>> +++ b/board/spacemit/k3/Kconfig
>>> @@ -0,0 +1,30 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> +
>>> +if TARGET_SPACEMIT_K3
>>> +
>>> +config SYS_BOARD
>>> +	default "k3"
>>> +
>>> +config SYS_VENDOR
>>> +	default "spacemit"
>>> +
>>> +config SYS_CPU
>>> +	default "k3"
>>> +
>>> +config SYS_CONFIG_NAME
>>> +	default "spacemit-k3"
>>> +
>>> +config TEXT_BASE
>>> +	default 0x102000000
>>> +
>>> +config SPL_OPENSBI_LOAD_ADDR
>>> +	hex
>>> +	default 0x100000000
>>> +
>>> +config BOARD_SPECIFIC_OPTIONS
>>> +	def_bool y
>>> +	select SPACEMIT_K3
>>> +
>>> +endif
>>> diff --git a/board/spacemit/k3/MAINTAINERS b/board/spacemit/k3/MAINTAINERS
>>> new file mode 100644
>>> index 00000000000..34cf1ed4453
>>> --- /dev/null
>>> +++ b/board/spacemit/k3/MAINTAINERS
>>> @@ -0,0 +1,8 @@
>>> +SPACEMIT K3
>>> +M:	Yixun Lan <dlan@kernel.org>
>>> +S:	Maintained
>>> +F:	arch/riscv/cpu/k3/
>>> +F:	board/spacemit/k3/
>>> +F:	configs/spacemit_k3_defconfig
>>> +F:	include/configs/k3.h
>>
>> -F:	include/configs/k3.h
>> +F:	include/configs/spacemit-k3.h
>>
>>> +F:	arch/riscv/dts/k3-u-boot.dtsi
>>
>> -F:	arch/riscv/dts/k3-u-boot.dtsi
>> +F:	arch/riscv/dts/spacemit-k3-binman.dtsi
>> +F:	arch/riscv/dts/spacemit-k3-u-boot.dtsi
>>
>> Note aside that K1 dtsi are listed in source tree root MAINTAINERS,
>> which is probably needing to be changed separately and follow the
>> example of per-board like you are doing here for K3. We are missing
>> something in per-board MAINTAINERS here for
>> doc/board/spacemit/spacemit-pico-itx.rst and it could be added here or
>> not, it is matching anyways by the source tree root MAINTAINERS on
>> 'spacemit' search.
>>
>> Other modified files (with required dependency patches applied) for our
>> reference:
>>
>> not applicable arch/riscv/Kconfig
>> drivers/clk/spacemit/Kconfig
>> drivers/clk/spacemit/Makefile
>> drivers/clk/spacemit/clk-k3.c
>> drivers/clk/spacemit/clk_common.h
>> drivers/clk/spacemit/clk_mix.c
>> drivers/clk/spacemit/clk_mix.h
>> drivers/clk/spacemit/clk_pll.c
>> drivers/clk/spacemit/clk_pll.h
>> drivers/gpio/Kconfig
>> drivers/gpio/spacemit_gpio.c
>> not applicable drivers/reset/Kconfig
>> not applicable drivers/reset/Makefile
>> drivers/reset/spacemit/Kconfig
>> drivers/reset/spacemit/Makefile
>> drivers/reset/spacemit/reset-spacemit-common.c
>> drivers/reset/spacemit/reset-spacemit-common.h
>> drivers/reset/spacemit/reset-spacemit-k1.c
>> drivers/reset/spacemit/reset-spacemit-k3.c
>> include/soc/spacemit/k3-reset.h
>> include/soc/spacemit/k3-syscon.h
>>
>> With the expectation that those drivers' patches are to be merged
>> in-order before this K3 Pico-ITX series, I think this all makes good
>> sense, and all dependency series will be covered by source tree root
>> MAINTAINERS on 'spacemit' search.
>>
> Ok, I will do some adjustment for the file name, maybe only keep
> the K3 specific files..
> 
> But, I'd rather not bother to add all the files which already covered by
> 'spacemit' keyword imply with the top MAINTAINERS file, it would simplify
> the file list a bit..
> 

Acknowledged, I agree, and thanks. -E

>>> diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
>>> new file mode 100644
>>> index 00000000000..9dd545e2a3b
>>> --- /dev/null
>>> +++ b/include/configs/spacemit-k3.h
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> + */
>>> +
>>> +#ifndef __SPACEMIT_K3_H
>>> +#define __SPACEMIT_K3_H
>>> +
>>> +#define CFG_SYS_NS16550_IER	0x40
>>> +
>>> +#define RISCV_SMODE_TIMER_FREQ	24000000
>>> +
>>> +#endif /* __SPACEMIT_K3_H */
>>>
>>
>> Reviewed-by: E Shattow <e@freeshell.de>
> Thanks for the review
> 

