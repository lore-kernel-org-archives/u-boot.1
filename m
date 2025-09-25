Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB600CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 16:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C38A80107;
	Thu, 25 Sep 2025 18:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB48080819; Thu, 25 Sep 2025 18:27:32 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30EC800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 18:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.29]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 12D2FB2201D7;
 Thu, 25 Sep 2025 18:27:27 +0200 (CEST)
Message-ID: <9113dd29-b862-4722-96d7-ad6d51219050@freeshell.de>
Date: Thu, 25 Sep 2025 09:27:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: Add a Zalrsc-only alternative for
 synchronization in start.S"
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250925160148.21624-1-ziyao@disroot.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250925160148.21624-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/25/25 09:01, Yao Zi wrote:
> This reverts commit a681cfecb4346107212f377e2075f6eb1bdc6a2b.
> 
> It has been reported that the commit causes boot regression for SPL on
> StarFive VisionFive 2 or compatible boards. Inspecting the code, I did
> spot one logic error for deciding whether Zaamo or Zalrsc is used, and
> it's still unclear what exactly causes the regression, let's revert it
> for now.
> 
> Reported-by: E Shattow <e@freeshell.de>
> Link: https://lore.kernel.org/u-boot/1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de/
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
> 
> The original series causing the problem[1] contains 3 patches, and I
> think it should be enough to revert the change of start.S only, since
> the others touch no code, and should be relatively safe. I'll fix the
> reverted change up and get it work on VisionFive 2 when I got my new
> board. Sorry for the inconvenience.
> 
> [1]: https://lore.kernel.org/u-boot/20250902081932.21103-1-ziyao@disroot.org/
> 
>  arch/riscv/cpu/start.S | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index 6324ff585d4..7bafdfd390a 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -151,15 +151,8 @@ call_harts_early_init:
>  	 */
>  	la	t0, hart_lottery
>  	li	t1, 1
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
>  	amoswap.w s2, t1, 0(t0)
>  	bnez	s2, wait_for_gd_init
> -#else
> -	lr.w	s2, (t0)
> -	bnez	s2, wait_for_gd_init
> -	sc.w	s2, t1, (t0)
> -	bnez	s2, wait_for_gd_init
> -#endif
>  #else
>  	/*
>  	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
> @@ -184,12 +177,7 @@ call_harts_early_init:
>  #if !CONFIG_IS_ENABLED(XIP)
>  #ifdef CONFIG_AVAILABLE_HARTS
>  	la	t0, available_harts_lock
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
> -#else
> -	fence	rw, w
> -	sw	zero, 0(t0)
> -#endif
>  #endif
>  
>  wait_for_gd_init:
> @@ -202,14 +190,7 @@ wait_for_gd_init:
>  #ifdef CONFIG_AVAILABLE_HARTS
>  	la	t0, available_harts_lock
>  	li	t1, 1
> -1:
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> -	amoswap.w.aq t1, t1, 0(t0)
> -#else
> -	lr.w.aq	t1, 0(t0)
> -	bnez	t1, 1b
> -	sc.w.rl t1, t1, 0(t0)
> -#endif
> +1:	amoswap.w.aq t1, t1, 0(t0)
>  	bnez	t1, 1b
>  
>  	/* register available harts in the available_harts mask */
> @@ -219,12 +200,7 @@ wait_for_gd_init:
>  	or	t2, t2, t1
>  	SREG	t2, GD_AVAILABLE_HARTS(gp)
>  
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
> -#else
> -	fence	rw, w
> -	sw	zero, 0(t0)
> -#endif
>  #endif
>  
>  	/*

Argument in favor of reverting three patches in the series are as: I do
not understand the use of invisible config symbols in this way for a
transition of something so dependent on toolchain implementation. How
would I express this from menuconfig selections without directly editing
symbols in the config ?

I only have some JH7110 boards (and one EIC7700X there is not U-Boot for
this upstream yet) that I can offer to do some testing for, what all
hardware for should this affect?  It's every riscv board ?

Anyhow a revert of this one patch in the series is the minimum to
restore working SPL for starfive visionfive2 (as Star64, and Mars
CM/Lite). Thanks, Yao!

Acked-by: E Shattow <e@freeshell.de>

