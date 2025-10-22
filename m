Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB6ACCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936008323A;
	Wed, 22 Oct 2025 15:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="daBHwxa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B678832BC; Wed, 22 Oct 2025 15:42:20 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B8182B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-428564f8d16so362670f8f.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761140537; x=1761745337; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APa4AF9MX0+2Op68+AvYpLkeWO3hCiVFj4s2GgNrvQw=;
 b=daBHwxa5zxkSTYPbi5pIudkfhdX/asOPWgHED67SCmYjfI0FhAXUAsS074QPBcJERu
 0gyJ80QO7UPDt9+/7iKqA+a662qvAOj6m6iZS8X7E+VqnbKvI8MYqS4mNgAq4EibAlCP
 WDTm8wrYGlD/2qCtU+FhOuwlMRLy2G8nfwlkdO+vcD6fQU0558bPi/VHHzhKe1d1gDk0
 BuFIno4l1EzkXvu9e7vIJUtBVE5Nd9lnraY1j9Gnic6/KgHPoT9Oc8lgqOvrHih5oZFK
 mX/sTQC++jzEXRb/3cx2IwSgMndS3sDTcbc6ICRj1rpnYrlS0OxOaqnaJFoBxcRmyDex
 VhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761140537; x=1761745337;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APa4AF9MX0+2Op68+AvYpLkeWO3hCiVFj4s2GgNrvQw=;
 b=qrfjzojWrmPBtXkg2XxSgj/e0O9m1gjamjXl0Zbua1JLeZ+E7UKv5iA8D7n+zdRLWp
 UB5h86A2v5CqB8LV8ugQ/cFLxf2H0/GKmcAo8BxTpulQVCxmECdm6fXPzmeXBEurlIXY
 n/FXZBzTxH8WqP07VVrHNCqDU5EYkyaPnesAV4mOWvODHxlfgThK8bRDDKDS7rP9GfZE
 PlDmHVkLrm6893B15DWLWPCgJSBwriSHHcgeISCUATurIHdmeCEEY3dypZh8Il/mR2Jz
 6Vq8+f4RNxNwH3jE197N/bLrcY3tQ85vao1sfZgvd2S20/3ODcthYow+BF6HolrXOF8y
 3SfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZvIoOPVP61TrALzQJN3wGKGInNAxMr9vM6eB17PWVAIqy+KP/xdO+ee+mR6O55lbvKDgSj/w=@lists.denx.de
X-Gm-Message-State: AOJu0YzGfYlDLsNfejREtWCElyONpYOlnPVYGZXMJ/XqNXCuKuc08jiv
 eNqdm5P6ERT3J7Cb+cbyBEhW8rwZTo1UojRlCmxfN9em//diU/76d/jTm1hPtNmzPAQ=
X-Gm-Gg: ASbGncufAZmJHfwwVvGZ7nfanJ7FcVx0E6fl4dachjeGe/pIO7bZQOthI/8V27IYwfO
 OxhQPtc4mdJ5vgNOyLD0P3vYOu55B9f3rDI0c2HPBiE7kvdwS2QSxVKQa6zPPbbwwll3/yUkne+
 7qeaPrIGycv3qXHcsWc1Hlru2Ea84Hg0RV3GYPpojicUSKLyrvY6xIFC/a+TwSPzWLQ6Ww+j/3Z
 eNYrAJDBPZCrqQfWx1+PSJgg9e9FmukCgxB1M3ws3o97SFMVGC5cUfaT6MfHEJib2jUszI0hLLj
 HcS8YH1E2QDxKk9pjuJ3wRAasG1YAH0VENrSGGysVLcpfZ5xEzg8YTq+D9k6+8DR5+l5vaG/h4A
 +bpzbsNWZaCi0EM9qYRWAPzyT6jxn+RwKkI9kwqG9tAoz+JraUig9B8KrfV5VxsY8040RYRB5f9
 4lWil+PxNteQrSxSlW7doqWe49U9EAPfiD6/GC2LBZpf0zrAb/Wg==
