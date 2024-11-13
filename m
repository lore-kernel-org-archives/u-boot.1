Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9819D41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 04:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D053894FE;
	Wed, 13 Nov 2024 05:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LgYLb+kZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E597289536; Wed, 13 Nov 2024 05:54:18 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D957E894E2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so57201641fa.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731473656; x=1732078456; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ypxzAmtUbxPfZBrG+Cb0KaRYQTwHXGStXJgTuYOO4E=;
 b=LgYLb+kZtIGXNpyg5/Pr127GMRT0Bd5Z0y6Jf51yriJ8mF03/1OvZpf1dz0J/Pbl0O
 bqFrR6vsQIi24TcJZ/ItG+0MELXVAwR9qfPFl3il4fWMRdif4cH9M58gm0uZzAUtia0n
 /mrABipvrUeVPEaG46fy4otx+WYmavEERsc5hNEFJF/WPu0CXQkoJXDrrXoafWubnlzs
 qpvJbNyQTCMSt3ESZus8Ak5yWVgC7wvQSep+scYXgEyIE+rB1etWBzxfFQh6s9Y5KQlu
 e0jwNdhlw+RVp4Jkfal+9Cwm1mDyElDKGMyVjlDdOLLIYOhAzeowu/JG5pDFdVVzcm+F
 GaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731473656; x=1732078456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ypxzAmtUbxPfZBrG+Cb0KaRYQTwHXGStXJgTuYOO4E=;
 b=nLEBwosaYtFeoT56my30Tk5fnWqlqmZUCo/POrHLqhWKFqsij7HyFq7GqxUe4R2dNV
 eVxA/l24WCuc2oPeyvB+d9qKLulTTLdRbxXsiIAFv537O3rid3p6dl9y4VE7uHAu44t0
 kfAkTXofjSbhT0NiDHSO2M0LhWILBK/0X/hLFI8LjqKVwJyefa1OxbLOImHjIpij3/1Z
 AH9SzGn05Ao2V3XbpKPEiPOkQW71ZzAB9b9IqeppnJU4QKNkDcuWMdV+8eHu4OkXJ1iC
 nwQJcEjdjaW4gIEpPZRvzlgYVkgiWTlkWum34xWUaS4in+n+F14XwjdL8/Js7jparL/p
 MQ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmmyE5rSeK1C4tRQfjzYTSCCVvoJbtstXM5NFptT5r6guxo47kqudPVpURGsDmHPPyDvnAt2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9PYHYbOQU7m5SsF5FVHVwA4nh6lWpQGRM7g8YuDGqpoEA101l
 biH/IYRKbakqL7rTKqv6TELQS3gH6r+dA1BYP5TZdmpx2Z9kft6uKVAsTGPagiw=
X-Google-Smtp-Source: AGHT+IH1Iftf3bRaJot+f5TDoiosNYOOl/JTxUGXMdxWm7ZGFR4qHursFzKytfVX1HuHUt3p4Pmf7w==
X-Received: by 2002:a05:651c:1994:b0:2fa:cdd1:4f16 with SMTP id
 38308e7fff4ca-2ff2014f224mr85672651fa.14.1731473656062; 
 Tue, 12 Nov 2024 20:54:16 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03bb6dd4sm6757446a12.41.2024.11.12.20.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 20:54:15 -0800 (PST)
Message-ID: <826be3de-3ee0-41cd-b6ed-63600f99fa22@linaro.org>
Date: Wed, 13 Nov 2024 05:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240714194948.1271135-1-caleb.connolly@linaro.org>
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

Just bumping this again, any reason this can't be merged?

Kind regards,

On 14/07/2024 21:49, Caleb Connolly wrote:
> We don't have audio support in U-Boot, but we do have boot menus. Add an
> option to re-map the volume and power buttons to up/down/enter so that
> in situations where these are the only available buttons (such as on
> mobile phones) it's still possible to navigate menus built in U-Boot or
> an external EFI app like GRUB or systemd-boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: u-boot-qcom@groups.io
> ---
>  drivers/button/Kconfig         | 11 +++++++++++
>  drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 3918b05ae03e..6cae16fcc8bf 100644
> --- a/drivers/button/Kconfig
> +++ b/drivers/button/Kconfig
> @@ -8,8 +8,19 @@ config BUTTON
>  	  U-Boot provides a uclass API to implement this feature. Button drivers
>  	  can provide access to board-specific buttons. Use of the device tree
>  	  for configuration is encouraged.
>  
> +config BUTTON_REMAP_PHONE_KEYS
> +	bool "Remap phone keys for navigation"
> +	depends on BUTTON
> +	help
> +	  Enable remapping of phone keys to navigation keys. This is useful for
> +	  devices with phone keys that are not used in U-Boot. The phone keys
> +	  are remapped to the following navigation keys:
> +	  - Volume up: Up
> +	  - Volume down: Down
> +	  - Power: Enter
> +
>  config BUTTON_ADC
>  	bool "Button adc"
>  	depends on BUTTON
>  	depends on ADC
> diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
> index cda243389df3..729983d58701 100644
> --- a/drivers/button/button-uclass.c
> +++ b/drivers/button/button-uclass.c
> @@ -9,8 +9,9 @@
>  
>  #include <button.h>
>  #include <dm.h>
>  #include <dm/uclass-internal.h>
> +#include <dt-bindings/input/linux-event-codes.h>
>  
>  int button_get_by_label(const char *label, struct udevice **devp)
>  {
>  	struct udevice *dev;
> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct udevice *dev)
>  
>  	return ops->get_state(dev);
>  }
>  
> +static int button_remap_phone_keys(int code)
> +{
> +	switch (code) {
> +	case KEY_VOLUMEUP:
> +		return KEY_UP;
> +	case KEY_VOLUMEDOWN:
> +		return KEY_DOWN;
> +	case KEY_POWER:
> +		return KEY_ENTER;
> +	default:
> +		return code;
> +	}
> +}
> +
>  int button_get_code(struct udevice *dev)
>  {
>  	struct button_ops *ops = button_get_ops(dev);
> +	int code;
>  
>  	if (!ops->get_code)
>  		return -ENOSYS;
>  
> -	return ops->get_code(dev);
> +	code = ops->get_code(dev);
> +	if (CONFIG_IS_ENABLED(BUTTON_REMAP_PHONE_KEYS))
> +		return button_remap_phone_keys(code);
> +	else
> +		return code;
>  }
>  
>  UCLASS_DRIVER(button) = {
>  	.id		= UCLASS_BUTTON,

-- 
// Caleb (they/them)

