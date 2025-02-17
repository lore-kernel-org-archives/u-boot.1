Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862A3C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 21:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E950380BAE;
	Mon, 17 Feb 2025 22:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Tl8etUWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9703C80F0A; Mon, 17 Feb 2025 22:17:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4747B8083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 22:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739827054;
 bh=rEX9xbFAN9C1bjz7H8/q0D66fzc4F19Bh9h1a+e2EhU=;
 b=Tl8etUWblhB/1XPEmrwzKBrxfID5Ydg4IQ2FoEngz23hM8nWgyDHaGt8oW6MI2a5u07dA/j5X
 aT0xXc5ugEKZ9Dd7MawXwztT4Y6d8oBm4wBu8d4ykGB9MPHNJquTP8S/Ko+xeqhVGfXsexr1aUJ
 nSGYy2h2UPmM1XDsDKoUDKbQ3Hfs7x8ugRvY7BGBgJL22TELG1I/FqXTPSPR0iuIxRyqtDK6QgP
 3vnENLDBU2InqEbl6wVrY0hi7B51mDSz53/xr4jYqXy1T9TPJvTk8ai5lFqAo0Li9Nr3oKT+QH4
 1rF6CDfsi4GIyGsD4KYD4DYjnUfIwnsZrLoW9dnomOeA==
X-Forward-Email-ID: 67b3a76a179e723bb8e57691
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c24f369c-e675-4095-bcc8-6e17f5df2162@kwiboo.se>
Date: Mon, 17 Feb 2025 22:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/35] spl: Use CONFIG_VAL() to obtain the SPL stack
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Leo <ycliang@andestech.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rick Chen <rick@andestech.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-4-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-4-sjg@chromium.org>
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

Hi Simon,

On 2025-02-09 22:14, Simon Glass wrote:
> Now that we have the same option for SPL and VPL, simplify the logic for

I suspect you mean TPL here?

> determining the initial stack.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
> 
> Changes in v2:
> - Add new patch to use CONFIG_VAL() to obtain the SPL stack
> 
>  arch/arm/cpu/armv7/lowlevel_init.S | 4 ++--
>  arch/arm/cpu/armv7/start.S         | 4 ++--
>  arch/arm/lib/crt0.S                | 6 ++----
>  arch/arm/lib/crt0_64.S             | 6 ++----
>  arch/riscv/cpu/start.S             | 4 ++--
>  5 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
> index c2a0fe061a3..72b7b7d082c 100644
> --- a/arch/arm/cpu/armv7/lowlevel_init.S
> +++ b/arch/arm/cpu/armv7/lowlevel_init.S
> @@ -26,8 +26,8 @@ WEAK(lowlevel_init)
>  	/*
>  	 * Setup a temporary stack. Global data is not available yet.
>  	 */
> -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> -	ldr	sp, =CONFIG_SPL_STACK
> +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> +	ldr	sp, =CONFIG_VAL(STACK)
>  #else
>  	ldr	sp, =SYS_INIT_SP_ADDR
>  #endif
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 3394db46953..959251957de 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -279,8 +279,8 @@ ENTRY(cpu_init_cp15)
>  	orr	r2, r4, r2		@ r2 has combined CPU variant + revision
>  
>  /* Early stack for ERRATA that needs into call C code */
> -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> -	ldr	r0, =(CONFIG_SPL_STACK)
> +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> +	ldr	r0, =CONFIG_VAL(STACK)
>  #else
>  	ldr	r0, =(SYS_INIT_SP_ADDR)
>  #endif
> diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> index 007e89407a8..8ef18ce17e4 100644
> --- a/arch/arm/lib/crt0.S
> +++ b/arch/arm/lib/crt0.S
> @@ -100,10 +100,8 @@ ENTRY(_main)
>   * Set up initial C runtime environment and call board_init_f(0).
>   */
>  
> -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> -	ldr	r0, =(CONFIG_TPL_STACK)
> -#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> -	ldr	r0, =(CONFIG_SPL_STACK)
> +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> +	ldr	r0, =CONFIG_VAL(STACK)

This changes behavior, prior to this the the SPL_STACK would be fallback
for TPL. Now this will only fallback to SYS_INIT_SP_ADDR. Is this
intentional and/or will this affect any board?

>  #else
>  	ldr	r0, =(SYS_INIT_SP_ADDR)
>  #endif
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 1b6782b06ed..30950ddaf9b 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -69,10 +69,8 @@ ENTRY(_main)
>  /*
>   * Set up initial C runtime environment and call board_init_f(0).
>   */
> -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> -	ldr	x0, =(CONFIG_TPL_STACK)
> -#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> -	ldr	x0, =(CONFIG_SPL_STACK)
> +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> +	ldr	x0, =CONFIG_VAL(STACK)

Same here, this changes behavior and should be mentioned in the commit
message.

Also this and two preceding patches deserve their own series, especially
since this changes behavior.

Regards,
Jonas

>  #elif defined(CONFIG_INIT_SP_RELATIVE)
>  #if CONFIG_POSITION_INDEPENDENT
>  	adrp	x0, __bss_start     /* x0 <- Runtime &__bss_start */
> diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> index c8526dd82fd..7bafdfd390a 100644
> --- a/arch/riscv/cpu/start.S
> +++ b/arch/riscv/cpu/start.S
> @@ -90,8 +90,8 @@ _start:
>   * Set stackpointer in internal/ex RAM to call board_init_f
>   */
>  call_board_init_f:
> -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> -	li	t0, CONFIG_SPL_STACK
> +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> +	li	t0, CONFIG_VAL(STACK)
>  #else
>  	li	t0, SYS_INIT_SP_ADDR
>  #endif

