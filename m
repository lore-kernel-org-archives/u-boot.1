Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BFD6ACFB
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 13:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93BE83D8A;
	Thu, 18 Dec 2025 14:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLQxjgBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE7783D8A; Thu, 18 Dec 2025 14:15:56 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D7383D07
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso5414095e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766063753; x=1766668553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqlnGOKGFryjYQ35+NoEdOPUi/0DjCKE46/trxymfmw=;
 b=eLQxjgBicccbP30V1x4OJ5sQwXhFexJYFcFAsfciVr8NkevSaAg1r+Ae4n8h1bB6tv
 toeKqmAtXAmbfhP2RKRxwBDcw07TZAp2h8Gkjj23jH+xzZmfgLFSKUoUtHcFwPCmTrKH
 VsTmAHMefONS8eCiP/bx57scm01S8Ga11sEt7M1bBwYeShCGAzEYaVLzxsm+0awkU+rc
 ZkKnxobUYxWNs+BfFGjwatx56ip0fLGA5YQAiUEzzJju1STFPS7v/8m6u/i7ZAIFvgeu
 HJuijCcj1yHjJtJZYBKasYKqTxax1GTymMe716ItppysAaCqIL0RHhNncWXHPG+m+pdL
 JYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766063753; x=1766668553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqlnGOKGFryjYQ35+NoEdOPUi/0DjCKE46/trxymfmw=;
 b=nZqS5mkStb2PVfr2Lsw4kr4GwqSmdF9HW/15p/MABdalAdF7MdSTOsqANbepU3wh/P
 Cg0U5QW6SzDlexKenC9VUI8Uqh3UG8cAXTe/Lof3HlgEKRACWmr6iKDdP08IVUuNUty0
 A4GkdK/emIQdJGTb/Owvf2E7rlqadctJImrmwhE+bQbkPZ+1RznCkgVRWwGsMIigiQnI
 BkSlKytqkrdXr+vHEH5Q8LHDsLVtRE2MctYmT4EU5LaE2f2Ld6P+aAVOHBdFSN3dho1k
 MQZwNtdJbaT+VNAKDQScbWL14W9Cckb94oQKovRJgXxOeMsqJPMktTDFGsHmpIJkKVUA
 l5dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZL8Ll4TviLOWYDQVWd4Z6fbooAC6xRS7+Xa/BtZYegDB1LhN7/YavCbtqziEMVNDbPE8Om84=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhy7xhZo9WNMzSNNrvApgkEUpvVHv2ZHV9FoDzf5PDH8vPUGSg
 jxOQkE8xhcYy97hqR9CqAf5VK8Qf3M3d7+XUBTEtfuObJgRQX2S4WM0M7xbdK3MVCGw=
X-Gm-Gg: AY/fxX7h6ZDHuAauDKILYt6dkWnWnYRWqNM1Nn5jN41UXw1IOD1mCXb3hO7W6GGBk14
 kwzMELyNQNOcJgSvpqeHdkIydISLRjRIDqONJAdgR6tlZCjggT1jM/DASD4XgSRPC2dMCZe4Y4f
 5rE1wroM+rwDHyS6uuOjgkW4zcNQyQ6cL9Gl+ucMR60h3oeXhEKfe/gnBJDZv3zpm3TMoB9mRFB
 AzwQv42XZm7D8GferEeP9KIzTAeFcrMS0HVD/tKz/kIZX/p6tau/Rd1NqLfjT8r9t5NSlXb6QQO
 HNvqULp8a2DSzUZOHX/YH1X7dH7zRifnK2pbTYjYgIuXYmXd0KOM9jVDlyYyahcfn/7vuZaCB+u
 8wz5EH4XK2IOpHknMYjHD7/uB5Lhzfm1g5TFWlEzYznyqzEuBIYAMIEVAfT3VV20lcJAIk1NaSO
 UqD1RP5vi9fb/emunbzhMQuPmqFXpO76KkEYVsxJ0wkHyKY00C4z5Vukz+X5tiPdlIxg==
X-Google-Smtp-Source: AGHT+IEcTj8PfnK4CuZGSvUHXw24c1T/lUq3BLuNWi6kW1dq/5mGGmc7rbAmCF25EZ08tAKil/Pp0Q==
X-Received: by 2002:a05:600c:1d20:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-47be29a52bfmr31622905e9.3.1766063753453; 
 Thu, 18 Dec 2025 05:15:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:cf83:fadc:3e6e:2b4e?
 ([2a01:e0a:3cb:7bb0:cf83:fadc:3e6e:2b4e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm13437915e9.16.2025.12.18.05.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:15:53 -0800 (PST)
Message-ID: <5ee9a4c5-ba21-428c-af12-6a83017c3ca2@linaro.org>
Date: Thu, 18 Dec 2025 14:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fix incorrect dependency for SPL_NET
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251218-spl_net-deps-v1-1-e943f3899574@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251218-spl_net-deps-v1-1-e943f3899574@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 14:33:52 +0100
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

On 12/18/25 13:05, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> SPL_NET depends on symbols that are only available if the legacy
> networking stable is made available. It is however possible to build

s/stable/stack/

> U-Boot without a networking stack at all, in which case SPL_NET will not
> compile. Fix this oversight by making sure a network stack (and the
> legacy one) is available.
> 
> Fixes: 8cb330355bd5 ("net: introduce alternative implementation as net/lwip/")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  common/spl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 3b7b6cafef8..ba434d5c46e 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1148,7 +1148,7 @@ config SPL_DM_SPI_FLASH
>  
>  config SPL_NET
>  	bool "Support networking"
> -	depends on !NET_LWIP
> +	depends on NET
>  	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
>  	help
>  	  Enable support for network devices (such as Ethernet) in SPL.
> 
> ---
> base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
> change-id: 20251218-spl_net-deps-62072f51243a
> 
> Best regards,

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
