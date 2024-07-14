Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BBC3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 20:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B81A880F9;
	Sun, 14 Jul 2024 22:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="S3AfNJ6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8FA884F9; Sun, 14 Jul 2024 22:48:32 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52C487EFA
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 22:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1720990110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5zrBq6xtP4UYn8FWWhm8uXnn5QkfJ8FgxnY0xCmO4Q=;
 b=S3AfNJ6BF9jfRciwuyCX4ERJkcMBGZTavsCc6D3K2ZPXbbeF5T4z7qyib88h5GQe7Q/RKd
 YX1BL+GIEad7JAIeRY5f8oSvMJI5myK2Xuv9RTxRrxjCIdfGeMR3Bc0BxMSMPw016GBtzw
 Hphrk9wQCgnsytUvKPuFOvdWCgV+0IbyYQ+838r5sRqiJFQlTDIt6ydpRTTu0uOomY9Gyn
 djEtbIbzYe9k2SCuohW3lblUynEGm2FuHyLycR9rN8E36YLraioHZd3SMd0Z8sl8ydV21S
 ikwShVnId+fuBDhr+LuAun6qk7cxkP0fxGOjXgmqQznMWlEZgknD9bKQxZtKYw==
Date: Sun, 14 Jul 2024 22:47:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] dm: button: support remapping phone keys
In-Reply-To: <20240714194948.1271135-1-caleb.connolly@linaro.org>
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
Message-ID: <c8e6a53d96a89e54585bfe28a647f44f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Caleb,

On 2024-07-14 21:49, Caleb Connolly wrote:
> We don't have audio support in U-Boot, but we do have boot menus. Add 
> an
> option to re-map the volume and power buttons to up/down/enter so that
> in situations where these are the only available buttons (such as on
> mobile phones) it's still possible to navigate menus built in U-Boot or
> an external EFI app like GRUB or systemd-boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: u-boot-qcom@groups.io

Very nice, thanks for this patch!  Looking good to me, with a few
suggestions available below.  Anyway, please feel free to add:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

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
>  	  U-Boot provides a uclass API to implement this feature. Button 
> drivers
>  	  can provide access to board-specific buttons. Use of the device 
> tree
>  	  for configuration is encouraged.
> 
> +config BUTTON_REMAP_PHONE_KEYS
> +	bool "Remap phone keys for navigation"
> +	depends on BUTTON
> +	help
> +	  Enable remapping of phone keys to navigation keys. This is useful 
> for
> +	  devices with phone keys that are not used in U-Boot. The phone keys
> +	  are remapped to the following navigation keys:
> +	  - Volume up: Up
> +	  - Volume down: Down
> +	  - Power: Enter
> +

Frankly, "phone keys" sounds a bit strange to me, maybe because there
are also tablets that have the same style of reduced-set keys.  Thus,
I'd suggest that the following language is used:

- "BUTTON_REMAP_PHONE_KEYS" instead of "BUTTON_REMAP_REDUCED_KEYS"
- "reduced smartphone-style keys" instead of "phone keys"

Using "reduced" would also allow us to have this remapping logic more
easily extended to also cover some other buttons found on some other
devices with reduced-set keys.

>  config BUTTON_ADC
>  	bool "Button adc"
>  	depends on BUTTON
>  	depends on ADC
> diff --git a/drivers/button/button-uclass.c 
> b/drivers/button/button-uclass.c
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
> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct udevice 
> *dev)
> 
>  	return ops->get_state(dev);
>  }
> 
> +static int button_remap_phone_keys(int code)

Pretty much the same suggestion as above applies here.

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
