Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283CCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 20:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C52F836C8;
	Thu, 16 Oct 2025 22:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459A7836D1; Thu, 16 Oct 2025 22:44:38 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0746F836C1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 22:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.134])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0FE6FB220119;
 Thu, 16 Oct 2025 22:44:33 +0200 (CEST)
Message-ID: <43872d3c-475d-484d-9709-4ad810bcaaaa@freeshell.de>
Date: Thu, 16 Oct 2025 13:44:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
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

Hi Heinrich, thank you for your attention to this.

On 10/16/25 09:58, Heinrich Schuchardt wrote:
> Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
> synchronization in start.S") changed the hart synchronization in start.S.
> It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
> use. If the macro evaluates to true the old behavior is maintained.
> 
> The macro evaluates to false for SPL builds which was unintended. Use
> IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
> 
> This fixes a boot failure on StarFive JH7110 based boards.
> 
> Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/cpu/start.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index 6324ff585d4..87b3ff0f93f 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -151,7 +151,7 @@ call_harts_early_init:
>  	 */
>  	la	t0, hart_lottery
>  	li	t1, 1
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>  	amoswap.w s2, t1, 0(t0)
>  	bnez	s2, wait_for_gd_init
>  #else
> @@ -184,7 +184,7 @@ call_harts_early_init:
>  #if !CONFIG_IS_ENABLED(XIP)
>  #ifdef CONFIG_AVAILABLE_HARTS
>  	la	t0, available_harts_lock
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
>  #else
>  	fence	rw, w
> @@ -203,7 +203,7 @@ wait_for_gd_init:
>  	la	t0, available_harts_lock
>  	li	t1, 1
>  1:
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>  	amoswap.w.aq t1, t1, 0(t0)
>  #else
>  	lr.w.aq	t1, 0(t0)
> @@ -219,7 +219,7 @@ wait_for_gd_init:
>  	or	t2, t2, t1
>  	SREG	t2, GD_AVAILABLE_HARTS(gp)
>  
> -#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> +#if IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO)
>  	amoswap.w.rl zero, zero, 0(t0)
>  #else
>  	fence	rw, w

I confirm this restores Pine64 Star64 (JH-7110) SPL boot in origin/next

Are we reverting the bad commit or papering over it with a fix?

Ref. "Revert "riscv: Add a Zalrsc-only alternative for synchronization
in start.S":

https://lore.kernel.org/u-boot/aOylBeAxyoKuPJYa@pie/

In any event, for this patch,

Tested-by: E Shattow <e@freeshell.de>
