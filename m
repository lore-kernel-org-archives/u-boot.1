Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7DBCD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1B4845E9;
	Sat,  2 May 2026 13:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="O4xM+EY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1ABB8464D; Sat,  2 May 2026 13:58:45 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B9A842D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 43d11f47-461e-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 43d11f47-461e-11f1-afe2-005056994fde;
 Sat, 02 May 2026 13:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=HVLFeNrmJ0k8Mt66/3AfVEc9PQPqI13cOWC234PtEts=;
 b=O4xM+EY/jAhpn6+2K8p2mDYiUwzssFZug9Yf6NsFW2Cg5bNYF1Khv3Dv/G4JfO3dS4/0lEldyCOCw
 NOhhmDnqDD37mzPtXsiY7vj6EzZqiZDGftsVrG9HGEaZKX0PxCrHXhj8JOHJ4ajXotogBVhegDBqD6
 z/sEtT3/4Xz+BvgNM3Knx4vXUAcVimHMzi63m7dlXclZf+Bd0D+z1C03eKieXZcdp3zl7f4p+zKuNH
 3jHN9D/bZx5b7+BFQ6eP2ZML7kwdjkRpk3L5d0m9FKaKIOLxD6AJhjOVir+2RYU/SH4QgyuNBVQ9O3
 Vh5keM4ncDLkBAEFrSaNq8DdrP1YKVA==
X-KPN-MID: 33|1VNWlWFH11UQoXY56dO3rWhJ7qLiErCTMEW9Ci+C9tFRksVfzJ3yrYEhTIhurS9
 saAh1KJRNDYlnY6h2zp3Q1ncdqDHSLuxdIFPdUEQH4Dk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zdjgcbSkPf3M++1Q7Az7GyWhHVTi55zIXqGagRkLPwfWSZfRuDYiN39KipWv48A
 xeT7nHXA+b+lDEeKnr26H4g==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 435a7114-461e-11f1-9c0c-00505699d6e5;
 Sat, 02 May 2026 13:58:42 +0200 (CEST)
Date: Sat, 02 May 2026 13:58:41 +0200
Message-Id: <87se8ac9am.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org,
 stefan.roese@mailbox.org, trini@konsulko.com, j@jannau.net
In-Reply-To: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:34:43 +0200)
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
References: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:34:43 +0200
> 
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,wdt".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/watchdog/apple_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index c7307f41cb7..9e998994216 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -78,6 +78,7 @@ static const struct wdt_ops apple_wdt_ops = {
>  };
>  
>  static const struct udevice_id apple_wdt_ids[] = {
> +	{ .compatible = "apple,t8103-wdt" },
>  	{ .compatible = "apple,wdt" },
>  	{ /* sentinel */ }
>  };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-watchdog-3de8a1053b88
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
