Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD18680C0F;
	Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PX9nFpN1h0sW; Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3BBC80B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747451;
	bh=znzpJRygnobzxhaPO1RSBxXzQ7OxVwUEYI+oYcKw6A0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CfYLKe9QfrrE/CvL0LhNmHxvSg1p4mByLEu5WAno3lBUMwQu2xBwJBtM/vt0+oB/p
	 X/xW2A2mcPfUhOqb6yGWmJ+m0+CI0s1L9yB+gzfiArjRuZ02SD1kus0newawl9o25l
	 R7tCmaQtt60nFaPLx+SfyFt35DEKzt06FSJj3woiQtsGJwiQiVFyCTFkgeRHbkqGdT
	 B5ggUBHiothUz51aBM0Yi89hp5koqPMIPgsiK20J+X/WxbHAd0LohNF3H6rlNCUIS9
	 1h/3m7zkQfGsrMuTq5RW1B9SUfKdjWxnST97Lxo2UDhVb3IsRNxI7ssw8U3KfuOfHQ
	 SoaQ8i73UAecg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3BBC80B33;
	Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E944D194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD03980886
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OzWbAR4jVcB for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ED5E4811B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED5E4811B3
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED5E4811B3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:07 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hMHMn6xGFz8sxn;
 Sat, 15 Aug 2026 00:44:05 +0200 (CEST)
Message-ID: <9eb93d89-41f9-4c9b-a876-22e6f496443a@mailbox.org>
Date: Sat, 15 Aug 2026 00:05:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] gpio: dwapb_gpio: Enable all clocks
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xd1fsfqkq4yag6te34shog4yy8jtnf4b
X-MBO-RS-ID: 51d1e7b929f8d3d3dcd
X-Rspamd-Queue-Id: 4hMHMn6xGFz8sxn
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:29 PM, Ralph Siemsen wrote:

[...]

> @@ -132,12 +134,34 @@ static int gpio_dwapb_reset(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int gpio_dwapb_enable_optional_clocks(struct udevice *dev)
> +{
> +	struct gpio_dwapb_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = clk_get_bulk(dev, &priv->clks);
> +	if (ret) {
> +		/* Clocks are optional */
> +		if (ret != -ENOENT)
> +			dev_err(dev, "Failed to get clocks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable_bulk(&priv->clks);
> +	if (ret)
> +		dev_err(dev, "Failed to enable clocks: %d\n", ret);
> +
> +	return ret;
> +}
> +
>   static int gpio_dwapb_probe(struct udevice *dev)
>   {
>   	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
>   	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
>   
>   	if (!plat) {
> +		gpio_dwapb_enable_optional_clocks(dev);
Error is not propagated from this call.

Fail path that would disable the clock is missing in this function.
