Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA3BC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5219878AC;
	Mon, 23 Oct 2023 10:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698049569;
	bh=ixYdz1MwSXs7T6Ib3JeT7OGivvyhwwwBJfxwctRYFpw=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSD8Dy62mSKNQKxRJxMxjAd6zlcwQ1Is17uomPZl81MMHE6JCjQgSac+0hf5+6JFl
	 /TGtPcbEcH5WvVDrm0wuoz0Kc3POfkyUxCEs33I6FoAKIJxZ4GjuqgJXyXspblWzZ5
	 VDmEdqZa1HeQmfGbYzXA7HVQWxArEtntqxvptbVQYj3RKlWcykuASMEePNlhgG63y3
	 OqI3r57ii3B1RN3EjtRCUi0QsIMXYL+/H+517qA3qivIAsIzHZshl29Mb8VQy7uxwN
	 dWRFvtSKg51xoCAIImt8BXa/+viXCDW1KprRC5oe4VXsZJQs1ReFRvYpz0nPb//3Uy
	 n4gZZGwskp0zQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B7B00875B1;
 Mon, 23 Oct 2023 10:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698049566;
 bh=ixYdz1MwSXs7T6Ib3JeT7OGivvyhwwwBJfxwctRYFpw=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=tI6b9SIqZYvyO0J51KnvI3HbV2jXHO6L81V27pekzGAnqFJxts0iBfrL2VVP0bIEa
 iKFMA1vk0ldSkmq4F6vRgBzMS35a/afpFcTrdYyoySpvWGVMsewa3i+3HO2ZUDMhPU
 NAYznOtWJkG+xnUpYApIh/LtiJe4U8fk1tLb6J1Xqm4CUxMPYFGl16UrMAgRJiNwVv
 p6oY6OyMxqnR2+HrjcywXtWZoWiOnmK1SXR60HxZ1SzO04TrxzFQaQQynfUP1AFpg8
 8aYz//TxfYoLl6suyaG76BoIa8hCT6+s2Cg7B/FWAgv2q5Vpi0CY/STz7k3bZy9DIc
 IFjk49ZJYB4KA==
Message-ID: <464e8700-c75e-4456-bb33-71873673b83a@denx.de>
Date: Mon, 23 Oct 2023 10:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] led: Do not overwrite label
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 open list <u-boot@lists.denx.de>
References: <20231023082117.39290-1-christian.gmeiner@gmail.com>
Content-Language: en-US
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231023082117.39290-1-christian.gmeiner@gmail.com>
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

On 10/23/23 10:21, Christian Gmeiner wrote:
> label might have been set by a non device-tree based U-Boot driver already.
> 
> In my concrete case there is a PCI driver that uses device_bind_driver(..)
> for different class types. The UCLASS_LED specific driver sets label
> in its bind function.
> 
> Without this change the LEDs exposed by the PCI device are not available.
> 
> Fixes: 83c63f0d11 ("led: Move OF "label" property parsing to core")
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>   drivers/led/led-uclass.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 68ca3c2970..aebdfdeb95 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -71,9 +71,10 @@ static int led_post_bind(struct udevice *dev)
>   	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>   	const char *default_state;
>   
> -	uc_plat->label = dev_read_string(dev, "label");
>   	if (!uc_plat->label)
> -		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
> +		uc_plat->label = dev_read_string(dev, "label");
> +		if (!uc_plat->label)
> +			uc_plat->label = ofnode_get_name(dev_ofnode(dev));
>   
>   	uc_plat->default_state = LEDST_COUNT;

+CC Rasmus, you really do want to review this one.

There is existing and more extensive series from Rasmus addressing the 
same issue.
