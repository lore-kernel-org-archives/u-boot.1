Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2439C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB808872A;
	Tue,  7 May 2024 12:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD768873D; Tue,  7 May 2024 12:26:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D444A88662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F1F81063;
 Tue,  7 May 2024 03:26:36 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 657873F587;
 Tue,  7 May 2024 03:26:08 -0700 (PDT)
Date: Tue, 7 May 2024 11:26:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Peter Hoyes <peter.hoyes@arm.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com,
 quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v2 2/2] armv8: generic_timer: Use event stream for udelay
Message-ID: <20240507112604.6e8e7388@donnerap.manchester.arm.com>
In-Reply-To: <20240501081633.120913-3-peter.hoyes@arm.com>
References: <20240501081633.120913-1-peter.hoyes@arm.com>
 <20240501081633.120913-3-peter.hoyes@arm.com>
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

On Wed,  1 May 2024 09:16:33 +0100
Peter Hoyes <peter.hoyes@arm.com> wrote:

Hi Peter,

thanks for the change!

> From: Peter Hoyes <Peter.Hoyes@arm.com>
> 
> Polling cntpct_el0 in a tight loop for delays is inefficient.
> This is particularly apparent on Arm FVPs, which do not simulate
> real time, meaning that a 1s sleep can take a couple of orders
> of magnitude longer to execute in wall time.
> 
> If running at EL2 or above (where CNTHCTL_EL2 is available), enable
> the cntpct_el0 event stream temporarily and use wfe to implement
> the delay more efficiently. The event period is chosen as a
> trade-off between efficiency and the fact that Arm FVPs do not
> typically simulate real time.
> 
> This is only implemented for Armv8 boards, where an architectural
> timer exists, and only enabled by default for the ARCH_VEXPRESS64
> board family.

I think total_compute would benefit from this change as well, but this
needs some testing and can easily be a separate patch.

> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/cpu/armv8/Kconfig         |  8 ++++++++
>  arch/arm/cpu/armv8/generic_timer.c | 27 +++++++++++++++++++++++++++
>  arch/arm/include/asm/system.h      |  6 ++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> index 9f0fb369f7..199335cd60 100644
> --- a/arch/arm/cpu/armv8/Kconfig
> +++ b/arch/arm/cpu/armv8/Kconfig
> @@ -191,6 +191,14 @@ config ARMV8_EA_EL3_FIRST
>  	  Exception handling at all exception levels for External Abort
> and SError interrupt exception are taken in EL3.
>  
> +config ARMV8_UDELAY_EVENT_STREAM
> +	bool "Use the event stream for udelay"
> +	default y if ARCH_VEXPRESS64
> +	help
> +	  Use the event stream provided by the AArch64 architectural
> timer for
> +	  delays. This is more efficient than the default polling
> +	  implementation.
> +
>  menuconfig ARMV8_CRYPTO
>  	bool "ARM64 Accelerated Cryptographic Algorithms"
>  
> diff --git a/arch/arm/cpu/armv8/generic_timer.c
> b/arch/arm/cpu/armv8/generic_timer.c index 8f83372cbc..e18b5c8187 100644
> --- a/arch/arm/cpu/armv8/generic_timer.c
> +++ b/arch/arm/cpu/armv8/generic_timer.c
> @@ -115,3 +115,30 @@ ulong timer_get_boot_us(void)
>  
>  	return val / get_tbclk();
>  }
> +
> +#if CONFIG_IS_ENABLED(ARMV8_UDELAY_EVENT_STREAM)
> +void __udelay(unsigned long usec)
> +{
> +	u64 target = get_ticks() + usec_to_tick(usec);
> +
> +	/* At EL2 or above, use the event stream to avoid polling
> CNTPCT_EL0 so often */
> +	if (current_el() >= 2) {
> +		u32 cnthctl_val;
> +		const u8 event_period = 0x7;
> +
> +		asm volatile("mrs %0, cnthctl_el2" : "=r"
> (cnthctl_val));
> +		asm volatile("msr cnthctl_el2, %0" : : "r"
> +			(cnthctl_val | CNTHCTL_EL2_EVNT_EN |
> CNTHCTL_EL2_EVNT_I(event_period))); +
> +		while (get_ticks() + (1ULL << event_period) <= target)
> +			wfe();
> +
> +		/* Reset the event stream */
> +		asm volatile("msr cnthctl_el2, %0" : : "r"
> (cnthctl_val));
> +	}
> +
> +	/* Fall back to polling CNTPCT_EL0 */
> +	while (get_ticks() <= target)
> +		;
> +}
> +#endif
> diff --git a/arch/arm/include/asm/system.h
> b/arch/arm/include/asm/system.h index 51123c2968..7e30cac32a 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -69,8 +69,10 @@
>  /*
>   * CNTHCTL_EL2 bits definitions
>   */
> -#define CNTHCTL_EL2_EL1PCEN_EN	(1 << 1)  /* Physical timer regs
> accessible   */ -#define CNTHCTL_EL2_EL1PCTEN_EN	(1 << 0)  /*
> Physical counter accessible      */ +#define CNTHCTL_EL2_EVNT_EN
> BIT(2)	     /* Enable the event stream       */ +#define
> CNTHCTL_EL2_EVNT_I(val)	((val) << 4) /* Event stream trigger bits
>     */ +#define CNTHCTL_EL2_EL1PCEN_EN	(1 << 1)     /* Physical
> timer regs accessible */ +#define CNTHCTL_EL2_EL1PCTEN_EN	(1 <<
> 0)     /* Physical counter accessible   */ /*
>   * HCR_EL2 bits definitions

