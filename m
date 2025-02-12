Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1092C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED1280079;
	Wed, 12 Feb 2025 17:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T90bbMvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD261809D0; Wed, 12 Feb 2025 17:17:43 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9074380077
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5de6c708315so6582823a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739377061; x=1739981861; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ljrw6NWPnoZqyDUvzMz1IQ5L1VyJSKJSiZ3huY2c+HA=;
 b=T90bbMvEWXxvRqK4ym4tSKHqGfmqmRohp4MOLyNilMP/Rby0mSbfT4E8B63sRW0A/o
 W3YtcjXjWJ9K7GiuWZEGASGl4dvur2gplXpbKINTMBZPND7oXxVvGwQ47/3LLAlGOgDA
 Js9BI6vY2FHj4a+KbC9gqSpDT8hoElXO4TJc3L4u91L074X7NLoTBG1lTuCTCa2P6P2/
 BquDZXe4Pmy3nsVuS98/MKnaT70rj4mJILPBHczI49Y+ku2MGeQK9GRLtD2I3wl0Orzd
 ONdRBVE+nG+ewYgA1XIJjRpUcXCP1UiCnCVlwZ5r+PQM8XEPACYEb8N8TUdq3FDs3zdI
 9IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377061; x=1739981861;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljrw6NWPnoZqyDUvzMz1IQ5L1VyJSKJSiZ3huY2c+HA=;
 b=BG6Xsh3K5v1iX8LewVR864q0ROPSXOem1Sd8e2gYdGAXuDh7SIEHi+nyKUK/ujVz5y
 oMVZVGXouws7o6z9JSANvBXP4nzMcbBqt4CJdeAPmpmKB3BdkQL2/072q5H+W1u7D4Tl
 ASDtOMQkCZqCP1SOd55583DjnM/mVnnkXbzB4S6HZRDMQiO2ct2pW2qdFT+vY7MGEjc/
 i/bTs+CeG9FFGW51eUdEr+BzyQbBtYbvSNsKR+t/HZamwJaFOhJlMa6WpUWC7IPxE821
 v8yMJmGYo+Zwu7RSQmmHJpeK3xwqwdmSvZ0+1/OHf9ykARdl+HyedoJWZvbfdOH90u55
 ylRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaFkHNLiPujy5wYMiGyVCjyfTtqQRxETD8oK43KPHmqAbON0txIZH2VDRJHdBv0xaVZhs7WdU=@lists.denx.de
X-Gm-Message-State: AOJu0YxlT0kWJfAG1iY/iPFpUIqECxeGBm70mhax2sNVglSxa1sodvzK
 IGZ/8gRlal72VDqpdTtwrQRb/hGXaDyWzryQzE0WY9G8fwGfUbaAzwFexZJ7ggbcXgRxr8y3NQO
 y6y8=
X-Gm-Gg: ASbGncuigvgRUOVP6mlhUTnZ6LOar4ElCxKqhkOLD4kONIDxZyDpY4OwTtMyI2cHvgG
 dUueKz07NDopk/smjNTB8Z2zDiMlSBn5hMpWwlwIkeRIyunX+rQPAvUjz5rB0qy369uUG71Z2Tg
 0i2nQvDjpquECHfAU2yBLtiRgJsQJsz3qzU+v3dJkU4ECLptGiz/tCqUYNkdCWVu9gSO/cNXEtJ
 7GCtwGU5QnMsVj1/2crHhhE10najFzaK95WJk8W5S4ONFEOHkYkVTf8NbTsMBoAdaXY375aB0wr
 9db2IvPcLc/R1TdwurOBJYo=
X-Google-Smtp-Source: AGHT+IF4MRLrqOdUOZ0ulxWCev23P/sBq3siUqOxR5n3xx/wzp6dso8s/42PVYGVwKgN1JfXp/Yabg==
X-Received: by 2002:a05:6402:4612:b0:5d0:b925:a8a with SMTP id
 4fb4d7f45d1cf-5deaddb57e2mr3260893a12.16.1739377060980; 
 Wed, 12 Feb 2025 08:17:40 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de63a89b6asm7932814a12.46.2025.02.12.08.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:17:40 -0800 (PST)
Message-ID: <b9b770fd-27ef-4996-ba67-d1120b6c84bd@linaro.org>
Date: Wed, 12 Feb 2025 18:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Align pio3 pinctrl node with Linux
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
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



On 2/10/25 08:51, Manikandan Muralidharan wrote:
> The series adds support in the pinctrl driver and additional
> changes in the at91 DT to align the pio3 based pinctrl nodes
> in the u-boot DT with that of Linux
> 
> Changes in v3:
> - 5/7 - Add comment block to describe at91_pinctrl_bind()
> 
> 
> Changes in v2:
> - 1/7 - Align the properties of AIC node with that of Linux
> - 2/7 - cosmetic fix
>       - Align and arrange the pinmux child node as per Mainline Linux
> - 4/7 - Modify the pinctrl node compatible property
> 
> Balamanikandan Gunasundar (1):
>   ARM: dts: at91: sam9x60: Define pinctrl node with its label
> 
> Manikandan Muralidharan (6):
>   ARM: dts: at91: sam9x60: Add AIC node
>   ARM: dts: at91: sam9x60: Move pinmux node to board DTS
>   ARM: dts: at91: sam9x60: Add missing pinctrl node properties
>   pinctrl: at91: Bind GPIO driver to the pinctrl DT node
>   pinctrl: at91: Add support to align with Linux Devicetree
>   ARM: dts: at91: Align pinctrl node with Linux Devicetree
> 
>  arch/arm/dts/at91-sam9x60_curiosity.dts |  71 ++++++++
>  arch/arm/dts/at91sam9260.dtsi           |  76 ++++-----
>  arch/arm/dts/at91sam9261.dtsi           |  77 ++++-----
>  arch/arm/dts/at91sam9263.dtsi           | 117 ++++++-------
>  arch/arm/dts/at91sam9g45.dtsi           | 106 ++++++------
>  arch/arm/dts/at91sam9n12.dtsi           |  93 +++++------
>  arch/arm/dts/at91sam9rl.dtsi            |  93 +++++------
>  arch/arm/dts/at91sam9x5.dtsi            |  90 +++++-----
>  arch/arm/dts/sam9x60.dtsi               | 151 +++++++----------
>  arch/arm/dts/sam9x60ek.dts              | 213 ++++++++++++++++--------
>  arch/arm/dts/sama5d3.dtsi               | 116 ++++++-------
>  arch/arm/dts/sama5d4.dtsi               | 118 +++++++------
>  drivers/pinctrl/pinctrl-at91.c          |  52 +++++-
>  13 files changed, 738 insertions(+), 635 deletions(-)
> 

Applied to u-boot-at91/next !
Thanks
