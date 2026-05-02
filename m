Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50450CD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 12:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4046845E9;
	Sat,  2 May 2026 14:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Lx38X/K6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4BE8460E; Sat,  2 May 2026 14:00:10 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D940F842D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 14:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 731164e0-461e-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 731164e0-461e-11f1-8ff3-005056999439;
 Sat, 02 May 2026 14:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=d3iyc1aq4A/j8dQX22cOs5ERbWXYZ22PumosjgTgiIU=;
 b=Lx38X/K6tM6DCsIjknimMX32XOpycpLSioiBMJcbO3J12s91yybJYdcouak2qNtg0534brTqNYfEB
 Viirn7lAkQwfPWbF0Lk9WI/7Y4/asudvkfofs12xnpB2eFUJwDmiWj4T5z1NUm78SVTqpzmRXjBzao
 0JR+X1UiOH8NY3rA0BkSugoK0pXH1Lt54mJTBQaSY0CHPhAExjinF7kAJ874mqjRTVVRFkPRxa16kd
 o7I712st53+JIc5DmbZ1QD9LimfrAtni/GBTjKQyQYhjEn6jgazMz9UQL2FxoeoN2M69LcYR9n3KzU
 BChS3Rf2dMYG72cYrCNAfzHr7WJz9Rw==
X-KPN-MID: 33|8LSem0yve9bdc5JAwmZ6izFqk7sEzRyrW0zYHjFBR2k4cbiHcwN68XPKM/iAfsB
 GqIuGgYeTU2TSGmbCeI8BFQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|S4AKpXQcCYPtESc0l3Inils7rdbvvIz8V4P/rpoW0mvBbdawa1spwu2qUMevx3k
 I6iLfMu+XvIXKUrStklMNBQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7286c463-461e-11f1-bffa-00505699772e;
 Sat, 02 May 2026 14:00:01 +0200 (CEST)
Date: Sat, 02 May 2026 14:00:00 +0200
Message-Id: <87qznuc98f.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 sjg@chromium.org, neil.armstrong@linaro.org, me@ziyao.cc,
 patrice.chotard@foss.st.com, visitorckw@gmail.com,
 kory.maincent@bootlin.com, jerome.forissier@arm.com,
 peng.fan@nxp.com, raymond.mao@riscstar.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org,
 philip.molloy@analog.com, alif.zakuan.yuslaimi@altera.com, j@jannau.net
In-Reply-To: <20260430-maintainers-apple-v1-1-43382ca4d780@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:59:36 +0200)
Subject: Re: [PATCH 1/2] MAINTAINERS: Add missing Apple M1 specific files
References: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
 <20260430-maintainers-apple-v1-1-43382ca4d780@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:59:36 +0200
> 
> The files weren't added to MAINTAINERS but clearly belong to Apple
> silicon (M1) support.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Sure!

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4b527560aa..2fc41a79dac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -132,11 +132,16 @@ S:	Maintained
>  F:	arch/arm/include/asm/arch-apple/
>  F:	arch/arm/mach-apple/
>  F:	configs/apple_m1_defconfig
> +F:	doc/board/apple/
> +F:	drivers/input/apple_spi_kbd.c
>  F:	drivers/iommu/apple_dart.c
> +F:	drivers/mailbox/apple-mbox.c
>  F:	drivers/nvme/nvme_apple.c
>  F:	drivers/pci/pcie_apple.c
>  F:	drivers/phy/phy-apple-atc.c
>  F:	drivers/pinctrl/pinctrl-apple.c
> +F:	drivers/power/domain/apple-pmgr.c
> +F:	drivers/spi/apple_spi.c
>  F:	drivers/watchdog/apple_wdt.c
>  F:	include/configs/apple.h
>  
> 
> -- 
> 2.53.0
> 
> 
