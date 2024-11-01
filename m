Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A232E6F086
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 20:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A29988DC8;
	Fri,  1 Nov 2024 21:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="j3MrfaeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A91288D9A; Fri,  1 Nov 2024 21:28:40 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710C188DC8
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 21:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: de6e3cf5-988f-11ef-9dde-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id de6e3cf5-988f-11ef-9dde-00505699b430;
 Fri, 01 Nov 2024 21:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=PzwU5JlpcecC7Xs0Lu6zpyuu74npA5FZwjRWIPzH5aM=;
 b=j3MrfaeJVtUFnNU1/7xz33ufsqrDDGfjy19RRKuDtPNfPsbiCqnkV97LhI5bD/1E8ioRRkMpUvAir
 zf2dUJQFuTZmvmc9aPRYqXLOnmvVIb7wXBpkyMEmPU1j5oEaxTSEGTfF837n32JndMUatie4WKd09u
 u7F3fmANaFdP5YFvZDtzqL4VysGadWIEdBpFSE1hL+bDAWEHzjLfu9W5GSOETFNg57Rm8lr4u0eKVZ
 eulQOdJ7cxH5DfcC0SE8d95J3fnST+DSbiYnHdbTOEJtNUxTP0l7QP0lbldWZKbIYMdeD23osFRZ8W
 Y5nhQArBYtvACnFGjhmaHwcBR/d1wXg==
X-KPN-MID: 33|0l8WKNQ23GFGA+2z6aZbRXHJV4dIBNe51wLw1p7AiCi+2PHNDtaL7L7XNcznp5Z
 /2I+cTYOyuLHRHsa5/cwelA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7/aBY6FbQik0coOxcF7+9J/2I0XOiPUt0caFd6CzJ2wV6+qa7XjxYfvRqN1y79V
 zcUMLAiDmm2WIU9t1kuFTjg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id dcae85ba-988f-11ef-9749-005056998788;
 Fri, 01 Nov 2024 21:28:37 +0100 (CET)
Date: Fri, 01 Nov 2024 21:28:32 +0100
Message-Id: <871pzu66mn.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, j@jannau.net
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
 (message from Janne Grunau on Thu, 31 Oct 2024 23:48:01 +0100)
Subject: Re: [PATCH 1/2] iommu: apple: Mark device with DM_FLAG_VITAL
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
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
> Date: Thu, 31 Oct 2024 23:48:01 +0100
> 
> Avoids NULL pointer dereferences in apple_dart_unmap when the iommu
> device is removed before its user. U-boot's device model does not track
> dependencies between devices.
> Observed on a M1 Ultra Mac Studio with v2024.10.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/iommu/apple_dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..9df174f32d721c39079e65736c91e3e27a72ace2 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -312,5 +312,5 @@ U_BOOT_DRIVER(apple_dart) = {
>  	.ops = &apple_dart_ops,
>  	.probe = apple_dart_probe,
>  	.remove = apple_dart_remove,
> -	.flags	= DM_FLAG_OS_PREPARE
> +	.flags	= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL
>  };
> 
> -- 
> 2.47.0
> 
> 
