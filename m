Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF26C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B577C80FDA;
	Mon, 28 Apr 2025 10:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NEilYbWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDE2820B7; Mon, 28 Apr 2025 10:51:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACBB80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so8611575a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745830261; x=1746435061; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1oIKO66VuQE/rjOFR+KWsccJllaAgBlpJx11Eou0zYM=;
 b=NEilYbWqiICRrsiZoZ05XixVQPSgqDMAqcxtC8LcrYu7C9VvurM4dJ2fbAIP4pyqDd
 X0F9pGEDxKbE3hnelgiy0v1hAH6Q6HE0AOBEkj5U77bNriAn1MvhyCIW8j/x2hlpj39q
 ERr9Dk6yqeC7vh18bP0q6u4ZyAulFVeD+F45F9+B615lx1OfYaP2iL8yj5hd27akDjF1
 y+R7v7XcnjPsMHh/TQs8EDdh8VzPvev4Jicc+26aXkmf/W+g8FfgTfBYjYhqz8sFL+n2
 txhIknK5QjDpRD5Sp6xW+8EYHIk18tAueSQ78C/Pjj/W1qlJl3Nn+sBlVLoohOWU0Ik3
 Du9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745830261; x=1746435061;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oIKO66VuQE/rjOFR+KWsccJllaAgBlpJx11Eou0zYM=;
 b=mrCSaQQNMrcVUxD8E/JUiuABAcPIktBtxH44PjZp/2wtEGQZ2DYpqtZPGxNBJZHViC
 B3YCND3WmZPIhxuK6HC9qQMT/awp96WRT/jGwu8u31IKQsdDTA8d7MnfXF3+G+9LfVVS
 DYWf/zyJwjqJA6DIamrB3reTHEKgJGG/yPaJXkys5Kw1JhWKKwk3bapQvtCUlEWsQ8pN
 98w2Ot/NNRCL/STvhV9wYrolrNKo2elhd+eJYlZOSGR0mvrL3x8y6+PgREVbU3DuMAAV
 y228fp+P5QX1+O3fT001ei3eIxMsxmSc8SIyaqgMCGMa0aZo3jp9i+dk9pUXcxkJOfeP
 1fnQ==
X-Gm-Message-State: AOJu0YxYnPpQg3QBFG7eLERojKM2fabMr/PMxckuLLAGsmNlVObLbWeg
 ZB1UJm78RCUopKEAbZgPJPJUKig1bGP70OSU7/c8M/RQrNkS1hKx260NIWK7JOx1rk8U6gsdIZk
 a
X-Gm-Gg: ASbGncv9w9UOaxMKgv2IO+lffwSm+vatkY7WMczOwhL5GbwSxQuk184ywPBzkT5cg1J
 U1Crqz2JhRDaZ9PnUmlfKiw4q5jpO1jim/U8hd2q9hsYrhDkhzurVed5ZCLgdYx9NwG/Iaoq1Vi
 UZcyZXuAYqEAQLEbZ6N6n1WlOsrXJ2AywQND214CLcv5Hfq3Y16rNPEUJLOWyR+k1pkOakUmkSL
 UYbIXxEInesnfTJ78QRCJQbi4mTf9mT2TLoN9puaL7n4xckcz3hFika1bFaMSmwNY6V0jxu9rML
 GE+sylhM0+TyGaD8S7UPpMivQkJWFcMt1N+M5QjjFnOJU8sQ
X-Google-Smtp-Source: AGHT+IEPfyLtq0fwV+URww8yuaZSgt09aTq4yC9a0872xWZM4vJ84iesy+XLj5bmN2fuPbhf7vAVbQ==
X-Received: by 2002:a17:907:3f91:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-ace73a45deemr908888566b.13.1745830261444; 
 Mon, 28 Apr 2025 01:51:01 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ed6fea9sm584206866b.127.2025.04.28.01.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 01:51:01 -0700 (PDT)
Message-ID: <5b6e4fae-2193-45ed-abd6-43e277aa439c@linaro.org>
Date: Mon, 28 Apr 2025 11:51:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ARM: dts: sam9x60: Add watchdog DT node
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
 <20250428-wdt-v3-5-86f0c5d92c32@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250428-wdt-v3-5-86f0c5d92c32@hifiphile.com>
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



On 4/28/25 11:37, Zixun LI wrote:
> Add the watchdog timer node for the sam9x60 SoC's.
> 
> A default timeout of 16s is added which is the maximum supported value,
> also matching Linux driver's behavior.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/dts/sam9x60.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 7631dfaa07fc1e7c605c70840da1196c1daeb638..588d2cb9f5109396b11a11e497eac282dffb4fb0 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -311,6 +311,15 @@
>  				clocks = <&slow_rc_osc>, <&slow_xtal>;
>  				#clock-cells = <1>;
>  			};
> +
> +			watchdog: watchdog@ffffff80 {
> +				compatible = "microchip,sam9x60-wdt";
> +				reg = <0xffffff80 0x24>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				clocks = <&clk32 0>;
> +				timeout-sec = <16>;

As the 'timeout-sec' is not in Linux, please move it to
at91-sam9x60-curiosity-u-boot.dtsi or sam9x60-u-boot.dtsi

> +				status = "disabled";
> +			};
>  		};
>  	};
>  
> 

