Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A0FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93F788137;
	Mon, 15 Apr 2024 15:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="SkimkQUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3858814A; Mon, 15 Apr 2024 15:54:59 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91BC880FC
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 900e21ba-fb2f-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 900e21ba-fb2f-11ee-b571-005056992ed3;
 Mon, 15 Apr 2024 15:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=F7i4+D5wx6h53OXDd8u/HmMA49vGCxp0DdUuKlS4l1s=;
 b=SkimkQUkenSxuhkCuI9aZDv4tUdHpJmZCMMYdm6y4E8GTPiuhtz6NPiEYNoSxXkPaDaVpp+Ofs9cS
 x5veDODrL+nzs/4c0m+gj9BzCl6MPqoYJRb7RlheCKp+WNFXEA6rvy0BSscpKVNytxLn0eeyEoU4Vq
 3+XBqNw1UI72BxUZxunIWFtAOYoJ9k9W0UhXT/gnyISZtNKk/i9mP+0jkX+cY2EFf6tq7mU0KW7JF0
 8hDUlrQPFUlGxy4TleS9UjN6W9kKr/84Et9sXULGIXW0WZODLJkFvHrMyzuITO4enp/owNwMuOESWH
 lHis6ll5I6Z8U8wXpIo3yddy5qhafeg==
X-KPN-MID: 33|+tRlo4EicGthqpH4CNUryr5VXNf0NDb9b/wsqDgskfA954N1n87i7Va4PsTMvgB
 NQsP6Js6reUW/pr2Ncveem6YlQvjZOAoXiar2KiSp8Gk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o2Ei4hbXENIp5s5K0TSmrfkGohMFifiogRxJIHB2Qj3m5Z/+Q2wj6O+cxAt8fd5
 rm6Z2XhXjBCdR7Jq/vKxR3w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id be16545b-fb2f-11ee-9eb4-00505699772e;
 Mon, 15 Apr 2024 15:54:57 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:54:56 +0200
Message-Id: <875xwihgsv.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20240317-apple_config-v1-3-1b862bc140a9@jannau.net> (message
 from Janne Grunau via B4 Relay on Sun, 17 Mar 2024 15:54:49 +0100)
Subject: Re: [PATCH 3/4] configs: apple: Enable CMD_SELECT_FONT and FONT_16X32
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
 <20240317-apple_config-v1-3-1b862bc140a9@jannau.net>
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

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Sun, 17 Mar 2024 15:54:49 +0100
> 
> From: Janne Grunau <j@jannau.net>
> 
> Apple devices have high DPI displays so the larger fonts are preferable
> for improved readability. This does not yet change the used font based
> on the display's pixel density so the standard 8x16 font is still used
> by default.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  configs/apple_m1_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index 31d966f0ab..c30aec7c55 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -9,6 +9,7 @@ CONFIG_SYS_PBSIZE=276
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_BOARD_LATE_INIT=y
> +CONFIG_CMD_SELECT_FONT=y
>  # CONFIG_NET is not set
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_APPLE_SPI_KEYB=y
> @@ -19,6 +20,7 @@ CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_XHCI_PCI=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_KEYBOARD=y
> +CONFIG_VIDEO_FONT_16X32=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
> 
> -- 
> 2.44.0
> 
> 
> 
