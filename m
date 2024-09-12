Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0B3EEB597
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 11:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 959C188F89;
	Thu, 12 Sep 2024 13:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TFLfWMqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6A888F1C; Thu, 12 Sep 2024 13:43:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4DB88F91
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 13:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso151476766b.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726141391; x=1726746191; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VgFlMOttD0V3NL7lXMO0ZhKSRFGgv7nRGRUJ8jezWME=;
 b=TFLfWMqrIKMbJ63kMEPTo4/B01WAiaAg8gKjiwNcSeaplQFRqXbyZTUvCFGXKPZffF
 TRYtcJPZxVwtwK1lrVLnidB6hkrbxaev4sjWxOR0Te/UgFohs9amUKCumFi9xKpfso+E
 s07aSL3IP3A1muK7gLxPTmCewjVk9iG7QjruW2zgGcZx8BDxpFo2m74JDOnUabgKwXNX
 sxRC7vLw1AdWpS8URx9cocsgfQmVLNknTRYJEEXWU9ODpgPZAOpzLVWEsTZKgBnrXYjO
 ZdDyuzDpo+rzIqxnNg42aqLg0XXvOv+BZm+2BlPJEK8p7TzsXUWYmG7il0lXc8FwALlb
 USuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726141391; x=1726746191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VgFlMOttD0V3NL7lXMO0ZhKSRFGgv7nRGRUJ8jezWME=;
 b=tsvcLkGH5RPtMIgg80AyPd8rZOtYoaXvpSS+7STMb1FEDEkZgK7fIOw2pKpldnjgoy
 gt03Xd0bPCWejLcHpxSunbbB7YcNMIDRJz5+GR+kKmgvgt5TEtxjBnTei0HmM/yUCiZr
 ZBgoUK67z2APSuEGlsQWEXLAXMUHsqe07T+hS0yky9ueX98ZQq8dWEhl6BcFhDyo4UC9
 U+a4q9D9Y9UDX5tNrKiF3jzu3rFR6Y8YNbntnFI0nifxU571IM2kwCgBEgcE31Ux9fOa
 SNPkTzbLDgs2n027uWefXmNFEH15Ygnkxg8TYR6eQ2MhSUHsDBMZwEkv4F6rdfEb8RrQ
 T4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtH376y57VvEoNm8QA8QAqZAHNxtDYSpLnAHiEzxYBF52R/zagt4URaoL6YZtPbDkfSqdeWA4=@lists.denx.de
X-Gm-Message-State: AOJu0YzETLNr4Y8MYZD9+5QdJPLwk1W3krAKbmNKnqW0lc6ZR6VgL6MP
 bgM3/PGQcCrIB0JWqlYbZp8QPKVvs/e4BKHPsVdygrLkzZWqnlSesUiiAzIkw1M=
X-Google-Smtp-Source: AGHT+IHxhv7nmQOgTlVfi7XEKH4KKzB9U2WRHJ+ZwQ/WNfuHY08+hpbyaTFRRv/r0LVZEjUktNtZCg==
X-Received: by 2002:a17:907:7b8d:b0:a8d:65f4:c7c6 with SMTP id
 a640c23a62f3a-a8ffae00183mr815666466b.24.1726141391009; 
 Thu, 12 Sep 2024 04:43:11 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a09e21sm736809466b.84.2024.09.12.04.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 04:43:10 -0700 (PDT)
Message-ID: <5478ad14-9cb1-459a-9538-4337966bc43a@linaro.org>
Date: Thu, 12 Sep 2024 13:43:09 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 0/2] qcom: allow msm_gpio to set special pins direction
 & value
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
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

Hi Neil,

On 11/09/2024 20:07, Neil Armstrong wrote:
> After struct msm_special_pin_data was introduced in [1], use the data
> to setup the pin direction and/or value if supported by the pin data.
> 
> Add the proper msm_special_pin_data for sm8250 after sm8550 and sm8650.
> 
> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks for this!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> ---
> Changes in v2:
> - dropped last line of sm8250_pin_offsets
> - Link to v1: https://lore.kernel.org/r/20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org
> 
> ---
> Neil Armstrong (2):
>       gpio: msm: add support for special pins
>       pinctr: qcom: sm8250: add special pins pins configuration data
> 
>  drivers/gpio/msm_gpio.c               | 97 ++++++++++++++++++++++++++++++++---
>  drivers/pinctrl/qcom/pinctrl-sm8250.c | 42 +++++++++++++--
>  2 files changed, 127 insertions(+), 12 deletions(-)
> ---
> base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
> change-id: 20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-943311b483e2
> 
> Best regards,

-- 
// Caleb (they/them)
