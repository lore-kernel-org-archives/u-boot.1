Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9815DC9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 01:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE9960850;
	Thu, 24 Sep 2026 01:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57FFx0Br92Cr; Thu, 24 Sep 2026 01:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 740A860890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790212897;
	b=sBf3yMXcDHR4IpHtMWt4qGQsFqFTJ4ygN81AiKr2SIfl+puLMmSUeaEs/D6zT62/tOpb
	 nySOd0jaEoc9m39nah/eV4CH+Ftu/BiHLAK/hXdKALml5YG47vRndZIatYKC8gmzWwD5/
	 hBqNL+sWZoa/VQcp9ewmLS2pL5URuqzkueSFE5ag6/5p6WpPZwhizjanLHyq3wRFuWgKQ
	 1I6acsWPgyXqy63GexbyIAYhzY01PhlUgMn3mkeeGdoY/Nvb3z5/ElhDVMJ+qiYe9QqvM
	 cCsmpem6+L+JM7HqG2B6yYLjjmnIrp3fW9cO02BJXYg22qtJE5UaI7TBmvcOzSwlq/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790212897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5c83uY84avV9q6tELR+Xb94Oof4J6UU2ltpJ3ERm4vo=;
	b=D/+XxqNEWKQyaLXUreSUIBrpw6N+limg1Zp3k5XV6hPe8RAEoxT12jzFIbxUvnpDwLB0
	 i6EPussmlBEjVbeCBYhsdZFyAmcDj0lOHTtL/X4YIbMkbiLDoyuplieV2glKaL/ZAwu2X
	 vEaWIY3pHNUvVZiVHd+Kye4xaY1FKe2uxJORX58vLHXuAtiFuHpEDW1EqOqny8dWPNE13
	 TuAAQigw1qhzbrGNxDv64QGMQTUL8ErZwh9fLzxO3mQwb3V9kszvxl0WhoiPZfmug10Wm
	 vyqhGjQyDvBdjHBD1sy6yNEfywD5iOirwbzM6NL30TnG4UZbE4rXj5BCC5gYnZm+EPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790212897;
	bh=5c83uY84avV9q6tELR+Xb94Oof4J6UU2ltpJ3ERm4vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KSkwBeV3TwKtskr7dUOj70QJcdKmW5qNxHSLiqRkpUhglQpkRzewj9M0PG1Yg7g1H
	 1hL5OrPZgU+DPoS5rDA5z+hv4tjyj6iImwqUIpXCTymNxRhNv/FO6FlP7mUdiP0oaX
	 YMMGMGrHkptt6dCrvDS0XgHzwktXs9AgZCIbK8nhu0wK6VI09sT0CTRtwcJQlvmpZk
	 xG05MOtcAHjU8y/pIfK9U1gARw0sxLXLpDpRlToBuNhfl8W08o+0DvlFQ32ssyKEVH
	 Qzrdo7GwZGEO3atmZxMA/l9wzPsNjFxaPgDHCOaNX1AL4WzlPV13GBAKAsaJFv4jZQ
	 OCuNiAvEXky9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 740A860890;
	Thu, 24 Sep 2026 01:21:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C93852F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A651E81A15
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hV8q7R47P0hp for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:21:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F0ABD81A12
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790212895;
 b=J3zXZ/sMGnPYd7OiJO5q58WaTfUcrtHfFi/6rvq65gLf8c74mL6KVCJXTwN6KOmPeo6q
 E11y01R1Spows2bRoJERYT89FhcYW+oLgghIxuT071b4mJ6N9M62wTT2bqhRJIIzZTAvj
 8AU3oD47cXy0mUQDh1S0FZqAVlpit2b7InZy6GVDDt+bsy03ik7BqcLrMH24lpm6kZVQy
 6wQeZ0za9gi2MZza1j9EyfLD3ntDKGVuBLxuzg/NxguEoBJ3wQMmlHCzTe05ZkhCIu03d
 kHAP1k3y/kvzPMRGDGhz7/Nb8CGqusr9X7ah5yU1+VJj0LNc1ncE2DyDcMDP+t4y2NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790212895;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=5c83uY84avV9q6tELR+Xb94Oof4J6UU2ltpJ3ERm4vo=;
 b=NeFgpJlZOdgnTdkRXNEtfa3tV4cGKwGWU9n+KjVzR+/WNcMeRR/q3mP5ofA4s8GMFG4m
 4agvEnLRu/aUVW95LnuEEwwB8Fd7pt6ZPaKRW2WnTHbRQ8Br33XZDJ97B7j+yVXQeQ/aU
 Od5uAi9qpzKTiTywTevcurfbG6JaS3t3Funk0LdW13ZRHQnfkS+m7BN6Ht/CAGx3+QNo5
 Fdqy3L8VxJUl67qclCFVve59PSL8UbJRATu3Yss1geH7S31c9oDBmP3bZHB63F876+ZaX
 DMi7ctu6q1ovRD0BsV6Lbv82Fx+GZiGtVVmqje9OlYwbQMHDGS/oh6hD+RnI5O/nV5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fIQZkEB7; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fIQZkEB7
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0ABD81A12
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:21:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 271D2433CB;
 Thu, 24 Sep 2026 01:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA641F000FF;
 Thu, 24 Sep 2026 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790212894;
 bh=5c83uY84avV9q6tELR+Xb94Oof4J6UU2ltpJ3ERm4vo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fIQZkEB7VwrOnBHkJyh8o7hLr+78dsePpfSEgyihy6nC0RjY02R1Y6IyXf6mzL4bi
 +m3NxOLvBH0jrgKzJ4N8KsG0ZPmhoIpMM2FDUp1x5QIhg5652ym16B3iM3yFxqiQtd
 kFgVxJKHpGg6W/0UG+ozWbnzHmaV2+MJEYebOERnlcrxX11kaV13n0NHybj22n6y3T
 UPuefCtOclPAjOpdq4D0JINBiTcDTn7O6N5OSHOQodB5H5vPbUVIW5LlOE66+oQ/cF
 z9QDWCba5GDYakt2iHytNWVWoEGVe9nFtR59pk478SquxPIe9mAFcI7C5PjHPVkkOH
 ju+G9Zoz3fPoQ==
