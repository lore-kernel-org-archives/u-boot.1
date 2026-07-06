Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B65C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 19:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4954A846FD;
	Mon,  6 Jul 2026 21:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="l0RBpE0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B604284852; Mon,  6 Jul 2026 21:10:49 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B87F846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 21:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-44cd237446cso2121568fac.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783365046; x=1783969846; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6uey9n5rouPOWU7nv33iyubNzIxYo9qWKy/8Id/Smyw=;
 b=l0RBpE0QzQC+RXALiChJUTQYIafzP5aoEu0VsCM8nrK2A1l6bk5zBwwTbW/9LYLozi
 ENZKLMlBByVhfooJxbzfyCIOZVZe3Q7QXc4a9Apm+bIXJZa7DGZ8htTXN3DlMl0ecdLb
 35c7wtjzj0C5Kg+/9MgbQ9QnSHfnruVsS/O0H5Ay9V5zVbna3s0xdiFVAhbp22+JUIS3
 od2OFWh9GvRfFFwH9+3APXQggLzziUWG5Qtqwoo3aRnX/7srCyMxKq8kil66NiUPFAmV
 vhmLC0zewxJXuBFwmhcyTIE+EjAkF12Qa1QL/DS7j1Ew0mNnGsG6N/GWZYsL582GIH7X
 Cx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783365046; x=1783969846;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6uey9n5rouPOWU7nv33iyubNzIxYo9qWKy/8Id/Smyw=;
 b=iOIat7UJztE6R+dP1hNxKwpxmEMwf+xdvyMh3UZGAlVO4hGYeNOdecEW24dWXCGRU8
 d8ewOC4R7vzb3js6oSVMRR/NQDVlEoi7KJxuWn0iqfn0SPAEaBGfoZ3dxPJSaFh4d1xb
 593Q6vX/CoLmVQM3XQBbN5cCHw5q9jqthgcmAv8GcBJLLLDxzEW1c9pEl3P+XRJc//zl
 8Bk6SSijdai+ROuRwgRqViRaArwqMiIBGJrirYq3Dw1IYXVryZR+GoWpMv7453MD4N64
 euxWvNg7TGbpeXra/qGfN8Q3xTEuOAs/QgvjMvLUwPdzlgbAyvmmCSu0eDlu+0LFMuHZ
 PM+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMByb06V/tHGtoFYY5QDQHXUfOeTF2rxfJcrn+NjtRChrbDxKbNjfPmp+9sbiR30+wAW0H7UQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzWL/xNuguM+qV3uZQTyjGomb+Wy2Jt7b/bx4+HK5MTUwsJxkhd
 nf+l7pvJCUVu6effI887pzWI21SxjtReKHd+jePNk1817wC9qnKpo9gq04A0ctnQmCE=
X-Gm-Gg: AfdE7cnt1b89o81YEsEZbrw4bppz6wiROVy7Lwe9Rg2o3FXuskiI80PumsuDW+ILMlf
 1wQh1hS38NF9IKzxllW0CVuFXSIHZopc+1so+9s+SL2Xc9ZJL89on97wc/jykOvTzh5w69dWF+0
 JsfT0zmNcnkaSC/kerYjCykwQ99dKyvfJNNLvsqt3L5M2yw3k1PL82+8yl4NCKnAuxYHyJnxr7F
 YdwIHa8VzBn8mH5m9iQEX+N8e2jrQ78voMXdG2bf+9gzAGP0WyI22WK5HJ3QE4dM6zHb4GQPtPA
 0LFNLkgdoc17DLKHk7i4tvYhJ2/njMs3PNXRwz9fKn8yZs+7ZjcJnuqvTXGLER5rHH0Ufnd7H0u
 06/ZxUeRJ/ruV8VR1LH4/eRb29p2U5hEEuFW4/rOkfyQha1eRjC2Em0oWNqOFofy67d0zYw7hHA
 f7ZlR+aG43XeNn86N2s1qlcXvWYLe0ZZowNO+9HfRexvtkYsllBrV281nehjJjE0s=
X-Received: by 2002:a05:6870:a689:b0:44c:ebe0:f50 with SMTP id
 586e51a60fabf-45106095d67mr1200868fac.14.1783365045970; 
 Mon, 06 Jul 2026 12:10:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a38a:a0af:ed1d:5c77?
 ([2600:8803:e7e4:500:a38a:a0af:ed1d:5c77])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5569e3sm11475039fac.12.2026.07.06.12.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 12:10:44 -0700 (PDT)
Message-ID: <6014ec62-5c2e-48db-ad45-64716acad733@baylibre.com>
Date: Mon, 6 Jul 2026 14:10:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: mediatek: do not autostart the watchdog on the
 Genio EVKs
To: Carlo Caione <ccaione@baylibre.com>, Macpaul.Lin@mediatek.com,
 jstephan@baylibre.com, trini@konsulko.com, jmasson@baylibre.com,
 u-boot@lists.denx.de
References: <20260706133322.68010-1-ccaione@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260706133322.68010-1-ccaione@baylibre.com>
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

On 7/6/26 8:24 AM, Carlo Caione wrote:
> U-Boot autostarts the SoC watchdog (CONFIG_WATCHDOG_AUTOSTART default
> y) and services it from its main loop, but nothing services it after
> ExitBootServices()/bootm: an EFI-booted OS that does not take over the
> watchdog in time is reset mid-boot at a wall-clock-dependent point.
> 
> The MediaTek toprgu can count at most ~16 seconds, once firmware stops
> servicing it at the handoff, the OS has whatever is left of those 16
> seconds.
> 
> On the Genio 700 EVK the generic Ubuntu 26.04 arm64 image is hard-reset
> before its first boot reaches the login prompt: the mtk-wdt driver is
> a module loaded from the rootfs and cannot win that race. Nothing tells
> a generic OS that the watchdog is armed, so the failure is silent and,
> from the user's side, indistinguishable from broken firmware.
> 
> Disable WATCHDOG_AUTOSTART for the Genio EVK boards (mt8365_evk
> directly, mt8188.config for the Genio 510/700).
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8188.config        | 1 +
>  configs/mt8365_evk_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 

What about Genio 520/720 (mt8189.config) and Genio 1200 (mt8195.config)?
Seems like the same reasoning would apply to those.

> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index 9dfba6bf99f..26823cf35d2 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -20,6 +20,7 @@ CONFIG_PINCTRL_MT8188=y
>  CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
>  # CONFIG_RANDOM_UUID is not set
> diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
> index 1a385492547..6620f540fd4 100644
> --- a/configs/mt8365_evk_defconfig
> +++ b/configs/mt8365_evk_defconfig
> @@ -29,5 +29,6 @@ CONFIG_DM_REGULATOR_MT6357=y
>  CONFIG_BAUDRATE=921600
>  CONFIG_DM_SERIAL=y
>  CONFIG_MTK_SERIAL=y
> +# CONFIG_WATCHDOG_AUTOSTART is not set
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y

