Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147BC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1798070C;
	Thu, 27 Mar 2025 08:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tv2t1a8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE8E81273; Thu, 27 Mar 2025 08:41:54 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F28806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so5926725e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743061311; x=1743666111; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUeAHQCKPOqp3wSlQ4CcCEYr2VGcnwDRR0ePOzJCV/Q=;
 b=tv2t1a8babOMqY4H9okPYvnhMIRI2C0KWI6XZz1Hnch7Z7M65qfaM94PoCfuWpOTPf
 7VOq61GfurpTCf2uFxejAB3YMZQehAUBzMafK/w9x4YqTOV4SZGtyGayaJES72tig6Py
 PXSyJq4i4PoCeyjdAXig1N1ZD3WfumlzOb9ecetOWpyZhjjBdvkngwgYeEJfFZPf/woO
 GwdR+yywXb0PZFzpaRNoL4QjbcrTsB6dkbsY1CKZvF/n4KHUgJpo/FQPgNk27vs77mok
 DIyyTYKXgxGLZ4E483ZQWi1oDeZ7n+CBIJkx0NFEUvZRx/I2inkZt+B7jIuZf8dKIdqU
 iVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743061311; x=1743666111;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUeAHQCKPOqp3wSlQ4CcCEYr2VGcnwDRR0ePOzJCV/Q=;
 b=JSSMteia8AtgBNjOHRPCocROC1UJ2EyBcFo40IzC3m5+YplAawwZ/pqSXps4iQkua+
 5CjxB2zmC2XDMg5Bm1CBuS03amMFDnlEid4AJAmGVPwvEAKNzRNHepgkfgNCN/fsYPPf
 WsjtQaGnFYfz6rqB8bouqoUcxNe+AJshQUvM/IwjEGcWAEus5i3ps/T1hG9AAjx0sAZa
 DfjF3CmjiM+O8ZnhWptVQmamPWxNBXmbM4+m0o1NbD+4ck6NA6yEHzWM7jEixp9EI2Nv
 cdpeM+/z0f/U7VHyGcA3lt8sHDU4fys/mhiMbtSZb4yPX2yUCAIZ4DKtrRA1XcUk8TOM
 Zu4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnjsFbtDyz8s1nUrJz+LN2WLB/vVROWDQ23sCQrQ21hTwCH66R2GTZlQMa47sajDQ6JT2dHy0=@lists.denx.de
X-Gm-Message-State: AOJu0YyHHKB26ebkzsch1Mnsm+VVc19k8sZKgvVP8oy2HtDRTKsWbKTQ
 xCMXkx1cAsdmzn/xxOq1pQwmkol93NbfsOivpxle0xfp5mt0cZHl03XE2Wd5vBU=
X-Gm-Gg: ASbGnctCL+OKt+Kc0tpzMLYKc9ScKDEL+V7BVKogWGnELxxJ15MZb+ySRulMin+a9az
 2CtfCqgxPW8D588JUloens+fu7G86i1Zw6Yfo3STBVpPnsGRpCvsWrdiazT+3io0NeF03UCG/ti
 iXnosykAX7J1gwXU/FDHvxrwHyOTk1xZa8yozT7iT1Kkd83ViuDjmwuGKQnrMZWDKSbBrGM1o1+
 vNTmi1+/x24rQAdlwu4BsWZfRM1zX/z0Q/v58/Qlh8ehvGtlhNAjRvj0/+8SFj3ZzFfy20I1Ux7
 SMXWAZP3E3SOoQbIAu3X3mDsoAIuOaIm21ODTMymSd90NFA1+uCW
X-Google-Smtp-Source: AGHT+IGowA6x5aMMwFxh2x23JtxIeobxQtmb+9Vnv8OoKiWEQm+d2PS7lILMQDeRdTz6JM+NUbMA+Q==
X-Received: by 2002:a05:6000:1889:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-39ad174b759mr2032573f8f.16.1743061311340; 
 Thu, 27 Mar 2025 00:41:51 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b409sm29117885e9.34.2025.03.27.00.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 00:41:51 -0700 (PDT)
Message-ID: <90b45c65-d4e9-4822-93ba-7fe69acb1d8c@linaro.org>
Date: Thu, 27 Mar 2025 09:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 mkorpershoek@baylibre.com, nathan.morrison@timesys.com,
 ilias.apalodimas@linaro.org, greg.malysa@timesys.com,
 caleb.connolly@linaro.org, Oliver.Gaskell@analog.com,
 robert.marko@sartura.hr, igor.opaniuk@gmail.com, semen.protsenko@linaro.org,
 william.zhang@broadcom.com, nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250327070615.334551-1-manikandan.m@microchip.com>
 <20250327070615.334551-7-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250327070615.334551-7-manikandan.m@microchip.com>
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



On 3/27/25 09:06, Manikandan Muralidharan wrote:
> Since the SoC and board DT are already available in dts/upstream,
> add the difference from upstream DTS to at91-sam9x75_curiosity-u-boot.dtsi
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../dts/at91-sam9x75_curiosity-u-boot.dtsi    | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
> new file mode 100644
> index 00000000000..e25e3734eb1
> --- /dev/null
> +++ b/arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity-u-boot.dtsi - Device Tree file for SAM9X75
> + * CURIOSITY board.
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
> + */
> +
> +/ {
> +	cpus {
> +		cpu@0 {
> +			clocks = <&pmc PMC_TYPE_CORE 25>, <&pmc PMC_TYPE_CORE 17>, <&main_xtal>;
> +			clock-names = "cpu", "master", "xtal";
> +		};
> +	};
> +
> +	clocks {
> +		slow_rc_osc: slow_rc_osc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <18500>;
> +		};
> +
> +		main_rc: main_rc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <12000000>;
> +		};

What is the purpose of main_rc ?
If you reworked the pmc driver and now it's no longer required, please
remove it.

> +	};
> +
> +	ahb {
> +		bootph-all;
> +
> +		apb {
> +			bootph-all;
> +
> +			pinctrl {
> +				bootph-all;
> +			};
> +		};
> +	};
> +
> +	chosen {
> +		bootph-all;
> +	};
> +};
> +
> +&clk32k {
> +	bootph-all;
> +	clocks = <&slow_rc_osc>, <&slow_xtal>;
> +};
> +
> +&dbgu {
> +	bootph-all;
> +};
> +
> +&gmac {
> +	compatible = "microchip,sam9x7-gem", "cdns,sama7g5-gem";
> +};
> +
> +&main_rc {
> +	bootph-all;
> +};
> +
> +&main_xtal {
> +	bootph-all;
> +};
> +
> +&pinctrl_dbgu_default {
> +	bootph-all;
> +};
> +
> +&pinctrl_sdmmc0_default {
> +	bootph-all;
> +};
> +
> +&pioA {
> +	bootph-all;
> +};
> +
> +&pioB {
> +	bootph-all;
> +};
> +
> +&pit64b0 {
> +	bootph-all;
> +};
> +
> +&pmc {
> +	bootph-all;
> +};
> +
> +&sdmmc0 {
> +	bootph-all;
> +};
> +
> +&slow_xtal {
> +	bootph-all;
> +};
> +
> +&slow_rc_osc {
> +	bootph-all;
> +};

