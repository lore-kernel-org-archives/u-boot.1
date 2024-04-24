Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F1C07E8E
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 10:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E542288E20;
	Wed, 24 Apr 2024 12:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF21188C3A; Wed, 24 Apr 2024 12:29:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96CC188E0B
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 12:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C64339;
 Wed, 24 Apr 2024 03:29:45 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDC73F73F;
 Wed, 24 Apr 2024 03:29:16 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:29:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Peter Hoyes <peter.hoyes@arm.com>, u-boot@lists.denx.de,
 trini@konsulko.com, mk7.kang@samsung.com, ilias.apalodimas@linaro.org,
 wqu@suse.com, neil.armstrong@linaro.org, sr@denx.de, michal.simek@amd.com,
 patrick.delaunay@foss.st.com, sjg@chromium.org, patrice.chotard@foss.st.com
Subject: Re: [PATCH 2/2] armv8: generic_timer: Use event stream for udelay
Message-ID: <20240424112913.1b0c22e5@donnerap.manchester.arm.com>
In-Reply-To: <8ccd1c8a-5ab2-44ad-b49a-26bff13187bd@theobroma-systems.com>
References: <20240423081005.23218-1-peter.hoyes@arm.com>
 <20240423081005.23218-3-peter.hoyes@arm.com>
 <8ccd1c8a-5ab2-44ad-b49a-26bff13187bd@theobroma-systems.com>
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

On Tue, 23 Apr 2024 12:55:55 +0200
Quentin Schulz <quentin.schulz@theobroma-systems.com> wrote:

> Hi Peter,
> 
> On 4/23/24 10:10, Peter Hoyes wrote:
> > From: Peter Hoyes <Peter.Hoyes@arm.com>
> > 
> > Polling cntpct_el0 in a tight loop for delays is inefficient.
> > This is particularly apparent on Arm FVPs, which do not simulate
> > real time, meaning that a 1s sleep can take a couple of orders
> > of magnitude longer to execute in wall time.
> > 
> > If running at EL2 or above (where CNTHCTL_EL2 is available), enable
> > the cntpct_el0 event stream temporarily and use wfe to implement
> > the delay more efficiently. The event period is chosen as a
> > trade-off between efficiency and the fact that Arm FVPs do not
> > typically simulate real time.
> > 
> > This is only implemented for Armv8 boards, where an architectural
> > timer exists.
> > 
> > Some mach-socfpga AArch64 boards already override __udelay to make
> > it always inline, so guard the functionality with a new
> > ARMV8_UDELAY_EVENT_STREAM Kconfig, enabled by default.
> > 
> > Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> > ---
> >   arch/arm/cpu/armv8/Kconfig         |  8 ++++++++
> >   arch/arm/cpu/armv8/generic_timer.c | 27 +++++++++++++++++++++++++++
> >   arch/arm/include/asm/system.h      |  6 ++++--
> >   3 files changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> > index 9f0fb369f7..544c5e2d74 100644
> > --- a/arch/arm/cpu/armv8/Kconfig
> > +++ b/arch/arm/cpu/armv8/Kconfig
> > @@ -191,6 +191,14 @@ config ARMV8_EA_EL3_FIRST
> >   	  Exception handling at all exception levels for External Abort and
> >   	  SError interrupt exception are taken in EL3.
> >   
> > +config ARMV8_UDELAY_EVENT_STREAM
> > +	bool "Use the event stream for udelay"
> > +	default y if !ARCH_SOCFPGA
> > +	help
> > +	  Use the event stream provided by the AArch64 architectural timer for
> > +	  delays. This is more efficient than the default polling
> > +	  implementation.
> > +
> >   menuconfig ARMV8_CRYPTO
> >   	bool "ARM64 Accelerated Cryptographic Algorithms"
> >   
> > diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
> > index 8f83372cbc..e18b5c8187 100644
> > --- a/arch/arm/cpu/armv8/generic_timer.c
> > +++ b/arch/arm/cpu/armv8/generic_timer.c
> > @@ -115,3 +115,30 @@ ulong timer_get_boot_us(void)
> >   
> >   	return val / get_tbclk();
> >   }
> > +
> > +#if CONFIG_IS_ENABLED(ARMV8_UDELAY_EVENT_STREAM)
> > +void __udelay(unsigned long usec)
> > +{
> > +	u64 target = get_ticks() + usec_to_tick(usec);
> > +  
> 
> This can theoretically overflow, do we have any guarantee this cannot 
> happen in real life, like... we would need U-Boot to be running for 100 
> years without being powered-down/reset or something like that? Can we 
> document this assumption? Does this make sense?

The Arm ARM guarantees a "Roll-over time of not less than 40 years."
(Armv8 ARM 0487K.a D12.1.2 "The system counter").
So that's not the 100 years you are asking for, but I guess still good
enough?

Cheers,
Andre

> 
> > +	/* At EL2 or above, use the event stream to avoid polling CNTPCT_EL0 so often */
> > +	if (current_el() >= 2) {
> > +		u32 cnthctl_val;
> > +		const u8 event_period = 0x7;
> > +
> > +		asm volatile("mrs %0, cnthctl_el2" : "=r" (cnthctl_val));
> > +		asm volatile("msr cnthctl_el2, %0" : : "r"
> > +			(cnthctl_val | CNTHCTL_EL2_EVNT_EN | CNTHCTL_EL2_EVNT_I(event_period)));
> > +
> > +		while (get_ticks() + (1ULL << event_period) <= target)  
> 
> This could be an overflow as well.
> 
> > +			wfe();
> > +
> > +		/* Reset the event stream */
> > +		asm volatile("msr cnthctl_el2, %0" : : "r" (cnthctl_val));
> > +	}
> > +
> > +	/* Fall back to polling CNTPCT_EL0 */
> > +	while (get_ticks() <= target)  
> 
> get_ticks() could wrap around here maybe?
> 
> Cheers,
> Quentin

