Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753E6C36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 20:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A35381DE3;
	Mon, 31 Mar 2025 22:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pg2ENf31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708E081EDD; Mon, 31 Mar 2025 22:34:26 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBCE81F32
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 22:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so49370575e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743453262; x=1744058062; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w7AJq8RTbZgv7pQioxPmEtVo0OIFMgXBh5TcEppKhc4=;
 b=pg2ENf313/lGNNQjfpWI90HSqZBvmCfSyoFxAqYnQIMlPIj/t78K0OdI6+YfbCjHkf
 TBzbM43LLYtGv5tK0p0IFh8EC7cOUa6E2fERczs0dO5iRm0cVNYeMoZh8RD7fFi/bz1R
 E2CuR7uTMg/PQUBvH8xTCe/2u1Bog2SdM2yVclsoxIKj3gAQJcyCLCAhyIj9GDh4JFer
 pjYcbLdah1phr9Fq3v1pPe0bf9k7FSXUpQnsmT+SRw2rGnfvZ4HNmtQp08b9DE9tSbAu
 vM6NOBhQtJsr13Ed9g9kgsgWvJGWM/u6X7UsI2rYNuYfJK8qc7pS+kq4yHqmfcD950qS
 uwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743453262; x=1744058062;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7AJq8RTbZgv7pQioxPmEtVo0OIFMgXBh5TcEppKhc4=;
 b=v0ZX70V88hXr7L3TB6THlzPj9QkU8d+m5SLZ6XrJAbOb98r+AyZasTIPDZHwyQ4w57
 So0ci8r5/9LjDx+DzROTrkzzV8J1dUAvsJdN0cYlva+XWugWhkmCnMKMHd3xWvJBcoIR
 rDeoKNDBkFwVfHe1kzDpYYGLwA21M69+AxubaonDa0Qo5m3HJoTuhUxnQGTO1hDG173i
 i6rvp/ZiUPFEHJ1jbF8kC6o2BOAvIMYs0ZZoPuwAQq1RtufSW30q0PKTeApJinZ1y1ZA
 hugp845/Dm7W1wmUT+lASJ56p46R4a5NE9L8Aljx4bWxfeb2JA709wyd3ZVm3/CvITzN
 Fojg==
X-Gm-Message-State: AOJu0YyAZFOQhJ1f1Y3k0dqXpH9UY/mXEejPDv+w1OO5YlMlMB/fSNrm
 0+J1AxVV9LoNqBn9NNBS24+q3H7CCFhHAURN78CzixELcfxW4s7Mxj9Vm4/ua2Y=
X-Gm-Gg: ASbGncu9+SguEreDClle5J+tB+VGiJIvtWqcIBXzn9gk2/1h1BeWajhBeAyqUjPLhbm
 KvRogAQM/KyfGQ7PVo3U4NMXIqTvTShT3DGoISQsiw6VV68l+N20F6QFCXYTCF2Ax/7JeGLYRQL
 8Jz8zSQYLENwkK/o6q4NeKOz07oAipG14uQYgoxuE0zzl3lreJoQeb46EgGGGpvOIARQArEFAvd
 KiCXjbvbIHCmCqZAtUbfxiShs3Iz4LFPQgnWwc7/cA+PPA95NPuYQHVEiQBvCj6Z6dBBRLQEta9
 piiylSd9S+OR6ryFY+JZtfjVvJ/jQAF9Xf9Q1qK7I5196e/51NY+
X-Google-Smtp-Source: AGHT+IGNaSU6h/x9u4mePlzZkX0eg+x5qnF7QU/qlA8uHJmK44IP60UXZcE5rEbtoY4m/VeIYnI5pw==
X-Received: by 2002:a05:600c:3584:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43db62b7c5emr75682265e9.19.1743453262349; 
 Mon, 31 Mar 2025 13:34:22 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314bbf1sm173618245e9.38.2025.03.31.13.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 13:34:21 -0700 (PDT)
Message-ID: <343cd86c-2ecc-433c-9400-bc9de72898a9@linaro.org>
Date: Mon, 31 Mar 2025 23:34:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: at91: sam9x60-curiosity: Enable USB
 gadget node
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-4-admin@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250331162611.1557759-4-admin@hifiphile.com>
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



On 3/31/25 19:26, Zixun LI wrote:
> Enable USB gadget usb0 node support.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
>  arch/arm/dts/at91-sam9x60_curiosity.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 99867d2bf8e..08480df88c6 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -248,6 +248,10 @@
>  	};
>  };
>  
> +&usb0 {
> +	status = "okay";
> +};
> +
>  &usb1 {
>  	num-ports = <3>;
>  	atmel,vbus-gpio = <0

