Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A47C10F15
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C692588E6A;
	Wed, 24 Apr 2024 16:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KnWVqlk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662BC88E61; Wed, 24 Apr 2024 16:14:10 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD8388E57
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a58872905b5so171240166b.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968048; x=1714572848; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTBMB3HdHBLjWyHgYeU+jo1E+IKUoSnacvu6XQpUTCo=;
 b=KnWVqlk+w4q+qXlqvqMxjSKIKSTirnRY7U6WD/jh+YX9zgUsJteg5wU2zbNVW3/9wV
 PkzWic5YEMSKgdDOdnXM474XhzOHn+90KFgXWG5uoYBX1LyLy76RCr/j9ZenyMCIs9qa
 r5yzcMrrlQf8bk68z5UeFuZGjdr6e4KLK5ynfRKu5t5A4nwsZmhEiiDszzoJ0/uMQvpq
 7qwaOQUvMK5tvc3VoNgrfy0mn28ATCuLCp03lbOC5jzAv85QFmXisMAkj9SlD24Ot0qO
 qVwXSxKkMwlKTH/XXilnKhai/cTmHGHqsoZzxf0sl2/hH6sw6ux20q6pWSf6MNIMzA2l
 qqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968048; x=1714572848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yTBMB3HdHBLjWyHgYeU+jo1E+IKUoSnacvu6XQpUTCo=;
 b=lW1PeB17juGAw+Rm+Vt/WGb/mdFWGKKOKFLHG3HFwHmdVsIORJySRdso5oIjgvUDT+
 hNhDMYYSYo9/yjq2UTkpjtlILebU3g7/mTl+Cm8uDic+mfeWao3YECE2go+Otm3SqNuM
 p2pnT+TDKuUtxBLIIuOu6gKmyJ4OzZeUPgDHsW4EoIRq9XTap25KJmtpVHO0fsYIVRGv
 376a5i48IF7mxdConNjL9bOCtDDMlQ3GTPpFPiIICbEjxQxCbXc3BkjYfkjUSoQqD3mK
 bSf7j7kv4BfYnOIY2X+zBpXWC7C7XBsvs3nxa6ETi6rG7x15ghWGwl3iyofO1K0nHvvp
 kifQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzm2hCar1qThhyTiXQcStozXv8vSRP6T0ng6100FyqeWlmr0K5jA2efrWY926fw1hTlZRJphHVY79iQejmFPa6BopnvA==
X-Gm-Message-State: AOJu0Ywf8HbwMBXvNUssREryse7VQHr4P859AfCPEouoHhWggUvbk+KG
 XgeInEc2QuKVmuIn9L7r6SmGuu/hDs9UrEonBJOawTk7yP9fSA6XxvlkhuwYsNs=
X-Google-Smtp-Source: AGHT+IE2MRuvPAfdZo3fo9A2c3Jeog/JY5iv2IUrcf+5oPNX43ZHjNSwWTZJsn9f6PVl7E/P8lnwXA==
X-Received: by 2002:a17:906:c141:b0:a58:934b:a051 with SMTP id
 dp1-20020a170906c14100b00a58934ba051mr1503224ejc.39.1713968048101; 
 Wed, 24 Apr 2024 07:14:08 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4c3a? ([2a02:8109:aa0d:be00::4c3a])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a1709064f0400b00a58a4e08893sm16321eju.104.2024.04.24.07.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 07:14:07 -0700 (PDT)
Message-ID: <94b98ef2-b84f-4bbc-bc41-9e68d83d2a8b@linaro.org>
Date: Wed, 24 Apr 2024 16:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mach-ipq40xx: use OF_UPSTREAM
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: j.beck@linefinity.com
References: <20240424111434.373920-1-robert.marko@sartura.hr>
 <20240424111434.373920-2-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240424111434.373920-2-robert.marko@sartura.hr>
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



On 24/04/2024 13:13, Robert Marko wrote:
> Now that drivers are compatible enough with the upstream DTS, there is no
> reason to not use the upstream DTS, so imply OF_UPSTREAM by default.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 93e12d8d53..5c2769b59d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -768,6 +768,7 @@ config ARCH_IPQ40XX
>   	select CLK_QCOM_IPQ4019
>   	select PINCTRL_QCOM_IPQ4019
>   	imply CMD_DM
> +	imply OF_UPSTREAM
>   
>   config ARCH_KEYSTONE
>   	bool "TI Keystone"

-- 
// Caleb (they/them)
