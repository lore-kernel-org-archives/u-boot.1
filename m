Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A051BC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 09:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FD7829D4;
	Sun, 13 Apr 2025 11:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ej7GXAnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F5A829E2; Sun, 13 Apr 2025 11:31:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4206A829B8
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 11:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8059=W7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744536703;
 bh=/4cI1fsFsgbz12fPaVjfmmYoLc7jWMnnjhiHi4JryEw=;
 b=ej7GXAnntkVxcHovWwgGBcA6S+vuLqmdNmh2VzvKOVhiDQywuM2R8RDMxoQYbIPftcjogSk2E
 c8/ymfp2ERkDhALl05tiejV3lZiuD+zgBKbs8LUdGIm1NS34s1evksgu5AzZaz1aRWLpxsjr3MF
 4zYP4ly6/cBvsQnBRQQLVWDndES9yb/cHMkH1rR0tIQfc+7K7EQ22yZAFnDov9z2uP3ygpNfrYl
 6edDdbfuG0XOfeiVuh8Ro/PMCkDL5i34MSaeeAhmI9IlCsavUBQmJkFWGX+dA5kW8s85N5CBqSd
 AJIGSiRZlaQxabSwx8CtWpxicIa5m6BcNA3uAfRvxWrw==
X-Forward-Email-ID: 67fb847a3367ea6d19bb5ecd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c0bad8cd-6be2-4fd4-a540-358af81c2689@kwiboo.se>
Date: Sun, 13 Apr 2025 11:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] rockchip: Add DFU to SPL
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org, ilias.apalodimas@linaro.org,
 marex@denx.de, mkorpershoek@baylibre.com, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org
References: <20250211053340.92919-1-naoki@radxa.com>
 <20250211053340.92919-3-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211053340.92919-3-naoki@radxa.com>
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

Hi,

On 2025-02-11 06:33, FUKAUMI Naoki wrote:
> Allows SPL to use DFU when SPL is booted from USB.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  arch/arm/mach-rockchip/spl-boot-order.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 3dce9b30898..2943c8bb494 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -35,6 +35,10 @@ static int spl_node_to_boot_device(int node)
>  {
>  	struct udevice *parent;
>  
> +	if (!uclass_get_device_by_of_offset(UCLASS_USB_GADGET_GENERIC,
> +					    node, &parent))
> +		return BOOT_DEVICE_DFU;

Please move this to the end of the function after the UCLASS_SPI_FLASH /
BOOT_DEVICE_SPI part. DFU boot is likely to be the least of mmc,
spi-flash and dfu being looked up.

This should probably also check for CONFIG_IS_ENABLED(DFU).

Regards,
Jonas

> +
>  	/*
>  	 * This should eventually move into the SPL code, once SPL becomes
>  	 * aware of the block-device layer.  Until then (and to avoid unneeded

