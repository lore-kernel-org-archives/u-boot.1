Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1016606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kLhU9aes;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZPTsJDP0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C10F60E24;
	Thu, 19 Nov 2026 23:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59_KyJaRr_hu; Thu, 19 Nov 2026 23:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4EDD60E02
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795132430;
	b=lvTxkmz71e2qk14qKRFkKP1LokmXYycj1kwMbPR+Ua0MJMvABmbX9/X1u5aHKVmpMecU
	 VVEB5Eh1PRvSjguQMdlr8mBcmYuqOAF+QmSSUmmKwX+9Mh4Mody2OcPSwdVONr7lrBOxm
	 yMF1U9Jf+qR0CYO/b/AQMBzP8Q9MOsC5OROK8fDcC6hd+esWp0RBUvSaVezM6pT3/L/0G
	 DE+KtA1NdMjXP0zZoxh5sHP3m5FBRf6iqKW+fJBfn/qcWodijXcbifyhxYafpBJ8y/cW9
	 F2wllOtZug3cVCvp3cvBLUKHrlif51JIbf2oX99S1fNxIbaDIDc1SXknfOvvPymnD7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795132430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IEitIFap97KmvaXqdHu+ii6zs4gd2ysbau7K9cNXPFM=;
	b=poW5VinB2zVluKmjjf4Pj93jEGbcKEl2xFTJ22AqiF42skcESQEEEE4rjNjaxilcvxsT
	 wuoOAEMxKLafExb/4dVr4nmhtDgGfG+u40ZAbEuvGGggTRZFcxBbDpJTTDuSFMplstRAC
	 bDIzSpYdUln1yYIokGNAD89o2VsQ94mfHnhG0gf2BgHZCJEkanqPseu3twR6Ht2h2HzC3
	 4Q7YBYB/fvqs1XPkaif8pk1XBe0DtzLY6G0DhQXmK+5e4yPmhddy7yp2M2ZI11Mdb5Wh9
	 9ztf6cA+01nX81tUq6A+Y0aFE3DpF36QhN54WmGyfYHSXmQvyTrgBmwzzUKSCM8GrAQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795132430;
	bh=IEitIFap97KmvaXqdHu+ii6zs4gd2ysbau7K9cNXPFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLhU9aesj8hKFfTYoVJvl/OeFBNqMMsr2m7BlWP5m4nZuwrOrMwv0Vl5mM9L6FReQ
	 F2rLLuDBT1NkKmNz9HwnjPv6KIQezCDCVkEey02qXnZBQOpuG4+TJOJfnr4pjdbStr
	 CzLH7VLcutUq/fu1gXvNMMTq6YF4JDRG0BIAxILGdGtvbn/YoroFMiR/sof25NtE1Q
	 wUFu4qP5XwdU/DnxmpxJUmP/kGqd37ZhDJgvpqUrQL/HYrsAhe0mZRCMnTF3UqO8XC
	 IEphe6afi146vYLwSKAmN7fjv+hWlJejDzIIBYG902u3KXLc/pSKqpjFnYF64ZzzFr
	 EJBNWxr4c/zSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4EDD60E02;
	Thu, 19 Nov 2026 23:53:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 867BB79D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78EC940079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ir_eU4fyfb5F for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F55A40063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=ZPTsJDP0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F55A40063
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:53:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71B1D1575;
 Thu, 19 Nov 2026 15:53:42 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2EBE3F673;
 Thu, 19 Nov 2026 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795132425; bh=TC4Dernl1/GH7u4VxyU0Gf4ERUci7FTb9wgAML5+al8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZPTsJDP0xb85sntTGLI1+AHCNNjJxOsrlDXkXCd2/n9AGh2BIfJ75V6DwCw5cnVY3
 vy/xYbtWKMlKNI1e5cnIG//xX25c5zBJBOfp9h4tTa9Co13D0DFpkJF7Pf5XanNcS/
 6i3+kXypq+9UGZjWilFuucqMAn0OIjhMZG4aIctc=
Date: Fri, 20 Nov 2026 00:53:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>, Yixun Lan
 <dlan@gentoo.org>, Enzo Adriano <enzo.adriano.code@gmail.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 13/26] sunxi: fel: Add Allwinner A733 ERET FEL return
 support
Message-ID: <20261120005334.655e5170@ryzen.lan>
In-Reply-To: <20261113023236.569054-14-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-14-alastair@d-silva.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 13 Nov 2026 13:32:23 +1100
Alastair D'Silva <alastair@d-silva.org> wrote:

