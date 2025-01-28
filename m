Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6F1C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E977781B4B;
	Tue, 28 Jan 2025 12:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/3Zzb2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE2381D42; Tue, 28 Jan 2025 12:14:07 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5233A819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso3018213f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738062845; x=1738667645; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mclxiHHUO1N+V+pJQ99aE23vymMJa/uBwpSqjMeAfdY=;
 b=h/3Zzb2nXihsveCS96JZOv+qNyF03MCCcpxKRFr5wZLizUkHDGo4yuGaUYJt6IntR8
 DRs5AQsQzC2qStu89//XU5FIY56uSMVl9bIWyNmv8ELHYg/qES+2ArlLsN0nJcuVgQ7W
 adE+IeOmjqE2g/Cd3o0dcVbQFJw44HdJYFOd7M7cOnnw1540Qb5vP26SOKMO7OmSrIsa
 uwr9OM80zd7LRApavxhjcACl8KipTB5jlfgKNa8NG4NA9+bsEXMN6RiKT2aq4gjb3hYQ
 bg2Ia+cnxlwrGpVnRyR6dIi8cnEjg1EC5s8cehvfgaeH4+VWBdZkwslrDpyNk8VkhqGt
 Pqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738062845; x=1738667645;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mclxiHHUO1N+V+pJQ99aE23vymMJa/uBwpSqjMeAfdY=;
 b=Ix31KJphJYD8XHroI0J+e7Pgo0h2NPP1GJKH8nZvRmpO2nEUXFK511UKL8Y0M2qZov
 /ka0gjNtNdEdje80OFlfi5CqWjZhvN416ZSzQ/HKRAAjP4NpNhQ3Ax+YrwyMAF02/xFg
 s13A2zMVNC/M/FSwWAWTf6EdWOtl0bQWkFn7uoYnxKcE+UiWWvNgoiGUYsZo+x9dRPqp
 c7LxSz6AhGsJ/BwXJC0wqfpXXd3yhf7+YzR+o0QIbKS1pEyKq9a8xcmgMyIcT2ebAJaM
 0Z7i/2vrAnYKHbD0IQKbuFkc8gIPEA5+uTrCevlp3OkSgD608v2nlXBi1mZvYCe2pgt2
 H7mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQTFkLqDEsJ7iotyuir8F6w8XW+uaq6WWQrB9pt2Oycj4XI7558f0ZyF6MxjkJInxe/Lj7wjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YybV1ik2JAyJypWEVUPmQfD217iK00oIl2aVQ0BBh8nzDZ1OWDq
 4HNVCDWZ6RVQKVejXfzOhusSDqxCq/ziE2WOS2S3/xwcYilDC+PTv4qoGAD+C4g=
X-Gm-Gg: ASbGncuOgMiu8O/wS09gopQXWj/yhHgLucFluR4RsrPisNkAfh/flntvZTYXK96FRNT
 KxQa77EUo6XWnnZXoM3V/UJKLnaE1ZIoCVzw356KtvUbzeqr07YTjAxLXKHoceUZsaygVD8hBfJ
 yvRt4AeBpk5+dSowv34QG5kw52ffOqcCrtwyNpr5q30YdsHZyGgYVH1U4Zc0Czm6cf/aDHm8CHk
 2Y1XLCwMGyZAmML+iDcx9O2NRLA9UC2NIdQofnl/d3lxBa5QWECG4YOm9P+hC7uzT/w7tbdsj7s
 R13HLERH7u+wLtuFegBzZCI=
X-Google-Smtp-Source: AGHT+IGG23o1iIZOC01v2mdiemWd2rmCcDYL6+pz8LlZ3DuEmeEtRrdN1GKxQhSWF/h901TkQWwDxQ==
X-Received: by 2002:a5d:64a1:0:b0:38a:6929:ff9e with SMTP id
 ffacd0b85a97d-38bf566e3c0mr37513434f8f.7.1738062844804; 
 Tue, 28 Jan 2025 03:14:04 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18918dsm14079984f8f.57.2025.01.28.03.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 03:14:04 -0800 (PST)
Message-ID: <5d583dcd-8b76-4979-8aec-b80dbcdc47db@linaro.org>
Date: Tue, 28 Jan 2025 13:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ARM: dts: at91: sam9x60: Add AIC node
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250127100930.108377-1-manikandan.m@microchip.com>
 <20250127100930.108377-2-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250127100930.108377-2-manikandan.m@microchip.com>
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



On 1/27/25 12:09, Manikandan Muralidharan wrote:
> Add Advanced Interrupt Controller node and define it as interrupt
> parent in sam9x60 SoC DT.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/sam9x60.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 3b684fc63d5..fdc3ad0fdcb 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -17,6 +17,7 @@
>  /{
>  	model = "Microchip SAM9X60 SoC";
>  	compatible = "microchip,sam9x60";
> +	interrupt-parent = <&aic>;
>  
>  	aliases {
>  		serial0 = &dbgu;
> @@ -199,6 +200,14 @@
>  				reg = <0xffffea00 0x100>;
>  			};
>  
> +			aic: interrupt-controller@fffff100 {
> +				compatible = "microchip,sam9x60-aic";
> +				reg = <0xfffff100 0x100>;

Reg property is placed below interrupt-controller in Linux, can you make
it identical please ?

> +				#interrupt-cells = <3>;
> +				interrupt-controller;
> +				atmel,external-irqs = <31>;
> +			};
> +
>  			dbgu: serial@fffff200 {
>  				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
>  				reg = <0xfffff200 0x200>;

