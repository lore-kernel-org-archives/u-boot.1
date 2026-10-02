Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FECCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA44940CD5;
	Fri,  2 Oct 2026 11:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSuKJ1Ly3dlF; Fri,  2 Oct 2026 11:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E5FE440BB3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790941424;
	b=CyjSZ9XH9fJ+syM7QNsGiDAV3OCnfzcYEhJ9Oefi53M9er9NJjjzD1Q2WGNjKWiWzO1S
	 usIllpQ4n3dlQLRBxIwkowW8VzQoHBF2Fd7lBI269BtZBghk6ZfBdqJU9iyCeBlh5mw3L
	 uvorHmnjZ76A+s93CMrNs7GZ2Sbhz3JaUSpy00A//KMITfk8L+HXQEXFxupOhVQlpaPAp
	 +mbr00AhWyzpwtSONZp6F9gjrdvzRA0DRNL6KF0DWS4UlayqXeaN6ZUkI/aEniFDHwRDx
	 JiBcQPHCeS29DXN6e4EmdKNl+BCBtu04iYFJbyNzsiIvJS2H4AU3diQoAJzLdiFY0Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790941424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YE71aJhGfwq+6wYvRufQ9O350Pb76i68/MpWs7tqt0I=;
	b=AkLzDFchHARJKOpUV7I0KAoTsLQdwvW+NvDlZ/FbVrLcughiOnwiZKuZOM0+7FgfYmHu
	 zSIbpwCv3sSU25tV3xNQzsB1EU90BM1hmcdTBLQeNovKKVIrPKtb/QKZ+zB+XoJWURS/i
	 NEVk1Scc1UJFV29tFBhb1TAimoBEYjJ9OG+dG3fudtx/MCRkQWHArWQ5aUPV56vombvIr
	 r4XczhRsLR/ytE16BNkd9ugN/xHSFxEeFfFng5ndFNK2sE1+yDr2hDPeEwNAV69PRITgw
	 Zg/V+fkocEx/MBoepK7meyQnNNX3w5T37Erl9DzkzRX6F19aA6aNNMaUWPldXAb2sPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790941424;
	bh=YE71aJhGfwq+6wYvRufQ9O350Pb76i68/MpWs7tqt0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mw4PMzmpYGoAsyGDpR9Lk06K6BryeBqfrnrzDyBr6mTyU45oJzceerYJP4Dlkojl/
	 icJHYbwELERyTcv/Wh3MXPwEPVADB5BbnNwzRSe0CsPlPpPhRKd8jB5MnKy6aK0ufc
	 KrqsTQelBGqSlK7H8u9cs2pqtidov0zr/FAtd1fln2XFKc3D4gxMDexvNZ4v3RhPG2
	 Esmu/1F6+X3fUkMNROlgX1QKS5UoGENM2NWCt9By61in3w9mq18hqoeCCxdX79nJjb
	 Rs+KwXXQa7wIcnb+qYu83FrIdz2uA9ianaaj4+rNXBVuO3qXPvFFLEcKOK0WMsfmQp
	 EHsT/r2Qvfkvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5FE440BB3;
	Fri,  2 Oct 2026 11:43:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 651F632F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AE2440059
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbS1Xt3nhHIq for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6C72F4004A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790941421;
 b=IxYR+IzWlSEeZbrAVDF7ATHZQjXJbVy5/N1msh3tGx7JCnpqLLYQ4o8i94m6hROTOFb2
 xDXRoGlvzxXAlfR3FGrd/wvDwCHtqDTL2fVeJauwyoUQ6vmPXMlww0dW8b6OdTUN6B7wE
 zeVJ92DUTadyNxJNRYBXyXD3/Hhdf1fYg/FCyNtuTy9TR/e4X7t3jyRIu7gMcsKjcKEER
 mAJd8SPl8O6Xr0Me56jAAmxs8sCNjvT4H/Kwd/0e4fcE2ZoQmLzlSaceycMX1/Jybu3lf
 5lOqReOEFNN8qpYzd/Gke2bYYxmvdipGGi71tSAD0cIshJtJlYGQHCfENW1/yoJCZHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790941421;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=YE71aJhGfwq+6wYvRufQ9O350Pb76i68/MpWs7tqt0I=;
 b=IuPT+hx5E3gKw/6EBYo2wg2+MWdRXtU+2S9afMX04eSz1kazstuRRek3JKJxu6MZqIsw
 DjHyWfV0km28Q6hmlAXoNSVNL+O7hrVjGXO6Fyih+6Nj2sV4r78ymwW1D8jEHk8rNUxxG
 +VQzDReG7TXq1vzSKRq1Ud8vw/Ttf4mHoLjuEZl6jWpeYfE8kpm0HYVfOmnVoW37n7U0a
 yDajYWhbmDr7AafxGEs/q5TbjQUJLZHpyfh6iYdQY0lzONSONrw7QLLFVoW5a+Syzg351
 qhcYLNm3UdL5q+PlA2C9DL5I1J+K1EJEQgexWLAVqfIMWph8h6LmsViXUpxTn6KZdHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BU6F+XHN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BU6F+XHN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C72F4004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:43:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 949AC60A70;
 Fri,  2 Oct 2026 11:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B111F000FF;
 Fri,  2 Oct 2026 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790941418;
 bh=YE71aJhGfwq+6wYvRufQ9O350Pb76i68/MpWs7tqt0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BU6F+XHNaabtmcewvQstojJS6VSW2/TwfgK8nNsOL4AKDEHuoWg4rb3yDJycz724h
 U6tubMHVaPLNTi2srZM1MaNaw6bjgAvwrjaYw30jRQieW/bHU0E4mNi4Ru/i7OKOhO
 ZT7Xh9vx9pSK7+LWtNbTNhU3bPfmU9ozczdmUUYAHdo87rBLSE0QhKeJKmkMACpP+r
 r4jGsCTKAUjgkNKyg9ett1TT+/pkqgB/mfX/zXZ6qYLWJcexU1HW3W1odc0P//2Rej
 ZlMXUNU2kzpQ6aXpsiZHX1cyrdxP2shHmi+k1rjmhu5cs51Z1EJ7ceb+uO6LEbtgzw
 gK6AKTEXwk9ZQ==
