Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D390C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B70783046;
	Mon,  7 Jul 2025 12:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qD7QVgyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68AEA8304D; Mon,  7 Jul 2025 12:39:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F0F83043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso24495515e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751884744; x=1752489544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f2ToWHFtMDICz9fIIaiS2QkyechXM/8MNlsEnVrChGQ=;
 b=qD7QVgydLGBm9w1GCtpqVuMS8mMrdRUDcB5fTca6wGIIBJpdYjykcBy6z1gD/t8plE
 guNXS+sNS9qLb5A86cuiKtA7W33GObhA/pGN7YhLpIhArXxtzaZ7pAvNzslQNFp/VjxF
 ZSkPU3zo5uu4J8hAvmQvC4/37vhMGO5+ydXx+AoXClLe087qi9WIB9nps61l1tj9x/s9
 ndZOTgT5UIvpBJ5lG25DubgTubMdE9vuKX9CvcFUZuj2xukXmnrQm+B/CBgtAqqOSuUV
 2aUIZoj7BiYTqwt/6OGiqQVQLtTVQRM/EXW/2SiDbDyTtEool99kkcHhVhP5n9iULULu
 69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751884744; x=1752489544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2ToWHFtMDICz9fIIaiS2QkyechXM/8MNlsEnVrChGQ=;
 b=KP+QddoIuv7puHJkaMG01ltdSJkkeGFIMajS/jvsBhdoXUbPxx9R2AE0Pr72g06fW4
 vnec79nVWCqomy8h7LcXok3rlrJW+JQyn3TERVranzGKfFH4jY53RmpxrjO+LB9Svvkz
 Di1HeSZj7WPKE7ubfVwKEj0nyPV03OYV1N1j3F3fwVFE4FdGyIISoisCaP/PdxCRoz3Z
 lo3IY2JZq/eGw2x0hdpJ8hVUt8+yhXy4fDBpztFLgdSdavNQzMkr4wriLgGthNKt9pe8
 vFgB8llZyBkdh336PYfgA8BszUmXDbnEhXO13altcMzzozXs+RkpTrmQ/+Ej0AeDvjNm
 OHcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXDSyxGdUUGF9qX69kMlobn/ekZxVTU5Xa/t3to8guCpnubzEISnEz23LgDvDIM8irHKNzdrw=@lists.denx.de
X-Gm-Message-State: AOJu0YwMCEx2GXMA/Sy5OmV4lnL+X+e7F/hRtiUfWW/tpvP5YfIHSSx5
 c8nUiIsipCUibmF9RCMKLDOX3Aa4jg6PEPRwGHZP+mj3hMhOiKsf2EqujzKycOrIeWg=
X-Gm-Gg: ASbGncuNjcpQux0bdQI3Oymc/QGC5yQv6Qkf/YDMzRCri1cL5tU73w3iSJPnaJcDonk
 lg265kZYzOhAyeJ/eMbsrfOOnDia44vfNnuYOjXGlcZfOYqPQgk4sFrEsKtOKmhm/jutKuNtZvi
 jVahPwaRzIdr0v7KovRPok3i6MBOjJn+h565pW/Ig6GwIDaDzlKSqmCLrHYTVcCEXkucybmf1Fx
 OSWHHhVagC/zIsIgwg3+aoUErou0FiWDyFx32x8nya7IrMOgjfLQBAvAFYkcvJggQFoCMTJaoIo
 jri1qXvUFXTdZBCcH4ifWtfkIpbuSx8R70ZrGWORsGIH6a3IHY7HNzEUPocTPrQ4T6G3mSd2DZj
 Hv1XD/LkZ/cIlWY+HxzZ7pCez9Bh5SWiVa7SxYtBOc4fsZydspg==
X-Google-Smtp-Source: AGHT+IEKqjDwTFQC3Z7ucVYS5ttET+2svOg+J3g7f//cBUnTHVB6aCvyU9eXKfON0fsdGJV6/jC1lQ==
X-Received: by 2002:a05:6000:2405:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b497029481mr8221523f8f.31.1751884744350; 
 Mon, 07 Jul 2025 03:39:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3?
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a2dcsm9785858f8f.71.2025.07.07.03.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 03:39:03 -0700 (PDT)
Message-ID: <a4947912-6ff5-4404-ad21-78adc1a3af35@linaro.org>
Date: Mon, 7 Jul 2025 11:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: Fix usb_control_msg() error path
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: marex@denx.de, trini@konsulko.com
References: <20250707102430.18125-1-pro@denx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250707102430.18125-1-pro@denx.de>
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

On 07/07/2025 11:24, Philip Oberfichtner wrote:
> As pointed out in [1], there is a logic error in the -ETIMEDOUT return
> path.
> 
> The while() condition evaluates false, when timeout is 0. Postfix
> decrement makes it -1. Adapt the if statement accordingly.
> 
> Fixes: 2fc8638403c (usb: Assimilate usb_get_descriptor() to linux)
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> 
> [1] https://lore.kernel.org/u-boot/caa9932c-c5dd-46d6-a5ae-120238300a73@linaro.org/
> ---
>   common/usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/usb.c b/common/usb.c
> index 7a8435296c6..266339e4897 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -258,7 +258,7 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>   		mdelay(1);
>   	}
>   
> -	if (timeout == 0)
> +	if (timeout == -1)
>   		return -ETIMEDOUT;
>   
>   	if (dev->status)

Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>
