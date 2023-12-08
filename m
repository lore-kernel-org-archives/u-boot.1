Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57911C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 01:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B86874ED;
	Fri,  8 Dec 2023 02:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E51C874D9; Fri,  8 Dec 2023 02:41:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E652687150
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 02:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD1511FB;
 Thu,  7 Dec 2023 17:42:07 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9976D3F762;
 Thu,  7 Dec 2023 17:41:20 -0800 (PST)
Date: Fri, 8 Dec 2023 00:25:48 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Icenowy
 Zheng <icenowy@aosc.io>, Jesse Taube <Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v3 1/4] sunxi: spl: Disable padding from SPL_PAD_TO
Message-ID: <20231208002548.6bd86fc9@slackpad.lan>
In-Reply-To: <20231031051805.62430-2-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-2-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 31 Oct 2023 00:17:38 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> Starting with H6, Allwinner removed the artificial 32 KiB SPL size limit
> from the boot ROM. Now SPL size is only limited by the available SRAM.
> This limit ranges from 152 KiB on H6 to a whopping 2052 KiB on R329. To
> take advantage of this additional space, we must increase SPL_MAX_SIZE.
> Since we do not want to unnecessarily pad SPL out to these giant sizes,
> we must set SPL_PAD_TO to zero. This causes no problems because binman
> already takes care of appending the SPL payload at the right offset.

That looks alright now, back in v2023.04 (at time of v2) this still
broke compilation, but this was fixed with your patch 9a4aa31ad514. I
actually cannot see any effect on sunxi builds anymore, apart from the
check in config_fallbacks.h, which is appeased with the value being set
to 0 here. So:

> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - New patch for v2
> 
>  common/spl/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 25cd18afda7..a0968ff1065 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -97,8 +97,7 @@ config SPL_PAD_TO
>  	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>  	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
>  	default 0x10000 if ARCH_KEYSTONE
> -	default 0x8000 if ARCH_SUNXI && !MACH_SUN50I_H616
> -	default 0x0 if ARCH_MTMIPS
> +	default 0x0 if ARCH_MTMIPS || ARCH_SUNXI
>  	default TPL_MAX_SIZE if TPL_MAX_SIZE > SPL_MAX_SIZE
>  	default SPL_MAX_SIZE
>  	help

