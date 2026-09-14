Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFB5C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 03:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61F9440552;
	Tue, 15 Sep 2026 03:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dbJYajSvtssu; Tue, 15 Sep 2026 03:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5791440543
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789442767;
	b=OpGwWgCzKka+51r0VpmyhGF15T41hIQ04GCbvvWC63IzUmb6UbchLkv8WQCKgL6YUH6N
	 VZ2qulvv4Vm1TgwGzWJT2KkpRqd6x+FSKTsi1lqGPMrwYxCjFoGugmUnfJigPN2X3JVym
	 8EGSuCAgzLluwKv/Zxvp5E/C9uahlywSqAjrh5ebhIj60HygJ044u6jLLKEVCjkA9mHqX
	 M6KEUioV/htMlPfMw5k4tw22Xp03o9VlGDTg8gOKdCGag2cgwrKzMQVA2KcrMAN+wlNVt
	 MtpN0Crt0z2XaiD1qb3EC3DWbgGaUBhk+rTQZNkSEspzB/7cjrmKWgr88bw2dsZTgzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789442767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oPMZcs1HkpT+2HBm7c3UZNLy9aPnZWDc0UkyPp/KaXc=;
	b=pHVhoar5aGD88c85DdWlCYrB7JrnZFQ/slyRqxPJooBFzQczx2JE0Xn0xDmtUqXXf+uy
	 GvnFz9OQT1pfrSJm5Q8AG8jP+Di3FEiQfveNnAuLlUPyBYKxLhRXfioN8cqw1udkQwxaf
	 RaW2IRpzKMFYTcBUEyncxCBf7aVss5B//T0oYSDb7+VBJTr9LJCMiAsn7tVK9pkliQJw6
	 KgpBBQmVRNyKw39TgDjiDXsHvZDtPCjVfFhyeptbYiqEVvz8Es7MPsx/2g97ZELS+caFZ
	 sQsOb6+gSLAj02S3jmBeE1u1KJdXGxZjQoi3e+7OWugj7gleb74wLUrA8lxXOG62mWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789442767;
	bh=oPMZcs1HkpT+2HBm7c3UZNLy9aPnZWDc0UkyPp/KaXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqSusn5DAJu177snjwkXFXaqsHj6UdGO4qIUGsh5Tn0zjCvBBjD7vvTm6t5ZTkxiG
	 FEaXwbWKM4eCRInj5vRtBQ5aqagrpj/ElbgpZTBZja8dKGWBglnDvLXEfVD468tVyO
	 X6QQgmRU8jK8PXhukcuBgT+XEdJFg8U9Cm1k8ttx/k84UVSwU98eesCXq+D9LXChjM
	 tuZD05v0lIhVQIRh7tPw2rsgSdNSUrE0kV8ol0E9RKsj9sZLzPu81/S67+eOs64csc
	 wmK9Ml5xuOy/VCW0hcG16QuYcj+enkpsIQTbgUBZ0cODeBqVGRfU3a+cMhnsj9PJDG
	 KWaQkNAzFurQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5791440543;
	Tue, 15 Sep 2026 03:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B878C259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA2424009D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObaLrjqBLP5V for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 03:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 491BE40082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789442765;
 b=pvLedPNM0POmNrVYgmXKqQoCQFNflDZ6exs2fHiQXvVCGGNPzTma4VKeU7GhEHZBu1dQ
 DCoS7qXrOqwUPTvqxTCNbOjeip/wxAc5nRnUeODOEcq2CNpw8mpYsBgksIXNxDC3EHxBV
 +TPGe3E2ktv7GGzRS6us0e8JcfYUs+eCF4wtIcuf6vzfsiyKH6t2CztQGloIwuIBOq1hB
 Ffs+nAiXkZg5DH8PP7NKte7IEM0KnZfBxcjcsBWK5Kji/90q92D3dMINlLvFRTCYhyCVg
 ucjoPGvIbmeWcYg1x8N0KrG5fjRQWO2nWbViD/P1m2sVxIC9W5xDKrFyTZTGNQgI84w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789442765;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=oPMZcs1HkpT+2HBm7c3UZNLy9aPnZWDc0UkyPp/KaXc=;
 b=Hp8KGQTWF/YmMwD0W+nYUgDy86I8vLV1jGNKOkQzTIrVnn5se1B1CY83OL+8hD46nUdy
 K96woGTrG73OSbm/UFiaM7Mw6/EZxmFVNcr09+agtI9XSFLtv6bYZ6DMDl1Eus8fFMYdS
 QZ+g+9BEPlVC8cTp7B6uj5Lt8X0wfnGddJJBuvcrwjFyrCY4TOoyX6UuR13vxIqL0U1nG
 g6xoW1cp00Izt0MKbwTdx+C1DQ8ff4Svj6577PKk+HGhadT5jjegKqntkgllqwvb/J6r+
 7LoXCe9fkRrgRNfsutIN6yxnwAUR2yppcK3nnyiD+ElvVaGd8j343D26vFHxikm67Ig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=DsvlLy37; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vUQClCRE; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=DsvlLy37; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vUQClCRE
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 491BE40082
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 03:26:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hkS8p3FNbzMl71;
 Tue, 15 Sep 2026 05:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789442762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPMZcs1HkpT+2HBm7c3UZNLy9aPnZWDc0UkyPp/KaXc=;
 b=DsvlLy379dcxsH5elzQOcBRQrAbmsB1QkR2MqJHBxI0BmOb9pVhworGCFS/77Sp4ozhhtP
 Lijs9gVJxc4z71I+QeVexheMtxBwv/EUOldi+9OLctIGaYfgJV/tCQ+Dyb7os47Dm4wqCa
 22IhgA8Sw5QSm24Ww8plPHHobcNys7vFHAgL/gc6+n0JZaoNvSFoauEuMkm8Dfrz2aSag2
 94DSpjwLVibxLPLY0e65vPeFfgyUetG4pO7fGTSiC8mJ5z9+9iJ9Q2x5QJkH+Sqzvr7M77
 BV7ecuyIUYbYilS22RjjJIyg4jgmxGYAb8subnDqD5YxlPrTwSN/JTAUS+a8RA==
