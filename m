Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07331EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E72589060;
	Tue, 10 Sep 2024 14:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E/TGWWsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8471589075; Tue, 10 Sep 2024 14:06:06 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0128909E
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so93031966b.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969957; x=1726574757; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dOEH9ISaCcEfCar7A+tYIOcVf3O6rsX82P9rcq/5z7c=;
 b=E/TGWWsZ8daukRX8MkC6vbYfJLTi2hDKMsI0EwkM/YBmu8Tp3v87mnJidVh4LIzteX
 xJ8cBw6QXk86WpGRK+Fh86Zprkpq74iGAdWi7LZsnWk3jtMiss10RIWdL9sl/Ar/8oE1
 2NhlejxOBxe9hKjbklV7L9I8uCRN3XOC3pXzbnROCWVrDnHA88Mb0MFMDg2cEcydqACp
 k2xLi25eI+kfybgyUXZiI9ceBsdcZ/Chq1qkCIw84pf0deNdsputq7E3SERAS3q4e2/o
 NTHK/zXhpD1mLa8BIhsSjAk4WEnyZ7YcZZnVPgAVxGABis4l3xK2YagvwAc28UoTxEZc
 Uh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969957; x=1726574757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOEH9ISaCcEfCar7A+tYIOcVf3O6rsX82P9rcq/5z7c=;
 b=SqLRIMoDrgAs6Y/v8OnjGl7NcFsBIlu8CZa9P5uPW4Mu5QEvLoHz51oMEKmR830Pa7
 +FyX0azDL/YpWuqq83OFwue8vCYQxLqKNzUd9cARqYoYRXIdJJKPFcYXLrm0e4xcU1g7
 SgewYWlY+jiuUC+WdlMUh0JkeR3hM1rTARZAdNNg/K0ZQh/sN62uYRXY2L1KxPtsH1cE
 7coeYzlkgCtBvO2wug5hLLGN0XWYRiwIgK3Ei3Ty4yJgxRHggMuDTS/B+MONYNz/1Fal
 j5jn9Ou+Wz/2S1Mdtv/CclaQJBpkR2oxTN1JRGBXKNJBLFUN203Oka0RMLjs+BVU881l
 2GMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULevBHUzI/aF0zSZGVdmJNGXO0FVu3SB61mGb//5onUrp+8KVYm06qF1Gv0AAzVEFtRTM0SsQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyA/8eRE9NUqhT1JmcKl2m96niiqRxoUNdUu/c+yMUhYFinXywQ
 5MdqXcnCNxMqRWpS3mUXUqOJFagapN3jEEiacWtNUn/fmjjj3cCUD+YoDOTGBm8=
X-Google-Smtp-Source: AGHT+IEuV/9DatbpLcBcS41cHdcSiOx9K4wyffxpf9+MdxnbDRrXcG3XGFpX1u+yWL0SoHO6AKE+0g==
X-Received: by 2002:a17:907:948e:b0:a8d:3b04:29db with SMTP id
 a640c23a62f3a-a8ffabaa2edmr46007466b.39.1725969956865; 
 Tue, 10 Sep 2024 05:05:56 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c60ef3sm470787866b.110.2024.09.10.05.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:05:56 -0700 (PDT)
Message-ID: <472e3998-7c03-432b-9e7f-f47a049ceb9c@linaro.org>
Date: Tue, 10 Sep 2024 14:05:55 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 3/3] config: qcom: add sm8150 to qcom_defconfig
Content-Language: en-US
To: Julius Lehmann <lehmanju@devpi.de>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
References: <20240909155315.307026-1-lehmanju@devpi.de>
 <20240909155315.307026-4-lehmanju@devpi.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240909155315.307026-4-lehmanju@devpi.de>
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



On 09/09/2024 17:53, Julius Lehmann wrote:
> Enable clk and pinctrl for sm8150
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> ---
> 
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 419e969e5d..03587d2dc7 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -49,6 +49,7 @@ CONFIG_CLK_QCOM_SM6115=y
>  CONFIG_CLK_QCOM_SM8250=y
>  CONFIG_CLK_QCOM_SM8550=y
>  CONFIG_CLK_QCOM_SM8650=y
> +CONFIG_CLK_QCOM_SM8150=y
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
> @@ -87,6 +88,7 @@ CONFIG_PINCTRL_QCOM_SM6115=y
>  CONFIG_PINCTRL_QCOM_SM8250=y
>  CONFIG_PINCTRL_QCOM_SM8550=y
>  CONFIG_PINCTRL_QCOM_SM8650=y
> +CONFIG_PINCTRL_QCOM_SM8150=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_DM_REGULATOR=y

-- 
// Caleb (they/them)