Date: Fri, 2 Oct 2026 11:43:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
Message-ID: <20261002114334-GKF51329@kernel.org>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
 <20261002-00-basic-spacemit-k3-v2-1-fd6779a0317c@kernel.org>
 <20fc5895-ac3a-4516-b302-7f1893dc370d@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20fc5895-ac3a-4516-b302-7f1893dc370d@freeshell.de>
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

On 00:02 Fri 02 Oct     , E Shattow wrote:
> Hi Yixun,
> 
> On 10/1/26 18:03, Yixun Lan wrote:
> > Add initial support for K3 Pico-ITX board, in this version, the DRAM
> > information is parsed from DTS "/memory" node. And with UART enabled,
> > the U-Boot serial console works fine now.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  arch/riscv/Kconfig            |  5 +++++
> >  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
> >  arch/riscv/cpu/k3/Makefile    |  5 +++++
> >  arch/riscv/cpu/k3/dram.c      | 21 +++++++++++++++++++++
> >  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
> >  board/spacemit/k3/MAINTAINERS |  8 ++++++++
> >  include/configs/k3.h          | 13 +++++++++++++
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
> > index 00000000000..b0e423d829c
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
> > +	default "k3"
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
> > +F:	arch/riscv/dts/k3-u-boot.dtsi
> > diff --git a/include/configs/k3.h b/include/configs/k3.h
> > new file mode 100644
> > index 00000000000..83e4945d2b3
> > --- /dev/null
> > +++ b/include/configs/k3.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> > +
> > +#ifndef __CONFIG_H
> > +#define __CONFIG_H
> > +
> > +#define CFG_SYS_NS16550_IER	0x40
> > +
> > +#define RISCV_SMODE_TIMER_FREQ	24000000
> > +
> > +#endif /* __CONFIG_H */
> > 
> 
> There is a Texas Instruments K3 SoC referred to as "k3" in u-boot
> discussion. Let's not add to the confusion here on a global include file
> that is named "configs/k3.h"
> 
> Please rename "include/configs/k3.h" as "include/configs/spacemit-k3.h"
> or "include/configs/spacemit_k3.h" to be consistent with the target
> defconfig name. "k1.h" global config header name may be renamed later
> when development pace slows that it would not be too disruptive, and to
> follow whatever hyphen or underscore delineation is decided for K3.
> 
make sense, I will pick "spacemit-k3.h" as the config file name

-- 
Yixun Lan (dlan)
