Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E3AC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 18:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B62A541008;
	Wed, 23 Sep 2026 18:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spk9rStSHMzP; Wed, 23 Sep 2026 18:02:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 50B6542310
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790186486;
	b=E7rPFSGuahKRd2Q7+Ez9fz0XWoH29E+JiNzQSNNLOMEnega7frP9gtjNPQY1EqrjTRAS
	 LxfJ5QNjfHxOQ4TyY76X+UYRqspSWHoLX+lqcJcpa44WHUgXJG5Y/LZkO8hUNOutqwtog
	 InabZcFKBzkGm2V3Q67K0NT4SZOl+Kow0DPInDAyK+XX2jcaBmGtxzRbscLj+VwV5Upqp
	 0SBGakHeiHUpiGIY5tv8vwhkIE6QtpGJ+GbmhhrN4YZmeu1MLU+RBv4JIKsUh03zlo6gp
	 c/kvxRPri0yORhFYVrM+fb3D/O0f6EMSYV55kzVIjLz/cxSSGzC49xDy0bNQ+S0JsiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790186486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dvhS1rZQp4fAn2XwWi9pM/dMKmxjh3mbwgCoy7n54v0=;
	b=AtprP9XhQo/o/PR9Qoj+c1swazNZhHFERuPli92CUSnGyhP0YZ9nt/WT0KL5ovzTAdoe
	 dk4AXI8NBuWlh62kzHR3+fD57gEU2PE6FgCptuM7d4/Rprfp753bUYT0lHYiLN3vc3OMT
	 OuQHJJfK47bYdD21CYXM/VnbtEKkRm+ivw2D9RalujfvsBgTfauCJ8ixB/LqJXKU2wKde
	 mVsjBlQVeN0sktV45GdycjcwM6TEKc3k7uAN1I6wLHyMX+261+m53YHoUN76Y1PmppZuf
	 gWgSX1+kz6wrMTUWmsqIC/IvfuEfns9dg9/EqcnQFsLrRJSp9Qd/9rwzy2I3Ze+UelA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790186486;
	bh=dvhS1rZQp4fAn2XwWi9pM/dMKmxjh3mbwgCoy7n54v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vk2I1fFG7AFkL+J7hBx9Z2c2YxAcy6lP0URdI9zu4et3yp4+5FaH2h5NVbmla87Vb
	 yj7XrK3EP1uF/Jki7xGYZLRgPcotBPj6fjt0gPdF0jHAnGvovbge1Kl6KB+TYJwY7F
	 TnLRWE5bREx9P8qdgjGk70DNaoPAMPfwUJSRXQ4UzouQnQdKnZGWI0kdSj0srB0z+0
	 WKS1VEeUZgzgzVg08Hf6cXTFsXo0yGrVJlK1ksysVL4DxkwyicEA1xI5Uxl7sIXzYK
	 y/mGgSS/mVoz6yjdEaJQ5I0C+Pf1OkCveAoE0rHuPP1CHAdV6RzSzP6jDwYgOPs9W1
	 pL1mPazwljO/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50B6542310;
	Wed, 23 Sep 2026 18:01:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F31A28C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 18:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60C2C428D9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 18:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IH-SfupxCc03 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 18:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A5AD141B6E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790186484;
 b=Si8Z/eRFYWEtpGiNaduHZXw19MWqiqL967wmrP/4SefNiJFYr8afOgCYq81CPOA6sFdB
 EA6D344I5gvs5KOeDHn11qDrY9j597jGi8+F1ekDOjar1R6nMzOqoTekXBqn5o0Qk48BK
 D2dxPNNkxX8UlRCuqsVpT+XFbFzcQXY3aoCwrbWJyq3k9Bhx24PNSDXeNy/+xB7XriEgm
 3yJ01RN9iQYuXhZTSFbM63jfsgRgvBs4LHJUzPz7S663CF2KScMI/n1XwkRvenbalVH9+
 7GmSzlkVOA8Sd9Uc8MuoZQhPq2i+TEFxr19/bVCEJTPlqE54C6oBwwblzx/+PpNAv7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790186484;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=dvhS1rZQp4fAn2XwWi9pM/dMKmxjh3mbwgCoy7n54v0=;
 b=DMAkALmw6d89B/qp/C4p37QmN5PJnUdzu0omEj29pwcZFCf++anBNpMKY3vWQhPHyUbr
 lnW8wvZ/ffRtcU+102Xi0pDpn+grAUR9hMZUfhH/MwC9JQ2qmlem1pvxJDHMnBHrKHRFa
 JD4B2ZrsfgMAN4QWYhkK+Zel/A6Q/YJqmSSLuzLATTBabwGt1JK0EGLX3ndLlBoTCgdlH
 YENVgaaUfEbffz+vmkL2rl8CaRWBbMH6Vyeh8xDxFy7zADgkSjJ9gX8gT8VHHtcSoxOsh
 sjTtCUOHlpy7yusWr58MiQACsMRT8lnetGbCUL4f37/IUMb1WLins7ogDcQjN6Q7oNA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=VxLcyN8D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=VxLcyN8D
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5AD141B6E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 18:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790186461; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fgF4BPPy3XGTqLmZF7VyChU/qg5nFHW/bOF3OnhcQcyzLTlZdIhfZdfc9Fh5e3Til2z8G2kFCjPFbZq1jgZTqcYV3e3J4OThpg1/nPHUbqiThjnbg3fwnJu+jhlUVca00GBRYjygwMF6ogM7dlfKatyX2eP3vK/08KtvXfsXS30=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790186461;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dvhS1rZQp4fAn2XwWi9pM/dMKmxjh3mbwgCoy7n54v0=; 
 b=gDB878zGifx4zw2Hp5tc5L2Js61qDu/KkO/wLohh5vwzBU1AyOkt2h9TyGKuCGTOtuU1aScrWToh4SkTjYN1KhvpPnIYS9pN8beILWSXtdg+WJzqIOLlSsNfmTUOXPKIZfb0AIPQurzbjvSGUbkkVgvpw87fsWIyRTW0aNGskAM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790186461; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=dvhS1rZQp4fAn2XwWi9pM/dMKmxjh3mbwgCoy7n54v0=;
 b=VxLcyN8DLf+ot/EZsS9LftAaj060QjKJ7DY5ARikSYjspFfbDSvYVbURqfZtrTrT
 Rdg5Mf5eR3XnNqEJ/WbmRBgxfbrnBJaWx/Ax0O+DKoU296Uzzw86r6ML9334++92e4d
 UOWO8+kB68y/EjQY161b9O3b3fL7zEsJXJkYst7g=
