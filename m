Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB07C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4D9836A6;
	Thu, 24 Jul 2025 10:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I9E2Igg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12A6836AB; Thu, 24 Jul 2025 10:59:07 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1821983666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso490769f8f.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347545; x=1753952345; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aBaE+sJeaajFwwXq+0BM8reBSlInSHl10setttO+sBw=;
 b=I9E2Igg8lxqcSIoj/WgEzgrd/kQhfMlPQ10dCyTeVArCjpWo2kjY+/Am3IavIXyXoC
 dE6brhf52QRMFZ6xhS7g3lzTI27bxDvkJT0aBSMAOlN4VvseS6DevnJmjode2LHA4d0u
 LDYhS6pEf4vYy2j0MYBCkMKSg4s31+x6YI0q0aMxte2cGFk+NtQmG4bgUUdJCP/BLw9n
 AUrIxeAu2Aa4blZr57kOXTEkeDELcCcTmkdXGRFJ+lGNM+uCCU2zGNRBjOC6V58f2POF
 3hyxvrjNU52EE1jWzuj4Ts49q0BFYurnEA7D9vTN9cJJ0eGYpu2QOjKoAWexUfXAIEd7
 uIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347545; x=1753952345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aBaE+sJeaajFwwXq+0BM8reBSlInSHl10setttO+sBw=;
 b=Sd3wee3L3WvEFDAgS7NqBS1wEdUrgNf0iIr4wYFIyAEni6mUNUODjx/GO27tMnI3nx
 vmniH29j574RH/9pXm6BP15v4E8hi88Lyx5o4/r20Krhm2EPG6qFy0lany4o/5RG+rnw
 l5T4sXPX51Z1Ai2z8PLkGCEn2CpdZHFGCsUt5HzzgkAf/kJfB1EnwAvN9heCmHuUiPpy
 4f0o7O8nh6n/VawNH1SC11fd/1nuUb1j23OPSjsvYLj+9i1FeGnmbvkd7aAmOJ6F7dfy
 x7nQwDbbnXQmbz8gG732NlxLrzLV0p/H+avlSqgeRo6TG+C4nTUE36ImsO03WdqyQV04
 l7xg==
X-Gm-Message-State: AOJu0Yy8Q20ogTV5yedj0fVmRSst2n7zqe6EaJKno/WqbrweLTFvBVcl
 p3usYbKxt1jSi9kH2HImS54X1wDgAmF8IFmxSVzXLQao7UQIHFCdxGdX1MPQMe4rxvg=
X-Gm-Gg: ASbGncvYj+BdZPznaIyibAGfrW/p0XYWoFmLWwxwa52jg99ePX/sN/chYyw8NQBZBp5
 xU+SOx2b/xqUcu7DQjdVUddEb+hFZ74P/FcsSgzU8caJsSMNWt/zOS4hMu9BzI2XjWA3L1o9jx/
 osXI9k+iot704CrAxK8miBOMGm9J2DV71NAakc9eJuAXy7ftJKYOd4P9+fTn9TiafTk9RNP8A8w
 3BETWeUb/ExmvTeRUDe0Z3NomHWGbCmkd0uqW/yWSoy+12NrtUnRYxOpPYcoHOk5fDZv5LhShSz
 OeaJGoN+rmoze/rwMAVGNQ624Q6vs0UaI7mZgRgV1Ju3UEyRGMS+L31TW0++nA2iCPzHxVDEH36
 XrlIaJbAx0br4AB5kUwdu30VyXJOlrVvQ1D0MSW3gW9K0TuyNWINF+B48t3AwSBSv1wAg/HjfL0
 WUpw==
X-Google-Smtp-Source: AGHT+IH4p7n2JkY+lU45eVmu61wenh/PMak7pWy96vPEQh1YeiqxnlF2AiXXK6UgTox4Huj8z7rVeA==
X-Received: by 2002:a05:6000:18ab:b0:3a5:1f2:68f3 with SMTP id
 ffacd0b85a97d-3b768f1f428mr4718053f8f.46.1753347545360; 
 Thu, 24 Jul 2025 01:59:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c599sm11638915e9.11.2025.07.24.01.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:59:04 -0700 (PDT)
Message-ID: <84393d64-b2c6-4287-8fe3-10c6b23dd8d4@linaro.org>
Date: Thu, 24 Jul 2025 09:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
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

ping?

On 26/06/2025 15:12, Andrew Goodbody wrote:
> The local variable size is not assigned to before it is used
> for the first time. Correct this.
> 
> This issue was found by Smatch.
> 
> Fixes: 86d462c05d57 (cmd: add a fetch utility)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   cmd/ufetch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 46bd16824e6..bc5db08eee1 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>   	const char *model, *compatible;
>   	char *ipaddr;
>   	int n_cmds, n_cpus = 0, compatlen;
> -	size_t size;
> +	size_t size = 0;
>   	ofnode np;
>   	bool skip_ascii = false;
>   
> 
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250626-ufetch_fix-54b741710142
> 
> Best regards,

