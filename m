Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A477CD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D3D842D7;
	Sat,  2 May 2026 13:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="svuWM8Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FC7845D8; Sat,  2 May 2026 13:56:37 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08DD83642
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f7422079-461d-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f7422079-461d-11f1-bea8-005056992ed3;
 Sat, 02 May 2026 13:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=+yzeOksHfmacZBXiOyYJ9OjXQPsvxP4ZeRCz90la1fg=;
 b=svuWM8YrfGl/99ab0DVjKn821vI1dAb+O+Np3ILJwMQBKRcIzMBkGzyanZaR2lnQNSw6QSnrIHyh4
 +7+tOEMWzJ4FyCqn3a8wMdfS/y0QuPJTde+NCZJrJs8kJuqMyNAOZsrg/GMZ3ospX4aT8j5dKjDwbc
 Aea5ovLuEleZweacFEILXyjPvJJRj08BZQYYVsAGIZZ5F+QubtbvgJJfiHmHAlfiat77QLKIZF+rof
 3LFQAm88mOY256XI4UQEhvf2goAHwq2sFVtiQgqifh0Jdddq1amzPXfOjTpMc2um9MrE0r7uwyFEYc
 ngejXxOO8w9mLtZO4q4D8O386nQl/vA==
X-KPN-MID: 33|iG4fNtIEkHA7RHgXJU04pt8OpEShySbZGdnQnbNclWI4svNKELIOdpPMy9voKyz
 7J+JfthHTVgQin3+S61XbXqigQObm/LaRNXOpZnGOh/w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VvZZe0uQU9PorniU3o21EJyChuslH+SiW3eTtu87K87Y3Drp1JE6Sjx3AoHZKtJ
 MAH0GGN96I2ZfNX1sJtD4aw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f6d28e85-461d-11f1-86d8-005056998788;
 Sat, 02 May 2026 13:56:34 +0200 (CEST)
Date: Sat, 02 May 2026 13:56:33 +0200
Message-Id: <87wlxmc9e6.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, trini@konsulko.com,
 j@jannau.net
In-Reply-To: <20260430-apple-compat-pinctrl-v1-1-f214a79616a2@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:29:55 +0200)
Subject: Re: [PATCH] pinctrl: apple: Add "apple,t8103-pinctrl" compatible
References: <20260430-apple-compat-pinctrl-v1-1-f214a79616a2@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Thu, 30 Apr 2026 23:29:55 +0200
> 
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,t8103-pinctrl".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/pinctrl/pinctrl-apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
> index f373afde58e..083ea6d6cd5 100644
> --- a/drivers/pinctrl/pinctrl-apple.c
> +++ b/drivers/pinctrl/pinctrl-apple.c
> @@ -192,6 +192,7 @@ static struct pinctrl_ops apple_pinctrl_ops = {
>  };
>  
>  static const struct udevice_id apple_pinctrl_ids[] = {
> +	{ .compatible = "apple,t8103-pinctrl" },
>  	{ .compatible = "apple,pinctrl" },
>  	{ /* sentinel */ }
>  };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-pinctrl-6602a0f1ef18
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
