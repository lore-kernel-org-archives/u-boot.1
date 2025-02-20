Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D6DC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 20:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F109980EC0;
	Thu, 20 Feb 2025 21:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eh+QMV8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F50380F53; Thu, 20 Feb 2025 21:44:28 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7881B806FE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso1010116f8f.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740084266; x=1740689066; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyphBKOs6Oqvqu6nGlTG2sXPKAs/YXGIZITxDsOc9Ok=;
 b=eh+QMV8mWAaLRvKvr7lbbXy/vNY3Nrv2q6TcznvKUnXmfG8fuWqVwkXojgGx5nrtse
 fyiAvBXSEb2Wn+u6Kb61BQLPgSrJRqjOHpo5ReXKGC54OJROKSQgjbVT0RF6ZMne8e0G
 crwqTmWavECDwwqYltEaBzCOv4qRCv+p0YM5hEmYyho9yrX6x3addCVuZZwJubqTApE+
 6A5ryD7ZuCFuG+3NW7rzihUo0nRf8ktj63UuAKf/BXVv7156bAi325taYI7UcCxNmsHz
 rylt8qufX5OErF0zI+Pv0NAplbdoCFeGjmRPFnn83zvgwaudC2Y/yshqdiL929BpWuao
 Mq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084266; x=1740689066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nyphBKOs6Oqvqu6nGlTG2sXPKAs/YXGIZITxDsOc9Ok=;
 b=NkaCgAeRhZTwqAHzY4M63+GzgMvORceaNJm5Uo4Y1j822OZsQu6k/m7Nw6CEpf5T3m
 gL0k/SrRuzdCA/4aqp/qFYHhEq9ub6k2HXB0uJv999lZP3ttDHbnS3xLoue/FKQmgbiO
 HK3+NG3jnmQHWd4lr9J5opg+uOsLTI1f5mRpX/9exZbXYBmyiEu81poqSrESKtq1XtVG
 zDESaDGYAuRvOlFTceZvDt8D1iTphjVnPqZFLtMadWZVwZy3a2h5OtQqgMLGKvgEFNLn
 EmhVK/STg3l/+hDZXV391X7oiAY2l/+buBA4fAX7XScb4adgfZnSuaGjGepQ4za2OWR1
 uXRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2KJtj+7IQ4ShzlRwLJC6CVB7mUfY9opg1jEEVs8qnK9gsl+HyUJbUpy53CO1Q6Jv0HO2h26w=@lists.denx.de
X-Gm-Message-State: AOJu0YwRlGWEyXLuAgK0sFV4iINKtWS88Wb2vurZ6O5drDL5G8sGngPn
 XNwXEUM+wqbh77tBFbchv+viEyZ7Pxw98nrtQz2Zeeh2m+rlRPR0Swix0OCON3g=
X-Gm-Gg: ASbGncuxWShzAS7ZuR6EuhgV+khBv+n6IAnTv7elw2OxSaunzAGl9l4yatuRZgeR+4y
 UFhxUHOFuAt2KCyWyPjdIXWuWMCWLXIgEDD2aCt2ObVes6DwESmuWppYeR+CK28CQcKaM0lESFY
 HcvYFDrulC5jqlrQcg4Rl0E5CBUaRwUUVuZ+CnFkVxww50kiDjLNvnMCQ25+gd3DA5qA9HoxxXw
 bLaaa9HJ/BlgFUwben64X4LuxhwgVJ3TDzG2qaFnIi1NZiGo2boUm61LaIRXJ4RSxlfVfsjHH2Q
 8daK/5vbryn4kVyeVl2B3QRhaFoRqEOL8SDIuQwm4P1TcwRz7NVnV5ZYdCE+5FKCPyQTsQ==
X-Google-Smtp-Source: AGHT+IF+76ZERAY84jaFlgFyqpCYk/LfCiiBZh/w940CbMQ8jJQsTcZ/ns38AFaaJEtkZbSFWDyMbQ==
X-Received: by 2002:a5d:584b:0:b0:38f:2176:45a0 with SMTP id
 ffacd0b85a97d-38f707b0957mr164151f8f.33.1740084265763; 
 Thu, 20 Feb 2025 12:44:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:56e8:1b9f:967:210a?
 ([2a0a:ef40:1d11:ab01:56e8:1b9f:967:210a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d9be9sm21854506f8f.79.2025.02.20.12.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:44:25 -0800 (PST)
Message-ID: <47882bed-ff45-4c86-b3c5-920ee6f0dee2@linaro.org>
Date: Thu, 20 Feb 2025 20:44:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dts: ipq9574-rdp433-u-boot: add override dtsi
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, Volodymyr_Babchuk@epam.com,
 sjg@chromium.org, lehmanju@devpi.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220073937.133687-1-quic_varada@quicinc.com>
 <20250220073937.133687-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250220073937.133687-3-quic_varada@quicinc.com>
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



On 2/20/25 07:39, Varadarajan Narayanan wrote:
> Add initial support for the IPQ9574 MMC based RDP platforms.
> Define memory layout statically.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Fix comments and give additional details
>      No code change
> 
> v2: Use upstream and override DT instead of own DT
> ---
>   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> new file mode 100644
> index 0000000000..390e2338d6
> --- /dev/null
> +++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/ {
> +	/* Will be removed when SMEM parsing is updated */
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x40000000>,
> +		      <0x0 0x4a500000 0x0 0x00100000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	sdhci-caps-mask = <0x0 0x04000000>;
> +	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
> +
> +	/*
> +	 * This reset is needed to clear out the settings done by
> +	 * previous boot loader. Without this the SDHCI_RESET_ALL
> +	 * reset done sdhci_init() times out.
> +	 */
> +	resets = <&gcc GCC_SDCC_BCR>;

I understand that Linux doesn't need this reset, but devicetree doesn't 
exist in Linux to describe what Linux drivers need, it exists to 
describe the hardware. This reset should go upstream. Ultimately this 
file exists purely as a stop-gap solution and the goal must be to get 
rid of it in the future.

I'd appreciate it if you could also send a patch to the kernel adding 
this missing reset.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> +};

-- 
Caleb (they/them)

