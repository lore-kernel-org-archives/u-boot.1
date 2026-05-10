Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A0CD3427
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 20:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57396846D1;
	Sun, 10 May 2026 22:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ujL6wMLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB826846E1; Sun, 10 May 2026 22:46:56 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD43846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 22:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 609fb732-4cb1-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 609fb732-4cb1-11f1-afe2-005056994fde;
 Sun, 10 May 2026 22:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=qdU8udU0lY1v0EUkxby7anFHn725l49ZoV5M2IHclIg=;
 b=ujL6wMLM65yXC2G7GZ3ddxpGIrlA1ivlRUSzSYma9GotBvR1nZlu2nsGe3skmkLJtBkaOv0+wIBOI
 0YzZI+KwhBabWSER9a8CKANejdKM9XIZXj7znfhPyNL0XNmB2vu0AsKlunj2YL1X2JY5eWTbj0ylNt
 Utwg91JWvbwqPKNWvKBW/wxcVJSo/nHaoD8FpX8AVSoIY4ty2MEpGs/uv5R6jOb5zc7fsQQtOHyw03
 Ors9pnckEsZo1AVxTIH5UjK+i/6rQZgN6vSy31i2sfwDhvUBsXmqfKIc1qYYIsoXjcYQHXj1Jfts8F
 4+RIlmNhUdTi6ohpVBU+LQpXvwE8xMQ==
X-KPN-MID: 33|xjUYc/QimYFslD7elf30JI0hV6vWDGkW00ROoMogb18u2EAe62lZsHmrXyIbG+q
 ugY+MprIRHPH3USsG79JgXwMSjeOg8tYMnE0aZUK5x+s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+ZkKXvcPdiiXCCfvNWrbmBZ3btR8LTZS98Tu+JqgXCkMjFsPoqVyOALVJ/U66nE
 l+N1t0BgqftkXw4Sbskp5xw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 602d304e-4cb1-11f1-9c0c-00505699d6e5;
 Sun, 10 May 2026 22:46:53 +0200 (CEST)
Date: Sun, 10 May 2026 22:46:52 +0200
Message-Id: <874ikfat6r.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, trini@konsulko.com
In-Reply-To: <20260510171621.56812-1-marek.vasut+renesas@mailbox.org> (message
 from Marek Vasut on Sun, 10 May 2026 19:16:17 +0200)
Subject: Re: [PATCH] spi: apple: Staticize and constify driver ops
References: <20260510171621.56812-1-marek.vasut+renesas@mailbox.org>
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

> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Date: Sun, 10 May 2026 19:16:17 +0200
> 
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/spi/apple_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
> index 5f94e9f7a74..acb74886708 100644
> --- a/drivers/spi/apple_spi.c
> +++ b/drivers/spi/apple_spi.c
> @@ -228,7 +228,7 @@ static int apple_spi_set_mode(struct udevice *bus, uint mode)
>  	return 0;
>  }
>  
> -struct dm_spi_ops apple_spi_ops = {
> +static const struct dm_spi_ops apple_spi_ops = {
>  	.xfer = apple_spi_xfer,
>  	.set_speed = apple_spi_set_speed,
>  	.set_mode = apple_spi_set_mode,
> -- 
> 2.53.0
> 
> 
