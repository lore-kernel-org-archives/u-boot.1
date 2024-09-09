Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94667ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0843E88972;
	Mon,  9 Sep 2024 12:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZokHLBLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFCE88995; Mon,  9 Sep 2024 12:40:41 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F4787C80
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so2476907e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725878439; x=1726483239; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2Bi1m6nhE67OtitS0aDIpkPMEpuzJU0+vwy8apsRLQ=;
 b=ZokHLBLNKT/gdmNqAbU0VkLAykm4J4EavRqe8fhz3Gw+scGsRsqc7Mwvnnh5hVWxpY
 107DhBXOXU+zwweL8jF2O4rXp707BNxh6Qf7DoUASi7gP5YL1+B/DrnCY0q+L+7bdj5n
 GzJ7r8pwsNA4Aywu0C2kygNfNxNlTWgbsAIs163BcErgEEgrVfzAofDwMOaaLPq6KJc+
 g5HY2DQCcI63Nxjturm/s8qXW22Dyh3FopJjyRBtfuE8MoA4lUkZkpKc+7VmZ8PIhm+1
 o7BkKgA6dNm9xFs1SBwDaljRca+eO0lZs1ASYUwr1z+BN8cuKImPx6zJqjZsKz3VlqN8
 kbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725878439; x=1726483239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A2Bi1m6nhE67OtitS0aDIpkPMEpuzJU0+vwy8apsRLQ=;
 b=afv6l6E5d/Snfz+oACFD7mccKq4ZWsGgZyrbGqU4RFeskVaPhTOxe/aujXIKX+7RoJ
 HDi+hQocmeuj2wDFJ3u9pfEmhyxFOnJsGYzO+9heuNYyi5tobaooK8uY2pPEsIFe2jVV
 +4dR2DcKe3pUxPU9mDc9DgNnJI44GMlbKOr9jOEs/4zNAsFHR3cpKDEgb6PWOlq4qmYl
 xSNXexosg44kemlbSlIBqnU/BtHelU+OTTQjiAOSPD30Vgoc472I6d4ml1L6i1cXL4he
 hwfn1eZKY7Ttor7d/V4qE2PfDERDgqpnjQtciqR79EH8o2iddfDw405P1ffLhLxG+jI4
 7Cww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU54rtYk8uZd0orml1Wg8Sk30D5FuxdGCEVynM/huiCMc9xh8qw6s+r3/Zgfydd7VqO/dZ2N4=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ6eBaMvZSel4vwERLgPtRwC+IxYgYENO68+/HQIbbzaB53rku
 8XVEIDEBixIBAmFK5o8mhsm45/cEt2BKXqxHi+UPWo4khSy41e/hRKQb8RlTrb4=
X-Google-Smtp-Source: AGHT+IHgtBckmKKAcoTKYEJ2XSNvoGe0L+Y/x5gcPtjX49lo2imcbz7qUtUi2oZC9oSMuFtz+U6yNA==
X-Received: by 2002:a05:6512:1191:b0:535:6935:7869 with SMTP id
 2adb3069b0e04-5365880fe89mr5377575e87.55.1725878438348; 
 Mon, 09 Sep 2024 03:40:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d63bebsm321266466b.207.2024.09.09.03.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 03:40:37 -0700 (PDT)
Message-ID: <a504b481-8e30-4f17-aced-4a9eb1ac32d1@linaro.org>
Date: Mon, 9 Sep 2024 12:40:36 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
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

Hi all,

There's been some interesting discussion around this (thanks everyone
who has chipped in).

To summarise, it seems like a more elegant solution to this problem
would be to introduce a new devicetree property "bootph,keys" (or
u-boot,keys?) to denote the keycodes which should be send when a key is
pressed in the bootloader stage, rather than the OS.

This does seem like an elegant solution, but it would also require
changing all the devicetree files for all the devices where this
matters. Considering the lack of other usecases for this, I'm not sure
if a generic solution like that is really worth it compared to what I'm
proposing here. I also don't think that accepting this patch is mutually
exclusive with implementing a "proper" generic solution later on.

Does anyone have further thoughts? Can we go ahead with this patch?

I'd be happy to re-send it, and go ahead with Quentin's suggestion to
make the funtion weak so that boards can override it (though maybe that
could be done in a future patch if there is some usecase for it).

Thanks and regards,

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
