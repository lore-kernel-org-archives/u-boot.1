Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3756C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D0C88620;
	Fri, 19 Apr 2024 13:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QflftjXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55B088620; Fri, 19 Apr 2024 13:47:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2CED88684
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-418e4cd1fecso11534375e9.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713527267; x=1714132067; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6tgimpZqIRvWBzZcUbmMSli8dwmg7hG63MFE2YxVCcw=;
 b=QflftjXUk5hatNbfzxGroHpcWd/mjl9o04C4kK2LxkfcyHtbAglcTYUR5ShPuQvchA
 IdtS3R8NX6YWW0RZXVKICva1u8WYh+Lgy4pmxpk2yDt/EvGrtZ3H7huYt7XlIHwYKVc7
 GWJ41WPIKcokrOJza49y6vy3aIGbX4fKeSOBMhVWXDoMcP0FoVcyVUlvrbpjPRmV35xO
 oT1Lv9JEbvuCSwon5RRCi7F28PwdV4be25l/3um1O72HTtIZZnYfRKpNtbDGvsuiu3Y1
 XOQwExA7rxyIa3lIWHJ8UiJvRqx9+ahJho0NfzA0xYqVQVxOFztxNIr9lfiuSGUMEtIT
 a4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713527267; x=1714132067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6tgimpZqIRvWBzZcUbmMSli8dwmg7hG63MFE2YxVCcw=;
 b=BdARg36ze6aOiC9OekF9LzgL+yWHMpUS4QY0Hpj16Ydh12nq9boMufIPb0g1KjOlA0
 HPDKoUac3h0RKcBPzzrUoNzNjEX9DTUOShsWSiUkxHCfHnlTCXoghHvbHb2NPKyES6H0
 y5EKHlyHfF7vMfQYFmDzy6Gowt5y2rdLyk87cxdHLCNvCxFNnYhWQgjEzlm3SHr63E8X
 2V7iKBRCowToTT63Uh+yX2GDGhdks/Kzs7ISzxZBRFLYhINdReWRyILbwxAXUs+Wcbb3
 +Nc9AST97e3YlymBBT7hVRGFNfdOpMlSJdz+ods3147WQ3dLnrNkQCDAHom3Nq4TS1ay
 j4iw==
X-Gm-Message-State: AOJu0YxGeWIL023fcbEjroc3PjU+6oeKTSB0J+aMdNT0Ht7MJgb0XHuQ
 wMC32knGmQfcYlSQ0S65tKmvhLNbberMb6ilVxw6/VVqyD9HhID/z1YvjDB8m5xPwkXQjWB4R5Q
 Z
X-Google-Smtp-Source: AGHT+IGOoX/eKTz7KByolXm7H6d5OrMsQUgxPf3YdmEtY4/DnQSO4RacDrdEGsCQN47UJkiTejfG/Q==
X-Received: by 2002:a05:600c:4686:b0:418:201f:f991 with SMTP id
 p6-20020a05600c468600b00418201ff991mr1007652wmo.40.1713527267722; 
 Fri, 19 Apr 2024 04:47:47 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 k41-20020a05600c1ca900b00417e8be070csm6209411wms.9.2024.04.19.04.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 04:47:47 -0700 (PDT)
Message-ID: <509f508f-1154-40cf-9ea3-2c3d1addfacd@linaro.org>
Date: Fri, 19 Apr 2024 12:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: qcom_defconfig: enable GENI I2C Driver
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org>
 <20240419-topic-sm8x50-i2c-v1-2-67651e27f23a@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240419-topic-sm8x50-i2c-v1-2-67651e27f23a@linaro.org>
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

Hi Neil,

On 18/04/2024 23:47, Neil Armstrong wrote:
> Enable the GENI I2C driver in the default Qualcomm defconfig.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 1abb57345ff..8d440b23625 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -41,6 +41,7 @@ CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_QUP=y
> +CONFIG_SYS_I2C_GENI=y
>  CONFIG_I2C_MUX=y
>  CONFIG_DM_KEYBOARD=y
>  CONFIG_BUTTON_KEYBOARD=y
> 

-- 
// Caleb (they/them)
