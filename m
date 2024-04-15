Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA20CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C6487CFC;
	Mon, 15 Apr 2024 08:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="m9IBenso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90631878ED; Mon, 15 Apr 2024 08:25:31 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7698811D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713162329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlrR/f4uVSY7YnS0RamzhU81RTHFIyfN8/CCUI6kyas=;
 b=m9IBensop4Wy44gi+hxgzXxO/91CxBE4FnfhZj1kcoB9EZoE91MosSY+4lCHfS03ZznNa0
 EdGIHNpReZwALtBR2+gmQagv9tLOGHze2vYnrKiYfOakroVYEreProCLEeIo0GGVglji8e
 gF/BA9v1bc7B7d7ebhoEA6jDbgsPTh8OSz/sHLcZ1Rdtv6YXPqV55ODuWZT5he5olUpx9S
 4rp1mF+XTWGRYAPMl+egt7RcGkxj0KjlhwhD/x1cmYYKK7+D2WNMMMCupkzCBiTLmPfrrI
 4hsMTVYpce+3D8GbcTf/SKxS7M2Haw1Cb0B+ptTP10X0QH2HbTUV+Ea1+YKf5Q==
Date: Mon, 15 Apr 2024 08:25:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/23] rockchip: rk35xx: Drop USB_GADGET_PRODUCT_NUM
 Kconfig option
In-Reply-To: <20240413181425.1384357-4-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-4-jonas@kwiboo.se>
Message-ID: <9e30f6f52cb394143da93c0335f211c5@manjaro.org>
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

On 2024-04-13 20:13, Jonas Karlman wrote:
> The commit 8c19275fdb13 ("rockchip: Update the default USB Product ID
> value") added default product id for all supported Rockchip SoCs.
> 
> Remove USB_GADGET_PRODUCT_NUM options that match default value from
> RK35xx boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: No change
> ---
>  configs/pinetab2-rk3566_defconfig   | 1 -
>  configs/rock5b-rk3588_defconfig     | 1 -
>  configs/turing-rk1-rk3588_defconfig | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/configs/pinetab2-rk3566_defconfig
> b/configs/pinetab2-rk3566_defconfig
> index bc7a77aa52fd..edeb1d89b993 100644
> --- a/configs/pinetab2-rk3566_defconfig
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -99,7 +99,6 @@ CONFIG_USB_ETHER_ASIX=y
>  CONFIG_USB_ETHER_ASIX88179=y
>  CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y
> diff --git a/configs/rock5b-rk3588_defconfig 
> b/configs/rock5b-rk3588_defconfig
> index 58c7c44fb4f7..ac4f1ebb4c13 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -102,7 +102,6 @@ CONFIG_USB_ETHER_MCS7830=y
>  CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_ETHER_SMSC95XX=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y
> diff --git a/configs/turing-rk1-rk3588_defconfig
> b/configs/turing-rk1-rk3588_defconfig
> index 07f7b848529e..e18ced721789 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -109,7 +109,6 @@ CONFIG_USB_ETHER_MCS7830=y
>  CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_ETHER_SMSC95XX=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y
