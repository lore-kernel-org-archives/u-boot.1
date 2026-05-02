Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749EECD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 11:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4F8842D7;
	Sat,  2 May 2026 13:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="OxL8efg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10D0842FC; Sat,  2 May 2026 13:55:41 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7476483642
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d66cac70-461d-11f1-89e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d66cac70-461d-11f1-89e5-00505699b430;
 Sat, 02 May 2026 13:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=izr0CYZNI7Ps4OaLH32mW65eqNIjIdxLOJYDqgVr6ts=;
 b=OxL8efg2eYUT6RAmrWzvTE9Vva4F3TH0oTw24jKzt3nI290wGS2drQGsXl5g0ljiQ8Lhy1xKAW5hN
 Yn5K3/npEoYoR5pLLYR2md3/owZqquIthjOJmTyoj9+6T0WA0VZNj/GAHqn3m/SrIYF/3FfX0dxKIA
 xdQXjFDSeGCAeKzbcCHEAHAT/Kr8+RtdpipN+EQPSgV5euKw+uiHvcBiSu6dYYW+hrzMRMvaqRiDDT
 nNCjtDonLAhN9uWz0s6f+jpajrnjLouMSJ6w0Vf7Z7Mu+NjCs8kklYcIc/h0brZ31eh3QOvyTJDIx/
 ni5zlOtnrsoHxGJmTjDDze6Wrn9A7Yw==
X-KPN-MID: 33|AsGJ/kvxhJ/xtpGuEic6taVPWWwXx7oV6fF35z5ZPiCoAfgNpMlHFfU3/zNJEAx
 Wei5CUp0h/oCz9prFllc18cna2GJYReDdw4/IgdSdBCQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Q3j+k+vWNc+CmMITX32KmOv4QFLKfpXoWnxzAJfeVmmdEwnpuAndJuyOKk/aJGh
 MVfpzR7YhrkpOJ7Arg8h5Mg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d5f51879-461d-11f1-9c0c-00505699d6e5;
 Sat, 02 May 2026 13:55:38 +0200 (CEST)
Date: Sat, 02 May 2026 13:55:38 +0200
Message-Id: <87y0i2c9fp.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, bmeng.cn@gmail.com,
 trini@konsulko.com, j@jannau.net
In-Reply-To: <20260430-apple-compat-nvme-v1-1-52c1e6e93aa6@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:28:36 +0200)
Subject: Re: [PATCH] nvme: apple: add "apple,t8103-nvme-ans2" compatible
References: <20260430-apple-compat-nvme-v1-1-52c1e6e93aa6@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:28:36 +0200
> 
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as this is the SoC the
> driver and bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,t8103-nvme-ans2".
> 
> Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
> Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/nvme/nvme_apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index 7e7538553e3..48f82bc826c 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -287,6 +287,7 @@ static const struct nvme_ops apple_nvme_ops = {
>  };
>  
>  static const struct udevice_id apple_nvme_ids[] = {
> +	{ .compatible = "apple,t8103-nvme-ans2" },
>  	{ .compatible = "apple,nvme-ans2" },
>  	{ /* sentinel */ }
>  };
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260430-apple-compat-nvme-71c2fe7a5149
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
