Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED892EBFD38
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB4D839DF;
	Mon, 13 Apr 2026 13:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qi6lZ5to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01E383EC6; Mon, 13 Apr 2026 13:15:34 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F00839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BC78D41866;
 Mon, 13 Apr 2026 11:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6C1C116C6;
 Mon, 13 Apr 2026 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776078930;
 bh=zBL/m0Ovr8OZ8DI04mu/byvz7RL14D+vXDvB7uYjZu4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qi6lZ5toeeTkvtubfgs+S3ZjJHlT5nepJovCeAgq3MsRBM2dgYJOPRgbhpg0QsVjw
 hkWQJ9B3cclGYexvqpKf3E7GaCkvB1aaijq/tANL8TAkMSsH40wifXh3j56ijBsVOc
 +yt3RUGh4pttzzB0Phe0/GmchrgIWHlIccqL719YZp1RxVe4HpMLy1cl6NNrw7j79Z
 bV/2/zriz/zFxD+DDooFzRc7C0+l1jP66iNcWwJONc1+ozLrD0vlnBSSHzScNaba90
 xluuT9g9Hv+CNgtdR2FP3our3Zy2y7JIxhIBZNjvMLFo24SFUDqYf/PW2DsUH1+c1e
 uMEXVjjHa2DCg==
Date: Mon, 13 Apr 2026 16:45:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] video: simplefb: Map framebuffer region on probe on
 ARM64
Message-ID: <adzQTOUoUXp1Q7pc@sumit-xelite>
References: <20260408-simplefb-map-v2-1-c0a8dd497582@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-simplefb-map-v2-1-c0a8dd497582@fairphone.com>
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

On Wed, Apr 08, 2026 at 02:04:28PM +0200, Luca Weiss wrote:
> The framebuffer buffer might not be mapped on some devices.
> 
> This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
> any other architecture.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - Use ALIGN(plat->size, SZ_4K) instead of + 0x1000 (Casey)
> - Add log_warning in case framebuffer base is not 4k aligned (Casey)
> - Link to v1: https://lore.kernel.org/r/20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com
> ---
>  drivers/video/simplefb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d0772d4e51..4d238b936ac 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -9,6 +9,8 @@
>  #include <log.h>
>  #include <video.h>
>  #include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <linux/sizes.h>
>  
>  static int simple_video_probe(struct udevice *dev)
>  {
> @@ -37,6 +39,13 @@ static int simple_video_probe(struct udevice *dev)
>  	plat->base = base;
>  	plat->size = size;
>  
> +#ifdef CONFIG_ARM64
> +	/* The framebuffer buffer might not be mapped on some devices */
> +	if (plat->base % SZ_4K)
> +		log_warning("Framebuffer base %lx is not 4k aligned!\n", plat->base);
> +	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)ALIGN(plat->size, SZ_4K), false);
> +#endif
> +
>  	video_set_flush_dcache(dev, true);
>  
>  	debug("%s: Query resolution...\n", __func__);
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260318-simplefb-map-abb9dba0eed1
> 
> Best regards,
> --  
> Luca Weiss <luca.weiss@fairphone.com>
> 
