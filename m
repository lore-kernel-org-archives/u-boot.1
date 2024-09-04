Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F9ECD4F4A
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 23:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015A388B1A;
	Thu,  5 Sep 2024 01:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556D788C1B; Thu,  5 Sep 2024 01:39:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 367F4889FF
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 01:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CFFFEC;
 Wed,  4 Sep 2024 16:39:46 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044043F66E;
 Wed,  4 Sep 2024 16:39:18 -0700 (PDT)
Date: Thu, 5 Sep 2024 00:38:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/9] sunxi: H616: dram: DDR3: adjust settings
Message-ID: <20240905003838.3158e3be@minigeek.lan>
In-Reply-To: <20240801225519.336667-2-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-2-macroalpha82@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Thu,  1 Aug 2024 17:55:11 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> Adjust H616 DDR3 DRAM settings to be in line with vendor driver.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> index 3faf8d5bd9..26b7eac342 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> @@ -24,8 +24,8 @@ void mctl_set_timing_params(const struct dram_para *para)
>  	u8 trrd		= max(ns_to_t(6), 4);	/* JEDEC: max(6 ns, 4nCK) */
>  	u8 trcd		= ns_to_t(15);		/* JEDEC: 13.5 ns */
>  	u8 trc		= ns_to_t(53);		/* JEDEC: 49.5 ns */
> -	u8 txp		= max(ns_to_t(6), 3);	/* JEDEC: max(6 ns, 3nCK) */
>  	u8 trtp		= max(ns_to_t(8), 2);	/* JEDEC: max(7.5 ns, 4nCK) */
> +	u8 txp		= trtp;			/* JEDEC: max(6 ns, 3nCK) */

I am not too sure this change makes sense: assuming that it really
should read:
	u8 txp		= max(ns_to_t(8), 2);
(as txp and trtp are quite different delays), it wouldn't really change
anything unless we drop below 500 MHz for the DRAM clock.
8ns are rounded up to 3 clock cycles (nCK), for both 648 and 720 MHz. We
would only get below 3nCK for frequencies under 500 MHz. 6ns would be
3nCK at 720 MHz as well, but 2nCK at 648 MHz. But changing the minimum
to 3nCK at the same time prevents any change. So since the current code
matches JEDEC, I'd rather keep it.

Cheers,
Andre

>  	u8 trp		= ns_to_t(15);		/* JEDEC: >= 13.75 ns */
>  	u8 tras		= ns_to_t(38);		/* JEDEC >= 36 ns, <= 9*trefi */
>  	u16 trefi	= ns_to_t(7800) / 32;	/* JEDEC: 7.8us@Tcase <= 85C */
> @@ -64,6 +64,9 @@ void mctl_set_timing_params(const struct dram_para *para)
>  	twr2rd = trtp + 2 + tcwl;
>  	trd2wr = tcl + 3 - tcwl;
>  
> +	if (trtp + trp < tcl + 2)
> +		trtp = tcl + 2 - trp;
> +
>  	/* set DRAM timing */
>  	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
>  	       &mctl_ctl->dramtmg[0]);

