Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6B9CD4F4B
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 23:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8877D88BB0;
	Thu,  5 Sep 2024 01:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78E488481; Thu,  5 Sep 2024 01:08:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9295D88BF7
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 01:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F378FEC;
 Wed,  4 Sep 2024 16:08:31 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460473F66E;
 Wed,  4 Sep 2024 16:08:03 -0700 (PDT)
Date: Thu, 5 Sep 2024 00:07:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, jagan@amarulasolutions.com, trini@konsulko.com,
 ryan@testtoast.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/9] sunxi: H616: dram: LPDDR3: adjust settings
Message-ID: <20240905000718.12f6827c@minigeek.lan>
In-Reply-To: <4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-3-macroalpha82@gmail.com>
 <4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com>
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

On Sat, 3 Aug 2024 16:17:26 +0300
Mikhail Kalashnikov <iuncuim@gmail.com> wrote:

Hi Mikhail,

> On 02.08.2024 01:55, Chris Morgan wrote:
> > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > Adjust H616 LPDDR3 DRAM settings to be in line with vendor driver.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-sunxi/dram_sun50i_h616.c         | 2 +-
> >   arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > index 37c139e0ee..a20264d8b4 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > @@ -945,7 +945,7 @@ static bool mctl_phy_init(const struct dram_para *para,
> >   		val = para->tpr6 & 0xff;
> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR3:
> > -		val = para->tpr6 >> 8 & 0xff;
> > +		val = para->tpr6 >> 16 & 0xff;  
> 
> This is the correct change to match the factory tpr6 parameters.
> 
> I think, we also need to change the default value in 
> arch/arm/mach-sunxi/Kconfig:
> 
> from: config DRAM_SUN50I_H616_TPR6
> hex "H616 DRAM TPR6 parameter"
> default 0x3300c080
> to
> default 0x33c00080

Can you please confirm what the vendor code does here? Does it use a
value of 0xc0 for "val" above, so we need to change *both* the
shift and the default value? Or does the vendor code write 0 (the
original bits[23:16]) into val? I am a bit puzzled because I think we
copied the TPR values verbatim from the vendor firmware, so changing
DRAM_SUN50I_H616_TPR6 looks a bit odd.

> 
> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR4:
> >   		val = para->tpr6 >> 24 & 0xff;
> > diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> > index ce2ffa7a02..82b86084a6 100644
> > --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> > +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> > @@ -24,8 +24,8 @@ void mctl_set_timing_params(const struct dram_para *para)
> >   	u8 trrd		= max(ns_to_t(6), 4);
> >   	u8 trcd		= ns_to_t(24);
> >   	u8 trc		= ns_to_t(70);
> > -	u8 txp		= max(ns_to_t(8), 3);
> >   	u8 trtp		= max(ns_to_t(8), 2);
> > +	u8 txp		= trtp;  
> 
> I think Jernejchanged this value using RE. I checked the 047fb104 
> register (dramtmg[1])
> 
> on my t98-h2b-lp3 tvbox, it has not changed and is the same as the 
> factory value.

So my educated guess (if that change originates from REing of binary
driver code):
- tXP and tRTP do not seem related, judging by JEDEC documentation. If
  the txp value is assigned the value of trtp, that's probably some
  compiler optimisation, because both variables were assigned to the
  same expression, in the original vendor code.
- The LPDDR3 spec describes tXP as "max(7.5ns,3nCK)", that would be
  the original setting. Down to 500 MHz DRAM clock ns_to_t(8) results
  in a value of 3 or higher, so this change would only be relevant for
  DRAM clock speeds below 500 MHz. I doubt we have a board with
  LPDDR3 DRAM that slow?

So I am happy to change that code, if that's closer to what the vendor
driver does, but I doubt that this will impact any actual hardware.
Also I would like to change the assignment to copy the *formula* that
trtp is using, instead of copying the value of it. So this effectively
just lowers the minimum clock cycles to 2 (instead of 3).

Does that make sense?

Cheers,
Andre

> 
> => md.l 0x47fb100  
> 047fb100: 10141811 0004041c 04070d0d 0050500c .............PP.
> 

