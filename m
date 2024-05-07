Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F88AC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 09:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F089288743;
	Tue,  7 May 2024 11:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jAXo9tKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D7588742; Tue,  7 May 2024 11:15:06 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B016F88746
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 11:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so30923525e9.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715073304; x=1715678104;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wXwBUud3F/3/R8n05ith/h1J+FSpbb2JAfGae8kH5uo=;
 b=jAXo9tKolXJ4CWQLI9ehjA+cEHJSCZ97KRy9xgS1McA4VIh/BbcBfPxkUd/1m53mb8
 VuMY2dVNbfb8kNBRvsK2FuoiABtZBRcIr1gjLc5MZyn4t7Hui/u309Yv63bw2TOngHjZ
 wM2Suyk35AxAHY91Fqvu6MhnDBhwz9SwPZciB9GgZCLbR/zaPGVTaE/ChfY/EJtSaOCL
 QcZlFJmhZOFlEVKwZ3j/0Om3J6zuHHvq8oayFMtbIPqZZRo33HFsICq49XeHu3MCRjgJ
 /BJzQ4uoQY3JKWlX4ZKTuYsOKgIMr5kJoUpqyrD/LgoI5X97qkoijT3fxIVGqkQZeIEm
 Fk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073304; x=1715678104;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXwBUud3F/3/R8n05ith/h1J+FSpbb2JAfGae8kH5uo=;
 b=DtDOARlqKQ9s9g7vC4dGYzVZFoH8uJW4POymarzyd/NE56IyHOEIshLV+5afnoSqfF
 krwsDlCO6JJPj41mGbfU0iLyf4+qFddU8fG2HQS96hPkIiJqKVxmJ3HLxaJOhyoE5bag
 x5j1IX08dje55EE42efLy7+RTN2cxmJW9huV9xNe5I/uXly/EvG9KBOudjmArLo+a7Cb
 gnGT3ZGpEvTx8qItBGt6Bh9k9Z+8XQCkE98Ic+t8LM32m1VNg0IEyY0kLdB1lFdTle1C
 cH5+28fEgu4BM9A+/Oir3dT5/nVPlDzPuxjG1dBfVs3npA5wKe9YuWHQAylDjWZCX9mx
 q24Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX38ISNAysqqRv7glDudjfYAqOvV0+Sq1Bcx9lFfry1817qgTyLgILpHJCiTlgGErkm66CNAMZ/iRlov+zuGkIGB/aRPA==
X-Gm-Message-State: AOJu0YwqzlYIdPKx389va/HMn772+z0rzW705/zvtuTTgbo8umhZ9qHX
 RpccavmqwG0MqQxKYxFRHGue3SspX4u5vQa0Rs/A47aJbGB7NsX2AlsRS05sqv8=
X-Google-Smtp-Source: AGHT+IGF/oWJO7OrowxrtwZrq1CH0/5SuXUy3xswDjWHURkO5GDHIFqxyfeQbkY2+E/Ks/kFY4Y38g==
X-Received: by 2002:a05:600c:19d1:b0:416:8efd:1645 with SMTP id
 u17-20020a05600c19d100b004168efd1645mr13350901wmq.7.1715073303688; 
 Tue, 07 May 2024 02:15:03 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 b20-20020a05600c4e1400b0041892857924sm18977783wmq.36.2024.05.07.02.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:15:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Martyn Welch <martyn.welch@collabora.com>, Dave Gerlach
 <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Martyn Welch
 <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 5/6] beagleplay: Add DFU support
In-Reply-To: <20240506143846.1252377-6-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-6-martyn.welch@collabora.com>
Date: Tue, 07 May 2024 11:15:00 +0200
Message-ID: <87h6fac7aj.fsf@baylibre.com>
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

Hi Martyn,

Thank you for the patch, and for taking over this series.

On lun., mai 06, 2024 at 15:38, Martyn Welch <martyn.welch@collabora.com> wrote:

> From: Sjoerd Simons <sjoerd@collabora.com>
>
> DFU mode on a beagleplay can be used via the Type-C connector by holding
> the USR switch while powering on.
>
> Configuration is already provided as fragments for both the A53 and R5
> u-boot parts. Include the am62x_a53_usbdfu.config config. The
> am62x_r5_usbdfu.config fragment needs to be added should DFU boot be
> required as this will disable booting from persistent storage due to
> binary size constraints.
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

I've tested usb gadget on Beagle Play board using fastboot.
Also tested DFU mode via snagboot.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes in v5:
> - Use existing config fragment for a53 DFU configuration
> - Force usb0 into peripheral mode
>
> Changes in v4:
> - New patch
>
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 9 +++++++++
>  board/beagle/beagleplay/beagleplay.env       | 1 +
>  configs/am62x_beagleplay_a53_defconfig       | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index fb2032068d..967a2bdcd1 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -54,6 +54,15 @@
>  	>;
>  };
>  
> +&usbss0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +	bootph-all;
> +};
> +
>  #ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
>  
>  #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index bbf6b925d0..8dbfc2f7d2 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -1,5 +1,6 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>  
>  name_kern=Image
>  console=ttyS2,115200n8
> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> index 4f1be1df59..ec62670d55 100644
> --- a/configs/am62x_beagleplay_a53_defconfig
> +++ b/configs/am62x_beagleplay_a53_defconfig
> @@ -121,3 +121,5 @@ CONFIG_EXT4_WRITE=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_LZO=y
>  CONFIG_EFI_SET_TIME=y
> +
> +#include <configs/am62x_a53_usbdfu.config>
> -- 
> 2.43.0
