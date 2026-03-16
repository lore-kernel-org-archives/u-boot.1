Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AE8F46441
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 10:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1754584027;
	Mon, 16 Mar 2026 11:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GffHT51O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD6384035; Mon, 16 Mar 2026 11:10:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCCA84020
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dbc6=BQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773655844;
 bh=tTKTVe5JJzeJtZzkyvkdypQnYlIn/BQ+OgqMk33rbsE=;
 b=GffHT51OffPvqjPYJs0bHNVh33Ly44naPTZ1Q6lAalQtxfbFFn8wJiulACPTBOwUBQ6QHNmr9
 TihYJrcVkKlLjjZ5caC6sfRaa7pXAPqfxyDjbLAkiTKgU31IEHupVu/c0Ln6+h/BY6NkPdr6OiD
 Vy75+bkvqACp+G/zuSFj4SNYbfqaav5MpBjjgGyWnmKhDNEHivMS9tZpJOecZAp5eg7r/3Ew3Bm
 Olq4uIpVKimJGeCmUcsVPiMqypuOzrSZ8p9s7ifSUXV6jZFpx7bKOCcuAMFNu3DIc3TIESs4WFt
 ozUm9QyDJ2xZp5H8pECgKHQoAsT9f0nsz/8Glipi4jqQ==
X-Forward-Email-ID: 69b7d7218ef23ace517da360
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.50
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4b4412f1-c915-4d9d-ba34-9d70da331886@kwiboo.se>
Date: Mon, 16 Mar 2026 11:10:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rk3288: add stub for ops->enable
To: Marius Dinu <m95d+git@psihoexpert.ro>
References: <20260316095709.2701-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260316095709.2701-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
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

Hi Marius,

On 3/16/2026 10:57 AM, Marius Dinu wrote:
> This fixes a bug where the watchdog can't enable the clock.
> AFAIK, this clock is always enabled.
> 
> Tested on Asus TinkerBoard. Test results:
> wdt dev         => works
> wdt start 200   => works, but timeout is 43s
> wdt start 10000 => works, but timeout is 1m27s
> wdt reset       => works
> wdt stop        => doesn't work

I have a different patch incoming that should fix this issue at watchdog
driver level, something like following should make this work and
properly handle platforms not implementing clk_enable ops.

diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index bd9d7105366..91228de5e8e 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -122,7 +122,7 @@ static int designware_wdt_probe(struct udevice *dev)
                return ret;

 	ret = clk_enable(&clk);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		return ret;

 	priv->clk_khz = clk_get_rate(&clk) / 1000;

> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> ---
>  drivers/clk/rockchip/clk_rk3288.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
> index a4ff1c41abb..9cc883662ff 100644
> --- a/drivers/clk/rockchip/clk_rk3288.c
> +++ b/drivers/clk/rockchip/clk_rk3288.c
> @@ -745,6 +745,10 @@ static ulong rockchip_saradc_set_clk(struct rockchip_cru *cru, uint hz)
>  	return rockchip_saradc_get_clk(cru);
>  }
>  
> +static int rk3288_clk_enable(struct clk *clk){
> +	return 0;

This should properly be implemented for the clocks you need, and return
-ENOSYS for the clocks not implemented.

> +}
> +
>  static ulong rk3288_clk_get_rate(struct clk *clk)
>  {
>  	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -947,6 +951,7 @@ static int __maybe_unused rk3288_clk_set_parent(struct clk *clk, struct clk *par
>  }
>  
>  static struct clk_ops rk3288_clk_ops = {
> +	.enable		= rk3288_clk_enable,

Also include proper disable ops for the clocks you add enable ops for.

Regards,
Jonas

>  	.get_rate	= rk3288_clk_get_rate,
>  	.set_rate	= rk3288_clk_set_rate,
>  #if CONFIG_IS_ENABLED(OF_REAL)

