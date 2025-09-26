Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553DECAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 07:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6798206E;
	Fri, 26 Sep 2025 09:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UWMHd+Lg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4E282998; Fri, 26 Sep 2025 09:25:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D7F8144A
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45ed646b656so12856795e9.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758871528; x=1759476328; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jiVSwWIBqxYg7V+/OUMwa8PqGuGqlBNVolkeuwDC5Do=;
 b=UWMHd+Lg6EjIj/DtzttK0tkDAIdw9tZ2p6fnfecI5jBSNCURV05Wg7C870yTn0U6xg
 qdvaLtdm8FYDGOepiSiQKuc+XYjkTh454QTarIFvEe4n6bzEFhZVaz9EQBxb99+ZCTbn
 gsVo0/PmOSHYqRVwz4ddrVE3XkZRaJI2OjOYU3eo6gi3ktPFQmSXuFmhIkyhqs/HFJOI
 F/IeU1P9QRd+qnxMbXzyK0nFgcP/6vkC12voLe5m8Ixq7jwfOBq2lNU7rGNmdz0YGyXv
 h1oNpmsBTpR8kON0K9a6jzDrtIDB1Uzyn0Tw8pVLiqf6tHCOdmC9wlWc+wS0KnZgCJr4
 bO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758871528; x=1759476328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiVSwWIBqxYg7V+/OUMwa8PqGuGqlBNVolkeuwDC5Do=;
 b=sh7jw8LjIwacXmNUeuJgd2J9BG8W5Hqq7gBObNqrc5wAVqqywJf68DYCcpub3PBes7
 F5kA0vNwkqi7+CmUQDo9yUwWNQyq6fTWWJWAiSBctal20OxqO/01qwBRScLuY2CRRb2f
 lA1OLfVn8y/ic7UeyF/lfny4/4utBU35gqHBZJuapuO5bPNbfyUJ3/4ExLcDWGndvTUy
 jgxZoiWWd0ZcFI8eZMdVFSsLJo1mGy5iHJVrve4ivckR+c1IKhRziHrksyL0YZOdzoVb
 IpbMl6X+vIDrsSzwfRcscE58GAFAmpus8wEo3ciJuHLWBTlBjEmorEsIYXevji1lld88
 vl5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXvRJxOYZrrIfaUu5QJn/rvfW7OnjzSv/jreVhnOms65Me5fziCXD/zDDg5QFYi8BkdLc6OVA=@lists.denx.de
X-Gm-Message-State: AOJu0YzQycZvbsJsaNVV/ANzb6IJMJAyfChgeLJbMDN7CYCXOCJkwIdE
 g5A7BRfYzrzIPrAF7r4xPX63kwWLidBeJf4xXS0JwR631Sqw9UKzc+OcZ46iso+7ueH3kZGqpVL
 3EX4Bbw0=
X-Gm-Gg: ASbGnct1uAcYAnQ26/vBF2sIiFEsMrCAioJ6g3LZ1dGogbfzIXruJYMX92wnOVNBIVI
 noNz+Kyyo+1AoGM67AmyiW6hsH1ros4iKYKnls+hoDKJKUhxjCM1NIIa1+ejGCTLkEpJl5vOU+k
 rKAtpiSdqLBeHWyZUgBXeLZ4W2jYb9GZrqXsQQgxyf6zhrXb6zGdtsse+1e30dGDi13gPMQXHcr
 no4nAOuMv9T7YxQRubaaAuFJiUCHnSJyR92gCG+HcSRTgnp+UJpA5mvqOpNvVRiIWYuBSDvL0TH
 f85CXBO0p5Ine9OHry87HX63FLPRX57yy/d2m2upp7cwavwG/DD0cyPk782cnjXJvfNhrbRe9ji
 773f0ResjqI8lvp6KBN+Bzc7KD42kloxI2Q2reUkuO9QKmrRe+bx8RsLCbbAffevIWNvR2dMmtC
 3EOhP+I4oGig==
X-Google-Smtp-Source: AGHT+IFUsOp+7eQDfI86lhOUkeBN9bFgCio14TpcxS13W3ExgDeJtfWbLmdqw32izv8eQulEDqIWJQ==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46e329e3f76mr70060575e9.10.1758871528116; 
 Fri, 26 Sep 2025 00:25:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c93:82d7:a602:f31d?
 ([2a01:e0a:3cb:7bb0:c93:82d7:a602:f31d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be363esm63219535e9.15.2025.09.26.00.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:25:27 -0700 (PDT)
Message-ID: <2e1c9d7d-b10f-490f-ad0b-cd567eae1912@linaro.org>
Date: Fri, 26 Sep 2025 09:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: Add SYS_FAULT_MII_ADDR to Kconfig
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250925204414.3561033-1-trini@konsulko.com>
 <20250925204414.3561033-2-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250925204414.3561033-2-trini@konsulko.com>
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



On 9/25/25 22:44, Tom Rini wrote:
> The support found under SYS_FAULT_ECHO_LINK_DOWN requires that the
> SYS_FAULT_MII_ADDR symbol also be set. This wasn't previously found in
> Kconfig, so add it now.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Changes in v2:
> - Add missing dependency on LED_STATUS_RED_ENABLE as well.
> ---
>  README      | 3 ---
>  net/Kconfig | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/README b/README
> index 07cfded6be53..27cde241bef4 100644
> --- a/README
> +++ b/README
> @@ -1238,9 +1238,6 @@ Note: once the monitor has been relocated, then it will complain if
>  the default environment is used; a new CRC is computed as soon as you
>  use the "saveenv" command to store a valid environment.
>  
> -- CONFIG_SYS_FAULT_MII_ADDR:
> -		MII address of the PHY to check for the Ethernet link state.
> -
>  - CONFIG_DISPLAY_BOARDINFO
>  		Display information about the board that U-Boot is running on
>  		when U-Boot starts up. The board function checkboard() is called
> diff --git a/net/Kconfig b/net/Kconfig
> index 40ec6bbce761..5768fab6f8fb 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -60,6 +60,10 @@ config SYS_FAULT_ECHO_LINK_DOWN
>  	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
>  	  be configured.
>  
> +config SYS_FAULT_MII_ADDR
> +	hex "MII address of the PHY to check for the Ethernet link state"
> +	depends on SYS_FAULT_ECHO_LINK_DOWN && LED_STATUS_RED_ENABLE
> +
>  config TFTP_PORT
>  	bool "Set TFTP UDP source/destination ports via the environment"
>  	help

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
