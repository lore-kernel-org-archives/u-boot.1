Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F4BC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 17:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5EDE87E8E;
	Fri,  9 Feb 2024 18:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Ra639hx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BEF87E91; Fri,  9 Feb 2024 18:58:39 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368E187E8E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707501516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rho83UwFUL+hewPUk+mIfcUp1mXkpJvcmI+byvmJaOI=;
 b=Ra639hx9eIUtKxKm0b+ur5osezE54k30slNlFxzkZVerlRxAl4gMKWyjYtDNQDmn2UgOtQ
 LqEnkHGFTGx9gWk0smzOcbQ4VyCQQpQHXw74vgCHG0Rj2f506YQlcO5DmEOVHv3mhdReWl
 ptDAP3dvlxOCXtfP75gG3kDLm8g9fzQAvCYShSB7nql7H2lvc5xRdM2eBZVp43cbXDtNOp
 7yLpAEtK5tD5Egly0/vJLZki+l68Irc7J4fJq3rLGt9v55clnAGIqbP1v6pPprz+G25ttc
 XFMjQqdGfHY61jGoOYlpMON5yLYzKcianVX23LPKHjeQy2X9pcjLuWuyzX4HYQ==
Date: Fri, 09 Feb 2024 18:58:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 10/20] rockchip: transform
 rockchip_capsule_update_board_setup into a weak function symbol
In-Reply-To: <20240209-jaguar-v2-10-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-10-6c9ffe09b924@theobroma-systems.com>
Message-ID: <7c941e4f6208ac1416fb7a4dc49995e3@manjaro.org>
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

On 2024-02-09 10:50, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> There's only one user of rockchip_capsule_update_board_setup, which is
> in board.c, and only one board defines it, so instead of having a 
> header
> only for one function symbol, let's just use a weak symbol instead.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm/include/asm/arch-rockchip/misc.h | 9 ---------
>  arch/arm/mach-rockchip/board.c            | 5 ++++-
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/misc.h
> b/arch/arm/include/asm/arch-rockchip/misc.h
> deleted file mode 100644
> index ef37ff1661a..00000000000
> --- a/arch/arm/include/asm/arch-rockchip/misc.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * RK3399: Architecture common definitions
> - *
> - * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> - *      Rohan Garg <rohan.garg@collabora.com>
> - */
> -
> -void rockchip_capsule_update_board_setup(void);
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index 80b4514852f..4f666aee706 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -32,7 +32,6 @@
>  #include <asm/arch-rockchip/boot_mode.h>
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/periph.h>
> -#include <asm/arch-rockchip/misc.h>
>  #include <power/regulator.h>
> 
>  #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
> defined(CONFIG_EFI_PARTITION)
> @@ -148,6 +147,10 @@ void set_dfu_alt_info(char *interface, char 
> *devstr)
>  	env_set("dfu_alt_info", buf);
>  }
> 
> +__weak void rockchip_capsule_update_board_setup(void)
> +{
> +}
> +
>  static void gpt_capsule_update_setup(void)
>  {
>  	int p, i, ret;
