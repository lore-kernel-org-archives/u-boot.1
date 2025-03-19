Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4049DC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5E48129F;
	Wed, 19 Mar 2025 03:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q+w3lCsv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k3a0OXZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E9B8193A; Wed, 19 Mar 2025 03:35:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068B181101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZHXqz47tfz9sRx;
 Wed, 19 Mar 2025 03:35:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJDOVlBGF+Xp0FI/JgE9sZzuUf8RT2dQ30DBaiNaPZ0=;
 b=q+w3lCsvBZdifQHfSjKIdh2YHScAdK30N9Reclj31fxLUq5MJh9Sm5/3Si5umqXd+TXhsX
 uvlzwmLdw3wH0fVNEpZwOdTmo5e+MPwGRgom4ANgNgY0yKHBiEeGbbCXjUp32Av44TbQt4
 X6w9RPleyFS/hY2yKhhFQhfdSqkj4u+2AJflmdrHhPrT7YIrIoN5JM2BpkiJHuqvLCxx/V
 Au+pjN9Qi82QBlMiCNgfXYlABiJ5iiZmam7+bX7pngllBrRwO7z+3ONfBe5WCexFwuB3EK
 Va10LE1dIpEfNwTD22FNGCFL6UNpsgDrKCvhy8cCo04DplgED5uiC2qKnv0HTg==
Message-ID: <8445d45b-1084-4156-9c9c-290819a398a3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJDOVlBGF+Xp0FI/JgE9sZzuUf8RT2dQ30DBaiNaPZ0=;
 b=k3a0OXZo/XMirHHAdAzIBtaLjwoyUi5cncLVyJaSuKDfk8ihcwHWL2G0j2i5Ddk3Zcywrh
 DwOovEXtqdCLQY8DV/rPZ2fv3s3LdyEKYIkfyQC2/9lM4i4uSKcZmRVZlV8dZc98VyZyzp
 CXPbuL37XPpC6vwRxHmM/4VSVcLsOsxBmy+w+ithzr7BYGPPyc9pKqbdXyaWL/opucLlYL
 GaAC0D/OQefprBlm4BWvgUJXQ4nI8cAtKwlnEZF9GnyZiTmC8AoyRwEoT13JPOOCQRiz38
 RD80Mz0O5dEyzV11ehdIWn/NgTwS6SZUMidGgZm2be6gwqsBv7cxV+4vzevaKg==
Date: Wed, 19 Mar 2025 03:32:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
 <20250311205748.2492-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250311205748.2492-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 39c17804a8369a86c6d
X-MBO-RS-META: 6jssnfastu1aa5booxc6kob71o4mmmyo
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

On 3/11/25 9:57 PM, Paul Barker wrote:
> Add a new driver to control the USB 2.0 PHY reset controller on the
> Renesas RZ/G2L and related SoCs.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/reset/Kconfig                   |   9 ++
>   drivers/reset/Makefile                  |   1 +
>   drivers/reset/reset-rzg2l-usbphy-ctrl.c | 113 ++++++++++++++++++++++++
>   include/renesas/rzg2l-usbphy.h          |  17 ++++
>   4 files changed, 140 insertions(+)
>   create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c
>   create mode 100644 include/renesas/rzg2l-usbphy.h
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index fe5c1214f57a..80e83a40bdff 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -235,4 +235,13 @@ config RESET_AT91
>   	  This enables the Reset Controller driver support for Microchip/Atmel
>   	  SoCs. Mainly used to expose assert/deassert methods to other drivers
>   	  that require it.
> +
> +config RESET_RZG2L_USBPHY_CTRL
> +	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> +	depends on DM_RESET
> +	help
> +	  Enable support for controlling USB 2.0 PHY resets on the Renesas
> +	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on this
> +	  SoC.
> +
>   endmenu
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index d99a78c9828b..9d438a755b30 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
>   obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
>   obj-$(CONFIG_RESET_AT91) += reset-at91.o
>   obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
> +obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> new file mode 100644
> index 000000000000..afd647e00b19
> --- /dev/null
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Renesas Electronics Corporation

Maybe this should be 2025 now ?

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
