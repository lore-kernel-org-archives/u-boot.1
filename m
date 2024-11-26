Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79713D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FC388D13;
	Tue, 26 Nov 2024 16:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VJtXbo/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055898899C; Tue, 26 Nov 2024 16:35:10 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18D488D3C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38245e072e8so5585859f8f.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732635307; x=1733240107; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3zTwFHdgTAE+HujhFjykTYkPC67smr7GasohzWHArwI=;
 b=VJtXbo/GkgDzAbgnM47zYqoyMVve4OkosvwlLN6QxeaYZaotpSqgLVKL4U9L5hV9DG
 PTH+D7Aj+8CRUCOx88tnQo4UxJF/KIdqw0N92od5+Tmt8FOxZmnuc7kuNUrW2HFSLozw
 drNoPyaoQCe21+aLTvHMyCkcZ9Y+A+qbxGCmgrdVbIRPTv+tgezfapbDHTpQMv2xCuRQ
 M+3uDZvSlSgkJHLt6HOCzUDvKebw5hnV6Qt6/8z8V0JakIBt1gx09qma5OXl4aIAXEy4
 HzpKuponjSbMmOWfw3qbGur1dcBlvsngrpBK/nLdwWq8EKX1lprDhNCJMWYyL3vN16nd
 uORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635307; x=1733240107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3zTwFHdgTAE+HujhFjykTYkPC67smr7GasohzWHArwI=;
 b=QpipRRBsigDVAmz3QboLDKtIsW0UXWz2EaqI3V9im6HgsO0omdnJLl/Ib7OtCRgzpM
 9iZn0fhS3D61z9A1kupbERkn/0oem1zOjrP3bN1lxTKceH0sNyFFhgmc1VA20zShe0EM
 kh6Q88HpmleNsu32oS8OXQ86RskRuC0IL2D9qE0BFWY/RB6d9S0BSP0YM9qxrsRNTcDB
 5XIfLJON1h3RulSlcHte8e1CMDY1XBGReVj6+83Rl02EoiKy+hfLU1KDkjK8giD5eWf2
 4NZxCsfEVQvuiUCejMzNi5ljCSnCYh2BMXaVUIL9ld+xjQvK0XcD+wAZRiIK0CkDShbq
 YFug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA/EJZXZvguW6TK7BrnP55lUyRJidfBJZJyoxHxzRh8xbRbda4+x5w58HMV+eHz1h/AjmIoq8=@lists.denx.de
X-Gm-Message-State: AOJu0YyfxMYCyLbphKYnnlGUcSD4wXX6i49plZPPFc6A/3g8f/q4CCri
 iYO8jO70aaJjXZsNyFtQ024gpmb6Vyu7afbQ+lKd0eWcEZWy/I+HY66CXVn5IJw=
X-Gm-Gg: ASbGncudhQAK+PeOZ70SBl3JPIn7wiOl+dDrX8uXt5Sjn97e0CRqXIHhbmrC7nFNb/J
 q7yPlXfmjuLeyw64jpYUwkdG38ZaF1xFySMvDaFP9XmnPyXR8wV1V52gcAf5Cts8TpQfQNERtk0
 utDNWeHCy3lVz84r2aVUrcgjg8aOB1wl+hQbjyGDwDniZYukVkiwm2DQk1RzLqZQHOQAS80yqBz
 mguk83mgrKVOgysDXK9swJxDNjm64y5ohpNQ3o2CBCe9u2cCEd44GqIKu60u10=
X-Google-Smtp-Source: AGHT+IF+vuEZDmvJaBu3gQ2DnR0HuC3+GvYHo025Zu/3xOcHwSfxSvMAbPQ5d3wKZlocY5J82sAeFg==
X-Received: by 2002:a05:6000:1faa:b0:382:511a:8f0c with SMTP id
 ffacd0b85a97d-38260bea7ddmr18786561f8f.56.1732635307113; 
 Tue, 26 Nov 2024 07:35:07 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3b4asm13873389f8f.84.2024.11.26.07.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:35:06 -0800 (PST)
Message-ID: <612dfbc7-5b1b-460a-a12d-d7cfafdbb091@linaro.org>
Date: Tue, 26 Nov 2024 16:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: zero terminate string with headers in
 wget_fill_info()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20241125171645.126487-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241125171645.126487-1-heinrich.schuchardt@canonical.com>
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



On 11/25/24 18:16, Heinrich Schuchardt wrote:
> Commit 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy
> wget code") introduced function wget_fill_info() which retrieves the
> headers from the HTTP server response. As we want to parse the string in
> later patches we need to ensure that it is NUL terminated.
> 
> We must further check that wget_info->headers in not NULL.
> Otherwise a crash occurs.
> 
> Fixes: 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy wget code")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/wget.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 3bc2522cde5..b290ca1843e 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -208,8 +208,13 @@ static void wget_fill_info(const uchar *pkt, int hlen)
>  	const char *second_space;
>  	char *pos, *end;
>  
> -	if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
> -		strncpy(wget_info->headers, pkt, hlen);
> +	if (wget_info->headers) {
> +		if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE - 1)

No need to check wget_info->headers twice. Why -1? I can't find where
wget_info->headers is allocated in the original series btw.

> +			strncpy(wget_info->headers, pkt, hlen);
> +		else
> +			hlen = 0;
> +		wget_info->headers[hlen] = 0;
> +	}
>  
>  	//Get status code
>  	first_space = strchr(pkt, ' ');

Thanks,
-- 
Jerome