X-Google-Smtp-Source: AGHT+IEyMcbjiL7ohKS13UTpITQMvFOa+gKCeymNyRdImizfl4ichvX9CtIu9jXGrj4D/s97K51wYg==
X-Received: by 2002:a5d:64c8:0:b0:3dc:1473:17fb with SMTP id
 ffacd0b85a97d-42856a821fcmr1055547f8f.20.1761140537110; 
 Wed, 22 Oct 2025 06:42:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed50:db7:290:9079?
 ([2a01:e0a:3cb:7bb0:ed50:db7:290:9079])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3affsm25010978f8f.12.2025.10.22.06.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 06:42:16 -0700 (PDT)
Message-ID: <2aca47d4-b0a1-4b8d-9613-95d96b4e7e83@linaro.org>
Date: Wed, 22 Oct 2025 15:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] net: airoha: bind MDIO controller on Ethernet load
To: Christian Marangi <ansuelsmth@gmail.com>
References: <20250920161013.31799-1-ansuelsmth@gmail.com>
 <20250920161013.31799-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
In-Reply-To: <20250920161013.31799-6-ansuelsmth@gmail.com>
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

Hi Christian,

On 9/20/25 18:09, Christian Marangi wrote:
> Bind MDIO controller on Ethernet Controller load. The Airoha AN7581 SoC
> have an integrated Switch based on MT7531 (or more saying MT7988).
> 
> Attach it to the switch node to support scanning for MDIO devices on the
> BUS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/Kconfig      |  1 +
>  drivers/net/airoha_eth.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index cee4a3fc9bd..ce7c7e6297e 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -126,6 +126,7 @@ config AIROHA_ETH
>  	depends on ARCH_AIROHA
>  	select PHYLIB
>  	select DM_RESET
> +	select MDIO_MT7531
>  	help
>  	  This Driver support Airoha Ethernet QDMA Driver
>  	  Say Y to enable support for the Airoha Ethernet QDMA.
> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
> index 6588eb3a806..6be6ec2845b 100644
> --- a/drivers/net/airoha_eth.c
> +++ b/drivers/net/airoha_eth.c
> @@ -971,6 +971,31 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int airoha_eth_bind(struct udevice *dev)
> +{
> +	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);

data is unused and causes a build warning which is an error in CI.

> +	struct udevice *mdio_dev;
> +	ofnode switch_node;
> +	int ret = 0;
> +
> +	if (!CONFIG_IS_ENABLED(MDIO_MT7531))
> +		return 0;
> +
> +	switch_node = ofnode_by_compatible(ofnode_null(),
> +					   "airoha,en7581-switch");
> +	if (!ofnode_valid(switch_node)) {
> +		debug("Warning: missing switch node\n");
> +		return 0;
> +	}
> +
> +	ret = device_bind_driver_to_node(dev, "mt7531-mdio", "mdio",
> +					 switch_node, &mdio_dev);

This needs #include <dm/lists.h> AFAICT

> +	if (ret)
> +		debug("Warning: failed to bind mdio controller\n");
> +
> +	return 0;
> +}
> +
>  static const struct udevice_id airoha_eth_ids[] = {
>  	{ .compatible = "airoha,en7581-eth" },
>  	{ }
> @@ -990,6 +1015,7 @@ U_BOOT_DRIVER(airoha_eth) = {
>  	.id = UCLASS_ETH,
>  	.of_match = airoha_eth_ids,
>  	.probe = airoha_eth_probe,
> +	.bind = airoha_eth_bind,
>  	.ops = &airoha_eth_ops,
>  	.priv_auto = sizeof(struct airoha_eth),
>  	.plat_auto = sizeof(struct eth_pdata),

I have picked up the four other patches in this series [1]. Please fix
and resend only that one.

[1] https://source.denx.de/u-boot/custodians/u-boot-net/-/commits/net-20251022

Thanks,
-- 
Jerome
