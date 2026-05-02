Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8099BCD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C1B845E9;
	Sat,  2 May 2026 13:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="EFJ/Vdo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B2384605; Sat,  2 May 2026 13:58:06 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FED6842D7
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2c02bc55-461e-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2c02bc55-461e-11f1-8ff3-005056999439;
 Sat, 02 May 2026 13:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=IYKJM9KXdijMOM38ol2FLgUlcIJujLDZaZdluLGfwNo=;
 b=EFJ/Vdo3D1cgy69mPADokEwox2M4anmbTSQ4SGkWSGoyzOA3BTw/rU4Yi6l/7SjqxBWIM3whD88Ed
 fZBibVowZmlUUwuB0va5sOj9ew0KBxfmQi4JRiyxQ0tz0DCZiXwNLmUqx+lmAQBpY0IiZVBHQsEJXa
 K3JdmFY8njmhQ3Ctn1ltJnvWUgxxYLTmXeWEnnuALAdf0O98Ig8+/VAQusC3uyt2fk4gbRuOfpchL5
 DdZHlar0XZAUh9YLN0/fihx+UrlzhmD4JlTZKYmLWD8tT1kLJJgCtjLXcC5p0ervH4mRWd58crfFd1
 hkRqJRwyTS4dYqWA/AQbtezubxjcnig==
X-KPN-MID: 33|Rid8x99CqXRlvuvCMQ+aKa8kxxfUtpwo+yHLrlccnQOHw9UxyPVKImWjxXoiuuy
 MwMMTPrenRXgRn6p0yl7zT58TkMg1a1qJfjS6Tr9K7vk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|t1Lq5qYnaXNNevihEV2qlh82Wq3WFbsV5+hgogrYoFRzmL36Nx++n1eG1l3P/Rr
 TybTbOqghz9NLxgbbLyRpEg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 2b689a04-461e-11f1-86d8-005056998788;
 Sat, 02 May 2026 13:58:02 +0200 (CEST)
Date: Sat, 02 May 2026 13:58:01 +0200
Message-Id: <87tssqc9bq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 j@jannau.net
In-Reply-To: <20260430-apple-compat-spi-v1-1-6fb3a6fc499c@jannau.net> (message
 from Janne Grunau on Thu, 30 Apr 2026 23:33:25 +0200)
Subject: Re: [PATCH] spi: apple: Add "apple,t8103-spi" compatible
References: <20260430-apple-compat-spi-v1-1-6fb3a6fc499c@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:33:25 +0200
> 
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,spi" anymore [1]. Use
> "apple,t8103-spi" as base compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,spi".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/spi/apple_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
> index 5f94e9f7a74..088d02e3b90 100644
> --- a/drivers/spi/apple_spi.c
> +++ b/drivers/spi/apple_spi.c
> @@ -270,6 +270,7 @@ static int apple_spi_probe(struct udevice *dev)
>  }
>  
>  static const struct udevice_id apple_spi_of_match[] = {
> +	{ .compatible = "apple,t8103-spi" },
>  	{ .compatible = "apple,spi" },
>  	{ /* sentinel */ }
>  };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-spi-a4f997c6ff4a
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