> On the Allwinner A733, boot0.h latches CLU0_CPU0_CTRL_REG to AArch64
> and sunxi-fel uses SRAM swap buffers across 0x47000.

Sorry, but what? Claude, is that you? What's that supposed to mean, how
are those two statements related and why does that matter?

> Rather than arming
> R_CPUCFG hotplug magic and warm-resetting through BROM, drop directly

Why?

> to Secure AArch32 SVC via ERET after draining UART0 TX, and install an

I am afraid this doesn't really work: even though the core resets in
AArch32 secure SVC, this isn't the same as ERETing into that
mode: the former is PL3, so the highest implemented exception level, the
latter is not. This is admittedly a weird corner case of AArch32
firmware operation on Armv8 hardware, I guess trying to somewhat
retro-fit the clear ARMv8 exception levels into the slightly murky
situation on ARMv7.

The difference is that some operations are reserved for running in the
highest implemented exception level: writing CNTFRQ_EL0, and writing to
RVBAR are prominent examples. The former is bad already, but the latter
prevents switching to AArch64, which is crucial for our boot flow.

So again, why is this needed, and what is the problem with the existing
way of doing things?

> EL3 SMC vector in SH_SRAM (0x00080000) so sunxi-fel can re-enter AArch64
> EL3 for BL31.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/arm/cpu/armv8/fel_utils.S | 113 ++++++++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
> index ccddfaaf04c..fc0e0b93c37 100644
> --- a/arch/arm/cpu/armv8/fel_utils.S
> +++ b/arch/arm/cpu/armv8/fel_utils.S
> @@ -11,6 +11,30 @@
>  #include <asm/system.h>
>  #include <linux/linkage.h>
>  #include <asm/arch/cpu.h>
> +#include <asm/arch/serial.h>
> +
> +#ifdef CONFIG_MACH_SUN60I_A733
> +#define A733_FEL_EL3_VBAR		SUNXI_FEL_EL3_VBAR
> +#define A733_FEL_EL3_A32_SYNC_OFF	0x600
> +#define UART_LSR_OFFSET			0x14
> +#define UART_LSR_TEMT_BIT		6
> +#define SCR_EL3_IRQ_EN			(1 << 1)
> +#define SCR_EL3_FIQ_EN			(1 << 2)
> +#define SCR_EL3_FEL_A32_CLEAR		(SCR_EL3_RW_AARCH64 | \
> +					 SCR_EL3_SMD_DIS | \
> +					 SCR_EL3_EA_EN | \
> +					 SCR_EL3_FIQ_EN | \
> +					 SCR_EL3_IRQ_EN | \
> +					 SCR_EL3_NS_EN)
> +#define ICC_SRE_EL3_ENABLE_ALL		0xf
> +#define ICC_SRE_EL1_ENABLE_ALL		0x7
> +#define ICC_IGRPEN1_EL3_ENABLE_ALL	0x3
> +#define SPSR_EL3_A32_SVC_MASKED		(SPSR_EL_ASYN_MASK | \
> +					 SPSR_EL_IRQ_MASK | \
> +					 SPSR_EL_FIQ_MASK | \
> +					 SPSR_EL_M_AARCH32 | \
> +					 SPSR_EL_M_SVC)
> +#endif
>  
>  /*
>   * We don't overwrite save_boot_params() here, to save the FEL state upon
> @@ -40,6 +64,89 @@ ENTRY(return_to_fel)
>  	adr	x1, fel_stash_addr	// to find the fel_stash address in AA32
>  	str	w2, [x1]
>  
> +#if defined(CONFIG_MACH_SUN60I_A733)
> +#if CONFIG_IS_ENABLED(SERIAL)
> +	/* Drain UART0 TX FIFO before dropping to AArch32 */

Why? And why is this not done in C?

