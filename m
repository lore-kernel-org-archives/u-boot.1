Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3E6CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C3286ECF;
	Wed, 18 Oct 2023 09:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q79WGx+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07D586EFB; Wed, 18 Oct 2023 09:01:38 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C24086A3C
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso5617870f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697612496; x=1698217296;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+V0aFEzC/ZcdWLGs7f9Y7ppzM935kZhwQgHfebJ4TgU=;
 b=Q79WGx+WZVeVGQZX5WEeL/OjiDSAYPmarsfOegCrOZ0KAviJpJfzLiptp1NSJFVY7c
 MIFXr0hTYgtGD2NRwxP4GuajTJsgTVWRIJoRTpPWp5+Cd2VgjZL9oKyfV8laLrrngm4b
 wktFUmnyxVgyExUWidZyQnME2SbG5YzPPUJkWWMSkpVIe6K/sYiB7z7MywbxhrE15IZt
 kY/x+VSUJbpAK2m7dLIj2x2XxxuYnCZst2J/gtmR4ZIlSqMt+AvFmsv6cEOvX7rtJrdH
 0EOvIpVdr7uEF1ErY3jQcvjfeA1Jr3i23ICMNuudG9+jepp1CUUuf+01FE71lI6+5Hqr
 sW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697612496; x=1698217296;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+V0aFEzC/ZcdWLGs7f9Y7ppzM935kZhwQgHfebJ4TgU=;
 b=OQ1a7G6yh3pJf6OK9FNU6dnIKchVt5ASjjGHDh/ImyVBrz+yXaNw8xoPuecuWY+qZ/
 0xJq8OvfiYhZ2R5SdY2GVuBPZHjhzkZdL0YE0IInOhc9y5nTnm91qq47XgzuVTjpT7tU
 iOYY3JxdKVBDRwqDUKJgsNReRoRhCH9Rn+DoeMJl61OWRdhyYJhoQlfAgEJM23hyl5kr
 yQ/hJfMHUYXoKoJm4K6LRpG75MQE92TfEh4PP+3Yr3LDEyB/HKFpJNe2UpcDDYEm48bV
 L+ZkuaqTfETM6loHx8ghmaQkkbXZoj8AT+dby972lSsZDYg+DN2yYkNvrh/sKpPxfw3W
 GYsA==
X-Gm-Message-State: AOJu0YwZmBKxwIysPnDKXqp6hfrLwupUU8Cs9gtthwYXkzphTOI/99N9
 FV7eEOdT6De7lMJdSZf3wcVigA==
X-Google-Smtp-Source: AGHT+IGRkzZBJ0itPmTMElB7XA/1DiuS8rkCH8JEG4gc3KHlwZy0dZZySJA0vclFkoPYsFKHWq4PKA==
X-Received: by 2002:a5d:65ca:0:b0:314:dc0:2fca with SMTP id
 e10-20020a5d65ca000000b003140dc02fcamr3783537wrw.29.1697612496468; 
 Wed, 18 Oct 2023 00:01:36 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:253d:7bb2:1f5f:7eaa])
 by smtp.gmail.com with ESMTPSA id
 bs30-20020a056000071e00b0032d9f32b96csm1394815wrb.62.2023.10.18.00.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 00:01:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut
 <marek.vasut@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 1/3] cmd: Change the dependencies between CMD_BIND
 and USB_GADGET
In-Reply-To: <20231010090304.49335-2-miquel.raynal@bootlin.com>
References: <20231010090304.49335-1-miquel.raynal@bootlin.com>
 <20231010090304.49335-2-miquel.raynal@bootlin.com>
Date: Wed, 18 Oct 2023 09:01:35 +0200
Message-ID: <87h6mo1kj4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mar., oct. 10, 2023 at 11:03, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Today CMD_BIND defaults to 'y' when USB_ETHER is enabled. In practice,
> CMD_BIND should default to 'y' when any USB gadget is enabled not only
> USB_ETHER. Let's invert the logic of the dependency and use the weak
> 'imply' keyword to enforce this.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested that the bind command exists when building with:
configs/khadas-vim3_android_defconfig

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
>  cmd/Kconfig                | 1 -
>  drivers/usb/gadget/Kconfig | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 43ca10f69cc..6cc3bf6c2d0 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -996,7 +996,6 @@ config CMD_BCB
>  config CMD_BIND
>  	bool "bind/unbind - Bind or unbind a device to/from a driver"
>  	depends on DM
> -	default y if USB_ETHER
>  	help
>  	  Bind or unbind a device to/from a driver from the command line.
>  	  This is useful in situations where a device may be handled by several
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 1cfe6022842..44f47a07207 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -17,6 +17,7 @@ menuconfig USB_GADGET
>  	bool "USB Gadget Support"
>  	depends on DM
>  	select DM_USB
> +	imply CMD_BIND
>  	help
>  	   USB is a master/slave protocol, organized with one master
>  	   host (such as a PC) controlling up to 127 peripheral devices.
> -- 
> 2.34.1
