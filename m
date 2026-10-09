Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DCECA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32475813FD;
	Fri,  9 Oct 2026 06:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUGam9PxnNBD; Fri,  9 Oct 2026 06:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1989D813F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791527189;
	b=mbDgpza7L/X7AnZGG2J9y9HCnzZCJsuoIidlCKzsGQUtUsNhw4toxzZhn4fZe2HClHUZ
	 JcaIU2UTlzATJrh0+oNOC8V84AufUxjqHQ8Lxfo5vDmggV3qV7Zo1fqSwbPa/87xmo616
	 VpfAOFGka1fvZvJNlp5NdPfylJr3vuhSB7jt/E+Lrk2Rgobds/B70vEMtDdV5y1kdWwAZ
	 Xj2PgWwD5tNIXG8Fd8i633OToCXKNncuPO1W/jx7wUFtpAsu7kW5o0mOekdJk+kpMrWO0
	 fwT4TY4l9cPZywJzGmuxLrUl8FA8Uk7xrvxPMM9k+ErwWDR8g2zykKvLK4EhQ/LAoUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791527189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5aOEKw3LFd3iAJVnlYhDdLVD1ZXu5TEJcgpRNnqxgFg=;
	b=It8/TEytgfF73AP7X5zFO3lHY6+L0NxDFUfESI1f8XtxUsqq1UpqwZexk6qLuWM7qEE2
	 eArlqXIDwIwnNaJtQx5pkmgFWipKB8YoMFFF/J8CgK8uXPXPbSboIuOmx8pcxkJsw1XHm
	 VV/2sspsfpDJ8utGoRdGCrSb9IgYbbhS93hFs314Ye6E3VyBLj7zJQsDxq/xkA1DjoeZV
	 iJQEU+JVKUUFgE/HPKQMfaoeqjckrzzI+HJyJDan8gJDJbn9fmtUdDZiUzf1ZqG0BPOs6
	 iFIJGNU2nJXqNtXItLrW/fRGjq5OhEafLrmov+NIO+iqOH9fWTpJk4O5XONPFu59ETw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791527189;
	bh=5aOEKw3LFd3iAJVnlYhDdLVD1ZXu5TEJcgpRNnqxgFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JxfoHIXcLPWkOpUly1vjeBAjSJQaUaj3bkQ8K9Uiqu83zrxG2uDNYdgCWbwkqtmvZ
	 eG6C27Rd12rkMnxRSfC8q6gYiCbgdXdAodMhdWcxXFPxWYi2YccFREyDOksXxip+cx
	 5DuMIpMgjtugiKCQEZ1nSHm7bCZi4iyp0NF+guEsGdC9dhESnLpJ8lLYSAcjOUu/lU
	 fp4iHZPnYYu7FXylXvoHPeEb12D1BiKPQEHgo32a04VFK/A8Yb0XtK0mKNW/Plj8JX
	 XSmvieOT8+szOVxhr2FJb9n7b0zE57HZG3RWGeTJQoJUAP4jW4UMRcTftYhFEwZ7hZ
	 8G3JN6UkwJ0uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1989D813F5;
	Fri,  9 Oct 2026 06:26:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A24FA75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A02FC4009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EifRJYmPJ0xK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE7DD40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791527186;
 b=iY0JOBZrpl7G25qVIjy84j/josjaZfrMoKUH0jpoijyEzfOFXtOl/vBiusi9fDojOrlh
 K3mtGsTTFacV600xeyAUvEeL8Col7ohAunGsfAS96X3gZsV0Zc+OD7wwELszClJg9q7zT
 mKD7nup+bUUMGZLkBP0/By/nms36nT8GApPePBl7h0peXFnIVFOKFJq40kFGA5O0Ya3mL
 5wYz5jn3M6mATfDLDFnYml4qSR0IsiULU3roVSUgli3en2aVUDkb7EyrHc5xxENGanH5h
 8VhtKUhQul+7V6GZ6NhgB2VWoQxiqdlnvg0DLOL5hlpcWN2HB34VRs0sea496gosWAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791527186;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=5aOEKw3LFd3iAJVnlYhDdLVD1ZXu5TEJcgpRNnqxgFg=;
 b=T458gHiorzNDjIXeQVLHRdBGRwGWH6mUmRTLc8L0zoq2yC61EPUOQDQ+Xqyof+5pKzLQ
 c6F6I1ZygRdtSCtPCKzMd5KML+kKlWIFhKBH4uM1QpN7ywQGGH4sjWym6FshuoB0vz4WH
 OW7vOMquRraCNxqupyseaBEO/ZFcXfYn/ATzDwsW2Bm7hj28MuY0JJiCK6ALkd/yccqjt
 JADU4gLydNiN9kauMEaGBfjlbJDdzYlr4J9J4K0/fE/SA0H4zdD2ZSSM5fAtOf6WAFpO3
 BzJQmzGC64GqAAh3J+C4ELPobzNY6RTz07lnZ0/lhuLonDGVMv5QYRSfzMH4QNG686A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bAf5yti7; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bAf5yti7
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE7DD40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:26:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FFA941B44;
 Fri,  9 Oct 2026 06:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0508A1F00893;
 Fri,  9 Oct 2026 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791527185;
 bh=5aOEKw3LFd3iAJVnlYhDdLVD1ZXu5TEJcgpRNnqxgFg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bAf5yti7f2Wb81wfkC9rvJn4roG72UA7PTDRr0yYx1S08X/XXnha8RkKl2q9IUWSl
 OA60HVWIU9RnTBjXhue54+27XrU7gJKdCo3gb7i3E9sq4je9/DYWuPzpT88G/Al/Oz
 UcF4bBMgTAVz7QpfS+DPoi2G7yinbu0+GSp1do/Z3+cPHG4Yywyu3SVDHLS2HMgvzO
 uv71k0KKyADHW/hF9P/VHoiiHIJb0VY9MZfzjxCYnBwEuC26l1/Kzc4zvFP4GjT8+Y
 oEPdhnt5PvvSk8k2KB5moL+y2H49MDlIjHGY65y/dxqxd2sorGT5C6D4EEjjMeMg9X
 ACAHHFY0C0eaw==
