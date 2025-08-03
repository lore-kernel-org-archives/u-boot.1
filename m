Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B797C87FD3
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 01:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A05183CAA;
	Sun,  3 Aug 2025 03:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B49583CC7; Sun,  3 Aug 2025 03:21:33 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E8583C91
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 03:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.147.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 8258D340D2E;
 Sun, 03 Aug 2025 01:21:27 +0000 (UTC)
Date: Sun, 3 Aug 2025 09:21:23 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] riscv: Add a Zalrsc-only alternative for
 synchronization in start.S
Message-ID: <20250803012123-GYA937293@gentoo>
References: <20250802092155.40915-1-ziyao@disroot.org>
 <20250802092155.40915-3-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802092155.40915-3-ziyao@disroot.org>
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

Hi Yao,

On 09:21 Sat 02 Aug     , Yao Zi wrote:
> Add an alternative implementation that use Zalrsc extension only for
> HART lottery and SMP locking to support SMP on cores without "Zaamo"
> extension available. The Zaamo implementation is still used by default
> since since the Zalrsc one requires more instructions.
~~~~~~~~~~~~~two 'since'

to slightly improve it..
.., The Zaamo implementation is prioritized selected if both extension available,
since the Zalrsc one requires more instructions.

while I can understand the logic, but if we interpret from the code below,
it's a little bit weird:
 if (RISCV_ISA_ZAAMO) not enabled:
 	use zalrsc implementation

instead of 
 if (RISCV_ISA_ZALRSC) is enabled:
 	use zalrsc implementation

I mean, to select Zalrsc implementation, enabling RISCV_ISA_ZALRSC is not enough,
but RISCV_ISA_ZAAMO should be explicitly disabled, in fact RISCV_ISA_ZALRSC is
superfluous here

make it further, it would be great if we could do some Kconfig sanity check..
(I have one more comment for configs/ibex-ast2700_defconfig in patch 1/2)

> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/cpu/start.S | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index 7bafdfd390a..6324ff585d4 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -151,8 +151,15 @@ call_harts_early_init:
>  	 */
>  	la	t0, hart_lottery
>  	li	t1, 1
> +#if CONFIG_IS_ENABLED
>  	amoswap.w s2, t1, 0(t0)
>  	bnez	s2, wait_for_gd_init
> +#else
> +	lr.w	s2, (t0)
> +	bnez	s2, wait_for_gd_init
> +	sc.w	s2, t1, (t0)
> +	bnez	s2, wait_for_gd_init
> +#endif
>  #else
>  	/*
>  	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
> @@ -177,7 +184,12 @@ call_harts_early_init:
>  #if !CONFIG_IS_ENABLED(XIP)
>  #ifdef CONFIG_AVAILABLE_HARTS
>  	la	t0, available_harts_lock
> +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
> +#else
> +	fence	rw, w
> +	sw	zero, 0(t0)
> +#endif
>  #endif
>  
>  wait_for_gd_init:
> @@ -190,7 +202,14 @@ wait_for_gd_init:
>  #ifdef CONFIG_AVAILABLE_HARTS
>  	la	t0, available_harts_lock
>  	li	t1, 1
> -1:	amoswap.w.aq t1, t1, 0(t0)
> +1:
> +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +	amoswap.w.aq t1, t1, 0(t0)
> +#else
> +	lr.w.aq	t1, 0(t0)
> +	bnez	t1, 1b
> +	sc.w.rl t1, t1, 0(t0)
> +#endif
>  	bnez	t1, 1b
>  
>  	/* register available harts in the available_harts mask */
> @@ -200,7 +219,12 @@ wait_for_gd_init:
>  	or	t2, t2, t1
>  	SREG	t2, GD_AVAILABLE_HARTS(gp)
>  
> +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
> +#else
> +	fence	rw, w
> +	sw	zero, 0(t0)
> +#endif
>  #endif
>  
>  	/*
> -- 
> 2.50.1
> 

-- 
Yixun Lan (dlan)
