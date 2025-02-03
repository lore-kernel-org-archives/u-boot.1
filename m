Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A97C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6341B80079;
	Mon,  3 Feb 2025 16:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RDYszgkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A2B800D7; Mon,  3 Feb 2025 16:13:14 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961C080077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso53060515e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738595591; x=1739200391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=klu7sDNynNIoUoZjQ4BbR6AzdWhrhAaW+bVo/M0+DoM=;
 b=RDYszgkW50+iolmsbB5xMbMnICcRq9EoaKo97tfhWGkc1pmIXLbxy4E65vEW23ef1N
 Spvin7QEVqXJ8Ist/HPCkZsnpOxKveFGAY5xThiQ+mVbaBtDX0Ahh11RAqIOF8V8XVnC
 ActQRAWpCfRZTtrC19XF9KzYnJgP0sEijx/Z4tKlTNpLirp8Khc7/SdIjFML3vaq3MF6
 4tEqZiwvuJfTGyJz/4XcZeGTdAzRhtOj9EaL9WM9N54li/RCwAn/US8I7kbnOMB80uON
 l7Zw98dc2+7pSRIihLYtxZ9Eyf7rWZIdYSt/XWuOpFT4CHrSQdwtpW1jHHkhg05T9Hds
 xhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595591; x=1739200391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klu7sDNynNIoUoZjQ4BbR6AzdWhrhAaW+bVo/M0+DoM=;
 b=t78QraucX4N78Vj4frt1AjVl9MAgAUOL13y/J18CLEp7dXKgz8y4mvFm20yvXOXw4d
 A3uFHV/9TmFPnPGTuEZU0zC7Jaar1dLgeJtcGo4H6OMGtM+YDSo+5BF70cMsj0FOUGy7
 wMlyvOtw5kroiV5xYzM5NQqHIc2+vDs9NNEulu0lovfvq3rnMYC78iRskMH7Jw+koE2k
 eNAvD20Nxms5Chx1662JbEtTt65On/OxFec1OeNORZu3RrefChhsr6sTdW900pf2fid7
 95V5GZMEwXTvT0wfMVeT65HwTmWAStaW6N2V5v+gRluO4Gem9jcXMc1SImIIuNLX0OQb
 /57w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2knruLXKjmdOCxVSRNClovYFY6EGUhlkGIABqJQpmT56durQJ6HS2k5gTZFe+5YSbPoLNKMY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9Ba0ZABr12HcN+x2sMPrz87C+SXqvKZuMaJeMTv+UiAhR3HQ0
 GS3i6uDaU9R3xIR7mw1z+vXwrIhZWjYUGojPoLL4OBS6S2vdvSIghtfDP9DDUyQ7Xh/hGySU7ir
 Q53pDAN3h
X-Gm-Gg: ASbGncuvXD4mnr+A6a99OU5WAAj19JiubI75LQBL0KEyUhC0SiDzhM1V52lySibiWgb
 pWKNomAhfm5aJJ5mIFf4UMXXcKyrY9ra52OqxU7Q+LJtv6Yx82RkpOig3Sjroe8kuz9jOiVcrOp
 zLfd5zjzahqlpfGvRGFm9OthZzPDNQFZsMQE2rCtiRV6ZdnbenjAuzSmDB1QM353s3qAi7RjRt0
 AE0Qfvm4xzLxvIyL561NpfxW+rTbPJ7EwsIfbXzvEKms0i0xSskJhCsUCjp9M0BZe8btKlzbPN8
 23YPTUH/zY1Nw0pMsO2QBjElYaA8rW+gyecVXXLVZgPeGnvg/w7EYHm5Hn2VXU3c25ctA6Q=
X-Google-Smtp-Source: AGHT+IG4Lt8lBoxY6b01N4F2IuL3HWO1OR1jV2FsDQvelhoyMbYx060XY04RccMpiQq4KuPuQULOJA==
X-Received: by 2002:a05:600c:b89:b0:432:cbe5:4f09 with SMTP id
 5b1f17b1804b1-438dc3bb62fmr185072275e9.4.1738595591057; 
 Mon, 03 Feb 2025 07:13:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:67a1:15b4:9565:fea8?
 ([2a01:e0a:3cb:7bb0:67a1:15b4:9565:fea8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bc0sm13203313f8f.35.2025.02.03.07.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 07:13:10 -0800 (PST)
Message-ID: <dfa29e39-319b-4b70-b117-8ade03c8c19d@linaro.org>
Date: Mon, 3 Feb 2025 16:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
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



On 2/3/25 16:03, Michal Simek wrote:
> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  net/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/Kconfig b/net/Kconfig
> index 24508026200d..6c684624fd6f 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -249,6 +249,7 @@ config WGET
>  	select PROT_TCP if NET
>  	select PROT_TCP_LWIP if NET_LWIP
>  	select PROT_DNS_LWIP if NET_LWIP
> +	select DM_RNG if NET_LWIP
>  	help
>  	  Selecting this will enable wget, an interface to send HTTP requests
>  	  via the network stack.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
