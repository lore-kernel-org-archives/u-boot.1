Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04916E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 21:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859078952A;
	Thu,  5 Dec 2024 22:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p5zTtca+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AC88955E; Thu,  5 Dec 2024 22:14:54 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 931A5894F9
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 22:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349e1467fbso9901915e9.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433292; x=1734038092; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfRlEP9BWxZ8CSWbn5Gz18aq8rE2bifcU/9CiyIlO1E=;
 b=p5zTtca+vP+BdBgwUNbc3yXms/4lBmmUkKfTQMpY1di6i7TMBtTGf0G366rnXMkDxk
 SgZPkPbw2ZoKMDWuvn/8FdSdV2SBaoE7szAauAXgvVtiILT9+WQNqRlDAsaXYCnv/edi
 rtWHB/73RB8blJKKupxJsXpiBUr5zrVpJ1AudY8PSvAGtzTthTZAzIKT7UxreXICq8tN
 RFcyKXgfmaeuO/s3sTuE/GANAJYBodi8YX2nu52429yADgVSxvMvimMA6jXRw3cWkHHq
 T+i0pfM7nwNQjvCgGXBzBXfKSUyDRdTZaybPQBXDEaonItWGCcKoE2WT4Wj2JDWJiY3Z
 I5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433292; x=1734038092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfRlEP9BWxZ8CSWbn5Gz18aq8rE2bifcU/9CiyIlO1E=;
 b=MvfJ458UJXkKRW8alhQLNXxtRG4VgYvj3MaOZqdNl6lp1peQG0louhW8kEAoeZu5sc
 3I12XXyKdAOsTAZ54N1wvuHhE7mCdFRJcOpKwZZJs2HIqYT3cFAAzKaXaS7cc53St5kv
 IuqAZO0h7GWOKfPNp6XATS0sdq8nhBCrvBGtDIYovmaO88k0w/ssFqenqN85tHzu+FBN
 L2ZzzPBoOPloNseV193E/SEn3ShfF2HEd2xEHT+V8fQdWl40aImMoyJvXzwNE8pj1bqO
 7urSLFIDnyO1hFOUV6FU5vdL+nmeL1ZJlHxDw4NLPfbkCmGy7rEVhccW7pITK/aE7Vpd
 hsUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8wE/2tzCGMShoJH6KW5HWzxWS9a7AVbDWueY5F6o4vAPkmhyx+yptR4VU5Dh6PwTokkfwl40=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6aWynzNy9Mv4qsVDJoBxZ0OM33bBthMvH8cJvB5NqHdnsbGF6
 8bAQYIgDxnR7QRsszP8tRFnAW+Y+GP/bW4DId1hMiGxl0cMln7x38LAjvah3Xtw=
X-Gm-Gg: ASbGnct83D+ORgjQfPHjwIvNQbIMSiIWV25tZzksdatz1LJjOoOYBI7UJTPtEyQw1C/
 gWhWGA8G7b4nfowGzV699bscKjrCSJfNTS9tjV23h/Aqp6bSztagzaYsIvqKKuJxyneJHLx4Y0r
 r13vO2yhorzOfDiex22bTYgFJs2gRw87oQjyTL3E4ScVBjChrPWlWjV1BZKv1F4bYFy37wfScVx
 yQAv/t8OdrnCMwcOrgOOW0du4rZBOzHi3SX+n/fSLymvGwYKvtg32ppjlHFYcNhLiIB5amvglw4
 1m2pOI4z5nZ2GC6/amUURgi1Baap+A==
X-Google-Smtp-Source: AGHT+IHC3JLoQ1rVuWASxw82PIQP/CNBxbyJVhQld2Kzx403YGZu3TgNyyu1blrs+h2UIH3b306HlA==
X-Received: by 2002:a05:600c:1d85:b0:434:9fb5:fddd with SMTP id
 5b1f17b1804b1-434ddecfeb0mr5872025e9.23.1733433292090; 
 Thu, 05 Dec 2024 13:14:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4d66:aea6:b365:82f1?
 ([2a01:e0a:3cb:7bb0:4d66:aea6:b365:82f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da119abbsm37728825e9.43.2024.12.05.13.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:14:51 -0800 (PST)
Message-ID: <74a3c413-4ab1-4c49-8bec-fdec66010ec7@linaro.org>
Date: Thu, 5 Dec 2024 22:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: lwip: do not return CMD_RET_USAGE if no interface
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20241205193254.25807-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241205193254.25807-1-heinrich.schuchardt@canonical.com>
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



On 12/5/24 20:32, Heinrich Schuchardt wrote:
> If the dns command cannot find a network interface, we should return
> CMD_RETFAIURE and not -1 (CMD_RET_USAGE).

CMD_RET_FAILURE

> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/dns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index 4b937feaee1..1de63c9998b 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -56,7 +56,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  
>  	netif = net_lwip_new_netif(udev);
>  	if (!netif)
> -		return -1;
> +		return CMD_RET_FAILURE;
>  
>  	dns_init();
>  

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
