Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17990C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D64806FC;
	Thu, 27 Mar 2025 15:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQaUrKqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E30C81A0C; Thu, 27 Mar 2025 15:44:34 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BE2805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3978ef9a778so23899f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743086672; x=1743691472; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ggWsSb7IIYbShXKyXG0FZrsmuP9j5EuOGVsANOfzvE=;
 b=vQaUrKqE9XlZETMGVogD6vfgaWOnZbejGisN5AZptwbd+/X0weU3RLh0evzxqrnTbl
 /scj2ciy2odt5toU1agKxJBQqK6HrrQGhQjCiZu8Kv78a9WSI6IjHt0y8/fmBAmwl0IZ
 5eVMGQKlVxZTq/vybbE9GGLUBo+YQWO4EzF3kH2E4qRPQfdP6ZCJeVlEcWaKE1jEJO3G
 +6H7UUwi4Zi/9HfC/cnco8Oey7GkJJKzy16jaQIyLhjcjtLxmL3bKGpR6q/uyJ/s7Ctq
 PjCHB1/ovr9NDr6HSuURUTUe1KwGQNAGLg0F5TGMoO21UnJiB9I72wkVzgbKNzu3Bgg+
 CHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743086672; x=1743691472;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ggWsSb7IIYbShXKyXG0FZrsmuP9j5EuOGVsANOfzvE=;
 b=oljfKnGQUSMdXQBueCwPLZjxVZ9RkwDVmI1j0NsDGySlC1lcsBnng1AyN6zvqJ+LWn
 BI+RJcRSXYZnHKHbe5P1Jxpn/HWrqvu3WMuWo6iNW9LBqA122+PV09qrgPh8aNecVBQI
 AHnH/oJMeR8v+7EgrMY2DhUvJ4GwrMvQpkKQFceHzoLeBe1Pvx9Ncu5ZcBCNVmzxHolD
 wNfOQA2dMcsiOyTIKEJQyRV0pdHZtDUIcndAZCnfMaxK84SLExw24MJNt5wQ74UrTY6f
 3C/B0Lla629iksNkmoUTts9MXqVhBURtixHnjQnaxexJxU5BCGQtNH1WfosJoa2kV6yU
 9U2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5E4yP/q0GLThpTLIlSvKhLS265UtLuSJ7cdpNRA55rrJqNrAAo07eBs+EyCwKi4nkUhDuXzU=@lists.denx.de
X-Gm-Message-State: AOJu0YyW5M0mIKu7iLVH/EKkHarBF3hDY/dvfmhRY2ShNDi8twsTYrFt
 GWHD1c/MHXwvMWkq9vPJXACjMNOkY/Eo3jyVsewI1GfMxZW0tgCPWV/izMm97JY=
X-Gm-Gg: ASbGncv2OgAXzeKKgOZ738XMTgXD1W16RSRSTibKpyTIJJ5SyBKwjDKVcfcJRYt1Myr
 hQXj7mI65LkRFxRhy/KZxcNK4tyhdatbuqphPFGSF0nMknax2QmEVPo1/UVFp04qVGf2EqON5qJ
 9y1zWFLh0UEC6WBvG1IvcWYlrLK5vfw9MsjHfM+ntuXxAWUzX228J69idscO9GUC4EgQOP/YWWk
 xsnriVAjFMh6uVyOEwn4y4rl37F0Dv//fsfaqyHG0z2JUfZzvuHookCEQuVY2EQbV181CXO9p8i
 XFKAKDQj99IWfcxmOVY4j0hud2m5KWsv1b0gbIEDm3kUE/Glg030LW29bwIJtByjpcyo/neOkw=
 =
X-Google-Smtp-Source: AGHT+IHtL9pHV+wyuawOWe1uSVqnyZJFMNuAcs+T0IpNmlpAjVZcHB7H9wJlx8vvjRByWCtF9AJSEw==
X-Received: by 2002:a5d:59a2:0:b0:391:2acc:aadf with SMTP id
 ffacd0b85a97d-39ad2ae536emr982714f8f.6.1743086671799; 
 Thu, 27 Mar 2025 07:44:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b565bsm20451303f8f.58.2025.03.27.07.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:44:31 -0700 (PDT)
Message-ID: <0f414199-678b-4441-8721-423f7436b241@linaro.org>
Date: Thu, 27 Mar 2025 15:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] dt-bindings: clock: add ID for eMMC for EN7581
To: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-7-ansuelsmth@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250314185941.27834-7-ansuelsmth@gmail.com>
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

On 14/03/2025 19:59, Christian Marangi wrote:
> Add ID for eMMC for EN7581. This is to control clock selection of eMMC
> between 200MHz and 150MHz.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20250113231030.6735-4-ansuelsmth@gmail.com
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> 
> [ upstream commit: 82108ad3285f58f314ad41398f44017c7dbe44de ]
> ---
>  dts/upstream/include/dt-bindings/clock/en7523-clk.h | 2 ++


I don't think Conor ever acked above change to "dts/upstream/" folder.


Best regards,
Krzysztof