Date: Fri, 9 Oct 2026 06:26:19 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v4 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
Message-ID: <20261009062619-GKD2005@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-1-c44d09937088@kernel.org>
 <f5f4086a-3208-4f1b-b2f3-06c1a60ff3d8@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5f4086a-3208-4f1b-b2f3-06c1a60ff3d8@freeshell.de>
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

Hi E Shattow,

On 03:51 Wed 07 Oct     , E Shattow wrote:
> Hi Yixun, we should refresh MAINTAINERS such as file rename and added
> changes requested are now settled. Keep R-by tag from me on the refresh
> if there's no v5 before merge, thanks!
> 
Ok, I will no send a new version, since it's really minor changes 

> On 10/6/26 22:11, Yixun Lan wrote:
> > Add initial support for K3 Pico-ITX board, in this version, the DRAM
> > information is parsed from DTS "/memory" node. And with UART enabled,
> > the U-Boot serial console works fine now.
> > 
> > Reviewed-by: E Shattow <e@freeshell.de>
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  arch/riscv/Kconfig            |  5 +++++
> >  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
> >  arch/riscv/cpu/k3/Makefile    |  5 +++++
> >  arch/riscv/cpu/k3/dram.c      | 21 +++++++++++++++++++++
> >  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
> >  board/spacemit/k3/MAINTAINERS |  8 ++++++++
> >  include/configs/spacemit-k3.h | 13 +++++++++++++
> >  7 files changed, 100 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c1b2890f1f3..386241efd4a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -53,6 +53,9 @@ config TARGET_SIPEED_MAIX
> >  config TARGET_SPACEMIT_K1
> >  	bool "Support Spacemit K1 SoC"
> >  
> > +config TARGET_SPACEMIT_K3
> > +	bool "Support SpacemiT K3 SoC"
> > +
> >  config TARGET_STARFIVE_VISIONFIVE2
> >  	bool "Support StarFive VisionFive2 Board"
> >  	select BOARD_LATE_INIT
> > @@ -124,6 +127,7 @@ source "board/sophgo/milkv_duo/Kconfig"
> >  source "board/sophgo/milkv_duo_256m/Kconfig"
> >  source "board/sophgo/licheerv_nano/Kconfig"
> >  source "board/spacemit/k1/Kconfig"
> > +source "board/spacemit/k3/Kconfig"
> >  source "board/starfive/visionfive2/Kconfig"
> >  source "board/thead/th1520_lpi4a/Kconfig"
> >  source "board/xilinx/mbv/Kconfig"
> > @@ -138,6 +142,7 @@ source "arch/riscv/cpu/mpfs/Kconfig"
> >  source "arch/riscv/cpu/generic/Kconfig"
> >  source "arch/riscv/cpu/jh7110/Kconfig"
> >  source "arch/riscv/cpu/k1/Kconfig"
> > +source "arch/riscv/cpu/k3/Kconfig"
> >  source "arch/riscv/cpu/k230/Kconfig"
> >  source "arch/riscv/cpu/th1520/Kconfig"
> >  
> > diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
> > new file mode 100644
> > index 00000000000..5474ac11243
> > --- /dev/null
> > +++ b/arch/riscv/cpu/k3/Kconfig
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > +
> > +if TARGET_SPACEMIT_K3
> > +
> > +config SPACEMIT_K3
> > +	bool
> > +	select BINMAN
> > +	select ARCH_EARLY_INIT_R
> > +	select SYS_CACHE_SHIFT_6
> > +	imply CPU
> > +	imply CPU_RISCV
> > +	imply RISCV_TIMER if RISCV_SMODE
> > +	imply CMD_CPU
> > +	imply OF_UPSTREAM
> > +
> > +endif
> > diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
> > new file mode 100644
> > index 00000000000..fba4e4b0a3f
> > --- /dev/null
> > +++ b/arch/riscv/cpu/k3/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > +
> > +obj-y += dram.o
> > diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
> > new file mode 100644
> > index 00000000000..e20d35dc1bf
> > --- /dev/null
> > +++ b/arch/riscv/cpu/k3/dram.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> > +
> > +#include <fdtdec.h>
> > +#include <init.h>
> > +#include <linux/sizes.h>
> > +#include <asm/global_data.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +int dram_init(void)
> > +{
> > +	return fdtdec_setup_mem_size_base();
> > +}
> > +
> > +int dram_init_banksize(void)
> > +{
> > +	return fdtdec_setup_memory_banksize();
> > +}
> > diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
> > new file mode 100644
> > index 00000000000..1a63c73b6bb
> > --- /dev/null
> > +++ b/board/spacemit/k3/Kconfig
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > +
> > +if TARGET_SPACEMIT_K3
> > +
> > +config SYS_BOARD
> > +	default "k3"
> > +
> > +config SYS_VENDOR
> > +	default "spacemit"
> > +
> > +config SYS_CPU
> > +	default "k3"
> > +
> > +config SYS_CONFIG_NAME
> > +	default "spacemit-k3"
> > +
> > +config TEXT_BASE
> > +	default 0x102000000
> > +
> > +config SPL_OPENSBI_LOAD_ADDR
> > +	hex
> > +	default 0x100000000
> > +
> > +config BOARD_SPECIFIC_OPTIONS
> > +	def_bool y
> > +	select SPACEMIT_K3
> > +
> > +endif
> > diff --git a/board/spacemit/k3/MAINTAINERS b/board/spacemit/k3/MAINTAINERS
> > new file mode 100644
> > index 00000000000..34cf1ed4453
> > --- /dev/null
> > +++ b/board/spacemit/k3/MAINTAINERS
> > @@ -0,0 +1,8 @@
> > +SPACEMIT K3
> > +M:	Yixun Lan <dlan@kernel.org>
> > +S:	Maintained
> > +F:	arch/riscv/cpu/k3/
> > +F:	board/spacemit/k3/
> > +F:	configs/spacemit_k3_defconfig
> > +F:	include/configs/k3.h
> 
> -F:	include/configs/k3.h
> +F:	include/configs/spacemit-k3.h
> 
> > +F:	arch/riscv/dts/k3-u-boot.dtsi
> 
> -F:	arch/riscv/dts/k3-u-boot.dtsi
> +F:	arch/riscv/dts/spacemit-k3-binman.dtsi
> +F:	arch/riscv/dts/spacemit-k3-u-boot.dtsi
> 
> Note aside that K1 dtsi are listed in source tree root MAINTAINERS,
> which is probably needing to be changed separately and follow the
> example of per-board like you are doing here for K3. We are missing
> something in per-board MAINTAINERS here for
> doc/board/spacemit/spacemit-pico-itx.rst and it could be added here or
> not, it is matching anyways by the source tree root MAINTAINERS on
> 'spacemit' search.
> 
> Other modified files (with required dependency patches applied) for our
> reference:
> 
> not applicable arch/riscv/Kconfig
> drivers/clk/spacemit/Kconfig
> drivers/clk/spacemit/Makefile
> drivers/clk/spacemit/clk-k3.c
> drivers/clk/spacemit/clk_common.h
> drivers/clk/spacemit/clk_mix.c
> drivers/clk/spacemit/clk_mix.h
> drivers/clk/spacemit/clk_pll.c
> drivers/clk/spacemit/clk_pll.h
> drivers/gpio/Kconfig
> drivers/gpio/spacemit_gpio.c
> not applicable drivers/reset/Kconfig
> not applicable drivers/reset/Makefile
> drivers/reset/spacemit/Kconfig
> drivers/reset/spacemit/Makefile
> drivers/reset/spacemit/reset-spacemit-common.c
> drivers/reset/spacemit/reset-spacemit-common.h
> drivers/reset/spacemit/reset-spacemit-k1.c
> drivers/reset/spacemit/reset-spacemit-k3.c
> include/soc/spacemit/k3-reset.h
> include/soc/spacemit/k3-syscon.h
> 
> With the expectation that those drivers' patches are to be merged
> in-order before this K3 Pico-ITX series, I think this all makes good
> sense, and all dependency series will be covered by source tree root
> MAINTAINERS on 'spacemit' search.
> 
Ok, I will do some adjustment for the file name, maybe only keep
the K3 specific files..

But, I'd rather not bother to add all the files which already covered by
'spacemit' keyword imply with the top MAINTAINERS file, it would simplify
the file list a bit..

> > diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
> > new file mode 100644
> > index 00000000000..9dd545e2a3b
> > --- /dev/null
> > +++ b/include/configs/spacemit-k3.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> > +
> > +#ifndef __SPACEMIT_K3_H
> > +#define __SPACEMIT_K3_H
> > +
> > +#define CFG_SYS_NS16550_IER	0x40
> > +
> > +#define RISCV_SMODE_TIMER_FREQ	24000000
> > +
> > +#endif /* __SPACEMIT_K3_H */
> > 
> 
> Reviewed-by: E Shattow <e@freeshell.de>
Thanks for the review

-- 
Yixun Lan (dlan)
