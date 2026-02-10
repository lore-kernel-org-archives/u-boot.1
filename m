Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1054EB2700
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 21:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CAC83A5A;
	Tue, 10 Feb 2026 22:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a09CiUHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DFB83D0B; Tue, 10 Feb 2026 22:27:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D285C83A47
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 22:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f9ZQD62Bcz9tqc;
 Tue, 10 Feb 2026 22:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770758820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WVAPmpQvFahDxc3sFeRlexCZC3pytMRrQ6Q4/bRWbo=;
 b=a09CiUHYsZBb3Efc3tI6AFHYrTcJbaMKo2d7E7uD/0FhTeZA8drsrFx0Pnp9ftJJX/jJ6B
 ldn+nC0kS+pA77yjdgzRsCs3URQaRBTZ9OS1an/phAhm7PyJ+XhKD59LSXsADU71/Hu7Gh
 vxwKYWW/rnHCIDb0yciUqqFS83ACDKMeDcZqn5bR0M8VE30Gj8M+tY0/FXY3Dk6y/alual
 V5fjYA08ITFUgqQFEuZgn5o8cJLmnc5xKjWPmdxhbIchKW3RMyS41xqjJiklYcJ37HNLcl
 NktqUO7GQ6QquB+xf2YwRX+7+SH5UERvvzPYE4QYl2AHEPKVbjMOO+Pl02zHgg==
Message-ID: <210d1411-b049-4366-a2b2-cac982007df4@mailbox.org>
Date: Tue, 10 Feb 2026 14:46:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260209201415.303190-1-jonas@kwiboo.se>
 <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
 <20260209205126.GK2603314@bill-the-cat>
 <f5dd98cd-be29-4587-8ddf-3e43fcb7a811@mailbox.org>
 <20260209225332.GA2436104@bill-the-cat>
 <f4a0bb7b-197a-42f2-b6f9-ee6012ddccd7@mailbox.org>
 <2bc53024-8de6-4adf-bad6-0bf9d418a0a2@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2bc53024-8de6-4adf-bad6-0bf9d418a0a2@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zufjb1mg6yd8p6m6mtns4imk6n1q1f7k
X-MBO-RS-ID: 3c32e6787992aad297a
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

On 2/10/26 1:52 PM, Jonas Karlman wrote:

[...]

> I think main issue is that U-Boot != Linux, and in U-Boot we can disable
> subsystems such as CLK, and the normal U-Boot way to signal that is to
> return -ENOSYS from functions, what clk_get_rate() does when disabled.

Sure, but if the function is called the same, people will make the 
assumption that the function return value handling is the same. So 
either the function has to be renamed and maybe a wrapper added that 
makes it linux-compatible, or simply make the function linux-compatible.

> Other clk_*() related functions also differs from U-Boot and Linux, some
> only exists in U-Boot, others behave differently.

Which is really not good.

> Last attempt at changing clk_get_rate() behavior in U-Boot I gave a NAK
> on the Rockchip driver side. I am not fully against changing behavior
> of clk_get_rate(), but the driver ops should continue to work the same.
> There is a difference between an unsupported and an invalid clock.
> 
> Something like below, and similar for other clk ops, could possible be
> fine if someone really want to align clk_*() funcs with Linux.
> 
> Back to this patch, I will send other patches to implement the missing/
> unsupported dwc3 ref clocks on Rockchip, this patch is still valid and
> matches current and documented behavior for clk_get_rate() in U-Boot
> and prevent lockups or crashes when ref clk is missing/unsupported.
> 
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 748359de287b..4603ecef82b5 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -485,6 +485,7 @@ int clk_request(struct udevice *dev, struct clk *clk)
>   ulong clk_get_rate(struct clk *clk)
>   {
>   	const struct clk_ops *ops;
> +	ulong rate;
>   
>   	debug("%s(clk=%p)\n", __func__, clk);
>   	if (!clk_valid(clk))
> @@ -492,9 +493,17 @@ ulong clk_get_rate(struct clk *clk)
>   	ops = clk_dev_ops(clk->dev);
>   
>   	if (!ops->get_rate)
> -		return -ENOSYS;
> +		rate = -ENOSYS;

This would have to be PTR_ERR() , right ?

> +	else
> +		rate = ops->get_rate(clk);
> +
> +	if (IS_ERR_VALUE(rate)) {
> +		dm_warn("clk_get_rate(clk=%p, id=%lu) failed: %ld\n",
> +			clk, clk->id, (long)rate);
> +		return 0;
> +	}
>   
> -	return ops->get_rate(clk);
> +	return rate;
>   }
>   
>   struct clk *clk_get_parent(struct clk *clk)
[...]
