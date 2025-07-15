Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB08C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 08:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEC582E52;
	Tue, 15 Jul 2025 10:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DtVPPRxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415AA82F00; Tue, 15 Jul 2025 10:03:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96C282CEA
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 67F7D5C59F0;
 Tue, 15 Jul 2025 08:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68051C4CEE3;
 Tue, 15 Jul 2025 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752566619;
 bh=i/4gzYDwzr0MMGa1FDJv1v6EHz4gJT1PNPCX1lNTNJA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DtVPPRxx3OKULhGEw70O0LrSc5qerS4tDYx+4kJ3pynhmKExzreWowZPJ6QG8F6qm
 HFt/GhyH8R29tl+Asg3oQ6RBKYt4PhLBxrNQChdU8+2NJ/ScCN3gA3QTqCWpKZCjET
 HiUphTitRuRcMTg+A4p5GlEyeulCndjPpBkb0F9a1YYM6thD2Qi49DuH5Wjpj1voT6
 A1/CzygZP1UQUmvmiaiXa+FivVw7kEGtixBX7mHJ7iTvxSpfMOz6sFISl6csfcOmy6
 E8luEGAumtyVQdEKM1xdtJv0IN8AsKEM9VNb+Cr9djjWVvGbgjXf7rMwhTVyWILelz
 +Z+g/jYmZqkCg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 3/6] rockchip: Add default USB_GADGET_PRODUCT_NUM for
 RK3576
In-Reply-To: <20250711222132.204344-4-jonas@kwiboo.se>
References: <20250711222132.204344-1-jonas@kwiboo.se>
 <20250711222132.204344-4-jonas@kwiboo.se>
Date: Tue, 15 Jul 2025 10:03:36 +0200
Message-ID: <871pqhnanb.fsf@kernel.org>
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

Hi Jonas,

Thank you for the patch.

On Fri, Jul 11, 2025 at 22:21, Jonas Karlman <jonas@kwiboo.se> wrote:

> Use 0x350e as the default USB Product ID for Rockchip RK3576, same PID
> being used by the BootROM when the device is in MASKROM mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> v2: New patch
> ---
>  drivers/usb/gadget/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481f..bab88567ea62 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -86,6 +86,7 @@ config USB_GADGET_PRODUCT_NUM
>  	default 0x350a if ROCKCHIP_RK3568
>  	default 0x350b if ROCKCHIP_RK3588
>  	default 0x350c if ROCKCHIP_RK3528
> +	default 0x350e if ROCKCHIP_RK3576
>  	default 0x0
>  	help
>  	  Product ID of the USB device emulated, reported to the host device.
> -- 
> 2.49.0
