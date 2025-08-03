Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76626C87FD3
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 00:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F1983B5F;
	Sun,  3 Aug 2025 02:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="b6FglJQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B1B83CB1; Sun,  3 Aug 2025 02:17:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B349F83B24
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 02:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3EA8A25C4A;
 Sun,  3 Aug 2025 02:16:58 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uuu2hagP24Vp; Sun,  3 Aug 2025 02:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754180217; bh=lFsUSiofilaajjolS4Bo95rk3eFzSNiTfQ4zCVlW2lQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b6FglJQsTwlhUEPtZD1UUS+J/1r9UBIURIB/eVv4MvBmeW/LINCtlL1MMvBAA3Gvt
 wonfbu8uzS8ptj60sjuaOBoBKMLbduAw6EaoTylH9PSJRcj/x0PX+dQeQEYsCQeZS5
 vEIt8AsWpzc4jZKKxx5kpdedT6pkdaBr2Pb7GobzNlaERoiAhnCgAZOrHOUQlB+JCS
 xz8iADGGFHkoj8ZVWqfhgMGAIsJlBoIkMLaDMN5CylORPtkvUcQ/1FZ6DtwfkZLLGP
 8sZps3DL67OJccGiMlQyACc1pU2H3/GnEKs2zVVZ+7tiIAfh6jGuIFKNkgExo3QdSu
 DPHD/6d/U/eGA==
Date: Sun, 3 Aug 2025 00:16:44 +0000
From: Yao Zi <ziyao@disroot.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] riscv: Add Kconfig options to distinguish Zaamo and
 Zalrsc
Message-ID: <aI6qbGCMyKOJwM0w@pie>
References: <20250802092155.40915-1-ziyao@disroot.org>
 <20250802092155.40915-2-ziyao@disroot.org>
 <20250802235905-GYA937132@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802235905-GYA937132@gentoo>
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

On Sun, Aug 03, 2025 at 07:59:05AM +0800, Yixun Lan wrote:
> Hi Yao,
> 
> On 09:21 Sat 02 Aug     , Yao Zi wrote:
> > Ratified on Apr. 2024, the original RISC-V "A" extension is now split
> > into two separate extensions, "Zaamo" for atomic operations and "Zalrsc"
> > for load-reserved/store-conditional instructions.
> > 
> > For now, we've already seen real-world designs implement the Zalrsc
> > extension only[2]. As U-Boot mainly runs with only one HART, we could
> > easily support these designs by not using AMO instructions in the
> > hard-written assembly if necessary, for which this patch introduces two
> > new Kconfig options to indicate the availability of "Zaamo" and "Zalrsc".
> > 
> > Note that even with this patch, "A" extension is specified in the ISA
> > string passed to the compiler as long as one of "Zaamo" or "Zalrsc" is
> > available, since they're only recognized with a quite recent version of
> > GCC/Clang. The compiler usually doesn't automatically generate atomic
> > instructions unless the source explicitly instructs it to do so, thus
> > this should be safe.
> > 
> > Link: https://github.com/riscv/riscv-zaamo-zalrsc/commit/d94c64c63e9120d56bdeb540caf2e5dae60a8126 # [1]
> > Link: https://lore.kernel.org/u-boot/20250729162035.209849-9-uros.stajic@htecgroup.com/ # [2]
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/riscv/Kconfig             | 17 +++++++++++++++++
> >  arch/riscv/Makefile            |  7 ++++++-
> >  configs/ibex-ast2700_defconfig |  3 ++-
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8c6feae5735..b1c2d657e99 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -339,10 +339,27 @@ endmenu
> >  
> >  config RISCV_ISA_A
> >  	bool "Standard extension for Atomic Instructions"
> > +	depends on RISCV_ISA_ZAAMO && RISCV_ISA_ZALRSC
> >  	default y
> >  	help
> >  	  Adds "A" to the ISA string passed to the compiler.
> >  
> > +config RISCV_ISA_ZAAMO
> > +	bool "Standard extension for Atomic Memory Operations"
> > +	default y
> > +	help
> > +	  Indicates the platform supports Zaamo extension for atomic memory
> > +	  operations. Assembly routines won't use AMO instructions if set
> > +	  to n.
> > +
> > +config RISCV_ISA_ZALRSC
> > +	bool "Standard extension for LR/SC instructions"
> > +	default y
> > +	help
> > +	  Indicates the platform supports Zalrsc extension for load-reserved
> > +	  and store-conditional instructions. Assembly rutines won't use
>                                                    s/rutines/routines/
> while to be more precise, "Assembly routines" should be interpreted as
> instructions generated by compiler? if yes, can you improve the wording?

Thanks for catching the typo. I was meant to refer the handwritten ones,
instead of the compiler-generated ones. As you could see in the commit
message and the Makefile changes, we always add "A" to march argument as
long as one of "Zalrsc" and "Zaamo" is available, so these two new
options basically have nothing to do with compiler's code generation.

Anyway, it seems helpful to be more precise here. Maybe something like,

	Indicates the platform supports Zalrsc extension for load-reserved
	and store-conditional isntructions. Hand-written assembly routines
	won't use LR/SC instructions if set to n.

I'll wait a little more time to see whether there're more comments on
the series, then send v2.

Thanks,
Yao Zi

> > +	  LR/SC instructions if set to n.
> > +
> >  config RISCV_ISA_ZICBOM
> >  	bool "Zicbom support"
> >  	depends on !SYS_DISABLE_DCACHE_OPS
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 6f80f4a7108..fdda6da1df3 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -11,7 +11,12 @@ ifeq ($(CONFIG_ARCH_RV32I),y)
> >  	ARCH_BASE = rv32im
> >  	ABI_BASE = ilp32
> >  endif
> > -ifeq ($(CONFIG_RISCV_ISA_A),y)
> > +# GCC starts to recognize "Zaamo" and "Zalrsc" from version 15, which is quite
> > +# recent. We don't bother checking the exact compiler version, but pass "A"
> > +# extension for -march as long as one of "Zaamo" or "Zalrsc" is available.
> > +ifeq ($(findstring y,$(CONFIG_RISCV_ISA_A)	\
> > +		     $(CONFIG_RISCV_ISA_ZAAMO)	\
> > +		     $(CONFIG_RISCV_ISA_ZALRSC)),y)
> >  	ARCH_A = a
> >  endif
> >  ifeq ($(CONFIG_RISCV_ISA_F),y)
> > diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
> > index f088aec8716..eb5cab43645 100644
> > --- a/configs/ibex-ast2700_defconfig
> > +++ b/configs/ibex-ast2700_defconfig
> > @@ -23,7 +23,8 @@ CONFIG_SYS_MEM_TOP_HIDE=0x10000000
> >  CONFIG_BUILD_TARGET=""
> >  CONFIG_TARGET_ASPEED_AST2700_IBEX=y
> >  # CONFIG_RISCV_ISA_F is not set
> > -# CONFIG_RISCV_ISA_A is not set
> > +# CONFIG_RISCV_ISA_ZAAMO is not set
> > +# CONFIG_RISCV_ISA_ZALRSC is not set
> >  # CONFIG_SPL_SMP is not set
> >  CONFIG_XIP=y
> >  CONFIG_SPL_XIP=y
> > -- 
> > 2.50.1
> > 
> 
> -- 
> Yixun Lan (dlan)
