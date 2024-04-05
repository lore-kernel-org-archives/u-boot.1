Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E8CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BD088473;
	Fri,  5 Apr 2024 17:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJJl4MlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A2188479; Fri,  5 Apr 2024 17:47:24 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C68E88465
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 17:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516c403cc46so4476788e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712332041; x=1712936841; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrjIkI9yHW9nUY0mizWpMKbrDwDglmVl9caDEDtgxQI=;
 b=LJJl4MlKYhBKmyo1Y+tO5azTe9lQPNAObl0rUkVqsUEw8LaVFyOCNNYkuKlJ+SjNeu
 0N2irpHBimYwrRnf4Pw86BmlPQlwPQnQW3/yrDQZdTIuSJQ9R82W3bd/06QZB3+3SPqV
 1ZqHRPhl7wSBqZTMOO01SyEF+yMEvHHafMwPpa4VorCXPnyU7RxqQmBVsfTX6bhaZr+p
 lSjAyt8kAHAX+mddZ0BSA6TSuZRPExslUAKj2rtcaaDfHwXMIPZWCU4iZczknZBNURHW
 LzsmkePyAYczabbZ6pcD0nF5RCUAGbpXmly83fZaa8BddXybfYb/fFw9ReQybSH/eYpS
 5CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712332041; x=1712936841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrjIkI9yHW9nUY0mizWpMKbrDwDglmVl9caDEDtgxQI=;
 b=mXzjr2Ceiu+G5WZDhymmSuAAb23J/axu+tCidZ9uOCP3136sxUj5+/JT1+kNqdp6Lu
 IgNx31d6oZpBP2kj1ohgE8hK0hdQSPOwJQSRxVIZkh1fjtsAPSfCIH4im6Ya0xpTAmz0
 D0n+ScJws6APbIm/RJFHRRXjAPU/g9HUy4LKTjJLG0wqbJ4a4xxsV16PvkeA+aZIisDU
 tNPMvMmG2wyYk/f15F6610UuUna5LkDnZmj+Lgz+njYjnV0SbYQfCea60QvcJ0rNye/h
 Igx70+kmQkMh1JeDhKXuuigSMLuQCVdlnMSufshaA++AQ6ccvjoZQrrzfnv5Wj8lFQyE
 /ogw==
X-Gm-Message-State: AOJu0YzyE+zROMbLsyNQQ65X6wi9nEsJsT1aShOrfMKyegeU4mckx6vJ
 rXWTHHaJiborACAM8uaCNZhmpLFxBLu6NRiPAgWOGDYzpF3oDTjkvmYm4V9w7EY=
X-Google-Smtp-Source: AGHT+IHt1EYjbBgdRkBc6YJyvMXxqJh85ytJWpJiKw0UVegLw09DyjQDt1qZHZBp3FXiufrSQhByfw==
X-Received: by 2002:ac2:51a7:0:b0:515:cf42:117b with SMTP id
 f7-20020ac251a7000000b00515cf42117bmr1816886lfk.60.1712332041419; 
 Fri, 05 Apr 2024 08:47:21 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4716? ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 gs9-20020a170906f18900b00a4e07f8b6bfsm963442ejb.59.2024.04.05.08.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 08:47:20 -0700 (PDT)
Message-ID: <532211b2-b654-43d8-bcd3-b98c51598637@linaro.org>
Date: Fri, 5 Apr 2024 17:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] qcom: add pinctrl driver for SM8550 and SM8650
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
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



On 05/04/2024 10:15, Neil Armstrong wrote:
> Add pinctrl driver for the TLMM block found in the SM8550 & SM8650 SoCs.
> 
> This driver only handles the gpio and qup debug uart pinmux, and makes sure
> the pinconf applies on SDC2 pins.
> 
> Finally enable both drivers in the Qualcomm defconfig
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Neil Armstrong (3):
>        pinctrl: qcom: Add SM8550 pinctrl driver
>        pinctrl: qcom: Add SM8650 pinctrl driver
>        qcom_defconfig: enable SM8550 & SM8650 pinctrl driver
> 
>   configs/qcom_defconfig                |  2 +
>   drivers/pinctrl/qcom/Kconfig          | 14 +++++++
>   drivers/pinctrl/qcom/Makefile         |  2 +
>   drivers/pinctrl/qcom/pinctrl-sm8550.c | 75 +++++++++++++++++++++++++++++++++++
>   drivers/pinctrl/qcom/pinctrl-sm8650.c | 75 +++++++++++++++++++++++++++++++++++
>   5 files changed, 168 insertions(+)
> ---
> base-commit: cec1c47bdaf84a643f318d480b1218bfff1041ff
> change-id: 20240404-topic-sm8x50-pinctrl-101fac729d23
> 
> Best regards,

-- 
// Caleb (they/them)
