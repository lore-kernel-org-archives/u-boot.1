Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BFFCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 15:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF66586E64;
	Tue, 17 Oct 2023 17:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697556786;
	bh=AfgqcEn8pDUuamYc3afAliWGav1zwPrx5Sl7zYhWb0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qCgpYpsMlOjaml5cneaiSsi0e2zFYGYFZA3qLr55ltp7cpYzpKTCOFgVQAnUtM6Gz
	 U/+lcbwvQGln47G7duyHLpeRhsx+VIFIS8aJIV7pdncyF8nSumwy/dSjOlmjQvzJON
	 Y93ueCwJLfIUy73f60HvLDFWy+1g3Re6mev2xAT24ZGbs7ZiJlmxcRDfTdGcr84nrS
	 jx4K338Y/MfOEoyqUynzmJliYhNNqkWj9okIy9PdABZYJyoaTsDaO7mekmvNf/OdFe
	 kqkEseH6wCvT4QciWlYFvo2pW+pvXmYJBnPYeBz28YPRXbJKgF5FdxmTNQuga/QUzq
	 aj1xjfdjmGr6A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E186A86CB1;
 Tue, 17 Oct 2023 17:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697556785;
 bh=AfgqcEn8pDUuamYc3afAliWGav1zwPrx5Sl7zYhWb0o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V3+CLoAHcrwF09E5QTbLH4jhtrNIFCTyMzXRsAQt/6HQAK0IWdipQB51R1S/cSdPZ
 cqnckEkbACXolqibiW4b9XT4yRGVsxRwt66U8ek7WFHP01X3jSCAA3fI/9sTS9GLOm
 VjkOaWxIYuAOcgWR7+zyPfjCLnSpHS4OuP/UP0E0Ouc9ed9iopOnQmvIOt4ojQOfJF
 UlA/LOy+g+BhYfswa0SquXw9vHcKH0au9psSjh7VJgUA+QtwqJao5b9bslEr3zIF7/
 cJ711wTY8qSI3IU5xdPZySXWaZb3M/JFMD3m5R1LLRn7kLOn259qQfuYRSvPu7TYPi
 cT0N43buF/5hQ==
Message-ID: <485cdc88-6898-43b9-9079-f9fe58e26848@denx.de>
Date: Tue, 17 Oct 2023 17:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 83c63f0d118 (led: Move OF "label" property parsing to core)
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 u-boot <u-boot@lists.denx.de>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
References: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/17/23 15:29, Rasmus Villemoes wrote:
> Hi,

Hi,

> I'm trying to resurrect an old submission of a driver for ti,lp5562, so
> had occasion to dig into drivers/led/. And I think commit 83c63f0d118 is
> buggy or at least incomplete.
> 
> Many of the drivers that were subsequently modified to not do that
> "label" parsing rely, in their .probe method, on the top node being
> distinguished by not having a ->label. And led-uclass itself does that
> 
>                  /* Ignore the top-level LED node */
>                  if (uc_plat->label && !strcmp(label, uc_plat->label))
>                          return uclass_get_device_tail(dev, 0, devp);
> 
> The drivers used to only do that label-parsing for subnodes of the top
> node, so that worked, but the new code assigns some ->label for anything
> bound to a LED uclass driver. There have been at least two patches to
> individual drivers to fix this up since (the current top two patches
> touching drivers/led/), but I think that's the wrong way to handle this.
> 
> At the same time, I actually think 83c63f0d118 didn't go far enough in
> deduplicating, since all drivers are left with essentially the same loop:
> 
> static int led_gpio_bind(struct udevice *parent)
> {
> 	struct udevice *dev;
> 	ofnode node;
> 	int ret;
> 
> 	dev_for_each_subnode(node, parent) {
> 		ret = device_bind_driver_to_node(parent, "gpio_led",
> 						 ofnode_get_name(node),
> 						 node, &dev);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	return 0;
> }
> 
> static int bcm6753_led_bind(struct udevice *parent)
> {
> 	ofnode node;
> 
> 	dev_for_each_subnode(node, parent) {
> 		struct udevice *dev;
> 		int ret;
> 
> 		ret = device_bind_driver_to_node(parent, "bcm6753-led",
> 						 ofnode_get_name(node),
> 						 node, &dev);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	return 0;
> }
> 
> and that string can, if I'm not mistaken, be gotten from
> parent->driver->name.

Which string ? The "bcm6753-led" is driver name , so that would have to 
be parametrized.

> So we really should be able to create a
> generic_led_bind() that does exactly this loop + the "label" parsing,
> remove the label parsing from post_bind (so it doesn't apply to the top
> nodes)

Make sure you test the 'led' command. The LEDs might be bound, but not 
probed (so label parsing in LED probe would be too late), and if I 
recall it right, the label parsing has to be in post-bind for the labels 
to correctly show in the 'led' command listing.

> , and switch all drivers over to this generic_led_bind().
> 
> Alternatively, we can still create a generic_led_bind() that just does
> the loop as above, but then somehow prevent the top nodes from gaining
> ->label, say by not adding the nodename fallback if the node has a
> "compatible" property (though that seems like a hack, maybe there's a
> cleaner way).

I am all for generic_led_bind() .
