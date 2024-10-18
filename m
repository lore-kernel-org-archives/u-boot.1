Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83412D30007
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6D288E02;
	Fri, 18 Oct 2024 15:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcZACjEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF60B88E02; Fri, 18 Oct 2024 15:33:06 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB8488D5B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a19bf0a1dso33609266b.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729258383; x=1729863183; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4OXLwPHyyBh4SwAYgZWURmGqN1HWydUhg+xG2f1PRb8=;
 b=JcZACjEXi2cmkVbndIKyyv71QkxHFm7bwjEu6vqXCqOHSpSjWfC9mLpJORIhTnGgnY
 BXizr/5PXj2z8DGFql/3IHgLWg54czq4En8WP47c4FzzdI4pEftt9cez4+q8nlZgGD74
 Xbu1k+6FprlPt0xCw1tklwCIemkhJ1zIcjfYvPj7pBpe7eXgjfwisdayxBhDHnZKnlYu
 1/I3UyAvSOYBm/WvWW+L4KS6ByjqF+DaJXaJPMQ2VaWmtHANy28eg4OZkTS4fYuUP0mN
 +wMoXXhsVp/cbd9e6IjK/FDiej8bsbLWsHbuKQVGAaEgHhIdd7ZDLtlQiNlG5Nb8NDg0
 gs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729258383; x=1729863183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4OXLwPHyyBh4SwAYgZWURmGqN1HWydUhg+xG2f1PRb8=;
 b=H+uaV2rF6lUMn1pFfVCWVdIZCw582f77cCHjIby+kanCP6V13Fe7XeZvoDuOAyV8/P
 WAtO2/hXxfVhk4at5c8zIcnnqhzSdsMpk8B1YP0m0lUP6pYMtb8TmzI6hTetb0vdKC/P
 BmsVVgyyw5G8vxC7jUROSLCSCPT+5ZOsX03UxGIUHEDLlggFWPkBxUy5xILcW4zWu/Gx
 IZ30nucHntbKMJY/9QqumABnT7dwHGEaEMzkIhJCeFNZWyIqc4ENkWioBORH2MML4RjN
 IBhScHVpfp5jg79hhz5emg8HjfKQmGIJcNXs6x+DD38+r2T+1tuwb9AHKADp58+oJLmX
 M2Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPHZpMupGUL6HZa0igyQx+TYlNiuI/5bbsiq5xZt0AQSLeCQghQzixe0ctKXshVXVo3t/cI24=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2xAAYG19Ig3CEL5JxV7uIDSJ96BczWtzy93saax/VujFyueGN
 DpAh9KnfriTvPK/HwkGvD8GS6qTEcKPj2TLKGewG909JU0Bz+qsU
X-Google-Smtp-Source: AGHT+IGQTBUDJ6F5LC6MgiXDTMYMiXOKguukOf/TG0diIDO9momSaZVdNy4LmF1c9JviG+tAJGI6jQ==
X-Received: by 2002:a17:907:6d0b:b0:a99:5f45:cb66 with SMTP id
 a640c23a62f3a-a9a69c92d01mr99249766b.11.1729258382904; 
 Fri, 18 Oct 2024 06:33:02 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68c2678bsm96436266b.191.2024.10.18.06.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 06:33:02 -0700 (PDT)
Message-ID: <4aef209c-cbed-4fac-b48a-4101e27e64f8@gmail.com>
Date: Fri, 18 Oct 2024 15:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: block: simplify rkmtd driver
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
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



On 10/18/24 03:30, Heinrich Schuchardt wrote:
> By using blk_create_devicef() instead of blk_create_devicef() the driver
> can be simplified and brought into line with other block device drivers.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/block/rkmtd.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
> index c55f052e51b..f84cacd7ead 100644
> --- a/drivers/block/rkmtd.c
> +++ b/drivers/block/rkmtd.c
> @@ -794,36 +794,19 @@ int rkmtd_init_plat(struct udevice *dev)
>  	return 0;
>  }
>  
> -static void rkmtd_blk_kmalloc_release(struct udevice *dev, void *res)
> -{
> -	/* noop */
> -}
> -
>  static int rkmtd_bind(struct udevice *dev)
>  {
>  	struct rkmtd_dev *plat = dev_get_plat(dev);
> -	char dev_name[30], *str;
>  	struct blk_desc *desc;
>  	struct udevice *bdev;
>  	int ret;
>  
> -	snprintf(dev_name, sizeof(dev_name), "%s.%s", dev->name, "blk");
> -

> -	str = devres_alloc(rkmtd_blk_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);

Hi Heinrich, Simon,

The function strdup() is not an exact replacement for the devres_alloc() function in relation to a device.
It is in use for memory leak detection / device resource management. 
Not sure what the status of that devres project currently is? Also tracking in general in relation to EFI and blk-class.

https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blk-uclass.c?ref_type=heads#L739

https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L812

Test for this driver are based on work done by Simon.
https://source.denx.de/u-boot/u-boot/-/blob/master/test/dm/host.c?ref_type=heads#L71

This rkmtd driver makes use of devm_kzalloc(). All the memory that rkmtd reserves is freed.
But if I remember well somehow I was not able to free all memory on unbind and was not able to find the source, so I didn't include that last test.
https://elixir.bootlin.com/u-boot/v2024.10/source/test/dm/rkmtd.c#L84

Johan







> -	if (unlikely(!str))
> -		return -ENOMEM;
> -
> -	strcpy(str, dev_name);
> -
> -	ret = blk_create_device(dev, "rkmtd_blk", str, UCLASS_RKMTD,
> -				-1, 512, LBA, &bdev);
> +	ret = blk_create_devicef(dev, "rkmtd_blk", "blk", UCLASS_RKMTD,
> +				 -1, 512, LBA, &bdev);
>  	if (ret) {
> -		free(str);
>  		return log_msg_ret("blk", ret);
>  	}
>  
> -	devres_add(dev, str);
> -
>  	desc = dev_get_uclass_plat(bdev);
>  	sprintf(desc->vendor, "0x%.4x", 0x2207);
>  	memcpy(desc->product, "RKMTD", sizeof("RKMTD"));
