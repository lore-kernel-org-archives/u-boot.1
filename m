Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89060C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E579B80077;
	Wed, 12 Feb 2025 17:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NVEu+FHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40699807C0; Wed, 12 Feb 2025 17:12:30 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A0F8001F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc1dfd9f2so4730203f8f.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739376747; x=1739981547; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxWFqdaMxV7NEVVhFg1BuZ6zXb9yHKE5+uLlNiDKFK0=;
 b=NVEu+FHPGxpmKqklShzfCF3a8x4rNEYooX6T0kSSyu1SY/9LYdK751yuvkMCpfndD5
 FnW0dJApir9K8BFp+cNHlo5Jq5mTSnTATJuCluH8D+KcBFgdYhQpioAJqwicA1/aFJe7
 8oXYwkAXRKtDMtU+bF8PxOTWwO0uM5HKcvRYrRGPRBmJAAdJWd5BUbyYTy6tfLELuYBQ
 OTGJmHH9eLSdzc8T/9RRqQZQ409vxdS6TGkrKdipAl/P+p2APam66jxhNmXDYYai2o0c
 6CNJce8h64jb7xs5kpcat+3UdB+O0lLk1nJl4ZHX2zvHxLMkXiJyqmiGQdKaebZyyeth
 iA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739376747; x=1739981547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxWFqdaMxV7NEVVhFg1BuZ6zXb9yHKE5+uLlNiDKFK0=;
 b=D2pfTu5KHgPKAKSajs2Hh7ouRGdCJvawrOoRdggL5fcbMabFE4iMIA9lHK3mr3l4BS
 WLBzemoq9kFQlP2l3DphV/DcYmsQBs7CmawLhGMiUbKX0szkQxlSDVTzxdlTdveXx9IK
 Nu3uS+Cishgix9zwKZ5ME1vi7gbi8EAAq2/J7/4XzEAOZGq5M8KT6wvDwE5BmiPoKipf
 yNexEMcCf4OLz1J0fEH/tjA6MWFCQsSg6+wbM0qHtnurrSyBSYj0JsfP4sEsz7SQHZOF
 qulSEMz1mEeXD0iUPh9KnTiJ8FR0uZjbk7akZiE+JF3dfHAQHsGAFwXI6btEXReCQZik
 Y16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUECplQ0+40PyxP4vUPMwTFa1L3Ni5NBysoMLqt1Of/6XSxTXoSbBJZccqgSDUl7WWHwdG+QDA=@lists.denx.de
X-Gm-Message-State: AOJu0YxPUEFwH1etX1u9Fp5nVSZDKz2Xi23hpApcgAXcXyKdNmpwSK7k
 UXFQTW0JzbKn8O44o+VlB7HrVs4mVC8Rii76XjdUfW/Sxpk3/sAcePVQym8GxQo=
X-Gm-Gg: ASbGncsp1i75QUVTbfPzMlJEFO1/3jN8BWQFm+5W2WpMbdEtETZFCoRKGoSLVfWjZMm
 BHxMir45FSX5ixdpZljZBmIKw9rTPfFa/kj3OEelKi2A1P1oM80Nqw6MYlmEjVrSTpNtQzJQ6LP
 cm1u6wQkzUYsCQxGy4YIVysJZ2WNirEkMKk9xpzsVClUYcJfGVaXyB07Y+V/1qjMGKyXyxnys4M
 EsMLHSlRpwRlKITDlKdC+mQfKMw6wSY28bj8Mn0qzd+77PaLq0PR7G/Mi+8MLo7Bb6DBlBlt9ks
 uQ/Saak7HHqgSWHsRBE6eW03++03TI7GCdb1KqnI8Zw0HvrnCLEzB+6ZT+42FlfPfXd7Mw==
X-Google-Smtp-Source: AGHT+IG1hARyHIxG+KQ1J0YilZ8BNqaU1YFw5qoDd581Lj8c/HhTZBfjogFyCP3lZH497ynlpi/s4Q==
X-Received: by 2002:a05:6000:4027:b0:38d:d4b5:84d6 with SMTP id
 ffacd0b85a97d-38dea25b016mr3726098f8f.3.1739376747252; 
 Wed, 12 Feb 2025 08:12:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439507518dfsm24772085e9.1.2025.02.12.08.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:12:26 -0800 (PST)
Message-ID: <982767ce-e47f-4633-a495-f223cc9bb3e8@linaro.org>
Date: Wed, 12 Feb 2025 16:12:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] rng: msm: fixes for MSM8916
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
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



On 2/12/25 07:01, Sam Day wrote:
> The msm-rng driver is currently broken on MSM8916.
> 
> The first issue is that the core clock isn't defined and thus not being
> enabled before registers in the PRNG block are accessed.
> 
> The second issue is that the enable method is only initializing the PRNG
> registers if the block is *already* initialized. This would have likely
> caused issues elsewhere once the driver was in more active use, but the
> problems on MSM8916 are immediate: trying to modify the state of LFSR_CFG
> causes SErrors, presumably because this register is protected by TZ.
> 
> I also included a couple of extra patches while I'm in the neighborhood.
> One is to improve the logging in apq8016 clk_enable (which would have
> better surfaced the first issue). The other changes msm-rng driver slightly
> to only enable its core clock when it's needed (similar to how the kernel
> does it).
> 
> Signed-off-by: Sam Day <me@samcday.com>

Thanks Sam! Really appreciate you fixing up this platform.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Would be nice to get Neil's confirmation for the RNG stuff since it's 
really not my forte. Then LGTM!

> ---
> Changes in v2:
> - split hunk changing clk_ens of existing clocks into separate patch
> - Link to v1: https://lore.kernel.org/r/20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com
> 
> ---
> Sam Day (5):
>        clk/qcom: apq8016: use BIT macro for clk en_vals
>        clk/qcom: apq8016: add PRNG_AHB_CLK
>        rng: msm: don't enable PRNG if it's already enabled
>        clk/qcom: apq8016: improve clk_enable logging
>        rng: msm: keep core clock disabled when PRNG not in use
> 
>   drivers/clk/qcom/clock-apq8016.c |  9 +++++----
>   drivers/rng/msm_rng.c            | 13 +++++++++++--
>   2 files changed, 16 insertions(+), 6 deletions(-)
> ---
> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
> change-id: 20250126-msm-rng-fixes-f5a722a9492c
> 
> Best regards,

-- 
Caleb (they/them)

