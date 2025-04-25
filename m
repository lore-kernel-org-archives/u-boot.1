Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D402FC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155FD81F0D;
	Fri, 25 Apr 2025 12:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LFcPt/Rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390B481F45; Fri, 25 Apr 2025 12:46:33 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E2D807B1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so272070666b.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577990; x=1746182790; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7gc7qdbus5+D4JqN+89H3XfzPF+AHTMOK5HT/BklZsI=;
 b=LFcPt/Rp8hwKEGxm6PT9EyEcyevHXfJu0GtubGSOtIaDW9HynkermMvVR4Q9rvG+hJ
 3+nLhakoMxSnGur3ArT5CL089cXThroMvwlvxig49CIFCPCeBC0LcEU3Pdk5ZVLQo/82
 iKM8OsmwF//jZFpR2xeJezCLQbvhWgyrS0MWJW+pGIjMY1/8sWy/+xHphBfOn0OK9vWD
 4pLFRL5G4MAgxS86fQcGBsrtp/XFN7r99dmwyO0giBlih8TK2HuBxU2fs1o9lvcf5M13
 OT0l5yKdHyBaaXvtYxSjHyGl5q9vNjm0L9SmsJyvquCS/zlNdGfE/cUPHzZs5aE2dbhg
 GvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577990; x=1746182790;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gc7qdbus5+D4JqN+89H3XfzPF+AHTMOK5HT/BklZsI=;
 b=eMcoWyOYTX+en5sFxcPENECpsx0T2l/SmwaAW46wg0kGt0qXahyUVCa+3Zotpt+YOC
 /0v28/YxHA7Lg6TBjcfjtugntMXSIULufqvGb0XMGCdGwKNvruYUkS3d+m0j+qV3d8dU
 +Ou+vGHWxzoI6qxMJl2yroPa2dFeUEn7tWKHu+Vux7mUr9I6ZHetawz28XJQ06dx6ujK
 cXnrj8LMR8MvfwD+OXyuLdkLGA/65KZrN/ut/3ZjEcqk7P3rhYYx5sdfzJ9MiGnh/HOI
 lI8bkeBDAI4M1jYdqd2b3p1Y0nQZpj/5i2QNcjyQ/Lnize7dt2t7AfmeAQV12j/vgpKM
 OLhA==
X-Gm-Message-State: AOJu0YybOBlzwPUWFe7mpRIUyuHilWZ3ZAKG3Egho69dAbfZ44S1EZKc
 /CfztdOKRNsHdRFOwxPJwxmB7dSQlfTC2mLE2yF4kdFLN4dRGKKP+N/BBlsdQFQ=
X-Gm-Gg: ASbGncs2L15rjmakVUyM4ydvLDMgIhCjxsSt0RX6cEBCL7lPfHOp+5R/BqCAHI9n0/4
 dji/IMjhJTYG7sSAGI+V6LA7miYUBxEGZdZTl+qaGNIwyn6Frb42sVCoIeh5s4xqtW4iYLbsoc4
 TZnnz3S4qCUgOCWsXHgMb4GWoeh0VIuoChHIUDdQeL1x4+ILqE3WVOHlBZPQEryARhkJo3qxgVa
 Ey3y+gRTfFJvDc7D/NnNxt4YaiNV2hxLFD6tpupxGjwsORYIZekeokL9nw1QrzwceRc1O9THM1l
 Fi2y0ZVDdDWbDeyqt7QyGIIIZDuNxsvg5Ti8B8W7iHiDfQ3H
X-Google-Smtp-Source: AGHT+IFn9WlUGMDzF80DRQ3yn+/5/+C8Jd299EjACzQuvS1aHV0O8i5K303/5jpqmZsQNotUMLAo3Q==
X-Received: by 2002:a17:907:94cf:b0:ace:6d5b:e785 with SMTP id
 a640c23a62f3a-ace7136c3cemr156363266b.47.1745577990455; 
 Fri, 25 Apr 2025 03:46:30 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8c9bsm116591766b.101.2025.04.25.03.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:46:30 -0700 (PDT)
Message-ID: <a75e8917-09a0-43d2-a45a-d80f4c0e5b3c@linaro.org>
Date: Fri, 25 Apr 2025 13:46:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] ARM: dts: sam9x60: Add watchdog DT node.
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-7-49939de473e1@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250417-wdt-v2-7-49939de473e1@hifiphile.com>
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


On 4/17/25 12:09, Zixun LI wrote:
> Add the watchdog timer node for the sam9x60 SoC's.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Nitpick: no dot at the end of the subject

> ---
>  arch/arm/dts/sam9x60.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 60de9140226981003c06747e103966b696b7b700..6a5465cf31d5ab48e1205896884f41d2203b5812 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -298,6 +298,13 @@
>  				clocks = <&slow_rc_osc>, <&slow_xtal>;
>  				#clock-cells = <1>;
>  			};
> +
> +			watchdog: watchdog@ffffff80 {
> +				compatible = "microchip,sam9x60-wdt";
> +				reg = <0xffffff80 0x24>;

Can you also add the interrupt line to make it identical with Linux node?

> +				clocks = <&clk32 0>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  
> 

