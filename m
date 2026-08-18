Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F22C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA6EF4067C;
	Tue, 18 Aug 2026 06:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWUHv7WvOtp6; Tue, 18 Aug 2026 06:22:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 198E240596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787034133;
	bh=uTQX7ufQPoy1wNe9ayBmycjjRM/cQuBIja5S1YxyAj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8ccyh+XBVrOz8Ag0OxK34fw6c2RsMO19pRzyMn2plOvJAZiFMm5RUSMdGO92jAiZ
	 s7/bb0YyPQ7IxZTJgk3gZN2kSFUQJybYDRgO+rLXLwFZWBydfsxnxY3cY5FIADOtgh
	 svt3VqY+8YzKJ2l1GUXyC9xrA34bYtvmjD/8w2XSx90keb+5lo8JJOjgdjGrNC6aXA
	 VeQAdBsoXJBDefIUT713knQrNqoNR22ANnzWwcJL1cFhdKlLW6brNlr83Bmq0v0HMD
	 Qlsn+Yhh+thJUz35iVVdSrM3YNBSBZRGQiCTCHosN81cc/L7QnoxzlkCq2tSCymNBM
	 BsX8iTyHwK7xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 198E240596;
	Tue, 18 Aug 2026 06:22:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A439322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FA7780FB4
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfX18LcWoJiL for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:22:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E8F7280ECB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8F7280ECB
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GN//ygN3
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8F7280ECB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787034093; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OinAihWuH8b+wrdxDZegl6Ppg6soCP16MU/IYWtHphoHWkkmtjBPIhGeTXAMDPUWIK9cpbQtlaK/EamUQ2lAaiiN+/Zbxhvi7thmoVV8gYFW98YBJPoNKz3ltEgg2V3e8n+QJSVK//8q+n32+iCLsDGDkBsfDHDN/lCFsa8ffww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787034093;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uTQX7ufQPoy1wNe9ayBmycjjRM/cQuBIja5S1YxyAj0=; 
 b=K4y/yF+GtuXounY2WXmykHV5r/9aXL2dGUqzw7wFtil97fISBqXss/AOrnUhyyr7O8Cthj4iecuI+VrHcamL7+DGhEYinD5gCRTpGA9KGno+BL9V2mA0CPlspIIDV+dj9pKv72/yu4Wu1lqok81Ako4jxDxl8OHk6j1Zt6rOIs4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787034093; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=uTQX7ufQPoy1wNe9ayBmycjjRM/cQuBIja5S1YxyAj0=;
 b=GN//ygN3lope+//kQZ1vHQEa+xBBWM6VvYcFuZWA80McTv01hv5livq9vVdJnfMB
 nGQyp6sgbb1iaaoVj3/ycTx7iacVo7hKalCmH6E2NAfYokB5jnnKsPN7kRlHVA8r/7w
 o9fA8VX0kawwF5XmSiG6coeskdgDNv7jUaMbmxV8=
Received: by mx.zohomail.com with SMTPS id 1787034091014305.97910763596394;
 Mon, 17 Aug 2026 23:21:31 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:21:17 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Heiko Schocher <hs@nabladev.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Lukasz Majewski <lukma@denx.de>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
Message-ID: <aoP53S88q9Lyc3Et@pie>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.21.86
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, Aug 15, 2026 at 11:40:23AM +0800, Junhui Liu wrote:
> The K1 I2C controller requires both its functional clock and APB bus
> clock to operate. The device tree provides them as "func" and "bus", but
> the driver currently acquires and enables only the first clock.
> 
> Acquire both clocks by name and enable them during probe. Use explicit
> named lookups instead of the bulk clock API to align with the K1 Linux
> driver and keep the roles of the two clocks clear if functional clock
> rate configuration is needed later.
> 
> Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/i2c/k1_i2c.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
> index 2c7a1e0d3775..e2e4f9e53447 100644
> --- a/drivers/i2c/k1_i2c.c
> +++ b/drivers/i2c/k1_i2c.c
> @@ -51,7 +51,6 @@ struct k1_i2c {
>  struct k1_i2c_priv {
>  	int id;
>  	void __iomem *base;
> -	struct clk clk;
>  };
>  
>  /*
> @@ -465,6 +464,7 @@ static int k1_i2c_probe(struct udevice *bus)
>  {
>  	struct k1_i2c_priv *priv = dev_get_priv(bus);
>  	struct reset_ctl reset;
> +	struct clk clk;
>  	u32 speed;
>  	int ret;
>  
> @@ -487,15 +487,21 @@ static int k1_i2c_probe(struct udevice *bus)
>  		return ret;
>  	}
>  
> -	ret = clk_get_by_index(bus, 0, &priv->clk);
> +	ret = clk_get_by_name(bus, "func", &clk);
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_enable(&priv->clk);
> -	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
> -		debug("%s: failed to enable clock\n", __func__);
> +	ret = clk_enable(&clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_get_by_name(bus, "bus", &clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&clk);
> +	if (ret)

I prefer to have something logged when any of these operations fail so
it's easer to debug. With dev_* or log_* APIs, they should be optimized
out and taken no extra space if they don't reach the logging level.

But anyway, we currently have many drivers silently bail out in such
cases, so this isn't a hard requirement.

Best regards,
Yao Zi

>  		return ret;
> -	}
>  
>  	priv->base = (void *)devfdt_get_addr_ptr(bus);
>  
> 
> -- 
> 2.55.0
> 
