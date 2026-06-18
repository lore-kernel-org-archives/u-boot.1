Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAE5CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 07:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E868484995;
	Thu, 18 Jun 2026 09:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="0XrIzA+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC4784995; Thu, 18 Jun 2026 09:00:33 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F2D849A1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 09:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id B68C11FFFF;
 Thu, 18 Jun 2026 09:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1781766030;
 bh=YUrC7MoXobJPx58KGKjfaK6x2qtFVtKv6GsXQkTr//8=; h=From:To:Subject;
 b=0XrIzA+5o8mcLZOHiHYu7joxARKH8tP+ZVtwzFdJU+QSSLcWAqDbJO1oDeDj1xQwS
 V4mzAvm7c4ll/g4iR9U/Y4xVPZjjYlxh51AqCq0Pqe6lMC1c56ZSmOtNpLHRiSBoFJ
 E+duPetEWLBntmv9LWUsjHzxhdTBXCJKNgGX2O1grkyVN1G5A8DIc78iuPQwJGBbGM
 02TjROfQAyUnKUAzWGmZz74LXNLlgVfY40Mtv0STunyGZ6CA6K+7XOS/jdzUcZQo9A
 z/NyVSEeSh46cEfIh/FwVKHomUuzogg9skvl4u4offYZ8jRMQY1D9KqF41i7UFxHWW
 FIz8BTZgFj3dQ==
Date: Thu, 18 Jun 2026 09:00:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: ye.li@oss.nxp.com, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH 1/3] imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
Message-ID: <20260618070028.GB18945@francesco-nb>
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618011749.2871269-1-ye.li@oss.nxp.com>
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

+ Emanuele

On Thu, Jun 18, 2026 at 09:17:47AM +0800, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> After supporting get DRAM size from SM, the trampoline buffer address
> still depends on PHYS_SDRAM_SIZE. If the real DDR size is less than
> PHYS_SDRAM_SIZE, the trampoline buffer address is invalid and SPL will
> crash. So use board_phys_sdram_size to get real DDR size to calculate
> correct address.
> 
> Fixes: e1cc7117b630 ("imx9: scmi: Get DDR size through SM SCMI API")
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/scmi/soc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 00b8693fbe0..ce86cdf8574 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -1177,10 +1177,11 @@ enum boot_device get_boot_device(void)
>  
>  bool arch_check_dst_in_secure(void *start, ulong size)
>  {
> -	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
> -#ifdef PHYS_SDRAM_2_SIZE
> -	ns_end += PHYS_SDRAM_2_SIZE;
> -#endif
> +	ulong ns_end;
> +	phys_size_t dram_size;
> +
> +	board_phys_sdram_size(&dram_size);

Emanuele: does this change has any impact on the memory size detection we have
implemented in our i.MX95 based boards?

Peng: board_phys_sdram_size() in board/toradex/verdin-imx95/verdin-imx95.c

Francesco

