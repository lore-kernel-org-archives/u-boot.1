Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB03C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742A58780A;
	Tue,  2 Jul 2024 15:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbSFx3wY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAEE883AC; Tue,  2 Jul 2024 15:20:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B349871C7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5903461B98;
 Tue,  2 Jul 2024 13:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D014C4AF07;
 Tue,  2 Jul 2024 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719926448;
 bh=4yjz/ylRLQh89qu9m9ng0XQXPCMUa9m02Dto6ARSYXs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gbSFx3wY/qSZl0ajr3Q8c4RrnS1lUBM8rfcnw8egCY8TVe7tsbHGqplGRr0fBGWIk
 ZHfUxNu0CCkacWa5PWla+o42UXyJaqWmo2/rqoTAX+fS3/MagYn/5PWttM6PoJ0dCy
 NNJscP190sCE/3QAO0b8Oa1S8qF5CAIW9Wf+Kuh+09Rs4dxDlUjtvGxwMhnLYNLNsj
 r7NpyD55/jw9V4pnUxXX9Dn/M2YHItvitJYdJY9LnRoS0oU7tVwm5uVyWrn3oZoY2T
 oyb9nnr+EPm6582feySBgCJv70QVzvrpOyQK2c2j6zvpSOMzYUQlW56OGro70Ex6OB
 O7XbxOYyqS+Pg==
Message-ID: <f75621af-cfcc-4909-bb79-dbbc9aeb30e2@kernel.org>
Date: Tue, 2 Jul 2024 16:20:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: continue probe even when USB PHY device does
 not exist
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de,
 trini@konsulko.com, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, danishanwar@ti.com, srk@ti.com
References: <20240702120724.368102-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240702120724.368102-1-s-vadapalli@ti.com>
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



On 02/07/2024 15:07, Siddharth Vadapalli wrote:
> Prior to commit cd295286c786 ("usb: cdns3: avoid error messages if phys
> don't exist"), cdns3_probe() errors out only on failing to initialize the
> USB2/USB3 PHY. However, since commit cd295286c786, absence of the PHY
> device is also treated as an error, resulting in a regression.
> 
> Extend commit cd295286c786 to treat -ENODEV as an acceptable return value
> of generic_phy_get_by_name() and continue device probe as was the case
> prior to the commit.
> 
> Fixes: cd295286c786 ("usb: cdns3: avoid error messages if phys don't exist")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> b4cbd1a257 Merge tag 'u-boot-amlogic-20240701' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
> of the next branch of U-Boot.
> 
> Regards,
> Siddharth.
> 
>  drivers/usb/cdns3/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index b4e931646b..5b3e32953e 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -338,7 +338,7 @@ static int cdns3_probe(struct cdns3 *cdns)
>  			dev_err(dev, "USB2 PHY init failed: %d\n", ret);
>  			return ret;
>  		}
> -	} else if (ret != -ENOENT && ret != -ENODATA) {
> +	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {

With this change we will not error out on a genuine error condition
that produces ENODEV.

If PHY phandle is not present the API should return ENOENT right?

static int __of_parse_phandle_with_args(const struct device_node *np,
...
{
...

        /* Retrieve the phandle list property */
        list = of_get_property(np, list_name, &size);
        if (!list)
                return -ENOENT;

Can you please check and point where the -ENODEV error is coming from?

>  		dev_err(dev, "Couldn't get USB2 PHY:  %d\n", ret);
>  		return ret;
>  	}
> @@ -350,7 +350,7 @@ static int cdns3_probe(struct cdns3 *cdns)
>  			dev_err(dev, "USB3 PHY init failed: %d\n", ret);
>  			return ret;
>  		}
> -	} else if (ret != -ENOENT && ret != -ENODATA) {
> +	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {
>  		dev_err(dev, "Couldn't get USB3 PHY:  %d\n", ret);
>  		return ret;
>  	}

-- 
cheers,
-roger
