Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09897CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3211887475;
	Thu, 19 Oct 2023 17:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729744;
	bh=wX3ASylr+L/3crtp9NHMJwB+2OqvGIPJMIdrI/MNifI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cC/prXxSLsZMp/wh5U0APmNNT4AbbQFe2TQDGQRjOzKEppdhP4M8DhSt1Hgmf4JXs
	 UFM5qXq3drBr3slrSbQTJ/lcdA3J6iBBP+CWqEBnD50pvF0tFgb430oE6rW/WNBAqB
	 F/3cZr/mL4LUEwWH/uf6pv3BN5SWmMDMhTheGVqJrrpKnZc/5GdNX1721wTrmAXVS5
	 IoF+ZfkNCJsYwN/+GVyteL2SPwQmfsiPDs4YiIkdFiDLS4iBxO2ZP1U7EZT3tN9vqd
	 55LhqzdK4i9YNMi0ThrjHG/Cm4nZXrrFltM/ZZrPzHvaqSFuSO6aT0aSKr6LfaxcWA
	 cVdL5H70ef9Pg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 658308745A;
 Thu, 19 Oct 2023 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729743;
 bh=wX3ASylr+L/3crtp9NHMJwB+2OqvGIPJMIdrI/MNifI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zb2heteC666o5YZhzBx9Xl+gM7rM8egY4mXGZGsYNaKMbqkPyjAt1RvFhCLy32Ai4
 ApRqiFl8XhH+YVaFKygosRQf4ojha10AGUVqP5jBRV3Lqa+5miBCcCpxMJnut57EvN
 d310SFo+wf+vSEQCx6CLQ0mLh9Yc2FtnhMBmiQk61k4YAFZx+w+H5t97f6sSV9j29K
 E3dWJM/y0/YbNqFDi8/TpXoyIQX399erdKhFFY+dXh0lwmK9+49GdpIY8LAkLCDVML
 ImJrGgBVftrjpV0oIcmS9iHOx1sLweFl82PmFzwWSJ8mlruacO3La1wZxDFZoi/IL2
 +uotwZ3fJXZjg==
Message-ID: <6d33180d-f611-43f8-9b73-9ec44eafd277@denx.de>
Date: Thu, 19 Oct 2023 15:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] led-uclass: do not create fallback label for
 top-level node
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-2-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-2-rasmus.villemoes@prevas.dk>
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

On 10/19/23 11:58, Rasmus Villemoes wrote:
> Many existing drivers, and led-uclass itself, rely on uc_plat->label
> being NULL for the device representing the top node, as opposed to the
> child nodes representing individual LEDs. This means that the drivers
> whose .probe methods rely on this were broken by 83c63f0d1185 ("led:
> Move OF "label" property parsing to core"), and also that the top node
> wrongly shows up with 'led list'. Some drivers have since been fixed
> up individually, e.g.
> 
> e3aa76644c2a "led: gpio: Check device compatible string to determine the top level node"
> 01074697801b "led: gpio: Use NOP uclass driver for top-level node"
> 910b01c27c04 "drivers: led: bcm6753: do not use null label to find the top"
> 
> Binding the same driver to the top node as to the individual child
> nodes is arguably wrong, and the approach of using a UCLASS_NOP driver
> for the top node is probably better.

Note that
83c63f0d1185 ("led: Move OF "label" property parsing to core")
and
01074697801b ("led: gpio: Use NOP uclass driver for top-level node")
were applied shortly after each other, so I don't see the point of the 
aforementioned rant.

I sort-of understand what you are trying to do in this patch based on 
$SUBJECT of this email, but not from this wall of text, so can you 
abbreviate the commit message ?

> But as a temporary work-around, we can use a heuristic that only sets
> the label to the fallback value derived from the node name if the node
> does not have a "compatible" property - i.e., if it has been bound to
> the LED driver explicitly via device_bind_driver_to_node() [similar to
> what e3aa76644c2a did, but that then vanished with the next commit.]
> 
> Fixes: 83c63f0d1185 ("led: Move OF "label" property parsing to core")
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/led/led-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 68ca3c2970..5a5d07b9a7 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -72,7 +72,7 @@ static int led_post_bind(struct udevice *dev)
>   	const char *default_state;
>   
>   	uc_plat->label = dev_read_string(dev, "label");
> -	if (!uc_plat->label)
> +	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
>   		uc_plat->label = ofnode_get_name(dev_ofnode(dev));

Is there an existing driver which has a top-level DT node with "label" 
property ?

>   	uc_plat->default_state = LEDST_COUNT;

