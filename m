Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84151C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024BA87C39;
	Wed, 31 Jan 2024 15:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ise1BjKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4800787C68; Wed, 31 Jan 2024 15:16:06 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5805B879A2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so52990625e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706710564; x=1707315364; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8fkWTv6vAfYHXabnMelSAacYtCYVlJ7pnkZmqEvs8M=;
 b=ise1BjKc2rxd6xODXrqCKmXsfEDV6djboRx+LzTTwdrtza+BiwUwvKZmVsBmKgvKg9
 hz+lUSmsiJztDomsdqNa2n0/9pVklbIBHFAyVchpFPA+ypTSJpcFYLI2zMNl+/HJHALv
 h6B1T83rKO1LIYgU6TS2AiEjNRooFxuSyYbJzO7m57VJV3onkzDLLrNPUtYMq6H2ldTi
 vrDtf645wXuIoA7BZIegyBphMWlzG0rfCDNYuQuafGpFNuBB26LaAsrjorss32kzn4ll
 Cur02uJsjOyTlThZvaPR3FcTM5wlTPipijXnV5/F2crOh5dWvni/3tQMsJmg/JOKYJDu
 5wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710564; x=1707315364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8fkWTv6vAfYHXabnMelSAacYtCYVlJ7pnkZmqEvs8M=;
 b=l/lsRoAzx4urYn1UTVsPk8xCTaq8Qe18QLFng0lidYtsclDh47bIraLC88JkUpuzMn
 ln+HiRC8FxfGnlaAnI5LN2JHNUAe5V8SQOL4S8LaA+gSGfNgDSldBAPfkw0HZWkkJiNJ
 8jowwG3PKJJd/GqmMHAM8B6k3E1/viJDmEiz5G9p/IOFKStJqyExOXh6QAk3JIOwx+vT
 QAga4L3rr+y0vi/vEgjeyKsDs4xqi8Xd2dqykYCVcmy9iw9q3sKPOgQeRr9cHUU5yFrQ
 ppbO9G20wtqdkbFrxZFcgT2s6GvXRcsVqZUDKRZAYaM2EraEmon1mScCM9hQioXkasm5
 Jf3Q==
X-Gm-Message-State: AOJu0Yz6aVBDo2JtMRqkQN2eZ+Bia0StonpXUZuwveGEMUrahZmKrxaP
 yJw8zUhlGlhdw+dd5wUZZQlCLJ7krJ2xth+2iQ4JauyY9HZlNYO8qVqHmla4TC4=
X-Google-Smtp-Source: AGHT+IGg8Q9nnxZUHNleMff5gxzyN54iRkjTgbLd7mjI5S6v3/rQwdsvmDe86uc/1XyVnYzxTcvBlA==
X-Received: by 2002:a05:600c:4f4f:b0:40e:a421:4c5d with SMTP id
 m15-20020a05600c4f4f00b0040ea4214c5dmr1323929wmq.31.1706710563776; 
 Wed, 31 Jan 2024 06:16:03 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 fo4-20020a056000290400b0033af3294417sm7091582wrb.21.2024.01.31.06.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 06:16:03 -0800 (PST)
Message-ID: <a8566993-3da8-4cc6-8e10-0761e996e8a4@linaro.org>
Date: Wed, 31 Jan 2024 14:16:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] button: qcom-pmic: fix some error checking
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
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



On 31/01/2024 07:09, Dan Carpenter wrote:
> The pmic_reg_read() function can return errors.  Add a check for that.
> 
> Fixes: 4e8aa0065d4b ("button: qcom-pmic: introduce Qualcomm PMIC button driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch is mostly to make static checkers happy but it's obvious and
> harmless.
> 
>  drivers/button/button-qcom-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index 34a976d1e6c6..e778e51a4f36 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -86,7 +86,7 @@ static int qcom_pwrkey_probe(struct udevice *dev)
>  	}
>  
>  	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
> -	if ((ret & 0x7) == 0) {
> +	if (ret < 0 || (ret & 0x7) == 0) {
>  		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
>  		return -ENXIO;
>  	}

-- 
// Caleb (they/them)
