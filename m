Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C28C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F73688877;
	Wed, 22 May 2024 18:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d+P4npP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E088889B; Wed, 22 May 2024 18:21:49 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0958883C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so233897566b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716394907; x=1716999707; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuemEA8dKTYgxjIrGD5OpC6XaHbmakNYKreN2CoJF+Y=;
 b=d+P4npP93bBJecEuMd0wVbCEu67ye52y/veZbFNS4c3+zypf+3E7d+DaTZGkKu8unJ
 rekz794YYCgeA+V+5EXhQ4DoZie3yQFg1Ih1uJB5K08O0et98wNOlb8o7HLjAATGDQzz
 jN4SbH4HseGR/gb2OHwHU3RrHhgeA9EKBqfvwIZIt+0bSDmV/VUkRA0bLq794x+VefHr
 tUbRKvv3Suy2TZEeV1KX5s9HxTuerm0SFi45M38xGwGBuO5le+YlpbXd97iqRsAdH9i7
 b56GWOwbTKGaU9iBAneRSCVIV/lCfeR7T/E4eV6/nAsltMOIhSF4Icakoo/B0idt22pS
 nruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716394907; x=1716999707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuemEA8dKTYgxjIrGD5OpC6XaHbmakNYKreN2CoJF+Y=;
 b=ZSoCcfY4FJNdCiwMqFiLFgMAziGMhVLMQfbPuyGniSqy3nc5lc4Pbzp1x+HamnTVJk
 Wl02mZG/K6JT8mvog+CHPEBpdwegULbyTBE8cApeuqoBxMCmE/8aFcQufnrLHpd8Le53
 mTIztHkiDDt7JmmD4tV6bD3t8Dg33QcbUfwasUW2DwiP8jCrUSFCK9AohGjvRMo9T6U6
 8zjEUBDObGUYzmzGjq7+mrARr448P4ywZ/Udl5lDnnBE/8qeu4ZIOy3DV3XfJOCARlaq
 IN1/XT6zm12F2S7F5DBbvrPNqBZHH3SqXO58ufMfeYO5OKPe80WX3d/zROtW7ObVwy8M
 8byg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI+YKXL3q3vIRZUZFGotz2HJWhdEa0GbCoQzxbJAzXyUjo+YFYpCqR7RbocmWMa7Z5txL6pGkADYLstKhw+R9yuhJJFw==
X-Gm-Message-State: AOJu0YxsLRbR4xwUVwN6dmlJ1YA337eFcKXdoyyCRss0tM78wjBxhtak
 dA4A6Gofy2vcavKk3U4TXK8dHm7nHh3gQfKfioLplV53PiwiUUtUMnhc21QrXKs=
X-Google-Smtp-Source: AGHT+IHM2nq1T0KcEbqBLoj80kWR4UoSTdnYrAMrYXSo0Asux4LMVgTWM9Uwpjh3Wksq1twnmX1IeQ==
X-Received: by 2002:a17:906:3ac2:b0:a5a:24ab:f5e with SMTP id
 a640c23a62f3a-a62232b6411mr193243266b.25.1716394906689; 
 Wed, 22 May 2024 09:21:46 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a178923fesm1800167966b.64.2024.05.22.09.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 09:21:46 -0700 (PDT)
Message-ID: <65635268-b146-4413-a926-af13687b9e7d@linaro.org>
Date: Wed, 22 May 2024 18:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 j4g8y7@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240522101437.225880-1-robert.marko@sartura.hr>
 <20240522101437.225880-5-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240522101437.225880-5-robert.marko@sartura.hr>
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

Hi Robert,

Thanks for the patches.

On 22/05/2024 12:13, Robert Marko wrote:
> IPQ4019 ESS EDMA support is not yet in upstream Linux, and even when
> eventually it is merged the node will not be compatible with U-Boot driver
> as the Linux driver properly models the internal switch.

Is this going to cause dtc compile errors when the node eventually does 
land upstream and gets pulled into U-Boot?

How hard would it be to adjust the U-Boot driver to work with the 
upstream bindings?

Kind regards,
> 
> So, lets add the U-Boot additions DTSI for ESS EDMA for now.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   arch/arm/dts/qcom-ipq4019-u-boot.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 arch/arm/dts/qcom-ipq4019-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/qcom-ipq4019-u-boot.dtsi b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
> new file mode 100644
> index 0000000000..f70ef5c9a5
> --- /dev/null
> +++ b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/ {
> +	soc {
> +		edma: edma@c080000 {
> +			compatible = "qcom,ess-edma";
> +			reg = <0xc080000 0x8000>, <0x98000 0x800>, <0xc000000 0x80000>;
> +			reg-names = "edma", "psgmii_phy", "switch";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
> +			reset-names = "psgmii", "ess";
> +			clocks = <&gcc GCC_ESS_CLK>;
> +			clock-names = "ess";
> +			status = "disabled";
> +
> +			switch_ports: switch-ports {
> +				phy-mode = "psgmii";
> +			};
> +		};
> +	};
> +};
> +
> +&mdio {
> +	psgmiiphy: psgmii-phy@5 {
> +		reg = <5>;
> +	};
> +};

-- 
// Caleb (they/them)
