Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B70D2F7E8
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 09:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C77489185;
	Fri, 18 Oct 2024 11:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QG3rd4CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639168917D; Fri, 18 Oct 2024 11:03:39 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC8189175
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: dc41b9f9-8d2f-11ef-bc3d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id dc41b9f9-8d2f-11ef-bc3d-005056992ed3;
 Fri, 18 Oct 2024 11:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=UP26ZZgiMre6hJJgvc/lNDn3NofC3vqhN4h0LHuTag4=;
 b=QG3rd4CMiDvGno/EyLbGPanMofAcG0CJMZHIxLvQmGk1DrrShllG7xo+cBk1+hQmT3N6XOnPD4jP8
 0/gAz0JvRmk+Loj3s29YiwrEFUNAmzoxMMCpwmaVTseWvA7EcIN2GC99geGsAnSg3L9yiz9b6EpGAE
 xFMcM/qbL++6db93F2IGU/tQE6csmeiuJq519t7Lh/YCymeFXv2WhqlqxBj234Yzh0ZXnmd/pkQPgJ
 mKjQQfTB0uyCcS2yzQWnTqcYVHZzJDBYd9jzLx02hKKut614y1ke5lE2oUmMNj89tbTbSkjQcNPRUN
 UhEORc+7o1B2VazxCxNzKtkqYOY3/nQ==
X-KPN-MID: 33|2pqnGPr/3mKCQvhC/mF834x4+eq9HGGJwkYQ2XoLi4nKu/pJSyuUhWRbDJS/+FW
 4YigAExm6ZGZHImCmGZXi/Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|voiyKeFctjmoUUsn2oa83e4HLPfJeuDAxHJlmwjLM+rBCSZWZrhuF8ly8Cf9Jfc
 T//t+OJqMwJH5eUoqWaXqmg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id db770702-8d2f-11ef-890b-00505699d6e5;
 Fri, 18 Oct 2024 11:03:36 +0200 (CEST)
Date: Fri, 18 Oct 2024 11:03:35 +0200
Message-Id: <877ca5hjfc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 marex@denx.de, mkorpershoek@baylibre.com,
 maximmosk4@gmail.com, raymond.mao@linaro.org, sughosh.ganu@linaro.org
In-Reply-To: <20241017232413.724808-17-sjg@chromium.org> (message from Simon
 Glass on Thu, 17 Oct 2024 17:23:55 -0600)
Subject: Re: [PATCH 16/34] image: Add a new type for EFI apps
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-17-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 17 Oct 2024 17:23:55 -0600

Hi Simon,

> Add an image type for EFI applications, which U-Boot supports reading.

Not necessarily a bad idea, but what would the image type be of a
Linux kernel that is also an EFI application?  See:

  https://docs.kernel.org/admin-guide/efi-stub.html

Cheers,

Mark

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  boot/image.c    | 1 +
>  include/image.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/boot/image.c b/boot/image.c
> index cf16fb7fbf7..b13644b03dc 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -184,6 +184,7 @@ static const table_entry_t uimage_type[] = {
>  	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
>  	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
>  	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
> +	{	IH_TYPE_EFI, "efi", "EFI applicaiton" },
>  	{	-1,		    "",		  "",			},
>  };
>  
> diff --git a/include/image.h b/include/image.h
> index 606e7d49169..a04925aa829 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -233,6 +233,7 @@ enum image_type_t {
>  	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
>  	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
>  	IH_TYPE_EXTLINUX_CFG,		/* extlinux configuration-file */
> +	IH_TYPE_EFI,			/* EFI PE image */
>  
>  	IH_TYPE_COUNT,			/* Number of image types */
>  };
> -- 
> 2.34.1
> 
> 
