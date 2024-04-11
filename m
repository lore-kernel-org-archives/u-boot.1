Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35119CD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 02:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8FD87F6E;
	Thu, 11 Apr 2024 04:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFZJBqfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF510874AC; Thu, 11 Apr 2024 04:53:10 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7319587F6E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 04:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-434925427c6so19530231cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712803986; x=1713408786; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fvJ965EQf6oHtkMOeWhmeB8CjTWyBqhjei9mHRQdEPk=;
 b=fFZJBqfZJxih1nusjxBK1gN0Y5kEFseFln4G2Q2oivjksRmKxlmxd0WZdzkonEj2YQ
 Z+LLWAicjBSvdT1YC+jumeQ0JItD3KV2tLMTRamyH8OGYo+Nyfj7s+7cFJUEx0b/K5OU
 jffr+yPNM1uZy3hJB0l/igkkNHpiO18dTnJPvnTlXB2iRKt3unts7wD7R4Z0zNx909eS
 DHR7cQgEY7SE5K0vSHIpKuGEMzT+C3+lFf+OLfSc6CGWIspV3JooAueH1OBWOZHfP5Rw
 2QBCvhRm1L6jGfQCEYblJLtI65uKofs6X5L8EUMUf5gqeVJPkOMTmyNxxDXuoFKoU/xy
 2abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712803986; x=1713408786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fvJ965EQf6oHtkMOeWhmeB8CjTWyBqhjei9mHRQdEPk=;
 b=UY24i4O2aiKAiOIDnJcow1l7KY0wgtNHCF9o/yCIouBgGzjhTBpFTH9pD3qEm0KbUC
 SmVCDTz1oAaz4n0syydOIlmtSzG4T0yopvPk1EUEpFVEgxJNyaGRsC28bJDAiAQmp42z
 bcTV7ThCoDMdz0Kkw3FhrCXKtHq6sSF3fH96T3GZyl5/bKBmfGfnK1mv/6tE0FXG8tLm
 Cq3eAc8SEeYRemOtTRPB1Vzf7eWBOMWQAkuEJuJy23F1sfRjQVGjza08QsgjUOKsc20n
 09xenByRkG9z/7U3ekPgnT6I+dtaa6rJI1/MonDh6qdDDU0zuc0g/VT+TnS6AL2J7NyF
 cGXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9EcvJUp8r+IAukxzz7XQJn5jZLy5StYbYT/OVm0HK7mOMy3OC3vHMN5/F/PXGLIU3lacSRolTXVZMEErQ6y9Pkuo+rQ==
X-Gm-Message-State: AOJu0Yzu3UNO6skFbTRPDaNDgx8KnTBiRXa6RBndxas5hYxcATkM5AkG
 Y9RyQWcBarYYojjxNaXNC8gvKSoAdCEAzttXluMCqIAIfBNFmkoL
X-Google-Smtp-Source: AGHT+IHH+DY1UUliupFJdoZu+f8BOnXjctUyDslEzPMQ0iXaFSf3HNdGwHZFCZfbh22AX5sLeZCaWQ==
X-Received: by 2002:a05:622a:610:b0:435:cd14:3372 with SMTP id
 z16-20020a05622a061000b00435cd143372mr3637118qta.37.1712803986227; 
 Wed, 10 Apr 2024 19:53:06 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 kq1-20020ac86181000000b00434c31fa60csm328936qtb.92.2024.04.10.19.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 19:53:05 -0700 (PDT)
Message-ID: <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
Date: Wed, 10 Apr 2024 22:53:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>,
 u-boot@lists.denx.de
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240308000432.32369-1-semen.protsenko@linaro.org>
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

On 3/7/24 19:04, Sam Protsenko wrote:
> Sometimes clocks provided to a consumer might not have .set_rate
> operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
> set. In that case it's usually possible to find a parent up the tree
> which is capable of setting the rate (div, pll, etc). Implement a simple
> lookup procedure for such cases, to traverse the clock tree until
> .set_rate capable parent is found, and use that parent to actually
> change the rate. The search will stop once the first .set_rate capable
> clock is found, which is usually enough to handle most cases.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   drivers/clk/clk-uclass.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index ed6e60bc4841..755f05f34669 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -571,8 +571,20 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
>   		return 0;
>   	ops = clk_dev_ops(clk->dev);
>   
> -	if (!ops->set_rate)
> -		return -ENOSYS;
> +	/* Try to find parents which can set rate */
> +	while (!ops->set_rate) {
> +		struct clk *parent;
> +
> +		if (!(clk->flags & CLK_SET_RATE_PARENT))
> +			return -ENOSYS;
> +
> +		parent = clk_get_parent(clk);
> +		if (IS_ERR_OR_NULL(parent) || !clk_valid(parent))
> +			return -ENODEV;
> +
> +		clk = parent;
> +		ops = clk_dev_ops(clk->dev);
> +	}
>   
>   	/* get private clock struct used for cache */
>   	clk_get_priv(clk, &clkp);

Can you give an example of where this is needed?

--Sean
