Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67991CD3423
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C954384605;
	Sat,  2 May 2026 13:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Gq73L+Mv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD458460B; Sat,  2 May 2026 13:57:13 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78E1842D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0cb338f2-461e-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0cb338f2-461e-11f1-8ff3-005056999439;
 Sat, 02 May 2026 13:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=IqWy7I/0+cX5UB3DnaaIrO55xOh4vjeVjHLH9rl6REI=;
 b=Gq73L+MvwHerY2yW2/5x7/CTA9pNcoz02J4r2PX1EHPH63ejH+wtpGRhCVq4QwD/HKFgbv/Q/cB6H
 82rHtw/MesEunGPzOsdO5UYQ3Ark8/7rEbVIb1y5ITqM+kuCLW8/bAY9EPycbT+Iz7YkBRIq5gKszm
 Hyr8AqipqhFPbOzNfDcTi4hJCsM9qvmKAzNPbJw1nikvFustdPnC5mXjc0QRe9tmS+GHytZvs77BaP
 7i13gggN6u4MM6BEsqro6NpiF3vMo5F/kd29dlyFKJgrEBjmMm0RfA/gtOKZwxfigagIoOTrNpkGl+
 wlA5JMFmu+acT9tJpf3ZD5dPSJdmoLw==
X-KPN-MID: 33|gqNKsTpGm+ZKmh4DHxWSIWuuC1XlrC0KcDOwTC/pfovN9V2eoSIsbisYaFH9l2J
 uMVeFz3MBwLQ5LRGauZ6l0PvG40cFTJ1Ql8jxcqBuzqI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bhvv/NNhk0cXZTR1DovRh/SYdJI3FsnBzz7VlSzsElpqahSKAmBVyBe8msH4/pm
 DIv1wM+hYmc18HvwAIBLYww==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0c45fd70-461e-11f1-9c0c-00505699d6e5;
 Sat, 02 May 2026 13:57:10 +0200 (CEST)
Date: Sat, 02 May 2026 13:57:09 +0200
Message-Id: <87v7d6c9d6.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, jh80.chung@samsung.com, peng.fan@nxp.com,
 trini@konsulko.com, j@jannau.net
In-Reply-To: <20260430-apple-compat-power-v1-1-0889d4334a7f@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:31:28 +0200)
Subject: Re: [PATCH] power: domain: apple: Add "apple,t8103-pmgr-pwrstate"
 compatible
References: <20260430-apple-compat-power-v1-1-0889d4334a7f@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:31:28 +0200
> 
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pmgr-pwrstate" anymore [1]. Use
> "apple,t8103-pmgr-pwrstate" as base compatible as it is the SoC driver
> and bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,pmgr-pwrstate".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/power/domain/apple-pmgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/domain/apple-pmgr.c b/drivers/power/domain/apple-pmgr.c
> index bf9940621ee..71fedb405da 100644
> --- a/drivers/power/domain/apple-pmgr.c
> +++ b/drivers/power/domain/apple-pmgr.c
> @@ -110,6 +110,7 @@ static int apple_pmgr_of_xlate(struct power_domain *power_domain,
>  }
>  
>  static const struct udevice_id apple_pmgr_ids[] = {
> +	{ .compatible = "apple,t8103-pmgr-pwrstate" },
>  	{ .compatible = "apple,pmgr-pwrstate" },
>  	{ /* sentinel */ }
>  };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-power-ac0aff6a86ec
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
