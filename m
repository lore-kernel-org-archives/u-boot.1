Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29431D4922F
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A418D88FC5;
	Mon, 18 Nov 2024 15:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wc5J6ClY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E908A891A9; Mon, 18 Nov 2024 15:59:48 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3A488E3F
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cfcd99846fso1176987a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731941986; x=1732546786; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jSqVS/B0rwQQHWBRKlDMyJtNb80hMgM9rQb5t2aELo4=;
 b=wc5J6ClYV+xiWcytQ4Zw1HNN2eWE2VQjklNQtmJgEYZsp00l0A71dqxWPWB4AdDemX
 NORHUmJONKVakafYIOHZo5kvlA8jtUHhgm/Wt8kWxIOHjPhRDexoJBJq/fy5VeLIt9q/
 mHlKr7o8+p2ukpg+eS2mWFJyvQdy3K/rtIgSkvczYu6mu5kLiAQRXe84LQLVCVSYYxSb
 zPr2FiYypl/61yb6RlHXiJqkqoTu6yieHcDORSFI3X94AezsFaT95wlObpzxC6FHq49H
 lYW+1Q2AjEg7iUfnE6MaGa6zLkHb4Y96LrhAY7sICMV3V/P/ejo8hhj4gzFsHx+dzXiy
 xB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731941986; x=1732546786;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jSqVS/B0rwQQHWBRKlDMyJtNb80hMgM9rQb5t2aELo4=;
 b=ZW6/OOSRZoW//X3sGrE2wBk/B3yQlsvDAiLwwLjm5r31oizboR8MWl6r3GyCXov+4D
 /O1KJjR7ixXS9TKrMyA6tPu+iNlPrXVoQUunO3FJYhaKTs7/jQZ2kWoqzqlV1LXs/BOI
 zjTVQM9RULqbpbExo2fh4PxpT8vHtPoJzCvVbOrFjbSIFTPO8lz0fB/OhbUgt2AHbV6L
 pangFSTucer5Xi8Fj5546GA1RMueh12MK5NBaTNvdldSippzfAX/B8bEgvn8M3AmXAdf
 sD7e39nlrAKy07aM+0XxPq3Q46z0mmncc/Rm6bacpLqT0TA2CNwVGT9XL0IGedzvrI2O
 QPYw==
X-Gm-Message-State: AOJu0Yz6aBNL+8q0U9O0vunFjh/B2DyQVXWbtC3tcuqYPU4bvn2US6cF
 S9JyKPy2+AyhK/aqbSDC5q5B1r6+jyJ6aslKg7EY1uLA4Ri43c3MNYMEC+wbp0Y=
X-Google-Smtp-Source: AGHT+IHkDtHjqFM0N2PfUXhnB7ZwyCEce2Rt4gmhFF9upH9xrANchCIz11m3CpY0ZMah1lD6iEi41w==
X-Received: by 2002:a17:907:608a:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-aa483553e12mr1177069166b.52.1731941986445; 
 Mon, 18 Nov 2024 06:59:46 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:767e:5e36:2eb3:ac68?
 ([2a02:8109:888d:ff00:767e:5e36:2eb3:ac68])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e00172dsm560174466b.120.2024.11.18.06.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 06:59:45 -0800 (PST)
Message-ID: <cce5d7d0-315c-422f-8dcc-ae4a9c83c5ac@linaro.org>
Date: Mon, 18 Nov 2024 15:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clock: add support for X1E80100 Global Clock
 Controller
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
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

Hi Neil,

On 11/18/24 15:41, Neil Armstrong wrote:
> Add support for GCC in X1E80100, and enable it in qcom_defconfig

Thanks for sending this!

In my testing so far on the Yoga Slim 7x UART doesn't seem to work 
correctly unless I skip the UART init sequence, and in that case on Tx 
works.

Seeing as it works on the CRD, I'm not sure what the cause is here...


> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (2):
>        clk: qcom: Add X1E80100 clock driver
>        qcom_defconfig: enable X1E80100 clock driver
> 
>   configs/qcom_defconfig            |   1 +
>   drivers/clk/qcom/Kconfig          |   8 +
>   drivers/clk/qcom/Makefile         |   1 +
>   drivers/clk/qcom/clock-x1e80100.c | 348 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 358 insertions(+)
> ---
> base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
> change-id: 20241118-topic-x1e80100-clk-d05b8f0fe1e9
> 
> Best regards,

