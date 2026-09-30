Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A66CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 21:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78B3940B47;
	Wed, 30 Sep 2026 21:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YTXoVP-pfi5; Wed, 30 Sep 2026 21:09:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84BC240B3E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790802586;
	b=AAiVqsqEfEcesDrZT+QHUbWCRWSzcfPcGMr/cNTDzdiqvsO9rEzS0+z+qBRVY7hJpbmm
	 /XnL0muuyenuqVJ8ho+nnTXEqu8G3C3xaXzuftH0FOmrxrWNGcxYNwMWQN5Z9iJm6yud7
	 UCZFyj2ZDfBdAD1gElaQlkIL4wjXTrzF2KIKgxVWOKzWj0LrHdck1iUVzCJplP/GsNd2F
	 h892w8F90bqvI9mVMML7mPsoEOSP3CWYvnOL1987rXmKjIXFhTP2d9Gqk9eKsD7rkvGUH
	 puFy/QuoqsmPm3NcYX6edyEfF+9i4zyVRPbKHcwDy0GvSFY5ZRAZQ4Ydu+V8iaNyT5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790802586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
	b=r0rzoQgTs0+ZuIyDgGwhhKwtlAmWDGaI6/nCVq+WSm2nL5nFGD+V1RWxvW6UDprrszvM
	 EQ7yLYBXmqIKDplsysnG/UkyhTe36uiYcC9dlXTihPY9aKEw39eOKFP+twWRBntN7b68C
	 DLfCCIj3EeQaIuZ5mAxpmmSrnNJ6BfHpapNbdfgrnu4ij7p2C+fkKTZ8fWX1o3/JU6WZZ
	 zzCEubimOoeprQgDREWP66hX0qVWslDxjPZue6JwdCmYC5NOU8mq2Wpxp/+0UqixVbsas
	 lDwYBCPDe/A3HmezMeOUVYwWuvzwhKd01Jv1eNpVaGxjjBKGFHhhvGUoaQhAHnAvfwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790802586;
	bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=raAnnJYcne5j79wFQrM8MYxn6yPWyjVMZAfS0JnXmlVSGLxZuMyPSvZtiMA683h6j
	 OyhGAz0K2dIj62t3N3bt8qHCNjytZ4cdmml6YBo6Rl3IX2VUCH4tR3Yc71C1M4GbE9
	 V4TBccL2Js7Rihrvra2x4JHgVtcLiWFuezCDERmH4IpZay7ci0qf09IPigWty83Lt2
	 I39WJY4QIbqdNQ8suP4RW2uaD+M0uF78hedrAWHoJvpmw6K7wJMI41WWogB36jTzLj
	 oS6+nV4vSiU/GqF9F9T7Ypors9HxEPDrOqUwbXdkNNyJzVe1s4U8vTNFrNWyviLm6r
	 PvU78pnUCeOjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84BC240B3E;
	Wed, 30 Sep 2026 21:09:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4DFB3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AE38811F8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIcsIFrUshbm for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 21:09:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C857811DA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::28"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790802583;
 b=iEM/C5eIIVewYym0PyxNZzlfJTfuSpjVyMRNP1v0d800e66DKitBiEhNxne33AOyG/bd
 1yu2C9RYPwtSoJIkyXhSfHN0gGKmav2qjiAOq452/6te0N3r7yHmZHKUVl9GSBBTaLHG8
 lhrIzogWY2SAsl+8XRMnF2iI7/DD+tJF/x/1ajeJGmG8/HT7HTjSLcnNKX4N9xefjUejr
 Z/lexw3vgSXTG7N9sQA6AYE6v5ploYJLqcx+nFlBLUgcxRgN4o1de6gJKSO3UB5Ju1Md3
 22EtK++qM1xxBnScwuwa6qDHstvc8iMCwz1n6nCCNYota7acYTubEvOKWhzRRgQPeCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790802583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
 b=KYZpp/uInIn3S4V6C/PcTw6FQYZaaZG5vAsibq4jvkxnq8HwA5LAdxwJEP/CM9XZWnIB
 kzhRJHbaVf79Y7uOWezLPusYM0TgKg0JUCYZ/VZ1vOjfNqlIFM8MoiOMHA1s8xz2076x0
 0sInSgQeOqWe0nUti+nBaVyRjorx8YRYNT+7ONIJn0YbbJutbXBqOfVAWTaE9nswVlOnX
 9cTv2sgULbN+Ozd0tdokt6Piw7uW0VP+VD3YzqxtmTP2f8yaj3lKp+VUzEHJgA0koPABw
 smviKMPu/xyeakqPFnCcqblZVG9XQ5NnM5rduZ/Wvvn+rCF9Q4y3bifEAXSt0JZkA/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=xJ0qAobV; 
 arc=none smtp.remote-ip="2a00:1450:4864:3a::28"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:3a::28; helo=mail-vs2-x28.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=xJ0qAobV
