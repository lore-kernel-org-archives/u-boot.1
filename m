Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8226C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261AB88929;
	Thu,  8 Aug 2024 16:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBmhuJCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E6F8893A; Thu,  8 Aug 2024 16:28:07 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7052B888D7
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7de4364ca8so126531566b.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723127277; x=1723732077; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ton6xcei4MLxgp0flrDV8v0erUzAn+pPxM6s+6IvYt4=;
 b=aBmhuJCg0NyV7GBA9iuhTfHATvbHzalPG9XEGKYbzth/UAwC+vkD3ymJiuPh1Jd1kY
 2yLuHPSLEQRPXNMTYEwc17iPM4DofnG6wRHCpQl0IueTPS28VVIm7OS+Rt/3qgZID74s
 7tAGUObN1/VSCLU6ZuvzUSHuJ0z022OvDxpGrL2xSW1DRvBej6TZG37kbLUzDSVAEKaU
 KFMEeOaUHhcemhQjKTupJtQa9WgVMtsXrcsAgJCf0I33m/ElqWA/+2q4EfOiZZg0DfFW
 jb8yH2c2bdxiVicnCJdImK0T/0OPv4AcdtWMqe7q9M9ajW3M97/71wBBEje3hqfCcEjv
 G/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127277; x=1723732077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ton6xcei4MLxgp0flrDV8v0erUzAn+pPxM6s+6IvYt4=;
 b=WJa8sZ/1eqkzojypOGvdHWu9NuOZK3byX3DkeZlFynN5GYLA0MOfLZSjjmFBQs943r
 rJfEimaf9O39kNtkx/JoW3yLBq1gKSMrR+ivux90rw8+gXYA2EbZcjP77y+5jbkmHh9W
 HhQEJpL/qxWwXryYQuncbirvWiUCpHGfC6zSc7wYW7A4SveCzSRfKe+DqksvHaTFMux/
 2lZFzJ9C+o5VmYAuAPw0K9PkHB2AnforbPniLmQuBmHkef96YgU2IcAoAu77yw9ZVQT1
 PnJOr7nKn7LFXvpsUQ1UvCU6hTouFtektmN/vznWpHV92tYFE660qxXeR940QN+wDgnH
 QdXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ZU3z3D8/4Uwm3bS4OtnAKvz/NDjjIq2B2HV4jqmdKv2FI1/4hI2uPvIcCbIGk42Vc5oMoYmwh4wsime3fHLfonxDvQ==
X-Gm-Message-State: AOJu0YxsI+AcHvheFmhdNfCROa2jlFDzYakLSRFU/Z0fViQt9QPRZnAw
 f8aBoYYkdREcDrMnOK5zJhc/62dYqEqDXC3x/NLLVZjA5NBiCG9Tczn2CBKelHYDwf9wjPyJ3IX
 k9bo=
X-Google-Smtp-Source: AGHT+IE9Qrh/5phrmookqjELPGU8rdHihoPtbVZqtdfnvo1IZK/Zj6MHfRBnLHXywdfN5rpNMGjXvw==
X-Received: by 2002:a17:907:e622:b0:a75:1069:5b94 with SMTP id
 a640c23a62f3a-a8090d79607mr163676466b.21.1723127276904; 
 Thu, 08 Aug 2024 07:27:56 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c16aa8sm748545766b.90.2024.08.08.07.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 07:27:56 -0700 (PDT)
Message-ID: <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
Date: Thu, 8 Aug 2024 16:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
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

Hi Jan,

On 08/08/2024 10:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
> for that so that targets like the IOT2050 will work again.
> 
> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index a9ba315463c..2ab41cbae45 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>   		return rc;
>   
>   	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
> -	if (rc)
> +	if (rc && rc != -ENOSYS)
>   		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>   
> -	/* Only returns an error if regulator is valid and failed to enable due to a driver issue */
> +	/* Does not return an error if regulator is invalid - but does so when DM_REGULATOR is disabled */
>   	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
> -	if (rc)
> +	if (rc && rc != -ENOSYS)

regulator_set_enable_if_allowed() will return 0 if the call to 
regulator_set_enable() returns -ENOSYS

Maybe it would make sense to have the stub implementation of 
regulator_set_enable_if_allowed() return 0?

Somewhat confusing to check for -ENOSYS here imo, since it isn't really 
obvious when that would be the case.
>   		return rc;
>   
>   	hccr = (struct xhci_hccr *)priv->gen_priv.base;

-- 
// Caleb (they/them)
