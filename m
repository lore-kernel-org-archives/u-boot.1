Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C295E68159
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 09:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2640783C72;
	Tue, 17 Feb 2026 10:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hSNnK86x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133FC83CB1; Tue, 17 Feb 2026 10:56:01 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BA08063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A73B860131;
 Tue, 17 Feb 2026 09:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF67FC4CEF7;
 Tue, 17 Feb 2026 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771322156;
 bh=U08ykoXLNLrifGZX1qd/+tTjl2S53hGLe/f2RmqiXRU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hSNnK86xwpErGOiOdcAOfaEWUE5lR83MXbB8NWIlWFmKnCuOWH9mO7QjEKVw8OHu+
 yEf4bZeRJqnThRNYBaMo8XHBp/R/oUcUeTHQepPLtVP1sj/dLlBbL0NSABG0HxjVLh
 sIl51pC5AOKXFtJXIS+7sezFvXufn6nepc0yxw/FNt/K3p2Qfu0zD6NW1p6aZuwfxA
 O0CvI5op+849lbPWxx1LyQCF//WKA41EKjqypra6J7tBXrPADW7xsm9gEEy74cLcqu
 nhGEwtikNKOS7KE8hjWhD1HbDzmYc2g3LdimcfJlYS91jtoiyeuSqxPoj9FpREUvry
 LeWCCrAFbd+bw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Heiko Schocher
 <hs@nabladev.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] arch: imx8qxp: Override weak
 fb_mmc_get_boot_offset function
In-Reply-To: <20260210054345.126651-3-hs@nabladev.com>
References: <20260210054345.126651-1-hs@nabladev.com>
 <20260210054345.126651-3-hs@nabladev.com>
Date: Tue, 17 Feb 2026 10:55:53 +0100
Message-ID: <87jywbk82e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heiko,

On Tue, Feb 10, 2026 at 06:43, Heiko Schocher <hs@nabladev.com> wrote:

> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()
>
> This is needed as bootloader offset is different dependent on SoC
> revision!
>
> For revision B0 the bootloader starts at 32k offset. On offset
> 0x0 the bootloaders environment is stored.
>
> On C0 revisions of the SoC bootloader image starts at offset 0x0
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Peng did provide some review feedback here:
https://lore.kernel.org/all/aXbHDnU+SpgnEt+Q@shlinux89/

I have not seen a response to that. Could you please respond there why
you did not apply his suggestion?

>
> ---
>
> Changes in v2:
> - added Reviewed-by from Mattijs
>
>  arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
> index 0e112af661c..27c431881b0 100644
> --- a/arch/arm/mach-imx/imx8/cpu.c
> +++ b/arch/arm/mach-imx/imx8/cpu.c
> @@ -899,3 +899,24 @@ bool m4_parts_booted(void)
>  
>  	return false;
>  }
> +
> +#ifdef CONFIG_IMX8QXP
> +#include <blk.h>
> +
> +/*
> + * On B0 revision SoCs the bootloader is on 32k offset
> + * and at offset 0x0 is the U-Boot Environment stored
> + *
> + * So we cannot flash bootloader images to offset 0x0
> + *
> + * On C0 revisions of the SoC bootloader image starts
> + * at offset 0x0 ...
> + */
> +lbaint_t fb_mmc_get_boot_offset(void)
> +{
> +	if ((get_cpu_rev() & 0xF) == CHIP_REV_C)
> +		return 0;
> +
> +	return 0x40;
> +}
> +#endif
> -- 
> 2.20.1