Message-ID: <94548efb-5bb8-4320-82ea-5e40b706d584@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789442761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPMZcs1HkpT+2HBm7c3UZNLy9aPnZWDc0UkyPp/KaXc=;
 b=vUQClCRE0EiQMWRwaqdw1RUuGVECibzBjDJzH3ebLu0a5/7I11px5Hyh6XP8PXgK+qBkwH
 WAZ5k3rAvi3QcFkmRj3zzf3l3aFg+iurfkGTa8ogV9w528AsQW0+rln9vghbnwOE5OmkpE
 21qa1xxxqoU5jJl8C4lpxhGz7oohRIJrJ9bJUAmnaF7iLj6nzDU6vaoJ5gwkay/RPsD/wq
 QA2V6uDUwT09VYCW2zRD5PKagjwwSXxlxNHJriFE10OkWL8bdQ+1VGJtWpFAMlUmkOqu9v
 Y3Ga+QVeW2jToF+598mtvYjxze/FAre76XVprY6vfCCHHwc8EuwGGlIYyrzH6A==
Date: Mon, 14 Sep 2026 21:26:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 lukma@denx.de, mkorpershoek@kernel.org, antoine.gouby@toradex.com,
 alice.guo@nxp.com, stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-4-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260914074314.12522-4-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a04fd235038d9256e2c
X-MBO-RS-META: mkwuhjaksdp7pudxzu4hq4h1qrgqbnir
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

