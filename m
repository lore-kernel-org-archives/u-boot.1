Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE79C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC7287C13;
	Fri, 15 Dec 2023 17:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xc0JAkhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A80187C13; Fri, 15 Dec 2023 17:30:48 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E5987C0D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-58dd3528497so621566eaf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702657843; x=1703262643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBbttW7ykI3R12+XzafV+W6+Uv9ZNHlYu3uGGAj7C2I=;
 b=Xc0JAkhQb7S6sAeN7DmqR6gF2ijxtJDq+W/OoLcIWMjuB31fDgowfQAe3PVgihCo+e
 7YHVSa15Rp85kwNGysp2XWTgDP9TptFBb6W/AKHVX4GJv7uGZZEZtTR90o/rlb+kp/n+
 lioePMOgKuEv7j0+T60mxr1bi5RgdDqexxU3C87u0dWRBtojK3wpzzHO7yWYPE72y5hD
 M/gonAwlPzA8RMkYDEj2BYt+BFrQCOZgBighm8mYaKFyJ4soszMLaGYuZ+gbOE3OXmP8
 HbA4DobEwvb1WVOUSo2txGT3AEntCAmew3ALkLfwInSaaJpU+LlAe6Q8SRDZSNwMY6EO
 VH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702657843; x=1703262643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBbttW7ykI3R12+XzafV+W6+Uv9ZNHlYu3uGGAj7C2I=;
 b=sMrKf8DNBodBTY7aa9sYwUROl4WGNBGl6V1HNaMoTsKKFafLaoyc1TRwt/RPy4H1Zx
 MTBr9c9T4wkVm4QuQn50WhpE2u3yVYk+xcbLAj9qA9leIO/IQWpH478GvQB+n7Ven+5B
 zFlWEby308Ihg2dti0yJJ45cwQR722FS2WisQdS34rk+0gejlZ94xTJ7i0lug9SzXUFS
 fuDH+eLxeRMWYZP2lD8HgLQ/+RICRcGJRrnJkw5YAe3rRCQFHyOw865iAN6uWo4Inpmd
 2LEE1lHTUhuI/FElMVHxkYzUSX8L2ehWaQ1diOD5Ewkz5Z3aUvVebXbVSBsxSN3jnzQG
 W9Nw==
X-Gm-Message-State: AOJu0YxpfNa1bF00bScT86mkXaxsBjyp3ZERk7QsiHdNUXYJ/SXz0RtL
 mSqRZ/ys3uAXIV68oaA/5kU=
X-Google-Smtp-Source: AGHT+IGfnghI0TkU9XnXxTYFOQdWeohPrH3I7/sml60JApcUAmsBiCxnxzR15bfNjfpde2SwuxB3Ug==
X-Received: by 2002:a05:6358:cc03:b0:16c:70c:7f63 with SMTP id
 gx3-20020a056358cc0300b0016c070c7f63mr10084944rwb.27.1702657843149; 
 Fri, 15 Dec 2023 08:30:43 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c16-20020a0ceb50000000b0067efe4f3cd1sm2152748qvq.75.2023.12.15.08.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 08:30:42 -0800 (PST)
Message-ID: <f1618f28-e1fb-d4cd-3690-ec325818452c@gmail.com>
Date: Fri, 15 Dec 2023 11:30:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] clk: fix clk_get_rate() always return ulong
Content-Language: en-US
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
References: <87o7erv9p4.fsf@baylibre.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <87o7erv9p4.fsf@baylibre.com>
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


On 12/15/23 09:09, Julien Masson wrote:
> When we call clk_get_rate(), we expect to get clock rate value as
> ulong.
> In that case we should not use log_ret() macro since it use internally
> an int.
> Otherwise we may return an invalid/truncated clock rate value.

Fixes: 5c5992cb90c ("clk: Add debugging for return values")

+CC Simon

> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
> Changes in v2:
> - remove local var ret (fix warning)
> - Link to v1: https://lore.kernel.org/all/871qcj5frz.fsf@baylibre.com
> ---
>   drivers/clk/clk-uclass.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3b5e3f9c86..3cbcb2d033 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -478,7 +478,6 @@ void clk_free(struct clk *clk)
>   ulong clk_get_rate(struct clk *clk)
>   {
>   	const struct clk_ops *ops;
> -	ulong ret;
>   
>   	debug("%s(clk=%p)\n", __func__, clk);
>   	if (!clk_valid(clk))
> @@ -488,11 +487,7 @@ ulong clk_get_rate(struct clk *clk)
>   	if (!ops->get_rate)
>   		return -ENOSYS;
>   
> -	ret = ops->get_rate(clk);
> -	if (ret)
> -		return log_ret(ret);
> -
> -	return 0;
> +	return ops->get_rate(clk);
>   }
>   
>   struct clk *clk_get_parent(struct clk *clk)

Anyway, I don't particularly care about logging the error here.

Reviewed-by: Sean Anderson <seanga2@gmail.com>
