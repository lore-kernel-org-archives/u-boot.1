Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA82F532DD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 06:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB998063E;
	Tue, 24 Mar 2026 07:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XnTk63S4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 952008063E; Tue, 24 Mar 2026 07:03:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E1C805D7
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BECD60103;
 Tue, 24 Mar 2026 06:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02650C2BC87;
 Tue, 24 Mar 2026 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774332180;
 bh=ydT9sPhSuEGavot0Nu63zydkDFJN8x7PRORr5GUPk0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XnTk63S4+0wv519ktc3PmyUJb04CEt/FkpPJCddDttFn5fBVr6mL120ihQ+RIXnFo
 r263G561wRqPW4bGF5Wp9Wb5NAlWOQ/Gu8SI+hFCwRkrnOMM4oEBfb6vIN7ZX66HZB
 NMKT6Ii5m5W9qlx/J7Zx3Gr0/RY9IPq3i8EPB+/SMCLckK8ioZAxDxIGBJ2o4lpugw
 rfR8+ksr1GweyaMONFjGPO7XZ83uao5iFBHj10Az/TCYQFjCgs4zpTYiANpTXCno2F
 y94He+NtnpYR4dlEJDc+tNQXy96NgDAwBs6Sg5LHE39XpJP8CqjVhu0PCK7JLf7Ev6
 7tEwjbAbCWSDQ==
Date: Tue, 24 Mar 2026 11:32:54 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] video: simplefb: Map framebuffer region on probe on ARM64
Message-ID: <acIpDkBPdC0DGW8y@sumit-xelite>
References: <20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com>
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

Hi Luca,

On Wed, Mar 18, 2026 at 04:07:17PM +0100, Luca Weiss wrote:
> The framebuffer buffer might not be mapped on some devices.
> 
> This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
> any other architecture.

This isn't an appropriate fix to the problem.

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Map 0x1000 extra due to unknown reason, but otherwise it's not enough
> and we still get a "Synchronous Abort" when drawing at the bottom of the
> framebuffer.
> 
> For milos-fairphone-fp6 the framebuffer is reg=0xe3940000
> size=0xa932c0 (2484*1116*4).
> 
> When just calling mmu_map_region with plat->size, then it's crashing at
> 0xe43d3000 even though everything up to 0xe43d32c0 should be mapped.
> With size+0x800 (or less) it was also still crashing, only size+0x1000
> then worked.
> 
> Possible I just don't know enough about memory mapping things, so
> suggestions welcome! :)

This sounds more likely the synchronous aborts caused by cache prefetch
of nearby reserved memory regions. I see there are some reserved mememory
regions around the address space you have mentioned on Milos.

On Qcom platforms, the default memory map strategy is to map the overall
DRAM space without excluding reserved reqions. One can exclude reserved
regions in a SoC specific manner here [1] but it adds some runtime
overhead. Give it a try for Milos as well in case it resolves your
issue.

I think we still need to revisit that reserved memory strategy where
default should rather be we unmap the reserved regions.

[1] https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-snapdragon/board.c#L743

-Sumit

> ---
>  drivers/video/simplefb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d0772d4e51..e144fde697b 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -9,6 +9,7 @@
>  #include <log.h>
>  #include <video.h>
>  #include <asm/global_data.h>
> +#include <asm/system.h>
>  
>  static int simple_video_probe(struct udevice *dev)
>  {
> @@ -37,6 +38,11 @@ static int simple_video_probe(struct udevice *dev)
>  	plat->base = base;
>  	plat->size = size;
>  
> +#ifdef CONFIG_ARM64
> +	/* The framebuffer buffer might not be mapped on some devices */
> +	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)plat->size + 0x1000, false);
> +#endif
> +
>  	video_set_flush_dcache(dev, true);
>  
>  	debug("%s: Query resolution...\n", __func__);
> 
> ---
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> change-id: 20260318-simplefb-map-abb9dba0eed1
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>
> 
