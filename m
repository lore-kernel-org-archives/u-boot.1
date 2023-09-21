Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53474E71084
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11AE867D2;
	Thu, 21 Sep 2023 16:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XtPZqezA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03A4868D1; Thu, 21 Sep 2023 16:49:59 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB5686380
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 174316607318;
 Thu, 21 Sep 2023 15:49:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695307796;
 bh=8Ku3wPVrl0foSVu3PHRNVKvjJSbkl8wRKElz8EMkgew=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XtPZqezAK8hwUGk3kwSAQNMUrVh4t1V8konFRkKUXhi/HayCIvlftH9CsDEPXXY/7
 /Va6LMbOdxo37wXA0hv36YVm3+HqIAG9//H3AdBe8RY/rkNivtq0IraTllYx3PSSLB
 q8PxVESBLnj9Sg3HN4Y0ujJfGAxaaix1llmXTtFj+mwVTQ2j3NMV+yzSoMYLT70Phw
 8Ok8j8rbiOeAfxEJRIiG42ayiJhvZspcj6Z7nS/ji3vcXtO3sASUF4/H8BbJoJtWcu
 gY6On62LfOC+PU75VL+BbkBvkXKI7JBFheW4O/IUYuoB1x0pyis1CB9P5mcxY0gOjx
 9IzxBMiyG1tfw==
Message-ID: <eb85bc3e-d7cf-efc9-c5d6-a42573a24a27@collabora.com>
Date: Thu, 21 Sep 2023 17:49:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: fix count parameter type for clk_release_all
Content-Language: en-US
To: lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de
References: <20230619104752.278500-1-eugen.hristev@collabora.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230619104752.278500-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/19/23 13:47, Eugen Hristev wrote:
> The second parameter for clk_release_all is used as an unsigned
> (which makes sense) but the function prototype declares it as an int.
> This causes warnings/error like such below:
> 
> include/clk.h:422:48: error: conversion to ‘int’ from ‘unsigned int’ may change the sign of the result [-Werror=sign-conversion]
>    422 |         return clk_release_all(bulk->clks, bulk->count);
> 
> To fix this, changed the type of the count to `unsigned int`
> 
> Fixes: 82a8a669b4f7 ("clk: add clk_release_all()")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>   drivers/clk/clk-uclass.c | 7 ++++---
>   include/clk.h            | 4 ++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a2615..eada3a3a5b62 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -416,12 +416,13 @@ int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
>   	return clk_get_by_index_nodev(node, index, clk);
>   }
>   
> -int clk_release_all(struct clk *clk, int count)
> +int clk_release_all(struct clk *clk, unsigned int count)
>   {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>   
>   	for (i = 0; i < count; i++) {
> -		debug("%s(clk[%d]=%p)\n", __func__, i, &clk[i]);
> +		debug("%s(clk[%u]=%p)\n", __func__, i, &clk[i]);
>   
>   		/* check if clock has been previously requested */
>   		if (!clk[i].dev)
> diff --git a/include/clk.h b/include/clk.h
> index d91285235f79..a342297007b6 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -243,7 +243,7 @@ static inline struct clk *devm_clk_get_optional(struct udevice *dev,
>    *
>    * Return: zero on success, or -ve error code.
>    */
> -int clk_release_all(struct clk *clk, int count);
> +int clk_release_all(struct clk *clk, unsigned int count);
>   
>   /**
>    * devm_clk_put	- "free" a managed clock source
> @@ -307,7 +307,7 @@ clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
>   	return -ENOSYS;
>   }
>   
> -static inline int clk_release_all(struct clk *clk, int count)
> +static inline int clk_release_all(struct clk *clk, unsigned int count)
>   {
>   	return -ENOSYS;
>   }


Hi,

gentle ping.

Thanks,
Eugen
