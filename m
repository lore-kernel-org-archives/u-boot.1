Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EC9CCD194
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 10:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB67E8362A;
	Thu, 16 Oct 2025 12:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="qKSmhekK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A47783631; Thu, 16 Oct 2025 12:26:13 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418B3835FE
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 12:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=p6K6fKXWA7Q7EfHoJOQtHHQsUM/V1pLx36b/fVKj5i0=;
 b=qKSmhekKjpEfkfUnBsp54FEzgazlYpAxWwbpZVoTa2RQpVN1DzaFtxDO8KYAvc27DB3kPZSFjCJhmnfoRap08Jbb2v1oqa0ohEGxNpRxeqghW40CqGPyI4L5QU4dN3+tUQwMvf3+A9bMIPiQZpltk7rXZtywXEU6kf62+ln5iIgjwzCkje4aTyLxohFpvA0vbVcaFBGj0YwLttmOLHtRmth/g+b86OcGa9czP81qSDbxyuXtFdr029tHT1
 CaHBvXjRM6xJqiLcIIItdc6JwdhONyiUd0KBHnIMf2ckCiA/6Jm7El75p66lEuxJk60clspjOo8Hb22QMrKk6PTc6egQ==
Received: from GRAPHRT (188-24-192-7.rdsnet.ro [188.24.192.7])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Thu, 16 Oct 2025 10:26:07 +0000
Date: Thu, 16 Oct 2025 13:26:04 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Subject: Re: [bug] can't start watchdog on RK3288
Message-ID: <aPDIPO4HEKRf2/Y2@GRAPHRT>
References: <aO5F+z0n5ETHZZGt@GRAPHRT>
 <CALeDE9M1nfBSM6jLer1uqtzf+b8eZq_33ALA7_mSKC5k53OoQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9M1nfBSM6jLer1uqtzf+b8eZq_33ALA7_mSKC5k53OoQw@mail.gmail.com>
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

On Tue, 2025-10-14 19.12.23 ++0100, Peter Robinson wrote:
> Hi,
> 
> > I have a bug to report. I tried starting the watchdog on Asus TinkerBoard S
> > (Rockchip RK3288), but it's not working. I investigated a little bit. Here's
> > what I found so far:
> 
> What version of U-Boot is this? Does the watchdog work in Linux?
> 
> > => wdt dev watchdog@ff800000
> > drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: timeout-sec: (not found)
> > drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: hw_margin_ms: (not found)
> > drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,noautostart: false
> > drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: u-boot,autostart: false
> > drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
> > drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
> > drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
> > drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
> > drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
> > drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
> > drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
> > Can't get the watchdog timer: watchdog@ff800000
> >
> > It seems that the error is generated in designware_wdt_probe(), after
> > clk_enable(). Function clk_enable() runs on branch CLK_CCF=false. It returns
> > error from ops->enable. Struct ops is defined by driver: rockchip_rk3288_cru,
> > in drivers/clk/rockchip/clk_rk3288.c, but it doesn't have a .enable or
> > .disable component, so there is no ops->enable.
> >
> > The solution to this one would probably be a stub for .enable. AFAIK, it's
> > always enabled.
> >
> > I also tried to enable CLK_CCF (drivers from Linux tree), selecting the
> > watchdog works, but if I try to start it, the board immediately resets.
> > I have no ideea how to troubleshoot this one.
> >
> > Thanks.
> > Marius
> >

I updated to latest u-boot (yesterday's github) and I patched clk_rk3288.c:

diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index a4ff1c41abb..9cc883662ff 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -745,6 +745,10 @@ static ulong rockchip_saradc_set_clk(struct rockchip_cru *cru, uint hz)
 	return rockchip_saradc_get_clk(cru);
 }

+static int rk3288_clk_enable(struct clk *clk){
+	return 0;
+}
+
 static ulong rk3288_clk_get_rate(struct clk *clk)
 {
 	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
@@ -947,6 +951,7 @@ static int __maybe_unused rk3288_clk_set_parent(struct clk *clk, struct clk *par
 }

 static struct clk_ops rk3288_clk_ops = {
+	.enable		= rk3288_clk_enable,
 	.get_rate	= rk3288_clk_get_rate,
 	.set_rate	= rk3288_clk_set_rate,
 #if CONFIG_IS_ENABLED(OF_REAL)

...and it works, but not exactly as it should.

wdt dev works
wdt start works, but the timeouts are all wrong
wdt reset works
wdt stop doesn't work

Timeouts:
wdt start 10000 => 1m27s until reset
wdt start 1000  => 1m27s
wdt start 200   => ~40s
wdt start 100   => ~10s
I measured timeouts while watching output via serial->microcom->ssh,
so they're not really precise.

Marius

