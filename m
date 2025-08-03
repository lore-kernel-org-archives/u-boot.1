Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F4C87FD2
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 01:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F28483CDF;
	Sun,  3 Aug 2025 03:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC79983CE3; Sun,  3 Aug 2025 03:24:31 +0200 (CEST)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAAA83C91
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 03:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.147.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 8B05833BE32;
 Sun, 03 Aug 2025 01:24:26 +0000 (UTC)
Date: Sun, 3 Aug 2025 09:24:22 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] riscv: Add Kconfig options to distinguish Zaamo and
 Zalrsc
Message-ID: <20250803012422-GYA937575@gentoo>
References: <20250802092155.40915-1-ziyao@disroot.org>
 <20250802092155.40915-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802092155.40915-2-ziyao@disroot.org>
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
> Ratified on Apr. 2024, the original RISC-V "A" extension is now split
> into two separate extensions, "Zaamo" for atomic operations and "Zalrsc"
> for load-reserved/store-conditional instructions.
> 
> For now, we've already seen real-world designs implement the Zalrsc
> extension only[2]. As U-Boot mainly runs with only one HART, we could
> easily support these designs by not using AMO instructions in the
> hard-written assembly if necessary, for which this patch introduces two
> new Kconfig options to indicate the availability of "Zaamo" and "Zalrsc".
> 
> Note that even with this patch, "A" extension is specified in the ISA
> string passed to the compiler as long as one of "Zaamo" or "Zalrsc" is
> available, since they're only recognized with a quite recent version of
> GCC/Clang. The compiler usually doesn't automatically generate atomic
> instructions unless the source explicitly instructs it to do so, thus
> this should be safe.
> 
> Link: https://github.com/riscv/riscv-zaamo-zalrsc/commit/d94c64c63e9120d56bdeb540caf2e5dae60a8126 # [1]
> Link: https://lore.kernel.org/u-boot/20250729162035.209849-9-uros.stajic@htecgroup.com/ # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/Kconfig             | 17 +++++++++++++++++
>  arch/riscv/Makefile            |  7 ++++++-
>  configs/ibex-ast2700_defconfig |  3 ++-
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8c6feae5735..b1c2d657e99 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -339,10 +339,27 @@ endmenu
>  
>  config RISCV_ISA_A
>  	bool "Standard extension for Atomic Instructions"
> +	depends on RISCV_ISA_ZAAMO && RISCV_ISA_ZALRSC
>  	default y
>  	help
>  	  Adds "A" to the ISA string passed to the compiler.
>  
> +config RISCV_ISA_ZAAMO
> +	bool "Standard extension for Atomic Memory Operations"
> +	default y
> +	help
> +	  Indicates the platform supports Zaamo extension for atomic memory
> +	  operations. Assembly routines won't use AMO instructions if set
> +	  to n.
> +
> +config RISCV_ISA_ZALRSC
> +	bool "Standard extension for LR/SC instructions"
> +	default y
> +	help
> +	  Indicates the platform supports Zalrsc extension for load-reserved
> +	  and store-conditional instructions. Assembly rutines won't use
> +	  LR/SC instructions if set to n.
> +
>  config RISCV_ISA_ZICBOM
>  	bool "Zicbom support"
>  	depends on !SYS_DISABLE_DCACHE_OPS
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6f80f4a7108..fdda6da1df3 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -11,7 +11,12 @@ ifeq ($(CONFIG_ARCH_RV32I),y)
>  	ARCH_BASE = rv32im
>  	ABI_BASE = ilp32
>  endif
> -ifeq ($(CONFIG_RISCV_ISA_A),y)
> +# GCC starts to recognize "Zaamo" and "Zalrsc" from version 15, which is quite
> +# recent. We don't bother checking the exact compiler version, but pass "A"
> +# extension for -march as long as one of "Zaamo" or "Zalrsc" is available.
> +ifeq ($(findstring y,$(CONFIG_RISCV_ISA_A)	\
> +		     $(CONFIG_RISCV_ISA_ZAAMO)	\
> +		     $(CONFIG_RISCV_ISA_ZALRSC)),y)
>  	ARCH_A = a
>  endif
>  ifeq ($(CONFIG_RISCV_ISA_F),y)
> diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
> index f088aec8716..eb5cab43645 100644
> --- a/configs/ibex-ast2700_defconfig
> +++ b/configs/ibex-ast2700_defconfig
> @@ -23,7 +23,8 @@ CONFIG_SYS_MEM_TOP_HIDE=0x10000000
>  CONFIG_BUILD_TARGET=""
>  CONFIG_TARGET_ASPEED_AST2700_IBEX=y
>  # CONFIG_RISCV_ISA_F is not set
> -# CONFIG_RISCV_ISA_A is not set
> +# CONFIG_RISCV_ISA_ZAAMO is not set
> +# CONFIG_RISCV_ISA_ZALRSC is not set

this is confusing, while in this patchset it actually equal to :
# CONFIG_RISCV_ISA_ZAAMO is not set
CONFIG_RISCV_ISA_ZALRSC=y

also I believe changes for configs/ibex-ast2700_defconfig should go as
an independent patch, please separate it

>  # CONFIG_SPL_SMP is not set
>  CONFIG_XIP=y
>  CONFIG_SPL_XIP=y
> -- 
> 2.50.1
> 

-- 
Yixun Lan (dlan)
