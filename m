Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9930C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A79288271;
	Mon, 17 Jun 2024 10:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tI5SkrxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F303A88271; Mon, 17 Jun 2024 10:05:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA0087CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so504016066b.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718611508; x=1719216308; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6DV9DZF7/+AXIVyPPC7lVW1ieNSMfb1FTcMw5C0//iI=;
 b=tI5SkrxFYG+jfX6JyCZZFRAJsR6lE+Vb+AQDRqPkA0HLbnJPblp89R0mi7O1Dt2Ysw
 az19AVnQofXlFqs3yToe801iD99+IIuVVABr1Bd42FLhWKe1Nj9qRks5Ka5g8Jib8hWH
 o7+f3dseT1Dgaj9FQwRjGsNIabZdKnAcZNmLlgrP2Dl1jRSiFq0Sh00Ha5A48cmZzzAW
 qkuZRFHpJeg2rKNHOup5/mBRpAYySim5nvXPORyP23aTx9LdogRC0+9kQArO5PjqFtTZ
 iv9Dga3vxRhy+fQ+qWjgaPmvox/TkoRH3NO5XH5iu2itTHgnMXXub5nRXYtL5W+neEKa
 q0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718611508; x=1719216308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6DV9DZF7/+AXIVyPPC7lVW1ieNSMfb1FTcMw5C0//iI=;
 b=D6iavE6x16k32PpjHiUud+WSSnhTv/LEIJjQYP93rv2XMEDsSljg9NZBzy8u9xDWtk
 v7eUrNZEY+WAyaZhycaj/vGsf8114SMqCEuxioaZqkcN2341RJMYXbc7BlEHdc9RSZvu
 UaRRrWw21KSi2jupHUZYs9uu9eLqGENRa4KIxdWxwwT41IGJP0mkptFP8od2i0Xeb+AQ
 DzaFJ21nqeA4kag4B/aiebk7a5RdnWamtQCnXsLac/+He6KZbpFIi0RuHCvv/xC5aGvD
 OZUMApx82KfAM+Sa+Nb0B3RGLfeWKOROFazQxDT6DXMv6jIin7Nfo5xmY58Ckn9hn9lK
 npIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlCiPk0M2cew/gxcrwGlDh+GYBcSO8lSoWy9gXSnie8dVKuJE8EEunrJB+OYUHlnp9BxFCAsLab0mg0F/7ZKsVJKAJHA==
X-Gm-Message-State: AOJu0YxNSTW9+eRMttdA4zCNRfEV94RFdmqFwhZwCee2FtZl+6lt3Nj+
 h/z3QqmQOHhbh77xS1ofMxI4DI6Yo9sKmPRGfNKw9GxVgFWlE6Q1JYWxYvcMmYcPKxhyjabh+3T
 PNr0IMw==
X-Google-Smtp-Source: AGHT+IHvJz1VlIfxYjd8DTZxMLafqRb64Y7uybWAb2Po/D8NjVCoAEuEzRhzJYcN7m/wYyWfejJ11Q==
X-Received: by 2002:a17:906:f2da:b0:a6f:5562:167 with SMTP id
 a640c23a62f3a-a6f60d42710mr588816866b.38.1718611507889; 
 Mon, 17 Jun 2024 01:05:07 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::52af? ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed359bsm491659766b.137.2024.06.17.01.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 01:05:07 -0700 (PDT)
Message-ID: <2f4478fb-6893-4e49-9f6e-4a17e1616d2b@linaro.org>
Date: Mon, 17 Jun 2024 10:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] clk: add a stub clock driver
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
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

Small bump, would folks mind taking a look at this?

On 27/05/2024 19:12, Caleb Connolly wrote:
> As U-Boot works to align itself with upstream devicetrees, there are
> some common issues we start to run into, that of hardware blocks which
> might be important for an OS like Linux, but which aren't useful in
> U-Boot.
> 
> For example, the Resource Power Manager found on Qualcomm platforms
> includes clock controllers and power domains which are only useful for
> managing power consumption and enabling low power states.
> 
> As this is not at all relevant for U-Boot, we can safely ignore these
> devices, but we don't have a good way to communicate that to U-Boot.
> 
> As an initial step, implement a "stub" clock driver which can be bound
> to these devices so that drivers will work as expected. Make the
> Qualcomm SM6115 RPMCC the first user of this, and enable the driver for
> Qualcomm platforms.
> 
> To: Tom Rini <trini@konsulko.com>
> To: Lukasz Majewski <lukma@denx.de>
> To: Sean Anderson <seanga2@gmail.com>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
> 
> Changes in v2:
> - Take the other discussed approach of just implementing a stub driver.
> - Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org
> 
> ---
> Caleb Connolly (2):
>        clk: add stub clock driver
>        qcom_defconfig: enable stub clock
> 
>   configs/qcom_defconfig |  1 +
>   drivers/clk/Kconfig    |  7 ++++++
>   drivers/clk/Makefile   |  1 +
>   drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 72 insertions(+)
> ---
> change-id: 20240527-b4-clk-stub-9698797a65ef
> base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
> 
> // Caleb (they/them)
> 

-- 
// Caleb (they/them)
