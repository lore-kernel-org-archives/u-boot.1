Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D1ACFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 09:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A6F83BF1;
	Mon, 24 Nov 2025 10:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OqbspzGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFB083C7B; Mon, 24 Nov 2025 10:08:04 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5143883BCF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 10:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso16770395e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763975278; x=1764580078; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lZr4hpC+YWESSDyoJD58cgwqxGNjh1Ol7xM1wIqQ8B8=;
 b=OqbspzGtdkgRiZmw5cqI2REESzAw5AoDpktNmiOhw93CURrAi8ArxYxYIoewQLZ5ni
 roIUT3od5HVTGtNjngev2PspZ/9MtGKraxv/DC9Q6Zxp6q+CyYGo+5o16DdxDVfW4afT
 bz1OvVt70foJ0qfxwX0dxiK6HXFoZ9dyxWR9fyrBZXpzSWn1fjel9mNhtOx7hO9Y5SSP
 Rhdr3nnw5onD1B/FvssJN518tZUUd7VHdjso1+0SOFwQCbDHaoMcutP7VCGR1/lWJu3D
 P9shpZSm1MEMm8zHuCaziwNidzXsZ+yGbrvGSVvgmBjnolWlSf0be0l5CzYrxyJzqXhi
 +yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763975278; x=1764580078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZr4hpC+YWESSDyoJD58cgwqxGNjh1Ol7xM1wIqQ8B8=;
 b=N6R4OAO/WoZh46OvAh5QsAqDzscFA9dTwzN8jALJh4N1AXaeqRL9P+aOYOI98CYHAK
 HDjZYDKhppPPvm3r7Ez7oGtQXeBjfPbtUfqL7LJ9uid/aFBcrXxKWpZ1cc70Yop/iVVt
 wR+tgOJ6r6Wr/2WWqFAKzIY9KVLNIx2+3HdudytD7S36wwSfB13qRrUaOCZ9WeRCV657
 veC70e9gYby9YaJDpJMVJ3/Gqo6tgIELbEmEJDpdPS++fzZWmk+kIQ8t2up51e1Tqmij
 IEfpGd0lSTlFRw1NesOx+Jr3VeD1q8Lkg1iLPVArwFD4Gj/xp+JonpeWb13Q+ldq9wvy
 b3rg==
X-Gm-Message-State: AOJu0YwbxMaDrpFfVfHTTmOJrzPASj+3KrwQ7C1pIgL31hgUQmg8i4n4
 qqCZMmD8SsQq+Texi4unibK6sG10zD6Pg7XDwjz4JrLjoFGWuhOyA1ownFXzxZMKn8s=
X-Gm-Gg: ASbGncvZkrJUtCRTXpfPQvxMdSFTqU3Fd/n4edRobD0+vH2yqNhY4eJLBFAnPn+tDMn
 kal82/GbAfc+yHlP/LKAh8o9cHhZSlMfDnyVRQEGnvdCOJb4wAooZAV4L6sJCxnZeG+XOE4feki
 32ZZsDV5XayQW7VU1Ob7pAk/cnwOatnAYZ/M1KZFZR1kI2zImTwlDWvTEFk6svHSo8jaFRiKlFl
 EpN+WBT3bXKSrz86KkWQ1AYXNItTE9L2TIQ4d9dWG6P1J6goiT97h1ua1lNA9FHMZh0keeTex2V
 SWRmdQ1JrMyBRiPnmNV7GrMbI8gu3dr4fQbTSQyc/Yy5QArfvr8PNxpKmI5h38BDYzWSI0cgbKW
 h5/fyjeY9+dX5Y9yDCvcdbfWdhSKiqzeGkX2YYXGdV7aCx8MzY4bBc5hAuGBiSYxPWIdHdANXPl
 8mCocaRLzc8PM+VaawRotjssFGO9EpYFcHQaT73PmQQPSw6NVSTJHuw+M9/PqjA/aZ4w==
X-Google-Smtp-Source: AGHT+IFz1pbDG4+JVw7dCzVK6R0c+3Xx5XQrH2/o3OM7DWmcWewX4bA5MowSFhvfxVI7sahV5v6VNw==
X-Received: by 2002:a05:600c:154c:b0:477:7b16:5f88 with SMTP id
 5b1f17b1804b1-477c0165a5cmr100273985e9.6.1763975277489; 
 Mon, 24 Nov 2025 01:07:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:fed:2c01:ce61:d495:e4ff:1fcc?
 ([2a0a:ef40:fed:2c01:ce61:d495:e4ff:1fcc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3af0ecsm184511855e9.9.2025.11.24.01.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 01:07:56 -0800 (PST)
Message-ID: <dd7a4093-afd0-4557-bbd4-f1a7debc5e0e@linaro.org>
Date: Mon, 24 Nov 2025 09:07:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: Prevent SIGSEGV on debug
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <20251121-clk_uclass_fix-v2-1-74f4ea10e194@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251121-clk_uclass_fix-v2-1-74f4ea10e194@linaro.org>
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

Sorry but I seem to have already sent this patch on its own. I will drop 
it if the series needs a V2.

Andrew

On 21/11/2025 17:34, Andrew Goodbody wrote:
> If LOG_DEBUG is defined and a NULL clk is passed to clk_enable or
> clk_disable then an attempt is made to dereference NULL in the debug
> statement. Guard against this.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/clk-uclass.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3dbe1ce9441ca513d41be90520ff175c96b4253a..1f55dbe385b76d0d6cfbf19bc9f4f1abe619baf2 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -660,7 +660,7 @@ int clk_enable(struct clk *clk)
>   	struct clk *clkp = NULL;
>   	int ret;
>   
> -	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
> +	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
>   	if (!clk_valid(clk))
>   		return 0;
>   	ops = clk_dev_ops(clk->dev);
> @@ -721,7 +721,7 @@ int clk_disable(struct clk *clk)
>   	struct clk *clkp = NULL;
>   	int ret;
>   
> -	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
> +	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
>   	if (!clk_valid(clk))
>   		return 0;
>   	ops = clk_dev_ops(clk->dev);
> 

