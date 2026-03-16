Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D8F53D67
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 15:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D1C840BE;
	Mon, 16 Mar 2026 16:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="xO+8XlC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F299F840CB; Mon, 16 Mar 2026 16:10:00 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E26840A9
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 16:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=dkVGii8kmEgbEaTbTSDFkqsUiZioFswHPOwyD3uCi1U=;
 b=xO+8XlC/a2X//F0w4UscV4B4DVZd6vfcT/beXAP/dKmC6ehVb77JNkCCp2uvFa49mX2KQrqxYQ2PnE9T+ZSkst8aaI2GWRZV+AXQKtvlwnyHp4o2MHIGTEGxmbpkCCOr+Pv7eI7TTTQamf/cR9gVO01HsTRtiuvaNTaori0UUzeOBaAHdP7pk1y30UKurAnVzkgkvH7LqKV3mIr3zyHDHKruYBoNgLHdmnhUL39TPwoFF/XoaYlxrPEoHJ
 DJDlMjgmG9AdgCRaT1yx1i8k17yR3GBflw8M26nRTN6UAL1eP0bkiCzlrdjAaqRLgCGnKtCEejdP5RS6uG6TbRuB99Yw==
Received: from GRAPHRT (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 15:09:50 +0000
Date: Mon, 16 Mar 2026 17:09:52 +0200
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: rk3288: add stub for ops->enable
Message-ID: <abgdQEXnw3rP3KE6@GRAPHRT>
References: <20260316095709.2701-1-m95d+git@psihoexpert.ro>
 <4b4412f1-c915-4d9d-ba34-9d70da331886@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4412f1-c915-4d9d-ba34-9d70da331886@kwiboo.se>
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

On Mon, 2026-03-16 11.10.38 ++0100, Jonas Karlman wrote:
> Hi Marius,
> 
> On 3/16/2026 10:57 AM, Marius Dinu wrote:
> > This fixes a bug where the watchdog can't enable the clock.
> > AFAIK, this clock is always enabled.
> > 
> > Tested on Asus TinkerBoard. Test results:
> > wdt dev         => works
> > wdt start 200   => works, but timeout is 43s
> > wdt start 10000 => works, but timeout is 1m27s
> > wdt reset       => works
> > wdt stop        => doesn't work
> 
> I have a different patch incoming that should fix this issue at watchdog
> driver level, something like following should make this work and
> properly handle platforms not implementing clk_enable ops.
> 
> diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
> index bd9d7105366..91228de5e8e 100644
> --- a/drivers/watchdog/designware_wdt.c
> +++ b/drivers/watchdog/designware_wdt.c
> @@ -122,7 +122,7 @@ static int designware_wdt_probe(struct udevice *dev)
>                 return ret;
> 
>  	ret = clk_enable(&clk);
> -	if (ret)
> +	if (ret && ret != -ENOSYS)
>  		return ret;
> 
>  	priv->clk_khz = clk_get_rate(&clk) / 1000;
> 

OK. I'm moving on from this arch and I just wanted to send all remaining
fixes that I use.

About your patch: aren't there commands or drivers other than wdt that may
try to enable the clock and fail?

> > 
> > Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> > ---
> >  drivers/clk/rockchip/clk_rk3288.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
> > index a4ff1c41abb..9cc883662ff 100644
> > --- a/drivers/clk/rockchip/clk_rk3288.c
> > +++ b/drivers/clk/rockchip/clk_rk3288.c
> > @@ -745,6 +745,10 @@ static ulong rockchip_saradc_set_clk(struct rockchip_cru *cru, uint hz)
> >  	return rockchip_saradc_get_clk(cru);
> >  }
> >  
> > +static int rk3288_clk_enable(struct clk *clk){
> > +	return 0;
> 
> This should properly be implemented for the clocks you need, and return
> -ENOSYS for the clocks not implemented.
> 
> > +}
> > +
> >  static ulong rk3288_clk_get_rate(struct clk *clk)
> >  {
> >  	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
> > @@ -947,6 +951,7 @@ static int __maybe_unused rk3288_clk_set_parent(struct clk *clk, struct clk *par
> >  }
> >  
> >  static struct clk_ops rk3288_clk_ops = {
> > +	.enable		= rk3288_clk_enable,
> 
> Also include proper disable ops for the clocks you add enable ops for.
> 
> Regards,
> Jonas
> 
> >  	.get_rate	= rk3288_clk_get_rate,
> >  	.set_rate	= rk3288_clk_set_rate,
> >  #if CONFIG_IS_ENABLED(OF_REAL)
> 

Right! That's probably why "wdt stop" doesn't work.

Marius

PS: There is a duplicate of this email sent from the wrong address. Sorry.

