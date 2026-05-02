Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F8ECD3423
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 12:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8279D845E9;
	Sat,  2 May 2026 14:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="C+5TG3Ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB9784659; Sat,  2 May 2026 14:00:46 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E20842D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 14:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8c4e354e-461e-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8c4e354e-461e-11f1-bea8-005056992ed3;
 Sat, 02 May 2026 14:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=+r6HmPv14NeYUy4txGg1zIwJcktOrtDrfe/prdtQ3UQ=;
 b=C+5TG3GepvF0xuxd7IfKYloYzME+X8qOxdlePfUwY8ni0TrgC2+ry/eeNGuN3HWaR6gdDjQO49P6L
 sE71fJWX3FmZP7MNcobanU5rpZWfTCfgCrlpNmuc10Zjueb3TBwnqJDScJXrkLn6pfiA4DhSORKCoe
 f06EIgUc4ZjnKa1TGtetMuLPhcFssqwRgpC/lr7pL4P5XWZNk2Nw8Bnpn2PxeB2LVU8Dwbhvhf+LY/
 hZJ9CYGNXZReyX6gvi6u8FqwzFLaNNxPhsOI4vwc3Jkn4KAjbOXUj/cTobspFYGfcyLu7zCaKT8pw4
 MgStgE+B7vB7mmlGHhVKRK+T5T8w4qg==
X-KPN-MID: 33|/FhSpT0EPiIzrbfl4O8pHllbyMDQMQEldI2UNLuqPlSeOP4lqDMrOu1DqwY84es
 BsF3z8pbnydYvFkkcqBKeZiTbODF20cnZQ/nl8wlMN1g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HFUNJ0b18DddewyX+Z8t/LjYnZjkrWvEBbNTT6U0FZ52x2ZRGMcDrnIM/7swXfQ
 vyP6TahOFJAbisN5w9Wd16Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8bb944e0-461e-11f1-abaf-00505699b758;
 Sat, 02 May 2026 14:00:44 +0200 (CEST)
Date: Sat, 02 May 2026 14:00:43 +0200
Message-Id: <87pl3ec978.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 sjg@chromium.org, neil.armstrong@linaro.org, me@ziyao.cc,
 patrice.chotard@foss.st.com, visitorckw@gmail.com,
 kory.maincent@bootlin.com, jerome.forissier@arm.com,
 peng.fan@nxp.com, raymond.mao@riscstar.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org,
 philip.molloy@analog.com, alif.zakuan.yuslaimi@altera.com, j@jannau.net
In-Reply-To: <20260430-maintainers-apple-v1-2-43382ca4d780@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:59:37 +0200)
Subject: Re: [PATCH 2/2] MAINTAINERS: Add Janne Grunau as reviewer for Apple M1
 SoC support
References: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
 <20260430-maintainers-apple-v1-2-43382ca4d780@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:59:37 +0200
> 
> I'm one of the co-maintainers of Apple silicon support in the Linux
> kernel and have contributed to u-boot's Apple SoC support.

Your help is very much appreciated!
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fc41a79dac..5bcc8607901 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -128,6 +128,7 @@ F:	drivers/mmc/snps_dw_mmc.c
>  
>  APPLE M1 SOC SUPPORT
>  M:	Mark Kettenis <kettenis@openbsd.org>
> +R:	Janne Grunau <j@jannau.net>
>  S:	Maintained
>  F:	arch/arm/include/asm/arch-apple/
>  F:	arch/arm/mach-apple/
> 
> -- 
> 2.53.0
> 
> 