Date: Thu, 24 Sep 2026 01:21:31 +0000
From: Yixun Lan <dlan@kernel.org>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
Message-ID: <20260924012131-GKG353745@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
 <20260923-00-basic-spacemit-k3-v1-1-fa1015f2cd1b@kernel.org>
 <arQT1qStODRtFxPo@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arQT1qStODRtFxPo@pie>
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

Hi Yao,

On 18:00 Wed 23 Sep     , Yao Zi wrote:
> On Wed, Sep 23, 2026 at 12:46:45PM +0000, Yixun Lan wrote:
> > Add initial support for K3 Pico-ITX board, in this version, the DRAM
> > information is parsed from DTS "/memory" node. And with UART enabled,
> > the U-Boot serial console works fine now.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  arch/riscv/Kconfig            |  5 +++++
> >  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
> >  arch/riscv/cpu/k3/Makefile    |  5 +++++
> >  arch/riscv/cpu/k3/dram.c      | 29 +++++++++++++++++++++++++++++
> >  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
> >  board/spacemit/k3/MAINTAINERS |  8 ++++++++
> >  board/spacemit/k3/Makefile    |  5 +++++
> >  board/spacemit/k3/board.c     |  4 ++++
> >  include/configs/k3.h          | 13 +++++++++++++
> >  9 files changed, 117 insertions(+)
> 
> ...
> 
> > diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
> > new file mode 100644
> > index 00000000000..203d72a5da1
> > --- /dev/null
> > +++ b/arch/riscv/cpu/k3/dram.c
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> > +
> > +#include <fdtdec.h>
> > +#include <init.h>
> > +#include <linux/sizes.h>
> > +#include <asm/global_data.h>
> 
> Please sort the headers alphabetically.
> 
Ok, will do

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
> > +
> > +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> > +{
> > +	if (gd->ram_size > SZ_2G)
> > +		return gd->ram_base + SZ_2G;
> 
> What's the intention of this limitation?
> 
This is a copy & paste from k1's implementation while K1 has discrete
memory layout which 0x8000 0000 - 0xFFFF FFFF is iomem space

For K3, there is no such problem, so no need this function
> > +	return gd->ram_base + gd->ram_size;
> > +}
> 
> ...
> 
> > diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
> > new file mode 100644
> > index 00000000000..bd5343be789
> > --- /dev/null
> > +++ b/board/spacemit/k3/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > +
> > +obj-y := board.o
> > diff --git a/board/spacemit/k3/board.c b/board/spacemit/k3/board.c
> > new file mode 100644
> > index 00000000000..29994e49ce8
> > --- /dev/null
> > +++ b/board/spacemit/k3/board.c
> > @@ -0,0 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> 
> I think it makes sense to omit the source if it's empty for now.
> 
Ok, fair

-- 
Yixun Lan (dlan)
