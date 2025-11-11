Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07511CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926F183B71;
	Tue, 11 Nov 2025 12:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CTmOFJkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9120683B7F; Tue, 11 Nov 2025 12:34:39 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A379183B5E
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso19044595e9.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762860877; x=1763465677; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gi5tOFkDJpVRGDaMbGLpOivJXH7igqazjQ8EuxYmQzY=;
 b=CTmOFJkduSzIKq72LA1I2HigA8E/PQdK/Dh42aMB5Gm41NKQ5xJdWEGCkC9Ssprhgu
 N8gPnzOyyfAVol0KCTuuR0eEQ09wYfn3dQ4nYbEvn4tncH1IPgaQgRNTeBh5ozcD3GXw
 He22gFjrOLyyYUzKh1x4re+jta+Vz60Qt20pq/S7a0nL17gmMRZpIAbJNVsTXukxcAJP
 y3e4mJ2xnDd6qQrHjhnFDvXfI6+3DsGO4okIGqii8PpuTok61HYVG9Zg4wZCl9ox/6bB
 fns11VcOL9XWJgfAXpFqdxPvz86ZEoNyZvclgUL1rhmlfiMmjtDf8gwhw38v6KQmelsV
 P1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762860877; x=1763465677;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gi5tOFkDJpVRGDaMbGLpOivJXH7igqazjQ8EuxYmQzY=;
 b=vz+PCQi7GZJKpiBQ50ciIGuYTSdVH25/5X+uA3fBd1swxa4QPkzCnP10EWJi1iRIIz
 GQE22qTEpvdHVuRZwG6nvYWdNw8wvwBgEl/cpsBQCNMCarVKBct+mBVNJ0QMCW2M4jHO
 q0rdxtUT7rlKx4goYj9HyBcxY0tR5ufBD2w8gaEEDq4L3eTL5gNw3xN0V4XHB5lVbgDZ
 dnI8GVfTOZ9uymYmEstX83l3tde9sWt5+we8q+LibGevgboknKCU3lL6lu4OC49j/iot
 dk74wqJSDXO8Bro6/VAKQ3TuQHttmFUwjELhaWj9r59LE74HV3PQHGs/hIlLjs0+W8Op
 F86w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX302+PPkMcSUF+YgbudKmNB6SybCyi/OsSPbfQP58zz1H40TgKPT27Ei5Rwgp1GzOk3hxYVP4=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ894uyCKkVqYEjS1Sp4HZVjpifxDAFTD4AMICcxOUzaMfycbO
 lyq9I0yOpoiwjjohF8pNUXdS4EQ/CVfGeXslvtMLWBhsc9GoxWULUlICdEQuAWDq3N0=
X-Gm-Gg: ASbGncuFUnZKWgOqe5jpz5wM/K+oalJGdQUaurIPuMGVkjrngiLOyo7WWyVW83EXB27
 SV9dDkg/bV+oUK8qz1irQZ2ASVBjk2cD5mgt8x95AXwMeag6u5GEXQuKf82wJ2l74ay69erqFGM
 BReVohB6PhIKILUL3XZDH5PyF28cBHTCubv3k+XPPal0jXnWIU+ktcb2RijcJ0Dvdd0OWguMdaj
 3DvOMqbWynA5CjVB7laxbYlJDbRFtOZiKZvtq9LWMHDqhBcERFes/IKJ05E3QCFCe1JvZiaEOQY
 vdsceIKRqvnhoPt0GAS8lfawpCKQmaHqNT04hjfyXYtVS8BuJGhdaCLIoGp1hYu6sOTe2DHf8QD
 ZM/fdi2UbrRZxbyrMYb8hPQ4sULge9xh9SghnUEFXm/AMPk6KoAT5nME6+Yf4ix6/je8sP9mqIg
 5M+xgi8IZfQCX6A6QkmWtg4IhcD3UF
X-Google-Smtp-Source: AGHT+IHFAUHHiuhR1mhOoEz8AeqdrBG5xo58PLOffLu0PIWYqy1MlkheqO5Iit7riRJnDK2kdaG2tw==
X-Received: by 2002:a05:600c:8b84:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-47773e9e1eemr96315875e9.35.1762860877117; 
 Tue, 11 Nov 2025 03:34:37 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm27804721f8f.20.2025.11.11.03.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 03:34:36 -0800 (PST)
Message-ID: <dec7e0eb-5df4-4d3e-878a-13587291ade1@linaro.org>
Date: Tue, 11 Nov 2025 13:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)
To: Alexander Dahl <ada@thorsis.com>
Cc: Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20251111112637.919074-1-ada@thorsis.com>
 <20251111112637.919074-4-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251111112637.919074-4-ada@thorsis.com>
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



On 11/11/25 13:26, Alexander Dahl wrote:
> Copied from linux kernel v6.18-rc4.  Stripped attributes not supported
> by U-Boot drivers (dma, interrupt, fifo-size).

Hello Alexander,

Have you tried to configure the build to use upstream DTS ? this should
be available in the U-boot dir. CONFIG_OF_UPSTREAM I believe.

Also, if you really want to update this u-boot DT, you would have to
copy it as-is, no stripping. Even if the props are unused. The only real
issue would be if Uboot stops working or gets confused by these extra props

Eugen>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  arch/arm/dts/sam9x60.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index a33c0d57398..1ee30422518 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -182,6 +182,16 @@
>  				ranges = <0x0 0xf801c000 0x800>;
>  				status = "disabled";
>  
> +				spi0: spi@400 {
> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> +					reg = <0x400 0x200>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> +					clock-names = "spi_clk";
> +					status = "disabled";
> +				};
> +
>  				i2c0: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;

