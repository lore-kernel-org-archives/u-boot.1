Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6880588089;
	Mon, 15 Apr 2024 15:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="To7BWjMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C3388158; Mon, 15 Apr 2024 15:45:23 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B84587F41
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3b307acf-fb2e-11ee-9a83-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3b307acf-fb2e-11ee-9a83-00505699b430;
 Mon, 15 Apr 2024 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=i3WmzlMMCfzRk3qHLZW1TVz1ONvMbptMvltpQwYNN9Q=;
 b=To7BWjMGRlLRql9Qv0C2cff+bkZ/QrS3XHOFbPrbGrh9e+FoB3HsPKhzIyOkwjUN25w4qyY+4K+54
 L44Xo0xfSPO+5UuXZ8NfuM3D2I5WXHFx3kf29T3H0luc/f8nrzzEoFG+XduxoG+SsQMqwq/VWQPm6I
 eWXBhWqJlSFzWeV8HI9nWZJSYGYQBRD/Pti2QUI/NjSKYLgbl/+PChdr5Cc7zJjtdGnd+JScIm810E
 aj6Twx7bDSwffPqGPZbtGxTdkWWnX5MbeLhtoDgXg36m9gPTqleZmA3a4dCZrmTQHE/uZejH4PcPeV
 pGTnWC+Aa6wpHz8Ye4fIVfavvfYNcKQ==
X-KPN-MID: 33|FsjQH1OiWUy1X4lIrzF+q232GLLj0K8BSDUw4SCTKRAVNBcFzF4SsFi7fIgVpjn
 INnkaAfosYiRagvUf5O5/cE91qaK7Vlwo7NIf35de0Oc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pY67LYVQJoIUVn/0T8gWZUhJaiZ3V6P0sbNu6K9UFVp2kxDsDdTiUtcbYug3/+D
 ho7UwicgTfFTAPrwDzbEZ9A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 65cca86a-fb2e-11ee-94ef-00505699b758;
 Mon, 15 Apr 2024 15:45:19 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:45:18 +0200
Message-Id: <878r1ehh8x.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net, marcan@marcan.st
In-Reply-To: <20240317-apple_config-v1-1-1b862bc140a9@jannau.net> (message
 from Janne Grunau via B4 Relay on Sun, 17 Mar 2024 15:54:47 +0100)
Subject: Re: [PATCH 1/4] apple_m1_defconfig: Turn on CONFIG_SYS_64BIT_LBA
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
 <20240317-apple_config-v1-1-1b862bc140a9@jannau.net>
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
> Date: Sun, 17 Mar 2024 15:54:47 +0100
> 
> From: Hector Martin <marcan@marcan.st>
> 
> This makes USB HDDs >2TiB work. The only reason this hasn't bitten us
> for the internal NVMe yet is the 4K sector size, because the largest SSD
> Apple sells is 8TB and we can handle up to 16TiB with that sector size.
> Close call.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  configs/apple_m1_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index e00d72e8be..31d966f0ab 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SYS_PBSIZE=276
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_BOARD_LATE_INIT=y
>  # CONFIG_NET is not set
> +CONFIG_SYS_64BIT_LBA=y
>  CONFIG_APPLE_SPI_KEYB=y
>  # CONFIG_MMC is not set
>  CONFIG_NVME_APPLE=y
> 
> -- 
> 2.44.0
> 
> 
> 