On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
> port the hub itself enumerates fine but a USB stick plugged into it
> fails intermittently:
> 
>    Verdin iMX95 # usb start
>    starting USB...
>    USB XHCI 1.10
>    Device not responding to set address.
> 
>          USB device not accepting new address (error=80000000)
>    Bus usb@4c100000: 2 USB Device(s) found
>           scanning usb for storage devices... 0 Storage Device(s) found
>    Verdin iMX95 # usb reset
>    resetting USB...
>    USB XHCI 1.10
>    WARN endpoint is halted
>    WARN endpoint is halted
>    unable to get device descriptor (error=-22)
> 
> Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
> both controller DT nodes") added a fallback that searches the DWC3
> child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
> the parent glue node, but always resolves the found index against
> glue->clks, a clk_bulk populated only from the parent glue node's own
> clock-names list. This is wrong since the child node's clock-names list
> is not guaranteed to be in the same order as the parent's, and indeed on
> Verdin iMX95 the child node has a different order than the parent node.
> 
> Fix it by looking the reference clock up by name with clk_get_by_name(),
> walking the dwc3 device first and then its parent glue device, so the
> clock is always resolved through the device that owns the node its name
> was found in. Also enable the clock before use, the child node's clocks
> are not part of the glue node's clk_bulk and are therefore not enabled
> by dwc3_glue_clk_init(), and disable it again in dwc3_generic_remove()
> to keep the enable balanced.
> 
> Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 47 ++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2356b3bc0aa..704dd242553 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
>   	struct dwc3 dwc3;
>   	struct phy_bulk phys;
>   	struct gpio_desc *ulpi_reset;
> +	struct clk ref_clk;
>   };
>   
>   struct dwc3_generic_host_priv {
> @@ -47,8 +48,8 @@ static int dwc3_generic_probe(struct udevice *dev,
>   	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>   	struct dwc3 *dwc3 = &priv->dwc3;
>   	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
> -	int __maybe_unused index;
> -	ofnode __maybe_unused node;
> +	struct udevice * const __maybe_unused clk_devs[] = { dev, dev->parent };
> +	int __maybe_unused i;
>   
>   	dwc3->dev = dev;
>   	dwc3->maximum_speed = plat->maximum_speed;
> @@ -63,22 +64,31 @@ static int dwc3_generic_probe(struct udevice *dev,
>   	 * - in top level generic node, with no subnode (i.MX8MQ)
>   	 * - in generic subnode, with other clock in top level node (i.MX8MP)
>   	 * - in both top level node and generic subnode (Rockchip)
> -	 * Cover all the possibilities here by looking into both nodes, start
> -	 * with the top level node as that seems to be used in majority of DTs
> -	 * to reference the clock.
> +	 * Cover all the possibilities here by looking into both nodes, the
> +	 * generic node first and the top level glue node second. The clock
> +	 * must be looked up on the device that owns the node it is described
> +	 * in, the clock-names lists of the two nodes are unrelated (e.g. on
> +	 * i.MX95 the glue node has "hsio", "suspend" while the generic
> +	 * subnode has "bus_early", "ref", "suspend").
>   	 */
> -	node = dev_ofnode(dev->parent);
> -	index = ofnode_stringlist_search(node, "clock-names", "ref");
> -	if (index < 0)
> -		index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> -	if (index < 0) {
> -		node = dev_ofnode(dev);
> -		index = ofnode_stringlist_search(node, "clock-names", "ref");
> -		if (index < 0)
> -			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> +	for (i = 0; i < ARRAY_SIZE(clk_devs); i++) {

Do we need a loop for two device pointers, where we are basically sure 
that there won't ever be any more device pointers in the list ? (I think 
no, so please use four clk_get_by_name() calls and be done with it)

Also, please send this patch separately, so it can be picked as a bugfix 
for 2026.10 .

Thank you.

> +		struct clk clk;
> +
> +		rc = clk_get_by_name(clk_devs[i], "ref", &clk);
> +		if (rc)
> +			rc = clk_get_by_name(clk_devs[i], "ref_clk", &clk);
> +		if (rc)
> +			continue;
[...]
