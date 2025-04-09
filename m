Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B624C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C9183869;
	Wed,  9 Apr 2025 17:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mmVfXlRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264FC8386B; Wed,  9 Apr 2025 17:13:46 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25B78381D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6178789f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744211623; x=1744816423; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmONFEvZuZE/YCij6bbUG0UlD+f5LnS0xBeZAe4z8Qg=;
 b=mmVfXlRRaowzaYMQUuBND/FH/WUoqpb0qbN+HJiv+8H6xhxQqplqsxDJzDq/U3Nqu0
 zTcFkNyHlo5lZSm2DmYMn/kN4QvxggTwRLTavIBXtJSMcsaLf7I/+R+R/UbL9yz7iVqo
 hP7OoJGt5fp0j9sFuNnOySnsxmlK4FOqX9hE/72D3vp/m1rX7Egp0WyZNgzgNY8Q8ZYw
 gc+nTcNjmb643rjJJGG9MS0IZa8TiJgb6Dpyw8S64WK4iJIy14BnTCv9HGmoRkXwmI8y
 JZqgSnWa0e4olkR3edgwa78/uM6NpypVvSHxwjf8UYDhtnVURR+nzhbsxHxzVV5qFY/2
 oUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744211623; x=1744816423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmONFEvZuZE/YCij6bbUG0UlD+f5LnS0xBeZAe4z8Qg=;
 b=HZduEF5gcRjkD4XplnFjdChLWbDe7wdglV6WJlpbh9gv9KeELuxL6yhv6Y7F3QfXAG
 TM621UOWG3LzLLtLoTRME1zDtYbb786VhvDEGyq6rCfNfnreqy1a9b65lVEJUm34T39D
 K2thSsRBbAqUoYmB2Inmsin1/yQN9gSRysOjq+XSCgbqNHcGncVu9CiGcxqL9zRr4/EN
 VZw4mR7GqZnXj7/NeE1aB8rKQzGuprN3D+zSAeI3qCtqnHb7HeStTQu/5l2h+zp14y9/
 UeWdiUcvioJB/BBjTcMAcbjzWiqsooQ1MLvtEUmTvVdjHj1DINs427/kU4A/TdrF28ef
 Evqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsu6ABGqSrN5MrCGSq5VkO2b5lSm6LnSB64KKLmwNAUtObW2njaUqI/UX65W2Fc0VtEV5AtKo=@lists.denx.de
X-Gm-Message-State: AOJu0YxJx5KeOm0N9vOii/kV5Ugl7t8ljUgrl8sjLPN4FhLt5jg6iUl4
 1Yqn76Cf79/46JhZesJdoOstuPRAloroQWHSE9hpuZSDOP9w1J5e13vYM81DTQc=
X-Gm-Gg: ASbGncsIu+8oFJEU4sBxemLuDgTj6xOgywag6lEDP+E8kIg6BmVTjteJ0npYBKHFdhJ
 qbJb1fpYo6z5VaHsGjGLyi58SBtutDfrX15hkON8dNRlKMfA7tGwcUgOJlZd/pQfKEt5nCOKH8f
 ris4wSn3dxgJaI0KzW0ZHQRC/5q6S99Zng5EAw+DS8ivzi+Vy1TIUDP+bYK8d/V4T8Cq97yN9DI
 2x7lDi7d+uz8NtgESN0IvpBa/ALWJfeNrhpnvRxIUeQmDxS5/vwk6cVVsRSfXvua3Fej/9RjMey
 Dp4b3oivAsf9mV8lpuV3E31tZ0V3ZOBwvl9PHAo+wbz3sToBEmIPBEwInKq+NsC6Duiv
X-Google-Smtp-Source: AGHT+IH2XtEV+DSTSH8s2jeCtDg3BXJ0//BUjdrXsYuiqO8nhRXlGRAyYDekn3ZrQCoB7lNeoFsGKg==
X-Received: by 2002:a5d:5f88:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-39d87ab54acmr3212519f8f.27.1744211622973; 
 Wed, 09 Apr 2025 08:13:42 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2338d6ebsm20199415e9.2.2025.04.09.08.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:13:42 -0700 (PDT)
Message-ID: <ea7bc45b-7b2f-424e-a07a-baca8552d81e@linaro.org>
Date: Wed, 9 Apr 2025 17:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
 <20250407175617.3494506-4-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407175617.3494506-4-jorge.ramirez@oss.qualcomm.com>
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



On 4/7/25 19:56, Jorge Ramirez-Ortiz wrote:
> Add support for the resource power manager clocks over SMD/GLINK to be
> stubbed.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks!> ---
>   drivers/clk/clk-stub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5fbbb07b7f7..38ed0d094fa 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -14,7 +14,7 @@
>   static const struct udevice_id nop_parent_ids[] = {
>   	{ .compatible = "qcom,rpm-proc" },
>   	{ .compatible = "qcom,glink-rpm" },
> -	{ .compatible = "qcom,rpm-sm6115" },
> +	{ .compatible = "qcom,glink-smd-rpm" },
>   	{ }
>   };
>   

-- 
Caleb (they/them)

