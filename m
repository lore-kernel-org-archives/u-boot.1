Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41381C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBBB82A64;
	Fri,  9 May 2025 14:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keWcWeLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C04E8210D; Fri,  9 May 2025 13:10:14 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040EE8059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so13795255e9.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746789011; x=1747393811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHUQid3hFKlUHZSPbtMNbZX2dhowBfx3X3tcRhp5mbw=;
 b=keWcWeLaPEzHwExdmxX7xvr6vZnHkEeRyQ6mhHsH3h7T5lporpWPERzysh51OtIYWP
 ZjHECAnWQrsbijWXipWoJp6YucKs7M253PxEpEhk4AAi/xfWtI9KWp2pfbMOVVPflpRD
 Wxnz+sinNxZAwQNL2s/2XJC+KRoEHkSq68gPksX/5eVN9bAXT2+5eYqSnT5zZ1AFcr0n
 c3dwAb1J+454TG7WZKAwNHX0EKJZWR9waG+D15p2Zcr0D+I6IA9rnT3y4V8aVdfTao9J
 3g0ApsTRpIZpzFGvBEFNCnwZnPLuV4qTMyOK7sQHzAqvdriFNv7sGFjyKRgL4rEN45Y+
 AZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746789011; x=1747393811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHUQid3hFKlUHZSPbtMNbZX2dhowBfx3X3tcRhp5mbw=;
 b=TVnJt6gcz0EekzKfee8mQNCNCJ2hpw3TFZQ4gQYPibaAfmlo7BoJAM8fn70sBHbdPo
 eozcGcxpQ3vm5EJ3GaGD9qBeX4AzE8TGyxqd5va7HdL0rcMa9L8svyTOAUMnNfmlXVEA
 QeiTxXWJNGADl+7NBJ15dyq1KoQiQBbsaE+XUjB1FPNZoDCGgh3m+yhDWS1+MoJOpgTT
 ma3KXYfW49wO0cwA4tJfbP1DYAHjihIlgGZIWoA+HLQqmmGcBHJ0DORScASumq5KOUF6
 ZPke6wcGu1cJeQNtTkmpzQgNUQTRTju2iZ0wEQnfInKq9I3GyoHZgeyQppXucuV5DCNs
 hyEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUku927RWra+QyN6dBl37leSjzgDrAwKyu8CLxNv6d5w5B7uwf8pPtjp06Bj2zuenDgjjKbsJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9pX6CnNCgQrNaOlwDH3LOUizef6eGrt614tzQoG27OoGxv8RS
 +Fu3ScexaViL2mcqzySqDUtUu4LG4dknBuaG7kVQTYqKpWEySqRJAYP1XDSNcdw=
X-Gm-Gg: ASbGncukPbkyx2bKrgyaW6ZW4m/gN8aEEPvlu2PqVyMZV79F2+rfTLZz8q24AwyEFvr
 xNYPd+ocH/lPoEfzB6UOyg//aHn5rz4xboj3G3fjMPCfXkHdNgU22YuxkLo+I/YY7DIRqu5ZqUC
 2veQivSEAqZmSOk9PnL0ib+2nm6lnq7Ded/gezTLn5tiUPu9ZBBI9aA1i5xcPMnaBf+B0k3kHU9
 NkPpLALqRZuFTQwFmuVYDhsH3g/xBs8voCayzO9PU3P7NjdlFg0pFOsemnCLigqLUBb9SfECURo
 6pOZdC1KgEEsTJfVcw0YEXc9P7OH70qWnw1S5RrEU26IHNdJWhDjiiRDIVd1BiWAvjPWO58vCYb
 ZNsxTNznq5Oza7A==
X-Google-Smtp-Source: AGHT+IH0pkSp7vUzxFrDlTOuL+C4JCvZwzawNKjkII/e18rnrRB1kX2WI9ioU4qKoUJnG8oyQas11Q==
X-Received: by 2002:a05:600c:64c4:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-442d6d18bc6mr26298395e9.4.1746789011416; 
 Fri, 09 May 2025 04:10:11 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de0ddsm2882584f8f.7.2025.05.09.04.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:10:10 -0700 (PDT)
Message-ID: <20f68dca-4abd-4c33-85e9-8ac0460184cf@linaro.org>
Date: Fri, 9 May 2025 13:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-3-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-3-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 13:19, Balaji Selvanathan wrote:
> Added the memory entry to bootup.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Woof we need to get the SMEM parsing sorted...

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   arch/arm/dts/qcs8300-ride-u-boot.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/qcs8300-ride-u-boot.dtsi b/arch/arm/dts/qcs8300-ride-u-boot.dtsi
> new file mode 100644
> index 00000000000..8c353ace71e
> --- /dev/null
> +++ b/arch/arm/dts/qcs8300-ride-u-boot.dtsi
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x11a80000>,
> +		      <0x0 0xc0000000 0x0 0x10000000>,
> +		      <0x0 0xd3100000 0x0 0x26b00000>,
> +		      <0xe 0x80000000 0x1 0x00000000>,
> +		      <0xa 0x80000000 0x1 0x80000000>,
> +		      <0x0 0xb0800000 0x0 0x0f200000>,
> +		      <0x0 0xd0100000 0x0 0x01800000>,
> +		      <0x0 0x91b00000 0x0 0x1e500000>;
> +	};
> +};
> +
-- 
Casey (she/they)

