Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8871BC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 10:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7519882DF;
	Tue, 18 Jun 2024 12:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X/E1Sytn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2750E882DF; Tue, 18 Jun 2024 12:34:16 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8548D8824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57c7ec8f1fcso6234594a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718706853; x=1719311653; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9HMr45hnHp60X5dLnjExrXsUVsD4HHhtH6552L6rTE=;
 b=X/E1SytnmhP3AqWriJuKM6zAtOCwE7gZbFrd41HpxxeAnx5BQR+cWRdcEhTWHbhS1x
 DxZEhRIuI80S4YJ+qiee7MsRjFAT+zp+oI9tBVfwF0ZjdUpJ8HKy4lfTQTKDJcnTLdVq
 fN6+IctPJ1GxSVC4GMZa9SwLe/eg+eHeDT0JuBWmeKbyoB4rhDl0e7xqjTlOHnavyree
 723S/nKiL9YBq2rZ1ZeyULifgPP0GUxv+cUn0qPna6MuCqvXfZIlLULJd1L65OFMSRd/
 Ko4d7IbQW+8Rixt7Ss8rLZRWHJy3g6SMV92HFT46yP0lgO1cA0EjCaDC3rGocF1TZ9h+
 kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718706853; x=1719311653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9HMr45hnHp60X5dLnjExrXsUVsD4HHhtH6552L6rTE=;
 b=wpZxrDQ34VK3R5UpZCWy4SPQgzSBp6vBoZsBNanAuayf2IcwOhqO+z6UBZMo9n9W87
 pCEUsw+GyivAkzyhK3+5VVi7RwXYyZEBSUmEp4of6Hb45Z3Nf1kQzdBxJb9QVFiRlDc3
 W9OPue791/CgHzHhP7+AsiOglrrjyB1jkipCZuZvxQWvMejBSUJUEvY0SG4cGSAk89Lg
 fi8O03U/njkKa5g5NnS7Q7m9EKQ/aNXPBuT4GIR2l8ssQezJZJiHy8JKEfBm2W0HWf1M
 FHrunxSAXQ8JOsP/oUHT2ADQ1CIpzjbYkKMuXyjeA6/yaDBB7sjN48SbT27HVVuyoZO9
 Ookg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRagTfmISP5ElrJTbPk2VQwqbbt+LXRuxSN30E1lgPiTGaAhZMwcBhFMzPigZcZTlxIi0F5p3ITuW4hVAHhbwtFmZRnQ==
X-Gm-Message-State: AOJu0YxmjKG0Ag6TolwnqItuq589G8uOvitUmEQut4C8JkrCOYUtvrsx
 hCw3jEEA2x33yh86RYGMLWDqjpz6pjTO6xmS506m7M2G7Jdx35rW4vi6FLLxsJw=
X-Google-Smtp-Source: AGHT+IENUtpVAtUQSu/9B3akif4Xu9EM1GZN+jrdkCb2PFGHiJ8ndbgj+D8YGL3Ey5vFA2bfSoiwig==
X-Received: by 2002:a50:d7c5:0:b0:57c:71a4:3142 with SMTP id
 4fb4d7f45d1cf-57cbd664b14mr8005399a12.11.1718706852757; 
 Tue, 18 Jun 2024 03:34:12 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::52af? ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cd26b423asm4302032a12.76.2024.06.18.03.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:34:12 -0700 (PDT)
Message-ID: <108cc118-0c94-4847-8e16-47cadc13efe1@linaro.org>
Date: Tue, 18 Jun 2024 12:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] usb: informative message if no controller
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
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



On 18/06/2024 11:58, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB. Use log_info().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> v3:
> 	plural controllers
> v2:
> 	add 'found' at end of message
> 	keep printf
> ---
>   drivers/usb/host/usb-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d66..e16432a1516 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -388,7 +388,7 @@ int usb_init(void)
>   
>   	/* if we were not able to find at least one working bus, bail out */
>   	if (controllers_initialized == 0)
> -		printf("No working controllers found\n");
> +		printf("No USB controllers found\n");
>   
>   	return usb_started ? 0 : -ENOENT;
>   }

-- 
// Caleb (they/them)
