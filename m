Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2726BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B7B88B0E;
	Thu,  1 Aug 2024 12:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722508086;
	bh=ISWlbOIcIOQ9jH/4YSueahGAzecWZpNDwRPus8us+mo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ajAh9o0AcxgyGYG5ZKtpe6KYeWymYXAL1+THFs8aF8X3h7Cnj/64F9oR8YPLlRyPX
	 r/5tmTw82EwMyLY1AagiZcZrakb2TMB+S2VBPNFzllEj7i9/WgcMGLCTOYz3znj0pN
	 UHz6t+DNx2zW8O3h17xKvOYy8Xb79o/+BEB6iog4Tbfto2PJjDsBwsbzWIxbMA1sVd
	 dmqe0aHuglFd0+KIDcVE1zPp4XXmSnFkJBbQV+O9O0qR3Kd5qrYnizHzkcF20wPCfA
	 /W+CXHqUluRP9RSsFZwMceuZGlKBBSUoK/AUdNE1/ANKv/TMRKlPESqZyLqi+mVMCG
	 U6K6wMd1hsJJA==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3575888B0A;
 Thu,  1 Aug 2024 12:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722508085;
 bh=ISWlbOIcIOQ9jH/4YSueahGAzecWZpNDwRPus8us+mo=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=OBIqPGXY7gX2mfWuaQB/6wLBVDgzFQ2mOqVSgA7GmF+IPOE++datANUbnGzMZ/dcL
 j4Me+gMsVnN9gMkc01Il3GsAzr6LaYyaE9423u4HwUtOnCU1vyDGwgvVfpAsW1erI5
 mdfUxVDzaYA4cGfmlfA+M9441Jiu2n7c9iDrL4bzYelN/U0m8Y9tja8BtmEYNN+Tya
 AcAD583BN/knnXVcMiRnL/wEBUpO4uyN7vtuZBncK08OtBSeX7CT1rgCZAmtwdYX8z
 xaohq4WOanV79v831sHbIlSTbJMYYAnNlPGdn9AfNJjnVKiaN4liHkROKHLl6Fr2EX
 CKLF2mgDsb9Ww==
Message-ID: <9cbf52df-2ab6-2445-fb6a-7105c583da98@denx.de>
Date: Thu, 1 Aug 2024 12:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: mux: Fix error path in i2c-arb-gpio
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <b526d573c09b940d7bb234f3e96c47753844c949.1722499288.git.michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <b526d573c09b940d7bb234f3e96c47753844c949.1722499288.git.michal.simek@amd.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michal,

On 01.08.24 10:01, Michal Simek wrote:
> There is no reason to use goto and just call return. Better is to call
> return directly which is done for some if/else parts.
> 
> Also make no sense to setup ret to -ETIMEDOUT and then to 0.
> Return timeout directly.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> index a83d7cb0829d..3d2ce0ca705d 100644
> --- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> +++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> @@ -54,7 +54,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>   		/* Indicate that we want to claim the bus */
>   		ret = dm_gpio_set_value(&priv->ap_claim, 1);
>   		if (ret)
> -			goto err;
> +			return ret;
>   		udelay(priv->slew_delay_us);
>   
>   		/* Wait for the EC to release it */
> @@ -62,7 +62,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>   		while (get_timer(start_retry) < priv->wait_retry_ms) {
>   			ret = dm_gpio_get_value(&priv->ec_claim);
>   			if (ret < 0) {
> -				goto err;
> +				return ret;
>   			} else if (!ret) {
>   				/* We got it, so return */
>   				return 0;
> @@ -75,17 +75,14 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>   		/* It didn't release, so give up, wait, and try again */
>   		ret = dm_gpio_set_value(&priv->ap_claim, 0);
>   		if (ret)
> -			goto err;
> +			return ret;
>   
>   		mdelay(priv->wait_retry_ms);
>   	} while (get_timer(start) < priv->wait_free_ms);
>   
>   	/* Give up, release our claim */
>   	printf("I2C: Could not claim bus, timeout %lu\n", get_timer(start));
> -	ret = -ETIMEDOUT;
> -	ret = 0;

I wonder here ...

It seems to me current driver returns 0 instead -ETIMEDOUT in this case?

So it is also a bugfix ... ?

> -err:
> -	return ret;
> +	return -ETIMEDOUT;
>   }
>   
>   static int i2c_arbitrator_probe(struct udevice *dev)
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