> +	ldr	x2, =SUNXI_UART0_BASE
> +	mov	w1, #0x10000
> +2:	ldr	w0, [x2, #UART_LSR_OFFSET]
> +	tbnz	w0, #UART_LSR_TEMT_BIT, 3f
> +	subs	w1, w1, #1
> +	b.ne	2b

Yeah, no, this seems like another case of an LLM going wild in writing
assembly code, and adding many hard-to-parse lines (without comments),
to solve an issue that isn't even properly justified.

Cheers,
Andre

> +3:
> +#endif
> +
> +	/*
> +	 * On A733, boot0.h latches CLU0_CPU0_CTRL_REG to AArch64 and FEL uses
> +	 * SRAM swap buffers across 0x47000. Rather than warm-resetting through
> +	 * the BROM hotplug path, drop directly to Secure AArch32 SVC via ERET
> +	 * and install an EL3 SMC vector in SH_SRAM outside the FEL swap buffer
> +	 * so sunxi-fel can re-enter AArch64 EL3 for BL31.
> +	 */
> +	adr	x4, el3_a32_sync
> +	adr	x5, el3_a32_sync_end
> +	ldr	x6, =(A733_FEL_EL3_VBAR + A733_FEL_EL3_A32_SYNC_OFF)
> +	mov	x8, x6
> +4:	ldr	w7, [x4], #4
> +	str	w7, [x6], #4
> +	cmp	x4, x5
> +	b.lo	4b
> +
> +5:	dc	cvau, x8
> +	add	x8, x8, #64
> +	cmp	x8, x6
> +	b.lo	5b
> +	dsb	ish
> +	ic	iallu
> +	dsb	ish
> +	isb
> +
> +	ldr	x0, =A733_FEL_EL3_VBAR
> +	msr	vbar_el3, x0
> +
> +	mrs	x1, ICC_SRE_EL3
> +	orr	x1, x1, #ICC_SRE_EL3_ENABLE_ALL
> +	msr	ICC_SRE_EL3, x1
> +	isb
> +
> +	mrs	x1, ICC_SRE_EL1
> +	orr	x1, x1, #ICC_SRE_EL1_ENABLE_ALL
> +	msr	ICC_SRE_EL1, x1
> +	mov	x1, #ICC_IGRPEN1_EL3_ENABLE_ALL
> +	msr	ICC_IGRPEN1_EL3, x1
> +
> +	mrs	x0, scr_el3
> +	mov	x1, #SCR_EL3_FEL_A32_CLEAR
> +	bic	x0, x0, x1
> +	msr	scr_el3, x0
> +
> +	mov	x0, #SPSR_EL3_A32_SVC_MASKED
> +	msr	spsr_el3, x0
> +
> +	adr	x0, back_in_32
> +	msr	elr_el3, x0
> +
> +	dsb	sy
> +	isb
> +	eret
> +
> +	.align	2
> +el3_a32_sync:
> +	mrs	x9, scr_el3
> +	mov	x10, #SCR_EL3_RW_AARCH64
> +	orr	x9, x9, x10
> +	msr	scr_el3, x9
> +	isb
> +	cbnz	w0, 6f
> +	movz	w0, #(CONFIG_SUNXI_BL31_BASE & 0xffff)
> +	movk	w0, #(CONFIG_SUNXI_BL31_BASE >> 16), lsl #16
> +6:	uxtw	x0, w0
> +	ic	iallu
> +	dsb	sy
> +	isb
> +	br	x0
> +el3_a32_sync_end:
> +#else
>  	ldr	w0, =0xfa50392f		// CPU hotplug magic
>  #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133) || \
>      defined(CONFIG_MACH_SUN55I_A523)
> @@ -63,6 +170,7 @@ ENTRY(return_to_fel)
>  	isb	sy
>  1:	wfi
>  	b	1b
> +#endif
>  
>  fel_stash_addr:			// must immediately precede back_in_32:
>  	.word   0x00000000	// receives fel_stash addr, by AA64 code above
> @@ -71,6 +179,9 @@ fel_stash_addr:			// must immediately precede back_in_32:
>  back_in_32:
>  	.word	0xe51f000c	// ldr	r0, [pc, #-12]  ; load fel_stash address
>  	.word	0xe5901008	// ldr	r1, [r0, #8]
> +#ifdef CONFIG_MACH_SUN60I_A733
> +	.word	0xe38110c0	// orr	r1, r1, #0xc0   ; mask IRQ/FIQ in thunk
> +#endif
>  	.word	0xe129f001	// msr	CPSR_fc, r1
>  	.word	0xf57ff06f	// isb
>  	.word	0xe590d000	// ldr	sp, [r0]
> @@ -82,7 +193,7 @@ back_in_32:
>  	.word	0xe590100c	// ldr	r1, [r0, #12]
>  	.word	0xee011f10	// mcr	15, 0, r1, cr1, cr0, {0}  ; SCTLR
>  	.word	0xf57ff06f	// isb
> -#ifdef CONFIG_MACH_SUN55I_A523
> +#if defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
>  	.word	0xe5901018	// ldr  r1, [r0, #24]
>  	.word	0xee041f16	// mcr  15, 0, r1, cr4, cr6, {0}; ICC_PMR
>  	.word	0xe590101c	// ldr  r1, [r0, #28]

