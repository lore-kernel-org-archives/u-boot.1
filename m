Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B91D21275
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 10:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE8688F57;
	Thu, 17 Oct 2024 12:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VoyHzik3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB64B88F69; Thu, 17 Oct 2024 12:45:11 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4A488D1B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 12:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a991fedbd04so47561466b.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729161907; x=1729766707; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/6qL4K1B4vobDk7ICRhow/AbLxAF8v7aMYLSrSawvAU=;
 b=VoyHzik3oOhqJvRKmuURgSVWmHgMQx22LbaIL5RX/701/E59rR/3saKv4NbMT+ebfa
 WDjdUAzSf7fdQeaeHsVAykmPr3Tj2SpOgvFNI7M96gqA8ECEhEF2nSwBZ2yKLacAdMYh
 Zjs5bNRtxtGbml/07wtkcUddHowpiXLz9/nutWUzcgvl8t61FkiEegd41jnfwA3w/NEh
 NeFdo61HijKKw9EiUe4e9QT2kHfIdqapPcBgf1Y/tUf+kMOJvbVXFeXtH9QrAXQRfp6/
 LD/dPgKcboToAvrSDfgBcKReP471N+0/swO64B62EHKD0F8idLfH98e4Szpsn6Zk0Miz
 CT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729161907; x=1729766707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/6qL4K1B4vobDk7ICRhow/AbLxAF8v7aMYLSrSawvAU=;
 b=eyKCheLiFAlsMGaNzbsvd+QnU1kk2chy2N4GdvpmUp6SnJF5uoLxhOrmPVCvNv4P9c
 CCUFleYN6372bztNOWLtIQPQCtojg9C9tMzQYcGd9S5YNyqT1x+k9wW4/ogv3xbg4OQK
 1qcEQHB+1O2PR0A2VJuoEUvjZ6E0vMZ+e6mDdZHunyM234/B/pTmpXXqi/ItOF2U9C39
 2U8mfqLjPzVO6GFc+sYNqmYNtCwYJ7QJm4gOwDaeUxNjXEWXZ7R5bw/JfRnYlw1so0p9
 p0V2qYQWldN2J2zuJnn+6caUTLst8Ig6PHpWDXoYPfA7N88A8QrnPomV6cjK8EKsYwWS
 ICDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWngfNiC4TD1rQSox7I3cwQhPlcJ0bWtoWx52E4T2Cr/1x7XM0ER9Q0EThZ35QYGXwq62GW3QQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxXTjgDRrOCG2wuBfoB791Uag2lX9nrIP//9/x5c0V0n8qzu3gj
 2Vd8xidyZ9wpg3hClOcjyRpKRt35P1o//qxcLbhWQxh7AIZfD2Gfohpb6z1PIAXlJWMUQBGtBU0
 o
X-Google-Smtp-Source: AGHT+IF0/r9IwVVTmga78KQj3S/JAQkscYZHN8AW56KTaRIrFbMMwHeFpbBXJTHmraakkoVnN26POA==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c95ac09876mr24893582a12.3.1729161907137; 
 Thu, 17 Oct 2024 03:45:07 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f97f1sm2656693a12.31.2024.10.17.03.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:45:05 -0700 (PDT)
Message-ID: <9f14f57d-3367-48b1-8a7c-f68087f52580@linaro.org>
Date: Thu, 17 Oct 2024 12:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: enable PINCONF
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241017-topic-sm8x50-enable-pinconf-v1-1-a70ddf492e87@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241017-topic-sm8x50-enable-pinconf-v1-1-a70ddf492e87@linaro.org>
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



On 17/10/2024 10:04, Neil Armstrong wrote:
> The SM8550 and SM8650 SoCs requires PINCONF to properly
> setup SDC pins in order to function correctly.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ea0dd3e58018c8bf08e4a455a47e29cf1bbd3c60..3ffc650c77191b224c7b2322fa4e1fbe1a1a97a5 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -81,6 +81,7 @@ CONFIG_PHY_QCOM_QUSB2=y
>   CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>   CONFIG_PHY_QCOM_SNPS_EUSB2=y
>   CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
>   CONFIG_PINCTRL_QCOM_APQ8016=y
>   CONFIG_PINCTRL_QCOM_APQ8096=y
>   CONFIG_PINCTRL_QCOM_QCM2290=y
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241017-topic-sm8x50-enable-pinconf-58ae8e77cd36
> 
> Best regards,

-- 
// Caleb (they/them)

