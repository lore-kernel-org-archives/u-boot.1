Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A321E82CAF
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 16:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0E086DD6;
	Wed, 27 Sep 2023 18:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A7586DF9; Wed, 27 Sep 2023 18:32:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 713B186BE1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 18:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC541FB;
 Wed, 27 Sep 2023 09:33:02 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04003F59C;
 Wed, 27 Sep 2023 09:32:23 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:32:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Maksim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 5/5] HACK: sunxi: psci: be compatible with v1 of R528
 patchset
Message-ID: <20230927173221.122c8de2@donnerap.manchester.arm.com>
In-Reply-To: <20230816173420.83232-6-CFSworks@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-6-CFSworks@gmail.com>
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

On Wed, 16 Aug 2023 10:34:20 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

> This is a hack for reviewer QoL. It is not being submitted for mainline
> inclusion.
> ---
>  arch/arm/cpu/armv7/sunxi/psci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index b4ce4f6def..27bac291d5 100644
> --- a/arch/arm/cpu/armv7/sunxi/psci.c
> +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> @@ -60,6 +60,18 @@
>  
>  #define SUN8I_R528_C0_STATUS_STANDBYWFI		(16)
>  
> +/* 3 hacks for compatibility across v1/v2 of Andre's R528 support series */
> +#ifndef SUNXI_R_CPUCFG_BASE
> +#define SUNXI_R_CPUCFG_BASE			0
> +#endif

Mmh, I didn't find a better solution than keeping this in.

> +#ifndef SUNXI_PRCM_BASE
> +#define SUNXI_PRCM_BASE				0

So this is now handled. As Samuel pointed out, the R329 (another member of
the "NCAT2" family), actually documents a PRCM block, and arguably the
T113s/D1 have that as well, it's just not very useful (at least for
U-Boot), so we didn't need it so far. I just put the address documented in
the R329 manual into cpu_sunxi_ncat2.h, so the symbol expands properly.

> +#endif
> +#if defined(SUNXI_CPUX_BASE) && defined(SUNXI_CPUCFG_BASE)
> +#undef SUNXI_CPUCFG_BASE
> +#define SUNXI_CPUCFG_BASE SUNXI_CPUX_BASE

So what's the story with this? Do we name this differently
(SUNXI_CPUX_BASE) because the IP block is different from the other SoCs?
Or is there another SUNXI_CPUCFG IP block on the R528/T113s SoCs?

If not, I think we should use the SUNXI_CPUCFG_BASE name directly in
cpu_sunxi_ncat2.h, as we never claimed that same names for some MMIO
address blocks means they are compatible.

Please let me know if I miss something.

Cheers,
Andre



> +#endif
> +
>  static void __secure cp15_write_cntp_tval(u32 tval)
>  {
>  	asm volatile ("mcr p15, 0, %0, c14, c2, 0" : : "r" (tval));

