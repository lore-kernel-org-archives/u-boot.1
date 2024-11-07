Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD697D43349
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1AE8924B;
	Thu,  7 Nov 2024 12:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yfvcuS/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787008924D; Thu,  7 Nov 2024 12:21:20 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADF689235
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so6776375e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978478; x=1731583278; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTjpPcOB/wtUn1fDtjVbZage/jCxDFmha03MtTsBpAI=;
 b=yfvcuS/odin5oWw9Qk6irbtCGc7z2VJIzFKWeByZfXkK9ojgFlcJkA5GHZ5XLwgDcT
 U0dDg4ePxWGcAK4XKoPFGb/ODnrvYJYWj/ymJmJmJ4lMxsmFDwmn/Qn3TcZ6hS5v+sMp
 dZ+I8dtrpaOhqV1Y63gka1MO7qyrtHi0PIWspev8MEbraC43jkK0UPCsX9RSW7FhyLFy
 eUJf2SJlD5SwV/iml1EjWKbIVNfAvTTq7HlfwaQ67qSmIw2cKi3XqkbUiQcsv8spFwnK
 sOnq2op7vnIAdr6WCHkWksK4Od9WMrHb9VY++lLW3kxBGXVdOiVd1VWINT77RNn4bUUh
 B/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978478; x=1731583278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTjpPcOB/wtUn1fDtjVbZage/jCxDFmha03MtTsBpAI=;
 b=S4k+tL6ha3uELFgsGoaHdrjPrXpY1gU3VZpfFTQZkZ8eonTEuNojwQ9WRRgn09Sehx
 qiNHSF/O0vQNax0HSf6+UqVQAMAdRpIA/jwTkkPI2XtbDq1D3FInA8f0KC7LUrZW1enN
 Nw3v5dwSK3ER3tQQAEl79m92qCZ6jwkWB/pmMNCtfBDFj2R7f39G22pEnNhPjwNXpHUQ
 7wM+h6YG0iDiEoIZ2SgPBtlJ6C6mu+k0IUEEYCydamN1oVd2Xd6xonK6JGnkQFuo9qqe
 DCb6/GTggctO5Bwcr3WWXFkY0fBMrwDxnreBkpt4ZC+ZjqL/n0Rz2CQcKbxHVsX5FOVt
 MRVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUDiPI5xHZJjG1ohJsgSgY4bp+Euo86Fmiv2Yn4vAWLnNwlZsSsAeq593JpQpQPBBXo/wZqs=@lists.denx.de
X-Gm-Message-State: AOJu0YzmQw5X2xF47pdXDeZJZTQ9TuelsvWXbSToXyrYguHlfewRy1tS
 f2uMZXC/xKlXcP0+s5Mv5Q0TOGAVJPlXSKmKKvP8kKaedVyPhbycIiKIQaWRgZU=
X-Google-Smtp-Source: AGHT+IE6+djvnRd+6KmZ3yR+trVr+gJHRhcBEJnSWrJgZ/XL1SabCEdKB+8YOUZ/UxwS6knlN4cPHg==
X-Received: by 2002:a5d:47a1:0:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-381ef6a48b9mr622015f8f.12.1730978477954; 
 Thu, 07 Nov 2024 03:21:17 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda0517csm1441268f8f.96.2024.11.07.03.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:21:17 -0800 (PST)
Message-ID: <b519fb69-308e-4608-9e61-491679d8f94f@linaro.org>
Date: Thu, 7 Nov 2024 11:21:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net: wget: Add a global struct wget_http_info
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de
References: <20241106130337.211101-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241106130337.211101-1-adrianox@gmail.com>
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

On 11/6/24 13:03, Adriano Cordova wrote:
> Declare and define a global struct wget_http_info. The default
> values are so that wget works as it used to, but they can be
> changed by an application before issuing an http request using
> wget, and restored afterwards. This struct is common to legacy
> wget and lwip wget.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/net-common.h |  2 ++
>  net/net-common.c     | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index 38ba95cf60..3039dfdce7 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -533,4 +533,6 @@ struct wget_http_info {
>  	char *headers;
>  };
>  
> +extern struct wget_http_info wget_info;
> +
>  #endif /* __NET_COMMON_H__ */
> diff --git a/net/net-common.c b/net/net-common.c
> index a7f767d5e9..e969d508cc 100644
> --- a/net/net-common.c
> +++ b/net/net-common.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <net-common.h>
>  
>  void copy_filename(char *dst, const char *src, int size)
>  {
> @@ -11,3 +12,12 @@ void copy_filename(char *dst, const char *src, int size)
>  		*dst++ = *src++;
>  	*dst = '\0';
>  }
> +
> +struct wget_http_info wget_info = {
> +	.method = WGET_HTTP_METHOD_GET,
> +	.file_size = 0,
> +	.buffer_size = 0,
> +	.set_bootdev = true,
> +	.check_buffer_size = false,
> +	.headers = NULL,
> +};

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
