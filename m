Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0FAC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B716388993;
	Mon, 29 Apr 2024 12:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2648899A; Mon, 29 Apr 2024 12:42:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A0F8488993
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34E42F4;
 Mon, 29 Apr 2024 03:43:04 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352713F793;
 Mon, 29 Apr 2024 03:42:36 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:42:33 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Peter Hoyes <peter.hoyes@arm.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com
Subject: Re: [PATCH 1/2] arm: Move sev() and wfe() definitions to common Arm
 header file
Message-ID: <20240429114233.6eef5c18@donnerap.manchester.arm.com>
In-Reply-To: <20240423081005.23218-2-peter.hoyes@arm.com>
References: <20240423081005.23218-1-peter.hoyes@arm.com>
 <20240423081005.23218-2-peter.hoyes@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 23 Apr 2024 09:10:04 +0100
Peter Hoyes <peter.hoyes@arm.com> wrote:

Hi,

> From: Peter Hoyes <Peter.Hoyes@arm.com>
> 
> The sev() and wfe() asm macros are currently defined only for
> mach-exynos. As these are common Arm instructions, move them to the
> common asm/system.h header file, for both Armv7 and Armv8, so they
> can be used by other machines.
> 
> wfe may theoretically trigger a context switch if an interrupt occurs
> so add a memory barrier to this call.
> 
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>

Looks alright to me, and the memory barrier for wfe looks justified.

For the records: we couldn't come up with a reason why "sev" would need
one as well, so even while the kernel has this, this seems to be more a
copy&paste incident rather than something intentional.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/include/asm/system.h              |  9 +++++++++
>  arch/arm/mach-exynos/include/mach/system.h | 19 -------------------
>  2 files changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 43f7503571..51123c2968 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -154,6 +154,13 @@ enum dcache_option {
>  	"wfi" : : : "memory");		\
>  	})
>  
> +#define wfe()				\
> +	({asm volatile(			\
> +	"wfe" : : : "memory");		\
> +	})
> +
> +#define sev() asm volatile("sev")
> +
>  static inline unsigned int current_el(void)
>  {
>  	unsigned long el;
> @@ -369,6 +376,8 @@ void switch_to_hypervisor_ret(void);
>  
>  #ifdef __ARM_ARCH_7A__
>  #define wfi() __asm__ __volatile__ ("wfi" : : : "memory")
> +#define wfe() __asm__ __volatile__ ("wfe" : : : "memory")
> +#define sev() __asm__ __volatile__ ("sev")
>  #else
>  #define wfi()
>  #endif
> diff --git a/arch/arm/mach-exynos/include/mach/system.h b/arch/arm/mach-exynos/include/mach/system.h
> index 5d0bebac57..0aed4c3e2b 100644
> --- a/arch/arm/mach-exynos/include/mach/system.h
> +++ b/arch/arm/mach-exynos/include/mach/system.h
> @@ -36,25 +36,6 @@ struct exynos5_sysreg {
>  
>  #define USB20_PHY_CFG_HOST_LINK_EN	(1 << 0)
>  
> -/*
> - * This instruction causes an event to be signaled to all cores
> - * within a multiprocessor system. If SEV is implemented,
> - * WFE must also be implemented.
> - */
> -#define sev() __asm__ __volatile__ ("sev\n\t" : : );
> -/*
> - * If the Event Register is not set, WFE suspends execution until
> - * one of the following events occurs:
> - * - an IRQ interrupt, unless masked by the CPSR I-bit
> - * - an FIQ interrupt, unless masked by the CPSR F-bit
> - * - an Imprecise Data abort, unless masked by the CPSR A-bit
> - * - a Debug Entry request, if Debug is enabled
> - * - an Event signaled by another processor using the SEV instruction.
> - * If the Event Register is set, WFE clears it and returns immediately.
> - * If WFE is implemented, SEV must also be implemented.
> - */
> -#define wfe() __asm__ __volatile__ ("wfe\n\t" : : );
> -
>  /* Move 0xd3 value to CPSR register to enable SVC mode */
>  #define svc32_mode_en() __asm__ __volatile__				\
>  			("@ I&F disable, Mode: 0x13 - SVC\n\t"		\

