Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78D8C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1E081F0D;
	Fri, 25 Apr 2025 12:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bmSdfrEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD8681F45; Fri, 25 Apr 2025 12:51:16 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B85807B1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso320033466b.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745578274; x=1746183074; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mm3dY2IonrKj+WDOeUxFmYOf/frg0MS/Q95NaX9zLfo=;
 b=bmSdfrEE+demsjQD5VH6O7pLXkjXlkiKmr4Y7RJMJGejkL11TloOuYg6oEQX/C2MLp
 1WVlGlFaR7me15kPo6Bl6Re5P4nldaDyShyyUwOQOotVKsK+PxwmG3QeWzsG8QdR6Rve
 Kgqc6q8ERYcw+pTC3WyDoyVWL2feH1b7prMp2N5di8hc13hYdoMmPRtEEpYreojUSwPW
 Tjor5R8iYK/l6PWpXIzv0T2PBPry5/QAeq7X1+ALQNS8x2eozLuVOpK91GUgEexhNX1F
 4ur4AP1OWjHwxKkY2Toc62zWkWYaFyv1mWy49dp+WN4IfIBdm+IJL2LYo07WdYN134eQ
 TfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578274; x=1746183074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mm3dY2IonrKj+WDOeUxFmYOf/frg0MS/Q95NaX9zLfo=;
 b=cT92Med6VGXF0+27BRElNu15Ec7cdLVCoe+L0QBlsIOInwGH8VovUxxvDWje9/KxMz
 FXgZm9IsU3Ie4VQ5eTHvGfvaDIFAxe3HUBsLoqmk+LiD0BBzFEpncP1VCykSsn5b8KAb
 hnLnhucYaewdpf4Y+gmR+fYNK64hg5c6cBc6xt8k7zYeJANv+8h8Z3EapQjhNRvGz0zj
 lb5+cSluMkJHh5Hm0XCcP1BF+ggg2eW4jmpcpPk3tQ2ilzjoSgbDO6dAixe40YrN8nBD
 FmmaQ9AxSGtTz7kNGHLq1jaeyT53PVEbE5thVxABYc8R1byAQEY0Mg/4lw6XS9EFP/2D
 sD0g==
X-Gm-Message-State: AOJu0YxTEwWvGV/BoOm1KHg5htbVar0/qDjW9BVA1qm3sXzWITLDO0Im
 HNlfjWJx3q/aEFqbWix3YF/NydBpv5OOwmKHc46eTVGcbGBSBM4cXCVEQq0HSGo=
X-Gm-Gg: ASbGncvCOgRQU4jwbxa3d2AYiIIAo//KZTKFWYiTHk5SuJEhYDK1X+ZX4ybMvfGMCDP
 3M77YUzKZ9HKFh6cvw0IUJCPSygo7j+BZC1mJWCgcdKn7IPLFk0HWAo2PkkdHz9SLZeMFQ89SUZ
 6a01rQRZiQGtlOtvT11KWTJpCmuWuy/3v7jxt4ba8z4TZG4TNANH+7faIoOpo7BwqqcZM0Ys2US
 QnthqkO+jM5ISkOWy/yvFVda9OAA6g6rPoHr4sAxnHxnZFpJpCPq7pIQLup/0DXBJHXJncTzvmD
 ABeKOM2HlBpSQze3Vnb8RFgZETnHtswfd0qGJIWAzta/W7GB
X-Google-Smtp-Source: AGHT+IHl1BfV+0FsmyuFrmgqSEwgPitlSsUjIOtq7xXK2I7k9gLCEjIxIHq36Qvvv8RUGnVyC025qA==
X-Received: by 2002:a17:906:9fd1:b0:ace:3a3d:7e35 with SMTP id
 a640c23a62f3a-ace713deef8mr159063966b.53.1745578273926; 
 Fri, 25 Apr 2025 03:51:13 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41bc41sm119478966b.24.2025.04.25.03.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:51:13 -0700 (PDT)
Message-ID: <119e31f2-72a8-4826-9c92-4db928a1020c@linaro.org>
Date: Fri, 25 Apr 2025 13:51:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: at91: sam9x60-curiosity: Enable watchdog
 node
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-8-49939de473e1@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250417-wdt-v2-8-49939de473e1@hifiphile.com>
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
> Enable watchdog node on SAM9X60-Curiosity board.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/dts/at91-sam9x60_curiosity.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 7f00014f13c97fe58e6ed40491f15e42512c6c8e..f70d782ff4338eff7662bb5b09b770fa1b97dd5c 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -332,3 +332,8 @@
>  &usb2 {
>  	status = "okay";
>  };
> +
> +&watchdog {
> +	status = "okay";
> +	timeout-sec = <16>;

This 'timeout-sec' property is not in Linux DT. Any reason for adding it
? is the default different in U-boot ?

> +};
> 

