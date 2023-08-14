Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B37EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 20:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041C68692C;
	Mon, 14 Aug 2023 22:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DE286967; Mon, 14 Aug 2023 22:40:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C03E68675B
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 22:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9F71063;
 Mon, 14 Aug 2023 13:40:55 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580EE3F64C;
 Mon, 14 Aug 2023 13:40:12 -0700 (PDT)
Date: Mon, 14 Aug 2023 21:39:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Marc
 Zyngier <maz@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
Message-ID: <20230814213854.408962d5@slackpad.lan>
In-Reply-To: <20230531201520.15479-1-CFSworks@gmail.com>
References: <20230531201520.15479-1-CFSworks@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 31 May 2023 14:15:20 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi,

(CC:ing Marc and Chen-Yu as the original authors)

sorry for the delay, found that mouldering in my Drafts folder.

> The nonsec code overrides/handles these:
> - Setting PMR to 0xFF happens earlier, in _nonsec_init, so this is
>   redundant.
> - The NS bit is not yet set: it gets set later in _secure_monitor.
>   Trying to clear it here is pointless and misleading.

So superficially this looks alright, but I am still somewhat reluctant
to apply this, see below ...

> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/cpu/armv7/sunxi/psci.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index e1d3638b5c..f866025c37 100644
> --- a/arch/arm/cpu/armv7/sunxi/psci.c
> +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> @@ -300,14 +300,10 @@ void __secure psci_arch_init(void)
>  	/* Set SGI15 priority to 0 */
>  	writeb(0, GICD_BASE + GICD_IPRIORITYRn + 15);
>  
> -	/* Be cool with non-secure */
> -	writel(0xff, GICC_BASE + GICC_PMR);
> -
>  	/* Switch FIQEn on */
>  	setbits_le32(GICC_BASE + GICC_CTLR, BIT(3));
>  
>  	reg = cp15_read_scr();
>  	reg |= BIT(2);  /* Enable FIQ in monitor mode */
> -	reg &= ~BIT(0); /* Secure mode */

I am scratching my head on this one: I see it deliberately being done in
the original patch by Marc[1], and wonder why. If I read the code and
the architecture correctly, this routine is called only(?) from the SMC
handler, which means we are in monitor mode, that only exists in secure
state. So the NS bit is irrelevant until we switch to another mode. And
we indeed set the bit later, before dropping back to non-secure. So I
agree that clearing the bit is pointless. Was it put in to be more
robust, for other potential callers of this function, for instance in
the boot path?

Does anyone remember?

Cheers,
Andre

[1]
https://source.denx.de/u-boot/u-boot/-/commit/d5db7024aafc5ea603f3a34f83bb29a1eaa3cbe7#f377950449a5dba076796d9e48fbd21f5d6ac545_0_65

>  	cp15_write_scr(reg);
>  }

