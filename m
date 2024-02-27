Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F1C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1CD87FB0;
	Tue, 27 Feb 2024 03:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wHFpb23s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE56287FB1; Tue, 27 Feb 2024 03:51:15 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FDA87FAD
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a7b68809so9231695e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709002273; x=1709607073; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8TiFmNC0JDZxhB0NmWLnu/zGJCSAGCSQQjwch25gG3w=;
 b=wHFpb23sv7mc3bil93TsUWh9fGYjVryxcuyxZ8hyDDoUKHh5zBOJwPefZin9ZXSRcP
 z/ydRi6NFGVkpiljHq4hSJYwJdqcBequkNNms+DZ0EYLbO9UEyG6xqbXMErTd59EfWsJ
 EIsOsEP8J06J2lh9zNeEXZJjzFLTYTZLet1GbSo1eJWJCmDkDUVc3EyvlweoDuLgGS2+
 OJ5itsCeCPlJYRXYVEDDf3y6YE49I+azpGoJ6pFl76S7HBtiacN+uV0TgJRwd2eimlkh
 AR35jGSbZLa1O2qFZQoQMrC+9fGbaXEJyWJViiVA7p1bJk6OiTmHixCgL6WsS8peMXFe
 7Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709002273; x=1709607073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8TiFmNC0JDZxhB0NmWLnu/zGJCSAGCSQQjwch25gG3w=;
 b=avqbNDsID5bzTeOfCrFAz+bP8WK+CZbSAD/wKPZO/A3NsCL22qPXbIemzG5fI4Bnp5
 YkekwT6XxWzkW8tL69yzc8Sn553NMJyqSbDzXzbg6hHUFKAL/LUxUVg+uhk5QXmnwjtn
 jLLE85GOFr39gNArk10OmByKCMqp/5tx/oaCHml+hpwoFlVmUqhRH4/zajt03rJrbqXT
 BmCN/GICBYMLiCzApwPpYokb+CrUin1BSEqBeKRgSNMatKAqEErnad6Mx31VGAPDJtzK
 07gXhQD39GQdfYlaGRKC8+dthMGdsnMX/iscQKjBRRJSY6pDO5GxcfK2TN3N9gMlaQVE
 0ITg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL8egEwm692FPKABtb1h8WkmnK74Hz82ZPE8DIgzMqp5wdqXzVpA+GnOqQUGh99YfddvHQn+nbfWy2bqvPRSUDwOmz0w==
X-Gm-Message-State: AOJu0YwHe7sHZOYFnSrx8KOQ8AjtPK3f7i3fXCU4Jg7c81bt+ZO7iRDa
 sqnSl9/Epjo99fZTLHI8B9HUSblSsDgtP3DdbeXpmYJMlllBBD0yGXIDV/xGCnpQFsVcpN8msFj
 a
X-Google-Smtp-Source: AGHT+IEowyXOi2wCOy0HlX4mN/MnVJGZFUT2yxvyHV+6M/v4GIhHkC0pUoLJK2lDgrMradB4nadHMA==
X-Received: by 2002:a05:600c:3596:b0:412:a6ee:f02c with SMTP id
 p22-20020a05600c359600b00412a6eef02cmr3055609wmq.41.1709002273084; 
 Mon, 26 Feb 2024 18:51:13 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a05600c3b1a00b00412a5cb5a76sm4149563wms.23.2024.02.26.18.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 18:51:12 -0800 (PST)
Message-ID: <1d0dc28a-c266-40ff-b111-c1dfbf8e2282@linaro.org>
Date: Tue, 27 Feb 2024 02:51:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] pinctrl: qcom: Add support for 'pull-down'
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-7-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-7-quic_varada@quicinc.com>
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



On 26/02/2024 10:08, Varadarajan Narayanan wrote:
> Add support for 'pull-down' needed for IPQ9574.
		'bias-pull-down'
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
>  drivers/pinctrl/qcom/pinctrl-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index dc3d8c4d90..ba53b6f290 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -37,6 +37,7 @@ static const struct pinconf_param msm_conf_params[] = {
>  	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>  	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>  	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
> +	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
>  };
>  
>  static int msm_get_functions_count(struct udevice *dev)
> @@ -104,6 +105,7 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  		clrbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>  			     TLMM_GPIO_PULL_MASK);
>  		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>  	case PIN_CONFIG_BIAS_PULL_UP:
>  		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
>  				TLMM_GPIO_PULL_MASK, argument);

-- 
// Caleb (they/them)
