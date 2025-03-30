Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF8C36010
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 15:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8179780FDA;
	Sun, 30 Mar 2025 17:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MuJz/bVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1A380050; Sun, 30 Mar 2025 17:18:59 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8636181D3B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 17:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso3476588f8f.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743347936; x=1743952736; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bnioqEzPPgnq6SvqivP1HzJbYpCxQ63O7znG6EKt1bM=;
 b=MuJz/bVcSSFGKlRYJDd0/aQ+o0HPf00i+EWx8i+gsPpaT2tEk6dUBDvj60mRsuGiDY
 IcQ0TsQ/F8vXCe9BMMUKiC6CbeWEAGh+MonP1KSqWAwbrOPRW1/DWipM1ziuoQyStOKs
 lm+H5HbNn0PgXmzjbSMXLvqHGNJFa1S6rThWHMRIkZw1QqBIOGBgsAWHkkXLmEnIpD1f
 HE+Ttn8rNJ0lQ7n7NzO1ofdfCACZfkA5tRkcMkjsTaZ9t2GmNuOVh6tJk15hHHA7kcQH
 p2rhVPqQhnncQwMmodu7yuny4KBQUce5YIXfBLIu96jrtBPWwvBttrGI1xdErr9x3MkV
 hYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743347936; x=1743952736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnioqEzPPgnq6SvqivP1HzJbYpCxQ63O7znG6EKt1bM=;
 b=EByk71fnHt6PvwrKW1Lk3vkGPEvtW5LL5WM/rKKo2BIVkPrbUcTSV8jEQD+krUZR2G
 w7utE0+B8QSeGrAg15a/c+drp77IKyRjQXGTElgRxLR087FgfR34r9sBLX2wdD47XFeL
 NbnvfwFn8FPBYueeee6pyblc+4B/x3BcMzRDet6D1ppB1HaCepTWox9havixUSD55JjU
 3lMdWAVNgn6e5I9BDo8N9FFh5moyK0W2XplK1Ib7TGoE077r9k7UxqLtA7DseU+O3jVH
 u4Yqmz4lNT+R+l9PntqSJzL4TYBZ6qgSGHe9S58BUT37AiRwVGJ5xnSTK7JSdruVsf5a
 dpzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwz2f591YkEFvSW80zL7tBEast/mdkgO5nQTrYahE+9wKZCSJvrkMA7YZHbyHsFqjPJbpBb2k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc4VnfMQOmiSF8RzvM54GfBoVjP5Gnf7rCVIREYl/clQAGhrLF
 XUWAi6WKubJatJ2+Z7LMMhfV8OE7NvIUZR4PJNl0hv5XHoPbZwPOMINCveATW0Q=
X-Gm-Gg: ASbGncvvp5cYSVXAWF2+YRHSbIGpFKyn2M+hRZhO281R4JKcYtIdGKv9zHUo5JP2vuD
 E9/+5ea4cAhg3XxgXInuGOxuA6cHI6ZD6R3JTAuh61x3p36pvwyHRCublhwWB4/kSo99Qzfuvlq
 S+Tz58HZuzkvMw9iI7pzpVm02doBwHa1YQBFTLE0XmWh7tWiTK9cHaRNPMwNvCXF6NHVZFEp3A7
 rn0QYk4DnwWjUFIzIP82oQFsPH8mcYUVND00dmPy3zs1C+itfxBO5ytrM/hKs3aqV7B74//syUb
 Pi2SPgZhZwnT27Hhdh9vPmicChNdrjFDuNnFtw//z23AH4tBvlTD7pVNJ72tSrqjLpZvdzCJyIf
 3bYXzu43AHQ==
X-Google-Smtp-Source: AGHT+IGGI7CrVVweQunJ3j29M0iTqH5y//vdbSThtdUcN23Mr1VuEUbw8gOpBmXG22IBQM7czuY7ow==
X-Received: by 2002:a05:6000:23c5:b0:39c:cc7:3c97 with SMTP id
 ffacd0b85a97d-39c1211d6ecmr2859364f8f.50.1743347936046; 
 Sun, 30 Mar 2025 08:18:56 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f84sm93992825e9.25.2025.03.30.08.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 08:18:55 -0700 (PDT)
Message-ID: <a6dec155-ff0b-4197-bd29-ca2cdb7f1ae7@linaro.org>
Date: Sun, 30 Mar 2025 17:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] qcom_defconfig: enable pinctrl for SA8775P
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 robert.marko@sartura.hr, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250324080504.2385747-1-quic_varada@quicinc.com>
 <20250324080504.2385747-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250324080504.2385747-2-quic_varada@quicinc.com>
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



On 3/24/25 09:05, Varadarajan Narayanan wrote:
> Enable the pinctrl driver for SA8775P
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 661a484f7bf..20c49223201 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -97,6 +97,7 @@ CONFIG_PINCTRL_QCOM_APQ8016=y
>   CONFIG_PINCTRL_QCOM_APQ8096=y
>   CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
> +CONFIG_PINCTRL_QCOM_SA8775P=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_PINCTRL_QCOM_SM6115=y
>   CONFIG_PINCTRL_QCOM_SM8150=y

-- 
Caleb (they/them)