Received: from mail-vs2-x28.google.com (mail-vs2-x28.google.com
 [IPv6:2a00:1450:4864:3a::28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C857811DA
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:09:42 +0000 (UTC)
Received: by mail-vs2-x28.google.com with SMTP id
 ada2fe7eead31-7ba99a2e56dso652719137.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790802581; x=1791407381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
 b=xJ0qAobVK/pHS6zC0nAjTJx39sGNyxm46VJneLkeTqJX1eENRn9C3Ks0t9tDdMm9Rb
 D2ZVFgisAXMLmEeezVUj17rpl/eb23VN2P7BpukPpR4ruV0Luf9dPAXBVtTwouc59kzB
 ahAkHbkTX4Sg5vthJePYui3dU2u+GI6nNc8pM6mHOxZQ2VlE2QCaJzQlzydHD436FyPo
 1ShakGzHIwHQUkpJrYODMyGc52+NcZCeEI5zFjgH1v90p9trleDyR6CYwq6n4FS4ibBX
 gnNyAHUkafThotEG6qxpuVgzNzC1ii7DVaBtVKga335CzMJ4qT46+XAAp1IvCXSs/Y94
 Y+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790802581; x=1791407381;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUfb7a5dhCuiY/V0z51GpxPSQqaqKwGcByKC7FcOHkM=;
 b=UAC5M8YhykjulKRpqmmEEG8W1RNYd4KR+YM2lsUr7xQaIIhq8cECK+YSAvS1/3u8Ha
 aWhuTi5B8JgHlHncJUXRtFTqLlTHkQf96noDTAwJ7A5pf5nEosw92c+SdL23vebg0WSD
 dQkhPdOeSK3FnvFm1o47V0SSuDtaXKv+17HrvZCaBfzhVUXAJDO0yZvC30ILf7R4U1zj
 JrWAAhKw2npSwAAI4G+wxX3vMEHS2zy010XKKvFHybpdGAJR0SmQzrrp1TVtWBRrilT9
 t44gieOZYchWVNr+ziPquQ/TuTMUDYt3WI3lujrOi+eS/zUVksZPfXjSaykcLTYjXUFp
 ZfaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt0ipXS8RI1KkNvqpsmFvxMU5R2UWi4pgNaIpx/4BLjD32nYfdbw4P18DghlH8/VyB2mteWbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLT8p6KjjmFO8RCGomJaAvZDlvBIqw6RAow2/B1GeZdF93jRSLr
 Xf9/zOkhFp/tslJfhiZ4YGoj7RpOSXPdMTf8myMVfRYT9q28D+sLDlI9g4nPDOfQdUwM0HJi4VN
 lV08ZfumjkXQRTYq/AbIIOzr+dd/9PyE7lkn1s2jORk2nV9tAGgBY/BfW0MllKSY=
X-Gm-Gg: AYBFou16qhMX9mUHNtodEX9h4/XIQc/9qpPb+S4Gh3hFTXmUlm42kYlkw8LZ/afgDDi
 efVvjd6YJ/0Nr1N9R0EmmpiVq8WuoMEpWC+ddqnrbrgOATsv0Gj/0nK8tBdxsirik7bpocG38RN
 FpqI28EX+Inwjg/6Owaw3Vuuqlw2JJW5XsaRo+2XM5ZDBqH16cxIPccR8oGDAATDYgITDeWbCyk
 jMtov8TN9sptM9lMsh5nxhel5mAP6/yRwXtU2F1j3dFPb308h1vs+P7swHtLWxEJlkkyInmamZ6
 iBnR8+FcUPQqLJHvdPhLNpHpg15FpMVJDjufPZP2tAjGazOtYQf3Wt3fRMH5cIxTOrDamEn2QWd
 99s4Fs+L2w4xXauK472hMd3431Sa28g7zswdOYgLFBClPyZyqZIVHkDga/TPE2323jDFbYC+48/
 DYjnrxnuLM9dBrWMvRXDjQhC9zyyn4NX2yxuN+pFEjkOrxFz73uzX852eSqeX+s+LiIftTC0C60
 vA=
X-Received: by 2002:a05:6102:f91:b0:7af:81dd:a9d3 with SMTP id
 ada2fe7eead31-7be73795bd3mr602925137.29.1790802580744; 
 Wed, 30 Sep 2026 14:09:40 -0700 (PDT)
Received: from [10.200.233.210] ([66.193.28.125])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7bfa6cba2fcsm685436137.8.2026.09.30.14.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 14:09:40 -0700 (PDT)
Message-ID: <4b0f1f15-3275-4d4e-85f7-b02d8bfdd88b@brivo.com>
Date: Wed, 30 Sep 2026 17:09:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: designware: Fix MDIO bus getting bound multiple times
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>
References: <20260929180055.3439132-1-sanderson@brivo.com>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <20260929180055.3439132-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 9/29/26 2:00 PM, Sean Anderson wrote:
> designware_eth_probe may be called multiple times for a given device.
> such as if the first probe (or post_probe) fails for whatever reason.
> When this happens, subsequent probes still try to bind the MDIO bus,
> creating several duplicate copies of the bus (all possibly sharing the
> same of_node). This can cause an infinite loop in dm_mdio_probe_devices
> if we have been probed at least once already:
> 
> dm_mdio_probe_devices()
>   device_probe(dwmac.mac0)
>    device_probe(dwmac)
>     designware_eth_probe()
>      device_bind_driver_to_node(dwmac.mac1)
>      return -EFOO
>   device_probe(dwmac.mac1)
>    ...
> 
> Prevent this by binding the MDIO bus in designware_eth_bind instead of
> designware_eth_probe.
> 
> Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/net/designware.c    | 35 ++++++++++++++++++-----------------
>   drivers/net/designware.h    |  1 +
>   drivers/net/dwmac_meson8b.c |  3 +++
>   drivers/net/dwmac_s700.c    |  3 +++
>   drivers/net/dwmac_socfpga.c |  3 +++
>   drivers/net/dwmac_thead.c   |  3 +++
>   drivers/net/gmac_rockchip.c |  3 +++
>   7 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 6ed9c6d538a..256e474a565 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -209,15 +209,14 @@ static int dw_mdio_init(const char *name, void *priv)
>   }
>   
>   #if IS_ENABLED(CONFIG_DM_MDIO)
> -static int dw_dm_mdio_init(const char *name, void *priv)
> +int dw_dm_mdio_bind(struct udevice *dev)
>   {
> -	struct udevice *dev = priv;
> +	struct udevice *mdiodev;
>   	ofnode node;
>   	int ret;
>   
>   	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>   		const char *subnode_name = ofnode_get_name(node);
> -		struct udevice *mdiodev;
>   
>   		if (strcmp(subnode_name, "mdio"))
>   			continue;
> @@ -231,8 +230,10 @@ static int dw_dm_mdio_init(const char *name, void *priv)
>   	}
>   
>   	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
> -
> -	return dw_mdio_init(name, priv);
> +	ret = device_bind_driver(dev, "eth_designware_mdio", dev->name, &mdiodev);
> +	if (ret)
> +		debug("%s: not able to create mdio bus\n", __func__);
> +	return ret;
>   }
>   #endif
>   
> @@ -855,6 +856,9 @@ static int designware_eth_bind(struct udevice *dev)
>   		}
>   	}
>   
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	return dw_dm_mdio_bind(dev);
> +#endif
>   	return 0;
>   }
>   
> @@ -961,19 +965,16 @@ int designware_eth_probe(struct udevice *dev)
>   		}
>   	} else
>   #endif
> -	{

This brace shouldn't be deleted, since it's the else clause of the above ifdef

> -#if IS_ENABLED(CONFIG_DM_MDIO)
> -		ret = dw_dm_mdio_init(dev->name, dev);
> -#else
> -		ret = dw_mdio_init(dev->name, dev);
> -#endif
> -		if (ret) {
> -			err = ret;
> -			goto mdio_err;
> -		}
> -		priv->bus = miiphy_get_dev_by_name(dev->name);
> -		priv->dev = dev;
> +
> +	priv->dev = dev;
> +#if !IS_ENABLED(CONFIG_DM_MDIO)
> +	ret = dw_mdio_init(dev->name, dev);
> +	if (ret) {
> +		err = ret;
> +		goto mdio_err;

This is the only user of this label so there's a warning when DM_MDIO is enabled.

I will fix these issues in v2.

--Sean

>   	}
> +	priv->bus = miiphy_get_dev_by_name(dev->name);
> +#endif
>   
>   	ret = dw_phy_init(priv, dev);
>   	debug("%s, ret=%d\n", __func__, ret);
> diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> index cccf9d54e02..3618300f4c5 100644
> --- a/drivers/net/designware.h
> +++ b/drivers/net/designware.h
> @@ -249,6 +249,7 @@ struct dw_eth_dev {
>   	struct mii_dev *bus;
>   };
>   
> +int dw_dm_mdio_bind(struct udevice *dev);
>   int designware_eth_of_to_plat(struct udevice *dev);
>   int designware_eth_probe(struct udevice *dev);
>   extern const struct eth_ops designware_eth_ops;
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index fde4aabbace..cb9de81a819 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -157,6 +157,9 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_meson8b_ids,
>   	.of_to_plat = dwmac_meson8b_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_meson8b_probe,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index 76daab961c0..d95f2111a5b 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -56,6 +56,9 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.id     = UCLASS_ETH,
>   	.of_match = dwmac_s700_ids,
>   	.of_to_plat = dwmac_s700_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe  = dwmac_s700_probe,
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index a55f3e29f9f..64bb2dbfbe3 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -143,6 +143,9 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_socfpga_ids,
>   	.of_to_plat = dwmac_socfpga_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_socfpga_probe,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/dwmac_thead.c b/drivers/net/dwmac_thead.c
> index 138d71a6202..5843bed49cb 100644
> --- a/drivers/net/dwmac_thead.c
> +++ b/drivers/net/dwmac_thead.c
> @@ -280,6 +280,9 @@ U_BOOT_DRIVER(dwmac_thead) = {
>   	.id		= UCLASS_ETH,
>   	.of_match	= dwmac_thead_match,
>   	.of_to_plat	= dwmac_thead_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe		= dwmac_thead_probe,
>   	.ops		= &dwmac_thead_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 2b6080dd9ee..1d21cb2606d 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -790,6 +790,9 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.id	= UCLASS_ETH,
>   	.of_match = rockchip_gmac_ids,
>   	.of_to_plat = gmac_rockchip_of_to_plat,
> +#if IS_ENABLED(CONFIG_DM_MDIO)
> +	.bind		= dw_dm_mdio_bind,
> +#endif
>   	.probe	= gmac_rockchip_probe,
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
> ---
> base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
> branch: dw_mdio_bind
> 

