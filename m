Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DEDFB5168
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 21:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5F58352B;
	Mon,  6 Apr 2026 23:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ehatpOTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAE083C2B; Mon,  6 Apr 2026 23:36:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1DC188341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 23:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE262328;
 Mon,  6 Apr 2026 14:35:59 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BAC73F632;
 Mon,  6 Apr 2026 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775511365; bh=b0Wgvbpz+HNB/LpA6pQXXJH2pH4DEuY7f9/V/KBJUbs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ehatpOTXQbs3RvKwcaMOZuRToDlbax3NPHZqU2KakD+gPMinmjzgQhClpvFrYHwXu
 DxkpY5BKMul3jypu9UdiR88dgMuhdkraauCvkJJamvNwrhyVI3ATHPmbyMEToFOTfB
 cs1slNkeqnSw6Ic9oVIsJyl+N/5rfizQIGqZacyo=
Date: Mon, 6 Apr 2026 23:35:56 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Paul Kocialkowski <contact@paulk.fr>, Cody
 Eksal <masterr3c0rd@epochal.quest>, Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 1/2] sunxi: H616: dram: fix LPDDR3 TPR6 parsing
Message-ID: <20260406233556.32e31718@ryzen.lan>
In-Reply-To: <20260405195927.2837914-2-simons.philippe@gmail.com>
References: <20260405195927.2837914-1-simons.philippe@gmail.com>
 <20260405195927.2837914-2-simons.philippe@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sun,  5 Apr 2026 21:59:26 +0200
Philippe Simons <simons.philippe@gmail.com> wrote:

Hi Philippe,

thanks for taking care of sending this patch!

> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> When a user copies the vendor value of tpr6 into the mainline U-Boot,
> the code parses the tpr6 parameter incorrectly and writes the wrong value.

That sentence is hard to understand unless you know what this value is
about already. What about:

===============
Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
some "Vref" parameter, to encode the values for *all* four supported DRAM
types. The code selects one byte based on the DRAM type used at runtime.
To allow copying DRAM parameters from vendor firmware, we used this value
and its encoding, but wrongly: the proper order of bytes is DDR3, DDR4,
LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.

Correct the masking for LPDDR3 to fix DRAM operation on some boards
using this DRAM type.
==============

Plus we need the second patch merged into this one, otherwise this
would introduce (an admittedly theoretical) regression.

But the actual changes in both patches looks good to me.

Cheers,
Andre


> Fixes Vref parsing from TPR6. Proper order from LSB to MSB is DDR3, DDR4,
> LPDDR3 and LPDDR4
> 
> Fix that.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> [adjusted commit message]
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 3345c9b8e82..42a0550e015 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>  		val = para->tpr6 & 0xff;
>  		break;
>  	case SUNXI_DRAM_TYPE_LPDDR3:
> -		val = para->tpr6 >> 8 & 0xff;
> +		val = para->tpr6 >> 16 & 0xff;
>  		break;
>  	case SUNXI_DRAM_TYPE_LPDDR4:
>  		val = para->tpr6 >> 24 & 0xff;