Received: by smtp.zohomail.com with SMTPS id 179018646002631.892375954315412; 
 Wed, 23 Sep 2026 11:01:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:00:54 +0000
From: Yao Zi <me@ziyao.cc>
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
Message-ID: <arQT1qStODRtFxPo@pie>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
 <20260923-00-basic-spacemit-k3-v1-1-fa1015f2cd1b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-1-fa1015f2cd1b@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.183.46
X-ZohoMailClient: External
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

On Wed, Sep 23, 2026 at 12:46:45PM +0000, Yixun Lan wrote:
> Add initial support for K3 Pico-ITX board, in this version, the DRAM
> information is parsed from DTS "/memory" node. And with UART enabled,
> the U-Boot serial console works fine now.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/Kconfig            |  5 +++++
>  arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
>  arch/riscv/cpu/k3/Makefile    |  5 +++++
>  arch/riscv/cpu/k3/dram.c      | 29 +++++++++++++++++++++++++++++
>  board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
>  board/spacemit/k3/MAINTAINERS |  8 ++++++++
>  board/spacemit/k3/Makefile    |  5 +++++
>  board/spacemit/k3/board.c     |  4 ++++
>  include/configs/k3.h          | 13 +++++++++++++
>  9 files changed, 117 insertions(+)

...

> diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
> new file mode 100644
> index 00000000000..203d72a5da1
> --- /dev/null
> +++ b/arch/riscv/cpu/k3/dram.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include <fdtdec.h>
> +#include <init.h>
> +#include <linux/sizes.h>
> +#include <asm/global_data.h>

Please sort the headers alphabetically.

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
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	if (gd->ram_size > SZ_2G)
> +		return gd->ram_base + SZ_2G;

What's the intention of this limitation?

> +	return gd->ram_base + gd->ram_size;
> +}

...

> diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
> new file mode 100644
> index 00000000000..bd5343be789
> --- /dev/null
> +++ b/board/spacemit/k3/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> +
> +obj-y := board.o
> diff --git a/board/spacemit/k3/board.c b/board/spacemit/k3/board.c
> new file mode 100644
> index 00000000000..29994e49ce8
> --- /dev/null
> +++ b/board/spacemit/k3/board.c
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */

I think it makes sense to omit the source if it's empty for now.

Regards,
Yao Zi
