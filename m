Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8833C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6575280F53;
	Thu, 20 Feb 2025 16:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="eXI9bt/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221AC80F42; Thu, 20 Feb 2025 16:38:38 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924D180077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3012925BFD;
 Thu, 20 Feb 2025 16:38:35 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wV5unyY0rgVr; Thu, 20 Feb 2025 16:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740065914; bh=RMCMfKP4+0g2mmfgz6Uy9xU9NMItPIZZhgFbolsR+Cs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eXI9bt/HhXBIOlorTzqJRA8f+1/mg/ux5bP0GXPvwltaXVHC0Cu27ZqhL2V/WfBua
 5pm0p/1RN9h9t1efgSZneZb3KR8iwvaMIAoDfdZaWhgaujfCNaT1NVd7tL2/Dm1Zos
 x2KN+gY3zMsT1J9xAvYYvqz3J/ZRh9RuxqItxQBESE3d3oPOWV4UwOMTmAjPrGMNQF
 jXfAZ/plK9nlPGSlTcr6s8YnJomqo6T1Yw9CJqq0ykDwDwvlY/shwObecWkd/npIvz
 b+OI8DrTpLJzjd/GBoWD8TnzDho+cdYhtbZ3f+Xjd3mKC+qud/5ripsXZ3UkR7L4mQ
 SYBatHJ968RWA==
Date: Thu, 20 Feb 2025 15:38:11 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] riscv: timer: Add thead,c900-clint compatible
Message-ID: <Z7dMY_GqLHsC-5gl@pie.lan>
References: <20250220103153.10768-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220103153.10768-1-ziyao@disroot.org>
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

On Thu, Feb 20, 2025 at 10:31:53AM +0000, Yao Zi wrote:
> Current implementation of riscv_timer.c only assumes readable TIMER CSRs
> present (IOW, Zicntr extension is available). Core Local Interruptors
> (CLINT) found on T-Head C9xx cores expose its mtime register through
> TIME CSR directly instead of a MMIO register, thus is compatible with
> the driver.
> 
> As running in S-Mode isn't necessary for the driver to operate, Kconfig
> and comments are also adapted to avoid confusion.
> 
> Reference: https://github.com/riscv-software-src/opensbi/commit/ca7810aecdba
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
> 
> This is necessary for several platforms based on T-Head C9xx to get
> system ticks, e.g. TH1520, K230 and CV1800. Tested on
> th1520-lichee-pi-4a in both M-mode and S-mode (with mainline OpenSBI).

Correction: it isn't necessary for all these C9xx platforms, since
drivers/cpu/riscv_cpu.c tries to bind a timer with the boot HART.

But there're still several problems left to solve,

1. It's really surprising to find out the driver may be manually bound
   somewhere else.
2. The comments in riscv_timer.c and its corresponding Kconfig help text
   are misleading. The driver DOES work under M-mode and there're
   already platforms depending on its behaviour in M-Mode (C9xx-based
   ones, shipping a T-Head CLINT).
3. Unconditionally binding riscv_timer driver to every "riscv"
   compatible core is technically wrong. RISC-V guarantees valid access
   to TIME CSR only when Zicntr extension exists, which isn't even part
   of the common baseline, RV64GC.
4. As a side effect of manually binding the timer driver, we lose the
   special early-stage initialization for timers in
   lib/time.c:get_ticks(). What's worse is
5. Earlytimer-related code in riscv_timer.c is conditionally compiled
   for S-mode only.

My proposal is,

- Remove the timer-binding code in drivers/cpu/riscv_cpu.c
- Correct help text and comments for riscv_timer.c, just like what has
  been done in this patch.
- Rename RISCV_SMODE_TIMER_FREQ to RISCV_EARLY_TIMER_FREQ, clean up
  preprocessor instructions that limit some functions to S-Mode only.
  They shouldn't be S-mode only stuff.
- For future RISC-V cores that are capable of reading timestamp from
  TIME CSR, we could either register the compatible string of its timer
  to riscv_timer.c (T-Head case, the underlying CLINT isn't a real
  SSTC-capable device) or add a "riscv,timer" node.

I'm willing to work on a series as RFC.

Best regards,
Yao Zi

>  drivers/timer/Kconfig       | 4 ++--
>  drivers/timer/riscv_timer.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index cb6fc0e7fda..00c4067a23b 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -241,8 +241,8 @@ config RISCV_TIMER
>  	bool "RISC-V timer support"
>  	depends on TIMER && RISCV
>  	help
> -	  Select this to enable support for a generic RISC-V S-Mode timer
> -	  driver.
> +	  Select this to enable support for a generic timer driver based
> +	  on RISC-V TIMER CSR.
>  
>  config ROCKCHIP_TIMER
>  	bool "Rockchip timer support"
> diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
> index 1f4980ceb38..3e6f0cd6d11 100644
> --- a/drivers/timer/riscv_timer.c
> +++ b/drivers/timer/riscv_timer.c
> @@ -7,7 +7,7 @@
>   *
>   * RISC-V architecturally-defined generic timer driver
>   *
> - * This driver provides generic timer support for S-mode U-Boot.
> + * This driver provides generic timer support through TIME CSR for U-Boot.
>   */
>  
>  #include <config.h>
> @@ -106,6 +106,7 @@ static const struct timer_ops riscv_timer_ops = {
>  
>  static const struct udevice_id riscv_timer_ids[] = {
>  	{ .compatible = "riscv,timer", },
> +	{ .compatible = "thead,c900-clint" },
>  	{ }
>  };
>  
> -- 
> 2.48.1
> 
