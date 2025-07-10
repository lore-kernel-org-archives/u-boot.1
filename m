Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D2C83F22
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 15:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9812583653;
	Thu, 10 Jul 2025 17:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I3IQd8js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16BDC836BE; Thu, 10 Jul 2025 17:31:50 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323EB83423
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 17:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so2189435a12.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752161507; x=1752766307; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USpUivX9h9i0XqvaI+eZuFiCuNf1Aa54BzvDejGEqIk=;
 b=I3IQd8jsBCAHgAzFdjCFQ94wKwkjXdpHz05g7dI+MQ3Ec7ym8o/XLWTQmu0CjBRCix
 d3hV06KDb3sQV2nK726SBgQ7QIwo7UhtX4PwvZKuLVCR2KbnRE1RuqDws6xtilPFGpw7
 6qzqaRBv/TdsQw0MX7K0obviAsq2klUSFpjCAfZ33uLqbFU8t3rdxZzXdygQoeREqWCJ
 uHiq2WnrKMnrauhQrRbZlQj8gkiDPRX4X8KwOaHhj8abJtnElH6qQYDx7S7HWhF1u46d
 13jDzDBTMkXu8BZZs2j6c5hVJCmq7AACsgx9kpT2iZXwYSjHI2M75BkRETDvBQsp8KY1
 bvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752161507; x=1752766307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USpUivX9h9i0XqvaI+eZuFiCuNf1Aa54BzvDejGEqIk=;
 b=kWq1mCMWJ12g6kbhOcyNig7wEfTHw06iBUc5+nBbTGEI1ozno2E3zubrjwqHcCPS93
 gq31HrqC7nF6MUWD9fxn/qENXKEcUlBlbxofCa5ra7tdlG0IEculTu01rb7DikJ0L/d8
 s+hrzfzsICRILaqYvPVvaUgQaCZHiyUHhOYxSCzC8//wz5SZVqbU9vFyIkoQ+n8jyEH5
 fcuyhGIhVMJOiWqiOuBxqniGuZYtSBOk67wU0veZNFb0+RANp8P+3FRrzZSReA0MKmHK
 vEifCwKdufaD1Wyp7qxbUzK1zIVZgnZgOT/LL6R/o4QrM6tY7r3QR57lEpmRFaTcb6QK
 2ZUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoJfyx7If2NjO/L9n5+nBCNy36qSwH+fzwrTQYYdkxXOIVg4IpJSf9JdWAXaluxRgyXEGKrJI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpuVPvMCE1SBPnQus8SE6r2yn68QfF6k9mO5swfIdSiDCKj6WV
 lxhhwMrp2PItJ6D1M3hbvLqOyZl0/F/wneZ088On98YPzXIZ0M2Ocju+ZYe3o71PF8zHaxc+uaV
 zwzOd8EQ=
X-Gm-Gg: ASbGncvmu542siTNGtWujLaJ7h/Ck0k9a6B1cN/nWI2dKpaRiEh9tFUj94Z35CAq1Hl
 QQKF56YGX2a5siz2Tg8p85TKqw3VKBCSaLxhJgF8wDWx6onM1j8bMhK7uHb6Hzfjy/2bbCwwtfQ
 9cs34L133cVpU3LGW6c1HGjwvEN/g4U1c0pnKVXHz3tjGuTwW4Ug2fdFwNJvXyzX54SsfxcB3yp
 aFVsJPS7HXEunsxDhF63qAtC7lL49sdeO9rcqKhXC8yQGKidf05XTASzlaTFVKbskXwVBfIWGoI
 Bk4mFMJ/TzetRkAbO+iQWNGKxz71ZNc3pO8ctOu9DFxd1fzjTZfXSEEzMAcKenEJksQAUMnttVA
 Jh3xSXpsVfCEsjC5QaAEcWggqXIgu762MGQJLBcU=
X-Google-Smtp-Source: AGHT+IFJC/9tGxq98d6zf/nI+RnClQ79cwvk7zYFKJUOz4j6GufAF7l1DYR9ubS4Np0hznOy138i+w==
X-Received: by 2002:a17:907:7ea1:b0:ad9:f54f:70a2 with SMTP id
 a640c23a62f3a-ae6e111c034mr440576666b.22.1752161507240; 
 Thu, 10 Jul 2025 08:31:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:157f:442:48ff:45a9?
 ([2a01:e0a:3cb:7bb0:157f:442:48ff:45a9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8316b60sm147045866b.184.2025.07.10.08.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:31:47 -0700 (PDT)
Message-ID: <d7491680-35ff-46f0-80c5-f3957fc0f92f@linaro.org>
Date: Thu, 10 Jul 2025 17:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: simplify net_lwip_eth_start
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250710151556.3834583-1-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250710151556.3834583-1-tharvey@gateworks.com>
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



On 7/10/25 17:15, Tim Harvey wrote:
> For NET_LWIP eth_is_on_demand_init() is always 1 so remove the check and
> simplify the code.
> 
> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/net-lwip.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index d53faa39ba11..660ceb10cbe2 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -184,16 +184,12 @@ int net_lwip_eth_start(void)
>  	int ret;
>  
>  	net_init();
> -	if (eth_is_on_demand_init()) {
> +	eth_halt();
> +	eth_set_current();
> +	ret = eth_init();
> +	if (ret < 0) {
>  		eth_halt();
> -		eth_set_current();
> -		ret = eth_init();
> -		if (ret < 0) {
> -			eth_halt();
> -			return ret;
> -		}
> -	} else {
> -		eth_init_state_only();
> +		return ret;
>  	}
>  
>  	return 0;

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
